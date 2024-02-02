Return-Path: <linux-kernel+bounces-50420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A978478BE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 710E328E3D9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB8F155F21;
	Fri,  2 Feb 2024 18:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WNUfVAoU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F66154092;
	Fri,  2 Feb 2024 18:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899322; cv=none; b=uCJO3VYE19fDRoEjTo4n6kSwoKg/WvkI8RXKd42Jq36f0SLaiy+NyLfdHyKpPbmpEi/oWr8C38Duw13r4/HcVmR8BzoiLJ4IXrRJ98Ut4xxvyrInNQVLzFpJx22YSzmLIHeVTayGsvKmmVfns7voVXWmUOmv1fbOe3byqAGJkjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899322; c=relaxed/simple;
	bh=39r6KwcwEavhQc/YC8RhALPOF3PfKMR2Uu9B0zwyiJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rL4/vQvfChehFngzJ+WFH8NKovFLJDIkRf+zhAFGXt3dZ8JX3pU4c5bdOpGBpG7yOb6tixaFnVO1RZJ4ZPRX2knBD2IAc8k8wirZ9y02qu2Z1jEFCYMKHRRlso+c+xNi7Effpwj+YdAljC2P1k1XfaLAWdMbFCuulGPckNrQ/UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WNUfVAoU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09DF7C43390;
	Fri,  2 Feb 2024 18:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706899322;
	bh=39r6KwcwEavhQc/YC8RhALPOF3PfKMR2Uu9B0zwyiJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WNUfVAoU3E7uz4xbwUD2W78w0IVDVmK4J3Jfx3KLGYmKcUyyY5u20YJpFnK96WsSj
	 OBbhKvEGUMeV+S8NagVPDkD7KVg9OXe9BaUoy6mKSZnjYs4Ph3z2aZl8a/9WKGix1Q
	 VfZKTy6sZBvWZrx2IKJCjjNC03+POhEh/l/Qe4fcE8yyREqkn8EUUV9oClsJr/SPzY
	 KF8IvLE1gDlCdqutf3g9c35jA/n8I7K4It7dZ3SiRApZ6wDc0QBw5gmCt4BswZOMYV
	 v7UYX6Zs1OTLpkLwblb9Q+mNzdt0QAjmc0QuJ7ztCSin3nft2nyXBk/Fiy/OvyFMe1
	 GbclEJjl5+nbQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Fullway Wang <fullwaywang@outlook.com>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>,
	adaplas@gmail.com,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.10 3/8] fbdev: savage: Error out if pixclock equals zero
Date: Fri,  2 Feb 2024 13:41:47 -0500
Message-ID: <20240202184156.541981-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202184156.541981-1-sashal@kernel.org>
References: <20240202184156.541981-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.209
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


