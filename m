Return-Path: <linux-kernel+bounces-19542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C403826E96
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70920283450
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34EDB45958;
	Mon,  8 Jan 2024 12:34:50 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C2740C0C
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 12:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F46CFEC;
	Mon,  8 Jan 2024 04:35:33 -0800 (PST)
Received: from [127.0.1.1] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 725F13F64C;
	Mon,  8 Jan 2024 04:34:46 -0800 (PST)
From: Cristian Marussi <cristian.marussi@arm.com>
Date: Mon, 08 Jan 2024 12:34:11 +0000
Subject: [PATCH 1/6] firmware: arm_ffa: Add missing rwlock_init()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240108-ffa_fixes_6-8-v1-1-75bf7035bc50@arm.com>
References: <20240108-ffa_fixes_6-8-v1-0-75bf7035bc50@arm.com>
In-Reply-To: <20240108-ffa_fixes_6-8-v1-0-75bf7035bc50@arm.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Cristian Marussi <cristian.marussi@arm.com>
X-Mailer: b4 0.12.4

Add missing rwlock initialization.

Fixes: 0184450b8b1e ("firmware: arm_ffa: Add schedule receiver callback mechanism")
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_ffa/driver.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index 6146b2927d5c..ed1d6a24934e 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -1226,6 +1226,7 @@ static void ffa_setup_partitions(void)
 			ffa_device_unregister(ffa_dev);
 			continue;
 		}
+		rwlock_init(&info->rw_lock);
 		xa_store(&drv_info->partition_info, tpbuf->id, info, GFP_KERNEL);
 	}
 	drv_info->partition_count = count;

-- 
2.34.1


