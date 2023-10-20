Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 166AF7D139D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 18:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377955AbjJTQFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 12:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377931AbjJTQFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 12:05:10 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03olkn2017.outbound.protection.outlook.com [40.92.58.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D93510C1;
        Fri, 20 Oct 2023 09:05:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bWhmdTf3BXBCxdOfTW6H5cAIhQSZqL3zH7ed1UTR+7u+TmM9Zuy/L4KUCC1wtVRjo9K5HYYUskHly/KoUxclEH85vcoaJ9/tma94rCYG5sM5c6xiD4nmmHAI17OyIy9Sz8RvYH7h6iMrTLXAMj22s+HaNvB6sSDC5U8CKn8CFAce/vQL8xpWxdcvK/NfLz3buWiHo2+S+KwTYj7y/ihba7XnTsbfDAqpR5TdNpGTaRUdeN3yxTNlyLOHyoQStckferAJUvpBxAiC/QhqEab/u7i1jnQJx2CXn3BePvW2VRrPtqqBCgHkFjjej0v9Xcc9LdG6lU3tgI5SaDqvVcfUzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gRcM0tFNyb+N0hzhGYOhYERWwwJ4diHPwXe/Efq8fVw=;
 b=DpIerM5bww6mHqN4ZIaK3r5wvGqdycKIx2WS+CA4FB/Rok+/3z/kytmRcoUwcsxsVLca9U99tEQe9SniG3lzZD9OAAJ9mzuChIOI5UdBGlOdQC4E5/ssqW/2wWyt5bcA3G5SnsYpx6Z46ytIPASdJKTJe6lijNJw3ja9ENeDPbuzOQSjBgCUtd7ua7Rc++/GZlwzgir98/bjA+PYvE8HsXqK1CMKOtAk4SBr8rzLFw1OL70sb8LS2kTwkUJ2j59cfzfdvaETkKW02rV0iILogT7ykPGVeAn85YJSCsIHnaJnGlX0rp5d+fj3fKByNddD+liCm2S8zBpo/xJIp6kuYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com (2603:10a6:10:347::11)
 by AM9PR02MB6930.eurprd02.prod.outlook.com (2603:10a6:20b:26d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 16:04:59 +0000
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::b753:178a:394e:af8e]) by DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::b753:178a:394e:af8e%7]) with mapi id 15.20.6886.034; Fri, 20 Oct 2023
 16:04:59 +0000
From:   Cameron Williams <cang1@live.co.uk>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Cameron Williams <cang1@live.co.uk>, stable@vger.kernel.org
Subject: [PATCH v4 07/11] tty: 8250: Fix up PX-803/PX-857
Date:   Fri, 20 Oct 2023 17:03:13 +0100
Message-ID: <DU0PR02MB789978C8ED872FB4B014E132C4DBA@DU0PR02MB7899.eurprd02.prod.outlook.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231020160412.118550-1-cang1@live.co.uk>
References: <BBPatchesV4>
 <20231020160412.118550-1-cang1@live.co.uk>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TMN:  [nqfhpQ0t8nyuwTCsCc2JBTbNlRoiXu4T]
X-ClientProxiedBy: LO0P265CA0011.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::19) To DU0PR02MB7899.eurprd02.prod.outlook.com
 (2603:10a6:10:347::11)
