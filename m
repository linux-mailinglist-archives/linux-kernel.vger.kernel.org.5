Return-Path: <linux-kernel+bounces-112989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C736988804E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6661A1F2357E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656E04AEE1;
	Sun, 24 Mar 2024 22:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dldgVlO6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A553012D77E;
	Sun, 24 Mar 2024 22:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319801; cv=none; b=Mm1J0rBESb9O9e/zeBrM7GtHMSRWJf396s/coX3Ay6phIMxcUhBPcp88en0vI8c8GU6ajiTrEwkAXORZL3trVjeB645fNwh3zeF3nw093cnonaMsE8TE9WemFlUa7OqqnrO0NhnU6VKLgcVjsO2upl7lccjtWUPLPowdYyzuaOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319801; c=relaxed/simple;
	bh=t7XSdAj6yxAQYf5fZv1wzXR8vjQRSTG70d/2KIqw3JE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hdyDZSmKV+jSnJJZKcm68cpyKfGk9+3Lw+w4WgnoUX8z+dB/bG+urP5fEFokXvVthV0GsO9SlxsI9qwUGhm6GQP6Jl1/g1UyYYUXt/+tEBNVQ32RmLnOHjNeTZlGA/OAtjtDp8767akIRrMA4cB4aznv/CLYcKRFY24QquKMQrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dldgVlO6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF57C43390;
	Sun, 24 Mar 2024 22:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319801;
	bh=t7XSdAj6yxAQYf5fZv1wzXR8vjQRSTG70d/2KIqw3JE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dldgVlO6d3w7BZe3Mra8c1lCEHd2cdfE80cASxIwTTi5g7DUQLeWlkHV2QrLTKWuB
	 8AoMbJAZTjUhww55+OX0uBqOF9fMV8E7GyAa3ZCzoALRQEOm+zHDU4IDtRElk0Z7Hr
	 +UcX18ZChFTrixLVyulCL2EPFh2vHMsaxMGoH24w6dyUaFhZiwXfeYzm9gIZc5dLQv
	 r4f6kmkQLXfIDhkMjbT9fNsW28/aI3QKd8Dc9JADFdd0O7MxnEwxx+fPq1yL+/4SkW
	 n0B3YG648Ug4ZaG+VsTI1fhb1ngO1inf66VDJppCnI4u2r0AdphwBl4Y+KMoFVw1OD
	 XAGbNOb51DY6A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jiri Olsa <jolsa@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 102/715] libbpf: Fix faccessat() usage on Android
Date: Sun, 24 Mar 2024 18:24:41 -0400
Message-ID: <20240324223455.1342824-103-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Andrii Nakryiko <andrii@kernel.org>

[ Upstream commit ad57654053805bf9a62602aaec74cc78edb6f235 ]

Android implementation of libc errors out with -EINVAL in faccessat() if
passed AT_EACCESS ([0]), this leads to ridiculous issue with libbpf
refusing to load /sys/kernel/btf/vmlinux on Androids ([1]). Fix by
detecting Android and redefining AT_EACCESS to 0, it's equivalent on
Android.

  [0] https://android.googlesource.com/platform/bionic/+/refs/heads/android13-release/libc/bionic/faccessat.cpp#50
  [1] https://github.com/libbpf/libbpf-bootstrap/issues/250#issuecomment-1911324250

Fixes: 6a4ab8869d0b ("libbpf: Fix the case of running as non-root with capabilities")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: https://lore.kernel.org/bpf/20240126220944.2497665-1-andrii@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/bpf/libbpf_internal.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 27e4e320e1a69..878a0d0b51f5c 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -18,6 +18,20 @@
 #include <libelf.h>
 #include "relo_core.h"
 
+/* Android's libc doesn't support AT_EACCESS in faccessat() implementation
+ * ([0]), and just returns -EINVAL even if file exists and is accessible.
+ * See [1] for issues caused by this.
+ *
+ * So just redefine it to 0 on Android.
+ *
+ * [0] https://android.googlesource.com/platform/bionic/+/refs/heads/android13-release/libc/bionic/faccessat.cpp#50
+ * [1] https://github.com/libbpf/libbpf-bootstrap/issues/250#issuecomment-1911324250
+ */
+#ifdef __ANDROID__
+#undef AT_EACCESS
+#define AT_EACCESS 0
+#endif
+
 /* make sure libbpf doesn't use kernel-only integer typedefs */
 #pragma GCC poison u8 u16 u32 u64 s8 s16 s32 s64
 
-- 
2.43.0


