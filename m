Return-Path: <linux-kernel+bounces-36368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5001839FBC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 03:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54D2628442B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 02:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FB55C98;
	Wed, 24 Jan 2024 02:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LL2WBjOi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76C35244
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 02:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706065123; cv=none; b=m47QYf5qnnTfIAOCQ4veU9W5+h8i7Kb8wH3ocFN80FTljw9EIhp/JVR6LwyxypDahL13mHa8IY1w8Imk/ccunx0m8cccHzHMF04ByMPri7cnFxaSVRQuEOyJXRzidp5qnC9hNhmM5UUPaBqk+EcNwbwZLHiDj9Y98KTtL0dmc5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706065123; c=relaxed/simple;
	bh=g73w3oGcjQjPTuHwF8LT2kH6K2o25tSddbNO6vmK7OE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bQGAyD/PsaZFbwaVWtRr+e78mT2wRjhDmjQ8JuJ5+g9Ag2kemhit3tvuOrloFNooN5yLQBcLjqLQd77v5dBPBu/beIOOByFPNROtZP9QVZugn05uXkSm0kPQItbfMLXLLGUyBOqah8SH2BR4OiimHSwzxRRUJUz4apGNztsx5vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LL2WBjOi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706065119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Aa5lqsF1sJUt2zL2UVZScY7jse2XJ4+k4JV/JtcjRIQ=;
	b=LL2WBjOizx886bb+NBpSxU0y74b2bWKyk/xT3pSjmqR1zDu8Grw5RGfaQAC7tbyT0Vbf0g
	2a+Fm0JN9ySMeKsWLP+P27VhNHTqR5k4ThSCCaJHkB2DZDLADK23NC5fN33VItxcc2uRPq
	5T3n+j87c0LPQ8bQLCWPW4Fuj2I1NWU=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-GgKqxspEPyKYuOl1YUyr9Q-1; Tue, 23 Jan 2024 21:58:33 -0500
X-MC-Unique: GgKqxspEPyKYuOl1YUyr9Q-1
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-598dfff253bso4724254eaf.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 18:58:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706065113; x=1706669913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aa5lqsF1sJUt2zL2UVZScY7jse2XJ4+k4JV/JtcjRIQ=;
        b=U1I0tkWQxQOdxQiyf5980Y03a3lBNvcb7x9Z+m2iTvN0Oi0/q3GxWQ+Vo9UN4Szbfi
         SQK488d9oP1W+rtfkKeRiW/odWK02h2hgBbZYvSqu5zuquDJEfZbK7ESeAA27q50C6QB
         XdB3DhOEf4p2rwAuPpWy1tbhs3b4e6AaXEWV07lshHTBbxsz/oyASGdwriwa1XaiyBpu
         f55Yb6Q1KZX41SyLlThPPWf7EKSFMC7P6i+Q8VDVzQsZVPMjp6LrDxzy7VSaCbgctst5
         DzMNY2gM9KBGlHDCsHDzdDupTJesHBpx80dtWt4t1HTPNODFFuxMeLDNHNdVQeMXxMr/
         6smQ==
X-Gm-Message-State: AOJu0YzFtyc5Nksdv3Rd9OCpLGMuleBK/1yNuEYx9mQVkj8RzJBeDUFg
	+xKr9+3+dauiFLhNKXJeOUpGm8GDnK6/btBRgWpvO2tVPiu/wTgGAjsFhZKMXvyEc4b1bla+FLF
	q2tuhm5lwfiTAjPvuqbuUeiIAwJv5Fq2xlHwOEO5U59AVpFRtJe4KoprVlDMZbfRzPbXBc6bJtV
	u9glmyVum+VqWtVt0xkES44URybcGf1tUak+ig
X-Received: by 2002:a05:6358:923:b0:176:91b9:831 with SMTP id r35-20020a056358092300b0017691b90831mr40192rwi.63.1706065113100;
        Tue, 23 Jan 2024 18:58:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFo8UyiGnq660sIA/58wPfOKhfxUA+DUrZjXFWkRF4CkLydOzrbPoGAyKjtdHtH1xeZuO/K9Je3ZJf0U1SkUi0=
X-Received: by 2002:a05:6358:923:b0:176:91b9:831 with SMTP id
 r35-20020a056358092300b0017691b90831mr40183rwi.63.1706065112851; Tue, 23 Jan
 2024 18:58:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240120103734.4155446-1-yukuai1@huaweicloud.com> <20240120103734.4155446-4-yukuai1@huaweicloud.com>
In-Reply-To: <20240120103734.4155446-4-yukuai1@huaweicloud.com>
From: Xiao Ni <xni@redhat.com>
Date: Wed, 24 Jan 2024 10:58:21 +0800
Message-ID: <CALTww28NL+yBT8bcL2=ATJr79eL45=TF-EXHUD8NsfCXXTG3Qw@mail.gmail.com>
Subject: Re: [PATCH 3/5] md: make sure md_do_sync() will set MD_RECOVERY_DONE
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: mpatocka@redhat.com, dm-devel@lists.linux.dev, msnitzer@redhat.com, 
	heinzm@redhat.com, song@kernel.org, yukuai3@huawei.com, 
	linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org, yi.zhang@huawei.com, 
	yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all

MD_RECOVERY_WAIT was introduced in d5d885fd5. From this patch,
MD_RECOVERY_WAIT only has one usage during creating raid device.
resync job needs to wait until pers->start finishes(The only place
which is checked). If we remove it from md_do_sync, will it break the
logic? Or we don't need this flag anymore? If so can we remove this
flag?

dm-raid uses this bit in patch 644e2537f (dm raid: fix stripe adding
reshape deadlock). It's the reason why md_do_sync can't set
MD_RECOVERY_DONE. Now we stop sync thread asynchronously, can we
revert this patch?

Best Regards
Xiao

On Sat, Jan 20, 2024 at 6:41=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> stop_sync_thread() will interrupt md_do_sync(), and md_do_sync() must
> set MD_RECOVERY_DONE, so that follow up md_check_recovery() will
> unregister sync_thread, clear MD_RECOVERY_RUNNING and wake up
> stop_sync_thread().
>
> Before this patch, if MD_RECOVERY_WAIT is set or the array is read-only,
> md_do_sync() will return without setting MD_RECOVERY_DONE, hence use
> stop_sync_thread() directly will hang because md_check_recovery() can't
> clear MD_RECOVERY_RUNNING, which is possible for dm-raid.
>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/md/md.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 6906d023f1d6..ba45c7be3dbe 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -8788,12 +8788,13 @@ void md_do_sync(struct md_thread *thread)
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
> +       if (test_bit(MD_RECOVERY_WAIT, &mddev->recovery) ||
> +           !md_is_rdwr(mddev)) {/* never try to sync a read-only array *=
/
>                 set_bit(MD_RECOVERY_INTR, &mddev->recovery);
> -               return;
> +               goto out;
>         }
>
>         if (mddev_is_clustered(mddev)) {
> @@ -9171,6 +9172,7 @@ void md_do_sync(struct md_thread *thread)
>                                                 mddev->array_sectors);
>         }
>
> +out:
>         spin_lock(&mddev->lock);
>         if (!test_bit(MD_RECOVERY_INTR, &mddev->recovery)) {
>                 /* We completed so min/max setting can be forgotten if us=
ed. */
> --
> 2.39.2
>
>


