Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB1B7D4B04
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 10:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234039AbjJXIxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 04:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233928AbjJXIxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 04:53:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854FC1712;
        Tue, 24 Oct 2023 01:52:45 -0700 (PDT)
Date:   Tue, 24 Oct 2023 08:52:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698137563;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9keY+q4ayzhYfj1Sywl/i+fSmvZAiGDKGIdRrjeEPao=;
        b=Vzmc0dVOKxkFjyP23HLc9Vsg5ONrlxIVzkD6KBjnmq6umrqmIbWZsLNQzH2UhqhublWUl+
        JDI79T1ZeB78YndUO6V723oU71nMLIUF+tUACpS8BwjFVrQaj2GVXZIhcLdoTuMC3rNQYB
        o98E+HXlr2o0L53NmDTOqqZA2R5iN/ERBtw4mIfdLU5e18ubNEP7Eg0GF0ltTmpPbZNbCh
        7DHhKOyGPILn7K1GuGlRLc06MTBoN9GZ2cm4FUXOWG3q+Wc7qwZkoDZBVpNJ6pAg7AvbWv
        qGGs3O+1clAwI+CnXsWZovzlr5f2dM+1alFfQq8iHd5+AFlSFLvt77i3//ahZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698137563;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9keY+q4ayzhYfj1Sywl/i+fSmvZAiGDKGIdRrjeEPao=;
        b=Uv+/y9J7Kixz9OlL6VLhiBIKuu2qHbyaimq0lgu2+GEItQrzNIJn5g5N4KymyqbDKS2/Iu
        MKQD6jffr2swE6Aw==
From:   "tip-bot2 for Will Deacon" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] scripts/faddr2line: Skip over mapping symbols in
 output from readelf
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231002165750.1661-4-will@kernel.org>
References: <20231002165750.1661-4-will@kernel.org>
MIME-Version: 1.0
Message-ID: <169813756305.3135.18196140276976513319.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     60fd39af33d3f63c4c94bd06784ebdf0d883f5c9
Gitweb:        https://git.kernel.org/tip/60fd39af33d3f63c4c94bd06784ebdf0d883f5c9
Author:        Will Deacon <will@kernel.org>
AuthorDate:    Mon, 02 Oct 2023 17:57:49 +01:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Mon, 23 Oct 2023 08:36:46 -07:00

scripts/faddr2line: Skip over mapping symbols in output from readelf

Mapping symbols emitted in the readelf output can confuse the
'faddr2line' symbol size calculation, resulting in the erroneous
rejection of valid offsets. This is especially prevalent when building
an arm64 kernel with CONFIG_CFI_CLANG=y, where most functions are
prefixed with a 32-bit data value in a '$d.n' section. For example:

447538: ffff800080014b80   548 FUNC    GLOBAL DEFAULT    2 do_one_initcall
   104: ffff800080014c74     0 NOTYPE  LOCAL  DEFAULT    2 $x.73
   106: ffff800080014d30     0 NOTYPE  LOCAL  DEFAULT    2 $x.75
   111: ffff800080014da4     0 NOTYPE  LOCAL  DEFAULT    2 $d.78
   112: ffff800080014da8     0 NOTYPE  LOCAL  DEFAULT    2 $x.79
    36: ffff800080014de0   200 FUNC    LOCAL  DEFAULT    2 run_init_process

Adding a warning to do_one_initcall() results in:

  | WARNING: CPU: 0 PID: 1 at init/main.c:1236 do_one_initcall+0xf4/0x260

Which 'faddr2line' refuses to accept:

$ ./scripts/faddr2line vmlinux do_one_initcall+0xf4/0x260
skipping do_one_initcall address at 0xffff800080014c74 due to size mismatch (0x260 != 0x224)
no match for do_one_initcall+0xf4/0x260

Filter out these entries from readelf using a shell reimplementation of
is_mapping_symbol(), so that the size of a symbol is calculated as a
delta to the next symbol present in ksymtab.

Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Will Deacon <will@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Link: https://lore.kernel.org/r/20231002165750.1661-4-will@kernel.org
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 scripts/faddr2line | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/scripts/faddr2line b/scripts/faddr2line
index 6b82068..587415a 100755
--- a/scripts/faddr2line
+++ b/scripts/faddr2line
@@ -179,6 +179,11 @@ __faddr2line() {
 			local cur_sym_elf_size=${fields[2]}
 			local cur_sym_name=${fields[7]:-}
 
+			# is_mapping_symbol(cur_sym_name)
+			if [[ ${cur_sym_name} =~ ^(\.L|L0|\$) ]]; then
+				continue
+			fi
+
 			if [[ $cur_sym_addr = $sym_addr ]] &&
 			   [[ $cur_sym_elf_size = $sym_elf_size ]] &&
 			   [[ $cur_sym_name = $sym_name ]]; then
