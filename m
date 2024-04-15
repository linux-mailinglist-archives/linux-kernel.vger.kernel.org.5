Return-Path: <linux-kernel+bounces-145127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E755F8A4FE8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 239361C20EBF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822F586262;
	Mon, 15 Apr 2024 12:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Anf1e6SF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C360885299;
	Mon, 15 Apr 2024 12:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185405; cv=none; b=QQ4ZU1lAMchZB6M1yHdYmAe1lPPr0fN9WEoJfhU2+FhdH4i2FUyF11U9i7z9AwmpVlgX9KTRUtWaXiN93/bIC9Nsu8E2nntP202G2Mc1yb75GMyrvKLHUEkah1uVi3EVb/mHzpS8v2w8a99QUKKV96enG9ImXmguc/Izj+Y7yk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185405; c=relaxed/simple;
	bh=su8lAdbQyVsMoyVxYqoxXb5brRrfnJdJWAb+55IZgJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ck0J1IHYbXEdv02CN7XA7QC3z8fr3f3AhUm5xBWODw+Dw92sNs58YAvIQ+synZ+WBwWY/kPqP6zFLoggOmQqJdZpnZ6iDVvGu19f5NL5SH38FMhyBpgHBlX74OzNWb8XYOel7ikL3pj2+XoLDnJ92z4GmDNRPNBr3s8RiiRnokM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Anf1e6SF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CB1BC2BD10;
	Mon, 15 Apr 2024 12:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713185405;
	bh=su8lAdbQyVsMoyVxYqoxXb5brRrfnJdJWAb+55IZgJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Anf1e6SF6vUuhNdU1GO8akN0ICZc90BKW9PMQnStCE2Hm6BywZ+xCUamgmvn2AtF8
	 gDAIvxJmtjtLjo5M1i55IEC726xybNb4dw0T82CaOgOoKtD50ZLS3KLMHXcCXQ8ES+
	 aQQhSle41ic7014sFnU0hwu+rxTuhbjE4FkEUO1TlTi1aiyymYfLQCrQlyhUN4FcXu
	 HtYyyNe0kM+jJrC7ZBRWgCx8Qm79HSlsKANFL/wVUOe6f+d6d7xLgPfqNmPincX842
	 pXel2qS0Dnlb69jvtOAp/HM+Kqk3gy+GKeE9bdaOqc7g45sezOLlQtYbW+lZnkdvtb
	 p2loF0RCQbRUA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yihang Li <liyihang9@huawei.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	John Garry <john.g.garry@oracle.com>,
	Jason Yan <yanaijie@huawei.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	jejb@linux.ibm.com,
	yangxingui@huawei.com,
	linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 05/12] scsi: libsas: Align SMP request allocation to ARCH_DMA_MINALIGN
Date: Mon, 15 Apr 2024 06:03:40 -0400
Message-ID: <20240415100358.3127162-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240415100358.3127162-1-sashal@kernel.org>
References: <20240415100358.3127162-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.27
Content-Transfer-Encoding: 8bit

From: Yihang Li <liyihang9@huawei.com>

[ Upstream commit e675a4fd6d1f8990d3bed5dada3d20edfa000423 ]

This series [1] reduced the kmalloc() minimum alignment on arm64 to 8 bytes
(from 128). In libsas, this will cause SMP requests to be 8-byte aligned
through kmalloc() allocation. However, for hisi_sas hardware, all command
addresses must be 16-byte-aligned. Otherwise, the commands fail to be
executed.

ARCH_DMA_MINALIGN represents the minimum (static) alignment for safe DMA
operations, so use ARCH_DMA_MINALIGN as the alignment for SMP request.

Link: https://lkml.kernel.org/r/20230612153201.554742-1-catalin.marinas@arm.com [1]
Signed-off-by: Yihang Li <liyihang9@huawei.com>
Link: https://lore.kernel.org/r/20240328090626.621147-1-liyihang9@huawei.com
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: John Garry <john.g.garry@oracle.com>
Reviewed-by: Jason Yan <yanaijie@huawei.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/libsas/sas_expander.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
index 5c261005b74e4..f6e6db8b8aba9 100644
--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -135,7 +135,7 @@ static int smp_execute_task(struct domain_device *dev, void *req, int req_size,
 
 static inline void *alloc_smp_req(int size)
 {
-	u8 *p = kzalloc(size, GFP_KERNEL);
+	u8 *p = kzalloc(ALIGN(size, ARCH_DMA_MINALIGN), GFP_KERNEL);
 	if (p)
 		p[0] = SMP_REQUEST;
 	return p;
-- 
2.43.0


