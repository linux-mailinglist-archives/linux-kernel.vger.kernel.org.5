Return-Path: <linux-kernel+bounces-50394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB8684786E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE4CC28A16E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C978E13C1DB;
	Fri,  2 Feb 2024 18:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hIcQDLPa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F5F13B2B7;
	Fri,  2 Feb 2024 18:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899267; cv=none; b=lnetOntTro8dqnOaXMq6JnYir//+1pBGevFcdmDo7cCV3lBvrcDbJUJiEX4thhSWJ2GynuflMFIVHYfbt7kJDidr7b6yVdOzok2eZ7Q/nDp6P5AsXfeL8DqAjHc+xxKMJmGhxE67GTeNS0HZ1KLPhXIwUK03/qz9n65urfEZDfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899267; c=relaxed/simple;
	bh=zlBTO+DIaLb1eyn6GqHbfx3msn97FB7ND0l06vg+m/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JK8cXcw++/YSTt5GaqubHKUKtTRLQG2ovQSaTV3QueYsPRuowvrnmNThWGaHbnI6Fef5rRWY45ihOpBJn4Xw0Mj5PLS+aNVreQU3hlhobkiWGsZ5xrw12lEYo61L7L2aYP2QcpG1dlWwOuU5KN1mloQd5UbTFlmMA9bjrAMen1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hIcQDLPa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EFFAC433F1;
	Fri,  2 Feb 2024 18:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706899266;
	bh=zlBTO+DIaLb1eyn6GqHbfx3msn97FB7ND0l06vg+m/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hIcQDLPa58vIQ/+wExqqSYkR1XF888GN4nU3KtrGqGFuEu98huPNKCDHW6n+Qmeq/
	 +siTHUOy7ngqD5X1Df1zPIECU7qvgrfDpacPc4jFakMUK+K4e1C6BECte4Svx20Nir
	 OJ+2/rMNDhYBsMcu3zwgC2nsKomFEGUo/LfrF8N5jRSLcyj5wE8NTLUDRTfk6nXf4K
	 i/diECVSNI7MFF2Kf5GSSKqTxnaSB/WBtswuc0MVS8gkU1P2TOF2uBDAV/yP5QyTjJ
	 a/8QlDN06JF+1LVUPHZSuOC7JG1UctOPVcXnfA6jHLirUUEZJ6Ndf2PdPEvEebQUiQ
	 XL7wNxtO5O9pQ==
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
Subject: [PATCH AUTOSEL 6.1 04/15] fbdev: sis: Error out if pixclock equals zero
Date: Fri,  2 Feb 2024 13:40:41 -0500
Message-ID: <20240202184057.541411-4-sashal@kernel.org>
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
index 1c197c3f9538..fe8996461b9e 100644
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


