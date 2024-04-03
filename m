Return-Path: <linux-kernel+bounces-130341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C21078976F8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3AE51C266C8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD7316ABE3;
	Wed,  3 Apr 2024 17:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVbIR+r8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB1C15445F;
	Wed,  3 Apr 2024 17:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164786; cv=none; b=OTgJsmIdtS6sBveLy46Lu+O/PXSIRlO85PTtBPSpeAAcaTTiXtJvlcL5sySeBxWAw6qnnJKrSuH5Pv5PMzmJ7yEqTDVHBjRWNWrwSveVDZ4KoDA1dtiTWsFp+c9DPX7iOogv4NJ4dvz2dGDm3C1jOufuIgE90G3UkilZRA0PatQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164786; c=relaxed/simple;
	bh=77b04zM3oNqv9H+eXalmP3gDnp2TBRyKL9pr39qzZ0I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GGla2lTzWbzheD5M1UXmkqjkxtGmAth1pxbAJkkxS1VVFH9ywA8ys2IWOVKncC25rqdFG25webB+QYuhZaH9lIThV4mRpDtPutFsQvQaAVAj3sTWCBoU5PsnXjerVUjdFUV/X7lCg5pnMHFJN1m9zTIAvOhGsMAr3rZv+VIYCnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVbIR+r8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4202BC433C7;
	Wed,  3 Apr 2024 17:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712164786;
	bh=77b04zM3oNqv9H+eXalmP3gDnp2TBRyKL9pr39qzZ0I=;
	h=From:To:Cc:Subject:Date:From;
	b=EVbIR+r8J0z1LSA6g3ojvDMv4776mo+GBk3H2S+mLRvWJKq2CbNQPRuHuefdKa1qB
	 L20jqlDry7Oa7bIiaXS0WE9UUrCC1v3IuC5Z47fbgBlIYf3c9i0cR5e5x12dNyOnH7
	 aQS9kk0s1TOS74Ws6tOQ21EmPvvc9J8JOorK8uZfwTjJWD/IkdRF6zHBio1rnINw9p
	 No4nsjVkgAeqgQ7DzswNCvxiyah+Hia1b2L5pc5w4EjvL4wHbyDvI9RR5D8xsGF68Z
	 UPJll4oS7ch7RHHdCTqqeBfFRanlxc+zJs0e+YbkXXrZG1xBLIg8twFXqsdebrLZkQ
	 pvo6FswTd/etQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Petre Rodan <petre.rodan@subdimension.ro>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>,
	jic23@kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 1/8] tools: iio: replace seekdir() in iio_generic_buffer
Date: Wed,  3 Apr 2024 13:19:34 -0400
Message-ID: <20240403171945.350716-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.153
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


