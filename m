Return-Path: <linux-kernel+bounces-50410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FCE8478A0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E0271C23CDE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDE315044B;
	Fri,  2 Feb 2024 18:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cCat88zz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD5114F9F8;
	Fri,  2 Feb 2024 18:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899299; cv=none; b=Owinvlo18vTQIJOCJNw4lS0IiS2rVsJtBwjpKKc2NDDxVJ00fgK+kH0CloPf1jmSdN52VLEHQVnDFnQoK59C45I9CaJ66qA13yzTVynm8p709DnIoJgtdTy4SIo6nMCoOWXOsX4uIvQ6FOTFv0ArmX/eM1PAh9DwaWRRzEcnKzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899299; c=relaxed/simple;
	bh=6BtX4sPr7on3EyLgivNTvKhnk2B/xsdLcflX7xhu3/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qkYib5wJ/zC0YrFaaYlJC4zxuaCy47rMdzRIgY90vHPX4+ipC09BtIsuKkr0bLqwlV7HkXGY7UHbrhzdnkxbUPXerQwHGWNhPvFD5WQB6c1IqD3NA7Cs2z/laXsfYxOgO19PEqN3oOJ0jQlGP86Gr/YsUlrIUe3Hcw3ILbhMgZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cCat88zz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E22FC433F1;
	Fri,  2 Feb 2024 18:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706899299;
	bh=6BtX4sPr7on3EyLgivNTvKhnk2B/xsdLcflX7xhu3/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cCat88zz4d+Ud37+OkQndOtDZhWyvdugVne/xecWKlQ/4OGeH4SbHphsgIcyUtY8Q
	 GyZGC6FGR1WVQWUh+/aohw1njVxpvzspZnYW7arL72rZCkv5IxK8wWLTjRbgbepK44
	 ucciGt3d736ZFp03sCwlQDsSegVq1x+dyupWMqQw+Ak79By7lGCKQQOfoTgWIOZxZ1
	 ho5glhND8YHeh88Q+IaD6ZZHa7wNLjHVy4I+YIcQlGB7Tm1acd261SFgHPKnOSAjC2
	 NMM58E8YYkPD7T6v7f1rMOwdwTPVRrXK081pRshw6dQ6K7oVrJVjWnrNnl5s2whoTS
	 +clOjnBvGu0Qg==
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
Subject: [PATCH AUTOSEL 5.15 04/11] fbdev: sis: Error out if pixclock equals zero
Date: Fri,  2 Feb 2024 13:41:18 -0500
Message-ID: <20240202184130.541736-4-sashal@kernel.org>
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
index 266a5582f94d..c6e21ba00895 100644
--- a/drivers/video/fbdev/sis/sis_main.c
+++ b/drivers/video/fbdev/sis/sis_main.c
@@ -1474,6 +1474,8 @@ sisfb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 
 	vtotal = var->upper_margin + var->lower_margin + var->vsync_len;
 
+	if (!var->pixclock)
+		return -EINVAL;
 	pixclock = var->pixclock;
 
 	if((var->vmode & FB_VMODE_MASK) == FB_VMODE_NONINTERLACED) {
-- 
2.43.0


