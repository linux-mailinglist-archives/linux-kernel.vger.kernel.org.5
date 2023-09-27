Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5857B7B0A59
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 18:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbjI0Qd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 12:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbjI0Qdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 12:33:41 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE68121;
        Wed, 27 Sep 2023 09:33:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZG+Lwf0gWOFYub+I9uJ92QnFh4PJl12B9enN7xwx1IKWnh4pXWvNda08qOU1ZdHR6q7cfM5PENehUxT2mJln4tYxvatHSDW7w6WNeRSZDLpQzykCxOFZxKklfmEDcrtAlrr2riGF38Zs45Nmt7oK07Q6gGSCV6cjjWh4KTzpdHCUJA2WEDAn7DX/QgzOxasWiw8vVzLlcWEiGvSazSwySmoZpol9TGJzhD9LUDejdDIFk9M/ml2SLJMdVKQrPBybrwV7K5QqqFhwcoggbjZ0HUw1F+YqkCQ1YQw0PjptEwnl+ziTSJsRlx96RNIrlB9m4g9mmPIqwnNyn/mPUGwc5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZPRftwa/5INHUuf/U0IO6DYv07+MkuBCaxGoh+MZ00E=;
 b=huhkI67tP8M6QtYr1GGcbmD43D/NYKT7XMEh/c5a9+XaNSiCTSRl3otIL1pzAyh4liXAtzMDCX/MiOIUzskb+F+0F35+gvF8/aSNEAYqQq59HeHg7P1R5YJtqzskgs5r5GlMml3WJl7XNPnixe6GyIF4ztmZG3c9NNcqiD9+JM0WgXuI3+YYFNRRP1q2ULa/W/+FZnvRAxNhcggeKX4FB+UxWyz2SNT5Dkew5dmIH664Bkwu0eU93pltjKa/eaQMYNEsG1hfP856YI+w+WHZlXJGjjWdilFZSJXMFccJz534IKoICzW8zwf4quylXmaRcYuhAm81tEry3zKdGQqEhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZPRftwa/5INHUuf/U0IO6DYv07+MkuBCaxGoh+MZ00E=;
 b=MyK/MeGDc/ayCNLod9IBgQjruHxrPsVfR0fu9XNRwccYQo0MuFs9zVeSKnCtvN3oXDwzbd+aV+IwBDchFYjtJSfcXUN+pByS7RmgZaor4/64PSToOp0vSjsnPscSbclQHDgk13WNx515PV4V1jS8ujLa/EXTBBasrfrvBoTQyp0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=silabs.com;
Received: from IA1PR11MB7773.namprd11.prod.outlook.com (2603:10b6:208:3f0::21)
 by SA1PR11MB6781.namprd11.prod.outlook.com (2603:10b6:806:25d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Wed, 27 Sep
 2023 16:33:30 +0000
Received: from IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::d6c8:4cb6:2594:d8f3]) by IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::d6c8:4cb6:2594:d8f3%4]) with mapi id 15.20.6813.027; Wed, 27 Sep 2023
 16:33:29 +0000
