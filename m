Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A007B40B4
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 16:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234203AbjI3OGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 10:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234185AbjI3OG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 10:06:29 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960DBBE
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 07:06:27 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qmabl-0001sC-I7; Sat, 30 Sep 2023 16:06:13 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qmabd-00A4Pi-ID; Sat, 30 Sep 2023 16:06:05 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qmabd-006Tsk-8S; Sat, 30 Sep 2023 16:06:05 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, coresight@lists.linaro.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Clark <james.clark@arm.com>, kernel@pengutronix.de,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH] modpost: Don't let "driver"s reference .exit.*
Date:   Sat, 30 Sep 2023 16:06:01 +0200
Message-Id: <20230930140601.2457711-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <CAK7LNAQegXeep+8fWCLH4TBGFah20kUcdHGn5sOeXS3L533egg@mail.gmail.com>
References: <CAK7LNAQegXeep+8fWCLH4TBGFah20kUcdHGn5sOeXS3L533egg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1463; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=hJsl78gXnQWrcDAVn49ln7riQyfrsnDajjAuw+8HdkM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlGCtFSqfo9e+nu2/xmbfwi40qflgT1U3UwzrCw DE+5DtSypqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRgrRQAKCRCPgPtYfRL+ ToHuB/9f4L8eic3cL4fbiH+q6jTJiSLF60bYZPb1R3ao0eTKdeeane3XWeUPMpgCs+I4o0b5n+V g4D3sCsqT7gIvpUc1W5VSbmT0mUKeenI6cKTnwa3kE5C6VsGr7DEWXoY0OLIg3kHTEB9UzFDVbL MuhcU1mPNq+0whgV2nDhbHn/FdE2DRSsg/1hKgFKgPzQG3RLUq5Pc71i6GktVsCEyl75NHnT623 QWNs2c0Q7Y8wJWOaPW0H4e3OZbI2tTP3Ap+R/aSS/J2EEXrS+3MkmWj0rxqHtup/tGP4xNrEVY6 N0AlhO/fI+WweDo0XbmP/MQNbA3tYnSFIGcFMrd4Y37okc8i
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Drivers must not reference functions marked with __exit as these likely
are not available when the code is built-in.

As of v6.6-rc3 building an allyesconfig on arm64, m68k, powerpc, riscv,
s390, sparc64 and x86_64 this now stricter check only triggers for a
single driver (drivers/hwtracing/coresight/coresight-etm4x-core.c). This
one is indeed broken, a fix was already posted
(https://lore.kernel.org/linux-arm-kernel/20230929081637.2377335-1-u.kleine-koenig@pengutronix.de).

This matches commit 0db252452378 ("modpost: don't allow *driver to
reference .init.*") which only handled .init.*.

Thanks to Masahiro Yamada and Arnd Bergmann who gave valuable hints to
find this improvement.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 scripts/mod/modpost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index de499dce5265..b17665e902fc 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1017,7 +1017,7 @@ static int secref_whitelist(const char *fromsec, const char *fromsym,
 
 	/* symbols in data sections that may refer to meminit/exit sections */
 	if (match(fromsec, PATTERNS(DATA_SECTIONS)) &&
-	    match(tosec, PATTERNS(ALL_XXXINIT_SECTIONS, ALL_EXIT_SECTIONS)) &&
+	    match(tosec, PATTERNS(ALL_XXXINIT_SECTIONS, ALL_XXXEXIT_SECTIONS)) &&
 	    match(fromsym, PATTERNS("*driver")))
 		return 0;
 
-- 
2.40.1

