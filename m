Return-Path: <linux-kernel+bounces-43029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D157B840A72
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01F691C22CB8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A864515444C;
	Mon, 29 Jan 2024 15:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xn7UBdJJ"
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590D3154BFA
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 15:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706543283; cv=none; b=BGhM0+l01ib331YNJFzypyQ3Qxa8Z5CdhK5L1O9zLfsxHrGkENpFZeUQn4Pl7lLICCYM4BgWv++88UnqJQxzQAXOa+G6THVwkaFBkvdVv0g6ARHR7hHAFSH5doWKVmz2oLJWePsyUaszE2H6vSlzSPjYHpG8VPFuv9ZcF63OGD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706543283; c=relaxed/simple;
	bh=3yDimO1UyMKiqWulOUWprVEfvvaqnqCbJQiBomSk6nA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kMbCRl4P/j3uRBgS/rBtRtWJGw+hapxacQfDgRZ14pFNB/vZfyODtlH2B7tRFOgwiyudJzPOgMLwymrc+rfYMLgCYtxgEuc9gRIiZxT7pB0EubJyDf2pw4ZG4ElWbW1MeubtBrBySx/NC5JeKsvd3rsFZyPS4cbq28ZoOO84kPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xn7UBdJJ; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-46b3359f5efso517063137.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 07:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706543281; x=1707148081; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ODjba7daqQSA/bpemrGWhqRuyPAJHOSTchEASYwM++Q=;
        b=Xn7UBdJJIy4dk6h07sxqJ08e4WdFapNf/KUiH3wD3S0RhjxZsCTf8sn1DHxDr6cqKO
         1CbnE/Bhr73Y5h6xFI1nH0XF56pOcYfEdyqZjdoyk/vcTDnzu+2XLFY+2E2afvQ899sd
         yXeAxutuVAA0mI4di09nIAIytgHi5Ovda2LwMnX5wlMh98lI1EGGpnjJ57Hftpws/ezR
         FObKmkt56PGSHUFI2jFuls38XsYyj46KRYDo+x1bAv0SMQJdN6TJyxyH0d67eFgmyyNt
         o+PVLuRUBfPF4oZV3XbAQvJILXfcZDovAiFPyfVZ7x4X6UnRljQjcKFbWlRFqyljKs3H
         KhyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706543281; x=1707148081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ODjba7daqQSA/bpemrGWhqRuyPAJHOSTchEASYwM++Q=;
        b=KjNcXisOQZ+K33hS+KqaL9eIjgfQ/oOs5VZium/tF4p1Do+mdsf42ZAk9ypMAV2Yd1
         ycnBz4GQfLGQFdlR2yNTbajX88nNwfU0JCjOCUucz2DctrPokJ1d55yQqCjsJOHWLZ79
         Sk0BnK9dL/vQ3i6jDs5qyLdMDz9C0DNZ/9BSJvnWdaCqjyEntqhmg9zp5MGHJqHtwQcM
         MPMKsWqNu0MEZVRe4xYbEuCArUbDv7rSV+fk/7227rskVQCNM8HhsLxQEsRCOIDtLPcC
         fSiVtoXXhJ/M7fLwNddCGfs0wdLS9yHcORJhKU72dzlmX67H6yzHsZnq1tES8wm8cULg
         6XsA==
X-Gm-Message-State: AOJu0YyPD5ELswRrRauy6bqNCXkmBRYCjO3eZBIwxtjsGyP3l8Yu0HA6
	4UR1PYiqb+NdZvytR7VR3rIYZUSpgQeaoe/LpMDzKPhuVMPv2749fViDsdNDG6A/G36ov8jquws
	4feMiKzOdbh+Nl92KAprCU+FZgAA=
X-Google-Smtp-Source: AGHT+IH4QDAGFfXnGhrLRLY6rwy51DbyBy7RrfW9QB8vtw0tWsB2LtFxMP4Js/YSviWWCO9pjcat/Nbe9mcYfXqywaQ=
X-Received: by 2002:a05:6122:4e88:b0:4bd:8a18:2b8a with SMTP id
 gf8-20020a0561224e8800b004bd8a182b8amr2197406vkb.24.1706543281055; Mon, 29
 Jan 2024 07:48:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117230032.2312067-1-daeho43@gmail.com> <df9645d9-1e9a-4bd2-88bb-26425cf45811@kernel.org>
 <CACOAw_yjEuGSvo_qyoA13U0HwOr3gOzGtNf2Twhes01SNSGQeg@mail.gmail.com>
 <b18c286a-cc72-439c-b373-98e0d6504618@kernel.org> <CACOAw_yqrtEhq4wtJbs7CVn260h7iZyC7koCWH1iMyeQo5140g@mail.gmail.com>
 <e879da72-4c4f-4aed-8081-784f2de5c887@kernel.org>
In-Reply-To: <e879da72-4c4f-4aed-8081-784f2de5c887@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Mon, 29 Jan 2024 07:47:49 -0800
Message-ID: <CACOAw_xDDoOQEHOAXkG+8PF8yD0MtUAW4J04tYcPCh3VMp7FGQ@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs-tools: allocate logs after conventional
 area for HM zoned devices
To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	kernel-team@android.com, Daeho Jeong <daehojeong@google.com>, 
	Yongpeng Yang <yangyongpeng1@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 28, 2024 at 5:27=E2=80=AFPM Chao Yu <chao@kernel.org> wrote:
