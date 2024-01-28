Return-Path: <linux-kernel+bounces-41817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAECE83F809
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A48E1F23E9E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F6814461C;
	Sun, 28 Jan 2024 16:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V8CR4WqQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DED144609;
	Sun, 28 Jan 2024 16:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458604; cv=none; b=ElGgYG4h8s+s4FP7pg3mfTeOLGsr1oV3LX2/CscudEZoPELLcpQOAdeH6TC9FPGamHXgaOlzsYPRgIQiYGYv9gh1EqTYl/ecEbpV2ZcQhIvcZZz2skLzmHisEZFcOzKbsOYyalw+pSup8TgFOMz206GttxppDPH/6Ruo5cY1mBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458604; c=relaxed/simple;
	bh=7Ag27uZL+0onuC6L2LLi1iOE8Tf+fmEvI6rkWRCAC+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FwF6VTHVa0xWGO5CpG803LJLR+CjcIqNUESdXvxMPciGTFZeIh7OtOA+Bx3XpcAOviJm2847MMhfZeW57RMaMbIi+2UhikoTk2M+uBStfoKASkXrp+PBvbc7Hw6qEc2FzS+/0FpcsLKrmI6sR2EfYTk32U1wmzbMC9laZUjZQR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V8CR4WqQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D45D3C433F1;
	Sun, 28 Jan 2024 16:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458604;
	bh=7Ag27uZL+0onuC6L2LLi1iOE8Tf+fmEvI6rkWRCAC+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V8CR4WqQN6VynaBB6FtZHNE/q97RCeebsC+f+6+5BxFYMW6Dugyh3vsQ+BdXmagv6
	 zjpiNurqvO8QkYblT7l8359uj/c2zWp5HfR1o3dbnSb4sxL0xXtr9gCxGSwgAM+rwX
	 2P8PPE5CGh9wwziGIKDk0t28TRUl7DxmESl5xLTQPtSgYn/MeeRHXOvh+3awFhhDuL
	 BkTzGRRucoT94dqGCp5lEMB7F6YGIAirOqOD/gebjfKJei8+hjsynbDl6q2VBUPkTb
	 WrgvsuYB+JN0+O4f1s61KdM+wUHdE8360GMWNnB5+0WwgpKNGGduJviADoKbZoPks5
	 aZTSg6pIAyyrQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hardik Gajjar <hgajjar@de.adit-jv.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	stanley_chang@realtek.com,
	ricardo.canuelo@collabora.com,
	johan+linaro@kernel.org,
	heikki.krogerus@linux.intel.com,
	royluo@google.com,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 03/11] usb: hub: Replace hardcoded quirk value with BIT() macro
Date: Sun, 28 Jan 2024 11:16:24 -0500
Message-ID: <20240128161637.205509-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128161637.205509-1-sashal@kernel.org>
References: <20240128161637.205509-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.268
Content-Transfer-Encoding: 8bit

From: Hardik Gajjar <hgajjar@de.adit-jv.com>

[ Upstream commit 6666ea93d2c422ebeb8039d11e642552da682070 ]

This patch replaces the hardcoded quirk value in the macro with
BIT().

Signed-off-by: Hardik Gajjar <hgajjar@de.adit-jv.com>
Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
Link: https://lore.kernel.org/r/20231205181829.127353-1-hgajjar@de.adit-jv.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/core/hub.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 9a1954e9f6f1..8e55eadb8feb 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -44,8 +44,8 @@
 #define USB_VENDOR_TEXAS_INSTRUMENTS		0x0451
 #define USB_PRODUCT_TUSB8041_USB3		0x8140
 #define USB_PRODUCT_TUSB8041_USB2		0x8142
-#define HUB_QUIRK_CHECK_PORT_AUTOSUSPEND	0x01
-#define HUB_QUIRK_DISABLE_AUTOSUSPEND		0x02
+#define HUB_QUIRK_CHECK_PORT_AUTOSUSPEND	BIT(0)
+#define HUB_QUIRK_DISABLE_AUTOSUSPEND		BIT(1)
 
 #define USB_TP_TRANSMISSION_DELAY	40	/* ns */
 #define USB_TP_TRANSMISSION_DELAY_MAX	65535	/* ns */
-- 
2.43.0


