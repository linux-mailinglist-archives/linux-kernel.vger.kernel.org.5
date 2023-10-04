Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC9847B868B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 19:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243703AbjJDR3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 13:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243698AbjJDR3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 13:29:11 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05509C6;
        Wed,  4 Oct 2023 10:29:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fzhEmLqZTWK/E7tYnq8b7SCCYwrECuTcxDsjtdqz8rwtgwX9ljPPjDxTvfHclOUIALnEGnsmYY7SGG4+pz0TOQb0CHuZgKCMkdvc0JrUQCENgIIHB28uvOXhKwkgY6VQEEI8Y0KbK0T8sGupRzik8ALh3P/jLFukisl2mqlQuQHgsq+txmk7eskhusSfLWXtc/0vO6+jRDzebZrvGCkVfIXi3ksdomTdQV7dpoFm7eabpk/yplX9wajnud3RS7BTR7/pCYwieL1Yw0oWcUfTOiiYQokVTVaCGigaZnS+NXV7KH5kBP31ZlQtBlB+n58xmJHGklqHD/M/9tGO+O3jew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bjGVnnI4IgQWVESipP4NJkbr9TxmMmdc9cZT7TgzWTk=;
 b=ZnYZmvPqNbdn2FY20SPI8mEI3Ll7MqB3DYhCZ9VKF4ASCKfhXagF5piyGdRDA1tUX6edWFPEfdTK4nXBbT7hYBebbB1mfeY4lVcXMuSgrDoee0g6ewud+fYOybTyIkRUgvlxvAwezyHjhGhU+iGlRIXmco0E6coHyaSs1/BrC3twBtcTKG1WmFOavN/iLa04s5TvaaQE3LDXrY9EKnXyZ/rvtGe51kVjJKSotMCdBn3xm/jxsU94ej1mk51zmMhlO3/QHdBt5V8lWsjJL89IBGIL4KwkgUMc/n3tClpISUjSXz41PBSA6k2VXio58L+YXlFgQ7Vy0mLP3zmRyHYXDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bjGVnnI4IgQWVESipP4NJkbr9TxmMmdc9cZT7TgzWTk=;
 b=DsYClD3F1hb8tlx6MGj12XK6Jb/TMzdjDZXSxUKgdhmFJIfVZEbfkDwBZmbH3bXLgS3V9TL2RTGbI56rsa5qYl82IzerkWJv29Xp805Jrz6DiPXTW5zUzMWQ81EdLMbhkNvRb+y/lWBzBMdm72TxLgge6UM+6ylx3yuqol0Tosw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=silabs.com;
Received: from IA1PR11MB7773.namprd11.prod.outlook.com (2603:10b6:208:3f0::21)
 by PH7PR11MB5982.namprd11.prod.outlook.com (2603:10b6:510:1e1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.34; Wed, 4 Oct
 2023 17:29:00 +0000
Received: from IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::d6c8:4cb6:2594:d8f3]) by IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::d6c8:4cb6:2594:d8f3%4]) with mapi id 15.20.6838.030; Wed, 4 Oct 2023
 17:29:00 +0000
