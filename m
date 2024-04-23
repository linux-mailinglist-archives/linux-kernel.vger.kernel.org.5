Return-Path: <linux-kernel+bounces-155153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9B58AE5EE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E5381F22D83
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD3B8615C;
	Tue, 23 Apr 2024 12:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qtQDLjrx"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828E18593E
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 12:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713875000; cv=none; b=Aw5BPz2wDcci1C7/lm1eO7EkcQx5Bw0HxfPhc6hw5d+i6Zmaefo3Ys5XlKugEyKH6OuM0fdUcbkTw4EaUF1l/n8nn5D8fvvSC6dUP8sPCvts/tXKuvTZZw0s8z9ZmjM2DZHnTqqjVq2QNgNvlXQizAHGb1I9fsuaAsnFpTFuFUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713875000; c=relaxed/simple;
	bh=zdEuS8XRlyMWs8i+nahfC/xh1vWX2u7uUNV94NmtyxI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QxU6pZvZEcHPnIEQ4X8c9xHRs5FajqTRU3wjnlo+feRT2zJRZQ4Nzkw/YDiH/zqjhKCXU5rdTx5VMIX4WetRhHqv935RjXj9ZHLCDiinA9vwOBkqCg6EFRn0OQqnsuHWzuqqeTKY7Zwq+SUFXYp+67UzbxNhnea/5xAsKD2VMQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qtQDLjrx; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-de45385a1b4so5240884276.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 05:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713874997; x=1714479797; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zdEuS8XRlyMWs8i+nahfC/xh1vWX2u7uUNV94NmtyxI=;
        b=qtQDLjrxOz4wZvnJ9bfDXVOwl9pgcBQaULNGILtSLiwxeDyEfhAr8hY1GpjLS2dTRk
         hQ1iEhbECkmemy1TAXFuMPOUOPGWJ4rJo2px55vkJ71AvfR6b49QPvbxKf8zrSmSbhDL
         bQ6ESm52uGwAZteQRyEsWi+LVmP+rj6eeITbPGoDbG9wthTw8JwH56ionOcthpbCsPt2
         4qkwk+V30rP778AX8Fo+6zV0EUS7gnYsMXei7jeXT20ob3nxPjhcJLsMDKuLfT5Ccqlj
         q+xCVo5CRZqIuVae8f4MvSq4uyC3n5xov/0Pw4C7KkELMp4EY9osQ15Hc88NeVYZ1Tq7
         vsMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713874997; x=1714479797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zdEuS8XRlyMWs8i+nahfC/xh1vWX2u7uUNV94NmtyxI=;
        b=U0+sD5W/GA/p7EDV5+2PU1tLKQDXPQAbrtfsgy3pEzOsS2f+Qg+FPn6cAHtqgScryx
         HSmAtx96wB6o9x17mqGjqb4eJl7wl7B4REGkN9ZLxgl5fvfWFF4hAYFIaUnIoRMo2QAw
         qfoCm36qmrM6oxxc1j2u7o8mkqkiRQeDTVbitO/Kn0MB9CqAQuTau8l7tcBAQ2G89hpy
         srMDtom6OnHsk+Cu+Hgg10bgJwZKmrqJqHhx+MlmBgTopIA4X15O7fP7T1OQbCq3PCtR
         f+8mmQVQKvOwLmysDIHUuXXanw7cnxCaIxdopDB8brbfok2NaLxW+vG0mt9AAHZM36Ah
         HBnA==
X-Forwarded-Encrypted: i=1; AJvYcCUQT3gQiKjIzsTFq6Ob5aLlnDhICWs1K1cHt2CTyUWueV/P3zZI4rNUKW4ocA3ooAMx/5D8XWmZwLxA76cx+Fhk/2g9eDGTra0K8U9r
X-Gm-Message-State: AOJu0YyO8NHpJt0D2JC+dctzHH41mHx94GYSGuSk5guihJik7RC4TrO+
	+1RSvGdysrwRJehbf3r9iS73r5RWMkymUnow9NPZvWa7FyMJK+69ZhYlInIRfTB6iLAxilXfdAI
	cKN2Gn0OBTBIptWpl3KNZZKiZlEZ3OZo5IxXZqg==
X-Google-Smtp-Source: AGHT+IFGEmHXL5CwAkBYa70XCoYWKwe8UnjgAcbc2h7iJmpsycDinZVPrwrOVKWCKX5O935DZ/QH6hClp73iSys2pzI=
X-Received: by 2002:a25:8251:0:b0:dc7:4067:9f85 with SMTP id
 d17-20020a258251000000b00dc740679f85mr12766959ybn.58.1713874997608; Tue, 23
 Apr 2024 05:23:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423040243.448091-1-vignesh.raman@collabora.com>
 <20240423040243.448091-4-vignesh.raman@collabora.com> <e3a0ea8f-d306-488c-a69c-aa18078e5e03@igalia.com>
In-Reply-To: <e3a0ea8f-d306-488c-a69c-aa18078e5e03@igalia.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 23 Apr 2024 15:23:06 +0300
Message-ID: <CAA8EJppaaitcXkXSFTB4-S2CbBcrAVHouB0wWiU5Nw2FvpagqA@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] drm/ci: uprev IGT and generate testlist from build
To: =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: Vignesh Raman <vignesh.raman@collabora.com>, dri-devel@lists.freedesktop.org, 
	daniels@collabora.com, helen.koike@collabora.com, airlied@gmail.com, 
	daniel@ffwll.ch, robdclark@gmail.com, david.heidelberg@collabora.com, 
	guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com, 
	linux-mediatek@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, amd-gfx@lists.freedesktop.org, 
	linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 23 Apr 2024 at 13:24, Ma=C3=ADra Canal <mcanal@igalia.com> wrote:
>
> On 4/23/24 01:02, Vignesh Raman wrote:
> > Uprev IGT to the latest version and stop vendoring the
> > testlist into the kernel. Instead, use the testlist from
> > the IGT build to ensure we do not miss renamed or newly
> > added tests.
>
> Nitpick: wouldn't it be better to (1) stop vendoring the
> testlist into the kernel in one patch and then (2) uprev
> IGT to the latest version? I feel that this patch is changing
> a lot of different stuff.

Definitely. Otherwise it's hard to understand whether a change to
fails/flakes is caused by the uprev or by the testlist change. E.g. in
several cases the list of failing subtests seems to be replaced with
the test itself.

>
> Best Regards,
> - Ma=C3=ADra
>
> >
> > Skip kms tests for panfrost driver since it is not a kms
> > driver and skip driver-specific tests. Update xfails with
> > the latest testlist.
> >
> > Increase the timoout of i915 jobs to 2h30m since some jobs
> > takes more than 2 hours to complete.
> >
> > Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> > ---


--=20
With best wishes
Dmitry

