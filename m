Return-Path: <linux-kernel+bounces-73289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF31285C087
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9001BB24505
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6CB7640E;
	Tue, 20 Feb 2024 16:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DLqveDLE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74482763FD
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 16:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708444898; cv=none; b=HEcbMoyJRWO849obUqQiAMy/ODNBczApTjbJYQdPya5BPVOd/WPY8UJb7ZYuWQZ+YTZouJjBE6gYQhA1zcEbbq5/fQEA898zOg1rpQ/UycSBGc8U24lUqy6OyyPrZLjuPoUqVvv39UAeF9H7I+T189xPln65gfl7u79p/ew2uSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708444898; c=relaxed/simple;
	bh=JL1jAzIirbuZqrIbR7J7LDpNto/ami0Xc9uTfqn5tH0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=thkrONplG4DmyNJniTtf2Jb5cr6eaeeO++Sjs8nI72eZuCfKOn9ZrD5xpvWNFB+EzfCY9g38qi4tDjx8Qur5mgueA+hC6y31J+kghiqg7rWGVsNpj9sr/+Ic9eJUQ8oG9qGDzrrcrU8AOBaKoBNLCxuWBaYPFSDZsXDjxU2vMg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DLqveDLE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E80A0C43399;
	Tue, 20 Feb 2024 16:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708444898;
	bh=JL1jAzIirbuZqrIbR7J7LDpNto/ami0Xc9uTfqn5tH0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DLqveDLE9Kj68zrK0Sz11X4FT9UJflcSOtfcKspd96eosYluZATRnB0xAetBI2fvz
	 ZAxCp4rsSoDDRleRN7gZfzO1UZxMTRo2PtbBOTILS3IIaWHzGAHJV8MX2xInFuUTZE
	 BL0pvgSj3JiJlVMBeYMjPzASqgA3F7/oHSISRcksQX00T1hIaoAfOxx3OuUljrYSwC
	 k8ix80UqTpAqmOMNkPhk/EQggcgGRXOB6SA8uxAgb10lPGptIpFVQmuAsXjv8sfZNr
	 x+AoM2plB1bEKCM6WlrGXbvocVg4/16EpRrwNBtU1mM2guOd/doAXZQ5d/agATn/6d
	 THKRQoWF5QljQ==
From: Oded Gabbay <ogabbay@kernel.org>
To: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 03/13] accel/habanalabs: modify print for skip loading linux FW to debug log
Date: Tue, 20 Feb 2024 18:01:19 +0200
Message-Id: <20240220160129.909714-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240220160129.909714-1-ogabbay@kernel.org>
References: <20240220160129.909714-1-ogabbay@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tomer Tayar <ttayar@habana.ai>

Skip loading a linux FW image into the device with the current supported
ASICs is done for test purposes only.
Moreover, for future supported ASICs it is possible that there won't be
a need to load such an image.
The print in such a case is therefore not needed in most cases, so
replace the used dev_info() with dev_dbg().

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/accel/habanalabs/common/firmware_if.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/habanalabs/common/firmware_if.c b/drivers/accel/habanalabs/common/firmware_if.c
index e7dcf2fe6552..364d292c76fa 100644
--- a/drivers/accel/habanalabs/common/firmware_if.c
+++ b/drivers/accel/habanalabs/common/firmware_if.c
@@ -2820,7 +2820,7 @@ static int hl_fw_dynamic_init_cpu(struct hl_device *hdev,
 	hdev->asic_funcs->init_cpu_scrambler_dram(hdev);
 
 	if (!(hdev->fw_components & FW_TYPE_LINUX)) {
-		dev_info(hdev->dev, "Skip loading Linux F/W\n");
+		dev_dbg(hdev->dev, "Skip loading Linux F/W\n");
 		return 0;
 	}
 
-- 
2.34.1


