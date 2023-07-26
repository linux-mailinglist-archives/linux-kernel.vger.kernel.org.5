Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 850BE763A77
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 17:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234702AbjGZPLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 11:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233820AbjGZPLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 11:11:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2B52718
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 08:10:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF6F961B19
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 15:09:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41041C433C8;
        Wed, 26 Jul 2023 15:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690384198;
        bh=rtgf9H8NvnpR3RggXakLZfl4HQgkZ7FJrFnDv7BLE6I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RfjHPdZicc3XXWnank9EicJ3+W4iFcSz+ZmbTVIk7JTJLCbDHLM1+iCa34La/+R8R
         lRFf9g1sR0dA6UHAsHtVnAOi0zCYXG+t1miQmTlqdM6kGbiIsjPZYDZLY1b8zdkEKx
         1vFQC67JLVXHJ77NztRs8/K+GLCDQSAeqkStJ9TKq/G33qxBwaKCNEs0laHBGetJ33
         CpsRR/GesOiuGvwS7uWPwTmd/1ijaKZlcspGe3EnRdRVpNCS9k9AysCCgMfv7cWu6W
         nGJUPF/ZCs884Ii45SMyLBpLTIYisj0JJC+mTk7SYCsPtIxbvJtBEaw+O6n9BopxZt
         DtbzOg83+1+/w==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] parport: mfc3: avoid empty-body warning
Date:   Wed, 26 Jul 2023 17:09:15 +0200
Message-Id: <20230726150944.2265044-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230726150944.2265044-1-arnd@kernel.org>
References: <20230726150944.2265044-1-arnd@kernel.org>
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
 drivers/parport/parport_mfc3.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/parport/parport_mfc3.c b/drivers/parport/parport_mfc3.c
index f4d0da741e856..3d996e89a1c21 100644
--- a/drivers/parport/parport_mfc3.c
+++ b/drivers/parport/parport_mfc3.c
@@ -102,8 +102,7 @@ static unsigned char control_pc_to_mfc3(unsigned char control)
 		ret |= 128;
 	if (control & PARPORT_CONTROL_AUTOFD) /* AUTOLF */
 		ret &= ~64;
-	if (control & PARPORT_CONTROL_STROBE) /* Strobe */
-		/* Handled directly by hardware */;
+	/* PARPORT_CONTROL_STROBE handled directly by hardware *t/
 	return ret;
 }
 
-- 
2.39.2

