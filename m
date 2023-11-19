Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723D97F05F3
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 12:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbjKSLdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 06:33:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbjKSLcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 06:32:43 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2065.outbound.protection.outlook.com [40.107.104.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9C71719;
        Sun, 19 Nov 2023 03:30:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kyVTx+9nf+1YNu4UDyoB3DuwM4uZYmtdbvV2F3+w+v7+JP9S302a9Jf5K3oTCAQkSLrCjbc9SmPRY8MfIr9Zm3lw/SEoy5kV+rgq17QnvviTUGqMRl8hRfE8z3JXoET96Pb0ZEKE2hWrVTTuAOBI8htD+F8OLws/jzhmZJQjuxScNi6HLun3pDBQF8sKyoTjpm91Mcl0ZqEdwMmYhG2ax51LiQOPmLLqm8oAf2IN2SLTmML97nGTtbFY8wYQn88gWOX8gTRdE7jWc1btu7geYSjX7UA8bFdymhiarTWQx2Bdm31tHtiCz/DldwcoMrsCs/fyDS8f0bZTguQU9WLUOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q4z698JLUkkru96cdedTpremk0cvUbZVueJtn/hJiUU=;
 b=YhyjFFbqyLxAIVodcTCTBxs20OtFqsmBQXcBXpObk6jGg6ZvqWbOK+mJRiXD2icdq98ae/I3iSWYMUFvA0XeihwUTKRH8mllEApUB8WGoJ5uS78JpR7DH4IK7u6yCHe5Kg5IHCh1Lpx9Y0oLY+0AVnrNZR0vyO3GDe3YkjdQlvp1x+i22bzarcJE0PpLA07SGhe5CAvwPz0c6P6R9l7/0QsuG7Zsk4Ddw0fNMwx3f+jGQBHZo2dvSVZ4vNY/rpQbfdCHlgy0PKuk6IbPTFOkTPIwa7LvQX+Np+w2F5Q8E4DTe2vW+5gQipmfWn8aZ4MFCYLQmOTZES8gJQemoJEOaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q4z698JLUkkru96cdedTpremk0cvUbZVueJtn/hJiUU=;
 b=TrEINb/E6SkAAVfvMuGjiUF0lHEtv0uUHJskmVk0haC+N0Q+bhr1CRA3UHj1nVdp4wbV78n/jSLp0/hjfl/r8RR14S61/lwkRnQ+buDL/RxVCozejmvy5AYBz8rh3WiPVPVn5HMnVO041CoES4MqXQzXuj1jyQSpqCl3Yv5KOrc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by AM8P193MB1060.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:1e5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Sun, 19 Nov
 2023 11:30:00 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::653f:d0f3:e7f6:8c06]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::653f:d0f3:e7f6:8c06%5]) with mapi id 15.20.7002.025; Sun, 19 Nov 2023
 11:30:00 +0000
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
Subject: [RESEND PATCH v4 2/7] serial: core: set missing supported flag for RX during TX GPIO
Date:   Sun, 19 Nov 2023 12:28:50 +0100
Message-ID: <20231119112856.11587-3-l.sanfilippo@kunbus.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231119112856.11587-1-l.sanfilippo@kunbus.com>
References: <20231119112856.11587-1-l.sanfilippo@kunbus.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain
X-ClientProxiedBy: FR5P281CA0007.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::17) To VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:803:4e::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0413:EE_|AM8P193MB1060:EE_
X-MS-Office365-Filtering-Correlation-Id: 50846c25-e5c3-4f5f-0e96-08dbe8f2dd84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1wU9hM38ah+qre32fsIhck9T+JgRUsfDwGKBAGGTvxJkiBdu4ziKcq/9DkObNfUyHyWbtznSjaDPTgnI5Ug9K/GN2DOx5vWyCVquXFVJkOPO1WMojYMMtbL7ntgpL4PDUqySMfd8jAZc1jVvNyBLqZ3JRRD+M/qTB4npJpXmMpP4tcJhvCqJ8/z6/kon4950XAuAZ/DDtEfARfEmeOkkzaEOeG3X2ZWZRqZ5VzZ9GnpTSgrLUJoGMp9TF5dO2nmOh98N9S+P1sm9qiNQo3wLPHWGKCLMhebwJRvBTzPXB17FoAVoGGx+f7IP5jiJ6PzqHoaL9/X74iRoS26ilNzrE7UJIWeHdpTNqB3z5TY9dWEWrERtyyMyrziU4x5VRQMXZFonrFRpgOU/pg7TtJQsODxD7r3vycLfFjoflzPBU5NlgzvmovtEm1niPhzDmu23mHjIg+8nRS+EEeVN0T2wxcdZdpe3EEMY+1FhqEhkYcC5rWwpePqyyIwRTu/PaMavKqaLr1pFanHpbxaJxKrH4k5VH3Xp8HK0GPoYbrDCAn82tcL/IL5NhrVNi3E/Br6v
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(366004)(39830400003)(376002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(6506007)(6512007)(52116002)(66946007)(66556008)(316002)(4326008)(8676002)(8936002)(66476007)(6486002)(478600001)(1076003)(2616005)(38100700002)(6666004)(5660300002)(7416002)(2906002)(86362001)(41300700001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vFkRnIgn+NoC3iA19inS+7TqhV8FQnsMhv6+HkegsjnqLBCefLVF+z/uLy8d?=
 =?us-ascii?Q?G5My6xN7qDkuRDZuGbZ26Ffw9BECWd+ys7+Kn24GzmbOBg8fTlx263WK0/cI?=
 =?us-ascii?Q?rBYqacqBCQMIi0V3MTZywrVl+qpV6Zgu8zN0GkzAk68x3K0/CUjw+joGtgkg?=
 =?us-ascii?Q?jSwPiI4U68vXNMew7ib8/yMJq9+bit91KkNtPs5uhKxpVqTIFXd1SAbaLytK?=
 =?us-ascii?Q?6Y5zgnQeMauiAAIHswQzn/Hl0QCK1sIaaMsINzrSZzyJsgZDrLgixq8YUw5B?=
 =?us-ascii?Q?gQfxNSBmsi4o5/iA6Vrh6Bg+ZENMdkbwm6MUFp0EOn2Urt1iDcQW+7Obk+nY?=
 =?us-ascii?Q?6d3lxuN13+8y/DxpJKH5l2zwdCWgLoaeCOGiMBg2DAjfQTEG8Oj+JapGpyKk?=
 =?us-ascii?Q?U90amiVR6QrnfHbFf7pOzh5EW0WTXJzwU4t2JxIAGG1ds8CkZjoTzd0dQRaR?=
 =?us-ascii?Q?vV8zKJMXMbtcGuVnBhrtWBG11Anmpvy1itS+awxu9QrrluCATRfXk9UPJB3I?=
 =?us-ascii?Q?04bi7iQmD8etYTF1Nr+4Cumu8CB6+tpDDuMWYoAVX9UNfo+HkS1nnYvxTtTD?=
 =?us-ascii?Q?JwPuwLT8FYCkvkmlq6VnKtxBNt+VrlPrLl1SdfvUxbyUnsVB2FD6lD+Hl4Rs?=
 =?us-ascii?Q?RBxSOoTHg+quqININkE2HYI+ysosLZQDWzTsw6wOA++lQ7lBS8VZvz6Io+T5?=
 =?us-ascii?Q?HFIUC2NP0ZAbG86LyKM34tRQB5O5j01j+4BYvua0t4gPwDwA1teEdB2f/VV8?=
 =?us-ascii?Q?TGdBeYsgXIITcJo0KcmKRnanHsIkKdQwkARk2zQKZhkC2g5KrLdJAobfOzhN?=
 =?us-ascii?Q?nZiQwUgl0rKdVcNYgOuSqyPWl222x/sAQjvIIRHTuqu4rSiZsj1hjl6Uykct?=
 =?us-ascii?Q?XOHdXVbA5kEyajfeG538DVQ75FZ9Cv+YSsrhZnit+kwRl5v72ENos4XVaHTo?=
 =?us-ascii?Q?GP6IRE+JlDgY3nj7IgVjycOxR7wgbZq2z0iMDsTjFAi57vvOgsddl/bEI4nb?=
 =?us-ascii?Q?4I5mj2T/rpI6SdnU4IEILRjf5w9Eb2w3ien5vQQ12hWa2ZR25+TLyeUA9J3k?=
 =?us-ascii?Q?U1DvGIHsswO5NMiVK94xSReQfvfh0IT3ed2DNRTCBhgfsaMl5nTlj9ZeEGbh?=
 =?us-ascii?Q?YhU1XU8/wGOvcgGhooxCZ7NbX8dznMlK2nPeVedVZlciEwCf29f7PrsJhrg1?=
 =?us-ascii?Q?3x1rUv+HjL1b0uOCAEQT+fObw0RFjj+VSbJXvFkPRjt0otSZ1XN017938x5p?=
 =?us-ascii?Q?f9mt4mHTrrY3CaaAfNR/1NRL+/EuSiDmL5t7ig1/KMyqkH1c9RYvYp7Dej0l?=
 =?us-ascii?Q?28XXiC1RKav+QDYKsgSoCuK7fSlvvu7i6OsngSo3xF51C3M5LfcMGHXqwVMb?=
 =?us-ascii?Q?Ey6MQ2Z08BJ6Heb7thwxx6xE6GaH5M5A/+Cqb3rzIPowpQjmxnl7eLb+u6Fi?=
 =?us-ascii?Q?0azbbNhhqwaNWN7CeC8Yt8k0SjQMTsQWKb1ThNyEwavAx05fbXDafbLyyxGR?=
 =?us-ascii?Q?XOxOTVQ+V75alO5fUYlOtLQ6k5ZDemUkIQN/WDRSBn3GwW21RbuW7Mn5utA+?=
 =?us-ascii?Q?hMFAeuK73Uk8Y7aHEIVgteN/egLox1qXk7sNmwfqAkwDVXpoTGEB3ZqiweaW?=
 =?us-ascii?Q?qK8fU2toW3FL+/rDkpvBxHC3gU2uYYAqWdw9Tr4vj9pD?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50846c25-e5c3-4f5f-0e96-08dbe8f2dd84
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2023 11:30:00.0566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s2SJzB5xe3T+JWxFOwCI8xuJTUKWzCTA3KSFbN7RYB6noY3/5Nh924EPgc2H+ZWk/R49uetOrpWTlIJuVbNAew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P193MB1060
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MIME_BASE64_TEXT,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SWYgdGhlIFJTNDg1IGZlYXR1cmUgUlgtZHVyaW5nLVRYIGlzIHN1cHBvcnRlZCBieSBtZWFucyBv
ZiBhIEdQSU8gc2V0IHRoZQphY2NvcmRpbmcgc3VwcG9ydGVkIGZsYWcuIE90aGVyd2lzZSBzZXR0
aW5nIHRoaXMgZmVhdHVyZSBmcm9tIHVzZXJzcGFjZSBtYXkKbm90IGJlIHBvc3NpYmxlLCBzaW5j
ZSBpbiB1YXJ0X3Nhbml0aXplX3NlcmlhbF9yczQ4NSgpIHRoZSBwYXNzZWQgUlM0ODUKY29uZmln
dXJhdGlvbiBpcyBtYXRjaGVkIGFnYWluc3QgdGhlIHN1cHBvcnRlZCBmZWF0dXJlcyBhbmQgdW5z
dXBwb3J0ZWQKc2V0dGluZ3MgYXJlIHRoZXJlYnkgcmVtb3ZlZCBhbmQgdGh1cyB0YWtlIG5vIGVm
ZmVjdC4KCkNjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnCkZpeGVzOiAxNjNmMDgwZWI3MTcgKCJz
ZXJpYWw6IGNvcmU6IEFkZCBvcHRpb24gdG8gb3V0cHV0IFJTNDg1IFJYX0RVUklOR19UWCBzdGF0
ZSB2aWEgR1BJTyIpClNpZ25lZC1vZmYtYnk6IExpbm8gU2FuZmlsaXBwbyA8bC5zYW5maWxpcHBv
QGt1bmJ1cy5jb20+Ci0tLQogZHJpdmVycy90dHkvc2VyaWFsL3NlcmlhbF9jb3JlLmMgfCAyICsr
CiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy90
dHkvc2VyaWFsL3NlcmlhbF9jb3JlLmMgYi9kcml2ZXJzL3R0eS9zZXJpYWwvc2VyaWFsX2NvcmUu
YwppbmRleCBhYjc2NmY0OGMxNzIuLmFmMTc1YzgwM2MyMiAxMDA2NDQKLS0tIGEvZHJpdmVycy90
dHkvc2VyaWFsL3NlcmlhbF9jb3JlLmMKKysrIGIvZHJpdmVycy90dHkvc2VyaWFsL3NlcmlhbF9j
b3JlLmMKQEAgLTM2MjcsNiArMzYyNyw4IEBAIGludCB1YXJ0X2dldF9yczQ4NV9tb2RlKHN0cnVj
dCB1YXJ0X3BvcnQgKnBvcnQpCiAJaWYgKElTX0VSUihkZXNjKSkKIAkJcmV0dXJuIGRldl9lcnJf
cHJvYmUoZGV2LCBQVFJfRVJSKGRlc2MpLCAiQ2Fubm90IGdldCByczQ4NS1yeC1kdXJpbmctdHgt
Z3Bpb3NcbiIpOwogCXBvcnQtPnJzNDg1X3J4X2R1cmluZ190eF9ncGlvID0gZGVzYzsKKwlpZiAo
cG9ydC0+cnM0ODVfcnhfZHVyaW5nX3R4X2dwaW8pCisJCXBvcnQtPnJzNDg1X3N1cHBvcnRlZC5m
bGFncyB8PSBTRVJfUlM0ODVfUlhfRFVSSU5HX1RYOwogCiAJcmV0dXJuIDA7CiB9Ci0tIAoyLjQy
LjAKCg==
