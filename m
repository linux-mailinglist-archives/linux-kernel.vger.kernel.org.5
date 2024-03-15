Return-Path: <linux-kernel+bounces-104690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC6B87D265
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E07A7284F84
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0575644B;
	Fri, 15 Mar 2024 17:03:55 +0000 (UTC)
Received: from mail.enpas.org (zhong.enpas.org [46.38.239.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A0354916;
	Fri, 15 Mar 2024 17:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.38.239.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710522235; cv=none; b=WHQqg/ODhRHshBsvTlrpcSeubKIYVD4uX23eBgt4lIKrzW4gSVp0EbrhzNJf4I/P1unRvffRU0CDSrlQO9h29UDzoyd5igsGGIHVFHRHK2j4Gb7umiBTGrbfn0gx35hPkTiKyGT7lVi/5bLpnv3ylwhIDv4dLlCwpYbIfF26+T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710522235; c=relaxed/simple;
	bh=L8ekJX/7I2WmOQ/OuIxQtjFMyvHp8xDkf0qHYdDgrkI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jyetL+7FvUH/2fp3YMGRVIkk4CtmIRQvGZSbPuXCAy6WWLnIwpGfvr8TvdKraXHuHo8ELKk5x42OvSRhz4P9AFIpDGC5k0QNvFq5qZKe/z7RmxU2CLzs2jQ4BEUYRW8Txk4/k0pmh90zqIJo0jLl/DAWVUPbjWw0D0rnHbTNT5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enpas.org; spf=pass smtp.mailfrom=enpas.org; arc=none smtp.client-ip=46.38.239.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enpas.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enpas.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mail.enpas.org (Postfix) with ESMTPSA id 681BF10145E;
	Fri, 15 Mar 2024 16:58:17 +0000 (UTC)
From: Max Staudt <max@enpas.org>
To: "Daniel J . Ogorchock" <djogorchock@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	max@enpas.org
Subject: [PATCH v2] HID: nintendo: Don't fail on setting baud rate
Date: Sat, 16 Mar 2024 01:57:29 +0900
Message-Id: <20240315165729.17817-1-max@enpas.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some third-party controllers can't change the baud rate.

We can still use the gamepad as-is, so let's do that.

Signed-off-by: Max Staudt <max@enpas.org>
---
Changes in v2:
 - Made hid_err() a hid_warn() since it's not a fatal failure.
---
 drivers/hid/hid-nintendo.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
index 997c3a1adaca..395ed6b5ef59 100644
--- a/drivers/hid/hid-nintendo.c
+++ b/drivers/hid/hid-nintendo.c
@@ -2164,8 +2164,11 @@ static int joycon_init(struct hid_device *hdev)
 		/* set baudrate for improved latency */
 		ret = joycon_send_usb(ctlr, JC_USB_CMD_BAUDRATE_3M, HZ);
 		if (ret) {
-			hid_err(hdev, "Failed to set baudrate; ret=%d\n", ret);
-			goto out_unlock;
+			/*
+			 * We can function with the default baudrate.
+			 * Provide a warning, and continue on.
+			 */
+			hid_warn(hdev, "Failed to set baudrate (ret=%d), continuing anyway\n", ret);
 		}
 		/* handshake */
 		ret = joycon_send_usb(ctlr, JC_USB_CMD_HANDSHAKE, HZ);
-- 
2.39.2


