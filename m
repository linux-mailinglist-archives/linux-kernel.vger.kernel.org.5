Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A186B813632
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 17:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjLNQ3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 11:29:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjLNQ3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 11:29:13 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2082.outbound.protection.outlook.com [40.107.8.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B27F123;
        Thu, 14 Dec 2023 08:29:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PgCLsG0ilMOnZfgNQSOl2SzVOGunh4WPo7SudUoPLMlUY6NHnkl70XL5gTfAU5EB94ncYNvs8FEf/Ab9DLFh2pOHXQ0dNnqPm9aK2uaCnatyxe0YsNywgQsH7D5GuASRrgq27Ut0VrQnsYKFDJW11D+K6YWxgbEN0zBKKJsVCSV+KMF+2++9Zg2/yUy37HVjGiI2fRiubUA+AfCbPtuRfYhW8l/p8al7TKNEaCXvL5QLW9zLvSiDjJT8t1IFtME+4M59dWEefVCvceFZjus2GBhv8+SjmrranZ5NCEBdmDNkgl83naiG4YIZe6zoKdZa3J0Eyv/kLftg+ep4vR9tyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dFinOaArdwIYeAM3WtAo6SpWlNlZf6708hGd1TSt4Uo=;
 b=kRm2pvyjJenONpAUQyG2Dh/GJQcEC6Ae87K5Q0nkFMAUZHgQZIzoEPRhtDcMJ4SuWp5q7yU0llainXzyXXR3Yp3GmNm9iRPo+3RGTVl4/+3NMpBE+EkcdmRYbSHBykttGibR+HpGx33vTH+6OwE8O60wpB+l6bK1ZMmZOvc9Wt77oyhFgfKG8lheZSwPahPVXrJIbIWWGjmuqXjfObR+BifEymAYYBpA6y2kd5LnDFN5//yGMRBs+MXmvZ/9c5Ww9fNFIgaloAFIzJ4PcFzAfiBx0c1W46h2JdExvmDiQJBmDhLZzEt65qhsL/RCQfjTf0twHh4YVV9cAqGx+Wx0DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dFinOaArdwIYeAM3WtAo6SpWlNlZf6708hGd1TSt4Uo=;
 b=lvVKyWMfuLfEWXjsHXrDeJAguP5AFAOlv8e2KRUQN8yCWptkrcVxHOlmLHUNBlBt6ECDFH4tuyv1yxVA12aTsZJUguR5r/CmcqeW5jciDoPDMLF+cIla6FtjSXdr1OiyZ1fpiWKCBeYAOPZSPYaHap/1KZke7C5ziAAgpsEBVQE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by DU0PR08MB8302.eurprd08.prod.outlook.com (2603:10a6:10:40e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 16:29:15 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc%4]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 16:29:15 +0000
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
Date:   Thu, 14 Dec 2023 17:29:09 +0100
Subject: [PATCH v2 1/4] usb: typec: tipd: add init and reset functions to
 tipd_data
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231207-tps6598x_update-v2-1-f3cfcde6d890@wolfvision.net>
References: <20231207-tps6598x_update-v2-0-f3cfcde6d890@wolfvision.net>
In-Reply-To: <20231207-tps6598x_update-v2-0-f3cfcde6d890@wolfvision.net>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Javier Carrasco <javier.carrasco@wolfvision.net>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702571354; l=4687;
 i=javier.carrasco@wolfvision.net; s=20230509; h=from:subject:message-id;
 bh=uuzBZoVgbfJRVw/uB3TAQ/14SQq/Je6fi5f+9uL7q9I=;
 b=ocXu4DT6SCja/JA6ebL7vPH4NHLCOvm1GnfeiAs9eqIDCcHl3Z7lZrjcmfVlKoJGUjZqtIexI
 NOTjSYf15UTAzCOQvzR5N0FLhwrp2S/C9/UhfWRVsi1Fvykzxlk88uF
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-ClientProxiedBy: VI1P191CA0011.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::19) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|DU0PR08MB8302:EE_
X-MS-Office365-Filtering-Correlation-Id: bfa5834c-e689-410b-7838-08dbfcc1d048
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fBylX6rcG6z046O1Gtdjb+vCcd8wpns6DgGBJpck3JyoGGo5M98PmVppMMqBploIbBD6wr+kJ5M5Zc/1GQ2rNyBlJKpvrLTEFufqRUlh2YarRAovaQetBHf0e1pKSQuM7ITcKBCbzXnfajbaWWrI4H83I1NvUNmnthuCLBdqesRrBE39ptAIp6YJrkBGn6d6EE+lB54d6hMuqt3pN5e/qXzRWDmty05SKG4hJowfJCNgGDP/yykUTd9x1/AUv0/HeAITSibzn6WT04F+QJYxvFb/jKiSfIdMdpnJsAo116wfMCSacEmg10KnZFx/WEFmNefPwDtkfkVnLE9W/P23r3ECva/b362EpR0tmnei7JVs41MNxaAmYr0QnbVlP2E0SUWEQUzeV1kTHd/0tXuya9MPJeYCPtIOXJol6WDCGYDURG+SGIDYlHIfRJ01vvf65SLY3dzP7CjW9v8+j16GTSaHyA/L1JckmllK2IPHcNBbsfRR7B1VPHGMhCHEZ708TDPQ270cU1xKuAUhqtP4Wp59cKWPNULDEZhYF/nFbhr6vaZnolMn8eDLWMrndUs2EIOo/YI3CNzYEuPWPHVbw+SDy2nvXO2bLxMEcRhSYEVRRjq93iZzDQVLp072rnyc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(39850400004)(376002)(366004)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(52116002)(107886003)(2616005)(26005)(6666004)(6512007)(6506007)(66556008)(83380400001)(44832011)(2906002)(5660300002)(41300700001)(6486002)(478600001)(66946007)(8936002)(4326008)(66476007)(316002)(110136005)(8676002)(38350700005)(86362001)(38100700002)(36756003)(66899024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTRtTndXNWxQYnQ2dTlRUWpkTDRUcldZT0dqT1E3ZHhHY003UG4rbjhaUlhB?=
 =?utf-8?B?YXA1YXIzcnVULzhrMzErUk9VL3FyYmx5UHVHaWdzL0o5WWZ4dWJkZkR6QjRy?=
 =?utf-8?B?NXY1cWdyYS9mZXZMRWVtbUFEQ3kwcC9FY0FZZ2ZCbXIwK3UvN05KUENFN1Z6?=
 =?utf-8?B?ZlBpcWw1ZUFsMDBjQjVnSUIwbFBaaGxXL2V4SnV0dWx2aEkra1pUTmE0SVZX?=
 =?utf-8?B?SEUwT2lCaWx5Q0ttWU9NQjMyVzlrWnRSOFc3b01IeWkzd0grLy9sZEVmcksz?=
 =?utf-8?B?dUphNUNtT1lrYkRSZTd3d3J1ZGRCRFRRRWQveGJwb3ZOOHc2NWpSKzdkcGpQ?=
 =?utf-8?B?aGNBNys5TG8vVkdWWHlRek9ZNjBDQ1NaL0dKUklkbkVEYk45SGI4L253THd3?=
 =?utf-8?B?czBUekk3eS9uU3BlUEZ1MmN3a00yWmZ4empSRERXeldZdndLWWQrV0VMTXBB?=
 =?utf-8?B?dlUxS1o3MUQ0cUtLZ00vSHRBWkRRaGxSeTZwL2x6WE9IVHdDeVNjanFuWnU4?=
 =?utf-8?B?YkdsdnpFSTNLVXpUZGMxWTl6WEo0ZnVpY2kwRURqdGkzNVpJQUVzQnh6THRL?=
 =?utf-8?B?akFQMXlIOFpKN3lTK0o0aldZZStmSjVwYlJ2cTM3ZFlxVFRRajJOZ0NFRHNH?=
 =?utf-8?B?MStJdWcrQ09hSklIWkQ2a24yS0I2bUdvWmtGTmkxWGxXcnprVWxndEZ0TTI1?=
 =?utf-8?B?UnM4UlJBTlVYR3NFRWtsWjRsY2NGUWgrQVBuWERjZEplN1JXYXFjL0FHaWd0?=
 =?utf-8?B?NzZnanI2UG9Hb1J5QktIY1paZmw0OXJvVDVTekk1Y0Q3cExsVkd4VG5XN1F1?=
 =?utf-8?B?SnpRRWJCZkRYOW1FYU1GbjRUSXl5MXR4Umx1R3Z0U1FOU2pqaGFFM0ZBVUVs?=
 =?utf-8?B?ZkpjYkh1b2JVZkVOK0pxd2xPcWJIalRqZG8vNm5lYkJWTGdvU3FCWmNSQTJN?=
 =?utf-8?B?VEJyckdLam4ycXEybXcwTmlqdXBpamtFL213M2RzOEx0T2JqbUY0UFE5dTdi?=
 =?utf-8?B?SDB2RUtxbWtWUTl2RlNVSjY1aVE5Zys1RStWU2UzMnBIckFyTEd0WksvVDhJ?=
 =?utf-8?B?bmIyTDk0ZlFBZWlrS0R1ZzNmOHhtckgrQVNjNENrbWtMRFlZbkZ3ajlNc0k3?=
 =?utf-8?B?a2JWc0F0WDVCSmMyTmoxQUdJYjNaZFYrYmcrVk16d3kxaWlRV2srR1BLUS9K?=
 =?utf-8?B?SEllQmkrWTNLMUpYYVBtcTUzdzNNSXFRMVRzR0JWaW1Udk1IMzR3VkMrRGZY?=
 =?utf-8?B?TzExUzhlMWVIUW9LanhLbkRLZGU0c09SLzVycUhsTXByeWQzTTEvWkdTd2cv?=
 =?utf-8?B?UDErTWI0UjYrNGtLYmozQU5DbEY0OFBUSUZsR3cvY2lHaFczTyt2UkhlM2k2?=
 =?utf-8?B?Yk1pajRLNU5kdG9uT0JzWEdOS0lpRzMzTDlCeitQRlpncGtkRkZ2VW1SRmtE?=
 =?utf-8?B?Z2pkQjQ5NExwZ0JWU3R3WFNmc1ZnYUpqNFhFczdQak9GN0crbTN0QVFYdkVF?=
 =?utf-8?B?NmdOWTFyQlFONmM4NHVhdndGa1pBVC9VVWVkUStGR3RmeDJqaXk5L2QySVQ4?=
 =?utf-8?B?bHgzMVc1OWVDcUsvVk9pdWtYUGxVekh6aWJZT282N0ZjNmRBTHdreVk0ZnV1?=
 =?utf-8?B?eCtTZWFGYmc2Qll2UGlFR0JSWHNEZENtZ1JaZXpwK3lseEI5TXBvemtUUTdn?=
 =?utf-8?B?dVZZUTlqblQ1Nk9YL1oveWl6bjNMeVpUMTJEZHM5WHRkd2FzcW4wSE1CeUhx?=
 =?utf-8?B?WHZ4bm9BMHVzTnpmZkRUd1B1LzFpLzhyOTRIOWtVc2N3cDU0b3pNZGcweGtH?=
 =?utf-8?B?WGpxSElud3VGOW5HeDc4Wm5lVmZxbUhsa1ZvRHhQSVBjOFB0VkpGVWpnaEpy?=
 =?utf-8?B?WFF3bzljZkVIb2cwVyt3L0pNWUszM01oTXBJN1VNeWV2TStrOFJVcTJqYWY4?=
 =?utf-8?B?cEZCYzVldjkwVmsyNlpUc25JSTU0V0RHL3ZsVHVSYXFJcS9ZclNhQTRrOW1i?=
 =?utf-8?B?NXBGLzlBR1hrbzRFQmhTYTRPVUxEMmc0a0p6WXVDNTB1LzZxME04WFoydUIz?=
 =?utf-8?B?ZjE2aDhCbVhSQWtkN1hlR2ZPREpiUFFhWGVGTWJoOE82VStHMW9IZlZzSmZj?=
 =?utf-8?B?bVRHTWVJRUd2NUdyRlhsU2taU3ZidWVYL2w3QkdkVzdLZlpXRDZ2VVhrbUt1?=
 =?utf-8?Q?7gs27LaxHvIjvA0TQcZCqBE=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: bfa5834c-e689-410b-7838-08dbfcc1d048
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 16:29:15.7403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H9g/5nHYkN/h/rxbw/NSEBhHK3P2f6FXLrxeZJP0IqQzl6KTest4bEvr2vIjmcSj1jb2gIbIiCGMHFZDBmebb/1HMXEiK04DQLsz+s0AoHA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8302
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current implementation includes a number of special cases for the
tps25750. Nevertheless, init and reset functions can be generalized by
adding function pointers to the tipd_data structure in order to offer
that functionality to other parts without additional conditional
clauses.

Some functionality like the cold reset request (GAID) is shared by the
tps25750 and the tps6598x, so they can use the same reset function.

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
 drivers/usb/typec/tipd/core.c | 45 +++++++++++++++++++++++++++++++++----------
 1 file changed, 35 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 806ef68273ca..f0c4cd571a37 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -115,6 +115,8 @@ struct tipd_data {
 	void (*trace_power_status)(u16 status);
 	void (*trace_status)(u32 status);
 	int (*apply_patch)(struct tps6598x *tps);
+	int (*init)(struct tps6598x *tps);
+	int (*reset)(struct tps6598x *tps);
 };
 
 struct tps6598x {
@@ -1106,6 +1108,11 @@ static int tps25750_apply_patch(struct tps6598x *tps)
 	return 0;
 };
 
+static int cd321x_init(struct tps6598x *tps)
+{
+	return 0;
+}
+
 static int tps25750_init(struct tps6598x *tps)
 {
 	int ret;
@@ -1124,6 +1131,21 @@ static int tps25750_init(struct tps6598x *tps)
 	return 0;
 }
 
+static int tps6598x_init(struct tps6598x *tps)
+{
+	return 0;
+}
+
+static int cd321x_reset(struct tps6598x *tps)
+{
+	return 0;
+}
+
+static int tps6598x_reset(struct tps6598x *tps)
+{
+	return tps6598x_exec_cmd_tmo(tps, "GAID", 0, NULL, 0, NULL, 2000, 0);
+}
+
 static int
 tps25750_register_port(struct tps6598x *tps, struct fwnode_handle *fwnode)
 {
@@ -1187,7 +1209,6 @@ static int tps6598x_probe(struct i2c_client *client)
 	u32 vid;
 	int ret;
 	u64 mask1;
-	bool is_tps25750;
 
 	tps = devm_kzalloc(&client->dev, sizeof(*tps), GFP_KERNEL);
 	if (!tps)
@@ -1207,8 +1228,7 @@ static int tps6598x_probe(struct i2c_client *client)
 	if (IS_ERR(tps->regmap))
 		return PTR_ERR(tps->regmap);
 
-	is_tps25750 = device_is_compatible(tps->dev, "ti,tps25750");
-	if (!is_tps25750) {
+	if (!device_is_compatible(tps->dev, "ti,tps25750")) {
 		ret = tps6598x_read32(tps, TPS_REG_VID, &vid);
 		if (ret < 0 || !vid)
 			return -ENODEV;
@@ -1251,8 +1271,8 @@ static int tps6598x_probe(struct i2c_client *client)
 	if (ret < 0)
 		return ret;
 
-	if (is_tps25750 && ret == TPS_MODE_PTCH) {
-		ret = tps25750_init(tps);
+	if (ret == TPS_MODE_PTCH) {
+		ret = tps->data->init(tps);
 		if (ret)
 			return ret;
 	}
@@ -1340,8 +1360,8 @@ static int tps6598x_probe(struct i2c_client *client)
 	tps6598x_write64(tps, TPS_REG_INT_MASK1, 0);
 err_reset_controller:
 	/* Reset PD controller to remove any applied patch */
-	if (is_tps25750)
-		tps6598x_exec_cmd_tmo(tps, "GAID", 0, NULL, 0, NULL, 2000, 0);
+	tps->data->reset(tps);
+
 	return ret;
 }
 
@@ -1358,8 +1378,7 @@ static void tps6598x_remove(struct i2c_client *client)
 	usb_role_switch_put(tps->role_sw);
 
 	/* Reset PD controller to remove any applied patch */
-	if (device_is_compatible(tps->dev, "ti,tps25750"))
-		tps6598x_exec_cmd_tmo(tps, "GAID", 0, NULL, 0, NULL, 2000, 0);
+	tps->data->reset(tps);
 
 	if (tps->reset)
 		gpiod_set_value_cansleep(tps->reset, 1);
@@ -1393,7 +1412,7 @@ static int __maybe_unused tps6598x_resume(struct device *dev)
 	if (ret < 0)
 		return ret;
 
-	if (device_is_compatible(tps->dev, "ti,tps25750") && ret == TPS_MODE_PTCH) {
+	if (ret == TPS_MODE_PTCH) {
 		ret = tps25750_init(tps);
 		if (ret)
 			return ret;
@@ -1423,6 +1442,8 @@ static const struct tipd_data cd321x_data = {
 	.register_port = tps6598x_register_port,
 	.trace_power_status = trace_tps6598x_power_status,
 	.trace_status = trace_tps6598x_status,
+	.init = cd321x_init,
+	.reset = cd321x_reset,
 };
 
 static const struct tipd_data tps6598x_data = {
@@ -1430,6 +1451,8 @@ static const struct tipd_data tps6598x_data = {
 	.register_port = tps6598x_register_port,
 	.trace_power_status = trace_tps6598x_power_status,
 	.trace_status = trace_tps6598x_status,
+	.init = tps6598x_init,
+	.reset = tps6598x_reset,
 };
 
 static const struct tipd_data tps25750_data = {
@@ -1438,6 +1461,8 @@ static const struct tipd_data tps25750_data = {
 	.trace_power_status = trace_tps25750_power_status,
 	.trace_status = trace_tps25750_status,
 	.apply_patch = tps25750_apply_patch,
+	.init = tps25750_init,
+	.reset = tps6598x_reset,
 };
 
 static const struct of_device_id tps6598x_of_match[] = {

-- 
2.39.2

