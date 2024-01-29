Return-Path: <linux-kernel+bounces-42559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A81A84031A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4BEB281CE7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D3A56477;
	Mon, 29 Jan 2024 10:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nFaBQ8RO"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3DC56469
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 10:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706525116; cv=none; b=aePqb7TwiTTbpMeRneuv/PyEoXUaQAY3KsH5T1CnmP921PukdnkmN3ncsDIRyi+w9LVj1iY2Z6ftAF3rEkSM4EuI09wwMGngh4I/b9sJTnA4fJqMaDr9m1ChQ21IvNhUiJyQZbfl/9i89rIdbaSmjZDypgI68bOyyUTfYCTopaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706525116; c=relaxed/simple;
	bh=Z8mp0RtDl51BFHkxZNr+PFoZ3oiWgxeFj38gUyFpRkI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iZ+hlF6z22Ke6Hx/sTxg1uFg8KxrOb5uR42ffQBNsAH5in2NSc7FtgN7c6KgspTaiLm4YMdx6gqwciKNBTjT+K2dul46EwFz+49pegW2iK1V0PHrUHzVtod4NdHskhM9YKVL8gedLLZAEoRAAXBfPRr8LjSpz2cOsph/H4tlQDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nFaBQ8RO; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40ef6442d60so7039345e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 02:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706525113; x=1707129913; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Z8mp0RtDl51BFHkxZNr+PFoZ3oiWgxeFj38gUyFpRkI=;
        b=nFaBQ8RO7T2Kcea7ugzG1qrFh3i5QQHRzpbdTiqLiertD0wwSiGFRqUFw5E8hslyIp
         TVmjnFRYPJEAuymNs1HA+YnifsWw/fl/zgEHs0qiDCZkVhlnbW8p4SSg6gaEmTXhw4Pg
         FBAdXnV6/22Im0N9n23buznfIE5Nvbmj78vuwREIM4nPgtMaMyYVHVoNHds6CYvBl0UZ
         JdH0kaFnQ8hBCrK0rFoQH7L+Ge14MbGKUNJKLQtcK768y2VGswI0SFNtoVB1ZKWYyZzM
         yrrHMgN29LbjO2YOjsfzVHdsGDe34TpgWCseyWMnQM8eBzF1rYEuSx04q/iz4RKWltUG
         mnnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706525113; x=1707129913;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z8mp0RtDl51BFHkxZNr+PFoZ3oiWgxeFj38gUyFpRkI=;
        b=l3D2VCWHHEzqGj0TNNnw0WHBP3zFVqUziuyA+1z6CaLi/HSPbIPd15JSTSsgQjSerj
         5LSDK/817KKm3HUhgW4mbYHW4ucpfYZGAc+GoRF+zDdPrEarYT9CUB8BpNTKAP70guZ5
         CN4pP0KUXP5fYRywXcjeKsA0iWso8CYAWXnsC731OmzFLHZ/UETDZhzGyWBA+R3g2Lt9
         19rQopCMVE5859mK2NLmPxi0ac+hDVzqhyFKvO52J0G6JcDpBY3ZrB2WqxWFYuegJWAK
         iBr59kyadbaC80oqfRN0yFTTxjk+yY+LUOmviUyukDKVtbNHKrYGfa/uQJhHcS/g1I3K
         ikXA==
X-Gm-Message-State: AOJu0YwvcyDp+kUTuTNn6PFqzY+8VD+VjRC8gwJk8R9fsQCriFezdKR+
	U8GzEBrxDesTK4I9o0tDtAKcLaHdDSILhAXIA8hRngAvNlCm5kC1bT6YyVICrcI=
X-Google-Smtp-Source: AGHT+IFihQ01Lv/3xhmJ2QRY4zWM3/6pk8fnT64QKAKwosslS/C3loV+UgYjHKedBDBzrFE/BLHtcA==
X-Received: by 2002:adf:a348:0:b0:33a:e73b:b0d0 with SMTP id d8-20020adfa348000000b0033ae73bb0d0mr2794136wrb.32.1706525112807;
        Mon, 29 Jan 2024 02:45:12 -0800 (PST)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id v2-20020a5d6b02000000b0033ae7d768b2sm3982537wrw.117.2024.01.29.02.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 02:45:12 -0800 (PST)
Message-ID: <d234060148ab6027bd84c5475851a30329e877a2.camel@linaro.org>
Subject: Re: [PATCH 8/9] arm64: dts: exynos: gs101: sysreg_peric1 needs a
 clock
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: peter.griffin@linaro.org, mturquette@baylibre.com, sboyd@kernel.org, 
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
  linux-kernel@vger.kernel.org, kernel-team@android.com,
 tudor.ambarus@linaro.org,  willmcvicker@google.com,
 alim.akhtar@samsung.com, s.nawrocki@samsung.com,  tomasz.figa@gmail.com,
 cw00.choi@samsung.com,  linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org,  linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org
Date: Mon, 29 Jan 2024 10:45:10 +0000
In-Reply-To: <CAPLW+4=PWCegZi8Wd=rhSUUiXNn_J46VGZoxDcRA89MX-2Y9tg@mail.gmail.com>
References: <20240127001926.495769-1-andre.draszik@linaro.org>
	 <20240127001926.495769-9-andre.draszik@linaro.org>
	 <CAPLW+4=PWCegZi8Wd=rhSUUiXNn_J46VGZoxDcRA89MX-2Y9tg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Sam,

On Fri, 2024-01-26 at 21:00 -0600, Sam Protsenko wrote:
> On Fri, Jan 26, 2024 at 6:19=E2=80=AFPM Andr=C3=A9 Draszik <andre.draszik=
@linaro.org> wrote:
> >=20
> > Without the clock running, we can not access its registers, and now
> > that we have it, we should add it here so that it gets enabled as
> > and when needed.
> >=20
>=20
> That sounds like this patch deserves "Fixes:" tag :) Other than that:

I didn't add it, because at the time &sysreg_peric1 was added, the clock
macro CLK_GOUT_PERIC1_SYSREG_PERIC1_PCLK didn't exist and &sysreg_peric1
wasn't in use until this series here anyway.
If this patch here gets backported to some older kernel due to the Fixes: t=
ag,
without the whole peric1 series, it wouldn't build. Therefore I left it out=
.

Should it still be added?

Cheers,
Andre'


