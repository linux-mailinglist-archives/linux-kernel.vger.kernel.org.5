Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4D27B8689
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 19:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243463AbjJDR3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 13:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243500AbjJDR3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 13:29:03 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96217E8;
        Wed,  4 Oct 2023 10:28:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NnCjr5HGRVO3jNX3vrGW/D4NRHwGFfCqK+5icF5MZ3yrT8EDq/SrhNtCLZqs/JftDPjKpt8ViTynfL7i+VGaKGtCr7xaqfrfC04XakFx6n7cb1LhE60l4hm5O10GbibQ8WktO3KSM5Wzb+nqJ459JRMXXqSvpuQoRTguNLv+6HqyQuQ/AUcK3IvgyF21Qyi+CtekA7W+8DwFiwo+lFK/6/b6uyAX8Pbusw9Sebo70WesRv6VdzjSoTghuKv713uHcAkMSqsdKHmMmysyoqh4+g6wUkeK6KqSBYJMMqHrn876UuI2XwqeON1p87vOX5Tjjxmdd1ZMeEgwKiPcuG3Ghw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UXDDYAw/FjyHzqsuvUPP7L/NGfzvmZvOut33xSEA38A=;
 b=CdWHhj9L5H6UtQazDUkdnUTzgn55yFcznsC7X3puTFuT5vU1nmERl5t3BxyxlAyvNDzSDCp4jYssEL2U2YnyFLItYEFsWowU6e0ENswyckOf6lebYZqfsyFgNlj+bbSC9sQ7H4KpdrX9YH8aKYB5Hv/rSt5AvEcFFwG87D57m2uWQb6r+wPDfoUfUaMLRr1fhP9GldmWaq7hrrjf6JUOMW1ScMtp28xnenWM+A9bYAaw67ek7Ww+9ZXZaA7r/w8NOqvC9PjY12pqYlv0inLiH4sQ2qEtFwTgKNgHnkGzESiAiU70yfPlUhnK9r981ZoVRoeIgEnr/hRDJPdmGdpRng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UXDDYAw/FjyHzqsuvUPP7L/NGfzvmZvOut33xSEA38A=;
 b=mU0kOUB7FU70K3UAV/6b8ayd3UxUvO7Lvg4uxeOodynbdBqd7KEdaRCBMlAnfPDvsKxRZxQ2LjidaKVINLXxoemGlBG0iMKap8NuSRnd9bkm4RXxkxtmjzzmM7cobqjzHVtiDiDQRiyyTJraY2zXXT/qsD2eN2B5A/zgC/QYD9E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=silabs.com;
Received: from IA1PR11MB7773.namprd11.prod.outlook.com (2603:10b6:208:3f0::21)
 by PH7PR11MB5982.namprd11.prod.outlook.com (2603:10b6:510:1e1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.34; Wed, 4 Oct
 2023 17:28:55 +0000
Received: from IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::d6c8:4cb6:2594:d8f3]) by IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::d6c8:4cb6:2594:d8f3%4]) with mapi id 15.20.6838.030; Wed, 4 Oct 2023
 17:28:55 +0000
