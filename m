Return-Path: <linux-kernel+bounces-124578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1A6891A2C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F053B1F29475
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22CF156669;
	Fri, 29 Mar 2024 12:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nxkZoCuM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66A8156866;
	Fri, 29 Mar 2024 12:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715449; cv=none; b=HAprWK4o28OzhyF38jO9H0VqQLIQ+o9rbW3/lIs75/wmohjlzmHLKlHsKyxRKQ2jVSzQfRLqzRufaVe0+oyHNUmCucG8MGRwscEtVDbFt+hN74QxUeXiAbp1k+E2AspkPj+IipVIsArrify4E75ywdhx+pfP+TRsNnr8ZJUWzaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715449; c=relaxed/simple;
	bh=kent2fKmh+9LgMnVo54GnXHT5e+jtbHgMLcFobcA1Y4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tj187LLnexqLEJvGXtQNPGPVRSEfh294+ZmIIIKIFauCWNb1E+Td3Ym+dAaDpsqe0G5tpy3koVVQdfRxbXpcApWnyeH68eJYFnRBmQDCRnbbv7T1mPlaxbMRHh6jbXW2biHh+eUBgkK0pc0nQe0P72hi8zkVpwkhOim20xLLjok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nxkZoCuM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C8AC433C7;
	Fri, 29 Mar 2024 12:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715449;
	bh=kent2fKmh+9LgMnVo54GnXHT5e+jtbHgMLcFobcA1Y4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nxkZoCuMbxpTOoivEz42fszf54QA65QyOF8nw6LGn4VmB80uHS1GN2P7fQC1aKfuW
	 9V6g+Mjet2o9yYWKOdwuHEOVbVitaVEmvjYiSb5Z+QpXo1lQ/loTLdts/txQUOd/C5
	 Wbt7zJH1gVc5pPtlOMqFEhsNdLaoZXf4lblKGrJshcX0LabLQR7OeuJ9rlWagz7O/0
	 g+0Vgto9GcGK3fxMapYaUo5w3UpQMcI/zuOIUfCtd7qQ668syxyOOxabB/s7jDjgRd
	 FBF9x0fbZOBIZAk6A+xu76162Es2HhhI3yVesQSiH+r8Tal6pXM6Ppy6ycbx1ad9l6
	 8/6KaTnboEF2g==
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
Subject: [PATCH AUTOSEL 6.6 27/52] firmware: tegra: bpmp: Return directly after a failed kzalloc() in get_filename()
Date: Fri, 29 Mar 2024 08:28:57 -0400
Message-ID: <20240329122956.3083859-27-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329122956.3083859-1-sashal@kernel.org>
References: <20240329122956.3083859-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.23
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
index 6dfe3d34109ee..b20d04950d99b 100644
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


