Return-Path: <linux-kernel+bounces-145104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C97AB8A4F9C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 852502841C3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EB777624;
	Mon, 15 Apr 2024 12:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XCTknpLv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136AE71B40;
	Mon, 15 Apr 2024 12:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185361; cv=none; b=j81rhr1O+6pL6zmlTiZmjWqyYvwMT/x6XlVM9PZXshXFJMMcDBabjuFBH0SffdZjw7iLRAyYhFce5MJblTVg2kJcIk2IQTD2kXI7E0+wh+vLfpdkCfIMMjgaX5VkUJ0XaMA2IyBiL3X25QEqPjV8gYDFlbRwSZ3uYrL+Q0t/9pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185361; c=relaxed/simple;
	bh=su8lAdbQyVsMoyVxYqoxXb5brRrfnJdJWAb+55IZgJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a4+0t4CRRNnxSrf87MluzKQe8G9JLsgoGcT0VHtV61BaDnj9WMOfQQiRXYiOAG1KsdoMwMCoeqJW3kqZpyEx9J5zN+SbUVyqJwzlBdOLVKIEz3ikTbWdNlMql9x0kpEwQQnqE73zUEadb1Dmc8u+zDalaPUdIOMKUas2aOHmnEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XCTknpLv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B14D5C113CC;
	Mon, 15 Apr 2024 12:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713185360;
	bh=su8lAdbQyVsMoyVxYqoxXb5brRrfnJdJWAb+55IZgJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XCTknpLv+/QM/hJQ4+FuGUmxt43pqzP++GFPR3PKpFYb8BM/hCgXvCUUQV7moZR87
	 spOHtICcUx6tbJBfpqsFiim3gwlnussnWOSGDydye4fA+AtOb8h1XvKyNV9co5zCNq
	 UJDO/VfxqraTzsCnV4qhieuZY1JU5WZ3aR1pJpE9hjMteOmLbM3fpAxigc1Zxc53Fu
	 iW0yUNkbGXaJbJtT1u99IhSzb2T6EZ/TlYDWsEv6DyR1wLQOPQ6Uk+oEDbe70BJ/Ib
	 E4AkSmc2pRHBNxZrWy9yWLks0+z721pQXXYz5xsIbPiLEZmmmnzWzaLQD5FEuLCkvD
	 mWr5dYPBjkxNg==
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
Subject: [PATCH AUTOSEL 6.8 06/15] scsi: libsas: Align SMP request allocation to ARCH_DMA_MINALIGN
Date: Mon, 15 Apr 2024 06:02:46 -0400
Message-ID: <20240415100311.3126785-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240415100311.3126785-1-sashal@kernel.org>
References: <20240415100311.3126785-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.6
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


