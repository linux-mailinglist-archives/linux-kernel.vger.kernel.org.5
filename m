Return-Path: <linux-kernel+bounces-81730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB609867976
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDF0D1C2AE7F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D542131E29;
	Mon, 26 Feb 2024 14:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RHh+Jln/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28B612BF29
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 14:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708958692; cv=none; b=dWJl9wvNa5bN637v06FXtdY1wmHpv79B4aZNyMLlGhq8e7eOK/nXvJttE38Mv4jjKnGqUlJWDu+S3UHxmhzUigMU/hzfQEpdt9EFoNuBUIriU/tYmD/QY5iUXRix8vtHkbwALHPdoHp+RN0xdC3ondiKvGJlAEKE4S5QuaPNtMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708958692; c=relaxed/simple;
	bh=oRQ9v7kB5bqRxTK8PhLxJf5eEHNOuOC6up/KxjKjbJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X6fNp3yViK8iN7rF/wdWqQcDkHCwipcqq6BW4yCMznEx4VKlpT4H8upzdfKiFeu+CJbxZp+Qe3seW5wmI4qoFPKz8Xcm8zlrvvAIaavD6Pb7PKb9kt3FA+zen17udJ68gdLTZyBAaf2smjChOqDSoBelwVNU5JIJa+EXJ3/z3nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RHh+Jln/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708958689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WVAz6OqM9YBIHNwy968Ocu5br0K4GggiejttotLLqFo=;
	b=RHh+Jln/hKWOlEqC8rYEhnGHMlVlzkJ/MrWipY10zjZ0s2M0p2dgAyB7GXe9dWKGYZ00/p
	pyjp1CdklRURxc3n14pUYhubScFaR7tqWqQZhWt+UKpm2f3r0iHE64ia7YgMuwujL+l7nC
	CIJgpApTddd4dsEc4/tUY7j62DlAEE8=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-21C21rZKMhKTakSEKwNy6Q-1; Mon, 26 Feb 2024 09:44:48 -0500
X-MC-Unique: 21C21rZKMhKTakSEKwNy6Q-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5c6245bc7caso2582708a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 06:44:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708958687; x=1709563487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WVAz6OqM9YBIHNwy968Ocu5br0K4GggiejttotLLqFo=;
        b=uIigPFMEle7C9nckYzqQkm5xshfX6ukX01yS+MLZWwP3rNCqSHqA13LUf1mrSzanKb
         4zojojbArku9mV+tgsBgLJjMOzzKdxwMhq19LlsGj8pHthXZa3JwO6bsxSMKQVuI3SYS
         dEeJ00zUCQNHKl/gY+tBlqCnALMitKFfluSR64up/ey/PE7i5xmZF2kAC6g7N2LnyXC4
         pG6lF6lRXq9GUDNx9kxC+f7WJRSTYpLqdDTxQG+jT9JJz/YO4HrLiRYbrl9PHwSLlbtP
         FAlZOKliI4c0icr5Dc/4e5Gmnm+IQOHDjNLARxWLNWfi1scFRvsk3WF+bIe/Q8cOI3+h
         NjSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGr/wdS6ZrsRLB8fehd+EZkTvczTRCUxswcqnQLlwPincuHxIvZeOX6hFcq6QbS4lMfrH4eea2PPvuqhbD1uIqJlEAmFzyRmg6ImwU
X-Gm-Message-State: AOJu0YzQkR1Hb6JCsbnfKDK8YTue12wPxCII1kcoIJ7cqDghjJgQjadU
	Q1sXf7AreK/SDHwFBMJwNDrWyLPsJt8O4+YY6F0rVoG+UsCGa+P06X2FPJSKQUK3e8qvZAPIp1W
	FYfAakkR5Urp8Qmn6nxKl7wIlYL+MFZNsRFI34wSCBL+DNtYZ0N+s6vp9T57T1dZl8+f7pKLymU
	sxAtb1ODQ21tvmctRLUmKsBPvinYM3/nESXNCF
X-Received: by 2002:a17:902:e841:b0:1dc:1c81:1b19 with SMTP id t1-20020a170902e84100b001dc1c811b19mr9002132plg.3.1708958687290;
        Mon, 26 Feb 2024 06:44:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG7cionqfGU4TMZnBAEDSHJq9kGuFCGsOtY/uktnXaRrzbGASDaU/mnx+5J/yKR+IzenDmrRXpXREZPNo0jbEo=
X-Received: by 2002:a17:902:e841:b0:1dc:1c81:1b19 with SMTP id
 t1-20020a170902e84100b001dc1c811b19mr9002102plg.3.1708958686977; Mon, 26 Feb
 2024 06:44:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222075806.1816400-1-yukuai1@huaweicloud.com> <20240222075806.1816400-8-yukuai1@huaweicloud.com>
