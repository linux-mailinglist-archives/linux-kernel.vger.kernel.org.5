Return-Path: <linux-kernel+bounces-82546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDBB868632
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F1221C27154
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A406FC6;
	Tue, 27 Feb 2024 01:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ebUesuIW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47402525E
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 01:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708998168; cv=none; b=MxYMu0s7TtfCBJ3npHYlN7i0nnt0oyo18gT1ZKDbvGdGp4Auzrl+LOEoAEhPCfeillonBYj/xfNAP37FmKqt0nVvSgQ1keR/VAd3gpRk+A+/cUpectoQSCjHpdjJ3GmzP7Im/A+SMZBsAp6cbIOj7znBwvtihc9yMFV27V5CPHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708998168; c=relaxed/simple;
	bh=8/lN/s6wZZCZwmm8YocYDJ6JlmhxJ/7EX/J+MLIBITg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=edHy2IEzN7jMwpd1TJQvhQZ4SPxu12+g69LAh49fEywWzt57nDodJYnF4y5MV4l9k80iCQh+sTgbxjiCAoBuG0AhkJ6Sd8aOHCIX6N9RYiD1C3a/8Da0BVt9tEtun9r7a3n/9QqLOtDzNcr+YCW8yaNX0ACBMyhOTqZRLW8+Wzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ebUesuIW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708998165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GSzkNQ2ybBAJU6H8pAUDZHXTzCD4MIxGThMlIRlQGM0=;
	b=ebUesuIWvDvFQT+FqXRj28jvMC3dmUYLIHlvwj/lPlCbhhjbD42/Zx2O5XApbP0g6fYBqc
	aA6A2DQtIdiVfHeMsbkPK/nvmI13YTmogmvUyx8F3iuVyCOKU7zPCmKoDD0Zv4wZaKJvds
	TaQiYcq2N+6pdB1jF1EpMHPD3rrQf2o=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-JHF_BVUSOp60VhpOLlxoDw-1; Mon, 26 Feb 2024 20:42:43 -0500
X-MC-Unique: JHF_BVUSOp60VhpOLlxoDw-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5d8bdadc79cso3655272a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 17:42:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708998162; x=1709602962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GSzkNQ2ybBAJU6H8pAUDZHXTzCD4MIxGThMlIRlQGM0=;
        b=emIhyzuokQxA2Gwu+gkmXSNXPsM74fRlmstgnayTT4dI7R8T6ifrsA6n5D0p3L5Orc
         /CJY9FP2NLpTxeUo/JfB2RdXSrdSPlP7sMEuhdyxb38AtVLj5I5Dvv6N+xLQ2JKf8dSm
         MoNBJAKJc5XbWcnWOjUmzkCtHtTE927NEr8UpCPA95n0QZmaGFTPFTBa/UPb9+VSkapf
         sVRJiUWLukDUI9AcmyrxHensb82v7fv0lhAqQJwkwCXzTIdhpOvBnIs+LvjRWriwMCJz
         SG9XLJaF5nb2Lu/z2RHuqXzSJ0YfKXurf69seLf5jZ5VFa3b3VrYL5SgUVccTeFMbqIG
         EOZg==
X-Forwarded-Encrypted: i=1; AJvYcCWPPiR4pp5y1Es16riuD/QlBgVxZYTD/qc6QErrKIM9SGSGbhHIIF0qH1aJBx8yNs6pu2MdeHjS5cEHfrjZL6qjXYZvEc1p4MMEijKH
X-Gm-Message-State: AOJu0YxPtz/COB3GGQ5Kc9mgCkLNLJqdkv+/QIA++GXIbV+xRQDL5sfL
	+9169I33UtyFv77BoPquTgg83Ml836ZBFKema5pv7pEMtpI9RTuo832EV72lJZfQ+xRbuSNicDh
	X70b46XYPoOjoQX6LYbWiUbn88Gqw6254IQs8a5hIrSdzCtuusgWL1wkaV5yUA4r7riuIpYBSK2
	cN09lz72hwk+8jw+Z8PVX8vKhsnL/kpyDHaYsd
X-Received: by 2002:a17:902:6505:b0:1dc:a837:7e19 with SMTP id b5-20020a170902650500b001dca8377e19mr3012078plk.16.1708998162335;
        Mon, 26 Feb 2024 17:42:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHNkrm797RMGihxLLDh7fquZ8LUsJPZszisKdsZUHK+vtFZEGeyhllggrlxJCSNafyNLGciYVPiVeHfqaS/ERQ=
X-Received: by 2002:a17:902:6505:b0:1dc:a837:7e19 with SMTP id
 b5-20020a170902650500b001dca8377e19mr3012070plk.16.1708998162001; Mon, 26 Feb
 2024 17:42:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222075806.1816400-1-yukuai1@huaweicloud.com>
 <20240222075806.1816400-7-yukuai1@huaweicloud.com> <CALTww2-ypx2YJOeXTzj7Y0EtXMkfrTOAJzzmDnnUK=1irspWtQ@mail.gmail.com>
 <4f2ae964-5030-907e-bc06-4d9e1fc8f3e8@huaweicloud.com> <CALTww2_q3XG5HFCYm3Wp7=fjM04cdWZy34R6MsDVLz-82iO88Q@mail.gmail.com>
