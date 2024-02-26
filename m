Return-Path: <linux-kernel+bounces-80627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 695B9866A9C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 08:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25144283526
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 07:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC661BF34;
	Mon, 26 Feb 2024 07:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pqtjI83a"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467311BDE7
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 07:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708932333; cv=none; b=U60AVxCm0aMske6YeJhkVH5PcBQuOEsuzHJiqA9FJkZmn6iasvPxXvDsUvDR6DIsnco7lYz0SIGAq/GXtiC9y4Sltxaod4kkLOVcF0rbz0KeasCO3aHbHkJu/vxJHFSw7o6wB4wWLVc0FI4n5AdcgrGUsfiZnkNhoUGXI3Bj8c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708932333; c=relaxed/simple;
	bh=wRfI4G+6FC0nrrabyF8vxsAkUOkinuF6aaxWAhU8zws=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jT41F+mEpKLy0xLr1nRxVlYYD7ae3aumAh/ix/Tu37totn94h9EEBjxUkv8Qpmdb4E6vX2/FyibzJ3/VXd9d5vNIxmPfzx8Ucat6VR3xCruaMiVjiIN0zkv3q8rxh4TlY/U6dRPTrTQPRsWrEOygo98z8QVlP+qOAtrmsSlbcqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pqtjI83a; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a293f2280c7so372684066b.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 23:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708932330; x=1709537130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9+XUqGWD6IWQzzvvwRX/+nQJA+03a/6QRsX8/vxcbvc=;
        b=pqtjI83aRyRY15JxPleiBJS+2K2AIuIkpwR2R0nv5a+DSLYOcfMMdjFNgo55cSlaSf
         +okydGVY00pRchG/gn4idnF/qG52pAepu6dmiYcHKiZ3yUGdadnRU58HPh2Aj+Zqu28q
         +r5u9X/vWMitAODz7q2pmJaWaVB0+X7WCgCbI4qKw/JQtLDc0F4s28kESfOsQM4oHW6d
         e9d+i7LOL7uMVwBURvERfNtdOYm94UiMg9hQyiZqRnA96uJTwKMB+u++t3Ctvnrciwv1
         rTKc+8rP0XBR+aLUAb06i3eUburFFape1XSDxWilGRz4C3N34hEQcR0bcRazDqZAJHH2
         CU4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708932330; x=1709537130;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9+XUqGWD6IWQzzvvwRX/+nQJA+03a/6QRsX8/vxcbvc=;
        b=awuq2LpWCEM094SfMse/PY74nHyMsj34ByFluyOZB0rcM5U+JnBixBIeQa+TgPaaSA
         nuAb5fgByDXGmuqbkkcCYAvZlK3qBkZyzJEFmIKOs/w/AB3VSa9kM7/H1D+3bFR0iwTw
         DFsDB3ueyra7dlaATzHoD3EA89dH8acuzXCnc9mqzKIhWWf8bA2yN+dbS/rUmzYBkt0r
         Voj4BlzxHy2mq4X5IA+Mh+r0EbCk1hYNA1Ve4DV0QHPZUx+F7Rb1UO8gaInxZ415vaD8
         FXeV45pfuaoGVtHNQUGbs4oub8uLEErBlbmHSW+6N4mrgHswzXm+2JfMaeuNqmnAVbFc
         VQ2w==
X-Forwarded-Encrypted: i=1; AJvYcCWRWmTWqd1mq4asSq/A5CD17LHC0f6xVcoALtkzAvwIJ+oqPi+T2v8tFAj1Jz7BOo4iRJTQHNVV+q5grsuCHPQsmoVwI7221gcatGPa
X-Gm-Message-State: AOJu0YxMy3fKlMmJab07BoLw945CKjJnHp4MBOteuH8NIrFH9q3KASSl
	wq+2y1tBB1EhNziGs2tAsD8JTvcq0BuU/hrW+JdFewRy/FcRjadUcDmVMPC2gCA=
X-Google-Smtp-Source: AGHT+IEC2B+D1Rc/Z2qp0EvJ/C5SuHJvn4PGDQCefwtskxiIujOGW6alTotXIUZsbE9gNtP2e1uK6A==
X-Received: by 2002:a17:906:318d:b0:a40:4711:da21 with SMTP id 13-20020a170906318d00b00a404711da21mr3696374ejy.37.1708932330575;
        Sun, 25 Feb 2024 23:25:30 -0800 (PST)
Received: from [127.0.1.1] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id l15-20020a17090612cf00b00a3f480154a3sm2136224ejb.65.2024.02.25.23.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 23:25:30 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 NXP Linux Team <linux-imx@nxp.com>, Sebastian Reichel <sre@kernel.org>
Cc: Dong Aisheng <aisheng.dong@nxp.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240224213240.1854709-3-sre@kernel.org>
References: <20240224213240.1854709-1-sre@kernel.org>
 <20240224213240.1854709-3-sre@kernel.org>
Subject: Re: (subset) [PATCH v4 02/16] dt-bindings: bus: imx-weim: convert
 to YAML
Message-Id: <170893232894.6616.17442231091055419472.b4-ty@linaro.org>
Date: Mon, 26 Feb 2024 08:25:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4


On Sat, 24 Feb 2024 22:29:34 +0100, Sebastian Reichel wrote:
> Convert the i.MX  Wireless External Interface Module binding to YAML.
> 
> 

Applied, thanks!

[02/16] dt-bindings: bus: imx-weim: convert to YAML
        https://git.kernel.org/krzk/linux-mem-ctrl/c/3884bdce169de87d3f978edf41829e5e52388072

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


