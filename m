Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13D117B0A64
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 18:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbjI0Qdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 12:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbjI0Qd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 12:33:27 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F213BE4;
        Wed, 27 Sep 2023 09:33:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CqlB+5lgIte6IAxgfpjVVBwy1lCyHPL5veEz9yt9/obLBW4u1ujVf4TXf0E9nbkZRM44AhUQ9FOTP6P13+6mMDve5MbJgvdrn1F0LZB5SUfUwCf2VUeqZ8j9EiH6y2Y6TZfT9eSHvchdf2cWoARlLmiHZuD4X9TiwHJBJzGHbAViZ2YkSVwFfRVPohIZcnf/E5rRagbtHvd6dN8eJgpd56p1bZYv+k1AT8kysbDw8P3PZ9cJ5IAiJ1nQUrvM4eQtsYr6ag95EuLxhHe/X1yJ+G7Eu1E/IBS3GiYbqQPo2fqWryvalfsOuYq2N7bTSYqjAEEyQcrqNV9cd0qQsBz/KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jOP92MESOXRIE8UQeRoit76K7t7rRgsKKFRdemcA71k=;
 b=kkSTKMtfQgfmTsypVUJiOmBrcypfZGJmB+37k8eAmIW1G0/u55S26wuqUJahvFtB5jZeHFESvFru/YMdxD7lsMJdc5xPTUm7hLbklkNBnW0GL5OKKm8ghbV4mkrQcd1ZRZnuvT2bW3RG4Qu8l6zKUjGt5kPaxwOWWqKgDkB/aW54BE8+j76rAOXXP7HOgX5bEjuF1hjHHp1qV8TBuOHEG9fl4CmdwcRj/HvFk3cVQkBxDoQCDQVcBBqS8dOu9aCs5dyu62VTWIlCtPB5LzsazqvjcLc6TVUXNYSTe7tZObdewO0BhmxMY8hpmEzBh73QuF3WuKO0EYfu7VobJmBcWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jOP92MESOXRIE8UQeRoit76K7t7rRgsKKFRdemcA71k=;
 b=N7AlkFB1/gaO3kFghs7nVtKyFzYoI75rIcChUSbWOwZ/m+KglD/ukZdO/jse9SR4+8FigqXCNG+NZin9ezTKR7GT1mMNHQrHyIP1PLUbkPBbVFtORDU6uqY0oWLT08hNl462oAVZjIvG2hKSQPHGQl589XrlVeGhbylx9GBSq+o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=silabs.com;
Received: from IA1PR11MB7773.namprd11.prod.outlook.com (2603:10b6:208:3f0::21)
 by CO1PR11MB5041.namprd11.prod.outlook.com (2603:10b6:303:90::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 16:33:21 +0000
Received: from IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::d6c8:4cb6:2594:d8f3]) by IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::d6c8:4cb6:2594:d8f3%4]) with mapi id 15.20.6813.027; Wed, 27 Sep 2023
 16:33:21 +0000
