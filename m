Return-Path: <linux-kernel+bounces-134749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A9D89B657
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 05:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2D0FB21F3B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 03:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA6D2913;
	Mon,  8 Apr 2024 03:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K11QaQIn"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6864E186A
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 03:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712546313; cv=none; b=pyKHTvKq5ZB4WRdm0nUFiAYK/LzIG9rve5reP33nPq2eJkEdm+NB76AvzgjTFPPWrZuEBcXZQna8ZqThqyIoNHvyB6HBXDpZ8Z3sQ/yR0LzgycFegMoFCcxIgjE6HbqGWyENQHXzg3XfCuXuoY2gseKk3IbdD6ILZfFU+e5HA1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712546313; c=relaxed/simple;
	bh=3ilci9gMyUWIKqfJPT0Xi9ZjjLNpXg7E1hfBAMC+znI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HcIXtlfHgn34e34nu0FkJB/eoCu+MOATAyzBiTOJq4e4iBH/SXKXnK2P3oJHokVPrG1ZnjcRndj5i8bu118Rvao7Ys27Oivq5LZM2usPJbrCvypaHMN7PIG8B8AUFEt/DFSRHla03gMmS6ZBnoESbLlCF2LIPQ/JT3WNAVyp4Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=K11QaQIn; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-78d575054c8so85867385a.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 20:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712546307; x=1713151107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LyQ3gqC4n7s5e/dZCBWNeKChUckyBUUi1w62B96nUuQ=;
        b=K11QaQIn3ldF3cN918Usz24I0uObiEJ2G1r9jfOgkLIrY+GJmjFl9gQo64voX5xOOi
         6liejsybsNHwOMt+3DJohzSHMnaSHF+2fRpbSGNh7mGqMKVtgLgA1t5N1FBS9PQtlLUR
         TeopixYw46L+W2Xty7JGLfQ+d6NHcQNAOaj7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712546307; x=1713151107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LyQ3gqC4n7s5e/dZCBWNeKChUckyBUUi1w62B96nUuQ=;
        b=n6ZkoTMqVF3Ss5pJMR0QyqwDvzd9eE66AGv2C/FtAGe+glUvIVFNhTwiiVl2+vWnjF
         YZL7/WhZB3+lON6jOaGoi4DntoOG5alOrDLoHVViRA4eYA5n2uYM2MWOcvGAJM2ei7kb
         qbe0+wLZhXA3On9gbUOBwjMrrwsCQO1rwCIInBcWDQckDGYW88PsFkMAZtYWtMuM0TNN
         C05e/PVuTUUuGo9fNP4x+82RGem8Mnt1TXLvlOHlhLVAWh9uazLsoh0YfNdvIDSfNfKH
         yyM29yb6Jw82MCJ+frOLNRruWwOvhIPVFzL/qUJUrwM37BJsfnTdnEV6qt3Q364Mwvj9
         9x9A==
X-Forwarded-Encrypted: i=1; AJvYcCWRFoQ9vy13px/6v0j8iwID2sFAV/1NOeDicOEksi0N7KXfkKWJXHsp9ot1mdlEUzZJfKoVy2TQ/j2XY7zumU1d7/yzH3s2CUhbWdkT
X-Gm-Message-State: AOJu0YwbxY0mXUQHS61Z/RRrU2uOjkIpY0nYoAbHzj0RwRRBnHGtZd31
	aKDoboIQ48kvwaeC8ZLs+6qLVzzsvTusp1n5v8LosfPQSkXjRrB02DIgK70qCJfpztzMUsqDg5E
	heA==
X-Google-Smtp-Source: AGHT+IHgEFG+KLgj7bFBmMjHqt/WcgjjXHoF8Vf/1bNEXPC4OvfdO75ipScnLgikEhEQLjhtRKmCIw==
X-Received: by 2002:a05:620a:4511:b0:78d:4404:2424 with SMTP id t17-20020a05620a451100b0078d44042424mr10050947qkp.59.1712546307306;
        Sun, 07 Apr 2024 20:18:27 -0700 (PDT)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com. [209.85.160.180])
        by smtp.gmail.com with ESMTPSA id h20-20020a05620a10b400b0078d60973a51sm1375602qkk.75.2024.04.07.20.18.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Apr 2024 20:18:26 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-42ee0c326e8so318381cf.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 20:18:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVRztz5nh0eWi9Nxpyi6feFUorHHLRNiKCOmxok/mURLEYMUFgaGhPJOkKJD3Y5GSnasPA4FJQRTLopWepgyRJzFqHy3RGavw3zusxR
X-Received: by 2002:ac8:7cba:0:b0:434:77b8:1ce4 with SMTP id
 z26-20020ac87cba000000b0043477b81ce4mr154092qtv.0.1712546305996; Sun, 07 Apr
 2024 20:18:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405102436.3479210-1-lma@chromium.org>
In-Reply-To: <20240405102436.3479210-1-lma@chromium.org>
From: Doug Anderson <dianders@chromium.org>
Date: Sun, 7 Apr 2024 20:18:10 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U4kLZMSViOMcUaXEJd8E2avb7wiBx=Y=Uad+04Q5LHXw@mail.gmail.com>
Message-ID: <CAD=FV=U4kLZMSViOMcUaXEJd8E2avb7wiBx=Y=Uad+04Q5LHXw@mail.gmail.com>
Subject: Re: [PATCH v2] HID: i2c-hid: wait for i2c touchpad deep-sleep to
 power-up transition
To: Lukasz Majczak <lma@chromium.org>
Cc: Jiri Kosina <jikos@kernel.org>, Dmitry Torokhov <dtor@chromium.org>, 
	Benjamin Tissoires <benjamin.tissoires@redhat.com>, Hans de Goede <hdegoede@redhat.com>, 
	Maxime Ripard <mripard@kernel.org>, Kai-Heng Feng <kai.heng.feng@canonical.com>, 
	Johan Hovold <johan+linaro@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Radoslaw Biernacki <rad@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Apr 5, 2024 at 3:24=E2=80=AFAM Lukasz Majczak <lma@chromium.org> wr=
ote:
>
> This patch extends the early bailout for probing procedure introduced in
> commit b3a81b6c4fc6 ("HID: i2c-hid: check if device is there before
> really probing"), in order to cover devices
> based on STM microcontrollers. For touchpads based on STM uC,
> the probe sequence needs to take into account the increased response time
> for i2c transaction if the device already entered a deep power state.
> STM specify the wakeup time as 400us between positive strobe of
> the clock line. Deep sleep is controlled by Touchpad FW,
> though some devices enter it pretty early to conserve power
> in case of lack of activity on the i2c bus.
> Failing to follow this requirement will result in touchpad device not bei=
ng
> detected due initial transaction being dropped by STM i2c slave controlle=
r.
> By adding additional try, first transaction will wake up the touchpad
> STM controller, and the second will produce proper detection response.
>
> v1->v2:
> * Updated commit message with short sha of a base commit and proper tags
> * Rearranged while loop to perform check only once
> * Loosened sleeping range
>
> Co-developed-by: Radoslaw Biernacki <rad@chromium.org>
> Signed-off-by: Radoslaw Biernacki <rad@chromium.org>
> Signed-off-by: Lukasz Majczak <lma@chromium.org>
> ---
>  drivers/hid/i2c-hid/i2c-hid-core.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)

As per my review comments in response to your v1 [1], this seems
reasonable to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

[1] https://lore.kernel.org/r/20240325105452.529921-1-lma@chromium.org

