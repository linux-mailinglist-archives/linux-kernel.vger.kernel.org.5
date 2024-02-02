Return-Path: <linux-kernel+bounces-50434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F05A8478ED
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 912F61C2718F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D863015DEF4;
	Fri,  2 Feb 2024 18:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iyD4/w0R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241811308CB;
	Fri,  2 Feb 2024 18:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899355; cv=none; b=LlsYfGFxBTGuGEZU5rvHl9RRptWxzcQIutcrzRu7qF4Z62wAEUdSySsf+iyeYxSwy2nSq4BcStc3FdQkAPRUU1xRAwaeQVDOj2KnAFTIrRplARcHvvJovTmxJzAu8DPUJ+G4cTS9aqxmo6yNdmzYq077tVJENmyZC0rq1uTTt9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899355; c=relaxed/simple;
	bh=RDplX8i+eCVHA9vQdejr+iOAe9siIjDUJX+BZWX9FEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NsTVIMZnEfQN/dNwWk4jliYu1pP6W3nzhRXDvvp1fU9qJv2C+9RnJs/2wbUEL5X4mNiwRXGGJcopAv293g88rDpug4+G7CVQAQ/lHPLZIrx3je6eoQrh4aRpmbb4Bn2VaC3GEvxvo3b/E4bhMw0KCL9GwEPbcPXvK0BRHe7oaXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iyD4/w0R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12997C43390;
	Fri,  2 Feb 2024 18:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706899355;
	bh=RDplX8i+eCVHA9vQdejr+iOAe9siIjDUJX+BZWX9FEI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iyD4/w0RLglKwcgZ51NTLdu6NUkkC2c15j+NvFGfhJKpKzSR7UO9pR3IFs6cuVT8H
	 pQMtGhu9AbjbNzofsRgJhgApalTFUISrU1i/IMdpuhE/jDkeUmCIOYZqM3rG+sX2YV
	 /hQP/7CxefiiwEx5CX+XauFojOqRkEXACvcfQXNojL9H6u1BMfsGrgWigb4QFEYv+1
	 CLBconZuvW4EMVPVaUSaNFd8fQstuLd4l6BrO63SfaVzQ2TnrV9cs1Bujem+EeXf5k
	 3nEhdASJFuXKZ/LoINoYRJEtyAPR0wPDIP6FH9jDrpWaxZMZ5lgRd5VDKNiOTE6u4u
	 WqFyt56euorDQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Fullway Wang <fullwaywang@outlook.com>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>,
	adaplas@gmail.com,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 3/5] fbdev: savage: Error out if pixclock equals zero
Date: Fri,  2 Feb 2024 13:42:24 -0500
Message-ID: <20240202184229.542298-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202184229.542298-1-sashal@kernel.org>
References: <20240202184229.542298-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.306
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
index c09d7426cd92..d9eafdb89cea 100644
--- a/drivers/video/fbdev/savage/savagefb_driver.c
+++ b/drivers/video/fbdev/savage/savagefb_driver.c
@@ -869,6 +869,9 @@ static int savagefb_check_var(struct fb_var_screeninfo   *var,
 
 	DBG("savagefb_check_var");
 
+	if (!var->pixclock)
+		return -EINVAL;
+
 	var->transp.offset = 0;
 	var->transp.length = 0;
 	switch (var->bits_per_pixel) {
-- 
2.43.0


