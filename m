Return-Path: <linux-kernel+bounces-113878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 894E3888718
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6CD81C24B84
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FCB20C03D;
	Sun, 24 Mar 2024 23:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iIviwsYN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BE01EBD24;
	Sun, 24 Mar 2024 22:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320931; cv=none; b=cGQ12KTQIS9TQphhHK8DYcfmrLJrmX7uCRtNq/cHsjRfcTS9uGtmjklhooyifGJpC0cZQptGJBk7cj9Kt/MHpjj624+iCmV/EiIpyjmACfiBVwtAThNhH4WTlWtEEc56LgYyCp37ODUb6ZDCo9nFKCoInJUffs8hexVkK/UN1wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320931; c=relaxed/simple;
	bh=IHQKUG65SlounuAeFf6b0YURdCZEgBFW9Po4H7Hhhfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rrSlSVOMyBKCZ/No+kSLE36QBnSCM/3fh98vv3GwdGPkowIKv1iQlAfWlWBfOZADUC3VPLAkURpDSWu+e1J8/bC+jAElZD7o1fOFrUEDxpwc3IBfqkfnF797s1LxYACPr+E3mtQ1nnP87AA78csPJfMmKfKAvwIerK9NB880p/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iIviwsYN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66D82C433F1;
	Sun, 24 Mar 2024 22:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320930;
	bh=IHQKUG65SlounuAeFf6b0YURdCZEgBFW9Po4H7Hhhfs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iIviwsYNEwMhox4MCe/mF+8Ak8hFm2C504XIKtNZC/Aub61cX+ImGHe3xyTypm+55
	 BezEo6c4ZiZm+fQ5EU8VlvkQncCmJ0Ude/JNHELaHBx7c2Cscs9uSJ6Q4Y/cHuNMpi
	 DgfUqFJX8++gKMbmVi08cJF+Is713QNjR9+5z+QhZYfM+RQ4Fr4PqaDVDV+UdPWk+Q
	 anEU486EUZMlhxLThOCkcwct3Cwxj/z451TXP2Ledi+REdc87w13bKQ3DHKMuEkt7p
	 eNP37zUJALxJBgLGHjWufNHz2fDJhKS2t9YrsZbn1RTQULGkejm60euavLRufc2Cks
	 hjUtKnIaxHlmA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Griffin <peter.griffin@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 494/713] mfd: altera-sysmgr: Call of_node_put() only when of_parse_phandle() takes a ref
Date: Sun, 24 Mar 2024 18:43:40 -0400
Message-ID: <20240324224720.1345309-495-sashal@kernel.org>
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

From: Peter Griffin <peter.griffin@linaro.org>

[ Upstream commit e28c28a34ee9fa2ea671a20e5e7064e6220d55e7 ]

of_parse_phandle() returns a device_node with refcount incremented, which
the callee needs to call of_node_put() on when done. We should only call
of_node_put() when the property argument is provided though as otherwise
nothing has taken a reference on the node.

Fixes: f36e789a1f8d ("mfd: altera-sysmgr: Add SOCFPGA System Manager")
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Link: https://lore.kernel.org/r/20240220115012.471689-4-peter.griffin@linaro.org
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/altera-sysmgr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/altera-sysmgr.c b/drivers/mfd/altera-sysmgr.c
index 0e52bd2ebd74b..fb5f988e61f37 100644
--- a/drivers/mfd/altera-sysmgr.c
+++ b/drivers/mfd/altera-sysmgr.c
@@ -109,7 +109,9 @@ struct regmap *altr_sysmgr_regmap_lookup_by_phandle(struct device_node *np,
 
 	dev = driver_find_device_by_of_node(&altr_sysmgr_driver.driver,
 					    (void *)sysmgr_np);
-	of_node_put(sysmgr_np);
+	if (property)
+		of_node_put(sysmgr_np);
+
 	if (!dev)
 		return ERR_PTR(-EPROBE_DEFER);
 
-- 
2.43.0


