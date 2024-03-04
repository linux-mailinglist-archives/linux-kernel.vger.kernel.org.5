Return-Path: <linux-kernel+bounces-91097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D84408709AB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BCEAB29022
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF03626AF;
	Mon,  4 Mar 2024 18:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="iIgJffdo"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852F061675
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 18:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709576934; cv=none; b=hgK7k95+d6UfMoZ900UxYrr4TNujRkQrkAWI7Id+UMubPPQvCShzqKvb+U9Ww7zVy43pOQXc9GTzDdpgjagDrZNhpozqtNZsEKgQUSbBeSFuP5zXmu7K44vfRXm7xhKu1G4NEg9baVZfog6sgICl2jjPSRm22NtQQZX6urH57sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709576934; c=relaxed/simple;
	bh=v9K54mCWFGXxTmk+0kMTeT8m/5ID9PzFuet4Ue7lEa8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=R0S798C+HvhIqRt5yl3HMsQabrRilCoKMUsO3UTQykhXP+WDzclqX7cGsiHw5S5faVWjokzXqlq0E0yXbVaNNVghYVbvoDt02NpnYqOkITL+U/HMGOh4/7r7hulspVhPliXDWOfuXr+TDHLwARrcoU6Vle/6wZGli5542SSqA9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=iIgJffdo; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709576930;
	bh=v9K54mCWFGXxTmk+0kMTeT8m/5ID9PzFuet4Ue7lEa8=;
	h=From:Date:Subject:To:Cc:From;
	b=iIgJffdobUV6zPpFOTq1ofzrrvjiE+JvULRCF/zLUCFl/dCOU+nUvJ6x715Lf4Hil
	 SVzlcsdWy+5pjLlukRBlxm1/sTXXDPbQ2ND9e0GkUPpeLU5OaC1aalj9OZaM/IVGc4
	 ZmnEg9HVbBryGVWuChAZUqYMvLmn7/E5bYOS9QLbD5hwNmCPSNhkIpWkTIuEr2z1GD
	 p4WXBUxn3L3IE5w+n0l5CzyEXfmv+4sQd5FU7ck+7uQWpIjOhhwUYxvJlqdnh6EWHj
	 jqlBgLTj8GLdDiNJCHy2RPX8xyVVy9DdnmM0JVG/MiaYzR8krm5V2kbtgwfd4zUFMg
	 4IF5Po/2eaBtg==
Received: from [192.168.1.234] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B776E3780C6C;
	Mon,  4 Mar 2024 18:28:48 +0000 (UTC)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Mon, 04 Mar 2024 13:28:35 -0500
Subject: [PATCH] arm64: defconfig: Enable support for cbmem entries in the
 coreboot table
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240304-coreboot-defconfig-v1-1-02dc1940408f@collabora.com>
X-B4-Tracking: v=1; b=H4sIANIS5mUC/x3MPQqAMAxA4atIZgtVY/25ijhoTTVLI62IULy7x
 fEb3ksQKTBFGIsEgW6OLD6jKguwx+J3UrxlQ61r1I1GZSXQKnKpjZwV73hXiIPpXdt2aAzk8Az
 k+Pmn0/y+H6f2ks1kAAAA
To: Arnd Bergmann <arnd@arndb.de>
Cc: soc@kernel.org, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
 kernel@collabora.com, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Brian Norris <briannorris@chromium.org>, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.13.0

Enable the cbmem driver and dependencies in order to support reading
cbmem entries from the coreboot table, which are used to store logs from
coreboot on arm64 Chromebooks, and provide useful information for
debugging the boot process on those devices.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
Patch split from
https://lore.kernel.org/all/20240212-coreboot-mod-defconfig-v4-4-d14172676f6d@collabora.com
as it's independent from that series.

Rebased on top of soc/for-next.
---
 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index f9cc5bff157c..97888eabb328 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -251,6 +251,9 @@ CONFIG_RASPBERRYPI_FIRMWARE=y
 CONFIG_INTEL_STRATIX10_SERVICE=y
 CONFIG_INTEL_STRATIX10_RSU=m
 CONFIG_MTK_ADSP_IPC=m
+CONFIG_GOOGLE_FIRMWARE=y
+CONFIG_GOOGLE_CBMEM=m
+CONFIG_GOOGLE_COREBOOT_TABLE=m
 CONFIG_EFI_CAPSULE_LOADER=y
 CONFIG_IMX_SCU=y
 CONFIG_QCOM_QSEECOM=y

---
base-commit: 856e4f898347c4b3dbe1ece5d8c511cf8858011d
change-id: 20240304-coreboot-defconfig-44968f557466

Best regards,
-- 
Nícolas F. R. A. Prado <nfraprado@collabora.com>


