Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D5A780A53
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 12:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376357AbjHRKjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 06:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356537AbjHRKiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 06:38:51 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7084213E;
        Fri, 18 Aug 2023 03:38:50 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37IAcdrX001569;
        Fri, 18 Aug 2023 05:38:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1692355119;
        bh=cGQuI/kExsbPSiA05+9fEPo0vBVRf8HF1Ve+YmA08m0=;
        h=From:To:CC:Subject:Date;
        b=pJwBj1DC6iWF04Yim2ha7sdCEfa8J7HdQLTacrjwWCgorN+Sb9723wZOIOjSCpfJu
         MQrFM4TGIGHJJt4hVR5eUMzxbPHPrK5Q282MwEyd/IFIvCBtkzTEr1NqMWvyVXdF2a
         prmB8SB7hvgv0sQkelXTQKQ0M9xtoylVasxd8Qps=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37IAcdXc020225
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Aug 2023 05:38:39 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 18
 Aug 2023 05:38:39 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 18 Aug 2023 05:38:39 -0500
Received: from dhruva.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37IAcZ5Z001102;
        Fri, 18 Aug 2023 05:38:36 -0500
From:   Dhruva Gole <d-gole@ti.com>
To:     Mark Brown <broonie@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, Dhruva Gole <d-gole@ti.com>
Subject: [PATCH 0/2] spi-cadence-quadspi: Introduce runtime_pm support
Date:   Fri, 18 Aug 2023 16:07:48 +0530
Message-ID: <20230818103750.516309-1-d-gole@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Abstract
********

This series aims to add runtime_pm [0] functionality to the cadence-qspi
driver/IP. Prior to this, the driver had system suspend resume support
which comes into picture only during system wide low power states like
deep sleep / Suspend-to-RAM.

Now, with runtime_pm support we can finally allow this driver/controller
to be clock gated/ suspended when it's not in active use. This helps the
overall system to reduce it's power consumption without needing to resort
to system wide low power modes.

As it turns out, the system suspend resume functionality that existed so
far can be re-used as is even for runtime suspend resume, hence the
actual implementations of those calls need not change.

Testing
*******

This series has been tested by me on a SK-AM625 [1] EVM by Texas Instruments.

I did a basic test to check if IP suspended by trying to access it's
registers while suspended (got core dump) and then to check resume I
read back data from it. Also used k3conf, a TI tool to check on the
device status in K3 Family of SOCs.

I highly encourage other platforms and users of this driver to test
these changes as it affects all those who use runtime_pm.
For this, I have uploaded these changes on my github branch [2] which
can be cloned and readily used.
For referring to how I tested, please refer to my logs [3]

Runtime PM usage
****************

The auto-suspend delay can be tweaked from the userspace using the
following sysfs entry:

root@am62xx-evm:~# cat /sys/bus/platform/devices/fc40000.spi/power/autosuspend_delay_ms
2000

Other useful information can be obtained from the same folder,

root@am62xx-evm:~# cat /sys/bus/platform/devices/fc40000.spi/power/runtime_*

To disable runtime auto-suspend for this driver one can set autosuspend_delay_ms to -1

Note to maintainers
*******************

* Patch 1/2 should probably go via Nishant's / Vignesh's tree
* Patch 2/2 (RFT) can go via Mark's tree

Reference/Links
***************

[0] https://docs.kernel.org/power/runtime_pm.html
[1] https://www.ti.com/tool/SK-AM62
[2] https://github.com/DhruvaG2000/v-linux/tree/ospi_runtime_pm
[3] https://gist.github.com/DhruvaG2000/6aeeb2196caf8fbbe518c89037cb7548

Dhruva Gole (2):
  arm64: dts: ti: k3-am62-main: PM fixes in the fss node
  spi: spi-cadence-quadspi: add runtime pm support

 arch/arm64/boot/dts/ti/k3-am62-main.dtsi |  3 +-
 drivers/spi/spi-cadence-quadspi.c        | 38 ++++++++++++++++++------
 2 files changed, 31 insertions(+), 10 deletions(-)


base-commit: 47762f08697484cf0c2f2904b8c52375ed26c8cb
-- 
2.34.1

