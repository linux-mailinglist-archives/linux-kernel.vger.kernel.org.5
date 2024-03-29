Return-Path: <linux-kernel+bounces-124618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C57B891AA4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C8C21F25394
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7306E15B55E;
	Fri, 29 Mar 2024 12:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ehYDRoCJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF95015B969;
	Fri, 29 Mar 2024 12:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715560; cv=none; b=QTFnHjikJOPk1+yEoDqYcV/EWlCJan55eX5OmzsWFMwtJGZFJXgsaszB0WTJSyAX3P5DrUvK6ZTeWbh3+ZaYsACSuIHSDVgIkpwxDDGrxmfbOlw4daLsn3BQrIOuuxQjdOEH4/N0xhijoDSbDd0RLSqCUv0mKhThov1ZzlHC9hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715560; c=relaxed/simple;
	bh=9KaPcBd2w3GO4IWPKE/D0ZVEMbN7tvs/SHcXt8jm7UQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mvrFqLcfpMPib7t7cwKBOqcFx83y51PIBGRJgFDaxec1VKR/iZqoUUiEapT/IIhr2awdr+QLOqzIpLyqsKHlf7bxiWb42KyF1tQNp7e0rWxQ682+48IL8VUmMg2fa2g3lYjErNZOqS7h0PdmtCwy/xLEBgDEmXqZKej8sgzX7tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ehYDRoCJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FF43C43394;
	Fri, 29 Mar 2024 12:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715560;
	bh=9KaPcBd2w3GO4IWPKE/D0ZVEMbN7tvs/SHcXt8jm7UQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ehYDRoCJY7eg9ajplnH0O/0JFHW9/kx+Mj0sIkBQUb5fwKps5FYW1pqEYKZetUW5X
	 oFOB0s7vyyvCcShCdXAcdIa90fbAXlz+796XgLrGgJFnsx4ST2WjTSIQNNGxfQbYS8
	 aATsKVqHKvTiKH+gW9KGEc7UFrSEzbx7m5aRK8F6nt24V02BFl5abcLlu6lZDQDsRD
	 1hFL0aAK3Cm0iuzIzGnBwosZe2Xya+xJNhVi/k6c/aZWxYJIxQyjpMpMPW0QxvmKh+
	 jhKd/jLUXB2/eFnAOA2dAxK2Ul/zYg5YvOhuRaw1wR1jjqUDUR4fkbcGkNcCTcLy4c
	 ORx3VjuYz5Aeg==
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
Subject: [PATCH AUTOSEL 6.1 15/31] wifi: brcmfmac: Add DMI nvram filename quirk for ACEPC W5 Pro
Date: Fri, 29 Mar 2024 08:31:34 -0400
Message-ID: <20240329123207.3085013-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123207.3085013-1-sashal@kernel.org>
References: <20240329123207.3085013-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.83
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


