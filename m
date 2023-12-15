Return-Path: <linux-kernel+bounces-1134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AFCC814AF9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6FD41F24AC8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2782D3589E;
	Fri, 15 Dec 2023 14:51:11 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2040.outbound.protection.outlook.com [40.107.255.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB2631734;
	Fri, 15 Dec 2023 14:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MMOuGSGsZE8eDr1fqtEyW8o0s6s/fB6tpjOfK3o0W8ka8FDzLbKBhQ0f/iKqbRBNzEDz2GfpoM1LF5R+Tq/WS6QFtldaTjZAzzYu6MNXB1CJrcqEOUoQHGmWZwbSy5OGjBF+OcBKHdZosjkzPX7MB7/o6kIUzSezGOFMvpXdKVfgLcKHdSjsp69OXzcCpVexypGY/1XYoPDJrIIrDXr84LA+RkY2h+gV/LSkkr7MWzw6QiiVVH5CNcsY7I6kuFSJQdrPEHd3ELvdxOipdSXPfHD20JYImhLvPoCG0DGVtjaYC6ELuXk+PN4Fd00Bd3tgZoWGiABtBk5ed5ci95IkTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IaVBmTTVogGJwFJmb9CEKtR4Qze1bpn2IjKHBcf08K0=;
 b=jofh9/Fc3pjjUrLJO1Ysg7UDf9ujcbb9TMbdi2GOCT/LCqt2rTL4d+DvABtW/NhNf3P9XiiAIX7iKVIAt/MlyhpahcJsiSb/DBOfU/jOmXtu9RFUBkIvsFjM7Ra3BDKnoH13DTXzmFGsbkKHKkpkLnIGHEo26/6n3gAyblOoM7SFjvgqPOYnfaw/XBSNrUVpjsntFXT2jrZ/HbsOYyUcArDXX/8Jx35e3u/Fr/J0P3NpTn2A2RL7/bx5rTVMyDQR6II+TmcRZCeTON1Ov8N/zAnaaan9boiMnEtPZI9LT12vdFL/ZeAoK5Z6Ux3vvi74BM3xqXTVAPwGiwJumllgxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cixtech.com; dmarc=pass action=none header.from=cixtech.com;
 dkim=pass header.d=cixtech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cixtech.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by SEZPR06MB5967.apcprd06.prod.outlook.com (2603:1096:101:e7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Fri, 15 Dec
 2023 14:51:00 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::2625:d246:abd7:4a7a]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::2625:d246:abd7:4a7a%4]) with mapi id 15.20.7091.028; Fri, 15 Dec 2023
 14:50:59 +0000
From: joakim.zhang@cixtech.com
To: andersson@kernel.org,
	mathieu.poirier@linaro.org,
	arnaud.pouliquen@foss.st.com
Cc: linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cix-kernel-upstream@cixtech.com,
	Joakim Zhang <joakim.zhang@cixtech.com>
Subject: [PATCH V2] remoteproc: virtio: Fix wdg cannot recovery remote processor
Date: Fri, 15 Dec 2023 22:50:23 +0800
Message-Id: <20231215145023.2248366-1-joakim.zhang@cixtech.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0201.apcprd06.prod.outlook.com (2603:1096:4:1::33)
 To KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|SEZPR06MB5967:EE_
