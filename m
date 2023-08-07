Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3DE772B1F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 18:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbjHGQhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 12:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbjHGQh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 12:37:27 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10ED7173E;
        Mon,  7 Aug 2023 09:37:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n11Bhy9Au1iEfB7RluYxFckU3v4CdtPnkU8rp3IcQoglYSomXw+ty212D421KeHz6fdc/6wMKP/J8wwee1K/+rE4ovGrxmITK5ARnN2SAPy95XqW0RGOoRQpyqbs0ocL/domwTZ+iwgWg7z+ejlfM9z9DRh91gy8XBlznreAt+ipyBB6g6a2sbAm95hFK757zN6+DMC42XiuBh8s5pxlo2I5TQnJ00fXNlbbFihzlTw1dhmgmMZQfxDeidJlFw90EDW0J4dD21LRKtdIc9Te0e9UuWkILcmlLCb1BPKwJnQzhdb787KSg4aE8iTmIlVlvGB4AT13aKJWLaUdFMO3Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+eZ/xCFFjIDv6U4yhmT73tvC1dZyQv7txgZFeQJxTUs=;
 b=C5DM2fWoW46AlZXiQMHBuj2eNx+veK9qc/7jdFHrBAezwH4un29zY3R2WlwPCJTnRxzwZrXNorFpVlT5VNJWaPJLjw+b9f9LO2FjFDgEwsfq3Jp7OY6FK6djyfmBYFRH6VftyITxMe8TyX4o8vIqjcgPocsXLoD7YXy6U+mftU0vpy/ZaTtyXbiYHXN7/zcp062lkAT3tFg3rdWhuSB8F6/hLm/31wvTJNlP3Vys1O7lhA8vyyZqWwkwSEyAk2vm/KujA0fbaLPllRw27haGk9UzrUFVDennh3+dA3X8Wa4C06tf4DQS/Kqc+WmEhez6xOPpO/dMef5XOHhyzFKxww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+eZ/xCFFjIDv6U4yhmT73tvC1dZyQv7txgZFeQJxTUs=;
 b=MxrK0yBqK6wrzFV59GgVTktxW8KzYNmMJE+3aHzt5he2ukFzmBVRv8/8ORjQxF9l/glHhiKuhS3xYqsJM+r/mR91znN9eFfz/9i55Drp6lpY0X7mICrAkZJQKFo1NFY62cVx83wM/QPnvC+wuzqxogRJ6OQKEgBjgnn7JD7dSuqheCkjOXpp2s6QLTfDdAv3ezehR4U49YJ6haT1b2bgsDNLUKYx7wTe2K6JCl9CcJtbQ4hYLzVRz9hcMgl2tyIKdwEZJaps1iFdIVXs0xMcQH10RpJRfLwjK2KNRbi28awBq4FXnQ513ZP+0U7zsl8uEzfRt5fSk2aURZXDclKbXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by CY8PR12MB8194.namprd12.prod.outlook.com (2603:10b6:930:76::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Mon, 7 Aug
 2023 16:36:28 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::bd1:3314:4416:227f]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::bd1:3314:4416:227f%4]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 16:36:31 +0000
From:   Rahul Rameshbabu <rrameshbabu@nvidia.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: [PATCH 3/3] HID: nvidia-shield: Update Thunderstrike LED instance name to use id
Date:   Mon,  7 Aug 2023 09:36:20 -0700
Message-Id: <20230807163620.16855-3-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230807163620.16855-1-rrameshbabu@nvidia.com>
References: <20230807163620.16855-1-rrameshbabu@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0108.namprd05.prod.outlook.com
 (2603:10b6:a03:334::23) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|CY8PR12MB8194:EE_
