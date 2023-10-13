Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 651E87C9023
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 00:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232308AbjJMWOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 18:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjJMWOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 18:14:10 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04olkn2053.outbound.protection.outlook.com [40.92.74.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331D2A9;
        Fri, 13 Oct 2023 15:14:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZqcaaqNj66COcAHzY7ICqccnA/X3F8mAT0M17pr0JIzQh35KxIoxYczEr5aQJ0m2mG6iMOIl5uxrT+pSspPua2tXNgCkPZmMnqdm/yYh/+s8KUkQfLKV5NDSzJE3Q/rIwE6PaxlpmqAmobI3v1i+2E3cNTDS2uoZgUYzFlw8EPmoSFkBPuc8NQKopHH3jeNdlxGEq4z0I8bgjpVEMKfZXLjEZKWal2NW+LuUZ0qR1J/NgiTVZWX0rTYSnRqy4l6O0MbY7DFZ8l/6XLvqISANePXceqAu7jt2IZ8r4ObW5Kmr3HA/WcS6J5+wLWHmAj1V87bj5oSdV0Ja3OU9hfUHIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z/kn0dclQXBv32mwRvO4hzvp/kw3qHCLQPzJsBk5F4s=;
 b=kqflxpGzLWrNum14v5rTEE5vcv9Xcq7QjT3PwnO//nvsuMKJXn+0Y5ok7zUvmI7PDH7Ey2sEuSepi/ZPRMzyMHvVEdQ25gpYSqAuuMvrjQi41bMfPgvl3OWykewUJnw+llazXmJjx1fbbqQvPTobSFzW81VipDsmBCLQdNiV6yS7zEjfwLGm32P4LuEG+quccg/MbxejDnRXdDzIFx3eqSLiTZx0S593kv5qutM2CC96Y3yFnA8qGfoaAsLaEurah/BnLHebKXoo5E7h95c8oSErZazxswExehwhE6DBE4MF2htfpPODYZ+xUV2+4F96rtTKtXbF8iYYj1RcqBh+Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com (2603:10a6:10:347::11)
 by AS8PR02MB8341.eurprd02.prod.outlook.com (2603:10a6:20b:521::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 22:14:07 +0000
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::b753:178a:394e:af8e]) by DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::b753:178a:394e:af8e%7]) with mapi id 15.20.6863.043; Fri, 13 Oct 2023
 22:14:07 +0000
Date:   Fri, 13 Oct 2023 23:14:05 +0100
From:   Cameron Williams <cang1@live.co.uk>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH v2 4/7] tty: 8250: Add support for Intashield IS-100
Message-ID: <DU0PR02MB789954113A4F513D4CD65140C4D2A@DU0PR02MB7899.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TMN:  [SH+USlmHeswGiUc+Ka0DN9WD87injK49]
X-ClientProxiedBy: LO4P302CA0015.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::11) To DU0PR02MB7899.eurprd02.prod.outlook.com
 (2603:10a6:10:347::11)
