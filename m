Return-Path: <linux-kernel+bounces-50371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A781847824
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE64A1F2F665
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6786512F370;
	Fri,  2 Feb 2024 18:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cgGDGdxh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DC912D77F;
	Fri,  2 Feb 2024 18:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899221; cv=none; b=YKp2AVbuGShvGF/zmPoPNuwowE+QCJkUYJKwSwSs38u3D5XiDQEyh4wNnBVndgmyNJq/VP0vo9F2YVsAQHvbHEVAqrzsPL9ayhiJ5FHqs6bzSCXT5hWI1rH7TqrwMplH+EDIQryK7nm2/JqMwrcdO37SgpKt1GhXY5O9MIQ5nSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899221; c=relaxed/simple;
	bh=JJlRPbjNPXraLj8lLa7eGdZgOqFlIB+AkU1+hUkUi/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QcNzV8Kftl2CNFtzlB+SMFa07U9UbL/iuVw5EykHXgvYLBXuH8rP8a+yGHS7WPQDBCW3kLhHZAgX9OetjbfNYpm9XrVor6s/hHMshcjMn57LjBQkARZjka0DBD8huO/uYEV25GblWXxYZwGNV6NoC5/JJWrEqNsjCTxO4bbTAYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cgGDGdxh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70457C43394;
	Fri,  2 Feb 2024 18:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706899221;
	bh=JJlRPbjNPXraLj8lLa7eGdZgOqFlIB+AkU1+hUkUi/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cgGDGdxh79XB6iURIrXW+bnAskcbjLuoOAVFaTp5P0lKbUMXEX8IKErBSdg1BEW/z
	 txZFrVhyT/Ehig3q2T+JzIXm6yMQ5mm8F8JeEd9yaWvnwVt2xXur6qNYN1KpxDaMr1
	 0gENCWO0A8TjbEW8F5pIpHB76nVQn9cCDmeS98/phyJzcpAAwKNR0D3ABKhgTZeJYj
	 VysjNLz/UiVIJjgCGYbjkCAbtnf4GKqelKmy8N92N+UNkIlP2SOGwO9lHLjs1nu6MZ
	 Is2iMCNf/mrUPf/wEKT65293OXTvkU7SUcs1dbybRpBf8FGUqjStk+EUm4UrMWgvfw
	 4E64u+saFvVnw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Fullway Wang <fullwaywang@outlook.com>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>,
	adaplas@gmail.com,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 03/21] fbdev: savage: Error out if pixclock equals zero
Date: Fri,  2 Feb 2024 13:39:50 -0500
Message-ID: <20240202184015.540966-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202184015.540966-1-sashal@kernel.org>
References: <20240202184015.540966-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.15
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
index b5f84bd4804b..4ba5cd55e5a5 100644
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


