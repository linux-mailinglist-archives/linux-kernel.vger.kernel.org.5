Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 954B981363A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 17:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443507AbjLNQ3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 11:29:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjLNQ3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 11:29:14 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2082.outbound.protection.outlook.com [40.107.8.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D794125;
        Thu, 14 Dec 2023 08:29:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LC/GedQ0M8c3vvDrPd8WNx+gHBZq8WX8WUwlEimV0Yb2ZxGoz4sByLa0RY8HYBIz7LeRLBdTpAe25wEj6OCjpykbXo0lb7qjR9G/Lh6TUX0NYO7XXu4yYKWx2bIJjYEFJq1swnbl1HiXK3GqF0elx9bLJcvF32Fs/wfZiK0As/dnWtSYbFkCkOJ7s/AmZC4k9bRiI2Mn1RB7VOBSt+ax4evkAN482dwKYew9iHH2GAKpT1koz4Zz5Y/nqPKBHZ0k5n7a4DlQVxOyfHEt4FG2cKTSR7vvSz2/NKsWjbBfkxduZscM8q/EkFcoYCsEM1DrVkNiZdKLZbFkRc5MYmdfXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Alf3X77o95+4npf2Xmg3XH0mq/gq3JSYWbS2tW+Hm+4=;
 b=Rp8AfizAK/cFmUUaKp42wjlhfB/H2egD2pxtbmIUhsE0NH1sg8PzD229ESj5xVXaMSQMi72a0VTpC+v55m3kF/YmOgA6fv+/x+shFEVpOOQ+t3SKODPjqzbocg85Mx86y1N1U475VZBJRLUcBg7VXfqkXhQW5Wkt9kv4Pj+EZVKezp6UEvX6dSmOrSw248qnVUhbuMVtJCFvlbQpmDwt5JgWR1lfoBxVYfM7kVE33kkbHH0540EG5x4T8tefF+mYAMKnyDNlEgNR889azxTTo+MwgP+B524ityEpnLb6bGJTSvwCJv7+meYe/6DgDHWhsPgJA2F7zMSGTS535orZPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Alf3X77o95+4npf2Xmg3XH0mq/gq3JSYWbS2tW+Hm+4=;
 b=VcEM6raCuel7OKb81UHkq4EOYCdHt8dFlr7wCkX2UGqx6A+H/5QIZiP+BDt1EXocTHrPefDIPnlIUIjgD/R1cutyTffRmmLMZuqcGlo/vABJNtQ4UvqINqWEfRjaXD5kAXU2KvV43KRfBl6OQAKAX5xKV6OO1CH/l+j/mfLTSMg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by DU0PR08MB8302.eurprd08.prod.outlook.com (2603:10a6:10:40e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 16:29:16 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc%4]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 16:29:16 +0000
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
Date:   Thu, 14 Dec 2023 17:29:10 +0100
Subject: [PATCH v2 2/4] usb: typec: tipd: add function to request firmware
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231207-tps6598x_update-v2-2-f3cfcde6d890@wolfvision.net>
References: <20231207-tps6598x_update-v2-0-f3cfcde6d890@wolfvision.net>
In-Reply-To: <20231207-tps6598x_update-v2-0-f3cfcde6d890@wolfvision.net>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Javier Carrasco <javier.carrasco@wolfvision.net>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702571354; l=1726;
 i=javier.carrasco@wolfvision.net; s=20230509; h=from:subject:message-id;
 bh=lu6STSMTUjxa+BhbXAPxJC7PhXobLmfFr1D/or+2rAI=;
 b=RSHvW9zwcGH7+aW/7UCIa4jd5kXjoEA2JuQNqkLNVXbd/4ps3mZSCh5/3he3xYYHGrzHA6FC+
 O6qDgge+zLlDIhZ1O+DVsFsyx13IJIPJWke1FWYMnodeLUtSy+pvvEz
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-ClientProxiedBy: VI1P191CA0011.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::19) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|DU0PR08MB8302:EE_
X-MS-Office365-Filtering-Correlation-Id: 48531cf0-c2f1-4d82-9c25-08dbfcc1d08d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mHBgiFvIdmh6ojZbOwIHJY/TuvJxE6JG+gYPXV6tPIJ23oDoBug1XGPSZtmZh1i6WZWKJAyM7gY/rzM+gMPhKggMarTtNciM3H0iD+JlfOmYnTCYzEjLvQOzQjkSPniHI7unFseOGE9IrAQZCZNQM0c1joZcmqPyPFDr48TKOxXLPHCHX7QX9BV5u2NcQD1MOtE9vVwuxC7J5xf0VvQ7yj4hBigCZ3Ec4cHHSipCd17zDw9YQ2gvZhjPb5dEkvPflPmxWyE83zxTOCNk0ZazB88m2KOAQjzMXI3W5P0IY9WBRJFVj9Buf1mccmU3e+c11eAGhArnMAOds9fvq7K3L8G3AwUn5P8Y30RoDj72f68aJxq/dtSeu4Gxse9hf92gpjnEcGiPz9IvIr8b549+Gj780itg5+60NSb9Jcucmu3RcCof83bOcrNpUzD5aDTLzPP/KdkrnzaOZXp9/33SYfGL/2AQmDFp5K7+915s/66Vs73bllSK/2Jb8UVa0JinWDnQ/TidYnVcoa2uILPGc4J7cUv/DrxKtHYk88BoKlNkEOYubZTHENF2f6XEqb9LW3Ohzu+mIeRzEvbsPSZf3glGkivog+vCIpTxH92jTQ5NYoUds7OjH5LVRIujf3Kr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(39850400004)(376002)(366004)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(52116002)(107886003)(2616005)(26005)(6666004)(6512007)(6506007)(66556008)(83380400001)(44832011)(2906002)(5660300002)(41300700001)(6486002)(478600001)(66946007)(8936002)(4326008)(66476007)(316002)(110136005)(8676002)(38350700005)(86362001)(38100700002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2RWeGMxbldxUlFWdlR6QmpJVlFaOUgzY0Y0VHpmdlkyY3Z0V1kxc1VxWE8v?=
 =?utf-8?B?VTNiSUllZDk5bzVqUWh1VXFENFZSRWtHS3djOTFsK3J6ZjlBcjVnanhPdXl4?=
 =?utf-8?B?TDlGNmJoUHY2WUxUUEdZNWJDd2ozVEt0SFFYUWkvdzhReXBhTHZyamJCY3dO?=
 =?utf-8?B?Z0ZaTWlTMHVGVzNabmNlbnBSMVRKOWxHYXR1THJGR0NwUWlQcWt3VEpmbmFj?=
 =?utf-8?B?SFNlQWU1TUdIejIyaFBuSktRWlZMcHJseG1RUDIwQVNhdm5pZTd1SVlNek1B?=
 =?utf-8?B?ZE5naDlIaUVsOUpNaGV4MzFYUlZIK1JacGxzSWh2aytSSlBuSktxTnQxYUlm?=
 =?utf-8?B?dXN6bmx6cEpEcm8yUkFJcEN0dGtHMzBGR2ZLYTJlR25HUE5hZjE1MldRbGZE?=
 =?utf-8?B?U1dycDFHbmFDNEljUXVMWEc1NE5RTWVMVUxmOVF5ZnlCWHJjUG0xVjErbFdB?=
 =?utf-8?B?VDZrWThZVGtkeVZxOWdJZVRpWjY1L3F2aUJCK0tKYk5XWFZDWkZMaEREVzV0?=
 =?utf-8?B?Y3p1RFN6TVMxRmJwWTkxRkZzWTFSVDJWdGtuZ0ViY1hFUThuSDRFNTJpdHNi?=
 =?utf-8?B?cnN3RFJ4TVJRUlB4bHFHa24yVDlQck5ZQXBaQUJhWWI1SUFVNXUzK2N5a1B2?=
 =?utf-8?B?aWpSem16bkczKzY2Z3orajZyQllTRWZUb1B5eGMzeFhyUU9hdEJBcjZpNGpq?=
 =?utf-8?B?ajRZWnl5d09uNVlNRlNYNVM4c21Qdm5DeDRiTElGbFczNVBXMVptT1pLT2Y2?=
 =?utf-8?B?STNISzJmaElCU1pJN3h5LzFvYXZyU1paRFRQdUNsRVlQS2I1NnNQM2FmTVVM?=
 =?utf-8?B?bng4L0ltVnVqYVNoS3R2UDZxdWI3WXpSOU5mMnBsSkUrQmY1M0d1enRodHd3?=
 =?utf-8?B?K3EyMURpdE90L0JNS2FBeGpUaktGdmN5dWVFSTZOZTVxUG9sYVZ5S3padWZU?=
 =?utf-8?B?Nm1WQ0FWRzNqM1U2VUI5SVlSZHdRM3Q0amI3S1pmTE1JVmF4Qk5VaWtmY2Mr?=
 =?utf-8?B?ZnZuYmJMWnk5UFpkcWpBQVJkYmU2TU5kSDhWSDhYbkRmalE3WUdDWkZ6aUVj?=
 =?utf-8?B?VThON2l6L3c2MEN2amNPSy9wY1U3WFVldWhMNEVUdDIwZnlYS0FoaVd0bjJa?=
 =?utf-8?B?bmpZbnZDU3RUYXhJQ0o5R2VlclRENXhITExyYmkwZjNHODUzQmE4YnlpN1VE?=
 =?utf-8?B?ZDEvNy9WbXkwRHF5aWJvUzVTRUtidjYwMDcyUmNlL3BkaG1wNGhwUVBvUVVm?=
 =?utf-8?B?Mzd5b1pTTHZYY0MyU3NBRzh4UXlGcUxMRDhIY29hb0pFU3RiZDhWMnRhMDUr?=
 =?utf-8?B?MGJKSlZuV2FFWEd4dFJsaWpteDB4M0NIMFdUSDg4Z0xnNUV1cmhETVRuanNO?=
 =?utf-8?B?TkZWYlJJNmZGQktCRlhjNnRYVzlmVGhUODBCb0xEV2hjT3FYTVJDR0hjY2h4?=
 =?utf-8?B?WDliQzZVd0pVcDNjZjhhUUxMeWtIdktPR1ZJRC9EK3V0VlpseFZUaVJrSEY5?=
 =?utf-8?B?c3hOY3FUM1ozMTg1dDlFWFVkMXFmV3ZVTnJxOFNjcE4xNFpSbHAzWEc2S2F4?=
 =?utf-8?B?U2l3TzNpMXFmdDhpVll2MnNtV0U2ZW9VMFFlUmdyYW1TQnBnRnd6U2NucWMv?=
 =?utf-8?B?cFNRQzluWTVkcWdNY1hRc2VNRmVtaGR3eWxiWDRHVFlRcEZ6RVJaOVFuQU1V?=
 =?utf-8?B?RW1TVXIrbVozSGNPTzU2YTZLZng0VHJxOXl0VUhjcUNRdzExL0t2UldnSXZN?=
 =?utf-8?B?ZGF1VE53aTZ5cEN5bE84UkZlQWJoMXp4TDlqUVoyTWNXMGpHS01CRitzVzdk?=
 =?utf-8?B?cHloMlgyaVh2UFo2Mm1LcWxpTUpYTGNkcG8vOU1OSFFna0t1NzVjc2xpSEZj?=
 =?utf-8?B?cEJtR203VEhlMGt6RVVVTklwRVVtaDhRc3l5REkxMzB5NDhLbVpwYUI5UWMy?=
 =?utf-8?B?QUNleENGejVLSktmMU5idklpSEVJWnFHN1FCbUNxR1d6dHJ3a0U1NHF2UnRU?=
 =?utf-8?B?MWVzQ3VscysrU0k1d3VucFdRMkdwbnV1UFJ6Vlc3NTdJMTdnZzNZWitUK2hR?=
 =?utf-8?B?MzVia1krR0pyektuUFhwTGVydlc4R2UwYnpJY1RZRDhCTFNQdkJEaDFOZUhJ?=
 =?utf-8?B?eFNDa202UER4Rm0rSFZDT25IMjhuVEtaR2svbytYRitrbU5wS2liTWxTR2pa?=
 =?utf-8?Q?kW0pCi6AiDJiUfadRBG0LTs=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 48531cf0-c2f1-4d82-9c25-08dbfcc1d08d
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 16:29:16.2077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P6aWcS4NVFV9qzCNh6ULaQtrwrBgBZDIXjQ8nTTnsEpZTCIsfGaGjCMChrpCQjiXLeE3F+OexB+k1eDss9BT14SUw9zIBLxhWFOZg3BTAKY=
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

The firmware request process is device agnostic and can be used for
other parts.

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
 drivers/usb/typec/tipd/core.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index f0c4cd571a37..83e5eeecdf5c 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -873,6 +873,30 @@ tps6598x_register_port(struct tps6598x *tps, struct fwnode_handle *fwnode)
 	return 0;
 }
 
