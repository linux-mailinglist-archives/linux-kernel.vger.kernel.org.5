Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60DEE7CA51C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 12:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233240AbjJPKRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 06:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233223AbjJPKQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 06:16:44 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852861BD
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 03:16:21 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39GAGCCn093567;
        Mon, 16 Oct 2023 05:16:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1697451372;
        bh=8Y44B5L9t+poTzbMACP4tWpaMfdbqEnIKJldTWMn6pA=;
        h=From:To:CC:Subject:Date;
        b=vThcx4UXvVjCKck/glEF9/4kIfTuCsUf/YtCYMb37CuPpiusNNrS8mndIii946AtS
         S4JE0r9RJHK1NB2igT0tTJTnPZVUDEFqsdnrd+O60Z+318Awz6eyBBhuAENameJi6v
         V/+vfoIo7mYGmltHHBhIcO67LOwm/QDEF9tYUQys=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39GAGCAW020250
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Oct 2023 05:16:12 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 16
 Oct 2023 05:16:11 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 16 Oct 2023 05:16:12 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39GAG90f033447;
        Mon, 16 Oct 2023 05:16:10 -0500
From:   Neha Malcom Francis <n-francis@ti.com>
To:     <nm@ti.com>, <ssantosh@kernel.org>, <t-konduru@ti.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <n-francis@ti.com>,
        <u-kumar1@ti.com>
Subject: [PATCH v3 0/3] Revamp k3-socinfo driver
Date:   Mon, 16 Oct 2023 15:46:05 +0530
Message-ID: <20231016101608.993921-1-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

k3-socinfo driver doesn't account for difference series of silicon
revisions instead of the typical 1.0, 2.0 etc case. This exception is
currently already seen in J721E. This series aims to modify the driver
to account for those exceptions as well as clean things up a bit.

Changes since v2:
	- Nishanth:
		- update commit message
		- move from double Signed-off-by to Co-developed-by
		- make j721e_rev_string_map[] a const char
		- drop k3_rev_string_map[] and continue using old
		  "variant++" logic for the typical cases
		- appropriate error handling with no overrides
		  distinguishing between ENODEV and ENOMEM
		- add patch for error handling initial cleanup
		- reorder patches

Changes since v1:
	- Nishanth:
		- undo churning of family attribute
		- remove unnecessary code relocation
		- add Thejasvi to Signed-off-by as we are now similar to
		  the initial attempt [1]
		- separate out typo fixes to another patch (2/2)

Boot log: https://gist.github.com/nehamalcom/ff9375dcde681dd78712ee8473b24a50
(See relevant k3-socinfo dev_info print on line 276)

v2: https://lore.kernel.org/lkml/20230915064650.2287638-1-n-francis@ti.com/T/
v1: https://lore.kernel.org/linux-arm-kernel/20230914074426.1901226-1-n-francis@ti.com/T/

[1] https://lore.kernel.org/all/20230607080349.26671-1-t-konduru@ti.com/

Neha Malcom Francis (3):
  soc: ti k3-socinfo: Fix typo
  soc: ti: k3-socinfo: Avoid overriding ret
  soc: ti: k3-socinfo: Revamp driver to accommodate different rev
    structs

 drivers/soc/ti/k3-socinfo.c | 76 +++++++++++++++++++++++++++----------
 1 file changed, 57 insertions(+), 19 deletions(-)

-- 
2.34.1

