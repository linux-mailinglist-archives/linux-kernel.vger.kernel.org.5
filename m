Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A3A7E50E5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 08:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234499AbjKHH0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 02:26:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjKHH0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 02:26:32 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27751A1;
        Tue,  7 Nov 2023 23:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YDuPeCwVmjpThnF/XEgOD0uqKSwNKZwyjOl5wFv5X1Y=; b=cBMGXxEfWEMEzrjrcplylVjz4A
        dWs/G9bBtygirluW65Nn8lBcIrqrm8VR+XH0kdj7XcKVgQKQZUwTYRynbu2rXA2+v7hS3x8hePLfQ
        zrT64XuAMuWT2vrgBl8p2RKvxPFUW80hiPCXjt7TPDRy0WVTt45r8WDCNh8YrPFgI4e0wTVWlieg+
        oOfmQ9ODFZY39HlIUP/3VEdQxMo0qfuGI+3pqKe6CZB+DZzOB0GYXVdrDbHNciZjqp3NmAErUkOrt
        Tguw0ouiqsSBKzomxGuIriqVzkerLLznHgp/SkZ7AfvSCnR2flEf+pbyqVfZl+2xgtT6qT52cWnG1
        Xa3LoORQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1r0cxI-003Awz-2x;
        Wed, 08 Nov 2023 07:26:28 +0000
Date:   Tue, 7 Nov 2023 23:26:28 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Edward Adam Davis <eadavis@qq.com>
Cc:     bvanassche@acm.org, axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+fcc47ba2476570cbbeb0@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH V2] blk-mq: fix warning in blk_mq_start_request
Message-ID: <ZUs4JIu0NBz2RWys@infradead.org>
References: <25a94b23-b42b-49fc-a1c8-3e635f536aae@acm.org>
 <tencent_6E1A9EAE1BB04B3A1B592506BAEABB313308@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_6E1A9EAE1BB04B3A1B592506BAEABB313308@qq.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2023 at 02:59:40PM +0800, Edward Adam Davis wrote:
> Before call queue_rq(), initialize rq->state to MQ_RQ_IDLE.

Request should never be able to be allocated if they aren't in
MQ_RQ_IDLE.  So papering over it here is not the right fix, we need
to figure out got it ends up being marked free in the bitmap while
not idle.

