Return-Path: <linux-kernel+bounces-151837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBA58AB48C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 19:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24658B222D9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3DA13AD3D;
	Fri, 19 Apr 2024 17:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VBtjoHLw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA994137C37
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 17:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713549213; cv=none; b=KwNAtj8cHRf6y/qDpdnpBHTShme8STOaMbOs4g00GFYNqiM2gxKs8izf6Y48vMTDY+YkUeNPGV5Rsz0ae3mJws0tin3tRjuqg4dJOhTEhHgJRB/48BQBzmzJyZ4+LJ2TBgdf0XGySktjMQTgt5W35QHvaowkid+KxNFublZitoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713549213; c=relaxed/simple;
	bh=iOvCT/WvjvN0ne6jZc9fwVFe6Ol/RX862VOzAL9BN1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IEFs83Whbs9ClUmQ7WVTqYZOMeKfwP0FlpA41DaN7jwOTfHUEAjTScVE9v0q19VYn1/AjeNQqfOwAwOQqDaFeBdy4uv8nahT3pdD4OoPe0ihEiTDLQfp8Ym9MyNSME4W/zTGISgSL9zReu6lWOdIA2Zp/Mn1c/ynvt/iG6RmFUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VBtjoHLw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25506C072AA;
	Fri, 19 Apr 2024 17:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713549213;
	bh=iOvCT/WvjvN0ne6jZc9fwVFe6Ol/RX862VOzAL9BN1A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VBtjoHLwKWN8PyJUUavjS656eJDpK3ndwx8vLbu9zKavIHlwlUckNNnvGQR2QCa88
	 Wlf+Pr8enEhSNpdWhHMnXCvW4akR++qh94/hqFgGS3DeU6sAzOdnnBmJfKAT8aF2dV
	 Cy9MD1+Pe9ZbvaQC3Y90yLFTeowxkZW3CssDcXQtUFBeUDN75JDFh/8weT8xDGx9sp
	 ayBEnxvEqFSEAu7uH5PKKHxfwnW70aSpacGNEm1/ajw8soyfEjk69PDRH8f4E/C7kZ
	 XYRdkcG0U+elu3/3z96LAHB+AkeUdHzhjFaZcYDTthwJTNOJ1nVkp0fD5OqnMOoLXs
	 Lw9PVugidVzDw==
Date: Fri, 19 Apr 2024 17:53:31 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: assign the write hint per stream by
 default
Message-ID: <ZiKvm57zbjq_ZpZj@google.com>
References: <20240417211201.3919770-1-jaegeuk@kernel.org>
 <afe91331-92a5-4ccf-b5b3-095a2d65f0d0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afe91331-92a5-4ccf-b5b3-095a2d65f0d0@kernel.org>

On 04/18, Chao Yu wrote:
> On 2024/4/18 5:12, Jaegeuk Kim wrote:
> > This reverts commit 930e2607638d ("f2fs: remove obsolete whint_mode"), as we
> > decide to pass write hints to the disk.
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >   Documentation/filesystems/f2fs.rst | 29 +++++++++++++++
> >   fs/f2fs/data.c                     |  2 +
> >   fs/f2fs/f2fs.h                     |  2 +
> >   fs/f2fs/segment.c                  | 59 ++++++++++++++++++++++++++++++
> >   4 files changed, 92 insertions(+)
> > 
> > diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
> > index efc3493fd6f8..68a0885fb5e6 100644
> > --- a/Documentation/filesystems/f2fs.rst
> > +++ b/Documentation/filesystems/f2fs.rst
> > @@ -774,6 +774,35 @@ In order to identify whether the data in the victim segment are valid or not,
> >   F2FS manages a bitmap. Each bit represents the validity of a block, and the
> >   bitmap is composed of a bit stream covering whole blocks in main area.
> > +Write-hint Policy
> > +-----------------
> > +
> > +F2FS sets the whint all the time with the below policy.
> 
> No user-based mode?

Not anymore, as there's no user.

