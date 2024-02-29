Return-Path: <linux-kernel+bounces-87021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 943EC86CE56
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C40AA1C223DC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C6115E027;
	Thu, 29 Feb 2024 15:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CXqkz2t9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D57154454;
	Thu, 29 Feb 2024 15:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709221883; cv=none; b=bBAHg+muws/ApoMCOCJI138IwGqgbAvAFYDR9D5Dc8lTJUn4nVqaq9dNeVt4bGLPM1BPXqVoQNBJ/QQU9s9a1NSspZsZWSQPVdeY2jjZ+ZAB9r8PkaFHSJONDOoqR4ykUCW6qXKwI1sz5wdgEXwVbsMZUL123k/c96Yy/tZy8uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709221883; c=relaxed/simple;
	bh=c6/DOxUKRsUIHujFZ6RcUlM4sO3EWtCuNBhifZZp5eM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PaSi2Ay1U3sYgPy2kAHlQp5S6HBO0T90wMXqxHXVeFQVoRWaTSpOV92so77q2zy6VqhcjPZWutonHUUuIGOZ9saaSkzdrGFl08YDM19hxxRGTf6jqtyQtubHcevz1JhvkQggQqHrNxUpbkDW00qMTrl7bZ+ByDHonGa5WtlxOSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CXqkz2t9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 526C7C433F1;
	Thu, 29 Feb 2024 15:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709221883;
	bh=c6/DOxUKRsUIHujFZ6RcUlM4sO3EWtCuNBhifZZp5eM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CXqkz2t9u2GDM2rOwD2VoNpQ2DINnc8A19fjpo144wAZUUIsXZf+zGXhSbwwcMiNB
	 XdNtmaosJn1lwdWWGvTHxeM2ZvkLmhCa/pj2JNNu/+i+CjqyLaWXDDK1Phj4GO+quS
	 TVIWNuyJiapKfbgWvvMGJXVXNQ4SlvAl+goccfhw4QI3HokWc2WFpWebGbX7lXAsZw
	 GIy1MeRc6Lr97//rGADMQlmrZ2sKV2Th9USuNm28X/U4TXj5+Fro4dnkiTjJBjynT9
	 NET08smkAQzS59mjVLgC5y6j3h87n/B7VwcBrAtSNw6iK4aaz0Ui7edF95Q3j8ebCs
	 z4/rO7D7sK05w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Manuel Fombuena <fombuena@outlook.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	jikos@kernel.org,
	benjamin.tissoires@redhat.com,
	linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 6/7] HID: multitouch: Add required quirk for Synaptics 0xcddc device
Date: Thu, 29 Feb 2024 10:51:10 -0500
Message-ID: <20240229155112.2851155-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229155112.2851155-1-sashal@kernel.org>
References: <20240229155112.2851155-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.210
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
index 7d43d62df2409..8dcd636daf270 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -2067,6 +2067,10 @@ static const struct hid_device_id mt_devices[] = {
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


