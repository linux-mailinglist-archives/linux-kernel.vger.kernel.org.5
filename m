Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4C77DD087
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 16:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345009AbjJaPbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 11:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344994AbjJaPbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 11:31:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC56E6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 08:31:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2537BC433C7;
        Tue, 31 Oct 2023 15:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698766264;
        bh=nEcygd4r/aqIimNh6oZz/KmSqcygFL3nW78dPlNEFAs=;
        h=Date:From:To:Cc:Subject:From;
        b=SH9lLeCq+FNPmW7M596sKQ3OH38PN6gO6WeS+aEe2m1xD8sID6EddQJ8MF9w6LJ20
         c8Yt8VAci2RiM13VryMilWq3JVR1B8hfmWJ/IyCWlXCkJFepqoO2ZnN0UY6Q7xd+/q
         jZdZcQNxCkmU9eHWasWCxLnDjGxXsJjStfg3gXnWWC7lvPo3pgDN5ZkY29UFa/JalU
         Tv8aTIP6qpYl1lZfK8WGlzlvM71NqsDfBiZBrYkEHBFYei0dNGQKj7ZRBnhK6Ex0hz
         rXA0SB/VZ0pYYOs28Yq8YZlix1wIgu2wWpEWJFJFmCPKx0nE8keuNcjluBDK4caVRD
         M66r+ymQMW5Wg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8FC804035D; Tue, 31 Oct 2023 12:31:01 -0300 (-03)
Date:   Tue, 31 Oct 2023 12:31:01 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Guilherme Amadio <amadio@gentoo.org>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH next 2/3] perf tests make: Remove the last egrep call, use
 'grep -E' instead
Message-ID: <ZUEdtblE8qDAQkBK@kernel.org>
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

One last case, caught while testing with amazonlinux:2, centos:stream,
etc:

   4     7.28 amazonlinux:2                 : FAIL egrep: warning: egrep is obsolescent; using grep -E
   8    13.87 centos:stream                 : FAIL egrep: warning: egrep is obsolescent; using grep -E

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Guilherme Amadio <amadio@gentoo.org>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/make | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index d9945ed25bc5ae96..8a4da7eb637a8abd 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -183,7 +183,7 @@ run += make_install_prefix_slash
 # run += make_install_pdf
 run += make_minimal
 
-old_libbpf := $(shell echo '\#include <bpf/libbpf.h>' | $(CC) -E -dM -x c -| egrep -q "define[[:space:]]+LIBBPF_MAJOR_VERSION[[:space:]]+0{1}")
+old_libbpf := $(shell echo '\#include <bpf/libbpf.h>' | $(CC) -E -dM -x c -| grep -q -E "define[[:space:]]+LIBBPF_MAJOR_VERSION[[:space:]]+0{1}")
 
 ifneq ($(old_libbpf),)
 run += make_libbpf_dynamic
-- 
2.41.0

