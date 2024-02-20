Return-Path: <linux-kernel+bounces-72579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1822485B57F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A6D61C215C0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9925D470;
	Tue, 20 Feb 2024 08:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eziz/zho"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5EF5D46C
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 08:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708418339; cv=none; b=Ll0w/JRkVTgOB0tWTAWsarmYOZ4xRZ8+PopxOddb/WYtcE/m3o/4iijNZ3ZadcshNqL+CqBM07juzsfd5BgvR5QIJA4igFo7eYTDgceTrXp5R4+TMMSHyhbx2I4rj6ucZN6Xmr6VuWjgWf0aq1/cPbX9jPdLP0kR4jl3mCR0Clc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708418339; c=relaxed/simple;
	bh=xaQQvYpzmBVHnCracW1/zWSt6cgfuwxk6XJIuCevoKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q/9dZNDIR/plSHEmLr2suwhqGfIDDjN75Id20bmGT7ALYYrQQGS6KDowXN4nTCdMaytTZhp9uiIf05OEoOZq5zWJd4GCoowWRkaZl7GnSF40QeXU6esNjlR/uUa/e+1ohZEDGPxM2muKDHyp4FPSXFGxs2aFFQKXUluxA9S1xRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eziz/zho; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-607e707a7f1so49657037b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 00:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708418335; x=1709023135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xaQQvYpzmBVHnCracW1/zWSt6cgfuwxk6XJIuCevoKo=;
        b=eziz/zhouO07dAp2r1xXi+RG/aEiEh8pdV+07MwbXl4BWTattvvPJe3YohtHQOPnl8
         823bE3VxU3wFxlKF/RWMqO3uVxT6elzrXUd3ZGX64Od7GdzPv+mh3H8EzHoJGvGAxwBA
         X4z47iX5AOYnh0HtJ/b9Am1qQlI/RTarO3hVxdCySD6/RJZR+7+J+RodCC35wNkpm+zD
         XbfdQpljkO6+zTtB+QdiMo2MdqydrDapLBNmMYDUk97BfI0RJjwZHem0QHSVBOWXXvZR
         CUD2olAhdfh9r/8wtfaH3XJsZt3vIT/4xl3TJLJNUxd9dy/cIhf++kKfiBpYIAJzbWxv
         Cwcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708418335; x=1709023135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xaQQvYpzmBVHnCracW1/zWSt6cgfuwxk6XJIuCevoKo=;
        b=swEr0PipDI5Se4pmS3ym4kTXLQlHk2rhn/l9weEOT05OtpLoafSwdfs5dX4qjdm0I/
         5xf1HFRNYZks4rYGOAPBdMXKG9q5kVyX+XIzafhVqMTtrSJ56Yd33AEr+dXizzBrxVMJ
         QsWPlo0kMiOBNp9N3xkNlOvBg2iLbgNC/QEyeq56YT2ada+zCvjGa/nPhRKRJo94aFcY
         CRv65SAe66uQr2H8a0F/mETICOp0exoYdDYwcyTablkD6S/UHrbdSzVMJAFiL0NvHm8b
         Zkd5EI3lkU8KLqSBLJI1em59rRf2e16QG1CPdv9f6W8HIvgjP0Zh/Zs1SpFLhfdTxzRq
         FYxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUClCOXRu4oXUUNUnum4GHI/Nz2c4HhAr4UHpXnYXtNa2fMxPgBQRhN3ndluTDXjDE5dV1Yr4IojsgauyXfEj3La2rfhHVGK96kGG0A
X-Gm-Message-State: AOJu0YwnkPeUgijmVpRRucn/njMiawykVpeQJz9vmN1NlBvOugptOBPv
	7FeZU4GqKR2BHlXLk/T51YZ4AGg6DCkIlQVu0yvBolHRZ3utWwGb0l7cYMFGHtEo9TViHxrtSeE
	3hswsgxI0E94+PUj9n072x48kuvA+fr+HM2V+8g==
X-Google-Smtp-Source: AGHT+IENmsrAW3hNZ65FtN4Wch6Ui7UqnKl8CYVsXo+LBVt7opEcneA5tQP/7szbzlwQuVHBwtF33xDyl73OiskgVQo=
X-Received: by 2002:a25:83c4:0:b0:dcd:59e4:620c with SMTP id
 v4-20020a2583c4000000b00dcd59e4620cmr12705446ybm.49.1708418335046; Tue, 20
 Feb 2024 00:38:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220045230.2852640-1-swboyd@chromium.org>
In-Reply-To: <20240220045230.2852640-1-swboyd@chromium.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 20 Feb 2024 09:38:43 +0100
Message-ID: <CACRpkdY0DE-XxPO3vj34zmMvGj-sfGrjkkwGLuCKFdj=ksMJAA@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: Add ChromeOS EC GPIO driver
To: Stephen Boyd <swboyd@chromium.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, linux-kernel@vger.kernel.org, patches@lists.linux.dev, 
	devicetree@vger.kernel.org, chrome-platform@lists.linux.dev, 
	Douglas Anderson <dianders@chromium.org>, Pin-yen Lin <treapking@chromium.org>, 
	linux-gpio@vger.kernel.org, Lee Jones <lee@kernel.org>, 
	Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 5:52=E2=80=AFAM Stephen Boyd <swboyd@chromium.org> =
wrote:

> The ChromeOS embedded controller (EC) supports setting the state of
> GPIOs when the system is unlocked, and getting the state of GPIOs in all
> cases. The GPIOs are on the EC itself, so the EC acts similar to a GPIO
> expander. Add a driver to get and set the GPIOs on the EC through the
> host command interface.
>
> Cc: Lee Jones <lee@kernel.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Bartosz Golaszewski <brgl@bgdev.pl>
> Cc: Benson Leung <bleung@chromium.org>
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: <linux-gpio@vger.kernel.org>
> Cc: <chrome-platform@lists.linux.dev>
> Cc: Pin-yen Lin <treapking@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

This looks good to me!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

