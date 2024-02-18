Return-Path: <linux-kernel+bounces-70202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 860928594AC
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 05:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA8CC1C2153A
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 04:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5005D4C8E;
	Sun, 18 Feb 2024 04:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vw20B/DS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856681C2D
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 04:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708232040; cv=none; b=cK9oMV/EsWDk1fIuH3+KjujYaLG+qFplNZPvGBMM5sUyuiD87d1L/CYqTCetYZb3dT4mK3WL9JCPXuk44p9bW2qaOD2vt25y/x4T/Xjv9nziiIyHrdWYFL7mcmj/pw0pB1P0XfwoJ23eSacllTCUTJWBftKDmxzcEua0UEudv3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708232040; c=relaxed/simple;
	bh=9CFmHE9fEn3alSP2eOe4TiIzrGtGHtJmQYPrcZsBtRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oLePkRXdrNqiev+ailjmMz6wbjDRmOOZOvtsH9uJqMI7BLuR8ANVCCc7ZTOI/sW6Idj968Tg2TeCU7HCkioIKFiNz1zNBbB1T2v+YWThqXWmU8p2R2wquG2EwerGdQTcO7BIuyuj0CqdUEP2xiNHeV9pERSlvztRYBJA0t4diqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vw20B/DS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708232037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hQc28nJ2FYhpME/qsNV85wqGEzn6QofMCqB2KioOZU0=;
	b=Vw20B/DS2HP8pb+Pq56gg30x26HqOhyS+MC/NaL03Y+Ov7E2kftyRKs+B5GzUpqA5Ew9yQ
	pwlFwCMkEJp06meudlKrsGu2wfpZ9erWnROXzj4X1L50DC2qN404Z45K0tp0ogk0ZP28ex
	IXHO6cYUqIedxn39JsqMSD18Zgqc2ps=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-_J_Mj3urNsmuhm2VwY9b4w-1; Sat, 17 Feb 2024 23:53:55 -0500
X-MC-Unique: _J_Mj3urNsmuhm2VwY9b4w-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5cfd6ba1c11so2270491a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 20:53:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708232034; x=1708836834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hQc28nJ2FYhpME/qsNV85wqGEzn6QofMCqB2KioOZU0=;
        b=hqZ9UrJMZvL6TlezPyorpkNskq8o00WpYjEZ+YNTZh/wttXHxl1b3kVTKqo79TwpYk
         jodE35j2K1Vj3m8jHM9MVJgOx0kqMOM05iIGEA0ehZmEqbLXJQXlq6M3XyL6snEwXKp0
         o0ZoWulDBfxogW8IuZv4TRML0bkhzcqqL+mX2KGGi4iqt8hfeIFStTjtepGPN+2ANCDz
         6efrM0lAuhowUUTIoxwcYNolfLwrFYPkgJs1Q/qlVbKcq5VBf3cpgWFyd3n4dgpOgT7F
         mdE64lkIl3ZWHQBFIsWsiHCGoQ17VxQPy4VsAZVE/s4Lyp5QT9t22nNuCfCiqVEdlMRo
         u3sg==
X-Forwarded-Encrypted: i=1; AJvYcCXfPFML3b6vD1P1/U9iFTFSr72vaA9maYarfeSMy1AUsdz9P/AYPakwBqLJ52PlcULFxFspBXq3nig1Hu0k5Ccpk4CbXn35c1vZ00Rh
X-Gm-Message-State: AOJu0Yx5uqLfDSDPJ/Avt5ZxgzfF9bmWRCiEllKjp24CSpBZuGLy4JPQ
	tMGL8i2ELHr+B6eHEq9QkXYEOOj7+nz0mo8jCY2HAAiGN1FXkXOGBT9McRGkDNtnA/sgplZ2Q/s
	ppZYk5FLn8o7MauO0+/LRgyDwXfnBIZpWTeYPe/c6nqKbYUnv3WC4Vb+WbzxgVy0hmL+2yrpbaU
	jqd5kb8WmbJ4OY7iP5jM6K5kF8nb8TbVFJIMvP
