Return-Path: <linux-kernel+bounces-158101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B02A38B1B84
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2EB01C22C8D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 07:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9366CDC5;
	Thu, 25 Apr 2024 07:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w10Qpr/b"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187936A352
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 07:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714029003; cv=none; b=VWp2UpdCHj2GTGy0As+aqhckCgFK+PsNDDs8K1zSCYqrdfN8o0k3d9zCqUbC2r+Fwq0LUIv1b4rO+4pB8Nq56FpqmK1rHOKWG3o0PQ9LWNph6/zyePZpmga7UQIDkHTtfowqItTDh8irKShv7vm6AJpnvMFPFodVe1A4EDhEjEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714029003; c=relaxed/simple;
	bh=kFy2c2MMRc7/mbY6XyHT0rM8BuRQOTFXPjjUtO+dJqw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=C9OrffgkxObqOks9d0pdZT9TJP+wcsSqFT/AVZ53tJfp6N0zI4Qj9e5RSoYNBPUX6/qarPOAcHOVR/hmP96hjs02ecQCku2FhTviJM2K64NyPFNdPaVeBk7jvzAdXRgwpItBFQVqMh3Ykj8Isfi1H/buf+CRL8aqXECYYQ7Vbbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w10Qpr/b; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a55ab922260so82958966b.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 00:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714029000; x=1714633800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pKbtdaZh3aa5WKKWvhlJ2SkTdhHq3DflemRgyxWAUJY=;
        b=w10Qpr/baTrdev26UCwAElEdXPrUBSkYufqNP5zfAEBPRP7y9riJj519ad6u9vEIiT
         uJXlUC7az14fnUo9PUgtJYkMo3sFq7KOIef3WcvR42FRgoAaWeaaBazrBgCs1SkWsXt9
         wdiK/zmH3zine7A6vms5+7DI8RvBpZyludQ6i2R0jiIFAOsHTyqM6QvfYfDBhT9nzLpS
         i/Hofu/VxHWSkj0fMl2l6vvS3jEt4R0qS9VdvZ5267NkOhNVH6sZVgSuiO+t1YQ71C9F
         G9HMg5zuV7RGo5BLWsMAOURV7+ODBeOe9vDpj0qEO93B0S4Nt65tyNSKlrXEQpAQ1esO
         ATZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714029000; x=1714633800;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pKbtdaZh3aa5WKKWvhlJ2SkTdhHq3DflemRgyxWAUJY=;
        b=FDEr+P8cBN2KP4IaaSoCCnjU1epgctYoYjr6KrnaF+iEflH6zYYGxx6/KTy/C7eeJD
         73Od+z+hNfQmZ8kM83zjW3yHcVf3yBP6uemxvch6kpQWdtgqGTQFY1BJaI3WKLtBCh4M
         opZXumJUerzM8VvzU47ylpyIrd8rfDIXPKfB3sZ646+IczY0J+jFrqyGOkwiFklDM95w
         F5QPR8DSVFPi2yCSUo8As7tmxSpXXbNBOdkqvqvJTo9pc1JPxHxqy3EMr1oxuW9VW5hr
         ZSSgu8tokdOAYXL+tnTQtfv9SN3S2QdiwQfGx+zBl/rDL6puFD4pCsA/w0MnT95QYqru
         OX3g==
X-Forwarded-Encrypted: i=1; AJvYcCW5V5Zrv7ymrQlWKz+Pn4etyveUEmzmyItA8xaTkb4WjnwlvzY/rkSV1uo1/7/duhqN00z5g59RQbpjFAPdwAWKuQxdbTYrxdW9FQg5
X-Gm-Message-State: AOJu0YySupZGqU3pkCVg2y1NhG4Kev/edAHyfgJpF90HoCP3pf3j3PLm
	6qKEht9vSLk8Oy1OdKCSx5Cyg2aNcH2BU7MPi+4Q8Vn+gNUU31Xze/ZoyCnRtZw=
X-Google-Smtp-Source: AGHT+IEs7Co328LLOzTBckFT/nv1oG4AADn4/nugSXCSJvSnYFZ91QkC3IWACxkGxn3XSoA8+ThZGQ==
X-Received: by 2002:a17:906:e0c7:b0:a51:f463:cfa6 with SMTP id gl7-20020a170906e0c700b00a51f463cfa6mr3235443ejb.29.1714029000353;
        Thu, 25 Apr 2024 00:10:00 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id z6-20020a170906434600b00a518c69c4e3sm9136727ejm.23.2024.04.25.00.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 00:09:59 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Peter Griffin <peter.griffin@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240423-hsi0-gs101-v1-1-2c3ddb50c720@linaro.org>
References: <20240423-hsi0-gs101-v1-0-2c3ddb50c720@linaro.org>
 <20240423-hsi0-gs101-v1-1-2c3ddb50c720@linaro.org>
Subject: Re: (subset) [PATCH 1/3] dt-bindings: clock: google,gs101-clock:
 add HSI0 clock management unit
Message-Id: <171402899869.8385.7722233712941698013.b4-ty@linaro.org>
Date: Thu, 25 Apr 2024 09:09:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0


On Tue, 23 Apr 2024 15:31:03 +0100, André Draszik wrote:
> Add dt-schema documentation and clock IDs for the high speed interface
> 0 HSI0 clock management unit. This is used (amongst others) for USB.
> 
> While the usual (sed) script has been used to derive the linux clock
> IDs from the data sheet, one manual tweak was applied to fix a typo
> which we don't want to carry:
>     HSI0_USPDPDBG_USER -> HSI0_USBDPDBG_USER (note USB vs USP).
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: clock: google,gs101-clock: add HSI0 clock management unit
      https://git.kernel.org/krzk/linux/c/dbf76c0d3da8d18a46f75130bdfae7b3b54407c5

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


