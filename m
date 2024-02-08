Return-Path: <linux-kernel+bounces-57586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3437584DB11
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD3481F2345B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC9B6A8C9;
	Thu,  8 Feb 2024 08:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WTyukh7R"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A956A8A2
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 08:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707379726; cv=none; b=PfKcMM+/U9Y233EiLBGC5g8TOdWx3TkbMYYUZokpAseDpIA7vxAjtZxIlSb7yer4t0DxWGJjkzemRhEUmkSMLVZpu7O3UkdsJvfag6r9hFnOIp8nE7dCQaCwogAxIXlzFPuSrukBgTc7/rlMQM1mrqYU5DepzolbnKCUimsl3PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707379726; c=relaxed/simple;
	bh=fd8o5HgLLb9xxGgOAt425TU4zZoNTb1DKaJucS6kv3w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sYCpzy9Ro7g7tmm3CQ8bNGZadWau1B8FxvrTJkEEZZWkrW9w6CkV+S5bqQaZePAMi2KUxyqnHwjc0opgCJdewPYDc+KZCAMx/1kXV02CcqGL53bBk/gr+q0SzA5MfgS4Ue8WHPtawpWcAXUZGlhJMA4qLv0nZMwrzw3einsoj6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WTyukh7R; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-410383da759so2262805e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 00:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707379722; x=1707984522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Toj79ymKzNIKiZBdlDcH6ZznHrVcAbCsKACfCBNCkOo=;
        b=WTyukh7R5DexTdE7YO/jt96CMoKpW5qbjok3n/GloCpTZr1EME7YUYacT75wTsPpO3
         l/ljU1N0KQXfyBtYZiPPRo8TSrXxBlvOOn/0nf5VdFpiDDAMkSitvicDR4jWc0Z7sPN/
         QTyHfyBYXK01VW2gWtpiHZi1Mb999BnZzFR7zlQi0Psmzxgp77mciiwowj27qGRpyAT2
         0A+cc3tzgthb/lYP85eqvMLBaY2Agck38p+CY0ZW4AsKQo+JwiXbcGhbpghtme0BR+oO
         XLfkH1fr+/6idyq/VbelxtvQ7NLS/FtbVPdkGw9MFqFeNTt07LvoqFLvGU9BEbGXcPnH
         wmFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707379722; x=1707984522;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Toj79ymKzNIKiZBdlDcH6ZznHrVcAbCsKACfCBNCkOo=;
        b=D5BbvFZZaOhALbCf/08xDbWh7AfAX4Q/rXNaNXa07vqZjnpMFKOS3RdFnuyWZYR1t4
         6719OeDRXRvn9V2axxSJkuyV6fTO/XB22JZZNmYdBu8ljoYD8HvOmdiFw/NAKRG2UT4e
         L3uWGOKVwiVytk6+13x/BDTKkd2ybXqTcMEGwNUZGG9bNqNY0eOgzu4JNiN1sffgUEEF
         lOWFRWhhLV3nW6GLC95+x7sydqA86OanFBJUGHNRkrXCjIaMxsat4C/gi+hUMbYTyKTU
         JCRpaCzltniBYdz77zyYPLSdhkLnowTluODoSIXDDqUp+cb8MMsuzpd8nAaJSn6fGGaC
         8dUg==
X-Gm-Message-State: AOJu0YzAV4akLCneBiz81aeY+/XPFKyIxDQF6MIHgwT1IZzOvO+pdB/n
	o3gRdTo3xKiOQEqUboeYpxefnMOSOg8vm+Vvqm3axknUnCAAN7GK+Kdml17hvxY=
X-Google-Smtp-Source: AGHT+IGTTlIUWS2U4hnjFra03OBr2NF6ysl00pLA3hZpRrUPSIeOwzQjZJKyK1JHXdu8va9R6ZadKw==
X-Received: by 2002:a5d:64eb:0:b0:33b:48ee:8a31 with SMTP id g11-20020a5d64eb000000b0033b48ee8a31mr6571911wri.13.1707379722682;
        Thu, 08 Feb 2024 00:08:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWSI+ny4D3Pz9fHERhXgGGh6e3HzBn0krV3BWtF8I64DZUDa+GBovZraZbO88NiQ0/rsfc1+lMJ9UmMyMSF5ZXzwUba5Dn+7UzdPnXPcNPZWXvtgQ7G9CiSF1pk4sTqP55+TTXK4oWTqyjxnCSAzlLQOTqGVZWMRTy0ePm6tfirY/mUj8T/Dhv0sko70NwNXQMnkKcGMY64OniHq6ixE1gIaK9bVJm/2Dsu/WsNwV/FcTtz/UGLm9GCcCixHTdlbYjJFFIPFQu/ljr6KRZhSqtX79KrcIFeqU4KCmDZZmG10e/Od563kDbMMUQjFzBYINP5xqB/H8vnx9cibL99zQZDmCUivJftCriJ/bdPgJcYMN9ygbfcDmapeQVeH7fWU1KgyrNGITvF+Cy5jRezZ4g1OWmPFZNLZBTEVYw+VhxzUuuHaY3jfEEz13ntBBZKva3aznb+wR7ldjDCFUhfgOBXT5xpRsuXSKHrW779xRaONtXnku4jCd440JY=
Received: from [127.0.1.1] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id m3-20020a056000024300b0033b2799815csm3065421wrz.86.2024.02.08.00.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 00:08:41 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: peter.griffin@linaro.org, robh+dt@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
 tudor.ambarus@linaro.org, willmcvicker@google.com, 
 semen.protsenko@linaro.org, alim.akhtar@samsung.com, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org
In-Reply-To: <20240130233700.2287442-1-andre.draszik@linaro.org>
References: <20240130233700.2287442-1-andre.draszik@linaro.org>
Subject: Re: [PATCH] arm64: dts: exynos: gs101: add stable i2c aliases for
 gs101-oriole
Message-Id: <170737972037.52344.9107022607101399076.b4-ty@linaro.org>
Date: Thu, 08 Feb 2024 09:08:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4


On Tue, 30 Jan 2024 23:37:00 +0000, André Draszik wrote:
> Now that we have more than i2c interface, add aliases to ensure
> deterministic bus number assignment.
> 
> So as to keep compatibility with existing Pixel userspace builds, use
> the same bus numbers for hsi2c_8 and hsi2c_12 as the downstream
> drivers with the intention to eventually add all the earlier busses as
> well.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: exynos: gs101: add stable i2c aliases for gs101-oriole
      https://git.kernel.org/krzk/linux/c/72ccd925dcbd2ad6935a4874679b6cf5b3de7156

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


