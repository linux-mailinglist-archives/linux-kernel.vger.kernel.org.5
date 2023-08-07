Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E205F772891
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 17:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjHGPGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 11:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjHGPGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 11:06:10 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB4610DE;
        Mon,  7 Aug 2023 08:06:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fdnouJEJns/MVAEQ5nfNHDovci46JCOHkfmaZBYHFf+kSuqHRhtVJ8CjUs7D1jIfP0A6h5RdlKxer6wxejkFxzVdmj/U7qnWhgWjU0GpnsZ79fkog0zBp67+FJSbh+h5yT65W3LYlGquflPZyFgK2hE1HDT0PZiPrp43X88rs+ZS4zyjxUos+EPHhC0V6L7YhtvPmJDXAEOehw+55/RDIabkdstmRHoWJuMFpzWFj+byZ8baOfhWYs5Ymmr13Fx+tDeukptnatIGjTyc3vgm+gJLbc/EaiKtMGMFWpTHTNfY2cB0WJvJp1HDadrI0rtlWlvK/hsnBNQjHvXoE3UHKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NNW368FJ5011+JKUDzVVojthKAEb404dVl3QoIUvwsY=;
 b=RmeT/u9qdUc9S7dDyoI8x/fAPYQRmBFDvFM296z2bzhMUrlS6fgceE88PQWsgeIROqaQ0la67BWoQa7s+620wIxXBPKRcc/xNrlIdTJvToPSlVC5Wirt5QPkYk5Re6WfZlcShEHT3cFMDenzwKyaXovOmwjhWb2Rtw3aDBiFsgnjfOZvpBbg6B+AwUsjGayn8TsvVFJD9lp4fOGXtzMrtS4qgPPNiaB9yMJSDdRcZMNEGdKNPIgebzn12t5LCOK0UcwG3cepi/XQDZzfOAoO8f5HripHENP8CdV1t/egO663T9WqFXsDtgk+tpJaa4RgTMpqriJvJqMiMZkXuJKTpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NNW368FJ5011+JKUDzVVojthKAEb404dVl3QoIUvwsY=;
 b=LUiRv/cAbNN3zWf3OKlQBAinUlra8CAPr0PJ08Zp1onfIVWgBzFsqGosZ0Z0ziWd1riejLILjXX84MogR5q6KI8YcCdkL1799AHkD/yJlmQAn+/AwuKmaWwp/+MaUYUjVcuuPtSwHk5S+EyfbAug/9xEaifFDpBiv4OOZjsP3LI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=silabs.com;
