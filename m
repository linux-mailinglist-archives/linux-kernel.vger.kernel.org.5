Return-Path: <linux-kernel+bounces-48419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B60845BB3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA3FB1F2C086
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191C46216D;
	Thu,  1 Feb 2024 15:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwWXTj4H"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0047626BA
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 15:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706801882; cv=none; b=E4xjhX0RCgCJsoHRzwrgYiXSjhI7UXtdk9rADVP3c7ZSOC5D9bIT5MfRV+nRkSoGKlJsAdaJkY2fq4uvSl7QC3x6XD1YFCTR6JUUWJo1zI8kkAvzu5u6RcN4CWz4xBdFPkHDPBIofBfWOa5LCLbMQBOl3/YyUbBOIc/lOwWYsPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706801882; c=relaxed/simple;
	bh=GVViT6tqISCoUu5TVAQ9rPmKEappfvHEDinsW+L8MNA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Su5XJWHUKxY6oQcQFTvewp9DwJiSaB4FQHIQPv7L1PCTI7G1NILhhnxu2edp8DJKB4JmC3TIqoGTyHSUsCh/CQZiZjb4zjMQp676rHdrPXSEKIdvbKU+dvx8Rph5W+KD0Ly9NWAaHGnsIXAH1Ln6AJNjeMJm+WwhqrHSQ4YqVho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SwWXTj4H; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-42a99f34cc8so5774971cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 07:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706801879; x=1707406679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3D22Un3/go87mbr1Mhl5zC05s5c/j7TuagOLXFOoVAE=;
        b=SwWXTj4HBMZ4IBndwKAk+kIMfLIXAxaQvVcUZqBP0qh7U+gsz470IBddPDbbTkeMEI
         zbrjso8QK3beY+F6DnOTTnlQP5S3HWUjTjy30ngkmAJ6BWOBiYhvQbDnU342SgS54wb0
         ugIONGLLYCxXurJYEKdwamfq4j+nENQNSu9ROkx/eW5c1QLzQX6hp3WfG98AckNZ1IjZ
         JIaJqXzAWEL70qqnwJszn9SldaNQHrtZZ16EhQPEZt5WYrvCi4/5x3rzGZLgH61n9ABG
         0jYo6HZqPsVm+85r6UsAJ8ZQeUgv7bzhix4JnC2gdQ7gafJ8iyOVeHDAq2DAyZZZ6Wby
         Vp8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706801879; x=1707406679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3D22Un3/go87mbr1Mhl5zC05s5c/j7TuagOLXFOoVAE=;
        b=OYiatnlbNwHBptr4LEfipp6qjBCBuHlx+4SFlwuTi9qp4UttUbvoi/gpSnfyBG33gt
         d4E61fqGHVAgdvyQjaj4NxQ4U+3qNJ63TZgTUkl+9a6BfPkQ3jmmvIN5PeZd6sgAxyG1
         xDEyVY79538kdZX3/a7h28UuhEaa8AkZSKCNCqY4ZBw05UIApZXVOY9OCpSw4Y5Qr+PW
         bMjHyWstNwI1/pLOUaAoa82z2d9vsEvR8lLhqW4JifmbCEEmvixMBTdct+E7LfGVAZd8
         1wMMgPM3P7SJcLH7RjfM8biKKVgf8NLHOOpzzZ3/DmE4NURRwzqKCFvjkD/xAfJJwsV/
         3JCg==
X-Gm-Message-State: AOJu0YyP5UaocryUeyEMpOBPq4e1PwElFGytRJ7+18B+XzL9xoRuXR4m
	oNl1juF965KFFjyYS4aX7mkesRYpduNyVIfeJqXPBu+vm/ZasdfFlqhSkJMwJbfwdqJhtBTBiCY
	FSpkTrqyr/l+mlVhopVakVJ/ikYFP27HqPOEU5Xnr
X-Google-Smtp-Source: AGHT+IFIV+HhJpXd/G2A60dyv4hp507KJye/46cghdPTGAhJIbcBSl/FHR2DsUhbxionxZ/MlToCdXInxaorheMZiU4=
X-Received: by 2002:ac8:7d4f:0:b0:42b:ef60:192 with SMTP id
 h15-20020ac87d4f000000b0042bef600192mr2812346qtb.13.1706801879379; Thu, 01
 Feb 2024 07:37:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123081258.700-1-qwjhust@gmail.com> <cedb4875-5795-4789-a010-a9c66fa61707@oppo.com>
 <6e91f64a-638c-465d-8fb2-ed70231db23a@kernel.org>
