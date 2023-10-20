Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41037D139A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 18:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377893AbjJTQFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 12:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377921AbjJTQFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 12:05:07 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03olkn2017.outbound.protection.outlook.com [40.92.58.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE09D68;
        Fri, 20 Oct 2023 09:05:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kD0VDSooG5k0BVl99deT94Du1uSZLaVW0o4dhpUonxs7bXrRT/YxkicyPUIPVHyWx49Ecu4sGkY8Ly3DcUhgPU1iFVohTH7LPa70QZaMXNJvWn/JhWBzOd24ixzbm4k6OU9eOQp4oPpJxO12lmqreGiGoJeFDJsft/kPSoZjPvIkQZOG8TA8wa412WONeLXlDwsVcYccpsLkM5TNJ4K7sozM4WjIrr/6xtt5FwNlMC+2b5gkL3cisUtYZm6JzjDfMWL1VUtae8W/5/6vpd9IXw+qOd+M0yYkLShRAJl2C2OM5aAapyKQ4/MlX369WwHkeoRj4hhL1h/GoZ192PGFjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ejxtx27CDjH2UpD6ljG1S1IyyG/V2WDuP08oM2fUEto=;
 b=C8ZXA04V5YGbrUB7w1tPY1CTL05Kb36YjDCqn2wIOlhahPm7u5MElP3IKuAqEIV6+Qg1JbDcyqImC/rNadfdWWP8eGyVPzkipCnDxa1exsoZ+Le8wyRG5MsJR0Tzt54cjUiwpR9W2+g7m91Hcc026aQVphLRDML5zpmO32zsfx20ZEQuOrndNr0BcNWdJXd7ArTv75t1ln16izlg0BwvQXMznf+15RjsEz/14VvYOcgf0QRNA1JaZcgC3K0rc1HgbAcaSUHmNnwSgiXrrHg5KfBu/yi51hqNIY6KbgJ3CdQhd36NJP4ayYlJAQ4TQ4uvwuAuNMWSiEwDC/PAy/3Hew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com (2603:10a6:10:347::11)
 by AM9PR02MB6930.eurprd02.prod.outlook.com (2603:10a6:20b:26d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 16:04:58 +0000
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::b753:178a:394e:af8e]) by DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::b753:178a:394e:af8e%7]) with mapi id 15.20.6886.034; Fri, 20 Oct 2023
 16:04:58 +0000
From:   Cameron Williams <cang1@live.co.uk>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Cameron Williams <cang1@live.co.uk>, stable@vger.kernel.org
Subject: [PATCH v4 06/11] tty: 8250: Fix port count of PX-257
Date:   Fri, 20 Oct 2023 17:03:12 +0100
Message-ID: <DU0PR02MB7899C804D9F04E727B5A0E8FC4DBA@DU0PR02MB7899.eurprd02.prod.outlook.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231020160412.118550-1-cang1@live.co.uk>
References: <BBPatchesV4>
 <20231020160412.118550-1-cang1@live.co.uk>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TMN:  [zDVnpbjMvDQknRzm6IyPv/P/YEooHuSc]
X-ClientProxiedBy: LO0P265CA0011.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::19) To DU0PR02MB7899.eurprd02.prod.outlook.com
 (2603:10a6:10:347::11)
