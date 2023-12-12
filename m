Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8056080F236
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 17:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346662AbjLLQRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 11:17:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235002AbjLLQRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 11:17:06 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012011AA;
        Tue, 12 Dec 2023 08:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1702397819; x=1733933819;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=J7+Xj3FjWfdGPh60vkm3axKqArxj/3g1wtG+A2GoS0g=;
  b=H1UvUyOV3eKWPq9JZXVJ64jdN7ctjA/xSYJxBQJz2UlFUyZYJ4yCNzjH
   WBehaOLk8RMWOkhh5uuGXiuBAVSyo5gHT72iSyvUGlxPiAkVA0qaUBQ+1
   cuSKrk1Po8QQ9CgXxpbhPck3StamS4yysKiq6ccwh/Pshh4W5sNxc+1i1
   ztPZ2+O9Vy/PKz622p3YTbCqnoI4jAHNwVjI9KS98b2cFW2i9ZzqUNJEX
   5x/Q8jbYbJM1G11Lf5RhBg5OSpZ0BRHKx5ZAOwN+4O9ED4lUmS9HTilbE
   I++2LBRKYw63CZuWVBzhyOn3h5T6xnybPhnhqScZ4M5AW5FFhORHbV+LR
   Q==;
X-IronPort-AV: E=Sophos;i="6.04,270,1695679200"; 
   d="scan'208";a="34463669"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 12 Dec 2023 17:16:55 +0100
Received: from localhost.localdomain (SCHIFFERM-M2.tq-net.de [10.121.53.15])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 653F3280075;
        Tue, 12 Dec 2023 17:16:55 +0100 (CET)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>
Cc:     linux-kbuild@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux@ew.tq-group.com,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH] Reapply "kbuild: Create directory for target DTB"
Date:   Tue, 12 Dec 2023 17:16:10 +0100
Message-ID: <20231212161610.100862-1-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit dd7699e37f289fa433f42c6bcc108468c8b198c0.

On powerpc, dtb-y is usually empty unless CONFIG_OF_ALL_DTBS is set. While
passing a DTB as a make target explicitly works fine, individual DTB
builds may also be pulled in as dependencies by cuImage.% and similar
targets. In this case, nothing creates the arch/powerpc/dts directory,
causing out-of-tree builds to fail.

Fixes: dd7699e37f28 ("Revert "kbuild: Create directory for target DTB"")
Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 scripts/Makefile.lib | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 1a965fe68e011..3fe0fc46badfe 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -389,7 +389,8 @@ $(obj)/%.dtbo.S: $(obj)/%.dtbo FORCE
 	$(call if_changed,wrap_S_dtb)
 
 quiet_cmd_dtc = DTC     $@
-cmd_dtc = $(HOSTCC) -E $(dtc_cpp_flags) -x assembler-with-cpp -o $(dtc-tmp) $< ; \
+cmd_dtc = mkdir -p $(dir ${dtc-tmp}) ; \
+	$(HOSTCC) -E $(dtc_cpp_flags) -x assembler-with-cpp -o $(dtc-tmp) $< ; \
 	$(DTC) -o $@ -b 0 \
 		$(addprefix -i,$(dir $<) $(DTC_INCLUDE)) $(DTC_FLAGS) \
 		-d $(depfile).dtc.tmp $(dtc-tmp) ; \
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

