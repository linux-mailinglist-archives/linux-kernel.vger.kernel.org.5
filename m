Return-Path: <linux-kernel+bounces-47783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 954928452D4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 299C12941C1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 08:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1119915A4A1;
	Thu,  1 Feb 2024 08:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bEBBu6Qo"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8444D2E842
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 08:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706776523; cv=none; b=pVSLoRUj1fq7pDbmNqZ3LFP7OGuzLhRCzkCh+dNZHV0aghlePX2zbtPD/iMZ53Ig01J1yWJawc9TB8bfoXzwgIhpn/nJDXsUgjC/uNZVXWHOPVV7UJCyCcZ4vc93xU1O7FaxU0BttYmACSzESN79e7xCZOuEKIqUGaa+/OILzqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706776523; c=relaxed/simple;
	bh=iHyEQ2KXdIyR0Q46AEjColJDwQljhOsmrS2qirjC+9Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=DxNRpwSg3krKzetXwnhLnm313v+alu8OMJKINMCmiwwkxzdLFnM8slL2rqpRjhUuud66avBVyf1bzNj9vzx6HOtlkfvBvLnnJIm7vO4CijqZG1wodv1SLqD5WvvHH7O89EPoK+0sfa5Uph4tJAIqXjd4Etzp6EJRq4U2UIJbYPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bEBBu6Qo; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-55f20f0013eso342763a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 00:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706776519; x=1707381319; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yDijPStjyNK8y9wipx4jasC/bHAVPAFiOvOL8ps5ECY=;
        b=bEBBu6QoutCoqsLWpsngjv+oo1yNFPTXbsHeqVzC7HM3RN4rH1SnXEq29VItKpzdjO
         K7TnMqpRcwhLXX1L2Fvip1yZ8I9sLg4NExhCzEzXynF6Axsde5Frve/XzJiyozAhcPvv
         +dV+vjalQNWfniGr9du8JuDMtF/qEEXVOan5eynlIhxLjaMEpLWYv9OtYicw8LaCdjuP
         g12Mafv3mW5x6ymVg+bYFPLTbFqIyfStQJ/jJtLSq0PsQUrj2Qv/PKl8k2lxTDw/FQ7R
         ttc2KqWYhigd9wb8ai8bA9Js1BZnCFIvROvd1IHW7PopvfDrx2z0HrC6bAndYgsj/4K9
         NmeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706776519; x=1707381319;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yDijPStjyNK8y9wipx4jasC/bHAVPAFiOvOL8ps5ECY=;
        b=EyN/63UoocmDtTBI/htpswll2fXMeHpMstqO6LOjJxp3DeeC10nLD6N2tsAmboL2gl
         FbEy7oqByLKktuvfYJYgCv3I3/D6p3xUBexPi/R40LJguSgpAN4G0IzAGLH/0p0u1g/1
         YEvH8IFsmoCkXiu6hgoPlmmq6kNvug+1bp/ZiZ9K+H0NLd5NB1240VQV02fOCQrEy50f
         3Gv4rV0GidwyESYHTonsaiHAnuSBsQlRpKRru8R+97MzXARaagYii2Jw2hxkMtYnOf0I
         q+g+u5MKcFyWgH1UiOeJ1PaatrA4QtoY48M8Nj9rSqeB95+yE4CePPjq3k1f1C/1fRab
         9DxA==
X-Gm-Message-State: AOJu0YygyCx6zRsN9GW8wsOn1/JDj/1OJcYh5tkEOO3HbSBeblf7IqBl
	MIP4rMO+NeYsMahwLng51llE6TzaEAPcxcpJEO7LxkutvUJ23iSLgV75vU7vGlTMi1NYjw8G1g=
	=
X-Google-Smtp-Source: AGHT+IGpYlrXxQ4pf2SgD9UFPN6gxoK9EQuNzVYVVNI/PX8RZh44GlCTq+L5CxRmI95uHiD5ihNh0Vw0Wg==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:c945:1806:ff53:36fa])
 (user=elver job=sendgmr) by 2002:a05:6402:44:b0:55f:2bd3:a896 with SMTP id
 f4-20020a056402004400b0055f2bd3a896mr10422edu.3.1706776519344; Thu, 01 Feb
 2024 00:35:19 -0800 (PST)
Date: Thu,  1 Feb 2024 09:31:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240201083259.1734865-1-elver@google.com>
Subject: [PATCH -mm] stackdepot: do not use flex_array_size() in memcpy()
From: Marco Elver <elver@google.com>
To: elver@google.com, Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Konovalov <andreyknvl@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kasan-dev@googlegroups.com, 
	Stephen Rothwell <sfr@canb.auug.org.au>, "Gustavo A . R . Silva" <gustavoars@kernel.org>, 
	Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"

Since 113a61863ecb ("Makefile: Enable -Wstringop-overflow globally")
string overflow checking is enabled by default. Unfortunately the
compiler still isn't smart enough to always see that the size will never
overflow.

Specifically, in stackdepot, we have this before memcpy()'ing a
stacktrace:

  if (nr_entries > CONFIG_STACKDEPOT_MAX_FRAMES)
  	nr_entries = CONFIG_STACKDEPOT_MAX_FRAMES;
  ...
  memcpy(stack->entries, entries, flex_array_size(stack, entries, nr_entries));

Where 'entries' is an array of unsigned long, and STACKDEPOT_MAX_FRAMES
is 64 by default (configurable up to 256), thus the maximum size in
bytes (on 32-bit) would be 1024. For some reason the compiler (GCC
13.2.0) assumes that an overflow may be possible and flex_array_size()
can return SIZE_MAX (4294967295 on 32-bit), resulting in this warning:

 In function 'depot_alloc_stack',
     inlined from 'stack_depot_save_flags' at lib/stackdepot.c:688:4:
 arch/x86/include/asm/string_32.h:150:25: error: '__builtin_memcpy' specified bound 4294967295 exceeds maximum object size 2147483647 [-Werror=stringop-overflow=]
   150 | #define memcpy(t, f, n) __builtin_memcpy(t, f, n)
       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
 lib/stackdepot.c:459:9: note: in expansion of macro 'memcpy'
   459 |         memcpy(stack->entries, entries, flex_array_size(stack, entries, nr_entries));
       |         ^~~~~~
 cc1: all warnings being treated as errors

Silence the false positive warning by inlining the multiplication
ourselves.

Link: https://lore.kernel.org/all/20240201135747.18eca98e@canb.auug.org.au/
Fixes: d869d3fb362c ("stackdepot: use variable size records for non-evictable entries")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Marco Elver <elver@google.com>
Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
---
 lib/stackdepot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 8f3b2c84ec2d..e6047f58ad62 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -456,7 +456,7 @@ depot_alloc_stack(unsigned long *entries, int nr_entries, u32 hash, depot_flags_
 	stack->hash = hash;
 	stack->size = nr_entries;
 	/* stack->handle is already filled in by depot_pop_free_pool(). */
-	memcpy(stack->entries, entries, flex_array_size(stack, entries, nr_entries));
+	memcpy(stack->entries, entries, nr_entries * sizeof(entries[0]));
 
 	if (flags & STACK_DEPOT_FLAG_GET) {
 		refcount_set(&stack->count, 1);
-- 
2.43.0.429.g432eaa2c6b-goog


