Return-Path: <linux-kernel+bounces-167989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 848558BB1F1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 19:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6C521C21941
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 17:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF551586F1;
	Fri,  3 May 2024 17:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHBnhkNf"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C02158219;
	Fri,  3 May 2024 17:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714758763; cv=none; b=ErlMyvl619DK31vKE543BjtUqNNIBrfHXke6DIChK3Va1gRlR/28pcsqhZruYNGdpJexeY7nyfHPoAzQxSOOefcaRjxvU4FxH9gI8k+DZ6gHfFa98h9JDMZPLNxRt6uLtPxwXDFvcbfuJ4rRZ6C8XyuRUyrJdFaU3CKVffzsjTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714758763; c=relaxed/simple;
	bh=lzVnrSjci3YdZbJDcigjVDnutqYD0vEbfrujcq5AHHs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kx6rgwmJDiz1z7RcsAdiTZLNOOY2vlw52ChjQ1R64gapawoNZS9Cctckp0WGy6RGtbDzpp119WXmcqEl7LNFjK8y+R0ld03VVkcBYjSp5LzZrZVN14jIzkZ8ml5c37wUL2S91/uI4te3xzENHr4o+Y6CMNyiW9JX5C/o9bRRwG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fHBnhkNf; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a5894c1d954so462406166b.1;
        Fri, 03 May 2024 10:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714758760; x=1715363560; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nDa0e4iujX0ACKE4cFSjYtiiXZ+21EvsOzvNajBTvcI=;
        b=fHBnhkNfFgY0EOvMbeVCSgUkK7B04ewgHLaKvupBI1FHbml3mOuJNEtp4z3KnDfxnP
         q/kpD0T4HiVuwFL0hzy/8ZE73zCE3GgCyoFHSwTqzKksgDaMMNnLm7kFmEHveYVR5Src
         YXEmQyX5QUeLdOF5PQ8IsAyZ6QXAPeue/CP1RzyBIg2hZYlVNhpb0Pm2ab+X6946Y+an
         x9LMs8Tnwo02wbyE+f8xZQQLQdkv1XJVdJ6N3fdMRQxPd6fU8rl5s1h4axpsQAkYCDCT
         h/8VKiGbPhwq56kNy+kXIdjb6pvFeQwx72K2b75ExFzx+K7llCFwQH68VOTtfKfSFU9o
         gkqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714758760; x=1715363560;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nDa0e4iujX0ACKE4cFSjYtiiXZ+21EvsOzvNajBTvcI=;
        b=LEAj6ZkKB/Gzuip3jB6vw7KmUtWNXJb/CnZrFKXCl53KJttPngkg6zRoUdkNqEyEsI
         FncKm1W2eqF38E3HUDbQffM0tPOtwZ8c3/MqfHwQYspzZcneeQTMiuKmtQZZL50ocqdN
         9L4NL5nrZfivnMGMUGzUU9r1T+dOqUSRVihH3Rt48iOeR+XHcJ0mTcatMXKiU5gPQmzV
         l5YrsJPl4tAgBiftbHy7h/CUlVjvKGZrUhGP3ke/Cuisj9suOMzSOIEEwiN7qCSfFmHn
         4qSPIaPz5b8VwplAQf25mEjQtJdo251Fu8LWaaU/9/kHVZ12d5HlUVfnC5Vl6CHA9z1N
         y13w==
X-Forwarded-Encrypted: i=1; AJvYcCUKfcPbNup11HdOgEIuDb30/ppXFEml47MxXTiR9wpbmDethXSNwaMdepGZV5l/R/xE6zD5l4m3pgN3nIwt3XdhtxBaItTAoJzLKyN9
X-Gm-Message-State: AOJu0Yy4sgNylC9OgJUrFGg9xvoB/S6GdsZGsVICfGsnowSkJ3O1HfVZ
	QjIc/MN9VQZ4+qdoPJEyjDQB1+xPX8yLIkpXn4h3kIw84KdNkaovYFLSc2wcOjE=
X-Google-Smtp-Source: AGHT+IFONK2j7f1Ty9XVR60wDESk+CJEsa1zFEF6TM1ALYU3+/t6lQ5A3HkIW/azPODD5tAnbepFfw==
X-Received: by 2002:a50:9549:0:b0:572:3483:8a27 with SMTP id v9-20020a509549000000b0057234838a27mr2688603eda.33.1714758759958;
        Fri, 03 May 2024 10:52:39 -0700 (PDT)
