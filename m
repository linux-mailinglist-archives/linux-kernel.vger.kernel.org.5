Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7AA6797AF0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245592AbjIGR6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343508AbjIGR57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:57:59 -0400
Received: from gauss.telenet-ops.be (gauss.telenet-ops.be [195.130.132.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CB91FED
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 10:57:34 -0700 (PDT)
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by gauss.telenet-ops.be (Postfix) with ESMTPS id 4RhL6D028Lz4x1cv
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 15:43:00 +0200 (CEST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:c214:2eac:128d:f67e])
        by albert.telenet-ops.be with bizsmtp
        id j1hy2A0042mGBSJ061hyaG; Thu, 07 Sep 2023 15:41:59 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qeFGQ-002m9K-L7;
        Thu, 07 Sep 2023 15:41:57 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qeFGf-00CMh0-TR;
        Thu, 07 Sep 2023 15:41:57 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-m68k@lists.linux-m68k.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Finn Thain <fthain@linux-m68k.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Philip Blundell <philb@gnu.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Joshua Thompson <funaho@jurai.org>,
        Sam Creasey <sammy@sammy.net>,
        Laurent Vivier <laurent@vivier.eu>,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 25/52] m68k: apollo: Replace set but not used variable by READ_ONCE()
Date:   Thu,  7 Sep 2023 15:41:26 +0200
Message-Id: <5406d0829d8204841c8cb8d265ca91a52cd22d2d.1694093327.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1694093327.git.geert@linux-m68k.org>
References: <cover.1694093327.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with W=1:

    arch/m68k/apollo/config.c: In function ‘dn_timer_int’:
    arch/m68k/apollo/config.c:171:32: warning: variable ‘x’ set but not used [-Wunused-but-set-variable]
      149 |         volatile unsigned char x;
	  |                                ^

Fix this by using READ_ONCE(), and removing the variable.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/apollo/config.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/m68k/apollo/config.c b/arch/m68k/apollo/config.c
index 0e6801eecbaf6361..fef9b8a1be673bad 100644
--- a/arch/m68k/apollo/config.c
+++ b/arch/m68k/apollo/config.c
@@ -146,13 +146,11 @@ void __init config_apollo(void)
 
 irqreturn_t dn_timer_int(int irq, void *dev_id)
 {
-	volatile unsigned char x;
-
 	legacy_timer_tick(1);
 	timer_heartbeat();
 
-	x = *(volatile unsigned char *)(apollo_timer + 3);
-	x = *(volatile unsigned char *)(apollo_timer + 5);
+	READ_ONCE(*(volatile unsigned char *)(apollo_timer + 3));
+	READ_ONCE(*(volatile unsigned char *)(apollo_timer + 5));
 
 	return IRQ_HANDLED;
 }
-- 
2.34.1

