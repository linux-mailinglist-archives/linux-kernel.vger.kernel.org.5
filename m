Return-Path: <linux-kernel+bounces-114660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7AE888B9C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79A0828C6E8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C7E18AC6C;
	Sun, 24 Mar 2024 23:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hryspmRc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC02236CF3;
	Sun, 24 Mar 2024 23:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322306; cv=none; b=hsGS57ptjOJyH2lSCTrJyXCSP819+p098sab454sFsQhF6pXYR7rYkRYMBnycAiCzbBQQ2QkVa1ULkWhYvXgxAfnY1eSaTLxNAbhOZieiA8tsR6dGT2ip5tWI7FcJO9Mn4IJJloLVXcfId77zvsJ2fTC9xjsd/SRtLEuYM4oAjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322306; c=relaxed/simple;
	bh=6jpmGh5BB99e4BcOprnXPR+Ho2oL/Z+bV4uopNb79hU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jb/GEaOGtMQsAs+KhYhCqAkh2OpSriO/1ynmKxVp2y25rmsixMsjPFI5aB/G02M+JaV9yZW9YrE5SwN7c4jj0qy/LpA5/CLeSYMiodjMasOY2k4mQINfFtxS+UmOFRd4C/FhMNPREvainqWYI1GnZA4rB617FDoFk/mzXnl299E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hryspmRc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 991F4C433C7;
	Sun, 24 Mar 2024 23:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322305;
	bh=6jpmGh5BB99e4BcOprnXPR+Ho2oL/Z+bV4uopNb79hU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hryspmRcB9SsI3qdgo77ZQPUExPwYV0JTB95fXzR3xDY7h2LamYtlHN9BCf0RUP+o
	 wr/quUSFSF+YFRrAA45gnyFV/lbdKGEzzNpAO46tmmeBjVCRKOIGd3JjtOL1c98b+p
	 SL9gBFDSSh8qzbvwgUbdRTsL+svblDlvXSAZipGrmYkOqC7XaeAU1pYjC9GpYIg1z7
	 waYm5vLFwNAKeDfxER7ka/KI7U/nSfgyQ0j+4xKuf7L3vDzIEvo4wZ4CID12+84ckN
	 PMruaeQLn4gB5Jl1LIJy1Z5iNV8yF3doLr/L1cSoFuw8sX9kpaSOaktG1JBwkmWgeg
	 75rSWlJEcf02A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 388/451] remoteproc: stm32: Fix incorrect type assignment returned by stm32_rproc_get_loaded_rsc_tablef
Date: Sun, 24 Mar 2024 19:11:04 -0400
Message-ID: <20240324231207.1351418-389-sashal@kernel.org>
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
index 722cf1cdc2cb0..385e931603ad3 100644
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


