Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB7B7C9A40
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 19:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbjJORNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 13:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbjJORMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 13:12:35 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01olkn2014.outbound.protection.outlook.com [40.92.65.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39664116;
        Sun, 15 Oct 2023 10:12:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QyBnjNiC1CZO/QOjCg7VmAOpuTuyVGtbs8mKzm1UyTdS8lEBh5rzr1svKqNU6q+zaHIR17QNU4k1gFL1SEkM5KVKsuy+eLnbIBXZM18bSRmFE1qswNBrSg0z9sbsns0oxfDi1xiWN8ebewjNbFNMKO5hX/dj9IuNl5tsJx+eYfkQ7GErfQXeQVniu4CWYST9qPr+6Pt8FSNexpGOhRdQWEORBM6iRfqYJtkGIALzwYHJ/dEhsVBJciyvP1wh7SeVuiFy/1qWV9Igm8n7BFRN6mEg5t/MM26H3Z0L1HeZO3dvotctlRABHNnq7KGaBPhXMbazUhU0TWT7QeKjXFxYOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Jv045tXMbphD4fy29eGMMI0gvuPje4eD7NGbIYhyBA=;
 b=dYh2Q5D2hmEkcW7O3emUFsDW70GyfLZjaEwjQ8DWoG96lwvtLD9PJBQ/FyalUBIboCRjsNIRzw5Def56b9AYZXYTznEaXPQJIzUGFKWXLlfcFphljWRpVWFfHjbEyHv6ZQfLx77YRcUE55h72VzpCT73u6aodiBSp0uQp3FZKu1yiGYRaqspOgfJIOjWZwdbuwg+NN6Yz7QYAuH2roTharXE2CqF76wd2d3GRIeqJQuwbe6UNuoIOafwNgzpZv0dOqYfjje7/leVrO0T1d/K7QS8DpMb6qtVcVwvfhAfmxCDmcLRmhvRO5RgpIexGHzbTGO7uXIQjSuvERaLDlEtFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com (2603:10a6:10:347::11)
 by VI1PR02MB6093.eurprd02.prod.outlook.com (2603:10a6:800:18b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Sun, 15 Oct
 2023 17:12:26 +0000
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::b753:178a:394e:af8e]) by DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::b753:178a:394e:af8e%7]) with mapi id 15.20.6886.034; Sun, 15 Oct 2023
 17:12:26 +0000
From:   Cameron Williams <cang1@live.co.uk>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Cameron Williams <cang1@live.co.uk>
Subject: [PATCH v3 7/7] tty: 8250: Add Brainboxes Oxford Semiconductor-based quirks
Date:   Sun, 15 Oct 2023 18:10:22 +0100
Message-ID: <DU0PR02MB78998961117757F4750A3AFFC4D0A@DU0PR02MB7899.eurprd02.prod.outlook.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231015171141.3309-1-cang1@live.co.uk>
References: <BBPatchesV3>
 <20231015171141.3309-1-cang1@live.co.uk>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TMN:  [NUy5mmo+IygKYg1HKy8FMUKL891YccSB]
X-ClientProxiedBy: LO4P123CA0066.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::17) To DU0PR02MB7899.eurprd02.prod.outlook.com
 (2603:10a6:10:347::11)
