Return-Path: <linux-kernel+bounces-81046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C40866F6F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 746471C21154
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2ED537FA;
	Mon, 26 Feb 2024 09:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YgCTj1gz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDC1535D9
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 09:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708939464; cv=none; b=Ud6ldiBdGNCZ0QtFX/CiMBdiQrUfiGij5MxDNfZ2yphyeTD5JNRHSpvGNu7R+BwUlcB0AkmVjA+u/aWmaN1a5ikQApfLlVF+TZeurWn6/ZMGivi9ayzCuLjh38dLt3PqBuyr+PlCdAefXVtfL+SEOAMOgxnRgk1worBpaBwaUIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708939464; c=relaxed/simple;
	bh=WB11LOzakWgU/VS2RK2M+0kpdhCDRQPecbLZWpYa+yg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iWtWgm66+4XG0wBQh6kzq0Bbqk3aQrPSIGFkFh3HXoJahkqvQrwXfWB0aaBvUVThgOyVzfvH99eIIJo6A6vBc7LOSJfiG3JHepyTf3NXa/S5FG6gsVmoOh6pXdsjJdV6iFTUEHKoJaO6X9gXZ2optCWYRh0CLmf+AXvCeRQ8t/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YgCTj1gz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708939461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WHheJQ8jhAvFra3cUorxFG8IGWS/n00FWO4HwRZi2Ho=;
	b=YgCTj1gzIyr0Uw/oGP4To3YpLJx7LeEQglvufD5xoj0ntEsTh0Gn5gtbW326VsPnaoKmDn
	moZIcT+5AX+stDEcZVQRnx5/8dy6mn/WjQfqLZ3OO8Da/Tv8pmN/m4AU7Is7Ste1tR9S0D
	0uoYHLZzY4229W+pc0EEkjTRW38NGF0=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-iTJs8F25MJSqoJfX4_pVoQ-1; Mon, 26 Feb 2024 04:24:20 -0500
X-MC-Unique: iTJs8F25MJSqoJfX4_pVoQ-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3bbaf0ee0d9so4024004b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 01:24:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708939460; x=1709544260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WHheJQ8jhAvFra3cUorxFG8IGWS/n00FWO4HwRZi2Ho=;
        b=OGKolZiYn8xK4vlcrf2GBC8wYoPCg9U/sy7Scjtnd1PhOhd18BUl+ITCCZtZ3nI6v1
         7lM4PScN3pzwi/FjBQemYhpDWk4jbdGIuTeii3OoJg9plze42Ip7Hk1H1gLo3IMmnP8W
         5tVavNlkUjp3c0VzquNDIfnM7tFStSIDDNF+z5u4okC6QxS7uUz8pNCLKeqN4yecy5PN
         G+pMbZF6J7p7uC1G7rr6GABtiB2oKSTd1h0DsbkD++yiCdLMWgEbOQvgYpLEVKJvrDe8
         V+GyXxEDlat+l3jdVoBpZFCFdzZ9GSgDzTOv5CvkZrULHPeyZIrnr4OflcuHpdZ2crXI
         icRA==
X-Forwarded-Encrypted: i=1; AJvYcCUlWjEz9Ez/TaupbCnq2ErZqhaiQev13o+hdAjmnqmpXMZRLHeZ/NSMdhkLqEOFcIUXjVT4kDm695tDSxiTHmm8HB3Q7XDHC2m4hVCa
X-Gm-Message-State: AOJu0YwnKXwe65KcTN02tPS8C2De4QOMfVW3b0tmUWZ5i20/F2Vca+hm
	n0Os8BiCzQRwt40i4BRIuuvXR8Cp1C4Vtl83g+8CyjYNUSgWEV6ml4PQD3SuPdncDLbISf3JxaD
	pjLVsw8PiPvvAKUU/aHyXLQI5+/pQsnpGipL/iSWVwiiNAsnbJh7i+zUFdDvl0zqDMmXiIGLbBV
	XYVAYe58hAZzEOBknqkuwMRdsV/3UXHE1AxwnKeYk/7q8fU08=
