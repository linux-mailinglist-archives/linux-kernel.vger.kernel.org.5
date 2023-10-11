Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B8A7C5A5C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 19:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbjJKRjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 13:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232926AbjJKRjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 13:39:18 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2088.outbound.protection.outlook.com [40.107.249.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D97C4;
        Wed, 11 Oct 2023 10:39:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QuSh1NXj8JHoy9LCLL+f2xorFck/5FWwXmfw09vLYL2thIoaym/KpRVy39Hg7OS9fqb8fzsFTTDB57YVj2wipshkmW8KFEnEHK8nwPt5sNPGYzmrd94ZClTofC2e10VX9wdc5/iyACpBPv11hnYdGD2ZhZem2DhjQtkGIVdu+UD+OJZz9/0+p5ZmNQ74TGyVvFByqN/av6GmEvYAMXt8WiIJJNazSmdAakyt58hasXcTOaTzK9PoTOQR1CSBcEt8Wlw1roGt6UofjMS5I4fP+ltQ9KVryhhXPWILsaMteLfEYVn8zJfy94uWHiDwXt89wg+4QFBRFuRsgyQTU7H4zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TJ5/eJP8FSTSE85vf+YgYI2YYEXaQjMZKL7yA99JX58=;
 b=UZZTUqNXgsZgu/466tYIm+Ix/uqnDGn/YDRUhle54azedumTc5ETSmx72cpHpS3tm3TorNpd0ruvJKMcX3RgX679cP8QJ/ZvJS5kzfbH2eHw7p8JR9BR+BcPZiRsoS/1NfU/mxhOvl6grpwb3ZuvL+W5qlhx5h7037jIEQVns0fNcoFnS0yri4kQD5GdGphsC55a4RuDpLrXFm0tVSxW1rm3mHK4MWsoHU8BqjS72RDKsvyHeGRmP0CElXW1dKrDLgHrXqioNlRYD/JLSP4kYCH63W3QJw9AtKPsmOFXZ3AuRmgY1j5bhXy0ZfZf2UV7QPtXrgVjyyfskTCgRwQeHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJ5/eJP8FSTSE85vf+YgYI2YYEXaQjMZKL7yA99JX58=;
 b=DbVAj2hhxlbE474a4rpPOhEOesiUrQaeAadFkRnHHiruO56n/owYU8kaO+I+eKAlF0LMGL22UYDN77HNRac3HkvfBEmA6eD7ndDqOn9HRSKGIGlmxu/jD8myX0k+mToWNnfwsO5DCQpUxCg9iYw2LGb29er1iI+wWKesh07E1Ac=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by AM8P193MB1187.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:362::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.41; Wed, 11 Oct
 2023 17:39:07 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::550d:2425:c0ed:3e59]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::550d:2425:c0ed:3e59%3]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 17:39:07 +0000
From:   Lino Sanfilippo <l.sanfilippo@kunbus.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        cniedermaier@dh-electronics.com, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, LinoSanfilippo@gmx.de,
        lukas@wunner.de, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        stable@vger.kernel.org
