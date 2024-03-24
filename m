Return-Path: <linux-kernel+bounces-113227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE46888278
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4F26B22750
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3CF182744;
	Sun, 24 Mar 2024 22:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WtuT8brS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E664182768;
	Sun, 24 Mar 2024 22:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320028; cv=none; b=i6MP9/81csjueVAQafHJN0kMGe2RQ79/WZ/vfytRIfDuZU2rN9ZVy3glXB3YDxXH0Sfk4/CUIea0dU8LYPv2LF/UjUs0SRip0ZVJHEsgIqPpWEdB/qjxKtNxf3mncUKUk8PHvvHl3sU6CG3Ph64HZL9zjwqv85TT5ho3+A2skFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320028; c=relaxed/simple;
	bh=hP68GkQ2L6JTHbh2rG6h+rkhITHFGKUHyafkXz2mEaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AEpvVBndloeOcQbYVMECZnpBMhfb6TzlTeEYcy9PADeMeWdNpnyMZ1n4l8jHEDowJSWcNjo5qADtnLxeBICyarqpJFKqhkkEp2ZAb7k8imbcZqFKgYsg5mKlycvdqlolaxbS6zbAeLzYrAvYNrk794CYurE7U0skNSc6rgIkg+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WtuT8brS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88274C433F1;
	Sun, 24 Mar 2024 22:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320028;
	bh=hP68GkQ2L6JTHbh2rG6h+rkhITHFGKUHyafkXz2mEaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WtuT8brSgOw50Z2ohzKv7FMKLWkuPAAWt1MPOE1d62hH85u7eTzXvayuZ0vjRRafa
	 p9pkaoQeC/Y22t5JBGmYDiKAcj/lq/9vjgMv3bzLb3iWP1Gm/xqjz/pX5jko05ETtx
	 I57vTiWb2FJ5FYhw7vLjRUp9wJIi1WXmQUobhE7Lzf3FVEfxyWCyxp0qveZhDxRUsf
	 Tow6N9k2FotDTWalBNbBk77kp1K/YjjLHaNpaUgdIFJkwYJrhHjFXMqm74ZxF4xKiY
	 jdZFuwuP3yhhj2VykHgrXvidSB9bUWDUqeJqKy35RVfBIB9c8QLKE/+/XHl6mLybqi
	 lPT3DXtiZ/zkA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	kernel test robot <lkp@intel.com>,
	Dhruva Gole <d-gole@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 336/715] OPP: debugfs: Fix warning around icc_get_name()
Date: Sun, 24 Mar 2024 18:28:35 -0400
Message-ID: <20240324223455.1342824-337-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index ec030b19164a3..f157fb50be50c 100644
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


