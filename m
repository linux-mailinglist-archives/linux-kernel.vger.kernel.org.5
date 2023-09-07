Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8D879798B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242252AbjIGRQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242220AbjIGRQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:16:28 -0400
X-Greylist: delayed 118 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 07 Sep 2023 10:16:01 PDT
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9DA10E9;
        Thu,  7 Sep 2023 10:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yaKS76r33jDdN4YRfQ9rWXkWuhK5u7HSRxlycGPVIFs=;
  b=btpK9sTraVPQp9hlYQYmLOZYuH4BemJfQO3Y6HfD7eMk6iciEM3G6gVp
   gj/DRuzgUayvoqqq1TEMEU1F88NNsRqJhwhhrETcRNKUTBsvLlgnP+2wx
   lmxSMbY4fUz+f98xZQTgpmAFpRGIQkc0iRe7rlU3MfCQyhTCBe4QtKCPv
   g=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.02,234,1688421600"; 
   d="scan'208";a="65324659"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 11:55:30 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Nishanth Menon <nm@ti.com>
Cc:     kernel-janitors@vger.kernel.org, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/11] genpd: ti: add missing of_node_put
Date:   Thu,  7 Sep 2023 11:55:14 +0200
Message-Id: <20230907095521.14053-5-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230907095521.14053-1-Julia.Lawall@inria.fr>
References: <20230907095521.14053-1-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

for_each_node_with_property performs an of_node_get on
each iteration, so a break out of the loop requires an
of_node_put.

This was done using the Coccinelle semantic patch
iterators/for_each_child.cocci

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/genpd/ti/ti_sci_pm_domains.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff -u -p a/drivers/genpd/ti/ti_sci_pm_domains.c b/drivers/genpd/ti/ti_sci_pm_domains.c
--- a/drivers/genpd/ti/ti_sci_pm_domains.c
+++ b/drivers/genpd/ti/ti_sci_pm_domains.c
@@ -153,14 +153,18 @@ static int ti_sci_pm_domain_probe(struct
 					max_id = args.args[0];
 
 				pd = devm_kzalloc(dev, sizeof(*pd), GFP_KERNEL);
-				if (!pd)
+				if (!pd) {
+					of_node_put(np);
 					return -ENOMEM;
+				}
 
 				pd->pd.name = devm_kasprintf(dev, GFP_KERNEL,
 							     "pd:%d",
 							     args.args[0]);
-				if (!pd->pd.name)
+				if (!pd->pd.name) {
+					of_node_put(np);
 					return -ENOMEM;
+				}
 
 				pd->pd.power_off = ti_sci_pd_power_off;
 				pd->pd.power_on = ti_sci_pd_power_on;

