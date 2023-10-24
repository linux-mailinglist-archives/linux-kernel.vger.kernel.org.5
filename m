Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2A027D56AC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 17:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343686AbjJXPjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 11:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234241AbjJXPjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 11:39:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BED6A3;
        Tue, 24 Oct 2023 08:39:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCF29C433C7;
        Tue, 24 Oct 2023 15:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698161946;
        bh=/WC2xE/MloO7WOkbdOiY+gYM4E6FAb5qDVXBP6DKJgE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H6k38Jn6oekyNutgwdatRXSG/Bw1GzzQuEieqct4eWuKBwkOz9GspxoWar6n0juBE
         F7bgw6ocWBEFUqFczUUnp4CGMTtpp6+H+BIQjXnY8FAIqP7p6msqBlf3PYnWBXps5l
         CPIQBSvvc77kslT628HI7WbPZjdX3JQzd6kCV44zJRogUQ8iXMbM7FcC/YVnNtmsTw
         us+LhBC4j7OYXOS59OQb5x2DnCpsoNY0kuFKibcb1SPH5dA+hmrdQlJgCHgnJCcq8B
         0c+kP6gqqhToRx4cGM5SnSfZx9GlvMYhWGknhYHI3pKwn/Oa7/LSUDMvi0B0CDywjl
         FH4Bx7+Y0G0PQ==
Date:   Tue, 24 Oct 2023 08:39:06 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     John Garry <john.g.garry@oracle.com>
Cc:     Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, martin.petersen@oracle.com,
        himanshu.madhani@oracle.com
Subject: Re: [PATCH 2/4] readv.2: Document RWF_ATOMIC flag
Message-ID: <20231024153906.GJ11391@frogsfrogsfrogs>
References: <20230929093717.2972367-1-john.g.garry@oracle.com>
 <20230929093717.2972367-3-john.g.garry@oracle.com>
 <20231009174438.GE21283@frogsfrogsfrogs>
 <ZSRk9Z6/i2E+YV9A@dread.disaster.area>
 <20231009210531.GB214073@frogsfrogsfrogs>
 <7da93082-2985-85f4-7688-a082728de0a5@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7da93082-2985-85f4-7688-a082728de0a5@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 01:35:33PM +0100, John Garry wrote:
> On 09/10/2023 22:05, Darrick J. Wong wrote:
> > > > If the file range is a sparse hole, the directio setup will allocate
> > > > space and create an unwritten mapping before issuing the write bio.  The
> > > > rest of the process works the same as preallocations and has the same
> > > > behaviors.
> > > > 
> > > > If the file range is allocated and was previously written, the write is
> > > > issued and that's all that's needed from the fs.  After a crash, reads
> > > > of the storage device produce the old contents or the new contents.
> > > This is exactly what I explained when reviewing the code that
> > > rejected RWF_ATOMIC without O_DSYNC on metadata dirty inodes.
> > I'm glad we agree. 😄
> > 
> > John, when you're back from vacation, can we get rid of this language
> > and all those checks under _is_dsync() in the iomap patch?
> > 
> > (That code is 100% the result of me handwaving and bellyaching 6 months
> > ago when the team was trying to get all the atomic writes bits working
> > prior to LSF and I was too burned out to think the xfs part through.
> > As a result, I decided that we'd only support strict overwrites for the
> > first iteration.)
> 
> So this following additive code in iomap_dio_bio_iter() should be dropped:
> 
> ----8<-----
> 
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -275,10 +275,11 @@ static inline blk_opf_t iomap_dio_bio_opflags(struct
> iomap_dio *dio,
>  static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>  		struct iomap_dio *dio)
>  {
> 
> ...
> 
> @@ -292,6 +293,13 @@ static loff_t iomap_dio_bio_iter(const struct
> iomap_iter *iter,
>  	    !bdev_iter_is_aligned(iomap->bdev, dio->submit.iter))
>  		return -EINVAL;
> 
> +	if (atomic_write && !iocb_is_dsync(dio->iocb)) {
> +		if (iomap->flags & IOMAP_F_DIRTY)
> +			return -EIO;
> +		if (iomap->type != IOMAP_MAPPED)
> +			return -EIO;
> +	}
> +
> 
> ---->8-----
> 
> ok?

Yes.

> > 
> > > > Summarizing:
> > > > 
> > > > An (ATOMIC|SYNC) request provides the strongest guarantees (data
> > > > will not be torn, and all file metadata updates are persisted before
> > > > the write is returned to userspace.  Programs see either the old data or
> > > > the new data, even if there's a crash.
> > > > 
> > > > (ATOMIC|DSYNC) is less strong -- data will not be torn, and any file
> > > > updates for just that region are persisted before the write is returned.
> > > > 
> > > > (ATOMIC) is the least strong -- data will not be torn.  Neither the
> > > > filesystem nor the device make guarantees that anything ended up on
> > > > stable storage, but if it does, programs see either the old data or the
> > > > new data.
> > > Yup, that makes sense to me.
> > Perhaps this ^^ is what we should be documenting here.
> > 
> > > > Maybe we should rename the whole UAPI s/atomic/untorn/...
> > > Perhaps, though "torn writes" is nomenclature that nobody outside
> > > storage and filesystem developers really knows about. All I ever
> > > hear from userspace developers is "we want atomic/all-or-nothing
> > > data writes"...

How about O_NOTEARS -> PWF_NOTEARS -> REQ_NOTEARS.

<obligatory "There's no crying in baseball" link, etc.>

--D

> > Fair 'enuf.
> 
> 
> Thanks,
> John