X-Microsoft-Original-Message-ID: <20231015171141.3309-8-cang1@live.co.uk>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB7899:EE_|VI1PR02MB6093:EE_
X-MS-Office365-Filtering-Correlation-Id: 758b9260-c6fe-49fc-d3d7-08dbcda1e7aa
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0vvKqtioe42vtuA2uMg0Vh0A/LelNScSw3YlcwWwsk54NZOdDmlmyazMoTFMnyP2kI5uJIj6Uf50DidYu/boTxGr3s6h6LQbTqDg1QQiMQZ91HHyDK4XCEeFXooGtNmicq9cUvT7C9jl9Mv0FJfI8w8rmFQ7/EBYnpVPuhyDAX9DWVu59bZKN5xc2/pd//QkZE4p4/FfpPkA18ndsuwYYRqmqrCH0cuuS1fx0v7J+nh+R8TY4UiCplPM587+/Cu9vvTOdABWI8H0LXmThHU8ZbJcvLbmiHssbGYUaMgCGqN+pP51llVN6srP2yklcxGMfWHliJ9l9JynyjXbHwEDRHKgtf2MdUkq0z7QYDSinX7nrQ7B4mPHdCoutSsj03lK/f/YOWV7FJOMExe2sTa8MU97iJ9r2XgdZ/wFOcMgd2VdO25J79uF/BVEXek4AGHKpcEMKQ3RQTjAlpjrQt6s8MRUuNnLh4igYoKWqzvyb7sKvGBRWAJGMV7VcJv7iNGkj/T+ZXh1kTcMEte0547VhLV01uuuj2Bo70eKoRt9jjFHubB0sVLiGQc9xoUBW61T9oELZ2EwZ1d1Ko4fxBtoxa1FYOYs7RlJvBY1nr+TTctCX2gB0mMPEN1lNTcq2h55vr//gBapGuyOgNQI+FIDuw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?du6uhUED2Jy81OlL6ToiLp1XzRGAPfBoXe0RsnXNidubzVaqy/S9TqHRsj/G?=
 =?us-ascii?Q?OBT3f/LkJpZ3RCftX8UPAmHDnyuQIW7IB65ZB7UX4qLKFJrCLGfVthWZqwu2?=
 =?us-ascii?Q?ncZ+ZJYwkVFN4W4ad/Zsy7YBRortM1Dwh14zhtKEIulNjr8FvaRJb51F0GJV?=
 =?us-ascii?Q?qTP5iDgS9Nx2phpuv2I9vinlO/0QDEz161XHfQXf1FX3QtlfX1UeK6vvzSjm?=
 =?us-ascii?Q?/T5mCkM/G1t95ldS+cY/yyeqjjsso80iL+pUkIK2znYGOtVPlepfHhHUU/sa?=
 =?us-ascii?Q?UF9UllqerppGRSh4dJOB6M7/GfE1NrK5VaKEIUD31eSYfP9pC3fzvD7944s3?=
 =?us-ascii?Q?l++uvxsTyqpnTUOl3FZuX+E5ao59mK9ww0U430ItZaoGrOgYEPSVMDgpeH42?=
 =?us-ascii?Q?Zs08EI3NTfA/wkt28OZSxnMvfdVUlagtXAKuZQDmkRqeaskIty359PHtTv/P?=
 =?us-ascii?Q?Xb8mr+2EVcZBT8qYHNQxG09d1/PkLN6te5j5pEwD5SBllrkYXs0g9ZWikcjz?=
 =?us-ascii?Q?dOLW6VDJ0Nufqtqnm/EiopTgEsK4A5np7VJZtg+1rSTVByhe1n0QSzf8ZPuq?=
 =?us-ascii?Q?NgENgkoihJ81hUcm9CnSTw/GRhug98Xk8uH0FOSGaSMGwyQg59kMnnPGphWR?=
 =?us-ascii?Q?DcR4o7jPlqQ17RdsKyJGx94T7PBOa89UVE4nNq5LPFFZddbNIC6ZxrbOPssW?=
 =?us-ascii?Q?vFgZRB6K/KGPnjXJh16M4hqi5ISnCCfXNvaRsJLJZ8VLNSQVddFsLxt+r02d?=
 =?us-ascii?Q?WY1vImDE+VwL7kS9wHPAYzH8Sw1xemYgCkFzLTp4WW9Q3Wanwv5SIk5PDhyD?=
 =?us-ascii?Q?yyfAgYl6j5BhrKktriZL1GOUCq7uwZdeR6kw2I/Fyz+A0tz6OSizDpicnj70?=
 =?us-ascii?Q?aI6/wWoNnpgC/BGdVksiJ6tUpTFvJg5W7KH+2uZVLKVkdxwPxOypIHg5anpM?=
 =?us-ascii?Q?aQX7W/NyqAnyfG4+VCabF0+1iVLU7YZJo2VJ7MkiCy0LgZaynHX6VBuJyxQ5?=
 =?us-ascii?Q?SVjtvkQrPDHiD6W962pkL52Q7CRJt/0b9w628ednmEPjgbBSHbMhRn8ECX5F?=
 =?us-ascii?Q?fOOnWEwSUbCaowsR552w4OSnI3tj5fEJuEjvRJnCXAC8P1v+OvWS4rrlbX/0?=
 =?us-ascii?Q?LuRAZozr/qVfQslxqy312bcLV46Vr5IHkA4ntE5kG/Yhu85mHSudH8P0SQa2?=
 =?us-ascii?Q?cgbopJOnlxBsXzmdkBtq8tZa1AlHu7GNjmiV4g=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-ab7de.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 758b9260-c6fe-49fc-d3d7-08dbcda1e7aa
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB7899.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2023 17:12:26.5855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB6093
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the later revisions of the Brainboxes PX cards are based
on the Oxford Semiconductor chipset. Due to the chip's unique setup
these cards need to be initialised.
Previously these were tested against a reference card with the same broken
baudrate on another PC, cancelling out the effect. With this patch they
work and can transfer/receive find against an FTDI-based device.

Add all of the cards which require this setup to the quirks table.
Thanks to Maciej W. Rozycki for clarification on this chip.

Signed-off-by: Cameron Williams <cang1@live.co.uk>
---
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

 drivers/tty/serial/8250/8250_pci.c | 147 +++++++++++++++++++++++++++++
 1 file changed, 147 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 82b445ddedb4..8242918970f6 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -2429,6 +2429,153 @@ static struct pci_serial_quirk pci_serial_quirks[] = {
 		.init			= pci_oxsemi_tornado_init,
 		.setup		= pci_oxsemi_tornado_setup,
 	},
+	/*
+	 * Brainboxes devices - all Oxsemi based
+	 */
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= 0x4027,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= 0x4028,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= 0x4029,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= 0x4019,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= 0x4016,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= 0x4015,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= 0x400A,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= 0x400E,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= 0x400C,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= 0x400B,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= 0x400F,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= 0x4010,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= 0x4011,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= 0x401D,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= 0x401E,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= 0x4013,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= 0x4017,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_INTASHIELD,
+		.device		= 0x4018,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_oxsemi_tornado_init,
+		.setup		= pci_oxsemi_tornado_setup,
+	},
 	{
 		.vendor         = PCI_VENDOR_ID_INTEL,
 		.device         = 0x8811,
-- 
2.42.0

