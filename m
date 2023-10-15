Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE237C9A3D
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 19:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbjJORMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 13:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbjJORMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 13:12:25 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01olkn2063.outbound.protection.outlook.com [40.92.65.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E8AEB;
        Sun, 15 Oct 2023 10:12:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GaGK25oAxpBjQo0t44VGmOrJedoBEjhmaVIjDdAsErdAtUh3zR3zxPl1bk7/FggLBSUbpx8BwzxdxGoZcg0FXj8ZgdjDdD30fsJuMQ+EdLGv2YiHatZZPAXTrre+sDkD0fDK/3Z7K3cKNK7Qzjvpr0dCqzgAJO1ukzID26DrKhFyiAQs61quhE7Ns/dN46eX1t002iksmOdRYDmpGugbXTvzuo0lS/R1jIyhsuwfeK2mdSmM33vHqeFSItO3cAY20BwTLTiGQN6PKBvkKa0i9k3XZGhIeR5W/EIRXI/h7Ar+3Kj0xS+Y0Zy9r9LrNFKa3ODQPCrAp3NwOB92JtqCug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=upWGgLKYLBO5mrcxAqw9jCsx7VTwlQMBs1k6uCZk5Mk=;
 b=i+QKGB7y0zIqcbYzhctQ9y1aYOEncIhCy6BTF7ifWy6qghr/+jjdEFxhxfYbb7/PpdrTjqzVR5LrzxsuLSvE/nA5mbtFuirkLOw7uN01cxpceOm3NGRXDvw4YLqOYukiaNEdulotZzr8ukE6MeEEhaXz14xIKSys1HqiPkVNpsxjCZP1yeDQvTfgClZUxJpVh82e5yAKCYOECvylx0dBcXx/n1rPdW7qbOraiKnYnPHEEq51852ugBET2er9imJIv/7SEaWvaSF4t0naCLmGoWii+wZ50GxVfn/KTM3C954NCdQ6Ac7MvitSTIouOQDFrXZbR3VCaGOx3PiwJZriMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com (2603:10a6:10:347::11)
 by VI1PR02MB6093.eurprd02.prod.outlook.com (2603:10a6:800:18b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Sun, 15 Oct
 2023 17:12:20 +0000
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::b753:178a:394e:af8e]) by DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::b753:178a:394e:af8e%7]) with mapi id 15.20.6886.034; Sun, 15 Oct 2023
 17:12:20 +0000
From:   Cameron Williams <cang1@live.co.uk>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Cameron Williams <cang1@live.co.uk>
Subject: [PATCH v3 4/7] tty: 8250: Add support for Intashield IS-100
Date:   Sun, 15 Oct 2023 18:10:19 +0100
Message-ID: <DU0PR02MB7899A8E98A24B0748FA74D59C4D0A@DU0PR02MB7899.eurprd02.prod.outlook.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231015171141.3309-1-cang1@live.co.uk>
References: <BBPatchesV3>
 <20231015171141.3309-1-cang1@live.co.uk>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TMN:  [mFgeTTn63csUzyKlux9LkN5DWjzstA+Q]
X-ClientProxiedBy: LO4P123CA0066.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::17) To DU0PR02MB7899.eurprd02.prod.outlook.com
 (2603:10a6:10:347::11)