X-Microsoft-Original-Message-ID: <ZSnBLUDFrh1OPW9X@CHIHIRO>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB7899:EE_|AS8PR02MB8341:EE_
X-MS-Office365-Filtering-Correlation-Id: f1d884c6-7844-437f-1ce1-08dbcc39b7bc
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pBZdQ6p/BYlAp9jUZ3/XPqSHguC1DYN4k7vu1TJyR+U4ypDAnviAzgmUWnS0ILHPoHMIs8zsrB7tmofI8GmJ7LtjjD5BKftMp6dJ3jLuvn+Mhg0796scs9ty0tjGubQFenREVfKWmPaNf+/D5KKWL8OC2GrVcY53qx3G1f610yl+JKZHptTDTlOlYc3Xhpr/NQibqJgqsXxThI84hwjmxv1KYyIvb3A/iHe3JdIW6UZuOQlU5hFMF8NnwYD8VWyWXvRTSvauZFWeXpdiPXianlYA8liSM57+baouI0d9TZTu2ZLinOuZtShYXYsPZrv9TD14PHIgAi13Ber9CQ+ZqA3uSafwJtKUpwQ5m4wQusF++3a5xzj9AA7Sd/YjVd16jtYQJkeCK4S+NGDFGuC0B6hIu2I88ppD89edgyO8vUcYlUQ2Jjuhxf9OC7npbsivySRJkcsMkJ5jycF+/1bPlkltBllIIFqvFN9vGS56p/exq9l4T3fyEqDxxd1Er59KWu+SJDSVkFdNNLmjB1npUnCz+hA+tDrJ2LRVwpO1UlilQlEUQm/NXGcu2ZyAzlHOyDvXHWbZBcmUxgHLLhJ8hg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ug0lpZb3V3fdNSAORwxChkfhFY4tBrvcLJ56JjGGq4iPLlrbv4X3CZfm8lrW?=
 =?us-ascii?Q?JxXCC/aHuDKSl9eiXZSqgSeEQl3f/HAW8E+IfYogHiY0FthxuGhrxKYRXm4I?=
 =?us-ascii?Q?a6b6qQ3S5WllpPpbNJEObSU4qdfAn6PvhjEGs3Dw72a0fUOJQW4DF9xDAP09?=
 =?us-ascii?Q?1gRKel7tEh+R/RqNPLfWT5bJyZKQzwMezPLGxxS9YwRZ9+ksuvQy6VcOhwjd?=
 =?us-ascii?Q?ayf3AB/xFIUaFNuUdYnCfx6rwvXKjeqrNOjT9CrEz62iup66frI77iSveo/q?=
 =?us-ascii?Q?86QGs/RbylC3x2N5CI3ZFa30qerG0vTEzcfb8DM6wmS3Z1tpGbqrMZIJlWvi?=
 =?us-ascii?Q?pLXd3kaH0Xezd7inxbYUOGahRLUKH20uBqOkWIWml+1OTqMkkEHKBwgAK6Zf?=
 =?us-ascii?Q?yVGcxzNZCqFMATmda0TM1hfR3pO39p3WsMDJ7zFBLJzrhxAHIuXvAUa70c7k?=
 =?us-ascii?Q?SbJskHdFmjFZeYx3qV6haBxGlulM/gZ2cngM9I+KyMshWqUui8hvMmH3fQ9b?=
 =?us-ascii?Q?NCw0XFhOHNOlet0PLnN1NbNTSszfrvH9Tt7l38+S5mLr6IdEyK2V00utoI05?=
 =?us-ascii?Q?Mr4hydo623ovhEvgxaA21SvlHqMp6uklVzVXYnxoqSrNNKysuA/R8HX9Xot4?=
 =?us-ascii?Q?WDWSv8iQyzfTv6TskgxBItbq6EOX4UPwB+l8BRV05V1b2UsWkb+xP53qd8T6?=
 =?us-ascii?Q?S8BUfN0tM6oWWBiVnCrMWjfZkuODGFbQlDMORA6sc/j99Fo+T7CzbmCG/PpR?=
 =?us-ascii?Q?6VYh4DPXPuTg7u1jf2atnDExhZHTpH11Yw4CWz8lUWkX9sFfJ1m5HhpMcC+E?=
 =?us-ascii?Q?cH+YsK5KWD9RpL4Dxs0moYonmK0YgbzQt0S4rttjf2j99CWXKJqt6fBrOOkc?=
 =?us-ascii?Q?p29rb+AV+Nyx8e184gL5RGAkCXSisvz16O0KPsv9h0HM1bOBQPhfUR5Zhy1b?=
 =?us-ascii?Q?BaVFe8L3MHoSdE7VZuVvOiyrN1TTyO8FvRTD3ZGwu3Lx+hzzPw/hoCCL+p6Z?=
 =?us-ascii?Q?Q9idkSACkC3vvx8G5BPgIlj1cfmkTN+xLiWVS9wyhHj9XGgvTRw9B1UokqpP?=
 =?us-ascii?Q?DzH+cvCn0CdUAVMnvrLFt8aM+Kn2eUhdvc/bB8bwukrFyC3xYTefezZ0ilfy?=
 =?us-ascii?Q?BLbOEjkEJssBpfT7W3wvdGgNESakRq0ai+Nf7gp3q+ERKLctFKOGszrlh4iL?=
 =?us-ascii?Q?mWzNM7ebnPlgVd81CZqiE53XAa4YiZLAs+yf6w=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-bcc80.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: f1d884c6-7844-437f-1ce1-08dbcc39b7bc
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB7899.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 22:14:07.3276
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

Add support for the Intashield IS-100 1 port serial card.

Signed-off-by: Cameron Williams <cang1@live.co.uk>
---
This is a resubmission series for the patch series below. That series
was lots of changes sent to lots of maintainers, this series is just for
the tty/serial/8250 subsystem.

[1] https://lore.kernel.org/all/DU0PR02MB789950E64D808DB57E9D7312C4F8A@DU0PR02MB7899.eurprd02.prod.outlook.com/
[2] https://lore.kernel.org/all/DU0PR02MB7899DE53DFC900EFB50E53F2C4F8A@DU0PR02MB7899.eurprd02.prod.outlook.com/
[3] https://lore.kernel.org/all/DU0PR02MB7899033E7E81EAF3694BC20AC4F8A@DU0PR02MB7899.eurprd02.prod.outlook.com/
[4] https://lore.kernel.org/all/DU0PR02MB7899EABA8C3DCAC94DCC79D4C4F8A@DU0PR02MB7899.eurprd02.prod.outlook.com/

 drivers/tty/serial/8250/8250_pci.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 1c46b65789c9..b0a632415d8e 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -4913,6 +4913,12 @@ static const struct pci_device_id serial_pci_tbl[] = {
 		0, 0,
 		pbn_b1_bt_1_115200 },
 
+	/*
+	 * IntaShield IS-100
+	 */
+	{	PCI_VENDOR_ID_INTASHIELD, 0x0D60,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b2_1_115200 },
 	/*
 	 * IntaShield IS-200
 	 */
-- 
2.42.0