X-Received: by 2002:a05:6808:a1c:b0:3c1:4524:43d5 with SMTP id n28-20020a0568080a1c00b003c1452443d5mr6240973oij.46.1708939459509;
        Mon, 26 Feb 2024 01:24:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEB6G2UgGCWKGREGy5JNuhDf+v8gE5/KCY45xD44t9wYyBCOCSXHGqMLZDYY7Wv3MdtkmLfuT4NJIEO4bx1AMs=
X-Received: by 2002:a05:6808:a1c:b0:3c1:4524:43d5 with SMTP id
 n28-20020a0568080a1c00b003c1452443d5mr6240957oij.46.1708939458986; Mon, 26
 Feb 2024 01:24:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222075806.1816400-1-yukuai1@huaweicloud.com>
 <20240222075806.1816400-4-yukuai1@huaweicloud.com> <CALTww2_g5Sdxh5f=krWiZ1y2y7ud3XaSX5Hhx-mz3AU45c6rGg@mail.gmail.com>
 <34fbafbe-a510-5193-b86c-91fac69de95f@huaweicloud.com>
In-Reply-To: <34fbafbe-a510-5193-b86c-91fac69de95f@huaweicloud.com>
From: Xiao Ni <xni@redhat.com>
Date: Mon, 26 Feb 2024 17:24:07 +0800
Message-ID: <CALTww2929Ddf_U1z3HJ0BLK2xH=tVSdYtf3EDkdBJrX=xw5Ywg@mail.gmail.com>
Subject: Re: [PATCH md-6.9 03/10] md/raid1: fix choose next idle in read_balance()
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: paul.e.luse@linux.intel.com, song@kernel.org, neilb@suse.com, shli@fb.com, 
	linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org, yi.zhang@huawei.com, 
	yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 5:12=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> Hi,
