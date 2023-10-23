Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB167D2ED8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 11:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbjJWJuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 05:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjJWJuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 05:50:19 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2071.outbound.protection.outlook.com [40.107.105.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FBFDF;
        Mon, 23 Oct 2023 02:50:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cClyaICvAudeFC/Ov3cPcyKsPRcy5/O+Kf1hHr16Q59QjZg3KxGcfXcdqloh+YdJs7InJc/euBibegIHjwIzBS8CgNc60NzeyiLEbKN+eZXGCb1Fj9OJFLQ29xPHqaSta3VlQ5XnmLd5aXg/qo7Z7oFSMX+UIzE8b3SM4ftJuqcs7/tDdkNjHVGYU6caIhpFZlCsH0kUTen+bX5q5QlqbGUWkVVuutn3Mf7auOQLjBcn8T2KQy97JQjb3vESt2Ck9SobiunYTcQzAM8IBvU7sing7ZXvParr3HWydh9mm13W/vtWEfnmDOILMlcJNAJjssksIImu8cq6Vj/qGFmjUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HsZWgVGxEw1SijQBMicQOvHLlV1xVTWpvaiizw4Ea20=;
 b=a0f+a5WgGmTCpBVGknzZSHpc/+0L4/l97p08RtphdwXD79p6FnAqJexZGcPZcqrMSdmMKDTAa/EjFPVOPPcOOGNmnH+EeWqBEbeSyYSpdoD7qVQwK8UkCPnk0IYyoSnpD5EocgcJCQ7qZnkTns7B8KYpVuhgb9p7t0BAVaedDyL9BBaty/3h+7B3JUWYYC0Uc2vYUfdGl6G8f3cGcRF1Nl1HS4hGQaVnyaY+mP+4T99lelnGJRl4bCCp2M1URAZaUlUUo6N9lbzz5+qIAtR9JprX7YixiT/I13AfBZhKabMQx9PoAMVc0Go9D+YFn/G48TcsHd5rLH+UiAqYbl+8aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HsZWgVGxEw1SijQBMicQOvHLlV1xVTWpvaiizw4Ea20=;
 b=kQH6LIQAnUoZfM8lL5GTlv6GgnEvnBvadsYdbh5oMeD5M050wa2U1VljxaWVnM9OzBwLGriEz2X1v6R0wK9qZ1PmUuyJkPfbZyrEWItqlF1ZQV8pLzBCz5Gnpzu+aEX/ptFnNL5GqvI8onuRcMjp3HhgKhG8sSrqZcoOi/c5Syg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by DBAPR08MB5590.eurprd08.prod.outlook.com (2603:10a6:10:1aa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Mon, 23 Oct
 2023 09:50:13 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::26e:c3c9:b87f:6372]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::26e:c3c9:b87f:6372%4]) with mapi id 15.20.6907.025; Mon, 23 Oct 2023
 09:50:13 +0000
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
Date:   Mon, 23 Oct 2023 11:50:02 +0200
Subject: [PATCH] iio: tmag5273: fix temperature offset
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231023-topic-tmag5273x1_temp_offset-v1-1-983dca43292c@wolfvision.net>
X-B4-Tracking: v=1; b=H4sIAMlBNmUC/x2NywrCMBBFf6XM2oBJ1aC/IqVM4qSdRR5kghRK/
 93UxV0cLpyzg1BlEngNO1T6snBOHfRlAL9iWkjxpzOYqxl1n2q5sFct4nI3dtz03CiWOYcg1JS
 21t688/R8aOgKh0LKVUx+PSUxojSq51MqBd7+4fd0HD9KtmNriAAAAA==
To:     Gerald Loacker <gerald.loacker@wolfvision.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Javier Carrasco <javier.carrasco@wolfvision.net>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698054613; l=1645;
 i=javier.carrasco@wolfvision.net; s=20230509; h=from:subject:message-id;
 bh=NnHBG4GI1UfRI61xmOhQRV8cRNuKEWfcPQKhuf0xA3M=;
 b=53zaDEDu6QDz2VHmjHb2kabd3uO5MkIXxxNkJIAsRraP503o8TGHSggxH+hbM31/0YzPwAXPE
 PNUibpSl1jFDe0SDukNMHSo6lQ+kLTL/jMTcUpqCuJZFVLwj5M5KiyP
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-ClientProxiedBy: VI1PR09CA0121.eurprd09.prod.outlook.com
 (2603:10a6:803:78::44) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|DBAPR08MB5590:EE_
