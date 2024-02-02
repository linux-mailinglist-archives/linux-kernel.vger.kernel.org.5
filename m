Return-Path: <linux-kernel+bounces-50435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2CF8478F1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6041C1C26FAE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D251E15DEEE;
	Fri,  2 Feb 2024 18:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gtmOCbON"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3BA15DEF9;
	Fri,  2 Feb 2024 18:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899358; cv=none; b=FrvXK3fNA/I6nlw1z/ypNcyzSY0ZsGRksQZ6u+MwUlavxULHE5mAnCwb7bmq6DkkgYbUEIWVqD1mCJ7FjbHkKeWGZM3fqqB44Lo53A15Gytmxm9y7gK0oHeAwaS8IC29sNIWqNz9R6K/0/Zq4j1vYmDh1Xkekzg0s4eXSyb07fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899358; c=relaxed/simple;
	bh=uvhYev15j5sKSpk4W36dY35o9B0FZ/iIo2RY+WGvCdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zb1b/TmMJ2uLXmeH2P4vXXqkjXnuc8oC1b5Gd77yQiyoXhQV2Mtb1VKh+x4stvvkLZtMUJrPtuVJc7DPypg9rTs7PXrnd58p/j7+E7q7dvolU7sl+JrjFQhw6J3lcvgukN6unt3ThAXEMgKhTmtP7q0mrQT3QKUdXAxo3CX+7P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gtmOCbON; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89DEAC433C7;
	Fri,  2 Feb 2024 18:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706899357;
	bh=uvhYev15j5sKSpk4W36dY35o9B0FZ/iIo2RY+WGvCdg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gtmOCbON1oxGBijgXNE1xXgOfJd920SfAxewvQTnK493WNdY8cP+1OY4zqz0tgnWW
	 Lm9Df06BDyq4GALDdeoww/Ew8OeE0NJ9DrnDgL14mevDJmVwFYObHgBGGsxk87bhAW
	 sft/LQNJEqVQ6DdTvuP50KNaKZBYimqTj57HE5IvSXYDICiwNcTrpcEWR69kjyzKhh
	 nhViWu2ctSoHX/Yotv9wY40OZgj/Qvv5LKpctKmnBWkJCrys+DTpmLGbk7OeZ0zDHL
	 MuAP0lm+om+oZppvcT31bOqHdJxYRtiwrWFHWRlpp5Bua3iVPIXTHkqc3l5d368vIs
	 hzTEqi0XTn/LQ==
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
Subject: [PATCH AUTOSEL 4.19 4/5] fbdev: sis: Error out if pixclock equals zero
Date: Fri,  2 Feb 2024 13:42:25 -0500
Message-ID: <20240202184229.542298-4-sashal@kernel.org>
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
index 20aff9005978..b7f9da690db2 100644
--- a/drivers/video/fbdev/sis/sis_main.c
+++ b/drivers/video/fbdev/sis/sis_main.c
@@ -1488,6 +1488,8 @@ sisfb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 
 	vtotal = var->upper_margin + var->lower_margin + var->vsync_len;
 
+	if (!var->pixclock)
+		return -EINVAL;
 	pixclock = var->pixclock;
 
 	if((var->vmode & FB_VMODE_MASK) == FB_VMODE_NONINTERLACED) {
-- 
2.43.0


