Return-Path: <linux-kernel+bounces-50421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8B98478C4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A1371F21F5A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE606155F4E;
	Fri,  2 Feb 2024 18:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPtm7Z+n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29495155F3D;
	Fri,  2 Feb 2024 18:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899325; cv=none; b=pxIyqjDCnwP3Br72a4KeSzaKsBNT03K9PvQHxOVUTMduh0B3tEdgnG4tXHFkdOCxpCXJrFikDAYw58XT+K4M16Sgqf53hCwlgba3AdkQJdInFgzlVpxaoVIVPCxfmMl0cTrmelKvvOru6J1e22M5YMsAwcznHdyB8yeKsYAlN9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899325; c=relaxed/simple;
	bh=mi1mYYcb2fqX35vWHqze/jCqRLdfTwh2lM8ip/So4yI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rcv4gvbz22q49yacZn1y+tl+tD/pDp8dlmFvGdy7mWceB7J0DvtpmMnhYG55dCXvtrzL75r4IRXTCQkMQR2QkPxiJTBqGr7ZPbZcRAxQPkFSVA3K09vNvTMGTTHOJiqDWDOpyHuA1IfXh55R71L3+VXxaQuSrfdmkR/dfup+tSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oPtm7Z+n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92D37C433C7;
	Fri,  2 Feb 2024 18:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706899324;
	bh=mi1mYYcb2fqX35vWHqze/jCqRLdfTwh2lM8ip/So4yI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oPtm7Z+nVUd/0Z/04fY+kblJ+T8gD1AIIUu3vVQG4H6anPcZLhT8eoJgtADO1itQl
	 NdfOsDNSTP+p8+vPWcdSuavDLCMXrQz8KVRHwAvdGOM4KS62Y0I8q+HgXeB+tsqecI
	 Vey8O13vsej3SdUUJBzYDwn4mQdXQf7k9EcGnawK8TWA6u6DBzoJ3ClF3Yg/Nxr48I
	 4dVp0UBZ2pzcRaQJtiwr13X/emvgrrxGwJrTLQcjGHs+EBmmaSuNKOMs8hd5a73WFI
	 kbWMUCgWi02MUx7ibiOShr1GNmP8iW9XBImftLgYiGrf9FKGNHF1zfJppyW0DaO/Q8
	 AuBBvU116IDhQ==
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
Subject: [PATCH AUTOSEL 5.10 4/8] fbdev: sis: Error out if pixclock equals zero
Date: Fri,  2 Feb 2024 13:41:48 -0500
Message-ID: <20240202184156.541981-4-sashal@kernel.org>
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
index 03c736f6f3d0..e540cb0c5172 100644
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


