Return-Path: <linux-kernel+bounces-132359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA57789938C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 05:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F43E1F2396C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 03:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4911BF54;
	Fri,  5 Apr 2024 03:05:59 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3E0134A9;
	Fri,  5 Apr 2024 03:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712286358; cv=none; b=QRyu1wokWx2Qsf5NznfWpldo53G5zrDKKqaqsbeolS0k0eXYpvmjyMAQ3ZZQTgldkYhZwfpmt2jyzM9wOFYuta1j/LkAtfUGxy9WhIj4v2dC9CWxpSnmMMihxX9Pj9VWFwyk1FaA2t3ERuS8CsxpN7kP3r5XDPTK+4cPI3SKmKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712286358; c=relaxed/simple;
	bh=C2VgREdi+4ETlKAR2VZI0tLQIj3vvb+U8c5FeOVWXV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Mime-Version:Content-Type; b=h3hlfosxyY/dzPbTbKO++kNL3bsF3pzJlvparz7w9M0lBiZYJBttu9MXbhg1jk6caf62HRuHmOwK349X6nRpZzwZi9oDA8EGSpbPEq12yD3DKDnimOSSVtbinFDhulP70kE1LH7L6ZV7flKzfXgyrnODVvCciI1l2cCKST+nf0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from fedori.lan (51b69867.dsl.pool.telekom.hu [::ffff:81.182.152.103])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 000000000006F223.00000000660F6A92.0025A894; Fri, 05 Apr 2024 05:05:54 +0200
From: Gergo Koteles <soyer@irl.hu>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
  Len Brown <lenb@kernel.org>, Ike Panhc <ike.pan@canonical.com>,
  Hans de Goede <hdegoede@redhat.com>,
  =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
  Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net,
  platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
  Gergo Koteles <soyer@irl.hu>
Subject: [PATCH v4 1/3] ACPI: platform-profile: add platform_profile_cycle()
Date: Fri,  5 Apr 2024 05:05:28 +0200
Message-ID: <fdc1b0b9f910753967b7a9b1996e4923cc63124f.1712282976.git.soyer@irl.hu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712282976.git.soyer@irl.hu>
References: <cover.1712282976.git.soyer@irl.hu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from 8bit to 7bit by courier 1.0

Some laptops have a key to switch platform profiles.

Add a platform_profile_cycle() function to cycle between the enabled
profiles.

Signed-off-by: Gergo Koteles <soyer@irl.hu>
---
 drivers/acpi/platform_profile.c  | 42 ++++++++++++++++++++++++++++++++
 include/linux/platform_profile.h |  1 +
 2 files changed, 43 insertions(+)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index d418462ab791..1579f380d469 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -136,6 +136,48 @@ void platform_profile_notify(void)
 }
 EXPORT_SYMBOL_GPL(platform_profile_notify);
 
+int platform_profile_cycle(void)
+{
+	enum platform_profile_option profile;
+	enum platform_profile_option next;
+	int err;
+
+	err = mutex_lock_interruptible(&profile_lock);
+	if (err)
+		return err;
+
+	if (!cur_profile) {
+		mutex_unlock(&profile_lock);
+		return -ENODEV;
+	}
+
+	err = cur_profile->profile_get(cur_profile, &profile);
+	if (err) {
+		mutex_unlock(&profile_lock);
+		return err;
+	}
+
+	next = ffs(cur_profile->choices[0] >> (profile + 1)) + profile;
+
+	/* current profile is the highest, select the lowest */
+	if (next == profile)
+		next = ffs(cur_profile->choices[0]) - 1;
+
+	if (WARN_ON((next < 0) || (next >= ARRAY_SIZE(profile_names)))) {
+		mutex_unlock(&profile_lock);
+		return -EINVAL;
+	}
+
+	err = cur_profile->profile_set(cur_profile, next);
+	mutex_unlock(&profile_lock);
+
+	if (!err)
+		sysfs_notify(acpi_kobj, NULL, "platform_profile");
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(platform_profile_cycle);
+
 int platform_profile_register(struct platform_profile_handler *pprof)
 {
 	int err;
diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
index e5cbb6841f3a..f5492ed413f3 100644
--- a/include/linux/platform_profile.h
+++ b/include/linux/platform_profile.h
@@ -36,6 +36,7 @@ struct platform_profile_handler {
 
 int platform_profile_register(struct platform_profile_handler *pprof);
 int platform_profile_remove(void);
+int platform_profile_cycle(void);
 void platform_profile_notify(void);
 
 #endif  /*_PLATFORM_PROFILE_H_*/
-- 
2.44.0


