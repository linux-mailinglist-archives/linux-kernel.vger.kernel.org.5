Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F206880CD3E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 15:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344308AbjLKOIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 09:08:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344137AbjLKOIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 09:08:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D5C30DC
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 05:56:07 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 702A3C43391;
        Mon, 11 Dec 2023 13:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702302967;
        bh=7FWLRc1p6rU6lBfjPN3MpBMeNXSUTIig4nLI3YeSsPM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HMDtTmrZdRo54xdeGELIEYyXlyCPWGvTXl6Vl320flODlruS9ce+NtOYct/wAWxOj
         WdUieECt9yZV+82SRFBDsIBvL0fe5WSxIkxxAYMklpI5pe/otBR8Ld+FCtKOvcFkri
         j+pY9F+1C7lqU0YDsWolZPt8iUFlWinPKdfhfbUZ1D9lmqug7Dm34QBeV1sJtfW3oG
         MSaDRHlVVtRkkTdOjRK2CL/cmfWawbUdVmTyBuWhCPyLHipCEo4HOkVsK1ggHmewbC
         cyIXDfaTkhk6GPOgfDnV5ZtLXdwKp0be2tv2wRKV30R8VpQKHGRaYfsFkQ62lsAi2f
         W2YMJ12yAmvSA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
        Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 19/29] nvme: introduce helper function to get ctrl state
Date:   Mon, 11 Dec 2023 08:54:03 -0500
Message-ID: <20231211135457.381397-19-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231211135457.381397-1-sashal@kernel.org>
References: <20231211135457.381397-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.66
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
index 69f9e69208f68..8b50b56b8ee31 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -377,6 +377,11 @@ struct nvme_ctrl {
 	enum nvme_dctype dctype;
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

