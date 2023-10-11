Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2B97C5B16
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 20:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235152AbjJKSQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 14:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235132AbjJKSQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 14:16:18 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2048.outbound.protection.outlook.com [40.107.22.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DCDCCC;
        Wed, 11 Oct 2023 11:16:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SlTzpTC8AATVaJOegdOeFwuXchrUbHiyLGrrrwd/l/bqrccBIckkXFfg1Oz3CuoGz7UOBc32dfnkEKhSikMsF3UtwRmySfrsfxAJo25FcwXvc8lFM26LmAr5r7Xa1T6zEkQf86kw64ChWnAEazMulgUWprUKzl0F1wQwwEtcOm9m9mFVF0E2IZmMPsRqOvXq3nzHgxZnvZPDvoDo64RBfyKHV9st5ZObMIhZh3dv+YHY1mLd61wmRpq66yPeeUsZ+KnGFt3GlmRdh3wf5Q/xSLBta3KBKLRyw4/iw9ePJ5J4c10G6Up+snRDelHoFxFCQN+EprrW7vbSr8aqg+9spQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TJ5/eJP8FSTSE85vf+YgYI2YYEXaQjMZKL7yA99JX58=;
 b=NBLgAoDMSmCfBpfit9+AEkAJ/JXtK0R5RUhjM+dpUk1x3dcH5xZKkUiYRC7XzuIuVuF596d3E79yhWaJeUPGRTKdqudlZnkDZvULWxvHYVaOzNiW6hBp3mWj8qPmpy6OuFKPXYp4TmdCfn1yeclOsoGMPS7meZHsbEng4URRo5fKFZIw1RvjrJCx7Nscd/AR1EUO9sSSnm8fJVOfayPBYS43stVtKEcT3iJLBgWXe3J3EZG4JyH0L14CMo1bMuPi/YIXPLliIw7xVmeWBBTQyz097wSD3qqr7eHeQ9z0iTwzJJIy8QG2e+SSVgEQrYJ80Iuc5+8YkP3LCFjUbYa/Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJ5/eJP8FSTSE85vf+YgYI2YYEXaQjMZKL7yA99JX58=;
 b=fll4aLeTaiE1OqtZpWYA3II6GUfQ/V1RKc+rTzBXsSPcY45IlJ9vVK5pkygAzp7EZj5ODn6ClYTHi52sTO8gAOC5CvVB5EFB9HfpvlrJ4EChDUyGijBHzVIwPHwG3SYGhntwRedmr7lUxTRPiKD/l2orRl5PKrSoEIaIhIR37vs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by AS8P193MB1925.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:3fa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Wed, 11 Oct
 2023 18:16:12 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::550d:2425:c0ed:3e59]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::550d:2425:c0ed:3e59%3]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 18:16:12 +0000
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
Subject: [PATCH v3 4/6] serial: core: make sure RS485 cannot be enabled when it is not supported
Date:   Wed, 11 Oct 2023 20:15:42 +0200
Message-Id: <20231011181544.7893-5-l.sanfilippo@kunbus.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231011181544.7893-1-l.sanfilippo@kunbus.com>
References: <20231011181544.7893-1-l.sanfilippo@kunbus.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0163.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::9) To VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:803:4e::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0413:EE_|AS8P193MB1925:EE_
X-MS-Office365-Filtering-Correlation-Id: f4a7bee1-354d-414b-8db6-08dbca862677
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1JXLIC83BsW85iEufFa2RRHTVcjnmYU8mMIQn6OAa94EOBOeK9vXa++pjVA11e6zrIGD7lvSGD4rBtmXDDE0aO8PyuAI5XoOs1eNlbI1WSnt2VwSNukQLnaQyi9KFRkp7qncwIQO1tnz84naTj04CSgrQ08MG8eJSokOHCCMhIzVBEoGrGImylrlMaiq/ZEraNJRxXlYRM6zaxZVwuxjaegpphURRy1b76htfv/i1N+45fqs9iHkkZik49mUfVwHh5+RFlS8B7T9vYOknjV2tx7VPQQE19qW5Kil/NrpzFeZBeJIXPP9g8DoM9QnkO/yykSCLmF44JIaYOD3RGlBQYmfCcZTxery/Upjq8fy5GUCArlRkBO7TvT1/QDnWSW98eeEt2VXr6jz/I71zAd6Ua1NVlBfsl/TtncOnyfrk8mo0z+IlZxfa/AOq1028NPYFxrLrJpM2Iqb9n9T6w51Zj7YhiXPVmCjhMWguOYo1h5vFmm8Qi6WeYB0wCTjcJPqJtNFPNRWteWd6wd5/qHQbeAkB0UaBlJY/vV9upgGifGXbXhuSWsA5ZIZrerep7Q+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(39840400004)(396003)(346002)(376002)(136003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(36756003)(6666004)(52116002)(83380400001)(6506007)(6486002)(6512007)(1076003)(2616005)(4326008)(41300700001)(2906002)(478600001)(8676002)(8936002)(5660300002)(7416002)(66556008)(316002)(66946007)(66476007)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7BRi2tYxfBa5bDJU+ZHMrI/poYhAUMY5Q/Da3aeM45p+hFBUgL9opQiqFZwV?=
 =?us-ascii?Q?/NGlaus7B2MggFO4VTvVWa7Pzf0Zqk85IsUs5/vOZ9f2dwjYrNq3q1fn+GsS?=
 =?us-ascii?Q?Cfrns/51YUrv/fACjCFKo+9VgS2iXTrSOw3kJvjtbkCh0pKfdzesUt95Cbvs?=
 =?us-ascii?Q?pAtcUVVkwQqsA/uXvowqJo0ewEMqnXeX1U1IDgqKC1X2Vod6u/GKbWVjIrbc?=
 =?us-ascii?Q?PvP8H0+CzjkjQArF4o2SLLLCrfyoGUd6WI5jzusUsAmKXC4UeFXpjTPxkRP8?=
 =?us-ascii?Q?UV+VXeUt2NwG6m/0UNeLwzoYjLnFblVPJ1MPgykSRW4jK5VzJE6Skiu9KaGD?=
 =?us-ascii?Q?Opk0v6jBFLoJ/Yif5XLU1Jjop3LAr2BbtkQRKal6jKACPW+XyJrUpp+fRsNH?=
 =?us-ascii?Q?1/gtGoMRSp4mTd9roEpaboDOU+CjPjoF6VSWZGx8rwhxqwZwJcU5MJP1nLEG?=
 =?us-ascii?Q?LGONfCTb2nTbR6KrwaC7RKLJ4oHmMcrnmYsI76OotBVqklpPL3gTp+yd2jCQ?=
 =?us-ascii?Q?myL2prndyKoAdsc/Hm7Hdfq7SdHvScYXNs7c5xXh77jTwAM0UhxHHJd7+fUo?=
 =?us-ascii?Q?JehQCOnHdyn4z59tHQG/M33cbMckS/f6zjRrVBchE7gkoR/AcNSUnbGTfwr3?=
 =?us-ascii?Q?MojyIbuvD+Q76lTAYXxGZiWP7IGP76G7PTngoNJ7xyGev1IvQ/FDyvLg9/Hj?=
 =?us-ascii?Q?QgUI0Zgxspt+pnrmomaMc0jg37PDwkFajCTry0gAq3hPDdEnP7S39LZhCs8q?=
 =?us-ascii?Q?P2NAIGHhwyoEhmBbfBw4RBlrTAkvk8Blt+VtIT7SfN+9vcNfy6lTeI0HIOA0?=
 =?us-ascii?Q?0ekUaS7QbGEYO9XH648+VhOOWD2Rt5ltmKU/uMyI1lv3mYPaW7UyFt47gKDg?=
 =?us-ascii?Q?C0X5vn8Dho7itlJtZIt7cfhkDJ4defVibLARzi7HcnJrffZciRxvTMHbDIgA?=
 =?us-ascii?Q?vO4S0OVudQv2E2A/S04+7yz5FZsTTSPk72jGkvKDxuvtKHRaCiCzVJa2EBmV?=
 =?us-ascii?Q?Kd5+lHJMsT8HdpmZ9lxKCS2zPBZoQscVUm0v1q/Q/Ux6V4OFH7wvQSL/lnLI?=
 =?us-ascii?Q?bH49BWxCFtEK/SrlvtqDDAE9HLOm9Uik8GzxpYysEJrpyMAvkiq7Yfimtnra?=
 =?us-ascii?Q?oGeHyj8XJWuebDeSEEO6i48fmeM3KhN77VmDmqeE2j7UfQWPXULg0GqnJNkT?=
 =?us-ascii?Q?iVm1GhAGu5+QDuZj47+faILZ3kf6Ao0wab1FVg/WfcNoFSb3ynz1bf7PbFHi?=
 =?us-ascii?Q?LPKxAnGA/gHmFN0NvDYlrPFGm7kyJFIlqLCn7y3uyoUpBIRUlCOr/PZNznKc?=
 =?us-ascii?Q?UPFIOJ1nBR137gtX5Ve64+4oh98udYUcxzxpo292+zt2obY5ttpy8BTCdewp?=
 =?us-ascii?Q?1KaJaedL82kJgs6s9LZaUH3T7IcTgXjwyKhKclYCwGxSwM2/aD8LRRH0eaDf?=
 =?us-ascii?Q?fAQDkWBFn/uc2tBuFPysWwaUlohbkidsZYCjCCqBL67yR7wE+Rkrydb2nBxV?=
 =?us-ascii?Q?wQtCBjEHXJHfjZoVn6+dOHeXTXkJNJ6fXi0Fcmguc9oCv5w/k0dFQNPFj+gw?=
 =?us-ascii?Q?zCqgV4dqXjYOAGN1D5dZ2S6dQx78V5TJxWI4L6RMMfixd7n5JZ/Tf5IWq5BB?=
 =?us-ascii?Q?Te2JL2i+VJmvLp3ZETp6HmpBOoQEG1L8vqjWiEIY9jEI?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4a7bee1-354d-414b-8db6-08dbca862677
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 18:16:12.3864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WE7OCKWKnzBs4RaaoKuG7ICatYY7wgRS7+ZweWkilPi32dvZOLaePMycwh3ECbz5oyg/wtfGTSmjeGHL0YJX6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P193MB1925
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MIME_BASE64_TEXT,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
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
