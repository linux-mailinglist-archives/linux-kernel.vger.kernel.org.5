Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5789C79EA9B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 16:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241482AbjIMOJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 10:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241311AbjIMOJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 10:09:13 -0400
Received: from cantor.telenet-ops.be (cantor.telenet-ops.be [195.130.132.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82361BEF
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 07:08:51 -0700 (PDT)
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by cantor.telenet-ops.be (Postfix) with ESMTPS id 4Rm2PG1Kw0z4x7bJ
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 16:08:50 +0200 (CEST)
Received: from ramsan.of.borg ([84.195.187.55])
        by baptiste.telenet-ops.be with bizsmtp
        id lS8o2A00x1C8whw01S8orG; Wed, 13 Sep 2023 16:08:50 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qgQXe-003css-1g;
        Wed, 13 Sep 2023 16:08:47 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qgQXv-00FV5k-CF;
        Wed, 13 Sep 2023 16:08:47 +0200
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
Subject: [PATCH v2 30/52] m68k: mac: Remove unused yday in unmktime()
Date:   Wed, 13 Sep 2023 16:08:20 +0200
Message-Id: <b25c42eac8beb0862f1b2041e817cb421ec66b4e.1694613528.git.geert@linux-m68k.org>
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

    arch/m68k/mac/misc.c: In function ‘unmktime’:
    arch/m68k/mac/misc.c:557:33: warning: variable ‘yday’ set but not used [-Wunused-but-set-variable]
      557 |         int days, rem, y, wday, yday;
	  |                                 ^~~~

Fix this by removing the unused variable and assignment.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
v2:
  - Add Acked-by.
---
 arch/m68k/mac/misc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/m68k/mac/misc.c b/arch/m68k/mac/misc.c
index c7cb29f0ff016360..65107abc8848232c 100644
--- a/arch/m68k/mac/misc.c
+++ b/arch/m68k/mac/misc.c
@@ -554,7 +554,7 @@ static void unmktime(time64_t time, long offset,
 		/* Leap years.  */
 		{ 0, 31, 60, 91, 121, 152, 182, 213, 244, 274, 305, 335, 366 }
 	};
-	int days, rem, y, wday, yday;
+	int days, rem, y, wday;
 	const unsigned short int *ip;
 
 	days = div_u64_rem(time, SECS_PER_DAY, &rem);
@@ -592,7 +592,6 @@ static void unmktime(time64_t time, long offset,
 		y = yg;
 	}
 	*yearp = y - 1900;
-	yday = days; /* day in the year.  Not currently used. */
 	ip = __mon_yday[__isleap(y)];
 	for (y = 11; days < (long int) ip[y]; --y)
 		continue;
-- 
2.34.1

