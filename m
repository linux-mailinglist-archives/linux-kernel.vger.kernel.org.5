Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 800327CE54D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbjJRRuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 13:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbjJRRtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:49:46 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2047.outbound.protection.outlook.com [40.107.22.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44AC5112;
        Wed, 18 Oct 2023 10:49:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Om64yqT6QtA9XIsqZl0GfdomHbPCvLmoyO5UJksiXefv+C7xZnz56ivs7UcSrPxufXZZfXYb9wYyUjO+ozf1qb7aeiA/4r0CDBmjkJ3pEMvBvPGQ2JUV6Mc1n3l8klSo6dzpBGE6oTk07tPLiynW15OjpdC7Hx/Is+phGPiXj9cRGayY8vrnh7cSLRgvBmF2/iTYbAtwyMOE35olNZIreaPr1CLSFrl6PgFPU/Hobhc2UH0LLj6ilLURX2BaV9ZjMUVfGcHMDDU9HpmgjqyualrwtjLtf4Tgv6alNaqF7dXzfQ0pyuUmKHafS5OVjJK8++1UH5CQ4dxpcqaTYJ5Etg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jty28h9E0xtb68sEWjbyY0P2pj9xkcJFJp53NmKQG+U=;
 b=ge58wig/MMVgy57YNCIPSYsFAllTU4SLFRV+d5CFrCMWvYzG0N/evARgUB5jZyR3IRKPbZV3EATXXYBkAHivr0mI99W7nmBhZ4y1xFwGHaJaR4KogI6MC+wESk9GjTGsfkM/NeGAlY9oM8wvbZeDQS0sTKZdBtL3n/UuNjVqJ7H24VjAYUONBQnmhkoPwJsCrtWZiBP5Lu7NrhFXGwV4sBHsHSIjYjxzpNqvAf8Z5fBi44swP7ceD0AJzYtRHmkEc0emccsc4dvGkvXmjKt8kejtHua6AY98IQ9zeznTClZYEyCTMlHJot+YjSPL/2hS+ccu8CUyCZeCEgVFnOs4jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jty28h9E0xtb68sEWjbyY0P2pj9xkcJFJp53NmKQG+U=;
 b=l+eAnmduG0YpjI7aCljrJG9ORqd+EBhRFaBNSFHsgMY/W3ifBygnYLNOyANpNWs2mIKB9stP2MMIr0ESYxoeyZcnB8RjkAmOvQkNcW6dGh9Pyb+PkM1aBWKC8dnyAtDXamoF8EiBXE9HDKqqggNKOf26pGtkMd7zdYEg32j1EzU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by AS8P193MB1478.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:350::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Wed, 18 Oct
 2023 17:49:40 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::550d:2425:c0ed:3e59]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::550d:2425:c0ed:3e59%3]) with mapi id 15.20.6886.034; Wed, 18 Oct 2023
 17:49:40 +0000
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
Subject: [PATCH v4 5/7] serial: core, imx: do not set RS485 enabled if it is not supported
Date:   Wed, 18 Oct 2023 19:48:38 +0200
Message-Id: <20231018174840.28977-6-l.sanfilippo@kunbus.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231018174840.28977-1-l.sanfilippo@kunbus.com>
References: <20231018174840.28977-1-l.sanfilippo@kunbus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-ClientProxiedBy: FR0P281CA0130.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::17) To VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:803:4e::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0413:EE_|AS8P193MB1478:EE_
X-MS-Office365-Filtering-Correlation-Id: 72b92e88-ba23-4c86-a918-08dbd0029a22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KDOMFT4bE62M04KLes3Y92TMGUbPgcsnfvRWdFlzkZIKiGR/fVnfZ+0HitHq3GBO2HL3/piUfbry6ujuwqEkTxtsKk76vNT2nVMF7ZUMi8rmjYciqRVr5VIlVAVoIDSOKX9KaSXo+XgWEyf5LOsyHf8/hGfmCSDqj93vfbk8amt1o3qcNSQgcEyKrkWsJnsTSqHwAlQMX610Dfw37vKTlnu3QN1v7qI1browjrcV0XNXTGTHOcmMgU3ipoBYI9uXqq8bx4YA0Z3jthW16zbCRvrXlvbqofeG/ad+5kdf0z473fRF6h/Bkj6RR0RDFZLbIJIKpvrdn9TJ3/yzW4grkK2KvjAB4SqFWFpQwv48K5s3mt2o9XkQQXAufLVpqFbJk4Z2eTrhrETJ8a1VKFg1E9jv2ToE4yDX9QCWROIXXGHj7HrRZ5maPPnq6t268dCS+Z+iKu9pd5uzuQxKcOlFdlWNFBT+2Bz5uiLVtPx5v/nLnEI6nm444GHJBdX6/0tHmxQdXLDr9PbV8tdxAPjVHzwknSZwuo/U1iaGIK9oAs0QvYV/HdEiZF+r/nuSzgdk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(39840400004)(376002)(346002)(366004)(136003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(36756003)(66946007)(66556008)(66476007)(86362001)(38100700002)(1076003)(2616005)(83380400001)(6512007)(52116002)(6506007)(7416002)(6486002)(316002)(478600001)(5660300002)(4326008)(8676002)(41300700001)(2906002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VSswcjA1em5NSDUrU3ZuT3Y5cmJGR1krQ3RlTldOOGFmckRmZXU0WnRVM21L?=
 =?utf-8?B?WktUNUZuOHFXVmpsTGNoQlljTFBmSlF0bzdHUGdSNndXS0R1WDlNY2d0SERI?=
 =?utf-8?B?dWdvSU1OWGp1MVE2U0hzTkFUNHo0am9Dc01mY2dJVDh4TlJVLzJaTlhKRkh4?=
 =?utf-8?B?SVl6TkhYOU9rVEdZQ211a1RBQVhZRUpZRzZNZDlkY29wVys5YnJ6SmM5Yjhj?=
 =?utf-8?B?NXptNnRwdU9PenNyVDhNUThTaElPc25Gc3FpV1JITG15aEFlblMrWmhFSkt2?=
 =?utf-8?B?c1R6c2k1cFdYR1JXV3RiNXRBQ0R1TzRJSWN1TlJnalBxTlI4d201UklBd3ND?=
 =?utf-8?B?RUhPcjFuWHlDSkQrM0dadUxzeGNxeENUSU5HWUJCdDFmcEZXNGxhT2ZPL29k?=
 =?utf-8?B?bUpSTEJqbnBQMnRybm1JcHB1K2lUallwU2VKWUl6L2pkRzlYQnA5V0ZYaW1i?=
 =?utf-8?B?b2pDM0txM0ZsTFU0ZW5Ea2FYalBaNnZ5djlGcDNCYk8xTHVkZmZoWnhmK0gx?=
 =?utf-8?B?b2xnMUUrM2EwS0EzY3dyak80dDFNRmRkRll4bE9uNU9DWGVKVVloQnJ2TDNN?=
 =?utf-8?B?aDQzKzhkdUNIQzZRdzBoUWNGREFyL0I1TmVZY2c4ZkVlakpLQm5NdGdROUpW?=
 =?utf-8?B?KzhsdTNvSzluampYaGc0K0ZCZThDdE1ZMXlDbForZDhmOGpBQUZuZjg5SFB5?=
 =?utf-8?B?L2ZkV3dJQ3pDMXJTaVQwbUxxblVDMGRmdjVvckFCQnVJU1ArM1p2S2ZWT0pU?=
 =?utf-8?B?cUw4QzhLMnltcnhRVnlJOEpmcy9uclRGTm5GaUxoWDFKUmQ5V2g2TTBtcWZo?=
 =?utf-8?B?RzBnRzNGWWtHay9pS2w1Yy84WFMvcldyTklJYkRxNGNLZzFRemNvRm02N2g0?=
 =?utf-8?B?QUxUbHNQRnp6NksrYXY0NUwyTjVuUmROeDZmZzFhRFJWcHdoTDJlTlhwZXNS?=
 =?utf-8?B?THJSREpZTW1POEptdWJxYlg1U1V6enRBVyt6UmdvZFduSWU4blkzWVY1Tlpk?=
 =?utf-8?B?NXN2ZER3S29HNjlZL2tobjFqWERHcHdZekpSOVFaMFdaKzJINlBNRGh4NHN2?=
 =?utf-8?B?SmQ0QmhMWUpNazR3Y2ZNVUlXRUxLWkpiSVhCQmJaOVVma1EwbHRWRVFNbWNo?=
 =?utf-8?B?ZEFkQ2JGNVVRMkFIazlucmFuaGNOT1JXWnBIWUZqNlkwNUlwTlE2aG5IVkRT?=
 =?utf-8?B?d1orenhJU0tlRklxNjJBN1NyNVFjVDNyRTNTRW5BK2FHM1M5RW5RTkN5Qlpx?=
 =?utf-8?B?UkJ2WHp4RndjUVE4ZEZXNDlsUnE2dEN3WlJsc29mTGI5SGdiWWQ1bUhTbzhS?=
 =?utf-8?B?VkYzVktTeHcvY3hTYUdwRDk3UG05V2F6Q0duZFZDeHBkeEdxR1hrdlZ6SkNn?=
 =?utf-8?B?MnBSUzN3TWVCcXZXTkxCU2FaeEpxOFdJZXVpc2VhT2pRTE5Lazc0Rm0wQWRy?=
 =?utf-8?B?N2NqK2l5WVBjZ25vWnVzd2p6ZjJYQXJKZ1NweXluRWFHQnIySktEUnlyKzd5?=
 =?utf-8?B?cnUvYVNYeG5PWDBPbkhnU1gvSWlXZVpReVFVNUJNekVqdFczV2dvdWNmemhk?=
 =?utf-8?B?ZURnQ1lhZ09Oc1lCQVdiQ1dLSEtyNG1HYVdaTGt3M09ydXd6Z2dlMHR5U1dE?=
 =?utf-8?B?dlZDNFpzd040MHVySVNDcXc5UDQreVlpcWl6WjEybmpSeVNNVU5tclBMV1d5?=
 =?utf-8?B?aEYyWXZKcTRiQ2dtUng2dUowcDdGeG10VlpTUWxXallZTWRRcURDbUxIUDQ2?=
 =?utf-8?B?RU10cHljQjJVay9TZTZRbUhETGFjZThCM1o2bGh0TWpjWXRRNVRkWHBmb09W?=
 =?utf-8?B?dkFNUG1lUjFmTzVPUy9JQ1o0L1Yydlc5Q091MDVQbmpsaXYyYWFBcUd0S0Rx?=
 =?utf-8?B?WHdPUXcxdDdjUi9SVENZODRjbzdSQkJIaElHUEVYTDRKY0dlcHhOWW1UbUln?=
 =?utf-8?B?MXNKQUN4bFRRWDlUQmFONG9RcTFpMDV2c3FmbnN0cEJNM3Z3ek9MRG82c2gy?=
 =?utf-8?B?bGovQlpUTzVIVTQ3VDBJYTZMNng4RzNCSzYzLy9iaFhkOFN4TjU0Wjh4OVZJ?=
 =?utf-8?B?WmwvVFJOUm9NVzExeE4ydXA5YlNkZDZtTU5pcjNWZnlvK0ZDT0pjZnJYRG11?=
 =?utf-8?B?Y1pxSUpmZHh6L3RkOGpVdGNEUkk1bkZpRmxGZlVKTmZueXp2Sm5udUJTMGMw?=
 =?utf-8?Q?Ss2fZ1mAOp2osNHkhJsg6uMH7eOBqvZfjMLOSxp62qo+?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72b92e88-ba23-4c86-a918-08dbd0029a22
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 17:49:39.9162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0aP0OJ5xQjQtUKhP3as4G8AuHwhn8gk4iza0d9j7nnK2WyXfZ84qJSd01bT29XU1hDGVTaluT/FLHhM7pVfl+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P193MB1478
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
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
aW4gcnM0ODVfc3VwcG9ydGVkIikKQ2M6IFNoYXduIEd1byA8c2hhd25ndW9Aa2VybmVsLm9yZz4K
Q2M6IFNhc2NoYSBIYXVlciA8cy5oYXVlckBwZW5ndXRyb25peC5kZT4KQ2M6IHN0YWJsZUB2Z2Vy
Lmtlcm5lbC5vcmcKU3VnZ2VzdGVkLWJ5OiBVd2UgS2xlaW5lLUvDtm5pZyA8dS5rbGVpbmUta29l
bmlnQHBlbmd1dHJvbml4LmRlPgpTaWduZWQtb2ZmLWJ5OiBMaW5vIFNhbmZpbGlwcG8gPGwuc2Fu
ZmlsaXBwb0BrdW5idXMuY29tPgotLS0KIGRyaXZlcnMvdHR5L3NlcmlhbC9pbXguYyAgICAgICAg
IHwgNCAtLS0tCiBkcml2ZXJzL3R0eS9zZXJpYWwvc2VyaWFsX2NvcmUuYyB8IDMgKysrCiAyIGZp
bGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS9kcml2ZXJzL3R0eS9zZXJpYWwvaW14LmMgYi9kcml2ZXJzL3R0eS9zZXJpYWwvaW14LmMKaW5k
ZXggZWRiMmVjNmE1NTY3Li5jOGMxOWJmODU4NWQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdHR5L3Nl
cmlhbC9pbXguYworKysgYi9kcml2ZXJzL3R0eS9zZXJpYWwvaW14LmMKQEAgLTIzMzIsMTAgKzIz
MzIsNiBAQCBzdGF0aWMgaW50IGlteF91YXJ0X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2Ug
KnBkZXYpCiAJCXJldHVybiByZXQ7CiAJfQogCi0JaWYgKHNwb3J0LT5wb3J0LnJzNDg1LmZsYWdz
ICYgU0VSX1JTNDg1X0VOQUJMRUQgJiYKLQkgICAgKCFzcG9ydC0+aGF2ZV9ydHNjdHMgJiYgIXNw
b3J0LT5oYXZlX3J0c2dwaW8pKQotCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJubyBSVFMgY29udHJv
bCwgZGlzYWJsaW5nIHJzNDg1XG4iKTsKLQogCS8qCiAJICogSWYgdXNpbmcgdGhlIGkuTVggVUFS
VCBSVFMvQ1RTIGNvbnRyb2wgdGhlbiB0aGUgUlRTIChDVFNfQikKIAkgKiBzaWduYWwgY2Fubm90
IGJlIHNldCBsb3cgZHVyaW5nIHRyYW5zbWlzc2lvbiBpbiBjYXNlIHRoZQpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy90dHkvc2VyaWFsL3NlcmlhbF9jb3JlLmMgYi9kcml2ZXJzL3R0eS9zZXJpYWwvc2Vy
aWFsX2NvcmUuYwppbmRleCA0OWRkNWU4NjQ3MTkuLmM4NTI3NWE1NzNlMyAxMDA2NDQKLS0tIGEv
ZHJpdmVycy90dHkvc2VyaWFsL3NlcmlhbF9jb3JlLmMKKysrIGIvZHJpdmVycy90dHkvc2VyaWFs
L3NlcmlhbF9jb3JlLmMKQEAgLTM1ODYsNiArMzU4Niw5IEBAIGludCB1YXJ0X2dldF9yczQ4NV9t
b2RlKHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQpCiAJaW50IHJldDsKIAlpbnQgcnhfZHVyaW5nX3R4
X2dwaW9fZmxhZzsKIAorCWlmICghKHBvcnQtPnJzNDg1X3N1cHBvcnRlZC5mbGFncyAmIFNFUl9S
UzQ4NV9FTkFCTEVEKSkKKwkJcmV0dXJuIDA7CisKIAlyZXQgPSBkZXZpY2VfcHJvcGVydHlfcmVh
ZF91MzJfYXJyYXkoZGV2LCAicnM0ODUtcnRzLWRlbGF5IiwKIAkJCQkJICAgICByczQ4NV9kZWxh
eSwgMik7CiAJaWYgKCFyZXQpIHsKLS0gCjIuNDAuMQoK
