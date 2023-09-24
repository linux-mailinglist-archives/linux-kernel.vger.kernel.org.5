Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0F77AC888
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 15:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjIXNRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 09:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjIXNRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 09:17:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF8B103;
        Sun, 24 Sep 2023 06:16:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2BB5C433AB;
        Sun, 24 Sep 2023 13:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695561379;
        bh=vh7BfSr1u7GfUodRI3KNjHPlHcY9eWH6Sws6x5MztBg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P+KwYcK+2m1m5ZnZk38v4D5WMBHFTfimEwNdAD6ZKvCbGBk18TIDigb+psyIk/8Ya
         ILuaDCcokz0NL9mAACjAF/AfgpFIG7CppPRqqANw4rl/8r0S0fa0+6/974P9ZY01rT
         8UOhHLxNVI5cson0a2DhG6heSI1VrL/pJRvz/IbJ6Qh1MILS/8SjoKbjJhj3+D++zH
         jnY4Eu/+HeBLtAHBNYy82F4N8FXbhz9Fakvylg06peDsC3SS/Y9/K+AHtIHAvH9ToV
         gx8w6CqwLtrgS1dehSsb//Jo7W6P24vUMEv3ENCJodojbS4U4RBL6TObeA0+QeyaN5
         gJQmtlRdSnl4g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, rafael@kernel.org,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 23/41] thermal/of: add missing of_node_put()
Date:   Sun, 24 Sep 2023 09:15:11 -0400
Message-Id: <20230924131529.1275335-23-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230924131529.1275335-1-sashal@kernel.org>
References: <20230924131529.1275335-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.5
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
index 22272f9c5934a..e615f735f4c03 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -38,8 +38,10 @@ static int of_find_trip_id(struct device_node *np, struct device_node *trip)
 	 */
 	for_each_child_of_node(trips, t) {
 
-		if (t == trip)
+		if (t == trip) {
+			of_node_put(t);
 			goto out;
+		}
 		i++;
 	}
 
@@ -402,8 +404,10 @@ static int thermal_of_for_each_cooling_maps(struct thermal_zone_device *tz,
 
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

