Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93C617A4903
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 13:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241809AbjIRL7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 07:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241791AbjIRL6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 07:58:32 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CFBC10C4;
        Mon, 18 Sep 2023 04:55:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k2WoUic1+IJlrnoD7TeH2HTuWdrFYlyJzrbl8ECeAznoYFM0N/TIjPk5Iz2zEkj2gehLXwvP4QKK/vIGn0vvXZfubLI0D/8E50qOPUCafCEUSsfY3tNIB91RXwVFtPaXAw9daf8pJf0mG9b/n2FsyQpKmXR0l79L6pxh71BDpojnqBVC1Phe0I4W/laiBsnZbl6QsPq4Vl6oeFB6aSrUc2yJ0wJ4NXVPvFNna7pQMXFrL5c1MSxYalDQcwANfkcPFYiE7gX8A7TLDzXUNjA5x0W6REIbWPVMVDtw5hMv2azR0IzMAFEPOH0A+/aPGDFOjqGw65Nig5qZ60Ys8cOFgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ByEztzR3QuMkR9qnReBnsK1Qq2OKwkHGtxkuklAGczM=;
 b=H4plHnD+6iBIrmWLx9MZFX4cF3wIcte1YvmfHS6kbqnpsZidVeng5XTqDbGUsb49X3tLmPEWCX6fA7iyWjO4OlgaqvgZHvchCYFubXUs6hkeaMntNnYi+CKrxHmooRin7mNJdwL1zghiWZXPQPruiQCZ57uAsBkfsi/9KDNjeuJJBDDfN5z+fpM7i3btzDNWUE2jwYV/QhXmxfo20IuaDfdFhnBbUUTVpDLeNJ4tfwtfc5TQ3g/armL1cCV55JwKsAB+5OVdLSbhlfUF1Hzn4n++7xnZgALa03v1J/tnF61K15j3kL5ShCC06J2uBXe7TItzEkF4KAacBFgB9JzP8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ByEztzR3QuMkR9qnReBnsK1Qq2OKwkHGtxkuklAGczM=;
 b=XU1sF9a7Z7aGpQGhaA7ioFVw1unbIRX96Vk61IuiEjKvnBY73BShHUGQWngtPj539yD4l2azYcf6VZWkYN+4QXLloi2g98oOSvVUwjT6qkRlc92Fvv6o/s96YIaJgKE5WMHRImsRGihx72irehy6Qd/cLIbpdRdiTs/+IXzmwFLMkI73jcK1ZkoEAqFneKsqc9mJTuaGGLqCR0Ow8m/QQHeYkKHvrfc55S92j5HbCZXKfjZOiODg6cF5poghkKvrIZc5tnEH68+9quPlOxpwk3DUSkHhYlU1K3m3T0j0jWADOH4l1Ro1ZbREgX0ZDPg+VBdKcu5eoBlFMVQ48RNxDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by PH7PR12MB7872.namprd12.prod.outlook.com (2603:10b6:510:27c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 11:54:47 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::5cc1:1ea3:4ec5:72af]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::5cc1:1ea3:4ec5:72af%5]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 11:54:47 +0000
