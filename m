Return-Path: <linux-kernel+bounces-167451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5237C8BA9C1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 11:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D82F2842C0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 09:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F600153826;
	Fri,  3 May 2024 09:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Wak1oHTl"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C48015357D
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 09:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714727943; cv=none; b=inm84u7uT/wACbYn5tOW2MO91IMefdWCdQ58ek+zwNDVmzGNME1ZISzQ4LxF9ffHt0uYUawR9plG6VzIuIRi6X2vre8xBJ4yQ1gLc3Gt2Qtf2gIJA/WpQPurnfUR7t1MpeVF3JG/LCHNuLI4huxVQzZhjU4B212ERCgXHzn2FPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714727943; c=relaxed/simple;
	bh=d4UQf/ZsLZS7cvretx2WXvAFWLig4xky110hNJGk3Zc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uDPD/ytTsRR0q7ujZbBDxu8bKGKFkO7g7Mor279BOcdZ2RyZs57xB7FhGx7kHDL16KAoEGu6Bp81FX7Tt1Js0B/fUCs5RKUwKWQZW7yhJV8Cry5c9GLTKEEGdKo07ASnt6h7pEdvvjq/YCx7LV8x3xe9ZCJtI5vlljgv64NscsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Wak1oHTl; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6eb8ea5ac95so5174145a34.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 02:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714727941; x=1715332741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wIlqiB/ZJyLpyyyQGB102ierEcV1ZXWEtzUdufZbr+0=;
        b=Wak1oHTl2uaiKkf7MnYR72iwjwyMvnQXlj1+VEhs/LpSkQDWx6QU4sQ6KyaOWXwake
         6TvVKjE+r/smGDor5KfYGT+cb+U+izXYyQpyzrynKsIdSfa+CIHrZbOyZCFJ3Heexvzq
         egU9d1fhD0+oFvrBNCOzbT/Kb1NWPpy2llWBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714727941; x=1715332741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wIlqiB/ZJyLpyyyQGB102ierEcV1ZXWEtzUdufZbr+0=;
        b=amaPwxih7ZEddGZFwnA99MnwCTa9oJ3mNIQXWYVlXWrIdZzcmSnfZEbrHezkxQ8EfK
         GQYKzW+r57Ag2hQCfAQ1cfAyVDney+3JFjPCRq97dBpWvUIQsZVPRUuwf7vdrMIMUvd9
         ApSk4iUJsIIu+CnxT2Hdr9uB16cv8/8VhKEdhHBI6Sk6CLvAdtcxU7YHDqblZ3U0+0nP
         xI1HFH4mnFgk3L6bDNnwq4JpW0lsvehrW6l8VUWtA1fpe9PKdgRtkOmkhutcYdC+VYwf
         A/Lkgw25PNPVb//3ChnJiwOzlEJGraFBVx9dJ77TxRWjCr1A7F17AOlkubBHPzNP+d5f
         N/Sw==
X-Gm-Message-State: AOJu0Yzm279E9SleAx/Y5aprTih+4KnoWCho//qZgkqBoXDpE7T39PS2
	282CIsZs28mJyoUbG4mMojf/5hOVJ8oTeI51EvqKKqcKBTFQfJj9T7Tc7zQF1w==
X-Google-Smtp-Source: AGHT+IGbhx7IVSUR92tftAY4BYbWmtRne6bxgDBkITjrGAh1c47LJ+SGuFRRgZDN5gDcxKTPwNUwXA==
X-Received: by 2002:a9d:5f09:0:b0:6ee:39ac:a757 with SMTP id f9-20020a9d5f09000000b006ee39aca757mr2471155oti.21.1714727941257;
        Fri, 03 May 2024 02:19:01 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:dc60:24a3:e365:f27c])
        by smtp.gmail.com with ESMTPSA id j6-20020aa78d06000000b006ecec1f4b08sm2621938pfe.118.2024.05.03.02.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 02:19:00 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH 11/14] zram: support compression level comp config
Date: Fri,  3 May 2024 18:17:36 +0900
Message-ID: <20240503091823.3616962-12-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
In-Reply-To: <20240503091823.3616962-1-senozhatsky@chromium.org>
References: <20240503091823.3616962-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for compression level level=N comp configuration
to comp_algorithm and recomp_algorithm knobs.

Note that zram cannot verify ranges, it's a task of
corresponding backends to make sure that level makes
sense.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index bd8433363cbe..89a2eb37e26c 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1013,6 +1013,12 @@ static int __comp_algorithm_store(struct zram *zram, u32 prio, const char *buf)
 	return 0;
 }
 
+static int comp_config_store(struct zram *zram, u32 prio, s32 level)
+{
+	zram->configs[prio].level = level;
+	return 0;
+}
+
 static ssize_t comp_algorithm_show(struct device *dev,
 				   struct device_attribute *attr,
 				   char *buf)
@@ -1030,6 +1036,7 @@ static ssize_t comp_algorithm_store(struct device *dev,
 	struct zram *zram = dev_to_zram(dev);
 	char *args, *param, *val;
 	char *alg = NULL;
+	s32 level = ZCOMP_CONFIG_NO_LEVEL;
 	int ret;
 
 	args = skip_spaces(buf);
@@ -1049,12 +1056,21 @@ static ssize_t comp_algorithm_store(struct device *dev,
 			alg = val;
 			continue;
 		}
+
+		if (!strcmp(param, "level")) {
+			ret = kstrtoint(val, 10, &level);
+			if (ret)
+				return ret;
+			continue;
+		}
 	}
 
 	if (!alg)
 		return -EINVAL;
 
-	ret = __comp_algorithm_store(zram, ZRAM_PRIMARY_COMP, alg);
+	ret = comp_config_store(zram, ZRAM_PRIMARY_COMP, level);
+	if (!ret)
+		ret = __comp_algorithm_store(zram, ZRAM_PRIMARY_COMP, alg);
 	return ret ? ret : len;
 }
 
@@ -1087,6 +1103,7 @@ static ssize_t recomp_algorithm_store(struct device *dev,
 	int prio = ZRAM_SECONDARY_COMP;
 	char *args, *param, *val;
 	char *alg = NULL;
+	s32 level = ZCOMP_CONFIG_NO_LEVEL;
 	int ret;
 
 	args = skip_spaces(buf);
@@ -1107,6 +1124,13 @@ static ssize_t recomp_algorithm_store(struct device *dev,
 				return ret;
 			continue;
 		}
+
+		if (!strcmp(param, "level")) {
+			ret = kstrtoint(val, 10, &level);
+			if (ret)
+				return ret;
+			continue;
+		}
 	}
 
 	if (!alg)
@@ -1115,7 +1139,9 @@ static ssize_t recomp_algorithm_store(struct device *dev,
 	if (prio < ZRAM_SECONDARY_COMP || prio >= ZRAM_MAX_COMPS)
 		return -EINVAL;
 
-	ret = __comp_algorithm_store(zram, prio, alg);
+	ret = comp_config_store(zram, prio, level);
+	if (!ret)
+		ret = __comp_algorithm_store(zram, prio, alg);
 	return ret ? ret : len;
 }
 #endif
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


