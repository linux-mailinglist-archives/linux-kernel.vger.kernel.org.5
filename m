Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A9175C80A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 15:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbjGUNlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 09:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjGUNlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 09:41:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1FEB1722;
        Fri, 21 Jul 2023 06:41:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5658F61B18;
        Fri, 21 Jul 2023 13:41:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C25DC433C7;
        Fri, 21 Jul 2023 13:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689946877;
        bh=hsP9Oos0WjKR1Uc0WBZ0FXpKTzVBPfutUi/3ykfZOgk=;
        h=From:To:Cc:Subject:Date:From;
        b=V9wiwFcd2muWD1xxfOwWvTMgOYs6Pk8wrzrYta8Zn2tGwJKcVb7W+XVZ3jT696ZlQ
         zzjIFkJU5V3ADCW0E95NQ8agicseWIFXngaWXFcVPoRK2hvGOYcgI+ovck7nq9RzK0
         /2r8hFknL9bvJ9/UWrZE3UNquo7AXvfLsEtbA2ZL+SZfKcABjjjciYBlSOib03ELGt
         Bzq0a2X6D1PNZEHW1nzOxvateb6LksWKmM+yXvwUTARW4GFk6fQ3VVm773oBJsAPmO
         tjC1GQLPSBGDfY+gq6D7+TEN2hroF182Fi5oBLVCA2RI7eQ2XR1BKScb+bpASSEJOz
         Cxl2WzDbVgMJw==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH] s390: use obj-y to descend into drivers/s390/
Date:   Fri, 21 Jul 2023 22:41:07 +0900
Message-Id: <20230721134107.3437947-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I like to use obj-y in as many places as possible.

Change the drivers-y to obj-y. It moves the objects from drivers/s390/
to slightly lower address, but fixes the single build issue. [1]

[1]: https://lore.kernel.org/linux-kbuild/d57ba55f-20a3-b836-783d-b49c8a161b6e@kernel.org/T/#m27f781ab60acadfed8a9e9642f30d5414a5e2df3

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Tested-by: Jiri Slaby <jirislaby@kernel.org>
---

 arch/s390/Makefile | 1 -
 drivers/Makefile   | 2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/s390/Makefile b/arch/s390/Makefile
index 5ed242897b0d..a53a36ee0731 100644
--- a/arch/s390/Makefile
+++ b/arch/s390/Makefile
@@ -119,7 +119,6 @@ export KBUILD_CFLAGS_DECOMPRESSOR
 OBJCOPYFLAGS	:= -O binary
 
 libs-y		+= arch/s390/lib/
-drivers-y	+= drivers/s390/
 
 boot		:= arch/s390/boot
 syscalls	:= arch/s390/kernel/syscalls
diff --git a/drivers/Makefile b/drivers/Makefile
index 7241d80a7b29..a7459e77df37 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -195,3 +195,5 @@ obj-$(CONFIG_PECI)		+= peci/
 obj-$(CONFIG_HTE)		+= hte/
 obj-$(CONFIG_DRM_ACCEL)		+= accel/
 obj-$(CONFIG_CDX_BUS)		+= cdx/
+
+obj-$(CONFIG_S390)		+= s390/
-- 
2.39.2

