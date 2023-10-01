Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 072067B4880
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 18:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235190AbjJAQAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 12:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235186AbjJAQAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 12:00:14 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471B5E3
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 09:00:12 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-406618d0992so18458715e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Oct 2023 09:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696176011; x=1696780811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pfhqMS4SBWNsRFumL7f2VoNpk2TCo8ZgiAHTNGqiqHs=;
        b=OL9jdxRbNe4765piky1C++UOFN5BOfkLGtMtaUCnY05qx7TND1M+mmB3wInOdtdTxm
         dIYYB9JZI3uQpKMnzC7NrMJJtRIGF768eq9z5bT1QKwgZHokRcCfNIYmFQsZvrGRmVif
         aR+qF0sn0LknzKCaOiFfqAR0r8v/ybbj4YfTSA3/3J+i4B6eYSi+ekEUFooEyOOfG2m1
         vLwUSZ3w92QTxt/8U3rpqVfO2e6h0JF6+bq4UqGwbv1J3u62Ew4gRNP42RiG2s9goLB/
         2HJrRilNNXjTHCvJ5+A2D3rDBFXdJzIre2NQ4YRomx9/2JJAml301z2HdYMceG6l1/W0
         Vo3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696176011; x=1696780811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pfhqMS4SBWNsRFumL7f2VoNpk2TCo8ZgiAHTNGqiqHs=;
        b=Qp4/cpL3+UmQtrnb4MREl2w32RGLVuP4RiOZuPIh7Ht9KPoqrstjSfaCRKujcsXx6k
         a/rArB7wSi4EUamQ37QsAHGRprNlOTXUuAX9NkKpmpPfwV48jMjN+Tkyxs14WA49y3mO
         OAlhCy2m1gHBbmGfIVOjI5fKm3YZQ7610T/it+AIFrpf1qSisyHeGJwAuZ5LL1ZDdNGf
         2dMjYE73yyJrSSP8Hggl2NE3IAJO3PryGLVrW+K4YqF1GcU7zgQXqR0Xgw2SGe6xG3Hi
         J7kWfgFglhcbZRAnKcEWgWSuW5CJkvkmmS3G+g27oLffmzBOawKR1vXftyH+1ayl2tPv
         HPXg==
X-Gm-Message-State: AOJu0YwqR7Sau8PcJmL1rSafyCWD/a7mQ4HIGSWgkawKh/NDw/VYFReh
        GkRfT9DeX557J1BowmUj5mg=
X-Google-Smtp-Source: AGHT+IEII6JdFJg8xpbvXnmUnQWjv6hpexCp5q2DqxZ8O7FssanDUSfov88XVS8L+47c6qXHvBvGoQ==
X-Received: by 2002:a7b:cd15:0:b0:401:c52c:5ed9 with SMTP id f21-20020a7bcd15000000b00401c52c5ed9mr8350531wmj.32.1696176010384;
        Sun, 01 Oct 2023 09:00:10 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id s16-20020a05600c045000b0040536dcec17sm5487695wmb.27.2023.10.01.09.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 09:00:09 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH 1/4] mm: make __access_remote_vm() static
Date:   Sun,  1 Oct 2023 17:00:02 +0100
Message-ID: <70436dcf596565770e604a4fc4e8f27a14c85166.1696174961.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1696174961.git.lstoakes@gmail.com>
References: <cover.1696174961.git.lstoakes@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

access_remote_vm() passes through parameters to __access_remote_vm()
directly, so remove the __access_remote_vm() function from mm.h aand use
access_remote_vm() in the one caller that needs it (ptrace_access_vm()).

This allows future adjustments to the GUP-internal __access_remote_vm()
function while keeping the access_remote_vm() function stable.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 include/linux/mm.h | 2 --
 kernel/ptrace.c    | 2 +-
 mm/memory.c        | 4 ++--
 mm/nommu.c         | 4 ++--
 4 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 52c40b3d0813..7b89f7bd420d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2415,8 +2415,6 @@ extern int access_process_vm(struct task_struct *tsk, unsigned long addr,
 		void *buf, int len, unsigned int gup_flags);
 extern int access_remote_vm(struct mm_struct *mm, unsigned long addr,
 		void *buf, int len, unsigned int gup_flags);
-extern int __access_remote_vm(struct mm_struct *mm, unsigned long addr,
-			      void *buf, int len, unsigned int gup_flags);
 
 long get_user_pages_remote(struct mm_struct *mm,
 			   unsigned long start, unsigned long nr_pages,
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 443057bee87c..d8b5e13a2229 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -59,7 +59,7 @@ int ptrace_access_vm(struct task_struct *tsk, unsigned long addr,
 		return 0;
 	}
 
-	ret = __access_remote_vm(mm, addr, buf, len, gup_flags);
+	ret = access_remote_vm(mm, addr, buf, len, gup_flags);
 	mmput(mm);
 
 	return ret;
diff --git a/mm/memory.c b/mm/memory.c
index d4820802b01b..e2743aa95b56 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5881,8 +5881,8 @@ EXPORT_SYMBOL_GPL(generic_access_phys);
 /*
  * Access another process' address space as given in mm.
  */
-int __access_remote_vm(struct mm_struct *mm, unsigned long addr, void *buf,
-		       int len, unsigned int gup_flags)
+static int __access_remote_vm(struct mm_struct *mm, unsigned long addr,
+			      void *buf, int len, unsigned int gup_flags)
 {
 	void *old_buf = buf;
 	int write = gup_flags & FOLL_WRITE;
diff --git a/mm/nommu.c b/mm/nommu.c
index 7f9e9e5a0e12..f9553579389b 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1651,8 +1651,8 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 }
 EXPORT_SYMBOL(filemap_map_pages);
 
-int __access_remote_vm(struct mm_struct *mm, unsigned long addr, void *buf,
-		       int len, unsigned int gup_flags)
+static int __access_remote_vm(struct mm_struct *mm, unsigned long addr,
+			      void *buf, int len, unsigned int gup_flags)
 {
 	struct vm_area_struct *vma;
 	int write = gup_flags & FOLL_WRITE;
-- 
2.42.0