+static int tps_request_firmware(struct tps6598x *tps, const struct firmware **fw)
+{
+	const char *firmware_name;
+	int ret;
+
+	ret = device_property_read_string(tps->dev, "firmware-name",
+					  &firmware_name);
+	if (ret)
+		return ret;
+
+	ret = request_firmware(fw, firmware_name, tps->dev);
+	if (ret) {
+		dev_err(tps->dev, "failed to retrieve \"%s\"\n", firmware_name);
+		return ret;
+	}
+
+	if ((*fw)->size == 0) {
+		release_firmware(*fw);
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
 static int
 tps25750_write_firmware(struct tps6598x *tps,
 			u8 bpms_addr, const u8 *data, size_t len)
@@ -961,16 +985,9 @@ static int tps25750_start_patch_burst_mode(struct tps6598x *tps)
 	if (ret)
 		return ret;
 
-	ret = request_firmware(&fw, firmware_name, tps->dev);
-	if (ret) {
-		dev_err(tps->dev, "failed to retrieve \"%s\"\n", firmware_name);
+	ret = tps_request_firmware(tps, &fw);
+	if (ret)
 		return ret;
-	}
-
-	if (fw->size == 0) {
-		ret = -EINVAL;
-		goto release_fw;
-	}
 
 	ret = of_property_match_string(np, "reg-names", "patch-address");
 	if (ret < 0) {

-- 
2.39.2

