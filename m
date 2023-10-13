Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D5F7C902A
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 00:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjJMWQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 18:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbjJMWQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 18:16:20 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01olkn2093.outbound.protection.outlook.com [40.92.66.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E775BD7;
        Fri, 13 Oct 2023 15:16:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jszHjxoFxDvqi6oeBEXvqN2NHWJg7r2apCo+sDX1VaP9ILjYbDaP/s3oIYBAvWnMdy/eYQ0D1KMymx2NeS1bktjQj/C3Y+bDYQ8zXEkS4WDLkRbuyKETEMcXDJGONF0mNilRqG9qCKTTEL112HF4CMAha9tlqLr8A+NHDi4UdNjc7H14+FnG0WV05xmx1/Ep35J9A2FdzPn5UYEUPQKnKfQbR2egE9Sncg4J5LIJtPll1ylN0ZjZPqRW2E7ms5iNKuKgCl8/7SMFrB7Bkiukk7Sj0DbjoqKDCP6FDzhPz0tB/SPetgDKfhcOdz59nHEIXJpFqYlxeAnBk8vJp8MBKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F4wR7lZXdebwtn9hlVVkbZT0Tqw5iT4VaBmvmUZ2v6g=;
 b=ENRyRBtOxuW9xNLwrvc6cIJTEy8FUr8RRBzUPMZt+MRtxdegIukHrkggrgtSAIEoUFmBC9nSnUOQUQ9G26P/d8PevJMXX20ylVN/DA0vcvbz/sxR08m/8FHe0m84qbQqEX0qGmqDAERIfTdlOtpgSROmYkGal0wtJXwfs33aiI+KWg05X2Upz7SF3vkXP1prO2sEQFUWzHymM3DIpo7yNrgMhyJRddLJcSQo43mzwofHnQx8ee36Ji+jc5JmDQp0WS+uMQpFuN+Dckgu0LUlhDVTkMz3Bmq7wXbau0OyOQhPzRagXGkwsmob/hx7JLVq45dSveQVZdnR62R0hrg3cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com (2603:10a6:10:347::11)
 by AS8PR02MB8341.eurprd02.prod.outlook.com (2603:10a6:20b:521::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 22:16:15 +0000
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::b753:178a:394e:af8e]) by DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::b753:178a:394e:af8e%7]) with mapi id 15.20.6863.043; Fri, 13 Oct 2023
 22:16:15 +0000
Date:   Fri, 13 Oct 2023 23:16:13 +0100
From:   Cameron Williams <cang1@live.co.uk>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH v2 6/7] tty: 8250: Add support for Intashield IX cards
Message-ID: <DU0PR02MB789945AC3746E79AF2390C73C4D2A@DU0PR02MB7899.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TMN:  [f6EUo4TWbQHYTJH3Ic7zzXNDfNZnyNey]
X-ClientProxiedBy: LO4P123CA0081.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::14) To DU0PR02MB7899.eurprd02.prod.outlook.com
 (2603:10a6:10:347::11)
