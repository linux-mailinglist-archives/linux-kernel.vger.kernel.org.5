Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60AF07ECAD8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 19:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjKOS5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 13:57:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbjKOS5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 13:57:19 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D68CC;
        Wed, 15 Nov 2023 10:57:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AjsrZXAmENzCdoc5BY9rr8KiPP1ID1CVzb/2I56pS8x/wkE0+0TdC1di+9XrAaNOWPE7WIsg1JbBOCGjopFx3+uIuEUMruU+Kz9lvQ6wyLgWufruoXv8aJceT0cEQVaGjcsfNLa65PT33NB7b49JcAVkvbdDf3DLf/bcM8R0Rro1pKBvt4aVK09/+qdLHPxgo5b+3HjfYnc362N7VQzdR3onNOqS1JUBx2fz6idV2uyjLMhrLHMqAVIZDYLFV52Yvn3ktbcViNRRWln8xHNkHLVVygGrsaNYDeORW71JmHsFfvNFZ45L60UX2GETxtRr2gdrGjW7OiHPHLLGAG5E+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4807cBLgCcfvcacNJpwZ+w6MUfvdyLUi2pmt5NLyBNM=;
 b=Wg9ZXKnx3zCYbT1k+bA6QIZTSom3PDPjB1e0rB/o+qpwW3eloJ8SUOEBGfKwyequaRj5+DDRxp6ofqKToPIEfYLP8Fc1Bk9zIJVmCTvQG/7fRLyFb4nowlsDM//L482U3v1aSfsRu/YcodXUcH781cg8v1gkcIjh7XoXDTpYY+o1jCF1xBa95Rwio8YDlUZkmbGISr3BE8UVBuU+KYsoxGcbKeduyR6DJiVyOg3LExEHo6Zc0pzIBzClcMOW/jxT4D5P+i+t5Yr7ByX6sR+Bo2uSX0Fr0iLxnkJUFM0AXcX/HDZw7vA3hxALQQmcX9DdONS/u5okXqA5t7HQAVV1Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4807cBLgCcfvcacNJpwZ+w6MUfvdyLUi2pmt5NLyBNM=;
 b=pOuIyxZtZ7yJG+mtVPakKBP0CzwPL3bed8oC5lmJZd5vWYGKcfY0ZQnIFRDGABbnhi1uVw3TPcsCZ/HRa795qcRny4T5JIJ23RmB5X0XYANb9+dJVMsy66fdH8FkWyW51jzgaseloAaAkGOXPJZOMnu2BzxvzHWscSo7ZiRNS5s=
