Return-Path: <linux-kernel+bounces-152696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFA38AC306
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 05:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F19421C20A1E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 03:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EADAB12B87;
	Mon, 22 Apr 2024 03:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Er5qu7FT"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8923DF49
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 03:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713756683; cv=none; b=aMwTdOGUgy47NITI6DbNG70xjEUQW1g5c9nAq1MvSoQXrqL719kMti0nTcRPyD340HpB3WyyJ5KNAlL7c+5Bqz8ixPkfY1COhhEnNnqM6QSxzrW5aReJOZ8TikwaATHw1pfeZYfzdX1V6c+KOO27IrMqFCwYFa4B4Wv+viogJgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713756683; c=relaxed/simple;
	bh=WgJQBh8J1Waa7dt3AUnqHF0bETc6Ofj/zz3UpXYRizY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kJuvqhUOWh/Pv2HOYUMNRIKbdtgVXqdoOw5TaixDS+CF+tf+njtNescvoQKP6Id+3OTf0+YjN6TrWrGNRgDA2SGJ54LEXIv4zEVPcIceX3fRm3G5sRGNooODFX3PFii6vJYMkns288bEnMMXFHqy1ejUkiZagbI76a9OBGzj0UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Er5qu7FT; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e3ca4fe4cfso27271495ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 20:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713756681; x=1714361481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Li3+1Ghj2slvXiv+/E7e/F9kDJtZLuXuC3BIKi+jfUc=;
        b=Er5qu7FTKrIPEWR48uAEX1DLYS3VrpieX1PAzPUN2S1jtCYeQcEqGhZymduJGj6U+t
         avDkS3SfYje394nnAdXeQX9DD86J8sH2kAd0D1+HfnuqL41j/NULtAJF/IOyrCTFSox2
         ftmMIQfgnDacyeH+vaHHqdWo2A1t+bRxe5UZhG/zO8bGNRKPjMuOYpUUiZVFCD74ZFua
         cNfatV6U+bwdYUHaTqJ6d07qjLw9/Y6X1UvoajhziCHJiemYdgFquIkaKqhzdlMcz2Me
         z84rjr7izdmwmlucBWp7PTsmCKwHRe/mByVCEso/21+FovunMHfQa0vnyomYhkZrVOdY
         eVLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713756681; x=1714361481;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Li3+1Ghj2slvXiv+/E7e/F9kDJtZLuXuC3BIKi+jfUc=;
        b=UVrZEJnlpmal+dNSvh9ZPpznEGjPBLZyQcOEBt2ZF3PL6Q5EDrRMseY9IRtCKL3VFi
         kbN2oxeEpXxvhq63uwtmv0DYrQrzDABTCTecpU/KM39f2il74CRgje/hfxKacI3EnCYO
         xmvvjOfzrCwFg7ZsQV/JyKuobll2JNxt5T3oiyxghWVJhJkfoqiqvyVnrYAI99jBMngC
         MS+ThNlrnunx1X6U81AGMLbe9DI9KtfqFHM9bZn9R6AQqBxpLZzT7mcgZf0ymsRWSymJ
         NuGstp1Dz9TDAVurTi0SKoqAdDtyiY6RW5K4DGkxWiBH0/V7OZKcTOEipcP216vubQFv
         zKpA==
X-Forwarded-Encrypted: i=1; AJvYcCV/bgeXBAtS45wtDELaEnM1k3eVAkPS7yurk+HOK7b/rBpV1ggqUydugJuhpounEezv4z3qcoNwLnZ75MIBUEgvdM9ko6e+Vk2DCmpC
X-Gm-Message-State: AOJu0YxNqAZRkd9CU1sOk5x53fUFbn24k2pWE277ke4Ft2JZZkKfRl9r
	YppEARBpVo3wTUObE3tn3Iuf3eQlIeA5U/QBn9hJvh4ZphrIXdvZi6Ox8ipMUYw=
X-Google-Smtp-Source: AGHT+IEGPELzo18c9HmsXyfk6vYoiNKnZbbOrQi5Dlekvq6DhkR5uumMN7p3RYSBJx4+oqieaxGcdQ==
X-Received: by 2002:a17:903:244b:b0:1e5:5041:b18a with SMTP id l11-20020a170903244b00b001e55041b18amr11845236pls.40.1713756680930;
        Sun, 21 Apr 2024 20:31:20 -0700 (PDT)
Received: from localhost ([122.172.87.52])
        by smtp.gmail.com with ESMTPSA id w5-20020a1709029a8500b001e435350a7bsm6981020plp.259.2024.04.21.20.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Apr 2024 20:31:20 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Yangtao Li <tiny.windzz@gmail.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	kernel test robot <lkp@intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: sun50i: Fix build warning around snprint()
Date: Mon, 22 Apr 2024 09:01:09 +0530
Message-Id: <285de20a187f3e4baeb28f639b5bf55e914a3821.1713756666.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Sun50i driver generates a warning with W=1:

warning: '%d' directive output may be truncated writing between 1 and 10 bytes into a region of size 2 [-Wformat-truncation=]

Fix it by allocating a big enough array to print an integer.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202404191715.LDwMm2gP-lkp@intel.com/
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/sun50i-cpufreq-nvmem.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
index 30e5c337611c..cd50cea16a87 100644
--- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
+++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
@@ -19,8 +19,6 @@
 #include <linux/pm_opp.h>
 #include <linux/slab.h>
 
-#define MAX_NAME_LEN	7
-
 #define NVMEM_MASK	0x7
 #define NVMEM_SHIFT	5
 
@@ -208,7 +206,7 @@ static int sun50i_cpufreq_get_efuse(void)
 static int sun50i_cpufreq_nvmem_probe(struct platform_device *pdev)
 {
 	int *opp_tokens;
-	char name[MAX_NAME_LEN];
+	char name[] = "speedXXXXXXXXXXX"; /* Integers can take 11 chars max */
 	unsigned int cpu, supported_hw;
 	struct dev_pm_opp_config config = {};
 	int speed;
@@ -235,7 +233,7 @@ static int sun50i_cpufreq_nvmem_probe(struct platform_device *pdev)
 		config.supported_hw_count = 1;
 	}
 
-	snprintf(name, MAX_NAME_LEN, "speed%d", speed);
+	snprintf(name, sizeof(name), "speed%d", speed);
 	config.prop_name = name;
 
 	for_each_possible_cpu(cpu) {
-- 
2.31.1.272.g89b43f80a514


