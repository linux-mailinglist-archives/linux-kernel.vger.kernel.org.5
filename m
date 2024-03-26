Return-Path: <linux-kernel+bounces-120125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F4B88D2B1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 00:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 720FE1C37B8F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 23:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B0213E03F;
	Tue, 26 Mar 2024 23:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UY2wN5Jq"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019D013DDAC
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 23:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711494900; cv=none; b=apDx8kgen8eBV6vK/Cv9qHc8Jkm1ljiWi5kgSPwaIL8b0IP8XOBaP3QeI13zooqlvGckXYCL4eCtTgx5TADj8QuE6PcoVDga+LZChsF7s/P1kK+4kwCGRZhsh83kBM2k7jOSehVidKR24nfp9mCju8t3/WLak0uWbuXkSADmJmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711494900; c=relaxed/simple;
	bh=NzgIE1Rh/KOBzAQ73H3jelY8pZu994zjvj10N12XaqU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sk+eCMulz4HXwp3ANjW8uA5PpzBYckMZ19kgcJ0EG6Q1NktuXARnskv1gmQSaOdweeQRbySkJT/zzNrSyfzGRcQu/Aq/nUmcspcfIwJCu/GoCY+z3gGOPflwrYn0rubaqYBzWTiFg+EZMM24zXI89E3QhhzO6EMGgIFRoWGKxzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UY2wN5Jq; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dd8e82dd47eso8403533276.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 16:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711494898; x=1712099698; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=c2odR+gvA8sNOrt3e0IxQU+kOy08wVxcx+crcuSd5WY=;
        b=UY2wN5JqrC2yw8HwpS80Y4xVE6Il1n9pAhSFKhWuTIwkA340KTr6+kIs7vTKNAKvr/
         ZvfblRcqFmzGsTkjdxHc22p7Vcbpvf/ubbPYYLtlQQVyoGeoPFi5WjCCR42vImekVjnp
         rEM3QI174Zzqt3IYLZhqRH9OPeXzKxBZfwJL5HfuXslopQJInrDdJZiH4eLp4Piib1Ne
         TcbTRZJdpVur081KoaV43X/f0K8jN9F1Jm/jBjeKmHsUtIZronM+bAd1XXg5WbaSNBP9
         D2y4+tL3Be2MUUWdP8SGYHa41PgaDcLgowoVMXTL5rLRfuTEaxPj0ArVT5I9dinVyVJj
         tWlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711494898; x=1712099698;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c2odR+gvA8sNOrt3e0IxQU+kOy08wVxcx+crcuSd5WY=;
        b=VDND2+RBdkpChlIjtxb2Rn9iQaRccq18Nlpf/NW5rXvOdArnslx2F/Jw27lFh6WXVJ
         mYSrjJKpyXyYgQnnXt90UgHfi6xStpwYpGA12JoQGLWOnhal+WQpTc+tASZGM8EySqIX
         Jz8HAnhy1Bu6DoJ2eWpfmfznWDAV6w9gMbZs4OPpbGbKW0Q6FdNkPdafAzjZeb+lsDD/
         9hQ13M+xdLPKjOXM2OSKsTUZjfrbEmYLl3+gvV5uejqup+4NS9vBpGqgYszadshWBgJM
         9gDXAccCL5AEhMiFJklT2wjqAnINqqxnVuXqGAuidwg2NfDxMUprHFnyq9BsqQE64a96
         jV9g==
X-Forwarded-Encrypted: i=1; AJvYcCXiCyQbox83BGgD2kqDPu8mgMdmdhQk6HkLNASmy7sqvcyJy4wcHHnRQCzqyNGFZt5VIltXO4rYfkcBhFQH681IXK2jvS8NR+EF9KOq
X-Gm-Message-State: AOJu0YzxwOo56L6+48Nfd6su1aiq7LKlUiqEbyRcuMR+PYxePWKhjU15
	4zrwdoH/ciSir4gX10fMMNo9SWUMLQrrYSD+Y1hjWct59epq7b918tXWNNhQRel6w81v4PYyupM
	o2g==
X-Google-Smtp-Source: AGHT+IFHYkY4cIWeIG5C7L3cVtTLvopmfj6ciQBc+eUr6sGVUl9PkI+oKLP5GmybkNhRmxFsc0JGuY8yjgo=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:cef2:761:ad8:ed9a])
 (user=surenb job=sendgmr) by 2002:a05:6902:150a:b0:dc7:82ba:ba6e with SMTP id
 q10-20020a056902150a00b00dc782baba6emr629440ybu.7.1711494898139; Tue, 26 Mar
 2024 16:14:58 -0700 (PDT)
Date: Tue, 26 Mar 2024 16:14:47 -0700
In-Reply-To: <20240326231453.1206227-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240326231453.1206227-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240326231453.1206227-2-surenb@google.com>
Subject: [PATCH 1/6] Documentation: rhashtable: undo _noprof additions in the documentation
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: rdunlap@infradead.org, sfr@canb.auug.org.au, kent.overstreet@linux.dev, 
	surenb@google.com, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

With kernel-doc script change to handle xyz_noprof() names, the previous
documentation changes and not needed anymore.

Fixes: 11c91be0e244 ("rhashtable: plumb through alloc tag")
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Cc: linux-doc@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
---
 lib/rhashtable.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index 35d841cf2b43..dbbed19f8fff 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -979,7 +979,7 @@ static u32 rhashtable_jhash2(const void *key, u32 length, u32 seed)
 }
 
 /**
- * rhashtable_init_noprof - initialize a new hash table
+ * rhashtable_init - initialize a new hash table
  * @ht:		hash table to be initialized
  * @params:	configuration parameters
  *
@@ -1085,13 +1085,13 @@ int rhashtable_init_noprof(struct rhashtable *ht,
 EXPORT_SYMBOL_GPL(rhashtable_init_noprof);
 
 /**
- * rhltable_init_noprof - initialize a new hash list table
+ * rhltable_init - initialize a new hash list table
  * @hlt:	hash list table to be initialized
  * @params:	configuration parameters
  *
  * Initializes a new hash list table.
  *
- * See documentation for rhashtable_init_noprof.
+ * See documentation for rhashtable_init.
  */
 int rhltable_init_noprof(struct rhltable *hlt, const struct rhashtable_params *params)
 {
-- 
2.44.0.396.g6e790dbe36-goog


