Return-Path: <linux-kernel+bounces-113794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7BE8886A2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57B871C25BEC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B2B1F9422;
	Sun, 24 Mar 2024 23:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jm9XH+Be"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0771E4A3D;
	Sun, 24 Mar 2024 22:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320813; cv=none; b=pZE3e/zYSH1e4oodjjwoxIF4dIwnczEhkDxJ0z5k7nUiLAViKBcjR9+YqcI0N9LWjFyKe30TRH26hVCKiGfserZHQ7zKjbvR/viQXxqeukBTrklyXQ23VNUR33PpO2zehSIpN2TDXrHe+8otGSZqF9614v7GOmHIW/YpPGCAddU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320813; c=relaxed/simple;
	bh=hP68GkQ2L6JTHbh2rG6h+rkhITHFGKUHyafkXz2mEaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V10IeFEz77UYva69vqBRb129F6DWQbxGmHheV7gpbV4M23+H89497ZxTg/kI5Wvz7YEpVBm4i7SVuCqLXdz3yRPeLPmTnH9ca7m1GCClw412kxD3mfzDLEb1Dd6BC9jrEHQeT36vGT/dxyLjbjp8Z+TSMJ7ZynhTIeq1QSF2P0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jm9XH+Be; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 013A8C433B1;
	Sun, 24 Mar 2024 22:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320812;
	bh=hP68GkQ2L6JTHbh2rG6h+rkhITHFGKUHyafkXz2mEaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jm9XH+Be06ErztLnCEWyvbkWCIS1oexB4uVpjPsyLr2AQ72PbpV2ykMC3xivq2ypu
	 r1i4sl6D+1SshrBy+qUun1S5gupefshuYp5F5ZkR21+2eCKdNGz21Zs4KfEKQZsIeT
	 SJ6qTnv5G8JoMYWZ0yqzK872EtUvBnZJ6bLuL2WOM0M4WiiJlhzwuISEaaQ6pazUG8
	 ++pbzW4ZsAmvc9DSu2mfaMwISAFb/HGMrLd/7yPYiEO+Dz6ZpeyZj8nlm5xv3AXHxD
	 Tzlh6T6x9SuGezxpYw2y6l8FsQ5NHFOJoBQbePhN0OtQJTGAhIwUBjDTnhf6gkW8Nn
	 z4to8uhyjO/7w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	kernel test robot <lkp@intel.com>,
	Dhruva Gole <d-gole@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 377/713] OPP: debugfs: Fix warning around icc_get_name()
Date: Sun, 24 Mar 2024 18:41:43 -0400
Message-ID: <20240324224720.1345309-378-sashal@kernel.org>
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


