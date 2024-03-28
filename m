Return-Path: <linux-kernel+bounces-122709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A9188FBE4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA4971F2AAAC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4F6657CB;
	Thu, 28 Mar 2024 09:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ydN9hIpm"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B496657B5
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 09:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711619000; cv=none; b=ZUNqJiXTUZGc+Jw3IhdS+8hP5U67PkdT7fn59pHPLw6vW3TdpUgiDGmJoVS3c5mTcVau1I/fF2c+BVLjJDveOhzyq8dnDpuZ4qqIOR/DhLZC0PAhxwa7y0kYcwkb47UAwXZTVu9PPeucoGrDPH1SfJFBmVP+Kl1YBA20rWC1Oxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711619000; c=relaxed/simple;
	bh=2bC4RkEx+VkqZ7aTbIqI3D4kCHyp83VRJ0WWVsVi87U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iuvKO6JbZmCJecdpz8L4UyQisGqqeFE31X2e+JG2CZe/1+0EdGZZXz9T+sWhg5VKdVZ9bMXVLa9L/XLH7vpht25YPjTekLthwIxbRATvYhcXNIh6BjdGYbQUFa7qVc960JAFYNa8Tx0xw4DwXlr9mtflWPOT85ZKA44eUdMxD+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ydN9hIpm; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-609f4155b76so7853917b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 02:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711618997; x=1712223797; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2bC4RkEx+VkqZ7aTbIqI3D4kCHyp83VRJ0WWVsVi87U=;
        b=ydN9hIpmcogzKvl5hikYQtlK69+8rKQr5lag4xz9Z/ibEB6b8wITlrw4WchT/O6Ntj
         qUGx02EKx5nrJQ39V8e4nylcpJCPVnwhQnds7vxwDw02zirYN/Vwgg3r+9PyySuHeUlB
         XRbeGEPNEfuaaXCyaYXo2NeaPLbcNEtNb/Qlzim0aD3Dr5zqn/1He3vTGqHhaTV4FLPb
         +kKvxSOg5a9voknmbX89j4PE81vqYPtqx2oA+IcqHLqSo6CskMC/Wjx1XtQty1DQIEpU
         YRfunZGPqOPAn3pXid0J0NfcyBqDpK2E+OfjZYr9zu2odV1cw5Zrb+rORROCcGpyojmW
         gWBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711618997; x=1712223797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2bC4RkEx+VkqZ7aTbIqI3D4kCHyp83VRJ0WWVsVi87U=;
        b=PzPyLueDNYdHuv8G0s8y+8bWF1RetW58d864qrlFmQFmUk9qqfWwoO0Xt8Eh+wg+/m
         QHBRjpdezNsKeCo1AnMUOM76M3JfGmYaETD2IhH5N56YMdObLsxEs4kOOh68c/QyhXYE
         gh80iPIzoay/hSUD7CKn4CvFTjknDP5dFLDAoUIFKGuKngdXfuNLTQJy+awr42zMV6P8
         E7A38ZLkCNEYaKXfo9lmjriRna3qWFqQv1kHyY49u5SHJR3W/fo0S4L9s42+FOxK2CUF
         a+xixC/bme8mVZ4sl22TI0LsaOy34z+qA2SoztAP4XSq6w6hSWc8RUNGTDuxh0pJPmt5
         nidw==
X-Forwarded-Encrypted: i=1; AJvYcCWcaP4qA59r+ZkOCYGRPtcvJ24wvJZxcEEDvnZ0j9hp/arrqk31g/ozSjxMgDyRjwO2LNt1cqRLkGWYDv3Pw6PUM9EnveXN4G4TVA/I
X-Gm-Message-State: AOJu0YxtkImP28BBawjXyJA3tVlT0aSIFMd6H3Rq1Wg1U1aGWbokNTzx
	gzNMJfGfQFAFF95DD1fqo+XDdqSbVAFhidDSYPm6h+d++d1/ktgpUOAq2cBtJ7nPN3NffFS/PNT
	55Wdp/JjElLFxlRhbVG/Bdgk3HIvKVem5v1s6VA==
X-Google-Smtp-Source: AGHT+IGIBgCifC94WWbmk1WL90a5JSXQTsvL9yU0DsuBNrPusLMZEBcn0E7fKCz4fiSDpZHvOK565KZ6ERPKVg6UNMQ=
X-Received: by 2002:a25:b9c3:0:b0:dcc:4b44:3377 with SMTP id
 y3-20020a25b9c3000000b00dcc4b443377mr2227810ybj.25.1711618997667; Thu, 28 Mar
 2024 02:43:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325113058.248022-1-jan.dakinevich@salutedevices.com>
In-Reply-To: <20240325113058.248022-1-jan.dakinevich@salutedevices.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 28 Mar 2024 10:43:07 +0100
Message-ID: <CACRpkdZPVTZvjbQ19vjPWVvdW35DO2U-CgVi3r1q9jJA0OupJQ@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl/meson: fix typo in PDM's pin name
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 12:32=E2=80=AFPM Jan Dakinevich
<jan.dakinevich@salutedevices.com> wrote:

> Other pins have _a or _x suffix, but this one doesn't have any. Most
> likely this is a typo.
>
> Fixes: dabad1ff8561 ("pinctrl: meson: add pinctrl driver support for Meso=
n-A1 SoC")
> Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>

Patch applied for fixes!

Yours,
Linus Walleij

