Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF80B7B593B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 19:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238531AbjJBQ6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 12:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238413AbjJBQ6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 12:58:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB451D9;
        Mon,  2 Oct 2023 09:57:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B14BC433C8;
        Mon,  2 Oct 2023 16:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696265877;
        bh=aChbnempkxcoiWrzh9EM6wKUX2YO3KC6v22o5SGsT+M=;
        h=From:To:Cc:Subject:Date:From;
        b=SW5WQvT8OhRvEd0clLUaOwZurg1clnffIB5fUH/lrRZ0ewqzunvOG6zhHrH95HJt+
         RCEpHt/UoqamKKWBBbJaV0UtTL7EQ1zBGS4oj+2kQ5t/FU9bqfKKSpHoaqHUCm7p/X
         T1o7CxhDw17Edky8oV1jwkQXEWfCD6Dk9q6lovCqoqUIqz9Ls5f+TN5lu3re6tUCxO
         ug0twuiQzvBDuPaOcV8SXegZNHtqPNuFhjessk6ptVML2/Vpyy2PuUw5mYBI3IMy+d
         W3i5/ZIhMt3/SklQQTPa7LcDAKNUyB2hQ9EtmHxOnm7iPvB+Ul26QRqPdiAzrScuMV
         +DvSchqUuxb2Q==
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        John Stultz <jstultz@google.com>, linux-kbuild@vger.kernel.org
Subject: [PATCH v5 0/3]  Fix 'faddr2line' for LLVM arm64 builds
Date:   Mon,  2 Oct 2023 17:57:46 +0100
Message-Id: <20231002165750.1661-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
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

Hello again.

This is version five of the fadd2line fixes that I previously posted at:

v1: https://lore.kernel.org/r/20230724174517.15736-1-will@kernel.org
v2: https://lore.kernel.org/r/20230725211157.17031-1-will@kernel.org
v3: https://lore.kernel.org/r/20230728113415.21067-1-will@kernel.org
v4: https://lore.kernel.org/r/20230914131225.13415-1-will@kernel.org

Changes since v4 include:
  * Simplify the is_mapping_symbol() regex to reflect the latest version
    of the C code.
  * Add Suggested-by and Reviewed-by tags to patch 1.

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

Will Deacon (3):
  scripts/faddr2line: Don't filter out non-function symbols from readelf
  scripts/faddr2line: Use LLVM addr2line and readelf if LLVM=1
  scripts/faddr2line: Skip over mapping symbols in output from readelf

 scripts/faddr2line | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

-- 
2.42.0.582.g8ccd20d70d-goog