X-Received: by 2002:a17:90a:17a4:b0:299:b60:ff0e with SMTP id q33-20020a17090a17a400b002990b60ff0emr7139718pja.13.1708232034588;
        Sat, 17 Feb 2024 20:53:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF+GMGP/Yv+45yAPHhrYahGDHYA36bY/lO40bcq3LnW72ZFq6nP0EQA/C9fAmgwD2jTibzzpfU7TD6WPwumFtY=
X-Received: by 2002:a17:90a:17a4:b0:299:b60:ff0e with SMTP id
 q33-20020a17090a17a400b002990b60ff0emr7139705pja.13.1708232034237; Sat, 17
 Feb 2024 20:53:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201092559.910982-1-yukuai1@huaweicloud.com> <20240201092559.910982-10-yukuai1@huaweicloud.com>
In-Reply-To: <20240201092559.910982-10-yukuai1@huaweicloud.com>
From: Xiao Ni <xni@redhat.com>
Date: Sun, 18 Feb 2024 12:53:42 +0800
Message-ID: <CALTww2_ppGe29wMOsLS45kR4YS6TyCTBswmeKyVE+-H6XmoN+g@mail.gmail.com>
Subject: Re: [PATCH v5 09/14] dm-raid: really frozen sync_thread during suspend
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: mpatocka@redhat.com, heinzm@redhat.com, blazej.kucman@linux.intel.com, 
	agk@redhat.com, snitzer@kernel.org, dm-devel@lists.linux.dev, song@kernel.org, 
	yukuai3@huawei.com, jbrassow@f14.redhat.com, neilb@suse.de, shli@fb.com, 
	akpm@osdl.org, linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, 
	yi.zhang@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kuai

On Thu, Feb 1, 2024 at 5:30=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> wr=
ote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> 1) The flag MD_RECOVERY_FROZEN doesn't mean that sync thread is frozen,
>    it only prevent new sync_thread to start, and it can't stop the
>    running sync thread;

Agree with this

> 2) The flag MD_RECOVERY_FROZEN doesn't mean that writes are stopped, use
>    it as condition for md_stop_writes() in raid_postsuspend() doesn't
>    look correct.

I don't agree with it. __md_stop_writes stops sync thread, so it needs
to check this flag. And It looks like the name __md_stop_writes is not
right. Does it really stop write io? mddev_suspend should be the
function that stop write request. From my understanding,
raid_postsuspend does two jobs. One is stopping sync thread. Two is
suspending array.

> 3) raid_message can set/clear the flag MD_RECOVERY_FROZEN at anytime,
>    and if MD_RECOVERY_FROZEN is cleared while the array is suspended,
>    new sync_thread can start unexpected.

md_action_store doesn't check this either. If the array is suspended
and MD_RECOVERY_FROZEN is cleared, before patch01, sync thread can't
happen. So it looks like patch01 breaks the logic.

Regards
Xiao


