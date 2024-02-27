Return-Path: <linux-kernel+bounces-82627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3454C868767
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 03:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA6AE1F2629C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20B61B28D;
	Tue, 27 Feb 2024 02:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gRuZFV3r"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04C717BB5
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 02:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709002220; cv=none; b=QkHCaYOA+RzwOV12IEjU3S+8uChuBwq/wSmnK3VYHk/LUq1jUU4Dd/DnqdJgvPx0EfEWhU+X+FkUg+KZgce25lbkxt4AKLcg68Gn3eQU5nDTxPE4V0a/Hs14nqa6gqcF+dvDSY17rsyP3NtH5BXaG3VDv4XRwUFiv1O6HsBCqVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709002220; c=relaxed/simple;
	bh=aZmZSv+iJIwcL0eOpELIyyIHLn/fedUN0ECNCQ3oEIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UdjODo9sCeyeL36S8Wr1Zf1pZoqdLhieWJlL56q2weu3EZQYGSS2MptH2zqtn/6Ckj1Ceh+LWa4iznXPNj2Mhb148MqzBmpiKt8Do9e4r0TgyZBSG9+kRySWf+2j5m1/Uv9TWq+BDo/vfKqpR6C9viSQFwU7ifSEXsUlL+p3PPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gRuZFV3r; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709002216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hJXVeY7zu8z4VEii50bAizXOv+RDi5UFWkizod0prPM=;
	b=gRuZFV3rkPKBQHJUceO6ptQ9jhceW+oLmS9GZ4i4gYjoJ8C9DTaW7QO/BH9XhmI46A8VCh
	CaQwWPnvqeVTn4gbjuAgZQKZUbySelEQM+japxQIqtQnGcbijS4wWTcF4QgoOea/fZYqsK
	Y5e3Sqdoq3vDjDwdDx17qx5StHSEvn8=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-M6kFKELZP7ayu-BlstFvdg-1; Mon, 26 Feb 2024 21:50:14 -0500
X-MC-Unique: M6kFKELZP7ayu-BlstFvdg-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-29a5bae5b3fso3318093a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 18:50:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709002213; x=1709607013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hJXVeY7zu8z4VEii50bAizXOv+RDi5UFWkizod0prPM=;
        b=FWC3bTeqbXM6ZWmaoDrnC2MDZz8N4FgQ+0PL9yOG1k/13t7qcRA4q+rZoqoYTadEXW
         JVs6FPLc5o/bsOGTZNeZp64rt/zAl7MhCgwIhx643ub9hCoaOuWz8HtR9PJ48yU64+wN
         EKpqGiFG42g6K06xC1sK5joHaJA4ciJIqTrSHH/eLhRjQht8e5NDhsV18tLnQQTUhL4+
         t9sU0w5J78wGrGmc3Tpyu0B64jewaUIM77bK9f3gYFwTdeX77znC8IF2a7H6tvjv8AnL
         atMtXCg8aCle6h2WOhOFXQ0QQwbEF0KIZ8uDtvx60uPDno2MOAlCaDLElu8PQRhTXZks
         xgsw==
X-Forwarded-Encrypted: i=1; AJvYcCUdW1SZIv+7Ec53QkyRE4D5lI1fSYwtkvzQxsdqdXi16TsMinHY0uCehZcQiNPBWk7NAIuKIHp2OvlAd3qrmagEJKrXLDhh7TpE54va
X-Gm-Message-State: AOJu0Yzri+K/O7+9IG7BtAHhwG/FybIbyoJXX5imDhdEAPBXXIwmomJU
	rbxC5xPAT2q0JVlRhftkgV3fy/cQd0dHrGxLlpy8/JqjLDujbITuSBaUQt54l3qHOit+SfA8/Pc
	WscNzrt7cjSirzjVQh75jx352NMEtIrqd+PS1OdECQRlghIuFcGQMdbiIy0IVXvZtDeirp+lMmo
	yfvPW0gozVWaOWfZvL8amx6feNgrcyV4M73Fa2
