Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 056377BEC49
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 23:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378618AbjJIVFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 17:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378201AbjJIVFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 17:05:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C4AAF;
        Mon,  9 Oct 2023 14:05:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74EB5C433C8;
        Mon,  9 Oct 2023 21:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696885532;
        bh=FZhRi5JSh0p/d2usQybblt8GOkPVFT7Pmxw3bLtebBs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T3qbRRq16OIPybsmh/yi+PWNwCeO1ieVJAqSU8vLBx8fVcFUkiqE8Sag9LIvWVzLe
         2IcwZnN8TBi8hj/vST0lqnJhIb0XyPybZuxDX3XLs5bUS9Su/JGkEt17yQmr+Oy+yF
         msi6r4boWZ90461u3nQrBvYTudl8BXWfPz0K0rF6eQEEl8YOPf0Ryah3cHYQnli8y7
         3CyL4hEMkP0OnGP63EZ4A5ibteVsrGljshMdeUaDDIK+pCMG14RcsW39fE756mNMT5
         OVB8YIQrBl6yOfCDudxsCtGQ6nshQRyVkRc91eGPA8PO2gtP85g9GXTpexJRJpOE5J
         +VQ8KfVDglBHg==
Date:   Mon, 9 Oct 2023 14:05:31 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     John Garry <john.g.garry@oracle.com>, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, martin.petersen@oracle.com,
        himanshu.madhani@oracle.com
Subject: Re: [PATCH 2/4] readv.2: Document RWF_ATOMIC flag
Message-ID: <20231009210531.GB214073@frogsfrogsfrogs>
References: <20230929093717.2972367-1-john.g.garry@oracle.com>
 <20230929093717.2972367-3-john.g.garry@oracle.com>
 <20231009174438.GE21283@frogsfrogsfrogs>
 <ZSRk9Z6/i2E+YV9A@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSRk9Z6/i2E+YV9A@dread.disaster.area>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 07:39:17AM +1100, Dave Chinner wrote:
> On Mon, Oct 09, 2023 at 10:44:38AM -0700, Darrick J. Wong wrote:
> > On Fri, Sep 29, 2023 at 09:37:15AM +0000, John Garry wrote:
> > > From: Himanshu Madhani <himanshu.madhani@oracle.com>
> > > 
> > > Add RWF_ATOMIC flag description for pwritev2().
> > > 
> > > Signed-off-by: Himanshu Madhani <himanshu.madhani@oracle.com>
> > > #jpg: complete rewrite
> > > Signed-off-by: John Garry <john.g.garry@oracle.com>
> > > ---
> > >  man2/readv.2 | 45 +++++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 45 insertions(+)
> ....
> > > +For when regular files are opened with
> > > +.BR open (2)
> > > +but without
> > > +.B O_SYNC
> > > +or
> > > +.B O_DSYNC
> > > +and the
> > > +.BR pwritev2()
> > > +call is made without
> > > +.B RWF_SYNC
> > > +or
> > > +.BR RWF_DSYNC
> > > +set, the range metadata must already be flushed to storage and the data range
> > > +must not be in unwritten state, shared, a preallocation, or a hole.
> > 
> > I think that we can drop all of these flags requirements, since the
> > contiguous small space allocation requirement means that the fs can
> > provide all-or-nothing writes even if metadata updates are needed:
> > 
> > If the file range is allocated and marked unwritten (i.e. a
> > preallocation), the ioend will clear the unwritten bit from the file
> > mapping atomically.  After a crash, the application sees either zeroes
> > or all the data that was written.
> > 
> > If the file range is shared, the ioend will map the COW staging extent
> > into the file atomically.  After a crash, the application sees either
> > the old contents from the old blocks, or the new contents from the new
> > blocks.
> > 
> > If the file range is a sparse hole, the directio setup will allocate
> > space and create an unwritten mapping before issuing the write bio.  The
> > rest of the process works the same as preallocations and has the same
> > behaviors.
> > 
> > If the file range is allocated and was previously written, the write is
> > issued and that's all that's needed from the fs.  After a crash, reads
> > of the storage device produce the old contents or the new contents.
> 
> This is exactly what I explained when reviewing the code that
> rejected RWF_ATOMIC without O_DSYNC on metadata dirty inodes.

I'm glad we agree. :)

John, when you're back from vacation, can we get rid of this language
and all those checks under _is_dsync() in the iomap patch?

(That code is 100% the result of me handwaving and bellyaching 6 months
ago when the team was trying to get all the atomic writes bits working
prior to LSF and I was too burned out to think the xfs part through.
As a result, I decided that we'd only support strict overwrites for the
first iteration.)

> > Summarizing:
> > 
> > An (ATOMIC|SYNC) request provides the strongest guarantees (data
> > will not be torn, and all file metadata updates are persisted before
> > the write is returned to userspace.  Programs see either the old data or
> > the new data, even if there's a crash.
> > 
> > (ATOMIC|DSYNC) is less strong -- data will not be torn, and any file
> > updates for just that region are persisted before the write is returned.
> > 
> > (ATOMIC) is the least strong -- data will not be torn.  Neither the
> > filesystem nor the device make guarantees that anything ended up on
> > stable storage, but if it does, programs see either the old data or the
> > new data.
> 
> Yup, that makes sense to me.

Perhaps this ^^ is what we should be documenting here.

> > Maybe we should rename the whole UAPI s/atomic/untorn/...
> 
> Perhaps, though "torn writes" is nomenclature that nobody outside
> storage and filesystem developers really knows about. All I ever
> hear from userspace developers is "we want atomic/all-or-nothing
> data writes"...

Fair 'enuf.

--D

> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
