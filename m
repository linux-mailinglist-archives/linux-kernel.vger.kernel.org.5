Return-Path: <linux-kernel+bounces-19545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69239826E9A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D7481F22D26
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0F245BFB;
	Mon,  8 Jan 2024 12:34:51 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959C344C9D
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 12:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C60051480;
	Mon,  8 Jan 2024 04:35:34 -0800 (PST)
Received: from [127.0.1.1] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 28D113F64C;
	Mon,  8 Jan 2024 04:34:48 -0800 (PST)
From: Cristian Marussi <cristian.marussi@arm.com>
Date: Mon, 08 Jan 2024 12:34:13 +0000
Subject: [PATCH 3/6] firmware: arm_ffa: Check xa_load() return value
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240108-ffa_fixes_6-8-v1-3-75bf7035bc50@arm.com>
References: <20240108-ffa_fixes_6-8-v1-0-75bf7035bc50@arm.com>
In-Reply-To: <20240108-ffa_fixes_6-8-v1-0-75bf7035bc50@arm.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Cristian Marussi <cristian.marussi@arm.com>
X-Mailer: b4 0.12.4

Add a check to verify the result of xa_load() during partition lookups.

Fixes: 0184450b8b1e ("firmware: arm_ffa: Add schedule receiver callback mechanism")
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_ffa/driver.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index 8df92c9521f4..0ea1dd6e55c4 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -733,6 +733,11 @@ static void __do_sched_recv_cb(u16 part_id, u16 vcpu, bool is_per_vcpu)
 	void *cb_data;
 
 	partition = xa_load(&drv_info->partition_info, part_id);
+	if (!partition) {
+		pr_err("%s: Invalid partition ID 0x%x\n", __func__, part_id);
+		return;
+	}
+
 	read_lock(&partition->rw_lock);
 	callback = partition->callback;
 	cb_data = partition->cb_data;
@@ -915,6 +920,11 @@ static int ffa_sched_recv_cb_update(u16 part_id, ffa_sched_recv_cb callback,
 		return -EOPNOTSUPP;
 
 	partition = xa_load(&drv_info->partition_info, part_id);
+	if (!partition) {
+		pr_err("%s: Invalid partition ID 0x%x\n", __func__, part_id);
+		return -EINVAL;
+	}
+
 	write_lock(&partition->rw_lock);
 
 	cb_valid = !!partition->callback;

-- 
2.34.1


