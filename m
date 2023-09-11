Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C829E79A5F2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 10:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235019AbjIKIW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 04:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233257AbjIKIWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 04:22:54 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2089.outbound.protection.outlook.com [40.107.22.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3E5110;
        Mon, 11 Sep 2023 01:22:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oHoDJv1h2J7uejyW7ZTBJqyf4damWccsnuijKEkYfbT33Eis6+v1Axd/q/svMxY3YCqXWt6ycnR0dfmQaVyHNAYpAzL7IR0i+9G6Pn0wmXN9J4Q40O9cx9ycz4J70+MkOPoCFzyUupYBRgPZYk+rtFEilIYY2DXpWV74dE6R7Zte0f4Lkbjo2pNkfqoNmrQB5d9W924JeVVRrPoPaLO08X68NlLSdH3NArbC71QrzMlNucNlu3SN9lumRa4GwYCPPV56vr4velAIXq2Ok1lc6XTqjDn/OSnCdKdWfRLl8FXeYk2pIRWo3Sf+u/xNCyVHSaQc9i1N1h+tfu40aNfi2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KkVjSHCVX2vsyFl7OLD6duvvFrtJPg+ZAufbThK/j4c=;
 b=TwP7ABLl9WdO2RW/dpOg8mEfRvfYCl52DBGPPM5lTKeETvca30zzBQX9ZEMdDRSURG3OWlY4R3e10vZz63ajv9/u0JV3rtKM94VdbcyoBFf3HIcUQO5XYrmneg83rwI1gZuB2gK2ItMr0gUWblM000TREoe2ZJBybK4NnCxdY9d2WvSuPtO299sJ63rcqWPpjuxv6pZp0SQCQgbqeEmSecF4YQDz4ETRASh6juAo7SJ2Z1v/Als7RSYwiQxZX5eEFJNGBY37y5NKn3dt9FeYTNPy7kqp/6tioYpjx9iVVmoUIIcv3BmAaYteT+npGohK/Ynf/0zKSnF6xX9VSUVrtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KkVjSHCVX2vsyFl7OLD6duvvFrtJPg+ZAufbThK/j4c=;
 b=2Y7uiNU9p/KBdCEhZjQExRTjk34Wop3q7V73g6JzXvaHiY5MQyHVLcKBNioX/JKRm7T3OBRGz8k4eyIM+9tO77DO/8z0Ee0hnmRP06YrSH2gFyANjvRcse9Ibk0C2vLrJpJDWtzLe2rFYaGQhcPD60f+bvZEvcmtEjhj/B3aQ/M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by DU0PR08MB9394.eurprd08.prod.outlook.com (2603:10a6:10:421::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Mon, 11 Sep
 2023 08:22:47 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bc92:216b:11ed:db63]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bc92:216b:11ed:db63%6]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 08:22:47 +0000
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
Date:   Mon, 11 Sep 2023 10:22:38 +0200
Subject: [PATCH] usb: misc: onboard_hub: add support for Microchip USB2412
 USB 2.0 hub
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230911-topic-2412_onboard_hub-v1-1-7704181ddfff@wolfvision.net>
X-B4-Tracking: v=1; b=H4sIAE3O/mQC/x2N0QrCMAwAf2Xk2cJSi1V/RWSkbbSBkY52E2Hs3
 y0+3sFxOzSuwg3uww6VP9KkaAc8DRAz6ZuNpM5gR3seb4hmLYtEYx3aqWgoVNOUt2Awee88Xx3
 FC/Q4UGMTKmnMPddtnrtcKr/k+789nsfxA8GULi59AAAA
