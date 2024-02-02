Return-Path: <linux-kernel+bounces-50409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B006D84789D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 679962854AC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D7214FFA6;
	Fri,  2 Feb 2024 18:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bHS7UpSc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF50F14FF89;
	Fri,  2 Feb 2024 18:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899296; cv=none; b=AM/QKKyv0VQIu0hW/Lj6V8OtaDSq5N2Z6O6GHKgZ1Outbkgby3sefQYN6EJiDsEOAoFcWrOUzVBLKE7NSOHzJ2z/tMeMJhJv0idZdk6fBQwR5m4IAWNHHcra6T5TAsUh7FTuL+pJQJVoHiH7yvcG7nMWvqOmGm0MCXdcvtLE78A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899296; c=relaxed/simple;
	bh=39r6KwcwEavhQc/YC8RhALPOF3PfKMR2Uu9B0zwyiJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YLFp4VzVSE8NLq7H6DuZnsmO+97v7jGE+WU8W+kfdK6bCBY0o2B29/ul+oWdnYyAV6EmEFu9qxjPvSvLxexiGTuuu3qXg8r6LoC9/C4lXAcQ1rDAFl+6Zyf96vG+ZST5Lj02TWrjtSGEMy8G7UK1cgjNt3TOGoWa1YCNyNf6WZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bHS7UpSc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DAF5C433F1;
	Fri,  2 Feb 2024 18:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706899296;
	bh=39r6KwcwEavhQc/YC8RhALPOF3PfKMR2Uu9B0zwyiJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bHS7UpScMaV47Iz9QJ/bQ5w+ZXXx8XaolBHcbVzcsav5Iqy+tL5hWTelit9YBqKC7
	 HpOm4uOT16TIFP9AWN/xL8h+NniSwv79SOKCCsjIwV0r4XY7yp8UfZuKpX41cVVy94
	 h95n62wrfZVXp1GX2GDY8mqv62+AVLTn3bhLhs8V1PxfWR+U+ZGULmdu6TbxlACHQG
	 +qYseo2bc4BSB6gxGUxq39Sr1+/p0bFbPw8VKMay0a5UUagspXOr1Q6qdK5EXCGY8A
	 MNd3AvZSCDwdgZp4z4aHSA9CBiMG4xSerGzP+3OUtjhzMBcPs/pVtstwRzH6opdnGf
	 C3lAsY/GeELzw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Fullway Wang <fullwaywang@outlook.com>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>,
	adaplas@gmail.com,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.15 03/11] fbdev: savage: Error out if pixclock equals zero
Date: Fri,  2 Feb 2024 13:41:17 -0500
Message-ID: <20240202184130.541736-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202184130.541736-1-sashal@kernel.org>
References: <20240202184130.541736-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.148
Content-Transfer-Encoding: 8bit

From: Fullway Wang <fullwaywang@outlook.com>

[ Upstream commit 04e5eac8f3ab2ff52fa191c187a46d4fdbc1e288 ]

The userspace program could pass any values to the driver through
ioctl() interface. If the driver doesn't check the value of pixclock,
it may cause divide-by-zero error.

Although pixclock is checked in savagefb_decode_var(), but it is not
checked properly in savagefb_probe(). Fix this by checking whether
pixclock is zero in the function savagefb_check_var() before
info->var.pixclock is used as the divisor.

This is similar to CVE-2022-3061 in i740fb which was fixed by
commit 15cf0b8.

Signed-off-by: Fullway Wang <fullwaywang@outlook.com>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/savage/savagefb_driver.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/video/fbdev/savage/savagefb_driver.c b/drivers/video/fbdev/savage/savagefb_driver.c
index 0ac750cc5ea1..94ebd8af50cf 100644
--- a/drivers/video/fbdev/savage/savagefb_driver.c
+++ b/drivers/video/fbdev/savage/savagefb_driver.c
@@ -868,6 +868,9 @@ static int savagefb_check_var(struct fb_var_screeninfo   *var,
 
 	DBG("savagefb_check_var");
 
+	if (!var->pixclock)
+		return -EINVAL;
+
 	var->transp.offset = 0;
 	var->transp.length = 0;
 	switch (var->bits_per_pixel) {
-- 
2.43.0


