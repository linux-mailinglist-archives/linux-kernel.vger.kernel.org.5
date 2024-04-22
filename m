Return-Path: <linux-kernel+bounces-154230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3EE28AD9AC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 01:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30F161C21239
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 23:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64052157484;
	Mon, 22 Apr 2024 23:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iE5aiybu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3CD47A6C;
	Mon, 22 Apr 2024 23:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830071; cv=none; b=oDEccHiSVLeWIAIXcFnYYtIDkdV5f74qNUE6LRU9MgAaBHBBkYedLXjKyIL3DxnFaMbeWeP98Z3QjC4EEUg89jxu1fE8XIkAmFJQxUsIGCaCP0L7vtFQRMhirIfs5M/172Ya5Q5JhDOHWTS+8JdLy2iyCTqI22ICa+TTmHfOt/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830071; c=relaxed/simple;
	bh=ZRTOCKMpkWvx3OoM+8EFdF+tjxpKDAQCkOieDMhcp0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y/mYCPCAUTHkXJN9MQ2BIUhHxH2GLJp3pvM4b3aoXfPtnKNFlExlN/OhTgItDctphlkiUSqyXaiHITTjqXd90MN2F8BgRvTMwnjlmm4dbkFsId2aUnqgp86jIkPSP/PeXTWhXycWEATTiO37DzcnJi8JDINhCHZ5sTL/XoqIzuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iE5aiybu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF78DC113CC;
	Mon, 22 Apr 2024 23:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830070;
	bh=ZRTOCKMpkWvx3OoM+8EFdF+tjxpKDAQCkOieDMhcp0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iE5aiybuhHaCpnF0AJgY+OS/eXFH2ekSFNcTgyXwDgFPr6tr+2c10n8o7CZu7Zxr3
	 FQeyND3QQmO/ZV6vrFgQwg0iKyPANHtwiIW5FqKJUNWWCv/2zqxypftNT3f8JcLGLp
	 yuaxG7bbGKLaeAJ+I75zp2x82roHw3AfDelB7rmdlWhGNAry2C3/Glj9+C9E/ZyUx3
	 WIfoiGtkbpejTeADYiE/4SXcOcYDKTduI+DGxWuc3hwjQdFd/iSHBrk/ORZYqwXm+W
	 Me0aMPM0sDjyKxQQ2xC+0OakKnVPGqIreIsAS0CkNSf2+GlvHrAnwH7a4/sO5s5qaZ
	 rG1gzcrj0jfdA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Danilo Krummrich <dakr@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	kherbst@redhat.com,
	lyude@redhat.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	airlied@redhat.com,
	bskeggs@redhat.com,
	ttabi@nvidia.com,
	dan.carpenter@linaro.org,
	dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 13/43] nouveau/gsp: Avoid addressing beyond end of rpc->entries
Date: Mon, 22 Apr 2024 19:13:59 -0400
Message-ID: <20240422231521.1592991-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422231521.1592991-1-sashal@kernel.org>
References: <20240422231521.1592991-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.7
Content-Transfer-Encoding: 8bit

From: Kees Cook <keescook@chromium.org>

[ Upstream commit 838ae9f45c4e43b4633d8b0ad1fbedff9ecf177d ]

Using the end of rpc->entries[] for addressing runs into both compile-time
and run-time detection of accessing beyond the end of the array. Use the
base pointer instead, since was allocated with the additional bytes for
storing the strings. Avoids the following warning in future GCC releases
with support for __counted_by:

In function 'fortify_memcpy_chk',
    inlined from 'r535_gsp_rpc_set_registry' at ../drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c:1123:3:
./include/linux/fortify-string.h:553:25: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
  553 |                         __write_overflow_field(p_size_field, size);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

for this code:

	strings = (char *)&rpc->entries[NV_GSP_REG_NUM_ENTRIES];
	...
                memcpy(strings, r535_registry_entries[i].name, name_len);

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Danilo Krummrich <dakr@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240330141159.work.063-kees@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c
index a73a5b5897904..dcafbb2004ca2 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c
@@ -1112,7 +1112,7 @@ r535_gsp_rpc_set_registry(struct nvkm_gsp *gsp)
 	rpc->numEntries = NV_GSP_REG_NUM_ENTRIES;
 
 	str_offset = offsetof(typeof(*rpc), entries[NV_GSP_REG_NUM_ENTRIES]);
-	strings = (char *)&rpc->entries[NV_GSP_REG_NUM_ENTRIES];
+	strings = (char *)rpc + str_offset;
 	for (i = 0; i < NV_GSP_REG_NUM_ENTRIES; i++) {
 		int name_len = strlen(r535_registry_entries[i].name) + 1;
 
-- 
2.43.0


