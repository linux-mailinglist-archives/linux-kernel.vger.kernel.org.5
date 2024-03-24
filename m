Return-Path: <linux-kernel+bounces-114747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDB68890F0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 337201C2CE60
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1110D1ACB53;
	Mon, 25 Mar 2024 00:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fg2SKXg9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446B9174EC9;
	Sun, 24 Mar 2024 23:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323333; cv=none; b=sMjWtZJULHi9t0tkXehxpmis12HeJ4p0ZDTeYZLzUO2EN58cONDErkqitgKpJCnTcwLsXSlLDMcQqLHW7OgDABw6pABYv1JtZ80Onvs8+UJpQiFaKZOP4h7+5CZC4Ls3RiFwpNrjC4D2QNuvQhQX7M88xkw6bD9VSx9kvrT9fiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323333; c=relaxed/simple;
	bh=RbiGQbM5DV6JGkgA0anqlw12MgJgoMvxfYB2/r2rRRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PWFZUlLyPPQhuK6OX2bVYKZoMsAVkbIdQ3fPkdu9FBJ0+qNIl5ThFLDYtldo01tFd0kWm1FINijN3L0+xH64vpRpxGvQA+voUynLZ8QUASJghelSFkgqAY9yweziAC03+zUHks9Au9wzDZUpCHQm2IFYdWZlzk3nmu2aBbEcGYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fg2SKXg9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13F04C43399;
	Sun, 24 Mar 2024 23:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323332;
	bh=RbiGQbM5DV6JGkgA0anqlw12MgJgoMvxfYB2/r2rRRo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fg2SKXg94aAaQ/XU4VQG41WEy9pB7EQLGCnP51EZ9XC8n2dkY/InTSry+UK1l2PGS
	 kfx7p0W1hubsBbSLeJynQrnAxMsKpQ727QHm6UQjx8m6BhlPDXRiNyb4Bp6JaXih1m
	 +4qF5P66MHCSaK8YbbB+sziSFRIhVCEuUawzou52Nbnu1YZDqV8DH2V4C5FqewaaGf
	 7kANwRbekXhyK5J9mttkMFpf+/nkbMSCIZ4JfghzL8DKXmfleGGbCzar+1P1+zm7M1
	 AGNYw5Rljj5kyxd0NNZ6dbfaTpjia0CpiEHxQ7d+ouB6Ir3mQZ/DpXnJAOdv3h2TP4
	 b+Q+AKL5Af0sQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stefan Haberland <sth@linux.ibm.com>,
	Jan Hoeppner <hoeppner@linux.ibm.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 033/317] s390/dasd: put block allocation in separate function
Date: Sun, 24 Mar 2024 19:30:13 -0400
Message-ID: <20240324233458.1352854-34-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Stefan Haberland <sth@linux.ibm.com>

[ Upstream commit 2b43bf061b2e1b67561cbb1f6f305421f5fc86af ]

Put block allocation into a separate function to put some copy pair logic
in it in a later patch.

Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>
Link: https://lore.kernel.org/r/20220920192616.808070-2-sth@linux.ibm.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: c3116e62ddef ("s390/dasd: fix double module refcount decrement")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/block/dasd_eckd.c | 38 ++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 56ab74aa07f42..cf80db7a74a3d 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -2028,6 +2028,25 @@ static void dasd_eckd_kick_validate_server(struct dasd_device *device)
 		dasd_put_device(device);
 }
 
+static int dasd_eckd_alloc_block(struct dasd_device *device)
+{
+	struct dasd_block *block;
+	struct dasd_uid temp_uid;
+
+	dasd_eckd_get_uid(device, &temp_uid);
+	if (temp_uid.type == UA_BASE_DEVICE) {
+		block = dasd_alloc_block();
+		if (IS_ERR(block)) {
+			DBF_EVENT_DEVID(DBF_WARNING, device->cdev, "%s",
+					"could not allocate dasd block structure");
+			return PTR_ERR(block);
+		}
+		device->block = block;
+		block->base = device;
+	}
+	return 0;
+}
+
 /*
  * Check device characteristics.
  * If the device is accessible using ECKD discipline, the device is enabled.
@@ -2036,8 +2055,6 @@ static int
 dasd_eckd_check_characteristics(struct dasd_device *device)
 {
 	struct dasd_eckd_private *private = device->private;
-	struct dasd_block *block;
-	struct dasd_uid temp_uid;
 	int rc, i;
 	int readonly;
 	unsigned long value;
@@ -2095,19 +2112,10 @@ dasd_eckd_check_characteristics(struct dasd_device *device)
 			device->default_expires = value;
 	}
 
-	dasd_eckd_get_uid(device, &temp_uid);
-	if (temp_uid.type == UA_BASE_DEVICE) {
-		block = dasd_alloc_block();
-		if (IS_ERR(block)) {
-			DBF_EVENT_DEVID(DBF_WARNING, device->cdev, "%s",
-					"could not allocate dasd "
-					"block structure");
-			rc = PTR_ERR(block);
-			goto out_err1;
-		}
-		device->block = block;
-		block->base = device;
-	}
+	/* check if block device is needed and allocate in case */
+	rc = dasd_eckd_alloc_block(device);
+	if (rc)
+		goto out_err1;
 
 	/* register lcu with alias handling, enable PAV */
 	rc = dasd_alias_make_device_known_to_lcu(device);
-- 
2.43.0


