Return-Path: <linux-kernel+bounces-79829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA07862743
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 21:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ACE3282BD3
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 20:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C180214264;
	Sat, 24 Feb 2024 20:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="mjvmKWjw"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2008A4CB41;
	Sat, 24 Feb 2024 20:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708805693; cv=none; b=rSO5Oy8RT3Fa5QJBUXUe/WmAqo9kKE7RLnu0IKbNRDNSXDLpvXcKTU5HywDUNWc32fVII/6cx8xgbIS0R1dXcIjxegCE5OiQXLJQjHn+/oQZJJkgXFRkiWoSwB/ExSFyOPkyYTjOQpg274XbLi0dIE1XYy7m6mvLhYBKGGZgF6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708805693; c=relaxed/simple;
	bh=wut1YBosBzB1qnnzqe5CqtzGgR1GNO22CaEOegfGHPU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ViudLLutuSwAWloqKRnKwgHJ8LbMRrjuF+6wYbuUatbgUM2BPDLvSfBPtc/8QgNvugUG0u5Rv8KpipTwMhzCeM7ugm5RktXa+6jbxP/fbacqGuWGL//FwOSHxjILLbD9ClxWTnkXJEefAc3AYb5aht9NDzvJiwz332FYtzUJXRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=mjvmKWjw; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1dc49afb495so13231105ad.2;
        Sat, 24 Feb 2024 12:14:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708805691; x=1709410491;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NlpDMTFxYtnaC+isKcoQ/ZJqOvMqucO6+nla6ANJH8Q=;
        b=i69u6C3lTVXCRqqwQP9IfHT2yQxH3uUOwTFMIU+aRCa2X9946YQo1JWyc0gY9n0cWs
         D+cOxSIH/fNAkt5EL1hUqzrL6qqqfjwTYzOm4ZXmv/dUNiKMBDpO3DHRk/tiJCxffDEi
         hWLmVXEm/ofPaU8irYkiQqMOirFGk2kZees0m3DoTony7lz3uG/09A+5hjnkGbn4W865
         rHqLydxjgNRyQEhczIcx3rTocR/sT2FF+UHHvsyP35SZNFcfyAU6XvnUChJKVIXkbAPc
         Cpd9OgQ9996VvXs6ERkW99OlxQh81UkN1xy7Ni5RaCiepzSrMB0wQG1nURLLVVX23ISh
         mcTg==
X-Forwarded-Encrypted: i=1; AJvYcCXFmdYDWZRyAkuS5RHmUinmkSwwE86T5ehxCxvsyt4kXWBNMGPJ77F4ddm9+2bViRJNlKaaCQuUY4Qw5zqR6XcTmzP2nvlqDagV2piq
X-Gm-Message-State: AOJu0YwJRVyBH9M67AVtb+lLvcaSUDF9KKepqZvNFszhhjpiyuu44WW6
	PlxNyZqlmqBhHfWHy8b1BsdO0V4xAZUn7AImfWm3sfOVgLEPI0f7z9038Ab5VE/7Mg==
X-Google-Smtp-Source: AGHT+IGO3LyDxc2jmqJU1ejF6Z8O9ONrCewmzj5imTwIAAgxIT5K8SmkPfnB3xJ3A3D+ubKw6UBTPA==
X-Received: by 2002:a17:902:6b81:b0:1dc:334:a87b with SMTP id p1-20020a1709026b8100b001dc0334a87bmr3151842plk.20.1708805691230;
        Sat, 24 Feb 2024 12:14:51 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id v11-20020a170902d08b00b001dc71ead7e5sm1339356plv.165.2024.02.24.12.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 12:14:50 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1708805688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NlpDMTFxYtnaC+isKcoQ/ZJqOvMqucO6+nla6ANJH8Q=;
	b=mjvmKWjwV8/PcaobuyxyeptvkNwFMGBp2/OQm29Xd+mni9lQGLHPNQ9BEpUxYs2+/nigrN
	RhFNmh2BWN3V1rW0goWv45j+Vv21jI8TKJqrQTQ/wVb97+f7r00ZOQEJIjxKxVvA9W+Jqc
	7oMIw3WQLJNKLGNQgQfKd7kQkeJNpi8y8OUG8DNVGb2NXO7sgYSOJ/pfWbLz0fIEl5rJ3v
	+3rJNIEEo80u4y+eD9lYjFR+PX0oY9KVHMCONeqMM1/MbNQijnKoIZP5fFxlWnRTjpPPJZ
	FAapH0+pG1U4UsQPwhfP6F6DrcYqPqqsP5R04Kkq2jx85mRzzccmKRJiXX5jqA==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sat, 24 Feb 2024 17:15:41 -0300
