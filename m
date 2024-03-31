Return-Path: <linux-kernel+bounces-126379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D11893600
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 23:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67DAC2828CB
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 21:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA06B14830D;
	Sun, 31 Mar 2024 21:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="hGGKROHL"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CE61C0DD9;
	Sun, 31 Mar 2024 21:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711921227; cv=none; b=HGHClFSnjnnb/4jAlfHpUv96xx9Zbbgr3igt6MLFYoHzdrxAKPncn1IWgOg+YrJpyMiSFEk8PaIdohv27gu09j4Krc9LqCinnHyf0QjPRdTqMWjBeY8THjJdxygnz9sOlrO9NzpAbS4dpPG40lMO82ejeJ0ueKCf2fk50yMtDKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711921227; c=relaxed/simple;
	bh=hG6ggvtVUcMqrtmz7yHqFSaOMOGmX9esE9uhSYVoWZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hcsQK5WCZTCvmLV2AkTRnCfER7THT/JCuIK+eEox4L2aD2H3AmmTC9GOMNlSxplZdw+GNCXJz+7rQDzx69OMX9pkfks+WmkblG/0LWkU+b87nSErPJQ9pJ6vcwPxcIXh8eYrGotonpOsAxoEK/uC5r9TPAu5Vq4/d9tvkIXV2fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=hGGKROHL; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e0189323b4so23869725ad.1;
        Sun, 31 Mar 2024 14:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1711921225; x=1712526025; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6bOAMX8CDxRFe75wZuJ9Z2dq25ZmCynlaxMc7spfxAM=;
        b=hGGKROHLfYmgrBH6aG8SPBlpuJIHMeB6Xvr6r1wm2HSiZ39hbuC9bfF1S+dRWQaunA
         DzbCio1F4IfyTOhl2aLQc5Ii6h5t9NTWMvmljY1qK92bd2o3HZjWBf1RJnhjKnujLeEB
         Q8FKymdPCJ4CcqbTsHEnQ6XNulZE8F37xKbKzQ3JcJoJSTh4P/6JUprjEyhbV2VnY24w
         zz7L1kmG2qrB1t/O2G838svBrtZS0jty99o7hQQKAmdB19uHa53qDdI/hi1+u1i+Tc9/
         RWrzWJADTe/PRXag6lGR2Es/FH61XoOoMyO8oAJ7CE+BeS+eVTnM/fpTsVSvcnwPqm37
         8NPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711921225; x=1712526025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6bOAMX8CDxRFe75wZuJ9Z2dq25ZmCynlaxMc7spfxAM=;
        b=dxAYiKXdykIXBVxPYFal6tZZDUxvS79Z8faatzyK59CgRzr6ljWQeL9qPINIh165Wh
         N7dU+pZrHL0dZjFhep1C6QZA9WvQ18QrABFltVDWeHD9VwEjLWIAPl6eiGhnnnKpTUU9
         GukMVHSN3AdLOZOvP6wdqY1zUF6MtScf7PZ++I42/SkROzUmCObS9xlG5nAmHUcO4xqZ
         SonKVILZ6OuTsn6clh4N2ldtyUzH8wGbnJbABv67xQL6dybAjtrSDxqIIECvcNuG9OHr
         XuhdnzsVnalTrvKHfUMJnYn5Ap7JLoo+r3ojPfGKEj6YFnpBp28ntyN0TY/wapVFDw+6
         SPNA==
X-Forwarded-Encrypted: i=1; AJvYcCXs5jTyaQkAzLhHcH5pm9+IOwHPHYQDOdQWlZ/9ykbbufoVTgORGHdzIuYYN2O0f1Pa7ftoUWZpA/JJ/GKy/Xd82gfW5CjkXXiUdowsE/xydXGJiyQIZEKtsiBcJe0EAC9AR8wPRmKD1bM1eowUkOGgbW9Q2rN+ffglNVcHTksaMiuHpw==
X-Gm-Message-State: AOJu0YzLxhb8TbTLfn2vdPxSKZ8E4pwE/xc+gdzR0/KU0g++KEZFR+pu
	HMH0DIpMQUqkRBbJRIOGKY4JwfSA8iaIBlcK6vFIA3TXjbrLrQBnoTx8LHVJ4OekdTRtClKbtpL
	sM9ymoR3cSnQaPoMl++Y/LZ70IRw=
X-Google-Smtp-Source: AGHT+IFiqj4SbYwzxlpmSNvPFU6oA3OXhWytg+jzKWNJs6wKOMo0mOw5iOQRrId8XNfTznU7DImuvdgTgbvN4vcPI8c=
X-Received: by 2002:a17:903:94b:b0:1e2:3719:43f5 with SMTP id
 ma11-20020a170903094b00b001e2371943f5mr9219842plb.14.1711921224652; Sun, 31
 Mar 2024 14:40:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329205904.25002-1-ddrokosov@salutedevices.com> <20240329205904.25002-7-ddrokosov@salutedevices.com>
In-Reply-To: <20240329205904.25002-7-ddrokosov@salutedevices.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sun, 31 Mar 2024 23:40:13 +0200
Message-ID: <CAFBinCCC5KK-4_w41B-+ZJ3zdZckq_EDuAW+Kak2C0Ow8uuD6Q@mail.gmail.com>
Subject: Re: [PATCH v1 6/6] clk: meson: a1: add Amlogic A1 CPU clock
 controller driver
To: Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc: neil.armstrong@linaro.org, jbrunet@baylibre.com, mturquette@baylibre.com, 
	sboyd@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	khilman@baylibre.com, kernel@salutedevices.com, rockosov@gmail.com, 
	linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

On Fri, Mar 29, 2024 at 9:59=E2=80=AFPM Dmitry Rokosov
<ddrokosov@salutedevices.com> wrote:
[...]
> +static struct clk_regmap cpu_fclk =3D {
> +       .data =3D &(struct clk_regmap_mux_data) {
> +               .offset =3D CPUCTRL_CLK_CTRL0,
> +               .mask =3D 0x1,
> +               .shift =3D 10,
> +       },
> +       .hw.init =3D &(struct clk_init_data) {
> +               .name =3D "cpu_fclk",
> +               .ops =3D &clk_regmap_mux_ops,
> +               .parent_hws =3D (const struct clk_hw *[]) {
> +                       &cpu_fsel0.hw,
> +                       &cpu_fsel1.hw,
Have you considered the CLK_SET_RATE_GATE flag for &cpu_fsel0.hw and
&cpu_fsel1.hw and then dropping the clock notifier below?
We use that approach with the Mali GPU clock on other SoCs, see for
example commit 8daeaea99caa ("clk: meson: meson8b: make the CCF use
the glitch-free mali mux").
It may differ from what Amlogic does in their BSP, but I don't think
that there's any harm (if it works in general) because CCF (common
clock framework) will set all clocks in the "inactive" tree and then
as a last step just change the mux (&cpu_fclk.hw). So at no point in
time will we get any other rate than a) the original CPU clock rate
before the rate change b) the new desired CPU clock rate. This is
because we have two symmetric clock trees.


Best regards,
Martin