X-Received: by 2002:a17:90a:17ca:b0:29a:6695:7c74 with SMTP id q68-20020a17090a17ca00b0029a66957c74mr6656030pja.45.1709002213373;
        Mon, 26 Feb 2024 18:50:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG/D/M4Jg1ROPze5BFJTqqz45y18Unvx1CcxmoObmAqtS8yDp+vpBSa6yTWnRNdeOlix9VB5T7rdH+Pg64oVAg=
X-Received: by 2002:a17:90a:17ca:b0:29a:6695:7c74 with SMTP id
 q68-20020a17090a17ca00b0029a66957c74mr6656018pja.45.1709002213073; Mon, 26
 Feb 2024 18:50:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222075806.1816400-1-yukuai1@huaweicloud.com>
 <20240222075806.1816400-7-yukuai1@huaweicloud.com> <CALTww2-ypx2YJOeXTzj7Y0EtXMkfrTOAJzzmDnnUK=1irspWtQ@mail.gmail.com>
 <4f2ae964-5030-907e-bc06-4d9e1fc8f3e8@huaweicloud.com> <CALTww2_q3XG5HFCYm3Wp7=fjM04cdWZy34R6MsDVLz-82iO88Q@mail.gmail.com>
 <20374432-d8d6-ceae-2f31-d154520288ee@huaweicloud.com>
In-Reply-To: <20374432-d8d6-ceae-2f31-d154520288ee@huaweicloud.com>
From: Xiao Ni <xni@redhat.com>
Date: Tue, 27 Feb 2024 10:50:01 +0800
Message-ID: <CALTww289FNGEVcF=oW+oWBXX5DKsH34opLegqa13TLRoA8SLRw@mail.gmail.com>
Subject: Re: [PATCH md-6.9 06/10] md/raid1: factor out read_first_rdev() from read_balance()
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: paul.e.luse@linux.intel.com, song@kernel.org, neilb@suse.com, shli@fb.com, 
	linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org, yi.zhang@huawei.com, 
	yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 9:44=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> Hi,
