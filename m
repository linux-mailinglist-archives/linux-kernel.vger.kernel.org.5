Return-Path: <linux-kernel+bounces-86993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9C286CE06
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D02E7B27823
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74AFC14402D;
	Thu, 29 Feb 2024 15:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FDyELvNN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A111C1433AC;
	Thu, 29 Feb 2024 15:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709221820; cv=none; b=MwEP9rkLnHkyp5GO82ojRl8aMKE7mBHcy/RfK+rQN6kFvzGW92ljI+6wIojcdEOQ4wQy8tf4IZ8M7JJw+lMcluVeSP0ajIWEh6/4gdk5KUnyepo6dYUnRPDR8qV2EcLi8QgBqRsc+M1xGa7kksea7j9vrRzE3T+UXuWFfNlrfPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709221820; c=relaxed/simple;
	bh=h7vZhE/3zNxbW/raux5GMr5zWcoQY2up1hIwKwdJiis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MZz1wnbU4f48SZ8KVVdW9Kq+D0iyXqsNXTCWNCrxLIvf97RAoABt04rSpRVO8q8QWBlgBBP6/qSvXNcRWUsuYxZ2JWr1D19Cj9EffpRmKCbveMzDWpmKqv1uKapPwiAvP5EBVdAc7u9dvA5LjvW386GbLibwWVhf4OWY8ibm7to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FDyELvNN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6149EC433C7;
	Thu, 29 Feb 2024 15:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709221820;
	bh=h7vZhE/3zNxbW/raux5GMr5zWcoQY2up1hIwKwdJiis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FDyELvNNUFO9xGtI8tRNDwWlTl1mfZZtR+/YdE5oFFaiiMoTmocNzDPl0iNIOV/yb
	 ivqWN/VEJMXL2e9hS9I/vjyheYwnkRVyWAKpRs5Ph0tPdbC+prlA76t0C3nVQkbFHr
	 4lLOcKif4M6AM+yA4LPGT2RvjTSjKvtQf/DKYzztASJ4i31NBkvp7YPBK9qNWPYXsG
	 lOVK3r3fn9pu9W30esdthLX6QOzwiHT69ALCmVl5rJ17jKBa/9Ki6zMVX1uReuppHj
	 zwDES/IIhmtP8kS1wL92CJCv9Q4vb9XrQzG5fDAWWaOKY86jk29bdZy+5vhTKx6qfe
	 Q3HZR2/Gv3s+Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Manuel Fombuena <fombuena@outlook.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	jikos@kernel.org,
	benjamin.tissoires@redhat.com,
	linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 18/21] HID: multitouch: Add required quirk for Synaptics 0xcddc device
Date: Thu, 29 Feb 2024 10:49:38 -0500
Message-ID: <20240229154946.2850012-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229154946.2850012-1-sashal@kernel.org>
References: <20240229154946.2850012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.18
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


