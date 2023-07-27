Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14AFC7653C1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 14:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233976AbjG0M0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 08:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234122AbjG0MZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 08:25:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708AC4213
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 05:24:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5120361E6C
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 12:24:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE583C433C7;
        Thu, 27 Jul 2023 12:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690460692;
        bh=DY00colqkK3gBCSjern+mAjAl2tFAKCXSE4uSH6JQ7I=;
        h=From:To:Cc:Subject:Date:From;
        b=WD+zHprzGffs66c97X6dMroL1XP2wNSq4L5QstSYLzptHJqgI8QX/Cfmlyso5Ohsa
         PHR2Zz7OnecACe/lBu51sO6GwOFqzmIWNUt8A5ncY4BSvqmn8wX0PJyOv/v6veR4/L
         5QAzjcHnkaJ5LaLTsNwINjQqnigoyQwMjkwRNv72AyCWkcBitWv6q+A0idFjhj5d4Z
         JAUCmZ1J67K0LIHVoE7i9eF3WtVIDCZ/vHc1YmJ909RWpyveb28vWoxWJf9aD7XUvP
         +qN3FOAaK5DYt4rqqBttXIMFZYl5M2FN+pOkzjvpA5mX514c00HOvGcLG26jq3Lzc+
         SRmnxeLssz/gQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] parport: mfc3: avoid empty-body warning
Date:   Thu, 27 Jul 2023 14:24:44 +0200
Message-Id: <20230727122448.2479942-1-arnd@kernel.org>
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

From: Arnd Bergmann <arnd@arndb.de>

on m68k builds, the mfc3 driver causes a warning about an empty if() block:

drivers/parport/parport_mfc3.c: In function 'control_pc_to_mfc3':
drivers/parport/parport_mfc3.c:106:37: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]

Remove it in favor of a simpler comment.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: fix typo
---
 drivers/parport/parport_mfc3.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/parport/parport_mfc3.c b/drivers/parport/parport_mfc3.c
index f4d0da741e856..bb1817218d7b2 100644
--- a/drivers/parport/parport_mfc3.c
+++ b/drivers/parport/parport_mfc3.c
@@ -102,8 +102,7 @@ static unsigned char control_pc_to_mfc3(unsigned char control)
 		ret |= 128;
 	if (control & PARPORT_CONTROL_AUTOFD) /* AUTOLF */
 		ret &= ~64;
-	if (control & PARPORT_CONTROL_STROBE) /* Strobe */
-		/* Handled directly by hardware */;
+	/* PARPORT_CONTROL_STROBE handled directly by hardware */
 	return ret;
 }
 
-- 
2.39.2

