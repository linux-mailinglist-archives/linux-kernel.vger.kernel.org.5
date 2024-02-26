Return-Path: <linux-kernel+bounces-81469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15AE5867656
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79A791F28708
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED72127B72;
	Mon, 26 Feb 2024 13:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S1h1z3dW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B133680047
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 13:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708953645; cv=none; b=jSQw345rjZoMXWAwtqs0L93bMpeTXRudDqC+Ir0fXYPuT8KUo/SnDLyoMIqA42Ap32YF2SJALiCf68opgZlU4DKr1886dJtfY8iDd9rywc/aLCDGApzG3eObpE8Gzlk5b8L3xAlFg1mWma42LFTuE4E7ZFhNVzo331GmtfvZvvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708953645; c=relaxed/simple;
	bh=psIYCYpBnH0fo6/M/5Rdv0ls6pa4T/2RvhrsUo1gFdc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=avCqOSPqF4InGbwrLKHl1ADoPhN5L7luUDanrD9qw/osAYIZRb2X47e8jH5tajRjVNIZL6m3YuhIWLCvz8ewsn27eSzl4NJcWCuftCNRIsR1UpB5hxNW0c6oD/EU/213mXdcm78Pmvc+ecWQGiOvAFGqIZIK0zKi9MhN2/bqMS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S1h1z3dW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708953642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UsD/vtGG6Pp/OYK0mG1PuwY5+brItxLXiMrL8IG+7Xs=;
	b=S1h1z3dWa644eJtQkskNxdCt6p3i89il4hK8K/BK/CTveUZ1XpcSpBNED3K2pvaMrggPMS
	2tswDlDeyTersR3Uf49ZglTrJ0YTjjwuX9PzX2Ros7BQH8EonHjWK6yXCC6nA4xUkcvosV
	0+D52KLc4p8QbqWB3HpTtqwFu3IIJx0=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-VDBZDaNNP3Gz9MHZprVhVw-1; Mon, 26 Feb 2024 08:20:41 -0500
X-MC-Unique: VDBZDaNNP3Gz9MHZprVhVw-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1dbcbfff988so28659965ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 05:20:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708953640; x=1709558440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UsD/vtGG6Pp/OYK0mG1PuwY5+brItxLXiMrL8IG+7Xs=;
        b=CRBnQrgmH+IeysFK/B3TMBNSWja34qo+yLJKZx66VLf9seo5tcQtZM661xkpzcW93m
         9WRmpbW0uoMw5wfcSEkOFcXswZF4IV7naXGJMN/rZbUGmg71MLKLykaMZDTgh6s0FGIj
         GEcxe/dw2gTAkPahiur3sAi0fi/N2Rw7HmVOGhaXxTGitZQLgkwfUAsCsOkxFyk6N6Bv
         GJvgIOkQ0J5aK+JylCYXZNW2ptisebNU4LaYCMl33YHHwvVYPxWVr8LEwB9YdkPq8fIG
         DDbTAgjvgsRBNK+r77uoAraOYlegT0tvIT6zJ5ceKzXC3uZXiBOttiil3vjO0gZ+gki0
         rOzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgiu+1ZXKiq8826lLrPHGMdOeZlVHdXO2/xH+3UoUJXV0X7SBj/TbIPFLTaUWDJGDgqDV44/OdTLCxcADqLW9U7mNucQs/8iD+NJT0
X-Gm-Message-State: AOJu0YxPFZV2uK4B+Ye2ZzJrJFvrEWSfuQ23o31KecO87TnU26JIo/rJ
	l6NU36oCJepKwVlXh2ac9mxEKQCf0p+I5IDidRNx/JS4maFMgtbFiglX3xY/kEoSS2+uTXacuUG
	+QA9xhuuMou8d1EA47hIGPynkOo9LHJmmcjXAK1EwFRa40o/HtwRsgkB0KC4ZCAj7mWzPpM/bv7
	UI1Co4e+vllIfGoYERDdVfWpMAz+uhmV76uIjc
X-Received: by 2002:a17:902:ced1:b0:1dc:a60a:a7c7 with SMTP id d17-20020a170902ced100b001dca60aa7c7mr2726124plg.25.1708953640040;
        Mon, 26 Feb 2024 05:20:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEL8ZGzj0P/TZL1oEPLgaDBPNrRIMFYFyoJbGCAFn/mioniGNyDtLErzzs3HigAwm8WSOhcv85RfF3pmSTy/uA=
