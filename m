Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A313E7D9DE4
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 18:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbjJ0QVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 12:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbjJ0QVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 12:21:14 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2074.outbound.protection.outlook.com [40.107.7.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C064128;
        Fri, 27 Oct 2023 09:21:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GMOG9qOWDYGNTHMuJ6glRD22F0s4p2FYZM3vAw7FtsWhqVHP10Dp3Q4Xl0d6F/tVdaq7R5vCIpaeCl9EP1i37stetGJ3PWvqWhDQoU3Sg2NmaY4CgZO/j/z0Mm80JnET8nXWAIPaZP1dWKcMe2CdQx3HllD7K2RP0bPUgzrtqv6Enmp41NtAlB3FZsW2I9kBk5o6lKVWrVlPosKradDfzM+LT015boL25aGjl5s8l9H4Zqc0GAUieSi7SsKEjDeowd9/d4vJZM0DkNBLF7PiYfYoSU14W4c7Sxg4l9LJVavhSjzvpl1yy9A2J92pQ1lDmWzyfM3/74nGVFEDNftqdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oXfF10Q0mLsJLnXv+HwPR6voKQgjC1TRr/6WR5NxZxQ=;
 b=dToX/WfEAJ3FFAas7RISV1McGYA/zQuFJa1T8cy7H3NwflLJLqJf5fdadycNjRT/JPF5gXWJYwW4W4BRGVT/gjY+1h0kYIGNDZCcVORbdIAvwXR6nrDPjD6RRCfjwaChEiKT8Pu+tzuiGRlRZWnb1dbTWCeKtNuHA1UzD8LajxI/zw+jb4uP0Go8mG9F+s4dpA8MhXOf7nzaiL+ykRPFva0M4akqViacXcDOHJIDJ2qVHi229fNYrJoVsM781artl+0ecVH2/VIL588FJdEq7QFpO+ojtUTXxfvd/xRq3s2UAP0vX642lejq+8lZyT3oamxVjN7XrNObECGnhp2mRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oXfF10Q0mLsJLnXv+HwPR6voKQgjC1TRr/6WR5NxZxQ=;
 b=DfvKINUb8OeghUf8HHC5+aMxgz5dpiKg4UPCaVxSkiT3Rm1cGI+fD84sXQ3PElcnMQhN1qw2vt0KPdgk659gjrNB4IDZDr1cEBiR8zxsRKJj3mc/FyaQs4wLxo8CGE1xzM4k7S1DyIsjWcQF4ke8G/3OZujek8BM/WlyhVcDOwg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by DB9PR08MB9563.eurprd08.prod.outlook.com (2603:10a6:10:451::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22; Fri, 27 Oct
 2023 16:21:09 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::a309:1d65:f5fb:436b]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::a309:1d65:f5fb:436b%6]) with mapi id 15.20.6933.019; Fri, 27 Oct 2023
 16:21:08 +0000
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
Date:   Fri, 27 Oct 2023 18:21:00 +0200
Subject: [PATCH v2] iio: tmag5273: fix temperature offset
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231023-topic-tmag5273x1_temp_offset-v2-1-52ef3f3bd80a@wolfvision.net>
X-B4-Tracking: v=1; b=H4sIAGvjO2UC/42PTQ6DIBCFr2JmXZoCtlRXvUdjDOKgJAUMEGtjv
 HvRXqCLWXzzkvezQsRgMEJdrBBwNtF4l4GdClCjdAMS02cGdmGc5iPJT0aRZOVwZYIvtE1op9Z
 rHTERKoQoVaewulHIFp2MSLognRp3E2tlTBh2ZQqozXIEP5vMo4nJh8/RY6b798/ImRJKqjvvl
 Sw5q5h6vP1L/4acHSZotm37Au058wLnAAAA
