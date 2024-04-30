Return-Path: <linux-kernel+bounces-163578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FCB08B6D4C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A48851F233C1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CD4129A6F;
	Tue, 30 Apr 2024 08:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uiUAHEJX"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FF2128826
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 08:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714466985; cv=none; b=EIwHIAhQRWG8WhOJDQo/pHPx23pxVPfuJsT2Fv2Yi3mlsdSd47v87+541PEnLsrJUdSd/ClUCRHxZptaHC1jqdYh6f7TFskDD7Zh8xyTaSnrSnU1S7Kl7I9zkPPdNFZpSi/FeSTK1lQyqZyZ28KIukn7+42ss2xMTWkfJ0yduRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714466985; c=relaxed/simple;
	bh=J8yxyFAtZQY9Dhgv7KXeZ4Mx3MLCOjba/Xn3sBIA4ak=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dGLlvAVnCz09A411cQvIRtv8jQ5JB0fSoA1f+Hc596PGIagLkrRFpBr2Cby1pDPXIiKlt1c8LjEH+ngjjPwHddrcYw1lbTWv5iQU+sZe+HA+KZ40bfI63PxfulmY5bsUDgkdN1fw3zfTxCCry3MRZqh/lHVtBCWFWWuAveXJRrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uiUAHEJX; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41b79450f78so29867025e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 01:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714466982; x=1715071782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UTOWm6ffUCb1fQAfPlYZjNwQ+bKxiRsAzYNUfxIcgfc=;
        b=uiUAHEJXIVqMPfbblwKCM0SKmNf2z85VJODHqDRGQAs2LUrTDnM/qiizWhFIkGy4LS
         YahbOGER1OC8rY+0YnoK2XvBREKkBtuJVPa5gRYQpmRH6E6+zi7i7znJiGRTZxVTlVEk
         ojd59E3XWGGtVHfTTZyzFs50cPP6Y9tWKYJyUXuau4FwUjQ9hSTBt5hHvR/zfqvO/Zkw
         4ZoPzsTk5ZOYW19ZnNzqPHZ0me6HNQbQ/Zz9J/V9NPXPV9irPq5SWiahGf/VmUsFmNYw
         PaQV3AS46alCS3qc9jWAxjG4NubGWdTsHVm4sJWB9zQUfqM4dCg2M3fpz8JVLoGGwfne
         IrWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714466982; x=1715071782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UTOWm6ffUCb1fQAfPlYZjNwQ+bKxiRsAzYNUfxIcgfc=;
        b=pu1tSvvnzdNnd4A3wgvvvpwjnVzis9c10BonIgrBWPflIv7rz3Rn2+n0INx6JLTyf4
         DSxSzDt0Yqa8Nh51jDHTIDaSfjiahR4/PvTK+6xVFe3WWn4qlRHPD7QNuQwmHTmeeiRh
         lPwDbsgsOhHOgWQQRHaDR+afZqtkCe3s5JiIcc7Mv150w86PTKCXpt9HjRj1dXHI2RWe
         HFq41PsOu3AHELgugYv+8xnk2x8NkRwy3CDwWARlbOWpRPZ4Ryn45hCZlHzPnrKfBmpw
         gXP3HSpilDV8NLhAauUktOBTrE0Zeap/OHuiWi9gseXBmQ1wYPdJkwrxEkd2UWX08OG/
         kjAQ==
X-Gm-Message-State: AOJu0Yw+bZesLj4f1YRbrbEXvUjt0+5S/VWFcsyTwF/7+qyKL+ObPd7m
	hb/Qr6kSOPIsVpN70KJYg7FxWDZEQPZL0qJGbOhZIKOBgBGz67WWGYg50SQmPmeKM/k1CSESCA5
	5
X-Google-Smtp-Source: AGHT+IEb8NnCjFuVS1HVB6kzHpSqNmvhGweumdUcJDQdIIlu3vrII+o7hvllynqYD+VXlQexpnaA/A==
X-Received: by 2002:a05:600c:474d:b0:41b:f106:bb89 with SMTP id w13-20020a05600c474d00b0041bf106bb89mr8297530wmo.18.1714466982044;
        Tue, 30 Apr 2024 01:49:42 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id q6-20020a05600c46c600b0041892857924sm44490309wmo.36.2024.04.30.01.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 01:49:40 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 04/11] nvmem: sc27xx: fix module autoloading
Date: Tue, 30 Apr 2024 09:49:14 +0100
Message-Id: <20240430084921.33387-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240430084921.33387-1-srinivas.kandagatla@linaro.org>
References: <20240430084921.33387-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=817; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=1szAbvATvwsifYrHEbSon3Ghug4/Usl73JU79h0w9HI=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBmMLCMHk280d35qsyhI5qxUbgYY6DdbPPl9q6rz rWl5CtCv8WJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZjCwjAAKCRB6of1ZxzRV N5ALCACxRmOoULqjWiAjNBDDVKxGt+1+mu1n/DvSwakKjdfrOhum8vBEo/tNOaNg3X4m0BCjGDa +6ztUZJG043zUdrzTg9Gbxq9WverL3he+fKbL3L+oueTR8bXltgzmui5I3yuU/VwQ7iUMzXeySa THMhZzDZmQOKoXNGAlxGpDTKMr3MXMfiEA0m69ursnimiUqqiGJtG4/Q8RtKQi705z4mWzWev1S NqF3K6nDm28p24SxuTtPpSAEwwJ/GwdYa2XKftvEUxHRS0BimZirD7FKcN5B1K+uYofAIPVIQ5c qbK1/kzhkLwMsPElXW0WP5X7bjgJLiiFH3FVFoQnwzPOIMMc
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Krzysztof Kozlowski <krzk@kernel.org>

Add MODULE_DEVICE_TABLE(), so the module could be properly autoloaded
based on the alias from of_device_id table.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/sc27xx-efuse.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvmem/sc27xx-efuse.c b/drivers/nvmem/sc27xx-efuse.c
index bff27011f4ff..4e2ffefac96c 100644
--- a/drivers/nvmem/sc27xx-efuse.c
+++ b/drivers/nvmem/sc27xx-efuse.c
@@ -262,6 +262,7 @@ static const struct of_device_id sc27xx_efuse_of_match[] = {
 	{ .compatible = "sprd,sc2730-efuse", .data = &sc2730_edata},
 	{ }
 };
+MODULE_DEVICE_TABLE(of, sc27xx_efuse_of_match);
 
 static struct platform_driver sc27xx_efuse_driver = {
 	.probe = sc27xx_efuse_probe,
-- 
2.25.1


