Return-Path: <linux-kernel+bounces-87027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D523D86CE69
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 754A3B28E78
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F19515F8BD;
	Thu, 29 Feb 2024 15:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="khv8LNIK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA21215F8AB;
	Thu, 29 Feb 2024 15:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709221895; cv=none; b=FfhPEmY1q5ZGNKVJ1bX3L8D4dIydq4pCfNLncZAuRn4u1TPOa3lplGz9m45lbfLNXxVALVrv6ooZOd0VCTr052yqCfIYmljxXFZGqA+UZHquLgU3d+bnfXdXhuRJFnY1euzEpemAvaulvumbKU9CVpROZHc3OThZG+Pwfckn6PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709221895; c=relaxed/simple;
	bh=6zsh90FjlNz03vkNYYf8ZUIghWHUOsxZgTKLCL4hVMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tABvJuc0y4r/EMXrQWHXpjXNQPUJ7vT4b4R3kEJrrJdLapEMOJSWDWr9dHQd8BHugGH9RGqqZafGOrODnPojlyd8YzzNzi7u+grush1WGHEXPsWhLAmMqHGGOSNO2PQmo/Y9Ts8ddAZeyzAK4EoyebDhUE8TN6h1KpXyMFmG9K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=khv8LNIK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81D56C433F1;
	Thu, 29 Feb 2024 15:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709221895;
	bh=6zsh90FjlNz03vkNYYf8ZUIghWHUOsxZgTKLCL4hVMM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=khv8LNIKByT7u4sAIuRA4X6iq3M3sx5dDu0Pt6YLABdHs4QrUKZYClIY90lRZJ/OO
	 79BafSk7GXAiPR6Fs5AlWBCNIOfYWCFLC59aEIKsSkgXY7LAYFuOkUIOZLSSvYGMye
	 f1MCSQOdVo2dtyrF8dR6xa8dtflQoxxuQwTSB6IWfox6xsX8O6jP2fEDZ3+5jLCamK
	 hvJg2tBxGP9X9yBkafyXvR/Q+uItR39Rktu/S4G57q1uqfCSFPjPg5HfuUlvIyynbO
	 xNUm+rl3p57VaPtjzg3cEcQfF9yeojBKJHQT3djIly+Jsd+I4foQMWFnNvyJUSKdFI
	 4cAMs3eZQepBg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Manuel Fombuena <fombuena@outlook.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	jikos@kernel.org,
	benjamin.tissoires@redhat.com,
	linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 5/5] HID: multitouch: Add required quirk for Synaptics 0xcddc device
Date: Thu, 29 Feb 2024 10:51:27 -0500
Message-ID: <20240229155127.2851327-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229155127.2851327-1-sashal@kernel.org>
References: <20240229155127.2851327-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.269
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


