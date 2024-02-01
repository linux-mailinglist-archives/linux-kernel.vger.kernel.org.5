Return-Path: <linux-kernel+bounces-47826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2824845362
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CBBE28516B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8135815AAD8;
	Thu,  1 Feb 2024 09:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O+bQMgY5"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA6715AAAA
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 09:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706778284; cv=none; b=t9/XH/NGVhqFWvb4b6W7QJZE4vV+WNgP6Jv8BZ3pHjOD2cKnOcZe1GY/mb0XbmW0bvRKEvLA0/K4Sx0L/ubcxXINIdKB3Z56tmKjW4Wg7IEd63Upp4KQMUj9Effm9BXEY92StzeuB3sFJQBt5gr900Cj95qOenjqRtsIZjac+Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706778284; c=relaxed/simple;
	bh=jZZnMprqf9KfgmZGIK91OrO1vJ+skCvhyHO1pCh6mYw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=K48CjNi8u8oiyhVvtW1yqpMSNFz7lvteRKD4mZi+iceg8UtkjMgzM15+ilU2EgfvFGOpVxRwkoEUEJ53Ak9+QHLzyLepp8zG48sxZpwyrodFHdo0CaOC/Z4TzlVAvPhu69VVokukJE1Md9lVpDM6lLckxgTCsl010tbrAdz876I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O+bQMgY5; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5f874219ff9so8625347b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 01:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706778282; x=1707383082; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qvWvk4QvsQxB0P/BHzB26BqaiUYgtrBgA7rGlBoMg2M=;
        b=O+bQMgY59uTkj5sEjiGJx4xMMnfnBVYS5BNoaLie5vcvFU8xWXAqUsHHIUE32TnE4a
         u2AM0Uo7smbysuKGHq76aaRf5KsraxD/0mT4xsUJM6ChQu/2Z2z/r/dHqDAnGqUWr/D5
         JO+ozRmXm7r5FRP6iNzSbN1cspLdzLLRO9Iku5V74LSYwFUAm6G/sw680xD5OzTQBiCV
         FotJilEx7+4fUMmTJ3dZD62lmYtUOxaXqMEa1k82pSQlr+S0FTNUfCLaee3SBCkuZImV
         UcSuJvAKT4etir3xS9/YW8Hxhn7NmETfYhrNJ6BQ/FwA+Rqdgnk+Cpg+gX2Poyt0YT+F
         ozpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706778282; x=1707383082;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qvWvk4QvsQxB0P/BHzB26BqaiUYgtrBgA7rGlBoMg2M=;
        b=A8TurE3MT7xqzmUzQUGBM460GROaXD0B7je3EG2RoaGj8XzlPJB1nHdrreCvKMvy0p
         1evZPa66bv+ZZmlFplnQriepRDdflEfwgaPAbnyZhe6xixJa7LpswrajOZgibb12yRrF
         lxkUhHjeaZ9l8KJxnDvYvl7i9u4vNjM003/yihw76efXG3glScc8ufsBkt4a7ix/2tbn
         LbNgONc8QdR3CfUGVlW+bHnpWuE/TcAist0yxZaLGZ9n4WjgsmtwIgWSlUBn9aUyEjXx
         1NFwEliw8XjFTqskvjoHSgUDdYQ59EQKKkn3nXi9tKCr+G00bWFPC2MIhgB+j5FuzzTV
         HzMw==
X-Gm-Message-State: AOJu0YwtiScswu+n6z/no6wW/ZUNAd+wA3yGdxHQ7Qu+ChR7A1SjvGi4
	xv1JsS8bB1fKTOalhQiidYSVkVIB+xhL39iqTHyj3uwskcbr45QJYNIc1ujsNQGQgNYzSPWU0w=
	=
X-Google-Smtp-Source: AGHT+IGMuY8j6HgmaOYL/yVI7EA1U7Y++bJ3lMlFLigy9FB5qwdbehhOpMkJ9usslQabmxdsVv6Y8adU6A==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:c945:1806:ff53:36fa])
 (user=elver job=sendgmr) by 2002:a81:99d8:0:b0:5ff:6e82:ea31 with SMTP id
 q207-20020a8199d8000000b005ff6e82ea31mr849671ywg.3.1706778282041; Thu, 01 Feb
 2024 01:04:42 -0800 (PST)
Date: Thu,  1 Feb 2024 10:04:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240201090434.1762340-1-elver@google.com>
Subject: [PATCH -mm v2] stackdepot: fix -Wstringop-overflow warning
From: Marco Elver <elver@google.com>
To: elver@google.com, Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Konovalov <andreyknvl@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kasan-dev@googlegroups.com, 
	Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"

Since 113a61863ecb ("Makefile: Enable -Wstringop-overflow globally")
string overflow checking is enabled by default. Within stackdepot, the
compiler (GCC 13.2.0) assumes that a multiplication overflow may be
possible and flex_array_size() can return SIZE_MAX (4294967295 on
32-bit), resulting in this warning:

 In function 'depot_alloc_stack',
     inlined from 'stack_depot_save_flags' at lib/stackdepot.c:688:4:
 arch/x86/include/asm/string_32.h:150:25: error: '__builtin_memcpy' specified bound 4294967295 exceeds maximum object size 2147483647 [-Werror=stringop-overflow=]
   150 | #define memcpy(t, f, n) __builtin_memcpy(t, f, n)
       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
 lib/stackdepot.c:459:9: note: in expansion of macro 'memcpy'
   459 |         memcpy(stack->entries, entries, flex_array_size(stack, entries, nr_entries));
       |         ^~~~~~
 cc1: all warnings being treated as errors

This is due to depot_alloc_stack() accepting an 'int nr_entries' which
could be negative without deeper analysis of callers.

The call to depot_alloc_stack() from stack_depot_save_flags(), however,
only passes in its nr_entries which is unsigned int. Fix the warning by
switching depot_alloc_stack()'s nr_entries to also be unsigned.

Link: https://lore.kernel.org/all/20240201135747.18eca98e@canb.auug.org.au/
Fixes: d869d3fb362c ("stackdepot: use variable size records for non-evictable entries")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Marco Elver <elver@google.com>
---
v2:
* Just switch 'nr_entries' to unsigned int which is already the case
  elsewhere.
---
 lib/stackdepot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 8f3b2c84ec2d..4a7055a63d9f 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -420,7 +420,7 @@ static inline size_t depot_stack_record_size(struct stack_record *s, unsigned in
 
 /* Allocates a new stack in a stack depot pool. */
 static struct stack_record *
-depot_alloc_stack(unsigned long *entries, int nr_entries, u32 hash, depot_flags_t flags, void **prealloc)
+depot_alloc_stack(unsigned long *entries, unsigned int nr_entries, u32 hash, depot_flags_t flags, void **prealloc)
 {
 	struct stack_record *stack = NULL;
 	size_t record_size;
-- 
2.43.0.429.g432eaa2c6b-goog


