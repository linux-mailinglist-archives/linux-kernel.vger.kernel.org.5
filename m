Return-Path: <linux-kernel+bounces-159767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD7D8B33B6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4491C28360C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42FD13D299;
	Fri, 26 Apr 2024 09:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JeM70k8k"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44161282EA
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 09:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714122990; cv=none; b=guuAtjSw7jaALyPlQ6dHZXSaAlJqo17N9YNp+kvgvyOwDc6sB6XqbR4Y25z/Iu6s+QXC9PAIn1FA3YT0nriyUBNozfllskheLuLBf2nscjqf7M3J9MCUM7n/d05u3pkEITNLWdK8fvsfLalmFL7mRF3tQH7BytrIX8PqN7+LQjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714122990; c=relaxed/simple;
	bh=KYiwra/dNC5/3zOT8JFwQmtny5RJSHuyKSiO/oZAH7A=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Z+kK++b9a0KQZjjj2b8vD6cfs0+era3edhl2ED3++l/mv1Pb6UHvDMgDczvLksw5bCoj2jDSu0eODjtQEFvit8iqGPimVkDcsoNvxMDe/umFEz4/1+RACgNsjFHojYZjd4J8Io+pipjQQ9VyeWyvV0L2aruuDhYg0VixglRoPbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--glider.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JeM70k8k; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--glider.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de5520c25f0so3755734276.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 02:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714122987; x=1714727787; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z4qUs0z4i6uPaM7muqfM7PcNVWD6PVFe9hqtGEfhGec=;
        b=JeM70k8kudIFXTSs07NJXycbeI8i+87s/gecq5BVay7gdiljRgzr6Itl9Vp5OEKM+m
         EpiC+H5cTDSSL4JlDYNOqoKTvcFx+zP9tP2A9ap3qDof7l7ubGQe2WlI6pRWU0R3nnDI
         +oSPeVM+xTYZ7LL5HpSGKKXFNVaE0wMGKw1VAXy6l2dgEYEZVXdntLWUIkrc+DROwLIi
         EzlHH8P2kfqr7f4AVBIQxsxvFtofIKR9lmDWGQ4IxUK8EyJpwhNntQDnyW7Z3pMeMcbd
         tRGWDEmlxR+deTSPwETHB9657tzB/tRyzvFCe9FPe0kwN/4NvKeZjYf7F+lzeZHJtH0D
         xaUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714122987; x=1714727787;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z4qUs0z4i6uPaM7muqfM7PcNVWD6PVFe9hqtGEfhGec=;
        b=nKGaE5w13ISR+0k3k60HfgSAj1em0JV8vCvA2aZJCqjsanqQ4zekHD+wDFDKz0XSlY
         QKvs7wdZxvCPIAzixxiTzp5ddOkowfAyYk49BlImW+nER7/hF8g4UL0FHgf0LHGrDIqq
         XWLLHhjgp6nVLGlaGJZWxNNeBGDcMBJNmj8tNqwzNK33GvZ0xbgcPoCM5mueVfE4w+Tk
         QjdOMi+fe2hu65Z/YBYa+7TwtLBeY/e8NMmScXd0GipMnYldnk59+x0kjobeEndrPuCr
         Juut54gVd+YQBb0T781jm5gsVmuPGIu0JzNmijOADD+R3qR5HEU+QMZOLWULamGPNiJX
         0wug==
X-Forwarded-Encrypted: i=1; AJvYcCXtDCtrlL7Q8s5UAqFSiavKo7plUlLp6ruJwH4vDaMP6IHMtMXEC7nhyiYXq2KRUO6kz5JvLfOzyhHCypy2qVWRONKAB8NLGF1/xyvH
X-Gm-Message-State: AOJu0YxYm1642ud0VV2n2PAJ58YwGeCYUEhjM0J+/MSY1+zMIab0kwhK
	kZ3AZ9pbE7VJyX9o3bFwX/o6CEdBD+CXsV/tTb2SwG2x0q/vI6wEsxIfm1dtcurindb4RCcIHC6
	b6w==
X-Google-Smtp-Source: AGHT+IFih6RbniRf/KkucHRhzDsd/1150aNGtsDTV/xrr69hergLJgqCOsMEVtTenXe2UnAmr7OHlHAwNUs=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:8a7d:cf77:4cb2:f97f])
 (user=glider job=sendgmr) by 2002:a05:6902:1247:b0:dc6:44d4:bee0 with SMTP id
 t7-20020a056902124700b00dc644d4bee0mr202369ybu.7.1714122987146; Fri, 26 Apr
 2024 02:16:27 -0700 (PDT)
Date: Fri, 26 Apr 2024 11:16:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240426091622.3846771-1-glider@google.com>
Subject: [PATCH v2] kmsan: compiler_types: declare __no_sanitize_or_inline
From: Alexander Potapenko <glider@google.com>
To: glider@google.com
Cc: elver@google.com, dvyukov@google.com, akpm@linux-foundation.org, 
	ojeda@kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+355c5bb8c1445c871ee8@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

It turned out that KMSAN instruments READ_ONCE_NOCHECK(), resulting in
false positive reports, because __no_sanitize_or_inline enforced inlining.

Properly declare __no_sanitize_or_inline under __SANITIZE_MEMORY__,
so that it does not __always_inline the annotated function.

Reported-by: syzbot+355c5bb8c1445c871ee8@syzkaller.appspotmail.com
Link: https://lkml.kernel.org/r/000000000000826ac1061675b0e3@google.com
Fixes: 5de0ce85f5a4 ("kmsan: mark noinstr as __no_sanitize_memory")
Cc: stable@vger.kernel.org
Signed-off-by: Alexander Potapenko <glider@google.com>
Reviewed-by: Marco Elver <elver@google.com>
---
 include/linux/compiler_types.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 0caf354cb94b5..a6a28952836cb 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -278,6 +278,17 @@ struct ftrace_likely_data {
 # define __no_kcsan
 #endif
 
+#ifdef __SANITIZE_MEMORY__
+/*
+ * Similarly to KASAN and KCSAN, KMSAN loses function attributes of inlined
+ * functions, therefore disabling KMSAN checks also requires disabling inlining.
+ *
+ * __no_sanitize_or_inline effectively prevents KMSAN from reporting errors
+ * within the function and marks all its outputs as initialized.
+ */
+# define __no_sanitize_or_inline __no_kmsan_checks notrace __maybe_unused
+#endif
+
 #ifndef __no_sanitize_or_inline
 #define __no_sanitize_or_inline __always_inline
 #endif
-- 
2.44.0.769.g3c40516874-goog


