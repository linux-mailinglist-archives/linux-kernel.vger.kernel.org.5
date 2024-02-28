Return-Path: <linux-kernel+bounces-85659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E93786B8D1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 21:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F1371F2A928
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D169C5E09B;
	Wed, 28 Feb 2024 20:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQFZqyWS"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72D15E07B;
	Wed, 28 Feb 2024 20:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709150709; cv=none; b=jfQi1n01sYNMf1lgjNQlcFXdS06g+cOoWVFv9PAM0boZZLzLfdVfwgvvcLFV7DWSw//n8vhNopWxlffpAUrzZ+WKPI0TJ1PsuM1pjNoDnhHs56NrVjsJ/zs40DmUOOkQAts15eUIcDIogH0OaDt9zSD1koaDjql2g/v3qsxLaUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709150709; c=relaxed/simple;
	bh=ts6LE4uaweEwgylH9vL9YuaXUhDNctkwvZFo82XQiT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nWvyDfmKZHmgrnMk2Am9QeehIkclr3cpQ23jqrjhveJUzE5EGEp5FFVa2+PWPwFUl+gFBLPwt2hwn0PIykqRcdhUl9ti14Hqc0w3vgfirPSVlX3NPc7zZUpfShUt4GPiXsBFxFHUhZz5LoEJC3p3GTVwFLiyAC/TLZszaW6Y1qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QQFZqyWS; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5d862e8b163so28924a12.1;
        Wed, 28 Feb 2024 12:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709150707; x=1709755507; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0knxogonTr/yjT6gx+hi9WmMThRVPOwQow3XCFImyS4=;
        b=QQFZqyWStBBvmRLtcbHyhbl6NX2u5jRk92+FAOHNSbiz4jwxxTEp0NelofKMzYUdVd
         mFfmX+HomMFxVqG6MY+VTA/nwIpfPxHG9mB/Sw1l1pSmitKisJllocBqRf+a/HXOqbnE
         Q/X3ELzP8tsBSdSRqgx4VGPCAOK9ISeE1T90r516eVqs531NqUsvhTw1Xh9/vreuIKQX
         YGB20u+RUzhUXXXF57GU3hmOyrM/2T68TGT4Xp9FvSxHjATVtjhtOjRGqus80nZWa9UY
         NNgfmq27ynRhi72hL2vjuJsD+PrLOA0ArU0F30wTbhcr3QfZ2Fg2GI25jA9JuG+O3xfs
         b63A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709150707; x=1709755507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0knxogonTr/yjT6gx+hi9WmMThRVPOwQow3XCFImyS4=;
        b=ZM71R4XK3XVQG6wiFXjqitfJdQDrZfEe4l5qqh88yz3obx8xgxgB3Od7yURGfQJqho
         tdVArtFIMuFbD8l+IhHJ64LPX5Xw5b6QWxHVTiRRYzrjFTn6ao+LDBZc+d6p0RlG6kpp
         N+MznB6zhReZtP0YTujQis8zU7YdN9/DKDJNLW1G5ufBb1EfgkX/IJiN14huIAbOryow
         l0m6UPYyOn3/1IQ6zbdBGQ/OQVvpGjYk03PH3L9IKuGgON/ieAWQPBcD4gbxrAPhZlqg
         /6bYkFcbzSgjx8T4Q/fVZvAG6f6CA938ZcCv+0/6Asl7X52Yi1PzBgp8+wHsCleAQ7n7
         /Xig==
X-Forwarded-Encrypted: i=1; AJvYcCXP/y7zlU5cQX0y4ULgb3E85oNZ2QbSIovJ4FdBuvM9q25TAMjaOtGwYB7/isuZbz6koXSLXBnmxWp/4u2WFNHSDthdxSPgAiU5efxu70fRU2kVpKX+r8zlm4bIZmtvKkViKFpda5TzAA==
X-Gm-Message-State: AOJu0Yzi3MkQhiqxur7UzTMc8XGn/dvoO2xUcUHFX4knn6R8ZPxo9N2B
	sSEERO+YeeRa4MIsDuACyxIRI0WWoXXw5VpeI5KlQikCJXxARIo3UgZL3W4Zoemruut5P5K+q2x
	XQIG10ATdRsRSbiYeEIF2qLsJoYU=
X-Google-Smtp-Source: AGHT+IGWaOuOj00eCLL+e0fMOr+0DQVFTXBPG2HVJ3olnvHFs3MNtqF8A6JwL+hnJK/4saJva8Xzl5TOrwJQA1cwj+0=
X-Received: by 2002:a05:6a20:1602:b0:1a0:57d2:1f96 with SMTP id
 l2-20020a056a20160200b001a057d21f96mr366436pzj.0.1709150707203; Wed, 28 Feb
 2024 12:05:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228-m4_lpuart-v1-0-9e6947be15e7@nxp.com> <20240228-m4_lpuart-v1-4-9e6947be15e7@nxp.com>
In-Reply-To: <20240228-m4_lpuart-v1-4-9e6947be15e7@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 28 Feb 2024 17:04:54 -0300
Message-ID: <CAOMZO5A0iNpU702DBEyPgkHyOR6M-xDkw9SQTxiFQK65Af79yw@mail.gmail.com>
Subject: Re: [PATCH 4/4] dts: arm64: imx8dxl-evk: add lpuart1 and cm40 uart
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 4:55=E2=80=AFPM Frank Li <Frank.Li@nxp.com> wrote:

> +       modem_reset: modem-reset {
> +               compatible =3D "gpio-reset";

I don't see this compatible documented.

> +               reset-gpios =3D <&pca6416_2 0 GPIO_ACTIVE_LOW>;
> +               reset-delay-us =3D <2000>;
> +               reset-post-delay-ms =3D <40>;
> +               #reset-cells =3D <0>;
> +       };
> +
> +       m2_uart1_sel: fixedregulator@101 {

Why is this @101 here? You should remove it.

Passing a unit address without a corresponding reg entry triggers a
dt-schema warning.

We want less warnings dt-schema warnings, not more :-)

