Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1087A4001
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 06:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239550AbjIREPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 00:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239519AbjIREOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 00:14:41 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2055.outbound.protection.outlook.com [40.107.212.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55B1FF;
        Sun, 17 Sep 2023 21:14:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iHoMhNo0JimCXWrKmF9fd4LIAufu0uhWD0RQd5xR9tS4NCG6a9jajkYtSWUsiUA1JFAUHig9f1/F7JnjCZ7ZR1TD6UtjrrdNULO7yM3fTUKtiLakhnt4dey2N1JZwXVGikFHwbSco8cruN9Cszudi517CVbCqBu6aTM2E8zvpZcJFtjWKJzACCglXUrSJLiOv9ti6PmKh0B5CbpGUpipI+xBVClGwMhJCYopwXgYffr5yE5/5OrRsJ3ct31jJqrwOqEi4nXX6N1S5rB4Umx399+TLZ0AtdMBBAGFoUTpESQOMtTFKYZDxvHZCRkqBDjfwDGWg0hHtrfkG/SI8s5WXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vktCfwR6O5t2TIifqIPV8Clwm49DhFPFArNxOy8kS88=;
 b=SW/yC2FUeR+s/Iq89ka9rM12i3ILGli4wa3jri8xMtrQZQsV+9vnDvyo5TZpLi+KjpsYtASEK+2xzhHAbluhcUudwb9Akji4UrBqqrWcJ6YaF/vxwh2I2mFYl0R1SVcUfZ8+Grf43MPSXTUHr+iw03n9a/u2yDyAhhziksHsVg5LNJyxtXRHGBpq7sZ/CkP8PlWhxGPFEmvtvxvigRpRuUc0VxJKtEF+2ksorwJvKn7hCAQANptDvAJjE/uZJYl5C/59dI7HI91aUd3B5yvkuqejZR7j9vHcq0lHSFWks0cQiXB6WG40x6JCDJp1wD978nIFbgyHp0u/sVlHKtCZMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vktCfwR6O5t2TIifqIPV8Clwm49DhFPFArNxOy8kS88=;
 b=e7QEhCBp5LlReKVTVUKPH0VJwpBLcdTO/E66T7pR9TI15U6/mvZTcPqB4JqhdRsOLigd0Az/+FY9irsf/aY0fyWVbdTIOowWX7Scz/u/NFAIt1SkQByUNMvUH+J4PC46BSTiKgPo6xXj2M/KuSrmY6JkFtMmMjkRVbt6u8FdcIqFD+Gt391DnmOWQmS+aIgtNfSmXNOirNRkSKcJN//y/gD/RH2KBlne/5J9WmdOKL7kufEufGv4Lv8mjI5goT3oxd9FAeDuc+ZCBLpvskAE3kTNKLuyQ1CznKlxDZzUF95pviPl3ZatiX/iOB7KSEkyXyJLJ8+NxTlyMCKpMsS2hQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by SA1PR12MB5658.namprd12.prod.outlook.com (2603:10b6:806:235::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 04:14:30 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::5cc1:1ea3:4ec5:72af]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::5cc1:1ea3:4ec5:72af%5]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 04:14:30 +0000
From:   Rahul Rameshbabu <rrameshbabu@nvidia.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        kernel-janitors@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: [PATCH v2 3/3] HID: nvidia-shield: Introduce thunderstrike_destroy()
Date:   Sun, 17 Sep 2023 21:13:45 -0700
Message-Id: <20230918041345.59859-4-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230918041345.59859-1-rrameshbabu@nvidia.com>
References: <20230918041345.59859-1-rrameshbabu@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0200.namprd05.prod.outlook.com
 (2603:10b6:a03:330::25) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|SA1PR12MB5658:EE_
X-MS-Office365-Filtering-Correlation-Id: c9336be4-9e8e-4baa-47d3-08dbb7fdc13f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FtbPFlCbCu735/ucZCmXdVAlZh5oyUe314kjV+qGZcmljcwEagWB/sTRCIJWFn6wiLdHJNWQme5R7x4yT6A++fZTaYKPpjlN5FgYG4zJPi1HWmF/vXne4NvgxHxheNlBvmiGpHk+wJKW6YhyJr0MUMge2g0yLZli2c3c9yrGj3dsE+8YpzHvhwMJYY3oRpxSBJp5GKdFMy9Z5dmgXrcN98M59RMUDKXwrkJiu/BsIIge0RmABa5GsyPGFzoUp/HsVNsssU/a3iUjNF9nr97Zj8tyD1cbHvcLXB+ZO8Zx5oKe5Z2DYfJX7pRUNpY3v8QQl4BQHNdr1QVdQVpgmzH4FMEJGxNxqlo1i9X2MUrhej0EN3bwIUyJ6t1jmCGSKuc/U8nFWTxDZ1j9QNVJ4J35gLRjwLJ/K+ia88zcZ1dRulASE1FQ9MbQYaJm8EL3TFepEUUc+bnEIMZ2mzLLVXnGgUQZZngmMEkk7Kfc/u8o3+92bv6Ipo4c/m+szA93NSuINmu2HKTSSvrep0JcbODy2F7bD4WC+EgBWQbsLkRRkf5wV9J35ol01GxJunrXUn2Q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(396003)(366004)(346002)(451199024)(1800799009)(186009)(6486002)(5660300002)(6506007)(86362001)(6512007)(54906003)(316002)(66946007)(41300700001)(38100700002)(66556008)(66476007)(110136005)(6666004)(478600001)(2616005)(8936002)(8676002)(26005)(2906002)(36756003)(107886003)(1076003)(4326008)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7JZrC8Mn0+yyF14u57PWUmWynbVrrjXQA6k/7+G7V1fLZSCC+py2bCkUzWiC?=
 =?us-ascii?Q?khcrEYRbTpNNSSweLnYEZFA3MXqsnbsod1tKDgj28Oh4OteM47Kujs3HZq8u?=
 =?us-ascii?Q?npt30NkLADmPIUsgzHk0zm3gDSfBJQluXqFdnpm0EN6SVVz+G2Y97RbbHY4o?=
 =?us-ascii?Q?cyfPEOfEf/DfrSM1O0VKWeNzBlhHUK6D1E4/pD5DuuXGbmrR0Yebj4CxapVp?=
 =?us-ascii?Q?PmrzpuT4wZ+u/L9YPbC6sEX3dkRjp7fBr0RfXhgStawy//XpA7DuwVw44fOY?=
 =?us-ascii?Q?efaZngo15CwPay1P4wUOckzJtQ25RlQgNK9b2bKkmtti+abV8oObFA4wIlhF?=
 =?us-ascii?Q?EYP9Mh6rJ6n5Yzhxw4r/KkW1LlHUJy70WahU6Qxyz7XKA2zFXBCvuCihKcWC?=
 =?us-ascii?Q?67NJYbj4QfVk91pejYwXcpdC0MAEo19/WuUBKyExt4ayoQ3t4pqtw2ZficCg?=
 =?us-ascii?Q?nifXT9qXwW4YCdV6z0fwHL1J9q+iM1GeJgo/Vb3JwI6CkwOQtUd3ZfvdUOCW?=
 =?us-ascii?Q?eYPa+q2euF+wUEzWZh/QV2w3aoJsjFa0M6byhHR/KkKTtYu6VdB3pjhOpjkt?=
 =?us-ascii?Q?92tvZ7jQhChi8W7An/vL3EHwmCTNGTjz6DRPLvNH1D4c7Qw7VMdtQyqEggpA?=
 =?us-ascii?Q?OzX2YHFykdEG9jKnGvqCauX0j3Ed8wASkEOfIdiiQvDLFwozk8hU80D90do2?=
 =?us-ascii?Q?IGpdeCvVGjkDCEA5eZr2XGBuM4VjP63QdpCLDtvtUfTJ1Hlj3I+GQ/ZPrZfI?=
 =?us-ascii?Q?4pof420fBIhzuRKtlFXTGZAqVRlA7B+ZGFT1LYvkRxh5qLV5GCJxJHcup77M?=
 =?us-ascii?Q?XXZOkL1TTUHR3EcNIS71qBzeb0zaLNg8k8D3U5XOBng2Mwcv51716/D1mGRw?=
 =?us-ascii?Q?vUAeJhnUOUFDLItCa+B7oueq85K7kcKnm2JAKAq3ttcIM7A/QqEmLezGICAk?=
 =?us-ascii?Q?WO3HsUa3n2PEq+7n6P99XfCbwScmJ4uiu5ysJnUyeKdwi3zQpxUBMaL2NkIo?=
 =?us-ascii?Q?e8ZlZHWMFdDrOWTMHABJExvahOragDPCIYfIyKlsfIeeg5VzbjLLt1bL7ILK?=
 =?us-ascii?Q?1IMKV/58VU4aEeG8aogkKYHOHbJFUvt4M/9vc+bhF7BCSRyoLs00noweSnwf?=
 =?us-ascii?Q?4Xoj5OYOaVxBFoZeZJjvTw2dHLKZPNnoafnnzAKssHHPKo6SWTZLFowteCXL?=
 =?us-ascii?Q?D1c5qawKxivTmKkxEcoYwzVsmm+TlNpHw8OQVFbYeJW1yKEatC5M8e8Yqaq0?=
 =?us-ascii?Q?C88800IphRbdaCDjl3uYRtlAkQT4A+n0hbF9SqaqL7fMbQBBG2ASP2N2wrnu?=
 =?us-ascii?Q?C6/ZVfzFea7UD3E98NiWwpzVykCL6BIdt2pgeo+SaGtyHJ6x9mw74/rjHHli?=
 =?us-ascii?Q?n6D6fp82kFnGveZykxCQkU0o2I8V1Zt6vk6WsD8s22RH3plZJgmCSwwyw+MJ?=
 =?us-ascii?Q?RwLNpdR34P7E6Sxuq7dZatp2CYp3yM679WYanS6pdUOsuE8mBd5LB+YXeglD?=
 =?us-ascii?Q?bP9nU1+qt6o4MoNmPWGaetCvEZRYdmOKcN86w93q2dSrdgbLl5pAlfEx53ln?=
 =?us-ascii?Q?z440HEn4MsBhepqNHZ0VDyQmOfvk15/Bai6pm3Dk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9336be4-9e8e-4baa-47d3-08dbb7fdc13f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 04:14:30.0935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2AH6E8dbKOLq7ID3Q1ScoMwEGvpKHtakG6NLx9pvDOvQ6OR7e1RFF9OhKO41lsMAdhRPpF7yvtRAfkT9YCBUbA==
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

 drivers/hid/hid-nvidia-shield.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/hid/hid-nvidia-shield.c b/drivers/hid/hid-nvidia-shield.c
index a566f9cdc97d..817ad6c01129 100644
--- a/drivers/hid/hid-nvidia-shield.c
+++ b/drivers/hid/hid-nvidia-shield.c
@@ -915,6 +915,20 @@ static struct shield_device *thunderstrike_create(struct hid_device *hdev)
 	return ERR_PTR(ret);
 }
 
