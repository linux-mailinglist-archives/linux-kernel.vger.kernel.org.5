Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8C37D138B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 18:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377902AbjJTQFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 12:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377860AbjJTQE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 12:04:56 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04olkn2036.outbound.protection.outlook.com [40.92.73.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6DDD4C;
        Fri, 20 Oct 2023 09:04:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y8JIz06ePK/Van9kaG3bakGBw6D+8EMRsBRGJMqIY8rDXZG/KqyjZ+Hpn/zM1+hPlhdyxFRK8urbJRni++lldWgDLl24TWyaaSTNtXEaoBw4yDpcV5YEc2gCrOMQ2OVKPmCPs8hWc829miUscuuU68MQMBzz/vKBZVut4Fwwy9UbVR+tpasa//87b9p3BcljMR0+b5HQm0t8MlE/4keQCnYr2eISePUBzqForNX5+GZUoYIZv8hf0LXv6m5D8ngYSGJJwkm19iZ50YKObBgxNcNpQi3QgciB0DuUQuBtfc45dvw5XgPjPuK8PaJZCHvkU8FgM0lmykOP40vmWOsMFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZZ7LzYawi1BjZNDRWoZEgW9zBmP8vBiaG+P8yaIcFPE=;
 b=kU0rbrQq1g320jkx0J62DRcxmy2J8h6Q9jo3fWJy+0siVP53a10CNI5p9+k/dsP8H/+myqneybPqz+juTI6sK8y+lb2CLU+xHM+S+x4IpX+E3J0W5tp3qNx+xcbx1R1TZPZmflr3GqcZk9D3pWUSuCf7wgfMUoSmsSoqDUD432emAutS2Tiamcl2jyTjh459SVjYGpnVyMIO+d9oyuGSxHLn5UVwp1kzaInVRp3XcVbNaOGuAIoyr90PPwEak0XKyXkUYMtA72KhZVRVAvRFh8N+91q+lDn0HP62vHhNEyvIsQ47qOIyFSb0WOcC1JlZ5oBzlakeeaZegf5vnV569w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com (2603:10a6:10:347::11)
 by AM9PR02MB6930.eurprd02.prod.outlook.com (2603:10a6:20b:26d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 16:04:51 +0000
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::b753:178a:394e:af8e]) by DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::b753:178a:394e:af8e%7]) with mapi id 15.20.6886.034; Fri, 20 Oct 2023
 16:04:51 +0000
From:   Cameron Williams <cang1@live.co.uk>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Cameron Williams <cang1@live.co.uk>, stable@vger.kernel.org
Subject: [PATCH v4 02/11] tty: 8250: Remove UC-257 and UC-431
Date:   Fri, 20 Oct 2023 17:03:08 +0100
Message-ID: <DU0PR02MB78995ADF7394C74AD4CF3357C4DBA@DU0PR02MB7899.eurprd02.prod.outlook.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231020160412.118550-1-cang1@live.co.uk>
References: <BBPatchesV4>
 <20231020160412.118550-1-cang1@live.co.uk>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TMN:  [X4O2jWJw2xv5EjEGXMEHhEj1PxTXw+VT]
X-ClientProxiedBy: LO0P265CA0011.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::19) To DU0PR02MB7899.eurprd02.prod.outlook.com
 (2603:10a6:10:347::11)
