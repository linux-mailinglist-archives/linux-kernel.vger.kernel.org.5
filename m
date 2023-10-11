Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7797C5A60
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 19:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345033AbjJKRjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 13:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233207AbjJKRj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 13:39:26 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2088.outbound.protection.outlook.com [40.107.249.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125EEDA;
        Wed, 11 Oct 2023 10:39:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aaeNd8w7b/VaFp07oj7NVehXLCwApFzAWz2mF0f5sAiCJvMWyqR1yXBgick8lvQFf9YNnsoBynXnenZAk5WgC/znJ+rJD17hSuNP0NYF2CDWoykSbE7CV7+VNg4mvNMr8HMzdkB++zcpHHQ9QBjSmDDiE0B/lt6adAYqHlFBSac11xHhpOHebVi17EJZIg41j51p9aYtmf/LLbZ2W6m/gHVLpOKTF4QfTdC3XC0CHMM90Czs0CJ2JOZ9E2YnwKoyV+t9PdPmENEOh+Wo0WVGzkCp+TzHGsdG25QjxQzmIT3EsjnxT397QvLbRJoXROLPVTWBbVekzSpvT1ybwUEU5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7/vH9Q9jKs2GzlPx8DEoi1T0SBAlJ5DZXJzhZrsbsp4=;
 b=MNCAcbQyL53gUiPvy1ONeCfRogQZ7UKe/s+wSBGImS7MMJcwerLSgRgz/rS0S2AJL6qN0RPP8ydqaxpiQrv9qThH5r1wj6JSDgaytxZXDkexT1qDQJI/PXofYAEBroDyNXnFIablT8/VKbSOCX/2iLQ7/CFrAOUFtqmGiB02jJAKuFbtfmIBDmi3jRi/B1YbFt6mcCWv5kk3VAiLj1xPhaLBIUTbdHRa5a/LXt3gkExuzRFoT+MPyxnElPNppE3mMytJC1wXu+p/MjGcGvdMndSm2LJh50B8w6oaMgv7z4BpJlkN8dA6lMyFidD1cR5tWAusrRZTk3RLYk/cWVyBnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7/vH9Q9jKs2GzlPx8DEoi1T0SBAlJ5DZXJzhZrsbsp4=;
 b=Ypvbg2b3hkZzQpttoBDg6IuUk/URlnlfgLufILYixdGAVIeJ9/rma8GCibCn62jpn+l+Ke+3sKLctCvFr1axNPq1tXQ77DH81oJ0jMps3nrNODJj36N8G/5P7E/OI82Y4/AjNzPJuQz1qkube8jp1nEfI3VAYga8T3u6QcXv1rY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by AM8P193MB1187.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:362::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.41; Wed, 11 Oct
 2023 17:39:08 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::550d:2425:c0ed:3e59]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::550d:2425:c0ed:3e59%3]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 17:39:08 +0000
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
Subject: [PATCH v2 7/7] serial: omap: do not override settings for RS485 support
Date:   Wed, 11 Oct 2023 19:38:29 +0200
Message-Id: <20231011173829.10508-8-l.sanfilippo@kunbus.com>
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
X-MS-Office365-Filtering-Correlation-Id: ea8cbbba-faa9-478b-3656-08dbca80f909
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3p6sozCcn2HL4jncWnuqlu4SCPtJqF5u6K8RLNRH3WWuGN/Ao19nMb8OlzF9sIefGXHfqfD9NC3JS2cfWzdbddcaIJ9+PRKXNPNe1xS+yaZ48B4y6MZ1+8m+6/YDu+fGBwLzA2j9uSbBYN8TjJGc5NAPGXggsdv8io9YjFrcxO6sXIepaZZGXfyOwUGiMfhJ8ligqFVUsiegqGmZlEqI6fJlm0OYzpcmJHxwdFOAXcYqkrCZ8bKe1sySPJ4Oaq9S1honTWynz+inu8nVzcgbQvdTKOj5iwaTwMBxGIp3XKCiDAh++ET+rrzcOhvcSX2rRMWtKel05Q4ypMQ7mVwr0SYpCwbADYZuL3LQ7JVnV83r+SuZSWSLPa5yvqBbeQtGPzeE3vuQabr415pHavg6cr25DfZFGlWVbTeDJ39zIQmL78nx8pcBZXqqOMVqF5TwoWvbpCpWI+ByGRvvOcg2O5YpMt/VHG8JyPmw4itcdMY1/42NvWlX29exSBo1qk00mCuTzdcugsj1OaTM1rSPQZX3rTITLx+4LHzUjh1g6FerIBZZ8Fw4LC1JIH0Evm86
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(39840400004)(376002)(366004)(346002)(396003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(6666004)(2616005)(83380400001)(6486002)(478600001)(1076003)(52116002)(38100700002)(6506007)(6512007)(66476007)(66946007)(66556008)(4326008)(8676002)(8936002)(41300700001)(316002)(86362001)(7416002)(2906002)(36756003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XeB9TZPG8Xe9zzSsxjCWo2zvsNf63NHcuuE/dXdm01KnFFB+rZuO9Q28U4OY?=
 =?us-ascii?Q?23SsDRsof4p4XdbVKnjhyvW5iH8etN9Fx01QFN8WKX6sn01KB9LMnn2UTFhP?=
 =?us-ascii?Q?iaedLAZtFapGfumpWPapBKR6xNhqv1pgWd/M/MIEIq0PagAZYLhqxE5NJIrM?=
 =?us-ascii?Q?1cVW7Ve/girqFRPcI+3Lch1gV89KhVZWJLGwLCSEB7WvmrMmlaXmrOhrd+lm?=
 =?us-ascii?Q?ns1MdowXa5AVDQEwLq5fHfbxHgopC7UuLEB8DgGJQbJaX+Rhv8VVB/u2sptI?=
 =?us-ascii?Q?Fedy7n/8kodqjgvjYFqTcHVLA9vs+fftztamwEY9w7CGpDmBr/j9FPl06yOk?=
 =?us-ascii?Q?Cjvbt/w6YAGlbWMfP5CyiPtbKVYMKQ25dMpuhlfK65uoQ07iUpm1LRDYXYva?=
 =?us-ascii?Q?VtbgbR7q7gVqFa5vu2+2/OibToYbKx+6XHd7GEAVj1oZnv58JKeYwI7IKXfd?=
 =?us-ascii?Q?6IOJNtonnCo5H+nhAnqjqO6xiHug6WDrLlRJEAHQwc7KCc2itjQFOZvvMnk7?=
 =?us-ascii?Q?UezIK52Hp3YfWxn+L3pP8GH81ye07aYyo61OnEKfcOucigY+ROXsEmdfXlht?=
 =?us-ascii?Q?lc3T4JVnp0jO0cWhc9hFqCJAcg0nMGCgE/q0PmqBdvOqgxxh5uzvmg1o1KxV?=
 =?us-ascii?Q?tMbzhj96KlyzCFTQAGtHMxckPMQQR1lO/C5zDcOHSujdLvYM5Hiuush+U1kZ?=
 =?us-ascii?Q?M9CgN7kPk6o9GqZGvohc2/+TdnYmqpSeweHlFIelleNC5ZbNyoF5eQuTgG8i?=
 =?us-ascii?Q?4iMfoSorGETMFxeKOqI9V8sW7V/uFRzE3urjvVlcPjisMUqQ56WxNAVJBiL+?=
 =?us-ascii?Q?lvv4JsUrVSPDG7pUl8trhUEnx1DtL09CW0XNbkftWzTZ+A18goxiMFEQqCSi?=
 =?us-ascii?Q?pCXRltf37hRPopgHDGQfzvGhO9w1w8QvvzKIRu7Kh24eEy/WKuyYC2onZqhc?=
 =?us-ascii?Q?fOq38hoV0lbs4ulWIQwwM2e4ty1hyB6Zn1Xa5zrAscuapfCE/aUNwEdSHP6T?=
 =?us-ascii?Q?HclWEoL1LVHIM1XPplzMzk0KLKePOIe+a3GpHQxOV/aAXcTlRQtGaCdSU88Y?=
 =?us-ascii?Q?eA/blBIk/zes1MBpKMuEc74eeTY2WIue/2gzRjzr7UTWbilyPfnlknQXYxYc?=
 =?us-ascii?Q?pEB4eFYmsrVQ5StK2mvvvaq53K917GZ5F4mGMUTM/T0TgQ5FT6Qgj/QfX87k?=
 =?us-ascii?Q?iBhs8sUmZhHuMm/d0pr6fgMgwDkZzsSy6XGx2tMCgTENzt8u0glNogLIVnSA?=
 =?us-ascii?Q?Ljsom63RmDijIpywShpuj53/QHHGA/qQClyKzvpjsn5pjKNbnAFnL4RHmvVa?=
 =?us-ascii?Q?oCO2OqOPrtRmvdeqXdLwfT7rm36nzT4FVr7jgFuXK8IjVtWUvamMT5f4nu/b?=
 =?us-ascii?Q?+18ImcjK3CLJh8H5F9sLKP869LLaUByAyc/fVPvofCeap36deogIGKfmLm0Q?=
 =?us-ascii?Q?8h+1wkCZV5JR9zyoBRRwOxdeJQvciey2feRpau9WSshc1FdfJVHaKnC6hIHZ?=
 =?us-ascii?Q?3Z9LVpirJBbmTwvOgbVtKYGRu+qOT5DoQMpl/Vguxo2zXlFSw78xBg//TfXS?=
 =?us-ascii?Q?a2F6MPoJjVKvnGTZUqgjOgHXztFIZLM0sTw48HqKZEVcDvFZVxdtHh4JjGmY?=
 =?us-ascii?Q?ecdF1EcCzXYfh1NyGPr+JLR/7cUfCSww0YLpH+YBK2vT?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea8cbbba-faa9-478b-3656-08dbca80f909
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 17:39:08.7136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y5j5NN90xeg3vpV0d5w8i6PHB2HhszRDvIpLQi84uiDUjSKFqYTqwpEFUSw/KT31EXHNIvZMgQFTcHQiI44UoA==
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
aWFsLmMKaW5kZXggMGVhZDg4YzVhMTlhLi40ZjdlZTQzOTIwMzQgMTAwNjQ0Ci0tLSBhL2RyaXZl
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
X2FkZF9yZXF1ZXN0KCZ1cC0+cG1fcW9zX3JlcXVlc3QsIHVwLT5sYXRlbmN5KTsKLS0gCjIuNDAu
MQoK