In-Reply-To: <6e91f64a-638c-465d-8fb2-ed70231db23a@kernel.org>
From: Wenjie Qi <qwjhust@gmail.com>
Date: Thu, 1 Feb 2024 23:37:45 +0800
Message-ID: <CAGFpFsQ2B0yvT35K+wn=XW7rMPkc-m3zU_FiVRAzX3psFT6QMA@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: fix zoned block device information initialization
To: Chao Yu <chao@kernel.org>
Cc: Yongpeng Yang <yangyongpeng1@oppo.com>, hustqwj@hust.edu.cn, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

Yes, I also agree with using bdev_max_open_zones() instead of
bdev_max_active_zones().
I will submit a revised version as soon as possible.

Thanks,

On Thu, Feb 1, 2024 at 10:47=E2=80=AFPM Chao Yu <chao@kernel.org> wrote:
>
> On 2024/1/23 17:18, Yongpeng Yang wrote:
> > Hi Wenjie,
> > It seems more reasonable to use bdev_max_open_zones instead of
> > bdev_max_active_zones.
>
> Hi all,
>
> I guess it needs to be initialized w/ bdev_max_open_zones(), due
> to the max of open zones of zoned device limits the number of
> zones that a host software can simultaneously write [1], right?
>
> [1] https://zonedstorage.io/docs/introduction/zoned-storage#active-zones-=
limit
>
> Thanks,
>
> >
> > If an NVMe device has multiple namespaces, and the device contains a
> > total of 11 open zones, two of the namespaces, nvme0n1 and nvme0n2, eac=
h
> > correspond to an instance of the F2FS filesystem, and both filesystem
> > instances can be initialized successfully. Since multiple namespaces
> > share all open zones, the number of open zones is not equal to the
> > number of open zones available to F2FS in a multi-namespace scenario.
> > This patch does not yet cover this scenario.
> >
> > On 1/23/2024 4:12 PM, Wenjie Qi wrote:
> >> If the max active zones of zoned devices are less than
> >> the active logs of F2FS, the device may error due to
> >> insufficient zone resources when multiple active logs are
> >> being written at the same time. If this value is 0, there is no limit.
> >>
> >> Signed-off-by: Wenjie Qi <qwjhust@gmail.com>
> >> ---
> >>    fs/f2fs/f2fs.h  |  1 +
> >>    fs/f2fs/super.c | 18 ++++++++++++++++++
> >>    2 files changed, 19 insertions(+)
> >>
> >> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> >> index 65294e3b0bef..669f84f6b0e5 100644
> >> --- a/fs/f2fs/f2fs.h
> >> +++ b/fs/f2fs/f2fs.h
> >> @@ -1551,6 +1551,7 @@ struct f2fs_sb_info {
> >>
> >>    #ifdef CONFIG_BLK_DEV_ZONED
> >>      unsigned int blocks_per_blkz;           /* F2FS blocks per zone *=
/
> >> +    unsigned int max_active_zones;          /* max zone resources of =
the zoned device */
> >>    #endif
> >>
> >>      /* for node-related operations */
> >> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> >> index 206d03c82d96..aef41b54098c 100644
> >> --- a/fs/f2fs/super.c
> >> +++ b/fs/f2fs/super.c
> >> @@ -2385,6 +2385,16 @@ static int f2fs_remount(struct super_block *sb,=
 int *flags, char *data)
> >>      if (err)
> >>              goto restore_opts;
> >>
> >> +#ifdef CONFIG_BLK_DEV_ZONED
> >> +    if (sbi->max_active_zones && sbi->max_active_zones < F2FS_OPTION(=
sbi).active_logs) {
> >> +            f2fs_err(sbi,
> >> +                    "zoned: max active zones %u is too small, need at=
 least %u active zones",
> >> +                             sbi->max_active_zones, F2FS_OPTION(sbi).=
active_logs);
> >> +            err =3D -EINVAL;
> >> +            goto restore_opts;
> >> +    }
> >> +#endif
> >> +
> >>      /* flush outstanding errors before changing fs state */
> >>      flush_work(&sbi->s_error_work);
> >>
> >> @@ -3932,6 +3942,14 @@ static int init_blkz_info(struct f2fs_sb_info *=
sbi, int devi)
> >>      if (!f2fs_sb_has_blkzoned(sbi))
> >>              return 0;
> >>
> >> +    sbi->max_active_zones =3D bdev_max_active_zones(bdev);
> >> +    if (sbi->max_active_zones && sbi->max_active_zones < F2FS_OPTION(=
sbi).active_logs) {
> >> +            f2fs_err(sbi,
> >> +                    "zoned: max active zones %u is too small, need at=
 least %u active zones",
> >> +                             sbi->max_active_zones, F2FS_OPTION(sbi).=
active_logs);
> >> +            return -EINVAL;
> >> +    }
> >> +
> >>      zone_sectors =3D bdev_zone_sectors(bdev);
> >>      if (!is_power_of_2(zone_sectors)) {
> >>              f2fs_err(sbi, "F2FS does not support non power of 2 zone =
sizes\n");

