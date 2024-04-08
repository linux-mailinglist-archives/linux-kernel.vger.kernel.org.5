Return-Path: <linux-kernel+bounces-135758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1270B89CADF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 19:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1C8728AE89
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52101448CB;
	Mon,  8 Apr 2024 17:35:21 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A50143C56;
	Mon,  8 Apr 2024 17:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712597721; cv=none; b=fUaKBDaFivf+Gs/8ygINyxKrA0MKIqquAWDYACxEZ0zBjk4sxQJ3kSKj5h+uKvmhOCmUenOcXNp00cNlvLD+9xx+25ACv+WL1PFl+8ASvniRGE7oN//dGk6yKzGsSBg1fD6mcbFGgKB0Xdl/goEICFUonAm2q9+jGmY33bMl868=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712597721; c=relaxed/simple;
	bh=nsmER8TaSoSQzlBZvVGHgGV7xQvfQxK/t/i2NjhP2W0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Mime-Version:Content-Type; b=tHVSJGWrvUStfGu+ZrAVJ2xuj5+CelY0rJd8+qLEyiVsFvPT+UeZWbB3A4qx0VtF5vzQNXp5XgAgdnAbideQsPGEfPEkqbyL0+p1GF3LEkHlc6H3MQAG412xewOsegDC4ISaf99hZUpnw26woUqmuXTVKmZK0wRgnBM1X+Y6GbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from fedori.lan (51b69f53.dsl.pool.telekom.hu [::ffff:81.182.159.83])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 00000000000706E7.0000000066142AD4.002645EF; Mon, 08 Apr 2024 19:35:16 +0200
From: Gergo Koteles <soyer@irl.hu>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
  Len Brown <lenb@kernel.org>, Ike Panhc <ike.pan@canonical.com>,
  Hans de Goede <hdegoede@redhat.com>,
  =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
  Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
  Daniel Lezcano <daniel.lezcano@linaro.org>,
  =?UTF-8?q?Barnab=C3=A1s=20P=C5=91cze?= <pobrn@protonmail.com>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net,
  platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
  Gergo Koteles <soyer@irl.hu>
Subject: [PATCH v6 1/3] ACPI: platform-profile: add platform_profile_cycle()
Date: Mon,  8 Apr 2024 19:35:10 +0200
Message-ID: <5a97deddf72aa5e764d881eb39a7ba35c01a903e.1712597199.git.soyer@irl.hu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712597199.git.soyer@irl.hu>
References: <cover.1712597199.git.soyer@irl.hu>
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
 drivers/acpi/platform_profile.c  | 39 ++++++++++++++++++++++++++++++++
 include/linux/platform_profile.h |  1 +
 2 files changed, 40 insertions(+)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index d418462ab791..4a9704730224 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -136,6 +136,45 @@ void platform_profile_notify(void)
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
+	next = find_next_bit_wrap(cur_profile->choices, PLATFORM_PROFILE_LAST,
+				  profile + 1);
+
+	if (WARN_ON(next == PLATFORM_PROFILE_LAST)) {
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