X-Received: by 2002:a17:902:ced1:b0:1dc:a60a:a7c7 with SMTP id
 d17-20020a170902ced100b001dca60aa7c7mr2726108plg.25.1708953639726; Mon, 26
 Feb 2024 05:20:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222075806.1816400-1-yukuai1@huaweicloud.com>
 <20240222075806.1816400-4-yukuai1@huaweicloud.com> <CALTww2_g5Sdxh5f=krWiZ1y2y7ud3XaSX5Hhx-mz3AU45c6rGg@mail.gmail.com>
 <34fbafbe-a510-5193-b86c-91fac69de95f@huaweicloud.com> <CALTww2929Ddf_U1z3HJ0BLK2xH=tVSdYtf3EDkdBJrX=xw5Ywg@mail.gmail.com>
 <05fab111-7111-1dca-57a8-89069a34adc2@huaweicloud.com>
In-Reply-To: <05fab111-7111-1dca-57a8-89069a34adc2@huaweicloud.com>
From: Xiao Ni <xni@redhat.com>
Date: Mon, 26 Feb 2024 21:20:28 +0800
Message-ID: <CALTww2_svVmTsj_ue7au96TQtQzSEfuX4AuAXFvKn9SZDUDSnQ@mail.gmail.com>
Subject: Re: [PATCH md-6.9 03/10] md/raid1: fix choose next idle in read_balance()
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: paul.e.luse@linux.intel.com, song@kernel.org, neilb@suse.com, shli@fb.com, 
	linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org, yi.zhang@huawei.com, 
	yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 5:40=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> Hi,
