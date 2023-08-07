Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE31177289D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 17:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbjHGPGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 11:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjHGPGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 11:06:12 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F7010F8;
        Mon,  7 Aug 2023 08:06:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lPyA03y6Gt+3zS01SpUM28Gh0M/Dl4TOTdspclqd0dDSSjcVF3EfdgDaYMcWhVf9fajXaGXuzjmHrSji2/hvdH50IMYQpXrnea9guuMsZoGc7I1LaS2rXvlIquKTfTsknLFdRFRQm3kBjur7WwkitYvMV3KwCQErD6LN0YsXkeCbF7dpQ0RX0q6MNlX2wd9o0/sslnFeogcBtUdx0o637JbYq1ISldRwqqQ6EWM9vDNr8r+iyv49qeVfClXcDYLL46ttv263Hetdl6WcxIfawFIhsOBXOFKgMv8zf2JcV6q56C3C5fE3yVdn8BHtkEPPSFatlsVM8zbSsf4VjM0bUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cPOV2Gz1E59W2pcAPTmW+HAfVjs5tUjGRDiUoEX/uys=;
 b=JjAo4j/E+IdQBToEfyMOf+O6KhiOUiv+BAf5+lQYP6GIS7RRqeTHHUb7Dtc7Y7cS70/k/hWpixYPjUxGIwLMqOGmdR57bCAdrra2s75t9np4sB0O5lz2/jOQu25mAPHCf3NTX5j2djzTS/zURlt2iTxScm+xzF2nFYj3cEZGMlE6ssiMUyTHIo9HOVnXpo62zne/gUZFbwNZiUrFSO1tJGGysG5Gh0R4FnIhEZmH9swJFECEC5KYqOxo6SSaRLOxVXYH5WDe+n9sFDpUCGcHayoggVfv9lUEQbi/oLyPPn0CIsmI484qQ+vCpCwSk1z2PDd7bfxgCxItUb1aGL3+xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cPOV2Gz1E59W2pcAPTmW+HAfVjs5tUjGRDiUoEX/uys=;
 b=aEAD1dKcXbj2ZdT9JHtGqc5VBbGzSggQoTwhAejuVzVFWGbu3yEpYtlnTMMpCvjYIm/VXGQbDjpSg1oio8L9tuRuu0yIZrWBGahfe4hAOYZTwpBdgHmcPtMKKq5mH7kcvYN9DoydYZ/8OLOQN/PVyS6B/01XYaSZo9xkU3bLDXQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=silabs.com;
