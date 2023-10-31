Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECBF7DD5D9
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 19:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376647AbjJaSMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 14:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376632AbjJaSMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 14:12:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C96A3;
        Tue, 31 Oct 2023 11:12:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17B8EC433C7;
        Tue, 31 Oct 2023 18:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698775926;
        bh=z2kKP0Kx2dr57rizxfyHv38jeggUfLgco7MlYnA5gyE=;
        h=From:To:Cc:Subject:Date:From;
        b=dcgLn6vSn6gm14DKigv2Fh7/WSvAoDVEs2UjDpd6TDtwuq09AUWgxPLuVALGPSarp
         34pPV1o98F2CmMGKv1QjRC4MCgbmp/iwVdbMpKZNrqe83luuMxboZhO4UfB6+8OyjL
         rBdjAcFNYmzjGITP4tpy8+ZYse6BTtaook47cxniePiZgjOpyUL3gwJdpKbLmKrrC3
         fCvmcd7fUbgKqtBVmvk584Q2SSTL1GhmmLHlUDbGIQgqqQJ7fq2hpGuwWQR15J4Lv+
         /x4umGUFK8eagzBKHuMAZYqSWkWwFK8Vr0nuFjZaIJgDFvRTSYOZrbBZCzC5GmJjA2
         ZLXnUswjZ8xSg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, linux-doc@vger.kernel.org
Subject: [PATCH] kbuild: support 'userldlibs' syntax
Date:   Wed,  1 Nov 2023 03:11:57 +0900
Message-Id: <20231031181157.704314-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This syntax is useful to specify libraries linked to all userspace
programs in the Makefile.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Documentation/kbuild/makefiles.rst | 4 ++++
 scripts/Makefile.userprogs         | 6 +++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/kbuild/makefiles.rst b/Documentation/kbuild/makefiles.rst
index d88d4f0f4f89..e9299971220a 100644
--- a/Documentation/kbuild/makefiles.rst
+++ b/Documentation/kbuild/makefiles.rst
@@ -937,6 +937,10 @@ Example::
   # net/bpfilter/Makefile
   bpfilter_umh-userldflags += -static
 
+To specify libraries linked to a userspace program, you can use
+``<executable>-userldlibs``. The ``userldlibs`` syntax specifies libraries
+linked to all userspace programs created in the current Makefile.
+
 When linking bpfilter_umh, it will be passed the extra option -static.
 
 From command line, :ref:`USERCFLAGS and USERLDFLAGS <userkbuildflags>` will also be used.
diff --git a/scripts/Makefile.userprogs b/scripts/Makefile.userprogs
index fb415297337a..f3a7e1ef3753 100644
--- a/scripts/Makefile.userprogs
+++ b/scripts/Makefile.userprogs
@@ -19,19 +19,19 @@ user-cobjs	:= $(addprefix $(obj)/, $(user-cobjs))
 user_ccflags	= -Wp,-MMD,$(depfile) $(KBUILD_USERCFLAGS) $(userccflags) \
 			$($(target-stem)-userccflags)
 user_ldflags	= $(KBUILD_USERLDFLAGS) $(userldflags) $($(target-stem)-userldflags)
+user_ldlibs	= $(userldlibs) $($(target-stem)-userldlibs)
 
 # Create an executable from a single .c file
 quiet_cmd_user_cc_c = CC [U]  $@
       cmd_user_cc_c = $(CC) $(user_ccflags) $(user_ldflags) -o $@ $< \
-		      $($(target-stem)-userldlibs)
+		      $(user_ldlibs)
 $(user-csingle): $(obj)/%: $(src)/%.c FORCE
 	$(call if_changed_dep,user_cc_c)
 
 # Link an executable based on list of .o files
 quiet_cmd_user_ld = LD [U]  $@
       cmd_user_ld = $(CC) $(user_ldflags) -o $@ \
-		    $(addprefix $(obj)/, $($(target-stem)-objs)) \
-		    $($(target-stem)-userldlibs)
+		    $(addprefix $(obj)/, $($(target-stem)-objs)) $(user_ldlibs)
 $(user-cmulti): FORCE
 	$(call if_changed,user_ld)
 $(call multi_depend, $(user-cmulti), , -objs)
-- 
2.40.1