X-MS-Office365-Filtering-Correlation-Id: f261093b-4d8f-4615-a93d-08dbd3ad7418
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: asWG+IT0ptxHlVDm3iTBEVdBrzvCbFR4rDNaT47aie9R5Jt9HxZvYu68SeT1zND/FXKRzqCLKob0EbYzGQHkWdG8EgGcuwwGvruGVYXkIyhmMelF3aDuF83F2A27qLVkO2iWR+R8YALNGeWM+Kv6Jr7xJKh0hW4CWAUD88pFY3Fo86FuGGjWaC4xsIubykW7v3wbDmH5y1gg+HQ0/xl5tlspzeyb1HIyk+bpVSxfYOzVzpKp18eVaS5l70jiOE9M6XE9H7Eofg72rrQZ2rnWtCC/Vl5luaUorgRyG7LtgfWgb0CdHPVqWAAJVJVC/Yqv2yORzN1nP4DYaEJo3sKVCG5rxTNefhzR3amEGHrEuhNNM8pSeVOl8jTNqKWy4a5ucpb9nlkOqYctLwyP9WuAMU5SyurIEOF7GDHsIUd9UcyXEvzGFe9DVDzid9JbCN3+RoA4/H3iNLoYpsCZZS8fTAXO56cOr7rsLOsCqn3akJmk5N/CYDeO9+IHjuzuHySo5lH9bfNlzTBCsjMtBqcj2+7sIB9KPfwvDNX171i2BQV5BijaD45F6UnfU2/jSJd5KddyXON4JxmFBujPB17A8ECjP9iDllDh+rWRSk3jXVDkd5/0SMVHG/7lV9T+nY7E
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(39830400003)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(6666004)(110136005)(86362001)(66476007)(66946007)(66556008)(41300700001)(5660300002)(6506007)(316002)(6512007)(478600001)(6486002)(44832011)(8936002)(4326008)(36756003)(8676002)(2906002)(38100700002)(26005)(2616005)(107886003)(52116002)(83380400001)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGJ0OGtsYkZOWGs0bC93aDd0WmRvNVJ2cm0rVlY4cDlmYWRLeFpzcEs0eU16?=
 =?utf-8?B?dUd3YVdlMElxTmsxeDcrQVJtTSsxOHZ5MzdIVDBpNWRLOGhOaUJlc1NhRVJP?=
 =?utf-8?B?Q1A4Z1lPd0pUQTJ0M3I0QWRHekZ3VG9jMDdyRDBTWU02N0w4NUllUThqMDcz?=
 =?utf-8?B?WlQvYjNYdXl1cHZGb25vSDFhZWhyaGhKcU0yV01IYk5tUUorQmlGeEFVWXpz?=
 =?utf-8?B?b0tPRm9pMjdIQmh1SlQyc2l0dDM0SytmSFJFMGVPalVOdEx1QThDOGFtV3Bp?=
 =?utf-8?B?M1FsdjBUY3BueC9CQnA5L2xuazFBaFg2R0tsbzRTWUw1OEZEZFhHTHNpd1JX?=
 =?utf-8?B?aDJGOWlONDdDS0xWeFF0MDE0MDBKRlRIRVVIdjNUS2R4N3NOUHZkVkRnaXYw?=
 =?utf-8?B?Qkd5NmtMT0VyQTU5bVFlMTRsYmU5ZjVvYlJvU284VjcwWHA3STliVC9RZVlL?=
 =?utf-8?B?OVRFVHY4Z205WHYydk9TOU8wRWZ0ZGJKYVpkT3krVHo5dTl3bEFzeVF1U3Uy?=
 =?utf-8?B?cDlmQkFrN29SQ0hqeG5uVEdEVjMrT1dlcWhRSUF0ZTI0aWJieE5vdGxRWVMz?=
 =?utf-8?B?NmZ3NURabWFOU1hWVVQ5TFh4QU4rdEIvL3J0aUNMU1FsOUNsRXRpZms3c3Ft?=
 =?utf-8?B?UnNvT2NmdDlJcGI2MVl1ZC8zUlU1VlowdmV2NTVLVjc2Q3ZaRitoVzdHeG42?=
 =?utf-8?B?TjN5elJGMVlyYXV0WlJDWHVBdm1HdTM2b2pYa1JvRnhKb0o5elR2QkVuTVdr?=
 =?utf-8?B?RDlEZ2VlN3Q3UGJqMWY0clpOODNUaXhXSWpEMXdHdlUvaE1YSFoxOTlUUmZv?=
 =?utf-8?B?bEJEWS95Q1FJM0tMZENybldBUlZWSStJTndON21zbTRYbmdZOXMxTCs5V1E1?=
 =?utf-8?B?WnZNcGpjOXpNUlJlV29pWkh3L250Y0liTk5mZ1BzaWx2RFJidEp3eHZvaDNU?=
 =?utf-8?B?SzlqVGxIWmZaVkJUdkxkWmZibTZjUFlMdW96VFI3dkd6bDdRL29VVTdiY0p6?=
 =?utf-8?B?OVZoN0V0ak1LSUhVeU1rQVcwS3greGliR25EVjBQcEVidG0zQ0R1clRQSC9C?=
 =?utf-8?B?SXBmcGgzVEJ6SjZ0OVVxalFVbXduRVdteTJHSE9PUHB1RGNEeGJJbmZ1WTlM?=
 =?utf-8?B?RFJwMUtIQ2V2ZGhvVUJxeWg5UHJiN0FnaDRzcFRxYWNsNDllZllPczU4NXF2?=
 =?utf-8?B?bkF4SndHV0VMSWJJL2FDTy8yZTNsWUVqY01jdEpjMmJvL2VJSmhIdnlyMHM3?=
 =?utf-8?B?UUtreXlXVUJIOU45MkFmWlNnb0xtZk9FSEY1aWk1VUtNd0xpWjJKWWdqTmlk?=
 =?utf-8?B?REdMNnBjM0NvdU9GTkEvdm1sb01YSVBWdTM1WWtPWSsxTUdjSlhvWEpFQmhO?=
 =?utf-8?B?NVFJMk1WY2Y3Y0diRFNRWGJudVVNSERNY0cySTFjZTVmUmFyb1F6elM5bXI5?=
 =?utf-8?B?QkgrU09DRFdQUVJsang2TXNFR3RVc2EySHNxeE5XWEJWWklycVVBYmdiMmFN?=
 =?utf-8?B?eHQyb3A2LzNtRWdkeXJqOVNrMUk1cjdBNmVjVjVJUzdDdzFyMkVEU1NYemd3?=
 =?utf-8?B?U0lGend3dy9DTmc0UHZ1R1p4aTdPZVNhays1bjZGYm1WRUtWNHFNeUFvcnVW?=
 =?utf-8?B?MnVTWDhVbHdhSkdmbjVlK1ZNbERJa0VmRWNqNnl1eXlZSXE4WGlqWU9BOFlT?=
 =?utf-8?B?Ykg5NlpUVUdaNmYxbWdCMm9HaXR3Ly9NTzQ5UllWUWpDR2t5VjlJaXl4NW9E?=
 =?utf-8?B?VTN3TW14bmFvQ0o1SGZrKy90VHE3UDZ5bGFXUlNFb1FjK0YzNUw1Z0hHVnVM?=
 =?utf-8?B?UzRwK1dMZ1pyVFlVZ2x3NkhKajl2ODNuV0xnTzFYaWFLSDVDNGlHSGlsMXU1?=
 =?utf-8?B?SlREZEd2OVZMclVCdHFDZkxoN3lURnppNXpLUWRSbHNnOWVhdUJua0pGZjNG?=
 =?utf-8?B?Nzkvc3gwZzZTRFpJNzNuS1orWVduRjJvSHJITTNadDJBNUpsMkN5RmdpMTJC?=
 =?utf-8?B?dSs2Q2J0V1JzQ2szekVpL2hCUmpNWFNWSDIwRlhZTm16eHNrbEJ3cjZHa25v?=
 =?utf-8?B?VFQ1amIxbWlqY2dvTlcxYlZDMzl3NGZpNzZBL3YzTE90NFlKb0RYVTFKbGhQ?=
 =?utf-8?B?T3JHVlhCNURtZ0RyendHUkZnR1FHdzlyblRaTEp0VjZBSlNDY2VyQ2NtRjM0?=
 =?utf-8?Q?yWinNjZsHYAStvxI7UK28ZQ=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: f261093b-4d8f-4615-a93d-08dbd3ad7418
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 09:50:13.4925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CyH8+krpdFX5W7PXWYLJeOE4RFOn3yHX7qweA63GmnpKBCaBj8vx6wfgL6As5Gh+li2ToxgL1rQruMiYHtm7/vrS5zc4XSdjXbnhByWJYKI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5590
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
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

The resulting offset is 16605.5, which has been truncated to 16005 to
provide an integer value with a precision loss smaller than the 1-LSB
measurement precision.

Fix the offset to apply its value prior to scaling.

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
 drivers/iio/magnetometer/tmag5273.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/magnetometer/tmag5273.c b/drivers/iio/magnetometer/tmag5273.c
index c5e5c4ad681e..d22ca39007b6 100644
--- a/drivers/iio/magnetometer/tmag5273.c
+++ b/drivers/iio/magnetometer/tmag5273.c
@@ -356,7 +356,7 @@ static int tmag5273_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_OFFSET:
 		switch (chan->type) {
 		case IIO_TEMP:
-			*val = -266314;
+			*val = -16605;
 			return IIO_VAL_INT;
 		default:
 			return -EINVAL;

---
base-commit: 05d3ef8bba77c1b5f98d941d8b2d4aeab8118ef1
change-id: 20231023-topic-tmag5273x1_temp_offset-17774cbce961

Best regards,
-- 
Javier Carrasco <javier.carrasco@wolfvision.net>

