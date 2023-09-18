Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB9C7A52D0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 21:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjIRTRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 15:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjIRTRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 15:17:36 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42CC8F7;
        Mon, 18 Sep 2023 12:17:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bzQWYlGBK2Qne3zq8ywj7s1AJtoJ7NnDFORS1axDhritzHuU07ktWX35dhrwdMa02VFlJIv1NqY25Su4v/zdbJI0QaY3KVYyjPIS5sLDzp0X8eu1mGJ+AXIsQbpW2BUBusJm7gF544UcBTAJDwEaxArj7BPxiDHLbdVyxQOS6wwksnhE3dl6yYWeOvYekFy9FRp9MNQRyQzztUvTAywhe89iNUmBE3Y1R/QuJnvBnE2rv6RbhPWumE2M4I5cgYS/Wcc3PaTeuL1gVFORsTDnay3l/IqbRfPaFpu4mKdZjDHXl0fsnJ5RJHUxrj3Mjztz9NopFe70wo1ptjgyJnxwRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=04VLBmkoD5cFhlzMpLZlKE4XTGFFrhBRWcve+1/7Mb0=;
 b=S/vnQx9hrPTIwM/GIAsiX/2JHnTe87PeU4S3d+KnmKX3Tdy7nO4FEIFFrxkwD5nlq6zXAQEinlFYmJTiY3hntB4TYQHdT/OiT4UuYcvYBVspQmw6CqehTKlHTqRZL6b7mbtegJG812Wt4InmCo/1eKOq3gBhovNbrIzZPH9dOj3r2tQvxNcqxjmJpwiBXsxW3j/kulpyMYuXeImKn4Th8sfzWlblt/EeqW769eiFdEqK/XljaLJjmCqpgPSwKzEwQQEi8r3RVlfjRBR3p2r4OkmCr84Zs3r9J/hjavBwKiSmqg1fJ+XCxRbnYSHGH7wVG9TLHO16wvs2MNgr8i3BrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=04VLBmkoD5cFhlzMpLZlKE4XTGFFrhBRWcve+1/7Mb0=;
 b=kiECMQqagC+jx9+bpFgsGNldjrWFO2q0Mz3mzF+mJMP2OG5lEqeitkujNd9uosZUlt9tplyvdutszYKwKQAH5IqwiHEz3YI0U3kLAmJTFS0hG2DEAYd5kP3UCKw3Fcjmk5WFLGtV7VgBh20J3ZmRPK0ZqDyWsYshRZJ7yq++uTU=
