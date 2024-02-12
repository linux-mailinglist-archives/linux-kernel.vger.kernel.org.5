Return-Path: <linux-kernel+bounces-61448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 875D2851280
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DD431F225B6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA19139867;
	Mon, 12 Feb 2024 11:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="ewpO4hV2"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CBD39857
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 11:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707738232; cv=none; b=Kl/ml0GxGHULBeN17JIg9Ibn+Nx+U4apto4PjB7hh5+wU7UhdXFXJs9tDewo2MGtQyMjodUs0xHiqjCXLZLgC+vkcCd8Q1FHNUAyPdVd85jX3PDDuijEC/QBydWkT7oOhZbrMkg0S58zahUrTJzw4n6V6BQuz6feY1FDJwj+gwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707738232; c=relaxed/simple;
	bh=WWCY8TDoimv/wkmildyvrGmdlzFkM/c16PoBudXe0i0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Sch438ky/gPuq6Clo3C3/j/6upHziKlNxOdb89zD7zOESYSoSajfHIs0cl6myvwn8gIyNK77gdg24ESbBwVgsO9cjj9YSDLycE7WsPqqnYhujY4C1b2D0BQxsX6wQnuUYwfIbiUqXjMcDbfP2i1XDQnPJTZwh3UIEFDWTV+8uPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=ewpO4hV2; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a26f73732c5so418384866b.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 03:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707738227; x=1708343027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I0gAmGbUXjHOQ4ZEgMrhCaz+UWFqY0y+vvz1dd+QPBo=;
        b=ewpO4hV2PRVMF9Dk+dDDmIvPJWLdTU2tms285XbOv+qQ6tmrM6O96REC77wfVkRG+U
         IVXZdeP+FleK0HZl7UHkkJ/0w37Sg6EkzTrEOg7SMK70YXIzzbtUCHIxLkRJonpj/wgI
         Ef8MNxrv9D30BCJsbgr131uT0mvDnNO/QeK142EGetAKCMpOqbwHg1kMZyJofJ7AEJ+F
         o0fLY93fJTgvQBgDkgvMYxwzbBfPhZVUCfNTGs+GS3u1dZCHC6t84DzsV6aFySA8IE7Z
         gzQ1qD7mBEztage7gulo++mYffaTqHPoPxFgUssmbNRV7/HbCOKFZ2G1x643s7lXdxGf
         MXaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707738227; x=1708343027;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I0gAmGbUXjHOQ4ZEgMrhCaz+UWFqY0y+vvz1dd+QPBo=;
        b=ZjU3vY3z+IqBctv3SusyQUhhiSZdvHYreNVlGVwxENRNjcDUu+sONTNVDpYMVTws9E
         r8p5ikPPjlCWA5tDiXEj3FkL3fBKyOZ+Kd8K+x5fVKslB5SwZN8JTFEwYLtGppbcbMf2
         fPWpxxe7PljxEj17FDcZihUkYofNsC5HzHzZDhdfWRU5y+0UlkUswBKBzFrSkHfUqMPn
         PSWAoUmx89dMwuAi18kUk2LwpDZI4XicRXlvJfFkjtrU0ya/NHzcDekoHR+daqMlLW5S
         jmrTK2pMij5pL/Wi1FGuS0WG4UOP/ID97plIK9LkGLCz87uaY5sda0e1+jWDDH1Hc/zu
         QZ+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWqnPN4rpvWtafw20W5ctdl22b+QljrODPsQwEFWmnWUTf+dJjxaXPU3lSISXSxZoZLm/V/QubnF2djT8mfnrhHNX/p/MI3zD+GcY0C
X-Gm-Message-State: AOJu0Yxov3zls4kITGO2iWf9RvIBtJ/d3GjacGex+v34b4M7tYOXZnEx
	blSgyE0clxkrq3UjuXU5axufhAUnrh0PqmsxSWWj1sAGNNMDGpL1n9t3yIYGZJxqVQSHD52fPE6
	O
X-Google-Smtp-Source: AGHT+IFWN/ZOM7xCIbOxOrVUCMxIGoaKfGaNR5vMYb7mH8o/3KbZ1faElyK06++7UX9t1+PrSTIzFg==
X-Received: by 2002:a17:906:4ed4:b0:a3c:881d:8a8e with SMTP id i20-20020a1709064ed400b00a3c881d8a8emr2365360ejv.64.1707738227019;
        Mon, 12 Feb 2024 03:43:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUVUxD49mn9Ht8/gvF0UKj7Yi1UxX79cnV5cETqd6PEE+/Ww6q833Uw7pjWnIdyIKNO2nQqikshCl+cJWYLNYsQeookXvppAeok/uP92E0AxjBEsT400RhngsINtHoah0LJ418=
Received: from raven.blarg.de (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id d13-20020a170906370d00b00a3c66ac5146sm122119ejc.120.2024.02.12.03.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 03:43:46 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: almaz.alexandrovich@paragon-software.com,
	ntfs3@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH] fs/ntfs3/frecord: don't define i_size if NTFS3_LZX_XPRESS is disabled
Date: Mon, 12 Feb 2024 12:43:41 +0100
Message-Id: <20240212114341.1736547-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes compiler warning:

 fs/ntfs3/frecord.c: In function 'ni_read_frame':
 fs/ntfs3/frecord.c:2460:16: error: unused variable 'i_size' [-Werror=unused-variable]
  2460 |         loff_t i_size = i_size_read(&ni->vfs_inode);
       |                ^~~~~~

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ntfs3/frecord.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 3b42938a9d3b..5cac06d27bf1 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -2457,7 +2457,9 @@ int ni_read_frame(struct ntfs_inode *ni, u64 frame_vbo, struct page **pages,
 	struct ATTR_LIST_ENTRY *le = NULL;
 	struct runs_tree *run = &ni->file.run;
 	u64 valid_size = ni->i_valid;
+#ifdef CONFIG_NTFS3_LZX_XPRESS
 	loff_t i_size = i_size_read(&ni->vfs_inode);
+#endif
 	u64 vbo_disk;
 	size_t unc_size;
 	u32 frame_size, i, npages_disk, ondisk_size;
-- 
2.39.2


