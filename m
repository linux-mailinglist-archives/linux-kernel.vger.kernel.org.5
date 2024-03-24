Return-Path: <linux-kernel+bounces-113748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B50AB888663
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 541B31F24EFD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9429A1EE6B6;
	Sun, 24 Mar 2024 22:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HmIZSVsD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E4B1442F7;
	Sun, 24 Mar 2024 22:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320753; cv=none; b=iAdCANCv9TLYUvDLmww0jz1Hrr4q/N/ZNNE5xaiT0Agez5LrpLqlTZ45lJSMTTutJU1grAiu3fk7byVFbAhJiJ9ueYJf005UnWG9+pUklaTAQ8NFWxjlrbvudGob2VIwaGURnFDqPfnViB7mJ/srj0BsJtu9FvaHUrSAPD79hmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320753; c=relaxed/simple;
	bh=Ta11fKnZobjyFkQcnU/qNvjknrk6rRLtjqxBTTMP/JQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nFVmi75Tw0sz7vRl+PZoGE0Rmu89J53U7W8NXTLkWI4gUUJTyU5pKSOGpbq929JjXKwLho2e1oIrbMDYqhlK7ngW5LJHDkQSUT8Ksvq4OXmpgMmbzLXrYb0SsWt5dxj1a7P6fJcKmCNqQUnMr1uFczzfJXJp9rbQ6UAHgsfq6ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HmIZSVsD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC9EEC433F1;
	Sun, 24 Mar 2024 22:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320752;
	bh=Ta11fKnZobjyFkQcnU/qNvjknrk6rRLtjqxBTTMP/JQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HmIZSVsD0qGMKraMeuLJBlOQ9pyX/2l+5A808AlOsUPLgNFxkn9uAhHMJlvS88A1N
	 0VzNIn6+3M9ftnuyqjYR19+7TNTQiUG0sZ8VDlfl7q0CdK3Ka0R2/a6LhC1uC0RfRp
	 wwA8TDJxKVEONfjbBvp4wUYfSLQSzEHh6fH9osmi7SOeKKavBF0+WXqF/4ueZQRCbc
	 DPAOIhgVFX8wiJF0AOezbLB6oX4sEUCirUJXVNvi7k4BkxTBfU7H9u1pl9T6a/YSUD
	 +vSrb0nKHTUfBnn1hbgg7t3mRqfq81ykfx+GPT8pZ4YqQqsado/qJVthaCYk03Orlb
	 4mBfoiklwuipw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: John Keeping <jkeeping@inmusicbrands.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 316/713] regulator: userspace-consumer: add module device table
Date: Sun, 24 Mar 2024 18:40:42 -0400
Message-ID: <20240324224720.1345309-317-sashal@kernel.org>
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


