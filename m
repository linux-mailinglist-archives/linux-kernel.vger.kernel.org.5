Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F5576242E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 23:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbjGYVMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 17:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbjGYVMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 17:12:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1924419B4;
        Tue, 25 Jul 2023 14:12:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F83F61909;
        Tue, 25 Jul 2023 21:12:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34F86C433CB;
        Tue, 25 Jul 2023 21:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690319533;
        bh=ARjM/rczxk3PX8PtoECoSFwHH4d2kchH7iqw5zHKaMc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Es8WBez048KDHgpfoMTc37khxgywhAUh1Fjp8T+Fcd0GRj+DLQo25GFk11awLdjP4
         rRlD28MBQilhGllWoeSs63csGlR2xv7LYvhJcE+ED/e+PF6DAT9ewPVcGZWVrCJpIJ
         vVVC54hqyEZZXBaUZ1bVhXn+Wdx9ig/Qgl8/tOs2+3WBlksIqY7AfAeCNEt4YDfK/k
         1erMGTAbh7j09grtpTOe+e/ExDu0mjGlBe1MjfvA/hXKRMyEJ1QYWAW7gZ7SDF2siI
         JPyGLNqXQ+Fd6CSNlJmw3H4yzBF0qXlaAu8lVGJ3ft/le4Bi1nHj6sY0CREHxO4GF+
         VMWxKh/sfWYQA==
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        John Stultz <jstultz@google.com>, linux-kbuild@vger.kernel.org
Subject: [PATCH v2 2/2] scripts/faddr2line: Constrain readelf output to symbols from System.map
Date:   Tue, 25 Jul 2023 22:11:57 +0100
Message-Id: <20230725211157.17031-3-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230725211157.17031-1-will@kernel.org>
References: <20230725211157.17031-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some symbols emitted in the readelf output but filtered from System.map
can confuse the 'faddr2line' symbol size calculation, resulting in the
erroneous rejection of valid offsets. This is especially prevalent when
building an arm64 kernel with CONFIG_CFI_CLANG=y, where most functions
are prefixed with a 32-bit data value in a '$d.n' section. For example:

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

Filter out entries from readelf using the 'sysmap-ignored-syms.sed'
script used to construct System.map, so that the size of a symbol is
calculated as a delta to the next symbol present in ksymtab.

Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: John Stultz <jstultz@google.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 scripts/faddr2line | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/faddr2line b/scripts/faddr2line
index 62a3fa6f6f59..da734af90036 100755
--- a/scripts/faddr2line
+++ b/scripts/faddr2line
@@ -64,6 +64,7 @@ else
 	UTIL_PREFIX=${CROSS_COMPILE:-}
 fi
 
+IGNORED_SYMS=$(dirname $0)/sysmap-ignored-syms.sed
 READELF="${UTIL_PREFIX}readelf"
 ADDR2LINE="${UTIL_PREFIX}addr2line"
 AWK="awk"
@@ -185,7 +186,7 @@ __faddr2line() {
 				found=2
 				break
 			fi
-		done < <(${READELF} --symbols --wide $objfile | sed 's/\[.*\]//' | ${AWK} -v sec=$sym_sec '$7 == sec' | sort --key=2)
+		done < <(${READELF} --symbols --wide $objfile | sed -f ${IGNORED_SYMS} -e 's/\[.*\]//' | ${AWK} -v sec=$sym_sec '$7 == sec' | sort --key=2)
 
 		if [[ $found = 0 ]]; then
 			warn "can't find symbol: sym_name: $sym_name sym_sec: $sym_sec sym_addr: $sym_addr sym_elf_size: $sym_elf_size"
-- 
2.41.0.487.g6d72f3e995-goog

