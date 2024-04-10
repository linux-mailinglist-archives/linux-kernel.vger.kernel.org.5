Return-Path: <linux-kernel+bounces-139095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C95A189FE75
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8447828BF28
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C07017BB20;
	Wed, 10 Apr 2024 17:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BroaiQuG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3ACA1779B4
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 17:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712770006; cv=none; b=V8sMtboNVBfvjoYgSmJwCE0RDoawMjZ+NKWkqCNulQ8Ma4yhc4YkTRCkvOCwEp3i+ZcEmtF4kEZ7FwyZR+fYISQPhLn/EahJlLI316mZeLhst2HBrGoOwg4FUWCHifl7um4YtZcPANw6dVWu8AdDy59yoR0FfTMfSnLWUGLdtLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712770006; c=relaxed/simple;
	bh=R0n3j7OnPtNSyIvSk/8MuEg1n88B8Mr80znTJaxrJwU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oM8z9h0LRjbrldkuFORTIqmraLb1yKku/ALPvNQ8asoZ6IOQFB149xC7ovUOlIqvPvPMnKypS5FkayJUKbyw2KOlf14QjbtnSPumHm8320csUgGap0ThV12vY1tErVRzOsuWC2WZgQTmJemLUmyg8kAGNBjHKhE+fh+vCL9tkfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BroaiQuG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 192A6C433F1;
	Wed, 10 Apr 2024 17:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712770006;
	bh=R0n3j7OnPtNSyIvSk/8MuEg1n88B8Mr80znTJaxrJwU=;
	h=From:To:Cc:Subject:Date:From;
	b=BroaiQuGhiF8Hj9Tij7uHm5rrLsbqr5N2/J2F/pZ1TvW52QPEAucglbGE0K+3aDHg
	 Ppa5Lv105PIvAJ9KXm9o+iyPha+vDeaO4w6T8FyA0BwfYSLtX540yVt/O87HIfm3Ob
	 GsPTLn+CoDAYlSbkMK9MjeFqBE9z/7u6DgMd4VrtRBYlo2V/1xCfaZoBIotGI1xeQF
	 37Keh5iBMQ+pkoDycIjbxa7GVpChGtumCwQaZ8BbiBft3ZvNCGkRdxLusxPGtTxXoH
	 BscFBG/Ne4wkGplLHtWaxmTNsNObG8ReLZ/A7GDpsrGyz4dwo9zusYz/pHbT2UHm2B
	 5IwlG7p4/EjNw==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 1/2] nvmem: sc27xx: fix module autoloading
Date: Wed, 10 Apr 2024 19:26:33 +0200
Message-Id: <20240410172634.255480-1-krzk@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add MODULE_DEVICE_TABLE(), so the module could be properly autoloaded
based on the alias from of_device_id table.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/nvmem/sc27xx-efuse.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvmem/sc27xx-efuse.c b/drivers/nvmem/sc27xx-efuse.c
index bff27011f4ff..4e2ffefac96c 100644
--- a/drivers/nvmem/sc27xx-efuse.c
+++ b/drivers/nvmem/sc27xx-efuse.c
@@ -262,6 +262,7 @@ static const struct of_device_id sc27xx_efuse_of_match[] = {
 	{ .compatible = "sprd,sc2730-efuse", .data = &sc2730_edata},
 	{ }
 };
+MODULE_DEVICE_TABLE(of, sc27xx_efuse_of_match);
 
 static struct platform_driver sc27xx_efuse_driver = {
 	.probe = sc27xx_efuse_probe,
-- 
2.34.1


