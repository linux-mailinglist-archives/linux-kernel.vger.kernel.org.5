Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D88EC803FFA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 21:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346155AbjLDUhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 15:37:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346297AbjLDUgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 15:36:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120CE30C3
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 12:35:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77FDDC433CC;
        Mon,  4 Dec 2023 20:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701722100;
        bh=eGm+sBvt0gdj+0zTu3T2RywpCFcezynjcVTWXyJLyW4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iVXk2owoS/1lAMxzsrTb8Vvzoc0KNIez8bAtw79bv0ZhaDpsgFVg1Hwkas8lCZP0I
         ZEN3vYcWvKktIOtDbZ8UCeKDBfO1FJzBMK8OBtiIkn03By01jKLclQUHKXo883KqgI
         ZpHvVC1Vo5nrlnkHwcoAMl2T2WGaYyiRmHpM/wPi5uvGZzI5t8RwzChlU09iFIhSGO
         aZMpk0WRRPyZQtvcAl6iVazG5f8vdUxXg8If317wIA142M47puQPZwO5K/+YkbH0Vy
         k8wWp1+Nrt6c2SZkUBCxoKPG7YKTr6Id3DQQ+dH3C0EuJBr7s+Xhqx7nPI9FtD1t2m
         8pN70Gfbw1BeA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>, sagi@grimberg.me,
        linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 32/32] nvme-core: check for too small lba shift
Date:   Mon,  4 Dec 2023 15:32:52 -0500
Message-ID: <20231204203317.2092321-32-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231204203317.2092321-1-sashal@kernel.org>
References: <20231204203317.2092321-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.4
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

[ Upstream commit 74fbc88e161424b3b96a22b23a8e3e1edab9d05c ]

The block layer doesn't support logical block sizes smaller than 512
bytes. The nvme spec doesn't support that small either, but the driver
isn't checking to make sure the device responded with usable data.
Failing to catch this will result in a kernel bug, either from a
division by zero when stacking, or a zero length bio.

Reviewed-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b4521deb1c716..dfc0e02150911 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1890,9 +1890,10 @@ static void nvme_update_disk_info(struct gendisk *disk,
 
 	/*
 	 * The block layer can't support LBA sizes larger than the page size
-	 * yet, so catch this early and don't allow block I/O.
+	 * or smaller than a sector size yet, so catch this early and don't
+	 * allow block I/O.
 	 */
-	if (ns->lba_shift > PAGE_SHIFT) {
+	if (ns->lba_shift > PAGE_SHIFT || ns->lba_shift < SECTOR_SHIFT) {
 		capacity = 0;
 		bs = (1 << 9);
 	}
-- 
2.42.0