X-Microsoft-Original-Message-ID: <20231020160412.118550-7-cang1@live.co.uk>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB7899:EE_|AM9PR02MB6930:EE_
X-MS-Office365-Filtering-Correlation-Id: fb619380-8c1e-46dc-d013-08dbd1864f04
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hi1meIyfOX0Fh9wbztR7+0dp+Ec2qVDwHlCbsuerBN0aA6HazQGHued8/zTJwLFvTmsEnmogsO/0AYR7u88y1Vra/w9nyrXv+sEptuWfI42uQR5eFhB+ZcHO03pB0kHVTntDGENljkw9aKBbw5e/Vx05IryB9om34psyZZWtZzCHQtnOKXyKlSiTFALJhSW+7SaFA8hDPjGlRJn4nhmSMhOJwfIXgzpqp6EPPJwVJorb2XJ4o9ny7kCmpKCk7xylwsiNXoZN0LeaqjErwx0PLbYl1Kb5CsV8eO1ygBghA51eQ9ghZ84SEEtLQ7CQykL9AzyzogMVo3SVbhm1YHeJuPaXazdI1KqTbpzZiGQUk2+nKm9fq6+4MuDZQmG1csQzjmeOwiJS5dBQ7boydL1pflbUqCOf+y2T9x+c6dh/dkdhtI0daf5B70VgnuYwO3P26m/CJVvgGW75YLHxAR91XHseitNxpXgT7Ckq63jCvuy44etDzMCW/8JwqkZFyWP1npmEyBE13jcI8mufAQHggNWXxa8YkcP0qWf9Dhq4GDD3gO7mvi/u2XIQ0efpBNABo8EuOeV6ddakN6Y3jXvtE9jzh+TIPmdJWQVxYPdYvsZu3WlvCYcDJXZi1QqWwDNvlHHMuLmUi5KrxVNeymqR0A==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GTMJO3deQfYLEKAW5UaQqvfYg+/CoIiEwTwkDhVhr3YXX9dSP2qwxbC4HfCc?=
 =?us-ascii?Q?9UsQN3Y6U9Lp/sg5Agx9S+V1XxwIXF/5f971C01gMp0/MPECyuD22Dvpqw25?=
 =?us-ascii?Q?fkM4OFtIm+vxR8bWP61sYnDycJAXUwHkRZ7HNUZx+Z5URAZXcZVAhvR3lent?=
 =?us-ascii?Q?o5Qoflp5vKSIoE8Vm5J64GiJZKaX23wJ3rYRL4UlDn0ZbZ9Oly+W1lokYnse?=
 =?us-ascii?Q?JIkxKXw3rEwUB2BQzdQboSzijU4Ft1w8KEEksihTBia89iJ2cFd2lIH3ZClD?=
 =?us-ascii?Q?DXweceVoE7TFMBWvoxZZTTKnRIbJ9qcUg/Ix1pMUiy1vm6uffGlF/RoYe2tL?=
 =?us-ascii?Q?fd2TOYeiNYPVK6bDuqL2eKQsBorpYyxHn4NfpGtMXUdYow/hkYsVtZHGIM7C?=
 =?us-ascii?Q?RZeLbkhK82o9wHDNhAR50UAgTbirHnIvcqNAo3XYL3KBu+xscaI55zuMQn4x?=
 =?us-ascii?Q?qO4kTpd1nt2xqy/9sCgehFIT3o5aVSUT/iSd8wqiGdGsOMObRjtKNsdGNdQj?=
 =?us-ascii?Q?eoat3nbOfGGoPLniKZrmOlR8+FdDSli6wZ5SAL+JY16PV7U9eWoajpKDFWyH?=
 =?us-ascii?Q?NyvkAD0ggrs6zTYPjstH/8c+4Pw1MsNYfbEUUtr9OzG0s0yqb1KguvEuP0sc?=
 =?us-ascii?Q?WxQSInV7Vqxu1CuPkiuWHFJz8Y3nvDlxG4pm5I6ONYnYQWhtfVCMejw7uAju?=
 =?us-ascii?Q?Nn48kOb4t2acywv0iJj3EN0+aXfRjrpnSKNlCh0H/IC0hF4jH63bQmvcOlcG?=
 =?us-ascii?Q?c0ETBNpwL44EcNgUsh4T07jILXidaQKKt5Zcqc89YRxNtSZJrRgHOz/dbcGd?=
 =?us-ascii?Q?fF7y8n3lcfdB66J093wwRlComlfEHIO8e9cALi4sd1hScXOazNDz6C1eppem?=
 =?us-ascii?Q?ViXIoi5kXeSlWlnJs3AgKRKudEqk25cX7+ofG0OZxxdaljBCJpw8HtLfY3yJ?=
 =?us-ascii?Q?Wn9GLu5R9QLXp5GOT0xc32ZPF9wTiX2N3oAvyy0zaSS7Oh/Y+gPHsEfnVzOO?=
 =?us-ascii?Q?pgLH1me/kWqhTkihJbTAD7LjYL/r2omeAHANtXRlJOegpD/PQlWK4l5AQS3u?=
 =?us-ascii?Q?ETEYHDXSVfPjUwiP8iyY70Be1wOMBm3ko7V8tsWr4MH73gGexUvVPF9ImDPT?=
 =?us-ascii?Q?RgcsYN4CHKNRwyXnKlJ1h6Zw2X2fTOfx3FnZaVWI7ItbK41DLaHoylklfWvi?=
 =?us-ascii?Q?cVSdVM/JMyFWkmAeNUQHl/8rN6hW64qnc4frGg=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-ab7de.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: fb619380-8c1e-46dc-d013-08dbd1864f04
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB7899.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 16:04:58.7548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR02MB6930
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The port count of the PX-257 Rev3 is actually 2, not 4.

Fixes: ef5a03a26c87 ("tty: 8250: Add support for Brainboxes PX cards.")
Cc: stable@vger.kernel.org
Signed-off-by: Cameron Williams <cang1@live.co.uk>
---
For stable: This patch is only applicable to 5.15 LTS and up, other LTS
kernels dont have PX card support.

v3 - v4:
Split patch v3 part 5 into multiple Fixes patches and an Additions patch.
Add Fixes: and Cc: tag.

v2 - v3:
Alter commit message a little to make the additions/fixes cleaner
Re-submit patch series using git send-email to make threading work.

v1 - v2:
This is a resubmission series for the patch series below. That series
was lots of changes sent to lots of maintainers, this series is just for
the tty/serial/8250 subsystem.

[1] https://lore.kernel.org/all/DU0PR02MB789950E64D808DB57E9D7312C4F8A@DU0PR02MB7899.eurprd02.prod.outlook.com/
[2] https://lore.kernel.org/all/DU0PR02MB7899DE53DFC900EFB50E53F2C4F8A@DU0PR02MB7899.eurprd02.prod.outlook.com/
[3] https://lore.kernel.org/all/DU0PR02MB7899033E7E81EAF3694BC20AC4F8A@DU0PR02MB7899.eurprd02.prod.outlook.com/
[4] https://lore.kernel.org/all/DU0PR02MB7899EABA8C3DCAC94DCC79D4C4F8A@DU0PR02MB7899.eurprd02.prod.outlook.com/

 drivers/tty/serial/8250/8250_pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index b0a632415d8e..59074a709254 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -5180,7 +5180,7 @@ static const struct pci_device_id serial_pci_tbl[] = {
 	{	PCI_VENDOR_ID_INTASHIELD, 0x4015,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
-		pbn_oxsemi_4_15625000 },
+		pbn_oxsemi_2_15625000 },
 	/*
 	 * Brainboxes PX-260/PX-701
 	 */
-- 
2.42.0