From:   =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>
Subject: [PATCH v2 2/9] wifi: wfx: relocate wfx_rate_mask_to_hw()
Date:   Wed, 27 Sep 2023 18:32:50 +0200
Message-Id: <20230927163257.568496-3-jerome.pouiller@silabs.com>
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
X-MS-TrafficTypeDiagnostic: IA1PR11MB7773:EE_|CO1PR11MB5041:EE_
X-MS-Office365-Filtering-Correlation-Id: 80fa8505-873d-4169-667d-08dbbf777556
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VGMY5yMdWT04GTSojxrFwnT8/BT8O+sE12s0hWLVcI+Serae+p3dq7vUJBFY5HZyDIfr7q+wd1L7fk+cgRFcJ9H73DvF6F+NDhP3+Lkc6RjhCG9eO9Ly3otrV2kAD3YSShVXpraeVqDjh0YT5JT4rlY92ncgrYzmfLSxK6l2tifRNqNlNxvaiAuzvEOVuqPwQvczjYpyNxA9aada4K+zQjEWarC79KEqVKmvzzRxqvBopf+dC0Lq60HXXINpFdEx2BTUy9yg7fL2danYc4zwd0rxyr0GNFUxoPJlgMRG/mESQ2HQxoiLzvP/wSAz6nF6GtDazjczBphi3l3gKMYVU11fpwqwZL2qmXyJXXZlJMQSwET3OO5eYJ1xQAlEgG3T041bA1fRp/OdiAXQZY0/aPGptkIR6gcpHPQmZVvKLfCXFCZxRzLC+R4ChVTyw53qjOTzx8OwnRFWyF/FtemAIqV5BnKjjkF2y9gnwgJhaA046c3tUpKmTTwMrrw5p6VCikpUrnrxfKMNmy9m/HdAVXw4Fihpovalj3TRaRMaang5VuQV+2QrOn6nWSS9NDna
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7773.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(39850400004)(396003)(366004)(230922051799003)(1800799009)(186009)(451199024)(6506007)(107886003)(66574015)(66556008)(66476007)(6666004)(1076003)(86362001)(6486002)(52116002)(6512007)(478600001)(38100700002)(2906002)(83380400001)(5660300002)(316002)(6916009)(36756003)(8936002)(8676002)(2616005)(66946007)(4326008)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzB6NmV4RmFNVVlxOU5zd1NOUzBXOUt4c0NNVFV3elY3YmJDNnplL29KVEFV?=
 =?utf-8?B?RzNmalBWUzhUYnFxTVRSUlV2TWtIMi9BK21KREZiSjk4NExlY2o0NVh6TDVP?=
 =?utf-8?B?Q09kbk9tcng2U3dXSGhYREh4SGdNazJuUkVnK0pPOWRDblByWXhJcTR1azlY?=
 =?utf-8?B?RWkzTGdQbjU3aC9aN3dOTStUbjhIWmRSUm1DcGFPbi80dDB1N3hXdEFkblMz?=
 =?utf-8?B?cDRYenJwcENHTEp5WXR3a2p3YzdBWHhlYkpSbG5PVzlENWtzRFlJMGhia1k3?=
 =?utf-8?B?OE9jamlGb096S0pGZHFGZ3pVSE13NmlHeGZwdHh1ZDBEeEhwMWdTelRtY0Fs?=
 =?utf-8?B?K2FGcktpanNVQ0dXZHJpYzB4ZXFKcUMxY0tObmJCWnU4aU9XOThYaDJ3dTZO?=
 =?utf-8?B?N2FTOFpUakt3bW1mMFl1TnBZS29IckFwdHkyWDdBRlVsY3Z4eVNHaHBhYTcy?=
 =?utf-8?B?ZzYreVBNaGJxcXNwRjlQdzB5Mis2MFExaTQ3VStKRytTV2toOGtQV2xEVzBm?=
 =?utf-8?B?SXoxREVMZG5GMDZncCtMS2p0WU5mOXRTUWR3NlcreFNERFdrN09ldEFkK2pB?=
 =?utf-8?B?SXdEV1k4a25SQ1BzUUFjWWJTcHArZk1QRHk0Lyszd3gyWGF3ekNINmU0UnFH?=
 =?utf-8?B?dnBzdkxSSndCb0FJeTBKN1RJTXQzSExMQlJQWmhhZ1N0OWRaZit3NGM5Q3Fz?=
 =?utf-8?B?VjhmRlVyWUdpS3J2QVlpbzEvMDBwbkFpTjErSFRtSUhtallkQkM4VEtKZWY5?=
 =?utf-8?B?cU9xbWNyelN5Lys0SENhMHc0Z2N2SFJXclJ0TnNQK3llVmJEQVI3MW9WQzVQ?=
 =?utf-8?B?bi9xQjZTRmc2SUpBREl6U1IyQm9EMkRDS3BkVEp4UitDNUpoMzA5d09ONlBN?=
 =?utf-8?B?MTZnd0xDSVc3dW1pREFvZi9aZVZHL2J6bk1TbEhiVUdQVXFycHRyYjRvM0pB?=
 =?utf-8?B?SWJGTWhwNEZRV1pJOVZ5R1YxS0VOa2swSlJzT0M1Q1BkcTlqVzdrSjFpMkVs?=
 =?utf-8?B?OTNZdEpxa2JwV3Uwell4alg5WTdOMmg2UVkvV1JWNko0L2I0VWsxNzFvcnF5?=
 =?utf-8?B?QTBmT3lLNXF0V2xlYjdUVUp3Yy8xeHFQSHBpbHoxVXhlYU9mem56SDhDcE1T?=
 =?utf-8?B?b2dLeGFvOUVxMm9TR1gxaTAvVWR2RmwyaEE3eUJvZnJZcitiUlIrdG1ELy8v?=
 =?utf-8?B?TUxNRzJtZmJhZzNDZ2EwbzVTaUozb0Q2TW9IVmtFTll2SU05Zno5aG1aUmE3?=
 =?utf-8?B?Q1JOd0JZeWhjS2E0bm1nRmVjMWFaN0gwSHMvbzJrc29QSVVUS1Z6aWRsWGcv?=
 =?utf-8?B?QWsvVVdBa3Y3NWtkTmpNSVZWejhhWlhuTmNRR2k1dkN4dXFlYVRlbVRsNWta?=
 =?utf-8?B?YnFjTDRBR1I0R0Y4a0k4cTdGbXZCRFd6WjFPWU9xVG1TWkdlUmxyVm9nbWV0?=
 =?utf-8?B?b0lEb1Z5V2JNclM1VUtkQWYxOVJlemRkZEpjd2NJcGZqNVc2SFBsMWdtOEtG?=
 =?utf-8?B?NDIrYkJESDJ3Ry9jQVF3c0lNdjI5ZTNXZnliWThhbTVXcWs2M2VER0VvZDlN?=
 =?utf-8?B?SmlVajlJYVptbm5jUDlvMnJyT0dYODFVR0FDaTcrVEU5RlB0ei9zM1Y0Z3JD?=
 =?utf-8?B?MWtXUFdSZFhWZVJyWUNpelg3ZVI0TWRSZGRxYWw3QXhrbElpQ0w1SCs5UXFY?=
 =?utf-8?B?Vy9xZnVvSVpndFlubzNEd3VFTERkRUFTWVgxUW1mVngzTVJpaHZXelliVXZ4?=
 =?utf-8?B?ZndoZDkzNzFaUkwyeWlEekU0bmY3MXF4eStWNTA4M3BlZk0wdEJyVCt4cjJR?=
 =?utf-8?B?RGlpU0huTC83bUIyMmw2MkpYL1R6OGFHQkZ6cEZFd3RXL0xFQ011R3oxeDdQ?=
 =?utf-8?B?ZmF6Zm00bVZZSENkRXdHWDR0dUpwZ1lOSmlBeE5Bb3NnZmt0VWc5Ykwvem4r?=
 =?utf-8?B?ODlZTngyaUd6VzZNeW01U2hwYStZSk9aMkJ5VCs4TVNYWjRlWjh4QkR4THRX?=
 =?utf-8?B?T3JDZXlWZkcyUjZ2OHBwb0QvVWUyTDBSN2ZxVUV2dE5NWjJ3d1ZKSHRSWVVI?=
 =?utf-8?B?S2hlMitkMWQwbTFoYThJWWlLQjVlRUQzaWNhTnpwak1tNHJXSG5FaGR1bTZP?=
 =?utf-8?B?TCsvM3QySVFVaGJrcm96THEzZm9PZFBnWGZjelJ3MTBDMWZLaTBDM1pMSWkx?=
 =?utf-8?Q?7DK9Hzd0E7J7V4t1TbjY6NNXDmJQuGckDDH32UrLUfVq?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80fa8505-873d-4169-667d-08dbbf777556
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7773.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 16:33:19.6087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MyrM3r982D6cpJ/TaaOPu2vLxZBGoFNFxpa5K/te1a/mKnsm7yBVEJM8xmguV7Mcsx8QIEsS4kuQmZoUy1EnCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5041
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

