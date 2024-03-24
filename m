Return-Path: <linux-kernel+bounces-115756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E60CF889768
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F4B629D90F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A08369DF5;
	Mon, 25 Mar 2024 02:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jmf+dKUv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C421448DE;
	Sun, 24 Mar 2024 23:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321954; cv=none; b=kiotw0SIv/pItXQO1qbVhKwSWRuDMviPIEqr7Gc8g800BapCFaN78PsAGHi2k/92ssckvP1r2KgfsSrRVjgc/d5nRTqe5Txp23wMxWdfWDsq7zEeqJFp1WK3oBMuhA/xKcrWXoScl8nKHHpenrlWVdUEUeDaLaxEqyeIZubwfQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321954; c=relaxed/simple;
	bh=h7vZhE/3zNxbW/raux5GMr5zWcoQY2up1hIwKwdJiis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VYXQKO7byzfN8xT06ieIa7XOJ4B64g3dtIOjnCAanHqXSUVp1IDEWDjp51n6xn+qp18HUZGXZw1Qr489UrbgaHT0c0tO+TDD/hlKqv0DC5LJBNbJMjTBXniiGdyb+WmEjOzcV0kabPw3u19vU187b3nU379/RZgvmnc3F7m9vGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jmf+dKUv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D83B9C433C7;
	Sun, 24 Mar 2024 23:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321954;
	bh=h7vZhE/3zNxbW/raux5GMr5zWcoQY2up1hIwKwdJiis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jmf+dKUvuCUGOJBELDQrChZR+ceg3W2jYMHOAye3D6pyISJypYWWcOJByAOnLjymy
	 6DA8zDq+FCHUtuKaHzJN01M78t+AeNVgQgTuV0qZn8hISJt7ppKgWKCQv2CMzot5Ig
	 IUMuF4bWXZbxtpvHAZgyYCvP3TjKr5A07TrFVziNDQElgdoG/26L9dDRRiAWjEkWMX
	 AMWbJXiux64KqqSlJoWxk4RXLdDiaATs+74NKYsLlqpUeo46CEc3Gf7JQTJN0UM3eP
	 1gEr5Uk/vkSf3TN5FEZOIbnYI9Stiv8gDLGH/Y4SdTyyQ6M4ghap8bzXVQYhw2A3Se
	 Pg1wZy7ENQ0wQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Manuel Fombuena <fombuena@outlook.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 026/451] HID: multitouch: Add required quirk for Synaptics 0xcddc device
Date: Sun, 24 Mar 2024 19:05:02 -0400
Message-ID: <20240324231207.1351418-27-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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