Received: from BL1PR13CA0064.namprd13.prod.outlook.com (2603:10b6:208:2b8::9)
 by BL3PR12MB6379.namprd12.prod.outlook.com (2603:10b6:208:3b2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Wed, 15 Nov
 2023 18:57:10 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:208:2b8:cafe::e8) by BL1PR13CA0064.outlook.office365.com
 (2603:10b6:208:2b8::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17 via Frontend
 Transport; Wed, 15 Nov 2023 18:57:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.20 via Frontend Transport; Wed, 15 Nov 2023 18:57:09 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 15 Nov
 2023 12:57:09 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 15 Nov
 2023 10:57:08 -0800
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32 via Frontend
 Transport; Wed, 15 Nov 2023 12:57:05 -0600
From:   Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To:     <radhey.shyam.pandey@amd.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <michal.simek@amd.com>,
        <linux@armlinux.org.uk>, <anirudha.sarangi@amd.com>,
        <harini.katakam@amd.com>
CC:     <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH net-next v9 0/3] net: axienet: Introduce dmaengine
Date:   Thu, 16 Nov 2023 00:26:50 +0530
Message-ID: <1700074613-1977070-1-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|BL3PR12MB6379:EE_
X-MS-Office365-Filtering-Correlation-Id: d3330b56-dabd-41dc-a797-08dbe60cab9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Z9mqbCvcwxGIYsDCtHG6ZeAG197VaANYGLaoksXO0p3PlAPPp8qqiVlvZtIgMtBPynEyQ8xKJyQYzZpzGKKodA6xwUqpcVhjPsj/t9pkl4Zf0tLMZx8LWcsOeDSwNDyCZwmKdPF93WUsPnPmsGE+cwQiMypSE/RMUG66n/cI/2Ss3zMv5I3x/i6O6zdO+bhA81UUn68zyJ+KcmwU6AAormtCFt+d6AXnrS+T79heI4mZE/Ms77KdJL9/WX0BOboxCXmEd3IsJomtgRPKxUxkdrXVKJ/qmHJOH6ypN5BSrWIRm97wGcYUBlsJ7wDMTri3L6v6FGxAMiHBQalarTHd4KzAlHKpHtmt+PFD4YQTPWpgTBI+L310Ssb6rRyziPEwKWn24TmeZDOGpbcX2siUUfoObyN9U8otqafAewD3rE2XXopEQuRqCOEpneEbPJok2TWir4i9tU4S1bxa2i32zMNCIYzHZFgewoIHcC7L1lMHQz7+9w/IHHGLjcUiR+nbvxNLf3wi/3fAvZMO75SJWEjCC1xrm5ZOF6+E2Yj5AD15lL7mZQlmgstB2pMTUA916Ei6Jx94qC2TMW1Ik2n5pkWeADIHnchJuWSoIYZ0Ud+hdp/9aCAX79vg1wDqw4aTEOmdfIcb+6e/g5ejOyIeINBmGgptqDP55NHESpycxl4pifpT9OCgUu6DjVLQ1BCAKO415z9nXZv5Zh1zXc3EvWA00i8AMDWVzQ85Qx8htraj2GEoqyUtYIaCYOb/i7k70aKMKvsw+KWIFBUx1fVKfv0LnB1dkYzhiluv3/w7Yhb2uVOS2nsGq8eflCDSwsK9IfImYoxrobMgdHN/7lY3bb/jfzIv+4Djmz830ndWu8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(396003)(136003)(346002)(230273577357003)(230922051799003)(230173577357003)(1800799009)(64100799003)(82310400011)(451199024)(186009)(40470700004)(36840700001)(46966006)(66899024)(70206006)(6636002)(70586007)(316002)(82740400003)(426003)(47076005)(336012)(83380400001)(40480700001)(36860700001)(36756003)(40460700003)(6666004)(2616005)(26005)(478600001)(966005)(356005)(921008)(54906003)(81166007)(41300700001)(110136005)(8936002)(2906002)(5660300002)(7416002)(86362001)(8676002)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 18:57:09.5286
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3330b56-dabd-41dc-a797-08dbe60cab9c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6379
X-Spam-Status: No, score=1.8 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
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

Changes for v9:
- In axienet_start_xmit_dmaengine() create drop_skb label to reuse exit
  error handling.
- Implement advance stopping and waking netdev queues and update perf
  numbers in commit description.
- Make axienet_start_xmit_dmaengine() return void.
- Use the reverse x-mas tree order.

Changes for v8:
- Use dev_consume_skb_any() in transmit callback.
- Fix queue stop logic in _xmit_dmaengine().
- Fix skb leak in _xmit_dmaengine() error path.
- In dmaengine tx path use dma_device pointer to call prep_slave_sg.
- In rx submit use rate limiting for mapping errors and fix error
  handling.
- Revert dev_err_probe from _init_dmaengine().
- Remove unnecessary new line after call to _init_dmaengine().
- Move free_irq(lp->eth_irq) to error path.
- Have separate netdev_ops for dmaengine flow.
- Remove spurious new line and inline attribute from axienet_init_legacy_dma().
- Drop indirection for xmit() func. For dmaengine flow have separate
  netdev_ops.
- Improve axienet_dma_tx_cb and axienet_rx_submit_desc documentation.

Changes in v7:
- Fix comment spaces.
- In xmit use correct XAE_FEATURE_PARTIAL_TX_CSUM define.
- Rename app to app_metadata.
- Switch to __netif_rx.
- In axienet_rx_submit_desc() add mapping error handling.
- Introduce new workaround 4/4 patch to enable lkp_test
  build coverage. To be dropped for mainline.

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
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 667 ++++++++++++++----
 4 files changed, 598 insertions(+), 121 deletions(-)

-- 
2.34.1