d2Z4X3JhdGVfbWFza190b19odygpIGlzIG9ubHkgdXNlZCBpbiBoaWZfdHguYy4gU28gcmVsb2Nh
dGUgaXQgaW50bwpoaWZfdHguYyBhbmQgbWFyayBpdCBzdGF0aWMuCgpTaWduZWQtb2ZmLWJ5OiBK
w6lyw7RtZSBQb3VpbGxlciA8amVyb21lLnBvdWlsbGVyQHNpbGFicy5jb20+Ci0tLQogZHJpdmVy
cy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9oaWZfdHguYyB8IDE4ICsrKysrKysrKysrKysrKysr
KwogZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9zdGEuYyAgICB8IDE4IC0tLS0tLS0t
LS0tLS0tLS0tLQogZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9zdGEuaCAgICB8ICAx
IC0KIDMgZmlsZXMgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKSwgMTkgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9oaWZfdHguYyBiL2Ry
aXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvaGlmX3R4LmMKaW5kZXggOTQwMjUwM2ZiZGUz
Yy4uZGU1YTMxNDgyZGYzOCAxMDA2NDQKLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJz
L3dmeC9oaWZfdHguYworKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L2hpZl90
eC5jCkBAIC00NSw2ICs0NSwyNCBAQCBzdGF0aWMgdm9pZCAqd2Z4X2FsbG9jX2hpZihzaXplX3Qg
Ym9keV9sZW4sIHN0cnVjdCB3ZnhfaGlmX21zZyAqKmhpZikKIAkJcmV0dXJuIE5VTEw7CiB9CiAK
K3N0YXRpYyB1MzIgd2Z4X3JhdGVfbWFza190b19odyhzdHJ1Y3Qgd2Z4X2RldiAqd2RldiwgdTMy
IHJhdGVzKQoreworCWludCBpOworCXUzMiByZXQgPSAwOworCS8qIFRoZSBkZXZpY2Ugb25seSBz
dXBwb3J0cyAyR0h6ICovCisJc3RydWN0IGllZWU4MDIxMV9zdXBwb3J0ZWRfYmFuZCAqc2JhbmQg
PSB3ZGV2LT5ody0+d2lwaHktPmJhbmRzW05MODAyMTFfQkFORF8yR0haXTsKKworCWZvciAoaSA9
IDA7IGkgPCBzYmFuZC0+bl9iaXRyYXRlczsgaSsrKSB7CisJCWlmIChyYXRlcyAmIEJJVChpKSkg
eworCQkJaWYgKGkgPj0gc2JhbmQtPm5fYml0cmF0ZXMpCisJCQkJZGV2X3dhcm4od2Rldi0+ZGV2
LCAidW5zdXBwb3J0ZWQgYmFzaWMgcmF0ZVxuIik7CisJCQllbHNlCisJCQkJcmV0IHw9IEJJVChz
YmFuZC0+Yml0cmF0ZXNbaV0uaHdfdmFsdWUpOworCQl9CisJfQorCXJldHVybiByZXQ7Cit9CisK
IGludCB3ZnhfY21kX3NlbmQoc3RydWN0IHdmeF9kZXYgKndkZXYsIHN0cnVjdCB3ZnhfaGlmX21z
ZyAqcmVxdWVzdCwKIAkJIHZvaWQgKnJlcGx5LCBzaXplX3QgcmVwbHlfbGVuLCBib29sIG5vX3Jl
cGx5KQogewpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9zdGEu
YyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93Zngvc3RhLmMKaW5kZXggOWMwYTExYzI3
N2U5Ny4uYzU4ZGIyYmNlYTg3YiAxMDA2NDQKLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2ls
YWJzL3dmeC9zdGEuYworKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L3N0YS5j
CkBAIC0yMCwyNCArMjAsNiBAQAogCiAjZGVmaW5lIEhJRl9NQVhfQVJQX0lQX0FERFJUQUJMRV9F
TlRSSUVTIDIKIAotdTMyIHdmeF9yYXRlX21hc2tfdG9faHcoc3RydWN0IHdmeF9kZXYgKndkZXYs
IHUzMiByYXRlcykKLXsKLQlpbnQgaTsKLQl1MzIgcmV0ID0gMDsKLQkvKiBUaGUgZGV2aWNlIG9u
bHkgc3VwcG9ydHMgMkdIeiAqLwotCXN0cnVjdCBpZWVlODAyMTFfc3VwcG9ydGVkX2JhbmQgKnNi
YW5kID0gd2Rldi0+aHctPndpcGh5LT5iYW5kc1tOTDgwMjExX0JBTkRfMkdIWl07Ci0KLQlmb3Ig
KGkgPSAwOyBpIDwgc2JhbmQtPm5fYml0cmF0ZXM7IGkrKykgewotCQlpZiAocmF0ZXMgJiBCSVQo
aSkpIHsKLQkJCWlmIChpID49IHNiYW5kLT5uX2JpdHJhdGVzKQotCQkJCWRldl93YXJuKHdkZXYt
PmRldiwgInVuc3VwcG9ydGVkIGJhc2ljIHJhdGVcbiIpOwotCQkJZWxzZQotCQkJCXJldCB8PSBC
SVQoc2JhbmQtPmJpdHJhdGVzW2ldLmh3X3ZhbHVlKTsKLQkJfQotCX0KLQlyZXR1cm4gcmV0Owot
fQotCiB2b2lkIHdmeF9jb29saW5nX3RpbWVvdXRfd29yayhzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndv
cmspCiB7CiAJc3RydWN0IHdmeF9kZXYgKndkZXYgPSBjb250YWluZXJfb2YodG9fZGVsYXllZF93
b3JrKHdvcmspLCBzdHJ1Y3Qgd2Z4X2RldiwKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVs
ZXNzL3NpbGFicy93Zngvc3RhLmggYi9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L3N0
YS5oCmluZGV4IDg4OGRiNWNkMzIwNmIuLmM0NzhkZGNiOTM0YmQgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvbmV0L3dpcmVsZXNzL3NpbGFicy93Zngvc3RhLmgKKysrIGIvZHJpdmVycy9uZXQvd2lyZWxl
c3Mvc2lsYWJzL3dmeC9zdGEuaApAQCAtNjYsNiArNjYsNSBAQCBpbnQgd2Z4X3VwZGF0ZV9wbShz
dHJ1Y3Qgd2Z4X3ZpZiAqd3ZpZik7CiAKIC8qIE90aGVyIEhlbHBlcnMgKi8KIHZvaWQgd2Z4X3Jl
c2V0KHN0cnVjdCB3ZnhfdmlmICp3dmlmKTsKLXUzMiB3ZnhfcmF0ZV9tYXNrX3RvX2h3KHN0cnVj
dCB3ZnhfZGV2ICp3ZGV2LCB1MzIgcmF0ZXMpOwogCiAjZW5kaWYKLS0gCjIuMzkuMgoK
