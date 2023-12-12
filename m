Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0351980E3C3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 06:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjLLFYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 00:24:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjLLFX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 00:23:59 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2071.outbound.protection.outlook.com [40.107.255.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A57CE;
        Mon, 11 Dec 2023 21:24:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iwl9p/+l7QtXDAOb2kmdEDCXKnp3V5MqO0ZN3G2adpIeGmdZ3fXcokRFsRAhYb5YbXdUliKQqTN8J64n3IpjAezSvJ4XE36h8XCVt5Qmfz5ROinzYOX07W+OsEpwG1dlnv9PT27iVHICYhCGu+3ELwyXgmRPAX9LxRi1KLI5wVAo3jkjaduAndC8uUjS6v90eiDI+ny5paTJuUWkVyphJ5NFjPvwMuRco85k+psfr9TMmDbANK3tap6Z2o/X8k4x33q9DFQn7QH3YFjpmRuP+JKrBFrs9tvoftah2JetXrkpUH1+v3bUgxfEvysM5k7tT0Cb270IY3MU16qvHR7SQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6WHzEij4Zdhj5xhmBv7s+4/UoOUhFSCQ/xLHRYiJS54=;
 b=XProbpmVxzBZgAbL972R1YVVdl8LwZ/ZQwI74xi4rtQ44YDepegKaIAjSS9zn32BmGMDW5hN5E3eznZz1X6lgBTgGgLXXtPFa51vbqZLkvhDBYv4pAemayClBJh17ppm7HFteQH1KCZo5Ji4c4KYpgjx/N4HK/YM8uAWH09vlSPuHxQzf/Qze7JG27KRB0kz8BYzu8myovmJobyz2rgB752jPpgIBua9mMlO0XlrHKNvTx0joXgJRZguA8weK9T7Ac2Czr2mVLJkN3OEDNnJc55zGjmnK4wEgDiX40Q5zmoge1z+be054BtosMjy7Pq7DZ+5dAHqUKTvtMaUjiLQqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cixtech.com; dmarc=pass action=none header.from=cixtech.com;
 dkim=pass header.d=cixtech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cixtech.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by TYZPR06MB6728.apcprd06.prod.outlook.com (2603:1096:400:44c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 05:24:01 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::2625:d246:abd7:4a7a]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::2625:d246:abd7:4a7a%4]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 05:24:01 +0000
From:   joakim.zhang@cixtech.com
To:     andersson@kernel.org, mathieu.poirier@linaro.org,
        arnaud.pouliquen@foss.st.com
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        cix-kernel-upstream@cixtech.com,
        Joakim Zhang <joakim.zhang@cixtech.com>
Subject: [PATCH V1] remoteproc: virtio: Fix wdg cannot recovery remote processor
Date:   Tue, 12 Dec 2023 13:23:57 +0800
Message-Id: <20231212052357.2052629-1-joakim.zhang@cixtech.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: SI2PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:196::8) To KL1PR06MB6020.apcprd06.prod.outlook.com
 (2603:1096:820:d8::5)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|TYZPR06MB6728:EE_
