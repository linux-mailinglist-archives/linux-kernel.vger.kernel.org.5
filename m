Return-Path: <linux-kernel+bounces-87014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E126D86CE41
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EDFF1C214F2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42C41574D2;
	Thu, 29 Feb 2024 15:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQYhbH9Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3208F1574DF;
	Thu, 29 Feb 2024 15:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709221868; cv=none; b=YuTPbVg7qv4e7y4wvv3h3Vi8Bz/vS6fzcsLNkN3mESV5m+G/89MyFQfCN+rDfWIu26CMOtUjDt/5rBJkG3ptmU3SpdiwAhXGXPWgg6dBPcDV8U1OhI9eHrWWXCGqIOnCBf1C79HvjmwQsATkqgR8Ikc5UzKt8mg/P/zkFg8Adc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709221868; c=relaxed/simple;
	bh=cALgQIXPRsKE1+5Ub3lHmnVuOotKVtUp6ahf58Vi568=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sb/3OlUGcgWuJEbt8Sbazl7oFtXUine0HzCtkXIueroWcM/fwvBTVsM/c1bNOTgnSsYHBQYBCUAbfzR/KZ/FJUqClMJRcuv7J2TDVkZA6hNI6SSN3g6md1JhSSU2v3PH3+UbuYxfkHKZoY2AnpcPc7+rYaOLXLAWXY65oIUDiTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QQYhbH9Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1521DC43399;
	Thu, 29 Feb 2024 15:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709221867;
	bh=cALgQIXPRsKE1+5Ub3lHmnVuOotKVtUp6ahf58Vi568=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QQYhbH9Q9EO5rzcTtvTLfH96ihGTTg7Yf2DlqulsclD2aOfyROpJHSn4z2BUPM/lh
	 aicdIucnKf7vK7MmtPDk7Frh6xecgzcmEt1Gnxa1beFWiIXJ3mFzfm+phSSZ/7EPLQ
	 /QOsZoXv1hyc4U2nuN78GdTd4yDxjMXlRXJu9Vrdm3XVGF1c5LqtWZ3xbmBZLOC4d0
	 zsRz0/tjQOvP2l9CmxDzBPdmG+L0234GxhEr2kdZ/xBr3qJD6xx6A2HMTOYnfVL5gT
	 3SPn2Azlq9FhIjxZdpV5YV/+g2+r7di0l/R5+C4rvY9bKj5bYXa/M/2FeN0rnri9yj
	 m3F2SSV61xgRg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Manuel Fombuena <fombuena@outlook.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	jikos@kernel.org,
	benjamin.tissoires@redhat.com,
	linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 6/7] HID: multitouch: Add required quirk for Synaptics 0xcddc device
Date: Thu, 29 Feb 2024 10:50:55 -0500
Message-ID: <20240229155057.2850873-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229155057.2850873-1-sashal@kernel.org>
References: <20240229155057.2850873-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.149
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


