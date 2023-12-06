Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B678C807806
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 19:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379108AbjLFSss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 13:48:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379234AbjLFSsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 13:48:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84BF41FCB
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 10:48:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9C18C433C7;
        Wed,  6 Dec 2023 18:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701888479;
        bh=+ti42Uy3LaDObl3C2cNA/it91T+eOi0j2YArak6KYyE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VNiL0HtDbCMJEgtw6xQk/Iypp0j8e/QsroWuZHB12LyrOYGCAc9pCPh2PJdmYILhu
         Jc7b/ryZmrcof+TPY9lq9kWqOePGpieR3X4xcLY+O24MVM124XkfUychzNL+OHq9NW
         uAyGYylocxT802Io2AMScXSvWcxH9V5GdouI4Qj0xY9cvsTRC+/YSQKxadYdBIxyOC
         xjZrM98Y7KPh8QL5Tm2XDxdKiwwYtA/wVI0VhWLPV1jNABLQJdu6/6Zo1iMjLASyoW
         gp2V90qAOmtvyUWWX0mSeo7p9Pl9Al8NIcYahHmJ7f7EJhstjwlnV31qT38eXvDiWc
         hStumjTX/XYHg==
Date:   Wed, 6 Dec 2023 10:47:59 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     fstests@vger.kernel.org, samba-technical@lists.samba.org,
        linux-cifs@vger.kernel.org, Steve French <sfrench@samba.org>,
        Paulo Alcantara <pc@manguebit.com>,
        Dave Chinner <david@fromorbit.com>,
        Filipe Manana <fdmanana@suse.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Issues with FIEMAP, xfstests, Samba, ksmbd and CIFS
Message-ID: <20231206184759.GA3964019@frogsfrogsfrogs>
References: <447324.1701860432@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <447324.1701860432@warthog.procyon.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 11:00:32AM +0000, David Howells wrote:
> Hi,
> 
> I've been debugging apparent cifs failures with xfstests, in particular
> generic/009, and I'm finding that the tests are failing because FIEMAP is not
> returning exactly the expected extent map.
> 
> The problem is that the FSCTL_QUERY_ALLOCATED_RANGES smb RPC op can only
> return a list of ranges that are allocated and does not return any other
> information about those allocations or the gaps between them - and thus FIEMAP
> cannot express this information to the extent that the test expects.

<shrug> Perhaps that simply makes FSCTL_QUERY_ALLOCATED_RANGES -> FIEMAP
translation a poor choice?  FIEMAP doesn't have a way to say "written
status unknown".

> Further, as Steve also observed, the expectation that the individual subtests
> should return exactly those ranges is flawed.  The filesystem is at liberty to
> split extents, round up extents, bridge extents and automatically punch out
> blocks of zeros.  xfstests/common/punch allows for some of this, but I wonder
> if it needs to be more fuzzy.
> 
> I wonder if the best xfstests can be expected to check is that the data we
> have written is within the allocated regions.

I think the only expectation that generic/shared tests can have is that
file ranges they've written must not be reported as SEEK_HOLE.  The
ranges reported by SEEK_DATA must include the file ranges written by
application software, but the data ranges can be encompass more range
than that.

> Which brings me on to FALLOC_FL_ZERO_RANGE - is this guaranteed to result in
> an allocated region (if successful)?

Yes, that's the distinction between ZERO and PUNCH.

> Samba is translating FSCTL_SET_ZERO_DATA
> to FALLOC_FL_PUNCH_HOLE, as is ksmbd, and then there is no allocated range to

What does the FSCTL_SET_ZERO_DATA documentation say about the state of
the file range after a successful operation?

Oh.  Heh.  According to:
https://learn.microsoft.com/en-us/windows/win32/api/winioctl/ni-winioctl-fsctl_set_zero_data

"If you use the FSCTL_SET_ZERO_DATA control code to write zeros (0) to a
sparse file and the zero (0) region is large enough, the file system may
not allocate disk space.

"If you use the FSCTL_SET_ZERO_DATA control code to write zeros (0) to a
non-sparse file, zeros (0) are written to the file. The system allocates
disk storage for all of the zero (0) range, which is equivalent to using
the WriteFile function to write zeros (0) to a file.

> report back (Samba and ksmbd use SEEK_HOLE/SEEK_DATA rather than FIEMAP -
> would a ZERO_RANGE even show up with that?).

That depends on the local disk's implementation of lseek and ZERO_RANGE.

XFS, for example, implements ZERO_RANGE by unmapping the entire range
and then reallocating it with an unwritten extent.  There's no reason
why it couldn't also issue a WRITE_SAME to storage and change the
mapping state to written.  The user-visible behavior would be the same
(reads return zeroes, space is allocated).

However.  XFS' SEEK_DATA implementation (aka iomap's) skips over parts
of unwritten extents if there isn't a folio in the page cache.  If some
day the implementation were adjusted to do that WRITE_SAME thing I
mentioned, then SEEK_DATA would return the entire range as data
regardless of pagecache state.

This difference between SEEK_DATA and FIEMAP has led to data corruption
problems in the past, because unwritten extents as reported by FIEMAP
can have dirty page cache sitting around.  SEEK_DATA reports the dirty
pages as data; FIEMAP is silent.

> Finally, should the Linux cifs filesystem translate gaps in the result of
> FSCTL_QUERY_ALLOCATED_RANGES into 'unwritten' extents rather than leaving them
> as gaps in the list (to be reported as holes by xfs_io)?  This smacks a bit of
> adjusting things for the sake of making the testsuite work when the testsuite
> isn't quite compatible with the thing being tested.

That doesn't make sense to me.

> So:
> 
>  - Should Samba and ksmbd be using FALLOC_FL_ZERO_RANGE rather than
>    PUNCH_HOLE?

Probably depends on whether or not they present unix files as sparse or
non-sparse to Windows?

>  - Should Samba and ksmbd be using FIEMAP rather than SEEK_DATA/HOLE?

No.

>  - Should xfstests be less exacting in its FIEMAP analysis - or should this be
>    skipped for cifs?  I don't want to skip generic/009 as it checks some
>    corner cases that need testing, but it may not be possible to make the
>    exact extent matching work.

It's a big lift but I think the generic fstests need to be reworked to
FIEMAP-check only the file ranges that it actually wrote.  Those can't
be SEEK_HOLEs.

--D

> 
> Thanks,
> David
> 
> 
> 
