Return-Path: <linux-kernel+bounces-124521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB9B891945
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE5C81C24955
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C28145B34;
	Fri, 29 Mar 2024 12:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lwCo7M7d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35C6136E18;
	Fri, 29 Mar 2024 12:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715292; cv=none; b=QpTMBgqYDau2tLfP+Tq7ORla8YLajzg2Si7v+ZA78cqcD79vkGll81jNKMP0wwJ7wOlTa/8dpWXHXErOa72fuxVrPt3PkTcNeLX3CPSo21KP4QGv1/Om30MtWB7EBGzPPtBGJYx31cI/9Dp3SC6V31zU9BHczH785OoARVHFO8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715292; c=relaxed/simple;
	bh=LgRgmxT9jx54hTmFgAykHaUQdMdqQrNb7S4KQJeQEsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mgiiy6P+N+KWYTFv5lsj3M3fk/sBeOVPHLA4ju+S66BM3cn6rYt7fC57YRJjEXGzlQu803gD/N+c9O6TnCUnY9r36tVJeAO53wwbTJ+2x08u9r2fZ0EWKMwPnwh3phmij+x13PcnUBtjbSR4U3bJpzUTyAuwTSr38/mK1nD9W0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lwCo7M7d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 151FFC433F1;
	Fri, 29 Mar 2024 12:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715292;
	bh=LgRgmxT9jx54hTmFgAykHaUQdMdqQrNb7S4KQJeQEsE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lwCo7M7dXzqYRXD9vQod3tz+xpCDjdO1EDa5QKm+iBNndw2oEuC+wITtsNGAN4CyR
	 0JLotZikXLL/kGBBfGLF7gGGc8ugFHDzGzMRY5Y4JwmkeLTXuRIqUFbOUlboqWM0Gb
	 AgsgysJKspPxSWtIX8sNfbC7n+H8T1TcTx/CsBCUduyvxt5oIMHCtvfI/s2s6kSenx
	 EhMRJd58vs6pDcLtls5xwEEYuGiPw2hTZFKEc28Ei0YMtNFLNou/ACMTDlDU805vPW
	 1Xc0ZRiH6DZ1mGv2z/vR4e9TkePuaIwcXUOLkUNojPYLOVuuVrawQNfqRcKI5USKLh
	 PJyNRWnZ+aVkQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Markus Elfring <elfring@users.sourceforge.net>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>,
	thierry.reding@gmail.com,
	jonathanh@nvidia.com,
	keescook@chromium.org,
	justinstitt@google.com,
	mperttunen@nvidia.com,
	linux-tegra@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 40/68] firmware: tegra: bpmp: Return directly after a failed kzalloc() in get_filename()
Date: Fri, 29 Mar 2024 08:25:36 -0400
Message-ID: <20240329122652.3082296-40-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329122652.3082296-1-sashal@kernel.org>
References: <20240329122652.3082296-1-sashal@kernel.org>
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


