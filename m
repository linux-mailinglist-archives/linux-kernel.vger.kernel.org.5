Return-Path: <linux-kernel+bounces-115400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B64F889B5C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C5211C34426
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FD8200A3C;
	Mon, 25 Mar 2024 02:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yanuz5BU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26C51D7929;
	Sun, 24 Mar 2024 22:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320608; cv=none; b=DncIEXAJEfUoRbKZpapS/f2QJxvflkEymWkOqlDw/kkZTzElZGg2WMVkYo7IIdVdTdoSiRS9MKKNgwzFiETOR/wBMR+o2q3NefDY57p/x2DcQEYq52A+1bF5E0phIlQBp0JVpqWOX+2AiuPeZimZ+kxcQytEDAkbqtRSar8yrzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320608; c=relaxed/simple;
	bh=OkXGC5MFg/57UAjfdYlyaez1Sc+KpouGnh0grG91cqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kEhfzyB2HeSvU27FIs5wqddTHrJpcVZKfW7a2A1xR+JIHaQWdLnQawuq7cBKmG6aPrY+6HDbjwcw4ZovGPlirjwyA6wYE70QMORoGvNrDLSIDLFtT7JT0ssGTSygdZL/WRf0+5qLc8UgwNYfYICvbHrwj9/jWUmDDSKhIxCeMQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yanuz5BU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00D00C433F1;
	Sun, 24 Mar 2024 22:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320607;
	bh=OkXGC5MFg/57UAjfdYlyaez1Sc+KpouGnh0grG91cqo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yanuz5BUL5RAXzVyZ0VdTShUEhTUBhD1YvReOwLuVNqR/k1y9cQyaHCEkGqdq85x6
	 n2By8Wc4+Pdt68Y9jIewpI3MYf71BlaQ7P+075bEtH1caBvU6NvEI5o16HdX3jBz6u
	 +KbfVPF+mexbWQH4ZCRpQf7L+p0plzNuBV4TY4o+qZl7z4wycZl9DIalaTUlddgqiJ
	 u1ipbk3Ioz+QXgZUHXCzXR7aT8UJ6gxgQh76yy0hM9OHh5Dr0uq79eXPOCFPpCBSne
	 tUsALgXW8nqtuE/SgJqULJrj24hSb5RiVAosr8wEbKOxtiejtjkde67v8MUTKyckw+
	 jPUznFJM+2iCQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jiri Olsa <jolsa@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 168/713] libbpf: Fix faccessat() usage on Android
Date: Sun, 24 Mar 2024 18:38:14 -0400
Message-ID: <20240324224720.1345309-169-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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


