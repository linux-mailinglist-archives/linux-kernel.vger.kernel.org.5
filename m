Return-Path: <linux-kernel+bounces-56780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB5E84CF0C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 17:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 499B0284E53
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A657A82D88;
	Wed,  7 Feb 2024 16:37:43 +0000 (UTC)
Received: from mail.enpas.org (zhong.enpas.org [46.38.239.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E045823BF;
	Wed,  7 Feb 2024 16:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.38.239.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707323863; cv=none; b=iZ6IJItjKGV+Xkema5l8n5dq/GfxxZ/4JKY55dO5/bjdaXDD3DxWP2hwKuXHsb0brkRUPKFyCPA3Re+Hbkp5TeOzEl3WBOHNkM/dzA1DIUVp5m2zUzmz7iBkdCNlSFiNry7KT6CXR+XcW8X3zy5EqsXVzXzpaOZ40k/FKmrEDBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707323863; c=relaxed/simple;
	bh=lOHItdgJbiCuF+QTQQRRcLdSwBfpIamrEpzDEwqonUA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fuqZhe5xJt33j/2XwLLNQbN3yP+jCMIv2PXs1jAPoe3/CR8vVGtHVuKZHdjGqYiWwiB1fwOUe7w3fx69qRWTJhvfpmODtRShQyUCICOp3ofvkZxiEwAETPBMgdqSdAcawhb8pz7JSM5uz3QvpgRztXAbmD4ExkkA5YdVsLLt8+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enpas.org; spf=pass smtp.mailfrom=enpas.org; arc=none smtp.client-ip=46.38.239.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enpas.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enpas.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mail.enpas.org (Postfix) with ESMTPSA id C04F7100BB9;
	Wed,  7 Feb 2024 16:37:31 +0000 (UTC)
From: Max Staudt <max@enpas.org>
To: Roderick Colenbrander <roderick.colenbrander@sony.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	max@enpas.org
Subject: [PATCH v2 2/5] HID: playstation: DS4: Don't fail on FW/HW version request
Date: Thu,  8 Feb 2024 01:36:44 +0900
Message-Id: <20240207163647.15792-3-max@enpas.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240207163647.15792-1-max@enpas.org>
References: <20240207163647.15792-1-max@enpas.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some third-party controllers can't report firmware/hardware version.

Unlike for the DualSense, the driver does not use these values for
anything in the DualShock 4 case, but merely exposes them via sysfs.
They will simply be 0x0.

Signed-off-by: Max Staudt <max@enpas.org>
---
 drivers/hid/hid-playstation.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-playstation.c b/drivers/hid/hid-playstation.c
index 7f50e13601f0..df50ca4dab90 100644
--- a/drivers/hid/hid-playstation.c
+++ b/drivers/hid/hid-playstation.c
@@ -2558,8 +2558,8 @@ static struct ps_device *dualshock4_create(struct hid_device *hdev)
 
 	ret = dualshock4_get_firmware_info(ds4);
 	if (ret) {
-		hid_err(hdev, "Failed to get firmware info from DualShock4\n");
-		return ERR_PTR(ret);
+		hid_warn(hdev, "Failed to get firmware info from DualShock4\n");
+		hid_warn(hdev, "HW/FW version data in sysfs will be invalid.\n");
 	}
 
 	ret = ps_devices_list_add(ps_dev);
-- 
2.39.2


