Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E17957B5D9F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 01:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237244AbjJBXPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 19:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237135AbjJBXPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 19:15:05 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADB9AD
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 16:15:02 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3226b8de467so339922f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 16:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696288501; x=1696893301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8CCf1YepfoJnZdTtxvEP7yh6ZYqHtmpLJthLBvRpqWQ=;
        b=ItCKK958uPcvOnGUWxDaFvxf/iSAE1qQORYwYqcO/d3Q895BvgA3irUvfNEi4b23vr
         IjQM0Oyph9oKqRxDy6wIWk2v/2q6lpy++mRS8S2PnzGDOCWcEttk67NVbY1eNt3lQVnP
         vEckMqkx7XbiGVxmli6x67+8dBodqFYqbI3AYPzjVRDXyfqxWoImKtbo1QyG4Hub3vri
         Yw+xZxzDdp5NjiVOafChucoQKWuIJumr/OK2/717M/ZMSwmCDFvks1SkrNaWofiR/eFy
         eN58f/dgbFmv2NVohc+YkYWacuwQp52jPpnu4wHpMJ5eKxKW8u7qog9ER5bPfvDK3lwC
         ka/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696288501; x=1696893301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8CCf1YepfoJnZdTtxvEP7yh6ZYqHtmpLJthLBvRpqWQ=;
        b=tZLl4Ut6sXKlqpFODBaNHcXsUX+i0f1V4gTOFdCeMQuT7wT1YG8IIc/8zcyEXbw/1W
         hF+3imZoQFg20GTeXZ+jr9TehkGRysV+pJ0NvHghWNj9ivLdYT+ZzVuQVHSu+vhkXcco
         boKVTO88EzNzdM44S5K6Asx218Q1wUUTNh3NMQnwdP7x7NPAr8mA/0QKqHypzpH/Gdgu
         81RHHErHYlvJGIVBb2GoI8jYyRH1EU9Uryf6IvxkRqoyrww2F6KMgTa+ouhlXRZ5gV0q
         DhlzAo4J5s5/uGgMh4PsGokZY3cVIja+eXLTOcud/AHgpiu8b05HvZ74+73ljfMs3zTe
         k6sg==
X-Gm-Message-State: AOJu0Yxl8XfUAKh25KSX/O2kdaQ6X0Qtrih/5l9RT/ehR5WjUt8gYjZL
        RHvraqffyHFh0hopMC3WpVE=
X-Google-Smtp-Source: AGHT+IHYriSecsmHZKvTmAjWX2tjh39AdJdHel618pmJyi/BsoVQvDJMPZheisgXAY/d1NQdCOZsLw==
X-Received: by 2002:a5d:4dcc:0:b0:320:5f:c249 with SMTP id f12-20020a5d4dcc000000b00320005fc249mr11333408wru.30.1696288500995;
        Mon, 02 Oct 2023 16:15:00 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id e31-20020a5d595f000000b0031fbbe347e1sm63860wri.65.2023.10.02.16.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 16:15:00 -0700 (PDT)
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
        Lorenzo Stoakes <lstoakes@gmail.com>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 1/4] mm: make __access_remote_vm() static
Date:   Tue,  3 Oct 2023 00:14:51 +0100
Message-ID: <f7877c5039ce1c202a514a8aeeefc5cdd5e32d19.1696288092.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1696288092.git.lstoakes@gmail.com>
References: <cover.1696288092.git.lstoakes@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

access_remote_vm() passes through parameters to __access_remote_vm()
directly, so remove the __access_remote_vm() function from mm.h and use
access_remote_vm() in the one caller that needs it (ptrace_access_vm()).

This allows future adjustments to the GUP-internal __access_remote_vm()
function while keeping the access_remote_vm() function stable.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: David Hildenbrand <david@redhat.com>
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

