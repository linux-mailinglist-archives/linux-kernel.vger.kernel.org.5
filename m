Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAC637CD7C6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 11:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjJRJVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 05:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjJRJUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 05:20:54 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2063.outbound.protection.outlook.com [40.107.255.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C33111;
        Wed, 18 Oct 2023 02:20:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b58SnlsDoB5vA2qagh13XTmj/uivpR6WHdPTRlT7Mo4LMdn1RGrGRIVFjXZmjO+hTcOl/6ec1Iu8L8sSGKddpEZ45Id7dHfGKnLUgf01AUyvZrUWNgal2tioQr8oi7vwNdqvviC652lDAQRBbXnbK7i2eabXUEOUBPe/pgEZDkhKoVfAUkyvLtQ/shb+D/uArndQuGi3Opop4gRuCzBhupJ9x4zwNE3QITA7Z06Oea+P4NlaT00wNIQ0Upiqod8doL+I5xF53MR3fwvlTZ8MqXrDnVP4bJLGfPWKtyboDYpeK18dtgKInbZIUv8zTpBIsZOyRnj1L08O4EpnsQ6kDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8TzAELGZcODFJp6UV+i3C2ZKh786FZQxrvBiAqGP6HU=;
 b=f5eLhJeeUt+BfGciePJXG5UjDHBnggVTu6d7acZ50h7V9lSorQnkIikIrOrW/rS1C2Sh9rN5UcdbUWlDgQ3sbIk8WMqgGeYkBqs0xkgiw5AF+7kC/pf6krvnvPeiqYX4cTdaUMBFg3cUqKIrgrpNSaWpPu0b4/KVWZrkrgqaO+sU/ilthRJVmW0lA1HOaptQ+5aO4cUa7fTIx+MXoOx2lC0CmwFzCgS/52E+JkjHCA1fZTRdDleiH4JfZoj5g9L43zvzw3w5BESQfJ6ehWLzWSiwuADS/y+RL4ZbcPGm5q3AhHau6A5EGiABj/bmGKSj1D0CuKfA4pQv4abH78BTmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8TzAELGZcODFJp6UV+i3C2ZKh786FZQxrvBiAqGP6HU=;
 b=SX4GdWDSI4me3a3lmMeMkU46KR4VdGZNR6BFysFrlP2rjKe/KXct4KBBgh2Oq01YH9h88QbrG4M9HQPDu898hYA39QlqCJBFSaLNNHdzUYgwLqIdgcmskCiGr8TSisBuUATeWYTYfKvrHz25BKMjXfrnVu+mqvwkjjVyDKjvwQM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by SEZPR01MB4134.apcprd01.prod.exchangelabs.com
 (2603:1096:101:46::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Wed, 18 Oct
 2023 09:20:41 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::3f1:6c0e:dec3:714b]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::3f1:6c0e:dec3:714b%5]) with mapi id 15.20.6886.034; Wed, 18 Oct 2023
 09:20:41 +0000
