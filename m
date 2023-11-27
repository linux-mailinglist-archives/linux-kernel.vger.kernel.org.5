Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21A697FA170
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 14:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbjK0Nxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 08:53:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233349AbjK0Nxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 08:53:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9497410F6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 05:53:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1814BC433C9;
        Mon, 27 Nov 2023 13:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701093217;
        bh=EOdwMS7vJXCXxyNePs9bFMY5mRinN5nN+9oKZfWkeWA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L4MHBN57G3QZY8ZAh54PDFudFE/St4hEVitLMygv1Z4kN+/CH7s0Ubc9aIiSMnpWw
         gN8AOtl4+2kJlP8xj/QCVHu7xMdGJbhNKMnvyychWczEQQ/qlfXzpbalfCqtA/EeFB
         zNs6si1q0pdoOYUndWF9NKh1+Jg7Ii43OKR4M0nQ3n+GYr8UTFk/emjyVFIZ2uubgx
         gWS3Aja/nmDUGqncUIc6Rae++58FMe3Jb6ytLBJVWIIAUXIPQNrvWwIMKnpTAFKPz8
         kUqE75Z+ZCFdXELpXEZQKSWEvS5N53wfCXvcCnOQrm2hN7ltjMteO7Rysr+4hgyxlA
         K1KjVb0sr1ChA==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Florent Revest <revest@chromium.org>
Cc:     linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        bpf <bpf@vger.kernel.org>, Sven Schnelle <svens@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alan Maguire <alan.maguire@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Guo Ren <guoren@kernel.org>
Subject: [PATCH v3 03/33] seq_buf: Export seq_buf_puts()
Date:   Mon, 27 Nov 2023 22:53:30 +0900
Message-Id: <170109320996.343914.1584440210780959121.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <170109317214.343914.4784420430328654397.stgit@devnote2>
References: <170109317214.343914.4784420430328654397.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Mark seq_buf_puts() which is part of the seq_buf API to be exported to
kernel loadable GPL modules.

Link: https://lkml.kernel.org/r/b9e3737f66ec2450221b492048ce0d9c65c84953.1698861216.git.christophe.jaillet@wanadoo.fr

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 lib/seq_buf.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/seq_buf.c b/lib/seq_buf.c
index 45c450f423fa..46a1b00c3815 100644
--- a/lib/seq_buf.c
+++ b/lib/seq_buf.c
@@ -189,6 +189,7 @@ int seq_buf_puts(struct seq_buf *s, const char *str)
 	seq_buf_set_overflow(s);
 	return -1;
 }
+EXPORT_SYMBOL_GPL(seq_buf_puts);
 
 /**
  * seq_buf_putc - sequence printing of simple character

