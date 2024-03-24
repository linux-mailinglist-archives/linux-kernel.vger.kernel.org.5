Return-Path: <linux-kernel+bounces-113963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E73688879E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7B2C1F2620E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93ADB21D14C;
	Sun, 24 Mar 2024 23:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lTpwkaOL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9071F10D9;
	Sun, 24 Mar 2024 22:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321075; cv=none; b=cfbmUaX6IXAsTWj7FBuGFG6l4BLLuti8TfNhC/K7DUqaItmv/AL2u+EV1lWCDtcdIc32IrVgk5h5e27JWZs6wL89wBpUZoSLcq4HCRZfN7WcKRo12VVPzAEPmOdgGBhEvB9UMBMKncGh3KvgFkJgwTpgMQHCwYyx8g47tYlCGgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321075; c=relaxed/simple;
	bh=h41NIA3cBQEswich+0ng8aJ7IT3gps/J6av94HWph0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YrioL/pFVjypQ8OnSCowG2tiZUdJ2Dz8b2iQFyG0axOw+S1z7trjIBT52ZwdoTFluVSf2A9+TRA02EO7Fxf6wwx5iLkWT8ro0XWVy6149+nRnzs2IzgRElIQ8XFkupGD2wisQM/PPGPFWWeD7cFjah6t09InboFgb1ooYtbsfOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lTpwkaOL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CBB2C433C7;
	Sun, 24 Mar 2024 22:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321073;
	bh=h41NIA3cBQEswich+0ng8aJ7IT3gps/J6av94HWph0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lTpwkaOLu0otXcxC5wC9jgo8eefG/SgT73htgaYrLju1ntdb2oxLZtqKiOU4VfQ6K
	 VfgobI8mRp0GiIoQ+cM64Q9tM7UffFpfhAs3SbCE9Ygw4via1sq36972LdolpPJKf3
	 KdDqEOr/Gj8RzuFEaZKXfkjs0KnBA9nNLpJNLECK7Xu8mQvHgMq3Au3WBuY7peHQkY
	 5Lma7iqFgIBHbnMb3Zrwwg4cG6f0YeIvmMYbtL1DusRMaziMjtQIBYrHee1WE2QwCS
	 1mERJJXu07pBurEJ/Ari/2IykmGpTSloVUo85rnic+iVlCfCO9sq981x/n+j13xFIW
	 RX730Fa4M8bCA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Michal Simek <michal.simek@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 637/713] char: xilinx_hwicap: Fix NULL vs IS_ERR() bug
Date: Sun, 24 Mar 2024 18:46:03 -0400
Message-ID: <20240324224720.1345309-638-sashal@kernel.org>
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

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit 316459ba4051fd91237171fdca88920128a646f1 ]

The devm_platform_ioremap_resource() function returns error pointers.
It never returns NULL.  Update the check accordingly.

Fixes: 672371832193 ("char: xilinx_hwicap: Modernize driver probe")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Acked-by: Michal Simek <michal.simek@amd.com>
Link: https://lore.kernel.org/r/ef647a9c-b1b7-4338-9bc0-28165ec2a367@moroto.mountain
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/xilinx_hwicap/xilinx_hwicap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/xilinx_hwicap/xilinx_hwicap.c b/drivers/char/xilinx_hwicap/xilinx_hwicap.c
index 019cf6079cecd..6d2eadefd9dc9 100644
--- a/drivers/char/xilinx_hwicap/xilinx_hwicap.c
+++ b/drivers/char/xilinx_hwicap/xilinx_hwicap.c
@@ -639,8 +639,8 @@ static int hwicap_setup(struct platform_device *pdev, int id,
 	dev_set_drvdata(dev, (void *)drvdata);
 
 	drvdata->base_address = devm_platform_ioremap_resource(pdev, 0);
-	if (!drvdata->base_address) {
-		retval = -ENODEV;
+	if (IS_ERR(drvdata->base_address)) {
+		retval = PTR_ERR(drvdata->base_address);
 		goto failed;
 	}
 
-- 
2.43.0


