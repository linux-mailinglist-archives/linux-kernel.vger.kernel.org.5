Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44DB87C9DF3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 05:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbjJPDjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 23:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbjJPDjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 23:39:12 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2061.outbound.protection.outlook.com [40.107.215.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48EBAD;
        Sun, 15 Oct 2023 20:39:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nban2s39k8kVz0YkwMdKAn6v86y26JM/T1k+hxPp2TONZjtZmWmoh87yvqvu7bPIwODCVLnbak2jck5rXI6hfqygMuGBtAduHfwEvAQM7MIURVubEIa3dfZHbQFkx6jMJA+biJK39RVe59RQzZqLdiYpIrSdcR+ukAjlc6bDlfMCYqp4sDUf+6IL6dkr2IfA6ZOV4rar1qZQMhxYqtVQHeKTOo6mpTmBsVJ91C1rU7rjh0zHdRTg/Mo9hFZlxRx/+ZEsgLDXkSL4pEHo+AHiUSUUSdm/++wKWQMqLcrr5WMeunw1trFtg8+Wo+enxKTbv3QoeEo/zZPsan9ktvv+NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=14sAvbOOuTyQauAqc8zQlg1bO9cyNbkFDhJHL60o9U0=;
 b=c4rb+8LuDHjvSFLG1z1KQGz2S0QJ5pBasOhQr/sz0oE65LSJpsMEQkmef6qUG69W9vdzKpKqUUuR87NL81IijB7cs34aXm8dhlz5fNrIL5gUirjRUkwXCo57h3O9Dr0uMFifEcPDpQQnuibIHPs5IFhUVAZf5F+kzCVh6p9t/El8ghcobiXMHNZRZ2N0uhtPoxofEXgx1FHEZs3njVLJeOBOnTWrV3FmXmuKUtFKEQ2kCVjjsnM7NWAGI7nxhBGd0Z44vDzRQJuq4O305UB5MxKljZXkHb0TeAu4O1jsGnOAS7NoSzhDf736EVg3CzHrzn9Y4wvm3rJ37T4pRMB4dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=14sAvbOOuTyQauAqc8zQlg1bO9cyNbkFDhJHL60o9U0=;
 b=Pt8x/TeYS5CS2ceBGo0Nyfaqs/am2DXq9DO3RymHUPKxjsy2RMgLqbvEoGSvCcCAFwi5M7qCuwFJ4glE9uGbEWFwhkhgTwzGxTbZNHYKvv5vYXT16ndvtL+bLTaf/3jDzO3WNEQNJ3gQe97NBHI+B4q3j9136lqJTsgYozT5ZkE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by KL1PR01MB5156.apcprd01.prod.exchangelabs.com
 (2603:1096:820:d6::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Mon, 16 Oct
 2023 03:39:05 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::3f1:6c0e:dec3:714b]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::3f1:6c0e:dec3:714b%5]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 03:39:05 +0000
From:   Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
Subject: [Patch v2 3/6] tty: serial: 8250: Relocate macros within 8250_pci.c
Date:   Mon, 16 Oct 2023 11:37:02 +0800
Message-Id: <20231016033705.20669-4-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016033705.20669-1-crescentcy.hsieh@moxa.com>
References: <20231016033705.20669-1-crescentcy.hsieh@moxa.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR01CA0015.jpnprd01.prod.outlook.com
 (2603:1096:404:a::27) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|KL1PR01MB5156:EE_
