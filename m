Return-Path: <linux-kernel+bounces-113519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FB08884FA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8AE71C24414
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD3E1BDB87;
	Sun, 24 Mar 2024 22:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E35IQHVM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267CD1BD5FB;
	Sun, 24 Mar 2024 22:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320321; cv=none; b=Jm8UpIKMh7UbL2JBJFhbljXylIrPhlZWf6mxVI+fV+TNu6UQ7U3fFG9u+eJLvCHWDcDgjkadgmj70VFRGaWw5iWhf6idJUgaR28sQrPCA1X3SMMuxFK5/j5RsMaN4XTSLk7PthKEhdMmwabaZtT+xOhAAxKc5mwL0Tlr/bLBJC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320321; c=relaxed/simple;
	bh=0U+5D4DRz8h15rzlQU+NzAMENCJf/RgVlOr9F6AF2wY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JkJcWNeDzAIQOhfp4wq9D5Xfzfatxwr6dIYWv8rRLuhTzyE0wDEVds0KR1OmLBAxkTKvk9y68p+Dy1RQKj9ELiyvZosRdkxID/K450t81OpDq85JseBCaY4XdpR6csCsapKgzJpUWkwhEeqaNg7NSEeomubdFcDi3Ky6liJ1UQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E35IQHVM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C7ABC43390;
	Sun, 24 Mar 2024 22:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320321;
	bh=0U+5D4DRz8h15rzlQU+NzAMENCJf/RgVlOr9F6AF2wY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E35IQHVMb44n5nMKW/9eEEwP5PFdiUm2+IglrLoX1NaQZmyPVbMroTTt++ck4sZ/d
	 9gKWmJscObgeHAH22AJaaGwf8BtbSMnNLJ0bQgCZLjQAzRsyzqiWYUzMmLgNdcw84s
	 DKD7f7XecOqC5tZ64DykPfq1bcxNWbSan4ohHSP7IiIWac897+ygb9TRgwOODoFHV4
	 3MpZfcfBHFQJZOGfODdJ3MvJEMglaUSz4VwR9uf6Sz8Mbyy6Of6MIuMHwzZvMZEdIy
	 iyK75l3o9TPR8mrflUpB67/sw+VbcoWYqHT6XDm/prnid0fSm8abdR422k4VcArCZn
	 K86Ax8ItbMzQg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 628/715] rtc: max31335: fix interrupt status reg
Date: Sun, 24 Mar 2024 18:33:27 -0400
Message-ID: <20240324223455.1342824-629-sashal@kernel.org>
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

From: Antoniu Miclaus <antoniu.miclaus@analog.com>

[ Upstream commit c12e67e076cbcb86fd9c3cb003a344ec684138a6 ]

Fix the register value comparison in the `max31335_volatile_reg`
function for the interrupt status register.

MAX31335_STATUS1 macro definition corresponds to the actual
interrupt status register.

Fixes: dedaf03b99d6 ("rtc: max31335: add driver support")
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Link: https://lore.kernel.org/r/20240219091616.24480-1-antoniu.miclaus@analog.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/rtc/rtc-max31335.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-max31335.c b/drivers/rtc/rtc-max31335.c
index 402fda8fd5488..a2441e5c2c74d 100644
--- a/drivers/rtc/rtc-max31335.c
+++ b/drivers/rtc/rtc-max31335.c
@@ -204,7 +204,7 @@ static bool max31335_volatile_reg(struct device *dev, unsigned int reg)
 		return true;
 
 	/* interrupt status register */
-	if (reg == MAX31335_INT_EN1_A1IE)
+	if (reg == MAX31335_STATUS1)
 		return true;
 
 	/* temperature registers */
-- 
2.43.0


