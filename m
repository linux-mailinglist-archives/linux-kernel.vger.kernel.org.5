Return-Path: <linux-kernel+bounces-115844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D311B88990E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 029B8B32C56
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C88E37C904;
	Mon, 25 Mar 2024 03:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WhBW5FKM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCED2145B2F;
	Sun, 24 Mar 2024 23:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322034; cv=none; b=HLEiUaBDseKuHi+c/kO6PLRRGS3gng00GElcHm6jORVWoyCkk8pPTHsJxPXW1rCDSGJkdDumDXYaRe9Bpl/fwKCDD/2pW811H971oTT/2a9tyqGi0NqNiStQWbkWpaykCeZdpfFbFDKbG9Dg6SI5+17LBIj4HD/3+LOBtCLPHpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322034; c=relaxed/simple;
	bh=ngN9xWqtsFLOKtMY70Ro83f6fR4n3SwhYSw3XqZWPRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UIEvxT55EtYjJ4B8rh1V7cmt4daW7E8S99Oz79zu60+dyTn7YQlvq014dsakDsHhZqC1nLO5iAHISBbKQpIxiSHTwTRreUBP8MmWBiPBuSPG6RnkiFxvRA21iPTy0JfUXE2kuTTo9A7h4A1TlpV1OGu6KJKqk+74g532KrJ4b0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WhBW5FKM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A582C433C7;
	Sun, 24 Mar 2024 23:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322033;
	bh=ngN9xWqtsFLOKtMY70Ro83f6fR4n3SwhYSw3XqZWPRQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WhBW5FKMfADGAtb5Y2sSMG4lSjSxk1Qr9lZKgTYTIdSfq8f+d6x3MHqjwpF2zGfNr
	 NJ1iqALULvn60wXXjTTklKZF6VDMr7p1cENR9ElFIkAbQHLN6Ja6VS72UjE+QozMyy
	 BwE6C61cjL89Fgwhz/fn31sR186ubGuG7USBL62FO/+oRy/XfR/A8DAv7ywJksCtnk
	 7X7Tge9PMiyjTvcs+spXqAVPiphZzCrG3OHtibRlvJw2bPXZ0zm7WHVHPX/Ut0zeLC
	 /jKR6J/EPEZ7JXB86pNjOjRYRi8TtQVWG8uR7K3bzTmxqcZjeL8l+NU9gqusLwQaLM
	 ID0kJoC/EUcpA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jiri Olsa <jolsa@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 105/451] libbpf: Fix faccessat() usage on Android
Date: Sun, 24 Mar 2024 19:06:21 -0400
Message-ID: <20240324231207.1351418-106-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index 377642ff51fce..8669f6e0f6e2f 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -17,6 +17,20 @@
 #include <unistd.h>
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


