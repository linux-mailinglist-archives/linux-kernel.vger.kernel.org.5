Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55DAF7AC8F6
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 15:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjIXNV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 09:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjIXNU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 09:20:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C9F1BE7;
        Sun, 24 Sep 2023 06:18:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21EC5C43395;
        Sun, 24 Sep 2023 13:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695561508;
        bh=l5DnyFuuiHFzaawxIuRGJaUElNH7zX3N6SPI0DudOqg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oSCaXQzyI/1XWlfL9nUrQXa83K7SFgrUJYiJGHzVv0iklIDsbbpnpniK/Xs868Daj
         NHeu0HaJubHeOLl1cu5kMIi3x1QBv3fdZfNSs6up+aTaDsEg7C6lg3uSV83EHUM65Y
         xZgxUxDlv86wEVsCXEVMGJryWvupxGMGlFKEH2Dx5xG5II/LLrmgEUZ5H5Dion9573
         2dk/VZr/2+SXzwb4cxJSpZIm3P9/7TCW17/BOOsv8DNTJH1FfEx/TJcHSz/PKkhEzV
         aUbFRLYikIXMt60fgdJPAgQlXGcbS3JvYKrlC1kZ8890b1qX+y7wJkQsIkJHTVkldp
         jsUv44VEMAN4Q==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, rafael@kernel.org,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 19/28] thermal/of: add missing of_node_put()
Date:   Sun, 24 Sep 2023 09:17:36 -0400
Message-Id: <20230924131745.1275960-19-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230924131745.1275960-1-sashal@kernel.org>
References: <20230924131745.1275960-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.55
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

From: Julia Lawall <Julia.Lawall@inria.fr>

[ Upstream commit 8a81cf96f5510aaf9a65d103f7405079a7b0fcc5 ]

for_each_child_of_node performs an of_node_get on each
iteration, so a break out of the loop requires an
of_node_put.

This was done using the Coccinelle semantic patch
iterators/for_each_child.cocci

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/thermal_of.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 762d1990180bf..4104743dbc17e 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -149,8 +149,10 @@ static int of_find_trip_id(struct device_node *np, struct device_node *trip)
 	 */
 	for_each_child_of_node(trips, t) {
 
-		if (t == trip)
+		if (t == trip) {
+			of_node_put(t);
 			goto out;
+		}
 		i++;
 	}
 
@@ -519,8 +521,10 @@ static int thermal_of_for_each_cooling_maps(struct thermal_zone_device *tz,
 
 	for_each_child_of_node(cm_np, child) {
 		ret = thermal_of_for_each_cooling_device(tz_np, child, tz, cdev, action);
-		if (ret)
+		if (ret) {
+			of_node_put(child);
 			break;
+		}
 	}
 
 	of_node_put(cm_np);
-- 
2.40.1

