Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD637E3CA9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 13:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234552AbjKGMSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 07:18:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234535AbjKGMRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 07:17:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D7449CD;
        Tue,  7 Nov 2023 04:12:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEBA0C433CB;
        Tue,  7 Nov 2023 12:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699359156;
        bh=UhzqtkAvz5hvgm49oxMlVfd4HYkO+RBaT0RgXicuMJc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hR6c3w5TpVVFNGhZ8gL53tFyM7zmq5bgNA8Tt7D2Td0p+038BbxlFeNiIokfVHSqR
         48cUuzcABulBfnVEX+16qd91eohZNnvi9kWMHa8BEzpZNXFgpE7iR65o4mN94jO/4x
         Z5cThkn/MGboYDod+vdfCkTaBT2A+ZMUJjUC3pyzQzE/ROX/0xlG/axzdcxJi1ipeP
         APnmX9OzOzNkUfV0crTgOeRuGWEDiABxVA0z0zogOAYRCrOIWOw6Ee2NAcD0q+iMK3
         T1gRrEXI923QaP+qcOJAQwLBlH53SYhbWuy6rXgXDxvb+CVATbKEgz/kyLAm++4/wJ
         7lkOOi5BIIKkw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>, daniel@iogearbox.net,
        andrii@kernel.org, bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 03/11] bpf: Detect IP == ksym.end as part of BPF program
Date:   Tue,  7 Nov 2023 07:12:18 -0500
Message-ID: <20231107121230.3758617-3-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107121230.3758617-1-sashal@kernel.org>
References: <20231107121230.3758617-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.199
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

From: Kumar Kartikeya Dwivedi <memxor@gmail.com>

[ Upstream commit 66d9111f3517f85ef2af0337ece02683ce0faf21 ]

Now that bpf_throw kfunc is the first such call instruction that has
noreturn semantics within the verifier, this also kicks in dead code
elimination in unprecedented ways. For one, any instruction following
a bpf_throw call will never be marked as seen. Moreover, if a callchain
ends up throwing, any instructions after the call instruction to the
eventually throwing subprog in callers will also never be marked as
seen.

The tempting way to fix this would be to emit extra 'int3' instructions
which bump the jited_len of a program, and ensure that during runtime
when a program throws, we can discover its boundaries even if the call
instruction to bpf_throw (or to subprogs that always throw) is emitted
as the final instruction in the program.

An example of such a program would be this:

do_something():
	...
	r0 = 0
	exit

foo():
	r1 = 0
	call bpf_throw
	r0 = 0
	exit

bar(cond):
	if r1 != 0 goto pc+2
	call do_something
	exit
	call foo
	r0 = 0  // Never seen by verifier
	exit	//

main(ctx):
	r1 = ...
	call bar
	r0 = 0
	exit

Here, if we do end up throwing, the stacktrace would be the following:

bpf_throw
foo
bar
main

In bar, the final instruction emitted will be the call to foo, as such,
the return address will be the subsequent instruction (which the JIT
emits as int3 on x86). This will end up lying outside the jited_len of
the program, thus, when unwinding, we will fail to discover the return
address as belonging to any program and end up in a panic due to the
unreliable stack unwinding of BPF programs that we never expect.

To remedy this case, make bpf_prog_ksym_find treat IP == ksym.end as
part of the BPF program, so that is_bpf_text_address returns true when
such a case occurs, and we are able to unwind reliably when the final
instruction ends up being a call instruction.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Link: https://lore.kernel.org/r/20230912233214.1518551-12-memxor@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index d3f6a070875cb..33ea6ab12f47c 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -602,7 +602,11 @@ static __always_inline int bpf_tree_comp(void *key, struct latch_tree_node *n)
 
 	if (val < ksym->start)
 		return -1;
-	if (val >= ksym->end)
+	/* Ensure that we detect return addresses as part of the program, when
+	 * the final instruction is a call for a program part of the stack
+	 * trace. Therefore, do val > ksym->end instead of val >= ksym->end.
+	 */
+	if (val > ksym->end)
 		return  1;
 
 	return 0;
-- 
2.42.0

