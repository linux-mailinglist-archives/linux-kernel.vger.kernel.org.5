Return-Path: <linux-kernel+bounces-118218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D210888B63A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 01:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E3CC2E86C9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 00:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616791B28D;
	Tue, 26 Mar 2024 00:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kM89+gX/"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA8718E1E
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 00:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711413562; cv=none; b=eJELFBmX5YegWoV5OA/p4M4IplPQqa8usMKerw8jqXZzRd88VTjwWPoVrgixSlmN7VLV9DqAZODyX/VlnizU3XnOS9znbWVxi4D+keuhhQ9MUrlAsd8PVI3rUjFwbzAFZzodF1iCfg09Asm1DKbRcCsUvgAO/YzE5QBtxuyhzoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711413562; c=relaxed/simple;
	bh=9gKlpAbqJ9G3tiym20+wEsqTadiIAcUeSc98kxAYpQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n7MtpUOpVOGtOlQ3Gsy7CEbqoBroauACosv2uGOJxKbwELSAc7Xy/0wDSdGpbCXWGY2A2hFj1Tzzkh00zonGY+RWKign8ypZRwGBqr6DpQuY+LBLXad6fERTpERbA/Iw2JIEfTXt5h3Mxl6O1p0ReYaPLsYfTqOVuWVv7y4pLUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kM89+gX/; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-513e6777af4so8941534e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 17:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711413559; x=1712018359; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9gKlpAbqJ9G3tiym20+wEsqTadiIAcUeSc98kxAYpQQ=;
        b=kM89+gX/VtSui1kqQBKTBrZUoovTbaZTrURy53uuyakSyQ3/CpDLl5PuFLliCH7b0O
         OcLcjvsWo9Ol2CdWoCyzE4NzJek7THhksHcsltjO5+UFb9R05hzvOT+2xMfH6DDKwJWj
         Jufo4xsDt6PKzv5FP1DNKs/Y5g72U6FXAt9CY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711413559; x=1712018359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9gKlpAbqJ9G3tiym20+wEsqTadiIAcUeSc98kxAYpQQ=;
        b=LAgMGo2nGDCJCO2wcjbAjPFwMBYKBBBhJZ0PHDbExM3blqH+YCW+ocze7hO0/nFHLv
         VwMGngJVwCk2zcYK4WQCNm8EOXD/G2ubVj0I/TE7FSz/0OR6212Gsb+xMyLa91fO78KF
         WzINdkpN/ENF5oaC2z08jUxAMJM7uwNKqTw/rlpBF0tfFlaqDC82aCFQvmAJ9W1rYoDk
         hARK0jQeekv0MYQ59YXqsUZ5edSeUzkPHavPxGkqUH62oMnV/IALyjO4K2B6ptYqHU0F
         aIIij2rbCs25Y2svNQ69BZtd0DaQBUp26h3AG81V84NZ+J0dOOSdE4dS/txt4FSIJ4Hm
         V4ig==
X-Forwarded-Encrypted: i=1; AJvYcCUcEokfVzCuKUmOk86hp5VUM5Br4zQEvjsq9ZwkN3jUTlme5ZNomMeH2HGOrk+qbNq8uYi1H80eerczLlY18Dm6x8WGNi+574mKX1OJ
X-Gm-Message-State: AOJu0Yyc6asOOQi+iojJNvrRwggDb1p+PYGfSogJZmzDV0QBfQlNmRnZ
	bIic1AzsgsNwUPFCreXV5NaeA0lWmPf1twMtY9qp8kyFVHYCmvepMtChWsZclsalhDVnEA6WdFe
	0dQ==
X-Google-Smtp-Source: AGHT+IEs0VESDTb4rmAMxbsFb0zMAWDuK6DRgWmBcnqGmbGai731veq9O4F1m8iLz1cVbRckPWY1Bw==
X-Received: by 2002:a05:6512:443:b0:513:d976:496a with SMTP id y3-20020a056512044300b00513d976496amr5874665lfk.50.1711413559004;
        Mon, 25 Mar 2024 17:39:19 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id c27-20020a170906171b00b00a44936527b5sm3601906eje.99.2024.03.25.17.39.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 17:39:17 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-341cce3e5f0so1519656f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 17:39:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXsXUNf2beHULcnF0rpXzjLvfY4WGVK50vnNK66E7gz8zzPBVvkXrgrndfshYLDr0yl6I2rB+AJqF6c/3riin5TJHjm4tnkDvZ2uJu/
X-Received: by 2002:adf:e045:0:b0:33e:db44:9a5b with SMTP id
 w5-20020adfe045000000b0033edb449a5bmr6963918wrh.14.1711413556919; Mon, 25 Mar
 2024 17:39:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322102800.1322022-1-s.horvath@outlook.com.au>
 <SY4P282MB3063D447DA09D35F5FBD4721C5312@SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM>
 <CA+ASDXM9=0jQA=MWpBOttUT7k67wmEDFGoOObQfYm=ca_HL8GQ@mail.gmail.com> <SY4P282MB3063048C537120C8D3477774C5352@SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM>
In-Reply-To: <SY4P282MB3063048C537120C8D3477774C5352@SY4P282MB3063.AUSP282.PROD.OUTLOOK.COM>
From: Brian Norris <briannorris@chromium.org>
Date: Mon, 25 Mar 2024 17:39:02 -0700
X-Gmail-Original-Message-ID: <CA+ASDXOj71wn1D1fxcScoLFpMFCN+-1UU9a7j=6FurVDsp4nug@mail.gmail.com>
Message-ID: <CA+ASDXOj71wn1D1fxcScoLFpMFCN+-1UU9a7j=6FurVDsp4nug@mail.gmail.com>
Subject: Re: [PATCH 2/2] platform/chrome: cros_kbd_led_backlight: Remove
 obsolete commands (EC_CMD_PWM_*_KEYBOARD_BACKLIGHT)
To: Stephen Horvath <s.horvath@outlook.com.au>
Cc: Lee Jones <lee@kernel.org>, Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 5:30=E2=80=AFPM Stephen Horvath
<s.horvath@outlook.com.au> wrote:
> my laptop seems to support both so I'll agree
> the older commands are probably the safer option.

Huh, it's surprising to me that it supports both, if one was marked
obsolete. But I haven't tracked the development in the EC firmware
that closely recently.

If the old command works, it's probably safe to keep using it. But
it's possible we'll eventually see some device with firmware that
doesn't support the old one, and we'll have to update the kernel
drivers for both. Note that there's an existing driver for the newer
generic PWM command protocol:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dri=
vers/pwm/pwm-cros-ec.c?h=3Dv6.8

So far, it's only been used on Device Tree systems as far as I can
tell, and one would probably have to wire it up differently for an
ACPI system. I just mention it as an FYI.

Brian

