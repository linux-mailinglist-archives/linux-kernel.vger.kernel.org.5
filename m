Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44C357B5929
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 19:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238591AbjJBQ6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 12:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238546AbjJBQ6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 12:58:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D00B4;
        Mon,  2 Oct 2023 09:58:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D177DC433CA;
        Mon,  2 Oct 2023 16:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696265884;
        bh=BdsyPvEj53bRhSrPGLPqhoMZxFh5sEybiAwaA9VVpew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MoarQNNeg90+ZrJS/8bCWOtdeyip/Ehjh86/RE+EGGzvFDosBwZcGY1z1RQ63OveD
         SMdtoHLgk61DoaWo1+DjXCqTATkbwX0SsEhgSEop0Ngos/5ZZ3DSfm26vZYJQ6Iqju
         EJxZisKAzbqHVcj5x2mQ8JsErjOOdCMg4KYsdU5/iD5ER243gBlawhplsUzfDDPEMf
         kAPfyNyPNRUJ2Dhx9r0HAXeSGtgjlTcj/gPVFyoSlPWvAJbmF6ah3ivJ7MUt+mcjKV
         eElZNnBThoDIIihUby56Wwn1BWy4wASAaMOEUXf+OoOUtzAUib5VMG++5Wc/IuTEhc
         T7d7sF6HltmXA==
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        John Stultz <jstultz@google.com>, linux-kbuild@vger.kernel.org
Subject: [PATCH v5 3/3] scripts/faddr2line: Skip over mapping symbols in output from readelf
Date:   Mon,  2 Oct 2023 17:57:49 +0100
Message-Id: <20231002165750.1661-4-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231002165750.1661-1-will@kernel.org>
References: <20231002165750.1661-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: John Stultz <jstultz@google.com>
Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 scripts/faddr2line | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/scripts/faddr2line b/scripts/faddr2line
index 6b8206802157..587415a52b6f 100755
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
-- 
2.42.0.582.g8ccd20d70d-goog