Received: from [127.0.1.1] (84-115-213-47.cable.dynamic.surfer.at. [84.115.213.47])
        by smtp.gmail.com with ESMTPSA id q28-20020a50aa9c000000b00572469a7948sm1968368edc.45.2024.05.03.10.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 10:52:39 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Fri, 03 May 2024 19:52:33 +0200
Subject: [PATCH 2/2] cpufreq: sun50i: replace of_node_put() with automatic
 cleanup handler
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240503-sun50i-cpufreq-nvmem-cleanup-v1-2-0a2352cac46b@gmail.com>
References: <20240503-sun50i-cpufreq-nvmem-cleanup-v1-0-0a2352cac46b@gmail.com>
In-Reply-To: <20240503-sun50i-cpufreq-nvmem-cleanup-v1-0-0a2352cac46b@gmail.com>
To: Yangtao Li <tiny.windzz@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714758755; l=2545;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=lzVnrSjci3YdZbJDcigjVDnutqYD0vEbfrujcq5AHHs=;
 b=EOd+5S8zrky1F+pf72NRCJOPHcqlppmlIu7H4SxMTuZa8DO0mns86VbChhQoq1UQhqm1esOuH
 iDf9qDV2t7qDx8DC46feRuLOrY1zGZIHAzv0ufxTYPAlC0XNm2P0FzB
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Make use of the __free() cleanup handler to automatically free nodes
when they get out of scope.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/cpufreq/sun50i-cpufreq-nvmem.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
index ef83e4bf2639..eb47c193269c 100644
--- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
+++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
@@ -131,14 +131,14 @@ static const struct of_device_id cpu_opp_match_list[] = {
 static bool dt_has_supported_hw(void)
 {
 	bool has_opp_supported_hw = false;
-	struct device_node *np;
 	struct device *cpu_dev;
 
 	cpu_dev = get_cpu_device(0);
 	if (!cpu_dev)
 		return false;
 
-	np = dev_pm_opp_of_get_opp_desc_node(cpu_dev);
+	struct device_node *np __free(device_node) =
+		dev_pm_opp_of_get_opp_desc_node(cpu_dev);
 	if (!np)
 		return false;
 
@@ -149,8 +149,6 @@ static bool dt_has_supported_hw(void)
 		}
 	}
 
-	of_node_put(np);
-
 	return has_opp_supported_hw;
 }
 
@@ -165,7 +163,6 @@ static int sun50i_cpufreq_get_efuse(void)
 	const struct sunxi_cpufreq_data *opp_data;
 	struct nvmem_cell *speedbin_nvmem;
 	const struct of_device_id *match;
-	struct device_node *np;
 	struct device *cpu_dev;
 	u32 *speedbin;
 	int ret;
@@ -174,19 +171,18 @@ static int sun50i_cpufreq_get_efuse(void)
 	if (!cpu_dev)
 		return -ENODEV;
 
-	np = dev_pm_opp_of_get_opp_desc_node(cpu_dev);
+	struct device_node *np __free(device_node) =
+		dev_pm_opp_of_get_opp_desc_node(cpu_dev);
 	if (!np)
 		return -ENOENT;
 
 	match = of_match_node(cpu_opp_match_list, np);
-	if (!match) {
-		of_node_put(np);
+	if (!match)
 		return -ENOENT;
-	}
+
 	opp_data = match->data;
 
 	speedbin_nvmem = of_nvmem_cell_get(np, NULL);
-	of_node_put(np);
 	if (IS_ERR(speedbin_nvmem))
 		return dev_err_probe(cpu_dev, PTR_ERR(speedbin_nvmem),
 				     "Could not get nvmem cell\n");
@@ -301,14 +297,9 @@ MODULE_DEVICE_TABLE(of, sun50i_cpufreq_match_list);
 
 static const struct of_device_id *sun50i_cpufreq_match_node(void)
 {
-	const struct of_device_id *match;
-	struct device_node *np;
-
-	np = of_find_node_by_path("/");
-	match = of_match_node(sun50i_cpufreq_match_list, np);
-	of_node_put(np);
+	struct device_node *np __free(device_node) = of_find_node_by_path("/");
 
-	return match;
+	return of_match_node(sun50i_cpufreq_match_list, np);
 }
 
 /*

-- 
2.40.1


