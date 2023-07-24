Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41C2675FE79
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 19:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbjGXRt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 13:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231880AbjGXRta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 13:49:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732DF4686
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 10:46:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 529366132A
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 17:45:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 808FAC433C8;
        Mon, 24 Jul 2023 17:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690220723;
        bh=F0EIIGsmfIB+Y7QbLwduV6cHaLIhokS7WljeV8e+XkQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nT369RIaytZKoua0dAoPD1E3ysYvjzoA7UIVRcXqwLuM2p29Xx48/D7VyYYKhumdy
         k7BNjmgz3bmm1pcPYlKPB8dnI1+ADa9nAw2A22dv8TrStw6hi2GMp7LjhPHQ7xKd77
         wlWeQgvB+Cwv35BEJXNdXF6loAJBFGtCQRNHM1oVqyHn6b0cQZOfea5DX8jsJnJkG1
         QH18n5Fpu3ILSCclHpkqgMTAeuIwTLVK0/4DLxverZTT9Rmaf3yLLvCrdsq2Xd9/Uc
         gwbEnL7i4xzLxdznfyc70BcTJiwRgJB6s6AYTtcnvDxIgjU88HFv74nYB5NbS/7pi7
         7SiuRtg09vjLQ==
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        John Stultz <jstultz@google.com>
Subject: [PATCH 1/2] scripts/faddr2line: Ignore non-function symbols in readelf output
Date:   Mon, 24 Jul 2023 18:45:16 +0100
Message-Id: <20230724174517.15736-2-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230724174517.15736-1-will@kernel.org>
References: <20230724174517.15736-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Non-function symbols emitted in the readelf output can confuse the
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

Filter out entries from readelf that are not "FUNC" type, so that the
size of a symbol is calculated as a delta to the next function address.

Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: John Stultz <jstultz@google.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 scripts/faddr2line | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/faddr2line b/scripts/faddr2line
index 0e73aca4f908..60368a1cdaed 100755
--- a/scripts/faddr2line
+++ b/scripts/faddr2line
@@ -179,7 +179,7 @@ __faddr2line() {
 				found=2
 				break
 			fi
-		done < <(${READELF} --symbols --wide $objfile | sed 's/\[.*\]//' | ${AWK} -v sec=$sym_sec '$7 == sec' | sort --key=2)
+		done < <(${READELF} --symbols --wide $objfile | sed 's/\[.*\]//' | ${AWK} -v sec=$sym_sec '$4 == "FUNC" && $7 == sec' | sort --key=2)
 
 		if [[ $found = 0 ]]; then
 			warn "can't find symbol: sym_name: $sym_name sym_sec: $sym_sec sym_addr: $sym_addr sym_elf_size: $sym_elf_size"
-- 
2.41.0.487.g6d72f3e995-goog

