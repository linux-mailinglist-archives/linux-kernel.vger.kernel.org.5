Return-Path: <linux-kernel+bounces-73293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 821E085C091
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5AD61C221AE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF5176C99;
	Tue, 20 Feb 2024 16:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZBDBLFMJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018D876C85
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 16:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708444905; cv=none; b=fA51vr0rU/CCZOlLUJ6zcdeM7yHIE0lIQQz+e6xQr/qPwEh61wjuY+0wTdfZDUEQc84hJGyFnEdScRMlfn1NxZEE3FLgzZtmpvD7FmJdmFQCrwSjJ3wdXsptTxL1T/pIQDj7mBymPyrlMijlPtYlsVve5wmuJskrfnIlxeVZ2ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708444905; c=relaxed/simple;
	bh=b5/Z55R6exEVvxby5IEzYsTksFcDh5Hf4EvWs+jygLE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eVJc2sh8RsY/S0hJiWZqUj9/MDO3DEqLcS3kgZ7WmYgVywWHZXAXcreK/qTCsjivWFZ9sS+pDa30s43u61aUtp9UMuX4wnOI09Gcf2BQYHGB8mqrvvnjVlnMCo2Y8Y7PLchxf9xWwVvIeaBkKQhqMpt5tDzGQ3V8XwCmAqGQwIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZBDBLFMJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66C26C433F1;
	Tue, 20 Feb 2024 16:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708444904;
	bh=b5/Z55R6exEVvxby5IEzYsTksFcDh5Hf4EvWs+jygLE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZBDBLFMJS2BrT4mZnHrA0+stJiohHRBo8uvCXXLWgZZpml4V1WpIb9mTyfFdsrZat
	 h0EbCrgQEQx8Vdv0WzJnhGb3mEzEQhO0c0GU673ydgB0vL2B+YTda54pHQR6GNrzVk
	 u+Qj/ex22frAV++VsRXP3wrZFRLfanliSpWaZlko64CI1XkU9G/HJGh5d444G2XZep
	 4+rLCdx9XWggoaC72hMhvxH1KZvrppTZ26WKIRAmAO2IaNbCalvrpj7vyDspZyDE5g
	 UzCSJkyCKL+51Egomc7/b16KNEmLR6QuXcyyqCL+6XVxECRylZNcRMfKyjnU3E0Fhm
	 cyzfbR4Ymtvzg==
From: Oded Gabbay <ogabbay@kernel.org>
To: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Tal Risin <trisin@habana.ai>
Subject: [PATCH 07/13] accel/habanalabs: initialize maybe-uninitialized variables
Date: Tue, 20 Feb 2024 18:01:23 +0200
Message-Id: <20240220160129.909714-7-ogabbay@kernel.org>
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

From: Tal Risin <trisin@habana.ai>

Prevent static analysis warning.

Signed-off-by: Tal Risin <trisin@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/accel/habanalabs/common/debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/habanalabs/common/debugfs.c b/drivers/accel/habanalabs/common/debugfs.c
index ab0fe74b49d0..b1c88d1837d9 100644
--- a/drivers/accel/habanalabs/common/debugfs.c
+++ b/drivers/accel/habanalabs/common/debugfs.c
@@ -484,7 +484,7 @@ static ssize_t mmu_asid_va_write(struct file *file, const char __user *buf,
 	struct hl_debugfs_entry *entry = s->private;
 	struct hl_dbg_device_entry *dev_entry = entry->dev_entry;
 	struct hl_device *hdev = dev_entry->hdev;
-	char kbuf[MMU_KBUF_SIZE];
+	char kbuf[MMU_KBUF_SIZE] = {0};
 	char *c;
 	ssize_t rc;
 
@@ -546,7 +546,7 @@ static ssize_t mmu_ack_error_value_write(struct file *file,
 	struct hl_debugfs_entry *entry = s->private;
 	struct hl_dbg_device_entry *dev_entry = entry->dev_entry;
 	struct hl_device *hdev = dev_entry->hdev;
-	char kbuf[MMU_KBUF_SIZE];
+	char kbuf[MMU_KBUF_SIZE] = {0};
 	ssize_t rc;
 
 	if (count > sizeof(kbuf) - 1)
-- 
2.34.1


