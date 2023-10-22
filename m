Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6F657D24C7
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 19:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232556AbjJVRGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 13:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232459AbjJVRGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 13:06:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C12FB;
        Sun, 22 Oct 2023 10:06:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D821C433CA;
        Sun, 22 Oct 2023 17:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697994382;
        bh=G00Dlt7/+9AAm/4d72vjWHQ0YOge50oj8FKlMUxA+RA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GWMI3dwTmlLB7pQ/P42Bade2Cuizg1E1JsnKsllyP+YlusoaBdNMxTIf4+KT2hTSY
         M8AeCjBuBgi0FPTSof1ueeF10hGXsrQNuThfa7J87WV5+rJVuedcGMmdxTdmrFcTs5
         +ehh4WVj+Nj+ztahCwj7Xcug3DdBL+kMf28D3UMVx6EMV7CBF77i98ShHR9QWfLB0s
         8ydkYvD+Gri8fdtulve0MmUJjWllsyXAF1bchNyDeeNS6j1gZRR9Wp7cQz9S7kYchX
         wPyQifBOfmnWbCIHa1lrINvzzMKQ4KsCzo3SyiFERH6czkg9Wos6tWCv5WAXCdvrvp
         e/+X4sX+xQ8Xg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 04/10] modpost: remove more symbol patterns from the section check whitelist
Date:   Mon, 23 Oct 2023 02:06:07 +0900
Message-Id: <20231022170613.2072838-4-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231022170613.2072838-1-masahiroy@kernel.org>
References: <20231022170613.2072838-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These symbol patterns were whitelisted to allow them to reference to
functions with the old __devinit and __devexit annotations.

We stopped doing this a long time ago, for example, commit 6f039790510f
("Drivers: scsi: remove __dev* attributes.") remove those annotations
from the scsi drivers.

Keep *_ops and *_console, otherwise they will really cause section
mismatch warnings.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 792ba9da0f27..19b138664f75 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -997,13 +997,7 @@ static int secref_whitelist(const char *fromsec, const char *fromsym,
 	/* symbols in data sections that may refer to any init/exit sections */
 	if (match(fromsec, PATTERNS(DATA_SECTIONS)) &&
 	    match(tosec, PATTERNS(ALL_INIT_SECTIONS, ALL_EXIT_SECTIONS)) &&
-	    match(fromsym, PATTERNS("*_template", // scsi uses *_template a lot
-				    "*_timer", // arm uses ops structures named _timer a lot
-				    "*_sht", // scsi also used *_sht to some extent
-				    "*_ops",
-				    "*_probe",
-				    "*_probe_one",
-				    "*_console")))
+	    match(fromsym, PATTERNS("*_ops", "*_console")))
 		return 0;
 
 	/*
-- 
2.40.1

