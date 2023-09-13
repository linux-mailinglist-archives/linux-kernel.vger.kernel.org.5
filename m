Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB8579EA9C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 16:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241326AbjIMOJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 10:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241274AbjIMOI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 10:08:56 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960851BE1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 07:08:50 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:f674:9611:cd05:f25a])
        by baptiste.telenet-ops.be with bizsmtp
        id lS8n2A0023fvA4V01S8nqC; Wed, 13 Sep 2023 16:08:48 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qgQXd-003crp-If;
        Wed, 13 Sep 2023 16:08:47 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qgQXu-00FV4S-U5;
        Wed, 13 Sep 2023 16:08:46 +0200
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
Subject: [PATCH v2 14/52] m68k: emu: Remove unused vsnprintf() return value in nfprint()
Date:   Wed, 13 Sep 2023 16:08:04 +0200
Message-Id: <a8b6b17ff352cc560d1848a92d171bb0f44ccb27.1694613528.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1694613528.git.geert@linux-m68k.org>
References: <cover.1694613528.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with W=1:

    arch/m68k/emu/natfeat.c: In function ‘nfprint’:
    arch/m68k/emu/natfeat.c:59:13: warning: variable ‘n’ set but not used [-Wunused-but-set-variable]
       59 |         int n;
	  |             ^

As the return value of vsnprintf() is unused, and serves no practical
purpose here, fix this by removing the variable.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
v2:
  - Add Acked-by.
---
 arch/m68k/emu/natfeat.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/m68k/emu/natfeat.c b/arch/m68k/emu/natfeat.c
index b19dc00026d9953b..344637539438d682 100644
--- a/arch/m68k/emu/natfeat.c
+++ b/arch/m68k/emu/natfeat.c
@@ -56,10 +56,9 @@ void nfprint(const char *fmt, ...)
 {
 	static char buf[256];
 	va_list ap;
-	int n;
 
 	va_start(ap, fmt);
-	n = vsnprintf(buf, 256, fmt, ap);
+	vsnprintf(buf, 256, fmt, ap);
 	nf_call(nf_get_id("NF_STDERR"), virt_to_phys(buf));
 	va_end(ap);
 }
-- 
2.34.1

