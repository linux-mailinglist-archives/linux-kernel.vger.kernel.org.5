Return-Path: <linux-kernel+bounces-85870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D45C86BC8D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72BCAB21784
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B1C63B9;
	Thu, 29 Feb 2024 00:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hfIRHJaS"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69037E5
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 00:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709165496; cv=none; b=GH/RgzktxVM93spBPlZhDQrzEKRpluhaCuE7YUWas5rD1xi7c4FhgBwdlRAh2U2zgom/r4DUwgDlAvqn7iSl/Jva65ovscoXCJXCCDUeKBAvtbHIXSrneufqvWHvfyswSbkkE0aQ8Pn4ZcMKUvh0OHCMztcpjQqnZmlCA1MG2P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709165496; c=relaxed/simple;
	bh=6R2p1tT69hwYIvRTpoq1HKWl4nCvoJdmLzAs09t2YNA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qwTdL5foY/mkYmvWsjC7Ad/yi/GubYhq/cggo2dcdeiK+iyICyh5+KVCxKublyayiyonpLBHuMKZ2PVOF2uEnjNBLj52Q8OSDTGKc9ZwdrNLa6ubAugNJP4UgG8waLr6Kd2AYirTfXrSmsYjfMzUALPTlrgTEeeuBlOA3R3U2xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rdbabiera.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hfIRHJaS; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rdbabiera.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60832a48684so5082417b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 16:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709165493; x=1709770293; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MQFNdf2PLvi1nXh0+ziRXHczc9B2IYbLND0MkZadbyk=;
        b=hfIRHJaS/FhRWEPk4+4rV3kzI8K9XDT1QJ5OoQCqxuRTK26mP0y0EZtISrkFdz2yr+
         vKnk/CtVQLfXwMp8/AXm9eCTd/nGtbLp6Vrg9MNhhV2IxrZNa6VF3YYmsyl0bGSY4+3s
         RhTsqqXoEXPKNMF92XjbszRT713eRvrPZQHROEW+Qzmv+xLQknH++3+nRldLQ0nOOtZa
         pjv+ryA+kP7dwFvT0iJwK8SEq/Mx3FqZ+XBt6mx5HuKwH1ArhJOa/MR53s0JE2JZ0ptm
         aYvye2hUp0ztCncAoqnIAfC0O0dyI7ig1yoAEnw+bopMs6sJFWDfrIs2jpt2b327Olo3
         JtaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709165493; x=1709770293;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MQFNdf2PLvi1nXh0+ziRXHczc9B2IYbLND0MkZadbyk=;
        b=UBwhKDK4u+j9u1cJCtpN0z/mK9nW4dYKCgc4DlcZsrHA757+DUxP+xZb+t/8FagiT/
         hGc+jAIVBC++ofbL0TcIPv5s3GMJBMWtqYt1Ce25iB3Tq3O4PaTh0SJ9TuhJZ1waF5TV
         OaRtLS2q0fHDoHmWOzDV7svCh8cZOZfYj6ev29FMGdzwPTjY9Bjhl0PjA5p2LDqkEzsu
         qE0uRa3mHMy29iVAney2qI9RlbX9ANJYC1HQUCJTa8hb2KgzsqY4UU/i9QAznyRbybdj
         l35d/UXyGLxKyoWxIFyNAzOwr0RnV7uu+bcbrmSpABwU76lxsNeO75vApYxuEqTC6QE9
         c+Jg==
X-Forwarded-Encrypted: i=1; AJvYcCURzSv9jOPhqtUee2x3w4dSWhGB+bTWmR8BxCeoVxFL6WP5TLaQtPxchkL76nHT7L+CWAcAwR0hHcswETm3eNZehAyrBjauA6dublQp
X-Gm-Message-State: AOJu0YxHvO/aaXbceS45hBENe8AHWDf7W7cy+ZEsDUFXsOfej5auyjZU
	Fhr6p2FXB0mT5oAqGyfAYU200gsJx84kaTjGC67TgffCqYAJz24a++K8eG3lsLQEsWCvKL8n7ag
	FhSwwLZ2wIB1dgw==
X-Google-Smtp-Source: AGHT+IGkhwIscE8/PuxWoKHW7c397dn2BWKxSf4SZvT89th3wJ8CWp82+PlXbcGph7FbhavNsjH1Lf+pBUQU/pQ=
X-Received: from rdbabiera.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:18a8])
 (user=rdbabiera job=sendgmr) by 2002:a05:690c:3606:b0:609:e1f:5a42 with SMTP
 id ft6-20020a05690c360600b006090e1f5a42mr117833ywb.2.1709165492995; Wed, 28
 Feb 2024 16:11:32 -0800 (PST)