X-Microsoft-Original-Message-ID: <20231020160412.118550-3-cang1@live.co.uk>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB7899:EE_|AM9PR02MB6930:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a734468-64fd-4a5e-c1bd-08dbd1864aeb
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bqOHvWHJpVCYTJV4rXZDVXKgxNaiGxzZ05GfJrF0f5Ol48ymIapBlbVEpY4wy45sowUyhgDEhEzTsa4uw4UdgcNMMdV+2bvYsmr608StWRVOM5SvMVYOWLTRfG+RKhFULiWvavPOy1ussh8HuOPw9aBC/svmIyptE5ULtXfHO0Oi69n9QxDsA9eZHDN2RPBbl5XcjNH82/4PtxMqv/GKGyXTgIflniKx0Yo8MzLFEzs7O6UKF1j1EAH2L0gSudejmn8QAXHM6kvO/Rc46LGldI4CoJPrn+KgDQndInbDUftTpooaIwCGGim1uyIb0tzt0/BPtPVbZothxbTGS96UWiXZbx8ixSbRBOwv36VFQtYPsy73i+eAa92wnZTV68pyW5FBR6J7S5NeKojlj9HH+kKJcL6IIiJlhWC/bedd8GF7Z39gEvsShKXhNSEftVHi3WduOZNY3+aaVFpQXlTrp6Sbpgf9KwGrPAe5us40+iDXPhkenrQOYabs0cpHXhQqb4fSHyLF5+GxJDbFKKOvLR66QyKjNpvVdtWRC9aZBc7/3nr4vArgOt3J64ESqEkcvW63tRgqG8Ej7mCoshZ32h0gf7Qwq8BVHNqA89YP6OMQ4/T11lMe8zoK0Zbxmkr5G/t4I4cvc9L9zxqHS7RMGw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ybyRhqy0OoQ6VssDGzreVOQIddPLtKGTejY+D5YWrPC97dtXei60+sqMYYuz?=
 =?us-ascii?Q?JpccBRPmzPnZ49j1QPYb2YKFDgDDefT0AWs5xORKJmXbU/RxS0F7aHW13D43?=
 =?us-ascii?Q?3bIqQ61+8fF5x4QvKz4iZwRdFBpfi5XFshs5MWc0nrb6E6Z5lBokalgdQX5Y?=
 =?us-ascii?Q?icSuGzsxSuXSc/+p3w0wcSrxxfgMW1w+IICYi0lCipKAEJAuW7hpy0t1s6JL?=
 =?us-ascii?Q?G2Y3XeZbkBOvkIRGNgi3Kz1PTwenPSu+C8hCuTf8zKeiehPaVxLrkTI9e2Zx?=
 =?us-ascii?Q?U8l8JKgXBsluOa+FPUGkNftjUWbvK1y8GskeYt+keFCR0JMdUeDs6Xz8IFtY?=
 =?us-ascii?Q?BMTVAR0lAzznB5khg2fKh72bANiJKx9lwwyP2dqEdSbPJk9PdTwhf6bbfpQW?=
 =?us-ascii?Q?X2pq8mFwB/XGFUUewnjly3evg25UGCTr45R8WWT/NW2VAQO50BohgKWmyCPV?=
 =?us-ascii?Q?PdXM8GztKhiRizoho6W1puQcOkDm3PiLhNnjaEwlwzCRqsNTS0FvCeW4LNxu?=
 =?us-ascii?Q?8eeDj275bGiMMTafNfzneEx/fpVT+uOx9y9shLjla1tGYOlpdI7JZSbABwx9?=
 =?us-ascii?Q?ThIo7JFZIzK8NxmzLQsndYnQepa0oOKJdxQbBzZNBH1+4nKhE5ngxyci2/H/?=
 =?us-ascii?Q?+8rPyJyRhIpfd6Jmlh1YhzHP+n+FrrIkZly8ydKAdRSgOfZphCpfO3V8VTfn?=
 =?us-ascii?Q?PPZu/5fTxI98IErQrK4vohwvTSDPWrtzB6zvPCmcfyQd13slac35ulcIgM6u?=
 =?us-ascii?Q?yo//awW23CuXITBATkl8qv+WdeKBBQCncWiofRCSry+sxnm/AJs44dUU62aW?=
 =?us-ascii?Q?aUfe9BWqAeQRxl2pkr3QnvIyL0Rw3DQZmiTWopfpJwvVM+UuF7rPVZNHUjXD?=
 =?us-ascii?Q?O2I8EpismJYvbtS8QhJDbSS/75uYMFo1tfUfq3/aqBQ9p1dM/WzFBEVjU9YX?=
 =?us-ascii?Q?LVS/E5DMWKdHPwlk6Hwp2fYKc9T6oQ5nr+DWMzOJGFTxxgH3oUtPMmd6Pbmt?=
 =?us-ascii?Q?GD9EpyylugEnzQUbTBDhrXpKQtGBWA1rCm1Dsfh1l2iP9OSpKxyApz8iQuX1?=
 =?us-ascii?Q?hlmC4047wWfpuuIWsxz+QbOQH2LaF0oyfc8SC9fbXatwkiQjqeGe+MbIw1kJ?=
 =?us-ascii?Q?tFJe/MDIlXPdigecqj7YAwbPEvKHUJL63KVqHAcsIv2/pBvBDW+1GD5r9WBB?=
 =?us-ascii?Q?uZlSNFNGFHmelAXiWOx/bejqFFvOlDwDq4k7Ng=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-ab7de.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a734468-64fd-4a5e-c1bd-08dbd1864aeb
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB7899.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 16:04:51.8816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR02MB6930
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UC-257 is a serial + LPT card, so remove it from this driver.
A patch has been submitted to add it to parport_serial instead.

