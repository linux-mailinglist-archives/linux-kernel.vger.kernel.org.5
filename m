Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3C27D56B5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 17:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343773AbjJXPj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 11:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234241AbjJXPj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 11:39:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78654A3;
        Tue, 24 Oct 2023 08:39:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 103A4C433CB;
        Tue, 24 Oct 2023 15:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698161993;
        bh=/rlLxhNSn/t+30txYLqZQGurJwDZR8upBwpSJggekiY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fNE2f5ibypsa5fChbuudRetPnBp1TT2xK6365rFeS3Js57m5bmA3h5FXnGV6UR1iK
         nXCwfuNle0QfKJq/vkrLReIgI34OSXVdYYJGElM3+qIH5M/7icyn0RlGfDfQjNPhac
         ggYGVB2nPffzd3NGz0FN7dQF6/ei9IJM3zChgLkpWl9iFHBQRPTbI3UiF3Ija5O197
         2rCtg6QjWgEeOCu16Q/HwEyqsj6dv3eFbWwzQmBdNpZUTayI/zb51ZivJRe+MKKnUF
         WJaDfX98ieCrds5MH5M8RQwKjAyx1V7nT1b4dEKbn+T757tZDgCraRuHmW/VtnpVwD
         I/VHb5EPZ/Y8w==
Date:   Tue, 24 Oct 2023 08:39:52 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     John Garry <john.g.garry@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        martin.petersen@oracle.com, david@fromorbit.com,
        himanshu.madhani@oracle.com
Subject: Re: [PATCH 2/4] readv.2: Document RWF_ATOMIC flag
Message-ID: <20231024153952.GK11391@frogsfrogsfrogs>
References: <20230929093717.2972367-1-john.g.garry@oracle.com>
 <20230929093717.2972367-3-john.g.garry@oracle.com>
 <20231009174438.GE21283@frogsfrogsfrogs>
 <0262fed7-a70f-8782-628f-2e9ded0108f8@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0262fed7-a70f-8782-628f-2e9ded0108f8@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 01:30:03PM +0100, John Garry wrote:
> On 09/10/2023 18:44, Darrick J. Wong wrote:
> > On Fri, Sep 29, 2023 at 09:37:15AM +0000, John Garry wrote:
> > > From: Himanshu Madhani <himanshu.madhani@oracle.com>
> > > 
> > > Add RWF_ATOMIC flag description for pwritev2().
> > > 
> > > Signed-off-by: Himanshu Madhani <himanshu.madhani@oracle.com>
> > > #jpg: complete rewrite
> > > Signed-off-by: John Garry <john.g.garry@oracle.com>
> > > ---
> > >   man2/readv.2 | 45 +++++++++++++++++++++++++++++++++++++++++++++
> > >   1 file changed, 45 insertions(+)
> > > 
> > > diff --git a/man2/readv.2 b/man2/readv.2
> > > index fa9b0e4e44a2..ff09f3bc9792 100644
> > > --- a/man2/readv.2
> > > +++ b/man2/readv.2
> > > @@ -193,6 +193,51 @@ which provides lower latency, but may use additional resources.
> > >   .B O_DIRECT
> > >   flag.)
> > >   .TP
> > > +.BR RWF_ATOMIC " (since Linux 6.7)"
> > > +Allows block-based filesystems to indicate that write operations will be issued
> > 
> > "Require regular file write operations to be issued with torn write
> > protection."
> 
> ok
> 
> > 
> > > +with torn-write protection. Torn-write protection means that for a power or any
> > > +other hardware failure, all or none of the data from the write will be stored,
> > > +but never a mix of old and new data. This flag is meaningful only for
> > > +.BR pwritev2 (),
> > > +and its effect applies only to the data range written by the system call.
> > > +The total write length must be power-of-2 and must be sized between
> > > +stx_atomic_write_unit_min and stx_atomic_write_unit_max, both inclusive. The
> > > +write must be at a natural offset within the file with respect to the total
> > 
> > What is a "natural" offset?
> 
> I really meant naturally-aligned offset
> 
> >  That should be defined with more
> > specificity.  Does that mean that the position of a XX-KiB write must
> > also be aligned to XX-KiB?
> 
> Yes
> 
> >  e.g. a 32K untorn write can only start at a
> > multiple of 32K?
> 
> Correct
> 
> > What if the device supports untorn writes between 4K
> > and 64K, does that mean I /cannot/ issue a 32K untorn write at offset
> > 48K?
> 
> Correct
> 
> Do you think that an example would help?

Yes.

> > 
> > > +write length. Torn-write protection only works with
> > > +.B O_DIRECT
> > > +flag, i.e. buffered writes are not supported. To guarantee consistency from
> > > +the write between a file's in-core state with the storage device,
> > > +.BR fdatasync (2)
> > > +or
> > > +.BR fsync (2)
> > > +or
> > > +.BR open (2)
> > > +and
> > > +.B O_SYNC
> > > +or
> > > +.B O_DSYNC
> > > +or
> > > +.B pwritev2 ()
> > > +flag
> > > +.B RWF_SYNC
> > > +or
> > > +.B RWF_DSYNC
> > > +is required.
> > 
> > I'm starting to think that this manpage shouldn't be restating
> > durability information here.
> > 
> > "Application programs with data or file integrity completion
> > requirements must configure synchronous writes with the DSYNC
> > or SYNC flags, as explained above."
> 
> ok
> 
> > 
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
> > 
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
> > 
> 
> 
> Will respond to later mail in thread.

Ok, thank you!

--D

> > Maybe we should rename the whole UAPI s/atomic/untorn/...
> >  > --D
> > 
> > > +.TP
> > >   .BR RWF_SYNC " (since Linux 4.7)"
> > >   .\" commit e864f39569f4092c2b2bc72c773b6e486c7e3bd9
> > >   Provide a per-write equivalent of the
> > > -- 
> > > 2.31.1
> > > 
> 
> Thanks,
> John
> 
