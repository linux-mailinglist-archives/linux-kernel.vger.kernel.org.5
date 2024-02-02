Return-Path: <linux-kernel+bounces-50429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BF78478DC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 877A11F21B8C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2C515B4D9;
	Fri,  2 Feb 2024 18:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tp2cH3e1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778FF15B4B3;
	Fri,  2 Feb 2024 18:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899344; cv=none; b=hvkcuR4UdLCrwttHliMxulim70VSaa3WbfR93iVR09zReYrkzQYL0b5dGYqR067M0A8qYI+xCKrKYdpiECgW8+ZS8c8mWHWcgXlH+l3rANJWdUSMlJTaPSNJ4Tbi48OkB2J4Qw7ofOk+27nls/7OyD3MMbMned2SHbgDsRnFgMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899344; c=relaxed/simple;
	bh=sWupTB0US2HxJhh+7cEVF9Kc8prI+Gw8oNBW+a09gKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SoTSGwJTYijiU9Nlq+F32DeIFqLBKqedDlLFlkyXQRMe4eZ0yO6V/CNIOhT409R5GuHdzGn4j1U3BmEOVRhsvYdnzDGk/alsS/2GSLslLx2i8gfQbc2Vyz23Lpk77kRtpzsL72bPT8xVeylrJjIdOZ01R8BzI2flvHYADNKCsUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tp2cH3e1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7DB6C433C7;
	Fri,  2 Feb 2024 18:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706899343;
	bh=sWupTB0US2HxJhh+7cEVF9Kc8prI+Gw8oNBW+a09gKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tp2cH3e1Aer5eS/hksKADJNcg1jy9jF77YNbi3XupqMWjdGOEw7YSxkosMmlzGl14
	 gVi5wII3Cjs3T3/f8HNt4rHxPeHi36NCvYRr3o8IMZXbNmIbpHRe5SvER34BoNol3n
	 qnb+aFZr11AcL6DsVd5bPXzIMZkb/p/ipgmoZhpV0peGyaS558EVVXnc4CHo6sJqNM
	 mbQkIbDfHynrWey7jIYrr+b2xwRKGxJ1B7Pw58plze4H/+9iPBl4tehXuzJNxpBPMd
	 iSh0ejvZArrncpkkSVErSLGEGYq0shZKTqbLP5sHVdsZKuTiFF8xzYiJTtcgVqI5lh
	 gmI6a5BEDTA6g==
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
Subject: [PATCH AUTOSEL 5.4 4/6] fbdev: sis: Error out if pixclock equals zero
Date: Fri,  2 Feb 2024 13:42:10 -0500
Message-ID: <20240202184215.542162-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202184215.542162-1-sashal@kernel.org>
References: <20240202184215.542162-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.268
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
index b443a8ed4600..2fdd02e51f5f 100644
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


