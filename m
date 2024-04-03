Return-Path: <linux-kernel+bounces-129715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B50896ED4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EF16B22267
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70FB6146000;
	Wed,  3 Apr 2024 12:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="kv3Y+KhC"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90460141991
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 12:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712147171; cv=none; b=KeM2kUiykgdlBiLVJ7VqpmXLcwhhT00PsDkNyi3d9fDTNjn8sgx5MgwYZuZ94g2VxEyzyhRZxkqXm3c0Gx+AdJJJ8la6sA9HqxNL/8YEhtmCHHBkXWBjNG6RXPkpiLAz9sS74I02L1jJij+dTp7rghM24wG0zgD0JJkVR7wcVM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712147171; c=relaxed/simple;
	bh=C+TwzIv0q7ONt2hgD/9G+JyqyDZ6Vk0qZXSCafE4C6I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=sarEDV8L6CWKoT217MiroHs1DG77GROzQz+Li16pUI6Epz29Po72i3LGD0PeKVGIO4m6xu4f9JJhDTnB+3u5NTodZziKLXBP2sg2hqIcxziA1cFKAB/Co0OHKxwo4eeUOgJwBYIsy6bKUcpLjbH7nxECI6QR5JRBxe0YFeZGa9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=kv3Y+KhC; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e27c303573so13087475ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 05:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1712147169; x=1712751969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=680IOIiYvO7U69q8/3NO/TM8zSL1qJ6oi50wwHypzL0=;
        b=kv3Y+KhCCdxJ/tXae9hD6NuHH8nXalMcD9CXmQiTAd8wM2d1Sq16vqJFUWfR7rRNDK
         5dXeA2Ox/OHF7F+Wog4bpp5q8UZkL+Wj1NrWrcg8Yvp+9hP/Q6ldBNNnGY5AUgeL6u+p
         3gN+cYXKTIVV1IZyrWq6dksu2hKNkMNCY7cQFTjLp4hsWRINlY9nXyy4BqB7Cei3IhwS
         fJ683WM1YOZnzGCTwNGdN16esx3gm7NYNZdzV/m9it9DEU/JZw1CGydptcTmJb7tT8dp
         KGN0F01kRthlKmvGLpwrMjL0I91ScSq/RbGyadYeM4K7OEDBlLRJVEtTALst2R4W+vqI
         Nizg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712147169; x=1712751969;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=680IOIiYvO7U69q8/3NO/TM8zSL1qJ6oi50wwHypzL0=;
        b=k4iIqeF/Ip97qGTfoHwCHVsexsKRGna9Mi8xljG45ojyUYDRVMEpkY2sEnVai2/IzP
         cB5TuUoiHymQaRl0W/PPuHwTOsJPH+j500VQHRgvWPxbG7bdLZc7+rDy1QtgNkVOL05F
         ZRvszbPuVY9mLdEvJd1xB7zHGrsgV3vDaaXSPv6pu61o6zpo+vxSmQoD6NAS19d1hERV
         oePDXrXD91XyotItKlZm4vF17bqIxiU1/tv+qVAaT6x575Y/nMzm5DbkxJVPixoAUPKN
         ONp8zUs416n5UqHNqXBDfQ4D+AoiN8veY9aXMDVxFfWV09re/mAmw1dsaQpc9Eb7Bntp
         FjPQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4VksLmYcuJaLkLxnE49U8pd2e2cviZuscnEUos0ZU2PMwd7Lcc2AZxBIE8u0+wMlJbnDDppbE4RkgQE6Q66Nyx/W2BQcx6fQsT1nx
X-Gm-Message-State: AOJu0YwjCO9NWIIIzTNAsA/ZQVpqJQoLvB8+9JREBLQM0GjXbYqJ+u3j
	0TAWqNuFe2y6zQWcv+VrCTcHelocNmmstT7YnKMDImoVAUjj4xs9kURO8soJFsY=
X-Google-Smtp-Source: AGHT+IE1BA6R9WM9FnWdKVLkzpxYrahMEwc8w8zzEYzMNbHHltFWvb9umn9zs6POLTFfyBTl89xnvA==
X-Received: by 2002:a17:902:d897:b0:1dd:b728:b8d8 with SMTP id b23-20020a170902d89700b001ddb728b8d8mr16254189plz.45.1712147168884;
        Wed, 03 Apr 2024 05:26:08 -0700 (PDT)
Received: from ubuntu20.04 ([203.208.189.8])
        by smtp.gmail.com with ESMTPSA id lg13-20020a170902fb8d00b001dddbb58d5esm13168939plb.109.2024.04.03.05.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 05:26:08 -0700 (PDT)
From: Yang Jihong <yangjihong@bytedance.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	james.clark@arm.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yangjihong@bytedance.com
Subject: [PATCH] perf beauty: Fix AT_EACCESS undeclared build error for system with kernel versions lower than v5.8
Date: Wed,  3 Apr 2024 20:25:58 +0800
Message-Id: <20240403122558.1438841-1-yangjihong@bytedance.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In the environment of ubuntu20.04 (the version of kernel headers is 5.4),
there is an error in building perf:

    CC      trace/beauty/fs_at_flags.o
  trace/beauty/fs_at_flags.c: In function ‘faccessat2__scnprintf_flags’:
  trace/beauty/fs_at_flags.c:35:14: error: ‘AT_EACCESS’ undeclared (first use in this function); did you mean ‘DN_ACCESS’?
     35 |  if (flags & AT_EACCESS) {
        |              ^~~~~~~~~~
        |              DN_ACCESS
  trace/beauty/fs_at_flags.c:35:14: note: each undeclared identifier is reported only once for each function it appears in

commit 8a1ad4413519 ("tools headers: Remove now unused copies of
uapi/{fcntl,openat2}.h and asm/fcntl.h") removes fcntl.h from tools
headers directory, and fs_at_flags.c uses the 'AT_EACCESS' macro.
This macro was introduced in the kernel version v5.8.
For system with a kernel version older than this version,
it will cause compilation to fail.

Fixes: 8a1ad4413519 ("tools headers: Remove now unused copies of uapi/{fcntl,openat2}.h and asm/fcntl.h")
Signed-off-by: Yang Jihong <yangjihong@bytedance.com>
---
 tools/perf/trace/beauty/fs_at_flags.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/trace/beauty/fs_at_flags.c b/tools/perf/trace/beauty/fs_at_flags.c
index c1365e8f0b96..c200669cb944 100644
--- a/tools/perf/trace/beauty/fs_at_flags.c
+++ b/tools/perf/trace/beauty/fs_at_flags.c
@@ -10,6 +10,14 @@
 #include <linux/fcntl.h>
 #include <linux/log2.h>
 
+/*
+ * uapi/linux/fcntl.h does not keep a copy in tools headers directory,
+ * for system with kernel versions before v5.8, need to sync AT_EACCESS macro.
+ */
+#ifndef AT_EACCESS
+#define AT_EACCESS 0x200
+#endif
+
 #include "trace/beauty/generated/fs_at_flags_array.c"
 static DEFINE_STRARRAY(fs_at_flags, "AT_");
 
-- 
2.25.1


