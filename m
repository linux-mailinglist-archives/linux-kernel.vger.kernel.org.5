Return-Path: <linux-kernel+bounces-114907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48014889289
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0B0E1F2ED37
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7022D2BBA;
	Mon, 25 Mar 2024 00:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DOJ9Zesq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D97E27DDFA;
	Sun, 24 Mar 2024 23:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323571; cv=none; b=uJus7QkyzB7TxkhZm3m+BI2mI/IDL9gnj9R/y06afZg/kDkbdYlqWiYG4YUq8Flz224ki586bdKRa9kSKImPc0v/ESPzW/piJvz7B6XneuwFLo5OtWpwooUddwFvTcqafQcK0OeV0ylzhxmcqNcECNyAst373vP70THx/XoIDEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323571; c=relaxed/simple;
	bh=GUrn/8keUU0zm210yU0iU05Z5ixZFkbqpYgv4ZfIFLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iEHDpX9BGViGVMqSqpNyR7TT2CNV3uV67xW9WrvHXSArY9oQ4g71ItGJqV4w6AI68GuX2FbN0a4LymrmPBT9tB24x2ncz6G+Z1iXjiYUHohXC8zlybUcR8yd1f0RQ1fdDR7e+67Oxtl/4ufYdyZnYaK5PCZvbv3gmcIOcGuGNI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DOJ9Zesq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACB8DC43330;
	Sun, 24 Mar 2024 23:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323570;
	bh=GUrn/8keUU0zm210yU0iU05Z5ixZFkbqpYgv4ZfIFLc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DOJ9ZesqnyKPPBr7PYPAQW70mq5Jswl/QyNGlqCanQlem8LXFJwx9PL40zNrbEWVZ
	 6qebsh5JWdLIA+ZNs3F3Y6riQh0yrycIjzuhGcudXQWjuskvQe1funq+FpHrnwQ6I4
	 Su8ZkNeOSe6Xk/I0cH5UyXG1iGvsl8pVkECn/0SOCUOXEYNIF7ycxs0+kgP1RZE1F2
	 wNkI2qzPHkvQR9sSSStDzQXcN2bUFdWVElB8EW0I4WuANeTGKZXJfWoecSin77z9V2
	 YFDfKj3m6EtXq4isnxEnZkIvwmRGvUCHOFPxQmh09InEtRIybw7Oc65YsH7YtPtrlT
	 GPPPFPcCl3O7A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 277/317] remoteproc: stm32: Fix incorrect type assignment returned by stm32_rproc_get_loaded_rsc_tablef
Date: Sun, 24 Mar 2024 19:34:17 -0400
Message-ID: <20240324233458.1352854-278-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>

[ Upstream commit c77b35ce66af25bdd6fde60b62e35b9b316ea5c2 ]

The sparse tool complains about the remove of the _iomem attribute.

stm32_rproc.c:660:17: warning: cast removes address space '__iomem' of expression

Add '__force' to explicitly specify that the cast is intentional.
This conversion is necessary to cast to addresses pointer,
which are then managed by the remoteproc core as a pointer to a
resource_table structure.

Fixes: 8a471396d21c ("remoteproc: stm32: Move resource table setup to rproc_ops")
Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Link: https://lore.kernel.org/r/20240117135312.3381936-3-arnaud.pouliquen@foss.st.com
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/remoteproc/stm32_rproc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
index e48dce98936ad..4db63e07e1cff 100644
--- a/drivers/remoteproc/stm32_rproc.c
+++ b/drivers/remoteproc/stm32_rproc.c
@@ -641,7 +641,7 @@ stm32_rproc_get_loaded_rsc_table(struct rproc *rproc, size_t *table_sz)
 	 * entire area by overwriting it with the initial values stored in rproc->clean_table.
 	 */
 	*table_sz = RSC_TBL_SIZE;
-	return (struct resource_table *)ddata->rsc_va;
+	return (__force struct resource_table *)ddata->rsc_va;
 }
 
 static const struct rproc_ops st_rproc_ops = {
-- 
2.43.0


