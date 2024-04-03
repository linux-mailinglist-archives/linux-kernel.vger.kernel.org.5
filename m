Return-Path: <linux-kernel+bounces-130325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5891F8976C8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89C261C2905F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7132C15358B;
	Wed,  3 Apr 2024 17:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3RF+Rrg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B050C433CB;
	Wed,  3 Apr 2024 17:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164750; cv=none; b=WZSnX2POfHm+Zavw9vH57dNcIvu0vGXkITufAyf76wc6iTCvXWX9CUnKaVr6Rf3SIVeZm/tgUmHb0ikO9oxcMIAfWdYPvjmf0guuee7g9ddtAbyj4NzvrnaiWFDCE0NXXqCmsq9msfD5THnS66sMBAFZAD2ZgnMsNZWJy4gRl7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164750; c=relaxed/simple;
	bh=77b04zM3oNqv9H+eXalmP3gDnp2TBRyKL9pr39qzZ0I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZDFU2XhV0UyMeftyzT5u/08ffww+gHhclGlUcWwdDE1ghDU76ELzRtQ979I4naZ2Padw18bq5yq2YN/44/Py0oV0GALAZu2x01zq5BlKjfOl0FzIcXcga+LqNMLN9y8GkZgAkAH58kgLso2dv4nOcLPgjgL4H7emWZF3pZd/0hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3RF+Rrg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 749DAC433C7;
	Wed,  3 Apr 2024 17:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712164750;
	bh=77b04zM3oNqv9H+eXalmP3gDnp2TBRyKL9pr39qzZ0I=;
	h=From:To:Cc:Subject:Date:From;
	b=l3RF+Rrgflu4DB516XN9qGQ+ScWhFlHfCsGt9yrUgTH2q3RZNv1NtMDLnJrht1Esr
	 8kHDlO1e64N1zF87O7wOdcGe0aJYB9k0jQd4i1MWYC4pUoFZ+tLvUTenxmUyK6Yk9N
	 vheEWcWxv4ZqT4G71AjOaBcZIZ35bYevDrt0KKJeHKhp6VEqwtYe2TD4ZhKltcjcNU
	 iL9tmE0I6CP8t6AJPsxBNHPCtDhixt7/y1c6lwNuTTmS3wC4MCmFPwy2/QOZ0EP7sY
	 CwZAqIwy3c6b1z9DgGrtl/o5+Gdy0gfH7E4wqJXoEzz6fuFcZZPtDXCJL3vEAGcrJi
	 X3mCWyuynI1oA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Petre Rodan <petre.rodan@subdimension.ro>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>,
	jic23@kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 01/15] tools: iio: replace seekdir() in iio_generic_buffer
Date: Wed,  3 Apr 2024 13:18:45 -0400
Message-ID: <20240403171909.345570-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.84
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


