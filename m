Return-Path: <linux-kernel+bounces-114485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC901889022
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDEEE1C2709B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4830013C82F;
	Sun, 24 Mar 2024 23:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L09UI7Ss"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33488224A28;
	Sun, 24 Mar 2024 23:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321932; cv=none; b=vEf6qyqLouxntZEFrojjCfAPnDK5ynnro9hQepbUAERuCkXws2VQfW3zO61vMss5g9HLhJfAQplVvRj4QMLPbOZFi1w8qCzWTKB7zfN2bOkXvl4SWNoaZV1ntgAYWQ4AE2G9z1FSAALrKK4fULUOLzSEkc3xVcyR1ud/9wJW2yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321932; c=relaxed/simple;
	bh=kWQta+JWW20WsDBpivL+3NRiXgc7IA9O36H5ZYgfLfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TRZ4Q2W/wvVzVmrrSnaQSgddtbQjlHZsuFro7+2Itj/h5o7BVdtP90j/wWF/rKWl+hejaxyXOS4xS/YdrKLAFojOpbC306NBOFeYwm+UPHBRBEdy6izdt8H7NNcRGzhQFMN8E+0CEY+zWI3H3/EdYSR8Aiep9MTT+DIEguWVIks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L09UI7Ss; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E860C43399;
	Sun, 24 Mar 2024 23:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321931;
	bh=kWQta+JWW20WsDBpivL+3NRiXgc7IA9O36H5ZYgfLfA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L09UI7SsGw+WhUGGz0sOOJMlo1sbJXLudPVAVIoFUSR5Bq964XPff9sdg6D8aLDY3
	 +Jr1xpcDyjV64sumFocolX4cdt8MYy4jiIUVNR0D+Fiy6oL5W7TM99S9IVfxVqneZ/
	 490bbhQjRSxjqAQ0vFms83d0Y5jbYUGoir6XCAfLYu/0p24KE1ERZLFYBniJf60kSn
	 zLRle0I/yPnVRRkNMrj9RPjqT+Tf3CA/CHUKb0BOogxNsZQqRTD+MFgZwhWtgn273j
	 tjXiJJJWfcWJoMZfpI2hhUBUXjnW5mJrxNhcT4hqp1oKOIPV4ghv/YiPPVZBKBgtgy
	 3xtite3p2uJKA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yu Kuai <yukuai3@huawei.com>,
	Peter Neuwirth <reddunur@online.de>,
	Song Liu <song@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 001/451] md: fix data corruption for raid456 when reshape restart while grow up
Date: Sun, 24 Mar 2024 19:04:37 -0400
Message-ID: <20240324231207.1351418-2-sashal@kernel.org>
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

From: Yu Kuai <yukuai3@huawei.com>

[ Upstream commit 873f50ece41aad5c4f788a340960c53774b5526e ]

Currently, if reshape is interrupted, echo "reshape" to sync_action will
restart reshape from scratch, for example:

echo frozen > sync_action
echo reshape > sync_action

This will corrupt data before reshape_position if the array is growing,
fix the problem by continue reshape from reshape_position.

Reported-by: Peter Neuwirth <reddunur@online.de>
Link: https://lore.kernel.org/linux-raid/e2f96772-bfbc-f43b-6da1-f520e5164536@online.de/
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Song Liu <song@kernel.org>
Link: https://lore.kernel.org/r/20230512015610.821290-3-yukuai1@huaweicloud.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/md.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 846bdee4daa0e..1c87f3e708094 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -4903,11 +4903,21 @@ action_store(struct mddev *mddev, const char *page, size_t len)
 			return -EINVAL;
 		err = mddev_lock(mddev);
 		if (!err) {
-			if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
+			if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery)) {
 				err =  -EBUSY;
-			else {
+			} else if (mddev->reshape_position == MaxSector ||
+				   mddev->pers->check_reshape == NULL ||
+				   mddev->pers->check_reshape(mddev)) {
 				clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
 				err = mddev->pers->start_reshape(mddev);
+			} else {
+				/*
+				 * If reshape is still in progress, and
+				 * md_check_recovery() can continue to reshape,
+				 * don't restart reshape because data can be
+				 * corrupted for raid456.
+				 */
+				clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
 			}
 			mddev_unlock(mddev);
 		}
-- 
2.43.0


