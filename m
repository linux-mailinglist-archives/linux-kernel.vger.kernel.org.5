Return-Path: <linux-kernel+bounces-114521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B19C889040
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AA2A1C2C267
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A20182766;
	Sun, 24 Mar 2024 23:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aKGT/BiW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFC615B136;
	Sun, 24 Mar 2024 23:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322147; cv=none; b=M60nr21RBQn+2Z9W5S7H9US08583qzZ82agD1j76ZNzJRoo+7s6mX4M38ll2Ku7Gtb3YMuT8kV2o1MViMdAlI9poQ4a8VT7/h09ikbqfzD8WqIFqo6+sGclYIh8og7saPhqYjdGC20OMmPCDWdWdUaU934TZL/tTe3msNgAfUIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322147; c=relaxed/simple;
	bh=Yc+sAjpbVNJuVec430jNGeE7JI6m7qT9zhuwoq1Ihu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MsGIBHYctoPcl17j4C8TcOiZrAEeS3GOs57WF7CTivwYeTtfFiM4gIaSvVwYfuKI6hUaeT2A0Uc58vVquo2GyCLLetyAAQrKLio0ZO4zLzFJ0BgEI4KOqvobAxYUKQr0mK/HKcFQaUuU6yGBeCunF+OSF4AVpLmUCxTbwyNWZ04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aKGT/BiW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 715A4C43390;
	Sun, 24 Mar 2024 23:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322146;
	bh=Yc+sAjpbVNJuVec430jNGeE7JI6m7qT9zhuwoq1Ihu4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aKGT/BiWFZVbwM2GeS9CVPkxu7ZN86P+7pJUBREbOscYb9VNTfqD0LzjExAKteKgW
	 PI4hbMCJgBxptNqiK4HUQVGaka73guY89DA6ictYpUP06QWK4AGmncXlZ3kJ2PYAXn
	 QXFo59HHuWCRzTbHmR0qPMvfzrLDgpG9r6mE/H6AmQ93uAmxMp8K2bOLZleTzm9JBf
	 JnV+JppXYbF6sXgyD5GK+OavInPwBr5s2a+u2dcIdNTXwHTv09hAIn+Za44ij0Fhz4
	 KKBVWrYuJicfvSPDdUsZZVMfBwM9KPP0KbHTQ/cVxoEob44++yiWLbrxGHqhQZILT6
	 GId9iCQOBVQ2w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	kernel test robot <lkp@intel.com>,
	Dhruva Gole <d-gole@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 223/451] OPP: debugfs: Fix warning around icc_get_name()
Date: Sun, 24 Mar 2024 19:08:19 -0400
Message-ID: <20240324231207.1351418-224-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index 2c7fb683441ef..de81bbf4be100 100644
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