X-MS-Office365-Filtering-Correlation-Id: bc224c28-0308-42a5-1020-08dbcdf971d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fZhqYFJrvSjKdqNOZLiST7zVX8Dg+gi+KOxs79mrJRRbq0lEfOcbKTinbJnDVIuquTRCWmFlb/yKLqzO7Bjz2O8Qr+K11fpTyQBiU3kgxigERFSe2AuinKj2lzDU2llD185aOBz7JrYp0pcmC11lceviiLUA6V8cv6EZ+kCAsEhfqVzdN117T5gkXqsu4hK4Byu8cYHjLbX8hn74tfP8L3jCMa4zQv3R6OGUoyxN7rLV/ern4+G7zieCwJvJnOlW7bIO0R4ZAXNlO1z3suJtplqSx1XCKj7TJxPUt7oG4ocjBInY0JihWDyk+N5sG12sGkTQFEWDBN5wn1viLamr9QiZplOEmc6rTY4VjN0OVXRyy3c7dtplZNSma5d1XYeQdbG949mpfrO/UX669hHwgOy+mNdQmJlrsQE1fR2k1ZSDPyJxjL7wB4vKtgSRmtBvCbIMyLJj+E+cskzMuLoDNUXk6jaMM9KwxA2Xl+dVwocB6qWoFFqnZApFzGOlNe1Pa/L9iCRtQqPAbQEir9g49jygiyWsbqeNWqgHSb9myx+d6ZWcHn/0m3GiqHt6RUXx7BchP7WPPtVHqiDULTvi9vw+XY1wXQ1lc4cJU2+aYjh8lIiIuXkTFHj+JABmhQcX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39850400004)(366004)(376002)(136003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(6506007)(1076003)(26005)(107886003)(2616005)(38100700002)(316002)(52116002)(66946007)(66476007)(66556008)(6486002)(478600001)(6512007)(83380400001)(6666004)(38350700005)(4326008)(8936002)(8676002)(5660300002)(2906002)(41300700001)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0/+bBwQVlxvD3jr6SqVYKEV6BzB3IBCH6VsG0ovNIZFpOCm85ialXkjI/yo1?=
 =?us-ascii?Q?1bstXy8MxDwQckK8+tb3vXYnsKQ1YQ2TADJbdmxgOGXpzYAQQvWu9fpnfEta?=
 =?us-ascii?Q?LCSit7nGVhhfgM5x9wTrQZTDb7AOR4flmcpaYjWxw1WmxK69IRT2VUTJ8lyt?=
 =?us-ascii?Q?FtxpcXcuBTbK2rjCBMBhZ30QrrBphzEkGnRsM+79RQVA4tk5XIdaSt3OK0q0?=
 =?us-ascii?Q?t6gz23srMfTTSyc+bEqhqBbgZW6IJSRwCFeS7H10JYu4Q7vCJvNIAMKi/mSi?=
 =?us-ascii?Q?cfZXDJK0Akv58pymcRk8zSTT+zQxYGJ/NQNAa6NohyTP0Sfl3a37WlhIPTJ4?=
 =?us-ascii?Q?oZp0CGMTdUS6TbUupOVwizt+/RnT7cLNvnSc2ZhHVjbmWZwa2IYHKs3P/Oau?=
 =?us-ascii?Q?5GxdDcP1qxUciAIkMo+FLd8qlq8w94M9CVha1SnGLIEk0lfMQ93DmDLQICba?=
 =?us-ascii?Q?Fq44xRh5dWgqPkmJkouzza9uz3cJkABMoLdyq0ukPxxKPzX/udjG3F/7LCS/?=
 =?us-ascii?Q?LMqqYXpGi3od1SrN3J8/qu46qCI1vjuds1bQ0pmCPGSxulW7UUMgdv/GG+pe?=
 =?us-ascii?Q?NqLbU8LY8v+Z5o2jiXUF/lvuZ4nwqesH18cFf2t3wkN0ahWq9CUt5uPxlcQV?=
 =?us-ascii?Q?JjqGI2ubemxCjbSivEGJSyeJVBZnf9RvD2BVQus6JyW0SgYQlZsk6+g0dzJf?=
 =?us-ascii?Q?/QZfHpPlpvz6RvoSMvnF5V0VCMHYm/lW5CIPjVByE56ItFBuXnwe77yzxkPG?=
 =?us-ascii?Q?PnNBszp8jxYpDpO1E11MN7Xc2iRjooY1MxPKXQ/RSV2Jp+FC35DRxvZXwvp+?=
 =?us-ascii?Q?2P3YYDnE1E1nRZrv7jy7l61ZPWjswtMxPWd5FMeIc835KF3kzQPAIx26ewpf?=
 =?us-ascii?Q?XQKgVk1lX1Ccsz4SaKbMkUixJLtJOL9m0hxZzSzXsHNN9KuVGQbokADnvWIr?=
 =?us-ascii?Q?beELq8ttZ75FKLK7PAKqgT6uNaBT2ydUvRDREVgTkgLjXjITt4/z+T0jwZhU?=
 =?us-ascii?Q?A+Vku9XtVjtO6A2dACsK2e94r42IvuETkrxEN45+KxxBajEpZBrUXmvCp5BU?=
 =?us-ascii?Q?zvTgHMw0PH5yb9QU4A6jzZm0FakCuOxvxp3fG9BvQLTy1UE6nk4YrSSiwO2W?=
 =?us-ascii?Q?xGotl1pp+n7isPrUIt2aCr3OhZdXvFxuElFhFozodgDWdhy6cBHVyNaSauHj?=
 =?us-ascii?Q?xWa7LD4s84CXry8xniJML+LDC04cpvVnOEcijKk8cf+6z/TIcK1WdZ6HCcwX?=
 =?us-ascii?Q?GCa5vOQY+wGwdqwtsvTkgEA7I1/8p7iC2u9uqK4Yc3oQ4Q5fJ9RPFz8tERDV?=
 =?us-ascii?Q?mYYEXud7I22EICaRTltwJSNDsR9Lenk3uoNxwv1AqDpcfm6Pd85gO7fao4KQ?=
 =?us-ascii?Q?Wk3v0c72KhJrfXlGxcW732tcTw2kxacXJoCYvkeKXW2lABJ6p2GITrQUPs/E?=
 =?us-ascii?Q?Pj01MvoBjavXJPhuP8VioegAV/QrO87zi9xNlR8UgPZaS538NJLbV+Wb4m3A?=
 =?us-ascii?Q?gCPJBgDnWylF9wg0fu463IAvvTxdU+cQcUspDBsa3XRIcCJ8+iTc0pCip+Ol?=
 =?us-ascii?Q?p6aTF2hD7k9XKNwj4tmgYdCHdh1KL67Dbg3HAJUcPiRcp8CWF4YbuPQ/b1Mg?=
 =?us-ascii?Q?9w=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc224c28-0308-42a5-1020-08dbcdf971d3
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 03:39:05.1233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gggl2Vu05o00EQ5N2ROzsOqp/tdKzHEDRcvy1ruwP1pku2xsd0LPMYJGfRtumTAETZA77lnQtzvL0p4SWuk2XqJvIl4ME61i1rx+7G3yQG4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR01MB5156
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move PCI_DEVICE_ID macros to the top so that these macros can be used
throughout 8250_pci.c

Signed-off-by: Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_pci.c | 144 ++++++++++++++---------------
 1 file changed, 72 insertions(+), 72 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index fd810a6ee38f..dd48b910bb05 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -26,6 +26,78 @@
 #include "8250.h"
 #include "8250_pcilib.h"
 
+#define PCI_VENDOR_ID_SBSMODULARIO	0x124B
+#define PCI_SUBVENDOR_ID_SBSMODULARIO	0x124B
+#define PCI_DEVICE_ID_OCTPRO		0x0001
+#define PCI_SUBDEVICE_ID_OCTPRO232	0x0108
+#define PCI_SUBDEVICE_ID_OCTPRO422	0x0208
+#define PCI_SUBDEVICE_ID_POCTAL232	0x0308
+#define PCI_SUBDEVICE_ID_POCTAL422	0x0408
+#define PCI_SUBDEVICE_ID_SIIG_DUAL_00	0x2500
+#define PCI_SUBDEVICE_ID_SIIG_DUAL_30	0x2530
+#define PCI_VENDOR_ID_ADVANTECH		0x13fe
+#define PCI_DEVICE_ID_INTEL_CE4100_UART 0x2e66
+#define PCI_DEVICE_ID_ADVANTECH_PCI1600	0x1600
+#define PCI_DEVICE_ID_ADVANTECH_PCI1600_1611	0x1611
+#define PCI_DEVICE_ID_ADVANTECH_PCI3620	0x3620
+#define PCI_DEVICE_ID_ADVANTECH_PCI3618	0x3618
+#define PCI_DEVICE_ID_ADVANTECH_PCIf618	0xf618
+#define PCI_DEVICE_ID_TITAN_200I	0x8028
+#define PCI_DEVICE_ID_TITAN_400I	0x8048
+#define PCI_DEVICE_ID_TITAN_800I	0x8088
+#define PCI_DEVICE_ID_TITAN_800EH	0xA007
+#define PCI_DEVICE_ID_TITAN_800EHB	0xA008
+#define PCI_DEVICE_ID_TITAN_400EH	0xA009
+#define PCI_DEVICE_ID_TITAN_100E	0xA010
+#define PCI_DEVICE_ID_TITAN_200E	0xA012
+#define PCI_DEVICE_ID_TITAN_400E	0xA013
+#define PCI_DEVICE_ID_TITAN_800E	0xA014
+#define PCI_DEVICE_ID_TITAN_200EI	0xA016
+#define PCI_DEVICE_ID_TITAN_200EISI	0xA017
+#define PCI_DEVICE_ID_TITAN_200V3	0xA306
+#define PCI_DEVICE_ID_TITAN_400V3	0xA310
+#define PCI_DEVICE_ID_TITAN_410V3	0xA312
+#define PCI_DEVICE_ID_TITAN_800V3	0xA314
+#define PCI_DEVICE_ID_TITAN_800V3B	0xA315
+#define PCI_DEVICE_ID_OXSEMI_16PCI958	0x9538
+#define PCIE_DEVICE_ID_NEO_2_OX_IBM	0x00F6
+#define PCI_DEVICE_ID_PLX_CRONYX_OMEGA	0xc001
+#define PCI_DEVICE_ID_INTEL_PATSBURG_KT 0x1d3d
+#define PCI_VENDOR_ID_WCH		0x4348
+#define PCI_DEVICE_ID_WCH_CH352_2S	0x3253
+#define PCI_DEVICE_ID_WCH_CH353_4S	0x3453
+#define PCI_DEVICE_ID_WCH_CH353_2S1PF	0x5046
+#define PCI_DEVICE_ID_WCH_CH353_1S1P	0x5053
+#define PCI_DEVICE_ID_WCH_CH353_2S1P	0x7053
+#define PCI_DEVICE_ID_WCH_CH355_4S	0x7173
+#define PCI_VENDOR_ID_AGESTAR		0x5372
+#define PCI_DEVICE_ID_AGESTAR_9375	0x6872
+#define PCI_DEVICE_ID_BROADCOM_TRUMANAGE 0x160a
+#define PCI_DEVICE_ID_AMCC_ADDIDATA_APCI7800 0x818e
+
+#define PCIE_VENDOR_ID_WCH		0x1c00
+#define PCIE_DEVICE_ID_WCH_CH382_2S1P	0x3250
+#define PCIE_DEVICE_ID_WCH_CH384_4S	0x3470
+#define PCIE_DEVICE_ID_WCH_CH384_8S	0x3853
+#define PCIE_DEVICE_ID_WCH_CH382_2S	0x3253
+
+#define PCI_DEVICE_ID_MOXA_CP102E	0x1024
+#define PCI_DEVICE_ID_MOXA_CP102EL	0x1025
+#define PCI_DEVICE_ID_MOXA_CP104EL_A	0x1045
+#define PCI_DEVICE_ID_MOXA_CP114EL	0x1144
+#define PCI_DEVICE_ID_MOXA_CP116E_A_A	0x1160
+#define PCI_DEVICE_ID_MOXA_CP116E_A_B	0x1161
+#define PCI_DEVICE_ID_MOXA_CP118EL_A	0x1182
+#define PCI_DEVICE_ID_MOXA_CP118E_A_I	0x1183
+#define PCI_DEVICE_ID_MOXA_CP132EL	0x1322
+#define PCI_DEVICE_ID_MOXA_CP134EL_A	0x1342
+#define PCI_DEVICE_ID_MOXA_CP138E_A	0x1381
+#define PCI_DEVICE_ID_MOXA_CP168EL_A	0x1683
+
+/* Unknown vendors/cards - this should not be in linux/pci_ids.h */
+#define PCI_SUBDEVICE_ID_UNKNOWN_0x1584	0x1584
+#define PCI_SUBDEVICE_ID_UNKNOWN_0x1588	0x1588
+
 /*
  * init function returns:
  *  > 0 - number of ports
@@ -1903,78 +1975,6 @@ pci_moxa_setup(struct serial_private *priv,
 	return setup_port(priv, port, bar, offset, 0);
 }
 
-#define PCI_VENDOR_ID_SBSMODULARIO	0x124B
-#define PCI_SUBVENDOR_ID_SBSMODULARIO	0x124B
-#define PCI_DEVICE_ID_OCTPRO		0x0001
-#define PCI_SUBDEVICE_ID_OCTPRO232	0x0108
-#define PCI_SUBDEVICE_ID_OCTPRO422	0x0208
-#define PCI_SUBDEVICE_ID_POCTAL232	0x0308
-#define PCI_SUBDEVICE_ID_POCTAL422	0x0408
-#define PCI_SUBDEVICE_ID_SIIG_DUAL_00	0x2500
-#define PCI_SUBDEVICE_ID_SIIG_DUAL_30	0x2530
-#define PCI_VENDOR_ID_ADVANTECH		0x13fe
-#define PCI_DEVICE_ID_INTEL_CE4100_UART 0x2e66
-#define PCI_DEVICE_ID_ADVANTECH_PCI1600	0x1600
-#define PCI_DEVICE_ID_ADVANTECH_PCI1600_1611	0x1611
-#define PCI_DEVICE_ID_ADVANTECH_PCI3620	0x3620
-#define PCI_DEVICE_ID_ADVANTECH_PCI3618	0x3618
-#define PCI_DEVICE_ID_ADVANTECH_PCIf618	0xf618
-#define PCI_DEVICE_ID_TITAN_200I	0x8028
-#define PCI_DEVICE_ID_TITAN_400I	0x8048
-#define PCI_DEVICE_ID_TITAN_800I	0x8088
-#define PCI_DEVICE_ID_TITAN_800EH	0xA007
-#define PCI_DEVICE_ID_TITAN_800EHB	0xA008
-#define PCI_DEVICE_ID_TITAN_400EH	0xA009
-#define PCI_DEVICE_ID_TITAN_100E	0xA010
-#define PCI_DEVICE_ID_TITAN_200E	0xA012
-#define PCI_DEVICE_ID_TITAN_400E	0xA013
-#define PCI_DEVICE_ID_TITAN_800E	0xA014
-#define PCI_DEVICE_ID_TITAN_200EI	0xA016
-#define PCI_DEVICE_ID_TITAN_200EISI	0xA017
-#define PCI_DEVICE_ID_TITAN_200V3	0xA306
-#define PCI_DEVICE_ID_TITAN_400V3	0xA310
-#define PCI_DEVICE_ID_TITAN_410V3	0xA312
-#define PCI_DEVICE_ID_TITAN_800V3	0xA314
-#define PCI_DEVICE_ID_TITAN_800V3B	0xA315
-#define PCI_DEVICE_ID_OXSEMI_16PCI958	0x9538
-#define PCIE_DEVICE_ID_NEO_2_OX_IBM	0x00F6
-#define PCI_DEVICE_ID_PLX_CRONYX_OMEGA	0xc001
-#define PCI_DEVICE_ID_INTEL_PATSBURG_KT 0x1d3d
-#define PCI_VENDOR_ID_WCH		0x4348
-#define PCI_DEVICE_ID_WCH_CH352_2S	0x3253
-#define PCI_DEVICE_ID_WCH_CH353_4S	0x3453
-#define PCI_DEVICE_ID_WCH_CH353_2S1PF	0x5046
-#define PCI_DEVICE_ID_WCH_CH353_1S1P	0x5053
-#define PCI_DEVICE_ID_WCH_CH353_2S1P	0x7053
-#define PCI_DEVICE_ID_WCH_CH355_4S	0x7173
-#define PCI_VENDOR_ID_AGESTAR		0x5372
-#define PCI_DEVICE_ID_AGESTAR_9375	0x6872
-#define PCI_DEVICE_ID_BROADCOM_TRUMANAGE 0x160a
-#define PCI_DEVICE_ID_AMCC_ADDIDATA_APCI7800 0x818e
-
-#define PCIE_VENDOR_ID_WCH		0x1c00
-#define PCIE_DEVICE_ID_WCH_CH382_2S1P	0x3250
-#define PCIE_DEVICE_ID_WCH_CH384_4S	0x3470
-#define PCIE_DEVICE_ID_WCH_CH384_8S	0x3853
-#define PCIE_DEVICE_ID_WCH_CH382_2S	0x3253
-
-#define	PCI_DEVICE_ID_MOXA_CP102E	0x1024
-#define	PCI_DEVICE_ID_MOXA_CP102EL	0x1025
-#define	PCI_DEVICE_ID_MOXA_CP104EL_A	0x1045
-#define	PCI_DEVICE_ID_MOXA_CP114EL	0x1144
-#define	PCI_DEVICE_ID_MOXA_CP116E_A_A	0x1160
-#define	PCI_DEVICE_ID_MOXA_CP116E_A_B	0x1161
-#define	PCI_DEVICE_ID_MOXA_CP118EL_A	0x1182
-#define	PCI_DEVICE_ID_MOXA_CP118E_A_I	0x1183
-#define	PCI_DEVICE_ID_MOXA_CP132EL	0x1322
-#define	PCI_DEVICE_ID_MOXA_CP134EL_A	0x1342
-#define	PCI_DEVICE_ID_MOXA_CP138E_A	0x1381
-#define	PCI_DEVICE_ID_MOXA_CP168EL_A	0x1683
-
-/* Unknown vendors/cards - this should not be in linux/pci_ids.h */
-#define PCI_SUBDEVICE_ID_UNKNOWN_0x1584	0x1584
-#define PCI_SUBDEVICE_ID_UNKNOWN_0x1588	0x1588
-
 /*
  * Master list of serial port init/setup/exit quirks.
  * This does not describe the general nature of the port.
-- 
2.34.1

