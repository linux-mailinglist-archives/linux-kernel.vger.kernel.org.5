Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6612808712
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379101AbjLGLvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 06:51:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbjLGLvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 06:51:14 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2064.outbound.protection.outlook.com [40.107.20.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D13D4A;
        Thu,  7 Dec 2023 03:51:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EVAk7iX9ZdNiXQtln7jLgNqgGtb34MAO7F6OWMqOeG9EffhnmUORAQU073SKcRgCDEjGEuRSxFKnIz0qEc68tpo62XS/RpmfI+R90y/PlJOEjG4RM3sSw92zZuFB0/4N94SWFfLPiQJ1yLJ7P0eMK00CwntxNo86GVeF3b5Uy1Aqs7EWSPstiqRXWuM1c9M7Uupk46JQEnV8fymoHjWlNs9Y7Tul4H2jTJGDbITldIh5ykMKbRxWWzxgCHSOkuOSEHBynI4LDQMfVyogByQBIPF1g4uQDbsaiJ1IYH/tFMzvXGbqiATeCykykY27/YX0FxCeRPXCNRoMAGxss6hbeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XOVUwsCdesOAxIwKuBpk7IheoIyYIMKYs3+/KWhnNw8=;
 b=J0FXJkGwiiq9hsNhDrxkipH/JVLJJDHAANLJAIiJv532WiYbsxFDt7JkyAhOLo6eOtf91Cg5fmHgcHOCNX8t74QnzdgvooHgoC5Q6+/CWzZrNaDdMFqCYv2GyxHLnCSXTg55bUCyEZjWA0s5oD00IBi0G7ztfhj018EJN6yfTb+dRAIKaehF483K2ojBEoyje6ARjYHYsrvtk8HFrc+FriL/LSy7e/L++2ohge1P+IRtefAuyZ6ghSAMFTSbeCXCxLgRIkTTIs3ugrpgIaBziv20ihE+zqNXrl37qISPC9ZE7NvygGqm0mC5atutFyOUrHeSE5gUDXhNi+z7B987Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XOVUwsCdesOAxIwKuBpk7IheoIyYIMKYs3+/KWhnNw8=;
 b=yT73oPMJmwnzrlNd9y97Wo05beUTMeBsbGc9Gh9mgCS4I1vtgrko2uKoLr+skYQy/S0cXJhXA3eYjB4x5D4rsuAQKra0ljqjga2kNKOIBGYxug2y3zyqPTdO2WEZEo/IAHBTK/sZaSO/DN1iyzlZzyPRfh5I4YlwIX7Xpnp0WxI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by DB4PR08MB8054.eurprd08.prod.outlook.com (2603:10a6:10:389::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Thu, 7 Dec
 2023 11:51:16 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc%4]) with mapi id 15.20.7068.027; Thu, 7 Dec 2023
 11:51:16 +0000
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
Date:   Thu, 07 Dec 2023 12:51:07 +0100
Subject: [PATCH 2/4] usb: typec: tipd: add function to request firmware
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231207-tps6598x_update-v1-2-dc21b5301d91@wolfvision.net>
References: <20231207-tps6598x_update-v1-0-dc21b5301d91@wolfvision.net>
In-Reply-To: <20231207-tps6598x_update-v1-0-dc21b5301d91@wolfvision.net>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Javier Carrasco <javier.carrasco@wolfvision.net>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701949872; l=2038;
 i=javier.carrasco@wolfvision.net; s=20230509; h=from:subject:message-id;
 bh=IiE6db3v4YrX0nZYmhvzOKALUG0QQqEAuGZEbigpqME=;
 b=TrqZJpl0BlUS3GCONO2c/i7kZj3SUO5wEvD22r/kf6tYVFUoSEiJPOPzy+1Exxc2c/ga9xIVx
 PP2PCmGyGO9ClSBkFbO9YcDs4YxKGTSzxGDpIFKz8PXTDmpzCpcUX/5
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-ClientProxiedBy: VI1PR08CA0248.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::21) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|DB4PR08MB8054:EE_
X-MS-Office365-Filtering-Correlation-Id: b890cb81-ad2a-4f87-8d18-08dbf71ad02b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fw9m00jCwL73MpgX/9RSdUSaTWjpW4xNNUntMDtGmqvL5Hh6mcTRfN08FurIIOOZEUctP5mGApQvClHNVvrHsNAbZCXv57r0eQLgj531jnqqWmLMYRzXcQia8XZqWtlwBRTC2DRSm1jsY2EcgRfoVS+HGcMS89K64s1H+XVMYnW0aCQ7XN+Uz8NzFmIsJYS/jpEGHUVbjoskz1kWGrntg9YKCI4xiW8jfOUO4DBZc0c0o7u4OKrxW23PewrH9AE37z12Pew0xbEK2GIZGyG7peM0rp5WjF0lLjj6sZkqFGd32eaH9AKsIXfT7hhNb7kkKuv1lGasRBKFmEkFEWo/+BNfsh9e4CIAT9ZtJX51h8Vdx2n5ogotlRqe6O4RA6DxeC/mqQzlqESz+KYhM7/F2W5OosdevGIqC+u8SWTtDvYMUQJnW/pAfaOSpVu0D19UT35jk7p0mFT1Ta09r+JF4LY4pB1ciVoKDGhqW4oJ33u7l+7VjI7QYvnFOwxDfHfVm2UmxOXFHF7Ke4RDvjhLYX7j4VkCII7RLkTE3ASL7Ha+mzsM2pemVz96MzAWsth9ck2aEQbSz8dkjz+8NPVAdb8rpp7FQqPgZR/H90YhihIm2z1xjWF/wkqnGtHDfbeo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(136003)(396003)(376002)(366004)(346002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(52116002)(38100700002)(5660300002)(38350700005)(2906002)(2616005)(6512007)(83380400001)(6666004)(6506007)(107886003)(26005)(110136005)(36756003)(6486002)(478600001)(41300700001)(44832011)(66946007)(66556008)(66476007)(86362001)(8936002)(4326008)(316002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blVZejFVTDRqenFmZDUrRVBmSXpLVXJiMmM1MFE2ajZtWWlHTUpScGV2K0Vn?=
 =?utf-8?B?VFVzWUppcHJGMm9nQitQSTlka05Fakc2cU85cnpyTnpLRFNiSG91SFVPV2JI?=
 =?utf-8?B?bFlGa1hTeHlyc21yUFBkUjVlZTRtanl6OVMyRjlMbFpnaGMzalFTT3dPTjBJ?=
 =?utf-8?B?aDdMa25jMzZRUExsbTBCQkYrekVROTJJYVhvNnM3NjNPdDNyRFpqVDRPc3pn?=
 =?utf-8?B?WjJiaHhQMkRYUDhsMkJsYnpsZy9LQ0hJbTV6bDV2MXRIYkxSZXVsRUwyRHpJ?=
 =?utf-8?B?MzNROEl5VndBQ2djQWRmTk0zVG15bmxta0h1N1Q3M2dZbFhFVFZ2K3A1U3B6?=
 =?utf-8?B?UjQ3WlM2NUorZFFvMlZGMnZkOHNYUk00NGFvd2FvbVlHZlo4VmpoM0pZc2FP?=
 =?utf-8?B?RmU4T2Y2QkwwWlhub3RnbUFHZFhVUXpSUGIxZHVhUEhzaDdPUldRWlRBZkZM?=
 =?utf-8?B?dlJydEwvMEk5NjR2KzQyb2J4OTdNb25adForbWh4REpYM0o3RDRaUkFnWWJa?=
 =?utf-8?B?c0MzNEFRRE5DbW9xYmthd01VWmU5K3RYa2RQR0V3Tk1wK2JkbUdYSlJVeE00?=
 =?utf-8?B?dXIzclYzdkNPWUlhTzJPNWV4bjlaSHJ2cW1QS3ZnYWRVWU9BcC9lWlpqZVBC?=
 =?utf-8?B?NHhvYy9zTWNQNFREQnZJeVBrSzh4Q2VTTmE0dHdNY0pNQUdSaSs4aE84Z3Nx?=
 =?utf-8?B?bnBxN1hjRENjZFR6cGJ3S0tCRzZYVHdNNWNsaDQyazBhOTVGWGZKbHRrNjha?=
 =?utf-8?B?Q1lId2VDUUUyM0llaXA4b3VKd3l3Z1VvZTViRkZhR0hYUDd4b09LbmxNTFhQ?=
 =?utf-8?B?S0xtQ2Zodk0vaUpGM2FOY0x2MHpPemcwT2psTE1hSk1uSWZsS2oxZGphRmJU?=
 =?utf-8?B?MGRJQWNuWkw4L21VdlVnNjVZOG9EMEFVQ2VUcjhEd1l5VHNHNVlyaHZWdE9I?=
 =?utf-8?B?RFV1bWdJVlk5Q1ZPVmZ1UWZNMDc2citTUkZKc09HN0FwNmdIQmR3Nzh5dVZM?=
 =?utf-8?B?aGdpelhrazZLZG5JamtNbjZncWhPQWkvREhDaHVDR2RwU2dWdmJJcWlDWDVo?=
 =?utf-8?B?RXllS01rZ1RMSDJlNXJRQ21hMkJwb1BnVkxDR1hxdnVYRTYvZll5K3d5ZE9k?=
 =?utf-8?B?cGFuZWhmSVg4SXhsbTYrRjhuR3RvYmpWNGp0Q2lqOWFKeVZiT1k4Y1Jydklj?=
 =?utf-8?B?UE1tK1J0azZYMHFjVFN3WWZ0Y2pGMEdJUG80MVJxbFVXRlh1eC80VE1HVi9Q?=
 =?utf-8?B?Qk5mWUozcEdkeW1KSFNsVlNpM09Pd0MvY1dFY2dtVSttL0xrUklGMWQ5WEY1?=
 =?utf-8?B?V2lmWUlzTkpEWUhhZFFqd005NUZIRmZhUi9OVlhGbDFtdm5PNy9uMWVFUFdV?=
 =?utf-8?B?TlcvSTNjWXljMTRwNVhUaEREYlJxVG52VUN3S0xKZ1F4VWRPZVlrVm9ObG5m?=
 =?utf-8?B?NXl6MTl5VlhEWnFTOFpiZjREQWRVZWQ1dGx5QU8zS0tmMUtSYXgyWTVERFRT?=
 =?utf-8?B?blV5NHhhc21rUUp4ZDZPd1dmb1FvQnBYSVlvNXdnd0dPU3FlbFhFR3Z3Nytw?=
 =?utf-8?B?a1czK3dVUHdSNHkwL21iRFdQamRGZ0FUMGQ0NGtPRVVBaGV4anNSOWlKZURo?=
 =?utf-8?B?a3lab2dyVHpjcDNadVZJQUJBMGJQdDlhYytiRXdVdDdiVXBacFpHRWdlY1pR?=
 =?utf-8?B?c2UvY21RTjRWMXRuNFJUTXg0SEJrV3YzMGFTS2ttZGhiL0VvOXo5dkoxa092?=
 =?utf-8?B?Q2VyNUlNZ3h5NnRvSEFrQ25KdGF2M1NuZmF4MTBsWGdVS3JPQktKOXlQVFNq?=
 =?utf-8?B?ZFV4NGljd3BXSVBZTzlKQWZaUmdITlk3ZWdTd3pVYVRwRFg1V1g1Vjd4R2Mx?=
 =?utf-8?B?T2wydkpqdmMxWjV5a3ZjaFhLN2h5ZXRyNGwyNmFCUnozejlQZkFQS2NsalJl?=
 =?utf-8?B?Ym5meWVXYktJSXluRmpNdzNjVG5oaGFaWmRqZEJxOE81SmdaL0F2NUY2RmQv?=
 =?utf-8?B?S2V1SC9rbzJDSlI3ZlhNSkg0dXNIWloyeE40eG0rSGVQang1K1JMTzhuYjhq?=
 =?utf-8?B?bG9zVVFjbXcvMlRheGdUYXIyemRFSTE5ellXZlhGQUdNMnV4OVArV3JwYWU2?=
 =?utf-8?B?MkZ2TVNDRTArdE9XQlhMUVV6ZXQ5Vk5obXVBYUQ0QkVRNForcGhiNU8xb21l?=
 =?utf-8?Q?aptzM4pqBtRTEiiWyJX4KQM=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: b890cb81-ad2a-4f87-8d18-08dbf71ad02b
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 11:51:13.7891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HTCWi00nD4a625C3drVdZs+QXipLfrXZG8Jqk0hO6sQMiHj2PtMK2eekLddUGwWHSwW3iolWzy1jNv+xPxb0ZtowvgucvxWFrDx6rfJiUmI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB8054
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

A probe deferring mechanism has been added in order to account for cases
where the file system where the firmware resides is still not available
when the probe function is triggered and no firmware is found.

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
 drivers/usb/typec/tipd/core.c | 36 +++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index f0c4cd571a37..165a1391dc72 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -873,6 +873,31 @@ tps6598x_register_port(struct tps6598x *tps, struct fwnode_handle *fwnode)
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
+		/* probe deferring in case the file system is not ready */
+		return (ret == -ENOENT) ? -EPROBE_DEFER : ret;
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
@@ -961,16 +986,9 @@ static int tps25750_start_patch_burst_mode(struct tps6598x *tps)
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

