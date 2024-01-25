Return-Path: <linux-kernel+bounces-38103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C9983BAF9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBB7A1F26373
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 07:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9870A17551;
	Thu, 25 Jan 2024 07:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O4MFiWAJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C055244
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 07:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706169086; cv=none; b=BXKoHdZ3zNW/Xap58ky5WzzlzZS4ySMr5I+F0gTC0knEhwUdw0exIoMFnBj3lq7RbZUpWbAU12ClzYc8Gz0VFTrAFR0r14iTb+UwBTQC8amSK7aZUaGk8SAWrx8KEHCSDgk/GP02PJEwLm13Jyth9P6lYP3OlrV/YCdHzFp11hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706169086; c=relaxed/simple;
	bh=IJk53f2ApOxRAEPTKIzDtiOaoN3YBA85NACNk6p/iB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uf95rtZIZZwqWT8nKFYmfXrdrpFjJXX2ELB9L6/729WoG7/dR3nuzgiQIq/A4IfTXLhPTuyXs4E9EOqEz5g8nkpiV2khgNhPS7wwR3nQ+Vj7fXm4LCtUqlZyxslmhm3bc6LeVvg7hJ8UJEoNQWgnS23vomNSzwl8rTCBEt7AbBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O4MFiWAJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706169082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LyC31zzzcvBQLccO8yitrHL0CNB1m9jX4OQ2W97orWU=;
	b=O4MFiWAJqU7cXQ+7vll8X1yn1Iu7fgwN7K9jVrXdcfmnTjJMsMQNHW0Y3l/gABeqDAIxTZ
	7U/qIfvIIZITkrY1++QlVAxr9Gomi0IdNe436iyvyuxDhVOmc6vnVT1wt0NZ1u3cMWyxBh
	UoZpt7Tf2UdjPBsz3C1wAMGC9EYSaJQ=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-E0VmIMqEPcOipDbMhGjpSQ-1; Thu, 25 Jan 2024 02:51:21 -0500
X-MC-Unique: E0VmIMqEPcOipDbMhGjpSQ-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6ddc41f35a3so803032b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 23:51:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706169080; x=1706773880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LyC31zzzcvBQLccO8yitrHL0CNB1m9jX4OQ2W97orWU=;
        b=VksT46Dc5oxHTrOVWjcfPfA+zLzK+ry7G4fVCrtvHx9IByMn0wk/CW9KFjkontsHJM
         bSWg6BQxajw5tifNcuagWNOfjwb6ZI/ycXeSx3VvQQ8fOEBrxRYaWw+edGECInSyHccB
         Ibx+hzPxYLZzQGPO59QV167VLMtcpUkmlel7Wiw6sTRpuS9jHYV6Xa0QvypBOZzIfi07
         evPiWKcc0cUPEuavA4ArI85dQgc3U5EWb5pRsQqegKcGvLGXp4WvHgzfs4p16yJ7+1dy
         5mHYIamK7UbN25WE2s5YnMcDV9KfIiX2aW8/8UU8rZzTbvlExIOtSCaZxLc2OACATNbw
         pYbA==
X-Gm-Message-State: AOJu0YxRWxnDSzoP93MT8n85DQ1BXgzG8iQ0opez1R89TDCJKUkY72/A
	k+RqvezgqYTrLwNhe3BPjdMg7WTSGlTIkHCC04Wq6qBOnw33LTMqrpRUYnUvw6BFe7ttJLEjV2v
	6UAT1dQ+GRImGpBdGZqE1ikmnL2u3IsFq7LckV+GMEdifFbf+hpuWLLNMq4EzjAySwWBE3EAyyw
	5jtGttUdwKn3o6Qlhix7JQKMpN00NsL2zZl5Ea
X-Received: by 2002:aa7:9819:0:b0:6dd:c379:28f7 with SMTP id e25-20020aa79819000000b006ddc37928f7mr252931pfl.21.1706169079990;
        Wed, 24 Jan 2024 23:51:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHSlcVyOOUsGiV0wV1PdgkTikecKl6oWsCQDpmwLacZpUS4x9H+HIkFzdIbi1zrP/QBZOMNarTehuzV4tTCU7g=
X-Received: by 2002:aa7:9819:0:b0:6dd:c379:28f7 with SMTP id
 e25-20020aa79819000000b006ddc37928f7mr252918pfl.21.1706169079670; Wed, 24 Jan
 2024 23:51:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124091421.1261579-1-yukuai3@huawei.com> <20240124091421.1261579-6-yukuai3@huawei.com>
