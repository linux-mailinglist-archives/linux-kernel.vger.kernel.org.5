Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3D5777289F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 17:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjHGPG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 11:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjHGPGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 11:06:13 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6237C10FC;
        Mon,  7 Aug 2023 08:06:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PzCcEyT16T6qKpkqIEF3jv9eGsa7Ds4ifP1fbNavFSpTax0JOW6WL9hkleu0TWPb2+zMOVhhvkPL20l+xhL8yBPACmPKGLQh6zMoPNj0nRX3yPrUDvewzXYr+qAR+wtukKp5hnCIEmzzY/3WAt2DHlzZ+xP7vbF4Y6dxqtxcbnFgd/tunIKXCR5ZmhJ1QF9eB1LKvGt5zXohWCxRtzleQNKnrLljCTO0u4VLIbOpRHJ9O3sSGFG07aeJN5b4UUEpFsOHOXSeYo1NiKDSmiHjLKWS9DwHxxi+Ty7MgGm9njtuVy8rnKFj3DRGCLLEqZET20iLNqNQKb2c84xb0c95mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=norDEW8Hxm6C7u81b2eY1C5/61vShbjHMSmIeYSui2Q=;
 b=V6nHNkMW4/M7p7XSmgW9H9IOLwdtN+qRgWmkhy3Ekv8ncvUVyF9aQVBQYccoJWxP7SbEvlCHZtM4Ac/beXj5eB5CQkOO880lZs5VrHK5OP4cnzMnC7qxo4PHqymatQpeyT+OhcYwjl0VCEBaE+10f74zGJzVsiWJSnMGPHSJEWOG6ATvhmrWblaH5pyghqj/Q2g7Df3FhQ9x1rI5XbX1HSFs68rt8NvIn5O+uKMYbXmmz0td8vBfC3RS40THGRysA1GxMHU8gcmHgB0vejL8rhEbE51+D+0MZL4xSOsHwcdVsGH0JMt9Ftg2tuypx2MFrQYkoNtiTmq9FHxDK/YgVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=norDEW8Hxm6C7u81b2eY1C5/61vShbjHMSmIeYSui2Q=;
 b=KVqy0aduMVkI9nDgww4LTggRX1O/zOz9OZmWiP4+LNCmEw2NT3bLO3hMbRjMrWpKk5GvG4DwbIcYa3Fqipf6LE5bxlz6TFGEBAEbN5sVkJ5flCntP8knU8slABRJg9Si2APbvM2yean92aBXyR10oK++N1zFyKwAStTh+uDNgB8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=silabs.com;
