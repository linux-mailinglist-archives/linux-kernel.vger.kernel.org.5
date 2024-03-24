Return-Path: <linux-kernel+bounces-116109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C45D58895A6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BC64B34C05
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE34181D04;
	Mon, 25 Mar 2024 03:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nIejtj2H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFB6179943;
	Sun, 24 Mar 2024 23:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323611; cv=none; b=XGVVjgRRjcrNKzO0Czf3aRQ0C9OkLhFhIYd+u2umcPG59oSYp7u8hmy5X502RdTe2WxJukrgtOWQv/M8XgXZGSZKa7xRZehcBWN9Suz7ZnEkl1Ve/e+pPjXtDmNCyEmzWYEKxsb84ofO44XMSzXGEGfAji/5el+uHTNKeRH30iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323611; c=relaxed/simple;
	bh=N9J+Q87Gpl6PopGY52TYfWuXItc8bHDolFg3pSYC4uA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=inT4Yw9coeBbtDxnN1LwoodY2zzF6vUB6SNYeShbsdeQA7+O6zXq+sfcKUGa41kT7jt8tedP8TmsvrV0r7hIGsvhwKUatV7R8Ka5Xc/0kHQFdlpQS8C2fz1Rae84x53xfZn1IvKeCQhkmGEWZ0kaDcG2yGoBuJQYvs64dc3IiZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nIejtj2H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C9A9C43394;
	Sun, 24 Mar 2024 23:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323609;
	bh=N9J+Q87Gpl6PopGY52TYfWuXItc8bHDolFg3pSYC4uA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nIejtj2HxIOzRyS2XObCvb4sku/uec0wHOtXq4fGuXjeFqMdS2E2EbMq6GeDyTt4V
	 4qy7XgTfWFv7NCTGdgfZYL5sQwy+EtfqAmL1hsz00JbL7lvX8+AG6WVaHwb9TKOEu2
	 /MvVBfcvkZ81EJydFxS3ea+ar+dPVfO7bMnSj4m562WrXGcbnLn9dNebinmQdXkSTh
	 jfYVxl31hLxLsXfQAnP8QIu41iIm2QnwKcRVMwAsyIwPwWSWq+0YKh2hoXXmp1w6ab
	 viYVUMt9REXhP8EP1/dZpmpMTES3yYvHKaJp+EBu/TivophXyYI71GWYpmCxT6JzJR
	 VyaOYMIdK1/RQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 316/317] regmap: Add missing map->bus check
Date: Sun, 24 Mar 2024 19:34:56 -0400
Message-ID: <20240324233458.1352854-317-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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
index 6adb345866610..893b0615935e9 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1836,7 +1836,7 @@ static int _regmap_raw_write_impl(struct regmap *map, unsigned int reg,
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


