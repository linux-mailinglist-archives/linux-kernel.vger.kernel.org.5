Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D60B7B425A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 18:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234580AbjI3QwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 12:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjI3QwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 12:52:23 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12014C6
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 09:52:22 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qmdCQ-00083K-Ew; Sat, 30 Sep 2023 18:52:14 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qmdCN-00A5ig-54; Sat, 30 Sep 2023 18:52:11 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qmdCM-006YZS-RT; Sat, 30 Sep 2023 18:52:10 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kbuild@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        James Clark <james.clark@arm.com>, kernel@pengutronix.de,
        Leo Yan <leo.yan@linaro.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-arm-kernel@lists.infradead.org,
        Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v2] modpost: Don't let "driver"s reference .exit.*
Date:   Sat, 30 Sep 2023 18:52:04 +0200
Message-Id: <20230930165204.2478282-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2253; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=ExAgENbFDy79YPL9zwkhUwd58OR3hIj9/ep56FwARBs=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlGFIw1iaUvqRkXmdHEuuytknWrwe98MGZS0mOe bymTwqIL/yJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRhSMAAKCRCPgPtYfRL+ Tv2wB/9TZ6zWLaUiIJNkMCcwv2THuCRjyXxDTrBVdfE1pAaQc617coqXgFNc7JgziISZgwDoeQn 0N0zbxBSZ4GXFF6OfcZjqkucea+mDp0ik+Sbg27CFFJ+Pyi5pHvL5i6dVVL6vN1InUzbb0H1st8 dklibia6QN0FCthvN90MIxGzMrOhC9U8gpr5PZmCxEVRAoaSGQXKVS7gM4WCEkdiIkGERLVB2IL IR8Uqxa6jU1N8yGa7W51ySmyi3jyEsy2PhKcePHHw2kaR+xNNht1mvi1ynAgo+jh2o9kohc+ruD dYXXkixPCno0nGA21I1gAeRFGZGhuzvqIGzcCtj2GGKLyFJL
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

There are few creative offenders uncovered for example in ARCH=amd64
allmodconfig builds. So only trigger the section mismatch warning for
W=1 builds.

The dual rule that drivers must not reference .init.* is implemented
since commit 0db252452378 ("modpost: don't allow *driver to reference
.init.*") which however missed that .exit.* should be handled in the
same way.

Thanks to Masahiro Yamada and Arnd Bergmann who gave valuable hints to
find this improvement.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

changes since (implicit) v1, sent with Message-Id:
20230930140601.2457711-1-u.kleine-koenig@pengutronix.de:

 - enable the warning about .data -> .exit.* only in W=1 builds to keep
   normal builds without warnings. *sigh*
 - improved commit log and mention the above item.
 - updated the code comment to match the code

Thanks
Uwe

 scripts/mod/modpost.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index de499dce5265..b3dee80497cb 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1015,9 +1015,20 @@ static int secref_whitelist(const char *fromsec, const char *fromsym,
 				    "*_console")))
 		return 0;
 
-	/* symbols in data sections that may refer to meminit/exit sections */
+	/* symbols in data sections that may refer to meminit sections */
 	if (match(fromsec, PATTERNS(DATA_SECTIONS)) &&
-	    match(tosec, PATTERNS(ALL_XXXINIT_SECTIONS, ALL_EXIT_SECTIONS)) &&
+	    match(tosec, PATTERNS(ALL_XXXINIT_SECTIONS, ALL_XXXEXIT_SECTIONS)) &&
+	    match(fromsym, PATTERNS("*driver")))
+		return 0;
+
+	/*
+	 * symbols in data sections must not refer to .exit.*, but there are
+	 * quite a few offenders, so hide these unless for W=1 builds until
+	 * these are fixed.
+	 */
+	if (!extra_warn &&
+	    match(fromsec, PATTERNS(DATA_SECTIONS)) &&
+	    match(tosec, PATTERNS(EXIT_SECTIONS)) &&
 	    match(fromsym, PATTERNS("*driver")))
 		return 0;
 

base-commit: 6465e260f48790807eef06b583b38ca9789b6072
-- 
2.40.1

