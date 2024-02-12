Return-Path: <linux-kernel+bounces-61841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E046851750
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDD3328270C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4B33C473;
	Mon, 12 Feb 2024 14:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="u3EpcVKE"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723983BB34;
	Mon, 12 Feb 2024 14:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707749486; cv=none; b=iyiPFVLAfm4i/vTJYhgYNx7srWLvNnr8nMVFPIbsKzjhgkD3ML8BimqHFtdOpulPr7nR2VO+Cye1ZdYU0FsaZfSnDUBL4ss5v3xkq7iq/NtebhhcUsPo7MIJfdR7cuAIpibOSqbMKCjUIpevpJSknBrRGD/cVRFYWW7JqzRQePc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707749486; c=relaxed/simple;
	bh=OiujR5lhNKhEimBkSB+EFRf6rM0jXBiQhXbfsxIV9UE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Axr3lIZZoUARrUmDPsZ8DoiUMmMIir94rlfbJJeziPBMLOZiUFQn7kyO+r8HOFWqjS+qlEuLXWaavOIG4T9K4O37UOhW5ZZR19A3HqItArnSa2/foANO+mgeK3hqBkEwelvsVouMyI5etZ6uwOhAUpxKW2MDCA0NPG8Mh7cYgHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=u3EpcVKE; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707749482;
	bh=OiujR5lhNKhEimBkSB+EFRf6rM0jXBiQhXbfsxIV9UE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=u3EpcVKEmcqpDIx/5waMjmUKIUIl0Boy2XqZqUi01fAXxocc0wSx+sXm6HN4uQy5/
	 sXZITsUKLcGkbFg5ity4LvFazzYGWMSogdiQdLFlO7+Bb0DhGbHZxNgyh/1fRQD/kZ
	 rGjpPm8YYdNYAFPXd7seJX1G1YCVx4UYgjZuwDjVDwqsStncmt+/yMI3+DdnJA/3e2
	 Q13eGoqmTLdyHKgjLRdqJ+0ariP7aibUNHU2ZqdNJcEOzJwWwY54atV0+wFfmLsiHW
	 XjRjl6RnKlhtRCTpQsQ5CV4J+t+8nGG/Nr/qZRkauyG1rdZ5OkN1PJNwR4O2sp4nJ0
	 6suxZhvZcRxvQ==
Received: from [192.168.1.30] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 9C5FD37810EF;
	Mon, 12 Feb 2024 14:51:19 +0000 (UTC)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Mon, 12 Feb 2024 09:50:05 -0500
Subject: [PATCH v4 1/4] firmware: coreboot: Generate modalias uevent for
 devices
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240212-coreboot-mod-defconfig-v4-1-d14172676f6d@collabora.com>
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

Generate a modalias uevent for devices in the coreboot bus to allow
userspace to automatically load the corresponding modules.

Acked-by: Brian Norris <briannorris@chromium.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Brian Norris <briannorris@chromium.org>
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


