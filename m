Return-Path: <linux-kernel+bounces-113159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1D28881EE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F2A9B222A1
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53616173324;
	Sun, 24 Mar 2024 22:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QwFXP7xa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88253172BD4;
	Sun, 24 Mar 2024 22:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319961; cv=none; b=XIZEkYEYqTKHYKmS5waHJ8IUvxy0RQq68ee0O/UsBfBy9FUyoIbV6Tqa/cbqJBdibJherSZIR6fzaF3vu+oFf1SBkM0/ngxv3R5Q1m1+AiK2BHGz/9sMSPfLROHQeKj+tFcQsNs7pZhaUL8T1IIRASrtJHfK0mGGlM/Td6qk6hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319961; c=relaxed/simple;
	bh=yEacVUk4vPPXTEet/MLxzVr9gJMeEgue7ybvIiF3cPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tQ7OuVsx0MjfYnZ4wEuq2FKVhrGfZ57+X2QdvaojHT4GrnVU1G9+tGoDPCJw5roLBOq4Ctjywm8Dav+7N5+Att/9rKbv31/nYX5tzXFFaMRbcceLbU4yrQu74cnLkAfD56iFhO941ETSpc7CnG03EDf+LHq25QCP3+m8jo8EK+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QwFXP7xa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C53B9C43394;
	Sun, 24 Mar 2024 22:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319961;
	bh=yEacVUk4vPPXTEet/MLxzVr9gJMeEgue7ybvIiF3cPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QwFXP7xaFxy0OqIVypzMtO0QmLzEAX7jWBxP4wWh098cJSg1i9/xIKH/CNNJAFYIV
	 4gurepvXVYe07fWoq+4/Pp6vm8/Zcgmc3hZkv2XzT9LixxyLYr+1X7761s3n69vy9J
	 2mzHftJJJFNjGiCbqEh9YSZ/NovSWLfbuNWX+gPw0M+Rxc9uShLgzFCYE242+TFEzc
	 zjv4VV/46bI+7AJRT200/DxE1hx2A7DYlP9Uj7WasWuMfTKaF7a0+I42r26IDMBiWS
	 CXwuZBqDUDZu6BTPheTach3Xrx33ywJdFagWs4dQmxfPw6mGPNBodZ9XHP1qaut80g
	 UObqz6QcWuDlg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: John Keeping <jkeeping@inmusicbrands.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 268/715] regulator: userspace-consumer: add module device table
Date: Sun, 24 Mar 2024 18:27:27 -0400
Message-ID: <20240324223455.1342824-269-sashal@kernel.org>
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

From: John Keeping <jkeeping@inmusicbrands.com>

[ Upstream commit 531a0c0cdbff9cecf41073220a826f8b1132f9ab ]

The userspace consumer can be built as a module but it cannot be
automatically probed as there is no device table to match it up with
device tree nodes.

Add the missing macro so that the module can load automatically.

Fixes: 5c51d4afcf3fd ("regulator: userspace-consumer: Handle regulator-output DT nodes")
Signed-off-by: John Keeping <jkeeping@inmusicbrands.com>
Link: https://msgid.link/r/20240226160554.1453283-1-jkeeping@inmusicbrands.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/regulator/userspace-consumer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/userspace-consumer.c b/drivers/regulator/userspace-consumer.c
index 53d1b9d6f69c5..86a626a4f610a 100644
--- a/drivers/regulator/userspace-consumer.c
+++ b/drivers/regulator/userspace-consumer.c
@@ -208,6 +208,7 @@ static const struct of_device_id regulator_userspace_consumer_of_match[] = {
 	{ .compatible = "regulator-output", },
 	{},
 };
+MODULE_DEVICE_TABLE(of, regulator_userspace_consumer_of_match);
 
 static struct platform_driver regulator_userspace_consumer_driver = {
 	.probe		= regulator_userspace_consumer_probe,
-- 
2.43.0