In-Reply-To: <CALTww2_q3XG5HFCYm3Wp7=fjM04cdWZy34R6MsDVLz-82iO88Q@mail.gmail.com>
From: Xiao Ni <xni@redhat.com>
Date: Tue, 27 Feb 2024 09:42:30 +0800
Message-ID: <CALTww296uye5UY8g-rhqdwO=Wcz0=CH0ySNzk2=eNePY8DJU1w@mail.gmail.com>
Subject: Re: [PATCH md-6.9 06/10] md/raid1: factor out read_first_rdev() from read_balance()
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: paul.e.luse@linux.intel.com, song@kernel.org, neilb@suse.com, shli@fb.com, 
	linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org, yi.zhang@huawei.com, 
	yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 9:23=E2=80=AFAM Xiao Ni <xni@redhat.com> wrote:
>
> On Tue, Feb 27, 2024 at 9:06=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com>=
 wrote:
> >
> > Hi,
> >
> > =E5=9C=A8 2024/02/26 22:16, Xiao Ni =E5=86=99=E9=81=93:
> > > On Thu, Feb 22, 2024 at 4:04=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.=
com> wrote:
> > >>
> > >> From: Yu Kuai <yukuai3@huawei.com>
> > >>
> > >> read_balance() is hard to understand because there are too many stat=
us
> > >> and branches, and it's overlong.
> > >>
> > >> This patch factor out the case to read the first rdev from
> > >> read_balance(), there are no functional changes.
> > >>
> > >> Co-developed-by: Paul Luse <paul.e.luse@linux.intel.com>
> > >> Signed-off-by: Paul Luse <paul.e.luse@linux.intel.com>
> > >> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> > >> ---
> > >>   drivers/md/raid1.c | 63 +++++++++++++++++++++++++++++++++---------=
----
> > >>   1 file changed, 46 insertions(+), 17 deletions(-)
> > >>
> > >> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> > >> index 8089c569e84f..08c45ca55a7e 100644
> > >> --- a/drivers/md/raid1.c
> > >> +++ b/drivers/md/raid1.c
> > >> @@ -579,6 +579,47 @@ static sector_t align_to_barrier_unit_end(secto=
r_t start_sector,
> > >>          return len;
> > >>   }
> > >>
> > >> +static void update_read_sectors(struct r1conf *conf, int disk,
> > >> +                               sector_t this_sector, int len)
> > >> +{
> > >> +       struct raid1_info *info =3D &conf->mirrors[disk];
> > >> +
> > >> +       atomic_inc(&info->rdev->nr_pending);
> > >> +       if (info->next_seq_sect !=3D this_sector)
> > >> +               info->seq_start =3D this_sector;
> > >> +       info->next_seq_sect =3D this_sector + len;
> > >> +}
> > >> +
> > >> +static int choose_first_rdev(struct r1conf *conf, struct r1bio *r1_=
bio,
> > >> +                            int *max_sectors)
> > >> +{
> > >> +       sector_t this_sector =3D r1_bio->sector;
> > >> +       int len =3D r1_bio->sectors;
> > >> +       int disk;
> > >> +
> > >> +       for (disk =3D 0 ; disk < conf->raid_disks * 2 ; disk++) {
> > >> +               struct md_rdev *rdev;
> > >> +               int read_len;
> > >> +
> > >> +               if (r1_bio->bios[disk] =3D=3D IO_BLOCKED)
> > >> +                       continue;
> > >> +
> > >> +               rdev =3D conf->mirrors[disk].rdev;
> > >> +               if (!rdev || test_bit(Faulty, &rdev->flags))
> > >> +                       continue;
> > >> +
> > >> +               /* choose the first disk even if it has some bad blo=
cks. */
> > >> +               read_len =3D raid1_check_read_range(rdev, this_secto=
r, &len);
> > >> +               if (read_len > 0) {
> > >> +                       update_read_sectors(conf, disk, this_sector,=
 read_len);
> > >> +                       *max_sectors =3D read_len;
> > >> +                       return disk;
> > >> +               }
> > >
> > > Hi Kuai
> > >
> > > It needs to update max_sectors even if the bad block starts before
> > > this_sector. Because it can't read more than bad_blocks from other
> > > member disks. If it reads more data than bad blocks, it will cause
> > > data corruption. One rule here is read from the primary disk (the
> > > first readable disk) if it has no bad block and read the
> > > badblock-data-length data from other disks.
> >
> > Noted that raid1_check_read_range() will return readable length from
> > this rdev, hence if bad block starts before this_sector, 0 is returned,
> > and 'len' is updated to the length of badblocks(if not exceed read
> > range), and following iteration will find the first disk to read update=
d
> > 'len' data and update max_sectors.
>
> Hi Kuai
>
> The problem is that choose_first_rdev doesn't return 'len' from
> max_sectors when bad blocks start before this_sector. In the following
> iteration, it can't read more than 'len' from other disks to avoid
> data corruption. I haven't read all the patches. To this patch, it
> resets best_good_sectors to sectors when it encounters a good member
> disk without bad blocks.

Sorry, I missed one thing. Beside the point I mentioned above, it
needs to update 'sectors' which is the the read region to 'len'
finally. It looks like the raid1_check_read_range needs to modify to
achieve this.

Regards
Xiao
>
> Regards
> Xiao
> >
> > Thanks,
> > Kuai
> >
> > >
> > > Best Regards
> > > Xiao
> > >
> > >> +       }
> > >> +
> > >> +       return -1;
> > >> +}
> > >> +
> > >>   /*
> > >>    * This routine returns the disk from which the requested read sho=
uld
> > >>    * be done. There is a per-array 'next expected sequential IO' sec=
tor
> > >> @@ -603,7 +644,6 @@ static int read_balance(struct r1conf *conf, str=
uct r1bio *r1_bio, int *max_sect
> > >>          sector_t best_dist;
> > >>          unsigned int min_pending;
> > >>          struct md_rdev *rdev;
> > >> -       int choose_first;
> > >>
> > >>    retry:
> > >>          sectors =3D r1_bio->sectors;
> > >> @@ -613,10 +653,11 @@ static int read_balance(struct r1conf *conf, s=
truct r1bio *r1_bio, int *max_sect
> > >>          best_pending_disk =3D -1;
> > >>          min_pending =3D UINT_MAX;
> > >>          best_good_sectors =3D 0;
> > >> -       choose_first =3D raid1_should_read_first(conf->mddev, this_s=
ector,
> > >> -                                              sectors);
> > >>          clear_bit(R1BIO_FailFast, &r1_bio->state);
> > >>
> > >> +       if (raid1_should_read_first(conf->mddev, this_sector, sector=
s))
> > >> +               return choose_first_rdev(conf, r1_bio, max_sectors);
> > >> +
> > >>          for (disk =3D 0 ; disk < conf->raid_disks * 2 ; disk++) {
> > >>                  sector_t dist;
> > >>                  sector_t first_bad;
> > >> @@ -662,8 +703,6 @@ static int read_balance(struct r1conf *conf, str=
uct r1bio *r1_bio, int *max_sect
> > >>                                   * bad_sectors from another device.=
.
> > >>                                   */
> > >>                                  bad_sectors -=3D (this_sector - fir=
st_bad);
> > >> -                               if (choose_first && sectors > bad_se=
ctors)
> > >> -                                       sectors =3D bad_sectors;
> > >>                                  if (best_good_sectors > sectors)
> > >>                                          best_good_sectors =3D secto=
rs;
> > >>
> > >> @@ -673,8 +712,6 @@ static int read_balance(struct r1conf *conf, str=
uct r1bio *r1_bio, int *max_sect
> > >>                                          best_good_sectors =3D good_=
sectors;
> > >>                                          best_disk =3D disk;
> > >>                                  }
> > >> -                               if (choose_first)
> > >> -                                       break;
> > >>                          }
> > >>                          continue;
> > >>                  } else {
> > >> @@ -689,10 +726,6 @@ static int read_balance(struct r1conf *conf, st=
ruct r1bio *r1_bio, int *max_sect
> > >>
> > >>                  pending =3D atomic_read(&rdev->nr_pending);
> > >>                  dist =3D abs(this_sector - conf->mirrors[disk].head=
_position);
> > >> -               if (choose_first) {
> > >> -                       best_disk =3D disk;
> > >> -                       break;
> > >> -               }
> > >>                  /* Don't change to another disk for sequential read=
s */
> > >>                  if (conf->mirrors[disk].next_seq_sect =3D=3D this_s=
ector
> > >>                      || dist =3D=3D 0) {
> > >> @@ -760,13 +793,9 @@ static int read_balance(struct r1conf *conf, st=
ruct r1bio *r1_bio, int *max_sect
> > >>                  rdev =3D conf->mirrors[best_disk].rdev;
> > >>                  if (!rdev)
> > >>                          goto retry;
> > >> -               atomic_inc(&rdev->nr_pending);
> > >> -               sectors =3D best_good_sectors;
> > >> -
> > >> -               if (conf->mirrors[best_disk].next_seq_sect !=3D this=
_sector)
> > >> -                       conf->mirrors[best_disk].seq_start =3D this_=
sector;
> > >>
> > >> -               conf->mirrors[best_disk].next_seq_sect =3D this_sect=
or + sectors;
> > >> +               sectors =3D best_good_sectors;
> > >> +               update_read_sectors(conf, disk, this_sector, sectors=
);
> > >>          }
> > >>          *max_sectors =3D sectors;
> > >>
> > >> --
> > >> 2.39.2
> > >>
> > >>
> > >
> > > .
> > >
> >


