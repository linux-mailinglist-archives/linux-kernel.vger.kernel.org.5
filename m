Return-Path: <linux-kernel+bounces-21021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E860A8288A5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 16:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58047287951
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB03A39FE8;
	Tue,  9 Jan 2024 15:01:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC72039AF1
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 15:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E1B80DA7;
	Tue,  9 Jan 2024 07:02:10 -0800 (PST)
Received: from pluto.. (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 71E963F5A1;
	Tue,  9 Jan 2024 07:01:24 -0800 (PST)
From: Cristian Marussi <cristian.marussi@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: sudeep.holla@arm.com,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH] firmware: arm_scmi: Fix Clock protocol version for v3.2
Date: Tue,  9 Jan 2024 15:01:06 +0000
Message-ID: <20240109150106.2066739-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable SCMI v3.2 Clock protocol features only when Clock protocol version
equals 0x30000.

Fixes: e49e314a2cf7 ("firmware: arm_scmi: Add clock v3.2 CONFIG_SET support")
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/clock.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
index aaa903a41273..c22b974a3e90 100644
--- a/drivers/firmware/arm_scmi/clock.c
+++ b/drivers/firmware/arm_scmi/clock.c
@@ -1008,8 +1008,7 @@ static int scmi_clock_protocol_init(const struct scmi_protocol_handle *ph)
 			scmi_clock_describe_rates_get(ph, clkid, clk);
 	}
 
-	if (PROTOCOL_REV_MAJOR(version) >= 0x2 &&
-	    PROTOCOL_REV_MINOR(version) >= 0x1) {
+	if (PROTOCOL_REV_MAJOR(version) >= 0x3) {
 		cinfo->clock_config_set = scmi_clock_config_set_v2;
 		cinfo->clock_config_get = scmi_clock_config_get_v2;
 	} else {
-- 
2.43.0


