Return-Path: <linux-kernel+bounces-167139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF058BA4DD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 03:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFC7628477C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 01:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807FFDDD7;
	Fri,  3 May 2024 01:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gigaio-com.20230601.gappssmtp.com header.i=@gigaio-com.20230601.gappssmtp.com header.b="C0J2fWpd"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D948F47
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 01:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714699360; cv=none; b=AMWLotvd84RRhi8NcWFWbYh817bzQ6ye7BssyrzDMsORs1MRxdIUxrLPJf3qL1GU0dA4mRrq2GfFaW5SuC+aQMC9i1CGvVbTHHha+P4QG8NehYEfCCV0cvLc7j2hqWq9xVhXxIhU5YrL6bO9JP31IUHfGjDssylnioxtDsqudSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714699360; c=relaxed/simple;
	bh=THq6Ze4gPUnRdVplVf82t5+be7u1nGQ6bRReSoZAFVY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=jsldj0uZ1TW1MQGv6SQfn/E1tvFi1HLLnCcn0jHP6J0gr9zS1UPLxm//276rnFgpjJHSw9/WhK6kwMll3p5BvWDIT0eu2YI6N5m5Yxiw6jTiZmGGXhxZPQnjWfHQEknB5UOj+PXsy+R3KJMu4R1xGkDsGM7VGb+9sFad2M9o+wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigaio.com; spf=pass smtp.mailfrom=gigaio.com; dkim=pass (2048-bit key) header.d=gigaio-com.20230601.gappssmtp.com header.i=@gigaio-com.20230601.gappssmtp.com header.b=C0J2fWpd; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gigaio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gigaio.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5d42e7ab8a9so4990708a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 18:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gigaio-com.20230601.gappssmtp.com; s=20230601; t=1714699358; x=1715304158; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k3nkCSoTperPlX+PtC8qWAin0Hv01DoPF7+bPAgfSgA=;
        b=C0J2fWpdfbp3GMXsOE611jRLWv7QcNkJfSuOw6/JSbqOePVf7z5Pau7Ux5s53/FPHn
         ikww9kqieEsLQ2xGKutOBFvBkoa4pJF8m9/maKNkbupAOQ+eLeLWjwF8GI3F2+rZLhZl
         ZcLrlthdCNTzKAmTvm6tjwLDQLZFsb0XKJBGIv9trcxa+tav1wKx/4XmQXHd+XQ+zIM2
         Hqf4GC7mretT7nxam7NSXYBiwVxR2opK5AEB7lGezpViYDQcq71wdX52E911nuZe11rw
         jEhntyuy9lHqmHdppJR35KtBJ+/3ie6IYrq3fircVq9bdyNNxi4GMECZ8KkW/NESoQuv
         1OSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714699358; x=1715304158;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k3nkCSoTperPlX+PtC8qWAin0Hv01DoPF7+bPAgfSgA=;
        b=D2imkXHuhFbcSCsTYV/2Va4QTAa0AamWjxyQKhqh99iCysZbhycxcIjhFaE58sIb5O
         DA8fqb6CPIXbAQ1gG5Q+MN8EXmIP7JvAZlFUc/qmxjhRVnz7d1CpMGHLpvw/uXRCTjVD
         07ByADMrR1X8NtzLENdilLlNdjB8HyLcIIb4S4VJ2rQofnmEJlkwKBRR0E3iAKDsslDe
         FxF8ZsZ0x0FLzT+05bmsjQsqCqTLYKNJgd017TT1iZCNRa4VUFoCa6HKTpc8uIYCEOM4
         xpeagLlAEsgqTjBk453alF9auCLVMguIh+uVZAa3WDFOWndlpA24GdCxRankF+7ildqv
         Vg1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXI1YwY6d2R75Ry7MnIksKQkkj5JkgBW3hUo/ATPrIyp7ZtwCg+BA3nBw9Mb0JBnlbyoNrX+XZCxitN+qLYiqnOc1mCLQ5csIGlZ8+n
X-Gm-Message-State: AOJu0YwXzNCIBF7plUnhy6NxyXoa2f7HxB+221X4mptDufr80M9wr3Oz
	cM2jCwYfr/y43/Zj3MJaMEVM6fSW9AGKSbgqm744obPj7QnUPAdKUvHbu95JGGk=
