Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45F6B7A201F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 15:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235488AbjIONrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 09:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235461AbjIONrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 09:47:47 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2070.outbound.protection.outlook.com [40.107.105.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8691BEB;
        Fri, 15 Sep 2023 06:47:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W3whhnAF5mLhTdfVesRNd/GgYr15BuI3u/lQ2joCYM5rnbIVy2rJD00a6Tdjm7jB0DGV2sdqR+T0P6Ju5Q2IucYqbQyjcmP4vy38i9X5XqymDiOK3WLzLKgf3LCarmUsGnO92lF254E6r48Ak7O+LgkksLpX/VBsa5+begXyt8su8tlTj77Mkuuma59GoHbnjEEJTl6q2C7yHK756CkiZbgiAC6UTKTva5qyA972hh4ItjOeBbxfoVqS9/3eY1lKxlPpiIcpHjjz43gIzfuq75zKWQ+vHx6u8HTbWq0BD0fKJ89rjG6XI3/5Y/mvTloQIVMIEMMJmLxWyq6nOdd7DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LALxW/oAIyxG7vh7eSxOonN+J0b9RaumMYhm7Wjenvw=;
 b=n7z0w36Woih7aeIg8hWd1jvhxw59Lo4BC0nrXMHwRei2wRu+EB7qmo7PqCYtpVY5Odt42Al6LLOpeQx9pMyFs0PSNHo9mOS3HJ2af11SpOQI4xDpz58GsX1SQs0NwHI7qNvjW0ZmxdQQiwwH0/vNSNXFnI3+yOSspzxJdTO06ZcHvwhZ8RJxtk9hT3RF5YhL8hUx67LlJRG81c4ocCkl+DGQ3fRC1H/YQZeojGyChnW6/96qXipRmLC5X43SGnFiqBfo8pPC748j6CES72fTiWLn7dZN9uc1EEP0cMYNiO9WBBvhbEc/8lDBIDiKJSfHG3lPP/L78nHsyDoyGsNz+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LALxW/oAIyxG7vh7eSxOonN+J0b9RaumMYhm7Wjenvw=;
 b=uajlXT9m/K3l5b951EYzODudZ1jDMFJSl3WmZaTGdY9bsZlqRuU23BQzZXV+irFt/yYGTfUjduB3whIIyzklWJJbuVkkDAoTN/wkbvbyuep/GRCJYX0AWp5MS5QiiNLDeDzecDjR0Ygjxm/AhVJGpc/2KYlIyZeC28ejitUCoGE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by PAWPR08MB9783.eurprd08.prod.outlook.com (2603:10a6:102:2ee::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Fri, 15 Sep
 2023 13:47:37 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bc92:216b:11ed:db63]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bc92:216b:11ed:db63%6]) with mapi id 15.20.6792.020; Fri, 15 Sep 2023
 13:47:37 +0000
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
Date:   Fri, 15 Sep 2023 15:47:25 +0200
Subject: [PATCH v2 2/2] Input: st1232 - add wake up event counting
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230826-feature-st1232_freeze_wakeup-v2-2-29ae9f747137@wolfvision.net>
References: <20230826-feature-st1232_freeze_wakeup-v2-0-29ae9f747137@wolfvision.net>
In-Reply-To: <20230826-feature-st1232_freeze_wakeup-v2-0-29ae9f747137@wolfvision.net>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Javier Carrasco <javier.carrasco@wolfvision.net>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694785656; l=1867;
 i=javier.carrasco@wolfvision.net; s=20230509; h=from:subject:message-id;
 bh=o408kdN/AxMKMa4Y2r3gFHy5WAht80gNXp9pdeuz7ak=;
 b=2pGM2GOIs9OZ9STHxUNzvClhwzeOp6P8fd/aDww2jHScsECTYrCwWU9Xa3ycrpIau3poIe8Dr
 L+Lsl8WrQNPDHCpR+XeG6CSw2+AjlsGzC3f6M0anIH+0HYZK7nd2qy5
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-ClientProxiedBy: VI1PR08CA0233.eurprd08.prod.outlook.com
 (2603:10a6:802:15::42) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|PAWPR08MB9783:EE_
