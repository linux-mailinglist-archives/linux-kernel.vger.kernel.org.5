Return-Path: <linux-kernel+bounces-125258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9328922EE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 18:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C616128161F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 17:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7F413699E;
	Fri, 29 Mar 2024 17:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aCbZ73c3"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865A613664E
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 17:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711734198; cv=none; b=B425JaRUDfo7qM/9810C4yucnM09dIy+LtU2y1ZZVn2/P6rrVN95FgwrBp4gHCK2/z2+psBheUzSlTjB0GsvbfO/U4PLFutgt9xvkbUq/cGTWxImpjYfzOix/1mwcAqT0TarOswdwlX0Z2zdMnI9lH5XPI1W9UT1dfYqJoFCKv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711734198; c=relaxed/simple;
	bh=Db+baHi+o4t0sQoTiWsOVnUn4il6QNvBEK0IZXfUirU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=kPzz7jJrLM+vXihFmCu0vCEUyAVV4uRJvah2OGw27DeFi3RlGmsGJVcWlmo+mXFLgiJd2MXnUPJVlo1z8fh4w35OhWOgW2DBEbDsofZmdece9oies0ejcFr51MMRPzVZ9MO2FTtrsjfVO3wN7aWPEObNXsWHvrjVGdHWMNBWVp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aCbZ73c3; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5c5c8ef7d0dso1632861a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 10:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711734197; x=1712338997; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y4P2FVE0GZuV8xN0/OHVBz5dTMWkMVwFfht6IsCHyUY=;
        b=aCbZ73c3/Ln/rgHYWSXOIZqEUec/jGXTDZdRrIbsTa984NwET58AEauEI4X+XflxXK
         ZtRpOP11Py69FNDNFynfMz6a+0LhV3nJEZPgA5hVKwSbPOOPmCBdAx/cTvuNrYYY16wZ
         RLdfdyLi+hru5SaQ0JK+ZMySYWSpDpLCjDLUFTi/dtkHG9YgNr/ZYOtAB/WVB9WMkt6N
         7vRtHVRWfBANx+DO8uzlgYmi+puIJLGBV5wtIhiY8wcDvzwnCR/D6s18lL6osdZsnSU2
         iOvWPd8UklUMVQUGV6WFbrqjr5z+iJmE6RrmuiFACvcMJd2stZkfF+GLdXwmhqi9Tg96
         U43w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711734197; x=1712338997;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y4P2FVE0GZuV8xN0/OHVBz5dTMWkMVwFfht6IsCHyUY=;
        b=At5zzRFCRyku+ua3Hs6CLzDnSmxmeO+nBtIpBHUSoKuhfzNpImqDy5Blji16f9zYFN
         l4Ud5nH5RQ6rHx1CDjbjxjA+aK/eu0Tnq+XQPONmaNwcsqH9wnD9RY1Pa+aRZ/ms6MmS
         vkmq90AhVajitydsMUhXVUMeHh5IfXGLHBNppPPi6z3oTp4hbxdLUGX+JaDfbOQbNVc7
         qESqpaMWJbTXLlQVXWdAMJBLkq+C8F/6N8O1qN7zNEgxTtJA6P26wbnaDe5uOJzUtQ7U
         TIx2MFk/VSJdkAshY/4LDQbeP/7Ji97Yn9+VoQki179bhBDwvhZdJp7tupVPwUk6DBzX
         JVGw==
X-Gm-Message-State: AOJu0YwN2wrRnq2nCSw6uG2/BaRI6B2CRImqQkM9uh4LaIGYzkdnlaKF
	SvG53m8tnMnd2o1PivMPPNcqrkxUJO3/Gd8ugCVyrbI2+OwXI/hS+G8FVpmeY/OVuP0CHppaf37
	U+UYde0LGZUw+kGzgOQ4SPO5qf6eT+KEb5UAJaFTTxF0NCESX014yL09FhjsoNaVS9FN1pSZwVA
	w5QVsgGE3GEHBbIbg8dz85pwuSMCvzpVkTt2b7lR+D
X-Google-Smtp-Source: AGHT+IEk3daVAOxTw6ZxgVuNe0bbBjzztiCGBF5zYuViJhnrfrxtU4S3QA/1YszNBdzc0L46hiha467222c=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a65:4388:0:b0:5dc:8af0:ca81 with SMTP id
 m8-20020a654388000000b005dc8af0ca81mr7467pgp.7.1711734195797; Fri, 29 Mar
 2024 10:43:15 -0700 (PDT)
Date: Fri, 29 Mar 2024 17:42:34 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240329174236.2278217-1-edliaw@google.com>
Subject: [PATCH] selftests/mm: import strings.h for ffsl
From: Edward Liaw <edliaw@google.com>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Peter Xu <peterx@redhat.com>, 
	David Hildenbrand <david@redhat.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>
Cc: linux-kselftest@vger.kernel.org, kernel-team@android.com, 
	Edward Liaw <edliaw@google.com>, linux-mm@kvack.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Got a compilation error for ffsl after 91b80cc5b39f ("selftests: mm: fix
map_hugetlb failure on 64K page size systems") imported vm_util.h.

Fixes: af605d26a8f2 ("selftests/mm: merge util.h into vm_util.h")
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/mm/vm_util.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
index c02990bbd56f..9007c420d52c 100644
--- a/tools/testing/selftests/mm/vm_util.h
+++ b/tools/testing/selftests/mm/vm_util.h
@@ -3,7 +3,7 @@
 #include <stdbool.h>
 #include <sys/mman.h>
 #include <err.h>
-#include <string.h> /* ffsl() */
+#include <strings.h> /* ffsl() */
 #include <unistd.h> /* _SC_PAGESIZE */
 
 #define BIT_ULL(nr)                   (1ULL << (nr))
-- 
2.44.0.478.gd926399ef9-goog


