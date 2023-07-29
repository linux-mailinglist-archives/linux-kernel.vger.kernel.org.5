Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1502767CE0
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 09:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjG2Hmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 03:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjG2Hmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 03:42:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8A430FC;
        Sat, 29 Jul 2023 00:42:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4ADF60691;
        Sat, 29 Jul 2023 07:42:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20464C433C7;
        Sat, 29 Jul 2023 07:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690616556;
        bh=ZKOq4dSq8LU22/XO77L6SVfNnBWbdQNZk2Y0aYMmtrk=;
        h=From:To:Cc:Subject:Date:From;
        b=oY8WlMg693/n1jO+IK3qR+BcpBifWVgXBOEoX2C0glibs2FGB4W6Bol3hKkW3axTX
         4uSBPz6vxZSPODP6NpXJX2NHZ7opwX3XEIMe07AOkJj74D1aNaKZEoA48pdX/kcNIf
         cG/vh0rd3JYWxz8X87Hkj9bshjXm/M3Jz978FESyJ8nSuWdTPL1KKfkNwu3eteP/tM
         /cz1IERe/2fIP+cVP9TOeLeY2nECxDPyuH+uLcaMyo12Vdvvit+8IQGrd/0cnXgy4H
         8mLISuJe7lo12xbGYwssti7nBvN9R/AtLWw+iXMCyi0iEzazmCw3RqHEnHR8Uz9guU
         1tl4Ox9dG55mg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Chen Gong <gong.chen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH] alpha: remove __init annotation from exported page_is_ram()
Date:   Sat, 29 Jul 2023 16:42:23 +0900
Message-Id: <20230729074223.1457109-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
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

EXPORT_SYMBOL and __init is a bad combination because the .init.text
section is freed up after the initialization.

Commit c5a130325f13 ("ACPI/APEI: Add parameter check before error
injection") exported page_is_ram(), hence the __init annotation should
be removed.

This fixes the modpost warning in ARCH=alpha builds:

  WARNING: modpost: vmlinux: page_is_ram: EXPORT_SYMBOL used for init symbol. Remove __init or EXPORT_SYMBOL.

Fixes: c5a130325f13 ("ACPI/APEI: Add parameter check before error injection")
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/alpha/kernel/setup.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/alpha/kernel/setup.c b/arch/alpha/kernel/setup.c
index b650ff1cb022..3d7473531ab1 100644
--- a/arch/alpha/kernel/setup.c
+++ b/arch/alpha/kernel/setup.c
@@ -385,8 +385,7 @@ setup_memory(void *kernel_end)
 #endif /* CONFIG_BLK_DEV_INITRD */
 }
 
-int __init
-page_is_ram(unsigned long pfn)
+int page_is_ram(unsigned long pfn)
 {
 	struct memclust_struct * cluster;
 	struct memdesc_struct * memdesc;
-- 
2.39.2