X-MS-Office365-Filtering-Correlation-Id: 946cc96c-4c3a-429b-da1d-08db976474ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AmymsSNiQxt1jtuHoOkI3KLLFPAXVUE5XFssB8AUEVBRYGj7cHI+iavbq/BISS/wtaO0RnhAbjk4yCcO87FPIaoBzsOummKAimE4YwLUCOX2D6prULGaZZl04+R9mt5uFxS62n9VnsxOvMgUeST+h6Ou2LP9+bBB8GkDpBDyRHE0m25nNN3n+/tmRFDXqBLCbntcYj15a5K/KgdOyAoIMbvd3sJtaF695QJ5R/cDhfyniOBgYUeUusCx3or0QAWbj2ZOKJtJhSCwPe/tkE7spxKPn8uIO2VlIVPf05Ff/hM5Qyo4mv5y+SIA8ZLJhzUhnfLqeb1Exu+mNfq2FQ9wfMI2//8c8cdyErKrzMZCQjnk+FxBsO5PsPEUvEVGIJ4lS151X3x1RkTDeMXojC6MBvefmiptqGUtg9J2Ui0aVfHyzp/oyxc/gzjkw9iJrq86guZiCrwsVefXr6tFZHPzAfXOL3DVbow8kXqRVy0B8n7QEkLDPmnrgQYwZQGxJ/eu3tkYn1w8uo8K88JFeoN/4eZaoNOMZO0jWdZ+cXLbOa22nHp4yjtMkvC4X095SHz9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(346002)(376002)(136003)(396003)(186006)(1800799003)(451199021)(4326008)(316002)(66476007)(66556008)(66946007)(38100700002)(36756003)(6666004)(6512007)(6486002)(107886003)(2616005)(83380400001)(1076003)(26005)(6506007)(2906002)(4744005)(86362001)(478600001)(110136005)(8676002)(8936002)(41300700001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?97uLySpM2XMihRo/G4rESNv1SExPzIC4rnJckupDytJHhhOnquuy357thDsm?=
 =?us-ascii?Q?iV1P3hdn3jipojPg3o+azan837WUcCJJg//5DaokdAskq1k0IRlAiK6V1JY8?=
 =?us-ascii?Q?6CkjJj6rz0euXcMNgFfOhqbEObq66Ha1S2gP9e7O8eVqzUXWxSV4omRwAbIl?=
 =?us-ascii?Q?yiJ6psqm3P40v2Jd2vdwh135OEsKCYqRr4ZymWmUVLafyHOtRbxiUSBBitA8?=
 =?us-ascii?Q?HVEto7rXPXgcrWWoXrCl++z82/ykAH2zs2xBPdXenuBlT8Gz7isPgKV2slxD?=
 =?us-ascii?Q?xeeRsR3iAE+v6iY17PxRZDqyytUdLy1EZ25E1Lo8ryitJvde/wwtUtSxxqrm?=
 =?us-ascii?Q?e1HtaCRDSmCEnNzSkoh+3rn0G1aLs5fiaPj9wSWW+uD31nbTHBGkNxCeA6Rz?=
 =?us-ascii?Q?cB94QgNVAe9oZ69bnxXyNHr07ZmbQinz4xKOoBrXvpPWBDN5eoIgQ2K2RZtC?=
 =?us-ascii?Q?ppycIpcgXY47L3IB6yQdSkjJIkHLbHoP/1C/6dTAhXb66752mKkgf9xGhlsH?=
 =?us-ascii?Q?5I858vRYF0lGeFJ988XiFPyF+BUqiw3A/+JhQvM5DSrCf9EoATxL8wpYxlV5?=
 =?us-ascii?Q?cK+K9fdl0wjHYChurVlnH8TJZPqNK5YrKtAKY2tOY/GF3NneLKeqn6Xz0a72?=
 =?us-ascii?Q?MLoJ48RylpiGRzUlhygTwxwUrqL+ikEkpmx1bT58bPcgDRJXokve7EcvkZI5?=
 =?us-ascii?Q?ls2RKS0iIgPBJp2KyZ8xBCkkzx3b3MHU8m8dfsGXiMG1AWnhsqBuF9qvDyX5?=
 =?us-ascii?Q?Us4kzd4FGvzA9RcoqxJqtjda8AwLIlaniVKo3ujOIK8RyVCcUETgEIhzbRdv?=
 =?us-ascii?Q?2t0pCEfoy6hbOicR+AAAjEaSUo7dfPKJlBmzAxWzfeR4nrePdOIfKlSkywIG?=
 =?us-ascii?Q?yBGUhSjWK5OdiisO7GEJXdLAHHLP3jzTyNFmIiZmgSgmGAxWdFHWK5yOs0ij?=
 =?us-ascii?Q?PzENwMm2hnG2BV7TzyueOKnEahFTHcojpDOKudal9ripSUYSXitOLYRtaFB0?=
 =?us-ascii?Q?tRSVp7vEhobwQ0sljugtRKgYu2sGp4PI0VkxI02x/L1JEi3lUbfE1Kl9tWEU?=
 =?us-ascii?Q?JAj8dUbi/kwU1HfFIi9oy+EUVZUL+nyonM35+zvtj8vyqTvLkCr63YqEAsl3?=
 =?us-ascii?Q?nSrlohj+0z2v7ySCyT8Pt7KTd3D0WN41w+QDsAqkqF7lUJM9YsV3PjRwZVAK?=
 =?us-ascii?Q?ZJ4s/VJsHFi0p00durYuTA7ZVHdxkpLEZ8Kp4xrSJzGxebtgLkktpyLjwM2X?=
 =?us-ascii?Q?dCYlwyLz+GACWUeBZ2xwZLah08DdlVdsFRnPOlkKZfikigI0h2R+U+45eLM0?=
 =?us-ascii?Q?rc7iQYkBpKBLohGmTr27ROK2O/E6SZ6v8jyxO700ILxDPyBPs80h9vFhwNwb?=
 =?us-ascii?Q?B309AZKk7XqV/L8YMKouI7N0wgoqZyZnn7Lqvk8FP4QuXS44xMWfBGQblnyl?=
 =?us-ascii?Q?gbomF1/C1zy9vK1yCWCGlIe2kuka/9SdVjJHo6utPmOQlme9WZvMTeGsSEEw?=
 =?us-ascii?Q?4QAXMKWEGdoRiJLIAiDPNsOAUpr0zohfRlhdMufjBItd8WtlIxIerOMdnCww?=
 =?us-ascii?Q?R/L4ZjYCRMLz6+4fMgK6N8XRhHeetYXD+ppD4pyQrr4PlJjT5c0Co1dytGcu?=
 =?us-ascii?Q?/g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 946cc96c-4c3a-429b-da1d-08db976474ba
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 16:36:31.5418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DPFY4FsNnvxlVM08jAAVqftabKGpu1F6GID1x4UzeZVTZAsNb7fWZeGVxZbtbLsbjoPR33pk8QUUF82jqub+Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8194
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously would let led_classdev handle renaming when name collision
occurred. Now that an ID allocator is used to uniquely identify multiple
Thunderstrike controllers, generate unique led device names.

Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
---
 drivers/hid/hid-nvidia-shield.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-nvidia-shield.c b/drivers/hid/hid-nvidia-shield.c
index 1612de3ef4c5..43784bb57d3f 100644
--- a/drivers/hid/hid-nvidia-shield.c
+++ b/drivers/hid/hid-nvidia-shield.c
@@ -798,7 +798,8 @@ static inline int thunderstrike_led_create(struct thunderstrike *ts)
 {
 	struct led_classdev *led = &ts->led_dev;
 
-	led->name = "thunderstrike:blue:led";
+	led->name = devm_kasprintf(&ts->base.hdev->dev, GFP_KERNEL,
+				   "thunderstrike%d:blue:led", ts->id);
 	led->max_brightness = 1;
 	led->flags = LED_CORE_SUSPENDRESUME;
 	led->brightness_get = &thunderstrike_led_get_brightness;
-- 
2.40.1

