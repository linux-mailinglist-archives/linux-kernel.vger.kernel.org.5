Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4230A78C275
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 12:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235121AbjH2Kl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 06:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232965AbjH2Kk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 06:40:58 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954011A4;
        Tue, 29 Aug 2023 03:40:55 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 5168F1F45F;
        Tue, 29 Aug 2023 10:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1693305654; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=boLPT8o1QF6Jm6UzBrYuJYuMB2bVuNiI0g7yzi9m94M=;
        b=AyFXxjMVNjn6gp6ULns0IM/sCnoDFhgAN2NqdIKakNDCwnjfplssIN5+ITt3rlqqAaV2RZ
        TYmWECro/G+XqySEepxPl55GGdLR+wefgGGEZV9ju21TyCbIGxE1yJbRXNT/chyx4ZCsh1
        Tkjk4TTTWp9Ci1dMLd/0JqF1rtCAKMI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1693305654;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=boLPT8o1QF6Jm6UzBrYuJYuMB2bVuNiI0g7yzi9m94M=;
        b=HhTkwVFqbsvvOSAdzWJ4prBV7PP+oBRQcAqBxf3n9H0qidx6s3DXN9qs3/74hZixyMjPt7
        y9eYl6pxifCNcwAA==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        by relay2.suse.de (Postfix) with ESMTP id 74A502C145;
        Tue, 29 Aug 2023 10:40:53 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Michal Suchanek <msuchanek@suse.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: dummy-tools: -mprofile-kernel is not limited to little endian
Date:   Tue, 29 Aug 2023 12:40:44 +0200
Message-ID: <20230829104047.20841-1-msuchanek@suse.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes: aec0ba7472a7 ("powerpc/64: Use -mprofile-kernel for big endian ELFv2 kernels")
Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 scripts/dummy-tools/gcc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/dummy-tools/gcc b/scripts/dummy-tools/gcc
index 1db1889f6d81..ebb34d016e5f 100755
--- a/scripts/dummy-tools/gcc
+++ b/scripts/dummy-tools/gcc
@@ -85,7 +85,7 @@ if arg_contain -S "$@"; then
 	fi
 
 	# For arch/powerpc/tools/gcc-check-mprofile-kernel.sh
-	if arg_contain -m64 "$@" && arg_contain -mlittle-endian "$@" &&
+	if arg_contain -m64 "$@" &&
 		arg_contain -mprofile-kernel "$@"; then
 		if ! test -t 0 && ! grep -q notrace; then
 			echo "_mcount"
-- 
2.41.0

