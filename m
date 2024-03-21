Return-Path: <linux-kernel+bounces-110358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7054C885DDD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE8B0B24AE5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F049134418;
	Thu, 21 Mar 2024 16:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M97DhcGW"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E3A1332AB
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 16:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711039042; cv=none; b=cANJpLB9f+wmPgB5OYlS3an79Gjze9iLUXMWyY8FLjjGUxd0zIlavPYKrkxXzy2hrn/oCL2yhyqUX0ygDiJUTycSV/wzU5E+q8/LbUCOuD5rilTREhzFVczG481btNWzO8CrGWGzirDTuKxr3a6rNDj65hlCnarJE12Rs7TzBGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711039042; c=relaxed/simple;
	bh=ir6xyZtmAUC+Ybm5fW49pWbbkzfCfz5BPQNom35E7HQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B/Rhl3nbwdY/qxATW/cvZoCI4CPCYImHu1aGcB+ptxjhSYxrliEaCkBz9r25AaTQgk9kYe6fDuEFCMClup7XLAX0J/dYvqgPtXyGdKprYtbsFBVNGvSWJ59ap08phTDnmQR1y3fURV3X/MWCP2b0rapjRqwlINUIHYQUbpb9wuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M97DhcGW; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dd8e82dd47eso1633585276.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 09:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711039039; x=1711643839; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FcsF8xuW3B4rJ7bvWaC3URPqDGHFVTOJU/Md9c+vki8=;
        b=M97DhcGW8hPCwutq/KjsElSFPJnWXH/25nt2pMe8zJPNVhhFUTwq6282ZNUp3MIMIf
         ud9EZrXxH5mpYspVXQaHAkvufZYzu7iAL8y3m1T1clfrO1mHw7DXuDG3S+0/9rAtql90
         2AjFb4iLI0tKvfe+2U3EIjHIEhtDFIrFowoLpxNCPGQV5hYtfhc8jGDE3XxhD4oXVu6R
         cI3Vp/jnnZVuCg9ZWBOeAhp8IGzgCCo7HUf/GeuXN7py9MY51z2w0RJ7YrX4bxvMlIqu
         6tHlyxNugquJvYPmKOAXkbCwr3CPMWqLXJ5kvBR6BER8iN9VXJk49w4t041PFILta3Ew
         KOLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711039039; x=1711643839;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FcsF8xuW3B4rJ7bvWaC3URPqDGHFVTOJU/Md9c+vki8=;
        b=ddkrPcGMRXnqgL7wNq8YkcRvxvpv5/UeX/jbOCewR+0o7/qfGcUFYTeUJ4FRJYlcyU
         ExGh0w7vM/8fDyBI0l955T4cvOHoZTO9lxtMeqYguE5MOY4QDXW/c7FIKnzHaKswUDaP
         7yhDDcwmR9gTf5v5nkxDLLE7yPK60LVQCBZCMHdG0NzwS46CyC7QVACvCRqGwiXOoxtE
         ucH/Vt0foHq+qdloSa9rqM1+SCO+6c0K5hkw9aLKWBVe5FIc7seKK16OAap/RVqzIkPT
         ZxOoBL/Zl2apBrD5diuT7zGdZlJk4HgpiS9WCRDX9y3ZNo7+PgF7H8EPFDl4C77iT4Ra
         4FxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPlXkC1YcwIAOaUqnltCXOZaxjeiLwqboTcxijgpJxtiWEhD22gAlILeoX3UljNukipanq1mCwPvrWoqgYChjgLbZRRoN6S7DSO/oj
X-Gm-Message-State: AOJu0YwzvR/xx7IwQerurpyhUbh5ZBZLpfbQu/3ZzJkB5JO2e06m2JnB
	7gGnhiHek0FSX9g14EZTHCdKvIE+ZC58QphucLw/fd0P3S5on0Gkazgju+/zYRg3gUY46fhIazC
	VTA==
X-Google-Smtp-Source: AGHT+IGrkFj5aE/qI6dA3cr3f2zIJD/myHIxBhs84G4EmxlJsslBgaCO9HAP/2XOVSrMpqDkAxdrZ+lOSbY=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:a489:6433:be5d:e639])
 (user=surenb job=sendgmr) by 2002:a05:6902:1207:b0:dc6:b982:cfa2 with SMTP id
 s7-20020a056902120700b00dc6b982cfa2mr1182860ybu.8.1711039038760; Thu, 21 Mar
 2024 09:37:18 -0700 (PDT)
Date: Thu, 21 Mar 2024 09:36:26 -0700
In-Reply-To: <20240321163705.3067592-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240321163705.3067592-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240321163705.3067592-5-surenb@google.com>
Subject: [PATCH v6 04/37] scripts/kallysms: Always include __start and __stop symbols
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, jhubbard@nvidia.com, tj@kernel.org, 
	muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org, 
	pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com, 
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com, 
	keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com, 
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com, 
	penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, 
	glider@google.com, elver@google.com, dvyukov@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, aliceryhl@google.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	surenb@google.com, kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Kent Overstreet <kent.overstreet@linux.dev>

These symbols are used to denote section boundaries: by always including
them we can unify loading sections from modules with loading built-in
sections, which leads to some significant cleanup.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 scripts/kallsyms.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 653b92f6d4c8..47978efe4797 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -204,6 +204,11 @@ static int symbol_in_range(const struct sym_entry *s,
 	return 0;
 }
 
+static bool string_starts_with(const char *s, const char *prefix)
+{
+	return strncmp(s, prefix, strlen(prefix)) == 0;
+}
+
 static int symbol_valid(const struct sym_entry *s)
 {
 	const char *name = sym_name(s);
@@ -211,6 +216,14 @@ static int symbol_valid(const struct sym_entry *s)
 	/* if --all-symbols is not specified, then symbols outside the text
 	 * and inittext sections are discarded */
 	if (!all_symbols) {
+		/*
+		 * Symbols starting with __start and __stop are used to denote
+		 * section boundaries, and should always be included:
+		 */
+		if (string_starts_with(name, "__start_") ||
+		    string_starts_with(name, "__stop_"))
+			return 1;
+
 		if (symbol_in_range(s, text_ranges,
 				    ARRAY_SIZE(text_ranges)) == 0)
 			return 0;
-- 
2.44.0.291.gc1ea87d7ee-goog