To:     Matthias Kaehlcke <mka@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Javier Carrasco <javier.carrasco@wolfvision.net>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694420567; l=2126;
 i=javier.carrasco@wolfvision.net; s=20230509; h=from:subject:message-id;
 bh=oCsLx/a2DAyB+iiaf6JFdAjrrrjl6uj4Lyk2O/OWTc8=;
 b=yMXT7qKtsGQC/hcF31OfVgsn2qfdXlIlY6d48tckha2/UHn46n8tSjRMN2xdIJPraW95qrY9X
 LDg6FO6bxY0Awn0CDx64kGSnB0v0gB6Y+KYgxpoRavjLheAao9v1QBx
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-ClientProxiedBy: VI1PR06CA0133.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::26) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|DU0PR08MB9394:EE_
X-MS-Office365-Filtering-Correlation-Id: dae7a88c-494a-49b5-24e0-08dbb2a047fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9MjqpCEIQwafQpcnhvRimXTZrF/nxAdgg8Pqf0GhpajOpnNbD6eVgVb4fl2leDUOZfWtjwOoHoENQDXSwaz0yK1OtMBgPDrHMWE12sHn1FBcc6Sl02pjWxiyhMtZViPmw9GlyzyxdTOqKu18onTOr9nJK+S4lJdioGNt8V0aS4peWsQtQd0gsIxHyOoRh2B9KL0AEd4MkiQBh1ksSg4W1SxC+eYxHRz8Q4tYC3+QEKn+Fa9+zphZh4/+OaMSUEHbrEInqA82Qb3sqdKHzJhMrMFkwhHbHtT0KLeIDL1ydNqbYFvTTvUDIoEz8McadwpQnMyjAuwHlCejVXCjsiwHk3QB6VmV3Steas66+hWMWL5kYEmKOh6dBlXW9190iIGGyipwLUNFL/oNCy+2FZV+DpdVvQ8FrXJkCi+4cdips2SEsQWNrLR6OqSUeCZd8ywehVtEGLTIxz36qWxm+hxxQOKI49fpuJcpkXHVGvb/QUQyrYNy+q11c8lQ95tsyOR2g7AR/VxcwZ2bseDKxL+KvipSQm2TR9vXTw0GTF6FcS/UhEab8r6TRZwbOILRVjP/EIoj+pZ9dBoZXxGOxekpGALVLOwqJY6JMfHt8iNqJGedh7TKT3lOd5QQMmRfOtBO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(376002)(39840400004)(136003)(451199024)(1800799009)(186009)(44832011)(2906002)(5660300002)(2616005)(478600001)(4326008)(6512007)(8936002)(26005)(6666004)(8676002)(110136005)(107886003)(52116002)(6506007)(6486002)(66476007)(66556008)(66946007)(41300700001)(316002)(36756003)(38350700002)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWs2SVhBbXZ0SWRZN3Roa0ppV3FRWDNEQ1RscHZzbjA4azV1QWl5anc3L3RV?=
 =?utf-8?B?LytjZGlEN0g3TDhYMGpCc1huMFNTRy9OVTJ4R1UvaXVzQkNndjdPSzg0cUZt?=
 =?utf-8?B?ME5RZ1ZJYW5WTFlwZFBJVlcwK0M5WitsU0RxZFlQZWQvNEFIWlhKbU8wUDRa?=
 =?utf-8?B?OGZlYXI0VnZBMzNKV2R6VWNHbXhXNGFCcllVV29NWkdEUnNLbko2eFBycUV6?=
 =?utf-8?B?NTBFYkdEYlNyczlQNlFCc2tCY3d0UjFBUXpLdm9sdjNtTmkvdmxiWHBORlo2?=
 =?utf-8?B?MSthYVdDbHRMYnZ2QW85VG5sYndkZDBKUE8yVC9qTjN6M3NtRXlzcW1KdTVF?=
 =?utf-8?B?M3pYZ2hlSmVLNjMrNkdtLzFUVVRiUGhkTytzRnY2cis2Z1BsR0lKUElHWnRa?=
 =?utf-8?B?WW5UKzIybjgxV0JLQWUwQWZWZklBUWIwekp2M0xrRUtEUkIyeTRyZlk1eFRw?=
 =?utf-8?B?REwvVkJWUDIrbURFOFF4R0dybmxQYkpWS0N1M0Z3WVpKZHZxdUJrUnRhc3Jw?=
 =?utf-8?B?QWF6Y1c4UWZ5MWxWQW1aNEc4bUhyRTVhWEF1MzRlQUdESDR0SlovZThkZys2?=
 =?utf-8?B?ZWRLZjF6aTd0OEcwak9TS3RPKy91VnVNUjAvTjk1SXFFVkwzdS8zYVNIdmhr?=
 =?utf-8?B?LzBVVUNSNXhtT2dRVmZIVlIzZ21NZThOM25hTGNlM1h3cDlDcFlSRm15clZu?=
 =?utf-8?B?OTJqQnZkemdHZTZGTjgreVdndlllTklZZUZMUFJRTGQzTkhaQVRiaW1zWWgw?=
 =?utf-8?B?OStvdk9reFQwOGdEaTJlR2JsaUZHVStqVzl4OUV3VG9jS3RPdkp2UDBSUmJj?=
 =?utf-8?B?M1NZaW5TK1pXemVGT1NLUWpiczVyOWZKS1RHR2ljakViK0Z4OGxGTmdDYmRo?=
 =?utf-8?B?RlV2UlB4M2w0V0FXZVlHaVFTVnV3QlQ4OGF5cTR4NzROcE9HQXM0eW40Uk9v?=
 =?utf-8?B?TkRsQmJKL2V5QUh0cXlFMGJXdm10NWpGNmtUOEdmQUtoMlFyang5UmEzdW5H?=
 =?utf-8?B?WVFGMDdtbDBsUWRKVTErNFlSdGVyc0p6RndvcW1LRzV0OVhiYkVQWXpUam0y?=
 =?utf-8?B?NGdwUW5BKytxN2UvbGFUMkdENGJ1RVZvU09yUk9KRU9VaWpKcVp6TDVXakhR?=
 =?utf-8?B?QTArSmpUcy9Sb29kdGZDTUhXcWwwdE5kV3VVR1BCZjQxam9BcnZGSUxhWk1K?=
 =?utf-8?B?MWxuYW9VaGdHNFJGNGhoenM0a1QyTHY0Tm5EWEJRV01ycis4MGZDaE84cncz?=
 =?utf-8?B?SUpYcFRFQzBleEkrcUxHalRRL1lQSWNINkQ2NTR1NTBaQWxjbjNTcnpDSGlp?=
 =?utf-8?B?VG9TQUd1V3UyTlBUOU1mL1l5RWg1RVRjYWxGaDdaWVdOaHNhNXA1Y3FRTFRT?=
 =?utf-8?B?THZmeGJRY1JKbUtWZlVKUHpYUXFVcUsyMFJlc0FPTnVaVjNBOG4zTlpRSnlW?=
 =?utf-8?B?aU5KQk0zOEs5QjlYTy9JV1JNbE83aG55L1AwcmJnc2RZSitvQzcwa0FIRmRz?=
 =?utf-8?B?M1NNcnhEMUZjU3ZDQTZmOGxpbU5OZmZHNzlaRXFCdTZGNi9hTUFHTkl6U2VT?=
 =?utf-8?B?WnNwNVBwdkNXeE50ZktFS1RUMkZacFVRdTZWLzBVQjRqSUxXR0h0Z0R2bjJm?=
 =?utf-8?B?UjEzN3pDUjFESVJHVXpMQlVmR2Fqc08vdmdKY21wV1phT2NCaXFIbGxYVkxx?=
 =?utf-8?B?SW9OTEpndnhaOTlXdit6THVVaWx3S1lidDUrSlVMRnR5YktJVFA3Q2drZHEv?=
 =?utf-8?B?QXAxTmJxd0x5eGpaSkhrSUlIaFV0RllmVHZWZ01KVHZTUWtXcEduVTZiM3dM?=
 =?utf-8?B?L2E2Sy9TdG80VE5od3dVcU45TmJydGlmaFhTSWJxVFZoQjlCb0pWaGx0aEda?=
 =?utf-8?B?YXFza2VyajVUQno5QzNRZko3SHowQVRQUU01YzgyVno0a0JYQjdmTG9ibEI2?=
 =?utf-8?B?ZUdMWHA3dUQ2akpHOTNFV1poa1BxdUJLZU1VaExCWUwrd0Q4UUdrYVFqYzRC?=
 =?utf-8?B?dkpJT3JsM2JMUGtZOERiZkZ2UWQ5QUdsVVQ4aVNVNEJ0eVF0em5QdEQyYWw2?=
 =?utf-8?B?Ry9SZGhYUUFyd3J6LzNVdVlMWk9nbXVpR2pBTW5DN2hXZFdyTEdoQlNrRzB0?=
 =?utf-8?B?clM1K3dWS0U3VmVGU1A3a2lWUjVWRnhYZjNVdGJDc1h4UXpnSzRVVk9mY0hI?=
 =?utf-8?Q?S5y2JnHtkF/gRM2dB7XtT18=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: dae7a88c-494a-49b5-24e0-08dbb2a047fb
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 08:22:47.6562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eXuJitY2oXfBNpN83DbLGuM5rWgqHAy3MULAAsUi/QCjCpE/vBofJgvicPEFP8davgi63dc75j8tYxFrK6XtXYa5axTl/4MJDqiP3dtu4k4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9394
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The USB2412 is a 2-Port USB 2.0 hub controller that provides a reset pin
and a single 3v3 powre source, which makes it suitable to be controlled
by the onboard_hub driver.

