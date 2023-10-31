Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5FB7DD0A0
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 16:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345070AbjJaPeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 11:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345067AbjJaPek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 11:34:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F20F9F
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 08:34:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08CBBC433C7;
        Tue, 31 Oct 2023 15:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698766475;
        bh=i4tDbQFfZ/m9gnZQSeb+WZMIei+PMyfAWyJny7aA+0Y=;
        h=Date:From:To:Cc:Subject:From;
        b=f5LsMLu7M21KIiYnFNUSeHUzU7j4LhCj77vYOIdo11UunvCE4RFaJB17jADcexoCy
         w7jUDYutOv9wyFw/L+Wd0t4HdY+ciFneLVOvtfZrXcnOrML71Imwmg6vibWcEW7c1x
         CKBEGEYJJmr6zagY1NK6okJOuNj03MDbMvbgl6MDkaZdwLml2rxyYkLFi3V6CqYFTC
         gW0JlAtPQ8m6EWLKDwBJYptAIdaxStqfbAMyatFXcZPKcSnHFwdmEbp0sNl/vS68G5
         4/BKeWetLcQ9yJbG09tUA1fAINPE7wfRecGXAtRrq+Rk01CSdLK0NApU7sL/LS8m1F
         FaTrfI404UhRw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E0EA94035D; Tue, 31 Oct 2023 12:34:31 -0300 (-03)
Date:   Tue, 31 Oct 2023 12:34:31 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH next 1/1] perf build: Warn about missing libelf before
 warning about missing libbpf
Message-ID: <ZUEehyDk0FkPnvMR@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As libelf is a requirement for libbpf if it is not available, as in some
container build tests where NO_LIBELF=1 is used, then better warn about
the most basic library first.

Ditto for libz, check its availability before libbpf too.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.config | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index b3e6ed10f40c6f6c..8b6cffbc485834c8 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -680,15 +680,15 @@ ifndef BUILD_BPF_SKEL
 endif
 
 ifeq ($(BUILD_BPF_SKEL),1)
-  ifeq ($(filter -DHAVE_LIBBPF_SUPPORT, $(CFLAGS)),)
-    dummy := $(warning Warning: Disabled BPF skeletons as libbpf is required)
-    BUILD_BPF_SKEL := 0
-  else ifeq ($(filter -DHAVE_LIBELF_SUPPORT, $(CFLAGS)),)
+  ifeq ($(filter -DHAVE_LIBELF_SUPPORT, $(CFLAGS)),)
     dummy := $(warning Warning: Disabled BPF skeletons as libelf is required by bpftool)
     BUILD_BPF_SKEL := 0
   else ifeq ($(filter -DHAVE_ZLIB_SUPPORT, $(CFLAGS)),)
     dummy := $(warning Warning: Disabled BPF skeletons as zlib is required by bpftool)
     BUILD_BPF_SKEL := 0
+  else ifeq ($(filter -DHAVE_LIBBPF_SUPPORT, $(CFLAGS)),)
+    dummy := $(warning Warning: Disabled BPF skeletons as libbpf is required)
+    BUILD_BPF_SKEL := 0
   else ifeq ($(call get-executable,$(CLANG)),)
     dummy := $(warning Warning: Disabled BPF skeletons as clang ($(CLANG)) is missing)
     BUILD_BPF_SKEL := 0
-- 
2.41.0

