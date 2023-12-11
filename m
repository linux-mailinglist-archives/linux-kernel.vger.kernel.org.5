Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0A8B80CBD2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 14:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343712AbjLKNyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 08:54:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234964AbjLKNyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 08:54:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8DEC213A
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 05:53:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61135C433C8;
        Mon, 11 Dec 2023 13:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702302799;
        bh=bXLk7LPUpePE3Ki598P6UjpqUiZundDKzq3xApB28bg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MFuA6RBx6av04SAxdysrCLfr6mSHptC2N7F773j/NMayV8rP6oQ3JbaVY0tehmOQg
         rt85482CMEyiRzuaPwXRzuUXiHmvfXuQaxwMt9LUZXSznMe1Ugzuju3L7XwIEDtbhh
         vsRFmrtU9PlEwtnSs3kNLhoO37AEwf6L2LcPJNhPqFvgsgclq3Htd6HSZTTn4BUnhB
         3ziwiy9WwDOMVWsbG+neg1duPqVNbDuJQi2SQENKndhZXNZt81C117GolqKhnMKLep
         i4VCSKn0b6qXUuEC42LC5MD51tsKqCfPfj8jlEyd8N33wswnkuiyZh3EtUvbQibhCK
         RcV4gNApRq5hw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>,
        Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 32/47] nvme-ioctl: move capable() admin check to the end
Date:   Mon, 11 Dec 2023 08:50:33 -0500
Message-ID: <20231211135147.380223-32-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231211135147.380223-1-sashal@kernel.org>
References: <20231211135147.380223-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.5
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

[ Upstream commit 7be866b1cf0bf1dfa74480fe8097daeceda68622 ]

This can be an expensive call on some kernel configs. Move it to the end
after checking the cheaper ways to determine if the command is allowed.

Reviewed-by: Jens Axboe <axboe@kernel.dk>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/ioctl.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 529b9954d2b8c..4939ed35638f1 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -18,15 +18,12 @@ static bool nvme_cmd_allowed(struct nvme_ns *ns, struct nvme_command *c,
 {
 	u32 effects;
 
-	if (capable(CAP_SYS_ADMIN))
-		return true;
-
 	/*
 	 * Do not allow unprivileged passthrough on partitions, as that allows an
 	 * escape from the containment of the partition.
 	 */
 	if (flags & NVME_IOCTL_PARTITION)
-		return false;
+		goto admin;
 
 	/*
 	 * Do not allow unprivileged processes to send vendor specific or fabrics
@@ -34,7 +31,7 @@ static bool nvme_cmd_allowed(struct nvme_ns *ns, struct nvme_command *c,
 	 */
 	if (c->common.opcode >= nvme_cmd_vendor_start ||
 	    c->common.opcode == nvme_fabrics_command)
-		return false;
+		goto admin;
 
 	/*
 	 * Do not allow unprivileged passthrough of admin commands except
@@ -53,7 +50,7 @@ static bool nvme_cmd_allowed(struct nvme_ns *ns, struct nvme_command *c,
 				return true;
 			}
 		}
-		return false;
+		goto admin;
 	}
 
 	/*
@@ -63,7 +60,7 @@ static bool nvme_cmd_allowed(struct nvme_ns *ns, struct nvme_command *c,
 	 */
 	effects = nvme_command_effects(ns->ctrl, ns, c->common.opcode);
 	if (!(effects & NVME_CMD_EFFECTS_CSUPP))
-		return false;
+		goto admin;
 
 	/*
 	 * Don't allow passthrough for command that have intrusive (or unknown)
@@ -72,16 +69,20 @@ static bool nvme_cmd_allowed(struct nvme_ns *ns, struct nvme_command *c,
 	if (effects & ~(NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC |
 			NVME_CMD_EFFECTS_UUID_SEL |
 			NVME_CMD_EFFECTS_SCOPE_MASK))
-		return false;
+		goto admin;
 
 	/*
 	 * Only allow I/O commands that transfer data to the controller or that
 	 * change the logical block contents if the file descriptor is open for
 	 * writing.
 	 */
-	if (nvme_is_write(c) || (effects & NVME_CMD_EFFECTS_LBCC))
-		return open_for_write;
+	if ((nvme_is_write(c) || (effects & NVME_CMD_EFFECTS_LBCC)) &&
+	    !open_for_write)
+		goto admin;
+
 	return true;
+admin:
+	return capable(CAP_SYS_ADMIN);
 }
 
 /*
-- 
2.42.0

