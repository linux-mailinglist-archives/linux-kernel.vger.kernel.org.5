Return-Path: <linux-kernel+bounces-124511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B88489191C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CA571C2471E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4757B142E9F;
	Fri, 29 Mar 2024 12:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZXTj7cV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773F4142E79;
	Fri, 29 Mar 2024 12:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715271; cv=none; b=toc9EbJIi7C/6AidwPfOaysuV9SmSWertNiRNN6DtioAWKlPHQP7dIteDK2Ub27uW+Plbjw1AP58q9HPJuW/O38txwpP2UMqpoDhpXYb1SOtP4B9w9qxte0WaLnutasg+v+g4GvUuUBksq8VUcaS5FsC6nstSVtUlmwjsbYOIGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715271; c=relaxed/simple;
	bh=yEd0TIh/lRZcOAMIPybsRJxzmRYTgRG5NAGV2GK4dAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gZgPSYyteRKoPoDwaMOtllQj3VjS+gVQIhobP9aRuhxzsSHFLc8fZeOTarvBZTsFdpWVngOOix43riYnCSirFpbVcpHlSzLyVdXc1jVyEbLHx+iMi2Bw169Z+I3z+hk8oMilH+o/VEo92UD+NNrcQZqaITQIkXQD6dvG/C5BlPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZXTj7cV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78284C433A6;
	Fri, 29 Mar 2024 12:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715271;
	bh=yEd0TIh/lRZcOAMIPybsRJxzmRYTgRG5NAGV2GK4dAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PZXTj7cVN4NeKlDLwXhXb7mfKOjSMSJjwnT/+HQLyv1PC3jxWvXYtUWCwz01x2x/H
	 4i7LOKXdyAb7rhEiZeoviYVfoFwNqlfEE5NxN9TeUrW9GM1fvK4DonHQqptoweCfzV
	 OxXclXw7R+XQTX3AQxhJ6f7krta7hbA6fWsJAaTd2Dtp7udvtRchAP7BvkjprBOc1a
	 S6v0dXtWAoETDMbkJiXBXl+2cpdOBpiEf3BzXJDeS0IY6sT/ybK6GQ9ZyxENHeuTuy
	 oXJQO9RuNwbzyMe1EYvQSr99tXuru4dkNuJonXIm4XY+GhSiT+/Pju8HJrmd9RnnGi
	 5HwbUM7rj4ZzA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kunwu Chan <chentao@kylinos.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	nm@ti.com,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 30/68] pmdomain: ti: Add a null pointer check to the omap_prm_domain_init
Date: Fri, 29 Mar 2024 08:25:26 -0400
Message-ID: <20240329122652.3082296-30-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329122652.3082296-1-sashal@kernel.org>
References: <20240329122652.3082296-1-sashal@kernel.org>
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


