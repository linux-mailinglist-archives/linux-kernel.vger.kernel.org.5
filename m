Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA147A4004
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 06:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239663AbjIREPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 00:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239512AbjIREOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 00:14:39 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2055.outbound.protection.outlook.com [40.107.212.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF615C6;
        Sun, 17 Sep 2023 21:14:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MX1VGqdqdnndUryxNZxQrCz41WPJDQ7M5E0FOBctU7wxYFM98bWK5COBzjMAD72qJjUAagocr0Ki8bfwt3HNi4NAp0qvGNCCD0BC9YhUu/5/AJyHrd+SRopHMvCztKoOpemFh7pG6h6EaYLHjNmk5hjzPvJNkclkOcZJJLYkKG1tPEl3ZNdqPpabNIQ0xnp0TjXdrkLwCf8TczILdsCWAEiiUPJK/wJQOorI8e0E+bMakVKBbmCWO/1CCJucrlgh9pV895ZzjyYWdLvUpxdmZ4S0e4AHydctZbFVGEPaNN1p5392XT6AAbLI8VUpuTneFOpeVrH0dmeOBHQxc/Xgpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DDkAfZKRnYEYRLCh+DVXLuzacnaY5ysTyeoTP8bolCY=;
 b=OeUFfSe9dtaohXWCg1wrE0WbPz8UP0KRhwVLoUPQNSrQhhiHgAblEqLrNuqCaYu1J2or6j7D8A/A5i7CYtzf1nut5XxDM117m1oEryLMSrMUYeYgx13KJAyKOo5aDtWP16uSHtB+fGxFTJwzFHWpiXiKr4SSBhCevD6fM88Z1wMLlxu/kfZXVbo7Rwl+lgGWd1K+lSfkjleoh2/pQGmlvHaAnXXfRCN73FmokgOsp2ptyXW/BXdzBEiHUzfgYdaPCgub9uEASLnxF4T2YaKIdIJZUsvb0C2mlGSiovstjwPTorI8ndh82VK9rzJbBDdrog7h/qcnu4kAeuEyjDSkjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DDkAfZKRnYEYRLCh+DVXLuzacnaY5ysTyeoTP8bolCY=;
 b=J6aFPoIQA6v3fI6o2odCFRxWfUq6N7nz3J3+EJN2j5z9xiVQyM6QQO2YINO3TVTb5HBWbmsktEJ9S1/HpnfAM+38nleAQ9Q+4ly9kPwgxWS/c4tDM8aJajyzHrBfH2243PmElPpYzurIfNL0ycuGYD/OxeTYuaEdmfYtvRfRqf1vN/6NunrDC/TGZeh6hymiTFemdQSK/IJw68uQ4Tdqi8BQjG3jsZHmcwAipkOSNozhQfZTTEE8GMpSknYyXRo8sUKS2X2p20WC88LECBpDKsBsvtqyz0/1JsBh82oa8/PimdfF+6dUTxPU2PKysh+HzpnOwEN/itXJmQeihdXDRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by SA1PR12MB5658.namprd12.prod.outlook.com (2603:10b6:806:235::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 04:14:28 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::5cc1:1ea3:4ec5:72af]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::5cc1:1ea3:4ec5:72af%5]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 04:14:28 +0000