Received: from IA1PR11MB7773.namprd11.prod.outlook.com (2603:10b6:208:3f0::21)
 by SN7PR11MB7590.namprd11.prod.outlook.com (2603:10b6:806:348::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Mon, 7 Aug
 2023 15:06:07 +0000
Received: from IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::14b1:be6e:19a3:2eca]) by IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::14b1:be6e:19a3:2eca%6]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 15:06:06 +0000
From:   =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>
Subject: [PATCH 4/9] wifi: wfx: introduce hif_scan_uniq()
Date:   Mon,  7 Aug 2023 17:05:37 +0200
Message-Id: <20230807150542.247801-5-jerome.pouiller@silabs.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230807150542.247801-1-jerome.pouiller@silabs.com>
References: <20230807150542.247801-1-jerome.pouiller@silabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-ClientProxiedBy: PR0P264CA0252.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100::24)
 To IA1PR11MB7773.namprd11.prod.outlook.com (2603:10b6:208:3f0::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7773:EE_|SN7PR11MB7590:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ed0e708-3480-48ec-9214-08db9757d36e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H/do6JqcBsc11+npB2JUKxGKZzkzPhzJc1g6QtmGinKxHEKXw1jumGzE4ySof5ovJ9MOHfqDPWldV4pzbetYAI6P3c/dwQIdeHtyRPMhLa70wbUjFXqbtfzlTZyhIMixYdUNkF6nYwa31b7zIk04uZ+5ElIm8XvquRwFg0CgDj/9dT9vLNNMtTUaYEGzO3lkhfEU8q1B5TU37TMnaTZvzMTDcaPCaPpHCatqk06IrPQ6pmqYmNW4HW1D7Sn1NRyqabZlSvVS7Quw3MTLJd56GkQbNPtcjjR5F1NdWhi1zmMFRIO5VvYZ/g4RfX0ZbRtMWi+ez6Q+DyYO/w6umFhbzW22c5OCstLTJbuIrxkr7RKurKXveAPgcW5gkaOmI8B3dWoDXWtFwDtWnMSuRxf52z8MU3knXH3jjxEng+selFIQYuXI1XaRbpmFYOxUgsq7Z3pLVr1gu5VLYx0haq5EtR0p0W8JZyRLVGeOA0SL89QLDy06BIkglSueDCa+IU3KT+KSKaPV7LrFhOvTO7R92Yll3ybvX2jDOSXDxAXboIiLNMmS9SyCSuzflBGH7y34iwTpdF9JZGE1BhdycpnhLHTlN5KsEP1warZ4wcKaIVRN7by53RCEExzcBB6r/UvD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7773.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39850400004)(376002)(346002)(396003)(366004)(451199021)(1800799003)(186006)(2906002)(4326008)(6916009)(66556008)(66476007)(66946007)(6486002)(52116002)(6666004)(66574015)(83380400001)(5660300002)(41300700001)(8936002)(316002)(8676002)(38350700002)(38100700002)(2616005)(478600001)(36756003)(107886003)(26005)(6506007)(1076003)(86362001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWdmY0daeDhkRXNaaExFWXFEVERDQlZCLzZEY1hYOVRSakFCMHlyWDkwY2Fq?=
 =?utf-8?B?NEFMSGhhVDkwRE1vbmZHSjRhR0ZDUmJIWlJXRHRPaDN2WTM4dkZsUHZ0cGRI?=
 =?utf-8?B?aWpuMEJ6eVFwNGRFc1puYUJ5VzJ1TnZycytMVU1QazhxSGxSS3FqNjBoMDFj?=
 =?utf-8?B?WGgwMlFoY2MwZ1JIZng4QmFvMjlNcmNyQjVOMEFMMHVHR1FzR1ZoVnIyRmV6?=
 =?utf-8?B?UlNzTE9Tc0VtdjBhS1NUYVpTMVZNSnQwVWVuTU1SYXNHOHdxT3pRMHhQZ2hw?=
 =?utf-8?B?eXY5cENUd3JLck95OFBkSk9FdjNoWlZwaThIQTRlVXovZFlwaWV1b09ITzBE?=
 =?utf-8?B?QkxGdTBnbVFqT3kvWDBRRjcyR1FydG9VRUwrRnM4TzV0S05KREtnYWZEZlFk?=
 =?utf-8?B?VmN5N0lpQ1lFZm1IYTVIZzdmK2pXbUhlb1pnajNTSithNkZ6S1VKd0NzTlc4?=
 =?utf-8?B?dEhSRzZhd21KS0l0WDN5SmhFMmVhUENIemJSTEdPUHM5VnpZNndIS1RxRXRk?=
 =?utf-8?B?M2JEMi9HRXZqRzVvR0I0R0NmUWZqTXhPeUp0bmZxMGRuZGRRR0NTd3dSTndy?=
 =?utf-8?B?SkowK3h1Z2k4MnFnekxVSzlLYXBLRThpTjN6U1VZaUFocUlsbCtUZ1JrNkpv?=
 =?utf-8?B?Y2F4VndRMkZvU3h1MXRnQTROTjI0YjNWUVF2SjgwT0dDZDR6dnliYUtDKzRN?=
 =?utf-8?B?T3JHWjBFQmxNQm1aRFFCakIxdzhsdXRFbWMwTmQwUXp2czh1bGpVTDg5STJU?=
 =?utf-8?B?Y2lkOXQxR3hUZTNBajNNYlVhS2hwcktZeTU5RFFGM2NzdzZsN0RPSGtpK2d0?=
 =?utf-8?B?QU10dXpyVGhPdEVkL2tCU0R1b3dEcENSa01vcDNZOTY4UWhiQ1lXN01LMm1z?=
 =?utf-8?B?UVR5MU11L3hIck1yYmtGTnMrRCttSnNqZGwvWUhwSlIvT1BtU1lTb1pUVlpJ?=
 =?utf-8?B?MFMrUWsra3NocXFZNHFacmlHOTFQZjlYU0c0Q0s4ams2TFJPeENva0dQTjFY?=
 =?utf-8?B?Z05BcnNwbHZpbUJpZVdib2ZpRzduQkRXN0JuZ1hmVTZoa1dXT01sSzFNRUdn?=
 =?utf-8?B?UHBUVWl2VkJrL05BcEJ3R2UwRFJLU01JbzJHa0VrQUMyWnpwd1BIZk5jNDBJ?=
 =?utf-8?B?N1lNN1ZYakNITHUyMld6Z1hpakRNTmdIZXRzYmxhc0w5c2NmNzEyb1NCRTJz?=
 =?utf-8?B?NURvd0dybncxUnZBc1hYWU5LY2V3RXF0UEpsWjNmcjU0UndhVWJlSER6M3Zi?=
 =?utf-8?B?ZVhzY0dNV1pmNldLYm9adGpiUlJBdFNINEtiQ3hVODRJVGN2T1ptUjg2RTJk?=
 =?utf-8?B?dzhnbDUxdXhsYWhSejBLTGo2YjFlejQwUjVuWnlwWFBWWG1mNEZRMFRHTGpy?=
 =?utf-8?B?ZVZoN1JpU0JXWDJyRUVQU1JqLzJVZ1RMeG9MWlRWTVlYS1NHaThydkRXa2FO?=
 =?utf-8?B?MWxFK1VlRk9IKzNzZWFML1Bid0MwR2FKVTg4ZS9yQXZYM1d0Q1BwdmVGaXBY?=
 =?utf-8?B?UmVyYWk0M2ZXREpJaE9lRlZ2RmgrbmNJUERlQTk0RHRlODBIaWNPbExvVEg0?=
 =?utf-8?B?R0tPYWo5VHlSOWVyNnJxY2l3Y2ZRMmxrajVxRDd4dXVnV0JzaHZpMXZ4SGZP?=
 =?utf-8?B?YzhQVktMMXl4ODFpZEY5UmtuR1N1Sjk2MkRNR2pYQ0MwdU4wTE9xc2ViMkVW?=
 =?utf-8?B?RnlYMW9tdWt0K2FVSUJUVlZNKy9hZXRhRnlybm5CUlJMcFFleUJNWXdSaDVu?=
 =?utf-8?B?UUZaaEZTL3RGTk5QYllMOUx2NEliVzM3UEVMbXlGTW5wOERFbXhhRWc1cGdY?=
 =?utf-8?B?aXYyNnFKVDY1UjdYU2pmTWp3aHZLdmhUcGtYMEEyTHBjMGlEZUZmQTBRd0Rk?=
 =?utf-8?B?dXhwWXo3UGhibENFWUtlWlBoYjBGUnRDcGNMYzBqR2FwU2FqWHVFVnZjU21j?=
 =?utf-8?B?d1doSWVwMlpBbEZRYmo0SWV3WjVNM2RUOXV5ZHZXRkwzQzhkR1RTdGx4UnV5?=
 =?utf-8?B?cmFEcHcvREtvU0EreHo1eWJJd1plUTI3ckFZaExXdnk0a2lia20rWGxydnND?=
 =?utf-8?B?WE85cDg4L2Npd2pUU1U0RjhSbUdFT3FIQnZYVVhkbVpSV0xBTXdVa043bDdY?=
 =?utf-8?Q?O/N9zHo5m6JXZGTnPncoUH8ae?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ed0e708-3480-48ec-9214-08db9757d36e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7773.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 15:06:06.9243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lgbH3INbRmAYdr5d28f/H5FAepSzAVdxZXt+hulUItfnDfC7w7qoyf1F7ZtbFdlaq+pnc64Xei4f2H/6xitxzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7590
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TGlrZSBoaWZfc2NhbigpLCB0aGUgbmV3IGhpZl9zY2FuX3VuaXEoKSBmdW5jdGlvbiBpbnZva2Vz
IEhJRl9TQ0FOLgpIb3dldmVyLCBpdCBwcm9iZXMgb25seSBvbmUgY2hhbm5lbCBhbmQgZGlzYWJs
ZSBwcm9iZSByZXF1ZXN0cy4gVGhpcyBuZXcKZnVuY3Rpb24gaXMgdGhlIGJhc2lzIHRvIGltcGxl
bWVudCBSZW1haW4tT24tQ2hhbm5lbC4KClNpZ25lZC1vZmYtYnk6IErDqXLDtG1lIFBvdWlsbGVy
IDxqZXJvbWUucG91aWxsZXJAc2lsYWJzLmNvbT4KLS0tCiBkcml2ZXJzL25ldC93aXJlbGVzcy9z
aWxhYnMvd2Z4L2hpZl90eC5jIHwgMjUgKysrKysrKysrKysrKysrKysrKysrKysrCiBkcml2ZXJz
L25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L2hpZl90eC5oIHwgIDEgKwogMiBmaWxlcyBjaGFuZ2Vk
LCAyNiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2ls
YWJzL3dmeC9oaWZfdHguYyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvaGlmX3R4
LmMKaW5kZXggZGU1YTMxNDgyZGYzOC4uOWY0MDNkMjc1Y2IxMyAxMDA2NDQKLS0tIGEvZHJpdmVy
cy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9oaWZfdHguYworKysgYi9kcml2ZXJzL25ldC93aXJl
bGVzcy9zaWxhYnMvd2Z4L2hpZl90eC5jCkBAIC0yMzgsNiArMjM4LDMxIEBAIGludCB3ZnhfaGlm
X3dyaXRlX21pYihzdHJ1Y3Qgd2Z4X2RldiAqd2RldiwgaW50IHZpZl9pZCwgdTE2IG1pYl9pZCwg
dm9pZCAqdmFsLCBzCiAJcmV0dXJuIHJldDsKIH0KIAorLyogSGlqYWNrIHNjYW4gcmVxdWVzdCB0
byBpbXBsZW1lbnQgUmVtYWluLU9uLUNoYW5uZWwgKi8KK2ludCB3ZnhfaGlmX3NjYW5fdW5pcShz
dHJ1Y3Qgd2Z4X3ZpZiAqd3ZpZiwgc3RydWN0IGllZWU4MDIxMV9jaGFubmVsICpjaGFuLCBpbnQg
ZHVyYXRpb24pCit7CisJaW50IHJldDsKKwlzdHJ1Y3Qgd2Z4X2hpZl9tc2cgKmhpZjsKKwlzaXpl
X3QgYnVmX2xlbiA9IHNpemVvZihzdHJ1Y3Qgd2Z4X2hpZl9yZXFfc3RhcnRfc2Nhbl9hbHQpICsg
c2l6ZW9mKHU4KTsKKwlzdHJ1Y3Qgd2Z4X2hpZl9yZXFfc3RhcnRfc2Nhbl9hbHQgKmJvZHkgPSB3
ZnhfYWxsb2NfaGlmKGJ1Zl9sZW4sICZoaWYpOworCisJaWYgKCFoaWYpCisJCXJldHVybiAtRU5P
TUVNOworCWJvZHktPm51bV9vZl9zc2lkcyA9IEhJRl9BUElfTUFYX05CX1NTSURTOworCWJvZHkt
Pm1haW50YWluX2N1cnJlbnRfYnNzID0gMTsKKwlib2R5LT5kaXNhbGxvd19wcyA9IDE7CisJYm9k
eS0+dHhfcG93ZXJfbGV2ZWwgPSBjcHVfdG9fbGUzMihjaGFuLT5tYXhfcG93ZXIpOworCWJvZHkt
Pm51bV9vZl9jaGFubmVscyA9IDE7CisJYm9keS0+Y2hhbm5lbF9saXN0WzBdID0gY2hhbi0+aHdf
dmFsdWU7CisJYm9keS0+bWF4X3RyYW5zbWl0X3JhdGUgPSBBUElfUkFURV9JTkRFWF9CXzFNQlBT
OworCWJvZHktPm1pbl9jaGFubmVsX3RpbWUgPSBjcHVfdG9fbGUzMihkdXJhdGlvbik7CisJYm9k
eS0+bWF4X2NoYW5uZWxfdGltZSA9IGNwdV90b19sZTMyKGR1cmF0aW9uICogMTEwIC8gMTAwKTsK
Kwl3ZnhfZmlsbF9oZWFkZXIoaGlmLCB3dmlmLT5pZCwgSElGX1JFUV9JRF9TVEFSVF9TQ0FOLCBi
dWZfbGVuKTsKKwlyZXQgPSB3ZnhfY21kX3NlbmQod3ZpZi0+d2RldiwgaGlmLCBOVUxMLCAwLCBm
YWxzZSk7CisJa2ZyZWUoaGlmKTsKKwlyZXR1cm4gcmV0OworfQorCiBpbnQgd2Z4X2hpZl9zY2Fu
KHN0cnVjdCB3ZnhfdmlmICp3dmlmLCBzdHJ1Y3QgY2ZnODAyMTFfc2Nhbl9yZXF1ZXN0ICpyZXEs
CiAJCSBpbnQgY2hhbl9zdGFydF9pZHgsIGludCBjaGFuX251bSkKIHsKZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvaGlmX3R4LmggYi9kcml2ZXJzL25ldC93aXJl
bGVzcy9zaWxhYnMvd2Z4L2hpZl90eC5oCmluZGV4IDcxODE3YTY1NzFmMGIuLmFhYjU0ZGY2YWFm
YTYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvaGlmX3R4LmgK
KysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9oaWZfdHguaApAQCAtNTQsNiAr
NTQsNyBAQCBpbnQgd2Z4X2hpZl9iZWFjb25fdHJhbnNtaXQoc3RydWN0IHdmeF92aWYgKnd2aWYs
IGJvb2wgZW5hYmxlKTsKIGludCB3ZnhfaGlmX3VwZGF0ZV9pZV9iZWFjb24oc3RydWN0IHdmeF92
aWYgKnd2aWYsIGNvbnN0IHU4ICppZXMsIHNpemVfdCBpZXNfbGVuKTsKIGludCB3ZnhfaGlmX3Nj
YW4oc3RydWN0IHdmeF92aWYgKnd2aWYsIHN0cnVjdCBjZmc4MDIxMV9zY2FuX3JlcXVlc3QgKnJl
cTgwMjExLAogCQkgaW50IGNoYW5fc3RhcnQsIGludCBjaGFuX251bSk7CitpbnQgd2Z4X2hpZl9z
Y2FuX3VuaXEoc3RydWN0IHdmeF92aWYgKnd2aWYsIHN0cnVjdCBpZWVlODAyMTFfY2hhbm5lbCAq
Y2hhbiwgaW50IGR1cmF0aW9uKTsKIGludCB3ZnhfaGlmX3N0b3Bfc2NhbihzdHJ1Y3Qgd2Z4X3Zp
ZiAqd3ZpZik7CiBpbnQgd2Z4X2hpZl9jb25maWd1cmF0aW9uKHN0cnVjdCB3ZnhfZGV2ICp3ZGV2
LCBjb25zdCB1OCAqY29uZiwgc2l6ZV90IGxlbik7CiBpbnQgd2Z4X2hpZl9zaHV0ZG93bihzdHJ1
Y3Qgd2Z4X2RldiAqd2Rldik7Ci0tIAoyLjM5LjIKCg==
