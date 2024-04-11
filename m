Return-Path: <linux-kernel+bounces-140636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1548A1714
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88EE02818A0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED52E14E2EF;
	Thu, 11 Apr 2024 14:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZIaEiIWe"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79C314D6FC
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 14:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712845422; cv=none; b=Vjqy2RGu+ds/h2KwdTu9ofoCY1YFYGSGaAWRH6oi2Pw0G/CzsTZxmvteJrrl0+W8nPxQ6ZkFTWNWypEupXVqxscrG22X1bh8gc2tGOCTVuMRSy9IaaqS1PSmRC3k6pVQV1G+uX4E2qpnv6LyjMhHz3oQ/0inxWUk+INxxHxu9B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712845422; c=relaxed/simple;
	bh=LUtbADJQAYJxj/Ogfyr9IscI3lkrbxOS5D0BwfwnczY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r1Rzj8y4G6bfAMWNFzylb+L2YaHnUtspvCMWbrkbSKahBITS2w8PRqlQhMvEkrVio4Vtw67lDcGnb6cWSjDx6LwxZvPIBeKOY+4iYJbXrdgCK2S2bmdyLGBpeLA0e4octC6RtsmygqPrxlZ++0xG4HPZo8yw30yX8XqbAfGZGN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZIaEiIWe; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d8b2389e73so33651051fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 07:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712845419; x=1713450219; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LUtbADJQAYJxj/Ogfyr9IscI3lkrbxOS5D0BwfwnczY=;
        b=ZIaEiIWebG2vtqDM3ZAa8oK7bMvVH5yIqVL1dgs+McEuEgzuiF0D0iFY0WKrWOcSmU
         fq0FhbTHU67nMtnFX2Ix855HUg4nQCA4KtJZc6l5HfrVvjT7q33OKbiHlP0Q6rItep9q
         t7JjgT1Nf/0gTgyUneHkrQiH8gkVnc5Jf+cVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712845419; x=1713450219;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LUtbADJQAYJxj/Ogfyr9IscI3lkrbxOS5D0BwfwnczY=;
        b=cCMEfOtTA1QCODDsQcQ1uty8P6LKXG0ejAxoBOwPIcRdVhz7stvyR3qYjPAOQjEfuA
         wkjikwZPxEIwxINFCXmz48jAy+JPImvxcR4zxFR3QPUMthQkqMpGg49BFa3y8X0j8VB8
         xjcaH6GscB9uEODLfenxfi3h9XcanY7zqPfrma8z1st10VynNweB/ua/Da++aFBWkx4Z
         /CS33+3w2uQPuwlAGlD/BrKcZ5wNJ10aAIJeVDPhDsrNJoaJxP3FMesbNuBMUeekiuak
         ak3oUtq8ImDZ2t2JJLmMovk+KW5qCmNHEkO5TMlC/F0H+7RCy4b4VV9r0eAymCBIZ0kP
         NEDg==
X-Forwarded-Encrypted: i=1; AJvYcCXXXCTFIlZrjE8mdqENk/RyXMpyUhMot7yeDI5TBNw3cjDFlcqWEk5W7WDZhufiM2PN403U9iXbPdDMm/ya5zIE9yRF9K/nFpwUpsBt
X-Gm-Message-State: AOJu0YyGk0CEg98u1vrTinIQAc8DrSwDGgZhn4UQDWjLCywtQg8QlxKj
	uKBcLf35h0jeagAV83E09S0WYjqIpVSuBumcdQZSX9mhDUnnvq6yHGnVYKW7vCt6KUe4kz9T3la
	F/NLTA7/CHcunILrdhp+sYwvxNKWP0KPQLk2k
X-Google-Smtp-Source: AGHT+IFNVcyx8krFZBQPjsFLg9xfCidm6tFM482BIiTiDZp8tHCIzPhuHhKYCeZTeFT6FNZdUnqtE+lVlPb3l1XeNNQ=
X-Received: by 2002:a2e:7d12:0:b0:2d8:7200:38ff with SMTP id
 y18-20020a2e7d12000000b002d8720038ffmr3769523ljc.24.1712845418803; Thu, 11
 Apr 2024 07:23:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405102436.3479210-1-lma@chromium.org> <ZhOccGFkTFkUkRUI@hovoldconsulting.com>
 <CAE5UKNqufWZfKLAXLcpBYKQpJEVt6jPD4Xtr=Nesh34VkNOETg@mail.gmail.com> <ZhVix-HJrqQbiPrB@hovoldconsulting.com>
In-Reply-To: <ZhVix-HJrqQbiPrB@hovoldconsulting.com>
From: =?UTF-8?Q?=C5=81ukasz_Majczak?= <lma@chromium.org>
Date: Thu, 11 Apr 2024 16:23:27 +0200
Message-ID: <CAE5UKNp3uS9cqDbQjcP3SbfxVi3wPFG4LtP6z=WU_V+M9x6LtQ@mail.gmail.com>
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

> Sure, but what about other transactions that are initiated by the host
> (e.g. SET_POWER)?
>
Somehow it is problematic only on reboot and works just fine on
suspend/resume and
set_power.
I will dig more and try to find out what the difference is.

> Perhaps this hack at probe is enough for your use case, but is an
> incomplete hack and at a minimum you'd need to add a comment explaining
> why it is there.
>
You mean a comment in the code ?

Lukasz

