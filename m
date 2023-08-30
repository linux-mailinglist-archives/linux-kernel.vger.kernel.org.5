Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF1C78DFCD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344160AbjH3T0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243699AbjH3Lb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 07:31:58 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DAD1132;
        Wed, 30 Aug 2023 04:31:53 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37UBVf45036499;
        Wed, 30 Aug 2023 06:31:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1693395101;
        bh=iUyON9g7N9bq9U037IOvUry7cZtyq8thRjkECZYM9MM=;
        h=From:To:CC:Subject:Date;
        b=aG4hV55GPkEmaM7LeEuE0trFGXTjrXWRmeEcFzgdcqQ3asurlYqXIF0Iu/ry2nSk3
         NsM2K7GiodG+cAkfUApghGqHa8J3kgeKhQbmtXxXT288APuD0Us28DjLoLF3PqNc6n
         MejOBmkMMjLi7OkVenIhfBXWVdldbHoPEx8Lk2mI=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37UBVfZK004957
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 30 Aug 2023 06:31:41 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 30
 Aug 2023 06:31:40 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 30 Aug 2023 06:31:41 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37UBVem0047202;
        Wed, 30 Aug 2023 06:31:40 -0500
Received: from localhost (uda0501179.dhcp.ti.com [172.24.227.35])
        by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 37UBVd0G009958;
        Wed, 30 Aug 2023 06:31:40 -0500
From:   MD Danish Anwar <danishanwar@ti.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Simon Horman <horms@kernel.org>,
        MD Danish Anwar <danishanwar@ti.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <netdev@vger.kernel.org>, <srk@ti.com>, <r-gunasekaran@ti.com>
Subject: [RFC PATCH net-next 0/2] Add Half Duplex support for ICSSG Driver
Date:   Wed, 30 Aug 2023 17:01:32 +0530
Message-ID: <20230830113134.1226970-1-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
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

This series adds support for half duplex operation for ICSSG driver.

In order to support half-duplex operation at 10M and 100M link speeds, the
PHY collision detection signal (COL) should be routed to ICSSG
GPIO pin (PRGx_PRU0/1_GPI10) so that firmware can detect collision signal
and apply the CSMA/CD algorithm applicable for half duplex operation. A DT
property, "ti,half-duplex-capable" is introduced for this purpose in the
first patch of the series. If board has PHY COL pin conencted to
PRGx_PRU1_GPIO10, this DT property can be added to eth node of ICSSG, MII
port to support half duplex operation at that port.

Second patch of the series configures driver to support half-duplex
operation if the DT property "ti,half-duplex-capable" is enabled.

This series depends on [1] which is posted as RFC.

[1] https://lore.kernel.org/all/20230830110847.1219515-1-danishanwar@ti.com/

Thanks and Regards,
Md Danish Anwar

MD Danish Anwar (2):
  dt-bindings: net: Add documentation for Half duplex support.
  net: ti: icssg-prueth: Add support for half duplex operation

 .../bindings/net/ti,icssg-prueth.yaml           |  7 +++++++
 drivers/net/ethernet/ti/icssg/icssg_config.c    | 14 ++++++++++++++
 drivers/net/ethernet/ti/icssg/icssg_prueth.c    | 17 +++++++++++++++--
 drivers/net/ethernet/ti/icssg/icssg_prueth.h    |  2 ++
 4 files changed, 38 insertions(+), 2 deletions(-)

-- 
2.34.1

