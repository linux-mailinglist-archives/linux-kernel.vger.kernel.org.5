Return-Path: <linux-kernel+bounces-45193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF6C842CBE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A314B1F263BD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0EF762D4;
	Tue, 30 Jan 2024 19:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jQz7ksEt"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D122762D0
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 19:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706642813; cv=none; b=dsnriGzc1CCwFkQsS9XHrCNsOctOGPqDGygPRiBlXjBTe+XiTxSFzxLw4CgsBc4NDcYHxR/ZQwFb1QKK43TX7re0a4Nyj70U/MrAA/eMaW91zArzcWo1NLYU/9qxT/MwUIwH24mesZGND2rMeAzzwzqwpcUyAWL/5yNoICLXrP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706642813; c=relaxed/simple;
	bh=B2kjYhFbSp4GX9YZwdN8eIiOyb3LTIyipZNOAiaztKA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=D4X2RQ8nTQl/SQH9McXRtUbN5io6fodVuR+Z5l3ThSKiMxdJBQ2o+Qnh23ysqCnn53mrNmD6OlVsLKNAU1x7tX3wOW0V//H8x+24nRbFCJLFo0+FaKmyENMsKiMgvxKj8R0d6aEsWq3eg8xKDMiD94IWHBH4XvwBKbKwq8dkXBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rdbabiera.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jQz7ksEt; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rdbabiera.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6ddc41f35a3so3046237b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 11:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706642811; x=1707247611; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DLNcddy21SBz7KyeQPUGhNdRXI+N/Fl5AuS+wQy0vi4=;
        b=jQz7ksEt62MNFesKRuKqre79VxAZ5IqSVefXUflsI0dF+mUKo14pysm0PCMhWz41gk
         Bf0ikAaY9aMTKH/RFMENn5QICy0EGS62Qzd0djEBZb00zwRGaPYxgtxhIdxPN5fU7SMu
         bi7qnyxnbAMpz7JT7HBAKRMdFGcvhjOW+HR0DZsbdXjiO+Qydl6f7QbTCasxGkXzxCOz
         FRYYOY05/YHFfwwNv9o98CRh1cIHK5Bi9PXB4Y5OysEq2ypzMPfv+HjMFXghgD6GN2Dd
         ZXWQYE4R3R/690hPPGUtbjeaz/RLdcjhKeFGCODI+yLlrWolvwIxHm14poCPBUA6DePf
         SIrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706642811; x=1707247611;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DLNcddy21SBz7KyeQPUGhNdRXI+N/Fl5AuS+wQy0vi4=;
        b=Rrpt2/KX0OZGg0yUQNSIm+4f2sInJqJpb53RAY9UtIzDCXRKgUQW9kOs/LN3hRH5Pe
         Lw0h9JHhwgSo1nl+jNXP9wfA20zxa5Ls8OltRIbQiBUJQHAcDrcRW0f5ThgjF9ZXEkut
         Zh5jXqqD9XzordNuClf1/RQPipa1hLKD4vqgRIDj7ohLxWCAmPyMsPRw5irI+fLFikko
         DIM55NLqfyHuVW536aMjvb03wOd3fdSPwX+27cdxq1dZo1+gP/0sAkntaGnk3lBv2IFH
         vcD2Bsv4lcMIeSVdPAKpUp2kLr5UQzAQ3V3h/X3H06oHt3Kr3qI9Dg9B3tFjHwLJp5D3
         rcwg==
X-Gm-Message-State: AOJu0YwVDbUjjPX+t0ELZfQVW6chiulA8j2jzRz7ACd/ySt9tHTfZxoT
	w45rDenKBy+fsWVmVsOrxAmbHsdnmmZFa+Na8lKCkOzHXmx8YNY8WG+vwlPF/uaWQbZ8ruMwjMT
	aaiK1NpR6Q/q+NQ==
