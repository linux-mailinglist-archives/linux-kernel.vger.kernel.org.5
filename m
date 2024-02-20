Return-Path: <linux-kernel+bounces-73292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9AB85C090
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF7BD286595
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DCB76C74;
	Tue, 20 Feb 2024 16:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NEXRpdpG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A354763E2
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 16:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708444903; cv=none; b=Qz7RRWycfoejB8u1eE9jL62Np0Mv2zBtt3nr3qjXWIwsHrLKxlI9Ih0CUVM87l+oD2sY9+AxRdNOsCIRKklqwipQsDU84BbCqdnFwh3HHQG5dWbXlUz8b1QUMtL/+/NtXTscvHhx1BQLVuTAH/RsNhGtaMP55eAU27Udls4zC4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708444903; c=relaxed/simple;
	bh=kXLVhT3LdweT4J+K9+WVLoauc3wapckO+u2vZBKTH68=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JCdgveNe47OByLlxoTGLS/ajEsPYk6Mt6xeWC5KDcyi+R8K9PatxhgL2c+oxxJ/QoZMQeOrNKSkiy5z8Yy1Tpmlc33EnK9Q0qPkpAW1xoHWs8KrAL0DWRb3nPUifMSTrabMOKZQXXgHQqVpnebM3vLH7Qt0yATldrJrbL/EuiDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NEXRpdpG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3ADBC43399;
	Tue, 20 Feb 2024 16:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708444902;
	bh=kXLVhT3LdweT4J+K9+WVLoauc3wapckO+u2vZBKTH68=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NEXRpdpGH6MwA92FWbpu3Y3VQUFDBGgA4ilODS2marXJyfiJ4FT1OqQBbkNPifnSR
	 u1ztKFlbnfZfDdofPn+hDNBM/Uxrrfg9KognQYKMXKsBMuXgjdWaeKmUBoc3q32u/b
	 bomZwwROb6UODcN6H2KpMVkinuW+2ZqmwpiJsb69LY7e3D57peVRoToXBliILggDjg
	 g5DKJB+YSCzjEM6EgZoatMot49EVAAtvisAv3fSYB/n+4WZe58oG2yQ6Z8v+7XX6jJ
	 MxTpSA2jbyQMBwjByjf1SHjpej8ySkraSpaOlLBDwv1VyPebU5XrCUukEp/veJsBDm
	 F5b3pFS0hhkUw==
From: Oded Gabbay <ogabbay@kernel.org>
To: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Avri Kehat <akehat@habana.ai>
Subject: [PATCH 06/13] accel/habanalabs: fix debugfs files permissions
Date: Tue, 20 Feb 2024 18:01:22 +0200
Message-Id: <20240220160129.909714-6-ogabbay@kernel.org>
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

From: Avri Kehat <akehat@habana.ai>

debugfs files are created with permissions that don't align
with the access requirements.

Signed-off-by: Avri Kehat <akehat@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/accel/habanalabs/common/debugfs.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/accel/habanalabs/common/debugfs.c b/drivers/accel/habanalabs/common/debugfs.c
index 01f071d52570..ab0fe74b49d0 100644
--- a/drivers/accel/habanalabs/common/debugfs.c
+++ b/drivers/accel/habanalabs/common/debugfs.c
@@ -1643,19 +1643,19 @@ static void add_files_to_device(struct hl_device *hdev, struct hl_dbg_device_ent
 				&hl_data64b_fops);
 
 	debugfs_create_file("set_power_state",
-				0200,
+				0644,
 				root,
 				dev_entry,
 				&hl_power_fops);
 
 	debugfs_create_file("device",
-				0200,
+				0644,
 				root,
 				dev_entry,
 				&hl_device_fops);
 
 	debugfs_create_file("clk_gate",
-				0200,
+				0644,
 				root,
 				dev_entry,
 				&hl_clk_gate_fops);
@@ -1667,13 +1667,13 @@ static void add_files_to_device(struct hl_device *hdev, struct hl_dbg_device_ent
 				&hl_stop_on_err_fops);
 
 	debugfs_create_file("dump_security_violations",
-				0644,
+				0400,
 				root,
 				dev_entry,
 				&hl_security_violations_fops);
 
 	debugfs_create_file("dump_razwi_events",
-				0644,
+				0400,
 				root,
 				dev_entry,
 				&hl_razwi_check_fops);
@@ -1706,7 +1706,7 @@ static void add_files_to_device(struct hl_device *hdev, struct hl_dbg_device_ent
 				&hdev->reset_info.skip_reset_on_timeout);
 
 	debugfs_create_file("state_dump",
-				0600,
+				0644,
 				root,
 				dev_entry,
 				&hl_state_dump_fops);
@@ -1724,7 +1724,7 @@ static void add_files_to_device(struct hl_device *hdev, struct hl_dbg_device_ent
 
 	for (i = 0, entry = dev_entry->entry_arr ; i < count ; i++, entry++) {
 		debugfs_create_file(hl_debugfs_list[i].name,
-					0444,
+					0644,
 					root,
 					entry,
 					&hl_debugfs_fops);
-- 
2.34.1


