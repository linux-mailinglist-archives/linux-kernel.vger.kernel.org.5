Return-Path: <linux-kernel+bounces-62669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F65852432
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22D421C209B7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A5463403;
	Tue, 13 Feb 2024 00:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S49AixcS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD3E62812;
	Tue, 13 Feb 2024 00:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783711; cv=none; b=nj8BYz7Yx36lysQjyxUU5QA8g75y2t6umGyRHNE8U/uGU2buL+viCkrfa5cBhG7dsdV1gKRv3sovZjPaZuNUQXUXUmRzRKrLxMY0w8X0xRg4sNX+mGoHZy0LFgFQP2Z64Z/PIH+zNvKu/eORQ7xdPUB6dZVHtr/f1kYnK4ZqWc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783711; c=relaxed/simple;
	bh=vldSKRNTJjwJ6UGBGCtx5oArb3tRvtDaR38H6SWACvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EdfROxf3xtgLthA38LkdP+4Qpw/S2ULRVRc7TNTWb1L7JTe0v4FeRvm/nctr8JNMpVGaNGSSigIgyLlCZ8tbR/1x5YIbLQ4UEqAgjQu1xcVNtvtA6p/ImtToYwIYZu5IhNPCKYgR6W+GkR8EHL4FSZhXMqjesofzdR6wjLUyZpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S49AixcS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E18CC43399;
	Tue, 13 Feb 2024 00:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783711;
	bh=vldSKRNTJjwJ6UGBGCtx5oArb3tRvtDaR38H6SWACvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S49AixcSLf68OKtavkvutiUeZbPrfa/wWBtHopT0vUEC9mMJXptdO3k0wuP4Z7VJ6
	 JWWaq1XxX7srLgyXLg4iep3M/99cTMXnUCd7rkK1R3gNKENIP2yJELiBi+qozJUfVI
	 dRhCc4knLD8D5ymOPZdep2IrjxGMBAe6pQzUbDal/rUyRMUVLHamx7MVDlsEunrvcg
	 X7Nuj6GqiMx9SECDwhevQZcMaNFrwjAUxGY8NRCF1dO6tUoCdGrCrkHi8Noo9amiyy
	 TsZe8T0epMg89wRPDoW52cpX1rQZz7SfW7ajVETDhMue4Ep3p0qHPTXCqap59S9g4G
	 HqCZJsntCuVGQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	Jeffrey Hugo <quic_jhugo@quicinc.com>,
	Sasha Levin <sashal@kernel.org>,
	stanislaw.gruszka@linux.intel.com,
	ogabbay@kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 38/51] accel/ivpu: Disable d3hot_delay on all NPU generations
Date: Mon, 12 Feb 2024 19:20:15 -0500
Message-ID: <20240213002052.670571-38-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213002052.670571-1-sashal@kernel.org>
References: <20240213002052.670571-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.16
Content-Transfer-Encoding: 8bit

From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>

[ Upstream commit a7f31091ddf457352e3dd7ac183fdbd26b4dcd04 ]

NPU does not require this delay regardless of the generation.
All generations are integrated into the SOC.

Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240126122804.2169129-4-jacek.lawrynowicz@linux.intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/accel/ivpu/ivpu_drv.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/accel/ivpu/ivpu_drv.c b/drivers/accel/ivpu/ivpu_drv.c
index 7e9359611d69..8fb70e3c7b9c 100644
--- a/drivers/accel/ivpu/ivpu_drv.c
+++ b/drivers/accel/ivpu/ivpu_drv.c
@@ -467,9 +467,8 @@ static int ivpu_pci_init(struct ivpu_device *vdev)
 	/* Clear any pending errors */
 	pcie_capability_clear_word(pdev, PCI_EXP_DEVSTA, 0x3f);
 
-	/* VPU 37XX does not require 10m D3hot delay */
-	if (ivpu_hw_gen(vdev) == IVPU_HW_37XX)
-		pdev->d3hot_delay = 0;
+	/* NPU does not require 10m D3hot delay */
+	pdev->d3hot_delay = 0;
 
 	ret = pcim_enable_device(pdev);
 	if (ret) {
-- 
2.43.0


