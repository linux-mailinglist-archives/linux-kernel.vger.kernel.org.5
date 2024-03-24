Return-Path: <linux-kernel+bounces-114576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E91D888B20
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD79728F3FE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216CE29ADE6;
	Sun, 24 Mar 2024 23:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gqf0Xjky"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C301FDA0C;
	Sun, 24 Mar 2024 23:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322221; cv=none; b=DtDio9VTK9a7UfB/L1rfPS8SbVjxizJI/1i+rh8tDOGwoM1hndcIHjGLlbN/n376GnikOZ2J83Udi0L+9zgJ7MrpnSBNlYOBvZhg1K7urY2M1eJvznxY5gES8RtO9InKH1Gpef8dP3OdlRZe0wnP2OB/A0AMCN8RoZZ5GtrRwi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322221; c=relaxed/simple;
	bh=gGhgmXxRAxAdvCVBVHuyDRRwC8UBwSafBfP2Eaj0jJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Euuwj+aFhF4gPlFL6zQ6O4fU7hBQzWJGg3bcHvQNFfWwZxMlPyIYQIca9eSwnbNklaNS+kU2Ablu0DN6jJ+9u2VvVRmoD19GKsMeQ+5q+2C/e0gVCvgZb8bmpb0zgVySZi/oHQbaVbDBmrkYwFCJw/a4RYaD+ydk4B4RSO0Eavs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gqf0Xjky; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BD51C433F1;
	Sun, 24 Mar 2024 23:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322220;
	bh=gGhgmXxRAxAdvCVBVHuyDRRwC8UBwSafBfP2Eaj0jJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gqf0XjkylPjI6lxtkgIZ++Ij4zX4/mL3PyI66LUxWzjLtmokjAkulIIjWwYS912TK
	 Tnfg1qU7lLrXeyAP+zpHZ1oMrNuIhLpTiRn+JDkXUDfhzHpxnNzSxESjKYEH1GLfK7
	 wS7kSvO77I/SU9iY3cwkdpInxV1TjnYTCC2U5fYbUbQV+q/XpQ/yxRnk+LW1O04OSl
	 5ZJiFwiIPzL8DRygemo2YoMxNrdHrVESA9twO7AWewGJhzPEFc84FNGrzItw69OOFh
	 uMBnZJHaUPr557UhJXvbyb/Q6ucoGCgCLjtsoHtQf3JnHtyxcaKib4m9eaB4xaCE/J
	 FYcw2hVBjAqJA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 300/451] media: sun8i-di: Fix chroma difference threshold
Date: Sun, 24 Mar 2024 19:09:36 -0400
Message-ID: <20240324231207.1351418-301-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Jernej Skrabec <jernej.skrabec@gmail.com>

[ Upstream commit 856525e8db272b0ce6d9c6e6c2eeb97892b485a6 ]

While there is no good explanation what this value does, vendor driver
uses value 31 for it. Align driver with it.

Fixes: a4260ea49547 ("media: sun4i: Add H3 deinterlace driver")
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/sunxi/sun8i-di/sun8i-di.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/sunxi/sun8i-di/sun8i-di.c b/drivers/media/platform/sunxi/sun8i-di/sun8i-di.c
index 01b44dd708bd3..7a2f558c981db 100644
--- a/drivers/media/platform/sunxi/sun8i-di/sun8i-di.c
+++ b/drivers/media/platform/sunxi/sun8i-di/sun8i-di.c
@@ -304,7 +304,7 @@ static void deinterlace_init(struct deinterlace_dev *dev)
 
 	deinterlace_clr_set_bits(dev, DEINTERLACE_CHROMA_DIFF,
 				 DEINTERLACE_CHROMA_DIFF_TH_MSK,
-				 DEINTERLACE_CHROMA_DIFF_TH(5));
+				 DEINTERLACE_CHROMA_DIFF_TH(31));
 }
 
 static inline struct deinterlace_ctx *deinterlace_file2ctx(struct file *file)
-- 
2.43.0