>
> =E5=9C=A8 2024/02/26 16:55, Xiao Ni =E5=86=99=E9=81=93:
> > Hi Kuai
> >
> > Thanks for the effort!
> >
> > On Thu, Feb 22, 2024 at 4:04=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.co=
m> wrote:
> >>
> >> From: Yu Kuai <yukuai3@huawei.com>
> >>
> >> Commit 12cee5a8a29e ("md/raid1: prevent merging too large request") ad=
d
> >> the case choose next idle in read_balance():
> >>
> >> read_balance:
> >>   for_each_rdev
> >>    if(next_seq_sect =3D=3D this_sector || disk =3D=3D 0)
> >
> > typo error: s/disk/dist/g
> >
> >>    -> sequential reads
> >>     best_disk =3D disk;
> >>     if (...)
> >>      choose_next_idle =3D 1
> >>      continue;
> >>
> >>   for_each_rdev
> >>   -> iterate next rdev
> >>    if (pending =3D=3D 0)
> >>     best_disk =3D disk;
> >>     -> choose the next idle disk
> >>     break;
> >>
> >>    if (choose_next_idle)
> >>     -> keep using this rdev if there are no other idle disk
> >>     continue
> >>
> >> However, commit 2e52d449bcec ("md/raid1: add failfast handling for rea=
ds.")
> >> remove the code:
> >>
> >> -               /* If device is idle, use it */
> >> -               if (pending =3D=3D 0) {
> >> -                       best_disk =3D disk;
> >> -                       break;
> >> -               }
> >>
> >> Hence choose next idle will never work now, fix this problem by
> >> following:
> >>
> >> 1) don't set best_disk in this case, read_balance() will choose the be=
st
> >>     disk after iterating all the disks;
> >> 2) add 'pending' so that other idle disk will be chosen;
> >> 3) set 'dist' to 0 so that if there is no other idle disk, and all dis=
ks
> >>     are rotational, this disk will still be chosen;
> >>
> >> Fixes: 2e52d449bcec ("md/raid1: add failfast handling for reads.")
> >> Co-developed-by: Paul Luse <paul.e.luse@linux.intel.com>
> >> Signed-off-by: Paul Luse <paul.e.luse@linux.intel.com>
> >> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> >> ---
> >>   drivers/md/raid1.c | 21 ++++++++++++---------
> >>   1 file changed, 12 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> >> index c60ea58ae8c5..d0bc67e6d068 100644
> >> --- a/drivers/md/raid1.c
> >> +++ b/drivers/md/raid1.c
> >> @@ -604,7 +604,6 @@ static int read_balance(struct r1conf *conf, struc=
t r1bio *r1_bio, int *max_sect
> >>          unsigned int min_pending;
> >>          struct md_rdev *rdev;
> >>          int choose_first;
> >> -       int choose_next_idle;
> >>
> >>          /*
> >>           * Check if we can balance. We can balance on the whole
> >> @@ -619,7 +618,6 @@ static int read_balance(struct r1conf *conf, struc=
t r1bio *r1_bio, int *max_sect
> >>          best_pending_disk =3D -1;
> >>          min_pending =3D UINT_MAX;
> >>          best_good_sectors =3D 0;
> >> -       choose_next_idle =3D 0;
> >>          clear_bit(R1BIO_FailFast, &r1_bio->state);
> >>
> >>          if ((conf->mddev->recovery_cp < this_sector + sectors) ||
> >> @@ -712,7 +710,6 @@ static int read_balance(struct r1conf *conf, struc=
t r1bio *r1_bio, int *max_sect
> >>                          int opt_iosize =3D bdev_io_opt(rdev->bdev) >>=
 9;
> >>                          struct raid1_info *mirror =3D &conf->mirrors[=
disk];
> >>
> >> -                       best_disk =3D disk;
> >>                          /*
> >>                           * If buffered sequential IO size exceeds opt=
imal
> >>                           * iosize, check if there is idle disk. If ye=
s, choose
> >> @@ -731,15 +728,21 @@ static int read_balance(struct r1conf *conf, str=
uct r1bio *r1_bio, int *max_sect
> >>                              mirror->next_seq_sect > opt_iosize &&
> >>                              mirror->next_seq_sect - opt_iosize >=3D
> >>                              mirror->seq_start) {
> >> -                               choose_next_idle =3D 1;
> >> -                               continue;
> >> +                               /*
> >> +                                * Add 'pending' to avoid choosing thi=
s disk if
> >> +                                * there is other idle disk.
> >> +                                * Set 'dist' to 0, so that if there i=
s no other
> >> +                                * idle disk and all disks are rotatio=
nal, this
> >> +                                * disk will still be chosen.
> >> +                                */
> >> +                               pending++;
> >> +                               dist =3D 0;
> >
> > There is a problem. If all disks are not idle and there is a disk with
> > dist=3D0 before the seq disk, it can't read from the seq disk. It will
> > read from the first disk with dist=3D0. Maybe we can only add the codes
> > which are removed from 2e52d449bcec?
>
> If there is a disk with disk=3D0, then best_dist_disk will be updated to
> the disk, and best_dist will be updated to 0 already:
>
> // in each iteration
> if (dist < best_dist) {
>         best_dist =3D dist;
>         btest_disk_disk =3D disk;
> }
>
> In this case, best_dist will be set to the first disk with dist=3D0, and
> at last, the disk will be chosen:
>
> if (best_disk =3D=3D -1) {
>          if (has_nonrot_disk || min_pending =3D=3D 0)
>                  best_disk =3D best_pending_disk;
>          else
>                  best_disk =3D best_dist_disk;
>                 -> the first disk with dist=3D0;
> }
>
> So, the problem that you concerned should not exist.

Hi Kuai

Thanks for the explanation. You're right. It chooses the first disk
which has dist=3D=3D0. In the above, you made the same typo error disk=3D0
as the comment. I guess you want to use dist=3D0, right? Beside this,
this patch is good to me.

Best Regards
Xiao
>
> Thanks,
> Kuai
> >
> > Best Regards
> > Xiao
> >
> >> +                       } else {
> >> +                               best_disk =3D disk;
> >> +                               break;
> >>                          }
> >> -                       break;
> >>                  }
> >>
> >> -               if (choose_next_idle)
> >> -                       continue;
> >> -
> >>                  if (min_pending > pending) {
> >>                          min_pending =3D pending;
> >>                          best_pending_disk =3D disk;
> >> --
> >> 2.39.2
> >>
> >>
> >
> > .
> >
>