In-Reply-To: <20240124091421.1261579-6-yukuai3@huawei.com>
From: Xiao Ni <xni@redhat.com>
Date: Thu, 25 Jan 2024 15:51:08 +0800
Message-ID: <CALTww2_hG2_YL1v-d0=uv2=bVzJ2wwpSJyQdBBGMCBx79bot-Q@mail.gmail.com>
Subject: Re: [PATCH v2 05/11] md: export helpers to stop sync_thread
To: Yu Kuai <yukuai3@huawei.com>
Cc: agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com, 
	dm-devel@lists.linux.dev, song@kernel.org, jbrassow@f14.redhat.com, 
	neilb@suse.de, heinzm@redhat.com, shli@fb.com, akpm@osdl.org, 
	linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, 
	yukuai1@huaweicloud.com, yi.zhang@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 5:19=E2=80=AFPM Yu Kuai <yukuai3@huawei.com> wrote:
>
> The new heleprs will be used in dm-raid in later patches to fix
> regressions and prevent calling md_reap_sync_thread() directly.
>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/md/md.c | 41 +++++++++++++++++++++++++++++++++++++----
>  drivers/md/md.h |  3 +++
>  2 files changed, 40 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 6c5d0a372927..90cf31b53804 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -4915,30 +4915,63 @@ static void stop_sync_thread(struct mddev *mddev,=
 bool locked, bool check_seq)
>                 mddev_lock_nointr(mddev);
>  }
>
> -static void idle_sync_thread(struct mddev *mddev)
> +void md_idle_sync_thread(struct mddev *mddev)
>  {
> +       lockdep_assert_held(mddev->reconfig_mutex);
> +

Hi Kuai

There is a building error. It should give a pointer to
lockdep_assert_held. And same with the other two places in this patch.

Regards
Xiao

>         mutex_lock(&mddev->sync_mutex);
>         clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
> +       stop_sync_thread(mddev, true, true);
> +       mutex_unlock(&mddev->sync_mutex);
> +}
> +EXPORT_SYMBOL_GPL(md_idle_sync_thread);
> +
> +void md_frozen_sync_thread(struct mddev *mddev)
> +{
> +       lockdep_assert_held(mddev->reconfig_mutex);
> +
> +       mutex_lock(&mddev->sync_mutex);
> +       set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
> +       stop_sync_thread(mddev, true, false);
> +       mutex_unlock(&mddev->sync_mutex);
> +}
> +EXPORT_SYMBOL_GPL(md_frozen_sync_thread);
>
> +void md_unfrozen_sync_thread(struct mddev *mddev)
> +{
> +       lockdep_assert_held(mddev->reconfig_mutex);
> +
> +       mutex_lock(&mddev->sync_mutex);
> +       clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
> +       set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
> +       md_wakeup_thread(mddev->thread);
> +       sysfs_notify_dirent_safe(mddev->sysfs_action);
> +       mutex_unlock(&mddev->sync_mutex);
> +}
> +EXPORT_SYMBOL_GPL(md_unfrozen_sync_thread);
> +
> +static void idle_sync_thread(struct mddev *mddev)
> +{
>         if (mddev_lock(mddev)) {
>                 mutex_unlock(&mddev->sync_mutex);
>                 return;
>         }
>
> +       mutex_lock(&mddev->sync_mutex);
> +       clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
>         stop_sync_thread(mddev, false, true);
>         mutex_unlock(&mddev->sync_mutex);
>  }
>
>  static void frozen_sync_thread(struct mddev *mddev)
>  {
> -       mutex_lock(&mddev->sync_mutex);
> -       set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
> -
>         if (mddev_lock(mddev)) {
>                 mutex_unlock(&mddev->sync_mutex);
>                 return;
>         }
>
> +       mutex_lock(&mddev->sync_mutex);
> +       set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
>         stop_sync_thread(mddev, false, false);
>         mutex_unlock(&mddev->sync_mutex);
>  }
> diff --git a/drivers/md/md.h b/drivers/md/md.h
> index 8d881cc59799..437ab70ce79b 100644
> --- a/drivers/md/md.h
> +++ b/drivers/md/md.h
> @@ -781,6 +781,9 @@ extern void md_rdev_clear(struct md_rdev *rdev);
>  extern void md_handle_request(struct mddev *mddev, struct bio *bio);
>  extern int mddev_suspend(struct mddev *mddev, bool interruptible);
>  extern void mddev_resume(struct mddev *mddev);
> +extern void md_idle_sync_thread(struct mddev *mddev);
> +extern void md_frozen_sync_thread(struct mddev *mddev);
> +extern void md_unfrozen_sync_thread(struct mddev *mddev);
>
>  extern void md_reload_sb(struct mddev *mddev, int raid_disk);
>  extern void md_update_sb(struct mddev *mddev, int force);
> --
> 2.39.2
>


