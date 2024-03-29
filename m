Return-Path: <linux-kernel+bounces-124905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BABDA891E2D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3C38B273AE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6461527BBBF;
	Fri, 29 Mar 2024 12:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jdQMOzO3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CD927BBCA;
	Fri, 29 Mar 2024 12:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716405; cv=none; b=bkv/VpTQOPpiyKKDc8DLfcyEm7/xhIl/LKQ9KWn+Sm26tZ7SKzyZFIljbe7mYrO1x9vy3EHRxFMND0V4RJxW4QAN3noFS/hXvEuLQj60Ha+0RpJfmrUYAJLGd3yguI+KikjGq8gQ0Y0W7Cq6AxUeypKpvOltARVLoPr5QzzED+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716405; c=relaxed/simple;
	bh=I2r9KSq9DUfKSFPDuayqPWnKFhzeb2NZosBa3x5Xb1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u/ebNb1jG+qCQUb+G8ldpYdBw7Ah0myqv2gjBexmSlOmZHFK1DiLFKcl/ySy3ccj8sLHrG6eLgOltfKiWMlmDM4BLPzDMkhZYvpd7yNzCFBLgGmo2Lcscdy7M05ysTdy9oGogTL7QFLv/p3DzdFSWipeIOYO3Oe3zeYKR5e12dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jdQMOzO3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA61FC43394;
	Fri, 29 Mar 2024 12:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716405;
	bh=I2r9KSq9DUfKSFPDuayqPWnKFhzeb2NZosBa3x5Xb1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jdQMOzO32N0uYoF6yH3fIDXRoctaBxSnvrE3K7abdrQArdYGWUfTEUCkktL5IPXhc
	 9Lp+JsRSwGkDqVCdcoezQl5LoM3NWrLRBP14Ihrt1uczpSwStbz77v8Ir2JDlX2YN4
	 wBZcxt/WlSpwqQl00RUfNYqsdPRyvZoldyQRJ/sR6a1xgZprETf57msuFel1XX87Zh
	 JQqb6/ZmMtvEBIm59MzDESED4k1sev+w1re40NNZDJF5KvpFUJD+ibQeA0uh2YpoI0
	 WZvysGfrGc9PLNknEuqIYDAu6XmW6VFm6l3qy7xGe3f7JrgpRpaRKqTtseh7g5GRdw
	 F1BlMvDK3x8lg==
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
Subject: [PATCH AUTOSEL 6.1 21/52] firmware: tegra: bpmp: Return directly after a failed kzalloc() in get_filename()
Date: Fri, 29 Mar 2024 08:45:15 -0400
Message-ID: <20240329124605.3091273-21-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124605.3091273-1-sashal@kernel.org>
References: <20240329124605.3091273-1-sashal@kernel.org>
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


