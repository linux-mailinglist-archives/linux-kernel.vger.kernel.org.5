Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88FEA802272
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 11:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbjLCKOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 05:14:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232339AbjLCKOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 05:14:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149EEFD
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 02:14:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1361C433CA;
        Sun,  3 Dec 2023 10:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701598466;
        bh=rjTEorOKOasXmLsA7k46njF60U2EzdHdA3xtay0TA6w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iV9ihJQ5p1xKzK8ySsg8JXWHcEecEpA1RX9Fvd73XsKS6JgW9SjvRSh/waEcC8Mqt
         hMB6WklR0jm3+7NQBemBJInVupiZfbolUzX3vHTj29b/Agf2NZKgbh2aBb4Iloo7AH
         DSoslmN4dUJ1PS4Lc5baA05psWDIvsOJk4CuoZphaf3WIgKQ7b9dH+Qjk0VZ/fTSrh
         yyVBAmfMqWyp5xt4HcW05xWDgfh8qn/aZeLkYqCU4ziBwRS8SZmLFg20f62jL9JsxO
         OmsA/o1Amqbs2HG/SEEc/MDxiaieHp/RhFfglXTTLpn7aKm5e4GXjtkNNOM00OtVP0
         N77fJzoP/ZQRw==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: [PATCH 2/3] sparc: vdso: simplify obj-y addition
Date:   Sun,  3 Dec 2023 19:14:17 +0900
Message-Id: <20231203101418.1910661-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231203101418.1910661-1-masahiroy@kernel.org>
References: <20231203101418.1910661-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add objects to obj-y in a more straightforward way.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/sparc/vdso/Makefile | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/sparc/vdso/Makefile b/arch/sparc/vdso/Makefile
index eb52d0666ffc..03a32b6156ee 100644
--- a/arch/sparc/vdso/Makefile
+++ b/arch/sparc/vdso/Makefile
@@ -3,9 +3,6 @@
 # Building vDSO images for sparc.
 #
 
-VDSO64-$(CONFIG_SPARC64)	:= y
-VDSOCOMPAT-$(CONFIG_COMPAT)	:= y
-
 # files to link into the vdso
 vobjs-y := vdso-note.o vclock_gettime.o
 
@@ -13,18 +10,14 @@ vobjs-y := vdso-note.o vclock_gettime.o
 obj-y				+= vma.o
 
 # vDSO images to build
-vdso_img-$(VDSO64-y)		+= 64
-vdso_img-$(VDSOCOMPAT-y)	+= 32
+obj-$(CONFIG_SPARC64)		+= vdso-image-64.o
+obj-$(CONFIG_COMPAT)		+= vdso-image-32.o
 
 vobjs := $(foreach F,$(vobjs-y),$(obj)/$F)
 
 $(obj)/vdso.o: $(obj)/vdso.so
 
 targets += vdso.lds $(vobjs-y)
-
-# Build the vDSO image C files and link them in.
-vdso_img_objs := $(vdso_img-y:%=vdso-image-%.o)
-obj-y += $(vdso_img_objs)
 targets += $(foreach x, 32 64, vdso-image-$(x).c vdso$(x).so vdso$(x).so.dbg)
 
 CPPFLAGS_vdso.lds += -P -C
-- 
2.40.1