X-MS-Office365-Filtering-Correlation-Id: f0234497-bb9d-4b86-1b56-08dbb5f2523a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gT2lOEChJfZ4MwsA3hEutE64NaCkYO1giojBSmKw/KP8mIUHj0/f+b1B3u2x5lYf5jCEa10lDghPDZiRu4IvQxjsxmfpkpAyBC7PTQ9JNA8zQYkWaKbIYPk7atU2B4aOcLU3AZYMFq4Xa+8/7n0cSD0UAhCM757t1JGAQKEc/BS+oY2wySfy02nLLX0h74dVe77xfws4ga0yQ6C5b7OkCgvK2W/CsCgjK/BTd9GS2UnMxsyMytGKHnLf331VDr+09PNqO2kMJUQ8JgV1dOXdbZfm7mgY/cayVmcj+yBDeCgWHPVj9gss59T5mbPNaqCZhMQIbIYKfW8pdBSCyp2gte5Aad+g7BXqs5WhN1Mgohi38xtxBmbIQgoqaeGBrQwdPDR8ICiCRi9q3L5xXCxegCYGcnRF6C6nphvcq2tH64L9cqp/5bMPweIPHNz47AAjWCGiGLM9Uia+A8YC5g6OgRgjznTMoKavn8zHGAv04mjiFZNkuS0sKjnLMyQWwL+0iT5NBHAdfqn/mM1kEKLRJ7alKlm5KbYBvfci0QbnVCjrPY2Y0cAzVvrUvOik2tWdL+fTwj/2XMLJNEAqKISFPtWEsHwI3+nUCJM6Kc7pU4P3AzgmVpcE3R0/a7NqcsXe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39850400004)(136003)(396003)(346002)(186009)(451199024)(1800799009)(41300700001)(6506007)(52116002)(6486002)(6666004)(38100700002)(26005)(36756003)(6512007)(86362001)(38350700002)(2906002)(2616005)(83380400001)(6916009)(8936002)(8676002)(478600001)(5660300002)(66556008)(4326008)(44832011)(107886003)(66946007)(316002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXdkaTlRQVp4KzFLZndNSTNhdjV5bEJQSVIxMFpjUmVXa3lWTDh4Z2dyZ0hG?=
 =?utf-8?B?LzIxemFoSzBuc0RnWUd5MUYvT0p2LzFJKzVMNmtLRHl5M040T3NjQ0dMaVdL?=
 =?utf-8?B?S3pqWm1nRWlhYk9aZURuV1VEVjlyOUVyK3JJQ1BRdk5xczJjZ3ozSms0UEVs?=
 =?utf-8?B?b2R3S3E5S3NDTjNQZlFJK1pvclc5SjVGbFM0UlUzK0xsUkxETVdvcWFLdW9j?=
 =?utf-8?B?N1hhN2xvMGNJdUZQQU5ZS3k2NVc5SzBzS3NCanZvejg0S0QyMFN5NmNDUFh4?=
 =?utf-8?B?VjV5MU9ZdWRmY3Q5RG4yQWM4TCtuakJBMVFlY1B3a2hNVk9NZWthaGRNNks5?=
 =?utf-8?B?N0ViQXlHNGhoMVEvelhGWjNOamZkOU1COTFEYWV3Y1NaMFRnMTlEbzUvNXps?=
 =?utf-8?B?d3VPbjZQM0RaM090WkRGbjdIUncyNmlxSk80UTFBbEtiTXZ0UE1Pak5SdCtk?=
 =?utf-8?B?dk5FYURaTFRpWVlnZGMxWkFCM1ZhdGFyZWZKNDQ2R1FoTTAzVVl6YWczWmcz?=
 =?utf-8?B?UWN2TTNaejVqUXJMbkFoTm15YU9CMTBqNGtjdkVCbTJqU05kZkZuaFpxNlJ4?=
 =?utf-8?B?T1EzSithbDdPcklJRHVqK1g0KzlkNXQwOWh5NTU3YVh6WlFWMzBuSEV3bGpC?=
 =?utf-8?B?d01tUkZpb0VXcEt3Qit4RDlRK29UaVRiTUdpVm1qSFBIckVrVHZCSE5iZEhM?=
 =?utf-8?B?blZnVnkzcGdvQ3gzRU5tYkpKRzAwY1BUc1FtSWU3VE5hLzZDUWY1MVVnZTdu?=
 =?utf-8?B?bW15SGJDTDZwWERQZVZ2VzBGUFg3NysyYXlQTGthaWRKYThjWlIyZ3ArbnRU?=
 =?utf-8?B?ZkVVVDBBajlMenhTNTlzYkRPbTd0UVZBenFLcEI2bEVZUFNkS0x3SHdWa3R3?=
 =?utf-8?B?amZTVFdndFp5OUR4MjBCN2wxaEJvYjBFaG16WWRidlFQc1dMT1pEQ0h1RHox?=
 =?utf-8?B?Vm5sbVZodWxreitKcjRyeVF0WXNlVHRpTGZZU0wwYjV3VjNnbktzckpKb1Bq?=
 =?utf-8?B?ZVp6dnZyZlV3c2I5QWFhZllRcmhJMkJ6c2xKQ2s3ZkY3ODRVVUpSKzJGcGlk?=
 =?utf-8?B?YUJmVEpmNDh0U0xDQmJhVWxoQmdaWkE1cHhxdEcvS3U2NmNGK3UxaHNhMDFh?=
 =?utf-8?B?OFFWY2FGLzc2cEhhWGxNYnRrSHE0cnlQeWE2eEN6QU9DYmZ5Qkhob1FqTEQ0?=
 =?utf-8?B?alBja0M4NnNHbUE3MHNnZ3NJa202bWczWUJSMFlHNHFQVXpPY2xUZXdkU2x5?=
 =?utf-8?B?VFk0T01uUlJodjRDT3NvUWtNQXBRSEpmTUh0M1hRTGNKT0dPWGJWOFhlZXFt?=
 =?utf-8?B?YnExenVoYzRISmdaeU5UR25oZmFtQndZMXVmWXZOYWR0UTJiaENrbWljeVRU?=
 =?utf-8?B?YmRUQlBPamtWTUNmMi9GeEI5aUxpTTFhRVFKRWdNVHRKeklWbHFBSTNoVHNK?=
 =?utf-8?B?MWNRWmdrVWlETXJaSTcrTFVtMzBxQlFtWjRKVW84ZWFtQWhxMWRuT1c5SmVO?=
 =?utf-8?B?VWc0bWk4NVRHRHRhMUNpRXRDV3A3VS9HbjNQd2k2cVJuK0JKR2pYelVLcFFS?=
 =?utf-8?B?VDcxYlkvWXNNcXVTa3cwSWdPUmFXZDl2NXZXc2lCN3pGUW1PNFlQbHoxQjNk?=
 =?utf-8?B?TmFOR0NYSVVIN052aXJaam5ITjVpWWlRSklhNGZmWFhQd095LzhhSFJmUVQz?=
 =?utf-8?B?VndDbi9WZWN3U09GU2I1RTU5VE45aHd0TWZLT2M0RlNCZWUrSXZYRFpkdG9v?=
 =?utf-8?B?REFiK1JKUUQ5M1dndU9VUExsR1lLdmw3azJuMEVQb1J3NWtUYkduTEk2MmFk?=
 =?utf-8?B?WnVuZTlTU2lRalJ0TFg1OHZTeE5ESjlmV0RHSThUNnMzTW02RzMya1dvOXl2?=
 =?utf-8?B?RkZXYUVyN3RSaThHMTBtY1drZUwvMDRUUXJwOTlISzhOTGhEK1JMcUs3K1NL?=
 =?utf-8?B?TWMyamZZdlpvNVUvd0RaK3N4b24xVkRudFlydmpZeENyb1BxSEgxWUhIN1BX?=
 =?utf-8?B?MmVOa1F2ZXEvMHpMUndFY2VZNXQvYU1UNytCQ3Jwb1ltbFZ3R1JvWDRsZksz?=
 =?utf-8?B?bG1aZDA5azdKa3RiMVlvakJ6SXFBOUxHUytuNnFGRVpwTEx5cTl4R1BwY05h?=
 =?utf-8?B?SU1vcmo5MGdIU2tia2xsd28xNVV1QUg1VjJORkhrNmduaE5mdEhyTjhvZ3I1?=
 =?utf-8?Q?1X3JX4W8UwtQlnX3Lg1flJY=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: f0234497-bb9d-4b86-1b56-08dbb5f2523a
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 13:47:37.0666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r+haayAeTfl7g0aUZjZSJaVWTTy3UN0LVfEtw90NE4sNbMUFdJKTqYhcVDL6d9i0MtA0Z0QL7mJmTWP9cChomPzVMyrMfDcVOmPyUIfqHo4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9783
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This device driver provides wakeup capabilities but the wakeup events
are not reflected in sysfs. Add pm_wakeup_event to the interrupt handler
in order to do so.

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
 drivers/input/touchscreen/st1232.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/input/touchscreen/st1232.c b/drivers/input/touchscreen/st1232.c
index d0ee90abc293..ad18d3944bf2 100644
--- a/drivers/input/touchscreen/st1232.c
+++ b/drivers/input/touchscreen/st1232.c
@@ -59,6 +59,7 @@ struct st1232_ts_data {
 	const struct st_chip_info *chip_info;
 	int read_buf_len;
 	u8 *read_buf;
+	bool suspended;
 };
 
 static int st1232_ts_read_data(struct st1232_ts_data *ts, u8 reg,
@@ -173,9 +174,13 @@ static int st1232_ts_parse_and_report(struct st1232_ts_data *ts)
 static irqreturn_t st1232_ts_irq_handler(int irq, void *dev_id)
 {
 	struct st1232_ts_data *ts = dev_id;
+	struct i2c_client *client = ts->client;
 	int count;
 	int error;
 
+	if (ts->suspended && device_may_wakeup(&client->dev))
+		pm_wakeup_event(&client->dev, 0);
+
 	error = st1232_ts_read_data(ts, REG_XY_COORDINATES, ts->read_buf_len);
 	if (error)
 		goto out;
@@ -345,6 +350,8 @@ static int st1232_ts_suspend(struct device *dev)
 	struct i2c_client *client = to_i2c_client(dev);
 	struct st1232_ts_data *ts = i2c_get_clientdata(client);
 
+	ts->suspended = true;
+
 	if (!device_may_wakeup(&client->dev)) {
 		disable_irq(client->irq);
 		st1232_ts_power(ts, false);
@@ -358,6 +365,8 @@ static int st1232_ts_resume(struct device *dev)
 	struct i2c_client *client = to_i2c_client(dev);
 	struct st1232_ts_data *ts = i2c_get_clientdata(client);
 
+	ts->suspended = false;
+
 	if (!device_may_wakeup(&client->dev)) {
 		enable_irq(client->irq);
 		st1232_ts_power(ts, true);

-- 
2.39.2

