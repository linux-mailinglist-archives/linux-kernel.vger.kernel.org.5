Return-Path: <linux-kernel+bounces-136706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDD589D749
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC3DE1F24F5E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5543983A08;
	Tue,  9 Apr 2024 10:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RWt+Yv/F"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AAE81725
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 10:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712660037; cv=none; b=Wyn7cCR5vwI9yGklMgxShKiEROi7El0jr3CLmVCBMp9oNzXi39nJiExJzInKPBYNGN7WQgbXUje12/XnQsx82I+O3fLRgZEbRA8HqoL9yUrssVQNHSc2vesux0BcEaR1x3PQF0uVXB7a2b/OsDaMns+hMzV1V9HTQ4oh1WGkuf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712660037; c=relaxed/simple;
	bh=d9SLtzD51uda5U7BOlp7uyL+uUypQJx04HhbXDep8Hg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HJp56bnMXvJviBdhuyhpi1UzPlsiS2kSrwJPSCiTqdZxKQteR4IFZ0iawD5ds3vFZlug/k6FBkAsQ5XlsyGWtvRUv+E/eNacP82bidng+9ZxRiQe8yDBuOyaSjIFc1KEbin/I3NJx3Y2KC/k7r+zxBCH75HFrh7tm6+U+H3Vz98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RWt+Yv/F; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d87660d5c9so31139881fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 03:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712660034; x=1713264834; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d9SLtzD51uda5U7BOlp7uyL+uUypQJx04HhbXDep8Hg=;
        b=RWt+Yv/Fxj+ZWLQC+WOj+QgMKzq4mRVGRqw0/4FVaBHH+LxsqQYsbRLeiB29ZdI8F9
         NGvxzHHqaynfid/ubi8TARqqflvGkmZBxn7oIa2sWg050HRQ1YFssNFI76OVc9W/D1c0
         H407Zv6y2glJxKwkBgJHFsdPtDsRbtEkfIgJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712660034; x=1713264834;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d9SLtzD51uda5U7BOlp7uyL+uUypQJx04HhbXDep8Hg=;
        b=vJRTxQtS3lvMaRgWfnSi7k0svLj2rJr9QrLZ9HTlhQd7fGzop12lxIHhTsxiFMO4H6
         l5ykvb0fOZmK5hGPhjyRRE1M6b8FM1SVcK59cch+5XmW/rok283+Fw2TN+nbW7xE6Mcx
         6HcYy1/QY18HNipCfVsk9GiRvwFa/uNL2Tpe57NtV3LROZ8q7KmKN0a9IteWqr3TvdZp
         vot3v7lT1cLLBEiZIxhqGDU/S8j5K1ElTbEFLUoX9ClaHVqp64x5TSUVp1Gl1CDWmwkY
         QD0AMtXGgL1/aSr2kWYzcIZeqf9ARjzrlQmcHxcTc9m38chYeWeYk+mVPpugWlotG6Hr
         hulw==
X-Forwarded-Encrypted: i=1; AJvYcCVu/SzynGTxZkHKSJC91Y6qqTLvTJlli9lNGercROyaD1ex7BoZKpknuUP1gajCY54y0pzvIdrePcURYnFVJXHvE920UIP23IHUaEwu
X-Gm-Message-State: AOJu0YwYpycJOhBzVhjq6U7uDcsj3qb1h4max3OQzHl7/Prn3+JZGjAt
	TWqAGrwqJLp0MGSpkrSgp6V9ieaMBmRu4rCnGHCAx8YwmVZ79xvcCoeBNmTwBafJJPNAOMuXWGL
	3ezLEUIDVB3mbzSBeBy4styxcfAgQY/7ZQr6r
X-Google-Smtp-Source: AGHT+IHEYeRTYFZMvp3NAjb5ImFPXtsX11vnH7B/nWxeaBYxhT1sMC34qXfKvJt+NykMNkOF2q/ZE6fmykGLoAhsU/g=
X-Received: by 2002:a2e:9d07:0:b0:2d8:8b9e:8e9b with SMTP id
 t7-20020a2e9d07000000b002d88b9e8e9bmr4336666lji.11.1712660034170; Tue, 09 Apr
 2024 03:53:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405102436.3479210-1-lma@chromium.org> <ZhOccGFkTFkUkRUI@hovoldconsulting.com>
In-Reply-To: <ZhOccGFkTFkUkRUI@hovoldconsulting.com>
From: =?UTF-8?Q?=C5=81ukasz_Majczak?= <lma@chromium.org>
Date: Tue, 9 Apr 2024 12:53:43 +0200
Message-ID: <CAE5UKNqufWZfKLAXLcpBYKQpJEVt6jPD4Xtr=Nesh34VkNOETg@mail.gmail.com>
Subject: Re: [PATCH v2] HID: i2c-hid: wait for i2c touchpad deep-sleep to
 power-up transition
To: Johan Hovold <johan@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, Dmitry Torokhov <dtor@chromium.org>, 
	Benjamin Tissoires <benjamin.tissoires@redhat.com>, Douglas Anderson <dianders@chromium.org>, 
	Hans de Goede <hdegoede@redhat.com>, Maxime Ripard <mripard@kernel.org>, 
	Kai-Heng Feng <kai.heng.feng@canonical.com>, Johan Hovold <johan+linaro@kernel.org>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Radoslaw Biernacki <rad@chromium.org>
Content-Type: text/plain; charset="UTF-8"

Hi Johan,
>
> Can you please explain why this would not a problem for all future
> transactions as well?
>
> If it is, then it sounds like this needs to be addressed in the i2c
> driver. If not, then perhaps the problem is really that you just need a
> delay after enabling the power supplies?
>

The problem is that the probe function calling i2c_smbus_read_byte()
is not aware that
uC on the other end is in a deep sleep state so the first read will
fail and so the whole probe.

In a normal scenario, when a user touches the touchpad (when it is in
a deep sleep), the touch will first wake up the uC and
then generate an interrupt to AP, so in this case the touchpad is
fully awake and operational.

> Nit: move above the 'ret' declaration to maintain reverse xmas style
> ordering.
>
> Johan

Will do so.

Kind regards,
Lukasz

