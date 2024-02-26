Return-Path: <linux-kernel+bounces-80609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C23866A4E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 07:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C771FB22148
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 06:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F307A1BC4F;
	Mon, 26 Feb 2024 06:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="DVxzCw5Q"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8512518E2A
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 06:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708930285; cv=none; b=aGPRfHey7zFOejya0XrkvSp5YU2bLf0ok2ulUGGqRJ31NmIjdFHhkrR5whOJj0/2WYPhLpy7Q0EUZEBMnkf+dSvNdMUznueuvQb8Iwzue2QC05UjGpvPR0TzKp5E1bnyiIkgecIXItz5AOA8+wgTqNdCg1m1PylFGQR5q+ntaZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708930285; c=relaxed/simple;
	bh=9igl0TTc8CPKGpvm8BLQNXjtSohUSijnfRrE5EBWjbk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Yy7IQjGr8sImk1z5NyIGuZe+E2txYSjIi6iOc9+5I8HXeR7dpHwKlslY57BdBh4GLov5J04A0SlLW2oFW5O88pVtYlO3K7Uje29adYNfpO2CA5MKm39KRNd7PY9Wx7XaN8Hmk1UsgkH6cQfCkiaxk0Bex/LtBTwvtJkzSg9sRWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=DVxzCw5Q; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1dca160163dso5146915ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 22:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1708930282; x=1709535082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9ZJDZa4dE6I7qh1K4oWjwqQuf4TRNeOV/pDFBmxz1NI=;
        b=DVxzCw5Q3OOqJTa1+2R1MF9fldtWZnvoTwdmBBcMT9LpKGQ7QtYTVIa9OqdnoqrZEz
         SgW9zAMfRPei0QFmo4+iCh4UZIBCEOzEM4S0PY8OYDEoMzND8++hw6vUB9W+NiBep/go
         0D+0GWrDkpuu+ixiSPJaHp3wlcrx5sJaSqpbgINcdFOAJE1jeBwUpdhsINfw//PeJQQz
         lZEKc0cDCgTGU82y6ABAz80q6ku1DspxljbDoWjchV5fELBUedeaYjlSgf12qNpCC0Oo
         CAvVnlzAsNsUeuoXS58dS1+gfFys8BGhc/SwmYJS+0VwJbYVDRBpSO7z5CDeo9D8+xDM
         FlyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708930282; x=1709535082;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ZJDZa4dE6I7qh1K4oWjwqQuf4TRNeOV/pDFBmxz1NI=;
        b=VaVlKaxx7QHtalsnK9eJi0kwNxo9gBeeD3ulnXpPetT5BpQGOg4WSWKKOxxrsxcJk/
         Vl2lWIxn0QCJ0OGHTdEQYVlUC7DAcWGW0mWYjgBAY9aQm9mU1bf9yJDOPP0TPfOwDG32
         YkDt2DjbG7GUFHUiqMVdIeNHDn5svecOeDaXLybFEjvb5L56HAj97gXGr0bIerrGA6Cm
         jOcC901k94wnzPj3bH6Nqn7zkooo/cRRsJ9upbGfccd6LI4DmuqcP0/zmatSKWJz30uP
         5x3R1T6WrpJVkx1S8BUc5anKj+s3864tuMelmuq9oJKrGBmCcr9+58ddQIyBcweOvONo
         co4w==
X-Forwarded-Encrypted: i=1; AJvYcCVswdUVTzupK0a3lNZcSHbJ814FGeVeaHonKzLS3pAx/FERhPKt8hBATLZPlCq3edkbaS3X94Jx9ITHSk+9SC8DDRG+EbEbUcHMBMN+
X-Gm-Message-State: AOJu0YzgVXtWMkjiGDNvV2s7MdTojrHfuefTcd03BFVZzafvymbSoggx
	xaspjaonj+N9FQqRej9raMOMiIesXLerOhzi4WCM1Digp+El97PdFtr1oWfkgek=
