Return-Path: <linux-kernel+bounces-114021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F528887F0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24259291177
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55F415ADAC;
	Sun, 24 Mar 2024 23:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZfaAVWgV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5E41E5F57;
	Sun, 24 Mar 2024 23:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321295; cv=none; b=ch7bE/Den6lGgJG/kLQoI+cKMQVlypR598q9MOX1mRZyXcNkuIDKVlueMtvecjbqG+vWqv14gHKruDRd4FaMQF0Rk+n7AgZuz9C3Y2kayaW9qb+R7Ssxsvea51OIADApOWotBT2kc0YQFtQGX29YpluNEWDiFjKbyrKVBlQV4sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321295; c=relaxed/simple;
	bh=h7vZhE/3zNxbW/raux5GMr5zWcoQY2up1hIwKwdJiis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XkHVXY4HcozmC77dD0GO2qI3fMRAqabDs4KNAXnc6wNMSKxRPa6WZ/ojN35cC3hDj9/UL+gpQ6T1mW7hzg2gMyfr16ZjAI0Is4KW5qbJN2mFKC40exUp6VwQH/YBjdProBMkbCBwz9yDWU+ItwunbIk4bpVUmnH2AWvzNo6Dlog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZfaAVWgV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1571AC43390;
	Sun, 24 Mar 2024 23:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321294;
	bh=h7vZhE/3zNxbW/raux5GMr5zWcoQY2up1hIwKwdJiis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZfaAVWgV/klIaQKULmM65NGqaANg8vq6TAC/L3XkbrdgZG8oq7f9fnijcv3GlzvIx
	 Dkf5ULEwUhj+hv2KtPxJeBla54XSLGolmqpw3VazHxrcrFFf437kae01fmNbEMQCxT
	 YVEGmJCBVMob0qA3BvcpbQ2V6M9CsCBx+AMDllTdyEBD7jLHfw9tv8E1yTNZv7Z/7+
	 mghGceDNQZbUmxHCfrbcpPW7/5tK9rpihpsFQhQ66+940ymQWzp78aw63bU7uvRtxv
	 O7GLQmMiTPHymLnxXZySKMfO1U3K+72G+T/o9wyUO3mss90txTBO1+puOZfRge9GvY
	 Q9IuKrC7IoeLQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Manuel Fombuena <fombuena@outlook.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 017/638] HID: multitouch: Add required quirk for Synaptics 0xcddc device
Date: Sun, 24 Mar 2024 18:50:54 -0400
Message-ID: <20240324230116.1348576-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index 5ec1f174127a3..3816fd06bc953 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -2153,6 +2153,10 @@ static const struct hid_device_id mt_devices[] = {
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


