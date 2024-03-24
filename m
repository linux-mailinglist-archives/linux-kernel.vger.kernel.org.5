Return-Path: <linux-kernel+bounces-116049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA127889523
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9000C1F304A8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B222745EA;
	Mon, 25 Mar 2024 03:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XGy9oImh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F324E130A6C;
	Sun, 24 Mar 2024 23:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323442; cv=none; b=jlcorT47JeTZL6eoAT11nVURCAduAc3XhOkzcY+dn9vuBHlXx06a6Gy/7XdEHfLjwWfFKvLXnQD48N5BL7qD5SEokUinKH1dm1mvzpw5rAYU/fBX4h6kl5t2ot8arL2tNmgbP5PRRljqlHMt1qkJBknUmxKkNPFuESlgoWyPX3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323442; c=relaxed/simple;
	bh=5om0Sv4UN6dza7Yz0fGHITEjIdk01Rz7bsp3BU26js8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VoAdiZRCdvbrL/aVWSsqOTn6AmhF1VgXzb42DLEkNonRSnqXvjwIjRm+b7cxB8pIWT4AmnLK7RnlAUP2QXdA71Gh9UKMnBi2gYk4kgdSDMMwT1Ef+Uhwbs/42LAfVEJs/le/q+d0sEXD4ZXeUlhdJG+g/MBHFwooLZ5XceevBrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XGy9oImh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F56C433C7;
	Sun, 24 Mar 2024 23:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323440;
	bh=5om0Sv4UN6dza7Yz0fGHITEjIdk01Rz7bsp3BU26js8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XGy9oImhBK9ERg4kjcqcZNqE3qRH8zLwLis2JPrRgNJr+84CgtUij1N+VDgHEwul1
	 edbnZZ9ZCFwz3krX8Z4vxdfMjxz84WFEtKxgsNule9j42CCaJ39KcLB65czxvPuwBs
	 RyyV8bRx6ouWV1zwhGifxRLcIPz5jAXuo7cRsD6uu7M34Ki0v2hTNr7+of4qFpjVWD
	 Ul3EpuLXhL1MkyM7B7mTVZzkZZhwIRkPyoMaa6BxIjrtI1WNVXTUMuAkbrfsRbHA2L
	 2ToMQG7HEm1LJbGlRp0gXn7wHwdHLK4EOuVkbYTEBHKO7sdbuv1Moe3k/PrGldX6ss
	 wtstI7EzMi+BQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	kernel test robot <lkp@intel.com>,
	Dhruva Gole <d-gole@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 143/317] OPP: debugfs: Fix warning around icc_get_name()
Date: Sun, 24 Mar 2024 19:32:03 -0400
Message-ID: <20240324233458.1352854-144-sashal@kernel.org>
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

From: Viresh Kumar <viresh.kumar@linaro.org>

[ Upstream commit 28330ceb953e39880ea77da4895bb902a1244860 ]

If the kernel isn't built with interconnect support, icc_get_name()
returns NULL and we get following warning:

drivers/opp/debugfs.c: In function 'bw_name_read':
drivers/opp/debugfs.c:43:42: error: '%.62s' directive argument is null [-Werror=format-overflow=]
         i = scnprintf(buf, sizeof(buf), "%.62s\n", icc_get_name(path));

Fix it.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202402141313.81ltVF5g-lkp@intel.com/
Fixes: 0430b1d5704b0 ("opp: Expose bandwidth information via debugfs")
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Dhruva Gole <d-gole@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/opp/debugfs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/opp/debugfs.c b/drivers/opp/debugfs.c
index 9eb71f47487b2..1c9d039edb26b 100644
--- a/drivers/opp/debugfs.c
+++ b/drivers/opp/debugfs.c
@@ -37,10 +37,12 @@ static ssize_t bw_name_read(struct file *fp, char __user *userbuf,
 			    size_t count, loff_t *ppos)
 {
 	struct icc_path *path = fp->private_data;
+	const char *name = icc_get_name(path);
 	char buf[64];
-	int i;
+	int i = 0;
 
-	i = scnprintf(buf, sizeof(buf), "%.62s\n", icc_get_name(path));
+	if (name)
+		i = scnprintf(buf, sizeof(buf), "%.62s\n", name);
 
 	return simple_read_from_buffer(userbuf, count, ppos, buf, i);
 }
-- 
2.43.0


