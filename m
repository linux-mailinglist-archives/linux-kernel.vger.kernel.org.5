Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C34F5768ED6
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 09:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbjGaHcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 03:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbjGaHbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 03:31:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2669610C;
        Mon, 31 Jul 2023 00:30:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B872760F07;
        Mon, 31 Jul 2023 07:30:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BE2DC433C7;
        Mon, 31 Jul 2023 07:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690788639;
        bh=ZxqLQEDqyrTI+b7ozLCG2peyd8pHZudlPd6y62zwtWQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hpZUtMBGR106BHm0aj2xR7/CzYRk5wdguE7xIfK2kjju17dMC1Ve8PY4G1GNYkn8P
         2LV0DgD+0uZ2JB2OfOKjP2TNXSwEacmeNU3iq2kQ+BM124AGnkMCwl8LK9dVJYNTbC
         eFZeK+jAz/1F9dBubKz5HaIaUNZyIsrk24FSMnmUWFXms6R1GFjXeVNp/oo5KiJ3di
         U3q5sCGsPnRGezK13vAsoxDPYLDL5D05+ljYET+h3qXjCOkCteT/bH7ZnIA/brGmOm
         pqUNLdUbGklzV2bIIs7RMX7T6iRZx6uu6BEa2Kx/6E0Ss/2t35rnt8vNq0+atuBnuJ
         dnNS988aIFc4A==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     linux-trace-kernel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        mhiramat@kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
        bpf@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH v4 3/9] bpf/btf: Add a function to search a member of a struct/union
Date:   Mon, 31 Jul 2023 16:30:34 +0900
Message-Id: <169078863449.173706.2322042687021909241.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <169078860386.173706.3091034523220945605.stgit@devnote2>
References: <169078860386.173706.3091034523220945605.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Add btf_find_struct_member() API to search a member of a given data structure
or union from the member's name.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
---
 Changes in v3:
  - Remove simple input check.
  - Fix unneeded IS_ERR_OR_NULL() check for btf_type_by_id().
  - Move the code next to btf_get_func_param().
  - Use for_each_member() macro instead of for-loop.
  - Use btf_type_skip_modifiers() instead of btf_type_by_id().
 Changes in v4:
  - Use a stack for searching in anonymous members instead of nested call.
---
 include/linux/btf.h |    3 +++
 kernel/bpf/btf.c    |   40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 20e3a07eef8f..4b10d57ceee0 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -226,6 +226,9 @@ const struct btf_type *btf_find_func_proto(const char *func_name,
 					   struct btf **btf_p);
 const struct btf_param *btf_get_func_param(const struct btf_type *func_proto,
 					   s32 *nr);
+const struct btf_member *btf_find_struct_member(struct btf *btf,
+						const struct btf_type *type,
+						const char *member_name);
 
 #define for_each_member(i, struct_type, member)			\
 	for (i = 0, member = btf_type_member(struct_type);	\
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index f7b25c615269..8d81a4ffa67b 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -958,6 +958,46 @@ const struct btf_param *btf_get_func_param(const struct btf_type *func_proto, s3
 		return NULL;
 }
 
+#define BTF_ANON_STACK_MAX	16
+
+/*
+ * Find a member of data structure/union by name and return it.
+ * Return NULL if not found, or -EINVAL if parameter is invalid.
+ */
+const struct btf_member *btf_find_struct_member(struct btf *btf,
+						const struct btf_type *type,
+						const char *member_name)
+{
+	const struct btf_type *anon_stack[BTF_ANON_STACK_MAX];
+	const struct btf_member *member;
+	const char *name;
+	int i, top = 0;
+
+retry:
+	if (!btf_type_is_struct(type))
+		return ERR_PTR(-EINVAL);
+
+	for_each_member(i, type, member) {
+		if (!member->name_off) {
+			/* Anonymous union/struct: push it for later use */
+			type = btf_type_skip_modifiers(btf, member->type, NULL);
+			if (type && top < BTF_ANON_STACK_MAX)
+				anon_stack[top++] = type;
+		} else {
+			name = btf_name_by_offset(btf, member->name_off);
+			if (name && !strcmp(member_name, name))
+				return member;
+		}
+	}
+	if (top > 0) {
+		/* Pop from the anonymous stack and retry */
+		type = anon_stack[--top];
+		goto retry;
+	}
+
+	return NULL;
+}
+
 #define BTF_SHOW_MAX_ITER	10
 
 #define BTF_KIND_BIT(kind)	(1ULL << kind)

