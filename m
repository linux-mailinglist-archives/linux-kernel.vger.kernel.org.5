Return-Path: <linux-kernel+bounces-124743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FFA891C08
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D68B2842C9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8D117A931;
	Fri, 29 Mar 2024 12:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jLylTHJ2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5890617A91E;
	Fri, 29 Mar 2024 12:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716063; cv=none; b=I8+2obs9tYZYSy6i56U9wdgAu3LLM7Clt9FSg7o5IN3s9/cU1rHVl5udPUipMNcBVTAlNw36iMDDLWy9S5AgvheMIMbrZH09/c22xMWbIXMpdUo0T/cOb88mEh1xQTEat5MiXER2TU89NgY89TUF3RD3hTo1NleW7TSVWiNHuno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716063; c=relaxed/simple;
	bh=yEd0TIh/lRZcOAMIPybsRJxzmRYTgRG5NAGV2GK4dAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rSwwGDdv6onkBigZyrSkbrNyNmBkPtmgF2V2YGxeu8KdyPw+Vx1N+FXC28vn5BRebdg6z/GZaUXj43vd+VGEtFChJhgI5UN7cihPc9xOx0h2woX1QaMyPuBccBomgdYk4oAJwnQ7toCYnsmHROneAopipPbZdPSgVNHal9WIB/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jLylTHJ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05DC8C433F1;
	Fri, 29 Mar 2024 12:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716062;
	bh=yEd0TIh/lRZcOAMIPybsRJxzmRYTgRG5NAGV2GK4dAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jLylTHJ2s/+I9PFxdsiKBpPOwiJbWAhC5u8lhCgPSOI6KOKaZMBHXD/hfSB+HJrNs
	 QfE4s/1xJNiu4bcOdsq9t1uN6CH19/JOilG1JXKg0zhba3U6lSyptEqZw3llLBKJY7
	 FU474TEnkU5KMHT7fPP2AGHt6hVzxJ43UV6Q44TJz4Sdq5kjwyI+9xhfyrDQ3Kt3NN
	 9BK0BmCxF1SegTsMFO32A+XcYDsYuQZnVxh9cnnIQqxNf/85dDTzCTgSWO4ONRP+o3
	 yIjzodo2oSoSy2+XRy7b9B0CeGafRw+U4964FvTkLSbOBYiXfK5Bjue1eaG2fjD4gN
	 g76XaKttE7K9Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kunwu Chan <chentao@kylinos.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	nm@ti.com,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 34/98] pmdomain: ti: Add a null pointer check to the omap_prm_domain_init
Date: Fri, 29 Mar 2024 08:37:05 -0400
Message-ID: <20240329123919.3087149-34-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123919.3087149-1-sashal@kernel.org>
References: <20240329123919.3087149-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
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


