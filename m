Return-Path: <linux-kernel+bounces-124948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A26B891E22
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 353622873C1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890D213BAE0;
	Fri, 29 Mar 2024 12:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UxL/Oofe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC3316C6A6;
	Fri, 29 Mar 2024 12:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716492; cv=none; b=rJAEwvXThZnJsEGnYMlcKbQOHz1v67EAIpsu+ifusBhln0mUkUn0ttd0ZkrcrY6QPEDbiVCmG7bM/iPp3efmdGRAbmdiQJBIdnUSxuRvFtuzHsjg54D3XiJRr31uFOSrDDXozmpjnnUF8x5KikD5h4UOuu2coyo3jbOEQpX8TSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716492; c=relaxed/simple;
	bh=FXDOgi0V6Yo6/LVBS0riKm3X13p/2W430AEkacAMzbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IqXrTRpi8o2gHWvhdqxOEcMmljdjAY3Z9+L2XeVaPMDiOHwpS4GUYfIqF2GjFgDPxOuKlzj9HMbdcX9baC4f7WqUEu1GFsisDP6bZC0WCNYQEyuA6cCvbaxWpYjIrlslb52BVuccdMcgctBhU0ub2zebMivjba9h3jGVpXeNkrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UxL/Oofe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88A28C433C7;
	Fri, 29 Mar 2024 12:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716492;
	bh=FXDOgi0V6Yo6/LVBS0riKm3X13p/2W430AEkacAMzbM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UxL/Oofer5dpwjgH/0FouyLomNlri2JDGm0iQl24fEhB9bHfmWw5gZidiW34rNdga
	 nxTp4GuoD3Sec8QKpVPWd+D9kDT9DwFJF29nScMotZadhc2EsVNhIuodaJS5EutBUW
	 velvkTjkkQ+d5w+W3OAbcsm+j+7MF/3wpT3UI4g2MuLzR0A59XhJBVuKJXbe8C5VcP
	 ppjk/+gsEgArVBislsZXXEIup0fwVI0Kxj77betYXzUwtyCbTULVceWH4I1GAP895t
	 VmLn3xnL1BqEOrlPursFMPF4YbiOA8Aej9s3QtSbc1q+vxh5NixNx0zw4fDSzwaiBW
	 j+5iNtYhjSC/A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>,
	mchehab@kernel.org,
	nathan@kernel.org,
	linux-media@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH AUTOSEL 5.15 12/34] media: sta2x11: fix irq handler cast
Date: Fri, 29 Mar 2024 08:47:13 -0400
Message-ID: <20240329124750.3092394-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124750.3092394-1-sashal@kernel.org>
References: <20240329124750.3092394-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.153
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 3de49ae81c3a0f83a554ecbce4c08e019f30168e ]

clang-16 warns about casting incompatible function pointers:

drivers/media/pci/sta2x11/sta2x11_vip.c:1057:6: error: cast from 'irqreturn_t (*)(int, struct sta2x11_vip *)' (aka 'enum irqreturn (*)(int, struct sta2x11_vip *)') to 'irq_handler_t' (aka 'enum irqreturn (*)(int, void *)') converts to incompatible function type [-Werror,-Wcast-function-type-strict]

Change the prototype of the irq handler to the regular version with a
local variable to adjust the argument type.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
[hverkuil: update argument documentation]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/pci/sta2x11/sta2x11_vip.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/media/pci/sta2x11/sta2x11_vip.c b/drivers/media/pci/sta2x11/sta2x11_vip.c
index 524912f20d9f2..74bbdc11abbb3 100644
--- a/drivers/media/pci/sta2x11/sta2x11_vip.c
+++ b/drivers/media/pci/sta2x11/sta2x11_vip.c
@@ -760,7 +760,7 @@ static const struct video_device video_dev_template = {
 /**
  * vip_irq - interrupt routine
  * @irq: Number of interrupt ( not used, correct number is assumed )
- * @vip: local data structure containing all information
+ * @data: local data structure containing all information
  *
  * check for both frame interrupts set ( top and bottom ).
  * check FIFO overflow, but limit number of log messages after open.
@@ -770,8 +770,9 @@ static const struct video_device video_dev_template = {
  *
  * IRQ_HANDLED, interrupt done.
  */
-static irqreturn_t vip_irq(int irq, struct sta2x11_vip *vip)
+static irqreturn_t vip_irq(int irq, void *data)
 {
+	struct sta2x11_vip *vip = data;
 	unsigned int status;
 
 	status = reg_read(vip, DVP_ITS);
@@ -1053,9 +1054,7 @@ static int sta2x11_vip_init_one(struct pci_dev *pdev,
 
 	spin_lock_init(&vip->slock);
 
-	ret = request_irq(pdev->irq,
-			  (irq_handler_t) vip_irq,
-			  IRQF_SHARED, KBUILD_MODNAME, vip);
+	ret = request_irq(pdev->irq, vip_irq, IRQF_SHARED, KBUILD_MODNAME, vip);
 	if (ret) {
 		dev_err(&pdev->dev, "request_irq failed\n");
 		ret = -ENODEV;
-- 
2.43.0


