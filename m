Return-Path: <linux-kernel+bounces-117392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A2388AACD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04CD034268F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CE713280D;
	Mon, 25 Mar 2024 15:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SPwZ4Igs"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA16E7317C;
	Mon, 25 Mar 2024 15:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711381153; cv=none; b=C0EuOaFQQcRc5XSKyBWULNVkm9/7yCf41yLH+h88CZjEjH1L6jS3xtZkAjVnCnXye8BzDvaxJG1HYYZ6168vtapAQ8C82c15OZC+w/e9jkYYmZCqr0/Ejjtt+8ojwDxzjs9kNGR2gVMIMwzYi8N+XPVfEs+QNz5jL+8dkHSKvVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711381153; c=relaxed/simple;
	bh=I3p4Ib0ISW7IQcsOO8wa91qosPmVrlgxRcCilUELSWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MdGFlUzUBnR/vDVU0ZAHhsyf9Xj91mNBAbbjU2xx3BuHzg18gacEhmE/g1VV5VWmZ5ESx00isEN93BOF3IM71vjig1AeSqFCDd223ClAiIIpgR/4DR5kRhpseoLjI56Y/TOV/6y4A2KvbNF/8jho6xQVY6Rmirot+04oK3aKvEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=SPwZ4Igs; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711381148;
	bh=I3p4Ib0ISW7IQcsOO8wa91qosPmVrlgxRcCilUELSWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SPwZ4Igslqq8cVcUFNt0jAQDh1F57pq5lT93gOA2EuPpG6+DiNigoyClRTBxq+top
	 WukpDbcUjOWh/M3jWTqsLv+0tSwyTIGtEKvmoWAzswrwtuzSK4cvh7Vwa8uapVtlrR
	 LOPL84gY8duLNLWn4B3yU3CUT0FFXL+8Oo3QOj7hEWIraOfENqwGraQ8ctl/2JM9OJ
	 6RYs3B4fHn+IPowVN2Lk978NnDooF7teQVhc3ypdYw7E+o/V1tL0AMeZOgx6T1SWue
	 w0ZlAZntqlRwoTfcByFIX+mAPUb9dTOX7fynkXsl6Vk+HMGiFCSGvQ7hi2FJLOUIlS
	 y3e7evKr9dG0A==
Received: from jupiter.universe (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D350037820CA;
	Mon, 25 Mar 2024 15:39:07 +0000 (UTC)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 6F8BD4800CB; Mon, 25 Mar 2024 16:39:07 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Heiko Stuebner <heiko@sntech.de>,
	linux-rockchip@lists.infradead.org
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	kernel@collabora.com
Subject: [PATCH v1 1/4] arm64: defconfig: support Mali CSF-based GPUs
Date: Mon, 25 Mar 2024 16:37:18 +0100
Message-ID: <20240325153850.189128-2-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240325153850.189128-1-sebastian.reichel@collabora.com>
References: <20240325153850.189128-1-sebastian.reichel@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable support for Mali CSF-based GPUs, which is found on recent
ARM SoCs, such as Rockchip or Mediatek.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 2c30d617e180..65e33174f813 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -907,6 +907,7 @@ CONFIG_DRM_MESON=m
 CONFIG_DRM_PL111=m
 CONFIG_DRM_LIMA=m
 CONFIG_DRM_PANFROST=m
+CONFIG_DRM_PANTHOR=m
 CONFIG_DRM_TIDSS=m
 CONFIG_DRM_POWERVR=m
 CONFIG_FB=y
-- 
2.43.0


