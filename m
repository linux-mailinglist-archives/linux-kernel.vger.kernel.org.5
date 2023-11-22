Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 395927F4693
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 13:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343821AbjKVMsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 07:48:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234981AbjKVMsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 07:48:00 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3FDED8;
        Wed, 22 Nov 2023 04:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/lJjJofj7oNx1tsDn6G0hMP38tInZAYQWY3bOgST5Os=; b=qxZN1SnOPNClHqFezkQCZQ/Rqa
        pwvqtIgipYYwuLG4w4DXTwRA6S9MMqR2uvMFW3Gf4kqjZ7xVfouTzchMBs+fZg5d3Od+HztJxYxkS
        jnv2gEQIbjnSgs3lsgkfLRa2YA/uHbmUrBnMrvnMwvdn8aVi72COnshOnLZ9jS0w9qt+ZPVTwl0Tc
        GvRfpZ1/g8sqOJB+Lda3fLPrj/zPoZiyIx3IrmsjihFoDY2M/8aUooyGvU3C1GtWyBZ7JJwRNppZf
        NrIxAZlZUGX0n2FHNjfe1pa4estJTHovJ2NSFRLDStS8E3q3yyZBZgt3Iarz4OEePPD1ulv3RnOu/
        iT8r6zvg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1r5mdz-001qmi-2z;
        Wed, 22 Nov 2023 12:47:51 +0000
Date:   Wed, 22 Nov 2023 04:47:51 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v3 2/3] block: introduce new field bd_flags in
 block_device
Message-ID: <ZV34d/hI12pKFUzj@infradead.org>
References: <20231122103103.1104589-1-yukuai1@huaweicloud.com>
 <20231122103103.1104589-3-yukuai1@huaweicloud.com>
 <ZV2tuLCH2cPXxQ30@infradead.org>
 <ZV2xlDgkLpPeUhHN@fedora>
 <ZV2zbTPTZ0qC2F1U@infradead.org>
 <ZV25nGGMYQuyclK6@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZV25nGGMYQuyclK6@fedora>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 04:19:40PM +0800, Ming Lei wrote:
> On Tue, Nov 21, 2023 at 11:53:17PM -0800, Christoph Hellwig wrote:
> > On Wed, Nov 22, 2023 at 03:45:24PM +0800, Ming Lei wrote:
> > > All the existed 'bool' flags are not atomic RW, so I think it isn't
> > > necessary to define 'bd_flags' as 'unsigned long' for replacing them.
> > 
> > So because the old code wasn't correct we'll never bother?  The new
> > flag and the new placement certainly make this more critical as well.
> 
> Can you explain why the old code was wrong?
> 
> 1) ->bd_read_only and ->bd_make_it_fail
> 
> - set from userspace interface(ioctl or sysfs)
> - check in IO code path
> 
> so changing it into atomic bit doesn't make difference from user
> viewpoint.

> 
> 2) ->bd_write_holder
> 
> disk->open_mutex is held for read & write this flag
> 
> 3) ->bd_has_submit_bio
> 
> This flag is setup as oneshot before adding disk, and check in FS io code
> path.

On architectures that can't do byte-level atomics all three can corrupt
each other, and even worse bd_partno.  Granted that is only alpha these
days IIRC, but it's still buggy.

