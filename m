Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 952117D1397
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 18:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377941AbjJTQFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 12:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377901AbjJTQFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 12:05:04 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03olkn2017.outbound.protection.outlook.com [40.92.58.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B118D7B;
        Fri, 20 Oct 2023 09:05:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e8m+BsypSBAtq2v49L/ITv7oSguQz1qPPLtXnTdR1gU0MV/VpODJD7RRjzdiEtrn7uNpJcLH7SY4L2kBx8OXCEEJ/3xs/Gd5JkHfmftrt/7fAIQm6keC+fqsNJJS5FGeKNxwEcc0+eC90S13rIrirLlkE8NAmZV9JPjqictLodknx/HuUx77n/BBiS1hrh1YTM9H9TZFfPSfpJ+pA2jbhR8YRUNIiCxruljxkIqqKcPj8bSt5Cn3POMBJtKw6UrDWV3khHqgUa1dJG3M1sIc5VoxvDS+WPA0JZTCIRHDAbg4kjOzFkstovW/ZDXvcnTPQ8nDbWbZOGC/A8gxmeYKZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d1+9ejdNVgk4lyGKbqkrwNDIEprllXb2rKoosU7gGfw=;
 b=jmxtikKxvDmSCFN7yt2TC1XayJcB1ZlB3I8tDhunhfRSUwDW760ouZB6IF+k2nhD3OTOeZkEsf5Id0W1YlQgm0x06PjnMlzRz07kz38PFVm6iV8nlv/J/nlWbATypBRAXDZFYdiqV/CKmhhM4yTGSpEuP9okA8YuIXPJxoLu3JU6v+7hP3+571hN/gdlHdSk5KM0TCh9wG1KgWflA9DFPBKm3ZbsTaMNF8oWVGJRyLSj7g0oLC06BznTGxRAXnwVx460EYcsCgt6iWp8b4Rj+g2xUjYv8XWG8jGvBElEtgCcWCqgKr8JdZ8HGaXUzwrMLOlwmnVvLxrrA4Gsriw+cQ==
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
Subject: [PATCH v4 05/11] tty: 8250: Add support for Intashield IS-100
Date:   Fri, 20 Oct 2023 17:03:11 +0100
Message-ID: <DU0PR02MB7899A0E0CDAA505AF5A874CDC4DBA@DU0PR02MB7899.eurprd02.prod.outlook.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231020160412.118550-1-cang1@live.co.uk>
References: <BBPatchesV4>
 <20231020160412.118550-1-cang1@live.co.uk>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TMN:  [tqedokQaSOc3Qi+k08cDYQnpKHkCPUPE]
X-ClientProxiedBy: LO0P265CA0011.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::19) To DU0PR02MB7899.eurprd02.prod.outlook.com
 (2603:10a6:10:347::11)
