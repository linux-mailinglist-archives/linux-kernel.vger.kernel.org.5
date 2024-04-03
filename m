Return-Path: <linux-kernel+bounces-130274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D372E8976D6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2EABB2CE36
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11173152E0D;
	Wed,  3 Apr 2024 17:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BiviCzas"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA73152188;
	Wed,  3 Apr 2024 17:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164617; cv=none; b=TaReA3EQIPg5Fh3oqKU1THc0oQ2QGZv3edH97P+PN+YC+UcBtN3gIoUY2Qm4raPMPmxXzBsmsfat1puuhObpFVfB6rK7kdmw74WQd3SxxBF+hIKf6OfBWUqyyO3LON9fa3VS3k1vdkcXdQQ8w+VvZxAqC9B+GFi379ujEp68YN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164617; c=relaxed/simple;
	bh=77b04zM3oNqv9H+eXalmP3gDnp2TBRyKL9pr39qzZ0I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G4iHXu4i9Zz2BAdKi+eXQI9dhFtHjia/xwAMo8D9FBSPH75kr+leD81I95AZEiu1aNMvb3cQumW5T3Z2c/4BjHIQsSS5Nl80pwiFXGhOgsQZAd1CXk01JBzbiF/ED5kNwLMNoYtriFKP2djjp20Z/udukiPvmzZ4TTSLLn2IU3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BiviCzas; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBED9C433C7;
	Wed,  3 Apr 2024 17:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712164616;
	bh=77b04zM3oNqv9H+eXalmP3gDnp2TBRyKL9pr39qzZ0I=;
	h=From:To:Cc:Subject:Date:From;
	b=BiviCzas7kbwzTc8HXu7yylDANcifuUtiL2BNJxMhD40Eq4bLf+I3KV72JDIWMBBD
	 f/oPYs7QH/i2pY1z3q0y8zo4t+C4vGOKb1f7dl4QBQUCgqJxmuonJwzItvnGtlQ92p
	 KzmemrgP9XexLVrYyEJcuQQeL1+WveO+Mrwk5FHTNhwbtPONaeCjcUmDDn/zEhnS8R
	 3wOZsA6HEv2y73z1jYdrG0OUg/7xy1Kmt0c5OAWwesqitUxOlKNBWGx6i7rTefNhks
	 Doj9nKDgijcE7RpYJ22Gx3Vl3gPnlPPOhf6kohh3zKFZIBIwOeoKu67/rzA2SZMHOF
	 +AUJ5ie/wMGdQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Petre Rodan <petre.rodan@subdimension.ro>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>,
	jic23@kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 01/28] tools: iio: replace seekdir() in iio_generic_buffer
Date: Wed,  3 Apr 2024 13:16:03 -0400
Message-ID: <20240403171656.335224-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.3
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
index 6a00a6eecaef0..c5c5082cb24e5 100644
--- a/tools/iio/iio_utils.c
+++ b/tools/iio/iio_utils.c
@@ -376,7 +376,7 @@ int build_channel_array(const char *device_dir, int buffer_idx,
 		goto error_close_dir;
 	}
 
-	seekdir(dp, 0);
+	rewinddir(dp);
 	while (ent = readdir(dp), ent) {
 		if (strcmp(ent->d_name + strlen(ent->d_name) - strlen("_en"),
 			   "_en") == 0) {
-- 
2.43.0


