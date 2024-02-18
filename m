Return-Path: <linux-kernel+bounces-70215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E938594EA
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 06:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1B451F22C4C
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 05:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3790D53A7;
	Sun, 18 Feb 2024 05:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N86D5dVB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4B5E554
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 05:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708235780; cv=none; b=YI8k7cLOtavsZevyOdDxnqAcYdrt7X+DfC03tQQGNiTaEFf5XJqxxa+ZhzA8YhX6oFbhzBViyEymlMUA2QH5ViCN0NvYXyV0aX6Dy9LhrDBwxUDtAtr8HSkFfqoh4NWFVMzTDMFIwiTVrPkk1jWjpAE4b77e8m6O7tkrf2PiSO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708235780; c=relaxed/simple;
	bh=ykciOYIUf3ziL/MfvckOIh5TxEtXF0aoZrWYpsipNEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AR1IIeQgPPIUPlGj8GUyGLRHsJFxIPcj8Pnhb9ypGwOSb8KhChH18XAWFcRny35n5c6Xg4FD3CMd6tw3ymCryWM6mSKHYjrnwza25FXQgsxh2o7EzWXYJ2raHH3AHZLM9pZZRPKafkbksth01HmdAe/LyPbJ9V5F2RO8HGF9Tss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N86D5dVB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708235777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Can3YssHnCfkpH1KexyMkQMSXqdagr3d1VhL/3Id/+U=;
	b=N86D5dVBXRiqJ9p8HqnDDgwlJ1uCWuLNEBGP2kJgqh75/iXoVWwOGZuntHlX37bH45sef3
	sPJPBnFzFEiYe9VrvPcJ9W2yxLsYMBkk9zzXNWtY4/G1LhQr1EwOP4MzU6SYWLLGV1x5u2
	JGNMVubKwqLaU8FoYkrIW52k/YoQ2S0=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-cCXuBVZJNGG7qYFkSO6B-w-1; Sun, 18 Feb 2024 00:56:16 -0500
X-MC-Unique: cCXuBVZJNGG7qYFkSO6B-w-1
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-59fb255d718so867378eaf.3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 21:56:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708235775; x=1708840575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Can3YssHnCfkpH1KexyMkQMSXqdagr3d1VhL/3Id/+U=;
        b=eW8oxCdah3EYewQa1YsJKRBbM+F0F8niGr2Gr0LyOifbzTDoDcTbvqk728W/XMizZ6
         jrBE/I4UbtW2IupO5IMGphy+Xa1XuVAJxzWyl7tlGpH3S2MxkEmN+dFL5Mk6hK+Q21Le
         sqIiBco6goS8Gda+A276iRwp+HhleSEoD7i1JWRDhlwETua03JgxDEvheo+8NPsUeyL2
         DO2YFLDcvPcNwgkfRF5LovNmV1ZarA9wAdrgThAAj7+qhWLQzOQHwzJO6EzGOMkqUhPa
         cYCBvmdRQW37KrqNO2yvmexHR/nxC4uVMI5PmDB2lxcRlAd5sc7MdsjwzgmKrdk6+3Y1
         8K5A==
X-Forwarded-Encrypted: i=1; AJvYcCVWBXh+bGmyqqw6xLQPLWN4BhGSJucRCN8N12gi5iQpyoZNcRVwlt/HgrdbbNTcH4GpW6tzXVWQQm20kWufYN4tNE+oH6FBIkhzgca7
X-Gm-Message-State: AOJu0Ywln5BMGeOQcRFRryYy2D5X9hg9RjvfjU2Sa0dNnNBqmi+rUXRu
	wDLqjHRCT6PPx+ZPw7pS8yqEFw3nErOQusGgDu4HyYMup65rVlBH7mg7kV7K12UA2VxbkyPwJ6E
	mEGEJ3xvIAFzvDQw9ogE1jgfJ4qoTnDm1yiDCakwxdXVTXb6idwBtbVKBVvr4xa5l9N9mZJwTu2
	DHq2pbJGCpAq04CFEqz0HeJm88ltXTpZ2RqHlD
X-Received: by 2002:a05:6359:4c23:b0:17b:426d:74f3 with SMTP id kj35-20020a0563594c2300b0017b426d74f3mr85572rwc.29.1708235775254;
        Sat, 17 Feb 2024 21:56:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG1oH3m48AGF5d9LWhpYqM/Ix7rL56PvuuMXgyGuIZ4+ENeuNFaOoxZhB6pcFZriK0iTrvDr5pU0tSWKeTn3pY=
X-Received: by 2002:a05:6359:4c23:b0:17b:426d:74f3 with SMTP id
 kj35-20020a0563594c2300b0017b426d74f3mr85561rwc.29.1708235774919; Sat, 17 Feb
 2024 21:56:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201092559.910982-1-yukuai1@huaweicloud.com> <20240201092559.910982-4-yukuai1@huaweicloud.com>
