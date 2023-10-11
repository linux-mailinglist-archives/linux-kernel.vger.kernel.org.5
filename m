Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129737C5A68
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 19:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234990AbjJKRji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 13:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233183AbjJKRj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 13:39:26 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2088.outbound.protection.outlook.com [40.107.249.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82388CC;
        Wed, 11 Oct 2023 10:39:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XAh2drSLMhIDGnpgmbeR5QxKNfoLgrTmzxZj3wqU08yayWnBU4t3w03PaPJG/8GPpIhBSSSjtzrVAZIhlsGd1y1qzYbyJU/XEvj90rbrQyZSGhqq5e/X5PaYYIq96gyZYd2zCeC3Obxh1wk4O7fxfGv/UAs5XKrZ1Qu3SKZHRXj0B25LpNvRhgCPJa2b/bPqrA8gh0yRU2UfCOJts7ifoVqT24T3ROAqIFGT2oU4txiwI3HcuenRiaFr+RheOEWhtwlMl1IbLhCJiUkrY4sGj/nXB4sqWawIF5Swf9t49O9SnNESAt+n6j/Pbk1qS3NA7Vkg3ytrWuTFxBmjQ6rwTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g9VNnrRh+93b9tiZ7+fqQ29BWG2jfMJ+okhxSduWaaw=;
 b=bBeAblgk4q/AM/hZYIdL5SHKWSx35276mQ/idQ9keKNchocVM+RCfsW4IH8pAeb1U9nxV9CTA3Xy+jG9kH19mGjSjpoVNO1bq8oORQM/VxgZCceBR8+2t0Jz51jlXMvZkNqmvWxcGXyDIK3Ls0dp1KSGd196U+F+soorjGPJeDOvyMT8e3W9ESyw/lHF17hAZHw0ZSVWVBrxhzx7vHyYUeujv6cvmzNNKBMCyiXtO06vbmC103NAfpm38e/bmr2GXsu2EE2rgTL3GQ4WCssnDqTEKThE0T9s4gWXeA+dofGXBUjBNoUI94FfI8vtpJ5hFJdBDjSTXwrhAT/4toGgpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g9VNnrRh+93b9tiZ7+fqQ29BWG2jfMJ+okhxSduWaaw=;
 b=aAO/cdrvJeQ7KrAch7thEVyxuqGaSN5jU0IxrAIquJXnO8kRwSMYGd7C6IAOGlWthsjeQjg4CaLu066BgAS94rUJV6pf3jb+0BBp9vmkc0lAeWoP5zeu0RG8nlJ0Hbvj4GWsdubrWf1HrcEW41rfoYNxzKwY2nfCpixV+2vM9KM=
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
        stable@vger.kernel.org,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v2 6/7] serial: core, imx: do not set RS485 enabled if it is not supported