Received: from IA1PR11MB7773.namprd11.prod.outlook.com (2603:10b6:208:3f0::21)
 by SN7PR11MB7590.namprd11.prod.outlook.com (2603:10b6:806:348::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Mon, 7 Aug
 2023 15:06:03 +0000
Received: from IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::14b1:be6e:19a3:2eca]) by IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::14b1:be6e:19a3:2eca%6]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 15:06:03 +0000
From:   =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>
Subject: [PATCH 0/9] wfx: implement Remain On Channel
Date:   Mon,  7 Aug 2023 17:05:33 +0200
Message-Id: <20230807150542.247801-1-jerome.pouiller@silabs.com>
X-Mailer: git-send-email 2.39.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-ClientProxiedBy: PR0P264CA0252.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100::24)
 To IA1PR11MB7773.namprd11.prod.outlook.com (2603:10b6:208:3f0::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7773:EE_|SN7PR11MB7590:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cb7fffe-e928-42f7-c160-08db9757d166
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h9wPSP77EhVzFKE9XjpqKPEcao2cGtJ0bj62NCksc3Fd3GFeff4g+NaCUkHk0UBQ5Sy4cigJtYGA+VV8Npxcp6GvNAvpPs0d1DYq8vfIfdD0pQIzn7sBGUA0bGmGaLlsW5leQNL6487UAWPzSMF6ir8G6V3GClK0DQVTjbaa3cLcbnuWdeiPETR3ILTeako1w6tYWq3R8b1cCxLCKvQWQPlOffR3FnB4Br7yIqc1zymXHLwOCloDLAhjoTBZTd5tKd6S/hJKYBU2tcHZae7mr6X0UL27c6rAIZM9R/MQfmATUU7hLzWTlxmebEQ9VL03b7W5YfctwbXe/Ou4BjnNKLHe18vnI6Y0I0SQH/ig/FwmE4fWjATs5+THOE3NPmX8EjeehqA1JAwN1d1DmS9fjaZHXUi6ZaPWix1EB+9c1q5/7TadM7WIz8w7cGtzoW5BeUKUsbf+9gtwT9gtf/mgYoDztwuv3XK2+kFh8Teo+SLvo9URuAfJzN6e0+A6BIu3YyJZPYWjt65DcAO+ci9kLxFXcl2tt3pnVGVcQkA533I/dOdSol//aLtbXNBIGXIUc+W/Oz+J/ydBwu2u1NHTpg1QRH/TwA/vrtYyq/OPeEkLJVi3C5yVM/nXtNM3FqAF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7773.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39850400004)(376002)(346002)(396003)(366004)(451199021)(1800799003)(186006)(2906002)(4326008)(6916009)(66556008)(66476007)(66946007)(6486002)(52116002)(6666004)(66574015)(83380400001)(5660300002)(41300700001)(8936002)(316002)(8676002)(38350700002)(38100700002)(2616005)(478600001)(36756003)(107886003)(26005)(6506007)(1076003)(86362001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEFzN3pib0JhRWFkVkJaaDdQeTM1d1N1RlJTSGI3VU1qRVNtdUNqSzBSRDF5?=
 =?utf-8?B?RGZvZ082VmNmaG8yUm14R2Q0K3FuVTM4cFZrNDRHQ2NVbDlJR0JtdWdYUlZl?=
 =?utf-8?B?eUtlNGt3bDlLOVY5YndCTlMvcUU5ZzdmYzlaQjBsRVBJZFAvWWNUS0JlcG9x?=
 =?utf-8?B?SlRTeEdXRmI1Um9sK3I5NTFrUUVYMzBzNmZPRStQM1M1MnVETHBLLzJIdkd5?=
 =?utf-8?B?YkxWaGx6L3lGRWNrNkFCdXJxTG93Wjl6V3hNSXFtMjFVOWZLem1GMHlLRUpP?=
 =?utf-8?B?TlJXTlNOUHRta3ZwbXNadHZyVXZYRjdzWEFGek81NzNxU0ZuTlNabUwrTGJE?=
 =?utf-8?B?UVl3Z0t0UDFYSFk2YkFGb1d3Z3h4c1pMaExnT20yL21XaDFuL2ZsNnZnYWM5?=
 =?utf-8?B?bitPQ2U0M3RRNC8rWVNqV0JDSnRIaUkyUUN4bWVnaGVvdTJTZmUwWjVPYS9u?=
 =?utf-8?B?YS96UUxpMXZqakxYWCtNbkdydHFzWEhkcDN4NnpBMWRTcXRybnltRUNXZ2dG?=
 =?utf-8?B?RUxTblllWXpXL0xHcVNNbFplM00rODlJMkFCN2R6SWEvVzBVRU54TnY2czNQ?=
 =?utf-8?B?M1d5ZVRscXRGa2xhelhRME5ackUwQzV6a3YxUVUrbFgvRk8vQVAyZmhXT2hE?=
 =?utf-8?B?T3ZsOXNzVzdMRkFPd3VjV21HaFFUK05PS1U0NFNKQ2EzRDBKb255Q0F3NURQ?=
 =?utf-8?B?Z0tocTB6TmtuQmRlR01MNStkTDRSdGVHVWhTUkM2RzhJOWtkK09rOVg5c1U2?=
 =?utf-8?B?U3VTaVBsdG5vTm1mVHR4K2FqV1BackZYNFhpSmhBdGhNUTVSbzAzQUhtdHZU?=
 =?utf-8?B?UEVuOU5OS0YzUnRoS0kyQVM2WXRNbkU4a29zbnBiaHkwb1ZTckxZQldjMkVu?=
 =?utf-8?B?cFRISzVldnZZM3RLMEUzdzYzdmVaYnI2N1FxMDJRclAwMEJhNXBjdjhhSEhu?=
 =?utf-8?B?Q2lFZTdkMEhWZXVFdkZxbmVGWktKOWFtekc1K1JZb2FrWStVSnltNW5iOFFZ?=
 =?utf-8?B?RjF0dEFJRVhsQlVIZ1p3b1pCZEVsQzhQbVFaWEVBZjNUZHBWK3NlRXdxM2pa?=
 =?utf-8?B?M3BsRGFRaERweWdvTUcwYmkxbTQyYmRNQnFsa2I4QTBHS3NmRzdrZTNncUE3?=
 =?utf-8?B?ZDJPZHA2bmdQb2hHUW0zeFI5dDVtUThkUVBuZVloUEhhbjdOSXBlZmo5bWtX?=
 =?utf-8?B?cEQxWmpZbkVKb2NHV1cwRDlzaHNtaktlbEtQSHBPbzVEVlhidXpqaFBuMnYv?=
 =?utf-8?B?TmJ3c1paUnVBUC9qQ0tQcCtGend0QW43MW0vWHdybS91WEtwK3loNVNIRU1v?=
 =?utf-8?B?a2RDRzJWQ0NORzZRQnliUGdJNlpOTCtkd1RDQytZamc3RWhhN3NNdmNlWnZ1?=
 =?utf-8?B?UXd6YmdBOENORStXV1NpRW52VmVxYjBqd05sQjJhYWN6Y3BKa3htbzk0all1?=
 =?utf-8?B?bS9XUXpWOWdkYWlhUkw4RTVxdDVLSitHVjJqN1JDdytWZWxWam1MRUl6MEw1?=
 =?utf-8?B?UkQxT0VCZTYvUEpibFo2UzBZSXBJTmxaSG1OTndHV1NUZ05tTEN1STNiWWJK?=
 =?utf-8?B?WlVuUWxESWIwUmtnblY0eHRMdWFNWHhXbFFlMXNxajZ2em9UV2FOM2N6YVUy?=
 =?utf-8?B?aUJ2anNEY291MEpIT05ZMVVBNDRJUzhVZXlWM1crakFRelJOelN6UW9JV3BL?=
 =?utf-8?B?Znd0SHFSZGpLdUZFZThEaE8rNjBOcHNrRzRZd0UxQncyYVBNcEkyZnNmL1ZI?=
 =?utf-8?B?emZDZEV0bXFxaWVpbGtZcHpRcDVuQ1p2N1Q2UXowUUFLcm9Ma2Ixd2N3M0gr?=
 =?utf-8?B?MnlSMkZvT1RwL1I5VTJKeGJPR0REN2syRFdWUkp3SkgwYnk2eFNQQXdLNkdI?=
 =?utf-8?B?elc5SHJkbTdhUE8zNU9MbTd5YkUwN3VyeU9zT1d3MTlYeTBVSVkzeXVTNnBz?=
 =?utf-8?B?cXJTNEpYZ01nVmdGemZEUW9WcE04MlFHOTYzQ1lLUHp0RE9yM3FGS0MrVFZF?=
 =?utf-8?B?MjZnZUNvQUtQc1VaRFpBUVkvWHphanRLNmxsM1oxd0s1VkNuZGhKdENnaGxn?=
 =?utf-8?B?c3Vld0VxRXk5MHVXU045NUdDS2MrSEhlUGVTOE1VeVNON3dSbEY3cnUrSjhU?=
 =?utf-8?Q?4RDPx7NeZvTBqZMBmA0O7uxSF?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cb7fffe-e928-42f7-c160-08db9757d166
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7773.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 15:06:03.5712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9XDlF6jS9unOmyJKN1Dj8AstkAIy8CSc2VsCiPQPHxPCImzNRxdCird/Us7dnS5zKC8HquOVMeJ8Bh2tY3UJ0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7590
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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
cyBST0MpLiBIb3dldmVyLCBpdCBoYXMgYmVlbiBleHRlbnNpdmVseSB0ZXN0ZWQgd2l0aApEUFAv
RWFzeUNvbm5lY3QgYW5kIEkgaGF2ZSBub3Qgbm90aWNlZCBhbnkgaXNzdWUuCgpKw6lyw7RtZSBQ
b3VpbGxlciAoOSk6CiAgd2lmaTogd2Z4OiBmaXggcG93ZXJfc2F2ZSBzZXR0aW5nIHdoZW4gQVAg
aXMgc3RvcHBlZAogIHdpZmk6IHdmeDogcmVsb2NhdGUgd2Z4X3JhdGVfbWFza190b19odygpCiAg
d2lmaTogd2Z4OiBtb3ZlIHdmeF9za2JfKigpIG91dCBvZiB0aGUgaGVhZGVyIGZpbGUKICB3aWZp
OiB3Zng6IGludHJvZHVjZSBoaWZfc2Nhbl91bmlxKCkKICB3aWZpOiB3Zng6IGFkZCBwbGFjZWhv
bGRlcnMgZm9yIHJlbWFpbl9vbl9jaGFubmVsIGZlYXR1cmUKICB3aWZpOiB3Zng6IGltcGxlbWVu
dCB3ZnhfcmVtYWluX29uX2NoYW5uZWwoKQogIHdpZmk6IHdmeDogYWxsb3cgdG8gc2VuZCBmcmFt
ZXMgZHVyaW5nIFJPQwogIHdpZmk6IHdmeDogc2Nhbl9sb2NrIGlzIGdsb2JhbCB0byB0aGUgZGV2
aWNlCiAgd2lmaTogd2Z4OiBmaXggcG9zc2libGUgbG9jay11cCBiZXR3ZWVuIHNjYW4gYW5kIFJ4
IGZpbHRlcnMKCiBkcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L2RhdGFfdHguYyB8IDU0
ICsrKysrKysrKysrKysrKystLS0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvZGF0
YV90eC5oIHwgMjEgKystLS0tLS0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvaGlm
X3R4LmMgIHwgNDMgKysrKysrKysrKysrKysrCiBkcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMv
d2Z4L2hpZl90eC5oICB8ICAxICsKIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvbWFp
bi5jICAgIHwgIDUgKysKIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvcXVldWUuYyAg
IHwgMzggKysrKysrKysrKy0tLQogZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9xdWV1
ZS5oICAgfCAgMSArCiBkcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L3NjYW4uYyAgICB8
IDY2ICsrKysrKysrKysrKysrKysrKysrKystCiBkcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMv
d2Z4L3NjYW4uaCAgICB8ICA2ICsrKwogZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9z
dGEuYyAgICAgfCA0MSArKysrKy0tLS0tLS0tLQogZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJz
L3dmeC9zdGEuaCAgICAgfCAgMSAtCiBkcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L3dm
eC5oICAgICB8ICA4ICstLQogMTIgZmlsZXMgY2hhbmdlZCwgMjE4IGluc2VydGlvbnMoKyksIDY3
IGRlbGV0aW9ucygtKQoKLS0gCjIuMzkuMgoK
