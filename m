Return-Path: <linux-kernel+bounces-79906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A99862886
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 00:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5CF728233F
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 23:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CFA4EB33;
	Sat, 24 Feb 2024 23:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uOTLlu9o"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4BE4D9E8
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 23:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708819176; cv=none; b=iXFdCdfaEN3/fX+QTr5o5TQrtTI99g/bBzSXoHnAZAWJx96OgPUdF3RMohIefV+uqi95cWL8AXkO3G2YTzrzvlJIxfO/GUxEnlnoJ1ip24hJSoFrD/AA33A1eEkIVVHoNVjQdNaoaHCz3fwacIlh+Pn6LjAeMxpXLvL8FmGyA8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708819176; c=relaxed/simple;
	bh=ckUxIr9E2HFFDl6qjsUCpotsMkiROkeR/piYuNBuUg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dmBAN17tC+zXIjhMiyk+RM1+0m2wbdMBEjdTACep7v4DXSkH84jaae5fJR7T/yCzFmuNPMj0qFp6GO1vV73kPHYSQCl1cfaZ2UNaqBfHJ4dTTVXEoAvBQyAdPxmiLa1H56DJ1TNTs9vStbwjbDiTjY7Rao8Cb1LNa/o0lBO63zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uOTLlu9o; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dc6cbe1ac75so1661144276.1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 15:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708819173; x=1709423973; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xok2xXQ0vGr1pj2FsmN5nCeRHn6DxQhEZTwOzT6wsCM=;
        b=uOTLlu9o6w36ilT07ANXYLrnkYqH1fy+yGL6NJj9bFpElpO8alJUbWnRhfic3Qr/RL
         VzEaZ2ML8cAeni1nt25I5688ncIScT2SyfxSnfOrsqGJqT4am6qORSXUwp1wKtxi7hyj
         uEFnkKh4Y0TmRwaASZqhg/l6AIct7fY1fW8vI6vjOApud3xeAa454+XVdIpqTGQ7Pe02
         het4FSEj8+ouv4vFpm4WpBALE5WW70d+QdnKdaiKPUuzCByuUo1azNDodKUx+ZHITQpX
         ptBJ4Gr6C8fhYlxAM6Dm2X0MZnF2FgQh4TytWtHogydCFqpRMNHWDnskMLXVUwivU72g
         ei1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708819173; x=1709423973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xok2xXQ0vGr1pj2FsmN5nCeRHn6DxQhEZTwOzT6wsCM=;
        b=q7SAYYfNLvqlPorVR6KZ5GjylTa0hNgH8k6ZWoFfdvZwse12ybQ4xmIkMQo4wBD4W0
         jLiZx5j7ho3YLThGigTVM8aYS94Eg+faJeQUPm9w3gcXOmfuFpMmevRZ/mr1xUs3/h29
         V/X7Fd3BaRECgPM/46F0SeNy66d0Ktrw8zb+g0jARZ7DVawcHrw6dR5Zt0F3Q0FZ2SVC
         Pkpv9+Vkgfu5gOxAiZCz+eugO4zgkSYwjzCBuWVBC+BwHvtCzugBnE0Wv1854UNShFy0
         X2clgOyUEo88fwUqvunen3TMkg5zMIiNbShcG254wVR3P6OoCRDZbNJ3bkFlZXm+uP0v
         tENw==
X-Forwarded-Encrypted: i=1; AJvYcCVouuBucvo4K/RZkEHRasmPG5u2eHsFDWRzZXYbmkkTifoATWQXqHvMuAiCInxi/y9hePuXOc2yGPxxdgbFVyCpbIs+k/noD5sY4P8K
X-Gm-Message-State: AOJu0YzXL+/AkiILXPpJIpI3nu7g4DZ/JGDQUZiNf99kv7lQ3ra6sndq
	cjNglnTQTnnDC+px1UyHNCkNr1l0yolzhZyYrThFxUKh98pMmONhJKGibl56Yt8/hNkGpT3KD24
	uQ0ID9Kj2tRIuWbGaNsxTEemk+HWtlCXi6+UxAMl3xcFVw+UcyxZTqA==
X-Google-Smtp-Source: AGHT+IEEWF/q9H4leTyQIxxYbOYmfgX2cTUmaIFRHf6/R5fcAuCr/SEsDzojC5RZar1CMevNhZK72yt+54/VUNSLZJw=
X-Received: by 2002:a25:ada8:0:b0:dc7:4988:6c77 with SMTP id
 z40-20020a25ada8000000b00dc749886c77mr2044340ybi.21.1708819173625; Sat, 24
 Feb 2024 15:59:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216070555.2483977-1-tudor.ambarus@linaro.org>
 <20240216070555.2483977-13-tudor.ambarus@linaro.org> <10f692ae-ac7a-4243-aadc-80712f781d39@linaro.org>
In-Reply-To: <10f692ae-ac7a-4243-aadc-80712f781d39@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Sat, 24 Feb 2024 17:59:22 -0600
Message-ID: <CAPLW+4=PYEHC3+Am1=xjtERsGcXmLsVAH218JryecaJdw8ER6g@mail.gmail.com>
Subject: Re: [PATCH v3 12/12] spi: s3c64xx: switch exynos850 to new port
 config data
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: broonie@kernel.org, robh@kernel.org, andi.shyti@kernel.org, 
	krzysztof.kozlowski@linaro.org, conor+dt@kernel.org, alim.akhtar@samsung.com, 
	linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	andre.draszik@linaro.org, peter.griffin@linaro.org, kernel-team@android.com, 
	willmcvicker@google.com, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 11:56=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linar=
o.org> wrote:
>
>
> Hey, Sam,
>
>
> On 2/16/24 07:05, Tudor Ambarus wrote:
> > Exynos850 has the same version of USI SPI (v2.1) as GS101.
>
> I tested GS101 and it worked, I guess exynos850 SPI shall work too as it
> uses the same SPI version, v2.1. Can you run a test on your side too see
> if works? If not, Mark can drop this patch I guess. Please let us know
> your preference.
>

Tested the series on E850-96:
  * All 3 SPI instances were tested
  * Tested using loopback mode only
  * Used spidev_test tool + spidev devices in dts
  * Polling, IRQ and DMA transfers were tested
  * Works fine even with no SPI aliases in dts

Feel free to add:

Tested-by: Sam Protsenko <semen.protsenko@linaro.org>

Don't have time to review the patches right now, sadly.

[snip]

