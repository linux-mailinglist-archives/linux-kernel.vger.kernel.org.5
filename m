Return-Path: <linux-kernel+bounces-124771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5CF891C5F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEDFFB29668
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809FE1836DB;
	Fri, 29 Mar 2024 12:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h1lQygJO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4CD181D1C;
	Fri, 29 Mar 2024 12:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716112; cv=none; b=MGX3jvcrRPU7gfliILFM68qvhhhlazkp4dhDcrdlygLNPJFZREiqk+r6CctpvRoCgCMY1UAXi36p71N36YbSuqkzV9MveOmceRMO/oRHCV5bzYpW+ZWtxaqdR1jCGP5qvnLWPeHCKTmuUkxh2Aff+u4r23J6swk7OWZvdvvR834=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716112; c=relaxed/simple;
	bh=N9NLZwnyfGXSjCFwpZS/eluPGucTnHJguKQARkgOkCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dDgTT+BY++zZSJvNVPt9z8JM2vs0x6POEiS/8VueUHOtcon5ADPxSRUg/zfXY3OP7GN89hrUmel1XVr+sTtuPjMDpe4AqWHytgap2FtQdG0eYzUfi2x1krTq/hIk334tOabqWwrGS/WMfwtY+4/0yeujxA+uy5Nw+SltCJt8aEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h1lQygJO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7755EC433F1;
	Fri, 29 Mar 2024 12:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716112;
	bh=N9NLZwnyfGXSjCFwpZS/eluPGucTnHJguKQARkgOkCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h1lQygJO+jEeKqbIsHy8GCXS0loVjE1ZI7k/FqFO75SXXf7SAEdkjzV4aLRRBW1UU
	 d9pMQMLOi0EoLFPyganir6UfAfBHgUNg/ZGrsfimZdzk9rdfj1pWtMzfER8n3aOAH6
	 f5qdHNCukkEu4hgoB298PZYiM7RRbPNXTrjkpCOZXFpZuZ40wTwEoYKwoBnWnYiQMF
	 97aDORCowQZwjaJ2eTMEJlvrlH/Je/yfiMcNsPn1ahNAXnIFORXyl3qkwoVOvd6yGT
	 YIuxyhU8Tke3fpPxCDz8WxwgJXj2VlZ8+oYxoHEGVhpzvgDLd6TFqFE16W1dlWwe9P
	 8BYjYDWeUThtw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	jikos@kernel.org,
	benjamin.tissoires@redhat.com,
	linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 61/98] HID: input: avoid polling stylus battery on Chromebook Pompom
Date: Fri, 29 Mar 2024 08:37:32 -0400
Message-ID: <20240329123919.3087149-61-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123919.3087149-1-sashal@kernel.org>
References: <20240329123919.3087149-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
Content-Transfer-Encoding: 8bit

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

[ Upstream commit 9a5b1521e2d0d7ace70c6e5eed073babcec91409 ]

Internal touchscreen on Trogdor Pompom (AKA Dynabook Chromebook C1)
supports USI stylus. Unfortunately the HID descriptor for the stylus
interface does not contain "Stylus" physical collection, which makes
the kernel to try and pull battery information, resulting in errors.

Apply HID_BATTERY_QUIRK_AVOID_QUERY to the device.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-ids.h   | 1 +
 drivers/hid/hid-input.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 828a5c022c640..175b6680087e0 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -430,6 +430,7 @@
 #define I2C_DEVICE_ID_HP_SPECTRE_X360_14T_EA100_V1	0x2BED
 #define I2C_DEVICE_ID_HP_SPECTRE_X360_14T_EA100_V2	0x2BEE
 #define I2C_DEVICE_ID_HP_ENVY_X360_15_EU0556NG		0x2D02
+#define I2C_DEVICE_ID_CHROMEBOOK_TROGDOR_POMPOM	0x2F81
 
 #define USB_VENDOR_ID_ELECOM		0x056e
 #define USB_DEVICE_ID_ELECOM_BM084	0x0061
diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index c8b20d44b1472..e03d300d2bac4 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -411,6 +411,8 @@ static const struct hid_device_id hid_battery_quirks[] = {
 	  HID_BATTERY_QUIRK_IGNORE },
 	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_HP_ENVY_X360_15_EU0556NG),
 	  HID_BATTERY_QUIRK_IGNORE },
+	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_CHROMEBOOK_TROGDOR_POMPOM),
+	  HID_BATTERY_QUIRK_AVOID_QUERY },
 	{}
 };
 
-- 
2.43.0


