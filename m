Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C20777A978
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 18:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233341AbjHMQNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 12:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233356AbjHMQMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 12:12:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906FA4217;
        Sun, 13 Aug 2023 09:11:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 947AD60B54;
        Sun, 13 Aug 2023 16:11:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52604C433CB;
        Sun, 13 Aug 2023 16:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691943088;
        bh=AmUKYD+d4jYmJTR3E1t1wEgufIl+FTQKg03u9VLjEtI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mF+CY4Ni/2DlgUtdPNH3WIMAUTyvvE4wp86l+VbByw4lbcqKqKoBUauqFy7ab8lGJ
         F/g3T/PKQOWLKB2tK21WjGkoobRRligwW6Raqx9MfvVjqQn03cGPmL82yjmcMNTzIB
         yQxn1FrACp3XTpAH0Uvnrs+7VnfHnD9dZX3UMSynHBJmhX7v0CoNTILHEojqefNGhB
         Wa9XjZp9dMs4Hpx/SprUSWAUWOClQj5eRZiowoMV8cW5xjM4cdV6vYqqohojX7v9nh
         8cllVT3C1Wop6RbLe383GGLVXQLahm9gKosgoADjNMen1n02GdWluw9bCT0KfPOTrL
         jWFYCa2ICYYcg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, davem@davemloft.net,
        linux-trace-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 25/25] kprobes: Prohibit probing on CFI preamble symbol
Date:   Sun, 13 Aug 2023 12:09:36 -0400
Message-Id: <20230813160936.1082758-25-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230813160936.1082758-1-sashal@kernel.org>
References: <20230813160936.1082758-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.190
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
index 86d71c49b4957..f1ea3123f3832 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1628,6 +1628,17 @@ int __weak arch_check_ftrace_location(struct kprobe *p)
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
@@ -1646,7 +1657,8 @@ static int check_kprobe_address_safe(struct kprobe *p,
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

