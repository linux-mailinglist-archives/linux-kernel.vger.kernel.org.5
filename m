Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED80B7976C6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238524AbjIGQQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjIGQPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:15:32 -0400
Received: from weierstrass.telenet-ops.be (weierstrass.telenet-ops.be [195.130.137.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0D230E1
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 09:13:00 -0700 (PDT)
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by weierstrass.telenet-ops.be (Postfix) with ESMTPS id 4RhL6D01cmz4x1N8
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 15:43:00 +0200 (CEST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:c214:2eac:128d:f67e])
        by albert.telenet-ops.be with bizsmtp
        id j1hy2A00A2mGBSJ061hyaJ; Thu, 07 Sep 2023 15:41:59 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qeFGQ-002m9S-MR;
        Thu, 07 Sep 2023 15:41:58 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qeFGf-00CMhB-Ur;
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
Subject: [PATCH 27/52] m68k: bvme6000: Make bvme6000_abort_int() static
Date:   Thu,  7 Sep 2023 15:41:28 +0200
Message-Id: <8e7e2013e00a35c2b74dc1ca16e93871b2d742d2.1694093327.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1694093327.git.geert@linux-m68k.org>
References: <cover.1694093327.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with W=1:

    arch/m68k/bvme6000/config.c:133:13: warning: no previous prototype for ‘bvme6000_abort_int’ [-Wmissing-prototypes]
      133 | irqreturn_t bvme6000_abort_int (int irq, void *dev_id)
	  |             ^~~~~~~~~~~~~~~~~~

Fix this by making bvme6000_abort_int() static.
There was never a user outside arch/m68k/bvme6000/config.c.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/bvme6000/config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/m68k/bvme6000/config.c b/arch/m68k/bvme6000/config.c
index 3a1d90e399e016cf..e604fe6602461334 100644
--- a/arch/m68k/bvme6000/config.c
+++ b/arch/m68k/bvme6000/config.c
@@ -130,7 +130,7 @@ void __init config_bvme6000(void)
 }
 
 
-irqreturn_t bvme6000_abort_int (int irq, void *dev_id)
+static irqreturn_t bvme6000_abort_int(int irq, void *dev_id)
 {
         unsigned long *new = (unsigned long *)vectors;
         unsigned long *old = (unsigned long *)0xf8000000;
-- 
2.34.1

