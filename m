Return-Path: <linux-kernel+bounces-124579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E797F891A30
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2757284C96
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08730156898;
	Fri, 29 Mar 2024 12:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HRKU2zyV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECCA15687F;
	Fri, 29 Mar 2024 12:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715452; cv=none; b=HDcq5NVYbTYgLN0DbTIcusjXG75FjifgDYxUn5i5R31EU/3siZhyTOfrHH7yJUyJMU5KjfknLCOeJYwt1EZa2Dktnq6dT71Ada2tvLXeWYX1jcRlhIN+gN4LukChuUYH8KSz2R9GDTovIk5x7wbQpgKdtzv90CTxQs/3dHCxjb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715452; c=relaxed/simple;
	bh=9KaPcBd2w3GO4IWPKE/D0ZVEMbN7tvs/SHcXt8jm7UQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uLQXBdXsCqXjps3CUShSy3f66qAEle+GWi5ddIh3A6Vu29vhysPoajcXoO5qMQj1xiPcPxWZzjPouDX667BCAQMjL1d7pVNPIoxDXhJQowYq+YYwBz8ND7l1Pvr5RhemcsXAmxywkPKD8DCC9J/HciTAlKyTVoCAMsYkenazmD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HRKU2zyV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27203C433F1;
	Fri, 29 Mar 2024 12:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715452;
	bh=9KaPcBd2w3GO4IWPKE/D0ZVEMbN7tvs/SHcXt8jm7UQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HRKU2zyVWTq/TlpWv3KXZcgTt3Jh6HaGrJimzhTVI53XIC/z2xaeew7Z33iZI1YCQ
	 HmNxcwmPVdr25PIUKj2T9/y5LVx4LcApEbfG4aP7ycm41HupFnziEKrZhtrIZujxYj
	 VHdIQRTRmVZLlmUH5sbgTKTlVE9IHScNESwHi219DdWrnqZ8OmmbcFNQUCLbSbJHQX
	 P+IP6Hc1r7/66IBX1faDuhGqiGQ2i8rHZmVyEXbynbo2RteM2CgjIE6Nz3EhqlyrGC
	 MYYztjaJ7HNwOTTPC8NVZst+u7Xh5jV8fFPGU08auR+H4DSwo/xmLtzgbosaC2dl2S
	 /ckNurzR/zYRg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com
Subject: [PATCH AUTOSEL 6.6 28/52] wifi: brcmfmac: Add DMI nvram filename quirk for ACEPC W5 Pro
Date: Fri, 29 Mar 2024 08:28:58 -0400
Message-ID: <20240329122956.3083859-28-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329122956.3083859-1-sashal@kernel.org>
References: <20240329122956.3083859-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.23
Content-Transfer-Encoding: 8bit

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 32167707aa5e7ae4b160c18be79d85a7b4fdfcfb ]

The ACEPC W5 Pro HDMI stick contains quite generic names in the sys_vendor
and product_name DMI strings, without this patch brcmfmac will try to load:
"brcmfmac43455-sdio.$(DEFAULT_STRING)-$(DEFAULT_STRING).txt" as nvram file
which is both too generic and messy with the $ symbols in the name.

The ACEPC W5 Pro uses the same Ampak AP6255 module as the ACEPC T8
and the nvram for the T8 is already in linux-firmware, so point the new
DMI nvram filename quirk to the T8 nvram file.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://msgid.link/20240216213649.251718-1-hdegoede@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/dmi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/dmi.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/dmi.c
index 86ff174936a9a..c3a602197662b 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/dmi.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/dmi.c
@@ -82,6 +82,15 @@ static const struct dmi_system_id dmi_platform_data[] = {
 		},
 		.driver_data = (void *)&acepc_t8_data,
 	},
+	{
+		/* ACEPC W5 Pro Cherry Trail Z8350 HDMI stick, same wifi as the T8 */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "T3 MRD"),
+			DMI_MATCH(DMI_CHASSIS_TYPE, "3"),
+			DMI_MATCH(DMI_BIOS_VENDOR, "American Megatrends Inc."),
+		},
+		.driver_data = (void *)&acepc_t8_data,
+	},
 	{
 		/* Chuwi Hi8 Pro with D2D3_Hi8Pro.233 BIOS */
 		.matches = {
-- 
2.43.0


