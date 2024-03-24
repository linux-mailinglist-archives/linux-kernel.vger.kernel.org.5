Return-Path: <linux-kernel+bounces-114198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22788888F63
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCF5B1F2AA45
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC73724DBB8;
	Sun, 24 Mar 2024 23:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rEmUqNBc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FF8208961;
	Sun, 24 Mar 2024 23:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321544; cv=none; b=mdY15Nwe8+wUDAdvRzH+xtH2nchWdsIYvKbf7+XBfewT9VnKC5WvctrlwWWJzGV56HjH7WSTUOSFK5Q4NvU1fN52Unxzp17paRZO3T1SrqKiXiVMgvyyxKm+N9CVazsmZt85kUz7yrWprkRkSgJvMSKYHJ1Q5ZIgEqKTLiMTAM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321544; c=relaxed/simple;
	bh=Ta11fKnZobjyFkQcnU/qNvjknrk6rRLtjqxBTTMP/JQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nTU0K7sSWnCOSPAI6x0pV7inTUBpgyKj7XzHSKa4xCidzD8rbfKryJrVpwnhoADXpfsZj1Q15yZFqSYy7Ga8x7i7GPCGaFU/cqsYNyoZ/A4c3n6Eu2VtK5QnUL/Sv1fDKsW/8GnyLkLBnrBop0M8JseJzGmRxiC9vjrj3Bfhfko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rEmUqNBc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6D16C43601;
	Sun, 24 Mar 2024 23:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321543;
	bh=Ta11fKnZobjyFkQcnU/qNvjknrk6rRLtjqxBTTMP/JQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rEmUqNBc5HCwXIYY7LHvDU7ZPPxUuOujHc4hmtGx/iAgtEGGvqe2e0rrGoD6BtKNY
	 2ejP/KgIKhCgrgM3ajzfTta6sY/sayyGO8CTiSNND5PrrrvHUp3LT/uvob0tqcUxnS
	 BxQFzphrNOVDbp9owOTxe/qIBTRGWJie4bpSGDhOrPJLkCp3hqgsRTInEL/VK14T5x
	 YxFYt9q29btTkPOyErsk8OmOw6BkX2aIMpNd7giuYDx2CvIreIpfsWXAn2vaUJIq2M
	 pfz2aIpDCTeBPjSDbZD6tttUJsHqbSwaxZERBI+hF93s6bEuWb4Z2Can+zU/P/b26j
	 3fpBTok+0Y+qA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: John Keeping <jkeeping@inmusicbrands.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 271/638] regulator: userspace-consumer: add module device table
Date: Sun, 24 Mar 2024 18:55:08 -0400
Message-ID: <20240324230116.1348576-272-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index 97f075ed68c95..cb1de24b98626 100644
--- a/drivers/regulator/userspace-consumer.c
+++ b/drivers/regulator/userspace-consumer.c
@@ -210,6 +210,7 @@ static const struct of_device_id regulator_userspace_consumer_of_match[] = {
 	{ .compatible = "regulator-output", },
 	{},
 };
+MODULE_DEVICE_TABLE(of, regulator_userspace_consumer_of_match);
 
 static struct platform_driver regulator_userspace_consumer_driver = {
 	.probe		= regulator_userspace_consumer_probe,
-- 
2.43.0


