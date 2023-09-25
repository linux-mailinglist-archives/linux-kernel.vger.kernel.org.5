Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2176E7ADF5F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 21:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233265AbjIYTDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 15:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjIYTDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 15:03:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E89495;
        Mon, 25 Sep 2023 12:02:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50FA6C433C9;
        Mon, 25 Sep 2023 19:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695668579;
        bh=fXjtOigHLEJ1WJtElTztBusz+atOZCq2/IkS7MCl4mI=;
        h=From:To:Cc:Subject:Date:From;
        b=MquU9wD8hYsuyJWG2dXdLxBp2tuZNIl4+TT9klhR9RxTVPdroNxfrbZhxKeimjh4Y
         JfrN6BpcD6a0DJu8IW9uLq9NwYfBWzgMfBLgIyJcbP8hrirGR8PpT3IuWlzM9yKWjf
         7AjkLV1PsBQAep7IecnHVy7fJJebuBwDTHWGFxUPQYfzizjByavVoA4V+bNujsVAza
         rzwf0ZJyGALJUb0SHKewArrjJJOopNKS51TmvMLrVkQz0FWGknyWN9SYJY3D0v3h0+
         HEwZcBOe3A0Bm4BmV44LbmkXA2yecvLWHmR6iyqMajxbX8NxN3BAlg3iOmhJqXOSIy
         FCAD5Dx2HQCmA==
Received: (nullmailer pid 1712705 invoked by uid 1000);
        Mon, 25 Sep 2023 19:02:57 -0000
From:   Rob Herring <robh@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] cpufreq: pmac32: Use of_property_read_reg() to parse "reg"
Date:   Mon, 25 Sep 2023 14:02:35 -0500
Message-Id: <20230925190242.1712212-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
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

Use the recently added of_property_read_reg() helper to get the
untranslated "reg" address value.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
 - Add missing include
---
 drivers/cpufreq/pmac32-cpufreq.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/pmac32-cpufreq.c b/drivers/cpufreq/pmac32-cpufreq.c
index ec75e79659ac..df3567c1e93b 100644
--- a/drivers/cpufreq/pmac32-cpufreq.c
+++ b/drivers/cpufreq/pmac32-cpufreq.c
@@ -24,6 +24,7 @@
 #include <linux/device.h>
 #include <linux/hardirq.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 
 #include <asm/machdep.h>
 #include <asm/irq.h>
@@ -378,10 +379,9 @@ static int pmac_cpufreq_cpu_init(struct cpufreq_policy *policy)
 
 static u32 read_gpio(struct device_node *np)
 {
-	const u32 *reg = of_get_property(np, "reg", NULL);
-	u32 offset;
+	u64 offset;
 
-	if (reg == NULL)
+	if (of_property_read_reg(np, 0, &offset, NULL) < 0)
 		return 0;
 	/* That works for all keylargos but shall be fixed properly
 	 * some day... The problem is that it seems we can't rely
@@ -389,7 +389,6 @@ static u32 read_gpio(struct device_node *np)
 	 * relative to the base of KeyLargo or to the base of the
 	 * GPIO space, and the device-tree doesn't help.
 	 */
-	offset = *reg;
 	if (offset < KEYLARGO_GPIO_LEVELS0)
 		offset += KEYLARGO_GPIO_LEVELS0;
 	return offset;
-- 
2.40.1

