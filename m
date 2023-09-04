Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D172791DA5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 21:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbjIDTdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 15:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237001AbjIDTb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 15:31:58 -0400
Received: from smtp.smtpout.orange.fr (smtp-29.smtpout.orange.fr [80.12.242.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A77CCB
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 12:31:54 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id dFIYqTR5S8E6NdFIYqYM3W; Mon, 04 Sep 2023 21:31:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1693855912;
        bh=o2e9NDGfNwzpiA1kqh0HoqAJClRDkDa8piEOQbsZYwY=;
        h=From:To:Cc:Subject:Date;
        b=RuDHDSD1LFumnGOpPsvM2hYvoCD2FgUpOXqCIY9MJND5sX2120Kyv4AAxWFnZcANs
         9V1R/hdXNqSxHqCEmuOlaC2o2KXeyaphWtDp2E4kfJWmropp4CCQWrxFnrmMMujO0C
         Cz0VMHdHLcT7R/dQw+8g5wH5czWvCmybe3QT/OC04tdyOr9R5Fo/t3/Yi/ZN31OKYM
         LHMlMDZvGuevXsoJf2b+UjksHClzeCIJsl8hqhN0J+PhU3WIuMJHf6q0/DJczpoOwz
         verkiTqS4gLjKo5L7Y7GXTV+WdDyLpT0o4ORC5Cm4TaVx5iS1g/FIL/1/TWIdOf4y6
         zxkk9/lFqWKrw==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 04 Sep 2023 21:31:52 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Greg Kroah-Hartman <gregkh@suse.de>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        speakup@linux-speakup.org
Subject: [PATCH] accessibility: speakup: Fix incorrect string length computation in report_char_chartab_status()
Date:   Mon,  4 Sep 2023 21:31:44 +0200
Message-Id: <b388b088485aff5dc223f2723ee61e00e5cd3f7d.1693855874.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

snprintf() returns the "number of characters which *would* be generated for
the given input", not the size *really* generated.

In order to avoid too large values for 'len' (and potential negative
values for "sizeof(buf) - (len - 1)") use scnprintf() instead of
snprintf().

Fixes: c6e3fd22cd53 ("Staging: add speakup to the staging directory")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
I guess that the -1 in the 2nd snprintf() call is here to overwrite the
ending \n.
---
 drivers/accessibility/speakup/kobjects.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/accessibility/speakup/kobjects.c b/drivers/accessibility/speakup/kobjects.c
index a7522d409802..1eea7c492875 100644
--- a/drivers/accessibility/speakup/kobjects.c
+++ b/drivers/accessibility/speakup/kobjects.c
@@ -92,9 +92,9 @@ static void report_char_chartab_status(int reset, int received, int used,
 	if (reset) {
 		pr_info("%s reset to defaults\n", object_type[do_characters]);
 	} else if (received) {
-		len = snprintf(buf, sizeof(buf),
-			       " updated %d of %d %s\n",
-			       used, received, object_type[do_characters]);
+		len = scnprintf(buf, sizeof(buf),
+				" updated %d of %d %s\n",
+				used, received, object_type[do_characters]);
 		if (rejected)
 			snprintf(buf + (len - 1), sizeof(buf) - (len - 1),
 				 " with %d reject%s\n",
-- 
2.34.1

