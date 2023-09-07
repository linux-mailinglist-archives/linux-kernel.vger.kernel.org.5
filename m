Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0E9797979
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238921AbjIGRPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234817AbjIGRPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:15:39 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA8561BF2;
        Thu,  7 Sep 2023 10:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iJOjUytuDi14rkC3oZrvSAs7iUFKHk35xiEtUoBzWQY=;
  b=Wvn/1xqn5JLO07S13jHJAovo4kcnBJi0y8eMSuBgrIcFRrzOIyiAIPdq
   HkuvT5fcNo/kCAe/p20kFWawK73TiiMf7pCleBDDqIcVDeXTj66dBOXZn
   unFbd1TZekXDv/QNta4xe8N8308R2XiBQ8rtrtZh+NDE2dTzzE/nM1kXl
   E=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.02,234,1688421600"; 
   d="scan'208";a="65324658"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 11:55:30 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     kernel-janitors@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/11] powerpc/powermac: add missing of_node_put
Date:   Thu,  7 Sep 2023 11:55:13 +0200
Message-Id: <20230907095521.14053-4-Julia.Lawall@inria.fr>
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

for_each_node_by_name performs an of_node_get on each
iteration, so a break out of the loop requires an
of_node_put.

This was done using the Coccinelle semantic patch
iterators/for_each_child.cocci

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 arch/powerpc/platforms/powermac/low_i2c.c |    4 +++-
 arch/powerpc/platforms/powermac/smp.c     |    4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff -u -p a/arch/powerpc/platforms/powermac/smp.c b/arch/powerpc/platforms/powermac/smp.c
--- a/arch/powerpc/platforms/powermac/smp.c
+++ b/arch/powerpc/platforms/powermac/smp.c
@@ -598,8 +598,10 @@ static void __init smp_core99_setup_i2c_
 			name = "Pulsar";
 			break;
 		}
-		if (pmac_tb_freeze != NULL)
+		if (pmac_tb_freeze != NULL) {
+			of_node_put(cc);
 			break;
+		}
 	}
 	if (pmac_tb_freeze != NULL) {
 		/* Open i2c bus for synchronous access */
diff -u -p a/arch/powerpc/platforms/powermac/low_i2c.c b/arch/powerpc/platforms/powermac/low_i2c.c
--- a/arch/powerpc/platforms/powermac/low_i2c.c
+++ b/arch/powerpc/platforms/powermac/low_i2c.c
@@ -925,8 +925,10 @@ static void __init smu_i2c_probe(void)
 
 		sz = sizeof(struct pmac_i2c_bus) + sizeof(struct smu_i2c_cmd);
 		bus = kzalloc(sz, GFP_KERNEL);
-		if (bus == NULL)
+		if (bus == NULL) {
+			of_node_put(busnode);
 			return;
+		}
 
 		bus->controller = controller;
 		bus->busnode = of_node_get(busnode);

