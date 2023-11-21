Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 468CF7F39A6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 23:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234905AbjKUW5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 17:57:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234900AbjKUW5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 17:57:21 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA6DD7F;
        Tue, 21 Nov 2023 14:57:07 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1cc938f9612so40362495ad.1;
        Tue, 21 Nov 2023 14:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700607427; x=1701212227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8cHNQWLeaX3Eaeqr4KDeKVPWKASKTSj+iTYazvJzg+8=;
        b=C1tKX3HfiozZ9T8Nlb5pgQB7+Ek4qzbmxiUg4WsZNy6giyRpzhMCTgM5E/TJ2cxHor
         Y+nweJUKS9zEIXEUU/iL+SWhbuYUyglXfy2PmgWfofJV+zlcyKUqNsqERGQvpNzbGSXc
         hWZRgtuh4ZRrzW7rJVi1EtD/A0IxrFll+PdScUTksVp/HmDp4FQmjbQk6Z+nQM6Ko1Rr
         opWK6pVrD6Jrnkb68okaRkbUaMmuzT7GAozmiHan1FYpljxQgTRzXZAoP+acxdBaaCEL
         qRg92B1ylE8cWkeIm9bDWoAzd5XhK9ZM37z8czWf1crlr3TkElLeZJgw2M436k1GC/mo
         K51Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700607427; x=1701212227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8cHNQWLeaX3Eaeqr4KDeKVPWKASKTSj+iTYazvJzg+8=;
        b=TWC6Vt72/5lXAApJM57Ak/otyP6bPlsow7ZWw/LAR/1dl2CWkCx/CGsblzEVyNnTLP
         obPQVSERc6tjF3dL9VOGEu4o61yKyp3U1fcGgDQpNV2Mfu77Kcfqb2el33XcPTKhIF8V
         kixSsvecSDYZ3hJ7aLrcw8Tm5Q4bC7FsjER8rf8zMLwHdYl2MteDtrbRNo1CyNs3B3+4
         NfQh/6X6Ko9MOC14VvI9l1ttxT6xKC3Kt+l+uHWhlNi4EHx7F9ALM2DVZcKtO8ciGoln
         yeXXckSBnCKi4UiHce56C2y0LGC2ICUDB/nw0IG3u33DGcl4KvOnrADhhHueMSQX3mec
         0yMw==
X-Gm-Message-State: AOJu0Yykf9ULKAm5LmV5NoR5i0MVIFTq9zZVFzhYrfj7LlLe+4GdFMPz
        kbyrUevuYbl5Eb1EjsWsmfc=
X-Google-Smtp-Source: AGHT+IEqnRZoF/phD6HSzSdY21h0h7tC1I39JtK6IEk90MbB3dit3i9hvRB+rV+MUJcHWL2zIOUb3w==
X-Received: by 2002:a17:903:188:b0:1cf:5782:7c74 with SMTP id z8-20020a170903018800b001cf57827c74mr805479plg.7.1700607427036;
        Tue, 21 Nov 2023 14:57:07 -0800 (PST)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:7377:923f:1ff3:266d])
        by smtp.gmail.com with ESMTPSA id m12-20020a1709026bcc00b001cc47c1c29csm8413189plt.84.2023.11.21.14.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 14:57:06 -0800 (PST)
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
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 12/14] tools/perf: Update tools's copy of powerpc syscall table
Date:   Tue, 21 Nov 2023 14:56:47 -0800
Message-ID: <20231121225650.390246-12-namhyung@kernel.org>
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

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/arch/powerpc/entry/syscalls/syscall.tbl | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
index e1412519b4ad..7fab411378f2 100644
--- a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
@@ -539,3 +539,7 @@
 450 	nospu	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
 452	common	fchmodat2			sys_fchmodat2
+453	common	map_shadow_stack		sys_ni_syscall
+454	common	futex_wake			sys_futex_wake
+455	common	futex_wait			sys_futex_wait
+456	common	futex_requeue			sys_futex_requeue
-- 
2.43.0.rc1.413.gea7ed67945-goog