In-Reply-To: <20240222075806.1816400-8-yukuai1@huaweicloud.com>
From: Xiao Ni <xni@redhat.com>
Date: Mon, 26 Feb 2024 22:44:35 +0800
Message-ID: <CALTww2-jdEos2HHgBHYHc0VOh1tWYuWTztmvW4iaBi6bS8B-YQ@mail.gmail.com>
Subject: Re: [PATCH md-6.9 07/10] md/raid1: factor out choose_slow_rdev() from read_balance()
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: paul.e.luse@linux.intel.com, song@kernel.org, neilb@suse.com, shli@fb.com, 
	linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org, yukuai3@huawei.com, 
	yi.zhang@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 4:04=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> read_balance() is hard to understand because there are too many status
> and branches, and it's overlong.
>
> This patch factor out the case to read the slow rdev from
> read_balance(), there are no functional changes.
>
> Co-developed-by: Paul Luse <paul.e.luse@linux.intel.com>
> Signed-off-by: Paul Luse <paul.e.luse@linux.intel.com>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/md/raid1.c | 69 ++++++++++++++++++++++++++++++++++------------
>  1 file changed, 52 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> index 08c45ca55a7e..bc2f8fcbe5b3 100644
> --- a/drivers/md/raid1.c
> +++ b/drivers/md/raid1.c
> @@ -620,6 +620,53 @@ static int choose_first_rdev(struct r1conf *conf, st=
ruct r1bio *r1_bio,
>         return -1;
>  }
>
> +static int choose_slow_rdev(struct r1conf *conf, struct r1bio *r1_bio,
> +                           int *max_sectors)
> +{
> +       sector_t this_sector =3D r1_bio->sector;
> +       int bb_disk =3D -1;
> +       int bb_read_len =3D 0;
> +       int disk;
> +
> +       for (disk =3D 0 ; disk < conf->raid_disks * 2 ; disk++) {
> +               struct md_rdev *rdev;
> +               int len;
> +               int read_len;
> +
> +               if (r1_bio->bios[disk] =3D=3D IO_BLOCKED)
> +                       continue;
> +
> +               rdev =3D conf->mirrors[disk].rdev;
> +               if (!rdev || test_bit(Faulty, &rdev->flags) ||
> +                   !test_bit(WriteMostly, &rdev->flags))
> +                       continue;
> +
> +               /* there are no bad blocks, we can use this disk */
> +               len =3D r1_bio->sectors;
> +               read_len =3D raid1_check_read_range(rdev, this_sector, &l=
en);
> +               if (read_len =3D=3D r1_bio->sectors) {
> +                       update_read_sectors(conf, disk, this_sector, read=
_len);
> +                       return disk;
> +               }
> +
> +               /*
> +                * there are partial bad blocks, choose the rdev with lar=
gest
> +                * read length.
> +                */
> +               if (read_len > bb_read_len) {
> +                       bb_disk =3D disk;
> +                       bb_read_len =3D read_len;
> +               }
> +       }
> +
> +       if (bb_disk !=3D -1) {
> +               *max_sectors =3D bb_read_len;
> +               update_read_sectors(conf, bb_disk, this_sector, bb_read_l=
en);
> +       }
> +
> +       return bb_disk;
> +}
> +
>  /*
>   * This routine returns the disk from which the requested read should
>   * be done. There is a per-array 'next expected sequential IO' sector
> @@ -672,23 +719,8 @@ static int read_balance(struct r1conf *conf, struct =
r1bio *r1_bio, int *max_sect
>                 if (!test_bit(In_sync, &rdev->flags) &&
>                     rdev->recovery_offset < this_sector + sectors)
>                         continue;
> -               if (test_bit(WriteMostly, &rdev->flags)) {
> -                       /* Don't balance among write-mostly, just
> -                        * use the first as a last resort */
> -                       if (best_dist_disk < 0) {
> -                               if (is_badblock(rdev, this_sector, sector=
s,
> -                                               &first_bad, &bad_sectors)=
) {
> -                                       if (first_bad <=3D this_sector)
> -                                               /* Cannot use this */
> -                                               continue;
> -                                       best_good_sectors =3D first_bad -=
 this_sector;
> -                               } else
> -                                       best_good_sectors =3D sectors;
> -                               best_dist_disk =3D disk;
> -                               best_pending_disk =3D disk;
> -                       }
> +               if (test_bit(WriteMostly, &rdev->flags))
>                         continue;
> -               }
>                 /* This is a reasonable device to use.  It might
>                  * even be best.
>                  */
> @@ -799,7 +831,10 @@ static int read_balance(struct r1conf *conf, struct =
r1bio *r1_bio, int *max_sect
>         }
>         *max_sectors =3D sectors;
>
> -       return best_disk;
> +       if (best_disk >=3D 0)
> +               return best_disk;
> +
> +       return choose_slow_rdev(conf, r1_bio, max_sectors);
>  }
>
>  static void wake_up_barrier(struct r1conf *conf)
> --
> 2.39.2
>
>

This patch looks good to me.
Reviewed-by: Xiao Ni <xni@redhat.com>


