Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C74ED80B475
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 13:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjLIM7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 07:59:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjLIM7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 07:59:24 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2043.outbound.protection.outlook.com [40.107.7.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3BD41710;
        Sat,  9 Dec 2023 04:59:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ijlLalFUnd58B664TWlflMLEeLslyOH3d3otA/GuOO1LADVYwdJzpK/ThsU+KLCkh3bja++zbnbJOpqej2Bxf2AzJ/8LVBoZGm4RbGHgPl/C7TzUYWGIHH61LkImFxxeaUE+UDEU7cZBL/DqBHV45ASPo0IA6nb+BdHK6KvgdwwWPo/2m6BrTqJBfzRG+GrzvwqGRLllej+1SoC/mIUCg7WjPigjWmTFx7mP/9NbPuzqSX8J6n7dyiugDlB5ozAR+k1f2+voF2prT5Sv384h0+OlIz9mL+YEEU3qgj2zeRXOw2pEa4cYhhXx7ggmodC6VhAlVpJb0HL+4+NuSpOOuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9sRBm8gY2tDiUYzcClFGE54s4heCXu5xxHjSH1pF67Q=;
 b=TugaFAE9ED7qPyWXPcQlfTlWcweypeRjV3wLXu4rj4LImE5CCYxWrRPpFnsbUglVolx1zxQt3C6WtTWA1I4dW6OssYXW0m9kHGTFr3Qs1CZ0k1EfjtHXmcZrwhdN5Hg6A8qSloWufIotdJBKaNDeYE+Hw7/wOaKOdKXt8e4UWW9RBoUh9YNIyzRhLfVFsQIfHSGzhhhUFEELmWunBXzNqlGPt5Em8XgzeHzUHJcqIre9sY9c3QX0fKKOYVVEZinaqxjBv32/uppGOM+EF1cwkep4OoJomBDYZVWnqEIttwEOjqYvyLI7FZURhCKVdo79EiLSSbOuYNAsLy6zd0+XGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9sRBm8gY2tDiUYzcClFGE54s4heCXu5xxHjSH1pF67Q=;
 b=qksT3Z4zN12YlmRmem2YRYEX1joJ5sDCl3xYn5KebEQdLop1ztYk7fCfWeOwFiKuyzBydh8fgkCfOM3bK9Jbq1AX67OyvXwY2Yckp5HAha2y66MsslKj5Q5fIqPtMDAEw4y3WtTuoi0SCeHTwMwd4PQdTqtuEiAWahjhhEoNu1M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by PR3P193MB0555.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:31::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.29; Sat, 9 Dec
 2023 12:59:20 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::653f:d0f3:e7f6:8c06]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::653f:d0f3:e7f6:8c06%5]) with mapi id 15.20.7068.029; Sat, 9 Dec 2023
 12:59:20 +0000
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
Subject: [PATCH v5 6/7] serial: omap: do not override settings for RS485 support
Date:   Sat,  9 Dec 2023 13:58:35 +0100
Message-ID: <20231209125836.16294-7-l.sanfilippo@kunbus.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4b92f7cf-e711-4323-3316-08dbf8b6a8a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uocdsEkqgHqFuSPW9Db0ig8290u2cJsSeIQ8+MdrJlNedicYd4ofc+vS+sHO9w5hlubaXkLiBEIM99yOCkKQbsYBGdesGqoWfZW2J2PCU1GLtpyQAmDeiGKpNV6XyXF1PKsmHqav3+pu3n/wBBhL199VtacrAZ6ofdLPBy7JarejIr55TatDv+Ai29dT311fwGn6XVvyadXwB4+f3mRS7IOml04l+bukE/QaJ9NoiRAJqkor0ofyncXHiC71UvLfGQCpNFsY9MXhyEJk/gCbCk7SbO0iJ/pTqon86oL+L5DRV8C2PZSKjXuyW9Wr1SUnMA2F+jKs4s+pa5CALCrix1YANjm2hwZKasb1vLMl2yL/AYidlKhEQwCE6s4ii3BqsWBBIIFM20Q7n8fPgHjKA50xjEqmzaSLbRGdwUalaAphcCRgnSX0/4+XvBWkshcqIEsvZ3kmoLl+K0WkNOlx6RD23rWMlbnBI0bITK7yBVlljvEL4yNrZBre+v0aW5dCef/TYhdY6usjmn8aK4w+NmpxE17T5ybG37wc8E1JWG1Acv+V7qwWEZyFKMi8Xd/+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(366004)(376002)(396003)(346002)(136003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(2616005)(1076003)(478600001)(6506007)(6666004)(52116002)(6512007)(41300700001)(83380400001)(5660300002)(2906002)(4326008)(8676002)(8936002)(7416002)(6486002)(66946007)(316002)(66476007)(66556008)(38100700002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jBF3AoWOhWizXLv9eydv7WNO1zPuQVG12NhpoN3RyxWyKCH3WraxafTSnOw7?=
 =?us-ascii?Q?D5wz+tKhwCHbDWALIaqCripH0IirovHsRrgW8ZJ+CLElo7u9d7vVvad7qfTn?=
 =?us-ascii?Q?IzmL3+bUtwt/Bg4nAKZRBYcbq/yWzm2Fq6qkTNjmG7j/E5JLfmujdAjBSSPy?=
 =?us-ascii?Q?9yVnYYDMK8qpuApr8HqLA1o77AtzToyZPtoYfeGYBjj7Ox3sTrs8zHzupJYE?=
 =?us-ascii?Q?/BfesAITyc7y0tGsB6zflNyQT8UAdeWAnTZUQyk9il9CKl6kKz4TkwhPlmzZ?=
 =?us-ascii?Q?7OsrTwcO2Enkx9mmCWeMBm3hYRQpGM5QaTDjYt4tyUZTD2oRhu6h6NZi5xF3?=
 =?us-ascii?Q?LULFf1X8GcvLF+RZaWCc18RM7ARLpUVy4RtfEN9Pj4vagXLIkOkUe0T57cAa?=
 =?us-ascii?Q?e7T+/4SzAy602IxhCXG5pPAbh6CQXXZW4J8YHCLHDAmcMXLl+v2uzSpSlIOY?=
 =?us-ascii?Q?C3ZpZ3DweSqfEAnBcEMjbXXAk8zs8pmAtpOdLByYz0ydQX1AoPqHDtfj3sRu?=
 =?us-ascii?Q?CNxoWegPZQCf0mYacLzK6Qsclcv76KX3AW2ihyeK/1S6x1hPEmNwl7AXWGpM?=
 =?us-ascii?Q?J2RZgydempLTSKCdE+e1Klu38DbtvqGBSk4j1yKY6wNMTXJNZFwEjgXabbjk?=
 =?us-ascii?Q?h+dxQ+MSuLp6vR/j4iYebm31rqTtSc/F4apmYLo7gdMz1FxxyP5PWgUJnTlF?=
 =?us-ascii?Q?Ah2aK6J36cBnpnRVEhr5BOxgRL62jLJaFNXjDYNHxL1IbN4gIp3q87zolNVl?=
 =?us-ascii?Q?gMtZmH+mZzHLVIFHDMO0rSjWL5WkP28C1r5W1t34QHBglITTYeW9dzGQ/MGk?=
 =?us-ascii?Q?S4SfsvL3GUpGxISQb6VTuGEst8OPbyKftcCYZSDtpDBp6n1X/Bssmbr+Q9Lc?=
 =?us-ascii?Q?MdOfN08NcmLLz+Xt19dNXgJTw8sFbmbcPCDKyQh72avuWUYYlqfrBg5y202S?=
 =?us-ascii?Q?8Ec5mDEbmdk5hej0C67QuAPRbvm0SQrxG7MK5ENhpx8XLNOMs7TGXmuS+60p?=
 =?us-ascii?Q?i6lk5hpozwpKFHbFF4mI7DM85t/CmxdOyO5DuzuXpeQsNQhxeF5StxxSYSUc?=
 =?us-ascii?Q?zGHTArhCHGHTwYBsMz6y8xM4BJSEB55ktMXKsBFTW6SmQyXbmFY38kYcKEVb?=
 =?us-ascii?Q?2Na/K6YAcHkmLtXpWdrDRnprgDAlGATMtTAoWcr97KTZif+InBNtTITp2z3m?=
 =?us-ascii?Q?ptgdhXKehD6iAFae9KDTuSGDnCjbIEKRzccfebs9JDpDxE4mC4+lBOxb0hoT?=
 =?us-ascii?Q?fdspydvq7kWl/8UJpu98KfE4ShuNbKTG3yEl67U9paah3NmCv/cUZ2zpEv7N?=
 =?us-ascii?Q?omw6LL/IzcOqHA5TRpwat9Sar3nu6FhMhDVKtG5SW1j//LxpSLnwKs/8AldN?=
 =?us-ascii?Q?1uvK9uyPfXAS8PAuV6pDcTS3QxtusaRpQkSZbScguIEWW5G4tWyEO9p0fYgX?=
 =?us-ascii?Q?tv/osyeJzO3QM76T2FdN8eH3ecRLWi2KVz/lipEGlSay2LV9/3CmCgCCbN0g?=
 =?us-ascii?Q?/1nfqJuyDWwJCG/zSA7YyJwoTJKlCvmwbljW9WglvrD3/IuTNEA6W96RF/m9?=
 =?us-ascii?Q?MKBOE5RFiusRPisXMlJCMzIEQDYih+RYpV/8UfOkzQsCDdULCQLc0LudCZ8c?=
 =?us-ascii?Q?tIN/YBySkSo2B9tBBKJtbLCNOvQV/qaT5d8DaiedLzjB?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b92f7cf-e711-4323-3316-08dbf8b6a8a6
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2023 12:59:20.1656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p0C5MMCwIzJn5shFRgodHEu4/CkWsEMAgQyEPFNOdeHMsaKrSzYmgNQwozv/tZsd5d4fmpV7RKHEPUgB2wLvzw==
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

SW4gc2VyaWFsX29tYXBfcnM0ODUoKSBSUzQ4NSBzdXBwb3J0IG1heSBiZSBkZWFjdGl2YXRlZCBk
dWUgdG8gYSBtaXNzaW5nClJUUyBHUElPLiBUaGlzIGlzIGRvbmUgYnkgbnVsbGlmeWluZyB0aGUg
cG9ydHMgcnM0ODVfc3VwcG9ydGVkIHN0cnVjdC4KQWZ0ZXIgdGhhdCBob3dldmVyIHRoZSBzZXJp
YWxfb21hcF9yczQ4NV9zdXBwb3J0ZWQgc3RydWN0IGlzIGFzc2lnbmVkIHRvCnRoZSBzYW1lIHN0
cnVjdHVyZSB1bmNvbmRpdGlvbmFsbHksIHdoaWNoIHJlc3VsdHMgaW4gYW4gdW5pbnRlbmRlZApy
ZWFjdGl2YXRpb24gb2YgUlM0ODUgc3VwcG9ydC4KRml4IHRoaXMgYnkgY2FsbGxpbmcgc2VyaWFs
X29tYXBfcnM0ODUoKSBhZnRlciB0aGUgYXNzaWdubWVudCBvZgpyczQ4NV9zdXBwb3J0ZWQuCgpG
aXhlczogZTI3NTJhZTNjZmM5ICgic2VyaWFsOiBvbWFwOiBEaXNhbGxvdyBSUy00ODUgaWYgcnRz
LWdwaW8gaXMgbm90IHNwZWNpZmllZCIpCkNjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnClNpZ25l
ZC1vZmYtYnk6IExpbm8gU2FuZmlsaXBwbyA8bC5zYW5maWxpcHBvQGt1bmJ1cy5jb20+Ci0tLQog
ZHJpdmVycy90dHkvc2VyaWFsL29tYXAtc2VyaWFsLmMgfCA4ICsrKystLS0tCiAxIGZpbGUgY2hh
bmdlZCwgNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvdHR5L3NlcmlhbC9vbWFwLXNlcmlhbC5jIGIvZHJpdmVycy90dHkvc2VyaWFsL29tYXAtc2Vy
aWFsLmMKaW5kZXggYWQ0YzFjNWQwYTdmLi5kOWIyOTM2MzA4YzQgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvdHR5L3NlcmlhbC9vbWFwLXNlcmlhbC5jCisrKyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9vbWFw
LXNlcmlhbC5jCkBAIC0xNjA0LDEwICsxNjA0LDYgQEAgc3RhdGljIGludCBzZXJpYWxfb21hcF9w
cm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQogCQlkZXZfaW5mbyh1cC0+cG9ydC5k
ZXYsICJubyB3YWtlaXJxIGZvciB1YXJ0JWRcbiIsCiAJCQkgdXAtPnBvcnQubGluZSk7CiAKLQly
ZXQgPSBzZXJpYWxfb21hcF9wcm9iZV9yczQ4NSh1cCwgJnBkZXYtPmRldik7Ci0JaWYgKHJldCA8
IDApCi0JCWdvdG8gZXJyX3JzNDg1OwotCiAJc3ByaW50Zih1cC0+bmFtZSwgIk9NQVAgVUFSVCVk
IiwgdXAtPnBvcnQubGluZSk7CiAJdXAtPnBvcnQubWFwYmFzZSA9IG1lbS0+c3RhcnQ7CiAJdXAt
PnBvcnQubWVtYmFzZSA9IGJhc2U7CkBAIC0xNjIyLDYgKzE2MTgsMTAgQEAgc3RhdGljIGludCBz
ZXJpYWxfb21hcF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQogCQkJIERFRkFV
TFRfQ0xLX1NQRUVEKTsKIAl9CiAKKwlyZXQgPSBzZXJpYWxfb21hcF9wcm9iZV9yczQ4NSh1cCwg
JnBkZXYtPmRldik7CisJaWYgKHJldCA8IDApCisJCWdvdG8gZXJyX3JzNDg1OworCiAJdXAtPmxh
dGVuY3kgPSBQTV9RT1NfQ1BVX0xBVEVOQ1lfREVGQVVMVF9WQUxVRTsKIAl1cC0+Y2FsY19sYXRl
bmN5ID0gUE1fUU9TX0NQVV9MQVRFTkNZX0RFRkFVTFRfVkFMVUU7CiAJY3B1X2xhdGVuY3lfcW9z
X2FkZF9yZXF1ZXN0KCZ1cC0+cG1fcW9zX3JlcXVlc3QsIHVwLT5sYXRlbmN5KTsKLS0gCjIuNDIu
MAoK
