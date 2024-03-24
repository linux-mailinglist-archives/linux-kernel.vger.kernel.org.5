Return-Path: <linux-kernel+bounces-115735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCB0889754
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CF651C2D148
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C603659C7;
	Mon, 25 Mar 2024 02:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cDfK+lBR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD54921AFE2;
	Sun, 24 Mar 2024 23:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321828; cv=none; b=i/oe8HySi3ADeMZrtQvb8ip3LczTJp/XihA4OJ/50ceVfPzlGhWTITErh58RSp28ihnw+22ZgEOQKkt3vkMlgb1pJxGu6+VHX71tpESTP/N88MRcFGFVqIm3ofweRBJGZt1gGTYUXo2NUCvT3bcbOn+5iO/tKwM1fpCQ3bQcLOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321828; c=relaxed/simple;
	bh=P1mp+ZwetPBcCADLeYgfqN8Hv3VfpT4y4hGzyfyub5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WNRpJppS2PPJCZ8BjDuLumItdjAIizv73lOh7rOvY5m3DBGK4s+i8ZXs41et5Gg+raZskXeTinnAUuukqpCvqkBzXxeO95TbGzr9cF8Pol4afFOGG/l+YWYkcMjHde/QB2+FEiiYpVbXKPxXtibATjuVXIjfURO9ofPpTUkc4bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cDfK+lBR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CAF2C43390;
	Sun, 24 Mar 2024 23:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321827;
	bh=P1mp+ZwetPBcCADLeYgfqN8Hv3VfpT4y4hGzyfyub5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cDfK+lBRm8FTuuU6Bpq0+q4rCeBRu+09B5p+nr2YpeCC84phuiaiSdmzhHPTLeH8K
	 bODn0rwrz5wpf70MqRC7hMhh+dGBPHgleZRS2KYm/EjAkRZC/sooW+T1Lc94QY7o8u
	 rq2DU8aLHwSo0GiqnAJH2Iz2dTqzJjlCyoZBHK4y5x6f9VdK4pPaMWp2LESduiJ/Vq
	 sNpUJmizk83n989yAOwAxjRYYU+OfF1J6yOyBSbrtQTXc9iYQVK1jTeHjo3hO06Vw0
	 1dWLruvNu10JgSnXUEB90WbcT0H3E5KvuNf0lyEVeWNoosbKvXBbxl+YEyyzCFIrw5
	 wXk9vP0+6hv7g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 556/638] remoteproc: stm32: Fix incorrect type assignment returned by stm32_rproc_get_loaded_rsc_tablef
Date: Sun, 24 Mar 2024 18:59:53 -0400
Message-ID: <20240324230116.1348576-557-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index 11bbd6018e984..61794c9c080fb 100644
--- a/drivers/remoteproc/stm32_rproc.c
+++ b/drivers/remoteproc/stm32_rproc.c
@@ -657,7 +657,7 @@ stm32_rproc_get_loaded_rsc_table(struct rproc *rproc, size_t *table_sz)
 	 * entire area by overwriting it with the initial values stored in rproc->clean_table.
 	 */
 	*table_sz = RSC_TBL_SIZE;
-	return (struct resource_table *)ddata->rsc_va;
+	return (__force struct resource_table *)ddata->rsc_va;
 }
 
 static const struct rproc_ops st_rproc_ops = {
-- 
2.43.0


