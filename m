Return-Path: <linux-kernel+bounces-109172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B008A8815B2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4237528148A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3FF138C;
	Wed, 20 Mar 2024 16:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GpTm3xKu"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891A6EDB
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 16:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710952377; cv=none; b=Uzxmaz96PH8UJLcR6SZbwK1/mgakhJNygnunLOqGo7CCf+uaLNdUb3gvjFdzKZme5Ln/xX1F1vO63fbTGXj4/VL5uJt3vXtz347WbDKP0oq+kFe7iRe1S37bfowzehmQaIOHBSllFM1Yh5yh4Emsrjx8eoUjYmTTWE1jx1zgibQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710952377; c=relaxed/simple;
	bh=RPvZL/F/5+LZWPkRsGvRCYGU0F/BRfHT875AjHjPcQk=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=j9UPn61aPy7HY3WKapEjIvZohlRoarziw78l3AC1tDYnXi3FDnMp2AhA/VavBdto87n/q4hED+0USzu2gJzSOwHSqzGNLe1Matvm1tjXVcPrLvb6zf1p0pd1508gVbYdPSeHvGuaSRe5o/Ad6gTK9C6qpTrTE6SepuhVe8uSMR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GpTm3xKu; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dccc49ef73eso9015947276.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 09:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710952374; x=1711557174; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PPh3+JK8STaNVcaoNnrH04Bjmq+JVNkjWGAVdUYYJeY=;
        b=GpTm3xKuy410sMKsXDSQGUFIj+rNkFZsErRGI/47uYdGayXTv4rxHDu49yW38OC3pQ
         wmuH5ojL/XEeFlSFhmP9k0unaNCsYYJ/hVXrgintVjT2TmS/halhKarxvlBZbsNGRNqR
         1Tm29B+cGE2yJNXyX1+KAvpFHc30NeLnL/gedZmzQpHjsN/33jReS8WzGXQBxMDqXC6h
         PMQvMHfWbvjyhUFOMuaNes3j4uHoT107GN1gncHvTvRHjNfA6+2x95UBuAfjOxCDz3IK
         f5DMjQGA/qp4P8JM6V9RpMEGz0XHNNAAF9nr0o6Lu8+azN4dSCX5sivDMg2U+cpf18iy
         LtAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710952374; x=1711557174;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PPh3+JK8STaNVcaoNnrH04Bjmq+JVNkjWGAVdUYYJeY=;
        b=OKzq6MNkEvRtbCkiiJnjb1FtwAzitMJGC/qWOtSV31jnp6AfiVlKv+vH03Yg6oGsK8
         aGRvKjQZrxV9PviGlhl/9NCYzPmfZkEuGzx5Oa7bIrJxclNYsVEk6IVw17wdXMJmXq6K
         mJQnI45bCdaOsOCXa5TzZ0GmIlP/5qnuS3FxVfV7QBOCv1o7UUErQI8SQij+ElAi15yQ
         ZbMLs74YuPy9sWVgxfnfm/z5kNYc4XW4jlwYQUZk1w2kCc8YalxkB6GP4YIZnZsfpf6x
         S7RuywW/NkbpubZ9rgi71YRXdBwCeLg/TpNBX+UmK2QgdNZq+i/ehH+s/EZLqlHNSokG
         2b+g==
X-Forwarded-Encrypted: i=1; AJvYcCXKmcZK8rSbd7AXcaiEsmoUfgPwg3GF9MKWbIdYsmbOeULTgL3Ek9xbSGf/1ve1IEfkkWnQ51PLY9xMH8uQ90db6aVRwSHyYlof2VB8
X-Gm-Message-State: AOJu0Yxb/NYUlDr5wXPDfcpcty10jRyx+CMrB4MUTNx9je+91AMuwD2L
	1R2PyVbXSkYSnVUcBlBSmG7BJJ4a6RvDjG4l4+LXUXEVDriFEpKU09rPfsLMlQtk/yr1phApUGn
	PqFqEvA==
X-Google-Smtp-Source: AGHT+IFy9qjZJ8qJt0m0fdcRwFHSNGZaErdUyns14VLHFaZriYh2eKSTtrlv5EWKfPlpoppugb2t3dHqFr41
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:f4f0:8ad8:3c73:cef7])
 (user=irogers job=sendgmr) by 2002:a05:6902:124b:b0:dd9:312c:83c8 with SMTP
 id t11-20020a056902124b00b00dd9312c83c8mr460549ybu.10.1710952374659; Wed, 20
 Mar 2024 09:32:54 -0700 (PDT)
Date: Wed, 20 Mar 2024 09:32:44 -0700
Message-Id: <20240320163244.1287780-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Subject: [PATCH v1] perf build: Pretend scandirat is missing with msan
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Memory sanitizer lacks an interceptor for scandirat, reporting all
memory it allocates as uninitialized. Memory sanitizer has a scandir
interceptor so use the fallback function in this case. This allows
perf test to run under memory sanitizer.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 1fe8df97fe88..74e0b17050b5 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -486,7 +486,10 @@ ifdef NO_DWARF
 endif
 
 ifeq ($(feature-scandirat), 1)
-  CFLAGS += -DHAVE_SCANDIRAT_SUPPORT
+  # Ignore having scandirat with memory sanitizer that lacks an interceptor.
+  ifeq ($(filter s% -fsanitize=memory%,$(EXTRA_CFLAGS),),)
+    CFLAGS += -DHAVE_SCANDIRAT_SUPPORT
+  endif
 endif
 
 ifeq ($(feature-sched_getcpu), 1)
-- 
2.44.0.291.gc1ea87d7ee-goog


