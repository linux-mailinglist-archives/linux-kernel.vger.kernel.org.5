Return-Path: <linux-kernel+bounces-101794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B12DF87ABA9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31604288747
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4D954669;
	Wed, 13 Mar 2024 16:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e9+cJ4DV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D27D664BA;
	Wed, 13 Mar 2024 16:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347648; cv=none; b=m+wR+6uR2SYSyOq0pBC0pdAIT1z+GLVtXjWy/JDG5IYV9UW2hGkLgVF3R4BW5N3cZVCqMXXvfp4IkuglrC1osDbdo3og+dniRmikCYd7/xHQU2mNX/gQzEieG4LH+7KlTNILIcKAfpQza+/7sX6J4mgzRYDsaHCdzFXmaW0uPfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347648; c=relaxed/simple;
	bh=EFcoG789kOXcScPJkWGmK574qeWaFYOL+39to9lgwH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KVchbkj/VzDmiHVVTBWUD51Iy4fHBNzj0V+8lCZDjAeWi29NSMd3/Xvk+A1Sh4T6IH7L5yuKxa7g3ykOrEnnDVk1wFkIwaFJrCuuZ5o2hDLWgWb1CtKyIWcLmMzOYLURL9JiaDlhJlelhxAnFn3qgDplhovDAEa2R4kpVVZUB+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e9+cJ4DV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12606C433C7;
	Wed, 13 Mar 2024 16:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347648;
	bh=EFcoG789kOXcScPJkWGmK574qeWaFYOL+39to9lgwH8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e9+cJ4DVMD93DvkwdKxqKxQsjykHwJfbjQfVvEdDdTuB2bvoBp9ZJk4FpZ7mcc1O8
	 +UGwF44gIeN1NvUK69Q4PM+07WQmOJKJT0Xr/jUng6Z5++wwuQgb4ROp/Z/6hfS1Fc
	 eTV6YIZ3z5l+P8nq3XZBfoIUjnIQoXReL5HR3osLW5lQHD5yDoA+zGJnApzB4uu49X
	 mH2dx/nYC/xQi8DpTqYQ3UdO3f28B8daWfDIuyJCVdo1m0LGaeTGrA2rZTWn+QQndd
	 FVNE+UjWj/6ONJIpefnKtwYd4DRj6bq5HeXA2lrjV1Zb8Z1ZNf48JNzfHrdlwxJ9jj
	 W9LLO7jgziIRg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yongzhi Liu <hyperlyzcs@gmail.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 55/61] net: pds_core: Fix possible double free in error handling path
Date: Wed, 13 Mar 2024 12:32:30 -0400
Message-ID: <20240313163236.613880-56-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163236.613880-1-sashal@kernel.org>
References: <20240313163236.613880-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.10-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.7.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.7.10-rc1
X-KernelTest-Deadline: 2024-03-15T16:32+00:00
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


