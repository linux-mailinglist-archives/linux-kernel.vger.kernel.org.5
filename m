Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68DB2753B62
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 14:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235804AbjGNM7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 08:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235651AbjGNM7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 08:59:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35133273F
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 05:59:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C79D261D11
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 12:59:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03FA4C433C9;
        Fri, 14 Jul 2023 12:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689339579;
        bh=xkMmZ3HjRvChUISkHAItxgCXPI4Pjj2KMRxqWgZUj54=;
        h=Date:From:To:Cc:Subject:From;
        b=d7nf/NIYKQpLbo8U9lYE+YVcw8gU2WgleRPKCw6IyXoiuH4AkwtPfsFRNxaDGuh/D
         kDh8mWrfUqLRFNmqpK+LWmUZE/K7jILMU2kxuiknB2o/xHjAsZ0Ooff8AqYGtzAs2m
         T+3PL4et2wdF0EiyJe57WMkYvz1e06x621Y8E2p18HuSLkQvXV4LJQlYpOet+W4YHi
         BrXshfKCg8qtFYkD3Mwiqw1cvzpvr1JudwepAH1oG956tKWltwOZSgaqprk+h1vLwt
         1fzlwNZO3f/5mgGxbXep843e3u/qxmudYpM9KURj7dMyOLlpFVMxfzS+lrwedqYoo6
         06FzErGguhLZg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5CAE440516; Fri, 14 Jul 2023 09:59:36 -0300 (-03)
Date:   Fri, 14 Jul 2023 09:59:36 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        David Howells <dhowells@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ian Rogers <irogers@google.com>,
        Jakub Kicinski <kuba@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 1/1 fyi] perf beauty: Update copy of linux/socket.h with the
 kernel sources
Message-ID: <ZLFGuHDwUGDGXdoR@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tldr; Just FYI, I'm carrying this on the perf tools tree.

- Arnaldo

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

---

To pick the changes in:

  b848b26c6672c9b9 ("net: Kill MSG_SENDPAGE_NOTLAST")
  5e2ff6704a275be0 ("scm: add SO_PASSPIDFD and SCM_PIDFD")
  4fe38acdac8a71f7 ("net: Block MSG_SENDPAGE_* from being passed to sendmsg() by userspace")
  b841b901c452d926 ("net: Declare MSG_SPLICE_PAGES internal sendmsg() flag")

That don't result in any changes in the tables generated from that
header.

But while updating I noticed we were not handling MSG_BATCH and MSG_ZEROCOPY in the
hard coded table for the msg flags table, add them.

This silences this perf build warning:

  Warning: Kernel ABI header differences:
    diff -u tools/perf/trace/beauty/include/linux/socket.h include/linux/socket.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: David Howells <dhowells@redhat.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Ian Rogers <irogers@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/include/linux/socket.h | 5 +++++
 tools/perf/trace/beauty/msg_flags.c            | 8 ++++++++
 2 files changed, 13 insertions(+)

diff --git a/tools/perf/trace/beauty/include/linux/socket.h b/tools/perf/trace/beauty/include/linux/socket.h
index 3bef212a24d776c2..39b74d83c7c4a7e8 100644
--- a/tools/perf/trace/beauty/include/linux/socket.h
+++ b/tools/perf/trace/beauty/include/linux/socket.h
@@ -177,6 +177,7 @@ static inline size_t msg_data_left(struct msghdr *msg)
 #define	SCM_RIGHTS	0x01		/* rw: access rights (array of int) */
 #define SCM_CREDENTIALS 0x02		/* rw: struct ucred		*/
 #define SCM_SECURITY	0x03		/* rw: security label		*/
+#define SCM_PIDFD	0x04		/* ro: pidfd (int)		*/
 
 struct ucred {
 	__u32	pid;
@@ -326,6 +327,7 @@ struct ucred {
 					  */
 
 #define MSG_ZEROCOPY	0x4000000	/* Use user data in kernel path */
+#define MSG_SPLICE_PAGES 0x8000000	/* Splice the pages from the iterator in sendmsg() */
 #define MSG_FASTOPEN	0x20000000	/* Send data in TCP SYN */
 #define MSG_CMSG_CLOEXEC 0x40000000	/* Set close_on_exec for file
 					   descriptor received through
@@ -336,6 +338,9 @@ struct ucred {
 #define MSG_CMSG_COMPAT	0		/* We never have 32 bit fixups */
 #endif
 
+/* Flags to be cleared on entry by sendmsg and sendmmsg syscalls */
+#define MSG_INTERNAL_SENDMSG_FLAGS \
+	(MSG_SPLICE_PAGES | MSG_SENDPAGE_NOPOLICY | MSG_SENDPAGE_DECRYPTED)
 
 /* Setsockoptions(2) level. Thanks to BSD these must match IPPROTO_xxx */
 #define SOL_IP		0
diff --git a/tools/perf/trace/beauty/msg_flags.c b/tools/perf/trace/beauty/msg_flags.c
index aa9934020232eaac..ed3ff969b5465bbf 100644
--- a/tools/perf/trace/beauty/msg_flags.c
+++ b/tools/perf/trace/beauty/msg_flags.c
@@ -8,6 +8,12 @@
 #ifndef MSG_WAITFORONE
 #define MSG_WAITFORONE		   0x10000
 #endif
+#ifndef MSG_BATCH
+#define MSG_BATCH		   0x40000
+#endif
+#ifndef MSG_ZEROCOPY
+#define MSG_ZEROCOPY		 0x4000000
+#endif
 #ifndef MSG_SPLICE_PAGES
 #define MSG_SPLICE_PAGES	0x8000000
 #endif
@@ -50,6 +56,8 @@ static size_t syscall_arg__scnprintf_msg_flags(char *bf, size_t size,
 	P_MSG_FLAG(NOSIGNAL);
 	P_MSG_FLAG(MORE);
 	P_MSG_FLAG(WAITFORONE);
+	P_MSG_FLAG(BATCH);
+	P_MSG_FLAG(ZEROCOPY);
 	P_MSG_FLAG(SPLICE_PAGES);
 	P_MSG_FLAG(FASTOPEN);
 	P_MSG_FLAG(CMSG_CLOEXEC);
-- 
2.37.1

