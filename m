Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5212782AB5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 15:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235487AbjHUNkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 09:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbjHUNkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 09:40:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A798CB1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 06:40:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 438E263768
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 13:40:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B0C3C433C8;
        Mon, 21 Aug 2023 13:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692625205;
        bh=robD6Qvk7RBLuzCXc8ksn5wD90WLafDnKkZgfTSvZWk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dzPIWunafzRrjSKU8cDGbYfniv4IKoMSXQtoXkjsBsHp5xJMcwvY5EiKRGRgPqY22
         rKVDJliSVOTpJZs4yAKytOujv5/k9Z9g7xgfXL1Aut5zpPaE8tMzS6qCchLTre0Xeb
         HUNAGgrDDnvJE8ENKz7NpTvIrSrGpE53XKwXXoogCKMo1N9xZ4CyKP3Yc/AdhNglkr
         H7n53YWlr0zpit7VYnD3Ce3l7AtBBjT9cxkddYp0ouXWekEgAF4HIq6soaOXnJJAMX
         RnlbXu4cg7t+LH70VpN5ZnlZ+f5QeYA79Gwed1Lyfx3Yx1vQGb4c4zbYjOsmqLNajC
         HQqWmYk5SvUOg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 10D2540722; Mon, 21 Aug 2023 10:40:02 -0300 (-03)
Date:   Mon, 21 Aug 2023 10:40:02 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] perf bpf_skel augmented_raw_syscalls: Cap the
 socklen parameter using &= sizeof(saddr)
Message-ID: <ZONpMu2/tQvZgM/S@kernel.org>
References: <ZN1ELw41wQE5zDrK@kernel.org>
 <CAP-5=fVU07VHcQE6r9k7aEV+xM3_HFcgY+5Y8N7qVvsZD3V9vg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVU07VHcQE6r9k7aEV+xM3_HFcgY+5Y8N7qVvsZD3V9vg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Aug 16, 2023 at 03:10:00PM -0700, Ian Rogers escreveu:
> On Wed, Aug 16, 2023 at 2:48 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >   R2 min value is negative, either use unsigned or 'var &= const'
> >   processed 22 insns (limit 1000000) max_states_per_insn 0 total_states 1 peak_states 1 mark_read 1
> >   -- END PROG LOAD LOG --
> >   libbpf: prog 'sys_enter_sendto': failed to load: -13
> >   libbpf: failed to load object 'augmented_raw_syscalls_bpf'
> >   libbpf: failed to load BPF skeleton 'augmented_raw_syscalls_bpf': -13
> >
> > So use the suggested &= variant since sizeof(saddr) == 128 bytes.
> 
> Could this be an assert?

you mean (removing the change to saddr to make it trigger):

diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
index 9c1d0b271b20f693..521ce2d7357d983c 100644
--- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
+++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
@@ -10,6 +10,16 @@
 #include <bpf/bpf_helpers.h>
 #include <linux/limits.h>
 
+/**
+ * is_power_of_2() - check if a value is a power of two
+ * @n: the value to check
+ *
+ * Determine whether some value is a power of two, where zero is *not*
+ * considered a power of two.  Return: true if @n is a power of 2, otherwise
+ * false.
+ */
+#define is_power_of_2(n) (n != 0 && ((n & (n - 1)) == 0))
+
 #define MAX_CPUS  4096
 
 // FIXME: These should come from system headers
@@ -112,7 +122,10 @@ struct augmented_args_payload {
 		struct {
 			struct augmented_arg arg, arg2;
 		};
-		struct sockaddr_storage saddr;
+		struct {
+			struct sockaddr_storage real_saddr;
+			char padding;
+		} saddr;
 		char   __data[sizeof(struct augmented_arg)];
 	};
 };
@@ -187,6 +200,7 @@ int sys_enter_connect(struct syscall_enter_args *args)
         if (augmented_args == NULL)
                 return 1; /* Failure: don't filter */
 
