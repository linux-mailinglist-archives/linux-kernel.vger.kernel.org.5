Return-Path: <linux-kernel+bounces-71338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C74985A3AD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1BB21C2142B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085962E83F;
	Mon, 19 Feb 2024 12:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="EyWdc7sc"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B647C2D05D;
	Mon, 19 Feb 2024 12:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708346599; cv=none; b=TGi2Zpf+bNqIDzzZP065nu1oNmYzKNxxumPCWmHDVFof62CZvQQFLdFIHOn1VI5hPK3pkt6OM6DaEnbgqpYiN0CElkZ2Tl08kgAQY09h7lr5N3mU1CEp8ZkyhaP+GYq1qBqfbFCEkbLaoDb8Xh7/v631O+c05J81Jf/b/iYhDu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708346599; c=relaxed/simple;
	bh=Zs9XwXfin6vsvyZ0Tkvtj1y1nmSBKNq0xIOxwIjWzyM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YTJoZ8EbcZ+7CBnl21imVDg5A17m41Ein7P4lHojD4b3ofAg9W07nNbnVXZ6cfNsjJ2I9cqgsORO98ny7eEUayV0R0RrvXpcfoxXbelTC67VCKtKf6DpQcg9JwI1K5zZfMQntl37vZ3F1yIkmpmfkpYuok3FOcQDjJxtANK+AAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=EyWdc7sc; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1dba177c596so21737645ad.0;
        Mon, 19 Feb 2024 04:43:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708346597; x=1708951397;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=81C9/qYgaM7+uTbMn1Q+DPCJE1ow0PPCxUFOn05+/9E=;
        b=BXh05nLq4ZAwiiAhDPEZREniCQcMZ12fHTSxdUiJUTIWEB1UXpKj5oYCZtw8Ad8i40
         Axl3JPnCCkNhjDF93nfqLNo833Fp1l/qniG9FHLc4d6VH8hYPbYc5a25495qaHv2AEAo
         1/CUPIvU/vFfAd79e0+vlMoc5oOad311wafs8WBoE+YflnUaArwo6f0f82DjccZeXXSs
         2esxTigin/bUaUYcIvzHrZWi6zjNUauYVzfWHC4Xj97feyDCUUc9g83L7gC/KqUPa0SY
         SmJAM3KMSSpW6EBLKGtKdBiMjhanr1AhDGqAZleDG+PJZft507pB6QdC/lvGVDkQll+T
         rD4w==
X-Forwarded-Encrypted: i=1; AJvYcCWfkqtjnR3YAjgO/DFdVH3b70gatTZ8EMeLWirTRNwBYKwM+Migu6K6hU3oGBNya2SuzmNzoalHY0E2P/LW4iWi3dzVm0/eh6DmBuHL
X-Gm-Message-State: AOJu0YzcytFF1fFN5a7/1V+UE7diKcbkSvP9kQCfJqB8FNMkXzuoBQ20
	SZskhQEyMtWH2Oige6VO2dWPGUq41QH2pZcEAnqT9tbn1PcnSuMcnwQXpozOZwQ+/Q==
X-Google-Smtp-Source: AGHT+IFQZO85RawS9N/GVLt7CKZ2Nc56+OWGJeihEfPdmFPM26vz9zhNukHu0h491d1y4B0JgOf0Lg==
X-Received: by 2002:a17:902:c402:b0:1d9:30e3:ea84 with SMTP id k2-20020a170902c40200b001d930e3ea84mr18763047plk.2.1708346596888;
        Mon, 19 Feb 2024 04:43:16 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id y12-20020a170903010c00b001d974ffa1fcsm4325840plc.173.2024.02.19.04.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 04:43:16 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1708346594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=81C9/qYgaM7+uTbMn1Q+DPCJE1ow0PPCxUFOn05+/9E=;
	b=EyWdc7scphkQr3bgEmgzEcABO8mh0xDJgwJFz1daVDpM2LDssZ+DHj8aPcKj6rOYZHRYJT
	bnGq+A91wOz9lQQSVJfNX3pcvgvmjE+hsnHguwuMDt1i1dSdjDrf+GFaIupCHRGonWz5KP
	hWabEyF3QxgufHBQCMRQ0d2PIO36ZJJ9YhTEj4Ls7aOsT6wgh3nWtk+5xGo9V1TQYSpYFk
	senLvpgdhx3msNDjWO/+bS/eJl4sujDMou1WSe178Tg5x3C/wtkuimMYHCq7vrTK5KkiQL
	2b3+ENFI+UEO3bFcHNMphUnmi3csnUJWHexUm37d3XGdE54QE90+fEZ/88h4Hg==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Mon, 19 Feb 2024 09:43:57 -0300