From:   Rahul Rameshbabu <rrameshbabu@nvidia.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        kernel-janitors@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: [PATCH v2 2/3] HID: nvidia-shield: Fix some missing function calls() in the probe error handling path
Date:   Sun, 17 Sep 2023 21:13:44 -0700
Message-Id: <20230918041345.59859-3-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230918041345.59859-1-rrameshbabu@nvidia.com>
References: <20230918041345.59859-1-rrameshbabu@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0073.namprd03.prod.outlook.com
 (2603:10b6:a03:331::18) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|SA1PR12MB5658:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fc52610-ffda-402b-6c2c-08dbb7fdc03b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RA6CBe2zyDJThg1+mFse+qAXFzlNboKD5S/UGkJPArJY8odND57pDcpiBhKXl7uHf26iVZu7PQQNNW9AIuQ41vBnb+tgMPEAiMhRvsaiajLPf6g2kJNSLayFY51D3DF2yWxhpLoRoB6hM2aMrRKvIwbIObjhCVxvwrR0fYsg/TBtYzAIUa1XvkHalReDDwHeDVc/KLuQBZlsozDRCUD/wTydS6IIf42tABmVWTUESRxnxYVcmOekxh90N81aOlSeXywj015Lr0ao1Uic/Q9Us4X4wUsajIgH/mbiZlTQJyfIW0cR3BfL7tIVX1UDvLsfi6yfMRRRov8MpUMA/C2Ca/4wf9pFUXWWIUiaHjedwG9SUrsD16qLSg498X7eoNMBphYV7j/thn5P9x7wkZ4sCNRXR2IuIwUMiBksR4msv5TAbPC+ffKKHYB65+zZQ+BMCQu/8Cd760f/tZpEKF0AWkiyY9ooGAb5BDft5yh2s+epY9/uuL5/xhGIvusOquJUT8/692scB3pIyf3tssO9FXc1zwG509lrzfdV4w20h3oQ1Q+K80ZV4bgDXKZrNbvk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(396003)(366004)(346002)(451199024)(1800799009)(186009)(6486002)(5660300002)(6506007)(86362001)(6512007)(54906003)(316002)(66946007)(41300700001)(38100700002)(66556008)(66476007)(110136005)(6666004)(478600001)(2616005)(8936002)(8676002)(26005)(2906002)(36756003)(107886003)(1076003)(4326008)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LrOWrlG6qVhqMxEwgYFIw3LbIyZKdU3lMSoETLL10vWCBYLaTjta4bY0BPOs?=
 =?us-ascii?Q?aE8l46K8E0owMekM/ESzV7VmGGGpSidq9IhfEe+D5407NwFCwNI2U0cLV6c+?=
 =?us-ascii?Q?8f7+JBf/Ze7eIpWYk6+Rbsv+CBmluSaxCrJGd6qWl91Kpsxqf4PpjKB/etwP?=
 =?us-ascii?Q?bbuAt3CDVFZc5zsPcPwSUlvDDhOD/uJ7LVSfo+dODHXTFi9LlPAdYYc/GcP3?=
 =?us-ascii?Q?Yhi88VTLa0JZce3XN6mfAvOVstjzon3Pco+b6xj9/FOwHYUJkJS0UFsfIgbq?=
 =?us-ascii?Q?J0QATtBL8KnOjVZ0Y51190L5exZusDUK+rVM0Ejly/xbPljP8IlNttPRg4Ub?=
 =?us-ascii?Q?8pgl7g6xQ8z0r6OuKA5kAQ3m8yPJZZpxLfg1RgudDozUWagkSqPMPskALSOt?=
 =?us-ascii?Q?GQnv7+rzRia+uiZiYicpFCKTGexMDdA1V4wvG6ObqCR67JOmQOd33D+mk6G+?=
 =?us-ascii?Q?zvy9U7DiRTktRCtweD49xG+qhOXEb/qjrDZKPkyz2Wb7ierAurve/BStNfgG?=
 =?us-ascii?Q?i+e5kfw11MPpb6td5kpiJXl+ssC82ubWiu/TCjn5F2I3QOLqQC2ft/LNg/Cl?=
 =?us-ascii?Q?BHzgJYOrsykg44v+zhYaSdARhZQ1xBNFDoH8Y7qat3WnYOzBYwYwLik+oJ3z?=
 =?us-ascii?Q?vQ3Et3TIdxqF8aIBjcE7bQ05hVfSreeZl0Bpo3LHJKW6YoirhgdlY4kxKR8u?=
 =?us-ascii?Q?RurZHDjTNxxRIhryoaCZEKJb4f2GhloDq0g/DCMErThJNvdMFZ08gkQgrF+x?=
 =?us-ascii?Q?nSwvPo9JRPWNsUyo4cDwtUorUAuh9KPpgK5zDHx4sWUEMrN5XicxQNnZZ9Mz?=
 =?us-ascii?Q?sEHnBKbjYhNx4q62FIz4/PR+Zr7/bf8qeVwi5U4UB1YVZyXA3phz0kNrmXn7?=
 =?us-ascii?Q?lyBPn3Brjv5Mcd2abju23gvzd00pOa8959wo4iZoZM6/HNpFl6D9mVIOv1Ze?=
 =?us-ascii?Q?9i7LQV1WG+GvBYglGNx5FRmm4qWGOaBkWx2E9LZOT926GZNagsqAXV739L/q?=
 =?us-ascii?Q?pF+Qo1LnIqQGmjui3XQeDjeAVeJyW38XR67flWSeuCUisgNgkUcr/WmaJEaM?=
 =?us-ascii?Q?15E27ityoBgmuMViDkgzkYitfL0eHOHe2Ku5Nw6Xup/miHiHwmCq3hqnAUMd?=
 =?us-ascii?Q?PltJSYcy4RO35LQOrSHj/PSJlVlY66oAwFhayxZb2igFOt3gW0xLX03XC9d6?=
 =?us-ascii?Q?sZRqItckClJd47xNSv0wslu+m1jKPaNWRfsSW7ldYuoirgTrdXm3Tcc8dKr6?=
 =?us-ascii?Q?RHIGl0VIXR9plKRAr0DnKHqVsulFOuf92P1nf4iFt0Sd0EdXsywyUmOnP3xj?=
 =?us-ascii?Q?lEby17S5aLv75rF+uRhOLhbFKhHjKNCWw+Xvuar1e2s9x2mm6fiKdC6WrCI4?=
 =?us-ascii?Q?2HP/4Cq52nSTwPZKTtFXQuSO/ecoBME6rMKMG2FGLnA8Z/h42BAN3FCNx8mo?=
 =?us-ascii?Q?6/ZBJ2/xErs3frTIk4Pl5Bb6uoFlygRilypINdsi3SmsLji+xuBKZQTOrxNg?=
 =?us-ascii?Q?0r6n5E8dLQOXvp/D+WMEYF41pEA77a7hJheowCBTqzCYR40l305QjmHF0Cqn?=
 =?us-ascii?Q?+Sb3HSQuUDFc2zJ9BNBHudFSoV47i19E4EmeTUow?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fc52610-ffda-402b-6c2c-08dbb7fdc03b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 04:14:28.4003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6fqbvQ5MGM3AD/y1ghNjhIaXDaPdWEDYPZ7Fz7jgElRRwYF/47iNVAPEZZpfj+iGxbwkFDb1Bim35ZRYv0QlOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5658
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