In-Reply-To: <20240201092559.910982-4-yukuai1@huaweicloud.com>
From: Xiao Ni <xni@redhat.com>
Date: Sun, 18 Feb 2024 13:56:03 +0800
Message-ID: <CALTww283nysUDy=jmW4w45GbS6O2nS0XLYX=KEiO2BUp5+cLaA@mail.gmail.com>
Subject: Re: [PATCH v5 03/14] md: make sure md_do_sync() will set MD_RECOVERY_DONE
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: mpatocka@redhat.com, heinzm@redhat.com, blazej.kucman@linux.intel.com, 
	agk@redhat.com, snitzer@kernel.org, dm-devel@lists.linux.dev, song@kernel.org, 
	yukuai3@huawei.com, jbrassow@f14.redhat.com, neilb@suse.de, shli@fb.com, 
	akpm@osdl.org, linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, 
	yi.zhang@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 5:30=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> wr=
ote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> stop_sync_thread() will interrupt md_do_sync(), and md_do_sync() must
> set MD_RECOVERY_DONE, so that follow up md_check_recovery() will
> unregister sync_thread, clear MD_RECOVERY_RUNNING and wake up
> stop_sync_thread().
>
> If MD_RECOVERY_WAIT is set or the array is read-only, md_do_sync() will
> return without setting MD_RECOVERY_DONE, and after commit f52f5c71f3d4
> ("md: fix stopping sync thread"), dm-raid switch from
> md_reap_sync_thread() to stop_sync_thread() to unregister sync_thread
> from md_stop() and md_stop_writes(), causing the test
> shell/lvconvert-raid-reshape.sh hang.
>
> We shouldn't switch back to md_reap_sync_thread() because it's
> problematic in the first place. Fix the problem by making sure
> md_do_sync() will set MD_RECOVERY_DONE.
>
> Reported-by: Mikulas Patocka <mpatocka@redhat.com>
> Closes: https://lore.kernel.org/all/ece2b06f-d647-6613-a534-ff4c9bec1142@=
redhat.com/
> Fixes: d5d885fd514f ("md: introduce new personality funciton start()")
> Fixes: 5fd6c1dce06e ("[PATCH] md: allow checkpoint of recovery with versi=
on-1 superblock")
> Fixes: f52f5c71f3d4 ("md: fix stopping sync thread")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/md/md.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 6906d023f1d6..c65dfd156090 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -8788,12 +8788,16 @@ void md_do_sync(struct md_thread *thread)
>         int ret;
>
>         /* just incase thread restarts... */
> -       if (test_bit(MD_RECOVERY_DONE, &mddev->recovery) ||
> -           test_bit(MD_RECOVERY_WAIT, &mddev->recovery))
> +       if (test_bit(MD_RECOVERY_DONE, &mddev->recovery))
>                 return;
> -       if (!md_is_rdwr(mddev)) {/* never try to sync a read-only array *=
/
> +
> +       if (test_bit(MD_RECOVERY_INTR, &mddev->recovery))
> +               goto skip;
> +
> +       if (test_bit(MD_RECOVERY_WAIT, &mddev->recovery) ||
> +           !md_is_rdwr(mddev)) {/* never try to sync a read-only array *=
/
>                 set_bit(MD_RECOVERY_INTR, &mddev->recovery);
> -               return;
> +               goto skip;
>         }

Hi all

I have a question here. The codes above means if MD_RECOVERY_WAIT is
set, it sets MD_RECOVERY_INTR. If so, the sync thread can't happen.
But from the codes in md_start function:

                set_bit(MD_RECOVERY_WAIT, &mddev->recovery);
                md_wakeup_thread(mddev->thread);
                ret =3D mddev->pers->start(mddev);
                clear_bit(MD_RECOVERY_WAIT, &mddev->recovery);
                md_wakeup_thread(mddev->sync_thread);

MD_RECOVERY_WAIT means "it'll run sync thread later not interrupt it".
I guess this patch can introduce a new bug for raid5 journal?

And to resolve this deadlock, we can use this patch:

--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -3796,8 +3796,10 @@ static void raid_postsuspend(struct dm_target *ti)
        struct raid_set *rs =3D ti->private;

        if (!test_and_set_bit(RT_FLAG_RS_SUSPENDED, &rs->runtime_flags)) {
+               if (test_bit(MD_RECOVERY_WAIT, &rs->md.recovery))
+                       clear_bit(MD_RECOVERY_WAIT, &rs->md.recovery);

Regards
Xiao
>
>         if (mddev_is_clustered(mddev)) {
> --
> 2.39.2
>