>
> Fix above problems by using the new helper to suspend the array during
> suspend, also disallow raid_message() to change sync_thread status
> during suspend.
>
> Note that after commit f52f5c71f3d4 ("md: fix stopping sync thread"), the
> test shell/lvconvert-raid-reshape.sh start to hang in stop_sync_thread(),
> and with previous fixes, the test won't hang there anymore, however, the
> test will still fail and complain that ext4 is corrupted. And with this
> patch, the test won't hang due to stop_sync_thread() or fail due to ext4
> is corrupted anymore. However, there is still a deadlock related to
> dm-raid456 that will be fixed in following patches.
>
> Reported-by: Mikulas Patocka <mpatocka@redhat.com>
> Closes: https://lore.kernel.org/all/e5e8afe2-e9a8-49a2-5ab0-958d4065c55e@=
redhat.com/
> Fixes: 1af2048a3e87 ("dm raid: fix deadlock caused by premature md_stop_w=
rites()")
> Fixes: 9dbd1aa3a81c ("dm raid: add reshaping support to the target")
> Fixes: f52f5c71f3d4 ("md: fix stopping sync thread")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/md/dm-raid.c | 38 +++++++++++++++++++++++++++++---------
>  1 file changed, 29 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
> index eb009d6bb03a..5ce3c6020b1b 100644
> --- a/drivers/md/dm-raid.c
> +++ b/drivers/md/dm-raid.c
> @@ -3240,11 +3240,12 @@ static int raid_ctr(struct dm_target *ti, unsigne=
d int argc, char **argv)
>         rs->md.ro =3D 1;
>         rs->md.in_sync =3D 1;
>
> -       /* Keep array frozen until resume. */
> -       set_bit(MD_RECOVERY_FROZEN, &rs->md.recovery);
> -
>         /* Has to be held on running the array */
>         mddev_suspend_and_lock_nointr(&rs->md);
> +
> +       /* Keep array frozen until resume. */
> +       md_frozen_sync_thread(&rs->md);
> +
>         r =3D md_run(&rs->md);
>         rs->md.in_sync =3D 0; /* Assume already marked dirty */
>         if (r) {
> @@ -3722,6 +3723,9 @@ static int raid_message(struct dm_target *ti, unsig=
ned int argc, char **argv,
>         if (!mddev->pers || !mddev->pers->sync_request)
>                 return -EINVAL;
>
> +       if (test_bit(RT_FLAG_RS_SUSPENDED, &rs->runtime_flags))
> +               return -EBUSY;
> +
>         if (!strcasecmp(argv[0], "frozen"))
>                 set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
>         else
> @@ -3791,15 +3795,31 @@ static void raid_io_hints(struct dm_target *ti, s=
truct queue_limits *limits)
>         blk_limits_io_opt(limits, chunk_size_bytes * mddev_data_stripes(r=
s));
>  }
>
> +static void raid_presuspend(struct dm_target *ti)
> +{
> +       struct raid_set *rs =3D ti->private;
> +
> +       mddev_lock_nointr(&rs->md);
> +       md_frozen_sync_thread(&rs->md);
> +       mddev_unlock(&rs->md);
> +}
> +
> +static void raid_presuspend_undo(struct dm_target *ti)
> +{
> +       struct raid_set *rs =3D ti->private;
> +
> +       mddev_lock_nointr(&rs->md);
> +       md_unfrozen_sync_thread(&rs->md);
> +       mddev_unlock(&rs->md);
> +}
> +
>  static void raid_postsuspend(struct dm_target *ti)
>  {
>         struct raid_set *rs =3D ti->private;
>
>         if (!test_and_set_bit(RT_FLAG_RS_SUSPENDED, &rs->runtime_flags)) =
{
>                 /* Writes have to be stopped before suspending to avoid d=
eadlocks. */
> -               if (!test_bit(MD_RECOVERY_FROZEN, &rs->md.recovery))
> -                       md_stop_writes(&rs->md);
> -
> +               md_stop_writes(&rs->md);
>                 mddev_suspend(&rs->md, false);
>         }
>  }
> @@ -4012,8 +4032,6 @@ static int raid_preresume(struct dm_target *ti)
>         }
>
>         /* Check for any resize/reshape on @rs and adjust/initiate */
> -       /* Be prepared for mddev_resume() in raid_resume() */
> -       set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
>         if (mddev->recovery_cp && mddev->recovery_cp < MaxSector) {
>                 set_bit(MD_RECOVERY_REQUESTED, &mddev->recovery);
>                 mddev->resync_min =3D mddev->recovery_cp;
> @@ -4056,9 +4074,9 @@ static void raid_resume(struct dm_target *ti)
>                         rs_set_capacity(rs);
>
>                 mddev_lock_nointr(mddev);
> -               clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
>                 mddev->ro =3D 0;
>                 mddev->in_sync =3D 0;
> +               md_unfrozen_sync_thread(mddev);
>                 mddev_unlock_and_resume(mddev);
>         }
>  }
> @@ -4074,6 +4092,8 @@ static struct target_type raid_target =3D {
>         .message =3D raid_message,
>         .iterate_devices =3D raid_iterate_devices,
>         .io_hints =3D raid_io_hints,
> +       .presuspend =3D raid_presuspend,
> +       .presuspend_undo =3D raid_presuspend_undo,
>         .postsuspend =3D raid_postsuspend,
>         .preresume =3D raid_preresume,
>         .resume =3D raid_resume,
> --
> 2.39.2
>