X-MS-Office365-Filtering-Correlation-Id: 21367383-a1d6-489a-0491-08dbfd7d3ffd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Gr1YdwvXbIcakaLvhWHj7pN0LOvRrUoNY3Fhl1u6i0M3xehLKV9qcSqvFIImW/hIBjCIMQ9a/dlMwhyvcrzzsy5PvYQZ8rrFDW6/I0zMcsXxP+AA+ew6oJELcRUPxRu1gOQFKW/hRaFfQ0+zmzJm2feIV4zVt36+IVbCgYM/uYgwu6bhTrKFiWd9c1e1gDZpYKLJUT/eLZSGRezlWROrFnQ/xQ+wsF/o6HhKMc7r65e2WmU4khkkFiubHbDeKqSysjZywqBY5Sjn6NE45qGhZAF2wBglqWC/iXSWlG020NOpgHqY4Dt8WQbVKxTZLa5b+932/6+M6+7i+/ty9tDARFH34P3P/Ynq5sDMeApg+eSd6ZIczHmeZbnRzmianmAmQXIHwf85htzweWkqWfSh2168I3iUQb1HEPQLxN9ykvt7gEOUAo2Xh+oZ0t/wlagZiCcfpH3mG9ZEYHNH3VHOBbm+qezNvLjVNdlEk9k78egZ5yrg3+e3mcqQ9Co0zS6QAIiaZLNKlgpTvDOihqe49lz8BIiz9MNV5iEuj+jq8Emh5ucOf3Wp1dqw381aEjpFJbYKUWqvL5Es0BZZH51+GiWA3k71DX46N39ek1BF9jFuFZAVgIjw4LNMopDqvLbc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(39840400004)(376002)(346002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(83380400001)(6486002)(478600001)(38100700002)(66476007)(66556008)(316002)(6666004)(52116002)(6506007)(26005)(2616005)(9686003)(6512007)(1076003)(107886003)(66946007)(86362001)(8676002)(4326008)(8936002)(5660300002)(2906002)(41300700001)(36756003)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CI+stEW1FrEGLBKhMBqj+ml0bynUbKDktvadGzIw4fTe8lN7dUigwuzFlibA?=
 =?us-ascii?Q?4IYkBsc3PONKD/76Zz0pyt3dJTrbgI/NPIyAt8hWATwi3A2evUEVVHh8LX7h?=
 =?us-ascii?Q?aEwsorgEPZ4/4puhSRwCNb7srDFkcmSMe6rk1kPrZweA5aQE+jrT8BmX8hhF?=
 =?us-ascii?Q?R107Kfa/Th0Rbdymtvs/0cEq8WUHHKJITUNLIiGhP/FH78UC+e36r3GdlkI0?=
 =?us-ascii?Q?HK14ekPk+Miy50ykFcTBTs020KitJ6hV1PTopLDDHCVZ0uOfADXtDlCeU0Jy?=
 =?us-ascii?Q?SEgG9JDnhQBLmU3lEJ72TijBYJF9MEMpMIpvrrt1i0Dh2PP+33sK4FRLLmkT?=
 =?us-ascii?Q?Hs+WE8bmW8DhRVt++Gz3QGW73x+2CbEL2JHBCYQisMfQ1fCFxkDf4TG0EXzR?=
 =?us-ascii?Q?j0zRUkMqvoWTvvMPctE/kRGvo8VBZS7n9g7V2CX56nj/rDIHXDm1F2/GWrX/?=
 =?us-ascii?Q?xYZCYyMXKrxNZ2SXUDPcL/3peHc/26kT2HBNp+BYqFRQfcHXnzXQXuKE3lJ1?=
 =?us-ascii?Q?8s+jZLkj7ctKDQk/qD3JXsxf7ncVKy9/dK/6JicC2KZ0rEhumpGDC9DauQbQ?=
 =?us-ascii?Q?zrXhrXqHtlOWgdBlTO5sai9U2PdgMHiebdh2RZdX1iL5D3IMze275PcMFMcY?=
 =?us-ascii?Q?PEBLFN5qmYL28devzRf/MsuKxRKuRQmCK6oO6Z0IDZlAN0iKsrhHv7Vgw7zS?=
 =?us-ascii?Q?e4LK/osOdkuRZmCwyiBkBpakFDHJQ0IuRuGFZfdaHjpkm51lecFHGZDf67lI?=
 =?us-ascii?Q?NnOkqC+gzqPI6eMhngOG4rnuZ8qyomQsBONrQGDu4tmPL6F0B7BHf7jRsXWo?=
 =?us-ascii?Q?4zB0rQbE8hLb9bZEmg7JKX8K+29kMMy7hOxGqiS2wilmL5AizRYBdU19pbSt?=
 =?us-ascii?Q?uf/FiYamdOVKIKZiiJT8C64eyp6JUS6C8OKVsaM/IXPUXoFfnEXPyCCHoJ2g?=
 =?us-ascii?Q?vMYePSBMjanCaE1rIcYr26DwAlW6MYI4DHcEiqoUsfXtXmur71lwIwbgEwFf?=
 =?us-ascii?Q?mrXJh9xPODuaLY6o38nh3CivI/Pi7Zh7KXfWMOEBi1X/oAdePdld3mXz9qBc?=
 =?us-ascii?Q?esVRMYqUp5DzVfQU3DDirq5ppQQ0CQICvzlOdO8JL7QqHOK3E1zclmrwFoAH?=
 =?us-ascii?Q?JRHBlslyeFPA/VqqMEL01XMW3LUhoQlBofHy4vyMplXkdC936A5YvBe6QKas?=
 =?us-ascii?Q?vo8sXBShjyvI3HPM1uak1QbO1Mvjzn0WFWm23cK2r7KJPZiATl+gd8oPoHzN?=
 =?us-ascii?Q?h+cTnb7C38zV46TUP6wOL9VRWFAMdSxDPNO+jg3nKCbNf8kLk4GuYh9zO/cs?=
 =?us-ascii?Q?Dpcp145wm3sIvRh4q11e9TNQnN911QEydWfgeU8K7PAlqMqZIv8ojnODIRNK?=
 =?us-ascii?Q?LArQndx39XuoU3Jkr9heLr8wAo28wKkystv/spKBp5ZntTNlkAHgBPO4j6yG?=
 =?us-ascii?Q?Txgb9HyYgkzloKn14s+Jl8GGuLDJto9BBozjCjDRPYYSmlIcBcDg+hFspJir?=
 =?us-ascii?Q?VZsxhxKEn/J/DlhRF0S5XmphMv6PJoLx9gNxptbe41NzCgqQ9MtsVP7FkQN4?=
 =?us-ascii?Q?/1eDbmjM3JgD5l6CkcNeTiiF+uAi0bEKBtlt8xl58Ee4HnLEw4J77zd489eJ?=
 =?us-ascii?Q?dg=3D=3D?=
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21367383-a1d6-489a-0491-08dbfd7d3ffd
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 14:50:59.7608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t3vq52V5O/bee17d/G41p4q20hDca6uxhhapiw0LnbLIChAyOXghLTuPxucvDC2qfzcKHgJ48GAK1VAKWLZlxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5967

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

We can see that dma coherent mem allocated from rproc_add_virtio_dev(),
so should release it from rproc_remove_virtio_dev(). These functions should
appear symmetrically:
-rproc_vdev_do_start()->rproc_add_virtio_dev()->dma_declare_coherent_memory()
-rproc_vdev_do_stop()->rproc_remove_virtio_dev()->dma_release_coherent_memory()

The same for of_reserved_mem_device_init_by_idx() and of_reserved_mem_device_release().

Fixes: 1d7b61c06dc3 ("remoteproc: virtio: Create platform device for the remoteproc_virtio")
Signed-off-by: Joakim Zhang <joakim.zhang@cixtech.com>
---
ChangeLogs:
V1->V2:
	* the same for of_reserved_mem_device_release()
---
 drivers/remoteproc/remoteproc_virtio.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
index 83d76915a6ad..e877ee78740d 100644
--- a/drivers/remoteproc/remoteproc_virtio.c
+++ b/drivers/remoteproc/remoteproc_virtio.c
@@ -465,8 +465,12 @@ static int rproc_add_virtio_dev(struct rproc_vdev *rvdev, int id)
 static int rproc_remove_virtio_dev(struct device *dev, void *data)
 {
 	struct virtio_device *vdev = dev_to_virtio(dev);
+	struct rproc_vdev *rvdev = vdev_to_rvdev(vdev);
 
 	unregister_virtio_device(vdev);
+	of_reserved_mem_device_release(&rvdev->pdev->dev);
+	dma_release_coherent_memory(&rvdev->pdev->dev);
+
 	return 0;
 }
 
@@ -584,9 +588,6 @@ static void rproc_virtio_remove(struct platform_device *pdev)
 	rproc_remove_subdev(rproc, &rvdev->subdev);
 	rproc_remove_rvdev(rvdev);
 
-	of_reserved_mem_device_release(&pdev->dev);
-	dma_release_coherent_memory(&pdev->dev);
-
 	put_device(&rproc->dev);
 }
 
-- 
2.25.1


