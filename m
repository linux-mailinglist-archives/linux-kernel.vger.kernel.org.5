Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2935F77A8AF
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 18:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjHMQEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 12:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbjHMQEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 12:04:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A3D1BD8;
        Sun, 13 Aug 2023 09:04:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 936E863711;
        Sun, 13 Aug 2023 16:04:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85887C433C8;
        Sun, 13 Aug 2023 16:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691942651;
        bh=QhCmGArcIGAUg7xrNAxrgEsBDLrQ7HzLiIbb2cDk0EE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=byplqiKkqOC/zAPkVqmy7IRosN/XBr2eIFc+GiIWhVT5zBdBiQJxJ9kUQfRP/7ARM
         sIMWvovz+MRBaIlYUfiKubVrFbXVtw8mPaqe5xXrrW9iu8+4zgm1hiCQCQtrkaqZjy
         4rGd4BWP709SbFIzav7K7PDu2rKzqG175FwltAKTXGsAZ8xDe6J6zAlcfhdV+rGusY
         Utw8Nbx+RcmHlRYLf50TzOEdNX0AiBZ7A+4AICoBGRlaNY9IHHrg3Bz8bKLbEkZJmO
         1XVmpZy+c1/aDU40uQ4ygBChpXfJruwf+UB3WwgZkNEEIZ7qRmLStNFthTL8+2mVwn
         NxzTBpjbx/wow==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, davem@davemloft.net,
        linux-trace-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 47/47] kprobes: Prohibit probing on CFI preamble symbol
Date:   Sun, 13 Aug 2023 11:59:42 -0400
Message-Id: <20230813160006.1073695-47-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230813160006.1073695-1-sashal@kernel.org>
References: <20230813160006.1073695-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.45
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

[ Upstream commit de02f2ac5d8cfb311f44f2bf144cc20002f1fbbd ]

Do not allow to probe on "__cfi_" or "__pfx_" started symbol, because those
are used for CFI and not executed. Probing it will break the CFI.

Link: https://lore.kernel.org/all/168904024679.116016.18089228029322008512.stgit@devnote2/

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/kprobes.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 00e177de91ccd..3da9726232ff9 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1545,6 +1545,17 @@ static int check_ftrace_location(struct kprobe *p)
 	return 0;
 }
 
+static bool is_cfi_preamble_symbol(unsigned long addr)
+{
+	char symbuf[KSYM_NAME_LEN];
+
+	if (lookup_symbol_name(addr, symbuf))
+		return false;
+
+	return str_has_prefix("__cfi_", symbuf) ||
+		str_has_prefix("__pfx_", symbuf);
+}
+
 static int check_kprobe_address_safe(struct kprobe *p,
 				     struct module **probed_mod)
 {
@@ -1563,7 +1574,8 @@ static int check_kprobe_address_safe(struct kprobe *p,
 	    within_kprobe_blacklist((unsigned long) p->addr) ||
 	    jump_label_text_reserved(p->addr, p->addr) ||
 	    static_call_text_reserved(p->addr, p->addr) ||
-	    find_bug((unsigned long)p->addr)) {
+	    find_bug((unsigned long)p->addr) ||
+	    is_cfi_preamble_symbol((unsigned long)p->addr)) {
 		ret = -EINVAL;
 		goto out;
 	}
-- 
2.40.1

