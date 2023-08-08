Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF2F774423
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235510AbjHHSPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233921AbjHHSPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:15:03 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73AA97D780;
        Tue,  8 Aug 2023 10:23:11 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 378AOBAE041944;
        Tue, 8 Aug 2023 05:24:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691490251;
        bh=1u9kGD/rb8axbOP01zrJVY3SrkgwGJf8cTD+q2iLrD0=;
        h=From:To:CC:Subject:Date;
        b=B8DJHqJgS6ZsPPCBzloE+klusOq3totzbEUtTGABX4KY6wgumo9LnNJjss9sr8CVS
         Jl/bEHmbTbYCEOA9Zxudvo24svqNbmzH5Lp1y1QOMcdWxQBT+kKT7GSmsO55YHmxtL
         YIQhsqXkpN7FizcckwOcM6bYMuxoZj9UltNtnK5I=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 378AOBvU004864
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Aug 2023 05:24:11 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 8
 Aug 2023 05:24:10 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 8 Aug 2023 05:24:10 -0500
Received: from dhruva.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 378AO6oA022340;
        Tue, 8 Aug 2023 05:24:07 -0500
From:   Dhruva Gole <d-gole@ti.com>
To:     Tony Lindgren <tony@atomide.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-omap@vger.kernel.org>, Dhruva Gole <d-gole@ti.com>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Haojian Zhuang <haojian.zhuang@linaro.org>
Subject: [PATCH 0/2] pinctrl-single: introduce am654-padconf compatible
Date:   Tue, 8 Aug 2023 15:52:06 +0530
Message-ID: <20230808102207.130177-1-d-gole@ti.com>
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

The K3 family of SOCs use certain bits of the padconfig registers like
WKUP_EVT and WKUP_EN to enable daisychain wakeups.

For example, these bits are described in the AM654 TRM [0] under
"Table 5-517. Description Of The Pad Configuration Register Bits"

This series adds the DT binding changes for adding the compatible and
also the driver changes which make use of this compatible.

NOTE: Some K3 SoCs may have these bits marked as reserved which means
that they don't support IO daisychain. Such SOCs are not expected to use
this compatible.

The general expected usage is when the device is in a suspended state like Deep
Sleep or Suspend to RAM, and any IO activity on configured pads can
trigger a wakeup.

Link to complete series:
https://lore.kernel.org/all/20230808102207.130177-1-d-gole@ti.com

Base commit:
71cd4fc492ec (tag: next-20230808, linux-next/master) Add linux-next specific files for 20230808

depends on:
https://lore.kernel.org/r/20230721082654.27036-1-tony@atomide.com

which has been picked up by Linus Walleij in his tree here:
https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git/commit/?h=devel&id=677a62482bd6e584f83d0342e78735e3cd449ba4

However, it hasn't reflected in -next yet so specifying the depends on
above.

[0] https://www.ti.com/lit/pdf/spruid7

Cc: Nishanth Menon <nm@ti.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Conor Dooley <conor.dooley@microchip.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Haojian Zhuang <haojian.zhuang@linaro.org>

Dhruva Gole (1):
  dt-bindings: pinctrl: pinctrl-single: add ti,am654-padconf compatible

Tony Lindgren (1):
  pinctrl: single: Add compatible for ti,am654-padconf

 .../devicetree/bindings/pinctrl/pinctrl-single.yaml        | 1 +
 drivers/pinctrl/pinctrl-single.c                           | 7 +++++++
 2 files changed, 8 insertions(+)

-- 
2.34.1

