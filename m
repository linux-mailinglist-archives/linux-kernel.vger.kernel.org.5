Return-Path: <linux-kernel+bounces-33530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 938E0836AD3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C21721C24ED8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D401482E0;
	Mon, 22 Jan 2024 15:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y16tZC94"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E051474D1;
	Mon, 22 Jan 2024 15:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936637; cv=none; b=cM0iodpoyuDPOz79DrZUOaY5f8xGYVXUp0V/u2Bh8fLjh8HfRrKzQgVKvdbxyYMfAGD7QgX8vpQPDjfO98sqZ3HB3a9K2Z9SVrqU+UQWfLTnZE9S/nMisAg/fEq+Wt8VAx7Hglla9DryU3q5RugL/jph9ItCNX5IlZoWPZoaQtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936637; c=relaxed/simple;
	bh=4qfjbcOA7Zrel+cu7YxJM2gsE3yKvkJzvU0GEAB2k/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z4tyutDH9Sq7unXWn9SiQeHbImbje1DRHzW/OMGitTVX4FHOaWZBHXIufOYM+8jvceEISYdn28CNro3B+IE8nDFALICBxPwqE52lz5Bi8i/FIMAy709aRilYuT+ynlJposgFfNgcM64FYwkVdRSuWjcpPgMRLcVB1FnMVCMNy7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y16tZC94; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEED0C43390;
	Mon, 22 Jan 2024 15:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936637;
	bh=4qfjbcOA7Zrel+cu7YxJM2gsE3yKvkJzvU0GEAB2k/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y16tZC94BNIS0sZKgch4HLpMuKkJ/utwwqRxuzpa9EDJpG0ohGTI0FJGA2hT8T1bn
	 8XvAKNNMKMn/o/mDaHHpT480uKc6DOTxVEXi6eD4fsdizri2aEDWktInFbtErkXa8q
	 tdYFdXpsmiYTfKN5bdGAcm7+knQ3f40/+lZBbkxxiEBzwQZHjJCKst0HfsKNc7kN8g
	 wftfajoV8/W5yxI+KUFGSYyg+zyIBitmuV3HdTRXd24LwJzLZTh7xHq3OVyKPMTTuU
	 1q8a82Qq0ddfVIEvOQNaQDjn0jrhOpZhnU11DncJFalHf67lWaDNRcfmvgaDr59Snh
	 IMbSyEjYdkO2A==
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
Subject: [PATCH AUTOSEL 5.4 07/24] drm/drm_file: fix use of uninitialized variable
Date: Mon, 22 Jan 2024 10:16:21 -0500
Message-ID: <20240122151659.997085-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122151659.997085-1-sashal@kernel.org>
References: <20240122151659.997085-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.267
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
index ea34bc991858..e27a15a6fe79 100644
--- a/drivers/gpu/drm/drm_file.c
+++ b/drivers/gpu/drm/drm_file.c
@@ -369,7 +369,7 @@ int drm_open(struct inode *inode, struct file *filp)
 {
 	struct drm_device *dev;
 	struct drm_minor *minor;
-	int retcode;
+	int retcode = 0;
 	int need_setup = 0;
 
 	minor = drm_minor_acquire(iminor(inode));
-- 
2.43.0


