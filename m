Return-Path: <linux-kernel+bounces-116116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2B58895D8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F020EB27184
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35340182742;
	Mon, 25 Mar 2024 03:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N7JyjnqN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11639280217;
	Sun, 24 Mar 2024 23:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323639; cv=none; b=F0U6e3vN0oSlVyx9DjEeryu5a2ucRgcQP6b/ZEnLdrxbeELJf+nbHS7NulxP7vi1yO5k+EWELo93Z7NyZpRW+fJVpLbg/TEq6DLJu2isrXWKTTK6IlZQOm/+wFtOOeG/9JA/8LzDa3X9VQuSZV8wiU8Mb1KtlSw8fHbJTnlZzcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323639; c=relaxed/simple;
	bh=c6/DOxUKRsUIHujFZ6RcUlM4sO3EWtCuNBhifZZp5eM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ncG8Lk8PJ4Gd/O8vvJpL1Q+q8yqP+tdUNb+oTsM1SXvTG8xGi6Yj+JGsusyZZrxZHgwt2yDj+FlbbAnUGNa4RcviAFqgsc7uscFQO9/aM0yyL9WiWj5HRXgRX04m986JWYDSy6WoCrBi1hCkLQC14jBph5YjxgszABHsHTxkBzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N7JyjnqN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53C46C43394;
	Sun, 24 Mar 2024 23:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323638;
	bh=c6/DOxUKRsUIHujFZ6RcUlM4sO3EWtCuNBhifZZp5eM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N7JyjnqN53NrDrTTd2dFT9IYwnpTuOprB4oA5gume2NnArcggp/9edMsm/JbNCXuz
	 CMd7YjvCFkvbGkmVDie4wvt26oivq8kxIo6X02qWtNoWVRVPWEOREeL6Ww3thnoOEO
	 k3jv1bWr1NShy2BXpdtVG4QTPZ1BaNWKguPIiYuMfwbTfYAL9VQqYcMQu5QrFDSIU/
	 ruoVmd0duyCVi0DyIOnT0HMnu6hwAmLl+ISQmJj1uq1EJoJ8utSOUHxoKqYp73t3Ht
	 maw7LDKGxJEhOHszqYmPHZgodZR+dARRhX9T9VZtSpxN2Aut9Qy+Ry2oYev0tbuLcQ
	 kxTKZJqzNvqWg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Manuel Fombuena <fombuena@outlook.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 010/238] HID: multitouch: Add required quirk for Synaptics 0xcddc device
Date: Sun, 24 Mar 2024 19:36:38 -0400
Message-ID: <20240324234027.1354210-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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


