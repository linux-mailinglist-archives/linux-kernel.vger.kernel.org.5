Return-Path: <linux-kernel+bounces-75673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B503085ED38
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 00:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 417E61F2187D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 23:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B074312C549;
	Wed, 21 Feb 2024 23:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C0LPisQ5"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A41812A16B
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 23:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708558908; cv=none; b=FYjzRClScPY0c1XYIpv/DnnNrgrhAH3t04oBBhnDKIXhim5T9QXkIcxPVI7yj+DskfGAuQwdeOrF26Ba1wZguka88SvCPg9m9knNeo0IeLt28HpK3KAXc0WyAkz0jJaw+UixwJ1rXc6/tTlkH1ZFT1dATt93AakS5wknO0kDdnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708558908; c=relaxed/simple;
	bh=9YvOp898aubJjbKRrUpp3NGfhZc4uwca3cNw/pQSCCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fKUb69AHpNzFMRQRcTEYOj1c9RZMa9SZ+gviSF20yUFVf5yDHg4GCesI29EzDmsVU1GEPfSw2ATG9nX5pxzobCXULneqtwPqu6smJKfY9ux7tI2ucrtGdiT1Pwq39FTlmzerYAeCh0er9mTTxxpTUvVel5h87oTS4SCzEI1UXrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C0LPisQ5; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-607cd210962so64435937b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 15:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708558905; x=1709163705; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9YvOp898aubJjbKRrUpp3NGfhZc4uwca3cNw/pQSCCE=;
        b=C0LPisQ5cs0aUZSHutzTZrhKCGvRJYx6GAHbFM8yhqgCh6IHHf27rPvRvbu2wGnY4T
         LWjn+bSp3nzH+pOY8cG0z4GojUYaR2gMtZ3UEZojl/KFclPqmBzZJVMSxRL7bH5pHFDC
         xVXhKl8DQq9vCFnRaic4TPvonDPMr1iz8uSI8vn/+QEEOIGClyqXt7WMQyPWU2lLjNFh
         cZQGg5wL23mcsYd9BrjkNuFW/1ou0G5yWd8i2clTGVloWeyzThhoPoj+vn/IlT942Ly3
         fYmRbsTjT5ZarFMwj5aZ56L4HvBTF4JAc+JEC3u57vv1NwCg6RhNYp6ebHhIGFu4v05g
         ZxWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708558905; x=1709163705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9YvOp898aubJjbKRrUpp3NGfhZc4uwca3cNw/pQSCCE=;
        b=eVaOveWKX4E8VoSYD6DaYBAHatxo0lbYTFPLLkAugtBtWA8GHyW0W4fcbpYcjXeKiG
         h+ZAQ69CjZWcteYdEjdeGOPkszzVOOHiQES0Y6AB99zIj1H/xbvJQ+QXHA26I0ub5atw
         X2CeAPLSQpzeKcEQFKcSpauaVWpE9wrbNaZFULbtHEpyYCChUwAThGBgHORC6wt+es9l
         fBtmzhsTw1JW+4iPJWPX7Ke6Klp65AQlxE9dVC0UKDOdCTWa5qPKbLsgQPkh1sPjmEYE
         eaNoyULT1PjfuCMeY2T1AEHLkBwZz1FIM4BtbllZYRxwqZCHM/UcL1fp/tr12fDSSACs
         ZFlA==
X-Forwarded-Encrypted: i=1; AJvYcCXtOEmECFt0taXTPz5fzWCGaJmvBcN03dAeL7Fsuq5LvoZfc3bl12305raIcG/pX14h8Dh1aYoBttLcVRwKDBt4cCnt9gbitAd2qfRs
X-Gm-Message-State: AOJu0YzvZeM8oIg+EpJjpHL/tOKm4jHHnKn4+dgO8EzwqVJvnWkJIjQr
	gmz6JABQCei+pHTL/eieXqReMsX+NEiSxunDauRTDAH65+bOtUIM3jToglMA6GwIJkBPiNk3d9T
	RodV4QD3EeJky758bBuJd+UjUBQtbVJ3uIJZaRA==
X-Google-Smtp-Source: AGHT+IE7g3qCDVff+W/CzfLEO8l+1aNVMFbNxg2BUH5qBAPDXU0ZojYsMYxoP7Sq3tZtsKEdt3zrgeBOx0yZNKS1nfE=
X-Received: by 2002:a81:a103:0:b0:607:85b3:b52f with SMTP id
 y3-20020a81a103000000b0060785b3b52fmr20920543ywg.22.1708558905505; Wed, 21
 Feb 2024 15:41:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216223245.12273-1-semen.protsenko@linaro.org>
 <20240216223245.12273-8-semen.protsenko@linaro.org> <8c1f0a4f-8a8b-41e7-b7f1-4c5a38ec7c1a@linaro.org>
In-Reply-To: <8c1f0a4f-8a8b-41e7-b7f1-4c5a38ec7c1a@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Wed, 21 Feb 2024 17:41:34 -0600
Message-ID: <CAPLW+4n6zA9=1ZswySPE7MmpbV_f99bi8OM9zawgST=XRDSyZQ@mail.gmail.com>
Subject: Re: [PATCH 07/16] clk: samsung: Pass actual clock controller base
 address to CPU_CLK()
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Tomasz Figa <tomasz.figa@gmail.com>, linux-samsung-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 4:53=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 16/02/2024 23:32, Sam Protsenko wrote:
> > The documentation for struct exynos_cpuclk says .ctrl_base field should
> > contain the controller base address. But in reality all Exynos clock
> > drivers are passing CPU_SRC register address via CPU_CLK() macro, which
> > in turn gets assigned to mentioned .ctrl_base field. Because CPU_SRC
> > address usually already has 0x200 offset from controller's base, all
> > other register offsets in clk-cpu.c (like DIVs and MUXes) are specified
> > as offsets from CPU_SRC offset, and not from controller's base. That
> > makes things confusing and not consistent with register offsets provide=
d
> > in Exynis clock drivers, also breaking the contract for .ctrl_base fiel=
d
>
> Typo: Exynos
>

Will fix in v2.

> > as described in struct exynos_cpuclk doc. Rework all register offsets i=
n
> > clk-cpu.c to be actual offsets from controller's base, and fix offsets
> > provided to CPU_CLK() macro in all Exynos clock drivers.
>
> Change is fine and makes sense on devices having separate CPU clock
> controller. That's not the case for:
> 1. Exynos3250: dedicated CPU clock controller space, but we merged it
> into one driver/binding.
> 2. Exynos4 and 5250: no obvious dedicated CPU clock controller, but
> register layout suggests that there is such, just not explicit.
>
> In all these cases you provide not the correct offset against explicit
> or implicit CPU base, but from main clock controller base.
>
> Mention it briefly in above commit msg.
>

Thanks, you are right. That also means the .ctrl_base field (and its
documentation) is incorrect. I'll rework the commit message and the
field naming to the best of my abilities in v2.

>
> Best regards,
> Krzysztof
>

