Return-Path: <linux-kernel+bounces-113955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 289AD88878D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A9A01C268DB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26C0155725;
	Sun, 24 Mar 2024 23:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D8/YTR0f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EB31F1AD5;
	Sun, 24 Mar 2024 22:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321080; cv=none; b=WDZZ+ooKtsVejXw1FpxLeXiPNPKOKwTCPJ/f9VkXeT7TOrAEerZSPFttzrRlp2q2860euICCVAFYjUMKraakZymyCztJ/d/IywJnuBEs31THAJEQcK491wBCLgL+2GQU5k0ZD6EbDAFsfYpLbX3ukRCPY7TeAemsFCjSsoj9XVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321080; c=relaxed/simple;
	bh=etuvMnhU1Yw1AqFeBdAgKEHh4IM1KJV2ySH1nskxOcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f1hadH+dSnmUXPHGGI53VPfC2YZjtrcii7ytv3adV14I61DMwObNoD7AheQoYf5++dmhqJTADrHs+r4IMjJ1B4nGE4FhYIMk8tm1A/DLDjgb/ujtrDdLFXiK24FRZY8Fy/kxX3IGwdYMxOTY/+PAngb3YP8toYBtP3Z/RwBlAk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D8/YTR0f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC2C6C43399;
	Sun, 24 Mar 2024 22:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321079;
	bh=etuvMnhU1Yw1AqFeBdAgKEHh4IM1KJV2ySH1nskxOcI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D8/YTR0fR+aNOCTSJOOSn606CvHVK1t0W32LNJyb8unH5Y4qZeHuiBjoIYwah/Kav
	 rqMqr04i2gfzMMgvNXLA0SVJQShiT4yOHf/tcJm972ox2h7j87FJNB9kz6Ue0Ze3lT
	 pDY717IFIVEbuvn3AVom4Y6PoyIDsbQ1jbnPPa0e5hxd7IvcZCV0qjI+Cp6mRBAtrb
	 CEEvlb9K7+/dUvKCSehCkJli3wME9dD7GrNmi4Tk9JALBj+NXBvNSqcGuRV4Yjwaa1
	 5rtWgzGtJvGCfsDEgZakOd0W3JosQSGDpz1nF4FwgvlOvkFn/40NkTM3abhLYhi6d+
	 k1cbd0PyTFmFw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 643/713] spi: lpspi: Avoid potential use-after-free in probe()
Date: Sun, 24 Mar 2024 18:46:09 -0400
Message-ID: <20240324224720.1345309-644-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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