X-Google-Smtp-Source: AGHT+IG+iLuHhzs/rqyv0mUJKiLZSB9huPbBXlKg4PKw62MWaoX8Gy2Vo+Uwin2x0VVilQL/hJd7ow==
X-Received: by 2002:a17:903:189:b0:1dc:692:2843 with SMTP id z9-20020a170903018900b001dc06922843mr8971565plg.5.1708930281569;
        Sun, 25 Feb 2024 22:51:21 -0800 (PST)
Received: from nickhu-X1C-TW.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id u11-20020a170903308b00b001d937bc5602sm3238871plc.227.2024.02.25.22.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 22:51:20 -0800 (PST)
From: Nick Hu <nick.hu@sifive.com>
To: anup@brainfault.org,
	rafael@kernel.org,
	daniel.lezcano@linaro.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	linux-pm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: zong.li@sifive.com,
	Nick Hu <nick.hu@sifive.com>
Subject: [PATCH] cpuidle: riscv-sbi: Add cluster_pm_enter()/exit()
Date: Mon, 26 Feb 2024 14:51:13 +0800
Message-Id: <20240226065113.1690534-1-nick.hu@sifive.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the cpus in the same cluster are all in the idle state, the kernel
might put the cluster into a deeper low power state. Call the
cluster_pm_enter() before entering the low power state and call the
cluster_pm_exit() after the cluster woken up.

Signed-off-by: Nick Hu <nick.hu@sifive.com>
---
 drivers/cpuidle/cpuidle-riscv-sbi.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/drivers/cpuidle/cpuidle-riscv-sbi.c
index e8094fc92491..298dc76a00cf 100644
--- a/drivers/cpuidle/cpuidle-riscv-sbi.c
+++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
@@ -394,6 +394,7 @@ static int sbi_cpuidle_pd_power_off(struct generic_pm_domain *pd)
 {
 	struct genpd_power_state *state = &pd->states[pd->state_idx];
 	u32 *pd_state;
+	int ret;
 
 	if (!state->data)
 		return 0;
@@ -401,6 +402,10 @@ static int sbi_cpuidle_pd_power_off(struct generic_pm_domain *pd)
 	if (!sbi_cpuidle_pd_allow_domain_state)
 		return -EBUSY;
 
+	ret = cpu_cluster_pm_enter();
+	if (ret)
+		return ret;
+
 	/* OSI mode is enabled, set the corresponding domain state. */
 	pd_state = state->data;
 	sbi_set_domain_state(*pd_state);
@@ -408,6 +413,19 @@ static int sbi_cpuidle_pd_power_off(struct generic_pm_domain *pd)
 	return 0;
 }
 
+static int sbi_cpuidle_pd_power_on(struct generic_pm_domain *pd)
+{
+	struct genpd_power_state *state = &pd->states[pd->state_idx];
+
+	if (!state->data)
+		return 0;
+
+	if (!sbi_cpuidle_pd_allow_domain_state)
+		return -EBUSY;
+
+	return cpu_cluster_pm_exit();
+}
+
 struct sbi_pd_provider {
 	struct list_head link;
 	struct device_node *node;
@@ -433,10 +451,12 @@ static int sbi_pd_init(struct device_node *np)
 	pd->flags |= GENPD_FLAG_IRQ_SAFE | GENPD_FLAG_CPU_DOMAIN;
 
 	/* Allow power off when OSI is available. */
-	if (sbi_cpuidle_use_osi)
+	if (sbi_cpuidle_use_osi) {
 		pd->power_off = sbi_cpuidle_pd_power_off;
-	else
+		pd->power_on = sbi_cpuidle_pd_power_on;
+	} else {
 		pd->flags |= GENPD_FLAG_ALWAYS_ON;
+	}
 
 	/* Use governor for CPU PM domains if it has some states to manage. */
 	pd_gov = pd->states ? &pm_domain_cpu_gov : NULL;
-- 
2.34.1