From:   =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>
Subject: [PATCH v3 3/8] wifi: wfx: move wfx_skb_*() out of the header file
Date:   Wed,  4 Oct 2023 19:28:38 +0200
Message-Id: <20231004172843.195332-4-jerome.pouiller@silabs.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231004172843.195332-1-jerome.pouiller@silabs.com>
References: <20231004172843.195332-1-jerome.pouiller@silabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-ClientProxiedBy: DS7PR03CA0305.namprd03.prod.outlook.com
 (2603:10b6:8:2b::25) To IA1PR11MB7773.namprd11.prod.outlook.com
 (2603:10b6:208:3f0::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7773:EE_|PH7PR11MB5982:EE_
X-MS-Office365-Filtering-Correlation-Id: 96a3ed65-6213-40be-c91a-08dbc4ff64f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cAai/+v5EiR0UyMEBN7cY1b7yGJWGiJWIAWHtNIpBDZVVB1ld+K53U5Lws2Fouj2HRWyCoqJipoNpgbIWDpCy+JlRH4ys+8Ha2o7r4JiAJ3FdXFwrVVYT3v7GRVwbmuin8panSxHMHS7FNFBmGa94yf+WCUzW7MUzeEzwawz656zhLV/sdCfJmAnd9Hi98/8edcdI8gizVHfgAoQOW77Lojmlyyw6QYmHzZEN6EnJeaIIBREKN41iyJ+g2GNRgm3sB1r6tsrOEzBVxLz+pJFj8QO6lW1A2XtIpDkhGE0HTzCQqg4yAizubxfUsfY4uodu49KJx2d2szv5Devu1FkjoYNbNiDHd9qYtgl/q89oJsSBviT2ToYp9KsmrAYu8f9y0HRbQW8sc/S8/mlaaZU8FIgvHEd6wYvXPF+anO9H1a7lxClqPu03RIOlKwogtZbyoFmLnk+jdThNqvX7AI3d4zafpM71RMnQlR/0oe6/TZHl8XFPeQilFr+WabpYXGkoAUnIIGMyCMtcznFCIiMtQ5vKQHUes+Df+z5p3ZFkLCpayt59DEuDQ1IXJ/81sRp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7773.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(346002)(39850400004)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(6486002)(36756003)(6512007)(38100700002)(6666004)(52116002)(86362001)(478600001)(6506007)(66556008)(66946007)(66476007)(316002)(6916009)(41300700001)(2616005)(107886003)(1076003)(8936002)(4326008)(8676002)(66574015)(5660300002)(83380400001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWRHSzV3VnRGaHgwdUUrN3dyWEN3dVgzZ0U1dnZYb3ZUenBENUFxZXdPRW9S?=
 =?utf-8?B?dkMyVkVSUktjbDl4N0pCMk5WdGRxMnlpbjE2WkNCOHRRUWN5MVduZlQ1R2w5?=
 =?utf-8?B?RUpWbkF4Z244RXBkNXJTdGFabE9tdzFXNGxiMXV3K2lReWNGRWM0VUtrdDlx?=
 =?utf-8?B?Tm1TZjFnc0g0M1lBWHlDemJ5NmF2Z1pMOWVuOXhsS3NDYjQveHJFbU5qaDZV?=
 =?utf-8?B?Y0ZMbU5Ra0dGWTZTOXlvUkE3V09aUUg0eDVTT2Z3QkZZanBBU1NvMVJ4SkYz?=
 =?utf-8?B?bTlxVzdZMG9INXRod2lhQ0hmcVR1bTZMMnFSWTJ1T2swdG1pVXEwaTQvdVp4?=
 =?utf-8?B?Y21sNDlTQUJ6VzN0NXlnNTU5RkVJeUlsVGN1ckRINVFXOWdXSXhHaHQ2NkFm?=
 =?utf-8?B?NHJGY3VUTll4QkxPdlRoK0F5T0o5SDlkZ0lnUEFQQzQ3VElMSVFaMVZ6TFdG?=
 =?utf-8?B?ZnU3Sm1BRVZiK0RhdnpudkNnVCtrenBnOXd4Ni9WcHVjS0pFM0VzTC9ITnJB?=
 =?utf-8?B?QTZ6MUdlZzVtVFdYQlN6ckUyM0JUc3kzc0QzTjYxTC9wYlo2ZFluVVRUU05m?=
 =?utf-8?B?cEk5MFAwYXlWVTJBS0FjWkw2WE9aU2NDdldOUllqYjNXNjh3Y1ZCbWFLNUt5?=
 =?utf-8?B?cUhCZE4wUDBzWEErVlB4cnBTNWRSb09STnVPR01kZnc3R2IxVjR5SDFMUlRT?=
 =?utf-8?B?bXJJVEF2cDVqdTJ0NS8vSm45ekRyQXdnd3ovN09URkdVYnRTSEYxdnpTK1Q1?=
 =?utf-8?B?WUxpajRsclhwLzE2T0U0emZ4ZnREcFhSU1BxbklJWWEvUjVqSDRObVY1ZVlr?=
 =?utf-8?B?OHhBWE9MdXBpSy9mUy81bEZIbTI3dlJDUkhHUS83S2N4UUxpSjRTa3ByZnlC?=
 =?utf-8?B?NmswVVFUZ3BUVmxXcjBmTW5rK3cyU2dEL251KzVlRi9IeDRvb1lUaTlabEpI?=
 =?utf-8?B?eGFxbStzQzlNWDg1KzY2Y25hdWV3MGdwSndmbjFiRThFbnBtWDM4eUZYVlgy?=
 =?utf-8?B?dE1pMWJLVFJVNUlXbnoyTU5Cd2k5R1NhdHlJeHFYcXI5cjE4d1EwYnVkczFs?=
 =?utf-8?B?RDRjWVVMUDI2NnVGZCtKbnFHNjlJOWtEVHRZeUpUdGtsQ2ZVOXBKbVVlbnNS?=
 =?utf-8?B?NHVsTmR1ZDRPUmFJM3RtYVFvZjhFRGcrcHFJdmRrVHlJN3pkeU16bVdzMlVQ?=
 =?utf-8?B?ZlhvV1BZOENnSUtTVkd4emplR1lQZ2ZjOFQ5YUcrT3g5MTFNMFhManV1Y1Qx?=
 =?utf-8?B?TGJ2MzlvQTgxaFFjUDhzcE04TGFiWVNSWWpNVkpKZUY1RmpyWlM2WU1Ba2pX?=
 =?utf-8?B?U1J4TmpwaS9KdkExN2ZuN084UDA2K0NrKzdGN2o5U0ZBQzNieFg1QTBoTWRM?=
 =?utf-8?B?Q2dpb2dTajNqamwyWWV3bEp2UkxQRUo5OFFIc2FNNUd4bXd6SmNDOUxCcmZJ?=
 =?utf-8?B?MWVWeWlFRHRMSzJ3RWVYMUl5NEVmbEdNNGgzaXFBOHNjUGMvVUc5T2xqOE4r?=
 =?utf-8?B?Wk9oSE5kRit4K1dLYm5XRXpObDFadENwVVFadVdNSHdQdU80eGlmRGh6YXhP?=
 =?utf-8?B?YjhPdm1PVDBjemp3Mm10K1lNbWZ3SHRIS1R0Z3lVbVFRdExod2theUp3cFJk?=
 =?utf-8?B?dWw2SEcwTlV3SU4vMS9leHUzSjlpcmYyVk1HdytHMCs4bGhSSkswLzNDaGUw?=
 =?utf-8?B?enBra1IrcUorbStkTW9hQ3FmTG5hYTVHUE9zV3BOVnFnUVJQMW5uVWloQ1p4?=
 =?utf-8?B?ZytCSTA3Q1c1Y0RCYW4xUHdrNUZCbE95YzBoRUFtRzU0dUM1THdYUThhRWNX?=
 =?utf-8?B?OEFuMXM1TFk1QlUybjJEaHRNTFpUZ0VKTGhJRldWUlRKTEpFU2dzU2Y1TFEy?=
 =?utf-8?B?OHBoTlFiOSsxeUhGOXp6MkdYNDF4UVlQQlZmTGR6d0VPaE1yRkVkbks0Ni9y?=
 =?utf-8?B?dkxlSTJlb2lkazk5MVlZSzBlQ2FxZ24xOGJiRUY5KzQrS3VubU5sSzJqbkt6?=
 =?utf-8?B?Q0EwMDRSM2lkRlBnR2lRSHlhOFpIVTNMTFNMaVZocDNHekhkNklaZXdxNk5i?=
 =?utf-8?B?SjhadVBDUU9naWJuTzVEMTFudkFPNGNGdVp4cktvL0xKOGRkRHJoWDV1Nm40?=
 =?utf-8?B?SW5xOWVGT1B2eHRtbGRHV3hQYml5NHYxVVFzS1VTdmd6NVg0RFJQelVVcmJU?=
 =?utf-8?Q?9Jvh1LlQTxXHxC9yDYAqKx7+tu88kbsizSI4C8QHEdGq?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96a3ed65-6213-40be-c91a-08dbc4ff64f1
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7773.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 17:28:59.4420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: atBr3ZKTFmXdbGgCLnhQ27llKTyNV+aCWoQ0XYqwosJaEi6DzbAQ2nVxaEla2+B81IJKMIZ6zS7lJzwPHpUOmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5982
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlcmUgaXMgbm8gcmVhbCByZWFzb25zIHRvIGtlZXAgdGhlc2UgZnVuY3Rpb24gaW4gdGhlIGhl
YWRlciBmaWxlLgoKU2lnbmVkLW9mZi1ieTogSsOpcsO0bWUgUG91aWxsZXIgPGplcm9tZS5wb3Vp
bGxlckBzaWxhYnMuY29tPgotLS0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvZGF0
YV90eC5jIHwgMTggKysrKysrKysrKysrKysrKysrCiBkcml2ZXJzL25ldC93aXJlbGVzcy9zaWxh
YnMvd2Z4L2RhdGFfdHguaCB8IDE5ICsrLS0tLS0tLS0tLS0tLS0tLS0KIDIgZmlsZXMgY2hhbmdl
ZCwgMjAgaW5zZXJ0aW9ucygrKSwgMTcgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9kYXRhX3R4LmMgYi9kcml2ZXJzL25ldC93aXJlbGVz
cy9zaWxhYnMvd2Z4L2RhdGFfdHguYwppbmRleCA2YTVlNTJhOTZkMTgzLi5jZTJiNWRjZmQ4ZDg5
IDEwMDY0NAotLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L2RhdGFfdHguYwor
KysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L2RhdGFfdHguYwpAQCAtMjA4LDYg
KzIwOCwyNCBAQCBzdGF0aWMgYm9vbCB3ZnhfaXNfYWN0aW9uX2JhY2soc3RydWN0IGllZWU4MDIx
MV9oZHIgKmhkcikKIAlyZXR1cm4gdHJ1ZTsKIH0KIAorc3RydWN0IHdmeF90eF9wcml2ICp3Znhf
c2tiX3R4X3ByaXYoc3RydWN0IHNrX2J1ZmYgKnNrYikKK3sKKwlzdHJ1Y3QgaWVlZTgwMjExX3R4
X2luZm8gKnR4X2luZm87CisKKwlpZiAoIXNrYikKKwkJcmV0dXJuIE5VTEw7CisJdHhfaW5mbyA9
IElFRUU4MDIxMV9TS0JfQ0Ioc2tiKTsKKwlyZXR1cm4gKHN0cnVjdCB3ZnhfdHhfcHJpdiAqKXR4
X2luZm8tPnJhdGVfZHJpdmVyX2RhdGE7Cit9CisKK3N0cnVjdCB3ZnhfaGlmX3JlcV90eCAqd2Z4
X3NrYl90eHJlcShzdHJ1Y3Qgc2tfYnVmZiAqc2tiKQoreworCXN0cnVjdCB3ZnhfaGlmX21zZyAq
aGlmID0gKHN0cnVjdCB3ZnhfaGlmX21zZyAqKXNrYi0+ZGF0YTsKKwlzdHJ1Y3Qgd2Z4X2hpZl9y
ZXFfdHggKnJlcSA9IChzdHJ1Y3Qgd2Z4X2hpZl9yZXFfdHggKiloaWYtPmJvZHk7CisKKwlyZXR1
cm4gcmVxOworfQorCiBzdGF0aWMgdTggd2Z4X3R4X2dldF9saW5rX2lkKHN0cnVjdCB3Znhfdmlm
ICp3dmlmLCBzdHJ1Y3QgaWVlZTgwMjExX3N0YSAqc3RhLAogCQkJICAgICBzdHJ1Y3QgaWVlZTgw
MjExX2hkciAqaGRyKQogewpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJz
L3dmeC9kYXRhX3R4LmggYi9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L2RhdGFfdHgu
aAppbmRleCA5ODM0NzA3MDVlNGJiLi5hNWI4MGVhY2NlMzlhIDEwMDY0NAotLS0gYS9kcml2ZXJz
L25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L2RhdGFfdHguaAorKysgYi9kcml2ZXJzL25ldC93aXJl
bGVzcy9zaWxhYnMvd2Z4L2RhdGFfdHguaApAQCAtNDUsMjIgKzQ1LDcgQEAgdm9pZCB3ZnhfdHgo
c3RydWN0IGllZWU4MDIxMV9odyAqaHcsIHN0cnVjdCBpZWVlODAyMTFfdHhfY29udHJvbCAqY29u
dHJvbCwgc3RydWMKIHZvaWQgd2Z4X3R4X2NvbmZpcm1fY2Ioc3RydWN0IHdmeF9kZXYgKndkZXYs
IGNvbnN0IHN0cnVjdCB3ZnhfaGlmX2NuZl90eCAqYXJnKTsKIHZvaWQgd2Z4X2ZsdXNoKHN0cnVj
dCBpZWVlODAyMTFfaHcgKmh3LCBzdHJ1Y3QgaWVlZTgwMjExX3ZpZiAqdmlmLCB1MzIgcXVldWVz
LCBib29sIGRyb3ApOwogCi1zdGF0aWMgaW5saW5lIHN0cnVjdCB3ZnhfdHhfcHJpdiAqd2Z4X3Nr
Yl90eF9wcml2KHN0cnVjdCBza19idWZmICpza2IpCi17Ci0Jc3RydWN0IGllZWU4MDIxMV90eF9p
bmZvICp0eF9pbmZvOwotCi0JaWYgKCFza2IpCi0JCXJldHVybiBOVUxMOwotCXR4X2luZm8gPSBJ
RUVFODAyMTFfU0tCX0NCKHNrYik7Ci0JcmV0dXJuIChzdHJ1Y3Qgd2Z4X3R4X3ByaXYgKil0eF9p
bmZvLT5yYXRlX2RyaXZlcl9kYXRhOwotfQotCi1zdGF0aWMgaW5saW5lIHN0cnVjdCB3ZnhfaGlm
X3JlcV90eCAqd2Z4X3NrYl90eHJlcShzdHJ1Y3Qgc2tfYnVmZiAqc2tiKQotewotCXN0cnVjdCB3
ZnhfaGlmX21zZyAqaGlmID0gKHN0cnVjdCB3ZnhfaGlmX21zZyAqKXNrYi0+ZGF0YTsKLQlzdHJ1
Y3Qgd2Z4X2hpZl9yZXFfdHggKnJlcSA9IChzdHJ1Y3Qgd2Z4X2hpZl9yZXFfdHggKiloaWYtPmJv
ZHk7Ci0KLQlyZXR1cm4gcmVxOwotfQorc3RydWN0IHdmeF90eF9wcml2ICp3Znhfc2tiX3R4X3By
aXYoc3RydWN0IHNrX2J1ZmYgKnNrYik7CitzdHJ1Y3Qgd2Z4X2hpZl9yZXFfdHggKndmeF9za2Jf
dHhyZXEoc3RydWN0IHNrX2J1ZmYgKnNrYik7CiAKICNlbmRpZgotLSAKMi4zOS4yCgo=