+static void thunderstrike_destroy(struct hid_device *hdev)
+{
+	struct shield_device *dev = hid_get_drvdata(hdev);
+	struct thunderstrike *ts;
+
+	ts = container_of(dev, struct thunderstrike, base);
+
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
@@ -1074,11 +1088,7 @@ static int shield_probe(struct hid_device *hdev, const struct hid_device_id *id)
 err_stop:
 	hid_hw_stop(hdev);
 err_ts_create:
-	power_supply_unregister(ts->base.battery_dev.psy);
-	if (ts->haptics_dev)
-		input_unregister_device(ts->haptics_dev);
-	led_classdev_unregister(&ts->led_dev);
-	ida_free(&thunderstrike_ida, ts->id);
+	thunderstrike_destroy(hdev);
 	return ret;
 }
 
@@ -1090,11 +1100,7 @@ static void shield_remove(struct hid_device *hdev)
 	ts = container_of(dev, struct thunderstrike, base);
 
 	hid_hw_close(hdev);
-	power_supply_unregister(dev->battery_dev.psy);
-	if (ts->haptics_dev)
-		input_unregister_device(ts->haptics_dev);
-	led_classdev_unregister(&ts->led_dev);
-	ida_free(&thunderstrike_ida, ts->id);
+	thunderstrike_destroy(hdev);
 	del_timer_sync(&ts->psy_stats_timer);
 	cancel_work_sync(&ts->hostcmd_req_work);
 	hid_hw_stop(hdev);
-- 
2.40.1

