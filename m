Return-Path: <linux-kernel+bounces-76371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 851F485F64B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FE01287DAD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6CE3FB39;
	Thu, 22 Feb 2024 10:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TwhZdvVr"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D572BB1B;
	Thu, 22 Feb 2024 10:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708599448; cv=none; b=Zpb8cYMP5ALgbEoeLoZulpO+6PUpEa/j85tFlKg/WrlwG3s3fXoanCoMiH2E+vS8B57NOwXduozLlekW+F83s80Cvu69Jd2p4vPcWSRoG1Q/7mZjsQIFGkb4Ob+Hnto5uE18xnbamC0XhR8riEW1hGyJ1erO7d31XZdHJDOkh6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708599448; c=relaxed/simple;
	bh=KZFamjtTkLlgnuhFg6Rr3E9yf5OE94BjBfpAh6iuEGI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ZHO+X7escd7HSUb2qvGSR2MmvemTnlMKPkzP5MGw3ee+Kg04nWUTQBzhrDpEMTRatNPC1zulVP+9NS3J79y0x9YNj5qPajsqw0F1lk3T/huqGu9aMUcrj3LRd5U/i0Y+QjGXe7f7RpLIA5hGL7/7oZba5ALcxafLE9gMtQiYtUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TwhZdvVr; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d208d0b282so101904501fa.0;
        Thu, 22 Feb 2024 02:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708599445; x=1709204245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wGYV6JHoJ7Q+x7LBEW9ExN+ZwTE9A2g4Q3ZY71UFQaI=;
        b=TwhZdvVrwp5X90pjhnXaRlOlxjZgNMD+gjazKx6iUu61Yr6AMEoIhyrvTlBJHD8hfW
         4yB/1u3kzyi5YYU4V6+RXO8wXR4ZLY9iQMeCZvK21rvNgQegaWxDWnWSThLaBDmk1HR+
         kWLewHVM15c49Yws4elSCRFmYYl+bVFmXMyCGQQwFyiCCMGcxnwb1bfq0cBse5Jo1Zbk
         XiLO5cBCMAzAEE7bQTap8Qtxj6IkdW5Q+KR7XE023IDOeZk+zjWL6dvMbuRwN2FWFIAa
         JpB1Lze4k93A5aPPaZaOrILQ4Id64LnfcU3sKYzwHyuc7xoIkDkUsnpRuV2EWOL+Mkmn
         eGtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708599445; x=1709204245;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wGYV6JHoJ7Q+x7LBEW9ExN+ZwTE9A2g4Q3ZY71UFQaI=;
        b=gC8mZQZwWy2kFijgURzH94OS9KyrBZ3qSaQGjz1hAxd2m2HNKHcxo6Mc73ieVmpa32
         p/oqxPpMAGbOZrS1Gbz1nk2hHZX4I49uIRb1QlxnYo3+B4HHRUiQ1YllDuvM1IT9TEX2
         LBOvFJWlPlAdCWISqQhUEr27fcY9xcCqdsUkWvnFYsO6hMje8j70QTdlcozkHiChE2jL
         iiDLndz+4NHcv7af3BUl1fU7wiiZrOWre9fxvmxZI4h+LomsbZ8zh4+WUlEax1VskhbJ
         zIJmSYEplamSzFrpj6mGvA7yEbZiE7HorbbevuyTfLTwKJ4pp2k9+NSruiTVpTRILPPC
         0ySg==
X-Forwarded-Encrypted: i=1; AJvYcCWv/D5gnvbEL8l7v2mc5KVcCMgevGTb0+12Bnn27F87iAzEhevmvPbtceGm8PM+lS3luym2sd/2kb1ILWcV6xHeOmZh1DOIJPqkf+SuAKrNvRIF3jBvOTH9S03oubEzQngHpCkrpWYaYw==
X-Gm-Message-State: AOJu0YypyCvNu7MEHwLsV2ZkuZ4mbkKri4O6cNrTyV6iBJoOKgmAui+5
	NN1LYGvz6BQDQfUwcE6tjFNCC7eDmgrGfMZW4DP5NyOG+Jq8n3a8
X-Google-Smtp-Source: AGHT+IHz5LqeM9DUmbD/xyQv66R4i+bjqBOk1QDmMso/Qu5MSDXQ0gE8+Dy4cGs7NeCGyFy9ARzguA==
X-Received: by 2002:a05:651c:1199:b0:2d2:6378:ad3e with SMTP id w25-20020a05651c119900b002d26378ad3emr623730ljo.7.1708599444544;
        Thu, 22 Feb 2024 02:57:24 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id m20-20020a05600c281400b0041214ff06cesm21011733wmb.42.2024.02.22.02.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 02:57:24 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next][V2] ACPI: thermal_lib: Initialize temp_decik to zero
Date: Thu, 22 Feb 2024 10:57:23 +0000
Message-Id: <20240222105723.3810303-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Static analysis with clang scan build is warning that uninitialized
data is being passed into various functions. Stop these warnings by
initializing temp_decik to zero.

Cleans up clang scan warnings in lines 106, 125, 146 and 164 such as:
drivers/acpi/thermal_lib.c:106:9: warning: 2nd function call argument
is an uninitialized value [core.CallAndMessage]

Kudos to Dan Carpenter for the deeper analysis of this issue.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---

V2: just set temp_decik to 0

---
 drivers/acpi/thermal_lib.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/thermal_lib.c b/drivers/acpi/thermal_lib.c
index 4e0519ca9739..6214d6ebe1fa 100644
--- a/drivers/acpi/thermal_lib.c
+++ b/drivers/acpi/thermal_lib.c
@@ -100,7 +100,7 @@ static int thermal_temp(int error, int temp_decik, int *ret_temp)
  */
 int thermal_acpi_active_trip_temp(struct acpi_device *adev, int id, int *ret_temp)
 {
-	int temp_decik;
+	int temp_decik = 0;
 	int ret = acpi_active_trip_temp(adev, id, &temp_decik);
 
 	return thermal_temp(ret, temp_decik, ret_temp);
@@ -119,7 +119,7 @@ EXPORT_SYMBOL_GPL(thermal_acpi_active_trip_temp);
  */
 int thermal_acpi_passive_trip_temp(struct acpi_device *adev, int *ret_temp)
 {
-	int temp_decik;
+	int temp_decik = 0;
 	int ret = acpi_passive_trip_temp(adev, &temp_decik);
 
 	return thermal_temp(ret, temp_decik, ret_temp);
@@ -139,7 +139,7 @@ EXPORT_SYMBOL_GPL(thermal_acpi_passive_trip_temp);
  */
 int thermal_acpi_hot_trip_temp(struct acpi_device *adev, int *ret_temp)
 {
-	int temp_decik;
+	int temp_decik = 0;
 	int ret = acpi_hot_trip_temp(adev, &temp_decik);
 
 	return thermal_temp(ret, temp_decik, ret_temp);
@@ -158,7 +158,7 @@ EXPORT_SYMBOL_GPL(thermal_acpi_hot_trip_temp);
  */
 int thermal_acpi_critical_trip_temp(struct acpi_device *adev, int *ret_temp)
 {
-	int temp_decik;
+	int temp_decik = 0;
 	int ret = acpi_critical_trip_temp(adev, &temp_decik);
 
 	return thermal_temp(ret, temp_decik, ret_temp);
-- 
2.39.2


