Return-Path: <linux-kernel+bounces-29347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 057CD830D1D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 20:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD92F1F261B6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 19:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B3424B23;
	Wed, 17 Jan 2024 19:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="3mnn8/Xz"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B67E24A1B;
	Wed, 17 Jan 2024 19:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705518355; cv=none; b=JFoLHXiB7AX0EBF8EUVMi9WWnaQjD/j3YNwRQZ83z1K3nhzJMYGRCDCuVAAuKHmHUjO+m7zonjrwkNTnhT+k4SIeHJzGKGJ85Hdfll7QfisO01dhhymWsTtjt4fyaptuWHSOMkh7zzKsvKTyFY7kE9XpzurenFlUhSeVE/fBtSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705518355; c=relaxed/simple;
	bh=+oH4EJn5sUeFLh47JfQVauFBQi5fBhiUE512d5N7kvA=;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer; b=Ly8OsUnIq0HntFeg15UQuk5noXnWdyNqnkrAsYJ/8kDKXyI2KmlD8XWpMsf0RCVwu9ui812gHoEwQNITcZoFJqu9Khkx+Y90QlxEXa0iBpsFtmi13jrOgJ8mb4exHfIzY4F0PGgi4kPPUBPvELtCrMWiEQmrm5OSWr6nBE7XMIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=3mnn8/Xz; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705518352;
	bh=+oH4EJn5sUeFLh47JfQVauFBQi5fBhiUE512d5N7kvA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=3mnn8/XzjgRV1yrJ/b0Bpm/qJbxf1HJflc3HSRevLRGcD9H1U+Ce3fwTb+l8Zkrmh
	 5NuxGp1EfTM/lzvqF+GqpNEuINU5oIotPcGQeBygv86q6ra+vwW3hCEyp+lU3OEiW3
	 pa2Kph7RhoRy7rAJ2dePc1+8MI8Fkqi+ge0nqRdLqMjDWGv5UViLhTgmxvcLkL7wKV
	 lqwywWw1tFai/KHSQqVsq0bARuIqLDtPI8YpQSRSiv0zTZXMRJNsPlumyCMLoEViTR
	 l786E/N96/lOKdR/os3q9AD58zgFDOMI2TvsGtytN9kFu/ZFCmLsXvJgc70YnVYGIo
	 ZXP4l9e61jYfA==
Received: from [192.168.0.47] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id AE9B73782033;
	Wed, 17 Jan 2024 19:05:47 +0000 (UTC)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Wed, 17 Jan 2024 16:03:22 -0300
Subject: [PATCH v3 1/4] firmware: coreboot: Generate modalias uevent for
 devices
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240117-coreboot-mod-defconfig-v3-1-049565a27bba@collabora.com>
References: <20240117-coreboot-mod-defconfig-v3-0-049565a27bba@collabora.com>
In-Reply-To: <20240117-coreboot-mod-defconfig-v3-0-049565a27bba@collabora.com>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Brian Norris <briannorris@chromium.org>, 
 Julius Werner <jwerner@chromium.org>, 
 Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, kernel@collabora.com, 
 chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.12.4

Generate a modalias uevent for devices in the coreboot bus to allow
userspace to automatically load the corresponding modules.

Acked-by: Brian Norris <briannorris@chromium.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 drivers/firmware/google/coreboot_table.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/firmware/google/coreboot_table.c b/drivers/firmware/google/coreboot_table.c
index 2a4469bf1b81..c1b9a9e8e8ed 100644
--- a/drivers/firmware/google/coreboot_table.c
+++ b/drivers/firmware/google/coreboot_table.c
@@ -53,11 +53,20 @@ static void coreboot_bus_remove(struct device *dev)
 		driver->remove(device);
 }
 
+static int coreboot_bus_uevent(const struct device *dev, struct kobj_uevent_env *env)
+{
+	struct coreboot_device *device = CB_DEV(dev);
+	u32 tag = device->entry.tag;
+
+	return add_uevent_var(env, "MODALIAS=coreboot:t%08X", tag);
+}
+
 static struct bus_type coreboot_bus_type = {
 	.name		= "coreboot",
 	.match		= coreboot_bus_match,
 	.probe		= coreboot_bus_probe,
 	.remove		= coreboot_bus_remove,
+	.uevent		= coreboot_bus_uevent,
 };
 
 static void coreboot_device_release(struct device *dev)

-- 
2.43.0


