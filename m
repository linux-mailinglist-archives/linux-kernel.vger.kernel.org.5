Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 387797BB2F6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 10:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbjJFIVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 04:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjJFIVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 04:21:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B801E9;
        Fri,  6 Oct 2023 01:21:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBEBFC433C7;
        Fri,  6 Oct 2023 08:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696580509;
        bh=Rleyk+ijWu/nDpxQgC3SNjU9qlvK6Ft6iDjWmhbKDIY=;
        h=From:To:Cc:Subject:Date:From;
        b=br3bgF/3/cRbaRJkBy3sRCjuWMUfnImgEykeBlfA8FIxEy2wPP8oSIi8IElBxVS/F
         BybGhOPmrxEKJfWzLGitiqFsXcVfNxxuCMctgyKZ7DWbYjSweS1CDFznttr1R/O7ED
         mrdpUTgGvPM4k+VaVLycb8ZeScw/wikpXbRP9poFuj954GaWiXiGGrMhY5kxxBPsYJ
         aW7NL9cpr4CGsLsRT1G91GUrR0SSRkvTR8zZTCBG+k7Cufy5hhijjW7eDsEIuOJhgF
         iFWyt8b+ta9VFf/OO1aKci9OBm/hgAaHgJo7VSpIfceLuTTgltILJ2CkcyANzlIUKZ
         v71a5H2bfqo3Q==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan+linaro@kernel.org>)
        id 1qog63-0004M8-2O;
        Fri, 06 Oct 2023 10:22:08 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>, stable@vger.kernel.org,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH] regmap: fix NULL deref on lookup
Date:   Fri,  6 Oct 2023 10:21:04 +0200
Message-ID: <20231006082104.16707-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not all regmaps have a name so make sure to check for that to avoid
dereferencing a NULL pointer when dev_get_regmap() is used to lookup a
named regmap.

Fixes: e84861fec32d ("regmap: dev_get_regmap_match(): fix string comparison")
Cc: stable@vger.kernel.org      # 5.8
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/base/regmap/regmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 884cb51c8f67..234a84ecde8b 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1478,7 +1478,7 @@ static int dev_get_regmap_match(struct device *dev, void *res, void *data)
 
 	/* If the user didn't specify a name match any */
 	if (data)
-		return !strcmp((*r)->name, data);
+		return (*r)->name && !strcmp((*r)->name, data);
 	else
 		return 1;
 }
-- 
2.41.0

