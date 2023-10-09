Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBC37BE88B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 19:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377959AbjJIRom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 13:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377460AbjJIRol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 13:44:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC70A91;
        Mon,  9 Oct 2023 10:44:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DF78C433C8;
        Mon,  9 Oct 2023 17:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696873479;
        bh=ulFW6LSt301EIno4tTQsbIE1fUhJGazrjkE/8EDaSCs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QEdHryOD48pncmxLlJ5bft0gnmB6asyRNvX8CTbb0MXa8fZ0eAENZl+KtMKmQbHKS
         yhT+hyKLUdn35HtHpNzlCUfcjjemV4Yog1YAbymyIPQqSfH47Evb0bt/sd/KC7jIY8
         bx3GhLcK0h1TvK2QDKcmVm9wi5gIiOkvzVbkoIdQQ3FuBx4yT7t94XBiYMgM7C+NTH
         NLXgzI4lgHivPc9uivID3N9XA58XeuB/slfArvnLKF1BCzraY1RTRKDxPM+clyJjZP
         YDl6St49lCgkCHxF1LGhbUesBPJrmGX2DpborkV2t8poSgbMVnUmHTDRIPZCfueH8+
         APEwo5gOMCCzg==
Date:   Mon, 9 Oct 2023 10:44:38 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     John Garry <john.g.garry@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        martin.petersen@oracle.com, david@fromorbit.com,
        himanshu.madhani@oracle.com
Subject: Re: [PATCH 2/4] readv.2: Document RWF_ATOMIC flag
Message-ID: <20231009174438.GE21283@frogsfrogsfrogs>
References: <20230929093717.2972367-1-john.g.garry@oracle.com>
 <20230929093717.2972367-3-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929093717.2972367-3-john.g.garry@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 09:37:15AM +0000, John Garry wrote:
> From: Himanshu Madhani <himanshu.madhani@oracle.com>
> 
> Add RWF_ATOMIC flag description for pwritev2().
> 
> Signed-off-by: Himanshu Madhani <himanshu.madhani@oracle.com>
> #jpg: complete rewrite
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  man2/readv.2 | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/man2/readv.2 b/man2/readv.2
> index fa9b0e4e44a2..ff09f3bc9792 100644
> --- a/man2/readv.2
> +++ b/man2/readv.2
> @@ -193,6 +193,51 @@ which provides lower latency, but may use additional resources.
>  .B O_DIRECT
>  flag.)
>  .TP
> +.BR RWF_ATOMIC " (since Linux 6.7)"
> +Allows block-based filesystems to indicate that write operations will be issued

"Require regular file write operations to be issued with torn write
protection."

> +with torn-write protection. Torn-write protection means that for a power or any
> +other hardware failure, all or none of the data from the write will be stored,
> +but never a mix of old and new data. This flag is meaningful only for
> +.BR pwritev2 (),
> +and its effect applies only to the data range written by the system call.
> +The total write length must be power-of-2 and must be sized between
> +stx_atomic_write_unit_min and stx_atomic_write_unit_max, both inclusive. The
> +write must be at a natural offset within the file with respect to the total

What is a "natural" offset?  That should be defined with more
specificity.  Does that mean that the position of a XX-KiB write must
also be aligned to XX-KiB?  e.g. a 32K untorn write can only start at a
multiple of 32K?  What if the device supports untorn writes between 4K
and 64K, does that mean I /cannot/ issue a 32K untorn write at offset
48K?

> +write length. Torn-write protection only works with
> +.B O_DIRECT
> +flag, i.e. buffered writes are not supported. To guarantee consistency from
> +the write between a file's in-core state with the storage device,
> +.BR fdatasync (2)
> +or
> +.BR fsync (2)
> +or
> +.BR open (2)
> +and
> +.B O_SYNC
> +or
> +.B O_DSYNC
> +or
> +.B pwritev2 ()
> +flag
> +.B RWF_SYNC
> +or
> +.B RWF_DSYNC
> +is required.

I'm starting to think that this manpage shouldn't be restating
durability information here.

"Application programs with data or file integrity completion
requirements must configure synchronous writes with the DSYNC
or SYNC flags, as explained above."

> +For when regular files are opened with
> +.BR open (2)
> +but without
> +.B O_SYNC
> +or
> +.B O_DSYNC
> +and the
> +.BR pwritev2()
> +call is made without
> +.B RWF_SYNC
> +or
> +.BR RWF_DSYNC
> +set, the range metadata must already be flushed to storage and the data range
> +must not be in unwritten state, shared, a preallocation, or a hole.

I think that we can drop all of these flags requirements, since the
contiguous small space allocation requirement means that the fs can
provide all-or-nothing writes even if metadata updates are needed:

If the file range is allocated and marked unwritten (i.e. a
preallocation), the ioend will clear the unwritten bit from the file
mapping atomically.  After a crash, the application sees either zeroes
or all the data that was written.

If the file range is shared, the ioend will map the COW staging extent
into the file atomically.  After a crash, the application sees either
the old contents from the old blocks, or the new contents from the new
blocks.

If the file range is a sparse hole, the directio setup will allocate
space and create an unwritten mapping before issuing the write bio.  The
rest of the process works the same as preallocations and has the same
behaviors.

If the file range is allocated and was previously written, the write is
issued and that's all that's needed from the fs.  After a crash, reads
of the storage device produce the old contents or the new contents.

Summarizing:

An (ATOMIC|SYNC) request provides the strongest guarantees (data
will not be torn, and all file metadata updates are persisted before
the write is returned to userspace.  Programs see either the old data or
the new data, even if there's a crash.

(ATOMIC|DSYNC) is less strong -- data will not be torn, and any file
updates for just that region are persisted before the write is returned.

(ATOMIC) is the least strong -- data will not be torn.  Neither the
filesystem nor the device make guarantees that anything ended up on
stable storage, but if it does, programs see either the old data or the
new data.

Maybe we should rename the whole UAPI s/atomic/untorn/...

--D

> +.TP
>  .BR RWF_SYNC " (since Linux 4.7)"
>  .\" commit e864f39569f4092c2b2bc72c773b6e486c7e3bd9
>  Provide a per-write equivalent of the
> -- 
> 2.31.1
> 
