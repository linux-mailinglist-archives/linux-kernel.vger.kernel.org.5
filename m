Return-Path: <linux-kernel+bounces-94395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46855873EB3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1992286E96
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 18:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02E3143723;
	Wed,  6 Mar 2024 18:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="shnnHBRb"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7610B140E50
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 18:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709749498; cv=none; b=YLLgizwJKseMreUJwfhvFAzfmEhTGPaNapMYRY4KhqXoB71RJYeCzM2Jrrpd/bz92OiT3qTP2BktXiCC/yfG9zBUGvJp4NsKSYfRR2nv7yOJlUVlbFs9DtbeQlfHzqaiGSq7o5KCkRIkpIPAxOac0pkwfbPsa7xIgR1CaR2inbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709749498; c=relaxed/simple;
	bh=ZqsbHPLTqR5vr2hfJmCxnAF/y893b7KN4UH1mJR1TTs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KS0+f7I1TCpTg6u4+AQ78Dp7SVNFDeDYtj0QF9jMg79YbBEUSinshjsCbV+5KcWeb/INhQnqIb1xGkTQ4SwL80bPG1lIV1AdkLW5wPt7nINAPjGT2ES9PwQEhXc5tBOJqu8A5D3xIgm48uVOarTU6BVHhIxuFdT2C/BUT0CKOBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=shnnHBRb; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b267bf11so8285450276.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 10:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709749493; x=1710354293; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5nTBv3DNXNZIxIc1ZBoC1bDpLfB6IB4LOR7eT5PZErs=;
        b=shnnHBRbQBYZtJVhyNwHvVRzZy+Evm2lS8VagOsCzaiCHc6GmmFRV36ibA+N/q6F3r
         LYvXjkGlzvrO326JxhEHIm7Wq32UUR9uGNo0qLC/rvbKyIpp2bH7NNiE3BlJRzxKg/MS
         8vejCOUz0P+b0uH+DlAG4jm4miZPtTkBaP/GHNp2BuarYul6Y4ROIF8hQNFud65s1V5W
         2y1fH9p2vKYpkQePKlcVkCA6FzrzPQUkCtS4nay/ZAL1Wu6MEgGJRdCSlJCDNEwyqd9M
         m2NG5scOVhCLX9FtEbs+L3AJz+KkpqP/meXpuSU1rQ6YmKSmrboAerQ327T2LZerNLFH
         3jKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709749493; x=1710354293;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5nTBv3DNXNZIxIc1ZBoC1bDpLfB6IB4LOR7eT5PZErs=;
        b=B8xlJLWDA6ot08rXnZ9vnYTGy/Tt9zvUN3q593RP+eLBx91pJTiONvDLw40KnR6mIv
         S3/5CI1tscz6dq0iTyk4SOCqhR4lpr5/kW7s8wviHj4iW31dT2AtmsnRm2+kfNf90vkq
         ku86JTbRaSIcFB/1eW5SZF3vwF5zWbzxgjZA5yNFbAr4YzIuTdFBOwxFYUXgZUADPHCy
         v1i4bOdGuBr68DJTaF8xjMP2xkku2j5q4vCMB5wTaoCyQ6LVu/MeBHyS0prH6qsKnpkd
         vgSnuvsyG2eHAMhfZH2//Zmo3VjXWG2U9i2vSP0JkWdYuqI/kjAZse9A7erXH5d5utxQ
         O6bg==
X-Forwarded-Encrypted: i=1; AJvYcCV2NW2BA2Oqkj2avVKq24N8Qwupvpbaa/hfa1ImF6SmK0X6nsF0Sh2KhzU9kB5v2ErdiH3qTegv/N/5VqhKuVH1cT6K6yQM5Ap0Trek
X-Gm-Message-State: AOJu0Yw8ed8LVpMZ30og7zZwXU/6fKkn/GGjPAjfrq0gxseUYQnHBcpW
	mFi05FljVzMmrB9tZ88RiWxfwFTe+3iYPvDnDkF2J1N0So435knTMEM8dttMxFD0T+Tn/5l/YZx
	bOw==
X-Google-Smtp-Source: AGHT+IG5gxx5etlJS8XEklM9jb6RXbjr2MBzNYyK3K6zvzjzbtTe9XCBybhsxXG5rBRlQj+HJ+M1RmTOlz4=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:85f0:e3db:db05:85e2])
 (user=surenb job=sendgmr) by 2002:a05:6902:1009:b0:dbe:387d:a8ef with SMTP id
 w9-20020a056902100900b00dbe387da8efmr534074ybt.1.1709749493516; Wed, 06 Mar
 2024 10:24:53 -0800 (PST)
Date: Wed,  6 Mar 2024 10:24:02 -0800
In-Reply-To: <20240306182440.2003814-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240306182440.2003814-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240306182440.2003814-5-surenb@google.com>
Subject: [PATCH v5 04/37] scripts/kallysms: Always include __start and __stop symbols
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
	glider@google.com, elver@google.com, dvyukov@google.com, shakeelb@google.com, 
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
2.44.0.278.ge034bb2e1d-goog