From:   =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>
Subject: [PATCH v3 0/8] wfx: implement Remain On Channel
Date:   Wed,  4 Oct 2023 19:28:35 +0200
Message-Id: <20231004172843.195332-1-jerome.pouiller@silabs.com>
X-Mailer: git-send-email 2.39.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-ClientProxiedBy: DS7PR03CA0305.namprd03.prod.outlook.com
 (2603:10b6:8:2b::25) To IA1PR11MB7773.namprd11.prod.outlook.com
 (2603:10b6:208:3f0::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7773:EE_|PH7PR11MB5982:EE_
X-MS-Office365-Filtering-Correlation-Id: 54426577-c80e-41c3-5df1-08dbc4ff6251
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bw198W5HXHP36GttJybJ+qs7jL/LYtIbEeyKnNhKstZXydPzvUoint5qYM+ImQxqGdP7UnIKSGdvVHtkwi3HeJETwPTBCRdLJmVSqiP/XcFlWvzQqzmM1iVYvYv7q73TDgrXT+UuJjifZX4ExSgbtkv8oHmWUieileqjpTUuel0CEau08WwU55EWI/kX5ZmqfIJ6NmsCSjFWr6C0guWgklmXsF08A7KJpHAgAu4RMjHU0W1gytZCwSKUE1LEU10bxt+/uR7rIldYeUfd44ecDVnmzE4OxfzpIHlHJEaiV1B8xRjq30xFNPsCJwt/704sG/LXwFKPt/VhA+t1rInofvUaSguXQFOehxovFZsnuUKG4K5xeWSP8ORcCmwD8Nm2ZSddNcWMCfnDbTfmIjb+C3y7IHsoElGocpd0ei0Xtf/7HT/2KNMWjLYrtZODuz7yo+kLmecaCccKWhwFWfaZv0FPhZf9mjoidFfpHmt+p281mUYlmvIJwpPE4wqR8a91q8MZH5s80ST8hYF2S0P1Pv9RX8gKDLEFOsq33cqDQpHiZZSlhWlJNf/09Y7s62VL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7773.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(346002)(39850400004)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(6486002)(36756003)(6512007)(38100700002)(6666004)(52116002)(86362001)(478600001)(6506007)(66556008)(66946007)(66476007)(316002)(6916009)(41300700001)(2616005)(107886003)(1076003)(8936002)(4326008)(8676002)(66574015)(5660300002)(83380400001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3dpOWhEMzV5WG1jWjZNSmlieHQvUjNZQmhJVithSUNhTEU3OFQyUVhuU0hh?=
 =?utf-8?B?b3gyaFhGOERJTzFoVkYzOGZUaEFLbTRBYmZtQU56SlFvdEZud2hMMmxwb0RO?=
 =?utf-8?B?Rml6OC9mYTZselZUUDFIVHY5emZFUTBFVks2ZWZldWptemhxQndtQXRwZDcx?=
 =?utf-8?B?ZG5COEE2QnBJbEJTQ1pJTzlrODFnazlVUU9hMEl0aUpETEZMS0RueFlKZDZ1?=
 =?utf-8?B?TDFoalErYnJ3d3pudnhaQVdPUTJjSWx0Q3ZlbisvWGRxV0pEcnRKeXVIYW55?=
 =?utf-8?B?ZEwxZkYxOXAvdjRLajhsUFE3bm9ydzhVSlBWRzJuVnRiSE56RndzOFRmUEJY?=
 =?utf-8?B?K3Uwd3p3SnZUbXRYOW9FRWM4dGhOVmVTdURzZWsxUDM0YzdRZzBpT2NFQ3VS?=
 =?utf-8?B?aEN1V2I4UlJzQXgvcVVqMEE5UDVvOWxRbzhCc2xWZ3RPRUM2YTEvWDNuVXgx?=
 =?utf-8?B?VU56cDRFaGd4T0ZEMmIxMnhlaFRMZXU3ODBWQ2g3TEtSVktXY1ozN2xVcVFZ?=
 =?utf-8?B?WSs0MUVOTnM4SkhWVGYyczU1b2tqaE81Ynl5cVBzWFJXc0dVSE83czZ5LzV4?=
 =?utf-8?B?ampwcitPR2lpVFE5K1BEbkpmTDRyV1BPSnhSRHMxbXl1bWNsbWpvTE1nY2pX?=
 =?utf-8?B?UTB1T3Bud1RxOWliUk9wSDIrYzBob2pVS2w5V1FBUkNhcnR4UFZWemNoQ3Rh?=
 =?utf-8?B?S1BhWE12UzZUQ1gxT2NuRWRxc2pIWWVvNTA4Rno5Q1lEeS9EenRHQkpYMGVR?=
 =?utf-8?B?NEhBRGdaSUE3M2tPcjFqaGpGZ05QcW1qTDV6bnBZcitjcXlPclAxUDJaN3Rk?=
 =?utf-8?B?NEpRaGI0NUNBSThSdzZhb0FoUS9PZlJTbElWMk9CeGV6YXJvQjViQ252VFAv?=
 =?utf-8?B?OFhxaFV2YUhyM29yRmJ4cHl2bUhXNmJEMGQ3RkVrclp2KytGUDBZbTJxQ2JG?=
 =?utf-8?B?VjcrMThBSTJnMzdkSlA3c0tlWVlERUFkRGZSekRLYTA4cVdQTzgwZzJLZlJJ?=
 =?utf-8?B?SzVRZkc2dHFQdTk5TnhpN2J0bTU0OHI1MFpnTkZuYmpmK0tHZjJhS3NwOWxM?=
 =?utf-8?B?RW9ESU9KMlhJbSszc1VoUWJ2UWpHRkh0YlBablRrV2Z6SkhHeFFCbXNLZG44?=
 =?utf-8?B?Q1IrUEhKUjJaRnM5MXMwOFo5WmFva3dXc2c4bTRndThOTERXZkxCYlcrOElP?=
 =?utf-8?B?Wm5JSlA2VlBqMzljNEdzWlU0QXVhMGg5VFE3L2JCMUJFTUUvdkIvWEFpcnBt?=
 =?utf-8?B?OXE3RHhCeXFYWmpqMW4yL2NDYUZEVVZxclJUK3RyUEFaME0yK1JYRGhYRFA1?=
 =?utf-8?B?Sy9VVy9TRm4zaVFqeCtVVmJRVzJSNlFyRk55bXFDVkRBekFMYVhmL0J0Q2VG?=
 =?utf-8?B?eW9WV3Y2dFlsaUpSM0c0ZVVaOVhRUEdoQkx2RTZBQkEzUFJKRzRNL2d4UlBu?=
 =?utf-8?B?a0VMWWpON29ubVdzb2xJTmlMOU9uT004MXVkU3RyUVh3WVZPcHFDT1hydDF3?=
 =?utf-8?B?QkJsZ0Z0ZXBUaDgzeDV1bnhYK2szV3FwUlcxZDhUTkNrS1ZURTJ6MjFUQXps?=
 =?utf-8?B?MXpaMUVXajhaSHJtcUdiN3IrQzB3QUFJYWkvM2JFM3FzWEZrQ0lkeUQ5U0h0?=
 =?utf-8?B?aFN5WjFEeVZmNzhWdG4wZUVJdTZZcnJQdFlMTDQ1UVVLekZRZEsxOUJKRVF0?=
 =?utf-8?B?SnNhNFNVK3FMSXpPOHBrWWFFNmV5cVVKL0lRQUpPMS9tc0QwM1BlamZIRyt0?=
 =?utf-8?B?UThuZENaSkJ5OEhZV1pXYjc1bFBPcG9EVXlFZkVPdXdyTDYwMVJWa3l4bFVi?=
 =?utf-8?B?V0FmQ1NEWkNrbHVHdDh3Mk1OVDQ2N0V5TWpKNlhMOG1XNlhIUWMyMzAyMys3?=
 =?utf-8?B?SXQrTFpRS0ZHRUduU3VGaVRzdUFVa0NtdG1jNCtmS1o5RzM0bzJnSFo1ZXRW?=
 =?utf-8?B?bUF2TGtKdE45MkVwcVpvclJsTFB2U3RIbis4QUNGQTkwQzZsUDRtcllYNHln?=
 =?utf-8?B?ZGxkNUlnNlRSVTFPc2cvYWhaQThBeUszYmpnUENzTjF5d09Lb1hSWUhKU1Jv?=
 =?utf-8?B?YkV1bGxxRXVtd1pIWHlVTFAzWWtRd29ZMVllQ2dDL1dEU3grbjEzTTVmZHho?=
 =?utf-8?B?UmdZZmJidXdyYWwwZHRWM2duTmtXRWNwZkFFdFI4QlJYK0NNNnc5OVB3QzZH?=
 =?utf-8?Q?af8JnqX3ay28mahxRI0nr8qC6DOqz7w5XaKT8ZzITzYv?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54426577-c80e-41c3-5df1-08dbc4ff6251
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7773.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 17:28:55.0427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8J8RphoW/hzbVTdbt7iTneTu7XLBc+x2yXH5vaNq8FKwLjV+t8aW02xJ9MuwcIbGQjmyG1a0KM4js2fURMbgfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5982
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sCgpBcGFydCBmcm9tIHRoZSAzIGZpcnN0IHBhdGNoLCB0aGlzIHNlcmllcyBpbXBsZW1l
bnRzIFJlbWFpbiBPbiBDaGFubmVsIGZvcgpXRjIwMCBjaGlwcy4gVGhlIGltcGxlbWVudGF0aW9u
IGlzIGEgYml0IHR3aXN0ZWQgKEkgaGlqYWNrIHRoZSBzY2FuIGZlYXR1cmUKdG8gaW1wbGVtZW50
cyBSb0MpLiBIb3dldmVyLCBpdCBoYXMgYmVlbiBleHRlbnNpdmVseSB0ZXN0ZWQgd2l0aApEUFAv
RWFzeUNvbm5lY3QgYW5kIEkgaGF2ZSBub3Qgbm90aWNlZCBhbnkgaXNzdWUuCgp2MzoKICAtIFBh
dGNoIDUgYW5kIDYgaGFzIGJlZW4gc3F1YXNoZWQuCiAgLSBSZW9yZGVyZWQgcGF0Y2hlcyA1IHRv
IDkuIEl0IHdhcyBub3Qgc28gZWFzeSwgYnV0IEkgZ3VhcmFudGVlIHRoZSBmaW5hbAogICAgY29k
ZSBpcyB0aGUgc2FtZSBhbmQgZXZlcnkgcGF0Y2ggY29tcGlsZS4KdjI6CiAgLSBSZWJhc2Ugb24g
bGFzdCBzdGFibGUgdHJlZQoKSsOpcsO0bWUgUG91aWxsZXIgKDgpOgogIHdpZmk6IHdmeDogZml4
IHBvd2VyX3NhdmUgc2V0dGluZyB3aGVuIEFQIGlzIHN0b3BwZWQKICB3aWZpOiB3Zng6IHJlbG9j
YXRlIHdmeF9yYXRlX21hc2tfdG9faHcoKQogIHdpZmk6IHdmeDogbW92ZSB3Znhfc2tiXyooKSBv
dXQgb2YgdGhlIGhlYWRlciBmaWxlCiAgd2lmaTogd2Z4OiBpbnRyb2R1Y2UgaGlmX3NjYW5fdW5p
cSgpCiAgd2lmaTogd2Z4OiBzaW1wbGlmeSBleGNsdXNpb24gYmV0d2VlbiBzY2FuIGFuZCBSeCBm
aWx0ZXJzCiAgd2lmaTogd2Z4OiBzY2FuX2xvY2sgaXMgZ2xvYmFsIHRvIHRoZSBkZXZpY2UKICB3
aWZpOiB3Zng6IGFsbG93IHRvIHNlbmQgZnJhbWVzIGR1cmluZyBST0MKICB3aWZpOiB3Zng6IGlt
cGxlbWVudCB3ZnhfcmVtYWluX29uX2NoYW5uZWwoKQoKIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3Np
bGFicy93ZngvZGF0YV90eC5jIHwgNTQgKysrKysrKysrKysrKysrKy0tLQogZHJpdmVycy9uZXQv
d2lyZWxlc3Mvc2lsYWJzL3dmeC9kYXRhX3R4LmggfCAyMSArKy0tLS0tLQogZHJpdmVycy9uZXQv
d2lyZWxlc3Mvc2lsYWJzL3dmeC9oaWZfdHguYyAgfCA0MyArKysrKysrKysrKysrKysKIGRyaXZl
cnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvaGlmX3R4LmggIHwgIDEgKwogZHJpdmVycy9uZXQv
d2lyZWxlc3Mvc2lsYWJzL3dmeC9tYWluLmMgICAgfCAgNSArKwogZHJpdmVycy9uZXQvd2lyZWxl
c3Mvc2lsYWJzL3dmeC9xdWV1ZS5jICAgfCAzOCArKysrKysrKysrLS0tCiBkcml2ZXJzL25ldC93
aXJlbGVzcy9zaWxhYnMvd2Z4L3F1ZXVlLmggICB8ICAxICsKIGRyaXZlcnMvbmV0L3dpcmVsZXNz
L3NpbGFicy93Zngvc2Nhbi5jICAgIHwgNjYgKysrKysrKysrKysrKysrKysrKysrKy0KIGRyaXZl
cnMvbmV0L3dpcmVsZXNzL3NpbGFicy93Zngvc2Nhbi5oICAgIHwgIDYgKysrCiBkcml2ZXJzL25l
dC93aXJlbGVzcy9zaWxhYnMvd2Z4L3N0YS5jICAgICB8IDQxICsrKysrLS0tLS0tLS0tCiBkcml2
ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L3N0YS5oICAgICB8ICAxIC0KIGRyaXZlcnMvbmV0
L3dpcmVsZXNzL3NpbGFicy93Zngvd2Z4LmggICAgIHwgIDggKy0tCiAxMiBmaWxlcyBjaGFuZ2Vk
LCAyMTggaW5zZXJ0aW9ucygrKSwgNjcgZGVsZXRpb25zKC0pCgotLSAKMi4zOS4yCgo=
