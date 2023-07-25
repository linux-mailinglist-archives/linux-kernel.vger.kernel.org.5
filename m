Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED13F76242A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 23:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjGYVML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 17:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjGYVMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 17:12:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E57B19A4;
        Tue, 25 Jul 2023 14:12:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07C05618F2;
        Tue, 25 Jul 2023 21:12:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A0CC433C8;
        Tue, 25 Jul 2023 21:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690319528;
        bh=cslsxVWSy/bUXNmzsWv9CS6om0VtnlhZ7mXcJq/v34Q=;
        h=From:To:Cc:Subject:Date:From;
        b=G26TqStOU9oo6/HdRhHILX13A0Gvcfg8UxkSKoT2Ulh0Q6PJCojwCDCXaxXiE1X7n
         WASl0SmlbHt59c1gJaOUu4P93CGHsPhW9Axthqq0yLGsqn+XpUSo2YEZZJ7StLXqwx
         eRZPJbgWmmX4Dvw9+tR0Lz/gwU0nxVzbejR3C5ffNz5q4Fe6HeAcX+dao4b0CEWK1P
         oQSr/FfDv5SMmf5gVxkABAimtjPYoR7DFzleM/GEqjMgDy9TxDQkxaj6tUWGwDK2/I
         oLlNTIzyjFTey4/VFWOVRqRyf/V8fU0zsbdHFy9tWY2n6ojXUkwDJei6v1MqT0134+
         aovXd1/CTq9eg==
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        John Stultz <jstultz@google.com>, linux-kbuild@vger.kernel.org
Subject: [PATCH v2 0/2] Fix 'faddr2line' for LLVM arm64 builds
Date:   Tue, 25 Jul 2023 22:11:55 +0100
Message-Id: <20230725211157.17031-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

This is version two of the patches I sent yesterday attempting to fix
'faddr2line' for LLVM arm64 kernel images.

v1: https://lore.kernel.org/r/20230724174517.15736-1-will@kernel.org

Changes since v1 include:
  * Dropped the patch adding support for LLVM=1, since Josh said he'd
    pick it up.
  * Reuse the ignored symbol regex from 'mksysmap' instead of ignoring
    symbols based on their type.

Feedback welcome. I've checked that the symbols in System.map for a
defconfig arm64 build are the same with and without these changes, but I
think I'd still like this to spend time in -next if we go down this
route.

Cheers,

Will

Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Nicolas Schier <nicolas@fjasle.eu>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: John Stultz <jstultz@google.com>
Cc: linux-kbuild@vger.kernel.org

--->8

Will Deacon (2):
  scripts/mksysmap: Factor out sed ignored symbols expression into
    script
  scripts/faddr2line: Constrain readelf output to symbols from
    System.map

 scripts/faddr2line              |  3 +-
 scripts/mksysmap                | 77 +--------------------------------
 scripts/sysmap-ignored-syms.sed | 74 +++++++++++++++++++++++++++++++
 3 files changed, 77 insertions(+), 77 deletions(-)
 create mode 100644 scripts/sysmap-ignored-syms.sed

-- 
2.41.0.487.g6d72f3e995-goog