X-Google-Smtp-Source: AGHT+IGPqQB/XAgZAB9D4Bug4cwSh5le6UZzq1h/8n6SQY9bePdvao23D1TuRx+ucuD5rPg2lKkumw==
X-Received: by 2002:a05:6a20:1585:b0:1ad:2016:dff2 with SMTP id h5-20020a056a20158500b001ad2016dff2mr1772812pzj.26.1714699358545;
        Thu, 02 May 2024 18:22:38 -0700 (PDT)
Received: from smtpclient.apple (45-31-42-85.lightspeed.sndgca.sbcglobal.net. [45.31.42.85])
        by smtp.gmail.com with ESMTPSA id sx7-20020a17090b2cc700b002a4b2933a7asm3931314pjb.1.2024.05.02.18.22.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2024 18:22:38 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH v6 0/4] drm: Use full allocated minor range for DRM
From: Eric Pilmore <epilmore@gigaio.com>
In-Reply-To: <20230724211428.3831636-1-michal.winiarski@intel.com>
Date: Thu, 2 May 2024 18:22:26 -0700
Cc: dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 intel-gfx@lists.freedesktop.org,
 David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Simon Ser <contact@emersion.fr>,
 Matthew Wilcox <willy@infradead.org>,
 Oded Gabbay <ogabbay@kernel.org>,
 =?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 James Zhu <James.Zhu@amd.com>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 Emil Velikov <emil.l.velikov@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <83E51798-5335-49AA-8211-60EC29577617@gigaio.com>
References: <20230724211428.3831636-1-michal.winiarski@intel.com>
To: =?utf-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>
X-Mailer: Apple Mail (2.3774.500.171.1.1)



> On Jul 24, 2023, at 2:14=E2=80=AFPM, Micha=C5=82 Winiarski =
<michal.winiarski@intel.com> wrote:
>=20
> 64 DRM device nodes is not enough for everyone.
> Upgrade it to ~512K (which definitely is more than enough).
>=20
> To allow testing userspace support for >64 devices, add additional DRM
> modparam (force_extended_minors) which causes DRM to skip allocating =
minors
> in 0-192 range.
> Additionally - convert minors to use XArray instead of IDR to simplify =
the
> locking.
>=20
> v1 -> v2:
> Don't touch DRM_MINOR_CONTROL and its range (Simon Ser)
>=20
> v2 -> v3:
> Don't use legacy scheme for >=3D192 minor range (Dave Airlie)
> Add modparam for testing (Dave Airlie)
> Add lockdep annotation for IDR (Daniel Vetter)
>=20
> v3 -> v4:
> Convert from IDR to XArray (Matthew Wilcox)
>=20
> v4 -> v5:
> Fixup IDR to XArray conversion (Matthew Wilcox)
>=20
> v5 -> v6:
> Also convert Accel to XArray
> Rename skip_legacy_minors to force_extended_minors
>=20
> Micha=C5=82 Winiarski (4):
>  drm: Use XArray instead of IDR for minors
>  accel: Use XArray instead of IDR for minors
>  drm: Expand max DRM device number to full MINORBITS
>  drm: Introduce force_extended_minors modparam
>=20
> drivers/accel/drm_accel.c      | 110 +++------------------------------
> drivers/gpu/drm/drm_drv.c      | 105 ++++++++++++++++---------------
> drivers/gpu/drm/drm_file.c     |   2 +-
> drivers/gpu/drm/drm_internal.h |   4 --
> include/drm/drm_accel.h        |  18 +-----
> include/drm/drm_file.h         |   5 ++
> 6 files changed, 69 insertions(+), 175 deletions(-)
>=20
> --=20
> 2.41.0
>=20


Hi Michal,

What is the status on this patch? Did it ever get accepted upstream?
If so, what release? I don=E2=80=99t see the changes in the latest Linux =
kernel.
I am working on a system that involves a large number of GPUs, where
each GPU consumes a number of DRM devices. As such, I=E2=80=99m easily
exceeding the current limit of 64 in the (6.6) kernel. To workaround =
this issue,
I have temporarily picked up this patch which is doing the trick, but =
now
I=E2=80=99m wondering if this patch has seen the light of day in the =
Linux kernel.

Thanks for any info!

Regards,
Eric


