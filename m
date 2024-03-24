Return-Path: <linux-kernel+bounces-113525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DAE888507
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DABE1F227EA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA8B1BE812;
	Sun, 24 Mar 2024 22:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fuiG/UXl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3161BE7F4;
	Sun, 24 Mar 2024 22:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320327; cv=none; b=L1pEsh44OxXDt3x2Gwpn1UV8anZPfhA+BnZ6XCUJKUB9XLvWrbm6WDf381X4yYJ4jKMvKnG5xPBsERqxf2tJyG69IIy1kmxPEFmoGYs58y/QmOH1jCX8kt+uznFLf4GWKWdnGYnO58M3S3h3n6RzaXygk5OxtQBnFuP55pLD28k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320327; c=relaxed/simple;
	bh=h41NIA3cBQEswich+0ng8aJ7IT3gps/J6av94HWph0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SoW3ilC3Rp2A8/NpPiDi8b9PfZ2X+lpcGeWtfMJg+gq7v38jgBQfUAA+Z6qal5vY5Hem0qWosOfKs3g/fQ8EsYxSJLItVDLaQcQZAhkPOKp99iT3t4m9s8mq7DL0jL5nfZ3XZRbPdjRJNKFdD7gQONQkRQQFnHvX5gW4mH3MdBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fuiG/UXl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4247AC43399;
	Sun, 24 Mar 2024 22:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320327;
	bh=h41NIA3cBQEswich+0ng8aJ7IT3gps/J6av94HWph0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fuiG/UXlPNZrhfctnjQtIKXRtwfwMExvPj/dq+13dffU/jjh//V4jWW6mDW0EsKiB
	 wMJZboMlB/SRFpSBe8S31g4DJ9G8acHbI8bUyYO1jOhSJlhlZ8cN6ZqUKajHZ+sJZO
	 ECHID7m+CnggdIhjgTQQukzW3nWVf0/1ZC86khzAr+je2pZ0AJ3CiuPyYClYt4cQ6h
	 J/ihevDmF06fVam3b9oAQLfc9toTuuIItwrvvJf/DB+4EVrQcJ4lrpy5IOU2GtI0fA
	 TQFpfcwc8/aPo2X0exfoLdnsPlu4dGZ6MGnxlI8SFdFlYCPLqCt0CisC5QxyWhPaP0
	 6g7pH2ADms7uA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Michal Simek <michal.simek@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 634/715] char: xilinx_hwicap: Fix NULL vs IS_ERR() bug
Date: Sun, 24 Mar 2024 18:33:33 -0400
Message-ID: <20240324223455.1342824-635-sashal@kernel.org>
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