This hub has the same reset timings as USB2514/2517 and the same
onboard hub specific-data can be reused for USB2412.

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
 drivers/usb/misc/onboard_usb_hub.c | 1 +
 drivers/usb/misc/onboard_usb_hub.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/usb/misc/onboard_usb_hub.c b/drivers/usb/misc/onboard_usb_hub.c
index 3da1a4659c5f..57bbe1309094 100644
--- a/drivers/usb/misc/onboard_usb_hub.c
+++ b/drivers/usb/misc/onboard_usb_hub.c
@@ -434,6 +434,7 @@ static const struct usb_device_id onboard_hub_id_table[] = {
 	{ USB_DEVICE(VENDOR_ID_GENESYS, 0x0608) }, /* Genesys Logic GL850G USB 2.0 */
 	{ USB_DEVICE(VENDOR_ID_GENESYS, 0x0610) }, /* Genesys Logic GL852G USB 2.0 */
 	{ USB_DEVICE(VENDOR_ID_GENESYS, 0x0620) }, /* Genesys Logic GL3523 USB 3.1 */
+	{ USB_DEVICE(VENDOR_ID_MICROCHIP, 0x2412) }, /* USB2412 USB 2.0 */
 	{ USB_DEVICE(VENDOR_ID_MICROCHIP, 0x2514) }, /* USB2514B USB 2.0 */
 	{ USB_DEVICE(VENDOR_ID_MICROCHIP, 0x2517) }, /* USB2517 USB 2.0 */
 	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x0411) }, /* RTS5411 USB 3.1 */
diff --git a/drivers/usb/misc/onboard_usb_hub.h b/drivers/usb/misc/onboard_usb_hub.h
index 4026ba64c592..2a4ab5ac0ebe 100644
--- a/drivers/usb/misc/onboard_usb_hub.h
+++ b/drivers/usb/misc/onboard_usb_hub.h
@@ -47,6 +47,7 @@ static const struct onboard_hub_pdata vialab_vl817_data = {
 };
 
 static const struct of_device_id onboard_hub_match[] = {
+	{ .compatible = "usb424,2412", .data = &microchip_usb424_data, },
 	{ .compatible = "usb424,2514", .data = &microchip_usb424_data, },
 	{ .compatible = "usb424,2517", .data = &microchip_usb424_data, },
 	{ .compatible = "usb451,8140", .data = &ti_tusb8041_data, },

---
base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
change-id: 20230911-topic-2412_onboard_hub-1d7747e84ac6

Best regards,
-- 
Javier Carrasco <javier.carrasco@wolfvision.net>

