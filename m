Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2EC480B465
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 13:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjLIM7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 07:59:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjLIM7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 07:59:15 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2043.outbound.protection.outlook.com [40.107.7.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87F010D8;
        Sat,  9 Dec 2023 04:59:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j3nuZnDB1sbK/8slOWy24jbK1DynajwdiRaYGh1gzS/DRBJn1xTJs5yteHRfhMnN0O4qVBcJ+9Do9g6dcOMWnO5MXZTEJSn1xOZMRHtaPi3hxEZ7GfMb2dNFg8KAFk6OV0REAJI0bRM+Zlkz+0W02Pb3i8qAGDAq97a0dXU/ZZKi5IVpxBkdJcXIQWf8DDDJEYGpGe6xGxq5C8wI4DqQfwI1L/PDbA1gZsN4kLJ+o/k5WOZkqNwmJBF9vT3lvuhdFetJ3BXfoq8LbQOVJv53Vx6asdbWdYOZF7ZbltSPrpCzwugd2ZJIM8Bd+6IqZqaBE7eb2zssEoTMzDqlJZS4Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ui9KCTXid1xQ6I8QFDMz29kSlbNm7B3mfuhdJjPmypQ=;
 b=a1KpvBvo7wiqdirTWw3HoSCuFvEz+WFIQjDj3adVjGHFA5xXb3hrxZ8o6KQdweABRGTGL7u50GahQtBEz9RIuGeZsfmgiCN115I8iGbqitcnfI0qq6rJY8Yk2qOYSs1xdwAi9Rb2POTEQ6B8us1UQcBKxOPoWF3UEa6g1E0Un2Vwnch+y1Lt/wV76B/iwhjdArlRb6WNnXEU+jRkFdHQweK/3Ngi9yrymWk1tux6BJzmFoQ6iRVrkGN2hGjsQmPav0xBFMMcuc1saxET71fVW1yaim43zCipyW4rGotoal2xHwjEf+K32WqXQz1wtpaghXRHf9wOOXZzxcr1zBqsMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ui9KCTXid1xQ6I8QFDMz29kSlbNm7B3mfuhdJjPmypQ=;
 b=MfhZWO3FWbkxNtBrKbntGgThLZLgvtlBdJ3LsmIZgksnj0r3GG/s76PlMLB5eukAkAn2dyQ62qKGBWR+RvScdI3DQbqgOztYTAyOj6I1QRcoBEXhkDc43LfY159pUlSfxuVGR1ZXo7th/xM72DZBDB0CVNjQ/q4pKBFHIlyRmU4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by PR3P193MB0555.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:31::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.29; Sat, 9 Dec
 2023 12:59:17 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::653f:d0f3:e7f6:8c06]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::653f:d0f3:e7f6:8c06%5]) with mapi id 15.20.7068.029; Sat, 9 Dec 2023
 12:59:17 +0000
From:   Lino Sanfilippo <l.sanfilippo@kunbus.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com
Cc:     u.kleine-koenig@pengutronix.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, cniedermaier@dh-electronics.com,
        hugo@hugovil.com, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, LinoSanfilippo@gmx.de,
        lukas@wunner.de, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        stable@vger.kernel.org
