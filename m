Return-Path: <linux-kernel+bounces-114588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EED889076
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 009561C2C3A3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48BE029CBEB;
	Sun, 24 Mar 2024 23:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M8Hdhj0j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAE92308BA;
	Sun, 24 Mar 2024 23:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322230; cv=none; b=YYt19QF+XJ9T3iibt0yorc1eYa6IHtyA0NtaOoJn66RG2zk5NEXnSIH7SElaLdeu7Ko8zb22KRefAGFHA9lq3+OMAMgMV/FAtLfFtRn2JsmNhR6GIXdgqkliLhMkA+Rvsr3MDcJNAMgkYT4kVMr8oaCgpro7vvQOUb9xfbpWT6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322230; c=relaxed/simple;
	bh=MSxCy/4TxfYruyCaWrEQgACwt3pBEGbUGmPsGDUWZeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dD5k5tBLY9sKPZl79UQ6suSAXgGgaxn1xaGLsxPj2m0nKmASUmrunesaL7Hmi2cuF9JZM7AWOkRfpN4Jt2kSYuXlZCpmrRLpbLtDaOsH/RfJh7NSw7dWOqRdUASc0efCSjoAd3xyWmyh8KqQq3hsRTrh9BVRqrpaEThBDSBruE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M8Hdhj0j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEF37C43394;
	Sun, 24 Mar 2024 23:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322229;
	bh=MSxCy/4TxfYruyCaWrEQgACwt3pBEGbUGmPsGDUWZeg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M8Hdhj0jmLkprMQQ8ksOkmjMWwzJggfok3yIceNp8T/5dZJTIGNPrNPqtdDqgCzYe
	 b0b/ERQlB7MH/l+q3RWeQusEFd47G6z5rE6LDAg6YR0ttHU2rAfVT8e7+DIn5bpbru
	 vhe5MTHhHZHMgl6xddHEidDSLEzYTYTLbQONoySXHSKx8kSq6lc7VcmQ3qwlDq23P5
	 F/ia0BTHM7Ygik21WGjkye+WkyCm15sCqG0hDhLh4gXCgaXqa32lNkN2TwqYMFBvH6
	 +7tMZxJycGsoup8Gkqr9pDbrHgLeLnzHrXTqWlSR495dlMcrXMEbJ2y/GLbaDXe6jO
	 4r1+p2GngVPow==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 310/451] drm/tegra: put drm_gem_object ref on error in tegra_fb_create
Date: Sun, 24 Mar 2024 19:09:46 -0400
Message-ID: <20240324231207.1351418-311-sashal@kernel.org>
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

From: Fedor Pchelkin <pchelkin@ispras.ru>

[ Upstream commit 32e5a120a5105bce01561978ee55aee8e40ac0dc ]

Inside tegra_fb_create(), drm_gem_object_lookup() increments ref count of
the found object. But if the following size check fails then the last
found object's ref count should be put there as the unreferencing loop
can't detect this situation.

Found by Linux Verification Center (linuxtesting.org).

Fixes: de2ba664c30f ("gpu: host1x: drm: Add memory manager and fb")
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20231215093356.12067-1-pchelkin@ispras.ru
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/tegra/fb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/tegra/fb.c b/drivers/gpu/drm/tegra/fb.c
index 9291209154a7a..a688ecf08451e 100644
--- a/drivers/gpu/drm/tegra/fb.c
+++ b/drivers/gpu/drm/tegra/fb.c
@@ -166,6 +166,7 @@ struct drm_framebuffer *tegra_fb_create(struct drm_device *drm,
 
 		if (gem->size < size) {
 			err = -EINVAL;
+			drm_gem_object_put(gem);
 			goto unreference;
 		}
 
-- 
2.43.0


