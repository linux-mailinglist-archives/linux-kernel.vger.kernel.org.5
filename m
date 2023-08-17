Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 828BF77EE39
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 02:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347318AbjHQA3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 20:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347317AbjHQA2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 20:28:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4E4E76
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 17:28:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78D3B63C74
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 00:28:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75F93C433C8;
        Thu, 17 Aug 2023 00:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692232128;
        bh=KuJ1u/Ptd1yFGVDRhEhDSVMIhKS60TBUWM8biRyZBv8=;
        h=Date:From:To:Cc:Subject:From;
        b=WaY7wanEr2DFpfb8YQ09wFRFZgdhxiwZhJ5zXucrNmGmqQuZuJcz1ag6mmAjNkN4h
         Q+M3SaBNqWvsaq+GLURjJPe90JpYGrR/p1VZP4Klx3lEZGG5ISuIMLOSO6HVYAuZ11
         XKZirib3+9JvdP/ra0bpTrS7MRg40In4D+k7tK2tuc6X8mRDPUwKHN8SgEKLbDYGZ2
         emWIFz3Q4rTVNofa9iHDDBRGWaapcATEvthJ18r7bWCsvNMGX80oxaoyA5qibJKgBL
         OYAgElYiI4a/QUXIJUTGwGv/silN6qu5a7mhHrVDY8k0kYu1tm1RWyjWny1Xj4nVbN
         AQO6PUofwpr4A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5A37A404DF; Wed, 16 Aug 2023 21:28:45 -0300 (-03)
Date:   Wed, 16 Aug 2023 21:28:45 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Dumping a struct to a buffer in an strace like style using BTF
Message-ID: <ZN1pveIr5W1ulPHh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

	Something I planned to do since forever is to get the contents
of syscall args and print in 'perf trace' using BTF, right now we have
things like:

[root@quaco ~]# perf trace -e connect* ssh localhost
     0.000 ( 0.342 ms): ssh/438068 connect(fd: 3, uservaddr: { .family: INET, port: 22, addr: 127.0.0.1 }, addrlen: 16) = 0
root@localhost's password:

in perf-tools-next when building with BUILD_BPF_SKEL=1 that will hook
into that specific syscall and collect the uservaddr sockaddr struct and
then pretty print it.

That is done manually (the last leg) in
tools/perf/trace/beauty/sockaddr.c:

  syscall_arg__scnprintf_augmented_sockaddr
     af_scnprintfs[family](syscall pointer contents collected via BPF)

which leads to struct sockaddr_in or sockaddr_in6 specific pretty
printers, I wanted to do what these two struct specific pretty printers
do but using BTF.

I guess this is already available, but from a _really_ quick look at
libbpf I couldn't find it, ideas?

I want to try the code at the end of this message for another
multiplexer syscall, bpf(), with this on top of what is at:

git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git perf-tools-next

Best regards,

- Arnaldo

diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
index 9c1d0b271b20f693..79767422efe9479c 100644
--- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
+++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
@@ -319,6 +319,27 @@ int sys_enter_perf_event_open(struct syscall_enter_args *args)
 	return 1; /* Failure: don't filter */
 }
 
+SEC("tp/syscalls/sys_enter_bpf")
+int sys_enter_bpf(struct syscall_enter_args *args)
+{
+	struct augmented_args_payload *augmented_args = augmented_args_payload();
+	const void *attr = (void *)args->args[1];
+	unsigned int size = args->args[2];
+	unsigned int len = sizeof(augmented_args->args);
+
+        if (augmented_args == NULL)
+		goto failure;
+
+	size &= sizeof(augmented_args->__data) - 1;
+
+	if (bpf_probe_read(&augmented_args->__data, size, attr) < 0)
+		goto failure;
+
+	return augmented__output(args, augmented_args, len + size);
+failure:
+	return 1; /* Failure: don't filter */
+}
+
 SEC("tp/syscalls/sys_enter_clock_nanosleep")
 int sys_enter_clock_nanosleep(struct syscall_enter_args *args)
 {