+	_Static_assert(is_power_of_2(sizeof(augmented_args->saddr)), "sizeof(augmented_args->saddr) needs to be a power of two");
 	socklen &= sizeof(augmented_args->saddr) - 1;
 
 	bpf_probe_read(&augmented_args->saddr, socklen, sockaddr_arg);


--------------------------------

  CLANG   /tmp/build/perf-tools-next/util/bpf_skel/.tmp/augmented_raw_syscalls.bpf.o
util/bpf_skel/augmented_raw_syscalls.bpf.c:203:2: error: static_assert failed due to requirement 'sizeof (augmented_args->saddr) != 0 && ((sizeof (augmented_args->saddr) & (sizeof (augmented_args->saddr) - 1)) == 0)' "sizeof(augmented_args->saddr) needs to be a power of two"
        _Static_assert(is_power_of_2(sizeof(augmented_args->saddr)), "sizeof(augmented_args->saddr) needs to be a power of two");
        ^              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
1 error generated.
make[2]: *** [Makefile.perf:1104: /tmp/build/perf-tools-next/util/bpf_skel/.tmp/augmented_raw_syscalls.bpf.o] Error 1
make[1]: *** [Makefile.perf:238: sub-make] Error 2
make: *** [Makefile:113: install-bin] Error 2
make: Leaving directory '/var/home/acme/git/perf-tools-next/tools/perf'

And here the assert being satisfied:

⬢[acme@toolbox perf-tools-next]$ git diff
diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
index 9c1d0b271b20f693..43549b63b433d81e 100644
--- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
+++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
@@ -10,6 +10,16 @@
 #include <bpf/bpf_helpers.h>
 #include <linux/limits.h>

+/**
+ * is_power_of_2() - check if a value is a power of two
+ * @n: the value to check
+ *
+ * Determine whether some value is a power of two, where zero is *not*
+ * considered a power of two.  Return: true if @n is a power of 2, otherwise
+ * false.
+ */
+#define is_power_of_2(n) (n != 0 && ((n & (n - 1)) == 0))
+
 #define MAX_CPUS  4096

 // FIXME: These should come from system headers
@@ -187,6 +197,7 @@ int sys_enter_connect(struct syscall_enter_args *args)
         if (augmented_args == NULL)
                 return 1; /* Failure: don't filter */

+       _Static_assert(is_power_of_2(sizeof(augmented_args->saddr)), "sizeof(augmented_args->saddr) needs to be a power of two");
        socklen &= sizeof(augmented_args->saddr) - 1;

        bpf_probe_read(&augmented_args->saddr, socklen, sockaddr_arg);
⬢[acme@toolbox perf-tools-next]$ m
make: Entering directory '/var/home/acme/git/perf-tools-next/tools/perf'
  BUILD:   Doing 'make -j32' parallel build
  INSTALL libsubcmd_headers
  INSTALL libperf_headers
  INSTALL libapi_headers
  INSTALL libbpf_headers
  CLANG   /tmp/build/perf-tools-next/util/bpf_skel/.tmp/augmented_raw_syscalls.bpf.o
  GENSKEL /tmp/build/perf-tools-next/util/bpf_skel/augmented_raw_syscalls.skel.h
  INSTALL libsymbol_headers
  CC      /tmp/build/perf-tools-next/builtin-trace.o
  LD      /tmp/build/perf-tools-next/perf-in.o
  LINK    /tmp/build/perf-tools-next/perf
  INSTALL binaries
  INSTALL tests
  INSTALL libperf-jvmti.so
  INSTALL libexec
  INSTALL perf-archive
  INSTALL perf-iostat
  INSTALL strace/groups
  INSTALL perl-scripts
  INSTALL python-scripts
  INSTALL dlfilters
  INSTALL perf_completion-script
  INSTALL perf-tip
make: Leaving directory '/var/home/acme/git/perf-tools-next/tools/perf'
⬢[acme@toolbox perf-tools-next]$