X-Google-Smtp-Source: AGHT+IGzyqpHDnMzaRV+nS2+r1StE8p1R6XAs2/YV+zXv2KaMvdh3kwztGtHSqhYXdO4zpbBnD2dX6We83IfeZ0=
X-Received: from rdbabiera.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:18a8])
 (user=rdbabiera job=sendgmr) by 2002:a05:6a00:4503:b0:6db:c6a5:da3e with SMTP
 id cw3-20020a056a00450300b006dbc6a5da3emr1109506pfb.5.1706642810832; Tue, 30
 Jan 2024 11:26:50 -0800 (PST)
Date: Tue, 30 Jan 2024 19:26:39 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=rdbabiera@google.com; a=openpgp; fpr=639A331F1A21D691815CE090416E17CA2BBBD5C8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2174; i=rdbabiera@google.com;
 h=from:subject; bh=B2kjYhFbSp4GX9YZwdN8eIiOyb3LTIyipZNOAiaztKA=;
 b=owGbwMvMwCFW0bfok0KS4TbG02pJDKk7ffM60yYd+Lhl7s6oww+lN4scPhCRv2uN2+mdVaHLu
 PJ04l7O7ChlYRDjYJAVU2TR9c8zuHEldcsczhpjmDmsTCBDGLg4BWAin98wMvyM+/HxveTGZr7Z
 eyfIn1z480L5hIvGsScvC7ZJfWF9X/eIkWGRTL7e9FreQ1I5WwubPlhl6tTz7xXsPbjTsi0ze9b XSbwA
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240130192638.3557409-2-rdbabiera@google.com>
Subject: [PATCH v1] usb: typec: altmodes/displayport: add null pointer check
 for sysfs nodes
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

Verify dp drvdata is present in sysfs reads and writes before proceeding.

Fixes: 0e3bb7d6894d ("usb: typec: Add driver for DisplayPort alternate mode")
Cc: stable@vger.kernel.org
Signed-off-by: RD Babiera <rdbabiera@google.com>
---
 drivers/usb/typec/altmodes/displayport.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
index 5a80776c7255..0423326219d8 100644
--- a/drivers/usb/typec/altmodes/displayport.c
+++ b/drivers/usb/typec/altmodes/displayport.c
@@ -518,6 +518,9 @@ configuration_store(struct device *dev, struct device_attribute *attr,
 	int con;
 	int ret = 0;
 
+	if (!dp)
+		return -ENODEV;
+
 	con = sysfs_match_string(configurations, buf);
 	if (con < 0)
 		return con;
@@ -563,6 +566,9 @@ static ssize_t configuration_show(struct device *dev,
 	u8 cur;
 	int i;
 
+	if (!dp)
+		return -ENODEV;
+
 	mutex_lock(&dp->lock);
 
 	cap = DP_CAP_CAPABILITY(dp->alt->vdo);
@@ -615,6 +621,9 @@ pin_assignment_store(struct device *dev, struct device_attribute *attr,
 	u32 conf;
 	int ret;
 
+	if (!dp)
+		return -ENODEV;
+
 	ret = sysfs_match_string(pin_assignments, buf);
 	if (ret < 0)
 		return ret;
@@ -666,6 +675,9 @@ static ssize_t pin_assignment_show(struct device *dev,
 	u8 cur;
 	int i;
 
+	if (!dp)
+		return -ENODEV;
+
 	mutex_lock(&dp->lock);
 
 	cur = get_count_order(DP_CONF_GET_PIN_ASSIGN(dp->data.conf));
@@ -698,6 +710,9 @@ static ssize_t hpd_show(struct device *dev, struct device_attribute *attr, char
 {
 	struct dp_altmode *dp = dev_get_drvdata(dev);
 
+	if (!dp)
+		return -ENODEV;
+
 	return sysfs_emit(buf, "%d\n", dp->hpd);
 }
 static DEVICE_ATTR_RO(hpd);

base-commit: f1a27f081c1fa1eeebf38406e45f29636114470f
-- 
2.43.0.429.g432eaa2c6b-goog


