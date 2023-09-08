Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 212A6798494
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 11:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241129AbjIHJKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 05:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240773AbjIHJKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 05:10:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259F41BF6;
        Fri,  8 Sep 2023 02:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hAaUM/xyOWpmkE94iyN0z7EBoyIh/DBzvfJchcaSLnI=; b=w7IEhWIwyYzV1mqWUUDTmle+K4
        nh12QqYUrZCafvBdnLhPmyuzVnZpqjdBFMKQBFXZkT5jts7GX7zcA4EvB6gbDB4mSPVmVc3CetgGE
        DZI2E3CYxErjrkhA/hQLqI3jkOtli/9ZlD9csNUnuXG2CZC2ylm8A9jQawE8yb/Q+7zRQFd3vnMdX
        kD/1xrVm7CKO+uc7uWSr+X+g559gWgu+013EJ9GUffF9HX9exuDdy8vhjHMpIRle1tfTYqAAcTdHw
        1WNy9p5pAHg3MdCjuwNuUard8afRpHckNG7VTO3ZZ4bJ4Y8hmg6Ur8/CnSrd7UGoVnpajLMv8/khU
        kH6TpFMQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qeXVV-00DNeh-0X;
        Fri, 08 Sep 2023 09:10:29 +0000
Date:   Fri, 8 Sep 2023 02:10:29 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 3/5] xfs: Use rwsem_is_write_locked()
Message-ID: <ZPrlBQ0UDyv3gJi8@infradead.org>
References: <20230907174705.2976191-1-willy@infradead.org>
 <20230907174705.2976191-4-willy@infradead.org>
 <ZPrk3yIrhA8usrgX@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPrk3yIrhA8usrgX@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2023 at 02:09:51AM -0700, Christoph Hellwig wrote:
> On Thu, Sep 07, 2023 at 06:47:03PM +0100, Matthew Wilcox (Oracle) wrote:
> > This avoids using the mr_writer field to check the XFS ILOCK is held
> > for write.  It also improves the checking we do when lockdep is disabled.
> 
> Hmm, is there any reason to keep the lockdep-based version of
> __xfs_rwsem_islocked around now at all?

Ok, looks like the last patch fixes that.