Subject: [PATCH] mmc: core: constify the struct device_type usage
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240219-device_cleanup-mmc-v1-1-1910e283cf5a@marliere.net>
X-B4-Tracking: v=1; b=H4sIAAxN02UC/x2MQQqAIBAAvxJ7TlDrUl+JCFu3WkgTpQiiv7d0H
 JiZBwplpgJ99UCmiwsfUcDUFeDm4kqKvTBYbVttTae8SEgT7uTimVQIqHRrjZ4RG985kDBlWvj
 +p8P4vh8Z+m4kZAAAAA==
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3388; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=Zs9XwXfin6vsvyZ0Tkvtj1y1nmSBKNq0xIOxwIjWzyM=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl000RePCeBs1bWiwAl9LosSaNviJ82I1W3PzrM
 Ut4tb+obZeJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZdNNEQAKCRDJC4p8Y4ZY
 poVXD/wLI4sBidqgdBxJQs4zMVBekU1VwhcVmqngHoYLP8wfbq7ynHP2WJwmm+hYDGFAApbP+l0
 AJaksMcgVN0sZ1aQXzV7bYWH6l7Dq4IJ33wXoO1firTHC9r0Yt8t9q+C24wJOyBwEZL4MRCYfyV
 4GlifwrH+Xh53LAhkL/E3Mhntv2r8iTlKmblJOEDONlSOpGDvg+PiYxaku/D6iHM8GLc1jrXl4G
 sVLBGoYayikC1F2NIFAkMCKhI1yPGCNJ5oDQjSqDeVrknAkIZmzAevyiJLmU5Y/+esoHkX3Tfx4
 dYopAaTp28OwDLUkVGivJlZ1Vm1cJcJToStPbv1D/5pAf2KUS5wTuuItJPtNXosdmWp+j5iUKn8
 +w+2425qZL3TSRnDWFo+NCH67cirRA9CX+NOBvgLxRxiZzkQXN8bGC5ekoftGLJblPRxPygw69u
 Ndjk8TaQtxVi6LNf4erqpwN1zKtv4sktWHUsUMPgH/D2phwt2rI0jFGt76XeoKkQ/TEAwWaMDEM
 DWofQvP5AO/oklARoOeEWxbaamZThs/5SeDMCgX1DjdlRSQtyFiVsqny3wVRhEuwgXcSn/vlgQP
 bUE5HALCacooKRMyMIH2Jp+jMv3KQjluPXzvxQJHq7+RNGZzaq6BcaUzqmHvZSnRPbxcU1HVwgk
 O96BMcM9739e+tA==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
core can properly handle constant struct device_type. Move the sdio_type,
sd_type and mmc_type variables to be constant structures as well, placing
it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/mmc/core/bus.c  | 2 +-
 drivers/mmc/core/bus.h  | 2 +-
 drivers/mmc/core/mmc.c  | 2 +-
 drivers/mmc/core/sd.c   | 2 +-
 drivers/mmc/core/sd.h   | 2 +-
 drivers/mmc/core/sdio.c | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index 48daeafdff7a..0ddaee0eae54 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -272,7 +272,7 @@ static void mmc_release_card(struct device *dev)
 /*
  * Allocate and initialise a new MMC card structure.
  */
-struct mmc_card *mmc_alloc_card(struct mmc_host *host, struct device_type *type)
+struct mmc_card *mmc_alloc_card(struct mmc_host *host, const struct device_type *type)
 {
 	struct mmc_card *card;
 
diff --git a/drivers/mmc/core/bus.h b/drivers/mmc/core/bus.h
index 3996b191b68d..cfd0d02d3420 100644
--- a/drivers/mmc/core/bus.h
+++ b/drivers/mmc/core/bus.h
@@ -23,7 +23,7 @@ static ssize_t mmc_##name##_show (struct device *dev, struct device_attribute *a
 static DEVICE_ATTR(name, S_IRUGO, mmc_##name##_show, NULL)
 
 struct mmc_card *mmc_alloc_card(struct mmc_host *host,
-	struct device_type *type);
+				const struct device_type *type);
 int mmc_add_card(struct mmc_card *card);
 void mmc_remove_card(struct mmc_card *card);
 
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 58ed7193a3ca..5b2f7c285461 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -883,7 +883,7 @@ static struct attribute *mmc_std_attrs[] = {
 };
 ATTRIBUTE_GROUPS(mmc_std);
 
-static struct device_type mmc_type = {
+static const struct device_type mmc_type = {
 	.groups = mmc_std_groups,
 };
 
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index c3e554344c99..1c8148cdda50 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -805,7 +805,7 @@ static const struct attribute_group sd_std_group = {
 };
 __ATTRIBUTE_GROUPS(sd_std);
 
-struct device_type sd_type = {
+const struct device_type sd_type = {
 	.groups = sd_std_groups,
 };
 
diff --git a/drivers/mmc/core/sd.h b/drivers/mmc/core/sd.h
index 1af5a038bae9..fe6dd46927a4 100644
--- a/drivers/mmc/core/sd.h
+++ b/drivers/mmc/core/sd.h
@@ -4,7 +4,7 @@
 
 #include <linux/types.h>
 
-extern struct device_type sd_type;
+extern const struct device_type sd_type;
 
 struct mmc_host;
 struct mmc_card;
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 5914516df2f7..4fb247fde5c0 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -66,7 +66,7 @@ static struct attribute *sdio_std_attrs[] = {
 };
 ATTRIBUTE_GROUPS(sdio_std);
 
-static struct device_type sdio_type = {
+static const struct device_type sdio_type = {
 	.groups = sdio_std_groups,
 };
 

---
base-commit: 25e69172db8a31ef8564ce1cf755ac5cb8374daa
change-id: 20240219-device_cleanup-mmc-04210bcc3d9a

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