X-Microsoft-Original-Message-ID: <20231020160412.118550-8-cang1@live.co.uk>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB7899:EE_|AM9PR02MB6930:EE_
X-MS-Office365-Filtering-Correlation-Id: 0170ca4e-3a53-4263-69a8-08dbd1864f5f
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WJEOzm1LYkybxDZG0BEyeMp3DGFFYfsQ/fnyAO44Cmd/ACnd6rk1A7Sxvk3skEQgE+tBB9T01qNKq+rldupXfkn2X61bn5//J69JruKyXB6nim0YzhyvX8g8J5WNxaLgDg1Ik5svYk9HlsFQosGhNpI5kUgVFYSEhIGPdyWs631JDQcG6jsnqsJjk9qhoBEXHdf+AUlJdeqsecqlb3fQmRMBVsZiWYyugygXefzWRHV+Y9zorU/N4YccKG0qMAOjzCcgxT123pnsz52Ar8Yauss0vCqsoZzsyz4OGBgd177Ol8Wln4J3+iOJXtqJS6GrUeDelXqDhbKGllU9JPcpw6Cjvbd4gFU/xP8it92HvJH01zW6l9XkkpnTLj6adTW+M5s0FtNMQY/ZkT0T6VlO++E9EIXVk/dfvHxF1WOt6NJi+w0sc+lg8kObvQdUrnrF8DNU8u9DgsluB55e/lIrpgw5OgBw39d6eUwyxdcBU1LH+RsUpsRM9sOAcfDH3i658+5jotWmQSe6QM9/y9Twf0CWvdO6TqiVfeykjDEkb14VkrLY3wkbIB3Cu3lpam7cx6p+woJxwEIKMXU0zHA7s67G3R4jFM67U0KAYJ06uu6Cj7/ujpBOmgu9VPbcyGk7q1OOWVltQ79pavfqrnA+PA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oty/7MIakE4ZD9IxfFV6zir5GONvr90bPg6joNWKD/oQqbDuph7AQFfDpL/m?=
 =?us-ascii?Q?ZgSwitwad+6Q+DylC/ZpWgGWcpXAzflLwIVVaf3KnLTjKHKwhTXxav7gQa8I?=
 =?us-ascii?Q?90qy6XION/VzEglyIOeh057KzooN5w0rpG4j0zuxHnrP24DjsxW7gOTSYUQ5?=
 =?us-ascii?Q?V0b7QVjTqSOVgmBIeN8fSF2KkTOMzaReqNynkzorD4mk9hZAeyItsYgM9lCN?=
 =?us-ascii?Q?NiZvIIO0uknslYTzMnDNvhU63duraAljCvM2sJ8t7UMU3pFkTrJWhRmvidG8?=
 =?us-ascii?Q?jXXy5jUqc6473nkFVi6KMmq/PNLyJ2ANmZxtA4dgtffcIY2CnmrA2Kv1Z7uk?=
 =?us-ascii?Q?zMZnjTsl1BoGm/FnTvtaHoKuND6/hjAORwOWfVvO67Lcu0uVr/CbgCcDYsqY?=
 =?us-ascii?Q?oYrGdChr/6mJyCOOw0T3HWlWoO5ddNw03ynYjDiCXxYM6l+37S4p5We8X5Ja?=
 =?us-ascii?Q?fumAvj/Km5sRS8gS1QoAckx9Pf9JdazDDbKZLN7yxm92zKcM1QqSe0dedHhN?=
 =?us-ascii?Q?5mi7FxnWYTQXETo0X9SqYzK8SRyXaiDyvGTvqTjl6HxPmHrz3ZwE6n8hV6hM?=
 =?us-ascii?Q?9SmJo5NMnQYoGBaBUyLxX/FUeugCcND37CrvRLgZhV2VZwnJGaj3qWSa+/l1?=
 =?us-ascii?Q?8eEcWvnHJuJOQGkehApMuJISlCTbzYcNaqF0ViytbheN02abVjd2EbTZwDDg?=
 =?us-ascii?Q?cUx64t67zdQgAGSRAAWm8EqMdPU0+aU6+GlbgN2YDydy3KVBadGq8kAECQEG?=
 =?us-ascii?Q?aoMD4i2CaTYQR7tvjMNGFyXu1dxODd8ceJeFfk1BI6sCtFnCiGioIegqVf9X?=
 =?us-ascii?Q?SzQWzCk0M5j3K1+/JradcbvPLfg6hLsgfuVb8k6mi/QOTeklnGBDXmht9Vk2?=
 =?us-ascii?Q?kLTLZ0EKmh9MSXWes4W+T493qC96IZZttia5hJOO+xl6jJDDiTHiQZgZdnET?=
 =?us-ascii?Q?HMjmrN7fyJjOyPFweWBBX+ParQ/bDdDb4qE6ut/D+rk3O41WQrToykj2n6oB?=
 =?us-ascii?Q?a7LSbO5WYnA3Miye/RiSbJBawzYAfAMN6wCaLoIFnzv0eC7OFnHQiiJquJME?=
 =?us-ascii?Q?gQzRsKm4buqbGk/rHUS+E4/rs9d2WF4losae7YK3OYJcy5kwz+fotQQLVqHW?=
 =?us-ascii?Q?tuYuYemA2TwfUEa/+4vWCZ03tm3uQgh0ehVOSKcrsXfvkhM3KP1DCxCXMBvF?=
 =?us-ascii?Q?kseD2fQEtNOCM0P14EH/26rVH4gIbakXvKQdNg=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-ab7de.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 0170ca4e-3a53-4263-69a8-08dbd1864f5f
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB7899.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 16:04:59.3692
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

The PX-803/PX-857 are variants of each other, add a note.
Additionally fix up the port counts for the card (2, not 1).

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

 drivers/tty/serial/8250/8250_pci.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 59074a709254..a68ae56e5578 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -5235,16 +5235,16 @@ static const struct pci_device_id serial_pci_tbl[] = {
 		0, 0,
 		pbn_oxsemi_4_15625000 },
 	/*
-	 * Brainboxes PX-803
+	 * Brainboxes PX-803/PX-857
 	 */
 	{	PCI_VENDOR_ID_INTASHIELD, 0x4009,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
-		pbn_b0_1_115200 },
+		pbn_b0_2_115200 },
 	{	PCI_VENDOR_ID_INTASHIELD, 0x401E,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
-		pbn_oxsemi_1_15625000 },
+		pbn_oxsemi_2_15625000 },
 	/*
 	 * Brainboxes PX-846
 	 */
-- 
2.42.0