Additionaly, the UC-431 does not use this card ID, only the UC-420
does. The 431 is a 3-port card and there is no generic 3-port configuration
available, so remove reference to it from this driver.

Fixes: 152d1afa834c ("tty: Add support for Brainboxes UC cards.")
Cc: stable@vger.kernel.org
Signed-off-by: Cameron Williams <cang1@live.co.uk>
---
With regards to the parport_serial patch, I mistakenly did not copy in
the LKML, only the maintainer, so I have no link to the patch, my mistake
and apologies.

v3 - v4:
Split patch v3 part 2 into Fixes and Additions
Add Fixes: and Cc: tag.

v2 - v3:
Re-submit patch series using git send-email to make threading work.

v1 - v2:
This is a resubmission series for the patch series below. That series
was lots of changes sent to lots of maintainers, this series is just for
the tty/serial/8250 subsystem.

[1] https://lore.kernel.org/all/DU0PR02MB789950E64D808DB57E9D7312C4F8A@DU0PR02MB7899.eurprd02.prod.outlook.com/
[2] https://lore.kernel.org/all/DU0PR02MB7899DE53DFC900EFB50E53F2C4F8A@DU0PR02MB7899.eurprd02.prod.outlook.com/
[3] https://lore.kernel.org/all/DU0PR02MB7899033E7E81EAF3694BC20AC4F8A@DU0PR02MB7899.eurprd02.prod.outlook.com/
[4] https://lore.kernel.org/all/DU0PR02MB7899EABA8C3DCAC94DCC79D4C4F8A@DU0PR02MB7899.eurprd02.prod.outlook.com/

 drivers/tty/serial/8250/8250_pci.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index ecb4e9acc70d..a59b9b8eaa68 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -4940,13 +4940,6 @@ static const struct pci_device_id serial_pci_tbl[] = {
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
 		pbn_b2_1_115200 },
-	/*
-	 * Brainboxes UC-257
-	 */
-	{	PCI_VENDOR_ID_INTASHIELD, 0x0861,
-		PCI_ANY_ID, PCI_ANY_ID,
-		0, 0,
-		pbn_b2_2_115200 },
 	/*
 	 * Brainboxes UC-260/271/701/756
 	 */
@@ -5026,7 +5019,7 @@ static const struct pci_device_id serial_pci_tbl[] = {
 		0, 0,
 		pbn_b2_4_115200 },
 	/*
-	 * Brainboxes UC-420/431
+	 * Brainboxes UC-420
 	 */
 	{       PCI_VENDOR_ID_INTASHIELD, 0x0921,
 		PCI_ANY_ID, PCI_ANY_ID,
-- 
2.42.0