Subject: [PATCH v2] power: supply: core: constify the struct device_type
 usage
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240224-device_cleanup-power-v2-1-465ff94b896c@marliere.net>
X-B4-Tracking: v=1; b=H4sIAGxO2mUC/4WNTQ6CMBCFr0JmbU1bNQRX3sMQU8pTJsHSTBE1h
 LtbuIDL7/3OlCCMROdiJsHEiYeQwe4K8p0LDyhuM5PV9qit1arNIY+b7+HCK6o4vCFKH8pTtfq
 +MZSrUXDnzzZ7rTN3nMZBvtvLZFb1z+BklFGwTQXt4XRpL08nPUOwDxipXpblB4BVj2e7AAAA
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3997; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=wut1YBosBzB1qnnzqe5CqtzGgR1GNO22CaEOegfGHPU=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl2k5smtAngcd7CnWTA/kU6wiQ90b5SKBF1MCVP
 5tKHZld4FWJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZdpObAAKCRDJC4p8Y4ZY
 pigwD/wKiRd4R9+aWZHmjxklfzTBLvKBcaPE7209701S+r5sS8xSSVCQHCD1d2xarebPOuKYW8Z
 pbPZImKRzsuahRu7+WwB5RkPFL3BAndxb6gPFDqG9uApiMtkI8fjKhc5d1UpTMYiuBGIxMNnoxG
 BgKQYFYAe/3PkEJ6WsTnHPGBOdG7ENXBdoBp0sbYjs/PG5K/WTjYiQXUB5Zsvola/JGRupEHFwm
 /5z0SoxKsP4/aRK0VcHjpclTABVAstv2SYuTZbFKBdM0k18lQFrTnTte8CrFBRcLuHqwiHgw4ey
 PAxFGcXR74RadUKx2f9iZdr09LyHnH8kg+lQ5VMcO9OiNYRn47hBnh9cXDl+VOud+BXV9qSRkUz
 ngWIhvPJ8c8aKcE/12U94GhP6AB4uhM9M+8jdFjRR0g6k8G27q0MnrK9+sbqlv93zvijTxMqQgE
 3ml1eTGA7kLUIsPB0bZVHyPOXaArZrPrKsAvgkSm5J/NvbeDnsrfS/8DP9HVflJEZLglcIrMlNY
 9kRFRZV1lqRaJU3TQpqn1pw2IALFo8YiJWZa/GvKLy+/SHk0t2z9AaUhPreHKxhQUjI9atln4IM
 iJts1HskJLY8RLse9t4SKVSn2h0staMqvPwTPH4r1jQVakTic1R06iO5RqJWjQTW9gu3w0UyciX
 Pr+Cy7KFswlftmQ==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
core can properly handle constant struct device_type. Move the
power_supply_dev_type variable to be a constant structure as well, placing
it into read-only memory which can not be modified at runtime.

In order to accomplish that, export power_supply_attr_group in
power_supply.h and use it with the macro __ATTRIBUTE_GROUPS when defining
power_supply_dev_type in power_supply_core.c. Therefore the attribute group
is no longer static. Lastly, because power_supply_attr_groups is no longer
dynamically associated to power_supply_dev_type in
power_supply_init_attrs(), make the function receive zero arguments.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
Changes in v2:
- Exported attribute group and made use of __ATTRIBUTE_GROUPS macro.
- Properly put the struct back where it should be (power_supply_core.c).
- Cleaned power_supply_init_attrs()
- Link to v1: https://lore.kernel.org/r/20240220-device_cleanup-power-v1-1-e2b9e0cea072@marliere.net
---
 drivers/power/supply/power_supply.h       |  4 +++-
 drivers/power/supply/power_supply_core.c  |  8 ++++++--
 drivers/power/supply/power_supply_sysfs.c | 11 ++---------
 3 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/power/supply/power_supply.h b/drivers/power/supply/power_supply.h
index 645eee4d6b6a..232fdd8c1212 100644
--- a/drivers/power/supply/power_supply.h
+++ b/drivers/power/supply/power_supply.h
@@ -13,9 +13,11 @@ struct device;
 struct device_type;
 struct power_supply;
 
+extern const struct attribute_group power_supply_attr_group;
+
 #ifdef CONFIG_SYSFS
 
-extern void power_supply_init_attrs(struct device_type *dev_type);
+extern void power_supply_init_attrs(void);
 extern int power_supply_uevent(const struct device *dev, struct kobj_uevent_env *env);
 
 #else
diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index ecef35ac3b7e..37dac7669090 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -31,7 +31,11 @@ EXPORT_SYMBOL_GPL(power_supply_class);
 
 static BLOCKING_NOTIFIER_HEAD(power_supply_notifier);
 
-static struct device_type power_supply_dev_type;
+__ATTRIBUTE_GROUPS(power_supply_attr);
+static const struct device_type power_supply_dev_type = {
+	.name = "power_supply",
+	.groups = power_supply_attr_groups,
+};
 
 #define POWER_SUPPLY_DEFERRED_REGISTER_TIME	msecs_to_jiffies(10)
 
@@ -1623,7 +1627,7 @@ static int __init power_supply_class_init(void)
 		return PTR_ERR(power_supply_class);
 
 	power_supply_class->dev_uevent = power_supply_uevent;
-	power_supply_init_attrs(&power_supply_dev_type);
+	power_supply_init_attrs();
 
 	return 0;
 }
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index 977611e16373..edb240450e38 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -389,22 +389,15 @@ static umode_t power_supply_attr_is_visible(struct kobject *kobj,
 	return 0;
 }
 
-static const struct attribute_group power_supply_attr_group = {
+const struct attribute_group power_supply_attr_group = {
 	.attrs = __power_supply_attrs,
 	.is_visible = power_supply_attr_is_visible,
 };
 
-static const struct attribute_group *power_supply_attr_groups[] = {
-	&power_supply_attr_group,
-	NULL,
-};
-
-void power_supply_init_attrs(struct device_type *dev_type)
+void power_supply_init_attrs(void)
 {
 	int i;
 
-	dev_type->groups = power_supply_attr_groups;
-
 	for (i = 0; i < ARRAY_SIZE(power_supply_attrs); i++) {
 		struct device_attribute *attr;
 

---
base-commit: a9b254892ce1a447b06c5019cbf0e9caeb48c138
change-id: 20240220-device_cleanup-power-037594022cb1

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


