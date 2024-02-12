Return-Path: <linux-kernel+bounces-61842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08421851753
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA7E5282AF8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE22C3B794;
	Mon, 12 Feb 2024 14:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="GX8DLeUc"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9204D3C488;
	Mon, 12 Feb 2024 14:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707749489; cv=none; b=OFr6EgkS0m48zTTWHaYVLHJLmeFa6Xr0jthd230hhpfGLPURKLJq5XJgnMCFy25V+Tf+wD6RQBTTHS/h/A/oKwosNWo5SEINJpXzhL0pWB2vPBilmQw/auZuLRvHbDJfdTHcHhIjt0UHvvOvj3eicJ26KPqv4luP7TydZMAqhc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707749489; c=relaxed/simple;
	bh=1TCvFrGXA9WRNIGq5qiS6fBnB/8Sfm3xS2xnBDJoK28=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VEyZlOqY6LnfiEAxFKIIw2IAXltlCuQ6x/66nqIfk0TuM0HVe588Z1V6TdY8Qbses8cLaoYr/ChJ+OTnYRukPBYqYIXVZ5XtF1NLoEJc7UCKNdhMOw0Y12jBc/NmcSxVOtyhnIc5RPsIWJ7N69bUnELVGyKQUBq0N+EZZiZMmEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=GX8DLeUc; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707749486;
	bh=1TCvFrGXA9WRNIGq5qiS6fBnB/8Sfm3xS2xnBDJoK28=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GX8DLeUcsHn718WGmcEX+K25/QWmMhkgZHgz5FKPw2HfaP9wTwEFGpGbXFQZsSJ4E
	 dY2G11h816hu9Bo86/VdQWeFvWL7C9l4uk4sHfobftI68YLgqph1qUwOhCEVdw837w
	 7ugfshFFKYdaRfe/1P6yEwDcMe577HoMELj9FLcsy4kjI4yFHkuwRCjpEU/BhRRpEA
	 Sdm0AAnmsSKjKmU7UaFydCBPm990kV70cA8irr2WS2BaIJMAVrIxIGV+sHwMSeZRmO
	 Tqp7anmsAXg6MRzc3wkFwJ5NwQsq4WF21o9mCgcBSRM5kdStPaIpGNPn7+NtIkPvXd
	 IDtAo4++BWVhA==
Received: from [192.168.1.30] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2FE39378203F;
	Mon, 12 Feb 2024 14:51:23 +0000 (UTC)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Mon, 12 Feb 2024 09:50:06 -0500
Subject: [PATCH v4 2/4] firmware: coreboot: Generate aliases for coreboot
 modules
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240212-coreboot-mod-defconfig-v4-2-d14172676f6d@collabora.com>
References: <20240212-coreboot-mod-defconfig-v4-0-d14172676f6d@collabora.com>
In-Reply-To: <20240212-coreboot-mod-defconfig-v4-0-d14172676f6d@collabora.com>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Brian Norris <briannorris@chromium.org>, 
 Julius Werner <jwerner@chromium.org>, 
 Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel@collabora.com, 
 chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.12.4

Generate aliases for coreboot modules to allow automatic module probing.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 include/linux/mod_devicetable.h   | 10 ++++++++++
 scripts/mod/devicetable-offsets.c |  3 +++
 scripts/mod/file2alias.c          | 10 ++++++++++
 3 files changed, 23 insertions(+)

diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index f458469c5ce5..7a9a07ea451b 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -960,4 +960,14 @@ struct vchiq_device_id {
 	char name[32];
 };
 
+/**
+ * struct coreboot_device_id - Identifies a coreboot table entry
+ * @tag: tag ID
+ * @driver_data: driver specific data
+ */
+struct coreboot_device_id {
+	__u32 tag;
+	kernel_ulong_t driver_data;
+};
+
 #endif /* LINUX_MOD_DEVICETABLE_H */
diff --git a/scripts/mod/devicetable-offsets.c b/scripts/mod/devicetable-offsets.c
index e91a3c38143b..518200813d4e 100644
--- a/scripts/mod/devicetable-offsets.c
+++ b/scripts/mod/devicetable-offsets.c
@@ -274,5 +274,8 @@ int main(void)
 	DEVID(vchiq_device_id);
 	DEVID_FIELD(vchiq_device_id, name);
 
+	DEVID(coreboot_device_id);
+	DEVID_FIELD(coreboot_device_id, tag);
+
 	return 0;
 }
diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index 4829680a0a6d..5d1c61fa5a55 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -1494,6 +1494,15 @@ static int do_vchiq_entry(const char *filename, void *symval, char *alias)
 	return 1;
 }
 
+/* Looks like: coreboot:tN */
+static int do_coreboot_entry(const char *filename, void *symval, char *alias)
+{
+	DEF_FIELD(symval, coreboot_device_id, tag);
+	sprintf(alias, "coreboot:t%08X", tag);
+
+	return 1;
+}
+
 /* Does namelen bytes of name exactly match the symbol? */
 static bool sym_is(const char *name, unsigned namelen, const char *symbol)
 {
@@ -1575,6 +1584,7 @@ static const struct devtable devtable[] = {
 	{"ishtp", SIZE_ishtp_device_id, do_ishtp_entry},
 	{"cdx", SIZE_cdx_device_id, do_cdx_entry},
 	{"vchiq", SIZE_vchiq_device_id, do_vchiq_entry},
+	{"coreboot", SIZE_coreboot_device_id, do_coreboot_entry},
 };
 
 /* Create MODULE_ALIAS() statements.

-- 
2.43.0


