Return-Path: <linux-kernel+bounces-124571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5923891A15
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C8F81C25316
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41501552E3;
	Fri, 29 Mar 2024 12:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zaju6J5F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F2212FF8C;
	Fri, 29 Mar 2024 12:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715433; cv=none; b=TMC57yTeyfT4nJYG+3UH7U71wzOK8iJQuXCh9bPJRIhz27FaDmMLIJ2i98265m/09T2nmI+FIqSMZRZTvkOy67qIeEEUOlcpb9Q+WmMjBYNd5LKTj5FFnYtKXK4/5wc2B9iAT8WQu38okFBNwtyJODv/9/7mi5O0RJpQclrEd+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715433; c=relaxed/simple;
	bh=yEd0TIh/lRZcOAMIPybsRJxzmRYTgRG5NAGV2GK4dAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q4ZpVoiDbHihNnx6msvPYw4zQ0wm/OX8CTJbJOQq0hxPvbrGjZBNmp7wSm4BMVWnR15GFfVWf3s3DszxasKQte9Aze61OfurrZW0Cwr8gvBDtcc97kxoql5GhLcRsZn5ytE0LeNEMr4drrmjfan4tcHX23wCWAtmC/TlX881z+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zaju6J5F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67E0EC433B1;
	Fri, 29 Mar 2024 12:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715433;
	bh=yEd0TIh/lRZcOAMIPybsRJxzmRYTgRG5NAGV2GK4dAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zaju6J5FMtT/Dj2yR4S5oqNFvQs3xkRs/MIShE9Pht8R8U9c2C+q26sjXpRNoC/yY
	 bK3iHaRakXo5AjOmVlo/lf7mYb14rxIFAsVI3UamPLZImW761sa7JvrL3QbqRDrF7h
	 hA0NucgLm51qem8sj4VSo5axD/g9EmYdCb7p35Tt1JcCrngD3meQbF4nfg9ixV3Vzo
	 crDsUJuD5fEc1rESzkXUhnl7pQgwa51lPDNWbqLRrybZHxJm8Alq0VjeEP3oe5ruPc
	 zCk2FW2ToR81x/wNCW3QLV3MB7iy7tSnjFkz7+yiB1MiORBNDlI1qwv1AZU5R4Va8D
	 +FpgY+Sd/XUkg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kunwu Chan <chentao@kylinos.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	nm@ti.com,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 20/52] pmdomain: ti: Add a null pointer check to the omap_prm_domain_init
Date: Fri, 29 Mar 2024 08:28:50 -0400
Message-ID: <20240329122956.3083859-20-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329122956.3083859-1-sashal@kernel.org>
References: <20240329122956.3083859-1-sashal@kernel.org>
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


