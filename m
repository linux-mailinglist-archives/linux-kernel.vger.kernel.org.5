Return-Path: <linux-kernel+bounces-124758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA690891C30
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 814D71F2191D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2421802A8;
	Fri, 29 Mar 2024 12:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vJG7t/4w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC61E17F36D;
	Fri, 29 Mar 2024 12:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716091; cv=none; b=MXPKUUQ/p/xTUm5tPrWoEacnMBMVh2AFDmlnVZD8QiI7lpjdy9/I8KxVCqHi+qs6rfj3ERy7gIS9bY7Y6mZqla2lbbynMpvLBMp6FDjIqjvXx4tUJiZGy81XcNGx5vEJtj573gNdxCW6g/xpUas+yEXIIxsnftr5eD3OqJo2thk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716091; c=relaxed/simple;
	bh=LgRgmxT9jx54hTmFgAykHaUQdMdqQrNb7S4KQJeQEsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Db2+ufhMF4vdR0YbvogCxN3Sk1r4nS6sKUCUbrGiSdg1Z4NWUAYxBlr0pOXGBrh7Dx+WPSJKzh3kXyQJ0CW/jEdv4Dco1z2ZX/6Xsb4+lDFppmBW9DEB5Suu2DKAwmSc4Au6axOEmJOLIZxuHdjywQncaNyAh4L4KrJe7WL9HnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vJG7t/4w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 947FCC43394;
	Fri, 29 Mar 2024 12:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716090;
	bh=LgRgmxT9jx54hTmFgAykHaUQdMdqQrNb7S4KQJeQEsE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vJG7t/4w6ZyBDor+vihQfV8lTsQ1ZwnB2qOWqPnE8A7cTC61ek+tk3k7YTNYL0nvL
	 Bz96hKPWgL/aWwr3lNAPP2I7lC9D170w7tle2Lz3IJ/jkxpycFtVNQQ6+8GRRbnqTn
	 6kKXjXhkvHSYiz7VzUcoCKnFKkb6uM967JC7Gy1pxYEmW3smxv+rdW2VP4VxSz7Rjt
	 UFbYrL4u7aqh3qQYay24FLbg1U2w79vWvaCTFTkgkhbbWzLdgYTmrRW5DJ4aYoCtxn
	 L/wBMLpjLNTxHp1tYC071YH4zaokX+Xkt4ZB8hE1HpKPKzRmNkvca1+P8rvXOj/XO5
	 Aa1AyMMMRYiXw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Markus Elfring <elfring@users.sourceforge.net>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>,
	thierry.reding@gmail.com,
	jonathanh@nvidia.com,
	keescook@chromium.org,
	mperttunen@nvidia.com,
	justinstitt@google.com,
	linux-tegra@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 49/98] firmware: tegra: bpmp: Return directly after a failed kzalloc() in get_filename()
Date: Fri, 29 Mar 2024 08:37:20 -0400
Message-ID: <20240329123919.3087149-49-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123919.3087149-1-sashal@kernel.org>
References: <20240329123919.3087149-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
Content-Transfer-Encoding: 8bit

From: Markus Elfring <elfring@users.sourceforge.net>

[ Upstream commit 1315848f1f8a0100cb6f8a7187bc320c5d98947f ]

The kfree() function was called in one case by
the get_filename() function during error handling
even if the passed variable contained a null pointer.
This issue was detected by using the Coccinelle software.

Thus return directly after a call of the function “kzalloc” failed
at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/tegra/bpmp-debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/tegra/bpmp-debugfs.c b/drivers/firmware/tegra/bpmp-debugfs.c
index bbcdd9fed3fb6..4221fed70ad48 100644
--- a/drivers/firmware/tegra/bpmp-debugfs.c
+++ b/drivers/firmware/tegra/bpmp-debugfs.c
@@ -77,7 +77,7 @@ static const char *get_filename(struct tegra_bpmp *bpmp,
 
 	root_path_buf = kzalloc(root_path_buf_len, GFP_KERNEL);
 	if (!root_path_buf)
-		goto out;
+		return NULL;
 
 	root_path = dentry_path(bpmp->debugfs_mirror, root_path_buf,
 				root_path_buf_len);
-- 
2.43.0


