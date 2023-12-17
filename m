Return-Path: <linux-kernel+bounces-2478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 517A1815DAC
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 06:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E96111F222F8
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 05:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67AE117F8;
	Sun, 17 Dec 2023 05:37:25 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2043.outbound.protection.outlook.com [40.107.255.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9E415B3;
	Sun, 17 Dec 2023 05:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OB+s/lgz4S+IJ/U6fi5QWOmmrmbUdpJcdaUGzCJtbuBJwme2m21d4KkySSmsZgqEOapqbQKA/JQkuqfaz0h/iuz6YqIBnK/wPT5//2vblYQRnAkBrLklHVVy8L/IhCQ2Jnpjcno0ptJZKGAcGmY0yL62K710Bm8uFj49WtudyxVcMQTsuBr5czH6SnriqEAA5+YkmGwTDTpDY9gIgWNw91xIMTjyRVBUEWbYXuUSYtLPyxvMdx9CJT17VVVenjF0IFLEbXDzrYtFXIKG0mSF5S2ZgsAC/GLUHzZhRcf8j5OB4ie9IAWladcFyOzqVRXdCFxNCuD5Fg2o/TpaNPdnfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kU5Zf9Ssz6gzoav2iRCbBsyVZmFs47VlB7A/EegGEUw=;
 b=iZXxZTd3TrudoTIk3ejYSlN/hcrjScVBUlswBbhLf4SaKh/n1vTTAcCagDCWzhjyLVqI9uVk0lwhYrl/KofRy/Vc1eEHWiFmXp/EQkPb+cJNtzkX//LLiAt1Hr7bos9R4mVrCHAv/riDxK+1qpF/oJa6Ykj7QmaR0H26uJ4c4nI4a3UgamdGlbbumZ7Hv8tPIRYxBMcKRgrYWWR6Uj92nZqonJrltfNpDZO1/3jqK3LWnUlco/hSf2ogu88X2ug8aO8qAEgL8fW4hiFK7jjsJmi/XDmZu24MY+CtucpjliBpBit43CqWGHHk3M6xpPEVrJZbL06xnn+LiSM9XQ/ZOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cixtech.com; dmarc=pass action=none header.from=cixtech.com;
 dkim=pass header.d=cixtech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cixtech.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by SEZPR06MB5438.apcprd06.prod.outlook.com (2603:1096:101:9a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.36; Sun, 17 Dec
 2023 05:37:14 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::2625:d246:abd7:4a7a]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::2625:d246:abd7:4a7a%4]) with mapi id 15.20.7091.034; Sun, 17 Dec 2023
 05:37:14 +0000
From: joakim.zhang@cixtech.com
To: andersson@kernel.org,
	mathieu.poirier@linaro.org,
	arnaud.pouliquen@foss.st.com
Cc: linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cix-kernel-upstream@cixtech.com,
	Joakim Zhang <joakim.zhang@cixtech.com>
