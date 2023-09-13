Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 573AF79E721
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 13:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240441AbjIMLsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 07:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235715AbjIMLsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 07:48:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E833110E6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 04:48:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 620DEC433C8;
        Wed, 13 Sep 2023 11:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694605712;
        bh=Vb33qlf0ZwjYVrEHkwd4Hitu/bcjtnaGY47clFBlEh0=;
        h=Date:From:To:Cc:Subject:From;
        b=hHdnDVQtMAz1N4rWXipk/2tlW2VtQpoQblEp6kRsV9+ywz5deHrMFobG3aqYukla3
         JM2tZqplzO2v4M7GhqN80/ODQoGcr0VyLE3poPmhWNMRnyO2i0Ew6toEbDL1VBKGpr
         NS1362FjxluAZBP/IKNCv6aInuLMFE6VIZ7JuBIgjTwIQxxjy6rqSnftY7s5muwNfG
         JN/juiZwVmz8b1bPsyBFylk3tpZL6c4VUeq4NxnsAD8uLj64FrJKLAyhyJtRDJthHT
         WI2/QWqgnaDDfPk3+806p7L5jWC+Ntz9vQTOsrl1RkNsBiNfxVFVeQmOrA2dCP88Mw
         rJVABKRyBH+AA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 95B5A403F4; Wed, 13 Sep 2023 08:48:29 -0300 (-03)
Date:   Wed, 13 Sep 2023 08:48:29 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrei Vagin <avagin@google.com>, linux-kernel@vger.kernel.org
Cc:     Kees Kook <keescook@chromium.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 2/2 fyi] perf bench sched-seccomp-notify: Use the tools copy
 of seccomp.h UAPI
Message-ID: <ZQGhjaojgOGtSNk6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To keep perf building in systems where types and defines used in this
new benchmark are not available, such as:

  12    13.46 centos:stream                 : FAIL gcc version 8.5.0 20210514 (Red Hat 8.5.0-20) (GCC)
    bench/sched-seccomp-notify.c: In function 'user_notif_syscall':
    bench/sched-seccomp-notify.c:55:27: error: 'SECCOMP_RET_USER_NOTIF' undeclared (first use in this function); did you mean 'SECCOMP_RET_ERRNO'?
       BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_USER_NOTIF),
                               ^~~~~~~~~~~~~~~~~~~~~~
    /git/perf-6.6.0-rc1/tools/include/uapi/linux/filter.h:49:59: note: in definition of macro 'BPF_STMT'
     #define BPF_STMT(code, k) { (unsigned short)(code), 0, 0, k }
                                                               ^
    bench/sched-seccomp-notify.c:55:27: note: each undeclared identifier is reported only once for each function it appears in
       BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_USER_NOTIF),
                               ^~~~~~~~~~~~~~~~~~~~~~
    /git/perf-6.6.0-rc1/tools/include/uapi/linux/filter.h:49:59: note: in definition of macro 'BPF_STMT'
     #define BPF_STMT(code, k) { (unsigned short)(code), 0, 0, k }
                                                               ^
    bench/sched-seccomp-notify.c:55:3: error: missing initializer for field 'k' of 'struct sock_filter' [-Werror=missing-field-initializers]
       BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_USER_NOTIF),
       ^~~~~~~~
    In file included from bench/sched-seccomp-notify.c:5:
    /git/perf-6.6.0-rc1/tools/include/uapi/linux/filter.h:28:8: note: 'k' declared here
      __u32 k;      /* Generic multiuse field */
            ^
    bench/sched-seccomp-notify.c: In function 'user_notification_sync_loop':
    bench/sched-seccomp-notify.c:70:28: error: storage size of 'resp' isn't known
      struct seccomp_notif_resp resp;
                                ^~~~
    bench/sched-seccomp-notify.c:71:23: error: storage size of 'req' isn't known
      struct seccomp_notif req;
                           ^~~
    bench/sched-seccomp-notify.c:76:23: error: 'SECCOMP_IOCTL_NOTIF_RECV' undeclared (first use in this function); did you mean 'SECCOMP_MODE_STRICT'?
       if (ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, &req))
                           ^~~~~~~~~~~~~~~~~~~~~~~~
                           SECCOMP_MODE_STRICT
    bench/sched-seccomp-notify.c:86:23: error: 'SECCOMP_IOCTL_NOTIF_SEND' undeclared (first use in this function); did you mean 'SECCOMP_RET_ACTION'?
       if (ioctl(listener, SECCOMP_IOCTL_NOTIF_SEND, &resp))
                           ^~~~~~~~~~~~~~~~~~~~~~~~
                           SECCOMP_RET_ACTION
    bench/sched-seccomp-notify.c:71:23: error: unused variable 'req' [-Werror=unused-variable]
      struct seccomp_notif req;
                           ^~~
    bench/sched-seccomp-notify.c:70:28: error: unused variable 'resp' [-Werror=unused-variable]
      struct seccomp_notif_resp resp;
                                ^~~~

  14    11.31 debian:10                     : FAIL gcc version 8.3.0 (Debian 8.3.0-6)

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andrei Vagin <avagin@google.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kees Kook <keescook@chromium.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/bench/sched-seccomp-notify.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/bench/sched-seccomp-notify.c b/tools/perf/bench/sched-seccomp-notify.c
index b04ebcde40361636..a01c40131493b76d 100644
--- a/tools/perf/bench/sched-seccomp-notify.c
+++ b/tools/perf/bench/sched-seccomp-notify.c
@@ -9,7 +9,7 @@
 #include <sys/syscall.h>
 #include <sys/ioctl.h>
 #include <linux/time64.h>
-#include <linux/seccomp.h>
+#include <uapi/linux/seccomp.h>
 #include <sys/prctl.h>
 
 #include <unistd.h>
-- 
2.37.1