From:   =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>
Subject: [PATCH v2 9/9] wifi: wfx: fix possible lock-up between scan and Rx filters
Date:   Wed, 27 Sep 2023 18:32:57 +0200
Message-Id: <20230927163257.568496-10-jerome.pouiller@silabs.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230927163257.568496-1-jerome.pouiller@silabs.com>
References: <20230927163257.568496-1-jerome.pouiller@silabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-ClientProxiedBy: DS7PR06CA0052.namprd06.prod.outlook.com
 (2603:10b6:8:54::30) To IA1PR11MB7773.namprd11.prod.outlook.com
 (2603:10b6:208:3f0::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7773:EE_|SA1PR11MB6781:EE_
X-MS-Office365-Filtering-Correlation-Id: 592df89b-9209-4b58-126d-08dbbf777b88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Y0TzJnRoGnKryoYEcR0dBJuhELdAyCKn+5eiMUFleo+drx4JGpm9c08S80jHxPpFPcE2OrGxssV4hsicojHZ1F+UGM46DZpu36zkczGWW72KhwETC4YuPmRaXgfMh1wH9y9O2VLAsOmLY8B38JQvEFKGvewBQjTPhGej2y/rPMIzP5zfDKyyoi5RBakCTWv/qFTu3ypqmYjGgqmRSoMFj5W39WeFb3kFiUXrzolyUWtDMCYTGLXhPla+nJwXnrvQq0aMcuRQtCZv4iqrDUZvoHHqHZGPrXlIhD1547V5QgBottHX9GDfU3VgMVgOjRho2MT1xGmoptbf1V2pPqDi/2Xk8zEF4Z1tX09vCuZ85HQJrOw0NbGXJiJLi903RWQG33rSYdVHyXdz5/J4xsE/hGaYVrshmb5ihi4Z+bJT7JhvCcZID2B0KB3apEfMTTMFrZAGTlfgK4uCLnF473st84+j7Cy+h9Kn4Ms+mT9kAC+PJ2kNQ+709BKeCH5eIvI1Bbw9PBpwfLo84deatoqZXyD4ntx2FDCutfY/pkCCH6SZOrXEyLBc3Q4bbqaAM7l
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7773.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(346002)(39850400004)(376002)(230922051799003)(451199024)(186009)(1800799009)(36756003)(86362001)(8936002)(107886003)(6486002)(8676002)(2906002)(38100700002)(4326008)(6512007)(41300700001)(83380400001)(66556008)(5660300002)(1076003)(66574015)(2616005)(52116002)(6506007)(6916009)(66476007)(66946007)(316002)(478600001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2h0czNVTldIUlBpeG9NNkxGdXBDWTFaY3dSbjBvMXU1NDBUK3Q3bTQyQ0Zz?=
 =?utf-8?B?UWVVVG9WZlcxTEg3Q0ljNFRDejdIWGtIZXRydWw2WjVyZlpwWVlwRkMxMzVv?=
 =?utf-8?B?cGlkNXVGcExzZmFyeElPamQzaGhRTEo0aW52eWhSbmExUFprVmhKK0tnTURJ?=
 =?utf-8?B?dGZkYWYzQXo2QlV0UWVwTkF5S3Nqd1BXS2tvRDVxcDNpQ1d0ZzV1RGlidFhz?=
 =?utf-8?B?K3ZXQVVyQkYyRFkrQUt4amxkUmFHZlZJWkZzOGs0WFU0MTRIeVhRYUFRamk4?=
 =?utf-8?B?czVwdHJiWGRpUU8zMjl3MWdnVHJoTWd2Y0J5TXdxeUNVWSthSHdmV1hUY2Zo?=
 =?utf-8?B?M25kMGt1MHJwWDFzenpINnBSaVo4WHk0a0UzNEZUTnhISTgyVGdOdDhyMXUw?=
 =?utf-8?B?dGJoSEpEZURhOEVkVkYzeHhTR1VvQitrUFJDREwybFgvOWdyWjhYRmdNL0dr?=
 =?utf-8?B?RFBpdmhITUZGbHhrUHZta2lRUUZvRmkwVURQTWpVdkMzdy9lTmVabTlnZllL?=
 =?utf-8?B?Mkg0UTlpRVNiVUo5NmkzMlFZblFTTUpBSXFUU2FuWno5bi9aUzJnZm14SndH?=
 =?utf-8?B?VFhQOWtGVDZjb3VGMEIvbkI0TUJFR3luK1E5QzNGNTgvTkpWM2FUVXVvNmtG?=
 =?utf-8?B?UTVPSUtGM1RvNzNGcW80UDVBbC9reEdZc3EraGQ2aXAyd0dFT1B0cTdTK0oz?=
 =?utf-8?B?d2NXcW1YSWJrTG5PMGYxZk5EaDFMR1JiYTFubkhvSUlQQmV4Y0RxNmpyMnBa?=
 =?utf-8?B?eUdxVmQzTkQ3Z3VhdS84UXF2SWE5bGVIdGp0OG51dmFJODc3ZUtWWmovd09a?=
 =?utf-8?B?cER4cWxWWmtXVFE0OEQzMjJocjB4eHo1Z2lTL0owRHZTazM3Y3JsUDczNUd1?=
 =?utf-8?B?bnVVSjFHS0VpVjVHbFBMRFdJZzAxcS9UVFRtM2hRNm1IZG04bUVZeW1uTll6?=
 =?utf-8?B?emZCbXpxa0ZYSHNIcG9JNEgwOFdzNDhrN2t6dlhXMGtlZS9LYXpmM2NXTUI0?=
 =?utf-8?B?NjNLUG5GeXkvNVhBOGhtSTY0NlVSaUloWjQzVk1oL1ZjZU10Q1cra3dJVkxo?=
 =?utf-8?B?d0EvcTluS0JXaU1QM0phQ3I4TGcxem4welRRTUMvV09FZy9WNmtvaHR2TVR2?=
 =?utf-8?B?UGJTMkpLZWRkVmtuWm93dEx2ZWtBK0V4eHRpcHlleFNvRGJmWUxYcjBCVnVu?=
 =?utf-8?B?ZGE0K2lWdmtyWVkzVVhybXRsNFRxQVNBbXJ3aFpiakN2Q3pGWHJVV3lRMnJk?=
 =?utf-8?B?SDFxYnRKbjc2eTYzSERSQ25YWnI1NjB2R3NxbHd4ekRXYnA5WktCQkZsV0FI?=
 =?utf-8?B?eVFMdlpNL2xHMlFwZkRoNzI1cjJqT2Yxckwrd3prcTlWcGw4T3BYQmtuOTE4?=
 =?utf-8?B?ZC8zU3BJeWlIMWppV3FBclRhQks4S1piUFd6VXZ0Q2VaQlVITllwRzExRTgr?=
 =?utf-8?B?TC9RZGh1QlVCUVZ5YlFSa2ZNVDdyUXBYeVNJbnFoMS9lNHBCMjJQL0JnNEZJ?=
 =?utf-8?B?aWlMeWhQUTl2bU1YQklNVEJGUW84bm9wMkhQSzRBbktXejRQK3RJVW1DQllh?=
 =?utf-8?B?NmtFbzgwUmE1bmt5anJIWnhPZUxBeFYxVzBkU2EwcEVCQ3E5RDFudUNEeXZB?=
 =?utf-8?B?K3ROVHhxdjRkRGxRL2w4c0RnR1kyVU5JSjh0ZlNEaFhtN3hVQklNRXo3MGdq?=
 =?utf-8?B?Zm5sempDdnI5UnY1RSt2Z0hCS0s0VmE2ZDBWeW5RM0ZxQVVwSWJQS2F6S0xJ?=
 =?utf-8?B?YXVDNHoyYjBaRGYvQ3NWSU9rRnJKb2JFME1lZ2duemtHc2RtOFhqU1Z4TU43?=
 =?utf-8?B?N1B3U0FRazVhWnhzRVlFaHhMcXcxaUFad0lIVlBtZFRFOGdOTkY3L3pzUWJj?=
 =?utf-8?B?b3prR1JJUlFUY0wwMS8zN2hiTldkTU1BUG9tQ2ZybUtzeDNpNEFhMXJWTHdF?=
 =?utf-8?B?aHlDTXo3RUMvSEJJUHlVNTU3SHF1WklLOE9lektKSVVBK2dJd3lzdGtmUm5I?=
 =?utf-8?B?Y1pUUzRScHZGMHlxQkVTdEdiS3I1WTJYTmpXWGcxZldmOGlPa1BtUmlWbjF1?=
 =?utf-8?B?NE5aOFdzdUdJUkxkUmhuSHVOcDh6UlU3c1FFbmQ3VVVOOG1NazgrWkpiYmd5?=
 =?utf-8?B?aEFGcDlJTm0xUk1zd0laN1hqL28zanZRaXpZQWxEak1kWEdTazVZWFlqdlll?=
 =?utf-8?Q?Vt0G1v/IrbSle6YW1LY5rD5R/RaUMytu4TliJJirFhu0?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 592df89b-9209-4b58-126d-08dbbf777b88
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7773.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 16:33:29.8944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p7i6HnOJC1ZtVIgU1/0k7TZoUapmI6IAlo0coRSVtgucHqhCqn+VqrhNJYWkxI9Iv5FT60VjK/VVrAoQt3ymNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6781
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIGRldmljZSBpZ25vcmUgdGhlIHJ4IGZpbHRlcnMgZHVyaW5nIHRoZSBzY2FuIG9wZXJhdGlv
bi4Kd2Z4X2NvbmZpZ3VyZV9maWx0ZXIoKSBhY3F1aXJlcyBzY2FuX2xvY2sgdG8gcmVmbGVjdCB0
aGlzIHJlc3RyaWN0aW9uLgpIb3dldmVyLCBpdCBpcyBub3QgcmVhbGx5IG5lY2Vzc2FyeSBzaW5j
ZSBtYWM4MDIxMSBkb24ndCB0cnkgdG8KY29uZmlndXJlIFJ4IGZpbHRlcnMgZHVyaW5nIHNjYW4u
CgpIb3dldmVyLCB0aGUgdGhpbmdzIGFyZSBjaGFuZ2luZy4gVGhlIHNjYW4gb3BlcmF0aW9uIGlz
IGFsc28gdXNlZCB0bwppbXBsZW1lbnQgcmVtYWluLW9uLWNoYW5uZWwuIEluIHRoaXMgY2FzZSwg
d2Z4X2NvbmZpZ3VyZV9maWx0ZXIoKSBjYW4gYmUKY2FsbGVkIGR1cmluZyB0aGUgc2Nhbi4gQ3Vy
cmVudGx5LCB0aGlzIHNjZW5hcmlvIGdlbmVyYXRlIGEgZGVsYXkgdGhhdAplbmQgd2l0aCBhIHRp
bWVvdXQgaW4gdGhlIHVwcGVyIGxheWVycy4gRm9yIHRoZSBmaW5hbCB1c2VyLCBzb21lCnNjZW5h
cmlvIG9mIHRoZSBFYXN5Q29ubmVjdCBzcGVjaWZpY2F0aW9uIGVuZCB3aXRoIGEgZmFpbHVyZS4K
ClNvLCBhdm9pZCBhY3F1aXJpbmcgdGhlIHNjYW5fbG9jayBhbmQganVzdCByZXR1cm4uCgpTaWdu
ZWQtb2ZmLWJ5OiBKw6lyw7RtZSBQb3VpbGxlciA8amVyb21lLnBvdWlsbGVyQHNpbGFicy5jb20+
Ci0tLQogZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9zdGEuYyB8IDYgKysrKy0tCiAx
IGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93Zngvc3RhLmMgYi9kcml2ZXJzL25ldC93
aXJlbGVzcy9zaWxhYnMvd2Z4L3N0YS5jCmluZGV4IDQ5NmI5M2RlM2VlNTguLjFiNmMxNTg0NTdi
NDIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93Zngvc3RhLmMKKysr
IGIvZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9zdGEuYwpAQCAtOTYsOCArOTYsMTEg
QEAgdm9pZCB3ZnhfY29uZmlndXJlX2ZpbHRlcihzdHJ1Y3QgaWVlZTgwMjExX2h3ICpodywgdW5z
aWduZWQgaW50IGNoYW5nZWRfZmxhZ3MsCiAJKnRvdGFsX2ZsYWdzICY9IEZJRl9CQ05fUFJCUkVT
UF9QUk9NSVNDIHwgRklGX0FMTE1VTFRJIHwgRklGX09USEVSX0JTUyB8CiAJCQlGSUZfUFJPQkVf
UkVRIHwgRklGX1BTUE9MTDsKIAorCS8qIEZpbHRlcnMgYXJlIGlnbm9yZWQgZHVyaW5nIHRoZSBz
Y2FuLiBObyBmcmFtZXMgYXJlIGZpbHRlcmVkLiAqLworCWlmIChtdXRleF9pc19sb2NrZWQoJndk
ZXYtPnNjYW5fbG9jaykpCisJCXJldHVybjsKKwogCW11dGV4X2xvY2soJndkZXYtPmNvbmZfbXV0
ZXgpOwotCW11dGV4X2xvY2soJndkZXYtPnNjYW5fbG9jayk7CiAJd2hpbGUgKCh3dmlmID0gd3Zp
Zl9pdGVyYXRlKHdkZXYsIHd2aWYpKSAhPSBOVUxMKSB7CiAJCS8qIE5vdGU6IEZJRl9CQ05fUFJC
UkVTUF9QUk9NSVNDIGNvdmVycyBwcm9iZSByZXNwb25zZSBhbmQKIAkJICogYmVhY29ucyBmcm9t
IG90aGVyIEJTUwpAQCAtMTI2LDcgKzEyOSw2IEBAIHZvaWQgd2Z4X2NvbmZpZ3VyZV9maWx0ZXIo
c3RydWN0IGllZWU4MDIxMV9odyAqaHcsIHVuc2lnbmVkIGludCBjaGFuZ2VkX2ZsYWdzLAogCQkJ
ZmlsdGVyX3ByYnJlcSA9IHRydWU7CiAJCXdmeF9oaWZfc2V0X3J4X2ZpbHRlcih3dmlmLCBmaWx0
ZXJfYnNzaWQsIGZpbHRlcl9wcmJyZXEpOwogCX0KLQltdXRleF91bmxvY2soJndkZXYtPnNjYW5f
bG9jayk7CiAJbXV0ZXhfdW5sb2NrKCZ3ZGV2LT5jb25mX211dGV4KTsKIH0KIAotLSAKMi4zOS4y
Cgo=
