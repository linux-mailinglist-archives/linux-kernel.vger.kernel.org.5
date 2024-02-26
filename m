Return-Path: <linux-kernel+bounces-80743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6C7866BF6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C2F11C22BAE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 08:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994031CA8A;
	Mon, 26 Feb 2024 08:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="bEt2Xa9D"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A231C696;
	Mon, 26 Feb 2024 08:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708935557; cv=none; b=lPhkL8CXaHxcfiM/cjapEJZ/RTDF6q+4ORS0VVW/Lz3cqLjvx9NcnvYyQIc3Y+Pc71qqeLfiJjuCw2dnp36wx19z1Uv5EtotXOQqC+mbfdaLUo1fVC1iyG2LX2F6thqOxHJMU9MfgWRSxPS58kHi+RYoT2OLxrmrJUbmtY1YFBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708935557; c=relaxed/simple;
	bh=zRa4yJkcA4V6X2vjCJFvlB/Gfr7vxYL8h6QUTOx2fZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RmpMVWeI6Zp/b0q1dvhdJyQepA2CHDFf0bGUEPVLcLd9siAz8buUrY6Qb6nvE9fWSuw6phctJzpDPAk6jJ1V5IRL1o2a2UN/xa4QoP6kXu1Goa18qFn5sBn8SkqKJbMC5fblVV3WUYsZkhiJFYj1zDEChkYRF/mxERr7MD6VSdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=bEt2Xa9D; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1dc09556599so24193465ad.1;
        Mon, 26 Feb 2024 00:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1708935555; x=1709540355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zRa4yJkcA4V6X2vjCJFvlB/Gfr7vxYL8h6QUTOx2fZc=;
        b=bEt2Xa9DGcTXdQdGdsPjiej0u93NgJNcNv19DrVWYZSGQ2YWEW4hDfmnYst9+BsDnj
         qhJxfirc9r4NVRtvSCbs3vG385Ye8dvtuJxl6ORS8gsXcmqxf2GrEThL+7fsYS/q1GiQ
         /lxKn8BAuLE4Hk3RJtcfQzFcf+MexBN+4o7ilkA9jffYfQMoL4bikZEo9Q0frHq/a/WP
         z/0C2AgEQhNwgj6G/CIHOAisFalbI8n3M2VmSS6MfNSW7ifif5N9EXmS5D8gULp82QKj
         v6b4V9U2BGRpc2j4MGV6TCaZRU4DikdCFlrP0SbqnoVLe92Mnf1OxIFHJiCQQW4fAkjx
         5D4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708935555; x=1709540355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zRa4yJkcA4V6X2vjCJFvlB/Gfr7vxYL8h6QUTOx2fZc=;
        b=uaO75uf0RqUmMiSObxd2C1TK/S+lCSTBgJw1iGhqdrTRPNqNuiC20ea+ndofvzKK+Q
         wf6cc6txcDV9TwxR/UI/94PC+Wijw6caAygmL56tcuulk/YyHIXWBofZLUnYURNvpF1q
         0+zV6DsFeeg5Ob90T37jLEF3LAZj4eiZL+JEWEWn25+RARabGQitdk8mdGOPWtb9VsBZ
         GtYt+/6yepArvnTicCU90PSsrPUhN0vj91X7bLdYM2YRxmTeNUtbJQuPYND6CaUG+7tl
         7aHd71SE9c+cCYx7MsG0LvW3g8hSAOYZ8owY2+9XmBMhxKoUpzpPWrQVUETc5IVITpLb
         PHRQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6Ybg1b/iju7E7YbrdKGzvcszL9M0+vCDabcPuOU7FytGD4CWn4WjvdikSmvJ79HjCbrCpS2QUIRcwDDeLe5wYvU2jCR9JvPsdh4I4Z2tDhd7Glqvi2y0l8hNdqJM0+1+DbdROhzR4nQ==
X-Gm-Message-State: AOJu0Yyouh03TA4uadbnHyocDx3rtrjJARCxfaVlEXgwTSH3BJ3yF/a8
	/CU15gFvtfcIfYjIFitzVvu1E+aXArEKgJkIlsQcilcJNE5WRwK7GSJrCPEEj4pFf3b7Lmwd7dR
	KHyFM0xdTZCHDXU3kd4y7mfR84/A=
X-Google-Smtp-Source: AGHT+IHSKx4UhHS4/QTc0p0DdYlvOIScoPdMc1mzgFs3IyOjSbzD8+0JaBmln7m9eAh6BmvSRIksg68WtgQUL+yJNrQ=
X-Received: by 2002:a17:903:54a:b0:1dc:afd0:e273 with SMTP id
 jo10-20020a170903054a00b001dcafd0e273mr173179plb.59.1708935554895; Mon, 26
 Feb 2024 00:19:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240224084030.5867-1-krzysztof.kozlowski@linaro.org> <20240224084030.5867-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240224084030.5867-2-krzysztof.kozlowski@linaro.org>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Mon, 26 Feb 2024 09:19:03 +0100
Message-ID: <CAFBinCBqh_0hbYWk8Hk6iYbkZuHa1Nbq5WJLY7FRhwbsgAyurA@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: arm: amlogic: add Neil, Martin and
 Jerome as maintainers
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jerome Brunet <jbrunet@baylibre.com>, 
	Kevin Hilman <khilman@baylibre.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

On Sat, Feb 24, 2024 at 9:40=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Add rest of Linux Amlogic Meson SoC maintainers and reviewers to the
> Amlogic board/SoC binding maintainers.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Obviously the patch is fine for me - still I have one question:
are you expecting an Acked-by here so you can take it through a
devicetree git tree or should Neil take it through the amlogic tree
(in that case I'm not sure if he can as the amlogic mailing list is
not CC'ed)?


Best regards,
Martin

