Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB34C7F5CD5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 11:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344849AbjKWKsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 05:48:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344808AbjKWKsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 05:48:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B86D1BE
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 02:48:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65959C433C9;
        Thu, 23 Nov 2023 10:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700736496;
        bh=XewRPhT99Y03FufuA1LV3jWgAM7RX4SOby0kMRaZJ00=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jb28IYZuVzwcLrvrvdnukKAYmz06zPlRup1+ZlrHUkGDRNnKhK/LnDE6VdgbLpj+m
         7nGH2w6Z1wEvV1o01yirEafTzIchxEfH4n2wh7+t8IoMcGHOFAP/SKIzyt37JchohU
         ib2t6BeZZQ86+vnPtZ+l1dn7dxrBqkZmLsRPiASWYcgVIFUmk5vGvqSqP1M1fKyprv
         WtPDeYK0T522Y3EVQc2uUKBE+AX0HUsdGJvTOEm3AvSFnWESX7NOSJgufEHOEpjU/O
         JVbzAaHZKimJUay/NoPr4L/SKxigHhRfZtozFHHOguviIMwsJd6aOJ0UukOcKdgPZy
         H1T4gcKWtWZTQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Arnd Bergmann <arnd@arndb.de>, Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] powerpc: pasemi: mark pas_shutdown() static
Date:   Thu, 23 Nov 2023 11:48:00 +0100
Message-Id: <20231123104801.15537-3-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231123104801.15537-1-arnd@kernel.org>
References: <20231123104801.15537-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Allmodconfig builds show a warning about one function that is accidentally
marked global:

arch/powerpc/platforms/pasemi/setup.c:67:6: error: no previous prototype for 'pas_shutdown' [-Werror=missing-prototypes]

Fixes: 656fdf3ad8e0 ("powerpc/pasemi: Add Nemo board device init code.")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/platforms/pasemi/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pasemi/setup.c b/arch/powerpc/platforms/pasemi/setup.c
index ef985ba2bf21..0761d98e5be3 100644
--- a/arch/powerpc/platforms/pasemi/setup.c
+++ b/arch/powerpc/platforms/pasemi/setup.c
@@ -64,7 +64,7 @@ static void __noreturn pas_restart(char *cmd)
 }
 
 #ifdef CONFIG_PPC_PASEMI_NEMO
-void pas_shutdown(void)
+static void pas_shutdown(void)
 {
 	/* Set the PLD bit that makes the SB600 think the power button is being pressed */
 	void __iomem *pld_map = ioremap(0xf5000000,4096);
-- 
2.39.2

