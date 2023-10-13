Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93487C80EC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 10:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjJMIye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 04:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjJMIyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 04:54:33 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D72C95;
        Fri, 13 Oct 2023 01:54:31 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39D8sPwe065459;
        Fri, 13 Oct 2023 03:54:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1697187265;
        bh=EIam3hHPeLxKkwM9apMuaUiIVgyIIPYm6Gl0dS+/eNc=;
        h=From:To:CC:Subject:Date;
        b=ulAQTU51GdEa+oQ/saoxM+fXUgbPwSrq1PZYzKpVPlRAgj9sjoong40r+wGg6OkdI
         gVZrbBHOrB9CL7Bf+lPWghbDsOC3SwbP9LjueAULBUJbI9h5bf4lQnZnit2jxT2p+w
         RJmwM9qBzTBjPsbVxVwmM3ki4JFROwbDlpdqYl20=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39D8sPsN037438
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 13 Oct 2023 03:54:25 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 13
 Oct 2023 03:54:25 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 13 Oct 2023 03:54:25 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39D8sOTZ040179;
        Fri, 13 Oct 2023 03:54:25 -0500
From:   Aradhya Bhatia <a-bhatia1@ti.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
CC:     Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jai Luthra <j-luthra@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>,
        Aradhya Bhatia <a-bhatia1@ti.com>
Subject: [PATCH] scripts/dtc: Allow ports to have a single port@0 child
Date:   Fri, 13 Oct 2023 14:24:24 +0530
Message-ID: <20231013085424.7137-1-a-bhatia1@ti.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exempt 'ports' from the rule which asserts that nodes with single child
node having reg = 0, should not have the '#size-cells' and
'#address-cells' properties.

Ports of certain hardware do need to be described as only having a
single child node 'port@0', especially when hardware has multiple ports,
and the other ports 'port@x' are planned to be added subsequently. In
such cases, just using 'port', would be an inaccurate hardware
description.

For example, Texas Instruments' DSS (display-subsystem), which has 2 or
4 video ports depending on the SoC. Describing the first video port with
just 'port' under ports would be inaccurate and even slightly
misleading. Simply using port@0 (when other ports are not added)
produces the following warning, while making dtbs with W=1 flag set[0].

code-block ::

	Warning (graph_child_address): /bus@100000/dss@4a00000/ports:
	graph node has single child node 'port@0',
	#address-cells/#size-cells are not necessary

Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>

[0]: https://lore.kernel.org/all/570903b6-8239-d44a-5fac-71700804cb5d@ti.com/
---
 scripts/dtc/checks.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/scripts/dtc/checks.c b/scripts/dtc/checks.c
index 9f31d2607182..705aa0fbcfa2 100644
--- a/scripts/dtc/checks.c
+++ b/scripts/dtc/checks.c
@@ -1797,9 +1797,18 @@ static void check_graph_child_address(struct check *c, struct dt_info *dti,
 		cnt++;
 	}
 
-	if (cnt == 1 && node->addr_cells != -1)
+	if (cnt == 1 && node->addr_cells != -1) {
+		/*
+		 * The graph node "ports" are exempt from this rule, because
+		 * certain hardware do need to be described as only having a
+		 * signle port with reg = 0.
+		 */
+		if (!strcmp(node->name, "ports"))
+			return;
+
 		FAIL(c, dti, node, "graph node has single child node '%s', #address-cells/#size-cells are not necessary",
 		     node->children->name);
+	}
 }
 WARNING(graph_child_address, check_graph_child_address, NULL, &graph_nodes);
 

base-commit: e3b18f7200f45d66f7141136c25554ac1e82009b
-- 
2.40.1

