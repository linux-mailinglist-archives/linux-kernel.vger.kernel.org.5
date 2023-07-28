Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F62D766BE2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 13:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236287AbjG1Ley (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 07:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236280AbjG1Leu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 07:34:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D259E3ABD;
        Fri, 28 Jul 2023 04:34:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D18F062113;
        Fri, 28 Jul 2023 11:34:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64DDAC433CA;
        Fri, 28 Jul 2023 11:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690544071;
        bh=GJfONZ1HCDvgFwQvE4AFHIvTONGQNDF8BXh10wDQUnc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mPn9okbatt3a+j1vX38yIOJxpJjENOWB/nhMO9o9C6D4CeK1tYFlhJ5M2irJfplak
         nkqDoTzt3Y+Y6B9kzZ1FYVG+JHz6r2i53skj63N0xJIra8JlxOC97zF76nNlUzLSZ4
         guIqS9ji9t6IwEh8PPWMK3rtPHmpqB/1YNxMoR87Okk94Y/ImwviIrnPR9UB4uq36W
         KelocNjmH/aRI8O62O7LR/yCe6/A8IwF/c2hoTTzTHb+8VpHDg/m5lpZollb3lKECz
         3CwTmWFn0y9JKZ9RkAt11CG7ZjZhYz2J8yrHTO4jG8V1cHJqo+4u8XOlz4Xh+KF72V
         MmVOacDXx+7GA==
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        John Stultz <jstultz@google.com>, linux-kbuild@vger.kernel.org
Subject: [PATCH v3 4/4] scripts/faddr2line: Don't filter out non-function symbols from readelf
Date:   Fri, 28 Jul 2023 12:34:15 +0100
Message-Id: <20230728113415.21067-5-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230728113415.21067-1-will@kernel.org>
References: <20230728113415.21067-1-will@kernel.org>
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

As Josh points out in 20230724234734.zy67gm674vl3p3wv@treble:

> Problem is, I think the kernel's symbol printing code prints the
> nearest kallsyms symbol, and there are some valid non-FUNC code
> symbols.  For example, syscall_return_via_sysret.

so we shouldn't be considering only 'FUNC'-type symbols in the output
from readelf.

Drop the function symbol type filtering from the faddr2line outer loop.

Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/r/20230724234734.zy67gm674vl3p3wv@treble
Signed-off-by: Will Deacon <will@kernel.org>
---
 scripts/faddr2line | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/faddr2line b/scripts/faddr2line
index da734af90036..47a010615903 100755
--- a/scripts/faddr2line
+++ b/scripts/faddr2line
@@ -267,7 +267,7 @@ __faddr2line() {
 
 		DONE=1
 
-	done < <(${READELF} --symbols --wide $objfile | sed 's/\[.*\]//' | ${AWK} -v fn=$sym_name '$4 == "FUNC" && $8 == fn')
+	done < <(${READELF} --symbols --wide $objfile | sed 's/\[.*\]//' | ${AWK} -v fn=$sym_name '$8 == fn')
 }
 
 [[ $# -lt 2 ]] && usage
-- 
2.41.0.487.g6d72f3e995-goog

