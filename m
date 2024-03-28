Return-Path: <linux-kernel+bounces-122571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFC788F9D7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCCA41C2C6E0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D805A55E40;
	Thu, 28 Mar 2024 08:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rGPu1T60"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AAF54773
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 08:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711613619; cv=none; b=IXPp/nOVeexeZGnq2XB3VJlB2U3BS+xRhmv6kIaaZ/siecQ4GY8sVBhoFzla21T4G/QcSkZBQ3wkeHZsEmJoMxtvepfWNQJdeOYN9viQpM1+CK8WUQ6sSmyNFHTTM1opr1It24OIKi9f6Pkm1RMkwfN6UrXPz9Ymn9FBGHTiwi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711613619; c=relaxed/simple;
	bh=eyAd8Fm3t44gc7qEKT0d4Zv8xoYimRNogrja13Iomu4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gbpRRnU2eg4ZIGtS131kJq1bI6UtgZBRyFBFQ3jhYksEGA7oLFowfyhBwlJ+PgBVrdQt1csUPQFqgE6fGKgfMyH+f7WT6UQarYQ5h1Ag9wCIWaXv/ShJMVB0jmEsDblufBxVEjO070SyKe+Uiu65/e07jdeUXMMr7fu1ntDJSVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rGPu1T60; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dc74435c428so697331276.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 01:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711613615; x=1712218415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eyAd8Fm3t44gc7qEKT0d4Zv8xoYimRNogrja13Iomu4=;
        b=rGPu1T604f65l8GfP69kX6JRbPffcFy/o35NPUwWnMiP/cna3H+Xg6fNhGYjtKS/G3
         RIy2e+bzL2xqdVXw2Z1021NrZmaTNrC+1qdFbpX2LZqGwUoNEmPWAS77AlCMMW4R1tA5
         cSWIy9kTz/13r0R7fMarsZB+7B37iGXCyyY1o7kKFjbQKdV12c9fuQ6zf7oNTGQI/Ko6
         V2B3lNf0ejPgsV8efoBeRELRNgcYaL+zkX6oTjEZlZVS8/14Q2x/vde5CdsywG8B4+Pf
         LBzjuPTq03IHDAXgBa1udYhNf2GpW0xkAEoYJkI662J3Uv+5MWzozByvFKcN88G83Svw
         ejkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711613615; x=1712218415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eyAd8Fm3t44gc7qEKT0d4Zv8xoYimRNogrja13Iomu4=;
        b=DeWkQzxWHMFzdncldPBsHhi4LzHsvu33BnEwk4wYVt7gz0papg4LNkbeusHHR/tuuZ
         CovfcMWjoFOE1B3RTCHYxhz9xrOs6kT6PECGeoSCnCilaauLESF7x6huB5FsW3CrbMTE
         LmTUF0u2NUUfiX+ERPxro4kfAbEkDYXKmAYs3QpS5QlJ2gsaNOn+0ZvChjzmgqdMFYeW
         rFKmqn6Zz3og3ZQ7FKtSvhmnu/JATsaUAtbepOYwyMeDF5RlUWv59D0evev7Jbmf6LIB
         O/jeUpITviOFYipKw0dZ8snxf2ltzgcwTPkHjkLYWXkHKlqfwXUTF2co157jsO5bQod7
         GSDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWW04BSrbzogFKS92fPF9339L6O9GppYYy3Phswu4wyOGJIaEufpIxwMzbwyxyKirOeTV9frUsDWyge3V59qYPWzdvHv7hWWA5kyRJv
X-Gm-Message-State: AOJu0YzHj1hXsAIFRkzgJUEOXObutHPXmdNRHDr5oPL4Emf4kBq6227+
	n7NRwPTsD+W5f4ti7X6VsL58Qflc20cl4jAqDBzR6GBv0cXC3BwatWPGzeJ86eg8e1cMGqdEkPk
	U9xhxI6htxelRZx4T9ORmM3XXLICpimMod3wwaA==
X-Google-Smtp-Source: AGHT+IGMP4Tk1rGQykOPNpks4MpJ7aMlQvkvBPR1XoNvNcoaKqQfOEDiNp35dK3mcwnlEPOwTL2pN8U5wfPMlD/HYFQ=
X-Received: by 2002:a25:4dd4:0:b0:dc7:4806:4fb with SMTP id
 a203-20020a254dd4000000b00dc7480604fbmr1887988ybb.8.1711613615243; Thu, 28
 Mar 2024 01:13:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326-module-owner-amba-v1-0-4517b091385b@linaro.org> <20240326-module-owner-amba-v1-14-4517b091385b@linaro.org>
In-Reply-To: <20240326-module-owner-amba-v1-14-4517b091385b@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 28 Mar 2024 09:13:23 +0100
Message-ID: <CACRpkdaXWOp9C+7ahUO+6eTGodABW1D3CAGoE-6RrXbFcpd8OQ@mail.gmail.com>
Subject: Re: [PATCH 14/19] i2c: nomadik: drop owner assignment
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Russell King <linux@armlinux.org.uk>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Olivia Mackall <olivia@selenic.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Vinod Koul <vkoul@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	Michal Simek <michal.simek@amd.com>, Eric Auger <eric.auger@redhat.com>, 
	Alex Williamson <alex.williamson@redhat.com>, linux-kernel@vger.kernel.org, 
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-i2c@vger.kernel.org, 
	linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org, 
	linux-input@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 9:24=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> Amba bus core already sets owner, so driver does not need to.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

