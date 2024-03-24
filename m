Return-Path: <linux-kernel+bounces-116225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73707889DA4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 139FC1F369C3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B2C291B73;
	Mon, 25 Mar 2024 03:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZXsab4lX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6AC131BBD;
	Sun, 24 Mar 2024 23:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323860; cv=none; b=RVr5AiU1Eq1WrDgzCPcJpj/3MbtIgvWmH3LOKlZ4BYovkAkCXSuSPyqamcisv5/QfRcI1kF5rlNxtpbqRMWgKU6onUcdghw4T6LRm/eNitx2RD+hZBM/vXtkFOTIIId1JdtoXJGTBSnRQfMinCb6DaN+5Pi/4fJ0/q87h6rd5RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323860; c=relaxed/simple;
	bh=5VQaZ7OnaaW+qUx+jzwOvmGzQYVd+zAXX4Becu7Jxdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b6dgKRN2HYIXYM4FgR/8CRiHQqpgOzmQkpCt+6fTqHmztHTWqQygeQIL3DIUaCpEzRPV1VGvk3QDzoE90Ohta50hSznCvyCcdpaVCERoOyrvZjmIcL/q3sJ8iUsmyR8kOZREnHrXL6nEAmAZCBTz+TWpXbICgSTcaIQMx3mfksU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZXsab4lX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B72CC43330;
	Sun, 24 Mar 2024 23:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323859;
	bh=5VQaZ7OnaaW+qUx+jzwOvmGzQYVd+zAXX4Becu7Jxdw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZXsab4lXZad0IX3gC+1oZcneakmm3zbZHfE9MqqaQokh+LvG0wcGCxQhZj/Es1u0P
	 z/g53cD1YHcSyvRGK0RsrHFliPVyeysixnKC5DYgYFgaHP9fIczRR063tVvk3P0kik
	 nZRZSA46ooJUfYdFYHzqX6l0erKvLwCpwcEFlOCuvIW/5Tgs17VdhfnQSFsrco4IPK
	 J0rP+wspa8WlF++vOThwEgVWIRiMWn2WCJzfbyLW6jeshTM0cDSeCCIAjfPzBVBlLA
	 GC3rHfH+B7u4qowv175Aeq4D4xdt5e1ROViAqrgnWioyX9vc2hbXUZ7FvqPYQO2Mav
	 ijv1TTvxYn6mw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 237/238] regmap: Add missing map->bus check
Date: Sun, 24 Mar 2024 19:40:25 -0400
Message-ID: <20240324234027.1354210-238-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Marek Vasut <marex@denx.de>

[ Upstream commit 5c422f0b970d287efa864b8390a02face404db5d ]

The map->bus can be NULL here, add the missing NULL pointer check.

Fixes: d77e745613680 ("regmap: Add bulk read/write callbacks into regmap_config")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org
Link: https://lore.kernel.org/r/20220509003035.225272-1-marex@denx.de
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/regmap/regmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 2dfd6aa600450..a3c4086603a60 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1796,7 +1796,7 @@ static int _regmap_raw_write_impl(struct regmap *map, unsigned int reg,
 				 map->format.reg_bytes +
 				 map->format.pad_bytes +
 				 val_len);
-	else if (map->bus->gather_write)
+	else if (map->bus && map->bus->gather_write)
 		ret = map->bus->gather_write(map->bus_context, map->work_buf,
 					     map->format.reg_bytes +
 					     map->format.pad_bytes,
-- 
2.43.0


