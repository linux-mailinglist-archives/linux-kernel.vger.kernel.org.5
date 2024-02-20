Return-Path: <linux-kernel+bounces-73771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3403285CADF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 23:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDE7D286178
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 22:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1836415443A;
	Tue, 20 Feb 2024 22:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="oydsPNWT"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CDA153BE6;
	Tue, 20 Feb 2024 22:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708468846; cv=none; b=gdnNeDMwkKI9zgSiTOJlrq3yct5EcGn8P5L+Es8NvSCIx4s6ZKyvIVRGHMVzMtpnTr59AfE77XHQLJpGHmjbo0ZvsxtqDxy1ECz95Ss9dEiptWUeRVpKEBlyAClZO0JxFZ8sM/rBA74ynsEpcJqmxh7z3iqDNcYh8Vf2LPps704=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708468846; c=relaxed/simple;
	bh=lcQ6tPFPA8ZPIIU2M50ETdjk/mv23gTBbEC2JUwD5Lk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=tvA9XfHBAPyVA8yfkt+MwMJqOkZJ/1hHyNaVaSzX+3WDInbjvaqFjAVuoX2c6guOV12aNSeaGuzuEZRMjOqZ4gwZz38gmNgP/5K4JKZ+bg/xqoGoxINWpR97s/g/L1G6Boi+HgDxcARnwLz6woaGxx1zRfJtMdcpPIZl3gYNzc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=oydsPNWT; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-295c67ab2ccso4305031a91.1;
        Tue, 20 Feb 2024 14:40:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708468843; x=1709073643;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ce2p+U1CVerp7eft6EXnwNDofuNiEGCs5Ue3VZIDbv4=;
        b=PSfASWo3Q/Sj411s3qJ0HDllqPKiajpHcq5gsLdpJ6o7OL2PRZDVaz16l/OkdmymU6
         elRMagKU49t97XLVTzHZ4fRHl/9zlreRnuTU3bWBZ/kRiCyVYD6tUPHZhRJNzY8vSeyl
         Obra6MwyXkbHLYQvMzrZ2eEhNXfjVBIcLhxAWS9m4NRpQDavR7FGuV4hRcdaOcKovPLS
         T8/w1qBMQ9qICCjuaD6O8Ma+sMjtrvAaBc1cQuNs5dHhGCHFmWLLuT3m9CWnBlNd4+3K
         EF3zGqi2+9FqAeQAs5rIc9EjqCStTTX4rfJ2KnLXXjsKK/8o/JpacjiqYnQE3zULDvWb
         /oaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpPCrzmgwExWARgwMlu9WicxtANOSIpFv+bauTO5rAxrv9k3e5bHRAMkIP+zu4B2j8/vgsHOuq9rNgRR6iZrnXV4y98P8lvv/VPmVJ
X-Gm-Message-State: AOJu0YypYGqnM8+h+myU/jQ6n3ABKIwaigcw6jQGhJ7EDjXbLdAsAsPf
	gTeqbswBWqb7CqyKT0PoykuJKmLnluVJwgygtHFjimgzNB8iNkN27Z5VXl76wyM=
X-Google-Smtp-Source: AGHT+IHjOq1j4GahfnZuxOTFxxyNhCB0oID6il9I+p8tq/vUY90rah5UASvrvQQPgM+5+bAYs/aiYQ==
X-Received: by 2002:a17:90a:3482:b0:299:3990:4e11 with SMTP id p2-20020a17090a348200b0029939904e11mr10986196pjb.34.1708468843402;
        Tue, 20 Feb 2024 14:40:43 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id dj16-20020a17090ad2d000b0029955fe814asm182488pjb.21.2024.02.20.14.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 14:40:42 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1708468841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ce2p+U1CVerp7eft6EXnwNDofuNiEGCs5Ue3VZIDbv4=;
	b=oydsPNWT6etjwfZi/jfuSZlFXl22LM/nYeXTC7r0mNwxm4ZY+fpMsWT/w36+dahb3AWhTb
	qZIibcRL/XraIF9/9BUojmgD/yPaokkACB7i7lZlO9XrfztoY074FcupIpb7mMMmUPIBPJ
	yYoNUmbbufmghKrP6v/yQ11TpJ5qaVYrXBJdtIZkCooWC516ME0xrkwYgvl19VmfBkHXEm
	z/SRhkVCpCKXozT5TDSvCt8Nee/Mp/462FpuiyoKs8dvkA+8QqfE2/lvY1zzzr2ZeJji60
	uPO/LQKr30YYZwh/mHKCU+hNP16qh2WxVpmoloUUwOREUScDakI8aEo9pwpVqg==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Tue, 20 Feb 2024 19:41:26 -0300
