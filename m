Return-Path: <linux-kernel+bounces-124832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF6D891CF2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 826981F26111
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEED81B6742;
	Fri, 29 Mar 2024 12:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="porQ4QwY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90FE1B5DCC;
	Fri, 29 Mar 2024 12:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716254; cv=none; b=H/rdUTA5Y/bBaaaGdNthAEJd+jYPO7vGrSUtpCfMvAxi9ADf9I+b74/ZFq3EvezmbEsRGtLMuFgVMB+VOjLFrxMmUYUugGJExlLSic3c5EZfwqZUWv6NMXhyYo3FRFiOcpYznySJmd2f124kzvGMnn2N0HNzfSfm3ZMwX66yaaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716254; c=relaxed/simple;
	bh=yEd0TIh/lRZcOAMIPybsRJxzmRYTgRG5NAGV2GK4dAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T+P5WBNLsKn1i/C29xc299fCXzQEliTbBdei1xxVVzUVNhmSle2E4P1k2acE9Vt3KLJhpf/7YUmoGL4VPG2vZd0Y3TxoJNkJTEVMRXsDIEh2/A7oczlquqyMeO5Ip2CjtqvYrL6SUlBiLdX37VId6NbdqR92/n+Fzuo/iWJwsMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=porQ4QwY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FE2DC433B2;
	Fri, 29 Mar 2024 12:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716253;
	bh=yEd0TIh/lRZcOAMIPybsRJxzmRYTgRG5NAGV2GK4dAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=porQ4QwYEAWtWs7THmyABLVeICWdo4nooftQCppgnkRNacFVqBNUf8JViq+yt/B5a
	 VOvbzi+mfXd+nTfgZkzLpMPtp/GVu/usGRZHGj0ifWNBVOPD6qNqFa19KIbOevGXwK
	 sFsojl4FcywGl1bwFkvNmhDhz1rHcf18te+TJ6I85VKhgW9ClIuwLCs1SFh4N86dPh
	 0x7XmBQuKKW6Xl+7Po6t/bmzkvxrZAX8j08U9KbJDD5dsobnKws5pWiuruYshP8nPz
	 lZr16UFvCBvh7WT6jVD5wY/qJ5LPkEtGd9JydqipMBmgofdzOQUP0jkpkqRBei2z6E
	 4nsBqs4H10FXQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kunwu Chan <chentao@kylinos.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	nm@ti.com,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 23/75] pmdomain: ti: Add a null pointer check to the omap_prm_domain_init
Date: Fri, 29 Mar 2024 08:42:04 -0400
Message-ID: <20240329124330.3089520-23-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124330.3089520-1-sashal@kernel.org>
References: <20240329124330.3089520-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.23
Content-Transfer-Encoding: 8bit

From: Kunwu Chan <chentao@kylinos.cn>

[ Upstream commit 5d7f58ee08434a33340f75ac7ac5071eea9673b3 ]

devm_kasprintf() returns a pointer to dynamically allocated memory
which can be NULL upon failure. Ensure the allocation was successful
by checking the pointer validity.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
Link: https://lore.kernel.org/r/20240118054257.200814-1-chentao@kylinos.cn
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pmdomain/ti/omap_prm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pmdomain/ti/omap_prm.c b/drivers/pmdomain/ti/omap_prm.c
index c2feae3a634ca..b8ceb3c2b81c2 100644
--- a/drivers/pmdomain/ti/omap_prm.c
+++ b/drivers/pmdomain/ti/omap_prm.c
@@ -695,6 +695,8 @@ static int omap_prm_domain_init(struct device *dev, struct omap_prm *prm)
 	data = prm->data;
 	name = devm_kasprintf(dev, GFP_KERNEL, "prm_%s",
 			      data->name);
+	if (!name)
+		return -ENOMEM;
 
 	prmd->dev = dev;
 	prmd->prm = prm;
-- 
2.43.0


