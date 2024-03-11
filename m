Return-Path: <linux-kernel+bounces-98458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A65877A6B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 05:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CF341C20F49
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 04:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13908C15;
	Mon, 11 Mar 2024 04:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="PiVzDdtK"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2091.outbound.protection.outlook.com [40.92.41.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B962D7464
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 04:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.41.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710131983; cv=fail; b=QDl5eXZXUJCA4ylKV975HIJPxPJrjgIDksuUfH9S2mfMg4sJZEB8x9IMZCgZE19DHo2lv+WZiUSVXn5KDQc+sNyoHGtZ4vEvbHJACCKc46jYvWhtizCqkv4VS0DgwvufTi84lQp6oxgSD+RHYuMydKamApfaYcxT4y2Ol+510Gc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710131983; c=relaxed/simple;
	bh=8ZcZj8sfO0qkVSF94NnrdjiZs4YL1tEvJDXRxCt9Ywo=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=aDRYXDUWXlGITutC7NtKuE59rPO3ASTXXTqu4s5lbyxst23vsfPn2M7vneolwFyJFnRY446R9qN1DUETh8AtHnTBnguGnOUm9U9+f3bdAG+uf5cm7SXIH1rDLwKAszvgGiKtla++YYxnIzEioWFfJGoizXXW4tIF70V+a8DneBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=PiVzDdtK; arc=fail smtp.client-ip=40.92.41.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WNydLXGBVPenhbkze3CuP78jV4hXseFmv4n1gpBHu9XkxJydrdktLAx/uq/wASaXBezUfty55eES7Zw2YMDGH1s3DggfdT1Beqe94XQGSQTEZp7c2ztvFEQRGxTmWfq7Hnc3K0WXdO1RMLcSSfzaU/5x/DjF3gliZCluissOzmmqJbNIni2bYc83e1kF9e9sQlOstRcLiIrNelYgRobkOHOhvRkLtXva9pmpWuZ5EOFO2k0OEVN9tgcgU1qvQ/LsWOdHsueDfMiLbOU12boQR2nvrqH5UZSOvCEyhowbKxK83EPZ/REwq+eFY89V58A6baF4z28Kf9SAC6Uv7jEgmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9IpH0tfMXiL5Y8fxdX5X45FrKirbNVeDoJVzU7VET3c=;
 b=iZ8R17zu46ElK7coC1IiSdO+VeiNH5rM+MWDkLOsKcqmNOTmus/Opj8Q6+B6Xv10UYkibAesE1EAPgPCVaJhNEqqGC7V8gvYbFtgbwLV5UAsFI1jmiQ+oQ4XdnFIE7aY/bx6jlBIpIccKQTvjl50UADRVPQBURJ3a3zQCWkkBduT6xrx1NnLK7ha/3H2+83egu5BZJX2+fJDHOmHI0zj6JX0je7g+tfHodZQmqbixq5ABFlX8fn5pyI/CPYaWJOBUXIrcuPKhOt8hYhyZ1TBgSjQWEG2A/YzghXKSYjyvrzbH1scORrD8e3OyqRj0jYpmxxOZbTHBHuFFQQNw8mEfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9IpH0tfMXiL5Y8fxdX5X45FrKirbNVeDoJVzU7VET3c=;
 b=PiVzDdtKAQdtr0bFzRFrplWpcpXEEUApec7VrYtLrAlRabNwwVzVLjs2h3rUFMPxtUMANfuRo6IYtU5kcEVMSURJb5i2YudAQYdZHA21tb92xHvRanvtUnQhmPhtqegMxn0jL9DFjT9gVkhaBzVjdcNWpeKpFvQz5yaB7y8Kz4aPoSIcQmX1dzFW10O0OHD1P8BoZN6CqWjPZY7l5ulVRbyDGvMips5sNWRlmGwNGZAJkxOBdTBC73jvKyYOhSHz5YKmHvwbXOG/QO0bVrGhqX8gz4xIBUVZc+wwTy9pwkZlCrF6XaOWU0U4k22EEdgfVkiZA/RleA9w5D0InGL4YQ==
Received: from CY5PR10MB5988.namprd10.prod.outlook.com (2603:10b6:930:28::9)
 by CH0PR10MB4953.namprd10.prod.outlook.com (2603:10b6:610:de::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 04:39:38 +0000
Received: from CY5PR10MB5988.namprd10.prod.outlook.com
 ([fe80::11ce:fd0c:d54d:a27e]) by CY5PR10MB5988.namprd10.prod.outlook.com
 ([fe80::11ce:fd0c:d54d:a27e%7]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 04:39:38 +0000
Message-ID:
 <CY5PR10MB598826EB007900A8BE01F4738C242@CY5PR10MB5988.namprd10.prod.outlook.com>
Subject: [PATCH] Print also the BSP number when announcing cpu
From: Dashi Cao <dscao999@hotmail.com>
To: linux-kernel@vger.kernel.org
Date: Mon, 11 Mar 2024 12:39:07 +0800
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1+deb11u2 
Content-Transfer-Encoding: 7bit
X-TMN: [boPwrUItzrdGqREUcX619zNVhft6V4My]
X-ClientProxiedBy: TYCPR01CA0206.jpnprd01.prod.outlook.com
 (2603:1096:405:7a::17) To CY5PR10MB5988.namprd10.prod.outlook.com
 (2603:10b6:930:28::9)
X-Microsoft-Original-Message-ID:
 <82e10ff69d703a1aab2a5368c63104b75aaa0a75.camel@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR10MB5988:EE_|CH0PR10MB4953:EE_
X-MS-Office365-Filtering-Correlation-Id: 387f8405-6bb5-4dbb-c610-08dc4185426a
X-MS-Exchange-SLBlob-MailProps:
	znQPCv1HvwXP1pgB6quBLdqLhL8BcDmj1JWv8mqkKKt/S8Ruzm6Fd02YG50NXK3cz/c7Ad7ks8obp+BhfxJLWZmvqXHnSvK4ELkDm6hPSBlL1FV/FNpfu8Q8gXk1opJ2/zaYpiwK44cUbJ5Rl/qOQ8ihrjOh0EaNzs6rUoAXAq6NXFPJZCGipl51u2zFR/OpnpXDaAGmSAdbJ8g08jsGEQEW0caYJNEYKYYPPKxS1EVH9+Vi1wccRKVR7JWzM7oHPE+ZCVvgRr9ERCgyc0rpANmoQUiMW6FbhX2oR6BZCP134HwEqDnyJAF+sOF+5sfsOKuviQu1ao/4M60eL1wqhQX78URR2+XdREW4OiIN0PwvysdJc+3FvuMz1iYvQ9LZ3MThFTEeM1cX4LsTnP8PkukDykk5pa6YbzSGEHECuHiVvNSx93FPf61I0wjngekN24BoORWwhwdjVzdG2FGJM6kXqf7mTb/5h6yoXPN+OG8aqk4F9xucpaKGrbE/mwbVcbfhZGBpkCGiVgT7HdTjXJOtrW4rX3k3T8ETC6k4/pYMha+5EC9Gep2AQ7UbXyKMK+pH0AQytWCMyFJRuchxYcYNaeeboBwohuwlQ+hPcfGhwgAtL8/M3h8ZegiGBRHTSmUH39RECY6zMSUm5S3ctD5VGwcfXMsN1R6KYBDm2Xyul/8ifSbTEqNni5315LwMqQUUaHodEt0OHRhpVbYd5WAcEtIbzA0c8FYGGTWBzmGmCga50jCag3/DKkMQtUXCS6V3++p5Fj0=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pZ2L9n8IUvpWcAMMZ04CWXHNzC4FEgV+qb+mcC/rT/au9u5kQ596YbVJZvTFUWT7WXP1GyEYbTBqD9OzWrEB6LrFZ/ej00sNRdMDR7XnTJZW3Ue9aPmP8qwAvWH64PVnDKM5ejfuOi1EAXwkb2I+a466ysDUh/D0bsMlYzT/lTDS4/w9yTfjCOvJ8xi6rc6FMTTWjb0DL9EFUUyjkCHEP8Rtvie+9Y1hjxoHHqTZ4Tzs/U0MP4kSlrHf1yVjbdK72nO1grMvAv1+QBLxYXlbyisYKwOXYvRZC9kL1ERVsxVg+/Fp1hD6TPKizssqT1C6ra4bn4Tcwwhc3fvP4Glylw4OXiipzEtZ2I1Y0SkrxDUi1XA1e83+ugop+cYbNgTuy92FHs3Qbyz5bNBcYdG5x0aYq3i1G+C4tC86pmyLbNYGFDTPKmR1bwgJ4145GRUaEodP2e24UZ2JADw8BjI239SX9WZYy3+1Wn7xWCQNLJY9bGOqcBLQJK+OsPMltLhzLhnN4zAQiansR18i6sO8pUtjpT9PiwIe894xBhEzIaXeUNK3YIseP28v+0ca2MIZ
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N2FZelJQZU8wbGlndjR0eDIxRkxSa3hiaUl3M0pFVGUydE9WVFZvOFZXT3BP?=
 =?utf-8?B?MWpieVliTnlDSzFYVE1LNDVmcXZpbStXMWM5UEhKOTB3eFUwT1BIUm9CUnBE?=
 =?utf-8?B?dk5JTDNpZWtqUVprU0trdHhocDVtYmFKZzhSakppd1g0cjMxZ3JmZ1MzVlF3?=
 =?utf-8?B?NERDWWtwOGtqYmNrVUpnaFRJQ3g0YTMrU2lEVHlKZk1PWnZJVE1ZaHhYWk04?=
 =?utf-8?B?eCszRHZaRXJ0WTlwUzdNcmk5UStBTmNjVGRsMnhBYlcwMjhuUWlBeUZiOVJW?=
 =?utf-8?B?cTlTNldDZ0RNTGczdFUwUjdqa29RTUxXMERnVzBhbURRTGJhTExCamUvNHRz?=
 =?utf-8?B?M2JkdGRTOXNVeUN6Q3VCOXNMOVJvMGR5VXRwV3ZwVTFhK3ZNQTRFL280WmRr?=
 =?utf-8?B?U3FadCt3OWR0YUlLWUJBNGVtNVRNQWtlNVpTTTV4WmpOUXBId2tUdDA3QXZq?=
 =?utf-8?B?UEdCVEdwQ0lqaW85Mk5PNDMwU0ZBRjYrS3FOaDk2WkczampWelloZGxndzVL?=
 =?utf-8?B?VlJyTXdWSWI1YTgvRk1lUHhWYVUvRWhaUitjcXVCYkhreE5Fa2ZZTDdVL0Vz?=
 =?utf-8?B?UVFIakxkWStjd3g3QWcyYnBMK1VNK0RnR3ErYkh2K01NMmpTbVZLL2p2aUFE?=
 =?utf-8?B?d0JqNlJoTmplSTNtb2cwRTVEdGVwVjhpMFJsREI0d0lnRzFWZURqNTBuQWNO?=
 =?utf-8?B?bE9STTBKTmxTVVRFMHU4K0o0YlczTk1iSHNaNW9BSUxPZ01XR1BGMEwremFE?=
 =?utf-8?B?SFFObnFPSmJrdmZmck53S1lBdzJWMEV3WWlKZHl5REl2WU9sMG1BaHpHN202?=
 =?utf-8?B?djZKYXBORmFDNzQwMm15TEFJMm11YzdPZ01BTjZZa2k4L2NvYTI0K3VnVUdi?=
 =?utf-8?B?YUowRTlsY0p6ME1ncjgvZkRCcU5vV3h6dDFmRmdjTG5iVXZLRE5ZVHNLeDVs?=
 =?utf-8?B?UDc1TG5nSTJqREdaWVpUc3hJbUZ3NzI4ZVhRMU0rVmhsMFZldlV3eEhJbXNw?=
 =?utf-8?B?czZCT2x2b0hLRG9jc1QyWjdKd2srYmJ0aW1nNzBaUkRSaFpkR2N1ejRwbWtq?=
 =?utf-8?B?ME14RlVBVVcxWWloT0laWE9LV3cvbk94SnUzVlVYMHBUYkFBRUV0S0cvL0Ex?=
 =?utf-8?B?ZldUb0duOEwrdVFraUdqVFRiWHJ4MGI1MVdMb3FqbGMxWmlNV2Y4eERyVFNH?=
 =?utf-8?B?bjVnYklnMEM3Y3B0UDN5d1hQZXhmRFQ0d0hQZVlJR3Y5WFBDR2VSWlU2blpQ?=
 =?utf-8?B?d0JrL1FNZjdEWjkzWUN6WXR1ZlpwQjNkVmVmRytReFdOOUJscFRaYk5TWG1K?=
 =?utf-8?B?MC9UN1NIeis1eFhid2hIQ0lLaXJiQ2hjRzN4eElFSjB4Z3hQSzFSajBmZnkw?=
 =?utf-8?B?bXUxMFlRNlFpTE9FVDI1c0RZYjlYOGIvdGsvRGRnYTlXbGNIWElFSSt2b2Jo?=
 =?utf-8?B?UEQwZ0RvRDBFM0xkcDNOMVpiWmpha21FVEJkUWwwWER6QnhkZ1h4NTlUYTkv?=
 =?utf-8?B?MU9lY1hVdmVjbVNIakVvbXVWVWFkSlJRdDZnQmhkNWRSVzdiNXBCOHUrdmVP?=
 =?utf-8?B?Wis3bVNqc2dGRXZZZG1TYWtEYWZhU0loQ3VkZ1BaR1J5bFRubW9MdUtKVmI0?=
 =?utf-8?Q?v4cqwcvyR4aqtKywDZXh5leJ/mru7Ia3brlwsmAF2fss=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-926a2.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 387f8405-6bb5-4dbb-c610-08dc4185426a
X-MS-Exchange-CrossTenant-AuthSource: CY5PR10MB5988.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 04:39:38.1991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4953

When announcing CPU, the BSP is always printed as blanks.
This patch will print out the BSP number. It has the assumption
that the BSP is not the last CPU in a CPU node.

Dashi Cao

Signed-off-by: Dashi Cao <dscao999@hotmail.com>
---
 arch/x86/kernel/smpboot.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 3f57ce68a3f1..073472742be4 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -931,9 +931,9 @@ static int wakeup_secondary_cpu_via_init(u32
phys_apicid, unsigned long start_ei
 /* reduce the number of lines printed when booting a large cpu count
system */
 static void announce_cpu(int cpu, int apicid)
 {
-       static int width, node_width, first = 1;
+       static int width, node_width, bspn = -1;
        static int current_node = NUMA_NO_NODE;
-       int node = early_cpu_to_node(cpu);
+       int bsp, node = early_cpu_to_node(cpu);

        if (!width)
                width = num_digits(num_possible_cpus()) + 1; /* + '#'
sign */
@@ -942,7 +942,7 @@ static void announce_cpu(int cpu, int apicid)
                node_width = num_digits(num_possible_nodes()) + 1; /* +
'#' */

        if (system_state < SYSTEM_RUNNING) {
-               if (first)
+               if (bspn == -1)
                        pr_info("x86: Booting SMP configuration:\n");

                if (node != current_node) {
@@ -954,10 +954,12 @@ static void announce_cpu(int cpu, int apicid)
                               node_width - num_digits(node), " ",
node);
                }

-               /* Add padding for the BSP */
-               if (first)
-                       pr_cont("%*s", width + 1, " ");
-               first = 0;
+               if (bspn == -1) {
+                       bsp = raw_smp_processor_id();
+                       bspn = cpumask_next(bsp, cpu_present_mask);
+               }
+               if (cpu == bspn)
+                       pr_cont("%*s#%d", width - num_digits(bsp), " ",
bsp);

                pr_cont("%*s#%d", width - num_digits(cpu), " ", cpu);
        } else
-- 
2.30.2



