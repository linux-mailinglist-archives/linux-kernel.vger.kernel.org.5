Return-Path: <linux-kernel+bounces-124843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36700891D0C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA6AE1F24000
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73621BB73D;
	Fri, 29 Mar 2024 12:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i0hxzZAQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342971BB72D;
	Fri, 29 Mar 2024 12:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716275; cv=none; b=nHowrpvygLEpSx4JG6CRUlqD17+JSpyUnKkJcKUk7XeLHQqRtWv05NoZblx0ytHNXdzwU9GRw/A4qFE3CGTUMqUUkJuO+++/0nf/CwBWi2zEjfJdNdd1nQmWqsRgELwpBHUVOB2eHbYHBnd1t4a4Z/SY4hLsYp5Jtm9OcG0FWmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716275; c=relaxed/simple;
	bh=kent2fKmh+9LgMnVo54GnXHT5e+jtbHgMLcFobcA1Y4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=prc0NviIjPZ8qSZ/7D7DwdBd0QCcaZxB1aCHVKP2pyFeDv8XeXuAt2NFY6wiDpl/8zw35+sTaLzIcZsTX3PavSWpazxQKxuKLw4OWF+CxlePt5I09ioBZTluEG22VAgR8OaQ5j5SJfq1lVIRMKc9e7Fu/VN5823xMEFcgfo/1WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i0hxzZAQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D18AAC433F1;
	Fri, 29 Mar 2024 12:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716275;
	bh=kent2fKmh+9LgMnVo54GnXHT5e+jtbHgMLcFobcA1Y4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i0hxzZAQ0U4Ne2ouE718UT3WtZSM20l6oQV+GMI79NR/2yNffZ2V4j3UZzJ5DXFA9
	 rnbZo7aCBkTZTbpnIJwCcqFwaS80HhCpBVjRE32tqBCrKOl3T66uQr/+Xg81zFd3zO
	 3Fi/vxjDHC7Jc80skdvn+3An/DZGqbqkDQPKvqLQohIESLjODEJqLer2sLhaCkToSH
	 c4TcZ4myEirJwk1bTpkbjZ/1a08pWmZ7nMDZgcQG93fqvFSC1vkXJU1B9dUJJRTCDC
	 hc3S2mtFnvpvzOi8D7XDvIwM6k5ivJu3df58lbWvrRFC7IqWQDcJHVPsWU20XtJxj/
	 26xzBhK754F6Q==
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
Subject: [PATCH AUTOSEL 6.6 34/75] firmware: tegra: bpmp: Return directly after a failed kzalloc() in get_filename()
Date: Fri, 29 Mar 2024 08:42:15 -0400
Message-ID: <20240329124330.3089520-34-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124330.3089520-1-sashal@kernel.org>
References: <20240329124330.3089520-1-sashal@kernel.org>
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


