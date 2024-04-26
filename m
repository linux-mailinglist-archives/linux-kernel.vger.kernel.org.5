Return-Path: <linux-kernel+bounces-159883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2CDB8B356F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 749DD1F21CA8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E403143C60;
	Fri, 26 Apr 2024 10:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mepckmim"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84A686AEE
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 10:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714128097; cv=none; b=SJ7DyUDYDxCPNv/BjeoRPBJABd5utgg235kwacXGx9G32cq9YdsUNGxNYO9l2Ka2Pa5LWoXKQD6l8jonvfN6x7uZ5dOIsk7POEnE+oI1hGmm8qmP5a5GLyD1np000mU9PlOSDEzeMtGz2Qa12JRjQM5WfNVRWkqSp7l6hY9KrHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714128097; c=relaxed/simple;
	bh=IMYKiq52emn3Dk5Vs4D46brLTo3TfZSVtNkXv8osBGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nEstJVp71nrp1uzm88fm4dvKYouFbZI525S2EhcMWTk6Tt4ElAEuDtkY6nlW1CbjVRt/OusmUJARuNsnN8cwfUYVWmGSl8wUudldHdWYoNS5smtgHLn1T+LJRsdFV0FiDES6aIIRgUmV7Zi2mJaDdEg54hfQ8GZwLyDUHUClpoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mepckmim; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-41ba1ba5591so1692775e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 03:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714128094; x=1714732894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=InFnIY+p533KdBP4NACQo0sZ0V7hrv1Ldx+BeIELt2w=;
        b=mepckmimJb+K130JwXXKEFDBtihiAAC0iY2SB0BDi8M/J5t6IlOfEBdisVgMRCUjaa
         0Y2R4TV99VD2xHkNPelcXGMVVAzs4G2xjxKehw2T51pKIOPplpOl1+l5D4QvqbYbcRun
         7TiCPmipUeIdNrcHmd7VD5v2+vFBCY35C2dBwY2oxjXBJNZXmbal1fGEEtSStnkmFcJM
         jYt79RlAEpADGl0+v0qA1qASeSQ4hMU4TekerDWifweTb1Ipime2Jm8WbYzonRC7+Nua
         wJLSqyO4c2B0g83i0njhY5XGfqQO4QyDJplOzHSpr8yJIwd75weglCggXg8WDtl8caka
         mjBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714128094; x=1714732894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=InFnIY+p533KdBP4NACQo0sZ0V7hrv1Ldx+BeIELt2w=;
        b=kPyHU+em1K+6vxMGf9NzRpRAAnFwET8OxT0OD6PBglvC1XRXa1SPE6ip43I0Nfz6Hh
         wkScjgEkyxr77On3++hX9cob+n4MjTAF3nAMzI5uwzyl1aUy7fEn40880jL/wD0PnWR7
         Mm+4kV4pow7MA09Zxjv+JYUJc7FE5YOp2UXx4BfXOiGsBneBu7kvDpwVJNOjXWak4tY+
         1zqPQTV1exhNWSYO9yIDSlzPXAcylOgnsS+sFwvyeVjzHgn2vaia1qnz/MxpVJm4pw87
         GnEN+Pon32sJ7Y1qSQWUncoToobNmgFVyihe6VORMg+1FL/s4KbdcYv995MPfW2OHk6q
         eqbA==
X-Forwarded-Encrypted: i=1; AJvYcCWpTHPL9Oc63fQ5ws0qH4DSmc7q0A+CtMwqc6E4OnwE+usSSxEgBanF0Iz6QOPXiwepuPD1NoHBSDbuuvVYDqOc4X+gb4s7TPai++QY
X-Gm-Message-State: AOJu0YyJ2ZBK5LjgXCWo/j4MXmLn4b43Ic1VFC4C6tbLNgfm//JeHOv6
	KugesCNdrsUBa0JY6MlJDIUIaKurrqEP0n0a245Zj71kRhRgtyDx5rCvlmXlKBKhWyhqma/NSB+
	UflQ=
X-Google-Smtp-Source: AGHT+IGzmmRcHxE+Swjg/ipOCc8mvlarSR/aWtWq2ae9ZhH60fFvijHKf6xSwV9kvZ7WJacR0rfTkA==
X-Received: by 2002:a05:600c:1986:b0:41a:903a:d2f4 with SMTP id t6-20020a05600c198600b0041a903ad2f4mr1778459wmq.2.1714128094263;
        Fri, 26 Apr 2024 03:41:34 -0700 (PDT)
Received: from gpeter-l.lan ([2a0d:3344:2e8:8510:63cc:9bae:f542:50e4])
        by smtp.gmail.com with ESMTPSA id o14-20020a05600c510e00b00419f572671dsm22035335wms.20.2024.04.26.03.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 03:41:33 -0700 (PDT)
From: Peter Griffin <peter.griffin@linaro.org>
To: vkoul@kernel.org,
	kishon@kernel.org,
	krzysztof.kozlowski@linaro.org
Cc: linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	tudor.ambarus@linaro.org,
	andre.draszik@linaro.org,
	saravanak@google.com,
	willmcvicker@google.com,
	kernel-team@android.com,
	Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH 1/2] phy: samsung-ufs: ufs: remove superfluous mfd/syscon.h header
Date: Fri, 26 Apr 2024 11:41:28 +0100
Message-ID: <20240426104129.2211949-2-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
In-Reply-To: <20240426104129.2211949-1-peter.griffin@linaro.org>
References: <20240426104129.2211949-1-peter.griffin@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mfd/syscon.h header is no longer required since the update to
exynos_get_pmu_regmap_by_phandle() api.

Fixes: f2c6d0fa197a ("phy: samsung-ufs: use exynos_get_pmu_regmap_by_phandle() to obtain PMU regmap")
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 drivers/phy/samsung/phy-samsung-ufs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/phy/samsung/phy-samsung-ufs.c b/drivers/phy/samsung/phy-samsung-ufs.c
index 813bce47121d..ffc46c953ed6 100644
--- a/drivers/phy/samsung/phy-samsung-ufs.c
+++ b/drivers/phy/samsung/phy-samsung-ufs.c
@@ -13,7 +13,6 @@
 #include <linux/of.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
-#include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
-- 
2.44.0.769.g3c40516874-goog