From:   Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
Subject: [PATCH v3 3/6] tty: serial: 8250: Relocate macros within 8250_pci.c
Date:   Wed, 18 Oct 2023 17:17:36 +0800
Message-Id: <20231018091739.10125-4-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018091739.10125-1-crescentcy.hsieh@moxa.com>
References: <20231018091739.10125-1-crescentcy.hsieh@moxa.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0015.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::19) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|SEZPR01MB4134:EE_
X-MS-Office365-Filtering-Correlation-Id: 877cc86a-ee95-4486-d5ea-08dbcfbb7fbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aV8JeNqComBQkYLjejEGBvtzyH8MAOOZrUPv34i5rq77pGahk0J3tcUQQpqEucXXricoTOvQrtXT29WPV7y4TfakVJQn4FHcdWt9f3BfLDjJ5Aqfp7PWyzdZOO8U3tbVp6W+eptioDz5hCG5uXezOrYi2fnJVpqrANHAW8EHUgymSH3lIui3HvwTCpqHzzWMk6O3u+MvH+kIzkCxkSI1KSjV/liXDX5ikrdV055GMUZby5liUACF9NNJpEEg9CTxNrAwb4D8fovooo0LRctpV+H1Im4CdMfexBadPIoh9ZXKFKICh/BPu61WERO6JK5AGc0bEY3Ov17UVT4gDjGZTnHkHHRxcP95j6MWmpWfyA7c6TH7IPbJQ94D+sN32+CrSvQoghIIDIqc+agLCy4JxrgJ9Dh+EyX0tFeC/aMDzzoLHLAXZmrzLJJl7WEoPvBaeOWNm7TNZn5dYjE7ot13DtUJQVud5TfcUjBZRDhOpvIJWzJMMRkF19bIDqhI/9QfqByBrdTHjEM5p+auk7hourI+Sczg99KxRHqNE/2qIhZWRVvTafBlQ09HPG5touaHp8zTjLvuG7V/B3JHoxAACLluu/3k0wmz+NfM5korAfE5JiDQdiOVTzR7WdZZzXhg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(136003)(376002)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(107886003)(38350700005)(6666004)(6506007)(52116002)(6512007)(6486002)(508600001)(66476007)(110136005)(316002)(26005)(36756003)(83380400001)(1076003)(66556008)(66946007)(2616005)(41300700001)(38100700002)(5660300002)(8936002)(4326008)(8676002)(2906002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?won8fXDPl4M86WYDAiGv9aEjdxxtCDIZc4bsoQ+tD/cJhkTpnvFD5o9SMoEH?=
 =?us-ascii?Q?7mDfo2TTtuEpYvizfxETQ0NZDvTAHiMuLhbn5s1sGHza3VYhfWdqfDmgsamz?=
 =?us-ascii?Q?XmuEGZKXWVYJEJVSdUvWyvKyEolrUGe701FCnmF3otPCigROPTcrCtG3N2V4?=
 =?us-ascii?Q?u/VXsLZNWnMb5SLZr10oJqE5KIYj80dHqTgEbjtDVoHHSdyP5Xw6DDkqhiT6?=
 =?us-ascii?Q?A5w/nGtCWEuf6ku/mUC71oTPa/RbpIsm4PMWCJEGXYGei1eN+GkdlOY4sdI3?=
 =?us-ascii?Q?DihrAf1kcAWaMCi0RYM5Fw9/qMrmG4Vi1Lm27+YIm5GdKanXizd8mpCM5f09?=
 =?us-ascii?Q?VP7fmTpnhKZlUZUsbvVDt5N1FvKrXmkPCxhwo07B2GlOho7AUBEDqsAHnofm?=
 =?us-ascii?Q?fcvoHK/0x6R161Xw6XbrVz7pvZexiGoxbhwjczuiY5hJtVU1vFAMvvUoRxos?=
 =?us-ascii?Q?i5DGlpPA1MEGLP7NnAudmiXXPuik/hNZxQqBcGxm4N4e74lPUV2f01xVoukZ?=
 =?us-ascii?Q?2E4rCKEONhHWjPmJBfNXoNrHejiL/oO3iL+Sko6rXz/SMW4nVyFEEerW+iFB?=
 =?us-ascii?Q?1WYd8wpp6fshCu88w9488IhRQvfzyMEH/p1jVumwAGMsmoixlfd1ovc8dDzc?=
 =?us-ascii?Q?V01Wp4bCSqu8GKwVa6m2wkwV1yMRvL3GraB/WcvclBJcpBRfMp59wVokun3z?=
 =?us-ascii?Q?jzJHaWxOL/Wbpqkg2HoMfRL5WWH766tqTIH5V9qPFiWC0JUdWOOJXjg4dxD+?=
 =?us-ascii?Q?3hwWN2VVzPxOxu+UtN7F5xO3nMXivpyT4D+csxSvqNRC2lqhP9DeotIZc8JZ?=
 =?us-ascii?Q?Rvcet8oYs2Kh74EbJ7tuOI5jg1MToITkktXa5bVIvBWVXCRQwiG4hodHRZiO?=
 =?us-ascii?Q?veq6dgHxtJu8BD4hkORuY770P7v6OhTa5unWwqDq9IBOLrVzM8GZlWglH2Qf?=
 =?us-ascii?Q?KXPLJnDWtG8SNBC78CdENAr5JUxKzT1D0sljZYJVefCuK+pdLVFvIG16bTEk?=
 =?us-ascii?Q?/2O8SrhzBRO94JIWl74EupEOIby1ZliqSrVjOI1n23ZRn+/WdWAc9Exmg/Hs?=
 =?us-ascii?Q?/bWHIwpKpP8Ly24XGwMZwoHXvliU/nhk7MYT6MktyWHVEgkIem5lg8B+FaC2?=
 =?us-ascii?Q?CU+7ahYLlEr4SGR5Ert1/62G6SEBEaeneeZfo8t2qTu1fkYa7OSU0a6OOMlm?=
 =?us-ascii?Q?2dcoZooHhIOtAVj1KNLUOZb4YEX5qvEPY46GhkXigBMspCOoqH42PpuNEmag?=
 =?us-ascii?Q?Ubr3RTv8+xtf6phwrytwe/GitmAWWCxQoHrm2b+2j3LwqU50mFTs9ydtHd/U?=
 =?us-ascii?Q?VtVbqtHL6LV5FhtThMYRkOHQoM2y8myG+4GxQopzzPiwHFr/d9ZEuuoSsdl+?=
 =?us-ascii?Q?VETMYPDw218d/8YvGoFSgYm0ASQWJVVOSrTzYFTuND5AcpCoIzF4ZuzOXZpR?=
 =?us-ascii?Q?wzzxMYhxVOtkF0Mqy6EF0kSTJFiJqMJjL9p4ZGk7mDwQEyhVsREbmTePLU0e?=
 =?us-ascii?Q?Yyt1gdcjp5dbBHgbR6uKTVcPpt4yUlI0ucHZ/VC1IvEZEwePiRP4YfXUKFoy?=
 =?us-ascii?Q?s2I8zdUGKqZhrj9hLWKX6WUGUbR2l2XncDRqr1ZXo+XKfM+KDEKVCA019Vhx?=
 =?us-ascii?Q?Og=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 877cc86a-ee95-4486-d5ea-08dbcfbb7fbd
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 09:20:41.3545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ANos1YSXali1QFLv6WrZ+hhKXohu9yYaib2qKXr9tGtFSm6uOuaZW6d2c6a6ROqD58cbeb0d8YOR+hBhKzOfR04A5SRKWDcISJlx3H+uy2k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB4134
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move PCI_DEVICE_ID macros to the top so that these macros can be used
throughout 8250_pci.c

Signed-off-by: Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
---
 drivers/tty/serial/8250/8250_pci.c | 144 ++++++++++++++---------------
 1 file changed, 72 insertions(+), 72 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 14e2e3433..ef23f1c6d 100644
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
@@ -1901,78 +1973,6 @@ pci_moxa_setup(struct serial_private *priv,
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

