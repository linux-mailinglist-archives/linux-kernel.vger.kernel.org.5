Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 358A37A165C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 08:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbjIOGrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 02:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbjIOGrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 02:47:09 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54312708
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 23:47:03 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38F6krgV112928;
        Fri, 15 Sep 2023 01:46:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1694760413;
        bh=5e/6Ce7vVJmSfy0L05izkNPmhmUIjdtio+jkh3g1ODI=;
        h=From:To:CC:Subject:Date;
        b=wha/9fke5ProGHzjxZll9ECxBEISRy6v4REqBtrL+nvPr6OtjPPbgSS+p79FxgdmI
         EuFxIPyKrzuCdfwYK8Rj7Kvdafkjoy+X16e9HINUW3Z/ocAzqtAeXzkpzGARFMU/W7
         Okll3Y4DdQx3X6yyEs3I3ZNmYuXCms8z+s40L0Pw=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38F6krMl043824
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 Sep 2023 01:46:53 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 15
 Sep 2023 01:46:53 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 15 Sep 2023 01:46:53 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38F6kota071619;
        Fri, 15 Sep 2023 01:46:51 -0500
From:   Neha Malcom Francis <n-francis@ti.com>
To:     <nm@ti.com>, <ssantosh@kernel.org>, <t-konduru@ti.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <n-francis@ti.com>,
        <u-kumar1@ti.com>
Subject: [PATCH v2 0/2] Revamp k3-socinfo driver
Date:   Fri, 15 Sep 2023 12:16:48 +0530
Message-ID: <20230915064650.2287638-1-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

k3-socinfo driver doesn't account for difference series of silicon
revisions instead of the typical 1.0, 2.0 etc case. This exception is
currently already seen in J721E. This series aims to modify the driver
to account for those exceptions as well as clean things up a bit.

Changes since v1:
	- Nishanth:
		- undo churning of family attribute
		- remove unnecessary code relocation
		- add Thejasvi to Signed-off-by as we are now similar to
		  the initial attempt [1]
		- separate out typo fixes to another patch (2/2)

v1: https://lore.kernel.org/linux-arm-kernel/20230914074426.1901226-1-n-francis@ti.com/T/

[1] https://lore.kernel.org/all/20230607080349.26671-1-t-konduru@ti.com/

Neha Malcom Francis (2):
  soc: ti: k3-socinfo: Revamp driver to accommodate different rev
    structs
  soc: ti k3-socinfo: Fix typo

 drivers/soc/ti/k3-socinfo.c | 73 +++++++++++++++++++++++++++++--------
 1 file changed, 57 insertions(+), 16 deletions(-)

-- 
2.34.1

