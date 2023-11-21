Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D80E7F39A9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 23:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234965AbjKUW5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 17:57:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234918AbjKUW53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 17:57:29 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD4910D5;
        Tue, 21 Nov 2023 14:57:09 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1cc5b705769so54214585ad.0;
        Tue, 21 Nov 2023 14:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700607428; x=1701212228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=imksGNoTkLOSWGxbTUx5c7bQ0SJEukVr1ISidEGWUC0=;
        b=FE5odhD+YNeYH/tP0IYFCDdRpF2jypuO8HoXkzP+quD4/FffvX3jLVcrTcnEorvRgL
         08ikyRUV8E+LOtooi7raES817D2PuhKgLP+aP0AfC70rD+AFI4k4+EOdiJzYLOhfChiv
         ld9DYKKiWW577wGI9pW9T+aqgLzZAumo2PevwfzJISd+yHxCOrWGFe186fWHC68pvHYi
         MricszYYXc6pwRT+KecHe5nk2AjZQrK1OPGzZj9EgWJCnuMmIPW8E9groxuB5IH1Nmg3
         9kS950i7BSWzr0ON9C4Cel1ORNonVO6cy86jUSuAbaLHaJulZ+6oSg1IVzTS1z4CGP/u
         96vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700607428; x=1701212228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=imksGNoTkLOSWGxbTUx5c7bQ0SJEukVr1ISidEGWUC0=;
        b=Yybu0d0SSCgFemFWy3wO1KxdfMknJy5J0KU4xiAnzJ2+IyDMXtMQnsD7v3EBO5oUP8
         kzb6d/W+6cezBmiQv64J1hec6xkSBjcqOb2EJ3CSikSAVGVhiJRzEdICvMNszJaNpjM1
         Btlxyq8oFzS6krKsFIybR/KuKK548UNcmrH2pZqtCsiGJ5vZqJWXOugHuuZnFPc1hdo1
         h7QU6gc/14gcX6SQAEX1HvUFJ0jsw8JmwfVXx+xW6U+AxdybfNSeNwk7XTmkHzcM4oxa
         bCMNN8ZM/EKiFjdiucB7TyahfPRfsRNC9cnW6u0QvzqZ60EEGSwLvshpP9GIByaN9zy4
         zuLg==
X-Gm-Message-State: AOJu0YzhvXFgTQEC2evHNOCujbAjUnDa5X79WvumFLmj98e2NTaB6UGF
        3BoAgq77jXoQEIXT2o/HQqM=
X-Google-Smtp-Source: AGHT+IF6nev15Wx1IU9Cm0JjON37lYLTr4XgdpZk/wISk+wgJmlSjDJ8Zf5yXSWHwpHpfWi5VvJQxw==
X-Received: by 2002:a17:902:e546:b0:1cc:5db8:7eb1 with SMTP id n6-20020a170902e54600b001cc5db87eb1mr686024plf.51.1700607428389;
        Tue, 21 Nov 2023 14:57:08 -0800 (PST)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:7377:923f:1ff3:266d])
        by smtp.gmail.com with ESMTPSA id m12-20020a1709026bcc00b001cc47c1c29csm8413189plt.84.2023.11.21.14.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 14:57:08 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: [PATCH 13/14] tools/perf: Update tools's copy of s390 syscall table
Date:   Tue, 21 Nov 2023 14:56:48 -0800
Message-ID: <20231121225650.390246-13-namhyung@kernel.org>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
In-Reply-To: <20231121225650.390246-1-namhyung@kernel.org>
References: <20231121225650.390246-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tldr; Just FYI, I'm carrying this on the perf tools tree.

Full explanation:

There used to be no copies, with tools/ code using kernel headers
directly. From time to time tools/perf/ broke due to legitimate kernel
hacking. At some point Linus complained about such direct usage. Then we
adopted the current model.

The way these headers are used in perf are not restricted to just
including them to compile something.

There are sometimes used in scripts that convert defines into string
tables, etc, so some change may break one of these scripts, or new MSRs
may use some different #define pattern, etc.

E.g.:

  $ ls -1 tools/perf/trace/beauty/*.sh | head -5
  tools/perf/trace/beauty/arch_errno_names.sh
  tools/perf/trace/beauty/drm_ioctl.sh
  tools/perf/trace/beauty/fadvise.sh
  tools/perf/trace/beauty/fsconfig.sh
  tools/perf/trace/beauty/fsmount.sh
  $
  $ tools/perf/trace/beauty/fadvise.sh
  static const char *fadvise_advices[] = {
        [0] = "NORMAL",
        [1] = "RANDOM",
        [2] = "SEQUENTIAL",
        [3] = "WILLNEED",
        [4] = "DONTNEED",
        [5] = "NOREUSE",
  };
  $

The tools/perf/check-headers.sh script, part of the tools/ build
process, points out changes in the original files.

So its important not to touch the copies in tools/ when doing changes in
the original kernel headers, that will be done later, when
check-headers.sh inform about the change to the perf tools hackers.

Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/arch/s390/entry/syscalls/syscall.tbl | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/arch/s390/entry/syscalls/syscall.tbl b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
index cc0bc144b661..86fec9b080f6 100644
--- a/tools/perf/arch/s390/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
@@ -455,3 +455,7 @@
 450  common	set_mempolicy_home_node	sys_set_mempolicy_home_node	sys_set_mempolicy_home_node
 451  common	cachestat		sys_cachestat			sys_cachestat
 452  common	fchmodat2		sys_fchmodat2			sys_fchmodat2
+453  common	map_shadow_stack	sys_map_shadow_stack		sys_map_shadow_stack
+454  common	futex_wake		sys_futex_wake			sys_futex_wake
+455  common	futex_wait		sys_futex_wait			sys_futex_wait
+456  common	futex_requeue		sys_futex_requeue		sys_futex_requeue
-- 
2.43.0.rc1.413.gea7ed67945-goog

