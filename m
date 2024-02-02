Return-Path: <linux-kernel+bounces-50393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF4784786B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AC26281EB3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A803213B2AB;
	Fri,  2 Feb 2024 18:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NCi9/4HN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B7613B29C;
	Fri,  2 Feb 2024 18:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899264; cv=none; b=f9yeMmsW/Vn/s6UqLgTo9pLtZ2WpFd5vbQ1LKRX/vEP9sGfJSIbq5SrJX148rcAP/m+bXk3pAY1actbPWZWAcX3n3O6WAXUfrIgNLQ6D+SNtrpOXBs+tp7vOcZCTylopavyGrWS2mDF70JXZDnb9PTjmwmEx+JRK2rbQn6Z82vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899264; c=relaxed/simple;
	bh=JDIEiQpNzq9zQGHpIs/DNTXbvhMO9jWtdWyr8IjOq40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WG6+TUr17KB/xw4gjqzzBUUAyTJAisY4Che+a/39Sl9RRJXGdq3Z+Ee6l/X+6CJgeaPo7o/bxp+8M63lwoD7q7iwfpxELxaYQt5PwITw9zwHMNSoCm8LTxxLjtTxsYPrJQaIYdETDmZFxUnc+Z17ghoCgxtQZP1wAcH1+HSKUic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NCi9/4HN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D48EDC433F1;
	Fri,  2 Feb 2024 18:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706899263;
	bh=JDIEiQpNzq9zQGHpIs/DNTXbvhMO9jWtdWyr8IjOq40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NCi9/4HNNpPNygSQB0a6kxIgkDnxZPHFk5d+v3zkILHcwZqK4JaXKLugWoiW8yqiN
	 aUISINvTn2y7GqfsaC+J+sACCqWOtsKoyZBqUUDzCFcYX44kQrFJ2gnqGc7kldeBOc
	 HWp/C3vgjSWWs2YdzQvuMcxk2+6A0nNJa5/rR0KE6FGN4JEwkWMhzf6AU/ysJxy6Mq
	 QfvAiHcSrYOrfY97Bf6rgOK3XbTt8eGhWllxFFK06NVSr5HmWot+YHC1E+zkwd40dl
	 1lJu5hdzCLrwHii2vr3HqICkpuN5Vnnkz5c9c7TGuH33mqkQRtNbC9jxWgPMH204PE
	 qRdvfIUxnPvEg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Fullway Wang <fullwaywang@outlook.com>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>,
	adaplas@gmail.com,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 03/15] fbdev: savage: Error out if pixclock equals zero
Date: Fri,  2 Feb 2024 13:40:40 -0500
Message-ID: <20240202184057.541411-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202184057.541411-1-sashal@kernel.org>
References: <20240202184057.541411-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.76
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
index b7818b652698..a7b63c475f95 100644
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


