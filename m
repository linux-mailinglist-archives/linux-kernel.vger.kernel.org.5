Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091447A48F3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 13:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241701AbjIRL4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 07:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241346AbjIRLzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 07:55:51 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64EA10F;
        Mon, 18 Sep 2023 04:54:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Exz7EGtXsNfBwM1pdmIOZ3TDbuuwshfb4keJsaTKoNaNrE3PVIJYZq9wbsrLEy84f5rZC3oJugBg2pQ9F4XZKSARoRmm/KPnd6P1FT6ud4MDMFd0YMZmc9TEJTB/GoYZwX3m2C1fvlIa+ouh52hrkY4XSeiXd94azr7bn3KnUncDUt9EgSrbD2ov9bPtjgFjjtHwAY0au81V8hhCXRjPGCFtHLpDvurX02o3Lc6ZbmsPNoJv+VzGFBSKMzbCjOVvZRIVdC+u1FEWTow2VuIU6G3gq2LJiRaF9YVAyGn0LgqnRXF9LjJO2xmWt3CpR+9QULQeWoj2e6BzV3YBpgHI9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aeb7NXPu+SVpuJcq0GnojPrdoC4Ed6o8r6TYXWxu18c=;
 b=Okli5iyhrTaTKmMd9Ha1D876VKvV8Pqe0uNdv7t7fPBAC191iLWr5G0Luhb+1b24LjLo6a+UcdNg7E2dmLnvnI8g5u4itJa7pcy6Oy29ZRNeWNsKM3ZFxcMtVm7Ohrsp3I+sk0gENe2gYoMlQmRH9wO0EWwUlIWCBgNpSP/3Pot+iE/S63xsUijgY06JdaStZUe31K1c5aOIOpyIMzpL0SF2gnYlANtIv2/SKiCs2NmXF4ejpAqpaPFb8cENfp7zsihqFtm9mKjBq9uI1jxHYrN++Vyb8rpefA40cJuq+LfBnGp4h13GSnIDgaL6oM2yl+kWH1IE+t8jws250qwOfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aeb7NXPu+SVpuJcq0GnojPrdoC4Ed6o8r6TYXWxu18c=;
 b=JH6Ktx8pJmekqwJwZBDzSxZAhlIgMz1W3ZkJnLSDu4TWnCDFQChDEmHGdLqIRHwxos5qvDYIvrzIXgqV10EXZa/LnOyIiybsG5bs43FrwDHF11+LNz0oA97OZJTrU6AOOxgQ8QBs0huWxRNgGwp5lkwW0U2RssYBWYJp51p//veNqLwQ54u7NT9s8ql3hNxydxtZ1JJ8RP+edcWgyVPhKtpSYfGdx1qUG4OLc48ZUapgAB09qSmc6kU3Iw6nnlIQM8vhz19BeIxRS222N5jCLYz7+dreKqXngYbek0uljFy9iTNOCd+KHRQmCoelBTJrpv5JLzqRD7+MI7TB5p5FPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by DS0PR12MB9346.namprd12.prod.outlook.com (2603:10b6:8:1be::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Mon, 18 Sep
 2023 11:54:50 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::5cc1:1ea3:4ec5:72af]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::5cc1:1ea3:4ec5:72af%5]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 11:54:50 +0000