Subject: [PATCH] power: supply: core: make power_supply_class constant
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240220-class_cleanup-power-v1-1-9ef579404351@marliere.net>
X-B4-Tracking: v=1; b=H4sIAJUq1WUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDIyMD3eScxOLi+OSc1MS80gLdgvzy1CJdQxMzCwMjQ0tzU+MUJaDOgqL
 UtMwKsKnRsbW1AI2hB0ZlAAAA
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5088; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=lcQ6tPFPA8ZPIIU2M50ETdjk/mv23gTBbEC2JUwD5Lk=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl1SqXboxLcsoUmejaMbZfVptUH57xyJd/HCqQc
 BHN9TIe4xOJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZdUqlwAKCRDJC4p8Y4ZY
 pkFoEACI+TUug3sFPm8/vVqr3MTthY9IR5GfMxjPk0XBWiWYbEaFUl3tF/69klWu1/us2vwp+pz
 GNHtNRfWBot6hoXK13YVMzO5bw1FuSak6dZ59XKWu1hxAp7cRGezDk0WPE5sgofSfFaL0/X6iF0
 RvycvUvmoOzXbE/JKE90BJtH36mFGT8/Jmnmo13JH9FR86JMcAaa8WZowox2Iop2AK6os89ndPx
 z/4WmN/Cy02TijHbjNRxoggEx8M6/dfFpldXhiNRfMS8yGUJp2q0YUj23ZH031WZU40A3bxf6//
 8NMH5Qakt/wxDnUSaPTozuO59htYfq310ZcEmcl95uglbxE/QvWyD4gCY23c1S6JKp/+Z7U0U3J
 V2cRh2KiwvN6RvfNXaxdsP8kmJA9sHS4H9TcVx12szW2w823K+LZFV03K0qgl5pHuC56NMHQj5s
 h5YzqvKcBota/FuiwkZt81M8GAfx6Age/esil1GAtsNzIxiZrvtSfjr5MwlPCidtFClrUMuAjof
 pPfqWeDHSinXK9eMEz2kuU0DFwqnioXp3ipkBcpZCetUKYLxgyUxgwN0zMUXwIOREiBCoJ4GFQZ
 UaC+q/1B8bVUHjKV4tb1IydXKXkFTuVfJnn9ii2HCYlUcqZUSunPXKC3+Q3fmvx1fKTV29UTDdM
 uzrZzcDqvk0VzQw==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit 43a7206b0963 ("driver core: class: make class_register() take
a const *"), the driver core allows for struct class to be in read-only
memory, so move the power_supply_class structure to be declared at build
time placing it into read-only memory, instead of having to be dynamically
allocated at boot time.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/power/supply/power_supply_core.c | 28 ++++++++++++++++------------
 include/linux/power_supply.h             |  2 +-
 2 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index ecef35ac3b7e..f13372e88589 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -26,7 +26,10 @@
 #include "samsung-sdi-battery.h"
 
 /* exported for the APM Power driver, APM emulation */
-struct class *power_supply_class;
+const struct class power_supply_class = {
+	.name = "power_supply",
+	.dev_uevent = power_supply_uevent,
+};
 EXPORT_SYMBOL_GPL(power_supply_class);
 
 static BLOCKING_NOTIFIER_HEAD(power_supply_notifier);
@@ -93,7 +96,7 @@ static void power_supply_changed_work(struct work_struct *work)
 	if (likely(psy->changed)) {
 		psy->changed = false;
 		spin_unlock_irqrestore(&psy->changed_lock, flags);
-		class_for_each_device(power_supply_class, NULL, psy,
+		class_for_each_device(&power_supply_class, NULL, psy,
 				      __power_supply_changed_work);
 		power_supply_update_leds(psy);
 		blocking_notifier_call_chain(&power_supply_notifier,
@@ -329,7 +332,7 @@ int power_supply_am_i_supplied(struct power_supply *psy)
 	struct psy_am_i_supplied_data data = { psy, 0 };
 	int error;
 
-	error = class_for_each_device(power_supply_class, NULL, &data,
+	error = class_for_each_device(&power_supply_class, NULL, &data,
 				      __power_supply_am_i_supplied);
 
 	dev_dbg(&psy->dev, "%s count %u err %d\n", __func__, data.count, error);
@@ -365,7 +368,7 @@ int power_supply_is_system_supplied(void)
 	int error;
 	unsigned int count = 0;
 
-	error = class_for_each_device(power_supply_class, NULL, &count,
+	error = class_for_each_device(&power_supply_class, NULL, &count,
 				      __power_supply_is_system_supplied);
 
 	/*
@@ -412,7 +415,7 @@ int power_supply_get_property_from_supplier(struct power_supply *psy,
 	 * This function is not intended for use with a supply with multiple
 	 * suppliers, we simply pick the first supply to report the psp.
 	 */
-	ret = class_for_each_device(power_supply_class, NULL, &data,
+	ret = class_for_each_device(&power_supply_class, NULL, &data,
 				    __power_supply_get_supplier_property);
 	if (ret < 0)
 		return ret;
@@ -458,7 +461,7 @@ static int power_supply_match_device_by_name(struct device *dev, const void *dat
 struct power_supply *power_supply_get_by_name(const char *name)
 {
 	struct power_supply *psy = NULL;
-	struct device *dev = class_find_device(power_supply_class, NULL, name,
+	struct device *dev = class_find_device(&power_supply_class, NULL, name,
 					power_supply_match_device_by_name);
 
 	if (dev) {
@@ -1369,7 +1372,7 @@ __power_supply_register(struct device *parent,
 
 	device_initialize(dev);
 
-	dev->class = power_supply_class;
+	dev->class = &power_supply_class;
 	dev->type = &power_supply_dev_type;
 	dev->parent = parent;
 	dev->release = power_supply_dev_release;
@@ -1617,12 +1620,13 @@ EXPORT_SYMBOL_GPL(power_supply_get_drvdata);
 
 static int __init power_supply_class_init(void)
 {
-	power_supply_class = class_create("power_supply");
+	int err;
+
+	err = class_register(&power_supply_class);
 
-	if (IS_ERR(power_supply_class))
-		return PTR_ERR(power_supply_class);
+	if (err)
+		return err;
 
-	power_supply_class->dev_uevent = power_supply_uevent;
 	power_supply_init_attrs(&power_supply_dev_type);
 
 	return 0;
@@ -1630,7 +1634,7 @@ static int __init power_supply_class_init(void)
 
 static void __exit power_supply_class_exit(void)
 {
-	class_destroy(power_supply_class);
+	class_unregister(&power_supply_class);
 }
 
 subsys_initcall(power_supply_class_init);
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index c0992a77feea..514f652de64d 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -895,7 +895,7 @@ extern int power_supply_powers(struct power_supply *psy, struct device *dev);
 
 extern void *power_supply_get_drvdata(struct power_supply *psy);
 /* For APM emulation, think legacy userspace. */
-extern struct class *power_supply_class;
+extern const struct class power_supply_class;
 
 static inline bool power_supply_is_amp_property(enum power_supply_property psp)
 {

---
base-commit: a9b254892ce1a447b06c5019cbf0e9caeb48c138
change-id: 20240220-class_cleanup-power-14680219753d

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


