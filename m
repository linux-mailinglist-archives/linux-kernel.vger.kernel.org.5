Return-Path: <linux-kernel+bounces-131429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB968987C8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 993A529033A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46FD12C7F9;
	Thu,  4 Apr 2024 12:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cdnR94Ie"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A049136651
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 12:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712233656; cv=none; b=HscKYKH2uZJQOJQYfgNHmSsy4R617y3wNnBO0XQFe/G2o6FBAEHDxRgSOdnDH24/K5bvKcim6PZrf89LmkvKkLzZ20OzpluBz4AMNT+clkX7S4Aa00n0QgVEitHJpXGU0kKV1inTYgHkIkp9hhyILYD0Brt+aA31lMDymH9XzGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712233656; c=relaxed/simple;
	bh=6E4PP5FfeLNXR6MMeKA2Ut8lL0g1LcQs4+c0K06ivCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P1tVpS8/44J+XDPfuq17DoY3bF6m5JiTtN+2cUJr6g+CGaVNTEiEDRPOdUKHdPmsiKDBBbODnTT4zAFlJr9nuX2M8WFW4ULHdesT93xZJXQ0Tq+2jeeTr6k5gA7IIMuY6wTYn8ydjpzhABBEWK0rRBlHf75KnLruimWcklxWka4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cdnR94Ie; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4162b8cb3e9so3273225e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 05:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712233653; x=1712838453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BekuFHDEQz3MItNlFSbu6RpX09gKsg0FByp3fiEppHo=;
        b=cdnR94IeBlsUbQb8jyNe7g2mSQ/NXfeR6aUnmb+mGuScdAiefR0QNooz2xyyvYKY8S
         m9VmZUa+VbjP8RXKfCHtR+ZNcrcVy1W73UWVIWtmpq2fpSo5+2TkedmT1JPU10xy4zx4
         YVd1fHdffQ9BEIVUqf16OYPxEox/CYkaOsruHNQzUSFAWKFSXs0BGx6wm5WZ67MjDyeS
         +BRc6RKUefTq9cn0FHPctDESkjg1/cb0tlBLv8jGdL/Lpzv5UM+D3iNuj0vWBWGR1hL5
         lyl2mSlnkdqP8x/eK3GKd4PIu8kn5YrwVvGOir2wBlJwWqfXxVzyitTrJQdwJdBVLTtN
         3qXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712233653; x=1712838453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BekuFHDEQz3MItNlFSbu6RpX09gKsg0FByp3fiEppHo=;
        b=jVXJggv/M55q5lEYpBPbtHA5j0UwFvvaqD5XQONqYfE+bfhbivPLri5oB8G8lbMn0o
         XRyXf0NBJW9gw7ijwypv7/jjbGNGzg+kASfgyHIPsXgeciqlBFqIJ9DNlwnI1LcGZbWz
         ELgYoSYPt0h9IQeoGy/SA1J+duknMyEiODry9jAdU1Sa6GcxfCpfANoYCd7dqdNaeIxl
         yOS/1S9Up1YRAsvP0vOPzEIeKI1Fpxu/Q6f/Gn1JZ2l9HmW0jR8ga+kTko7tnqRHdoGJ
         9f3J/m1ZatqO1YaCTVwXj7NiUgLQTSDuhYXF4Tgtx3WpjswP6NP0aJwvgs4gA7b90NSm
         68Lg==
X-Forwarded-Encrypted: i=1; AJvYcCWp9+rl8GZe7MbwURsg0oSDdc4Os9kn1kYhD/0DOe87E85eN/MzVOI+TL2zWLLQOJ8vCh3X7IV3nq8gazhbJR5wqyygoSMKVY3PFWcn
X-Gm-Message-State: AOJu0Yxf8u5pJk65hDcSVjp5P3WiYO6j9U/vRYtAQ2O89JkkMDJZTcJR
	WRQSg/MdnycKDowDlVwSOJCm8fGOtJONCkjce7fn+chCGugJ1LbEQRBZYx/nJ0U=
X-Google-Smtp-Source: AGHT+IHo0UA4VkLq9YNMWVrdRmiVEAsMxBZeIPEoAivlBSwwv6+wNOZwB+W4FPP8qAuWikZ3EcwZ2Q==
X-Received: by 2002:a05:600c:54ef:b0:415:533b:1071 with SMTP id jb15-20020a05600c54ef00b00415533b1071mr2319673wmb.19.1712233652986;
        Thu, 04 Apr 2024 05:27:32 -0700 (PDT)
Received: from gpeter-l.roam.corp.google.com ([148.252.128.204])
        by smtp.gmail.com with ESMTPSA id bu14-20020a056000078e00b003434b41c83fsm12106303wrb.81.2024.04.04.05.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 05:27:32 -0700 (PDT)
From: Peter Griffin <peter.griffin@linaro.org>
To: mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	vkoul@kernel.org,
	kishon@kernel.org,
	alim.akhtar@samsung.com,
	avri.altman@wdc.com,
	bvanassche@acm.org,
	s.nawrocki@samsung.com,
	cw00.choi@samsung.com,
	jejb@linux.ibm.com,
	martin.petersen@oracle.com,
	chanho61.park@samsung.com,
	ebiggers@kernel.org
Cc: linux-scsi@vger.kernel.org,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	tudor.ambarus@linaro.org,
	andre.draszik@linaro.org,
	saravanak@google.com,
	willmcvicker@google.com,
	Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH 14/17] scsi: ufs: host: ufs-exynos: allow max frequencies up to 267Mhz
Date: Thu,  4 Apr 2024 13:25:56 +0100
Message-ID: <20240404122559.898930-15-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
In-Reply-To: <20240404122559.898930-1-peter.griffin@linaro.org>
References: <20240404122559.898930-1-peter.griffin@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Platforms such as Tensor gs101 the pclk frequency is 267Mhz.
Increase PCLK_AVAIL_MAX so we don't fail the frequency check.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 drivers/ufs/host/ufs-exynos.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ufs/host/ufs-exynos.h b/drivers/ufs/host/ufs-exynos.h
index acf07cc54684..7acc13914100 100644
--- a/drivers/ufs/host/ufs-exynos.h
+++ b/drivers/ufs/host/ufs-exynos.h
@@ -116,7 +116,7 @@ struct exynos_ufs;
 #define PA_HIBERN8TIME_VAL	0x20
 
 #define PCLK_AVAIL_MIN	70000000
-#define PCLK_AVAIL_MAX	167000000
+#define PCLK_AVAIL_MAX	267000000
 
 struct exynos_ufs_uic_attr {
 	/* TX Attributes */
-- 
2.44.0.478.gd926399ef9-goog