Subject: [PATCH v2 5/7] serial: core: make sure RS485 cannot be enabled when it is not supported
Date:   Wed, 11 Oct 2023 19:38:27 +0200
Message-Id: <20231011173829.10508-6-l.sanfilippo@kunbus.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231011173829.10508-1-l.sanfilippo@kunbus.com>
References: <20231011173829.10508-1-l.sanfilippo@kunbus.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0093.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::18) To VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:803:4e::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0413:EE_|AM8P193MB1187:EE_
X-MS-Office365-Filtering-Correlation-Id: eac9b7c1-c153-473b-7d9b-08dbca80f84a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MhzVGNtm64uw4rKQgbL0d0zQXFs3Mw2rITxyAFESodnZquKHFt1tTsZcnHK5Bj505w8NMp1LeOsv8pqxwtbyEL6PZ3w3eRm+1L4FGiij6His1Lp78BUw5H/9kPoZ6587d83o1vambc6kjK1CeUwZIzc5wD6/Lpn/4hWKB110C5pdkmZdbrk5NDiTlDqOG5VddyqQu0kMNsGugqGlD3QIA/VrPbG4DagCwCeFrg46IvC7Wh8jGLuA8tbwP38hFxJEKoWN29XxXhiv1V9NJst5RUTdQt+VY0tRD/EZAHwzJLb9tWzbrBokk6Wl8luoG7JwLLMImZtU5C2AE9lhaHI3a5IHGdHcz1M1YdKPDb6VghaFJRkGrQn14ku338WN0kJHskaLeKnkO4MnAov/uw15e932jXDy5UYXbCG94fXWYW81ojzLXy1bSjBrlhu3+L+fWE7KmhKIWD6vlXCoDPYUn5bc5ZzyAi73hcv9XI5gm6vtS2n1SCLxG2U+34wSua4w2dQmTQXMXcGuhC3wirP8AJs2hEhVCX+dV6RXGHwH05UYd/epY0XmBqxQSagZsJIT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(39840400004)(376002)(366004)(346002)(396003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(6666004)(2616005)(83380400001)(6486002)(478600001)(1076003)(52116002)(38100700002)(6506007)(6512007)(66476007)(66946007)(66556008)(4326008)(8676002)(8936002)(41300700001)(316002)(86362001)(7416002)(2906002)(36756003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p62od7rs+/j5jbADP20rHQ7RBWos/B04yXkWO7fPgRJ0Bv2DyZhOA0KAeaGT?=
 =?us-ascii?Q?kWo3Q5J2fqHgC7H55sw2DXF1s72O8QfImWT7tbreJhwtE93t8L5W+8XVNfwb?=
 =?us-ascii?Q?2sct+3C86LHDo+wQSwE0fVKz+nVju+vcMzvVlbuLsb1vqvb8OttSerLiSWV9?=
 =?us-ascii?Q?bQwSGKGAKFEngOJqXqBYWp2DoWkaRbCOpxshGSaXnxrDeW4Vpb7IQWj6WcrX?=
 =?us-ascii?Q?7Og67dZ5E+Sjnc5E1Y3195iMfnIU3pkjBa7vnk05J4l479dyBl26Ak8Yje72?=
 =?us-ascii?Q?quya5X6/+au7daG3FOgfPqKzAli39G17wn17NbOhAgMI1TGixjl58NSV2KZ/?=
 =?us-ascii?Q?jzPFMzr0/LpwZ/2O7kge9/2u+3l6VyrkwBUv+Vt/2FLb88Ymato/XbG3TsWY?=
 =?us-ascii?Q?hwwm2EN1MS2pfyW41BPRLmnE1/yNa7FcHGdzXTKUL/CdQy4arbAdVkt7xHgO?=
 =?us-ascii?Q?fJCm9mYizbsZLT7B9cvW4KEnD6KCApzhbK3Oiz5sK5pm68+9bqHwbwpYTmyI?=
 =?us-ascii?Q?AYvmbgksfd4fwBXA+I2KHI2dgabb1mxf6hJBDWjGKiPormrD/SKa+EK1nDgW?=
 =?us-ascii?Q?SbeZcORXZjCH9gHGyMFnZZkgMCGTOjGeEXuPLXcRHmYVe87hy2mT7hEaVHMI?=
 =?us-ascii?Q?XpEa9rXHCJiJc4F5jGfso+LaQKQ0q0oFwFr4oGXDy/TmzxybfUcv0KAe3Ahm?=
 =?us-ascii?Q?RFh2ZS+DXmlG1QdikVfPtyGswRIIdjsSi/OA5lIK+aKRn33+xGuR7SAaUhKQ?=
 =?us-ascii?Q?weXzTZn+SWcmuOa3grwDXiwcCsFZsPbbIxVvQoKNn9RrRFX+m0iBfHhCye3o?=
 =?us-ascii?Q?u2sZ/tipIAjSlb2L/dKe46lYU/1EVLcMznGSQkZThEWLNJ3f/zpq7Opze2vP?=
 =?us-ascii?Q?X89xMWf5MHcdQqK4yedA5zBLCqeu3ZPUE6vXGhd75ZDHbAOvPFgHBC+ugjDh?=
 =?us-ascii?Q?tgG1mP7tK9OPI84QTTSWTinGupZLcms1TKkkKhRlJSOjP0RE73rJqY3065IA?=
 =?us-ascii?Q?QGDBQtCP52Hm7/NFcfS+bPYV8YXaonJf6/wxhMUIGx7xZEZq8jG47jw76Np0?=
 =?us-ascii?Q?lV+Xbt3ACc3dYJk7wYbs6xMal025atICXLk1q3e7tc6W6JBhSgkQ8h0NTdK6?=
 =?us-ascii?Q?c3f1JCer5Sc1Tc0LP0sgPFsu+2k0mz5d54t4btxc5VV9GhrXM28xD1R8vc8V?=
 =?us-ascii?Q?kyOzO/HW5DCaCxgZvmO/qsiZVymt6MKcj1nZxfgq8o/7t5g75+jlm2//z0KQ?=
 =?us-ascii?Q?SCwCEX1xzP+mfiZMEZYf1qTm6f0H78NdKS+37qltBGr0ILJ0t5b23Ojg8IGl?=
 =?us-ascii?Q?37vb/Aywpyu3lmvU+1/A2W4Nv4ADn7tAitwsXI29atep1jARTIpQ6/CnHkRy?=
 =?us-ascii?Q?uDhPVDSdtsOrHD6yZ76gc5BszjC3I/TbpGQOY+ScYbgWty5mczWdngkzEaQr?=
 =?us-ascii?Q?G+B3cLRPiXPuMfPXdobHVVP4PIa8qEOvVKaH+Y5mc5vtqxaOFA79VciYSZmP?=
 =?us-ascii?Q?9WjdjMZ1akaV5xH3WM1m5uMXcFi8HqPY0Tv8Ut+kCDPhGyBjCWsuV1jUoo2z?=
 =?us-ascii?Q?cLLQZ+9TjmjVBKpQgLp4xz03WEP+0BVecDWA2VJ9h8uguEnL+wKOeB0UsNMa?=
 =?us-ascii?Q?PGabdP7fyC6pblDCYYCWWUg/9i9uTFLhaf87OKiSAy7d?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eac9b7c1-c153-473b-7d9b-08dbca80f84a
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 17:39:07.4494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y44YvyJicRxX4989Fx82MRVRea2sNpcn/Q43LyqVHgJevGG9nz1epqiK+sHkvJhOjg55efNVBIFVqU8+cN281w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P193MB1187
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MIME_BASE64_TEXT,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
aXphdGlvbiIpCkNjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnClNpZ25lZC1vZmYtYnk6IExpbm8g
U2FuZmlsaXBwbyA8bC5zYW5maWxpcHBvQGt1bmJ1cy5jb20+Ci0tLQogZHJpdmVycy90dHkvc2Vy
aWFsL3NlcmlhbF9jb3JlLmMgfCA1ICsrKystCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy90dHkvc2VyaWFsL3Nlcmlh
bF9jb3JlLmMgYi9kcml2ZXJzL3R0eS9zZXJpYWwvc2VyaWFsX2NvcmUuYwppbmRleCBmNGZlZWJm
ODIwMGYuLmRjYTA5ODc3ZmFiYyAxMDA2NDQKLS0tIGEvZHJpdmVycy90dHkvc2VyaWFsL3Nlcmlh
bF9jb3JlLmMKKysrIGIvZHJpdmVycy90dHkvc2VyaWFsL3NlcmlhbF9jb3JlLmMKQEAgLTE0MzIs
NiArMTQzMiw5IEBAIHN0YXRpYyBpbnQgdWFydF9nZXRfcnM0ODVfY29uZmlnKHN0cnVjdCB1YXJ0
X3BvcnQgKnBvcnQsCiAJdW5zaWduZWQgbG9uZyBmbGFnczsKIAlzdHJ1Y3Qgc2VyaWFsX3JzNDg1
IGF1eDsKIAorCWlmICghKHBvcnQtPnJzNDg1X3N1cHBvcnRlZC5mbGFncyAmIFNFUl9SUzQ4NV9F
TkFCTEVEKSkKKwkJcmV0dXJuIC1FTk9UVFk7CisKIAlzcGluX2xvY2tfaXJxc2F2ZSgmcG9ydC0+
bG9jaywgZmxhZ3MpOwogCWF1eCA9IHBvcnQtPnJzNDg1OwogCXNwaW5fdW5sb2NrX2lycXJlc3Rv
cmUoJnBvcnQtPmxvY2ssIGZsYWdzKTsKQEAgLTE0NDksNyArMTQ1Miw3IEBAIHN0YXRpYyBpbnQg
dWFydF9zZXRfcnM0ODVfY29uZmlnKHN0cnVjdCB0dHlfc3RydWN0ICp0dHksIHN0cnVjdCB1YXJ0
X3BvcnQgKnBvcnQsCiAJaW50IHJldDsKIAl1bnNpZ25lZCBsb25nIGZsYWdzOwogCi0JaWYgKCFw
b3J0LT5yczQ4NV9jb25maWcpCisJaWYgKCEocG9ydC0+cnM0ODVfc3VwcG9ydGVkLmZsYWdzICYg
U0VSX1JTNDg1X0VOQUJMRUQpKQogCQlyZXR1cm4gLUVOT1RUWTsKIAogCWlmIChjb3B5X2Zyb21f
dXNlcigmcnM0ODUsIHJzNDg1X3VzZXIsIHNpemVvZigqcnM0ODVfdXNlcikpKQotLSAKMi40MC4x
Cgo=