Date:   Wed, 11 Oct 2023 19:38:28 +0200
Message-Id: <20231011173829.10508-7-l.sanfilippo@kunbus.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231011173829.10508-1-l.sanfilippo@kunbus.com>
References: <20231011173829.10508-1-l.sanfilippo@kunbus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-ClientProxiedBy: FR2P281CA0093.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::18) To VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:803:4e::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0413:EE_|AM8P193MB1187:EE_
X-MS-Office365-Filtering-Correlation-Id: 7563fd0f-131b-4ca1-b310-08dbca80f8a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 58WR2e9qytcd68wapZlInQB0RgQtzyhh+s/A+CUeJqJIyQS5PDGb8QgP/UiSxn1AEwkKSBVfKkCRiuOPoMuGKL/ImF+7QakoAuPjZQ6Tqxh2h3DB3CsmMIzfPJ3kzFv8YIHmt6gBwyOZOy0HZSGXCzKDtJpYMvMhVdeV9br2L1j2ZO5XI44Sg15Dy3i/tTkvtt6MhGirONesdrUfTQMF6dh5HIPMD/uRuRjZS7rwCwWYaYmr4L9TKrLJ505rcp7tS/66/h6CiEKc9o1hNumk13Y6MJQ0RUR51cjqxwIJSHXWYJGOOy2oR7iJPg7zHWrSKWNxSSH5bTdYSk5a4yugE2Cy8R+5Aoigufm258uoiFFZx+vG7of2XhQiLj4vvgLoVyossx52PvcLWjbxhzOAaL6s8qNEo0c9fRyQ4cZz5fciwv1IEmQDSUqMB5+FjiNoMjTKCtZmbiSkaJDoOj9HnVdPqXzHDgu6f1tnvGU6CXTLIctzDZOBhUojrKTBWiubJjfXYZSg4kciB1fb3rVz/ELrYeymehic3t+gi8k9JOnMizht/BHHp9uCgPNYLTHQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(39840400004)(376002)(366004)(346002)(396003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(6666004)(2616005)(83380400001)(6486002)(478600001)(1076003)(52116002)(38100700002)(6506007)(6512007)(66476007)(66946007)(66556008)(4326008)(8676002)(8936002)(41300700001)(316002)(86362001)(7416002)(2906002)(54906003)(36756003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1hMSmg0aXRGaW5sdWVUdWRqQ0p4VjJOd0F3dVcrOXVubnJrN04wK005Mks1?=
 =?utf-8?B?cGtoT0dUbHRyT0dEOEtMZENjUDVNOGQrNnNRNHRkMmZjaXhsSGZJSjBlWVpx?=
 =?utf-8?B?QlRGSlpQdmVodC9lZkk2U0V4M0psZkI5NTJNVU9ZUldnSzZQejZRdlRYMkNS?=
 =?utf-8?B?YTJ5NTV0TDlsa2ViVmY2QnJIcXVyKy80UHoxQWlOTHlCVGova0xRdm9IYVpx?=
 =?utf-8?B?QlhUajVtUG85c2crT0k5YTlydTNUL3JzR2lqM25FQ0w4K1hTQ0xjQ3NMaTNG?=
 =?utf-8?B?aEtleTAwQXRJMDZxOVBEcThaZDEvdmJrcTY2cndGT0dTd3B4eEx2ejhZc1Aw?=
 =?utf-8?B?SXRvRFV3S251dTg1ZDJ5NDVkeDhqK1FBMFpISlpSckFsNC9yUHRGNUVTRU4x?=
 =?utf-8?B?TXhHMFV5b0FqUGNwdS9mZ2NXK1RDL0lhQk5LNnBwUDJidnVXRXpyM016TUVX?=
 =?utf-8?B?NTNWYk50OGxPOUNXeC8rTC9xNXY1TnJQRDkrcGlvU2crNlVZa0kzRzRDTUdR?=
 =?utf-8?B?S1ZSUUtkVUVHSTBoV01maFlqVWhlVHYyT1o1Ui9IK3lYWFlsWWFXanlmNFFH?=
 =?utf-8?B?cjFUNFpmN3RkdHN1TmNvamV2WmxleHdOeDV5OGJZcUxXaEN0ZkJQTU5ZdVc3?=
 =?utf-8?B?WVJCcUQ4Z1ZaQ1BRQXRjS2JXSFNwOGNKZ3dBZzBUUHBVOTV1RXpHUytQMUhF?=
 =?utf-8?B?b2hkUFM1dS9TOVFtYVloR0I3MndZOEg5S2xDenYrQ0p2YVBsb2pIYmF2M0hK?=
 =?utf-8?B?eXJuckI2T0gzenpJUGtxSFBHNitjaHVmQUxxVElpdUhBQWZMTUFDSzlVZm1Y?=
 =?utf-8?B?R0llSG1WYTRaSWRuanhmOEhOaXRTV3o2US9ObXhWNEdiTCsrNTZDR2pIM1I0?=
 =?utf-8?B?YmlzaExHYllKZG4wOTZ0ZnJCU0pIOEUvNzNPMjJJTUF1YXBzUlpXZjJlZGJG?=
 =?utf-8?B?YU91YmFaa0VnOUsxeGlkUmZnWlRPdGJ2dWZwTEFaWGptQnIyajJDcWhpcDRy?=
 =?utf-8?B?SkRybFF5b0Zvay9XbituV24zVVFUUGh4bUEzUEpQdFZrTEdPd0NFOEVwR3ZB?=
 =?utf-8?B?NVp6ZmJVMk9FSzl0Nk9CSllDdVRnMkVMemZPVXJ5U3F2SXBMbXdyaFp5V0Nr?=
 =?utf-8?B?OU00aTA5VlFybFF2blJmUDlkdnVoTkg3Rjl3a1JnN0FxeEpNalFzK1R2dnIr?=
 =?utf-8?B?ZFVlNjJISWNUSmpraVRTak1xUVd1cmZSMFYwZGdpck92dUdkaW10TFY0MlRY?=
 =?utf-8?B?cGFjV2lNWHdMRGVCMzEyclZFb0xYS2hvZm9oMWF1SHVyRFRYYkRDMnNNN0t6?=
 =?utf-8?B?MFZFRytmcDFmYlAwenlQVHc3VlYzOWx5TWRXeUFUTENZK2k2UVlMdmtqcEl1?=
 =?utf-8?B?bFNrMjZqNGJGL2lwYng0UXQ2anhMeXRNZjY2TSt4NFNpbDM2OU5rT2owWXRX?=
 =?utf-8?B?OFFWWjZiUU5Zb2NxeFlVcEpTd1lLTFZkYjJKMExoOXFwMmJRcDJONVMwSWFi?=
 =?utf-8?B?ZmZFS2MxTHZVa0dxcThWcDZIdDE5S0RWdERIcDRBcERPUkZNbGloN25QOWI5?=
 =?utf-8?B?L3RWR1RiMTBxT2RoRng5MWcxVWFNMTRyWkNHWXVvd0JqVlFvZkkwOExSbnZC?=
 =?utf-8?B?L3lNdVRiTWgvd2dGNHp5bXN2KzI4L3F4L05ENTZ6eGpoZUVFZEhxdUp5a0t0?=
 =?utf-8?B?Ulk2UFJ1YTN5Vm9MN2hObjV1NUc5V0hUUElsWXZmOTdBams1SlZyTG1tSGRZ?=
 =?utf-8?B?UGM4c21xSitHbWtZTEpJNDFEVm5lY2Vsa1dzakJWem5QTWJjY3E5UUd0ZU14?=
 =?utf-8?B?eVN6blphbGNreU8vVWtGKysrakVNSlRQWHJLd000WWN5WWVPMGlKeDlHczV1?=
 =?utf-8?B?VStJdnhnRjRKdjZ4L3NrL0FnOVRBb1VHbE9xbDJKcGdCeC90TkRraUtRMFB2?=
 =?utf-8?B?cFBaUVVML0RDK2lpWEJPZ0dxMjhVUkQvWXJmdEJYMXFOcjJWUmZkcXUvZkNY?=
 =?utf-8?B?ZHZNS1k2bGNHVHNqZ2N3K3g0cExwVnlDemxlbmJLUm1pQUhFLytYcExscDRH?=
 =?utf-8?B?N284Vi9aeEdGNEhIdU9QdmVXMTlTZk5ld0lORFB4bm8vYVJRZGtuc2N3eThu?=
 =?utf-8?B?VWV6dXdlZDFDOFVpVUpPcjQvWkJkajlVSkpKUE9ORXlOQktLNnRZM2NPZ1FE?=
 =?utf-8?Q?caBeGvRCazl5t2cme45FSmvfuLvBaj9OlxOvaoQ1p8Gf?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7563fd0f-131b-4ca1-b310-08dbca80f8a2
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 17:39:08.0536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3G/BcBG+MR0SKgB0v9OH9fWXUk4Z96ezoa242iKnjMLz/idaDYLIuT7767KHxp4W8c/vim2rxhhbVa9f0eLhMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P193MB1187
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SWYgdGhlIGlteCBkcml2ZXIgY2Fubm90IHN1cHBvcnQgUlM0ODUgaXQgc2V0cyB0aGUgcG9ydHMg
cnM0ODVfc3VwcG9ydGVkCnN0cnVjdHVyZSB0byBOVUxMLiBCdXQgaXQgc3RpbGwgY2FsbHMgdWFy
dF9nZXRfcnM0ODVfbW9kZSgpIHdoaWNoIG1heSBzZXQKdGhlIFJTNDg1X0VOQUJMRUQgZmxhZyBu
ZXZlcnRoZWxlc3MuCgpUaGlzIG1heSBsZWFkIHRvIGFuIGF0dGVtcHQgdG8gY29uZmlndXJlIFJT
NDg1IGV2ZW4gaWYgaXQgaXMgbm90IHN1cHBvcnRlZAp3aGVuIHRoZSBmbGFnIGlzIGV2YWx1YXRl
ZCBpbiB1YXJ0X2NvbmZpZ3VyZV9wb3J0KCkgYXQgcG9ydCBzdGFydHVwLgoKQXZvaWQgdGhpcyBi
eSBiYWlsaW5nIG91dCBvZiB1YXJ0X2dldF9yczQ4NV9tb2RlKCkgaWYgdGhlIFJTNDg1X0VOQUJM
RUQKZmxhZyBpcyBub3Qgc3VwcG9ydGVkIGJ5IHRoZSBjYWxsZXIuCgpXaXRoIHRoaXMgZml4IGEg
Y2hlY2sgZm9yIFJUUyBhdmFpbGFiaWxpdHkgaXMgbm93IG9ic29sZXRlIGluIHRoZSBpbXgKZHJp
dmVyLCBzaW5jZSBpdCBjYW4gbm90IGV2YWx1YXRlIHRvIHRydWUgYW55IG1vcmUuIFJlbW92ZSB0
aGlzIGNoZWNrLCB0b28uCgpGaXhlczogMDBkN2EwMGUyYTZmICgic2VyaWFsOiBpbXg6IEZpbGwg
aW4gcnM0ODVfc3VwcG9ydGVkIikKQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcKU3VnZ2VzdGVk
LWJ5OiBVd2UgS2xlaW5lLUvDtm5pZyA8dS5rbGVpbmUta29lbmlnQHBlbmd1dHJvbml4LmRlPgpT
aWduZWQtb2ZmLWJ5OiBMaW5vIFNhbmZpbGlwcG8gPGwuc2FuZmlsaXBwb0BrdW5idXMuY29tPgot
LS0KIGRyaXZlcnMvdHR5L3NlcmlhbC9pbXguYyAgICAgICAgIHwgNCAtLS0tCiBkcml2ZXJzL3R0
eS9zZXJpYWwvc2VyaWFsX2NvcmUuYyB8IDMgKysrCiAyIGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0
aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3R0eS9zZXJpYWwv
aW14LmMgYi9kcml2ZXJzL3R0eS9zZXJpYWwvaW14LmMKaW5kZXggZWRiMmVjNmE1NTY3Li5jOGMx
OWJmODU4NWQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdHR5L3NlcmlhbC9pbXguYworKysgYi9kcml2
ZXJzL3R0eS9zZXJpYWwvaW14LmMKQEAgLTIzMzIsMTAgKzIzMzIsNiBAQCBzdGF0aWMgaW50IGlt
eF91YXJ0X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCiAJCXJldHVybiByZXQ7
CiAJfQogCi0JaWYgKHNwb3J0LT5wb3J0LnJzNDg1LmZsYWdzICYgU0VSX1JTNDg1X0VOQUJMRUQg
JiYKLQkgICAgKCFzcG9ydC0+aGF2ZV9ydHNjdHMgJiYgIXNwb3J0LT5oYXZlX3J0c2dwaW8pKQot
CQlkZXZfZXJyKCZwZGV2LT5kZXYsICJubyBSVFMgY29udHJvbCwgZGlzYWJsaW5nIHJzNDg1XG4i
KTsKLQogCS8qCiAJICogSWYgdXNpbmcgdGhlIGkuTVggVUFSVCBSVFMvQ1RTIGNvbnRyb2wgdGhl
biB0aGUgUlRTIChDVFNfQikKIAkgKiBzaWduYWwgY2Fubm90IGJlIHNldCBsb3cgZHVyaW5nIHRy
YW5zbWlzc2lvbiBpbiBjYXNlIHRoZQpkaWZmIC0tZ2l0IGEvZHJpdmVycy90dHkvc2VyaWFsL3Nl
cmlhbF9jb3JlLmMgYi9kcml2ZXJzL3R0eS9zZXJpYWwvc2VyaWFsX2NvcmUuYwppbmRleCBkY2Ew
OTg3N2ZhYmMuLjk1Y2VjMjM0M2IzNSAxMDA2NDQKLS0tIGEvZHJpdmVycy90dHkvc2VyaWFsL3Nl
cmlhbF9jb3JlLmMKKysrIGIvZHJpdmVycy90dHkvc2VyaWFsL3NlcmlhbF9jb3JlLmMKQEAgLTM1
NzYsNiArMzU3Niw5IEBAIGludCB1YXJ0X2dldF9yczQ4NV9tb2RlKHN0cnVjdCB1YXJ0X3BvcnQg
KnBvcnQpCiAJaW50IHJldDsKIAlpbnQgcnhfZHVyaW5nX3R4X2dwaW9fZmxhZzsKIAorCWlmICgh
KHBvcnQtPnJzNDg1X3N1cHBvcnRlZC5mbGFncyAmIFNFUl9SUzQ4NV9FTkFCTEVEKSkKKwkJcmV0
dXJuIDA7CisKIAlyZXQgPSBkZXZpY2VfcHJvcGVydHlfcmVhZF91MzJfYXJyYXkoZGV2LCAicnM0
ODUtcnRzLWRlbGF5IiwKIAkJCQkJICAgICByczQ4NV9kZWxheSwgMik7CiAJaWYgKCFyZXQpIHsK
LS0gCjIuNDAuMQoK