Date: Thu, 29 Feb 2024 00:11:02 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=rdbabiera@google.com; a=openpgp; fpr=639A331F1A21D691815CE090416E17CA2BBBD5C8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3202; i=rdbabiera@google.com;
 h=from:subject; bh=6R2p1tT69hwYIvRTpoq1HKWl4nCvoJdmLzAs09t2YNA=;
 b=owGbwMvMwCFW0bfok0KS4TbG02pJDKn3T097H9P7TEBZqWu/kLU8z9XNmbYfT3H3MAulTPA+s
 1zimc62jlIWBjEOBlkxRRZd/zyDG1dSt8zhrDGGmcPKBDKEgYtTACaysp3hf/izhmTBPl8hMV42
 a+G4S63FS9YJTXi0pyj8UlT4/I3FKxkZFntaaJye7BP3rOZaPJ/oBn7Diz2yL6QuTZEUbTVU2XO FEwA=
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240229001101.3889432-2-rdbabiera@google.com>
Subject: [PATCH v3] usb: typec: altmodes/displayport: create sysfs nodes as
 driver's default device attribute group
From: RD Babiera <rdbabiera@google.com>
To: rdbabiera@google.com, heikki.krogerus@linux.intel.com, 
	gregkh@linuxfoundation.org
Cc: badhri@google.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The DisplayPort driver's sysfs nodes may be present to the userspace before
typec_altmode_set_drvdata() completes in dp_altmode_probe. This means that
a sysfs read can trigger a NULL pointer error by deferencing dp->hpd in
hpd_show or dp->lock in pin_assignment_show, as dev_get_drvdata() returns
NULL in those cases.

Remove manual sysfs node creation in favor of adding attribute group as
default for devices bound to the driver. The ATTRIBUTE_GROUPS() macro is
not used here otherwise the path to the sysfs nodes is no longer compliant
with the ABI.

Fixes: 0e3bb7d6894d ("usb: typec: Add driver for DisplayPort alternate mode")
Cc: stable@vger.kernel.org
Signed-off-by: RD Babiera <rdbabiera@google.com>
---
Changes from v1:
* Moved sysfs node creation instead of NULL checking dev_get_drvdata().
Changes from v2:
* Removed manual sysfs node creation, now added as default device group in
driver.
---
 drivers/usb/typec/altmodes/displayport.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
index 5a80776c7255..94e1b43a862d 100644
--- a/drivers/usb/typec/altmodes/displayport.c
+++ b/drivers/usb/typec/altmodes/displayport.c
@@ -702,16 +702,21 @@ static ssize_t hpd_show(struct device *dev, struct device_attribute *attr, char
 }
 static DEVICE_ATTR_RO(hpd);
 
-static struct attribute *dp_altmode_attrs[] = {
+static struct attribute *displayport_attrs[] = {
 	&dev_attr_configuration.attr,
 	&dev_attr_pin_assignment.attr,
 	&dev_attr_hpd.attr,
 	NULL
 };
 
-static const struct attribute_group dp_altmode_group = {
+static const struct attribute_group displayport_group = {
 	.name = "displayport",
-	.attrs = dp_altmode_attrs,
+	.attrs = displayport_attrs,
+};
+
+static const struct attribute_group *displayport_groups[] = {
+	&displayport_group,
+	NULL,
 };
 
 int dp_altmode_probe(struct typec_altmode *alt)
@@ -720,7 +725,6 @@ int dp_altmode_probe(struct typec_altmode *alt)
 	struct typec_altmode *plug = typec_altmode_get_plug(alt, TYPEC_PLUG_SOP_P);
 	struct fwnode_handle *fwnode;
 	struct dp_altmode *dp;
-	int ret;
 
 	/* FIXME: Port can only be DFP_U. */
 
@@ -731,10 +735,6 @@ int dp_altmode_probe(struct typec_altmode *alt)
 	      DP_CAP_PIN_ASSIGN_DFP_D(alt->vdo)))
 		return -ENODEV;
 
-	ret = sysfs_create_group(&alt->dev.kobj, &dp_altmode_group);
-	if (ret)
-		return ret;
-
 	dp = devm_kzalloc(&alt->dev, sizeof(*dp), GFP_KERNEL);
 	if (!dp)
 		return -ENOMEM;
@@ -777,7 +777,6 @@ void dp_altmode_remove(struct typec_altmode *alt)
 {
 	struct dp_altmode *dp = typec_altmode_get_drvdata(alt);
 
-	sysfs_remove_group(&alt->dev.kobj, &dp_altmode_group);
 	cancel_work_sync(&dp->work);
 	typec_altmode_put_plug(dp->plug_prime);
 
@@ -803,6 +802,7 @@ static struct typec_altmode_driver dp_altmode_driver = {
 	.driver = {
 		.name = "typec_displayport",
 		.owner = THIS_MODULE,
+		.dev_groups = displayport_groups,
 	},
 };
 module_typec_altmode_driver(dp_altmode_driver);

base-commit: a560a5672826fc1e057068bda93b3d4c98d037a2
-- 
2.44.0.rc1.240.g4c46232300-goog


