Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 308A977218F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 13:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbjHGLXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 07:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbjHGLWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 07:22:23 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DC22109;
        Mon,  7 Aug 2023 04:20:04 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 377BJ2iY122323;
        Mon, 7 Aug 2023 06:19:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691407142;
        bh=2ZPc25P6pv2d81n61nsdhXtMSF1qpkDm391PfSd0OXE=;
        h=From:To:CC:Subject:Date;
        b=HCOMoeBsubs638d3ZHJtMxVBNL3kQqaKG2Ox6YBB1cfdhWFTgR9RRWSRB54ZOWvjY
         f9kFQn/2Ra1ZLbSgVFtzJqxMIDlVq7Tdx/Y4ept0L0NzsddBZ1Of4mdQNemWNo/Y8+
         a4oZOL7ez/OHNulSPxzj5zmoqHBlbMmDy8RGL0Ik=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 377BJ2Vq000618
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Aug 2023 06:19:02 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 7
 Aug 2023 06:19:01 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 7 Aug 2023 06:19:01 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 377BJ1fV090849;
        Mon, 7 Aug 2023 06:19:01 -0500
Received: from localhost (uda0501179.dhcp.ti.com [172.24.227.217])
        by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 377BJ0iW031598;
        Mon, 7 Aug 2023 06:19:01 -0500
From:   MD Danish Anwar <danishanwar@ti.com>
To:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>
CC:     Tero Kristo <kristo@kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <danishanwar@ti.com>, <srk@ti.com>
Subject: [PATCH RFC 0/3] Add AM65x ICSSG2 Ethernet support
Date:   Mon, 7 Aug 2023 16:48:52 +0530
Message-ID: <20230807111855.2614761-1-danishanwar@ti.com>
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

Hi All,

This series adds support for ICSSG2 ethernet on AM65x SR2.0. This series
is dependent on [1] and [2]. [1] is part of linux-next and [2] is still
under review. This series can be merged in next cycle once both [1] and [2]
are part of the mainline kernel. For now, I am posting this as RFC to get
comments and modify patches if needed.

[1] https://lore.kernel.org/all/20230807110048.2611456-1-danishanwar@ti.com/
[2] https://lore.kernel.org/all/20230807110836.2612730-1-danishanwar@ti.com/

Thanks and Regards,
Md Danish Anwar
MD Danish Anwar (2):
  arm64: dts: ti: k3-am65-main: Add ICSSG IEP nodes
  arm64: dts: ti: am654-base-board: add ICSSG2 Ethernet support

Suman Anna (1):
  arm64: dts: ti: k3-am65-main: Add PRU system events for virtio

 arch/arm64/boot/dts/ti/k3-am65-main.dtsi      |  72 ++++++++++
 .../arm64/boot/dts/ti/k3-am654-base-board.dts | 131 ++++++++++++++++++
 2 files changed, 203 insertions(+)

-- 
2.34.1

