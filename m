Return-Path: <linux-kernel+bounces-113442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D42888845E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1250F1F24671
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCBAB1ACFE1;
	Sun, 24 Mar 2024 22:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ha3nSw0L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0411ACFC4;
	Sun, 24 Mar 2024 22:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320244; cv=none; b=oRBTp65E69wYshCjGOkrj/Sk6pJ/KE6/Q/ZohEtz2MY6tPLVuT7yHZcGLspP6UzeeyKwzSrJJCLCz850B1sL/okjoZhOcCN4UTDexRSSQ6bsgiy224HzhQ+za7N3qyduwabk0bny8h8nQdQTGqF3pwgki0UXFsi/IPsSGKJB+94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320244; c=relaxed/simple;
	bh=5nBvLPvS85hnNcyAAtJrXNKzInCyyP9RkBGuH1IF9ig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KUmwfmduI2+kKanIcM5I2LKV6NcW3UCiZYDKEZL3vm+vOntgAsdBSgL/w331cT5td0WigS1PMRgHRfblqOou02F8iAoxNZK7zL6dOoH1aOxk272vCajYFAREX7ODJxL9G3mSYZVfXcS1dWB/O918jH7KbnauLDJ0VCFhfoSGWAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ha3nSw0L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 459C6C433C7;
	Sun, 24 Mar 2024 22:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320244;
	bh=5nBvLPvS85hnNcyAAtJrXNKzInCyyP9RkBGuH1IF9ig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ha3nSw0LPyBkYhaZqO00HTux5rJOrPB0FxTd/iRgTW+Z/MxqqfkYNCBmm4WtGPXNX
	 GT4v9eboyypMVCZ+Frlv1gsSJnQ/5+USAKtmV9Rx77SiwC/igeiufPqK4iCGvJhVmI
	 PHJJ2Cc4sodnsuyn+T8bUVY8gbBu0P8iZMIxvVhmGMyAV87PREpTpsdkETn4pRYZXN
	 4KxD4/AA7ktVfBoDWGGLDCA2Of6R3NRqBA2vg2SHMXKnsNHI7pGq2vg0b5FYwvJN8d
	 zkcgf6Vll4OVKC9j3vw1jEZgYXP2AciuKb7uy9dZ7mS1h3Oy4pO5wByh4nx+SohwA6
	 93+NnEcJn4/Ew==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Armin Wolf <W_Armin@gmx.de>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 551/715] platform/x86/amd/pmf: Do not use readl() for policy buffer access
Date: Sun, 24 Mar 2024 18:32:10 -0400
Message-ID: <20240324223455.1342824-552-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Armin Wolf <W_Armin@gmx.de>

[ Upstream commit e42dddce83a0578a518cb7078930c8269a6083af ]

The policy buffer is allocated using normal memory allocation
functions, so readl() should not be used on it.

Compile-tested only.

Fixes: 7c45534afa44 ("platform/x86/amd/pmf: Add support for PMF Policy Binary")
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
Reviewed-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Link: https://lore.kernel.org/r/20240304205005.10078-3-W_Armin@gmx.de
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/amd/pmf/tee-if.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/amd/pmf/tee-if.c b/drivers/platform/x86/amd/pmf/tee-if.c
index dcbe8f85e1229..4ebfe0f5a7fb2 100644
--- a/drivers/platform/x86/amd/pmf/tee-if.c
+++ b/drivers/platform/x86/amd/pmf/tee-if.c
@@ -249,8 +249,8 @@ static int amd_pmf_start_policy_engine(struct amd_pmf_dev *dev)
 	u32 cookie, length;
 	int res;
 
-	cookie = readl(dev->policy_buf + POLICY_COOKIE_OFFSET);
-	length = readl(dev->policy_buf + POLICY_COOKIE_LEN);
+	cookie = *(u32 *)(dev->policy_buf + POLICY_COOKIE_OFFSET);
+	length = *(u32 *)(dev->policy_buf + POLICY_COOKIE_LEN);
 
 	if (cookie != POLICY_SIGN_COOKIE || !length) {
 		dev_dbg(dev->dev, "cookie doesn't match\n");
-- 
2.43.0


