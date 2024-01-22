Return-Path: <linux-kernel+bounces-33467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D1F836A05
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C9601F24EF4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34986131752;
	Mon, 22 Jan 2024 15:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EqchSTfX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A79131743;
	Mon, 22 Jan 2024 15:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936410; cv=none; b=BhA//i18/7VZZGKW1ldTsWXLeIf+Cozwf0X/6SK8vi1MPUzgTv0HchnCRW+Xpt0TtCT9wxN9901XraWICklmfVliqK9sI38MyjU6as6viv+tanP3A2K/8//NdldcCcHoX81WkeTAD5A5QOEBJmWfwdQ3dux17nVsOmLgLi0ElZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936410; c=relaxed/simple;
	bh=rB5RS1jGXfDDaY17Utrvix35Vv91jLWQVm87A7UPu6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sw4ApmV2bTatc+hVN20Fr2bX3rKX7bHoqe/njAAmCYkhsRUECieo3rUr5GGnXgqsaFmc2S41wkJ/twJexkRCIT7Rq2JCTnUoW0m9vRcpb6ja3ySs4TrW2D08Q776gLBTimLhqongT6wWjJVNUd3yM6efcUjXPpFY3tfh2se2SHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EqchSTfX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F38E9C433A6;
	Mon, 22 Jan 2024 15:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936410;
	bh=rB5RS1jGXfDDaY17Utrvix35Vv91jLWQVm87A7UPu6g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EqchSTfX9GJ6iHawF4eqT2XhUhByxXDu2b+pa4zRp280wdFe+K4NDzVFn2U/dQOUt
	 9A3YeMYtDRt89dvnipPTpQ5H4lEDaijCKtuE6NUyLG3FVi/JViSF1ve4SwkitKJLdP
	 BO1EnvqGu9KzLmvEkjDZV7A/PKguoYRL+/T9HExk65dGHP0Bqulse7fzCHRak6WIEk
	 c6kieS4SnATdfFsKFpQZmO0EVdpzyKHeI+ES4vbEVgaMvu+3tZHsGKJjhnjT/x4SIL
	 J4jtes7B4dturpJef8u+QWIZeBQLUKxQ0xe6b3HPZBwfbIemuCrd+4NQM5FUS2Xf0N
	 PG4OfTdeIiesQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Maxime Ripard <mripard@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	maarten.lankhorst@linux.intel.com,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.15 10/35] drm/drm_file: fix use of uninitialized variable
Date: Mon, 22 Jan 2024 10:12:07 -0500
Message-ID: <20240122151302.995456-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122151302.995456-1-sashal@kernel.org>
References: <20240122151302.995456-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.147
Content-Transfer-Encoding: 8bit

From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

[ Upstream commit 1d3062fad9c7313fff9970a88e0538a24480ffb8 ]

smatch reports:

drivers/gpu/drm/drm_file.c:967 drm_show_memory_stats() error: uninitialized symbol 'supported_status'.

'supported_status' is only set in one code path. I'm not familiar with
the code to say if that path will always be ran in real life, but
whether that is the case or not, I think it is good to initialize
'supported_status' to 0 to silence the warning (and possibly fix a bug).

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20231103-uninit-fixes-v2-1-c22b2444f5f5@ideasonboard.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
index ed25168619fc..5062f13808f2 100644
--- a/drivers/gpu/drm/drm_file.c
+++ b/drivers/gpu/drm/drm_file.c
@@ -411,7 +411,7 @@ int drm_open(struct inode *inode, struct file *filp)
 {
 	struct drm_device *dev;
 	struct drm_minor *minor;
-	int retcode;
+	int retcode = 0;
 	int need_setup = 0;
 
 	minor = drm_minor_acquire(iminor(inode));
-- 
2.43.0