X-MS-Office365-Filtering-Correlation-Id: 0739d0eb-a246-4ffd-3b5a-08dbfad28cd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E1YVsMkktZX8+hQOJTO3DfeKz6Gh6TaYnPbTXyyM3OZjxDLeF5DP4OuZnszEouAOm7Cayf4Cv3uRXWuMIRhHWWX3yTt4wf/6ErdAJ9N2ZWE1xqKEwJma+RrrQJgVCnMmWbiNz7ME3KHdnoRVkL7JNcVlj9SqgVOZ2o5rHCucchN9FaelHt9yeBO2JTU+9eLJ/SOcjuKc4JjYhihltx2+sDnL2s8kd800DiFE26c1nE/x/QI1GxuwB+VcAk77BD49f9b8DsQamXkRKe7nrBRD6C/VivN9DkhR3XO3DUCRL6xH6FKa+Dt0Rt6jEb5MBwGf1oQGPhhkcNjR3F9o+IcoTvNzMJd3tydsZycx+UrOt0oBDRTl7ykK3/RZHnvhP9K5n4q/r+UVmqb/mYr0Xp0oEQolgvk09Y9+MzqI+LEdZsadwjl7xmHKCUgey+Rce01yqFy75uh8s9ldvfC4EI+0IGI2eBw1lj4XHguFV8yFGLutS1frAWLuZrGJfmMsFrK8BW/JCyod7BfWaIzz66Kg1EYSGerkcNuE+HaBk6AMEC2H5pVTgH790oQJjmuWieCl4RGtVdibF/ViR7bVM9w5n5w11zoIGpqHdsNBoanzg4fcsFAiruFRz2M4AjWAbgKW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(376002)(39830400003)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(1076003)(26005)(107886003)(2616005)(38350700005)(38100700002)(36756003)(86362001)(5660300002)(83380400001)(6506007)(6666004)(9686003)(6512007)(52116002)(316002)(66946007)(6486002)(8936002)(8676002)(66556008)(66476007)(2906002)(41300700001)(4326008)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EN163ZZJDV+Xk+NQ61xtLbJizNcTDmckM/fxOS2prcHK/sh6nulKSPORvI7u?=
 =?us-ascii?Q?LG0cEbmk5kz6gL3a4jBu/vznvLZgYaSiA8TO2Tn1gV1m0Gg4NUPnno0sKM4K?=
 =?us-ascii?Q?3gXHmrnj9vDPP71Dg845eyguR224UZ7/Z1lPephuSSR5x0ZAXCqO82fytzsH?=
 =?us-ascii?Q?+IikMHnwER0i5aHtULGqbwZhvUOstIotf0TX3Jac+fpM32O9xmWyrXKXKb7M?=
 =?us-ascii?Q?ZSHqC5G9KrJ/qjSGNgNdXGuMjpxCOZOYozaA9ZpwpcQ4VB6TAD/OHzOAYy0x?=
 =?us-ascii?Q?46D3Ik+joZOff0cA29Up4+c/v40rf+xdHoy+6Qa0Tso/lbzFG2zZ01z8fLZF?=
 =?us-ascii?Q?C7QBGa6D4AjGTtOG2DSHlo6sb5s2KoaYrSF/pqDilsMWgwS16PkgRAhlv8cn?=
 =?us-ascii?Q?WuRnaS5YMt7cYXyRK1nJ3a69W9QveXyx2wPSvwdn0pkRE7z4odGn1dHEs61K?=
 =?us-ascii?Q?Es6jq7e6DHaSMye7YOVXD133yud8U7o9Wtobyw/eh+kIMy8uzL9zy40tCLcE?=
 =?us-ascii?Q?MXsq7JCcsGa0wZDqBj00haA5tB9F/krCZgU3Yg2HfxMpUsJ8+oisiHiTlKsz?=
 =?us-ascii?Q?BiyClElE6KBJyknUZyPvPOTB6hmzAh/uJW+FK/O9YscoIBr8Br829nIDZlfx?=
 =?us-ascii?Q?UghCpDOyoG0LxytdFnPaDf6D4XRqXMwFA9/CVp+VOtaF9MtjZOlyto4XwWQv?=
 =?us-ascii?Q?de+24ZMDjBKQDDRLgSxaoIA9K6r5Moc41t0dpT3MDgHMUZuhAoE33NMLflJu?=
 =?us-ascii?Q?g2Ss7nWeJJmLajYideOEs+aKtQHx3vEv/uP6MqgqvVh9jp0q7elgvw5mFVst?=
 =?us-ascii?Q?z+dj4QSp3V5OHqok2U9VooTArnh3MTDBNxYMXxsZQCPUN5kygciQM9k1G3GN?=
 =?us-ascii?Q?RJiIvWNFcAKNEESMvX3KErTLubYs0wzndfYzEtMTXxoZJMCyn1rn7dDmQrR8?=
 =?us-ascii?Q?mxcjswA4WBiNTjT3qD5/8DLFqb4IHoJinwk3Vmh81kpDGU4X+fd58YbLjkmD?=
 =?us-ascii?Q?txYe+6R0JxSom79nD4MumtXb3PqNSYloinYhI2ZyN0cIB7UMMtJr8CmUZuQU?=
 =?us-ascii?Q?l8XINmIOxPbkotjT4/W6kg9soi/4r5Rax6P12487wXYWGi+Xn2uSikqL2d75?=
 =?us-ascii?Q?f8EXsM/TtoP2q4U4jQE7+z61r2FlVuy0nlipS3/ZTt/0SXY1LxRxEsj2h86t?=
 =?us-ascii?Q?dx+HqOHR39yr6zmD0lnLiLT+bO3jUQm3k4dwM1ItaROf71iO0VmDNaM84L09?=
 =?us-ascii?Q?ocULBMP0Ab1j4SEVeBe00Tf6zkVoMDcuafVMUdd7zSryVSDQ9947cB3jGmi6?=
 =?us-ascii?Q?pq/PLXLFZw6ItAQ7yGE0asLRAWYlEFxGmzU3/5s1UmuVuS7BOP17eW3s/kXT?=
 =?us-ascii?Q?vHeaHjAokgD8WA+A0L+XEWrLGKYpOKQ8qqMDbGJyjyA0gtEi2UqyyBsqmU9F?=
 =?us-ascii?Q?xlI6bgnWQETy5saVOoGsp8nkiBJxxFwCDqhwnVOX2Sm8dztFz0vEjubpFQx2?=
 =?us-ascii?Q?70L0sVVh7FH9KBBya1zhuRQic4sbCLIB1FNWye26Wg51VAu38cwC2N2c+vbG?=
 =?us-ascii?Q?biua94oRr9w5kvO6eEFu5bT8nSlpPFTbTW8iLqlV7ojxZKsPSSTd7iy5dNrN?=
 =?us-ascii?Q?2Q=3D=3D?=
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0739d0eb-a246-4ffd-3b5a-08dbfad28cd1
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 05:24:01.6492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d7j3POFrzOggnhMsR9soKLnNwa4ReYjlWcOk5YjmU2KEzxz0aF8AvTjhr+n0L551gUEHESUF9eeJM3A202Cckg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6728
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Fixes: 1d7b61c06dc3 ("remoteproc: virtio: Create platform device for the remoteproc_virtio")
Signed-off-by: Joakim Zhang <joakim.zhang@cixtech.com>
---
 drivers/remoteproc/remoteproc_virtio.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
index 83d76915a6ad..725b957ee226 100644
--- a/drivers/remoteproc/remoteproc_virtio.c
+++ b/drivers/remoteproc/remoteproc_virtio.c
@@ -465,8 +465,12 @@ static int rproc_add_virtio_dev(struct rproc_vdev *rvdev, int id)
 static int rproc_remove_virtio_dev(struct device *dev, void *data)
 {
 	struct virtio_device *vdev = dev_to_virtio(dev);
+	struct rproc_vdev *rvdev = vdev_to_rvdev(vdev);
 
 	unregister_virtio_device(vdev);
+
+	dma_release_coherent_memory(&rvdev->pdev->dev);
+
 	return 0;
 }
 
@@ -585,7 +589,6 @@ static void rproc_virtio_remove(struct platform_device *pdev)
 	rproc_remove_rvdev(rvdev);
 
 	of_reserved_mem_device_release(&pdev->dev);
-	dma_release_coherent_memory(&pdev->dev);
 
 	put_device(&rproc->dev);
 }
-- 
2.25.1