X-Microsoft-Original-Message-ID: <ZSnBrQ46Z98RCIuI@CHIHIRO>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB7899:EE_|AS8PR02MB8341:EE_
X-MS-Office365-Filtering-Correlation-Id: a9bc4c49-0df4-4388-42cf-08dbcc3a0424
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aoAAiFunFG5/eczJ1fjtybF50JvxOaqomUzmycwtai8pGmbF7PHslXVMsY5NKK3vN0r7Zlh9LBveejOMYdzbYK4Q8KRNe2q/zz7Fio8Bzyc7T4Mf2nV1fKdcK4LXMfCmN+bln2WfOmLPHRQyvmx7JeA7bm+Qs8to8NlGDszKkbI0by7/Nx9HYfjy30KaGMnLGuReKaXaKRDB4kgqY6euKqNYBbhfH5RJC7Ftz1f6GxOIllg+FbdZ07TKr+KrY0SPKFeMaA/Eem4WnHIK9MJwhMBm97MDxpq1QHpRox/KoRUFtdPzol8ZfT0mYL0LBqlQq/DUkPCsY53gFnncLlmn5lKysLbd9DL3tTdEVbTsTH5BUFvllgok2xhT2nTKS4LtpB8X1ZymwK3SvrRHXXlgPRlm0cJ6RxjJzt+ai3vJSttHGkYeyWquAQVC+F15xwT5MPtlTp/SPW8WRKuVtK8643EnCQ/HwLzXiRRGaPCBMMRMAyXS8VDc6jA6KctF0NohtNv70lFZbS8dxUsScqcencjRr2wS1DArvBi6oXClXGKY/ZiZCsMrmKNpWnc9piloYyHTvx6b2/eCvnQwHlR85g==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K8mgVUXoDdENva3RsaVtbKNM+1tYiATdbZB42GTMhKLtdszZZllE2/OcPbzo?=
 =?us-ascii?Q?YR8YZEz3GBW1KCDncFltVLxHJQywm/iFuciTAJE4YPSMxqgu/V3DIo5zArjt?=
 =?us-ascii?Q?KNlwRiggd2/ZVEUj2pBLUgLxOlAXbDazSvfciVOfAOvkQAz7FQgPdKaTJctg?=
 =?us-ascii?Q?l79ZYgxdxeRAZFYAZsSD9RV2PRLUJCp8NgyBq4a7ButMq9BslFVR7NEWL3eF?=
 =?us-ascii?Q?8femgaduoTrARzEbadZlXIoSKvhNC7oAtqnWQLmxRahfoM/XsJ3aU2vepvty?=
 =?us-ascii?Q?Gm6gp5KRxCHGYDDVTIFsBY9a5aM9bTqmAUpHCt3c2qIeP/kdnBgzxyEhdGy3?=
 =?us-ascii?Q?9Z0lmbPwE0TCbiIGNE9nH5M8ON7CcXQ0r0/9+UphMeb1QSiNkYkcO90vF7GF?=
 =?us-ascii?Q?ahQScqFvBXmKgZRg1AHBStheKdwJhHTN0xEXgsWB6UxaxrKK7TMu5BlUIYCd?=
 =?us-ascii?Q?DwtFKLm41K5uqPSEfCq14p2uU/SMxQUEw0cu5CqAWrroYHd3g8DmtKDsbgTK?=
 =?us-ascii?Q?sACYUooiEtHEWNYLTL3JALXs33EgMJz6X1atOXwl/gQTXygonJ0Mx+zewXQs?=
 =?us-ascii?Q?EZ/RMLVzk02yaPM5ceT6PDtfeUYLFR+OavTCSF1H6HndJWjqHeWhi4ol0SBS?=
 =?us-ascii?Q?bLBUlgHelpbxBQSKeqAHfFkSXllblyvXOXi8OUZ/b4tysPLAicVgraL+SSlp?=
 =?us-ascii?Q?mH0P1rNPd4rvIkWTyCSOx05hZdQKw9LU5zNv5NvoJPC5yHY/jERpC6LWlBlJ?=
 =?us-ascii?Q?a5nGapWh24TKYEf/KtyjJMF92QJug1+dofjQD8zmoD7+OEC/zYo4dcYABt+K?=
 =?us-ascii?Q?b3wGJ4pG68wGPVcCY1SO8y3OXAh7Pgog3auZvxyji6x2WDmJpJLkiFQ7J6Dh?=
 =?us-ascii?Q?sTgRWsMSK7abohgB6QQjGYYLnrNcG/UfmBDKgFdunY048x6lkTjlln4piniL?=
 =?us-ascii?Q?vChDEBDnbDAykROEuwgorb+4E7aO6WBCBl2/S3zSQGmRv24ZHdh/Y6QlBZBb?=
 =?us-ascii?Q?hNgk1x32PoBLtAjIkarpnU8nt81je6ggP1bmtcpP0A/Cvs4+I19BVx7sgTsb?=
 =?us-ascii?Q?ToqY5bvFarE8zsiqXrDIskstxi1Ccpp0MnqZ5ywxM4PFbiWJ3XjjcZqZ56tC?=
 =?us-ascii?Q?lyBjtvRx0caT+u9RBpPxBQNWMGEDUD2ZNyspFQ1kaRJs5HmJWXOFj8r5SxAC?=
 =?us-ascii?Q?Wr5cexzzAymGU1kXNKyH3KW7LLoVjZQsw0fr3w=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-bcc80.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: a9bc4c49-0df4-4388-42cf-08dbcc3a0424
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB7899.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 22:16:15.5172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB8341
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the IX-100, IX-200 and IX-400 serial cards.

Signed-off-by: Cameron Williams <cang1@live.co.uk>
---
This is a resubmission series for the patch series below. That series
was lots of changes sent to lots of maintainers, this series is just for
the tty/serial/8250 subsystem.

[1] https://lore.kernel.org/all/DU0PR02MB789950E64D808DB57E9D7312C4F8A@DU0PR02MB7899.eurprd02.prod.outlook.com/
[2] https://lore.kernel.org/all/DU0PR02MB7899DE53DFC900EFB50E53F2C4F8A@DU0PR02MB7899.eurprd02.prod.outlook.com/
[3] https://lore.kernel.org/all/DU0PR02MB7899033E7E81EAF3694BC20AC4F8A@DU0PR02MB7899.eurprd02.prod.outlook.com/
[4] https://lore.kernel.org/all/DU0PR02MB7899EABA8C3DCAC94DCC79D4C4F8A@DU0PR02MB7899.eurprd02.prod.outlook.com/

 drivers/tty/serial/8250/8250_pci.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index b0e7354ba119..82b445ddedb4 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -4931,6 +4931,27 @@ static const struct pci_device_id serial_pci_tbl[] = {
 	{	PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_IS400,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,    /* 135a.0dc0 */
 		pbn_b2_4_115200 },
+	/*
+	 * IntaShield IX-100
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x4027,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_oxsemi_1_15625000 },
+	/*
+	 * IntaShield IX-200
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x4028,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_oxsemi_2_15625000 },
+	/*
+	 * IntaShield IX-400
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x4029,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0,
+		pbn_oxsemi_4_15625000 },
 	/* Brainboxes Devices */
 	/*
 	* Brainboxes UC-101
-- 
2.42.0