Received: from SJ0PR03CA0151.namprd03.prod.outlook.com (2603:10b6:a03:338::6)
 by DM6PR12MB4185.namprd12.prod.outlook.com (2603:10b6:5:216::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Mon, 18 Sep
 2023 19:17:27 +0000
Received: from DS3PEPF000099E2.namprd04.prod.outlook.com
 (2603:10b6:a03:338:cafe::35) by SJ0PR03CA0151.outlook.office365.com
 (2603:10b6:a03:338::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27 via Frontend
 Transport; Mon, 18 Sep 2023 19:17:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF000099E2.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Mon, 18 Sep 2023 19:17:27 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 18 Sep
 2023 14:17:26 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Mon, 18 Sep 2023 14:17:22 -0500
From:   Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To:     <radhey.shyam.pandey@amd.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <michal.simek@amd.com>,
        <linux@armlinux.org.uk>
CC:     <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@amd.com>
Subject: [PATCH net-next v6 0/3] net: axienet: Introduce dmaengine
Date:   Tue, 19 Sep 2023 00:46:52 +0530
Message-ID: <1695064615-3164315-1-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E2:EE_|DM6PR12MB4185:EE_
X-MS-Office365-Filtering-Correlation-Id: f8be7f1c-c57a-41d0-ca4a-08dbb87be56f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BRdZDgb4tcuMLOPiPkmkqFkUzWbikpX3kdhUi52Zj7DNZRSZV62y140Nw2YTeVJxiYw70TZzy6feREpAKrINCKg9k8TQq6Pp9mD+FUG2Yy6Vzs2YQvSHrRoz0RPhQTGFVpsCSsf92meHIszAMkhVxTzVHNNporWlxP+9CDwoBphoeVw00Nw1V/iaGUffTTbYl+7ldQOoO3nAQFVZy4poqVmjmmgCPKq1pIwLrQRFNN+aaBr3VuvP0mlOeKwyd8kUQneUXr/992QHoc9aPucHzrg+3uQ8Ga1HFIj04xr9QmmHj0wyO3tsPA86n7oUgatlWb4o+wAodi4rDOdVK90i2KwEAkoE1Xqci4aaXH2yhZY4ZssbHeIu4T4U8JFdbW4mtI8mPgsa/ahozuUyr5Y5eeJNoxIzGfPH2uWk2QNy0kaGEWZGGcvvFFcnIr3Hai/F4cpW1nxihe7W516Mx5LLf+dkMB0Lo281NCzv+GQv4Q+NclRVCiBjm5NvEZuiBArd1JGCuwN1Tg0flSlAuvHqc1DDrTRdHfbBRjT7aKnyU/54VMfimmTF30nQOPaqVK0ZlWHwmphGxPFR12jnB7qpOQfrfeAlGZpB4H3HLWisCOiIrjjoiNm2BZkg5FsA1lfIgID0Ut+lkVKLv0gLBs7ZeJeVwjU+Hpitq2xqN05X88TrITX5FNjC+qRnfaF5ySlXoSCSrfmVxzHyTiIR1RYGHckcPxVVRGZR/HV3zadamv1L56buxm9ifzlLSOGn5xOLPDMTi39fDQFrY+occmRsKIaPQxPT1TeJRSGx7TpSn5BslfFQwSprDQhF/NrxdIeJ
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(346002)(39860400002)(376002)(451199024)(82310400011)(1800799009)(186009)(46966006)(40470700004)(36840700001)(6666004)(36756003)(478600001)(966005)(40460700003)(40480700001)(426003)(336012)(7416002)(26005)(86362001)(5660300002)(2906002)(83380400001)(47076005)(36860700001)(66899024)(82740400003)(356005)(81166007)(921005)(2616005)(70206006)(70586007)(110136005)(316002)(54906003)(41300700001)(8676002)(4326008)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 19:17:27.2072
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8be7f1c-c57a-41d0-ca4a-08dbb87be56f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4185
X-Spam-Status: No, score=-1.1 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The axiethernet driver can use the dmaengine framework to communicate
with the xilinx DMAengine driver(AXIDMA, MCDMA). The inspiration behind
this dmaengine adoption is to reuse the in-kernel xilinx dma engine
driver[1] and remove redundant dma programming sequence[2] from the
ethernet driver. This simplifies the ethernet driver and also makes
it generic to be hooked to any complaint dma IP i.e AXIDMA, MCDMA
without any modification.

The dmaengine framework was extended for metadata API support during
the axidma RFC[3] discussion. However, it still needs further
enhancements to make it well suited for ethernet usecases.

Comments, suggestions, thoughts to implement remaining functional
features are very welcome!

[1]: https://github.com/torvalds/linux/blob/master/drivers/dma/xilinx/xilinx_dma.c
[2]: https://github.com/torvalds/linux/blob/master/drivers/net/ethernet/xilinx/xilinx_axienet_main.c#L238
[3]: http://lkml.iu.edu/hypermail/linux/kernel/1804.0/00367.html
[4]: https://lore.kernel.org/all/20221124102745.2620370-1-sarath.babu.naidu.gaddam@amd.com

Changes in v6:
- Remove patchset 1-7 as it was applied to dmaengine tree in v5 version.
- Added Krzysztof reviewed-by tag for dmaengine binding patch.
- Rename struct axi_skbuff to skbuf_dma_descriptor and removed
  __packed attribute.
- Drop kmem_cache implementation and switch to using ring buffers.
- Remove __inline from axienet_init_dmaengine().
- Name labels after the target.
- Add error check for platform_get_irq_optional().
- Fix double space and no empty lines between call and its error check.

Changes in v5:
- Fix git am failure on net-next
- Addressed DT binding review comments i.e Modified commit description to
  remove dmaengine framework references and instead describe how
  axiethernet IP uses DMA channels.
- Fix "^[tr]x_chan[0-9]|1[0-5]$" -> "^[tr]x_chan([0-9]|1[0-5])$"
- Drop generic dmas description.
- Fix kmem_cache resource leak.
- Merge Xilinx DMA enhancements and optimization[4] into this series.

Changes in V4:
- Updated commit description about tx/rx channels name(1/3).
- Removed "dt-bindings" and "dmaengine" strings in subject(1/3).
- Extended dmas and dma-names to support MCDMA channel names(1/3).
- Rename has_dmas to use_dmaegine(2/3).
- Remove the AXIENET_USE_DMA(2/3).
- Remove the AXIENET_USE_DMA(3/3).
- Add dev_err_probe for dma_request_chan error handling(3/3).
- Add kmem_cache_destroy for create in axienet_setup_dma_chan(3/3).

Changes in V3:
- Moved RFC to PATCH.
- Removed ethtool get/set coalesce, will be added later.
- Added backward comapatible support.
- Split the dmaengine support patch of V2 into two patches(2/3 and 3/3).
https://lore.kernel.org/all/20220920055703.13246-4-sarath.babu.naidu.gaddam@amd.com/

Changes in V2:
- Add ethtool get/set coalesce and DMA reset using DMAengine framework.
- Add performance numbers.
- Remove .txt and change the name of file to xlnx,axiethernet.yaml.
- Fix DT check warning(Fix DT check warning('device_type' does not match
   any of the regexes:'pinctrl-[0-9]+' From schema: Documentation/
   devicetree/bindings/net/xilinx_axienet.yaml).


Radhey Shyam Pandey (2):
  dt-bindings: net: xlnx,axi-ethernet: Introduce DMA support
  net: axienet: Introduce dmaengine support

Sarath Babu Naidu Gaddam (1):
  net: axienet: Preparatory changes for dmaengine support

 .../bindings/net/xlnx,axi-ethernet.yaml       |  16 +
 drivers/net/ethernet/xilinx/Kconfig           |   1 +
 drivers/net/ethernet/xilinx/xilinx_axienet.h  |  35 +
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 661 ++++++++++++++----
 4 files changed, 590 insertions(+), 123 deletions(-)

-- 
2.34.1