>
> On 2024/1/27 2:17, Daeho Jeong wrote:
> > On Thu, Jan 25, 2024 at 5:27=E2=80=AFPM Chao Yu <chao@kernel.org> wrote=
:
> >>
> >> On 2024/1/26 0:25, Daeho Jeong wrote:
> >>> On Wed, Jan 24, 2024 at 7:34=E2=80=AFPM Chao Yu <chao@kernel.org> wro=
te:
> >>>>
> >>>> +Cc Yongpeng Yang
> >>>>
> >>>> Daeho,
> >>>>
> >>>> Yongpeng reports a potential issue: if c.devices[0].total_segments i=
s
> >>>> larger than segments of mainarea, c.cur_seg[CURSEG_HOT_NODE] will ex=
ceed
> >>>> end boundary of mainarea. Could you please check that? though it's a=
 corner
> >>>> case.
> >>>
> >>> Can you elaborate more?
> >>
> >> Since c.cur_seg[CURSEG_HOT_NODE] is an offset started from main_blkadd=
r.
> >
> > Oh, Got it.
> > Then, how about this?
> >
> >           c.cur_seg[CURSEG_HOT_NODE] =3D c.zoned_model =3D=3D F2FS_ZONE=
D_HM ?
> >                           (c.devices[1].start_blkaddr -
> > get_sb(main_blkaddr)) / c.blks_per_seg : 0;
>
> Better, but log header should align to start blkaddr of zone?

It's already aligned here.

        if (c.zoned_mode && c.ndevs > 1)
                zone_align_start_offset +=3D
                        (c.devices[0].total_sectors * c.sector_size) %
zone_size_bytes;

..

        for (i =3D 0; i < c.ndevs; i++) {
                if (i =3D=3D 0) {
                        c.devices[i].total_segments =3D
                                (c.devices[i].total_sectors *
                                c.sector_size - zone_align_start_offset) /
                                segment_size_bytes;
                        c.devices[i].start_blkaddr =3D 0;
                        c.devices[i].end_blkaddr =3D c.devices[i].total_seg=
ments *
                                                c.blks_per_seg - 1 +
                                                sb->segment0_blkaddr;
                } else {
                        c.devices[i].total_segments =3D
                                c.devices[i].total_sectors /
                                (c.sectors_per_blk * c.blks_per_seg);
                        c.devices[i].start_blkaddr =3D
                                        c.devices[i - 1].end_blkaddr + 1;

..

        total_meta_zones =3D ZONE_ALIGN(total_meta_segments *
                                                c.blks_per_seg);

        set_sb(main_blkaddr, get_sb(segment0_blkaddr) + total_meta_zones *
                                c.segs_per_zone * c.blks_per_seg);

>
> Thanks,
>
> >
> >> If c.cur_seg[CURSEG_HOT_NODE] was assigned w/ c.devices[0].total_segme=
nts,
> >> and c.devices[0].total_segments is larger than segments of mainare,
> >> c.cur_seg[CURSEG_HOT_NODE] will exceed the end boundary of mainarea.
> >>
> >>          c.cur_seg[CURSEG_HOT_NODE] =3D c.zoned_model =3D=3D F2FS_ZONE=
D_HM ?
> >>                          c.devices[0].total_segments : 0;
> >>
> >>> In the case of F2FS_ZONED_HM, we have the devices[1].
> >>> Do you mean the case we format the filesystem intentionally smaller
> >>> than what devices have?
> >>
> >> I mean blew case:
> >> device[0]: conventional device size =3D 10240 MB
> >> device[1]: zone device size =3D 2 MB
> >>
> >> Thanks,
> >>
> >>>
> >>>>
> >>>> On 2024/1/18 7:00, Daeho Jeong wrote:
> >>>>> From: Daeho Jeong <daehojeong@google.com>
> >>>>>
> >>>>> Make to allocate logs after conventional area for HM zoned devices =
to
> >>>>> spare them for file pinning support.
> >>>>>
> >>>>> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> >>>>> ---
> >>>>>     mkfs/f2fs_format.c | 3 ++-
> >>>>>     1 file changed, 2 insertions(+), 1 deletion(-)
> >>>>>
> >>>>> diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
> >>>>> index f2840c8..91a7f4b 100644
> >>>>> --- a/mkfs/f2fs_format.c
> >>>>> +++ b/mkfs/f2fs_format.c
> >>>>> @@ -557,7 +557,8 @@ static int f2fs_prepare_super_block(void)
> >>>>>                 c.cur_seg[CURSEG_COLD_DATA] =3D 0;
> >>>>>                 c.cur_seg[CURSEG_WARM_DATA] =3D next_zone(CURSEG_CO=
LD_DATA);
> >>>>>         } else if (c.zoned_mode) {
> >>>>> -             c.cur_seg[CURSEG_HOT_NODE] =3D 0;
> >>>>> +             c.cur_seg[CURSEG_HOT_NODE] =3D c.zoned_model =3D=3D F=
2FS_ZONED_HM ?
> >>>>> +                     c.devices[0].total_segments : 0;
> >>>>>                 c.cur_seg[CURSEG_WARM_NODE] =3D next_zone(CURSEG_HO=
T_NODE);
> >>>>>                 c.cur_seg[CURSEG_COLD_NODE] =3D next_zone(CURSEG_WA=
RM_NODE);
> >>>>>                 c.cur_seg[CURSEG_HOT_DATA] =3D next_zone(CURSEG_COL=
D_NODE);