> 
> Thanks,
> 
> > +
> > +===================== ======================== ===================
> > +User                  F2FS                     Block
> > +===================== ======================== ===================
> > +N/A                   META                     WRITE_LIFE_NONE|REQ_META
> > +N/A                   HOT_NODE                 WRITE_LIFE_NONE
> > +N/A                   WARM_NODE                WRITE_LIFE_MEDIUM
> > +N/A                   COLD_NODE                WRITE_LIFE_LONG
> > +ioctl(COLD)           COLD_DATA                WRITE_LIFE_EXTREME
> > +extension list        "                        "
> > +
> > +-- buffered io
> > +N/A                   COLD_DATA                WRITE_LIFE_EXTREME
> > +N/A                   HOT_DATA                 WRITE_LIFE_SHORT
> > +N/A                   WARM_DATA                WRITE_LIFE_NOT_SET
> > +
> > +-- direct io
> > +WRITE_LIFE_EXTREME    COLD_DATA                WRITE_LIFE_EXTREME
> > +WRITE_LIFE_SHORT      HOT_DATA                 WRITE_LIFE_SHORT
> > +WRITE_LIFE_NOT_SET    WARM_DATA                WRITE_LIFE_NOT_SET
> > +WRITE_LIFE_NONE       "                        WRITE_LIFE_NONE
> > +WRITE_LIFE_MEDIUM     "                        WRITE_LIFE_MEDIUM
> > +WRITE_LIFE_LONG       "                        WRITE_LIFE_LONG
> > +===================== ======================== ===================
> > +
> >   Fallocate(2) Policy
> >   -------------------
> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > index 5d641fac02ba..ed7d08785fcf 100644
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > @@ -465,6 +465,8 @@ static struct bio *__bio_alloc(struct f2fs_io_info *fio, int npages)
> >   	} else {
> >   		bio->bi_end_io = f2fs_write_end_io;
> >   		bio->bi_private = sbi;
> > +		bio->bi_write_hint = f2fs_io_type_to_rw_hint(sbi,
> > +						fio->type, fio->temp);
> >   	}
> >   	iostat_alloc_and_bind_ctx(sbi, bio, NULL);
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index dd530dc70005..b3b878acc86b 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -3745,6 +3745,8 @@ void f2fs_destroy_segment_manager(struct f2fs_sb_info *sbi);
> >   int __init f2fs_create_segment_manager_caches(void);
> >   void f2fs_destroy_segment_manager_caches(void);
> >   int f2fs_rw_hint_to_seg_type(enum rw_hint hint);
> > +enum rw_hint f2fs_io_type_to_rw_hint(struct f2fs_sb_info *sbi,
> > +			enum page_type type, enum temp_type temp);
> >   unsigned int f2fs_usable_segs_in_sec(struct f2fs_sb_info *sbi,
> >   			unsigned int segno);
> >   unsigned int f2fs_usable_blks_in_seg(struct f2fs_sb_info *sbi,
> > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > index f0da516ba8dc..daa94669f7ee 100644
> > --- a/fs/f2fs/segment.c
> > +++ b/fs/f2fs/segment.c
> > @@ -3364,6 +3364,65 @@ int f2fs_rw_hint_to_seg_type(enum rw_hint hint)
> >   	}
> >   }
> > +/*
> > + * This returns write hints for each segment type. This hints will be
> > + * passed down to block layer as below by default.
> > + *
> > + * User                  F2FS                     Block
> > + * ----                  ----                     -----
> > + *                       META                     WRITE_LIFE_NONE|REQ_META
> > + *                       HOT_NODE                 WRITE_LIFE_NONE
> > + *                       WARM_NODE                WRITE_LIFE_MEDIUM
> > + *                       COLD_NODE                WRITE_LIFE_LONG
> > + * ioctl(COLD)           COLD_DATA                WRITE_LIFE_EXTREME
> > + * extension list        "                        "
> > + *
> > + * -- buffered io
> > + *                       COLD_DATA                WRITE_LIFE_EXTREME
> > + *                       HOT_DATA                 WRITE_LIFE_SHORT
> > + *                       WARM_DATA                WRITE_LIFE_NOT_SET
> > + *
> > + * -- direct io
> > + * WRITE_LIFE_EXTREME    COLD_DATA                WRITE_LIFE_EXTREME
> > + * WRITE_LIFE_SHORT      HOT_DATA                 WRITE_LIFE_SHORT
> > + * WRITE_LIFE_NOT_SET    WARM_DATA                WRITE_LIFE_NOT_SET
> > + * WRITE_LIFE_NONE       "                        WRITE_LIFE_NONE
> > + * WRITE_LIFE_MEDIUM     "                        WRITE_LIFE_MEDIUM
> > + * WRITE_LIFE_LONG       "                        WRITE_LIFE_LONG
> > + */
> > +enum rw_hint f2fs_io_type_to_rw_hint(struct f2fs_sb_info *sbi,
> > +				enum page_type type, enum temp_type temp)
> > +{
> > +	switch (type) {
> > +	case DATA:
> > +		switch (temp) {
> > +		case WARM:
> > +			return WRITE_LIFE_NOT_SET;
> > +		case HOT:
> > +			return WRITE_LIFE_SHORT;
> > +		case COLD:
> > +			return WRITE_LIFE_EXTREME;
> > +		default:
> > +			return WRITE_LIFE_NONE;
> > +		}
> > +	case NODE:
> > +		switch (temp) {
> > +		case WARM:
> > +			return WRITE_LIFE_MEDIUM;
> > +		case HOT:
> > +			return WRITE_LIFE_NONE;
> > +		case COLD:
> > +			return WRITE_LIFE_LONG;
> > +		default:
> > +			return WRITE_LIFE_NONE;
> > +		}
> > +	case META:
> > +		return WRITE_LIFE_NONE;
> > +	default:
> > +		return WRITE_LIFE_NONE;
> > +	}
> > +}
> > +
> >   static int __get_segment_type_2(struct f2fs_io_info *fio)
> >   {
> >   	if (fio->type == DATA)