Subject: [PATCH v5 1/7] serial: Do not hold the port lock when setting rx-during-tx GPIO
Date:   Sat,  9 Dec 2023 13:58:30 +0100
Message-ID: <20231209125836.16294-2-l.sanfilippo@kunbus.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231209125836.16294-1-l.sanfilippo@kunbus.com>
References: <20231209125836.16294-1-l.sanfilippo@kunbus.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0070.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::22) To VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:803:4e::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0413:EE_|PR3P193MB0555:EE_
X-MS-Office365-Filtering-Correlation-Id: f07165ad-c521-41c0-72c8-08dbf8b6a69e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fy7yyyM2iBJ81/YY1YEVoIB6yAqEAXTHB9SqJiN+zWrOmlRYTjsKGCDIMnTO7qlwNbngoeHUggAI7WrdFM9sJsyrw+EzZkDdcHsyuLZjniR5aekdCdVw+/osoCALTRBq+7I4sF7MKYE48hEIQL80BUFiNqNtyomAmqwUKq6m3LfUay8Dwe6GkP823kJuFNK67MpVrrwjQfmhzzhS6mbNpThvDvFFE9aVm2CKqiuY6UhWlEM05iUSbcg84GCn7XcG72awYZpwu7rfZLvqUXj9N+4Z7T9zt1PrIzZfA7KDPywUjY3p3QcsiXu2nlFxvgGGA0KdWKffGf084qpwRiGvUoDJxBMJw2NmOrr8celxwJvcmIB5CpgdplCJRP9IavcElkb2CtVcukQvhv9K2w6i4IPpzu4kBEnGtIO7EnDcYkc4aemJkuvX2VXelw6cM0fFjmD49KaOqYERtU/NCWphvvQIVPRcXrj1hyYWmahdb3Ay79KrV/fZ4WtzrxJdQOf1voEakuVZVcSI+kt9dInHesS8esTtf8tdqV/7cG+tqidAY764K35iGmiDcN4aLd0A
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(366004)(376002)(396003)(346002)(136003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(2616005)(1076003)(478600001)(6506007)(6666004)(52116002)(6512007)(41300700001)(83380400001)(5660300002)(2906002)(4326008)(8676002)(8936002)(7416002)(6486002)(66946007)(316002)(66476007)(66556008)(38100700002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QC3nGixn46mXECUwVXiCF0FJUfsIYc7NyQL4CvxsYwaa44V+ptxqWe4zTyTO?=
 =?us-ascii?Q?Ia86Tq0svO9IEelF2GHMjagNHafr+Hav9hC5b9YPcx9W2KVgyJ6BjDitna1+?=
 =?us-ascii?Q?zaN3WG3RtkerA3IG5fVxHl42V/By7C7bUDFNfWTRapmxxeweDai0nzu0/hMq?=
 =?us-ascii?Q?K6O8SPQDZMZVrWWPkjLx+jgpBAwaomDM4Cca62j872xt8B9tPfLB/GRmgHVN?=
 =?us-ascii?Q?I1z9KtJLccDQYvG7gWlTVNAZ9WKRQ7OoTWJ/TGFooM5GmurbFmYBiARE6OJI?=
 =?us-ascii?Q?jr0Dq00IaFr4ELy51oaL9b1Fm83NekBwn3hgNGRxVk5xy8zKT3cErAyjOyFU?=
 =?us-ascii?Q?K91JOiUFalFJ7gu0Pi7hvV8jZTeADtuNGvL8vMBPVPeyJHKCKocZBJRVxLyl?=
 =?us-ascii?Q?i8d5fee+1aXGwSlY4IiEB/JfkPD9/ghKybSWTmKubOM5cjk2qQAYMSZddVUx?=
 =?us-ascii?Q?CaqFwy2p5mcI6oOVnd+N7akAYub8XUTadsx/+mPxlaV1S3Li7HuHtxChR4OZ?=
 =?us-ascii?Q?bDIEBICWQav+1eWO90QLPMMoh+XTHupCvsBZYRM6VLffI73A5/PdtLtvnCqA?=
 =?us-ascii?Q?Uh6S3Wd/8XXunA8si2/LPEE1kiKLtL20rhwU2mK7TvQUrwXPoqC5dkHLeTtI?=
 =?us-ascii?Q?q9IQTOITZsdbqxz4E6CYbSkaXMrOguMiXCtF/MtWlQ1Gb2cdH2YI2Zo3zO+4?=
 =?us-ascii?Q?voYgGjMv+To7daQgRhtlrSGfDSAqd3OTgLnsvW0eTO7yuYtEIGJFsbLd3LhF?=
 =?us-ascii?Q?WtANL2ymdIF1jwCulcovEM2pT0eD498Z4lIFFzVtyM9rzP6Wjnc7N58q52fb?=
 =?us-ascii?Q?CL7ydFz6c2tpcdeLZcWzRurpxOnfKNXg0nJ7+0z7RuoyHXG3XzfWIwdL5Stz?=
 =?us-ascii?Q?86VxoRiF/hZ9tKD6i2dBXxmgdK5h1aS7G+dAYcx6CA7jQs7IuGjab5s1CzT3?=
 =?us-ascii?Q?hsw/Be8A937lkOAxkjzF4iGfWA83K0aWaVbueYEdq08a7v++o5AJV0HP4xow?=
 =?us-ascii?Q?FgPJVJE4IP1r6itLlXnZOb279KApv2rw+LXkOOADbg6zFMp3iX5H0WHhd+0V?=
 =?us-ascii?Q?oo9aa6TBtI2vtSduvR/xiqnxjV/sdMS515RQtPgxWSoY+5miZ7NLGrAagELl?=
 =?us-ascii?Q?2qo56rEB7zcCoDGtgXA7dHLgtDZrjWOS1HGzy5i4HCMxMeiQHrqzf6yIe9p4?=
 =?us-ascii?Q?vyDVrFCo1G2xzNKxvnqvB//yyque2kfCSjRhOiBN2SEN1uTKjyV1n+oXS1/k?=
 =?us-ascii?Q?UEEbr5NbdTNdJNRj4slR1IQuFFHS9O44+LZ+7tpvjWkYYzm+KYlMM+cMmhOG?=
 =?us-ascii?Q?wgtAR1Wx50vZEBAuFRUkF98df7zMHPmyp7eR++e2fHPRIOK92+RRz4JKF0q9?=
 =?us-ascii?Q?UICm3Vv91P+AoC5NZYQc2ZuOAu9ctaQwaFKNqA3a9GlrOD7tmqw5yRWtIclK?=
 =?us-ascii?Q?UQxGtD+TjCAayfs62RFNrh2g8TVquX+LloMYmUDUzJTF74tVDucnAPHOFuGY?=
 =?us-ascii?Q?03s0jnH32mIT9BIww1RXEUD+pC2/oKhwZA6p9Jt4jCjjv/tDN6zfX5pHOLKp?=
 =?us-ascii?Q?yRkXAWpT8uBLhwNRnOI/0BgElmuTv18lNwYOWoXSOUPTtw8AiK22hV6kR5xf?=
 =?us-ascii?Q?7WsNRQFw7R92Kb9Zie7Vzyl2VCNVdiaE6fEPpv34n84n?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f07165ad-c521-41c0-72c8-08dbf8b6a69e
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2023 12:59:16.7942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /J16/FjfSkP2LSYuYnSYrW1IIbPsaqP9Qp1Bvv6OOpx2m9OTxJKUB+Gf5t2L/K/qMdyZo7SREo09Lw2wbU0K4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P193MB0555
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MIME_BASE64_TEXT,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qm90aCB0aGUgaW14IGFuZCBzdG0zMiBkcml2ZXIgc2V0IHRoZSByeC1kdXJpbmctdHggR1BJTyBp
biByczQ4NV9jb25maWcoKS4KU2luY2UgdGhpcyBmdW5jdGlvbiBpcyBjYWxsZWQgd2l0aCB0aGUg
cG9ydCBsb2NrIGhlbGQsIHRoaXMgY2FuIGJlIGFuCnByb2JsZW0gaW4gY2FzZSB0aGF0IHNldHRp
bmcgdGhlIEdQSU8gbGluZSBjYW4gc2xlZXAgKGUuZy4gaWYgYSBHUElPCmV4cGFuZGVyIGlzIHVz
ZWQgd2hpY2ggaXMgY29ubmVjdGVkIHZpYSBTUEkgb3IgSTJDKS4KCkF2b2lkIHRoaXMgaXNzdWUg
YnkgbW92aW5nIHRoZSBHUElPIHNldHRpbmcgb3V0c2lkZSBvZiB0aGUgcG9ydCBsb2NrIGludG8K
dGhlIHNlcmlhbCBjb3JlIGFuZCB0aHVzIG1ha2luZyBpdCBhIGdlbmVyaWMgZmVhdHVyZS4KCkZp
eGVzOiBjNTRkNDg1NDM2ODkgKCJzZXJpYWw6IHN0bTMyOiBBZGQgc3VwcG9ydCBmb3IgcnM0ODUg
UlhfRFVSSU5HX1RYIG91dHB1dCBHUElPIikKRml4ZXM6IGNhNTMwY2ZhOTY4YyAoInNlcmlhbDog
aW14OiBBZGQgc3VwcG9ydCBmb3IgUlM0ODUgUlhfRFVSSU5HX1RYIG91dHB1dCBHUElPIikKQ2M6
IFNoYXduIEd1byA8c2hhd25ndW9Aa2VybmVsLm9yZz4KQ2M6IFNhc2NoYSBIYXVlciA8cy5oYXVl
ckBwZW5ndXRyb25peC5kZT4KQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcKU2lnbmVkLW9mZi1i
eTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KLS0tCiBkcml2ZXJz
L3R0eS9zZXJpYWwvaW14LmMgICAgICAgICB8ICA0IC0tLS0KIGRyaXZlcnMvdHR5L3NlcmlhbC9z
ZXJpYWxfY29yZS5jIHwgMTIgKysrKysrKysrKysrCiBkcml2ZXJzL3R0eS9zZXJpYWwvc3RtMzIt
dXNhcnQuYyB8ICA1ICstLS0tCiAzIGZpbGVzIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDgg
ZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy90dHkvc2VyaWFsL2lteC5jIGIvZHJp
dmVycy90dHkvc2VyaWFsL2lteC5jCmluZGV4IDcwOGI5ODUyYTU3NS4uOWNmZmViMjMxMTJiIDEw
MDY0NAotLS0gYS9kcml2ZXJzL3R0eS9zZXJpYWwvaW14LmMKKysrIGIvZHJpdmVycy90dHkvc2Vy
aWFsL2lteC5jCkBAIC0xOTQzLDEwICsxOTQzLDYgQEAgc3RhdGljIGludCBpbXhfdWFydF9yczQ4
NV9jb25maWcoc3RydWN0IHVhcnRfcG9ydCAqcG9ydCwgc3RydWN0IGt0ZXJtaW9zICp0ZXJtaW8K
IAkgICAgcnM0ODVjb25mLT5mbGFncyAmIFNFUl9SUzQ4NV9SWF9EVVJJTkdfVFgpCiAJCWlteF91
YXJ0X3N0YXJ0X3J4KHBvcnQpOwogCi0JaWYgKHBvcnQtPnJzNDg1X3J4X2R1cmluZ190eF9ncGlv
KQotCQlncGlvZF9zZXRfdmFsdWVfY2Fuc2xlZXAocG9ydC0+cnM0ODVfcnhfZHVyaW5nX3R4X2dw
aW8sCi0JCQkJCSAhIShyczQ4NWNvbmYtPmZsYWdzICYgU0VSX1JTNDg1X1JYX0RVUklOR19UWCkp
OwotCiAJcmV0dXJuIDA7CiB9CiAKZGlmZiAtLWdpdCBhL2RyaXZlcnMvdHR5L3NlcmlhbC9zZXJp
YWxfY29yZS5jIGIvZHJpdmVycy90dHkvc2VyaWFsL3NlcmlhbF9jb3JlLmMKaW5kZXggZjEzNDhh
NTA5NTUyLi5hMDI5MGE1ZmU4YjMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdHR5L3NlcmlhbC9zZXJp
YWxfY29yZS5jCisrKyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9zZXJpYWxfY29yZS5jCkBAIC0xNDAy
LDYgKzE0MDIsMTYgQEAgc3RhdGljIHZvaWQgdWFydF9zZXRfcnM0ODVfdGVybWluYXRpb24oc3Ry
dWN0IHVhcnRfcG9ydCAqcG9ydCwKIAkJCQkgISEocnM0ODUtPmZsYWdzICYgU0VSX1JTNDg1X1RF
Uk1JTkFURV9CVVMpKTsKIH0KIAorc3RhdGljIHZvaWQgdWFydF9zZXRfcnM0ODVfcnhfZHVyaW5n
X3R4KHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQsCisJCQkJCWNvbnN0IHN0cnVjdCBzZXJpYWxfcnM0
ODUgKnJzNDg1KQoreworCWlmICghKHJzNDg1LT5mbGFncyAmIFNFUl9SUzQ4NV9FTkFCTEVEKSkK
KwkJcmV0dXJuOworCisJZ3Bpb2Rfc2V0X3ZhbHVlX2NhbnNsZWVwKHBvcnQtPnJzNDg1X3J4X2R1
cmluZ190eF9ncGlvLAorCQkJCSAhIShyczQ4NS0+ZmxhZ3MgJiBTRVJfUlM0ODVfUlhfRFVSSU5H
X1RYKSk7Cit9CisKIHN0YXRpYyBpbnQgdWFydF9yczQ4NV9jb25maWcoc3RydWN0IHVhcnRfcG9y
dCAqcG9ydCkKIHsKIAlzdHJ1Y3Qgc2VyaWFsX3JzNDg1ICpyczQ4NSA9ICZwb3J0LT5yczQ4NTsK
QEAgLTE0MTMsNiArMTQyMyw3IEBAIHN0YXRpYyBpbnQgdWFydF9yczQ4NV9jb25maWcoc3RydWN0
IHVhcnRfcG9ydCAqcG9ydCkKIAogCXVhcnRfc2FuaXRpemVfc2VyaWFsX3JzNDg1KHBvcnQsIHJz
NDg1KTsKIAl1YXJ0X3NldF9yczQ4NV90ZXJtaW5hdGlvbihwb3J0LCByczQ4NSk7CisJdWFydF9z
ZXRfcnM0ODVfcnhfZHVyaW5nX3R4KHBvcnQsIHJzNDg1KTsKIAogCXVhcnRfcG9ydF9sb2NrX2ly
cXNhdmUocG9ydCwgJmZsYWdzKTsKIAlyZXQgPSBwb3J0LT5yczQ4NV9jb25maWcocG9ydCwgTlVM
TCwgcnM0ODUpOwpAQCAtMTQ1Nyw2ICsxNDY4LDcgQEAgc3RhdGljIGludCB1YXJ0X3NldF9yczQ4
NV9jb25maWcoc3RydWN0IHR0eV9zdHJ1Y3QgKnR0eSwgc3RydWN0IHVhcnRfcG9ydCAqcG9ydCwK
IAkJcmV0dXJuIHJldDsKIAl1YXJ0X3Nhbml0aXplX3NlcmlhbF9yczQ4NShwb3J0LCAmcnM0ODUp
OwogCXVhcnRfc2V0X3JzNDg1X3Rlcm1pbmF0aW9uKHBvcnQsICZyczQ4NSk7CisJdWFydF9zZXRf
cnM0ODVfcnhfZHVyaW5nX3R4KHBvcnQsICZyczQ4NSk7CiAKIAl1YXJ0X3BvcnRfbG9ja19pcnFz
YXZlKHBvcnQsICZmbGFncyk7CiAJcmV0ID0gcG9ydC0+cnM0ODVfY29uZmlnKHBvcnQsICZ0dHkt
PnRlcm1pb3MsICZyczQ4NSk7CmRpZmYgLS1naXQgYS9kcml2ZXJzL3R0eS9zZXJpYWwvc3RtMzIt
dXNhcnQuYyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9zdG0zMi11c2FydC5jCmluZGV4IDMwNDg2MjAz
MTVkNi4uZWM5YTcyYTViZWE5IDEwMDY0NAotLS0gYS9kcml2ZXJzL3R0eS9zZXJpYWwvc3RtMzIt
dXNhcnQuYworKysgYi9kcml2ZXJzL3R0eS9zZXJpYWwvc3RtMzItdXNhcnQuYwpAQCAtMjI2LDEw
ICsyMjYsNyBAQCBzdGF0aWMgaW50IHN0bTMyX3VzYXJ0X2NvbmZpZ19yczQ4NShzdHJ1Y3QgdWFy
dF9wb3J0ICpwb3J0LCBzdHJ1Y3Qga3Rlcm1pb3MgKnRlcgogCiAJc3RtMzJfdXNhcnRfY2xyX2Jp
dHMocG9ydCwgb2ZzLT5jcjEsIEJJVChjZmctPnVhcnRfZW5hYmxlX2JpdCkpOwogCi0JaWYgKHBv
cnQtPnJzNDg1X3J4X2R1cmluZ190eF9ncGlvKQotCQlncGlvZF9zZXRfdmFsdWVfY2Fuc2xlZXAo
cG9ydC0+cnM0ODVfcnhfZHVyaW5nX3R4X2dwaW8sCi0JCQkJCSAhIShyczQ4NWNvbmYtPmZsYWdz
ICYgU0VSX1JTNDg1X1JYX0RVUklOR19UWCkpOwotCWVsc2UKKwlpZiAoIXBvcnQtPnJzNDg1X3J4
X2R1cmluZ190eF9ncGlvKQogCQlyczQ4NWNvbmYtPmZsYWdzIHw9IFNFUl9SUzQ4NV9SWF9EVVJJ
TkdfVFg7CiAKIAlpZiAocnM0ODVjb25mLT5mbGFncyAmIFNFUl9SUzQ4NV9FTkFCTEVEKSB7Ci0t
IAoyLjQyLjAKCg==
