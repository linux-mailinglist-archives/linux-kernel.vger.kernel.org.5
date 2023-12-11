Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD32580CDF1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 15:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344332AbjLKOPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 09:15:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343914AbjLKOOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 09:14:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5159C6A59
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 06:00:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25541C43391;
        Mon, 11 Dec 2023 14:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702303214;
        bh=dT3TjpU5nkeVbApxHkWNYjJktKleH4Jfc/XG8mWzMKE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UWc7TwGA1vCcS3JtS9qg5KNymYBVaVbV0SjLSDcPmo1PCAf/NOoMowc3PrK/C7f0M
         DQDPG22tfRh4HaN/WX3p/vHFwwGTHJLAvNh1oM6A51IermLPXJ5899c6JzXxAu9GFX
         ng1jbJkESdHhnzClfEN3z02QEdQQOyn338Vn0UwoNzuITSXW0lpzhcRZS4VyAFVKbV
         Gki7Ktne0tEjL2r2VVxi2OGuAcpeFbstsGNb2a52C4mY3mkZp0P3mOiUp+6ZrDY++/
         wRyn4eChBxNRkS1rXOzzxaQb+gb+B+EbyvBxxdR2Pv7Bt9u45+wvXzmyVC7Z1pPcKm
         HMRmWjaMCIUPg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
        Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 14/19] nvme: introduce helper function to get ctrl state
Date:   Mon, 11 Dec 2023 08:57:48 -0500
Message-ID: <20231211135908.385694-14-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231211135908.385694-1-sashal@kernel.org>
References: <20231211135908.385694-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.142
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

[ Upstream commit 5c687c287c46fadb14644091823298875a5216aa ]

The controller state is typically written by another CPU, so reading it
should ensure no optimizations are taken. This is a repeated pattern in
the driver, so start with adding a convenience function that returns the
controller state with READ_ONCE().

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/nvme.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 590ffa3e1c497..e523427d8a581 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -360,6 +360,11 @@ struct nvme_ctrl {
 	struct nvme_fault_inject fault_inject;
 };
 
+static inline enum nvme_ctrl_state nvme_ctrl_state(struct nvme_ctrl *ctrl)
+{
+	return READ_ONCE(ctrl->state);
+}
+
 enum nvme_iopolicy {
 	NVME_IOPOLICY_NUMA,
 	NVME_IOPOLICY_RR,
-- 
2.42.0

