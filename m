Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1119175C719
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 14:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbjGUMra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 08:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbjGUMrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 08:47:23 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4ED23599
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 05:47:08 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b89e10d356so12717835ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 05:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689943628; x=1690548428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zOhQoPjGrp3aso+jrzR34u3Ml2QJYToj9I27g4uhl+E=;
        b=sLt6bNbNO5+X1FVNrje31z+kzhAtTrYWfTf5ak1d8fmUA7BIhfftjsIIEBLVnc8dLe
         zroqTQt12W9Le2eqkqBzLc/YbS8Xqo/rxK6KRAuZySb/LGilDP4A16Oslzp8ZqB4fubB
         QNWnyGSK3/p9z9HwfCb3NvQblxoH2QjVDol04bz5aX+GXEwmkTmTmdyCwrQjtqlnsocf
         i23s6sLnswwIeIgsRtHpOZiLrcnk2CaPubUmpOrwMzQdmge3kjwOnikBb3cf4K9JMrZF
         IG9YgqpKp9cQOfkEdjq50lJclhMpknUtxbisbP3OdznFHvqRm4hu2D3Ts44iuxcbFUns
         DANw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689943628; x=1690548428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zOhQoPjGrp3aso+jrzR34u3Ml2QJYToj9I27g4uhl+E=;
        b=ZlndZHhqhuBPMtfoqwGy5LOQeiXcQWZsDFXR2D336YVuDAnUWpWcPCqKtkGq3fyz2r
         NbwoBueODupBnn7gaEGNAcLlgagiIiN+Gr6pO6uDXvV5vWNdB5RhQnnGDP48APE6P63E
         gDXYS0J0ZlQU3Mdoh1GN8qbrwvmtJCdta9ICSJ/hPyx1RUz+oHHjPjU5/4S4KCsFbjTU
         +7iXWuzRwpTovB0H5Tg+Q0eINluTv6N3VFkB0qyyua7yourC9xemVwKHTvgM9AM4lXtN
         ZjOiXyEnvmmGObjJWAx46tNX+Am5nxX18G7ELtz5/SLqqVcOKQahTcfGVUj0LBCqtpd4
         VOWA==
X-Gm-Message-State: ABy/qLaKRa9g6rzITWV9gNsg+booJBf6BIo2B+EZ19x3Xlyp3SVgt/Kk
        Q3mjkDxv1Ky2uB1KBCoG3NQp
X-Google-Smtp-Source: APBJJlEdCdJ54RYTf2M0lyVjCXwtHC0oYWc7MxLH34VQXUF+B57CezarbfLcluW1zYrN+qI7GF9Axg==
X-Received: by 2002:a17:902:c409:b0:1b8:918d:ac48 with SMTP id k9-20020a170902c40900b001b8918dac48mr1894397plk.56.1689943628161;
        Fri, 21 Jul 2023 05:47:08 -0700 (PDT)
Received: from localhost.localdomain ([117.206.118.181])
        by smtp.gmail.com with ESMTPSA id ix7-20020a170902f80700b001b8b2fb52d4sm3369828plb.203.2023.07.21.05.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 05:46:57 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 1/2] OPP: Fix potential null ptr dereference in dev_pm_opp_get_required_pstate()
Date:   Fri, 21 Jul 2023 18:16:33 +0530
Message-Id: <20230721124634.63612-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230721124634.63612-1-manivannan.sadhasivam@linaro.org>
References: <20230721124634.63612-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"opp" pointer is dereferenced before the IS_ERR_OR_NULL() check. Fix it by
removing the dereference to cache opp_table and dereference it directly
where opp_table is used.

This fixes the following smatch warning:

drivers/opp/core.c:232 dev_pm_opp_get_required_pstate() warn: variable dereferenced before IS_ERR check 'opp' (see line 230)

Fixes: 84cb7ff35fcf ("OPP: pstate is only valid for genpd OPP tables")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/opp/core.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 3f46e499d615..98633ccd170a 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -227,20 +227,18 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_get_level);
 unsigned int dev_pm_opp_get_required_pstate(struct dev_pm_opp *opp,
 					    unsigned int index)
 {
-	struct opp_table *opp_table = opp->opp_table;
-
 	if (IS_ERR_OR_NULL(opp) || !opp->available ||
-	    index >= opp_table->required_opp_count) {
+	    index >= opp->opp_table->required_opp_count) {
 		pr_err("%s: Invalid parameters\n", __func__);
 		return 0;
 	}
 
 	/* required-opps not fully initialized yet */
-	if (lazy_linking_pending(opp_table))
+	if (lazy_linking_pending(opp->opp_table))
 		return 0;
 
 	/* The required OPP table must belong to a genpd */
-	if (unlikely(!opp_table->required_opp_tables[index]->is_genpd)) {
+	if (unlikely(!opp->opp_table->required_opp_tables[index]->is_genpd)) {
 		pr_err("%s: Performance state is only valid for genpds.\n", __func__);
 		return 0;
 	}
-- 
2.25.1