X-Microsoft-Original-Message-ID: <20231015171141.3309-5-cang1@live.co.uk>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB7899:EE_|VI1PR02MB6093:EE_
X-MS-Office365-Filtering-Correlation-Id: 59275f87-8929-4c29-cb64-08dbcda1e448
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VYxktL7ujX4sQsv7hROfpqXnDSgZlJO1lY2CpA9vr1Nb47l8QNzBO2LwoD5qUs6Aq2Sn/DXNVO+tpsHqKm3jwnPHX3NWbUedbGW6BX/mIxFm88/ouHGHg03nqqJPsMcb63GhMddt//Yqt1WAlvc+57aNqWSoyp0xMwQmyYs3qwnp0KsPXbZGMdU9jpuWH3pG6x2d/w2f97kpzWsKSo3Y9OqRswmVarD3/q2zPdEEzy/r3L/OqRy1o2sCh6JgmNR4eM6d+tGvUUFKQvMVlTVxDrOpa7uvCVCBnrONT8Y1aJu+Uw/BdUzfChSghXA3iDZ/WH8Wa29TI5PrXhwySUd/T/cbyqcVKKD59ITa7QXkoGLOn02u/Jspj+yDoUB39+I+itU14JMvXQXYum+VUp1ITWOHu7FZQPjYl1WtEOAIv1QD09lriHznZEPKVHLwKox53w9ftOiJWFaugD7p9iQhvb+upnnbbC9YF0gt2g8OlSbKO4cBvZPp+U8SIoRzoL+/FqFmxBqEbz/Hax6hTQ9cSWB1aF0sd7XMU6eMpJoSALTWCBCJaAthE253Ey1HhmvVXYNYa2WzLaKzRpg7Nm8MstrV3buK6LBLDXBOwfz7T5cDvJoBDLerac5GZjpmXmeFZe0WqpSX+xBe56hvrN16Aw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MW6MF8q8qC6QKLaLq5znAvutZT3Ys5HuEKXF8PyOV3Pg0DdbLF9/OalvLrBp?=
 =?us-ascii?Q?9IC9azPqVVvyOZFkN2M6H6ZUjA6L3kirts30/Nvnlg3fhYGkkdHIisDaacX+?=
 =?us-ascii?Q?Z2ur1i3r47ExWXvXNwI5SU1FRSPCv2vr7cFuBC9EeoB9pfewlQ16Tdj78fB5?=
 =?us-ascii?Q?OoYSZou5dGS32y8iKH7o5iWzwC7QxKQl3agzknx3GyPMsUPG1aImtfN0Dxer?=
 =?us-ascii?Q?25VA/Ap0itqgds7QI05kCoMKp9TdpiBs4cWD4OgCg1QAcVUnvlejDlOWc9cT?=
 =?us-ascii?Q?ijOvgXklvxBank7+csoaoIrFx07OjwREnsVQG6TiMc4WDRD6Tri0NSvD5ZIw?=
 =?us-ascii?Q?guS1YP+9iqCNxw1u3vG3YzkgrPxA2sM8Kjva19MXqWYuFXZMiJzZ2Gle7W/S?=
 =?us-ascii?Q?MKSlOBMFin910EmeG+ej53cacK5Fq+m9000veYkgtLhbh742UHV0dJiLvE6d?=
 =?us-ascii?Q?TepJ52e3SiNXh9SKoESR95/RKilP6+pgMezCyASlt3dzF0LgsDNU5vHN7K3U?=
 =?us-ascii?Q?bGAlhPLtpE0TN4fbImTBld0CdjFrIJbJT9AT2qE/KviFbxQHP/xjICChWYA9?=
 =?us-ascii?Q?pkAsbeGGxe/tjB/XJolJu60Y+4YgvN1KSUxa+c4Ydq1GTYyBndVeJyuppWB+?=
 =?us-ascii?Q?JnrsC+I42fxXT5VrAnFQ4FbgVT6kuxGmj9nA9bFfDaG6214OuDZBrn7Q3BVR?=
 =?us-ascii?Q?PQw4hTKT5TrSmwQaS//SQfNrNjj4W8rj7S4niWHl3kc+o2pWElZngGkOGlvr?=
 =?us-ascii?Q?LPoGyyRDmDrIEysZ4d6YTdOhrInInIbvfEBha6FFJJS5JT2wNgT3twUrpCiu?=
 =?us-ascii?Q?dR1x/5DOnmvdKYb6xP00H1Zmxg07H9QPbroVfCCx2DUSYU2HDQVW5T6ut1jr?=
 =?us-ascii?Q?YNSe0Usyhqp828YwKhjaIu+ZevEZo9KDRxr1xcB0kebCnn2OUicCzO3rqDSL?=
 =?us-ascii?Q?a3UqF3EDyX6a7sg4D3nUcwlZcWejwoVGyYK+ooK44JTwkhLlczhgxdDYrO2l?=
 =?us-ascii?Q?J/Yd715278tydY+SPe2hWJJBlSwfFnFWji9N7VQAXoAz87PxvEzLuywWHMoJ?=
 =?us-ascii?Q?VMx3VgunFsJMJf5MNp4oaRxk9xk5Pzw+hnlIvsslI6TNRUZJHuwCEMgmIEC7?=
 =?us-ascii?Q?jGyctOWQrd98hNxu1qaLdwTH686kGp46HufeNuwerIXTou+/+S79oZG/w/2r?=
 =?us-ascii?Q?VEGipduMlIWonbPAiazNnfSlJjGrmjbMyldAxw=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-ab7de.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 59275f87-8929-4c29-cb64-08dbcda1e448
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB7899.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2023 17:12:20.9160
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

Add support for the Intashield IS-100 1 port serial card.

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