From:   Rahul Rameshbabu <rrameshbabu@nvidia.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        kernel-janitors@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: [PATCH v3 3/3] HID: nvidia-shield: Introduce thunderstrike_destroy()
Date:   Mon, 18 Sep 2023 04:54:32 -0700
Message-Id: <20230918115432.30076-4-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230918115432.30076-1-rrameshbabu@nvidia.com>
References: <20230918115432.30076-1-rrameshbabu@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0002.namprd05.prod.outlook.com
 (2603:10b6:a03:254::7) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|DS0PR12MB9346:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c6d9c14-6bba-4e28-5d86-08dbb83e1036
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CREfAjYvumeXMZoZQ1mp5W21Cif+fDm3hvDmcyoHxjUSWeB+pBzM6GR5EuA5IZEAvG3xlXcyZJnBLG2S/5RtjBBE7nHsToZMAUJAsoDFMTprYkv5ED0fuTbRMrLME8X604vUkp788lTL7fVJ80oBTE3kfSpuTqOiYwNPyZRrVLsvi0sMVI68vTWvSF8FzxfKWnBLRPHL6kWQYLD0WEZAqn67wCu4/PtB/1lEcBkBYPjL9PuYBqFc580H3Xl1Kz0LdalIFtmc8rZUnuYOCAVMdE01kAqNZXTJiIje6EwLwuWQpcPPiKXtLf0M4QCDURDlhPWzihnjMi1Dqd3RWnpZNL40XHtB4P1xES5p1jsZ5SVeuSSILpMW35aRNvAAvW5exEwEVG7revOsNImYVh4BBx+RuSN+R12odMcwHo1hL9jNzJSyh+S7NT0TOIIoPddvyIRXkiF6yGidmFjsM9bvWKzNRejRsynv9vZqZssrgiKKUaYKYNQOygJ3+PMGMnJdKz2WGXPwVQrDEP2Rymvn8OjVH+hP2oSiKm32ToJHG8bH2XkDqPWe5l4dZuiriw6v
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(136003)(376002)(346002)(186009)(1800799009)(451199024)(6486002)(6506007)(6512007)(6666004)(83380400001)(86362001)(38100700002)(36756003)(107886003)(2616005)(1076003)(26005)(316002)(41300700001)(8936002)(8676002)(4326008)(2906002)(66946007)(54906003)(66476007)(66556008)(110136005)(478600001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1Y6Aa8yCZiwDRtjc3+iOaMyrJPO6Enssffq9KPmpjlskIpiD4zAYPl9Q0PrK?=
 =?us-ascii?Q?Gkii5eNrp4/4s7XTOBprjmhPxB9RmMWiwa0+llmVXW7jqm/y0bPPs+ijRzyW?=
 =?us-ascii?Q?PA+nulU4PQlpo5D/sbz9iAOfhHliZ6idfCQQPCKcmiMmCIEBWkiOJAQ5bl4n?=
 =?us-ascii?Q?OkwoxowKgJRkgGFenCuUvY+xRU5eQy6WufPxx7LhSK5zo1VANEpDBoHhfM1l?=
 =?us-ascii?Q?6mme5jOQrR/iPijLKGQNAKqIcaY0No+Hpeae8t9uHfeyiuuOrFHKHD4U/mFy?=
 =?us-ascii?Q?PsVWMpcLeybTTP1R50comyNmYeyCBtiKzld1p3MFc7SlIoPaXKEeEkLnwptZ?=
 =?us-ascii?Q?ymAJeys/57eXT+9hEdYWb/qFCHjP3vy1LkNPe9BC2tVhtRBtcEz0EQ0Tufwr?=
 =?us-ascii?Q?U0AeTDZvUt+pgorBxVVcyyWk9vGuv868RxIdHZ51lvjNtLK00uYz8psqkloi?=
 =?us-ascii?Q?rFQgQKlHR611XCzGMe4R2A+aSb4hwgGt0b7pS0mzkFMnx4XYvvpV8Zux4x/C?=
 =?us-ascii?Q?0rJdoVnl7yii1uD6IAhfZGIbwD0YHD8wBM9z1IQB8kJNKsPhcT5oMQ8MsNjw?=
 =?us-ascii?Q?zP6FjElKx+FMK0Gspkhve1gwYWTbhkklr6xyKRs8J7mCQBl/9MtxKe7ogedH?=
 =?us-ascii?Q?Jdk7c6XlMxZ1WBiXSbK84wH8zHsVrnecLMY0VnCqNwVUGN5A04CG7PzziLVg?=
 =?us-ascii?Q?GKVUh6/vJBsuSrcjnATLJz/Zii5RpTSYWlAug4PpaBCdVdMkQ930+maHO3ZG?=
 =?us-ascii?Q?Ipc+OJRPg7GXE0NTubZGKKnJpgLZidBlDyYAWnaqv7vXXolnDXI4GqyHNUqL?=
 =?us-ascii?Q?xWvprJFOavRUqvb9Nbbog6cwhyqNLLUwVGFAH6cw+bGXTl/o/nwkrEvLsITF?=
 =?us-ascii?Q?RzTnkb8q7wyCgF5ohat1eIcqqUYejWauqZiYwz8PAL4x50SSzYzWappORE45?=
 =?us-ascii?Q?bRS35gqkSm34UVFnh1Q3MkzzOILA2VodxwPBRbaOuyBxjbBLI3xeZ3E2h6RC?=
 =?us-ascii?Q?BJRb6Jgmbvo4jvEhLxblPwXE5DbDSbE7ovFJiOmlFynY6tYKPEBKIZLS+8sL?=
 =?us-ascii?Q?GWg5KZq5FY0k5qgtMeoT26UT6Yn3Y3GzmrD4LpdEXolSvT+PNmF5u9fNDBzL?=
 =?us-ascii?Q?KdLH5+tr+NxUwAw+VtSfc50QRlCsZ5uDiQN8HnmTx4hf/Jgcxjkx9JztIWtf?=
 =?us-ascii?Q?kMHJVW7vm5CSAsNNDprICCMgI612DBWWNj5Lj0gGrc0Vm3iwl9mFwit4tJQX?=
 =?us-ascii?Q?owV/wVV4zF5Eh7/NjpvSeLAXT5wAQyupWvlxsdYjsXk7FdUayC+6PWhncWKS?=
 =?us-ascii?Q?D8Q6TkkxncN7a/cHDmOtMI2ElkEnHjCnf7+ng0xE7dy4Su0ChkAqqJXJTsAE?=
 =?us-ascii?Q?rt5uTyu9+Wh7VtG6eDsOvT5PwfyrDdrfj2/GCEs8JVzpGKZs8J4XJcIQeWqE?=
 =?us-ascii?Q?6Jf8g/IguvyQODBCUgA7088+yex9RosuMZ4I+X6HpnkbP6sqLCBS0vmZNFj0?=
 =?us-ascii?Q?GKthtWAc7ILQApq5bpo9wbousykonSjmx6CCKa2W17qwCQKBL2OuCxhq5tlh?=
 =?us-ascii?Q?+EiQPbpAe6X5O2Gz8bUZl9m85hs52Maq4gqepVle?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c6d9c14-6bba-4e28-5d86-08dbb83e1036
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 11:54:50.3746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xyr4U2Otah3fjMO0zXnA/pnjdqjuA4zOO/Sshj85hAwDcUYCcgSFPgv+HtOXdvPisOwsz7tzoyCeOnh0bfFHXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9346
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

In order to simplify some error handling paths and avoid code duplication,
introduce thunderstrike_destroy() which undoes thunderstrike_create().

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
---

Notes:
    Changes:
    
      v1->v2:
        - Re-order operations in thunderstrike_destroy to be in LIFO order with
          regards to the operations in thunderstrike_create.
      v2->v3:
        - Refactor thunderstrike_destroy to take a thunderstrike instance
          pointer as a parameter and prevent a variable from being unused
          in shield_probe.

 drivers/hid/hid-nvidia-shield.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/hid/hid-nvidia-shield.c b/drivers/hid/hid-nvidia-shield.c
index a566f9cdc97d..bc47e19ef117 100644
--- a/drivers/hid/hid-nvidia-shield.c
+++ b/drivers/hid/hid-nvidia-shield.c
@@ -915,6 +915,15 @@ static struct shield_device *thunderstrike_create(struct hid_device *hdev)
 	return ERR_PTR(ret);
 }
 
