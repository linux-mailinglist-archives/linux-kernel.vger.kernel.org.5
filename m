Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F587CE546
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjJRRt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 13:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbjJRRtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:49:45 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2047.outbound.protection.outlook.com [40.107.22.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381C5111;
        Wed, 18 Oct 2023 10:49:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c2gQQChVxGzC6HUdhwdjwJLe92l0XLbgCSLxjXtcJowjFKwDi4x7E57tcMzl8TuQStOkDs/40o7eSsf3Q76rP3NxSXPCJ8mwsPiTPBdeOsZqyTCoN2tIiAZMX35rbO8lIHst+jN4PDYWmnMYX30UawCtwiWXddAUgsyx11JirNGw2oi7dANboY1xg40AEDzWehr+maV6m+V6lhK/z1AsQP8qZ5h78jTm9VvD/511FeO99cR45+20PYAQmGKekJIW39rj5pqWwyliJPoIUnCKYG27S8id4m0wd5xqt3hwFkUXOPmiO94ASYWr5ZpawCGsp9phnAJeGlPKhrQ4seOyOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w4GqqAu1YpbERiRD53HRt9O/SyEoX2/kmKWMxhgAsE8=;
 b=fU9VEmhv41xMBgB/IShPS6QFGJz2VfHdpc5ORnWlhsy8EWNreiAO4nmPJxij/2G7DTH/Y+KHUpbrwHhaqV/4H+GlOhOAV2eHbPa2dU1u9RC9OaXTZfOU4vk6abuu9aYzDjcbayN6ZHPveJ2ASByAO7NSBvUhyFE4sAx2kz3m9oNCwDwRPAjiXGwkwXjq1biCyO8wXdg2U8M/c3dns/uyxrUJt2VK2LmtrONL8uXMyEYCmV4SjRTN0QTUjPDmztaJ30PIdEBcY/1y1lLX7YwXNq9kXC7qhsrqrxgIIKp2JUvpU7itUz4tD0KVJHZd9RHSq7Ig05UVAE/L95Wu6Srn8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w4GqqAu1YpbERiRD53HRt9O/SyEoX2/kmKWMxhgAsE8=;
 b=VpQJ+1cXGAjHN/rUQW6HSGGQxPC0FrYAMAsXArNpCvjliGscg2SHW5Y3CemmpqdGMQBjnYRCdi87t0YdlmVzBRgqOHSM4efWyDsS/HeAxgKmboj54hdELSzTrioOy+z/F5S8VA6pEKyaVPMv8xoDm2eZE6uWBiMJuepqIS4hyg4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by AS8P193MB1478.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:350::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Wed, 18 Oct
 2023 17:49:39 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::550d:2425:c0ed:3e59]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::550d:2425:c0ed:3e59%3]) with mapi id 15.20.6886.034; Wed, 18 Oct 2023
 17:49:39 +0000
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
Subject: [PATCH v4 4/7] serial: core: make sure RS485 cannot be enabled when it is not supported
Date:   Wed, 18 Oct 2023 19:48:37 +0200
Message-Id: <20231018174840.28977-5-l.sanfilippo@kunbus.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0b4caad4-19ef-4727-e8b1-08dbd00299c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: svjy0K3wb7yzn5wApTnwDw5STDiJKfNnI73LjKOy73hMJlfYnAQZhbMP9j+6tX6KpCV9QbiDJrWVrJdSAnQtzPoaS3Leio5oaUctqpPOvGfXjpsYWR1exbIPzx16AWkuqnczbpw+kkkK8RY+x3vIgcBAvCZl4TdWTc+oRcysdVrZ9am7u31M+ztz3SjCIBUsrpGqWquy/RKbMdidoUYO+F5TiqSosePJeCkNlDiNwYDemH60ZC60vnEIA3U/bRdkqHSj6mOXmb4E3cxiyRvIbJpY/tlrHtg63cOfAl49DKkKc4PG5JdASyOw/mUU7aSOzrIcuJnGudFKLuMapLujcD52ZoVgDuoERwDWrP3R5bZeUtTSB6Vc8gKgiYnq7W4oUwgDmxl3ad/IJubkKHKEZtDyFE1jx0i+eUyYqn67IfvGmse2Wnl0zCCnO7tsXB7hIGEvS0h1BQeamNN9VyYIEOJyLSBjA0xiNll9J+zluKD5/VHtNZNWUmvlzzreyKiOj+pGlDBE8AqgXpkcOjyibDXDsA3hxv6+UdFljxdHTdUFFcv2NBCmxHFPn03uO7yl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(39840400004)(376002)(346002)(366004)(136003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(36756003)(66946007)(66556008)(66476007)(86362001)(38100700002)(1076003)(2616005)(83380400001)(6512007)(52116002)(6506007)(7416002)(6486002)(316002)(478600001)(5660300002)(4326008)(8676002)(41300700001)(2906002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u2uscTQ6tODp/oVuSdzy5OPWtfbQLid62kem5zmpQoSzxx157DkkNC4Ef2iu?=
 =?us-ascii?Q?XcjKE46EkxQBUPpDmkqgs/TMdLTdHlnBRJRWhKbHUvuHNEadb3+0U5/ypf0+?=
 =?us-ascii?Q?kYHIaczUVr5xKHTp0YHag5il2PpQ8hvcYvvFjhCD1oPzQ6A6gTsV/kt+Tb+B?=
 =?us-ascii?Q?/B3F+Iit9OlzUgKdPiuclG9ZkyU2pWx5VZlbX9mZQ1SJgADpqhgcn8uwIIJw?=
 =?us-ascii?Q?Y0utzn1yuCFO/aykkoNtTbpdNqkx1z0meJHobsgmerTk3yADAG8Xgc3ydirz?=
 =?us-ascii?Q?giSCb+HvjULbT1+oVJZtzkwg9gqnFwL92Zr6HxbyGv4s1XPFyixaeL7mtlyN?=
 =?us-ascii?Q?3lcZfhzs1BtOUMuXU3ZXAqbMvSHQ9ScA1e0bSMSX+r9vKPjaYQBV6BTzIfsi?=
 =?us-ascii?Q?Ky98ekwsWFzUu/m0NqBOhkPWN31+y86bVhZkPRQpFEUrOFvAlZLOnXJ3Fsmj?=
 =?us-ascii?Q?C7+0pwpO20sGw2pf4lWq4DWbq/G+uEbmz8HmEC4aUizLQm3rOZIBCjRBEpoQ?=
 =?us-ascii?Q?xGNdlbi/fIDADGv48luC9nY8ociTjcytyww3tKU3CIQAuEdwy0JfQfuVvFNB?=
 =?us-ascii?Q?bgPEbgjmvPa+NghSUW43MsuTPO+pJdxqoIHwyViIKYIRVhr8E6//9aRi9VjH?=
 =?us-ascii?Q?gJZDgwjgzGlfukTHSG/MPNtwtmXLmbJmyXB3IfhOrLrnGLEPPsU14qvr5X43?=
 =?us-ascii?Q?YXvgQM+YVQ3rG/DFfIFILmiWiqo2VBsYnyFkUiHfJ2A94K8k1J/CrOpcr3WO?=
 =?us-ascii?Q?Fijxc2V4u6flLJsvwDyDDzTRGz/BUR3qY9jhL9SQrwLOEQpYKGNPmfX4F692?=
 =?us-ascii?Q?FFGLamiDug1r2S0A0ICBqJ7M2B+AmVYJFe97G+LS8l9SAnapV46lXXsXlXhZ?=
 =?us-ascii?Q?s/y5H+uEVWKMD0lc7bD7nKzHoJi3muVnsFDRE78x2gx4WyUlmpWXyHniGUYC?=
 =?us-ascii?Q?TUzRb+IiNenb/JdQAe3Q9WxZ8CiAyVWTKdsT42baAEA+V56sF3yTYA6hB/v7?=
 =?us-ascii?Q?28IyhUUD1hhxADQI/IzyapjnJLXNcrI8194+iwWGdbEQitin9BY9yyHpus0U?=
 =?us-ascii?Q?p9m3GgYaeIfneNls00MzrhY5Hqhq4tqb4fLSrCCkF0vvlZ54dnMhv6Gx1Khm?=
 =?us-ascii?Q?9Pi/DaN+1Uj4BOFySaUnj0JweI5N91xhFvnPq3s9hdwcNZGrEwIhiEWO333p?=
 =?us-ascii?Q?Pf06qbbbsAf4kIVc/bpep2QahrRknvwKwleo/WNY3FWUX5T5aQ31FInbUyct?=
 =?us-ascii?Q?35rtnZboGs3s2vOcC0VW7/rx/kL6zGgCzw/x4abr+hXFcOK2gZ3CThsWGIh6?=
 =?us-ascii?Q?nEea90cVCcxdGMGUmS4AOUYDEW9v8vlfPZ2yle1+yd6cVEKnBKuNkJFz/bn9?=
 =?us-ascii?Q?UrDyhtdcCW8FcHA2L8nrEgK8+do/3zG1/o6P8e5K6qQli77X3Zo1UKlTdJwn?=
 =?us-ascii?Q?CrLrE4ufsdiGaYoov1Z7elO+9D2trxSpKPj6r2cezpLuZJRnpxvpbfQUEN60?=
 =?us-ascii?Q?cRB1ZiuSZLgeKZe5J6zYbjsBMH3eg9qCb88I8qCiOjVA7phNWb8SmIDsxZXC?=
 =?us-ascii?Q?+pyXitgRaLLKzo8PCFj7M8kWsbHC8Kh5IWm6zm1c45qR7Rz/WzE5YBESWFdx?=
 =?us-ascii?Q?szt697Rfs2xjOsPwuKV+/siR1aBv3/WFUIbtqdLE0dGU?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b4caad4-19ef-4727-e8b1-08dbd00299c0
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 17:49:39.2625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uQaQsd7nbtBLqbD64cqci+u1b2lhwe6JQKcwQn3DTh1/d5pUYQIOWy0R+fPePTFK51lekSrsTWTpqrPPCi7Tgw==
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

U29tZSB1YXJ0IGRyaXZlcnMgc3BlY2lmeSBhIHJzNDg1X2NvbmZpZygpIGZ1bmN0aW9uIGFuZCB0
aGVuIGRlY2lkZSBsYXRlcgp0byBkaXNhYmxlIFJTNDg1IHN1cHBvcnQgZm9yIHNvbWUgcmVhc29u
IChlLmcuIGlteCBhbmQgYXI5MzMpLgoKSW4gdGhlc2UgY2FzZXMgdXNlcnNwYWNlIG1heSBiZSBh
YmxlIHRvIGFjdGl2YXRlIFJTNDg1IHZpYSBUSU9DU1JTNDg1Cm5ldmVydGhlbGVzcywgc2luY2Ug
aW4gdWFydF9zZXRfcnM0ODVfY29uZmlnKCkgYW4gZXhpc3RpbmcgcnM0ODVfY29uZmlnKCkKZnVu
Y3Rpb24gaW5kaWNhdGVzIHRoYXQgUlM0ODUgaXMgc3VwcG9ydGVkLgoKTWFrZSBzdXJlIHRoYXQg
dGhpcyBpcyBub3QgbG9uZ2VyIHBvc3NpYmxlIGJ5IGNoZWNraW5nIHRoZSB1YXJ0cwpyczQ4NV9z
dXBwb3J0ZWQuZmxhZ3MgaW5zdGVhZCBhbmQgYmFpbGluZyBvdXQgaWYgU0VSX1JTNDg1X0VOQUJM
RUQgaXMgbm90CnNldC4KCkZ1cnRoZXJtb3JlIGluc3RlYWQgb2YgcmV0dXJuaW5nIGFuIGVtcHR5
IHN0cnVjdHVyZSByZXR1cm4gLUVOT1RUWSBpZiB0aGUKUlM0ODUgY29uZmlndXJhdGlvbiBpcyBy
ZXF1ZXN0ZWQgdmlhIFRJT0NHUlM0ODUgYnV0IFJTNDg1IGlzIG5vdCBzdXBwb3J0ZWQuClRoaXMg
aGFzIGEgc21hbGwgaW1wYWN0IG9uIHVzZXJzcGFjZSB2aXNpYmlsaXR5IGJ1dCBpdCBpcyBjb25z
aXN0ZW50IHdpdGgKdGhlIC1FTk9UVFkgZXJyb3IgZm9yIFRJT0NHUlM0ODUuCgpGaXhlczogZTg0
OTE0NWUxZmRkICgic2VyaWFsOiBhcjkzM3g6IEZpbGwgaW4gcnM0ODVfc3VwcG9ydGVkIikKRml4
ZXM6IDU1ZTE4YzZiNmQ0MiAoInNlcmlhbDogaW14OiBSZW1vdmUgc2VyaWFsX3JzNDg1IHNhbml0
aXphdGlvbiIpCkNjOiBTaGF3biBHdW8gPHNoYXduZ3VvQGtlcm5lbC5vcmc+CkNjOiBTYXNjaGEg
SGF1ZXIgPHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU+CkNjOiBzdGFibGVAdmdlci5rZXJuZWwub3Jn
ClNpZ25lZC1vZmYtYnk6IExpbm8gU2FuZmlsaXBwbyA8bC5zYW5maWxpcHBvQGt1bmJ1cy5jb20+
Ci0tLQogZHJpdmVycy90dHkvc2VyaWFsL3NlcmlhbF9jb3JlLmMgfCA1ICsrKystCiAxIGZpbGUg
Y2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJp
dmVycy90dHkvc2VyaWFsL3NlcmlhbF9jb3JlLmMgYi9kcml2ZXJzL3R0eS9zZXJpYWwvc2VyaWFs
X2NvcmUuYwppbmRleCBmMWQ4ODlmOWZkNmUuLjQ5ZGQ1ZTg2NDcxOSAxMDA2NDQKLS0tIGEvZHJp
dmVycy90dHkvc2VyaWFsL3NlcmlhbF9jb3JlLmMKKysrIGIvZHJpdmVycy90dHkvc2VyaWFsL3Nl
cmlhbF9jb3JlLmMKQEAgLTE0NDMsNiArMTQ0Myw5IEBAIHN0YXRpYyBpbnQgdWFydF9nZXRfcnM0
ODVfY29uZmlnKHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQsCiAJdW5zaWduZWQgbG9uZyBmbGFnczsK
IAlzdHJ1Y3Qgc2VyaWFsX3JzNDg1IGF1eDsKIAorCWlmICghKHBvcnQtPnJzNDg1X3N1cHBvcnRl
ZC5mbGFncyAmIFNFUl9SUzQ4NV9FTkFCTEVEKSkKKwkJcmV0dXJuIC1FTk9UVFk7CisKIAlzcGlu
X2xvY2tfaXJxc2F2ZSgmcG9ydC0+bG9jaywgZmxhZ3MpOwogCWF1eCA9IHBvcnQtPnJzNDg1Owog
CXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJnBvcnQtPmxvY2ssIGZsYWdzKTsKQEAgLTE0NjAsNyAr
MTQ2Myw3IEBAIHN0YXRpYyBpbnQgdWFydF9zZXRfcnM0ODVfY29uZmlnKHN0cnVjdCB0dHlfc3Ry
dWN0ICp0dHksIHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQsCiAJaW50IHJldDsKIAl1bnNpZ25lZCBs
b25nIGZsYWdzOwogCi0JaWYgKCFwb3J0LT5yczQ4NV9jb25maWcpCisJaWYgKCEocG9ydC0+cnM0
ODVfc3VwcG9ydGVkLmZsYWdzICYgU0VSX1JTNDg1X0VOQUJMRUQpKQogCQlyZXR1cm4gLUVOT1RU
WTsKIAogCWlmIChjb3B5X2Zyb21fdXNlcigmcnM0ODUsIHJzNDg1X3VzZXIsIHNpemVvZigqcnM0
ODVfdXNlcikpKQotLSAKMi40MC4xCgo=
