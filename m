Return-Path: <linux-kernel+bounces-139028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7F489FDA5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73DAE2831F2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8CD17BB08;
	Wed, 10 Apr 2024 17:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/nKmqow"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAAB17BB13
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 17:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712768575; cv=none; b=aZxUeO5YI0DR1v3+ajrWr6CtaDi2NgMArxvKFBSu8ZsrpbbOXmuMK10Z9PK1wqioJFgT+He9sFdloY7hDHsO9IEla+yK+eAOoErpz2EAm5eVwdhvvDGAI4WYeEUSdg1vpKfQwjj16klhC2pGFuPuORx65kxMzlnLyycujRNIsjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712768575; c=relaxed/simple;
	bh=rjF1Pdc/BJy0/UEE1biPbPNCWphTBBh7owEWC6+TaEc=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=c80IkCDD7qkasGlkdfmieJPZ9/X9tdYErCAGegT0YiA3w4a3uTjp3i91U38z7lZPZRxkmh7FceERIgxxln5DWhp+j76W/5ONSBQkQv4i1F3HrzEKksgOI8TkBsXLboqzkxTm975jor7inbOThfDGcLwtzlgNn+BnwCrVgv3Y5Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/nKmqow; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCD8BC433C7;
	Wed, 10 Apr 2024 17:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712768575;
	bh=rjF1Pdc/BJy0/UEE1biPbPNCWphTBBh7owEWC6+TaEc=;
	h=From:To:Subject:Date:From;
	b=L/nKmqowWG/NAgbnXvfppxvuU0tDAeNPJqDqoZkSV4A95+NYWGdfgUysKuzn3u6pW
	 KafKKSOobxnWtmUYi+LgmCaPkdnt4wwrABwdY/bv/Mif4SMYhnJtOm9auPsNttKQ8h
	 bme64wWKpFv1pdEmdHARBHAfVz1H2P/Dd3JSsqd1/1+BmVU9IeXdPu8twZpBfEkIH+
	 n/VUWkcAIlc2nYuaPmx37evT3ki/yEXx6TIXf8G/MFGh1SCumjPh0VuATaYb6jAjGT
	 qEpwhHIlS94ZynIa7GEyYcpNBN5HqKskWCAQ5EjLLr7mNsBInIpfZ9Gptv3MsojEWH
	 yfLIT0y068A2g==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] memory: brcmstb_memc: fix module autoloading
Date: Wed, 10 Apr 2024 19:02:41 +0200
Message-Id: <20240410170241.248626-1-krzk@kernel.org>
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
 drivers/memory/brcmstb_memc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/memory/brcmstb_memc.c b/drivers/memory/brcmstb_memc.c
index ea9213f7152e..4f17a93aa028 100644
--- a/drivers/memory/brcmstb_memc.c
+++ b/drivers/memory/brcmstb_memc.c
@@ -243,6 +243,7 @@ static const struct of_device_id brcmstb_memc_of_match[] = {
 	},
 	{}
 };
+MODULE_DEVICE_TABLE(of, brcmstb_memc_of_match);
 
 static int brcmstb_memc_suspend(struct device *dev)
 {
-- 
2.34.1


