Return-Path: <linux-kernel+bounces-114121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B8F888F48
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F5D81C2B86B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6F223E431;
	Sun, 24 Mar 2024 23:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TLnZ6B7u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30B2202392;
	Sun, 24 Mar 2024 23:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321427; cv=none; b=Y8Sc2fI705jSx34k3PXyRNcNra8CD8pF/ttqJVTi/jQPLuQ9gh8iexkV5LrnLeNkiNf46FceB4UUrKNiUFiWVVZcMsa/vp7sV296pqE1u0JQbU5qXT/zawzA+cc2YOU9zs8SEi6YxVD1VsZXWZLx4P4NnRQWOX887bj55ZCJZTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321427; c=relaxed/simple;
	bh=OkXGC5MFg/57UAjfdYlyaez1Sc+KpouGnh0grG91cqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nLqvU0Axjq29s7sU0W7MSCCOdoZbabBWxSp7NcDBCMeNNzzpaeGk4yubOCgMa6PBqd3vHhH8XzxeN0PqZqRQhKTv4QXAD7XfQaPQrQrf2sWJcO8luEPk+krM301r/zbugPJJ96AFISJpjGyAYoYqD6QG5CyH6TAkPFuQ73fhUZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TLnZ6B7u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7724C433F1;
	Sun, 24 Mar 2024 23:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321426;
	bh=OkXGC5MFg/57UAjfdYlyaez1Sc+KpouGnh0grG91cqo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TLnZ6B7uJBR7+zqDqg/upQJADq9cC4m01ieIIfrq2Yv7nHXGUIYpEkpG7RzQEyv/T
	 ud1z4hvWmqGguJIp456VCcOqajjenRZtOmuI/R/AMepW80jE9EjX+Zt51BtQB0XUJG
	 dCmB7qFnh3puz36CCa8qXJKkTU6I8Jnv3J0dt7NTjUEEVUzO8cyHhmrk5B0BPWp5OT
	 ktkF+7s6QbamY4tb6tWw717cAlhLmIkKoSVgMcJN2XQVPJjXlU4jPkyTP2szUuJE0F
	 91UL+xfz1KORjDkjOLGyfc6KrJ3raMJQvriBV5hd2ahVVosAHFfZP/oz0+CiDA5o6F
	 0dBUrstJ5LviA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jiri Olsa <jolsa@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 150/638] libbpf: Fix faccessat() usage on Android
Date: Sun, 24 Mar 2024 18:53:07 -0400
Message-ID: <20240324230116.1348576-151-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index f0f08635adb0d..57dec645d6878 100644
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


