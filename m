Return-Path: <linux-kernel+bounces-50372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB19847829
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E1991C21946
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDCE12F39D;
	Fri,  2 Feb 2024 18:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bbS/7aXh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDC512F390;
	Fri,  2 Feb 2024 18:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899224; cv=none; b=AV+lBUWyUTb9GX6mYUDqySbNmllLq3Htac2T+I2RgCPMCxN3lI4LvsN0kCRiltZFS14hNQDvFumsOpf7M4rdoKKPAzCTNt45OC80x0UQa3Yagc4z7A0YzvbZg9uMTDzEJMpQ2Y0YJmA0J9l5lvDAgbANhbVsyt+FBXu2NosIgIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899224; c=relaxed/simple;
	bh=OQN9U8WPS8z0nO6aDPPSkvoCxJT81vr63obFC3R8S94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yo6Ly1npfHOP0j/ujlRiBDB9lSaLp0yq1bfP1SQz7/1TJUiDjlJ5yxVxgGW7JATRFxr59SkiRn1kyF/zYb9JEJ3Vdx2m+VZ4kI5jnY8pCkngXHC+hm4SgInVCTlgPusBhYbmGVBU+X14cZuITV4QgACtK1SFK+3q3BzHVt1ToAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bbS/7aXh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB75EC433C7;
	Fri,  2 Feb 2024 18:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706899224;
	bh=OQN9U8WPS8z0nO6aDPPSkvoCxJT81vr63obFC3R8S94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bbS/7aXhoLSD59TtTnZsnQhEP3XejFkpDERE1gg+XNA8FXyj4BdkLWBOo6CUEc8Hb
	 t3nO8tCkLe+F0cKN5PCxVsGPSoMMYnh2+ylxTlLtVu88aouMe7Zj4FDseWs4MIWfqn
	 JlBRJYnlLLwfsFKjBoO08Xh7ZazC8srjEPzXw6x+Cm6oyIuIqeHVBCneN6B/of4a1f
	 ww36zViXeKzzyEf44MlRH49w4e7GxEuPX/npyMwoIFRUw34e6Lmj/l4mkPu5NWpykT
	 OgXbmXPaFz/64BVZ8zA2LWgRT9uLU8I9tovbAK7T+GcZBRCK5lxnw8s9pseistjdAm
	 wgW4ZizkeyEdQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Fullway Wang <fullwaywang@outlook.com>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>,
	tzimmermann@suse.de,
	sam@ravnborg.org,
	javierm@redhat.com,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 04/21] fbdev: sis: Error out if pixclock equals zero
Date: Fri,  2 Feb 2024 13:39:51 -0500
Message-ID: <20240202184015.540966-4-sashal@kernel.org>
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

[ Upstream commit e421946be7d9bf545147bea8419ef8239cb7ca52 ]

The userspace program could pass any values to the driver through
ioctl() interface. If the driver doesn't check the value of pixclock,
it may cause divide-by-zero error.

In sisfb_check_var(), var->pixclock is used as a divisor to caculate
drate before it is checked against zero. Fix this by checking it
at the beginning.

This is similar to CVE-2022-3061 in i740fb which was fixed by
commit 15cf0b8.

Signed-off-by: Fullway Wang <fullwaywang@outlook.com>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/sis/sis_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/sis/sis_main.c b/drivers/video/fbdev/sis/sis_main.c
index 0f5374f6ef05..6d524a65af18 100644
--- a/drivers/video/fbdev/sis/sis_main.c
+++ b/drivers/video/fbdev/sis/sis_main.c
@@ -1475,6 +1475,8 @@ sisfb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 
 	vtotal = var->upper_margin + var->lower_margin + var->vsync_len;
 
+	if (!var->pixclock)
+		return -EINVAL;
 	pixclock = var->pixclock;
 
 	if((var->vmode & FB_VMODE_MASK) == FB_VMODE_NONINTERLACED) {
-- 
2.43.0


