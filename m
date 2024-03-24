Return-Path: <linux-kernel+bounces-113531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D40888513
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 310191C2040E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB55113E037;
	Sun, 24 Mar 2024 22:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P7/HZrxy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6AE74402;
	Sun, 24 Mar 2024 22:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320333; cv=none; b=gcTRcryXIleDPLQQ0IGudHt3QHOGrpYqodD12wNc9/jfdc8OC8dOEqnRwAqlZDrpUj2ucQe+zK/5hlQkba8/7bX8FdIVOIUT9leW04o7R70f693SGRr0rO1a4bOEPur8MxvJMcwwM6N8Kl39Q71fUyOv15SdG8nnvGn988HZFA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320333; c=relaxed/simple;
	bh=etuvMnhU1Yw1AqFeBdAgKEHh4IM1KJV2ySH1nskxOcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GJNNaz8ZRSc5mVEiFPaPnxlM6rANvRt8VpKys8MFNvihsxUiiItjqNnwR/vQAo5qyC3s6qpMSJEcN1WRLWWitvx3q2LGXOKaWPj8Lo9H81tNnWUeGY7df+dMfv8hw8dkMlZO1PEErH1e2r9jtVcefqtdJlcD70CwKYXWvfWXNr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P7/HZrxy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BE10C433A6;
	Sun, 24 Mar 2024 22:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320332;
	bh=etuvMnhU1Yw1AqFeBdAgKEHh4IM1KJV2ySH1nskxOcI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P7/HZrxyUli9X2kT6zmf9ihUiKgVbDRIogNY2GV47GC/dC9+CdYFzHWn9qqXrqzvA
	 h2w2WPL+Jgq5ARJi9y1jcZKo6jkDwH/7R+4DTpRgLn1kmKJUi+7tvYS+Mg9nLiZIxQ
	 IHOFFH41aD+pTjUBSrclOLTGhaitwguH75ecricYRcdSRtntBa3MTUC8NcO1lWKYhZ
	 XbKjfBDvLhjvNRHoDu0lLZnPCPjPOtCLEh0B0LiMpnFicOxC7ilzGJqpB0yaqWAXjE
	 SBtJDAaWXSmk/gRfX7Vm4Ux7UZtmncR/8wC1P1+6fhFiHxhoL9v9cSg+0PrhP07gn9
	 dK4V40EPFJOYw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 640/715] spi: lpspi: Avoid potential use-after-free in probe()
Date: Sun, 24 Mar 2024 18:33:39 -0400
Message-ID: <20240324223455.1342824-641-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

[ Upstream commit 2ae0ab0143fcc06190713ed81a6486ed0ad3c861 ]

fsl_lpspi_probe() is allocating/disposing memory manually with
spi_alloc_host()/spi_alloc_target(), but uses
devm_spi_register_controller(). In case of error after the latter call the
memory will be explicitly freed in the probe function by
spi_controller_put() call, but used afterwards by "devm" management outside
probe() (spi_unregister_controller() <- devm_spi_unregister() below).

Unable to handle kernel NULL pointer dereference at virtual address 0000000000000070
..
Call trace:
 kernfs_find_ns
 kernfs_find_and_get_ns
 sysfs_remove_group
 sysfs_remove_groups
 device_remove_attrs
 device_del
 spi_unregister_controller
 devm_spi_unregister
 release_nodes
 devres_release_all
 really_probe
 driver_probe_device
 __device_attach_driver
 bus_for_each_drv
 __device_attach
 device_initial_probe
 bus_probe_device
 deferred_probe_work_func
 process_one_work
 worker_thread
 kthread
 ret_from_fork

Fixes: 5314987de5e5 ("spi: imx: add lpspi bus driver")
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
Link: https://msgid.link/r/20240312112050.2503643-1-alexander.sverdlin@siemens.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-fsl-lpspi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 11991eb126364..079035db7dd85 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -830,11 +830,11 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
 
 	is_target = of_property_read_bool((&pdev->dev)->of_node, "spi-slave");
 	if (is_target)
-		controller = spi_alloc_target(&pdev->dev,
-					      sizeof(struct fsl_lpspi_data));
+		controller = devm_spi_alloc_target(&pdev->dev,
+						   sizeof(struct fsl_lpspi_data));
 	else
-		controller = spi_alloc_host(&pdev->dev,
-					    sizeof(struct fsl_lpspi_data));
+		controller = devm_spi_alloc_host(&pdev->dev,
+						 sizeof(struct fsl_lpspi_data));
 
 	if (!controller)
 		return -ENOMEM;
-- 
2.43.0


