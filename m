Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C84766BDA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 13:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235125AbjG1LeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 07:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233792AbjG1LeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 07:34:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10DCD19A1;
        Fri, 28 Jul 2023 04:34:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99C8C6210F;
        Fri, 28 Jul 2023 11:34:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21AEFC433C8;
        Fri, 28 Jul 2023 11:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690544062;
        bh=lt7VqNcO/DMxewMKvB7u1wGlWbj/6ig8fJ1HtNw/4Gk=;
        h=From:To:Cc:Subject:Date:From;
        b=rJ+s2cwTRi1Ui++NMq1A65zCB5udu6EUXrx1tDOD93TGHMosTBUzZKyWBvgPrqZpV
         3hTG51FxLZfuSKCdUbifo8Z3bB7OQ7Iq3/VQmkk0CgFeMpAk7BPyybbMJueQ37xje6
         G9Encj5y5NHyN3huS6tjVObCvk7mEajJaMwcYj1s2rMN7FgCxdOZ+xu6LnF9gGnyPn
         6nBh7aOqZ0EnxBLJHRfKoLEgRWAR5nhQV9XXYz98GuT2nasDsKeN++RcQg+eHmqL0U
         woaSw8ru7y5iQexxYfnvdoR9MdVll8Ky3Qr64ZRQOP00EdShrmcN2wCxplw3ku+uIN
         4k7mbIS1RA58Q==
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        John Stultz <jstultz@google.com>, linux-kbuild@vger.kernel.org
Subject: [PATCH v3 0/4] Fix 'faddr2line' for LLVM arm64 builds
Date:   Fri, 28 Jul 2023 12:34:11 +0100
Message-Id: <20230728113415.21067-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
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

Hi all,

Here's version three of my faddr2line fixes previously posted here:

v1: https://lore.kernel.org/r/20230724174517.15736-1-will@kernel.org
v2: https://lore.kernel.org/r/20230725211157.17031-1-will@kernel.org

Changes since v2 include:
  * Brought back the (unchanged) patch introducing LLVM=1 so that all
    the patches are in one place and don't end up conflicting with each
    other.
  * Added a new patch to drop the strict "FUNC" symbol type match in
    the outer loop

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

Will Deacon (4):
  scripts/faddr2line: Use LLVM addr2line and readelf if LLVM=1
  scripts/mksysmap: Factor out sed ignored symbols expression into
    script
  scripts/faddr2line: Constrain readelf output to symbols from
    System.map
  scripts/faddr2line: Don't filter out non-function symbols from readelf

 scripts/faddr2line              | 15 +++++--
 scripts/mksysmap                | 77 +--------------------------------
 scripts/sysmap-ignored-syms.sed | 74 +++++++++++++++++++++++++++++++
 3 files changed, 86 insertions(+), 80 deletions(-)
 create mode 100644 scripts/sysmap-ignored-syms.sed

-- 
2.41.0.487.g6d72f3e995-goog

