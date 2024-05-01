Return-Path: <linux-kernel+bounces-164960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D15FD8B8576
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 07:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 845D91F23D13
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 05:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EC44D9FE;
	Wed,  1 May 2024 05:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6sVQv06"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0E74C62B
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 05:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714543110; cv=none; b=q7SReoXdinSppARxobnu2MOKeEVs37kkn92mhm8CTlL+0/wTJbA5DGGuj86nIXitv8O7wh+MclHLy233OOY53PwzWkK+03KWwWnnF1iaQ4ScmCuZbNQghNKftxHuyP4SNua2ayVLlB6DruS3qN1zBKqB5CVcspoeq7ZwE7LnBrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714543110; c=relaxed/simple;
	bh=qFOxNZDdgb4xgczhp7k/37TYS9T8b5TqtSX9kQNfMB4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OkfGc9RUsy17qey99kJJ+pMThMgZl4yKZyx1WwX9fh1wpx+E3HY7wba7OkV++cZ9RImCLU/RWSQjWcXnrZfl+N3pMHxsvSPmlrblz9+ME8ABtIwwufMdgjYmdVqJm1T1ncrzoVbP4RIAhGr7NbPCc1o0SlkekTeVH/EjZA99iQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6sVQv06; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41adf155cffso46262935e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 22:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714543106; x=1715147906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3hiWw6jP2yYUJTSlYbKDexViseqF5lmbHWHi/tGYz+w=;
        b=O6sVQv06mLAUUVm0+hQoovc1gRErngqbwpquISs31t+A6LHX2z5+EPI/DwRQL35gm4
         xWKEm0kHGAnqe6m5b+HUjnyuTi0d+0FK5H5rsYZl/cUEGwpTBPNrqckg5JB4oeGSz5H6
         4m2UYFBRlyfY/N/SdAi83IbQAJ7bbnxM7ZjOjNXJBvF/KvIsBviueoDHsGzxNawTOfXR
         k4XEFQdGxnFEiyvtaMZsreeF1s1Qy1pu1wtB5Sufx1xloK6e8fE0hrd18TtCwc9QMN0t
         C3Qn6HsvuEFHqNW2taHUjbQgvt8OZjk7cX8zrgqqUxVrHpBdFKNxNwTsMrpUXKaLogDY
         XMrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714543106; x=1715147906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3hiWw6jP2yYUJTSlYbKDexViseqF5lmbHWHi/tGYz+w=;
        b=NFsSKnU/CmPDsvEHJO0489eEXfweo97NMvaqkkWHscSt6XZQo5j8/Bhgyfla9iC/u9
         BW7Q1qTgQihAUavTljobx1DH+gPpD5zNIs1LPzi+Q9J1+GIRFcwHu0SPTzfYG/sHO1mD
         /nLEGYmy/O4fZZ4ZGXQZl6BwH/8IrLO9Hc1q9li/iV0YoOa8PrFNl9Zviarf+LUrS3mt
         sqRgMh/6oIZQaOc6UHuBWbUFg/1rw6R0sVKYrDv4v9UJy2+6gjohHF81y+4UyNbkg+U+
         wmPae5zbCBn2r7lzkcFIjkDW17h5AhGXeUeu+11qkAhAjwSehk5hc810Emj7Ur6gby1K
         iNWA==
X-Forwarded-Encrypted: i=1; AJvYcCVNkTd28z91bpemLE9QIYPaKwflGqWtwI1AVdsGzehUV+Bx30CQhaa5GrEV8Q17DgPqpBDkFVzo6pueUyas8+qGF4y0/n/qES/4cXkD
X-Gm-Message-State: AOJu0YybJgALOJImEd0n2V79LiMmHuVhMx24xePidwGOfA/bBMTH3WGp
	89PaScBWaOAUReilCX7jG3T9SuEiaVCFTCP4dfSyOZIvURte3PUR
X-Google-Smtp-Source: AGHT+IGSsffDeCqMeZYpwWvnrTyvTJE6ovsRobFE+nE77rXh8klVag5MujXA89iVOdsPZMVzGiBzuA==
X-Received: by 2002:a05:600c:1988:b0:418:f5a9:b91c with SMTP id t8-20020a05600c198800b00418f5a9b91cmr965776wmq.33.1714543105688;
        Tue, 30 Apr 2024 22:58:25 -0700 (PDT)
Received: from YOGA.local ([2a06:c701:737b:ef00:e314:db5d:b033:4fc2])
        by smtp.gmail.com with ESMTPSA id s7-20020a5d5107000000b0034c61e211a5sm12451390wrt.63.2024.04.30.22.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 22:58:25 -0700 (PDT)
From: Shahar Avidar <ikobh7@gmail.com>
To: gregkh@linuxfoundation.org,
	hverkuil-cisco@xs4all.nl,
	andriy.shevchenko@linux.intel.com,
	robh@kernel.org,
	felixkimbu1@gmail.com,
	dan.carpenter@linaro.org,
	krzysztof.kozlowski@linaro.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] staging: pi433: Rename goto label.
Date: Wed,  1 May 2024 08:58:20 +0300
Message-Id: <20240501055820.603272-3-ikobh7@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501055820.603272-1-ikobh7@gmail.com>
References: <20240501055820.603272-1-ikobh7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use destroy_class_and_remove_dbfs instead of unreg_class_and_remove_dbfs.

Signed-off-by: Shahar Avidar <ikobh7@gmail.com>
---
 drivers/staging/pi433/pi433_if.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index c8c1d296184b..4fffd7007040 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -1409,11 +1409,11 @@ static int __init pi433_init(void)
 
 	status = spi_register_driver(&pi433_spi_driver);
 	if (status < 0)
-		goto unreg_class_and_remove_dbfs;
+		goto destroy_class_and_remove_dbfs;
 
 	return 0;
 
-unreg_class_and_remove_dbfs:
+destroy_class_and_remove_dbfs:
 	debugfs_remove(root_dir);
 	class_destroy(pi433_class);
 unreg_chrdev:
-- 
2.34.1


