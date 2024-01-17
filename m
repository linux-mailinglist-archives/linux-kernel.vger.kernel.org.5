Return-Path: <linux-kernel+bounces-29350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BA6830D23
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 20:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82A5BB25E54
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 19:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58EB249FF;
	Wed, 17 Jan 2024 19:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ORwyB35h"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D670B250E6;
	Wed, 17 Jan 2024 19:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705518373; cv=none; b=SM+UrC4Q3EWF4uPS78a6V3oaEp+1X4XpXh1JGYiZl5Qig/reeVOnSdl2WuiV/oc+FegCHvh0sj/r+Vv61m9HF8djt8bpDfshPdJCEx3RWcxgqts3GemT5m6FzHa2SLihJSk0OUSe40HFxXmKevZI0lu6IGXApcr5LssTLIhQJpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705518373; c=relaxed/simple;
	bh=7YAKPQ9tYWmvfAcseobwrvrV34TmrklbQkwFX2veRSg=;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer; b=Ki5DRS2t505FXzPZkMRkqdsUWQuU9LqoDwStLmduyW6X0QJUolCJfz1Ytf1FTZQIm/PAFLbv+mRGyZ119PPZtH/61RdtPJI3aAXD6XgrgjRTv072PztweAdkV4CEQ933CoWYIWEfdlNqOC1B9ssIDuF8Mi8LGYQzU6bwVkrzrqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ORwyB35h; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705518370;
	bh=7YAKPQ9tYWmvfAcseobwrvrV34TmrklbQkwFX2veRSg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ORwyB35hhAm9kLf8Bcd4HROoAmtgxqxmS2ACAQ3fMDQGcNkW2bMbpuzV+ZJ5HxfpD
	 DgAY4TMzhNP4tMx939kuxoUA+F9xlD9veVlaQg4tWJiRsBCsOmBIkRGzN+hCYE7k6x
	 DVjsw7r6MSfnrTTzQzk+Y9s2tdeuvcgvQJoZRHMdPrki05SHAIUfJNbz0iXuO/7fc/
	 mgjeG7NuuLZyX2a3WZVDL8s2UEnuznork+NcgqPbtL39ZBcHT5hnLTHqIG31x89TLz
	 jiSZiPUltHzQnngZFxZxJeyJwLWx2hPufU4p3uo56YXb2CJDicn3CZ93w4Zn6ndz+z
	 WTUBtWQUORmaw==
Received: from [192.168.0.47] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E08823782033;
	Wed, 17 Jan 2024 19:06:04 +0000 (UTC)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Wed, 17 Jan 2024 16:03:25 -0300
Subject: [PATCH v3 4/4] arm64: defconfig: Enable support for cbmem entries
 in the coreboot table
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240117-coreboot-mod-defconfig-v3-4-049565a27bba@collabora.com>
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

Enable the cbmem driver and dependencies in order to support reading
cbmem entries from the coreboot table, which are used to store logs from
coreboot on arm64 Chromebooks, and provide useful information for
debugging the boot process on those devices.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 361c31b5d064..49121133f045 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -255,6 +255,9 @@ CONFIG_INTEL_STRATIX10_RSU=m
 CONFIG_MTK_ADSP_IPC=m
 CONFIG_QCOM_QSEECOM=y
 CONFIG_QCOM_QSEECOM_UEFISECAPP=y
+CONFIG_GOOGLE_FIRMWARE=y
+CONFIG_GOOGLE_CBMEM=m
+CONFIG_GOOGLE_COREBOOT_TABLE=m
 CONFIG_EFI_CAPSULE_LOADER=y
 CONFIG_IMX_SCU=y
 CONFIG_IMX_SCU_PD=y

-- 
2.43.0


