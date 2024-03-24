Return-Path: <linux-kernel+bounces-114251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF30888962
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F38D1C27E72
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DD3152527;
	Sun, 24 Mar 2024 23:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jk9BT6so"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F4320AF65;
	Sun, 24 Mar 2024 23:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321604; cv=none; b=qNAKBgcLT9NAPhMt7M7eB+H63G1iqDjV0bDiuxuXnjWlgn5j2A58xxpx8XHHshq1vPjFXjVGOY2rmFSP2Lkj2UYCv8Wq0unYaqhhKIAZbKimOqZWYu+nz2fPJSssL9PUL/udKOINyNAdB4P+1hQH3Ip7ySSzVy8eK4oh3vJzQaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321604; c=relaxed/simple;
	bh=Bf9m2+7A8COOO48NlNPXdpwFsMPV5/s8wTbqPVJavGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IxuDpt81CcGBa0J8OqRu6qi3m6eskozTwt9lC/EC3ZXSCm0cyH2v21Ud+eBvLTss1zFQMw3jnAPEn74T5oFdIfIyKssbM0PLy4ByKnLRW2VahsiMwNFkZ7vJzz9gK12UY0CgAuNJ6e6RK8xiv//Qgsh7GMPbDNEMAt1izhySQdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jk9BT6so; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1088DC433F1;
	Sun, 24 Mar 2024 23:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321602;
	bh=Bf9m2+7A8COOO48NlNPXdpwFsMPV5/s8wTbqPVJavGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jk9BT6so4JQptHHoQzaX3BmN5zaTfkU3NIh5ySeGwgw9hjQofPHC8JZakATL5O5+r
	 i95IVIs39WPcLUOQjvhzpEBk7crNlN0B5jErG/h59+PfWCNyKaM7TsUR6xeTe2aa+J
	 WjU44MxlGsa25YzyQi00T6/zAt6SI3K4ehhAlc+X8c3QsXhOXs+nP6lsvaYdHhjccA
	 HYidnMgJy73FnMu6gpXEN/9GumN+WK7eT+XX4KoZExbG1lpJNl58fijY/s8RFI6cOI
	 gjpscb0UprRkenzZmCd/aFYr8jM7jR9aWjrkQe3TbyBWZk4TldQFnkmc7Ylz5iG280
	 KI2BWh0Pu2r7g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	kernel test robot <lkp@intel.com>,
	Dhruva Gole <d-gole@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 332/638] OPP: debugfs: Fix warning around icc_get_name()
Date: Sun, 24 Mar 2024 18:56:09 -0400
Message-ID: <20240324230116.1348576-333-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index 17543c0aa5b68..83f591e40cdfc 100644
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