From:   Rahul Rameshbabu <rrameshbabu@nvidia.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        kernel-janitors@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: [PATCH v3 1/3] HID: nvidia-shield: Fix a missing led_classdev_unregister() in the probe error handling path
Date:   Mon, 18 Sep 2023 04:54:30 -0700
Message-Id: <20230918115432.30076-2-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230918115432.30076-1-rrameshbabu@nvidia.com>
References: <20230918115432.30076-1-rrameshbabu@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0032.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::45) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|PH7PR12MB7872:EE_
X-MS-Office365-Filtering-Correlation-Id: bd7dc719-d49f-4d76-567e-08dbb83e0e3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yMFtArjR/U9JD0u15ZE4lH2Dpr70YTfimHZuTd4nKNjkvYEo27A3B0ryNCemH14wjgY6GKdU2PDRn+h5lzplJ9+bVF4JSBroqqsqVKeLdBG2YK1T5KkbsrUvn4UYoF465tpzovLVeRsqvZ8syQPCKcftcyEti4DX/cGXEte7NI3naLKyVdA40LhEr8uTcoZvh3ubnXNQcicOeLzxRpgNNRylDVuzaOFpQ5d3OlxaBFiQJpsIWhJXfVx/c4SrfrKPGbImvIx5C1Y92ShB49JxWQCrHNw3cSehyYPyoldcuyrM6nuBCmCooH6wPtoCCI1fwrwW35mUtfyi0xQ8t8ursd/yqQ2fOSg4q2bOZkVAGhPAKIDnd/bfIduWqf0VRhBe1EJJN9gKPgn+PGS0Y55Fy7tzWYwkTT5M9HBN8MM4rEJXz4FTXiEUF2DlFqgeFC0RY9m/WiZkEXEEKFVBmiIE5u3w32J2m1bunnwjucdsPcCrPq9Fyz6nqnut6AyDhWb0pWADIdDQtIG/igxcR0gCsax7CxaCrNrYnJpyWXtVqGGp/xp1Om077urdzRA350KM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(376002)(39860400002)(346002)(1800799009)(186009)(451199024)(26005)(2616005)(8936002)(8676002)(1076003)(4326008)(107886003)(83380400001)(2906002)(36756003)(5660300002)(86362001)(6506007)(6486002)(478600001)(6666004)(316002)(54906003)(6512007)(110136005)(66946007)(66476007)(41300700001)(66556008)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I0oWNNpbbfzRFXDC/aavYhtxTq+o6mTcDCYfwl85xirJaMJZ0YgzaNrsNOnw?=
 =?us-ascii?Q?i/NVdAtT4D5Gt5SikJqWCYX3FjJt5eweQk1sQbqFY8JlgR0/ZwEkTsbXFrZJ?=
 =?us-ascii?Q?xg8e07nD04PR5hA+ZgRSeS3xXMhZJpo7Bpl5iElTaUHsuFTg5PiQBBnad//k?=
 =?us-ascii?Q?LVEyPSJdDOEeALNJBOEkA6pzP20RbN7jd8c5e7rQS6FnMhVLeOqg/SsHMTM3?=
 =?us-ascii?Q?E9s+yVaMBwST4gYu4OuqBV/jxzeEGYGWT9EonW82ElewOCuhPKE4Wb2VnkfU?=
 =?us-ascii?Q?lDZ+GlQsnecZt5p6LQRposVAD5Wma1ELm43iZ2uaub4Xy+rPtzyEYLFaiTBx?=
 =?us-ascii?Q?M/miCBUiRoup/YYUadTCG8BkhOcJH9KSuZIDgbhXgNPkE8h5zhrzvNr7x5G+?=
 =?us-ascii?Q?wXytW/ugbUqL/DDq5TcriVGGzAT4A50dZbliFtVKPuEXZqGHsxo1rHBNlvVZ?=
 =?us-ascii?Q?gDio1DQEePx24/9kc7zjIRqk/XKMCdGU+qAyhamrwuIe6QTIMppVG6u3DVwZ?=
 =?us-ascii?Q?kGoYy42XhODr+vhoEqlU/Wo/TltpNddEEwHpdQVTUjBPn270TtBHdkpSW17y?=
 =?us-ascii?Q?3Rs1+VBbW7uOW+nX30aiTVrSnNJ1+ePATRm3eslHDIhpDwUmlY33A7b+n6Bj?=
 =?us-ascii?Q?CUjcHW0Az10TzPf1paGMQe3aOM1fNdYEhjpXfuUnTFmHaKrHHgmIUtTenn9R?=
 =?us-ascii?Q?b+v7+Z++t62RxWaBQj0qd53I53zmYMPgqHl6ET7wAq4/+0mznrwP/d578MUy?=
 =?us-ascii?Q?7Ycm8YGD6V1l0L2mPtr5cnF077tqOpIQ+yKTdFuniBM27d31hW2xTXXVR/12?=
 =?us-ascii?Q?5mNmN+HOQAT0MgWnBwSUFqeRis1HfOEcsGbd+AE95WaeNJmlcoCV2sVjJi/t?=
 =?us-ascii?Q?Bs8NiLA7fen3fcKuvlaxYk/cHZlzcqf6zDteM/x1/dWXAscpf/ZTvUWn/E4r?=
 =?us-ascii?Q?E2rNkDp72MYTWia65uqMD5Mq4eGj2VO4qhjlc/sI//NZvUsS+1NTn9GzYB/C?=
 =?us-ascii?Q?1QnaP4pQP3+kdAVi5V5Ebh8gcIZH10VrZkf4c3HGtViwpAaKEp2GlYHTtPht?=
 =?us-ascii?Q?yAjMlOVG4eT9XuxiC6hjA0VDFka2TNneHVEQ7ITgk2pXANHDRC5XwnKKxL8Q?=
 =?us-ascii?Q?qXRTPDmD7HJv4mLmAwTbiefGo/9z8tY4EwkJvyeU4mgkeqLTTXXGs4R1CKaV?=
 =?us-ascii?Q?yrsv75jSJZ9WfBXN1IwjIuFyyMFNOPUaVdM+eERRTnnOy+IivUWiM2Vgl17R?=
 =?us-ascii?Q?qz2iGh3T3qo3oR0pzSAD57m+e/3poKyZV7WdLwg6tbfu07OjnvhqtUUUczA4?=
 =?us-ascii?Q?Rmt3fiv5Q4340CPTOxy6sYd6eDCJzgOSDeEZGBfFgAePOyZ90OVmKs9gDrvq?=
 =?us-ascii?Q?LXSPnr8GZQS09f+/GoDUc8IV6j0uiiGtFE5BJ8tIEY+ovUN0VfKNMAC/txrv?=
 =?us-ascii?Q?wGCvE1Bv4q5dyXV1GW4VW0fW1FLFNYEfjYWYsdQpVUWRwx/JzDSlnm55wtEb?=
 =?us-ascii?Q?dHVP65H24rAJH11SLYC24GP4FMlsvwFMF5Hl8I/JKoG1fL6oltHttG9WgSUP?=
 =?us-ascii?Q?b9U6XOFrztvgu+WmUKTDtYASVBKT5MYPVXpz9yGQLa7vtfoYbILxwlrPQ0Hu?=
 =?us-ascii?Q?JA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd7dc719-d49f-4d76-567e-08dbb83e0e3f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 11:54:47.0740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CLhhrHljH3Jko+fRaM/tqjaqt6YYY4Li3MGy9bI7fN5yu9d7CPNdSJ2b6ViElaQ8l6Q6Br0mbquWD5mB6Hwd8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7872
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

