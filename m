Return-Path: <linux-kernel+bounces-115993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E85A88990B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02B921F35FE7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC8B39A0DA;
	Mon, 25 Mar 2024 03:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VTT2pFn1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A451F238F26;
	Sun, 24 Mar 2024 23:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322329; cv=none; b=l2wDnJ7OHMLOb7Y1ld6CUq58Xa2nU5inJitXUNUKLXLLI+1WNv2IqohiF+pgmmPTiNkr5yauis6ei2jpvSEhq3NjBZjIJ8nQYbvrjHzhpgS5rp9F1j6hKiwQ2/qBDVavxyrfSwbuKNj+cRkhORAfd2+CrptMWFkMdmfraIKAibo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322329; c=relaxed/simple;
	bh=Tf/BdClWZkjm4ty8prHKaV6TYXiJjuqx+5eyai5/hKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VLFCcyqh4uOs/pcDipYLkLmUF7SXcxiMGbH3dRCR+42u9g7JKArRT7xpNpWq5hTGhJxClMDUXqM4skZO4t9HAIeOwJiqYW8P7khhORkEDtz+Cf1v0K8yy4tSVcgjKyMjim5A0SVjPlPZ9Veq1N8g35CVDUA0UBoCUglRkmb5RX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VTT2pFn1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE14AC43601;
	Sun, 24 Mar 2024 23:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322328;
	bh=Tf/BdClWZkjm4ty8prHKaV6TYXiJjuqx+5eyai5/hKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VTT2pFn1Mbq+QeJx75kiW6mJgk+wLjqsQfMqnOwV1NRyPH9zzuz/HVVoidiA8+Yi8
	 24VbSMVfX5F7im9RlRxs02dPIU5mHTsc50EessSzSjgm1huION8MRy2FN02BtWhBn0
	 PcsDH8kSzBK1saAqD7Q1Mgzg5AjEFIL9ZtRjzCk6b/DYpjak0DZysQRvCEQpJpoVXE
	 ht1Fs+9IgYe07FH4/JmSFg1dzom9mabHFy07gjfjNU+oRyE+pbvMF8YwpKdtkEWwDJ
	 zq0CelgzQ2nasbzr1TN8RowcDg2IxyFLybZzQPBJUrrItVObi4W7mlOoEkBOUECvz0
	 orKKLKZE1gHPg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 411/451] nvme: add the Apple shared tag workaround to nvme_alloc_io_tag_set
Date: Sun, 24 Mar 2024 19:11:27 -0400
Message-ID: <20240324231207.1351418-412-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 93b24f579c392bac2e491fee79ad5ce5a131992e ]

Add the apple shared tag workaround to nvme_alloc_io_tag_set to prepare
for using that helper in the PCIe driver.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Stable-dep-of: de105068fead ("nvme: fix reconnection fail due to reserved tag allocation")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 98a8d90feb37d..951c8946701aa 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -5029,7 +5029,13 @@ int nvme_alloc_io_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
 	memset(set, 0, sizeof(*set));
 	set->ops = ops;
 	set->queue_depth = ctrl->sqsize + 1;
-	if (ctrl->ops->flags & NVME_F_FABRICS)
+	/*
+	 * Some Apple controllers requires tags to be unique across admin and
+	 * the (only) I/O queue, so reserve the first 32 tags of the I/O queue.
+	 */
+	if (ctrl->quirks & NVME_QUIRK_SHARED_TAGS)
+		set->reserved_tags = NVME_AQ_DEPTH;
+	else if (ctrl->ops->flags & NVME_F_FABRICS)
 		set->reserved_tags = NVMF_RESERVED_TAGS;
 	set->numa_node = ctrl->numa_node;
 	set->flags = BLK_MQ_F_SHOULD_MERGE;
-- 
2.43.0


