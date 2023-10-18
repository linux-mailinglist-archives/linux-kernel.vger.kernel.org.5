Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D86B57CE54E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbjJRRuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 13:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbjJRRtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:49:53 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2057.outbound.protection.outlook.com [40.107.6.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD81116;
        Wed, 18 Oct 2023 10:49:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZI11Qp0ddyi3ArfPj6/gxZ0GYiY4qu8wh2njXgL3FnAb54hRe5JyS+Bvfgvq+RTvJ48Qn8YmYnQQa9EBTFq6Ftc0BokRhR5zVAzh1+/eR0F3xe+dlj9RMfje0SNGxWe/BOPUiJ56KDzvE2MC2Ux6FYFrcxC97CpLfsgwFCsmx3gVOyWUnarySyVyq7c+NO9ENCtdIVhF+M9ulXfogkATdWnOyPmmVSHpwc0QsLtKcV1rR6aBasdFX5S+K5FVCvDHubadJBwZfd7t/8FsKF5j1dYD/HMTzYpGANkWXUx6QDPMq/f6zHoXkMquvqzQp4iqpu7OYpv5jHo+J8SOz0vuMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KixZxt5y8At1EBQmQPkFhCe8T2ISnHTFVXiaP8tzWo0=;
 b=n/ybaCQ7K3jKLhxWsm+wVxTmnEf+53MJvI6nMtyUH6xIpvlw8KKdluv7+FS5Kn139bU4m556llJdYKaQQkUw07I6tEY3xCcvgi1g6M5un4bVKLIUCzyFsbHtomAu0Z9fYx4mXglIWpNtslrsu+lL9/6zEeK2pOsCJTgdKbHIMVwi4gBPKXzAlxqS9AT49o+Ce58loAJHgxRwZTAguy5bdBaEScSusSi26pwfHTI75Q0U8uqkSFX/OC6gJuiYsHsGIHxC82ku71kliUbNywj9TyQR2wGt7HgGX6y8FnqzupkpBtDGedbWDnlVSknSjV1uQCl0hSf6m4cQhue1synCgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KixZxt5y8At1EBQmQPkFhCe8T2ISnHTFVXiaP8tzWo0=;
 b=a+Q1ikQM8PAbOPC7VKtnALztbYQp1OaETVlctgOY5tVMV0N1CwwUMFgojGCdyoWO1f837C4eLX0izQHnwmgWJkw+QrAEqKJG9ofN7+b45eb5QkzAZx12tlmKXBXR5E9dlYN+r/2i/sWGqbtfWcEr+ofuAw6kfO6GTI3mmp7ck4o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by AS8P193MB1478.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:350::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Wed, 18 Oct
 2023 17:49:41 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::550d:2425:c0ed:3e59]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::550d:2425:c0ed:3e59%3]) with mapi id 15.20.6886.034; Wed, 18 Oct 2023
 17:49:41 +0000
