Return-Path: <linux-kernel+bounces-101853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB43587AC29
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A64B1F2721B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B681C74C0E;
	Wed, 13 Mar 2024 16:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rSCagq5N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA34174BFC;
	Wed, 13 Mar 2024 16:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347890; cv=none; b=EoTnvbHOXBSUFNLDVzpq5Y/UZ2mQCEyzuy0HSMDeVc07ej4pT+6HGN7J1p1Uf2xaWkHJ6WqG1uaSm0mqOyQ5WrTb5Acp2zFOs3dOen8Sw6MGv0wWLRjtI0YIXSbCxG5tkh2oE/HKrwGOUMrVCJYDNbBa7hHFrTMp4sZwicxPaTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347890; c=relaxed/simple;
	bh=EFcoG789kOXcScPJkWGmK574qeWaFYOL+39to9lgwH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cLBYNyvFzRzn13BZNkjcQjMX4y4Qf5jNOnxCtFzMewWyWPxg4D4fSca9W4WuxxDhsgAZh0F/pyH8CGH//h9cwd6ON0LNO/i2Q0jeO4ITlRjMhV7Q033bFQS2HFO75mqvZAmfeXXcmEy2S2bVRbpIS4x5mUoy/I2+RoUEWzbcszQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rSCagq5N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AF0EC433B1;
	Wed, 13 Mar 2024 16:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347889;
	bh=EFcoG789kOXcScPJkWGmK574qeWaFYOL+39to9lgwH8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rSCagq5N1vxdkoHAcpUx4fL9f5fteYDaVJIGHKz02XkRXINcJ4a+c+J/XRADn9bOu
	 yerE5j+QK0CnuLdRr9QOyHwCOs32Q6bkrd+ON9fPSNIeD1TVwpcQe9PkVnmGJbk066
	 mmvHFow58wxRIfZwzyshJYDg+4ukf9UcUogxcMrUdg7FpIYVglgXPV5ItJY0CfIB4h
	 qiLs3ZM9ZQY7IirNTb45P7nh3cidgErtbb2xH3R/ffMvmtw3JhrB3bC3AJsVhm7F+N
	 7Or2Rzn2cYb/BN53Hygg+oDWRDq1W2FIsbF8egfwG9jrmgXyC5VH+wqxiK6UrO8fLC
	 BddqX2gcLZAQA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yongzhi Liu <hyperlyzcs@gmail.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 50/60] net: pds_core: Fix possible double free in error handling path
Date: Wed, 13 Mar 2024 12:36:57 -0400
Message-ID: <20240313163707.615000-51-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163707.615000-1-sashal@kernel.org>
References: <20240313163707.615000-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.22-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.6.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.6.22-rc1
X-KernelTest-Deadline: 2024-03-15T16:36+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Yongzhi Liu <hyperlyzcs@gmail.com>

[ Upstream commit ba18deddd6d502da71fd6b6143c53042271b82bd ]

When auxiliary_device_add() returns error and then calls
auxiliary_device_uninit(), Callback function pdsc_auxbus_dev_release
calls kfree(padev) to free memory. We shouldn't call kfree(padev)
again in the error handling path.

Fix this by cleaning up the redundant kfree() and putting
the error handling back to where the errors happened.

Fixes: 4569cce43bc6 ("pds_core: add auxiliary_bus devices")
Signed-off-by: Yongzhi Liu <hyperlyzcs@gmail.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
Link: https://lore.kernel.org/r/20240306105714.20597-1-hyperlyzcs@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/amd/pds_core/auxbus.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/auxbus.c b/drivers/net/ethernet/amd/pds_core/auxbus.c
index 11c23a7f3172d..fd1a5149c0031 100644
--- a/drivers/net/ethernet/amd/pds_core/auxbus.c
+++ b/drivers/net/ethernet/amd/pds_core/auxbus.c
@@ -160,23 +160,19 @@ static struct pds_auxiliary_dev *pdsc_auxbus_dev_register(struct pdsc *cf,
 	if (err < 0) {
 		dev_warn(cf->dev, "auxiliary_device_init of %s failed: %pe\n",
 			 name, ERR_PTR(err));
-		goto err_out;
+		kfree(padev);
+		return ERR_PTR(err);
 	}
 
 	err = auxiliary_device_add(aux_dev);
 	if (err) {
 		dev_warn(cf->dev, "auxiliary_device_add of %s failed: %pe\n",
 			 name, ERR_PTR(err));
-		goto err_out_uninit;
+		auxiliary_device_uninit(aux_dev);
+		return ERR_PTR(err);
 	}
 
 	return padev;
-
-err_out_uninit:
-	auxiliary_device_uninit(aux_dev);
-err_out:
-	kfree(padev);
-	return ERR_PTR(err);
 }
 
 int pdsc_auxbus_dev_del(struct pdsc *cf, struct pdsc *pf)
-- 
2.43.0


