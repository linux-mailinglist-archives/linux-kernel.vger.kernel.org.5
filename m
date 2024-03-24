Return-Path: <linux-kernel+bounces-114986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EEB888C60
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBA091F28DD3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4F217AF9B;
	Mon, 25 Mar 2024 00:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DzpW7mxr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BE817B519;
	Sun, 24 Mar 2024 23:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323727; cv=none; b=dYFYCJPBXcns4gn8CslKmUBzpwivohUraMMxxxprfxQGLPti3XFyvICPnVnEPbyaaNvhjXa40uMgYdNFLDWZI5UMT0Gfb0RQlOtfrmE85C3jYUNsmj+tNEIXH+vo96XtNOIORQtf+qkrddXzzu7WRTOuilEoXcG78dV9g+mjhmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323727; c=relaxed/simple;
	bh=FU8bOYJOpA7z5HZUBn8V79nlonCFP1MChAiD587xR18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ArCZGgWRnS5h0CYhpyWoxt0joBX3I/GejCwzt+31KcneP4REJLFXjxL0UQQnGcXi8RYgPRDEYyZvOMv/yuTB0WT5UJ1Q1AisTzbi9fmX7J7gxiTe6IL70ZK5VCR1RZFKKZAylZIOtx/44Top8/OEeWZZAfNvs73zj32LyKiU0Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DzpW7mxr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 573A4C433C7;
	Sun, 24 Mar 2024 23:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323726;
	bh=FU8bOYJOpA7z5HZUBn8V79nlonCFP1MChAiD587xR18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DzpW7mxrH+GLwsfSeFj+kW9LBbzI2zpw//kPq5gGrBAWVMHLstju8CdLd1zaRojPH
	 jq+xBt8LCP3vaG5BytdyibwPOVJDIZLr3l5judsz/88QHmmGtPpElkgl3UE0zajW+9
	 zTb6C1eJZcK9oykD8W0tzUmc/70y+MmGbtzRaoFeg7dMSJ+9AIedee97b2UTua3XxS
	 VnlTyfYBIRMBRmapWbPRVupi4lKPLbLY/MPRMs51brmqZzKT6R9cGSnulFbXGvF30t
	 5UyW2zzG4fVpg3ckQDTz6wX6CKwOLXhfgEPxgS5qgZob56kkwyxOPvxihPa94cW8oB
	 P+gAGxHY29lfg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	kernel test robot <lkp@intel.com>,
	Dhruva Gole <d-gole@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 099/238] OPP: debugfs: Fix warning around icc_get_name()
Date: Sun, 24 Mar 2024 19:38:07 -0400
Message-ID: <20240324234027.1354210-100-sashal@kernel.org>
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
index 60f4ff8e044d1..016dea5a412be 100644
--- a/drivers/opp/debugfs.c
+++ b/drivers/opp/debugfs.c
@@ -36,10 +36,12 @@ static ssize_t bw_name_read(struct file *fp, char __user *userbuf,
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


