Return-Path: <linux-kernel+bounces-125304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2028923C3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 19:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E54371F228C0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 18:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0678B12A144;
	Fri, 29 Mar 2024 18:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nsmaeifo"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E615F3B293
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 18:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711738709; cv=none; b=E/muLAtPnGMjpucB89GAlkrzZtxX1OyS7XWBIcAZrV76yORem4AtljbMoEzF7P7dda3qCneLzQ2G1GCkuL/B1ymfZcAPBubpbn4rP4h0AjcGZvw6RcZS09gAiTcXvumEVqBUTFxsWXXrehPHKeKV9HkQjNIO/eAWDPP6RK7dPRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711738709; c=relaxed/simple;
	bh=TZwuVTutyuYWS/hRX6g2t+0lQdgDJNCLshkGhJvNRDI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ctmavl+C3MV82tFEwUzr+c4Jo3D5QzD0Ki70Mxj11xUlC96Ydhk7CxbC8KeuMqTP99VoymPoG94ylwnWkSliTOZWddDP38Dy8UphgNhpM29W7W77Uoi9SkeR6bRbe4mWlm41Nyncx8AhvckQZTrqraPwdWeNUNRjPXon3HGLk6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nsmaeifo; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60a2386e932so41761347b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 11:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711738707; x=1712343507; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W6jpWkrIAWPntOGVPlX+CoN3n1daGIwh5z3zUFqEtOY=;
        b=NsmaeifomgPWqx7c6f/v9AKpV8Efgzjdw3uITCnCAt7NLceqiXQcRL21fR8tSEVP4K
         Ec7VXhW5Ch98jQXFpQTihhKzro5yl29ruXk3s+lBSbb/bPQhyl4DoEFtRO0glqHUgkKs
         3TPWFr0LkDdkG3LqzygbY+gWmqtP2XrXIOCqVVG0P+22KWEgRvcz7VBWHPatK1rOI12H
         nKI3wicAWp5lPmXQaAMaYoIncyNbHTotfDn0pmz0Dr+ooeDoOYQjf1x6WzZUo4BgZiza
         HKSByKitxmyMOkFwt80b/E5uyEuaPd14to9BPVAhWCYn8vELyPORRTLjuVAUXRU49lRc
         79Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711738707; x=1712343507;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W6jpWkrIAWPntOGVPlX+CoN3n1daGIwh5z3zUFqEtOY=;
        b=EvVrcLlQ5YZPr7nCwMgYxbg9UTUXBDymbYqW27aFT1GzyVMYi0vyD32WtxsLx0DFuC
         m+/PPAkbzdGv8cP8dUq+2JyNVMNw1Nj/uphnoEHr/B3FWblxv9KH2nUmLNVI+os4xFBC
         Dtp1HJ5lyn2/xX1keiAARFLwc2Zm9trFaKPNhCKfDmuJAGgI7+bx6wtj4PCvfgVerIVB
         gTV8CW+VvBqOq4xPmWr3pKFSQ0w22MD/Fpv+sNmbe1nmME1pB+vqDMXyS81Wz0G0IU1M
         W1WV3pWgpm4hOvkhAO7Gzu9Pzqs0PWvSAJPnjL9YkpiK4QxhZoS0aIEYIFa2jsbyX1Nh
         pgmg==
X-Gm-Message-State: AOJu0YxskfUo4eiAzVcMAIUubdpy/TgvCNpIUbcZOBhrFXl6SmjR8qQ/
	63F/S7nkXdTXvaPF7ajWfvAfroWhkYso9w/bN46D+INllgwgHml71j/IM3KVpA5T1/gz5TKS/fF
	/Js8wqxb6F+xHgXWH7SHLzQXJWOZYYMERI0nkrX+830rBSrh3rF9kGRK0yZtoypjVcAIkW3Xzwt
	BjwcleVorbH5FsB4dFp8i9ADqPvEczYVA0fXmswEaS
X-Google-Smtp-Source: AGHT+IFFFQ81uVFMy2JFSqiJ92NRr3e2zklngl/rFoikve1UjEUR1bAtgZavAMWyXRRu2Nmkm6XBrFE1SoM=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a0d:e28e:0:b0:611:9f44:3d40 with SMTP id
 l136-20020a0de28e000000b006119f443d40mr811961ywe.1.1711738706411; Fri, 29 Mar
 2024 11:58:26 -0700 (PDT)
Date: Fri, 29 Mar 2024 18:58:10 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240329185814.16304-1-edliaw@google.com>
Subject: [PATCH v2] selftests/mm: include strings.h for ffsl
From: Edward Liaw <edliaw@google.com>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, Peter Xu <peterx@redhat.com>, 
	David Hildenbrand <david@redhat.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>
Cc: linux-kselftest@vger.kernel.org, kernel-team@android.com, 
	Edward Liaw <edliaw@google.com>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

Got a compilation error on Android for ffsl after 91b80cc5b39f
("selftests: mm: fix map_hugetlb failure on 64K page size systems")
included vm_util.h.

Fixes: af605d26a8f2 ("selftests/mm: merge util.h into vm_util.h")
Signed-off-by: Edward Liaw <edliaw@google.com>
---
v2: s/import/include and clarified that compilation error was on Android

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


