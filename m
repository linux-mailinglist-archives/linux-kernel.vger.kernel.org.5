Return-Path: <linux-kernel+bounces-130358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7145189771F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D2AA2985BF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4957F155A56;
	Wed,  3 Apr 2024 17:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rMWSA/5e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8640C152DE8;
	Wed,  3 Apr 2024 17:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164826; cv=none; b=krc8y1X7PXpZKlYGmmvWFxyf3tKjEL27xOpnz+Y+TSCylNUOreho+oWXz2DPl7fp360iAUNZ2zLbcNL8CkxbNeRRw7zoPsiS+aBzl4PCrO1Xvb+XRemA85bnvLBoAlM8fDOEjFZWGEt/I1O9dQoB/ncII4s9y2bNEp4dSBwK2eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164826; c=relaxed/simple;
	bh=n7saXgpZFFhdB2bpOB45XPxdJLSkbI0Y1Yd6vPZwHLY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cWWX3s5530RM9cpuUWft3GnafaNBFmVOI+cT2rzhxRw/zlS2Yu/8VboQs6m+kXQdjdX9CDhUNY62Y6mysE7pnoutg08k/PnIzNHzn0J2Bwoa4lxhTmlCN7jbZU986LJSKGcCK7g3PqGNuNGxERWs3IshZlMDi+v2H97L8RVTviw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rMWSA/5e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98300C433C7;
	Wed,  3 Apr 2024 17:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712164826;
	bh=n7saXgpZFFhdB2bpOB45XPxdJLSkbI0Y1Yd6vPZwHLY=;
	h=From:To:Cc:Subject:Date:From;
	b=rMWSA/5ePMuyDQyEBrb1ojwN/gKD8iGhGy2qklfHJRIklsY4XBRAoF5KX7UXl9PVH
	 KKHGefEiekr2wcIUFoisPOMZsP5B3NrjBuFlvelEAkXVZKkOJ18LyDH/KBwq6JYCQ/
	 UFi56Q8MX1dEPlqUK7K1drUsoMZ1fXBToSW1XBOUBvSWabqgXraVDImstuql23FYoE
	 In7fvMlzIWM1GPl2qALa2DH1JaeD9AGnMe+Dpl6PY1WFfdpajHNHeW9v3UFQTE5eH3
	 hI1WuNSv3CkNfasfIvIoz1UkCHkdHHqaqw6mQumlf8rj5GuCLj/lR/rqkIDmV4/4j+
	 XcHKjfMZjGyYQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Petre Rodan <petre.rodan@subdimension.ro>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>,
	jic23@kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 1/6] tools: iio: replace seekdir() in iio_generic_buffer
Date: Wed,  3 Apr 2024 13:20:17 -0400
Message-ID: <20240403172026.353926-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.273
Content-Transfer-Encoding: 8bit

From: Petre Rodan <petre.rodan@subdimension.ro>

[ Upstream commit 4e6500bfa053dc133021f9c144261b77b0ba7dc8 ]

Replace seekdir() with rewinddir() in order to fix a localized glibc bug.

One of the glibc patches that stable Gentoo is using causes an improper
directory stream positioning bug on 32bit arm. That in turn ends up as a
floating point exception in iio_generic_buffer.

The attached patch provides a fix by using an equivalent function which
should not cause trouble for other distros and is easier to reason about
in general as it obviously always goes back to to the start.

https://sourceware.org/bugzilla/show_bug.cgi?id=31212

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
Link: https://lore.kernel.org/r/20240108103224.3986-1-petre.rodan@subdimension.ro
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/iio/iio_utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
index 48360994c2a13..b8745873928c5 100644
--- a/tools/iio/iio_utils.c
+++ b/tools/iio/iio_utils.c
@@ -373,7 +373,7 @@ int build_channel_array(const char *device_dir,
 		goto error_close_dir;
 	}
 
-	seekdir(dp, 0);
+	rewinddir(dp);
 	while (ent = readdir(dp), ent) {
 		if (strcmp(ent->d_name + strlen(ent->d_name) - strlen("_en"),
 			   "_en") == 0) {
-- 
2.43.0


