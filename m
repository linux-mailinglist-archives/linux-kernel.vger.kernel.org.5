Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92317D952D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 12:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345598AbjJ0KY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 06:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbjJ0KYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 06:24:55 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C361DC;
        Fri, 27 Oct 2023 03:24:52 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPA id 6724CFF813;
        Fri, 27 Oct 2023 10:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1698402290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=cGPv+pY+P6hcMNmV/AQ4WJAxMTYlBDo9T5+aYFQOgzo=;
        b=BNqnkM7DL8PHAvoJucbsNnzyN67Xqv3vw1XSqrpkP1Wp9YjQY4tN0jdVh2O7osNMJeG5Aw
        HbasXwbwQngKO6KQyOahNUFA2dVEFk8GQj48Uwgg+YoM1jylHXugFjPYuFMSzEVSnktN/L
        I5bNGYZQFOnS6xXdKD1ptxClT2j8f4sGj+Lr6deYmvsznRyiqLwtIVu2QsdfghvB5Rg493
        +8YPecnqp0FJdfUn1sez8dAbku1P06TJxMXwf5EqFd7BtVFqSbYNgI6b4VtYZaLujWuuuj
        8SJPi8ECG2bqwlq+AYAG5XSl+lO2oiBwQ5u5M+mEefUQLaR0VtWysla/9zFDfg==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Lizhi Hou <lizhi.hou@amd.com>
Cc:     Max Zhen <max.zhen@amd.com>, Sonal Santan <sonal.santan@amd.com>,
        Stefano Stabellini <stefano.stabellini@xilinx.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 1/1] of: unittest: Fix test build on config without CONFIG_OF_ADDRESS
Date:   Fri, 27 Oct 2023 12:24:37 +0200
Message-ID: <20231027102440.677773-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_address_to_resource() is not defined if !CONFIG_OF_ADDRESS.

Return early in of_unittest_check_addr() to avoid the
of_address_to_resource() usage.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202310271513.8MUErCK4-lkp@intel.com/
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
Rob,

This fixes a patch you already applied from my series
https://lore.kernel.org/all/20231017110221.189299-1-herve.codina@bootlin.com/

I don't know if it's too late or not but maybe you can squash this fix patch.

My apologies for this issue.

Hervé

 drivers/of/unittest.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index ffbecd349899..e9e90e96600e 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -1201,6 +1201,9 @@ static void __init of_unittest_check_addr(const char *node_path,
 	unsigned int count;
 	int ret;
 
+	if (!IS_ENABLED(CONFIG_OF_ADDRESS))
+		return;
+
 	np = of_find_node_by_path(node_path);
 	if (!np) {
 		pr_err("missing testcase data (%s)\n", node_path);
-- 
2.41.0

