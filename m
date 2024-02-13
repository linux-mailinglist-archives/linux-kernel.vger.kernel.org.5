Return-Path: <linux-kernel+bounces-62616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 122CA8523AB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64184281E11
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6993D57310;
	Tue, 13 Feb 2024 00:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qGdBG80H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B4556751;
	Tue, 13 Feb 2024 00:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783591; cv=none; b=iYGhHYd8TzA5/5YKMjdllf8zzUG1MNSGHfV0dXizD3B9MWWBGi7Nd2nbLh5Us2P+VH06EfT98rsxWCzkF3G7npol9VfSWC7AB+7SjCBEdqUqVhsC5yF/hWNZRVOIR9ixtgB/xuS3V6LMEjch9VZPYCYtfD7qPijxD6MgfvyuCOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783591; c=relaxed/simple;
	bh=pTLmszu6BhzSoKlRWW+NOEMbyMqr/DXKXZ8u2xMscig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E3/6E45QCGkZZ5uWfElQKVXDevsD0Lr/uskt/AwAYeVNlBCZ850EjcJve8RP2v/ZzKWepZ3njLGrr639WF69SoxLSVqI4Ni0stlvcyjLjeloi0zEDqNiQkCrBUoU+yectSUP1ujvHaT7FQd1Xbz9ZpTHt1CKRRMQQshlDXGQgCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qGdBG80H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FF8FC43399;
	Tue, 13 Feb 2024 00:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783591;
	bh=pTLmszu6BhzSoKlRWW+NOEMbyMqr/DXKXZ8u2xMscig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qGdBG80HTEUpTxClpzh6fnNuKdrfnZTBznrqThEJGWxIvup2mzmwddeozpHHcH1Ew
	 n0TkFtsMG6qtiTCSKi96JNKXETeRAGBVCaa4cKGLjmOpuYcpmR/dErtBXJ+opzk+M2
	 JUACTcXD6kWJbA+N5VdGodK68ZgIr2/0/HYbM7ZgOTfSiE6U+Oac93G+blExHngEeQ
	 Tf8t5B0gJj4m4SUgDOG+0xaEluDZNwOYvwMLNibTn7i57aNxCoI6YDXzLiJ0uLCedx
	 y6RY5uAWKfEtxxXqNCQds1WrTk7CSWa5gRuA5leYdxEyBI2RyaIjLIz5FExinnzElo
	 11qI80Oa8K0+g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	Jeffrey Hugo <quic_jhugo@quicinc.com>,
	Sasha Levin <sashal@kernel.org>,
	stanislaw.gruszka@linux.intel.com,
	ogabbay@kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.7 44/58] accel/ivpu: Disable d3hot_delay on all NPU generations
Date: Mon, 12 Feb 2024 19:17:50 -0500
Message-ID: <20240213001837.668862-44-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213001837.668862-1-sashal@kernel.org>
References: <20240213001837.668862-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.4
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
index 790603017653..c856c417a145 100644
--- a/drivers/accel/ivpu/ivpu_drv.c
+++ b/drivers/accel/ivpu/ivpu_drv.c
@@ -479,9 +479,8 @@ static int ivpu_pci_init(struct ivpu_device *vdev)
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