+static void thunderstrike_destroy(struct thunderstrike *ts)
+{
+	led_classdev_unregister(&ts->led_dev);
+	power_supply_unregister(ts->base.battery_dev.psy);
+	if (ts->haptics_dev)
+		input_unregister_device(ts->haptics_dev);
+	ida_free(&thunderstrike_ida, ts->id);
+}
+
 static int android_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 				 struct hid_field *field,
 				 struct hid_usage *usage, unsigned long **bit,
@@ -1074,11 +1083,7 @@ static int shield_probe(struct hid_device *hdev, const struct hid_device_id *id)
 err_stop:
 	hid_hw_stop(hdev);
 err_ts_create:
-	power_supply_unregister(ts->base.battery_dev.psy);
-	if (ts->haptics_dev)
-		input_unregister_device(ts->haptics_dev);
-	led_classdev_unregister(&ts->led_dev);
-	ida_free(&thunderstrike_ida, ts->id);
+	thunderstrike_destroy(ts);
 	return ret;
 }
 
@@ -1090,11 +1095,7 @@ static void shield_remove(struct hid_device *hdev)
 	ts = container_of(dev, struct thunderstrike, base);
 
 	hid_hw_close(hdev);
-	power_supply_unregister(dev->battery_dev.psy);
-	if (ts->haptics_dev)
-		input_unregister_device(ts->haptics_dev);
-	led_classdev_unregister(&ts->led_dev);
-	ida_free(&thunderstrike_ida, ts->id);
+	thunderstrike_destroy(ts);
 	del_timer_sync(&ts->psy_stats_timer);
 	cancel_work_sync(&ts->hostcmd_req_work);
 	hid_hw_stop(hdev);
-- 
2.40.1

