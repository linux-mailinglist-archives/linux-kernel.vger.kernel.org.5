Return-Path: <linux-kernel+bounces-125860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDEC5892D2A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 21:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E3461F21CFC
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 20:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80C14AEFE;
	Sat, 30 Mar 2024 20:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mX23JWSW"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7401C1D526
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 20:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711831120; cv=none; b=IazLOxY3DlHBN6kD2E5644R6yR1JQBBJjYJV+WDmtOqwnJkqtjbT3V9FNrbV9SHUoyqxylqD9PeGiSnJWhOUP/gI24snL7B4VldRNx0Tm258IF4wJfk+kPDZAzpPaxUj4RzqRgJW6dwVDbB34fjp67fb9kr3bn+1Foyl7SAoxUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711831120; c=relaxed/simple;
	bh=jnGxk1VSBLxJwPy69dDLCMJiDdecqYYVAuPwT9AmU7I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gSu1T08SaPyUy7cLMO6a+GhXR24eH4yP/p5AEzvPotHblcFUdxR28j07wH+VfnFuFFjf1QMKs8lVAlknCK9lIY//wV2rvGwmx2NqG1dU2vSdHtGDKkjymCZFyEek31RZfGdV2ZnIlPDdO4sLIphRsQxr8IqELFqNxzjU0Nwai0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mX23JWSW; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4155baa696eso2630875e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 13:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711831117; x=1712435917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tEuhNlFy4b3+yhLexNOoFHfsFUeLSaYltIREIoKVZzI=;
        b=mX23JWSWRaDqpT9gDnYgi/tAfFhar0xEQgRF8yiQf8rmrZ4cuuJi7yRgigpAtSmqFN
         HKDql0LL7sQCSoW1sK49XdEzzGQdT40z+Qgl4yztu2BrIRP3iiSNsIhmSlBP0IAn21a3
         dK+m43qQh7s/ad8P3Ke3YD9tXBor/p4QcXt+F/dVsJXzYpVFe5VJ+MaBfgwu28wfS15O
         xETgf+ngnXXCpXktsx6H6CuHi33FZ0RdmvMc7XSwiQTC9P3qXmhGk0LNa4UrZv0QYJHa
         VKymKHOsHvXi8JkHRRBAW7gR21eTV2qBNDCcrNzKLqWL9U3c2HJDBPnd4lxfhV6J2voE
         8sTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711831117; x=1712435917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tEuhNlFy4b3+yhLexNOoFHfsFUeLSaYltIREIoKVZzI=;
        b=GSHTVjNre1fDTh7McOqnP1+AgMWTUFRjXQSXU2xd8ZLgNpt4CkMhl153oTgldQ0DPp
         8GlI+S2tUXInDVpqCIkC9kqqmHyAwzyisw1r+GUAFbIIAB5SqvDPG82eHgxK1W5H/pU+
         hpKPKqm3EBYtOjJfC+ajjKSe9yAG00GkO64P6OESvHyJFG+UCGrQOxC95zp3QhW65450
         eLan+d1rBLaQACbfVYTAMySq2pgO9WQif/jn3S3NUCEiAK0Frn7GgiC2GcB6/QXM1RBa
         w+rObtJ32LTljwcgmbS8HwY7YUD2HCAvNeQCGqsOtpMfFd6dOZXA9W8GMhal3n26dsuT
         6v8A==
X-Forwarded-Encrypted: i=1; AJvYcCW+WFbLb8dZIKFF9iGs99fYqes4+yhq0NMUAU5RrZTeE60s5mzL1o+9Q5PEttfFsmdYxiAPagl4qh6yN46xXUMlmVxeAOaz9CMYs/ua
X-Gm-Message-State: AOJu0YzgFv5AcRa2kdZbvGNNQnMHR/HECR5O+O9UsDI/1cgo1Uulx4bv
	xc5FsH9OPujR5haj+c4/+yTno2FdSfzx51sPnFYxrPXWZdUYyB7WiAiEEQaWmWY=
X-Google-Smtp-Source: AGHT+IHHAQTuIzSwBI4Bu2eK2F2rnc7x4I9zYnB2XZiiedbhLcKRgcKBtNt7iw26Cp3hUzmPb8k/Og==
X-Received: by 2002:a05:600c:1d1d:b0:414:897b:bc2b with SMTP id l29-20020a05600c1d1d00b00414897bbc2bmr3623342wms.33.1711831116903;
        Sat, 30 Mar 2024 13:38:36 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id n14-20020a05600c4f8e00b0041493e21844sm12663154wmq.27.2024.03.30.13.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 13:38:36 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Alain Volmat <alain.volmat@foss.st.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/4] drm/sti: hda: drop driver owner assignment
Date: Sat, 30 Mar 2024 21:38:29 +0100
Message-Id: <20240330203831.87003-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240330203831.87003-1-krzysztof.kozlowski@linaro.org>
References: <20240330203831.87003-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Core in platform_driver_register() already sets the .owner, so driver
does not need to.  Whatever is set here will be anyway overwritten by
main driver calling platform_driver_register().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/gpu/drm/sti/sti_hda.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/sti/sti_hda.c b/drivers/gpu/drm/sti/sti_hda.c
index 6ee35612a14e..f18faad974aa 100644
--- a/drivers/gpu/drm/sti/sti_hda.c
+++ b/drivers/gpu/drm/sti/sti_hda.c
@@ -807,7 +807,6 @@ MODULE_DEVICE_TABLE(of, hda_of_match);
 struct platform_driver sti_hda_driver = {
 	.driver = {
 		.name = "sti-hda",
-		.owner = THIS_MODULE,
 		.of_match_table = hda_of_match,
 	},
 	.probe = sti_hda_probe,
-- 
2.34.1


