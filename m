Return-Path: <linux-kernel+bounces-114728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EB0888C31
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58D2FB2D2E8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BFF1A0B0B;
	Mon, 25 Mar 2024 00:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IBaar1a3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB45272974;
	Sun, 24 Mar 2024 23:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323311; cv=none; b=enU2QyJ/uhxuicKGJMq/XCZcL6vtN1+fsy6Lg34yvUMCQ0nJj/wyDJFrQt8uG1H5BCJ/i+wlehCMUkhYHz9iKmZTxmGp3kumlNFQjbibGz4AtzlQV7Brr3DB6lguhIU1scItNnKJO8O9DzH712PmLj2zuYR95tPczZgK85B0KEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323311; c=relaxed/simple;
	bh=cALgQIXPRsKE1+5Ub3lHmnVuOotKVtUp6ahf58Vi568=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OEhIMV1Pb7WgmLRlzQ3qwtd7LyEW/2QHt4q+B5agzW0nnjQ7wOMDde+xeFcapGqq0+IAMoUuMT+oHfdKNl/FRSeM8kCNxDCa2xbbU5nSJxa3tsNN6Z/gQv1P2rdmLq5hsBzf0r5tF7ksYqfc3ki1P6zXon7IJwdcUoBc7Y733cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IBaar1a3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A3EAC43394;
	Sun, 24 Mar 2024 23:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323310;
	bh=cALgQIXPRsKE1+5Ub3lHmnVuOotKVtUp6ahf58Vi568=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IBaar1a33epz0wm+ebnXc7wcW5tnYKWKtSsHLdScC5ahj3qjYH2mz1IZ5sceHzqU2
	 cB6FkE8ZTHZxMQCgvP5SrQ/Eidl0y1nr6FQyxshqBKA9ev2oTgSfDyewB9LyR6zIOw
	 sePHdlFDONjOOYWa2LPpyEW1HILyaDqDH4fh2S2iAm9uvKy9ipxUEqfbrebEUMDjiC
	 rV3B1Xfj29zSeTHXW2MK6l6kDzbOi9qIVS+ODFw7oMh4RJ+/pi544S9UsgcNzTk0Qr
	 0U058Ksyu6FA+hamGWJNLtZXyFEV6iNopi4GMTZ/LWa1u/ivao0ShXX87jKrgYL2AW
	 wSTh4PjtVkx2A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Manuel Fombuena <fombuena@outlook.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 010/317] HID: multitouch: Add required quirk for Synaptics 0xcddc device
Date: Sun, 24 Mar 2024 19:29:50 -0400
Message-ID: <20240324233458.1352854-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Manuel Fombuena <fombuena@outlook.com>

[ Upstream commit 1741a8269e1c51fa08d4bfdf34667387a6eb10ec ]

Add support for the pointing stick (Accupoint) and 2 mouse buttons.

Present on some Toshiba/dynabook Portege X30 and X40 laptops.

It should close https://bugzilla.kernel.org/show_bug.cgi?id=205817

Signed-off-by: Manuel Fombuena <fombuena@outlook.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-multitouch.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index fc04538d93cbb..2e14e3071aa69 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -2151,6 +2151,10 @@ static const struct hid_device_id mt_devices[] = {
 		HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8,
 			USB_VENDOR_ID_SYNAPTICS, 0xcd7e) },
 
+	{ .driver_data = MT_CLS_WIN_8_FORCE_MULTI_INPUT,
+		HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8,
+			USB_VENDOR_ID_SYNAPTICS, 0xcddc) },
+
 	{ .driver_data = MT_CLS_WIN_8_FORCE_MULTI_INPUT,
 		HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8,
 			USB_VENDOR_ID_SYNAPTICS, 0xce08) },
-- 
2.43.0


