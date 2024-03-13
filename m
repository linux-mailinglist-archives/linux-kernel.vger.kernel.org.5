Return-Path: <linux-kernel+bounces-101758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C4287AB54
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 599D1B23B30
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E205EE8D;
	Wed, 13 Mar 2024 16:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ktp6qR6w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DAF5EE64;
	Wed, 13 Mar 2024 16:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347582; cv=none; b=mhAL4WrfE+WCseC3bEt5owdFUF7gytC4ElVQZvKOJDz17M18GeSHyZrKeKzzefy3Ebe7p6CVGPynnJf12vwKjEjAFG1H0Om/tFR7UJ3TqFGyIuvCQQX4bea7metfzCgwSN8afEfmoaDMJQqPTp9sgr/9BIO1j6vjaMpbzLOMFZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347582; c=relaxed/simple;
	bh=H2VUbgktaqbNth6+JJL4CT0s14g7H4+8bKuRnMz788s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LQZr68w3uvy5VpCCCzHkQmlp/P737n6jnw0gb0m6dEVk2FWbh4zCJeizATFR4EgDihPiiHedQ4Yi5JW/Mw/JuNJejyB114avvED8hPZt4nSwjdH1VRl7glTKTY2EIsLLJERDQuSL3xGMQ2rJe3jgiJJg6cxjN/vXhh9YwcbSvW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ktp6qR6w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D38FC433C7;
	Wed, 13 Mar 2024 16:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347582;
	bh=H2VUbgktaqbNth6+JJL4CT0s14g7H4+8bKuRnMz788s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ktp6qR6wD24TmNJh+oHx6V6X2vXxWSrNuvMKILd53mY2CPX+y+WPYYoYqgjXdNscD
	 nEumQlTH4Dp0Ybu1N84nkySSZxEysutLZLWp83U+EJVStNXjTzHT1/NUXETLHbU2sY
	 l+CCHDjLo5IbWYpZL0km3+Xp0Q0/Pmr+VTQVichi0Dkc6BW7Smrsscx6+C1rj7HI1t
	 wDRGNYD22Fz7J91ORddYu6k6QAdqeKo1gFTrRIXvQtRSiV9z7jpngDbOw8oo0MXeKC
	 RTAk538QTpvu8A1HCydaYdKJH8APXFR+vqRBMEyi9JQ6wpgm5WKxSzqgKL7yTixdrz
	 scQXG6e+idS5A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Aya Levin <ayal@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 19/61] net/mlx5: Fix fw reporter diagnose output
Date: Wed, 13 Mar 2024 12:31:54 -0400
Message-ID: <20240313163236.613880-20-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163236.613880-1-sashal@kernel.org>
References: <20240313163236.613880-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.10-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.7.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.7.10-rc1
X-KernelTest-Deadline: 2024-03-15T16:32+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Aya Levin <ayal@nvidia.com>

[ Upstream commit ac8082a3c7a158640a2c493ec437dd9da881a6a7 ]

Restore fw reporter diagnose to print the syndrome even if it is zero.
Following the cited commit, in this case (syndrome == 0) command returns no
output at all.

This fix restores command output in case syndrome is cleared:
$ devlink health diagnose pci/0000:82:00.0 reporter fw
    Syndrome: 0

Fixes: d17f98bf7cc9 ("net/mlx5: devlink health: use retained error fmsg API")
Signed-off-by: Aya Levin <ayal@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/health.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/health.c b/drivers/net/ethernet/mellanox/mlx5/core/health.c
index 8ff6dc9bc8033..b5c709bba1553 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/health.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/health.c
@@ -452,10 +452,10 @@ mlx5_fw_reporter_diagnose(struct devlink_health_reporter *reporter,
 	struct health_buffer __iomem *h = health->health;
 	u8 synd = ioread8(&h->synd);
 
+	devlink_fmsg_u8_pair_put(fmsg, "Syndrome", synd);
 	if (!synd)
 		return 0;
 
-	devlink_fmsg_u8_pair_put(fmsg, "Syndrome", synd);
 	devlink_fmsg_string_pair_put(fmsg, "Description", hsynd_str(synd));
 
 	return 0;
-- 
2.43.0