Received: from IA1PR11MB7773.namprd11.prod.outlook.com (2603:10b6:208:3f0::21)
 by SN7PR11MB7590.namprd11.prod.outlook.com (2603:10b6:806:348::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Mon, 7 Aug
 2023 15:06:08 +0000
Received: from IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::14b1:be6e:19a3:2eca]) by IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::14b1:be6e:19a3:2eca%6]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 15:06:08 +0000
From:   =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>
Subject: [PATCH 5/9] wifi: wfx: add placeholders for remain_on_channel feature
Date:   Mon,  7 Aug 2023 17:05:38 +0200
Message-Id: <20230807150542.247801-6-jerome.pouiller@silabs.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1d66e59c-821f-430c-ca6a-08db9757d423
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2IkcFdRV2xFzeg7sWZCxUb9iJZqRr4D2uleMGUjPiol4n8e3Tpf/PUcDu/mJ48yJBLh0zV1LqnggNQ8sxyHBVtLzMTa7tgJpdFyXIFrAjlVULL5OlzE7LIvBjMPGPjwlavB9aSzl8wVleq3GtbnQBpXQOloYfJoSUQIHVJWaPtDgogwGD9GZgM8mhGmQqL9n4C8VR7dx9+vyrxXQ2DwoPf+gS0l8AYvEIv/vItXNPFHvwwvM5sCilgHHjV/zqDLCzUka7wfpQ2OgdYY49VVrqrOy1RMnR+poooMwbfXL0vJe9mJwVYqssBzAuyFVwT3R5yMVSeOdfPnirNwxM9boOOQdFpeiYmZftKZLfrzOgdIVof2uEYM1W75BWZaqeHaIeoS2NLPo208aFMUeBl3HBQKLEfcpz2F/N1ifi0Hc83F6hfMOETWEpHAd5adl1uECnz7yvj9tzyhHK6nMKw28Rz3Nzxz6iICJh4juIviAPaJ4HE5G/z43QJqou1SvfRK9LoxNkeJTbmRpfirq70pJxkT63YTIs1H99Q5A9tUwYJm/4ekWjadHIZ8EndB/8Njd8bQ+i/PHie7irqlXRypxgZFGH4rWMdiVKzUwP2IreD78xyujr/6dmPiuy9QsIyHl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7773.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39850400004)(376002)(346002)(396003)(366004)(451199021)(1800799003)(186006)(2906002)(4326008)(6916009)(66556008)(66476007)(66946007)(6486002)(52116002)(6666004)(5660300002)(41300700001)(8936002)(316002)(8676002)(38350700002)(38100700002)(2616005)(478600001)(36756003)(107886003)(26005)(6506007)(1076003)(86362001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dk9XRlRrL0VQNllkdFkyTlhkcVJkdzlTZFlIWnhJL21PSU02WXRtQlFiZ052?=
 =?utf-8?B?TUU2OGJCNm15WVhpNTdBWG9qUTFDM1pZUHdRQ0NoK3VlL0c3NTYzVStMOHVE?=
 =?utf-8?B?WkxXWlFEZEI1amY3OStzelBqT2Q2SnluUkJSTURUeEFkcS9PbFNhRTdrWDBq?=
 =?utf-8?B?empKNzd6UHhWRDI2MlJ6azRyaVJkUHV6VWpEM1crdVV6Y1F3MU5Id3J3Vm56?=
 =?utf-8?B?U01FNDltaHgrV1RQN0RwMm1KOUhFRFZ4bG1Pb2dCUk5HWkJiTGNJdFcxaTkw?=
 =?utf-8?B?WXJBeXUreDZQNTZOUXdta2lwbjlHbkI0NlpETUMwdVVWY2d1WWxvVTNyK0hN?=
 =?utf-8?B?WDJVbkVyTG1Dcjk3MEZnTDFvVmVpRHUwR0Z4d05hK3c0TkxEVnVrVGRpdjFD?=
 =?utf-8?B?Uy85Tzh3MS9VQ1hYVUovT25QYklDZWJpb3N5Y1pSdENTQThBQlBPOGlXbDJO?=
 =?utf-8?B?S0NFcDZoL2ZDemRHWFlTL3VCRlZIM0FRQjBSdjFNc25iZGpTdE1xK1Y1RlA0?=
 =?utf-8?B?VWpYMEM5U2tQS1pNWGtGQllGZzAyMXB3d1lCMjRheGVsQTRHaHN2NHZwK2Qz?=
 =?utf-8?B?bTZtNXVMMGxPM3A0OUhCUUxDTmlNMXdDQmJHVzk5enIzaXEyMkpzbkxjYzRG?=
 =?utf-8?B?dXRQNGhleTcySWk2a3VaQnNqN0YyMUZQVUs1bE9uclZEenF1NkFJeXFSeDNO?=
 =?utf-8?B?ZVByNE83dUsxSW9vTXhHVEErSTc5YWxQUkcvSk1kcE11RTgwU1VkSXByNDNM?=
 =?utf-8?B?czJCQllEL3lFS2Zad29HdnVVbXpDckV3TlU5MTJkUmtoR29lVXg3UHdubE4x?=
 =?utf-8?B?Z3dnVWNHbkVLSnZFa24xckxaWm5icTAyNytuK1ZHR01YYmdqMXZ6RS9iSExO?=
 =?utf-8?B?bFRqcDJmS1VpN1VJWnBaVGJQZms4bFJ6YXRwR3BYUGt1azNUTFU3NjZqMjNC?=
 =?utf-8?B?RTUrZHEwanFibDJ5WWxJT0lkYlVRT2srcXdneFFlSHlKaTJ6eXovMFUweStY?=
 =?utf-8?B?Z2F1NlgySW83bUJtaDNjcEZxNFEwcktsd1dEbVBxNDdDeDUrcTQyblhuWlUr?=
 =?utf-8?B?eGthRktyNWtKNUZaNjVwL0kxbFNMdDRLaVMxT0tjejVQZTJwTnlVVGFFMjZh?=
 =?utf-8?B?RUlvT3d2MU9UTWl2LytqVnoxQjAvWk1aUE1qR3RJT0Y3N2hDYUZ2OVE5cENW?=
 =?utf-8?B?MjhCdXJXWUFreVNLYU14QTFDTUcxQ1dGalYxTnU3Y1F2NHdCU2Vkbk8yTnlj?=
 =?utf-8?B?bS80Z1lwUUEyRTAybmZnU240VjJoZ1Fja1J0V2lldHpuQy9Da0orcFdxdmdP?=
 =?utf-8?B?eG9MOTluNi9GYTZyeklDdmZLZWlScXhJMEpHWnphOVJoUHBJc1d3dGM0U0Fy?=
 =?utf-8?B?WTJUZDluZGppQU8yVmU3TEkrKzZwYnE3bnJVcVRxZXRqZWpjUnRMb2t6bnVo?=
 =?utf-8?B?VU51Tkxoa0FtUExGM1V3UzFNcFdRWGo0ZHMyVktzOTExN2tOQmhjbnV1N1ZH?=
 =?utf-8?B?S3Y3V0FIZk52TVlMS20rYWF0WmdkN0YyMmVMWmxrRlByUTI0UHc0Wk1jTG1j?=
 =?utf-8?B?ODl2Smo0bHdkdzBmT1RtUjNISitKMUViZmVrUG1xVm1UQlo5QkdrL205Lzl5?=
 =?utf-8?B?emMyVkowRE1LM2hOZlFvSlF5UlA3MG13T0RJRU0wa2FKQ3ZwSnlXYVVxeHYy?=
 =?utf-8?B?MW5qNWhQbWNTT1pCTDY2Ty85SEErRmJlY3kvU2cwOXZYOWV0bXVRbmpBdkdM?=
 =?utf-8?B?MWY2eXB1VjVONUczN1pCalJtRXhoSFN5T0R0ZFd6V1U5cVhIYTNuU1AyMlBS?=
 =?utf-8?B?RnRqc3MzVnVlNkdWWnQ3K0ZWeHV2OU85S2t2VFhsK2JIVUdpdGhLQ3NzSkdx?=
 =?utf-8?B?YUtIeU8xK3czeTA4Sk43SFBqSnZYYUQ5ckFmeForcFNOUlQrN085bVNpWndQ?=
 =?utf-8?B?RGhXbG5keE82RnJrNzBkbU4rV1pPWnZxUGlpOCtqc00rRndnTURRdXh1SmVB?=
 =?utf-8?B?dWtkNUxYdzBwNStaRE9IbXpmMkJGTDNkd3JvQ3JCK1hrdElMZzdoWXkvTjhv?=
 =?utf-8?B?R1JvUFZFUUMyVW5zMzZlQS9zcFpTRUF1WS8rMDZ2dXlPRWc1NFI3WmgrVHlq?=
 =?utf-8?Q?Iyl+nIZ4dpkpQ/V3HZePbRufa?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d66e59c-821f-430c-ca6a-08db9757d423
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7773.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 15:06:08.1092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Sky6aDTnJCttxZ+QArkIF2kvrhqdy8SbgATw7ZxGqGvtTDnrnDKG9KbO/CUPr3sw3RoEsP1KAPtGzQnmcHIMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7590
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rmlyc3Qgc3RlcCB0byBpbXBsZW1lbnQgcmVtYWluX29uX2NoYW5uZWwuCgpTaWduZWQtb2ZmLWJ5
OiBKw6lyw7RtZSBQb3VpbGxlciA8amVyb21lLnBvdWlsbGVyQHNpbGFicy5jb20+Ci0tLQogZHJp
dmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9tYWluLmMgfCAgMyArKysKIGRyaXZlcnMvbmV0
L3dpcmVsZXNzL3NpbGFicy93Zngvc2Nhbi5jIHwgMTIgKysrKysrKysrKysrCiBkcml2ZXJzL25l
dC93aXJlbGVzcy9zaWxhYnMvd2Z4L3NjYW4uaCB8ICA1ICsrKysrCiAzIGZpbGVzIGNoYW5nZWQs
IDIwIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxh
YnMvd2Z4L21haW4uYyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvbWFpbi5jCmlu
ZGV4IDBiNTBmNzA1OGJiYmMuLmEwOTA2ZDdkMDI2ZTAgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbmV0
L3dpcmVsZXNzL3NpbGFicy93ZngvbWFpbi5jCisrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3Np
bGFicy93ZngvbWFpbi5jCkBAIC0xNTEsNiArMTUxLDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBp
ZWVlODAyMTFfb3BzIHdmeF9vcHMgPSB7CiAJLmNoYW5nZV9jaGFuY3R4ICAgICAgICAgID0gd2Z4
X2NoYW5nZV9jaGFuY3R4LAogCS5hc3NpZ25fdmlmX2NoYW5jdHggICAgICA9IHdmeF9hc3NpZ25f
dmlmX2NoYW5jdHgsCiAJLnVuYXNzaWduX3ZpZl9jaGFuY3R4ICAgID0gd2Z4X3VuYXNzaWduX3Zp
Zl9jaGFuY3R4LAorCS5yZW1haW5fb25fY2hhbm5lbCAgICAgICA9IHdmeF9yZW1haW5fb25fY2hh
bm5lbCwKKwkuY2FuY2VsX3JlbWFpbl9vbl9jaGFubmVsID0gd2Z4X2NhbmNlbF9yZW1haW5fb25f
Y2hhbm5lbCwKIH07CiAKIGJvb2wgd2Z4X2FwaV9vbGRlcl90aGFuKHN0cnVjdCB3ZnhfZGV2ICp3
ZGV2LCBpbnQgbWFqb3IsIGludCBtaW5vcikKQEAgLTI4OCw2ICsyOTAsNyBAQCBzdHJ1Y3Qgd2Z4
X2RldiAqd2Z4X2luaXRfY29tbW9uKHN0cnVjdCBkZXZpY2UgKmRldiwgY29uc3Qgc3RydWN0IHdm
eF9wbGF0Zm9ybV9kYQogCWh3LT53aXBoeS0+ZmVhdHVyZXMgfD0gTkw4MDIxMV9GRUFUVVJFX0FQ
X1NDQU47CiAJaHctPndpcGh5LT5mbGFncyB8PSBXSVBIWV9GTEFHX0FQX1BST0JFX1JFU1BfT0ZG
TE9BRDsKIAlody0+d2lwaHktPmZsYWdzIHw9IFdJUEhZX0ZMQUdfQVBfVUFQU0Q7CisJaHctPndp
cGh5LT5tYXhfcmVtYWluX29uX2NoYW5uZWxfZHVyYXRpb24gPSA1MDAwOwogCWh3LT53aXBoeS0+
bWF4X2FwX2Fzc29jX3N0YSA9IEhJRl9MSU5LX0lEX01BWDsKIAlody0+d2lwaHktPm1heF9zY2Fu
X3NzaWRzID0gMjsKIAlody0+d2lwaHktPm1heF9zY2FuX2llX2xlbiA9IElFRUU4MDIxMV9NQVhf
REFUQV9MRU47CmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L3Nj
YW4uYyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93Zngvc2Nhbi5jCmluZGV4IDE2ZjYx
OWVkMjJlMDAuLjUxMzM4ZmQ0M2FlNGYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNz
L3NpbGFicy93Zngvc2Nhbi5jCisrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93Zngv
c2Nhbi5jCkBAIC0xNDUsMyArMTQ1LDE1IEBAIHZvaWQgd2Z4X3NjYW5fY29tcGxldGUoc3RydWN0
IHdmeF92aWYgKnd2aWYsIGludCBuYl9jaGFuX2RvbmUpCiAJd3ZpZi0+c2Nhbl9uYl9jaGFuX2Rv
bmUgPSBuYl9jaGFuX2RvbmU7CiAJY29tcGxldGUoJnd2aWYtPnNjYW5fY29tcGxldGUpOwogfQor
CitpbnQgd2Z4X3JlbWFpbl9vbl9jaGFubmVsKHN0cnVjdCBpZWVlODAyMTFfaHcgKmh3LCBzdHJ1
Y3QgaWVlZTgwMjExX3ZpZiAqdmlmLAorCQkJICBzdHJ1Y3QgaWVlZTgwMjExX2NoYW5uZWwgKmNo
YW4sIGludCBkdXJhdGlvbiwKKwkJCSAgZW51bSBpZWVlODAyMTFfcm9jX3R5cGUgdHlwZSkKK3sK
KwlyZXR1cm4gMDsKK30KKworaW50IHdmeF9jYW5jZWxfcmVtYWluX29uX2NoYW5uZWwoc3RydWN0
IGllZWU4MDIxMV9odyAqaHcsIHN0cnVjdCBpZWVlODAyMTFfdmlmICp2aWYpCit7CisJcmV0dXJu
IDA7Cit9CmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L3NjYW4u
aCBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93Zngvc2Nhbi5oCmluZGV4IDc4ZTNiOTg0
ZjM3NWMuLjJmODM2MTc2OTMwM2UgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3Np
bGFicy93Zngvc2Nhbi5oCisrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93Zngvc2Nh
bi5oCkBAIC0xOSw0ICsxOSw5IEBAIGludCB3ZnhfaHdfc2NhbihzdHJ1Y3QgaWVlZTgwMjExX2h3
ICpodywgc3RydWN0IGllZWU4MDIxMV92aWYgKnZpZiwKIHZvaWQgd2Z4X2NhbmNlbF9od19zY2Fu
KHN0cnVjdCBpZWVlODAyMTFfaHcgKmh3LCBzdHJ1Y3QgaWVlZTgwMjExX3ZpZiAqdmlmKTsKIHZv
aWQgd2Z4X3NjYW5fY29tcGxldGUoc3RydWN0IHdmeF92aWYgKnd2aWYsIGludCBuYl9jaGFuX2Rv
bmUpOwogCitpbnQgd2Z4X3JlbWFpbl9vbl9jaGFubmVsKHN0cnVjdCBpZWVlODAyMTFfaHcgKmh3
LCBzdHJ1Y3QgaWVlZTgwMjExX3ZpZiAqdmlmLAorCQkJICBzdHJ1Y3QgaWVlZTgwMjExX2NoYW5u
ZWwgKmNoYW4sIGludCBkdXJhdGlvbiwKKwkJCSAgZW51bSBpZWVlODAyMTFfcm9jX3R5cGUgdHlw
ZSk7CitpbnQgd2Z4X2NhbmNlbF9yZW1haW5fb25fY2hhbm5lbChzdHJ1Y3QgaWVlZTgwMjExX2h3
ICpodywgc3RydWN0IGllZWU4MDIxMV92aWYgKnZpZik7CisKICNlbmRpZgotLSAKMi4zOS4yCgo=
