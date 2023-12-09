Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2572F80B46E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 13:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjLIM70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 07:59:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjLIM7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 07:59:18 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2043.outbound.protection.outlook.com [40.107.7.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE7510D0;
        Sat,  9 Dec 2023 04:59:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mnh5tw+jySzm6oFT4sY6kCzsSwiYJaEWmeOrFwWjUBzYVNm4mCD61wL0jJOlSz7TrqMPtHd+oIgq5CdJUEEEtcgREQNzzpjCpLMM3MNJJZlK1C0TiaxR6R9i6u1u4eN6P5JaVI5Eu//lYSlFyuuJWNLvVhcu4QzCkjdoHKXYtAPxiGXiD0rJgsucyT3RvZ9zGIOvR8Pjpm/V9rNQIeOKT9CXaZeJHkjT2bZvVrpeupYHbK+DVmCGgsVrWCyzdxFkWt4r7XtBvOvMx8O17TnDnp1QHC58jNniz0mqUeITr21Py6JKZyo6kZvG9N1e5r6UL1BwBwO2cXXKpgKUdYDxJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rszBlcOxsSoMrEwBQMjDWsnQP5LdeKunsCjYCVGKsZI=;
 b=SDviClzrvRMdpO26oUJc3bmup/5DGryqBtuAm6lpYzXpukr0no+bMhFMprT+FXmdTcG4ZcXORAMCZNCBe2zuCHu8IZ2zRKzYxdhAMZT3A6gNIdEA858BIwXk556pd4ZASyqwUiou6Z8zN0wfRitnzFNrqHzlBFyYgRBw4bz2TbZSx7dzZ9o0lC09bMAc9CD3X+//upmqJE3bSrn0fNB72Fgaf8zcpLJ+Qa63WMYNuq7hEBYxpcHnSwtZkvc+U0rAZS5Qk4DRBHS+sObEkW4CPkmbUaofz/umjyMiZardxzVyBXtOneUqiRDHkQx5D5MMduSc0OGILwpaGxVa4MMj4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rszBlcOxsSoMrEwBQMjDWsnQP5LdeKunsCjYCVGKsZI=;
 b=olbQ3ZIbNIjuMx5WQpe5/PDYoVSYDgZRoX4LDaDQEl+m5WL+sGpG8Y1xpLmEB3eIlNhBf5znH7hajF5y3WR01kndXgMxXBpEhfrpI5T7O7NoMBLkeCBQKRKb66EpZ9WzYvr3fuWGT2A7qwe/7C8K0oDjm/2hJdX0UQlBzCOrv7Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by PR3P193MB0555.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:31::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.29; Sat, 9 Dec
 2023 12:59:18 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::653f:d0f3:e7f6:8c06]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::653f:d0f3:e7f6:8c06%5]) with mapi id 15.20.7068.029; Sat, 9 Dec 2023
 12:59:18 +0000
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
Subject: [PATCH v5 3/7] serial: core: fix sanitizing check for RTS settings
Date:   Sat,  9 Dec 2023 13:58:32 +0100
Message-ID: <20231209125836.16294-4-l.sanfilippo@kunbus.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9d57188b-ef44-495d-a3e8-08dbf8b6a772
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /0okGIZNCuW+G79mn4HXAjBdqq2xw1qZ8WiGyoRN3Mt/0BxSVrxCbOaqd7bwNRNnK12AmEmQNOsljQTqnasGKsf/z+HcIuNRThaCAwYN536MNBYoyp+ZpCE7SWJ+tlvBjv5m1hZYx/2u0ngZdUs+mun8jjfhuo4NuwX9r1Cn8OW5P6VSfJeRexvB6iZ5plhUfTUeEf9hogu/2Dp6RfNPYMyuVTGgDIjamTnmh2toNIOCGQY489dATAweKyerXT/3ZchfV7avHcKisFZUyfoRnqxefpWxXQmoif4TC1JQFKlNvuuT83R21bwL+2QggsWr9QTl3jZQFwkL4AwxtiWqcWj2M9BfvxNJi8GBPahYLdcWv+xzhktUZujmBYng1PiPhxeuApDhbifSgAPzDK85xmJDjTUCKZeh1vpLEo/6bsAKgnGuz+Pkpgo02MqN1eULQduapicXHHFTyc3yAmhaKT8/3JZ3O3HjE+uwiWr0AGq9MSWVBpXg2eyk9gyVRmLqsF/NeuvasjRz0Vwi8ZTkN2ndg61IyuCtctRfu99oaYl380dErnA8wQjsu8KrH1Lc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(366004)(376002)(396003)(346002)(136003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(2616005)(1076003)(478600001)(6506007)(6666004)(52116002)(6512007)(41300700001)(83380400001)(5660300002)(2906002)(4326008)(8676002)(8936002)(7416002)(6486002)(66946007)(316002)(66476007)(66556008)(38100700002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MeJmEEn0eCJa0xvD9sIEdlNiNuUEZAznyl5t80GW/AdKkE2LGeMe5oDJhQyp?=
 =?us-ascii?Q?87jozw4uLR1hV4EMImPPa+aDM41SbJqsPSq2yubtjk16kYIaPlHnu4AJ8TJO?=
 =?us-ascii?Q?Oa+9JsWuODshFXdbKtDzDAFYjc0wHRm5/BR5TTeSJ19s9tUm9B9zYRJ4mQ0g?=
 =?us-ascii?Q?Z00P7VYJ64D6FxX6eDJn9REtRZEAJPF9kb+vkqYp0fKwNq09vw8qirfzzq2R?=
 =?us-ascii?Q?DiDMdlUPXwg6AEUqKWtzLeFpoduDXblKJ2wYnfVL2t89wNteCAQdUHVgu7K9?=
 =?us-ascii?Q?9GwkBdPAWpDB2mR0o+DKeA2+/e1ct2a+FikKBoaSewkmvTr3GEwWD9zrJjx/?=
 =?us-ascii?Q?NRq8lHaXiYMeBfsOp4ZSS+SZl/EkcYGSiNxOEZM6sWM0sENY3GxjE0K3l4rV?=
 =?us-ascii?Q?anoUK9T4P8MYzr6FdkgWKd+RDNV+4y5NxDdxTRdRIIWJERTQ+h2HoYvJoK1B?=
 =?us-ascii?Q?MntvuX70xbf7Ta+Yy0BEylvXF/W+tMXS0n3SPUbUjT0vkB5OE4nRD8Ms2K/0?=
 =?us-ascii?Q?s9UAjG8qozSX+6JK+mNT4WVchc+gDPz/cPvAX3ZqThyCCEd/xB7oU/VHdK2m?=
 =?us-ascii?Q?jrpvWnMPsCezooNpHC0KY2EnQjO/cX3kWj5gN86Vt8RPL/JebZS/Mc40g2Qq?=
 =?us-ascii?Q?Q6fOdytwtektkNfjZJXGB6/z8CC4unYwq1pLZUMQYBdcbxGLCXlV/Bdymgdk?=
 =?us-ascii?Q?iGJl+k+Hcuch5/4Xfr+cKRLKEkSJaHvbSU1Z7rvCKYi15hyHVJqS5kwHUP42?=
 =?us-ascii?Q?eOaZEtO0lxNsV4LI5Za5kMDftYHLOtecdYa+nwBGFHL3vE6cTtgPqlbwYlUu?=
 =?us-ascii?Q?VYXZ5kDObAYw7j8o+bJiWgb3fHmJnWMq+KvfDFBfGsrkDB8D66T1efDTzbao?=
 =?us-ascii?Q?EVPle8wKBLtqFlOKZmwFqXCJwnhUhVN3ncYrga2d5mZKCFNugiqaPCEtv9m4?=
 =?us-ascii?Q?NYp+7EkdngUBA9KEF8zvk7hfWAzPElEVGedKDKGJSPJG7uae0lLm1ZA220+d?=
 =?us-ascii?Q?kA9pzCLPUoPpWQGB9zIDcqVwi7zmDzW53O5JE227TIwDcQ92gd2OilZlr2Ia?=
 =?us-ascii?Q?ktK5B5DTWNHesDBRKPidKN+d8Qu/TYnXpmSgDO/zAzf4ynUO+JUG9JnF+J38?=
 =?us-ascii?Q?7jSQAWKG5IeV651+ojjCfqYRMPazXgkxnDkue4k2hqBoIgeTqqnq+7K4vulr?=
 =?us-ascii?Q?/ayjjyfzwxSuYkXISZ9tXr0lzcA0xrW9IiOe3rCFDgCHD6Ei79hWtkcedyfW?=
 =?us-ascii?Q?q83N76MwI/e4HSc0Md+NpAtEJLHs+blsE96R5vLWscHy9QvcGci4qRedTcmJ?=
 =?us-ascii?Q?3CFyiaJYgeaS4A+H+vFq9hOVYwrElO9rBm9jU4Fe4HXFaDuAiyir+sTTfHo7?=
 =?us-ascii?Q?9R06wbA2o8uwElqdB6eqK477ah2/vS2xRav8h5oOeQFCRVZu/U/qIHmvNV24?=
 =?us-ascii?Q?tjc/hOA7uVCWw3P/Ni8UHuK1d6UA+zR4Vv90SLCKabX5qYcmltl2rwmfJQMH?=
 =?us-ascii?Q?w/brm3KAHBLm0bhEqiD153Xkrd+wDlOmAc3GXMiEFhJ8CJiRhZ5806VIHVfq?=
 =?us-ascii?Q?ZvS0T/Ilmv7YgY8Wmajx9I7NbjC8hEgowIfjw8Fwooni5ps6Wqrixn5Ejr/t?=
 =?us-ascii?Q?jFSjsGeJtvc11FFjX3n4bJPTMsJuBFSyX72Awyxq8+ip?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d57188b-ef44-495d-a3e8-08dbf8b6a772
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2023 12:59:18.1827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b7KnC4AAlMfVdYOXFMkvkC0b6q/1xncjkXubvUbluJ8UlfB5UjNLAu6z+WsZdOw6bLmMh3X9EipzSH5x8updEg==
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

QW1vbmcgb3RoZXIgdGhpbmdzIHVhcnRfc2FuaXRpemVfc2VyaWFsX3JzNDg1KCkgdGVzdHMgdGhl
IHNhbml0eSBvZiB0aGUgUlRTCnNldHRpbmdzIGluIGEgUlM0ODUgY29uZmlndXJhdGlvbiB0aGF0
IGhhcyBiZWVuIHBhc3NlZCBieSB1c2Vyc3BhY2UuCklmIFJUUy1vbi1zZW5kIGFuZCBSVFMtYWZ0
ZXItc2VuZCBhcmUgYm90aCBzZXQgb3IgdW5zZXQgdGhlIGNvbmZpZ3VyYXRpb24KaXMgYWRqdXN0
ZWQgYW5kIFJUUy1hZnRlci1zZW5kIGlzIGRpc2FibGVkIGFuZCBSVFMtb24tc2VuZCBlbmFibGVk
LgoKVGhpcyBob3dldmVyIG1ha2VzIG9ubHkgc2Vuc2UgaWYgYm90aCBSVFMgbW9kZXMgYXJlIGFj
dHVhbGx5IHN1cHBvcnRlZCBieQp0aGUgZHJpdmVyLgoKV2l0aCBjb21taXQgYmUyZTJjYjFkMjgx
ICgic2VyaWFsOiBTYW5pdGl6ZSByczQ4NV9zdHJ1Y3QiKSB0aGUgY29kZSBkb2VzCnRha2UgdGhl
IGRyaXZlciBzdXBwb3J0IGludG8gYWNjb3VudCBidXQgb25seSBjaGVja3MgaWYgb25lIG9mIGJv
dGggUlRTCm1vZGVzIGFyZSBzdXBwb3J0ZWQuIFRoaXMgbWF5IGxlYWQgdG8gdGhlIGVycm9ybmVv
dXMgcmVzdWx0IG9mIFJUUy1vbi1zZW5kCmJlaW5nIHNldCBldmVuIGlmIG9ubHkgUlRTLWFmdGVy
LXNlbmQgaXMgc3VwcG9ydGVkLgoKRml4IHRoaXMgYnkgY2hhbmdpbmcgdGhlIGltcGxlbWVudGVk
IGxvZ2ljOiBGaXJzdCBjbGVhciBhbGwgdW5zdXBwb3J0ZWQKZmxhZ3MgaW4gdGhlIFJTNDg1IGNv
bmZpZ3VyYXRpb24sIHRoZW4gYWRqdXN0IGFuIGludmFsaWQgUlRTIHNldHRpbmcgYnkKdGFraW5n
IGludG8gYWNjb3VudCB3aGljaCBSVFMgbW9kZSBpcyBzdXBwb3J0ZWQuCgpDYzogc3RhYmxlQHZn
ZXIua2VybmVsLm9yZwpGaXhlczogYmUyZTJjYjFkMjgxICgic2VyaWFsOiBTYW5pdGl6ZSByczQ4
NV9zdHJ1Y3QiKQpTaWduZWQtb2ZmLWJ5OiBMaW5vIFNhbmZpbGlwcG8gPGwuc2FuZmlsaXBwb0Br
dW5idXMuY29tPgotLS0KIGRyaXZlcnMvdHR5L3NlcmlhbC9zZXJpYWxfY29yZS5jIHwgMjggKysr
KysrKysrKysrKysrKysrLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDE4IGluc2VydGlvbnMo
KyksIDEwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvdHR5L3NlcmlhbC9zZXJp
YWxfY29yZS5jIGIvZHJpdmVycy90dHkvc2VyaWFsL3NlcmlhbF9jb3JlLmMKaW5kZXggYzI1NGU4
OGM4NDUyLi40ZWFlMTQwNmNiNmMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdHR5L3NlcmlhbC9zZXJp
YWxfY29yZS5jCisrKyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9zZXJpYWxfY29yZS5jCkBAIC0xMzcx
LDE5ICsxMzcxLDI3IEBAIHN0YXRpYyB2b2lkIHVhcnRfc2FuaXRpemVfc2VyaWFsX3JzNDg1KHN0
cnVjdCB1YXJ0X3BvcnQgKnBvcnQsIHN0cnVjdCBzZXJpYWxfcnM0CiAJCXJldHVybjsKIAl9CiAK
KwlyczQ4NS0+ZmxhZ3MgJj0gc3VwcG9ydGVkX2ZsYWdzOworCiAJLyogUGljayBzYW5lIHNldHRp
bmdzIGlmIHRoZSB1c2VyIGhhc24ndCAqLwotCWlmICgoc3VwcG9ydGVkX2ZsYWdzICYgKFNFUl9S
UzQ4NV9SVFNfT05fU0VORHxTRVJfUlM0ODVfUlRTX0FGVEVSX1NFTkQpKSAmJgotCSAgICAhKHJz
NDg1LT5mbGFncyAmIFNFUl9SUzQ4NV9SVFNfT05fU0VORCkgPT0KKwlpZiAoIShyczQ4NS0+Zmxh
Z3MgJiBTRVJfUlM0ODVfUlRTX09OX1NFTkQpID09CiAJICAgICEocnM0ODUtPmZsYWdzICYgU0VS
X1JTNDg1X1JUU19BRlRFUl9TRU5EKSkgewotCQlkZXZfd2Fybl9yYXRlbGltaXRlZChwb3J0LT5k
ZXYsCi0JCQkiJXMgKCVkKTogaW52YWxpZCBSVFMgc2V0dGluZywgdXNpbmcgUlRTX09OX1NFTkQg
aW5zdGVhZFxuIiwKLQkJCXBvcnQtPm5hbWUsIHBvcnQtPmxpbmUpOwotCQlyczQ4NS0+ZmxhZ3Mg
fD0gU0VSX1JTNDg1X1JUU19PTl9TRU5EOwotCQlyczQ4NS0+ZmxhZ3MgJj0gflNFUl9SUzQ4NV9S
VFNfQUZURVJfU0VORDsKLQkJc3VwcG9ydGVkX2ZsYWdzIHw9IFNFUl9SUzQ4NV9SVFNfT05fU0VO
RHxTRVJfUlM0ODVfUlRTX0FGVEVSX1NFTkQ7Ci0JfQorCQlpZiAoc3VwcG9ydGVkX2ZsYWdzICYg
U0VSX1JTNDg1X1JUU19PTl9TRU5EKSB7CisJCQlyczQ4NS0+ZmxhZ3MgfD0gU0VSX1JTNDg1X1JU
U19PTl9TRU5EOworCQkJcnM0ODUtPmZsYWdzICY9IH5TRVJfUlM0ODVfUlRTX0FGVEVSX1NFTkQ7
CiAKLQlyczQ4NS0+ZmxhZ3MgJj0gc3VwcG9ydGVkX2ZsYWdzOworCQkJZGV2X3dhcm5fcmF0ZWxp
bWl0ZWQocG9ydC0+ZGV2LAorCQkJCSIlcyAoJWQpOiBpbnZhbGlkIFJUUyBzZXR0aW5nLCB1c2lu
ZyBSVFNfT05fU0VORCBpbnN0ZWFkXG4iLAorCQkJCXBvcnQtPm5hbWUsIHBvcnQtPmxpbmUpOwor
CQl9IGVsc2UgeworCQkJcnM0ODUtPmZsYWdzIHw9IFNFUl9SUzQ4NV9SVFNfQUZURVJfU0VORDsK
KwkJCXJzNDg1LT5mbGFncyAmPSB+U0VSX1JTNDg1X1JUU19PTl9TRU5EOworCisJCQlkZXZfd2Fy
bl9yYXRlbGltaXRlZChwb3J0LT5kZXYsCisJCQkJIiVzICglZCk6IGludmFsaWQgUlRTIHNldHRp
bmcsIHVzaW5nIFJUU19BRlRFUl9TRU5EIGluc3RlYWRcbiIsCisJCQkJcG9ydC0+bmFtZSwgcG9y
dC0+bGluZSk7CisJCX0KKwl9CiAKIAl1YXJ0X3Nhbml0aXplX3NlcmlhbF9yczQ4NV9kZWxheXMo
cG9ydCwgcnM0ODUpOwogCi0tIAoyLjQyLjAKCg==
