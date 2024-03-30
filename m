Return-Path: <linux-kernel+bounces-125743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BAF892B8B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 15:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4466E1F21DE0
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 14:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC9E2E84F;
	Sat, 30 Mar 2024 14:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kO9j1Rt6"
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5162F1DDF8
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 14:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711807928; cv=none; b=f5PH35t3+wDKzf41F3bzuQ2SGeldiUmjOgLklSjlyIg0hwmCiLgVAfCfhvUWJ/9K4ewznMMD5XMSWEpbcEQn6NzsdpttIAQPsR9xdG9kLJPhCfBhXrHnHvKNclz6SFMN9j8SeE/MvCUfUywLou7foqXaSgDR4W4DaZh4XAf/3NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711807928; c=relaxed/simple;
	bh=72NlypCU3m1Ai+nlWdQqXQ/FhzgDGtzVMmXe9FDsnK0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oQptehjxX5asY9ojeLX3Se1Fth3vWGQmD07/Etv2bRymvzkyq0AzgN3t/cnAvq+AXlqGcvQBxoRVO5y7VHBd/OtaRFwihLt795j/3LEsYy6dDn42DTXz5bHdDKl6Sm2hb4P2TjkOcE+YhnaGJPw5kTlaM4snutSvgBFAcTVmK7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kO9j1Rt6; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5a5508007fcso1476115eaf.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 07:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711807926; x=1712412726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5R0+AkTWI8QZwkAahS3FDyHG9j7KXHmvm4QW/s+hHfA=;
        b=kO9j1Rt6JU6GRsyHJFWfGh0Ervom6Srh6hwFvU4JfhBQClsJBOrd8tO8ue6zwWQ/pF
         3rVqaX29VpwarDNSFYkWF6UdlE3x7zMgxq4/TDeC3b7ZJV1hotttADvXMgIfOxPrYsNG
         WU9xjZrf/rn6pR4bErxbf5kWBl/Tjhy8gK4L4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711807926; x=1712412726;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5R0+AkTWI8QZwkAahS3FDyHG9j7KXHmvm4QW/s+hHfA=;
        b=swWyos7mWE7EPVKW1/Qa/VXUF8jKTcsjnFKw/QZDNe6t92IRskoEN9QEF1ujQHt+uy
         WH50eywKsq+FhTS8ChB+o+i/kgCXjOjg/0YsuWEyrFpcHowMOQSEonQQcMKUVIbu5Fmt
         GqxRffF48YkwOsnSp1dN2EykkWp61i5cK7lV6CLx3FOCC1wUlrwCeVdAfNJRQVPeKBst
         mt30u+D8Ltq4Et0Kvk+qNvPVcCdekX+Lq4KnK0PZKLAH7PNsFF4ACqbCYfWKd/KiAnxS
         1ZjBY4iVBCkqiN1rieZjTli+AeIsp3zWWjNYKtf5mviI9qEBdfhVBOmpfPg6PvdhZ4dK
         bWxw==
X-Forwarded-Encrypted: i=1; AJvYcCXqFYb5dAwiZ3wJebwrUpCFEVf9DB+FxrmKqkhv3KOnweCw78Dc7FNMtTjFPrn/s3E7/Lw8HbOYObCm9/FF0ymVC2i4dgyebOPZ7jvQ
X-Gm-Message-State: AOJu0YzN7CkmCaVO3X5XtQVzC6z70nk2I0Z5IsggzxL61D95T2Xfg8Xv
	FsE85eMDYhkwiUgYy2ScEe3JfY/co3/LUh47ioBfR64UfIiDT85P1D+GPjKqkw==
X-Google-Smtp-Source: AGHT+IEJtzUzuRZgSZPHVHwVuvYRyBRpL8kDmcK5MecWGpcsJm7ruAhRPpLIlgMAXixtWQGCSKy74g==
X-Received: by 2002:a05:6359:4121:b0:178:6c79:6ccf with SMTP id kh33-20020a056359412100b001786c796ccfmr5950622rwc.17.1711807926336;
        Sat, 30 Mar 2024 07:12:06 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id w22-20020a63fb56000000b005dc4b562f6csm4607931pgj.3.2024.03.30.07.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 07:12:05 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Karol Herbst <kherbst@redhat.com>
Cc: Kees Cook <keescook@chromium.org>,
	Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@redhat.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Dave Airlie <airlied@redhat.com>,
	Ben Skeggs <bskeggs@redhat.com>,
	Timur Tabi <ttabi@nvidia.com>,
	dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] nouveau/gsp: Avoid addressing beyond end of rpc->entries
Date: Sat, 30 Mar 2024 07:12:03 -0700
Message-Id: <20240330141159.work.063-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2226; i=keescook@chromium.org;
 h=from:subject:message-id; bh=72NlypCU3m1Ai+nlWdQqXQ/FhzgDGtzVMmXe9FDsnK0=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmCB2zFC4lHA+jf2TBWjM1ztczWQiNIUhah6PlJ
 NpV613q9s6JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZggdswAKCRCJcvTf3G3A
 Ju46D/41X6YPEmbiOsUB+J4DpwOnPKKcWsCj004G4gCAGXDcM6V+h7frx+gzNYT4Rf8x4XsR+Jr
 rQie9X4uNZp2UqZjv6FoMoJ/4Fns8PwbjLF+l0gB/Fb9vnxXhMacWym6B8w+PswdMS16W9pSaen
 F5Zs8+sTbvHAaRXn3iZCPYx6ui3LhmHpqy/e7+pHVKnrj4FCMPmAuZYvV4anVze9FSq+nPmoFVe
 4z1zpNbj5Nty9xbyRYWwhQNfAB8YuZpgDUGoG1p2AdiphqV77NP//zHYPcHsfgP+y0JIz/5BUxR
 Lp65/01z/jPpJyAivKhVM2pvS3aEM7N8bTOuAaM+rtB1V3deWraWkypkkJSwRAtdxUTiXrnbr3Q
 zK1KtBGo7BRK6DVc03milid8NDHuHnIwNJM3w+/h3ePn0NlvlmBD9bJLoAajAl/hlrYTzTAak2Z
 VHzHA0SQ2Vhn9Etuq2ipHNQhNVT3u8txxcSJCBr6Q6RBWkaeHS+IXH4DIwvKkwbcmc2SZ7BehHC
 gecHXXvfcvmvsbcNQnJHTKr0dZmjQsZkf7YPzVfhrYvzU33RIoADtfHAmcVTQXZsVqXFZq5PRjO
 3LC4+FeijavF4l/RRJPr3Btg3mW8DmycJkmfTy3BiYHrt1lxWF488MN0zrq3NdSq2+JfZ8KkBrh
 pVR23AZ tcRpXu8A==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

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
---
Cc: Karol Herbst <kherbst@redhat.com>
Cc: Lyude Paul <lyude@redhat.com>
Cc: Danilo Krummrich <dakr@redhat.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: Timur Tabi <ttabi@nvidia.com>
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
---
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c
index 9994cbd6f1c4..9858c1438aa7 100644
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
2.34.1