X-Microsoft-Original-Message-ID: <20231020160412.118550-6-cang1@live.co.uk>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB7899:EE_|AM9PR02MB6930:EE_
X-MS-Office365-Filtering-Correlation-Id: ddb1f28e-5f91-4a71-5d69-08dbd1864eb1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7uWHPjc6Ojvj7rj5X6DbFlCwiAjNr5KUOe2lHZorcT2zWnPgZgcFPfuVMd6+vxAJgKvacz/ZIF3kkCvJxD+LiFC6PjKg6jkYrapD4/hm3ZXP0/PWL8NA7morvg/jGsDwFp2RMeWpTpzPvkXqQWsnIrTA12qwR0PUojrfw1SqE58hRK/a3uj2Nbj8Kdk/pTpxIxtJT90UwcXlqFoS8B3XEt0PF5OV1PQyIoecLppLijzCHJzmASGnFM71xD3gSVmg8G06l2LPG/1rxKtZcVVjRnyBnbZGckZxNvmWntxnJT2zZQdEjgHSRjc3q8TXxazUo+YVrMITtdAITkLDmqRucQig0RpvpftAh9Ir55MOSAF9mkUJr0XHsL0/h/tsbAe9aZFRDluH1WLvVWNo1TA3iaf/GM7zTOWa7rkhsMEUKFJB+7sVWpv25lnleB8aayzurk2rpoRY9wUT4PgA4gRsPn9hPPcayy5tPvY/PfcuLTpat7l7pewVThylguEba7ISXrh9Pb3kwIs/W87aE2FFCc5lMCVlXlct92Rrx1bLmA85WXPTHwB7G9MzimTqY7iyTlOgFjvN7bSZToXxAzVQSfNJ3FpcwZsIWJxaO1sq1yX1cwLyhSAV0Sd5yBZ9BuHiyo84Mxiewh9ydy8upu/rIQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fS9CPIiL+2Kt29v4Y63BdLfQacu1Cj3XpmA2A+1vomGSxWF8qjEVKzGShVHM?=
 =?us-ascii?Q?9oTpaq0NCQIiEqAl4ASNjWXEBHad+WJZl/kv7v7c38gB+MM/iMB8+V+wqd/h?=
 =?us-ascii?Q?vbyR7q1MgUtXgdXO9n6p3VptvuX+B8J1lWVXKf3uoW5R06w3jU89GW6DXWkD?=
 =?us-ascii?Q?jBQQuT+KBsZIkUsZQ5nFOQMpN/afajnGxFej9t57Wv2VglSGgSilnyIsL7Q5?=
 =?us-ascii?Q?mcAK3SIJG4nsimSEQUc2/eTkude3bCPKVQuYkP9HPc+jsdgZv+3oi/cpqMOp?=
 =?us-ascii?Q?3a7x46kuWtC+gyYqEIcDx2Tgf1kUzLeHHRQcB7EXE8cWGnrp2j74KkrWZTQw?=
 =?us-ascii?Q?fgJ1OONTim6rkrIOReErihdOjBVgyH+stsSjg5QuCEhdaobVl9Zoxj8Hy5LA?=
 =?us-ascii?Q?Vd6xeLcfxgfseBmMQq7Vt3rqDF/rJKF7R89Fs4vi4l9gONo4YP3rHTLxVBHb?=
 =?us-ascii?Q?hzSTTJLDdf7UIr6MdkNYgfjoJ0tXNcudSGn7aIog6cfLjJn44oe6iJWpocFl?=
 =?us-ascii?Q?rNDBXebsBjCBOrLXMGIJiEGUVjadt0y8+N7VAgJN5QExJW9l6yujUPNFK6eS?=
 =?us-ascii?Q?5FTz3SZ9Xp9//rQyJXgW6M+i9gM+r25LR7RUWQqbUx33EDq1NOMPWQ18lPaE?=
 =?us-ascii?Q?rvPWFi6tmX34hn4OZeYTn/upz+4T/f3JzPEJ9tsDqr3HRBCX7KFxSP8nz6Jl?=
 =?us-ascii?Q?sij8NTUXLicRrxVu1xIzw4P/b4NqlfvLrYly3daWjtxRVyocNCuC+4Z9uH2d?=
 =?us-ascii?Q?i2OhJ3oZ50qdsr7hOFQJZOHqJTvgePl/2e7fRoJG17RIXfSNL8xy5AYERSKC?=
 =?us-ascii?Q?It++iy4kvS5G6HPxzGgFMMk7sMgf6gNrWUNmn3QJrkCDGi7eyDuFwpycoBrK?=
 =?us-ascii?Q?VOikw6l4kwj/i+NsYJNvrRxsFb2b87AHxwV4jxxmD6brk1TYHay24phn+eb8?=
 =?us-ascii?Q?0RDriOYlUcijXlkboNumFbJDNSX818Fe47IG8T7y3buvwjbIiCV2fsPQBiNE?=
 =?us-ascii?Q?BwpK6ViWX+sANihLhhOlArPEazjwDUw4a6rq3OtThJIgQZqJeY4jvnVsOYiN?=
 =?us-ascii?Q?ONjRYs7cVzUS4SZXwLMXOAD/87WIu9pEuHndndo5HAGeblHwSt7nNCH+LbWE?=
 =?us-ascii?Q?hpAQIGS5Plh+9hZgTFJKdk0lqqDR5KcwlVxM94H+NUQmvLoMPExXZCTzp/Yg?=
 =?us-ascii?Q?l+EggOZrBsFr63TbO/SbqgRBwZ9p/OmFqrkJMw=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-ab7de.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: ddb1f28e-5f91-4a71-5d69-08dbd1864eb1
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB7899.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 16:04:58.1983
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

Add support for the Intashield IS-100 1 port serial card.

Cc: stable@vger.kernel.org
Signed-off-by: Cameron Williams <cang1@live.co.uk>
---
v3 - v4:
Add Cc: tag.

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