>
> =E5=9C=A8 2024/02/27 9:23, Xiao Ni =E5=86=99=E9=81=93:
> > On Tue, Feb 27, 2024 at 9:06=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.co=
m> wrote:
> >>
> >> Hi,
> >>
> >> =E5=9C=A8 2024/02/26 22:16, Xiao Ni =E5=86=99=E9=81=93:
> >>> On Thu, Feb 22, 2024 at 4:04=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.=
com> wrote:
> >>>>
> >>>> From: Yu Kuai <yukuai3@huawei.com>
> >>>>
> >>>> read_balance() is hard to understand because there are too many stat=
us
> >>>> and branches, and it's overlong.
> >>>>
> >>>> This patch factor out the case to read the first rdev from
> >>>> read_balance(), there are no functional changes.
> >>>>
> >>>> Co-developed-by: Paul Luse <paul.e.luse@linux.intel.com>
> >>>> Signed-off-by: Paul Luse <paul.e.luse@linux.intel.com>
> >>>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> >>>> ---
> >>>>    drivers/md/raid1.c | 63 +++++++++++++++++++++++++++++++++--------=
-----
> >>>>    1 file changed, 46 insertions(+), 17 deletions(-)
> >>>>
> >>>> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> >>>> index 8089c569e84f..08c45ca55a7e 100644
> >>>> --- a/drivers/md/raid1.c
> >>>> +++ b/drivers/md/raid1.c
> >>>> @@ -579,6 +579,47 @@ static sector_t align_to_barrier_unit_end(secto=
r_t start_sector,
> >>>>           return len;
> >>>>    }
> >>>>
> >>>> +static void update_read_sectors(struct r1conf *conf, int disk,
> >>>> +                               sector_t this_sector, int len)
> >>>> +{
> >>>> +       struct raid1_info *info =3D &conf->mirrors[disk];
> >>>> +
> >>>> +       atomic_inc(&info->rdev->nr_pending);
> >>>> +       if (info->next_seq_sect !=3D this_sector)
> >>>> +               info->seq_start =3D this_sector;
> >>>> +       info->next_seq_sect =3D this_sector + len;
> >>>> +}
> >>>> +
> >>>> +static int choose_first_rdev(struct r1conf *conf, struct r1bio *r1_=
bio,
> >>>> +                            int *max_sectors)
> >>>> +{
> >>>> +       sector_t this_sector =3D r1_bio->sector;
> >>>> +       int len =3D r1_bio->sectors;
> >>>> +       int disk;
> >>>> +
> >>>> +       for (disk =3D 0 ; disk < conf->raid_disks * 2 ; disk++) {
> >>>> +               struct md_rdev *rdev;
> >>>> +               int read_len;
> >>>> +
> >>>> +               if (r1_bio->bios[disk] =3D=3D IO_BLOCKED)
> >>>> +                       continue;
> >>>> +
> >>>> +               rdev =3D conf->mirrors[disk].rdev;
> >>>> +               if (!rdev || test_bit(Faulty, &rdev->flags))
> >>>> +                       continue;
> >>>> +
> >>>> +               /* choose the first disk even if it has some bad blo=
cks. */
> >>>> +               read_len =3D raid1_check_read_range(rdev, this_secto=
r, &len);
> >>>> +               if (read_len > 0) {
> >>>> +                       update_read_sectors(conf, disk, this_sector,=
 read_len);
> >>>> +                       *max_sectors =3D read_len;
> >>>> +                       return disk;
> >>>> +               }
> >>>
> >>> Hi Kuai
> >>>
> >>> It needs to update max_sectors even if the bad block starts before
> >>> this_sector. Because it can't read more than bad_blocks from other
> >>> member disks. If it reads more data than bad blocks, it will cause
> >>> data corruption. One rule here is read from the primary disk (the
> >>> first readable disk) if it has no bad block and read the
> >>> badblock-data-length data from other disks.
> >>
> >> Noted that raid1_check_read_range() will return readable length from
> >> this rdev, hence if bad block starts before this_sector, 0 is returned=
,
> >> and 'len' is updated to the length of badblocks(if not exceed read
> >> range), and following iteration will find the first disk to read updat=
ed
> >> 'len' data and update max_sectors.
> >
> > Hi Kuai
> >
> > The problem is that choose_first_rdev doesn't return 'len' from
> > max_sectors when bad blocks start before this_sector. In the following
> > iteration, it can't read more than 'len' from other disks to avoid
> > data corruption. I haven't read all the patches. To this patch, it
> > resets best_good_sectors to sectors when it encounters a good member
> > disk without bad blocks.
>
> In this case, 'len' is not supposed to be returned, caller will split
> orignal IO based on 'max_sectors', for example:
>
> IO:             2, 4    |  ----
> rdev1: BB:      0, 4    |xxxx
> rdev2: no BB
>
> Then choose_first_rdev() will set max_sectors to 2, and return rdev2,
> then caller will split and issue new IO:
>
> orignal IO:     4, 2    |    --
> splited IO:     2, 2    |  --
>
> Finally, issue splited IO to rdev2. Later orignal IO will be handled by
> read_balance() again, and rdev1 will be returned.
>
> Is this case what you concerned?

Ah I was still in the original logic and forgot choose_first_rdev is
iterates all disks.

The case I want to talk is:

bad block range:   1------8
first readable disk:    4-----------16

The io starts at 4, but the bad block starts at 1 and length is 8.
raid1_check_read_range returns 0 and len is updated to 5. In the loop,
it can split the io as expected. Thanks for the explanation.

Best Regards
Xiao
>
> Thanks,
> Kuai
>
> >
> > Regards
> > Xiao
> >>
> >> Thanks,
> >> Kuai
> >>
> >>>
> >>> Best Regards
> >>> Xiao
> >>>
> >>>> +       }
> >>>> +
> >>>> +       return -1;
> >>>> +}
> >>>> +
> >>>>    /*
> >>>>     * This routine returns the disk from which the requested read sh=
ould
> >>>>     * be done. There is a per-array 'next expected sequential IO' se=
ctor
> >>>> @@ -603,7 +644,6 @@ static int read_balance(struct r1conf *conf, str=
uct r1bio *r1_bio, int *max_sect
> >>>>           sector_t best_dist;
> >>>>           unsigned int min_pending;
> >>>>           struct md_rdev *rdev;
> >>>> -       int choose_first;
> >>>>
> >>>>     retry:
> >>>>           sectors =3D r1_bio->sectors;
> >>>> @@ -613,10 +653,11 @@ static int read_balance(struct r1conf *conf, s=
truct r1bio *r1_bio, int *max_sect
> >>>>           best_pending_disk =3D -1;
> >>>>           min_pending =3D UINT_MAX;
> >>>>           best_good_sectors =3D 0;
> >>>> -       choose_first =3D raid1_should_read_first(conf->mddev, this_s=
ector,
> >>>> -                                              sectors);
> >>>>           clear_bit(R1BIO_FailFast, &r1_bio->state);
> >>>>
> >>>> +       if (raid1_should_read_first(conf->mddev, this_sector, sector=
s))
> >>>> +               return choose_first_rdev(conf, r1_bio, max_sectors);
> >>>> +
> >>>>           for (disk =3D 0 ; disk < conf->raid_disks * 2 ; disk++) {
> >>>>                   sector_t dist;
> >>>>                   sector_t first_bad;
> >>>> @@ -662,8 +703,6 @@ static int read_balance(struct r1conf *conf, str=
uct r1bio *r1_bio, int *max_sect
> >>>>                                    * bad_sectors from another device=
.
> >>>>                                    */
> >>>>                                   bad_sectors -=3D (this_sector - fi=
rst_bad);
> >>>> -                               if (choose_first && sectors > bad_se=
ctors)
> >>>> -                                       sectors =3D bad_sectors;
> >>>>                                   if (best_good_sectors > sectors)
> >>>>                                           best_good_sectors =3D sect=
ors;
> >>>>
> >>>> @@ -673,8 +712,6 @@ static int read_balance(struct r1conf *conf, str=
uct r1bio *r1_bio, int *max_sect
> >>>>                                           best_good_sectors =3D good=
_sectors;
> >>>>                                           best_disk =3D disk;
> >>>>                                   }
> >>>> -                               if (choose_first)
> >>>> -                                       break;
> >>>>                           }
> >>>>                           continue;
> >>>>                   } else {
> >>>> @@ -689,10 +726,6 @@ static int read_balance(struct r1conf *conf, st=
ruct r1bio *r1_bio, int *max_sect
> >>>>
> >>>>                   pending =3D atomic_read(&rdev->nr_pending);
> >>>>                   dist =3D abs(this_sector - conf->mirrors[disk].hea=
d_position);
> >>>> -               if (choose_first) {
> >>>> -                       best_disk =3D disk;
> >>>> -                       break;
> >>>> -               }
> >>>>                   /* Don't change to another disk for sequential rea=
ds */
> >>>>                   if (conf->mirrors[disk].next_seq_sect =3D=3D this_=
sector
> >>>>                       || dist =3D=3D 0) {
> >>>> @@ -760,13 +793,9 @@ static int read_balance(struct r1conf *conf, st=
ruct r1bio *r1_bio, int *max_sect
> >>>>                   rdev =3D conf->mirrors[best_disk].rdev;
> >>>>                   if (!rdev)
> >>>>                           goto retry;
> >>>> -               atomic_inc(&rdev->nr_pending);
> >>>> -               sectors =3D best_good_sectors;
> >>>> -
> >>>> -               if (conf->mirrors[best_disk].next_seq_sect !=3D this=
_sector)
> >>>> -                       conf->mirrors[best_disk].seq_start =3D this_=
sector;
> >>>>
> >>>> -               conf->mirrors[best_disk].next_seq_sect =3D this_sect=
or + sectors;
> >>>> +               sectors =3D best_good_sectors;
> >>>> +               update_read_sectors(conf, disk, this_sector, sectors=
);
> >>>>           }
> >>>>           *max_sectors =3D sectors;
> >>>>
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


