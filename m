Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE9778C293
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 12:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjH2KvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 06:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjH2KvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 06:51:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2399EAC;
        Tue, 29 Aug 2023 03:51:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6F8960BC7;
        Tue, 29 Aug 2023 10:51:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A086DC433C8;
        Tue, 29 Aug 2023 10:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693306271;
        bh=9EMLlwBP3d+/Jjp4Z6iGtFHMhVlj6enF1/kkKQkoQSo=;
        h=From:To:Cc:Subject:Date:From;
        b=ABM/A6fkCN5moCa3/sl0bh5As6Sc71QwYbelxi5371wbNV42TYCEFSglv9ULjSCY6
         FTGFPRz8kTDfRf3YcOz7emT5r89lkC46Ao04PsZjm9kpVQp9FzsFpOCSzzC20SdDxV
         YW3dY3Un9g1hasjd+5VMpJarr4k5kJpm9bxko/zHUMRVHlk0IZ3WmKjoq2mPS6yAsN
         xbjtdqJE8k+QDvL/uZHNiesSlQlgsacvC8z3OrSdM6+j0CwG9jzV0itZhLO6dK77zm
         ncCkK10E91n6I7l2eURHLahI1de8UzXnK+56ML11xyhv4fww+lzIRO3wQLUxBs1npP
         yp+rCqRC1ioRg==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     masahiroy@kernel.org
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Kubecek <mkubecek@suse.cz>
Subject: [PATCH] kbuild: dummy-tools: support make MPROFILE_KERNEL checks work on BE
Date:   Tue, 29 Aug 2023 12:51:06 +0200
Message-ID: <20230829105106.1277-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Slaby <jslaby@suse.cz>

Commit 2eab791f940b ("kbuild: dummy-tools: support MPROFILE_KERNEL
checks for ppc") added support for ppc64le's checks for
-mprofile-kernel.

Now, commit aec0ba7472a7 ("powerpc/64: Use -mprofile-kernel for big
endian ELFv2 kernels") added support for -mprofile-kernel even on
big-endian ppc.

So lift the check in gcc-check-mprofile-kernel.sh to support big-endian too.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Nicolas Schier <nicolas@fjasle.eu>
Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Michal Kubecek <mkubecek@suse.cz>
---
 scripts/dummy-tools/gcc | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/scripts/dummy-tools/gcc b/scripts/dummy-tools/gcc
index 1db1889f6d81..07f6dc4c5cf6 100755
--- a/scripts/dummy-tools/gcc
+++ b/scripts/dummy-tools/gcc
@@ -85,8 +85,7 @@ if arg_contain -S "$@"; then
 	fi
 
 	# For arch/powerpc/tools/gcc-check-mprofile-kernel.sh
-	if arg_contain -m64 "$@" && arg_contain -mlittle-endian "$@" &&
-		arg_contain -mprofile-kernel "$@"; then
+	if arg_contain -m64 "$@" && arg_contain -mprofile-kernel "$@"; then
 		if ! test -t 0 && ! grep -q notrace; then
 			echo "_mcount"
 		fi
-- 
2.42.0