The commit in Fixes updated the error handling path of
thunderstrike_create() and the remove function but not the error handling
path of shield_probe(), should an error occur after a successful
thunderstrike_create() call.

Add the missing call. Make sure it is safe to call in the probe error
handling path by preventing the led_classdev from attempting to set the LED
brightness to the off state on unregister.

Fixes: f88af60e74a5 ("HID: nvidia-shield: Support LED functionality for Thunderstrike")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
---

Notes:
    Changes:
    
      v1->v2:
        - Add the LED_RETAIN_AT_SHUTDOWN flag to prevent
          led_classdev_unregister from trying to set the LED to off before a
          successful call to hid_hw_start.
      v2->v3:
        - No changes.

 drivers/hid/hid-nvidia-shield.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-nvidia-shield.c b/drivers/hid/hid-nvidia-shield.c
index 43784bb57d3f..c144641452d3 100644
--- a/drivers/hid/hid-nvidia-shield.c
+++ b/drivers/hid/hid-nvidia-shield.c
@@ -801,7 +801,7 @@ static inline int thunderstrike_led_create(struct thunderstrike *ts)
 	led->name = devm_kasprintf(&ts->base.hdev->dev, GFP_KERNEL,
 				   "thunderstrike%d:blue:led", ts->id);
 	led->max_brightness = 1;
-	led->flags = LED_CORE_SUSPENDRESUME;
+	led->flags = LED_CORE_SUSPENDRESUME | LED_RETAIN_AT_SHUTDOWN;
 	led->brightness_get = &thunderstrike_led_get_brightness;
 	led->brightness_set = &thunderstrike_led_set_brightness;
 
@@ -1076,6 +1076,7 @@ static int shield_probe(struct hid_device *hdev, const struct hid_device_id *id)
 err_haptics:
 	if (ts->haptics_dev)
 		input_unregister_device(ts->haptics_dev);
+	led_classdev_unregister(&ts->led_dev);
 	return ret;
 }
 
-- 
2.40.1

