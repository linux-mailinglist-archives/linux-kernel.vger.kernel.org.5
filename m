Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C48F76B045
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 12:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbjHAKDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 06:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233980AbjHAKDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 06:03:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49951DF;
        Tue,  1 Aug 2023 03:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=F9BXdlbwpUYCCGV+1bYwP+JXHESL2UKwaIWerHheSxQ=; b=G9ArVPnFgYc6sVVMFAzUvlJZdO
        JAULzD2YiCX17SOQRLguWqfX8uV9Kq0ouUJy2WjPFEwfLFVmsvBkbxi/eQ4kUMnna0STEhui1QbUl
        UbXT4FplP8OhkICf7bQU+z0SRo0hhQFGk/O0H/2PF7CbOE1Kd6+VwpkUPaRstWkjNglkqZkLpK7+F
        o8wqNCCIvQ2Q5XHSoiJBsaTgCfYHrF6oy9thx9/tpg0HW9adNHIGXlivPDMbuh0HV3I5ZRoAzrBdK
        ucrhbHY3vP7MMyjVEXW9DGGQk31OugHf4wXhY1NWAeG0uPTW+SiQPGN5L5uTKeO8D4kVzZaI4fljI
        o/idd8Uw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qQmDi-001ibl-1I;
        Tue, 01 Aug 2023 10:03:14 +0000
Date:   Tue, 1 Aug 2023 03:03:14 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jinyoung Choi <j-young.choi@samsung.com>
Cc:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "chaitanya.kulkarni@wdc.com" <chaitanya.kulkarni@wdc.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
Subject: Re: [PATCH v2 3/4] bio-integrity: cleanup adding integrity pages to
 bip's bvec
Message-ID: <ZMjYYtXgzn86UIF8@infradead.org>
References: <20230731124710epcms2p55b4d1a163b5ee6f15d96bf07817e12a5@epcms2p5>
 <CGME20230731124710epcms2p55b4d1a163b5ee6f15d96bf07817e12a5@epcms2p1>
 <20230731125459epcms2p177a5cc5caa7ef0a9de35689e96558f43@epcms2p1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731125459epcms2p177a5cc5caa7ef0a9de35689e96558f43@epcms2p1>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 09:54:59PM +0900, Jinyoung Choi wrote:
> The bio_integrity_add_page() returns the set length if the execution
> result is successful. Otherwise, return 0.
> 
> Unnecessary if statement was removed. And when the result value was less
> than the set value, it was changed to failed.

Maybe word this as

bio_integrity_add_page() returns the add length if successful, else 0,
just as bio_add_page.  Simply check return value checking in
bio_integrity_prep to not deal with a > 0 but < len case that can't
happen.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