To:     Gerald Loacker <gerald.loacker@wolfvision.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Javier Carrasco <javier.carrasco@wolfvision.net>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698423668; l=1858;
 i=javier.carrasco@wolfvision.net; s=20230509; h=from:subject:message-id;
 bh=WvsUO69p4hTpuJAC8gJYwF1xi3E+Aecqkb1+b5Fd9dA=;
 b=FoqMTsTUzIPyZdEMLq7muIbfvnU6UY1K8ywCUF5dKwxPT5SQW+S3gRmXJGwf3r5zmxpXiPxUj
 v0dzpc3wc+4C89wdVbRXkXNl/tWJH4jOv0hvrJLa2uqQ1anvOwquq3l
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-ClientProxiedBy: VI1P189CA0012.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::25) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|DB9PR08MB9563:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e63c9c6-c9f6-473b-f164-08dbd708ba0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UleYKHlZtJsZbzm4HagEF5avsA5BNSzv5FVW39JApu/RXf4EHExIQyi78JdvyogUTUD0tueIHW0/hTInpEUJAvDYdcHdeRMKJigxQE4wcyGuBkQLbuGeZBa3euX/hF9ie+VBd2dXWCtQYNVn9fkvYvDAUd0gfJHDRVik7j0GEkqngmYR2XjPNsbwxGGjLZL+afVOGALyBB1DDsaUrtjgLA6sfuxtWbIOHaPOpvhQZGYMtt9KCCMhCTCy4VSclaf/qld1ARksvwJ+CNSPxWh2WBbgC3yek0gpkUGGpphbdNu3hUbMd20uW/ii8fqqMl9IEnvMZpSCgWtdtIS2deHEk1krQRbfLLkoPIbC6zK2AgFRvrk9BwWIXsrNbC4nmhhnIsK7tWiPUAFBmiW+4Fd5otkcJ9ISKP/9531Uh7bBNr7mkCO1DeDn25DVZW5i6Ds0afTGeMS55HXSeK7ZvedfYk6seMOQ2ZZ/iLJJqgVBWzpKI09X2TOVdmXD+iRKanGGk9PLYrf+Wg61Fkea4gHdo9tbFoVE26zJraLqwvuoEVYqTG8L7gJzF6VGAOUWJMKff61wf1gUBViafiPQ5wx+2TSIxRt9wuOf2deYBVLJqqM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(396003)(136003)(39850400004)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(6512007)(2616005)(41300700001)(44832011)(5660300002)(107886003)(6486002)(26005)(8676002)(966005)(8936002)(4326008)(478600001)(110136005)(66556008)(38350700005)(66476007)(316002)(66946007)(36756003)(6506007)(52116002)(6666004)(86362001)(38100700002)(2906002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dE9oOVh0S3NtbjFCZGl3RHg5Q3dZd3NBRzdtTWxBdHJyemNCQVdCUjByVFRk?=
 =?utf-8?B?RU5qVmRiWDNhaVhSMXdYQXhNSlNGZmM2MVBrbERFMXkzcHBpNzB4MEs3MFRh?=
 =?utf-8?B?Q0FTYzRJWUJ4UmpQNEVsODNJTU44WHVwOSs0WWhMaDRXMHhsRjc4SHV5SS9a?=
 =?utf-8?B?VHFNeDZtN2NWemhNRFBEeEpMc0FHeDRmT0RLWTJOc2o0V3FZZnJRa0xiZ28x?=
 =?utf-8?B?Qzg5T1l2Wis0dUIvQ2pqYVpxejJIY3lqV3hOMDNNbDdGbzN0QzI2enljYitp?=
 =?utf-8?B?MkxvZE9ZRVUxZjBoWXMrQzQxOXMwQnFaODJJb3ZVVXJyMTZyeVU1VVlFeWt4?=
 =?utf-8?B?REttSGIxU0xQbVBGdVh4aEhLMUJ0cHh6ektpdWtqMzQxYTgxdStZVXRiRDJm?=
 =?utf-8?B?TWtoZVhZeHFJVEhvaUIvOHhuQ3M5NFFuWWxnZE1adDBxeXF0TGdlazQ3ZGtQ?=
 =?utf-8?B?N1JNMGRuN05Lb2o0VFpZWWtQOTRhbTdkTmFDbnZ4R1llM2FSc1VLVVpXaU9v?=
 =?utf-8?B?Q3hRQ3RmdTBIQzN2TDM1NC8vTTZlaDM0T1FsNDNmTHpRZndxWWMrZnBrK0RG?=
 =?utf-8?B?OVErMVp2a2dkWmFTOHVCNG51eEpOckdJYmRrZ29qUVFyWXc4a1ZpYzVqSndZ?=
 =?utf-8?B?dk5ZTnE0QTFHNkUzNmFwOVN6eng2T0xVQTlFdk9pMzlicjQzUW9wbytWQmp3?=
 =?utf-8?B?cndieHI3dVlLVE9QWkVXci9xK090NEo1M0RCQnYxTG9qR3dvY0M3Ykw4WGQ1?=
 =?utf-8?B?OG1EWHA3UzlnRlFsSENRaEt4amhUMFV1SlV1RXZBUGozcWFTMUF2R0h6dExp?=
 =?utf-8?B?NUtmSnI3NmhicUkwVXRSRHpVR09Ld1pITUxNRzJhd1ZvU2p0dVVzcTVBTi9y?=
 =?utf-8?B?VndlckN5bkFhTXhaRW9JWnhORXBNMjEvaEFrOWw1eVRsZzJZbHhSdzZ1cm91?=
 =?utf-8?B?Q29rRFdsUTU0VEoyTVp1eElweUs5ckh5ZUJrUFNIQkV3SXZMWW85aGpzclF2?=
 =?utf-8?B?a0tZNVFsQU8wZHp3cDhidFhMcmtGSUtSM2FJRXB0c3hxY0ZXM2psbC85bUY0?=
 =?utf-8?B?K3FNdklNWHFxUFl3YWRuZmsvTzRTNGt5UGF1SXVjQ1I0dUJXbXJBR3FGMWJt?=
 =?utf-8?B?dkdPWDZHeElSS1c0V2RodWFkY0ZRTkZrRDNxd1lQNnJGK21xNjZ5WWZyVnpC?=
 =?utf-8?B?Q2p4OUxjVFNRdXB3dFY4TGlqcStlT1JyQVRMby8wUTlyT0ZEY1RPbDNCUGQ5?=
 =?utf-8?B?dVRsa0F2R1FZNkJzZHhlOWZJNE80S1Y4aStwSlhXRVgvKzBOTjU1d2lLa1JI?=
 =?utf-8?B?WWVhRnR5Y1RrbGwxVWFvVzBLQjI3SmpBUGphLzUyMjFVRVY3aFM3bDR4UDVX?=
 =?utf-8?B?aTBjQnR2YnBHc1NzV2k1WjAwWFAwblpoN0dUbE00UHF0RDYwdGczTTFteDVW?=
 =?utf-8?B?aWJQMXpLbEFYeXB3QWg0b1F3bi8wbXpFM2Z6Z0MyNGVaamFGWm9mUllJQTB6?=
 =?utf-8?B?c1YzY202RTRMZkxsWlhJVzRIbkQwdEM4MGNLQVBtZlJDZ2w4OVZ4N0E1ZGpU?=
 =?utf-8?B?VHBTUHkyMWFZcWQ0bDZuVG44czZORGtHbHhJbnN0dEZGdk0weDNTUHBoVHNX?=
 =?utf-8?B?UDM4TVpKZlpTUWg4TDVjOG4xZEVMN3crcE1zdWtMUHI0b2RWVy9nRzhIMlFm?=
 =?utf-8?B?eE1rMmhuVTJJVHpnNVIwckNEaXlRMzg5eE5nNC9VMjcxQmJLT3h1NFhabWd1?=
 =?utf-8?B?RHRId3BSSHhMQ3ZEK1RBQ3R3ckRNNWg1YngzNnJYV3owWE8rUDhEcjFTRlpu?=
 =?utf-8?B?Mk9qRTJlZG0zQzFtdzgxRlJaeTl2UmgvbEl6UDZhMGdxQUkyZHE2ajBZY0xR?=
 =?utf-8?B?ZktlMG1CdlRYNGJSVEZkTXpORTZrQ0xmbTVvT1ZPNTIzWTVBOUxLOWhEaitK?=
 =?utf-8?B?M3NUckUxb0NDSjNjSHlQcTdudVhwUURrczR1Y2k3UE5uRWJvYlFxU09yZW9a?=
 =?utf-8?B?bjA5TFlKbFhTUUlvN0VuNUpybGxSOTFLSTZXZmpJKzJxaVZIMEdGaDVVaTVp?=
 =?utf-8?B?Y3lQQzFYZTZxNmxkZGZ3cUMrMWE1MlVMcmNja2FrdzBndHJNTVpzb1RsK1kz?=
 =?utf-8?B?a3RQYytiTmdaTm9paGE3UFh0Q3d3OHJVTUVLMG9MZktkMUNUMmdYYmVhSS9q?=
 =?utf-8?Q?BsA6y+H/tiLffx1udsB45FU=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e63c9c6-c9f6-473b-f164-08dbd708ba0b
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 16:21:08.5582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zWAmNfEmuuj4Q6QSZonxZ2FyHC2+86Xr6UyVJ8XGnQQNbHG+o/oYCgNS2HVWs7oUUp7i7/P+F9H2E3qmNczczo+RU4T5olKhYYo5xLv2hfQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9563
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current offset has the scale already applied to it. The ABI
documentation defines the offset parameter as "offset to be added
to <type>[Y]_raw prior to scaling by <type>[Y]_scale in order to
obtain value in the <type> units as specified in <type>[Y]_raw
documentation"

The right value is obtained at 0 degrees Celsius by the formula provided
in the datasheet:

T = Tsens_t0 + (Tadc_t - Tadc_t0) / Tadc_res

where:
T = 0 degrees Celsius
Tsens_t0 (reference temperature) = 25 degrees Celsius
Tadc_t0 (16-bit format for Tsens_t0) = 17508
Tadc_res = 60.1 LSB/degree Celsius

The resulting offset is 16005.5, which has been truncated to 16005 to
provide an integer value with a precision loss smaller than the 1-LSB
measurement precision.

Fix the offset to apply its value prior to scaling.

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
Changes in v2:
- Fixed typo in the offset value (16005 instead of 16605) (Jonathan Cameron)

- Link to v1: https://lore.kernel.org/r/20231023-topic-tmag5273x1_temp_offset-v1-1-983dca43292c@wolfvision.net
---
 drivers/iio/magnetometer/tmag5273.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/magnetometer/tmag5273.c b/drivers/iio/magnetometer/tmag5273.c
index c5e5c4ad681e..e8c4ca142d21 100644
--- a/drivers/iio/magnetometer/tmag5273.c
+++ b/drivers/iio/magnetometer/tmag5273.c
@@ -356,7 +356,7 @@ static int tmag5273_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_OFFSET:
 		switch (chan->type) {
 		case IIO_TEMP:
-			*val = -266314;
+			*val = -16005;
 			return IIO_VAL_INT;
 		default:
 			return -EINVAL;

---
base-commit: 05d3ef8bba77c1b5f98d941d8b2d4aeab8118ef1
change-id: 20231023-topic-tmag5273x1_temp_offset-17774cbce961

Best regards,
-- 
Javier Carrasco <javier.carrasco@wolfvision.net>

