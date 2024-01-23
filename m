Return-Path: <linux-kernel+bounces-35049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B425838B0C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE8251C2074B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D235C61A;
	Tue, 23 Jan 2024 09:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W+isd+PV"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2F75BAFC
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 09:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706003705; cv=none; b=CDwwIjp62Uzgs72LdTvBX6LlQ4fBBU+0d3tZs4VncHhzGx/PTfxW2uZ8trh5Fh8DTdEFFRP3AHAuLcX4UIfh4OZpMoVz+dwbfTehIMk7voKaohctairuw6nAwJQf9aGnY9yw1CBMn1uDPY3y0svw2ybUUM/x1vYxwRZ/k1BGS6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706003705; c=relaxed/simple;
	bh=LDx4x+PbphlW2IlWmkbie/u9O6xlW/ljOSnG6So+pg8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=e0JvVd53cn0D8uC6rRDdjqjSVMbwUEiHRrSm/Zx1cLHuvmQXb2bVXHg5atEp2yx1YbzfHp/+9qxBBibPQESUwy7Jnyq0Okr+DdN7eRPX62w4nYMZYn1QxGs6asuKNZJFCPvMJ7lmZbk+4/7SC0sQqtUi30Xw8qYNnVPTo1B88Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W+isd+PV; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40e7065b7bdso48839225e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 01:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706003702; x=1706608502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vp9Qkxpyl0SLEsF0UAyLTjA2Ib2sT1Vds4gNvwsTHtA=;
        b=W+isd+PVkpKZAZlJa/La6hQJ7aq4WeQScSZoiD1yvp3/b0RelDkyDhprN99bfNXMKE
         G4swfqKBPYvUnBZb5bOX7sg+AypvpQKYMAmLb5Xsej2gIYd415XKIAVHiyiR6d/3omrB
         8bwlwOKK5fJJ40w/AEcIAAMJ3EBQz8Al8mfQdNdyiEnssyOueMrrtVUEzoFwaAPEhl2B
         Dq5jP81DbALgm/+LboaqOE7mlA7OG0x8Xngj/qEcc3kd+S31Zv4LKSFVeo3WFBojHVjV
         ME23vCcgPF1T4Vmqg2wfALxPxbTcPZRo26IKnw8fidmUWIeBVdiwGl5hYmNNGmxLi5Jd
         Hu6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706003702; x=1706608502;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vp9Qkxpyl0SLEsF0UAyLTjA2Ib2sT1Vds4gNvwsTHtA=;
        b=BR+AKqQxP3l7FDPV8QjpqYPPmZ6WmrVBrb6dj1NaJLmkJj04y+kRYQRF70/h6nea4H
         nWg/LJ2kEKuytGzZLPk3h8n3tohiODA9hafPdtyBDNFEAUBO9NFHLmJNeUoQqBKJrdOB
         wQkRSz/uZHplg6ghqzCnlnt6XwTdAf658AQ7ukyYiPdXApqEw+ITkudKgkIaU/lFOYGz
         1kbHJEzP+w/sTxN6lI4dELM1bpTkQaPluozJjSAHjVzwHLBkJKUjrjHqlShOUGkBDhlY
         Whpmcol8BuhFKz9uMK4E22NqYtZ69ix7xCtqgE2JeS3K0FQn2y1dzfDgGAxo8YlkAneC
         QvTA==
X-Gm-Message-State: AOJu0YzxrHPx0tJwikW3jsCha6kk9/XR0W1wgquK+OZ2a+h5tPmvOwZY
	CKgGdwK91oYsNx3IFrx0kE2ChKN9Rm18cMgtGCA7LAO4FQhaiF7zx0w5pNe2g7U=
X-Google-Smtp-Source: AGHT+IG41tP9StehDN0qHxWlZ79Rb04+IOcVI3mvK2WoSqofs3q14dkzZICzZdniGGR2Pr8wx5ufwA==
X-Received: by 2002:a05:600c:4b27:b0:40e:78ee:cb61 with SMTP id i39-20020a05600c4b2700b0040e78eecb61mr235679wmp.94.1706003702005;
        Tue, 23 Jan 2024 01:55:02 -0800 (PST)
Received: from [127.0.1.1] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id l34-20020a05600c1d2200b0040e89ade84bsm21649964wms.4.2024.01.23.01.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 01:55:01 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: peter.griffin@linaro.org, mturquette@baylibre.com, sboyd@kernel.org, 
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: andi.shyti@kernel.org, alim.akhtar@samsung.com, s.nawrocki@samsung.com, 
 tomasz.figa@gmail.com, cw00.choi@samsung.com, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
 andre.draszik@linaro.org, semen.protsenko@linaro.org, 
 willmcvicker@google.com, kernel-team@android.com
In-Reply-To: <20240119111132.1290455-9-tudor.ambarus@linaro.org>
References: <20240119111132.1290455-1-tudor.ambarus@linaro.org>
 <20240119111132.1290455-9-tudor.ambarus@linaro.org>
Subject: Re: (subset) [PATCH v4 8/8] arm64: dts: exynos: gs101: enable
 eeprom on gs101-oriole
Message-Id: <170600369957.35728.5412696474700042763.b4-ty@linaro.org>
Date: Tue, 23 Jan 2024 10:54:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4


On Fri, 19 Jan 2024 11:11:32 +0000, Tudor Ambarus wrote:
> Enable the eeprom found on the battery connector.
> 
> The selection of the USI protocol is done in the board dts file because
> the USI CONFIG register comes with a 0x0 reset value, meaning that USI8
> does not have a default protocol (I2C, SPI, UART) at reset.
> 
> 
> [...]

Applied, thanks!

[8/8] arm64: dts: exynos: gs101: enable eeprom on gs101-oriole
      https://git.kernel.org/krzk/linux/c/c68efa676ca8febfd36aab50fe747c072c224d52

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


