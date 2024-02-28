Return-Path: <linux-kernel+bounces-85834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A5386BC00
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF644284E97
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 23:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF99113D301;
	Wed, 28 Feb 2024 23:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZE9GA6zo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4843D13D2F2
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 23:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709161935; cv=none; b=TiPf17JK2y/7PSC8fpfFEQlUlX4Z7cFybUOt5CxfGnxJUGfm1ldpJQs5fQqqkBbw3Nlp5KdEsgNNYOvt/itKseTG7NKy+s67Ncg77g4K92bURzlV+da7POHPg/W07T8jXXQkzL/0fLg4he/46RH9J3o3t9OYCBQfUdjOeQgIdMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709161935; c=relaxed/simple;
	bh=Kh9UkKZ1e7XMeFM+3ZNbmlTEAPU02Xhe90wn6scq6bg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A/OJj/BiY61A/9Srtw7R/o0aIH7Moi4HQT+p6nEnWr9sFyAtCRqMwnBlMw1C447G4pTvp5Dv///ZFGPMaUzMxZzZUW8zYmo5x/iZ2PwmBQYPeSaf6izOweHu96xm7aePMqe7/HnTNvdV8cNhyebXS6Gizk4mc7UC6yC8ypG21Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZE9GA6zo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709161931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M2IAhhTxkG9uPUwm7NpsFl2OrlljKctFXF++HriPSyQ=;
	b=ZE9GA6zofKGO/NKHhFIShE9bh2u9Rxr1EDdTZ6JdQG021+CibImeqoLB9rSjzCW1fKboAr
	R4euo3/VfwVG2pjeBCQkQet1qCJlm1zQ5lyxXifkDBy+DNNFKYoj1RBKezacwgjj5gQ2mV
	9nJhlrCZxDlK9FPRUbBvWDPSOekB6AY=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-wAngxh49NwKGbkNq4RVWQg-1; Wed, 28 Feb 2024 18:12:10 -0500
X-MC-Unique: wAngxh49NwKGbkNq4RVWQg-1
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-59fbb444bacso248880eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 15:12:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709161930; x=1709766730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M2IAhhTxkG9uPUwm7NpsFl2OrlljKctFXF++HriPSyQ=;
        b=DlWTVl2Abdu1TlJccLSPITxopq0Tqs+Xd54SvKvD/P2LqLkoc4gIWuS1XttVpRTMtC
         Yg2Tn6XKUikDGdn2VbXqKiooLIH3f34jDr4sptGU4DtyV7Ge49ytqxJpiPK19QeNaS9s
         MGPTMmk9mv+TN7atN+FxHp5kxNG6DKAOqDy6PGrKRdz5rzx996ux6/7Cw2NpAKED2RNQ
         ov4D/WI52pS16oj2TxVdZhtag4VaRzU7iCTGjJpDS9VwYoqSbef0ZHtPCCWTYH1/06hS
         LWF9zjqynkoWlfhRtWv28zsAFQPCtDKDknQ6W5wq0ynbGIRROF00CQfUE0kQ1P7zKtIj
         d9Bg==
X-Forwarded-Encrypted: i=1; AJvYcCUH7qw4eqqbREvEGIeVeNQ0f1uiw8MHRVkHv8hGLSSB6E+9zuAKATGfUDfaAVTU4AcvoPEvXhRmTgDlz2EiwJEAHD4P5xHrhRhXtq5F
X-Gm-Message-State: AOJu0YzcmmLMal5l9VQbNX6n+Uy8DcvzMPiebQiaCXjpS+X5rbtyPWyv
	bFBHwvMDZVviPF6Gtc7RQJJOmM067bOc6NOmr862yzQbCeLPhB1Tg63KSw1G9d9frsQH/uFiADy
	xIzGO8xXLZ7bAAhq+Zxo+UhAT7WgGI91pyPDLY62w7rieuy8/1mL/KDsaZx3WXAjPC0cG6yBJx4
	kXqX28R/77jHaP/ANyhLCBXhZxFjupmLXxB0/Z
X-Received: by 2002:a4a:3447:0:b0:59f:fc2d:8179 with SMTP id n7-20020a4a3447000000b0059ffc2d8179mr493593oof.9.1709161929870;
        Wed, 28 Feb 2024 15:12:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFntvEPbQKWTGSDsAEHdmd9g3EM74H/QdrIiJ47zPCDBlTr2DD7PBA+alIV24Pc/h5p+S7aH/zbiYAQw5HARoE=
X-Received: by 2002:a4a:3447:0:b0:59f:fc2d:8179 with SMTP id
 n7-20020a4a3447000000b0059ffc2d8179mr493578oof.9.1709161929669; Wed, 28 Feb
 2024 15:12:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228-tidss-dev-err-probe-v1-1-5482252326d3@redhat.com> <8734tcnt7y.fsf@minerva.mail-host-address-is-not-set>
In-Reply-To: <8734tcnt7y.fsf@minerva.mail-host-address-is-not-set>
From: Enric Balletbo i Serra <eballetb@redhat.com>
Date: Thu, 29 Feb 2024 00:11:59 +0100
Message-ID: <CALE0LRvUMQmMv57UQNncrDFZu=ucmOuSXZNCaJ-10VTFjvenvQ@mail.gmail.com>
Subject: Re: [PATCH] drm/tidss: Use dev_err_probe() over dev_dbg() when
 failing to probe the port
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: Andrew Halaney <ahalaney@redhat.com>, Jyri Sarha <jyri.sarha@iki.fi>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Andrew,

Many thanks for proposing this.

On Wed, Feb 28, 2024 at 11:02=E2=80=AFPM Javier Martinez Canillas
<javierm@redhat.com> wrote:
>
> Andrew Halaney <ahalaney@redhat.com> writes:
>
> Hello Andrew,
>
> > This gets logged out to /sys/kernel/debug/devices_deferred in the
> > -EPROBE_DEFER case and as an error otherwise. The message here provides
> > useful information to the user when troubleshooting why their display i=
s
> > not working in either case, so let's make it output appropriately.
> >
> > Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> > ---
> > There's definitely more spots in this driver that could be upgraded fro=
m
> > dev_dbg() to something more appropriate, but this one burned me today s=
o
> > I thought I'd send a patch for it specifically before I forget.
> > ---
>
> Makes sense to me and I agree that's useful to have that information ther=
e.
>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
>

Logging in  /sys/kernel/debug/devices_deferred was useful for me, so

Tested-by: Enric Balletbo i Serra <eballetbo@kernel.org>

Cheers,
  Enric

> --
> Best regards,
>
> Javier Martinez Canillas
> Core Platforms
> Red Hat
>