Add the missing calls.

Fixes: 3ab196f88237 ("HID: nvidia-shield: Add battery support for Thunderstrike")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
---

Notes:
    Changes:
    
      v1->v2:
        - Rename err_haptics label to err_ts_create to make the label name more
          accurate.

 drivers/hid/hid-nvidia-shield.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-nvidia-shield.c b/drivers/hid/hid-nvidia-shield.c
index c144641452d3..a566f9cdc97d 100644
--- a/drivers/hid/hid-nvidia-shield.c
+++ b/drivers/hid/hid-nvidia-shield.c
@@ -1058,7 +1058,7 @@ static int shield_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	ret = hid_hw_start(hdev, HID_CONNECT_HIDINPUT);
 	if (ret) {
 		hid_err(hdev, "Failed to start HID device\n");
-		goto err_haptics;
+		goto err_ts_create;
 	}
 
 	ret = hid_hw_open(hdev);
@@ -1073,10 +1073,12 @@ static int shield_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 err_stop:
 	hid_hw_stop(hdev);
-err_haptics:
+err_ts_create:
+	power_supply_unregister(ts->base.battery_dev.psy);
 	if (ts->haptics_dev)
 		input_unregister_device(ts->haptics_dev);
 	led_classdev_unregister(&ts->led_dev);
+	ida_free(&thunderstrike_ida, ts->id);
 	return ret;
 }
 
-- 
2.40.1