From:   Lino Sanfilippo <l.sanfilippo@kunbus.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com
Cc:     u.kleine-koenig@pengutronix.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, cniedermaier@dh-electronics.com,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        LinoSanfilippo@gmx.de, lukas@wunner.de, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        stable@vger.kernel.org
Subject: [PATCH v4 7/7] serial: 8250_exar: Set missing rs485_supported flag
Date:   Wed, 18 Oct 2023 19:48:40 +0200
Message-Id: <20231018174840.28977-8-l.sanfilippo@kunbus.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231018174840.28977-1-l.sanfilippo@kunbus.com>
References: <20231018174840.28977-1-l.sanfilippo@kunbus.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0130.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::17) To VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:803:4e::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0413:EE_|AS8P193MB1478:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b44f502-6f15-4798-29cc-08dbd0029ae6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rZkcZ87g+MV0N8+Z6DVmA2u3soE55ZeWshYC58BRH/JYaeI63ilaIVPWaUOCc0A5oGRZjx+gA5Fnq6QiFd/iP4M3NvUS54sRcrIGMbdEsmLaa5PdZk0OcFz+8LIuqSfBnqHUS05PRYHd2aosHK9cXa218AT98aSsmeaaspdF03Qi9sMfl2yfD2cEhOBRre3NDDAZ6bMSsemaKY8pQKuf6ZNI3hFTd/iikHr/S/eu4a3+bx3+A6jpEVNCIPc0Ydm4FDO/OaliBBMjmRNj2WGIFC2NgqKwobDYglpJJuPa6mbfQ2RnAcYV3NdP4P5G8SsU1BkYdY0nMGZ/PYuh7989WxvY5bSKNWA4MoOShYCc5ZhjK+29edwtYxHsDQ1hmHvhTEdwd6COJX8MGG1hVh5EvTcWs9aC1NctBd5IOD/SfjJipv9n0jQPgqY5Em1KlMjhEuuyNUAR/hjLLwbHdLYq+z9xdqJVU7VjygAswBI9vI3oHrt9p10YjBfZ+GcR3d5nJ97EBAd3j6BQjRJqpjv0ryxlN+LgYMA2mjg7FmmQbqFdCH5N2HxY0VZ0BMsp4O/P
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(39840400004)(376002)(346002)(366004)(136003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(36756003)(66946007)(66556008)(66476007)(86362001)(38100700002)(1076003)(2616005)(83380400001)(6512007)(52116002)(6506007)(7416002)(6486002)(316002)(478600001)(5660300002)(4326008)(8676002)(41300700001)(2906002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+Vg6WFXscyqjfbqBBEjQg0Onb0PsOjkTqLQJ7dcX3x9QXM8aIxV2cy7zEhwy?=
 =?us-ascii?Q?6lvc5CK/bhcr57HWyl3/oehwns+aQuyHiwFpSsS6kfekM93LgomeRCDq90aM?=
 =?us-ascii?Q?pm5wSrxtLGwCniFP8dPG/lPkUk82fN01qyfd7HSEEQUw8gESlITnr98WGAu/?=
 =?us-ascii?Q?S10o/+0Douqo8WEkYPohcv4pZ5h4Lp4wUwohotGvUeVtBdyDmXJVgMLomzIU?=
 =?us-ascii?Q?wlbXsXyNpio8ip2m7IlN2RybGLBdmtGmidZWlyBICBnXql+8w1vOICcYU81D?=
 =?us-ascii?Q?NV8kCOySIA/78wPMHox/bkQBjU7ipAH9O5gjl5FN9ZCVPEZc9fsDho0YI9KM?=
 =?us-ascii?Q?Qnn6HZNAjEVdYJkNthOJDFjl1e3FmGbgL6V8GrR0Eoaogiy+TbS/b46xSuDI?=
 =?us-ascii?Q?b/t35EFfkFNmB7muId7IDyh6gf9kOSz+0ikmPaxT3uMOglKl6MkZ2B2CBLp/?=
 =?us-ascii?Q?r1gxb38Nri2mI1Rb3R/4GqTRR1cZ6PDMJKD5t9Nci4iQfIJq/B+mE+fD4JKG?=
 =?us-ascii?Q?z7Ci7NGok8eZ2ovCy8SHz7+n6n50h0MC96+9takI4A5vuEC4dblwMONaxtBV?=
 =?us-ascii?Q?t6hvxw5oeGyPfQb/o4dU5BDLlMSi0VvaiOTqB4+DgxaplriLv3+zHdhfNayB?=
 =?us-ascii?Q?2f0ZkPbpVKuqKg6hB5jyk9II4/sW0iSURpmsmVW/V/2upCo30CYNUhVCmFtH?=
 =?us-ascii?Q?hQi36D2HKZ4EhA4Ag0HT0WZGXJvjyIh8hqOH2GGAiPuxhcUt8FanxWsVCVhe?=
 =?us-ascii?Q?LFqSY2wW85JFyktaDj8asH4R6X7oDfBwMnWdFcE8bX+/p7R3qMfhl0fSrZOZ?=
 =?us-ascii?Q?pF3jD3SK2r8n4uVDIgk0VunWzbbkhooQebrLX5BUCsSwAPXA3gDSy8bWThS7?=
 =?us-ascii?Q?YtYttzNh5MLlPiqbLIaGMgwHK+xgpzTL6tHQ45Z6+BEJ3/JrDxQDZY8NEl15?=
 =?us-ascii?Q?fCMKUcZVVK7on4MK5g51opDl1Xx/cEDK/tlcQ3rn3tUpXT2INkDLYzEXBYYV?=
 =?us-ascii?Q?8dVrr/XacZzn2zWccIZ6V5OqOavGDcgdA7ysEpSq3CNULWi/avFYR78Zz2XW?=
 =?us-ascii?Q?uQPvawm5WBphIoRc05bk8oQHEY8UvUKCd1JKA681XGT0+mWNrTmZAQDgfbJl?=
 =?us-ascii?Q?o7NCORZirJeo3ThpgC1HTxpljtm3Y4I05RoXzmYaKbLotTO4Rebx4wIOTsD7?=
 =?us-ascii?Q?8sVWWEqTAryX+MX4K4Yhhk7bEVpPRGx1vdREX8wu2MEa5E+lDLaVzl5qSvra?=
 =?us-ascii?Q?4A2Stk3NJSwFcyvI/VhdTiiTZi+WlfCnnvNdLiWe8dNOZKwegre8avSEGQ0Q?=
 =?us-ascii?Q?plTPHJW4xv4hnAfuJhHP8NYn1WUqCi4sfK/mMAX0ECuBYA87RRKT0WyyUKbS?=
 =?us-ascii?Q?CBHB/1dRTWJVld5KtPYkMX7cEshDudz5ojz7P5WuDm13o9YFhz8jbBcx0eq7?=
 =?us-ascii?Q?UkukGOl4d/LsJEz4PCJjFAer8EE4TBaaFHauClVBrNNfhVMrzvz37HCIoUgu?=
 =?us-ascii?Q?NuJB8hpIal/ZGlJo6bU4P4gFERj77pe9QtkWOuMiDFJ0gd3amqjAQFvuzzMW?=
 =?us-ascii?Q?gb13O5MlUlK5O785fJDx/j9dGtdsHrym8kiCfMsx+w8CjhRY1egbS/VKpg/p?=
 =?us-ascii?Q?QLAjL2VBt3I0dr/W7mE+ODlzjOtkfC6xYkKYz8ZGZXRh?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b44f502-6f15-4798-29cc-08dbd0029ae6
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 17:49:41.1409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GZuGhQcJ/UAZhnIJhtsXmXjPPFLaAHyc+BG0wmsA7KS3mCRpFcLTiVfjVr9+trzU9GWHDgJfHCRXfMJfew+u/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P193MB1478
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MIME_BASE64_TEXT,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIFVBUlQgc3VwcG9ydHMgYW4gYXV0by1SVFMgbW9kZSBpbiB3aGljaCB0aGUgUlRTIHBpbiBp
cyBhdXRvbWF0aWNhbGx5CmFjdGl2YXRlZCBkdXJpbmcgdHJhbnNtaXNzaW9uLiBTbyBtYXJrIHRo
aXMgbW9kZSBhcyBiZWluZyBzdXBwb3J0ZWQgZXZlbgppZiBSVFMgaXMgbm90IGNvbnRyb2xsZWQg
YnkgdGhlIGRyaXZlciBidXQgdGhlIFVBUlQuCgpBbHNvIHRoZSBzZXJpYWwgY29yZSBleHBlY3Rz
IG5vdyBhdCBsZWFzdCBvbmUgb2YgYm90aCBtb2RlcyBydHMtb24tc2VuZCBvcgpydHMtYWZ0ZXIt
c2VuZCB0byBiZSBzdXBwb3J0ZWQuIFRoaXMgaXMgc2luY2UgZHVyaW5nIHNhbml0aXphdGlvbgp1
bnN1cHBvcnRlZCBmbGFncyBhcmUgZGVsZXRlZCBmcm9tIGEgUlM0ODUgY29uZmlndXJhdGlvbiBz
ZXQgYnkgdXNlcnNwYWNlLgpIb3dldmVyIGlmIHRoZSBjb25maWd1cmF0aW9uIGVuZHMgdXAgd2l0
aCBib3RoIGZsYWdzIHVuc2V0LCB0aGUgY29yZSBwcmludHMKYSB3YXJuaW5nIHNpbmNlIGl0IGNv
bnNpZGVycyBzdWNoIGEgY29uZmlndXJhdGlvbiBpbnZhbGlkIChzZWUKdWFydF9zYW5pdGl6ZV9z
ZXJpYWxfcnM0ODUoKSkuCgpDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZwpTaWduZWQtb2ZmLWJ5
OiBMaW5vIFNhbmZpbGlwcG8gPGwuc2FuZmlsaXBwb0BrdW5idXMuY29tPgotLS0KIGRyaXZlcnMv
dHR5L3NlcmlhbC84MjUwLzgyNTBfZXhhci5jIHwgNSArKystLQogMSBmaWxlIGNoYW5nZWQsIDMg
aW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKClRoaXMgcGF0Y2ggaXMgb25seSByZXF1aXJl
ZCBpZiAic2VyaWFsOiBjb3JlOiBmaXggc2FuaXRpemluZyBjaGVjayBmb3IgUlRTCnNldHRpbmdz
IiBpcyBhcHBsaWVkLCB3aGljaCBpcyBhbHNvIHBhcnQgb2YgdGhpcyBzZXJpZXMuIApUaGVyZWZv
cmUgaXQgbGFja3MgYSAiRml4ZXM6IiB0YWcuCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy90dHkvc2Vy
aWFsLzgyNTAvODI1MF9leGFyLmMgYi9kcml2ZXJzL3R0eS9zZXJpYWwvODI1MC84MjUwX2V4YXIu
YwppbmRleCAwNzdjM2JhMzUzOWUuLjgzODViZTg0Njg0MCAxMDA2NDQKLS0tIGEvZHJpdmVycy90
dHkvc2VyaWFsLzgyNTAvODI1MF9leGFyLmMKKysrIGIvZHJpdmVycy90dHkvc2VyaWFsLzgyNTAv
ODI1MF9leGFyLmMKQEAgLTQ0Niw3ICs0NDYsNyBAQCBzdGF0aWMgaW50IGdlbmVyaWNfcnM0ODVf
Y29uZmlnKHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQsIHN0cnVjdCBrdGVybWlvcyAqdGVybWlvcwog
fQogCiBzdGF0aWMgY29uc3Qgc3RydWN0IHNlcmlhbF9yczQ4NSBnZW5lcmljX3JzNDg1X3N1cHBv
cnRlZCA9IHsKLQkuZmxhZ3MgPSBTRVJfUlM0ODVfRU5BQkxFRCwKKwkuZmxhZ3MgPSBTRVJfUlM0
ODVfRU5BQkxFRCB8IFNFUl9SUzQ4NV9SVFNfT05fU0VORCwKIH07CiAKIHN0YXRpYyBjb25zdCBz
dHJ1Y3QgZXhhcjgyNTBfcGxhdGZvcm0gZXhhcjgyNTBfZGVmYXVsdF9wbGF0Zm9ybSA9IHsKQEAg
LTQ5MCw3ICs0OTAsOCBAQCBzdGF0aWMgaW50IGlvdDIwNDBfcnM0ODVfY29uZmlnKHN0cnVjdCB1
YXJ0X3BvcnQgKnBvcnQsIHN0cnVjdCBrdGVybWlvcyAqdGVybWlvcwogfQogCiBzdGF0aWMgY29u
c3Qgc3RydWN0IHNlcmlhbF9yczQ4NSBpb3QyMDQwX3JzNDg1X3N1cHBvcnRlZCA9IHsKLQkuZmxh
Z3MgPSBTRVJfUlM0ODVfRU5BQkxFRCB8IFNFUl9SUzQ4NV9SWF9EVVJJTkdfVFggfCBTRVJfUlM0
ODVfVEVSTUlOQVRFX0JVUywKKwkuZmxhZ3MgPSBTRVJfUlM0ODVfRU5BQkxFRCB8IFNFUl9SUzQ4
NV9SVFNfT05fU0VORCB8CisJCSBTRVJfUlM0ODVfUlhfRFVSSU5HX1RYIHwgU0VSX1JTNDg1X1RF
Uk1JTkFURV9CVVMsCiB9OwogCiBzdGF0aWMgY29uc3Qgc3RydWN0IHByb3BlcnR5X2VudHJ5IGlv
dDIwNDBfZ3Bpb19wcm9wZXJ0aWVzW10gPSB7Ci0tIAoyLjQwLjEKCg==
