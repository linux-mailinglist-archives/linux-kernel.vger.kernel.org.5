Return-Path: <linux-kernel+bounces-40415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1720E83DFC7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 496451C22D86
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E9722EE7;
	Fri, 26 Jan 2024 17:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ybizXlmU"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3931F61F
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 17:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706289368; cv=none; b=o+Ti2b2r7McYNZYjFIUlvcTrl4pMqze8EJajT1QPedO3EEU3w9vFyj2Aj4grVBOFKqY85rdWAXQu+y21egszTlTiF0uYrxBrg/jkJ5zn8qd9LhNIU+V/01tzh6aY9J0AJAOWqohea49rFpmCY5TmBOU4wjm4JdeiSVP0QDv3T2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706289368; c=relaxed/simple;
	bh=qd5gH6HA0zeTl7vAn9ID3bQtUYcxhzqMjBdEahDK+9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SHoyPnuf80KT1SnbUGY2Jdw0y7TUuUc1DGrhIdMUOY6qAivwQxTx5Xm94EbLJuz6ztQinC3Dh9PIppz01+K0WUPOLA9vSC2SvbdzAJgaMZh0xQwkSD/tdK01WVhMOts2y6lBl27gfSwUYTzSN80/7Hzm0p/jXYyHXpkEXUk/W0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ybizXlmU; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40e60e137aaso14176975e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 09:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706289365; x=1706894165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tGTNJGu0ukXFyt9xeb5mPdj6cnncaL6QD7HHX08zdSQ=;
        b=ybizXlmUgcZxVD2fq5vgJRFnwNeBDtqx74C7Dh2yPyZWojprfqebJoCwlAOHvgDXfF
         CPDvLC4+AIeRjHm9sQCQNY+BYaJz/VfY47C7j7kFg00COzsNwhi4RId73Oi18E3kdG6A
         02f1nBrYvVb0HlH6Apptg3XCOTKVY+Fmy40njzdaDXK5A6RwIj2JTf12gSHBwxivNfQQ
         qhLNzN6a+O6hCyC8znVrSJiHw9kKBUKOwwv7rSD84ibyBI4OaCHJHdws4kAEM8M108v5
         T4NzC+eAk4Ab0OmLPWl2x5BoBujX7WTZtIwd1RhKqU/oV7v2bh5uMEVOGLlYXzT95VXC
         hVTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706289365; x=1706894165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tGTNJGu0ukXFyt9xeb5mPdj6cnncaL6QD7HHX08zdSQ=;
        b=G9Mgu3S+t5/13VtxgyRoliyWMXSOZO7GooT/Lce2h0uw9+ttsBpvIRSlXgiSvyMKjf
         otCcxHQYuGlCgJZPQXtNjg5VeD6rL2GzapeGFqZBBnhGZMxFOxrFUixKbUacgpvJVrnf
         KEvI6NdPuNvd7sj0Bb1Va1FIAwCXGHwtTN+RRPNyz0VtwTYiXXuTcG2JC6nzwmCPNYGr
         pXcD9NXMIBI6aXV3HrdokJ/wkGdl08N+GM7u8/PxHbrDjFZkSy88Vf2cPa8Vg7mkfL9P
         iDsOCPmaE9zFSw1vcCKiXW+6as+GkQcvqC72osoO+6Vwkjcz9xerYKVXQQaWmmHLgOGr
         rjQg==
X-Gm-Message-State: AOJu0YynmG0at8K3Y7X+4aunqa6KVJbc8n/ww30S7gjor5UTi5U6pngR
	eBJgJYgRNj7J6I2qHsmiIBCH0K1lDCqToWSAq5uLMzp82piylyNQT6kG5NRrQW0=
X-Google-Smtp-Source: AGHT+IFm06n9bv4+cWRnJ/uDg+/bPG8VRaqfbnFy+FN0Vjs4qRwIYkxG124p37ZXa85vCR++v+/zDA==
X-Received: by 2002:a05:600c:22d5:b0:40e:863e:2f16 with SMTP id 21-20020a05600c22d500b0040e863e2f16mr76277wmg.128.1706289364833;
        Fri, 26 Jan 2024 09:16:04 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id k10-20020a05600c1c8a00b0040e451fd602sm6287286wms.33.2024.01.26.09.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 09:16:04 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: broonie@kernel.org,
	andi.shyti@kernel.org,
	semen.protsenko@linaro.org
Cc: krzysztof.kozlowski@linaro.org,
	alim.akhtar@samsung.com,
	jassi.brar@samsung.com,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v3 13/17] spi: s3c64xx: drop blank line between declarations
Date: Fri, 26 Jan 2024 17:15:41 +0000
Message-ID: <20240126171546.1233172-14-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240126171546.1233172-1-tudor.ambarus@linaro.org>
References: <20240126171546.1233172-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop the blank line and move the logical operation in the body of the
function rather than in initialization list.

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 2f2c4ad35df4..08ba14adb428 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1320,8 +1320,9 @@ static int s3c64xx_spi_suspend(struct device *dev)
 {
 	struct spi_controller *host = dev_get_drvdata(dev);
 	struct s3c64xx_spi_driver_data *sdd = spi_controller_get_devdata(host);
+	int ret;
 
-	int ret = spi_controller_suspend(host);
+	ret = spi_controller_suspend(host);
 	if (ret)
 		return ret;
 
-- 
2.43.0.429.g432eaa2c6b-goog