Subject: [PATCH V3] remoteproc: virtio: Fix wdg cannot recovery remote processor
Date: Sun, 17 Dec 2023 13:36:59 +0800
Message-Id: <20231217053659.3245745-1-joakim.zhang@cixtech.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0019.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::31)
 To KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|SEZPR06MB5438:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e5c2ddb-3850-4f55-1ecd-08dbfec23987
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4rH+g/ml3zWshjdijwg5RYrnMUS9fSI81KhFRPqDpHs5T1m4qlue/4XS3GlTVPOVYcwAwlY2bxG/zLfup/YhcYLNGsaiP+EImHJ27DNUqFNAd/IU8jS8OyoBZ7/jpIeY6E6rfsFKLuHJLP5AzKtiwlpLTK7+4SPJcG60qR6WRha8sepIoElkJmjqgZAblpWFm6B780qRhHkYpAy8DMv5H9JBkECjyQFZxaRlC1/SRvZivGcotBN+au2uhUB4QH1TGR2dzx59sHfMV7D8znFEQIp9XF/4HKPZqh0wS0XutUOCG8HNSCq7Pxih+vTuNW9k1wyhT09jYLi8F6sCa6Ra6pR13erBrF77fgC4jgy3o7Avf9BoY4cboH3tglIiURi/lWdhELxGK31U7Evdi5KiSEJuW9g4cWz+8gUfbWANjWKVABZ2SOInOHhFIOBRDYdIRb2ul+qmjY3p2SZDYMddWIUrcslnR0YQFq8BuApYkxZRwvTL232h00SUDFO1kBP5Zg8+V9K5P/R+OOylhzO2o6NdLxLw+KtNsx8GnCnci2ZXYt5oXkn16czuYOrEZBR9MRg0ggMUFAnIBGcuWu2/jVJCt1iqohk7h/rwlG6AjdBIjLl6LqGvvHGOVvnV0AYv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39830400003)(366004)(396003)(136003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(4326008)(8676002)(8936002)(5660300002)(2906002)(9686003)(52116002)(6512007)(6666004)(66556008)(83380400001)(316002)(66946007)(66476007)(6506007)(41300700001)(478600001)(1076003)(6486002)(107886003)(38100700002)(26005)(2616005)(86362001)(38350700005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Gi43NGbE4Fiw8V9A5GMlgTkylCb1009BydAB74A1UZLCHnCnJu84DlhsloCr?=
 =?us-ascii?Q?KRHuPWkgxAXipsOHOQ2uufu/AKTEH8ixs85k4kLVWR5n96kR+egf39DvpTdJ?=
 =?us-ascii?Q?vkf2+vfld5XV2Ryzrn31WcwfEiYzZsf0IURGBBstFV2QtGWDEA+liO+D0Bi9?=
 =?us-ascii?Q?0F7PTYaZjpxLBwYc9kmZmhjb6MYHqjGF+AXZ3TYss5+c6K5xOM9m5ZxR/GAy?=
 =?us-ascii?Q?wLhrr/3c63o82LGSXzRx28JMDdjY7pOoIRTfKwiZgLiJgIsdIsAwensGdR7g?=
 =?us-ascii?Q?hGDVPD5xc84fSTAxNS0fY8OUDc03SmwyuqI30318S9FRNmHCjNj6NQc9gzQw?=
 =?us-ascii?Q?nQTcEusj6pRvLzsL88QVTzGReYsKyKYhWYN+a7zgEoU6pErEnSHgkxYh5rsp?=
 =?us-ascii?Q?yg0/o3wJ7TOJgYkFeQlcR7X+zNX01RWti1x7wBthKs8ODyv/qJFu5x82jtda?=
 =?us-ascii?Q?XvqjEIOJAfZfb0Mpqj0NBaXSylpSyxCTgamOfndhYUaOyGyg1E8QEsd5UgxH?=
 =?us-ascii?Q?2q9tenCubARaZxwSz+vTKTMvlJdK/QYLAtcx9kHlQboFTETBPOGU3fbiDj5e?=
 =?us-ascii?Q?eBidG6Eh4Ms0qq3uPxbVy0Kp2XwEt8BxmhxoOAzxMGn+Fr7/uU6wOE5xxDW7?=
 =?us-ascii?Q?0320UekagLTq+jnuZPqrmI3h4GR3CLGyj99nFvLUbte/EnI6UzFLOXyQEI50?=
 =?us-ascii?Q?maD3JarPfp0/alUvRxh1KOZypZZDNMx9Xr39akQ5s391+rzi6qHsz0k85f3z?=
 =?us-ascii?Q?vgkodl+P0uy/V9mOWGFD+mXLOmDeNdry73CTch4G3AKzZHZQcJnNSaH+htcG?=
 =?us-ascii?Q?RzNMFoSzRVz8NlLB2jQGcSb9C/RrVHCNBFVwtUvG/BM/12ILlYdZwPBw47FV?=
 =?us-ascii?Q?hGTTOt9RPZPosAxThdvP/KMC+YFGHEuFRmP1NgEtvsM0uczOHWjczbnRGZ78?=
 =?us-ascii?Q?KF8G43bFO7zOj6EOjHe0Mh9103N8/rs5lDu/kBzA/HpRKsIpCo0KO3eJhz+n?=
 =?us-ascii?Q?+kgpTyQo64rXrIC0g5DGV8hboqlSd0C4kO79LToo+KoURCugzWL1x71A67PU?=
 =?us-ascii?Q?r2lAh6R01xKsW3L9aqlh0vg6NhpsdCQ6SDxk1kcbVpDNESIG3PN4ygQPY2js?=
 =?us-ascii?Q?uMeSrGIlfxDPjrknyfl/+bFjfOIX/qmbQ2geRUjVJLN+uFOi9KznxbROBQ/c?=
 =?us-ascii?Q?QKQWq/uB/d+qSw3QD8hgEsY5yc8H6t98UUNftpPe0VcSReAXhkLn+WrbyI6C?=
 =?us-ascii?Q?bf4c+CR0KiSSwjfp8jl8GWhHTwP/mYTFItVBlrRs5fO3dPtQ1DfHH5OA0doI?=
 =?us-ascii?Q?3f50cfYPEyD9LLdi+H/71ydDkvmZCCc8ken2n7x81qGnE6zUjEIEBmb0+ULI?=
 =?us-ascii?Q?2c3RX5XMZQFpeSS9BpWCMvFOHFwpGgU3Z2mkBdD/AvNEiPSw0T6PTuhY17Rr?=
 =?us-ascii?Q?AOJgJ4Lwnrwm3NW3V12qxUqXDfy05YCcS5X2kfHEo5v8/+ISczaofK5q0Tcf?=
 =?us-ascii?Q?E38ssgBCK2mgeRHT41bTzd+I/x0lIJr6wgWGFS3wMXU+xvnVfZvaTIi8+Evk?=
 =?us-ascii?Q?Ky+0NYu7LswxhIWmZn/011TI0/7TiyQq6GlrxzgkShaJ0z5DsQ4SZw17CQWR?=
 =?us-ascii?Q?bA=3D=3D?=
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e5c2ddb-3850-4f55-1ecd-08dbfec23987
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2023 05:37:14.8026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7cWSbCShqwt6GtSlejKXJ044Oq94Oa4VsrKLf/HxxJjFVZZ5wBN8er5DoH6+E+n+M2YGWHw64tnwOKM5esKuHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5438

From: Joakim Zhang <joakim.zhang@cixtech.com>

Recovery remote processor failed when wdg irq received:
[    0.842574] remoteproc remoteproc0: crash detected in cix-dsp-rproc: type watchdog
[    0.842750] remoteproc remoteproc0: handling crash #1 in cix-dsp-rproc
[    0.842824] remoteproc remoteproc0: recovering cix-dsp-rproc
[    0.843342] remoteproc remoteproc0: stopped remote processor cix-dsp-rproc
[    0.847901] rproc-virtio rproc-virtio.0.auto: Failed to associate buffer
[    0.847979] remoteproc remoteproc0: failed to probe subdevices for cix-dsp-rproc: -16

The reason is that dma coherent mem would not be released when
recovering the remote processor, due to rproc_virtio_remove()
would not be called, where the mem released. It will fail when
it try to allocate and associate buffer again.

Releasing reserved memory from rproc_virtio_dev_release(), instead of
rproc_virtio_remove().

Fixes: 1d7b61c06dc3 ("remoteproc: virtio: Create platform device for the remoteproc_virtio")
Signed-off-by: Joakim Zhang <joakim.zhang@cixtech.com>
---
ChangeLogs:
V1->V2:
	* the same for of_reserved_mem_device_release()
V2->V3:
	* release reserved memory in rproc_virtio_dev_release()
---
 drivers/remoteproc/remoteproc_virtio.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
index 83d76915a6ad..25b66b113b69 100644
--- a/drivers/remoteproc/remoteproc_virtio.c
+++ b/drivers/remoteproc/remoteproc_virtio.c
@@ -351,6 +351,9 @@ static void rproc_virtio_dev_release(struct device *dev)
 
 	kfree(vdev);
 
+	of_reserved_mem_device_release(&rvdev->pdev->dev);
+	dma_release_coherent_memory(&rvdev->pdev->dev);
+
 	put_device(&rvdev->pdev->dev);
 }
 
@@ -584,9 +587,6 @@ static void rproc_virtio_remove(struct platform_device *pdev)
 	rproc_remove_subdev(rproc, &rvdev->subdev);
 	rproc_remove_rvdev(rvdev);
 
-	of_reserved_mem_device_release(&pdev->dev);
-	dma_release_coherent_memory(&pdev->dev);
-
 	put_device(&rproc->dev);
 }
 
-- 
2.25.1


