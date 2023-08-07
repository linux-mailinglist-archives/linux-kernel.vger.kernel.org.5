Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A38771A62
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 08:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjHGG3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 02:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbjHGG3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 02:29:23 -0400
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C12B21FDE;
        Sun,  6 Aug 2023 23:28:53 -0700 (PDT)
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
Received: from 192.168.10.47
        by mg.richtek.com with MailGates ESMTPS Server V6.0(3962120:0:AUTH_RELAY)
        (envelope-from <alina_yu@richtek.com>)
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Mon, 07 Aug 2023 14:28:10 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Mon, 7 Aug
 2023 14:28:10 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex3.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1118.25 via Frontend
 Transport; Mon, 7 Aug 2023 14:28:10 +0800
From:   Alina Yu <alina_yu@richtek.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <alina_yu@richtek.com>
Subject: [PATCH v7 0/2] Add Richtek RTQ2208 SubPMIC support
Date:   Mon, 7 Aug 2023 14:28:05 +0800
Message-ID: <1691389687-31211-1-git-send-email-alina_yu@richtek.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for RTQ2208 SubPMIC regulators.               
The RTQ2208 is a multi-phase, programmable power management IC that    
integrate with dual multi-configurable, synchronous buck converters    
and two ldos. The bucks features wide output voltage range from 0.4V to 2.05V
and the capability to configure the corresponding power stages.

Thank you,
Alina yu
---
Change in v7:
- In Patch 2/2:
	- Include missing <linux/mod_devicetable.h>
	- Remove fixed_uV in self-defined structure and rtq2208_ldo_get_voltage
	- Modify sizeof() parameter in rdesc = devm_kzalloc(..., sizeof().....)
	- Add const to type casting in regulator_ops to avoid unexpected manipulation
	- Remove rtq2208_of_parse_cb and use of_regulator_match to get constraints.min_uV
	- Return devm_request_threaded_irq directly
	- Remove __maybe_unused and redundant comma in rtq2208_device_tables
	- Remove v2 in MODULE_LICENSE
Change in v6:
- In Patch 1/2:
	- Add "additionalProperties: false" to regulator node
- In Patch 2/2:
	- Remove Reported-by tag
Change in v5:
- In Patch 1/2:
	- Revise filename from $id
	- Remove "regulator-compatible" for ldos
	- Add missing "high" for "richtek,mtp-sel-high"
	- Remove "regulator-mode" property
	- Add and modify "unevaluatedProperties: false" and "additionalProperties: false"
	- Remove "richtek,fixed-uV"
	- Remove redundant space in "buck-a" and "ldo2"
- In Patch 2/2:
	- Modify 'rdesc->fixed_uV' get, becasue "richtek,fixed-uV" is removed from yaml
	- Modify 'mtp_sel' get because read property is changed from "richtek,mtp-sel" to
	  "richtek,mtp-sel-high" in yaml
	- Add missing regulators_node points to regulator node in yaml
	- Include <linux/bitfield.h> for 'FIELD_PREP' reported by kernel test robot
Change in v4:
- In Patch 1/2:
	- Modify filename to "richtek,rtq2208"
	- Add more desciptions for "regulator-allowed-modes"
Change in v3:
- In Patch 1/2:
	- Fix some typos
	- Modify the descriptions for "richtek,mtp-sel"
	- Modify the node name to lowercase and remove underscore
	- Remove '|' from description
	- Remove "regulator-compatible" from property
	- Remove "regulator-state-mem" from pattern
	- Modify node name to generic one
---
Alina Yu (2):
  regulator: dt-bindings: rtq2208: Add Richtek RTQ2208 SubPMIC
  regulator: rtq2208: Add Richtek RTQ2208 SubPMIC driver

 .../bindings/regulator/richtek,rtq2208.yaml        | 197 +++++++
 drivers/regulator/Kconfig                          |  11 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/rtq2208-regulator.c              | 583 +++++++++++++++++++++
 4 files changed, 792 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rtq2208.yaml
 create mode 100644 drivers/regulator/rtq2208-regulator.c

-- 
2.7.4

