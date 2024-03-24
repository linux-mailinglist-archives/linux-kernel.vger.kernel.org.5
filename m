Return-Path: <linux-kernel+bounces-116248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A8B889DC0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAC201F36C90
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232303C4256;
	Mon, 25 Mar 2024 03:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MXDyNkkl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2616C17EB7A;
	Sun, 24 Mar 2024 23:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324008; cv=none; b=IGRXn2PToLk3saSO6QiEv2Nfz7eXOTaNfpxF2ZQE5xPygC1mb4EbUGYBu8+0booPL/4lhcR978aSkXhKjt9+Z/0g7VR7y1aAI1BmvaLK+WpJ40Jj9CuDnIT3Y7/sf6t0bGR5R2/vBkSZTYGxUWFnEcOlGtlJ4vl1PAeP9C2p7rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324008; c=relaxed/simple;
	bh=6zsh90FjlNz03vkNYYf8ZUIghWHUOsxZgTKLCL4hVMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ja1lqz7a+bjYR3gUaDv0mbBeMNKE4P6yPOBNsrzxn04YrI/mW0HjQR6FhXHeUBKN75IKPx3AMoXaZTMfr4siFpKPmgj7CvQQEWMDRx4097M/pwzqy5J9mkSyIZprSilHraNpxgGnmlgsr0xuu8Pzcau+UEJnDf5KJIkfQ7BG+mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MXDyNkkl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BBBDC433F1;
	Sun, 24 Mar 2024 23:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324006;
	bh=6zsh90FjlNz03vkNYYf8ZUIghWHUOsxZgTKLCL4hVMM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MXDyNkklRmk52bcbitSxR/aF337OSF+q6tFmarZR9rvz7BNR5kPHrJ7PQx6UxJDDv
	 kGznPmjiRKrySsTcox+XO52wehabY/gvr1DV8928DqZ3jJCuEKqA9Hxf1elLZAFB5R
	 N88M3gcrBFDCYDOhyRaEI/A+1gL0m136YQyAP2CE54melwnt6SIzjWsJBZGkn9SN3O
	 piFE/UWHMKjKIaz15PA0o+izfYpqXnl/ptCzykWW3fbpIhFfNvLJyPKwJK+HLrYspu
	 BkMr2wz8f0RMCfHhJwSvpSDpQOTXyhUX5Zrp6mBmB7cwqZc5S5KPeiBDoyeXQtifU8
	 Tb8Bi10vo2NxQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Manuel Fombuena <fombuena@outlook.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 007/183] HID: multitouch: Add required quirk for Synaptics 0xcddc device
Date: Sun, 24 Mar 2024 19:43:40 -0400
Message-ID: <20240324234638.1355609-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
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
index c37399f61c67b..c3810e7140a55 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -2090,6 +2090,10 @@ static const struct hid_device_id mt_devices[] = {
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


