Return-Path: <linux-kernel+bounces-53167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA4A84A195
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC951285105
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA08347F41;
	Mon,  5 Feb 2024 17:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j/kKlqU6"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BDC4E1BF
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 17:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707155770; cv=none; b=JMaA9Na0VyOiXu3DUbm/PbvrYpVKyMb9KzLzEwtSaQGQZ0dl3s234OUEGphXFC1C5HYBbwGGpY2rYGSB/rRG3Hrsn0uthwRwg4vWrcjrKNjMEtFTawmwBPbwuSS9t6fN+HFkUo+v4a7EttD4h0QtqlPbW13voSTWokwcoOAvFWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707155770; c=relaxed/simple;
	bh=Y1+OGpgO63h+CoyrYHJeBkVHIfjV8yHeOKcX7588wxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KSOLTeljl8oeIDG42pcyPz3l6fsoJSeaxMFsLpCTK64RpDg/qejDwcu1kswPx/8szxGS7mCq8WPA8BHBsdt+7q2FRE7e6ioVJ1UntOnSx2/xJBzkKebn8jmMlgPu3VXGkrEPC1iud6I2pC6yQpKeWcKTFPEfSdClKRcDHMxVmzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j/kKlqU6; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40f0218476aso6925e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 09:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707155767; x=1707760567; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y1+OGpgO63h+CoyrYHJeBkVHIfjV8yHeOKcX7588wxQ=;
        b=j/kKlqU6T0qIJhCMy9EQ6i/Q6rVT7CdP2dbM1BlcQ8UrvDwthHQo4m6xsIJVw6i+fy
         ulBleSkxPDLG3JRTwuH28kV+Xd+lmrdbpFMXMHnvPKgo1Urf/zvcDBjNuOwiU/eRGyyw
         WM9xYPRlIDhnXuxkH/KFH7Ce5NHpF7GfXVVTXLi5Zt0EnQ6uGFaxb7AKUqSqtsDQcil0
         M6R9DDgP4e8yB5tdSrfsrQM1wuA6cSB+EEMDVCiUrvEDCUSNYSvnYYski9LFv4NN9sYE
         oTanzUAfMa1fk/naCr9BvAdXL4suah7SV0ovpjPlv2oT8kvMXenolFAydHAb8CloJ1be
         JDNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707155767; x=1707760567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y1+OGpgO63h+CoyrYHJeBkVHIfjV8yHeOKcX7588wxQ=;
        b=svNFH9TJ/Xt9SyvV/uWd90aeEjrwY3kkS8Sl+WDnFjz+9XRD8dfhKfIaN1hnFfcRdd
         xtAGVKnV6zS6Hkbs/gAsT6iS7aqPQ6NAcnukSXrC2gVMo+8JXAI2rw07zAbE/hyt9OO1
         IXYtANz2ckIZ63XA480VcZa05NzmYqoeZHbi0xIvYD3NKxehheuY3LFqH3Ugn9z7iJYD
         4fh1Ay4cHL2CGZ3bPxuO2zrSbVVoko6VFj3n3ioNH/QyD1kOM1LoL70gWo/EAhebjV1w
         DMgyPUknCFgSicLGo3PRmUZv0LlERcxKT/bslzix/je2PTv7kn4WGbAHeruV/fD9XXbI
         8dUQ==
X-Gm-Message-State: AOJu0YxEoDkdbvI8SQ0Izh8c3v4K+owUg8fD4EYhtJJJfoZ8tFs2Vyds
	DKj/yDwpigjt1Wa21d+2l8nTiwq2iWrmrswTrZd9Oh87iZn62tBxSCGa94ve/DcDhuX36bSFxcJ
	dkYIiOr4LA5OGipw6sZ2R/cs7j3iM779+RGY=
X-Google-Smtp-Source: AGHT+IEnaDiX/OcCRASvTFKqqbb/i//uiR4yKUJvHKwFX4zPwyfbM9Aww/8xHpm2xtrafzPUXoU0/HaRQHki1N+jtes=
X-Received: by 2002:a05:600c:1e07:b0:40f:df29:9abf with SMTP id
 ay7-20020a05600c1e0700b0040fdf299abfmr18729wmb.2.1707155767456; Mon, 05 Feb
 2024 09:56:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b236236a-9953-4246-a697-19ed1b22d86a@web.de>
In-Reply-To: <b236236a-9953-4246-a697-19ed1b22d86a@web.de>
From: John Stultz <jstultz@google.com>
Date: Mon, 5 Feb 2024 09:55:53 -0800
Message-ID: <CANDhNCpZZ9k-7h4VWNq_=56v1fRehKJcHobZ=mfu3MP9Rzno+w@mail.gmail.com>
Subject: Re: [PATCH] drm/hisilicon: Use devm_platform_get_and_ioremap_resource()
 in dsi_parse_dt()
To: Markus Elfring <Markus.Elfring@web.de>
Cc: dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org, 
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	Douglas Anderson <dianders@chromium.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Tian Tao <tiantao6@hisilicon.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Xinliang Liu <xinliang.liu@linaro.org>, Xinwei Kong <kong.kongxinwei@hisilicon.com>, 
	Yongqin Liu <yongqin.liu@linaro.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 12:13=E2=80=AFAM Markus Elfring <Markus.Elfring@web.=
de> wrote:
>
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 5 Feb 2024 08:58:21 +0100
>
> A wrapper function is available since the commit 890cc39a879906b63912482d=
fc41944579df2dc6
> ("drivers: provide devm_platform_get_and_ioremap_resource()").
> Thus reuse existing functionality instead of keeping duplicate source cod=
e.
>
> This issue was detected by using the Coccinelle software.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

I no longer have hardware to test with this, but this looks reasonable to m=
e.

Acked-by: John Stultz <jstultz@google.com>

thanks
-john

