Return-Path: <linux-kernel+bounces-167452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE058BA9C4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 11:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50B9A1F2541C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 09:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469A3153BCC;
	Fri,  3 May 2024 09:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m3ujW7ck"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D47B15381E
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 09:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714727945; cv=none; b=TKq94l8gnUenwnDLsZzQiR5DlxCPFGb2EbFZ8q5F9/k1mRkWAJqCZIMr8gDa1ihSQ+HRr9SYmecwg6HNUTJK0HbJd1pAYS0giqrcysJPFJ+QpK9hd3oZUN2VGYl1snpjsaYGAP0B4AEmbpo5Mr7WG/Oel55GwuQoxy0NY5cMWwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714727945; c=relaxed/simple;
	bh=0st2HobpNox1lw9rfTM0Izpmujgy1vssbMv9Vmn3p4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iVbAjWz6B1L9OBg4sWKjGVsZjetHUbGHSEIIFbFA/9ZAyBRTcbH3qDOYae02dPkvUC4hpgn8uTmg0YvpEez5PcgUON0pyPT0lz344hdBmkpzA2AuSiGIFSnutVjf0Xyh+sThzMZfQBkkeWwWRzUacIJv2Dp+TLNcdY93R+j/1CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=m3ujW7ck; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e46dcd8feaso5275152b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 02:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714727943; x=1715332743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hkEHTBQxR1IAOMp6Di+8t+w03Mn2F1ACoLhl2VS9uYE=;
        b=m3ujW7cky9Trd8BhZnN2Ty/1+lBol3GrzKwLLT8nG3zu1O+EsCPWk1XDQXx2RL1l/c
         EzFFVT2k5mij/RwR78T+7xXqqouQNHiIww4KLmeHE8hGJDyemgV0cxI5AD191P3bU5QN
         yyyxj+kg5W+9clYqJWmVEnQlO/NiMy27JgFNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714727943; x=1715332743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hkEHTBQxR1IAOMp6Di+8t+w03Mn2F1ACoLhl2VS9uYE=;
        b=B1sZQjx4xC3Lpq2D4qQ9nd/50+Tx5ZU/UQaF4fQWP25yXahQlkUx/sQbdcK/xxehD0
         hGJWrdW8UbjCqdREke/xg5Gp3k83j+xulVb/07Jw+qHxXRGYbamzzyW7KADgom1Oe4b4
         B79iIgly83il3DGcH22rcUMtcrb0VGA2MzwohK+yL8dmPstnMgd3d4RjIXFby0saHag5
         Y3kRrkBJmkcGl1AJV8eiaXTLct4kY6CtwWKpxj5odYj8SAZcOsuEv6lQMG+CPGQdTHpm
         AD5hpdhzAb9Vmg1iRCQ+UZiUJdJBi6hbLF9UmesbuyiU5TSMPaz1RwvOT8GE7IUgerdB
         MPAA==
X-Gm-Message-State: AOJu0YzNGKQPGPn/gIdsyHKbo6j2+EVZXQIsp+aT7eEagYsRzUDNn39P
	aIiSwxx8sXuPK4MBdMaCpGxY4YCG1gXCpI3YD2adzN3670Erafzs7ys5ZD+HLf9pM9FfcuFFFH0
	=
X-Google-Smtp-Source: AGHT+IHPfkg+X9GkqI+WL5uh/PWaBh9iygZx9qFc257y4/YG1wrDms+rR+hPW8EPaj7MxNhEKY0ihw==
X-Received: by 2002:a05:6a00:140b:b0:6ed:332:ffbc with SMTP id l11-20020a056a00140b00b006ed0332ffbcmr2011169pfu.20.1714727943515;
        Fri, 03 May 2024 02:19:03 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:dc60:24a3:e365:f27c])
        by smtp.gmail.com with ESMTPSA id j6-20020aa78d06000000b006ecec1f4b08sm2621938pfe.118.2024.05.03.02.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 02:19:03 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH 12/14] zram: add support for dict comp config
Date: Fri,  3 May 2024 18:17:37 +0900
Message-ID: <20240503091823.3616962-13-senozhatsky@chromium.org>
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

Handle dict=path param so that we can read a pre-trained
compression algorithm dictionary which we then pass to the
backend configuration.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 89a2eb37e26c..c50283c7231e 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -33,6 +33,7 @@
 #include <linux/debugfs.h>
 #include <linux/cpuhotplug.h>
 #include <linux/part_stat.h>
+#include <linux/kernel_read_file.h>
 
 #include "zram_drv.h"
 
@@ -1013,9 +1014,23 @@ static int __comp_algorithm_store(struct zram *zram, u32 prio, const char *buf)
 	return 0;
 }
 
-static int comp_config_store(struct zram *zram, u32 prio, s32 level)
+static int comp_config_store(struct zram *zram, u32 prio, s32 level,
+			     const char *dict_path)
 {
+	size_t sz = 0;
+
+	if (dict_path) {
+		sz = kernel_read_file_from_path(dict_path, 0,
+						&zram->configs[prio].dict,
+						INT_MAX,
+						NULL,
+						READING_POLICY);
+		if (sz < 0)
+			return -EINVAL;
+	}
+
 	zram->configs[prio].level = level;
+	zram->configs[prio].dict_sz = sz;
 	return 0;
 }
 
@@ -1035,7 +1050,7 @@ static ssize_t comp_algorithm_store(struct device *dev,
 {
 	struct zram *zram = dev_to_zram(dev);
 	char *args, *param, *val;
-	char *alg = NULL;
+	char *alg = NULL, *dict_path = NULL;
 	s32 level = ZCOMP_CONFIG_NO_LEVEL;
 	int ret;
 
@@ -1063,12 +1078,17 @@ static ssize_t comp_algorithm_store(struct device *dev,
 				return ret;
 			continue;
 		}
+
+		if (!strcmp(param, "dict")) {
+			dict_path = val;
+			continue;
+		}
 	}
 
 	if (!alg)
 		return -EINVAL;
 
-	ret = comp_config_store(zram, ZRAM_PRIMARY_COMP, level);
+	ret = comp_config_store(zram, ZRAM_PRIMARY_COMP, level, dict_path);
 	if (!ret)
 		ret = __comp_algorithm_store(zram, ZRAM_PRIMARY_COMP, alg);
 	return ret ? ret : len;
@@ -1102,7 +1122,7 @@ static ssize_t recomp_algorithm_store(struct device *dev,
 	struct zram *zram = dev_to_zram(dev);
 	int prio = ZRAM_SECONDARY_COMP;
 	char *args, *param, *val;
-	char *alg = NULL;
+	char *alg = NULL, *dict_path = NULL;
 	s32 level = ZCOMP_CONFIG_NO_LEVEL;
 	int ret;
 
@@ -1131,6 +1151,11 @@ static ssize_t recomp_algorithm_store(struct device *dev,
 				return ret;
 			continue;
 		}
+
+		if (!strcmp(param, "dict")) {
+			dict_path = val;
+			continue;
+		}
 	}
 
 	if (!alg)
@@ -1139,7 +1164,7 @@ static ssize_t recomp_algorithm_store(struct device *dev,
 	if (prio < ZRAM_SECONDARY_COMP || prio >= ZRAM_MAX_COMPS)
 		return -EINVAL;
 
-	ret = comp_config_store(zram, prio, level);
+	ret = comp_config_store(zram, prio, level, dict_path);
 	if (!ret)
 		ret = __comp_algorithm_store(zram, prio, alg);
 	return ret ? ret : len;
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