>
> =E5=9C=A8 2024/02/26 17:24, Xiao Ni =E5=86=99=E9=81=93:
> > On Mon, Feb 26, 2024 at 5:12=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.co=
m> wrote:
> >>
> >> Hi,
> >>
> >> =E5=9C=A8 2024/02/26 16:55, Xiao Ni =E5=86=99=E9=81=93:
> >>> Hi Kuai
> >>>
> >>> Thanks for the effort!
> >>>
> >>> On Thu, Feb 22, 2024 at 4:04=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.=
com> wrote:
> >>>>
> >>>> From: Yu Kuai <yukuai3@huawei.com>
> >>>>
> >>>> Commit 12cee5a8a29e ("md/raid1: prevent merging too large request") =
add
> >>>> the case choose next idle in read_balance():
> >>>>
> >>>> read_balance:
> >>>>    for_each_rdev
> >>>>     if(next_seq_sect =3D=3D this_sector || disk =3D=3D 0)
> >>>
> >>> typo error: s/disk/dist/g
> >>>
> >>>>     -> sequential reads
> >>>>      best_disk =3D disk;
> >>>>      if (...)
> >>>>       choose_next_idle =3D 1
> >>>>       continue;
> >>>>
> >>>>    for_each_rdev
> >>>>    -> iterate next rdev
> >>>>     if (pending =3D=3D 0)
> >>>>      best_disk =3D disk;
> >>>>      -> choose the next idle disk
> >>>>      break;
> >>>>
> >>>>     if (choose_next_idle)
> >>>>      -> keep using this rdev if there are no other idle disk
> >>>>      continue
> >>>>
> >>>> However, commit 2e52d449bcec ("md/raid1: add failfast handling for r=
eads.")
> >>>> remove the code:
> >>>>
> >>>> -               /* If device is idle, use it */
> >>>> -               if (pending =3D=3D 0) {
> >>>> -                       best_disk =3D disk;
> >>>> -                       break;
> >>>> -               }
> >>>>
> >>>> Hence choose next idle will never work now, fix this problem by
> >>>> following:
> >>>>
> >>>> 1) don't set best_disk in this case, read_balance() will choose the =
best
> >>>>      disk after iterating all the disks;
> >>>> 2) add 'pending' so that other idle disk will be chosen;
> >>>> 3) set 'dist' to 0 so that if there is no other idle disk, and all d=
isks
> >>>>      are rotational, this disk will still be chosen;
> >>>>
> >>>> Fixes: 2e52d449bcec ("md/raid1: add failfast handling for reads.")
> >>>> Co-developed-by: Paul Luse <paul.e.luse@linux.intel.com>
> >>>> Signed-off-by: Paul Luse <paul.e.luse@linux.intel.com>
> >>>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> >>>> ---
> >>>>    drivers/md/raid1.c | 21 ++++++++++++---------
> >>>>    1 file changed, 12 insertions(+), 9 deletions(-)
> >>>>
> >>>> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> >>>> index c60ea58ae8c5..d0bc67e6d068 100644
> >>>> --- a/drivers/md/raid1.c
> >>>> +++ b/drivers/md/raid1.c
> >>>> @@ -604,7 +604,6 @@ static int read_balance(struct r1conf *conf, str=
uct r1bio *r1_bio, int *max_sect
> >>>>           unsigned int min_pending;
> >>>>           struct md_rdev *rdev;
> >>>>           int choose_first;
> >>>> -       int choose_next_idle;
> >>>>
> >>>>           /*
> >>>>            * Check if we can balance. We can balance on the whole
> >>>> @@ -619,7 +618,6 @@ static int read_balance(struct r1conf *conf, str=
uct r1bio *r1_bio, int *max_sect
> >>>>           best_pending_disk =3D -1;
> >>>>           min_pending =3D UINT_MAX;
> >>>>           best_good_sectors =3D 0;
> >>>> -       choose_next_idle =3D 0;
> >>>>           clear_bit(R1BIO_FailFast, &r1_bio->state);
> >>>>
> >>>>           if ((conf->mddev->recovery_cp < this_sector + sectors) ||
> >>>> @@ -712,7 +710,6 @@ static int read_balance(struct r1conf *conf, str=
uct r1bio *r1_bio, int *max_sect
> >>>>                           int opt_iosize =3D bdev_io_opt(rdev->bdev)=
 >> 9;
> >>>>                           struct raid1_info *mirror =3D &conf->mirro=
rs[disk];
> >>>>
> >>>> -                       best_disk =3D disk;
> >>>>                           /*
> >>>>                            * If buffered sequential IO size exceeds =
optimal
> >>>>                            * iosize, check if there is idle disk. If=
 yes, choose
> >>>> @@ -731,15 +728,21 @@ static int read_balance(struct r1conf *conf, s=
truct r1bio *r1_bio, int *max_sect
> >>>>                               mirror->next_seq_sect > opt_iosize &&
> >>>>                               mirror->next_seq_sect - opt_iosize >=
=3D
> >>>>                               mirror->seq_start) {
> >>>> -                               choose_next_idle =3D 1;
> >>>> -                               continue;
> >>>> +                               /*
> >>>> +                                * Add 'pending' to avoid choosing t=
his disk if
> >>>> +                                * there is other idle disk.
> >>>> +                                * Set 'dist' to 0, so that if there=
 is no other
> >>>> +                                * idle disk and all disks are rotat=
ional, this
> >>>> +                                * disk will still be chosen.
> >>>> +                                */
> >>>> +                               pending++;
> >>>> +                               dist =3D 0;
> >>>
> >>> There is a problem. If all disks are not idle and there is a disk wit=
h
> >>> dist=3D0 before the seq disk, it can't read from the seq disk. It wil=
l
> >>> read from the first disk with dist=3D0. Maybe we can only add the cod=
es
> >>> which are removed from 2e52d449bcec?
> >>
> >> If there is a disk with disk=3D0, then best_dist_disk will be updated =
to
> >> the disk, and best_dist will be updated to 0 already:
> >>
> >> // in each iteration
> >> if (dist < best_dist) {
> >>          best_dist =3D dist;
> >>          btest_disk_disk =3D disk;
> >> }
> >>
> >> In this case, best_dist will be set to the first disk with dist=3D0, a=
nd
> >> at last, the disk will be chosen:
> >>
> >> if (best_disk =3D=3D -1) {
> >>           if (has_nonrot_disk || min_pending =3D=3D 0)
> >>                   best_disk =3D best_pending_disk;
> >>           else
> >>                   best_disk =3D best_dist_disk;
> >>                  -> the first disk with dist=3D0;
> >> }
> >>
> >> So, the problem that you concerned should not exist.
> >
> > Hi Kuai
> >
> > Thanks for the explanation. You're right. It chooses the first disk
> > which has dist=3D=3D0. In the above, you made the same typo error disk=
=3D0
> > as the comment. I guess you want to use dist=3D0, right? Beside this,
> > this patch is good to me.
>
> Yes, and Paul change the name 'best_dist' to 'closest_dist_disk',
> and 'btest_disk_disk' to 'closest_dist' in the last patch to avoid typo
> like this. :)

Ah, thanks :)  I haven't been there.

Regards
Xiao
>
> Thanks,
> Kuai
>
>
> >
> > Best Regards
> > Xiao
> >>
> >> Thanks,
> >> Kuai
> >>>
> >>> Best Regards
> >>> Xiao
> >>>
> >>>> +                       } else {
> >>>> +                               best_disk =3D disk;
> >>>> +                               break;
> >>>>                           }
> >>>> -                       break;
> >>>>                   }
> >>>>
> >>>> -               if (choose_next_idle)
> >>>> -                       continue;
> >>>> -
> >>>>                   if (min_pending > pending) {
> >>>>                           min_pending =3D pending;
> >>>>                           best_pending_disk =3D disk;
> >>>> --
> >>>> 2.39.2
> >>>>
> >>>>
> >>>
> >>> .
> >>>
> >>
> >
> > .
> >
>


