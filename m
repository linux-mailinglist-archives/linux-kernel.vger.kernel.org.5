Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3E5E7D2492
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 18:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbjJVQab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 12:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjJVQa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 12:30:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D228E1;
        Sun, 22 Oct 2023 09:30:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBD23C433C7;
        Sun, 22 Oct 2023 16:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697992227;
        bh=22dOGM1bDDcSQ28bcNdFqNtyQg+6TduOtwRc2laN08w=;
        h=From:To:Cc:Subject:Date:From;
        b=GJfLP/OsSYA/kdPP961o9XrGapU1og9Wg4T+aJVrMeNKmlN5Iu2YanXSdpZvyAyMJ
         7akOuCI+nE8/D8rAVtmcutVCEmXpnZBySa3DiMHGY02sG1Fn/h2+4jBEul00ko5jRS
         DCbmmx8Ej6IMQaGWw0y+tHHtBTb6YljLj0SNSVRx/TdXxGuAQfBi+9mrjcQMNTy8Rt
         D+3NyIZxkj3Nw4TS1HBAguP0owKt2m1blqUVJgvfjVuyAI6M836RGtd9PuJaD45Hsu
         lxeYPl7zQKKQ0BUZsdY0o4kq5GhLDbZ2cDPdDduFZ2vxpAiABkZ5ldhai090BeYkLw
         7VxPnc2x3dUEw==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH] kbuild: simplify cmd_ld_multi_m
Date:   Mon, 23 Oct 2023 01:30:14 +0900
Message-Id: <20231022163014.2067970-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

$(patsubst %.o,%.mod,$@) can be replaced with $<.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/Makefile.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 82e3fb19fdaf..5eefce3dad63 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -425,7 +425,7 @@ $(obj)/lib.a: $(lib-y) FORCE
 	$(call if_changed,ar)
 
 quiet_cmd_ld_multi_m = LD [M]  $@
-      cmd_ld_multi_m = $(LD) $(ld_flags) -r -o $@ @$(patsubst %.o,%.mod,$@) $(cmd_objtool)
+      cmd_ld_multi_m = $(LD) $(ld_flags) -r -o $@ @$< $(cmd_objtool)
 
 define rule_ld_multi_m
 	$(call cmd_and_savecmd,ld_multi_m)
-- 
2.40.1

