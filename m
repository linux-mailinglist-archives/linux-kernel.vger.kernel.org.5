Return-Path: <linux-kernel+bounces-130350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3846389770C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A4431C2094E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04897155A25;
	Wed,  3 Apr 2024 17:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CmmLGj9v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B5416D339;
	Wed,  3 Apr 2024 17:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164807; cv=none; b=P9N/vgmyIde9/EpPAvDYrH5qPJuUvqqgV36Auysi5sEMkbU/p4TRPNOLcFcgrJwGG8Eo9EqBvhhgnwCZobpZJLMkGdFFDDSH45XR1a1eXmQAX0BAO1VpsfzqmVDELkvkLISFOW+URk1g8fDSucA+5qrkIRB5z2rLnBbpKn5oEmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164807; c=relaxed/simple;
	bh=n7saXgpZFFhdB2bpOB45XPxdJLSkbI0Y1Yd6vPZwHLY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TEMXpcaHjSrf8GPF9VC7wUad1rTPuIBetmS68XFw20BoHS/rXBra4J42J3a/5X0mcNG8tCrQXyN+/bWk9oXdd6oG3UC7zobwNQUHxvEyI8halO701qDWswnHOOnoLaYzU/I9Vfm1doykropzhq6ki73WbE6cralPBYtj6sFmO6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CmmLGj9v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 518C3C433C7;
	Wed,  3 Apr 2024 17:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712164807;
	bh=n7saXgpZFFhdB2bpOB45XPxdJLSkbI0Y1Yd6vPZwHLY=;
	h=From:To:Cc:Subject:Date:From;
	b=CmmLGj9vAfWM9iIltFC+Jp74PtPKNuWmp0JHxzncCxkno+ouYT9c2hMT5M5piHTHF
	 0GkK2ib+O/qObYdLEHe/OaG+mCZy20IJDqOYbReb15AJOBPeMfFwOnpXaX4h0+N5d7
	 CTLTk0L34wjYUzo9M0uaHculmES/YLH3VkwY6yZApJ7US6OtfChSbE3q6QWvdijFHe
	 PEq9zbtToNuViQdFvM7faW7fTGJHv6FPq7lz9+pEiIHsFP4FbjOYEmh7vOqF655r9K
	 jXumVwwWnyOShfosVdl4nfwNR+2bJYEwLOKQkXyQ7s3GgKS4rySqXKjuaDzbebNwF9
	 UDp1V/ilBMY4A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Petre Rodan <petre.rodan@subdimension.ro>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>,
	jic23@kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 1/8] tools: iio: replace seekdir() in iio_generic_buffer
Date: Wed,  3 Apr 2024 13:19:55 -0400
Message-ID: <20240403172006.353022-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.214
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


