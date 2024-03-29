Return-Path: <linux-kernel+bounces-124617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08641891AA1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A85BB265A6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7FF131BAF;
	Fri, 29 Mar 2024 12:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hZEqzsRE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2855115B55E;
	Fri, 29 Mar 2024 12:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715558; cv=none; b=Ws6+gLU0sbPP0pSjerw8BONpa5lxfWnP0DCWAknvHcawz4idHVoBymCyTtKJXmtgfMVpVdlzbLhUHSgfAWnPsvjHWTrGz6ZrlweM5KcVVdKkGH+LZNyxEAE0BdP6bJ2SCRft5eozMk6axc+0VLTGN5jHV5i9UurWDy5nN3J5/3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715558; c=relaxed/simple;
	bh=I2r9KSq9DUfKSFPDuayqPWnKFhzeb2NZosBa3x5Xb1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bt/ARcRw9y04pgNWLAi7O5B+dF8YbCfuEjyF04k1bRaoUKW7rLI7Ciw8bqUE6L16iOxe9TuxXSz7EHFKxSwUgK2pzlXST4JAkVEYDBlVCqqfrvOkDKUlCC2UMkJbgnB0hMqED14swBpTcg0QLD/q4RLbzByMPtZHE9ihYTpmYEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hZEqzsRE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1EE8C433F1;
	Fri, 29 Mar 2024 12:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715558;
	bh=I2r9KSq9DUfKSFPDuayqPWnKFhzeb2NZosBa3x5Xb1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hZEqzsREsAcMmSQ9unLO9GEvZ+kz0hgHlWcpii4VNE83khNutMnMrIMk3fB33jlv1
	 YiPXRAvK4K8CN7GbbMexNife1ja6nL6FhR+kOIv+NGDh1OooiZps4lCTTelEtMIWGE
	 ijo+knIWpuxdPoLH6mN37l7o1HWEhbhuYpKUCaRX9Ce6C86wSn1qTSnI7FtM3GTexN
	 P3t+tTIqwNl+Vh/pI2AbwEv5Pny7ij7bm8QQ8Icmc2LLmJAjQcq8TcQLOQtAaHXzTS
	 mk18eVoZZnZetvXCrnMWtbfpeRIwKTWtCx2L2DabyYQho5s05G3IV1uTzEpaw6crcV
	 Hsud1Qr9tn5zQ==
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
Subject: [PATCH AUTOSEL 6.1 14/31] firmware: tegra: bpmp: Return directly after a failed kzalloc() in get_filename()
Date: Fri, 29 Mar 2024 08:31:33 -0400
Message-ID: <20240329123207.3085013-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123207.3085013-1-sashal@kernel.org>
References: <20240329123207.3085013-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.83
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
index 9d3874cdaaeef..34e4152477f3b 100644
--- a/drivers/firmware/tegra/bpmp-debugfs.c
+++ b/drivers/firmware/tegra/bpmp-debugfs.c
@@ -81,7 +81,7 @@ static const char *get_filename(struct tegra_bpmp *bpmp,
 
 	root_path_buf = kzalloc(root_path_buf_len, GFP_KERNEL);
 	if (!root_path_buf)
-		goto out;
+		return NULL;
 
 	root_path = dentry_path(bpmp->debugfs_mirror, root_path_buf,
 				root_path_buf_len);
-- 
2.43.0


