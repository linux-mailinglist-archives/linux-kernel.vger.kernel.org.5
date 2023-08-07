Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79614772895
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 17:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjHGPGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 11:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjHGPGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 11:06:11 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526D010F8;
        Mon,  7 Aug 2023 08:06:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MRueQWB98NEBCdGy+QHPwZPVuHeNlMtUR9IBqkiSZx2hmqhUZVlxW3ePAPgQzsfcd/aB4xMhuJLwjc8p71oB9ySn36++XoahdnBl/yVi6mZL+J5xfrfKMmZHvD1skz458rZsBA7BpyRwneuhwpnbBaIJSX6D3WiPhs2jjUgX6F2ANvmtAf/Ys3jtmWPDf1KK4g89R5QqKQ62mTUTpQWczdEIo+howI4gFBHt8w8G7asoVLB/H+bxYZDrj1XlTUsBPzfifR5rPrI9irD+mfqgHiQw/XElUMsUSLhaNTnzc7b4Ljr8C2WG1MYGk5koNDhwFlinrcue0t0uW1MtZvutPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jOP92MESOXRIE8UQeRoit76K7t7rRgsKKFRdemcA71k=;
 b=JV5OndEi+l3uqa+eDykICL8Az7JS/KrWbvmgefW9BkU5K6E+SY9dTCox6A3xIaBAtmRdS/i6QBh8BIS1922kHA+1XendBdHQ6arRnlg5xn5w2Q83U5NIX/dCmD2y4n7aAs32C75SDgIdsS6l2K3xqUtQaMNXLWQlMr+aoz5L4qWtuaD8iBe3pALAy1n0h714mfrvLrpAPDQn0X2qVKEx7t0URUSYFi0hrfEqymL42JQEivzbznCbc2mgbkPI/6ElgUUiNyGf2/vLNQpnWfe677adyqqdmlC6RUeD3ji04YZzUJdNGQNaavP/DASYyK6pA0yUUJU4TdrifngoUjpieQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jOP92MESOXRIE8UQeRoit76K7t7rRgsKKFRdemcA71k=;
 b=TgNuy6fWywhvqvh9Ld1mq32zvKqd1mhTY7b8uePJ3fxWZ7C2jYdL08GPYVv5PqSHOad3MiM9YEK5e/nJFqMPeynXLVGa5h0QTt9KpYmLMqsyIcoPvsSmU9LXYb/wJhooOdeNkeFp6ESCGsioYVdCHyRLNn+dNXLXqWxDXmZlfgg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=silabs.com;
Received: from IA1PR11MB7773.namprd11.prod.outlook.com (2603:10b6:208:3f0::21)
 by SN7PR11MB7590.namprd11.prod.outlook.com (2603:10b6:806:348::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Mon, 7 Aug
 2023 15:06:05 +0000
Received: from IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::14b1:be6e:19a3:2eca]) by IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::14b1:be6e:19a3:2eca%6]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 15:06:05 +0000
From:   =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>
Subject: [PATCH 2/9] wifi: wfx: relocate wfx_rate_mask_to_hw()
Date:   Mon,  7 Aug 2023 17:05:35 +0200
Message-Id: <20230807150542.247801-3-jerome.pouiller@silabs.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1919d4d8-34ba-4d34-3363-08db9757d274
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NSPywcVr6fApUXiYHY9vsBGhwupGZjlaNg5D2PmvbNFcbJaLTVVSczI4XTZPVjIBGMtsZX1zvwjAECF9vUD6qLAWAIat8taSi8UAN5omm0G5rZ7aRLMZZuhiqmq67SBNxTBEJMLhWCRmF4bdEF1hBn2h0igNrTJNmCBblQuCOL4YBkC1TZk95u23JchRZiPJqJNYhhF2Hu9B833T7k7whM2aCk8+80vTlHNxtc6YcsuodQ7diqITwI0sUDI14OuMiZiFpC63qHE5GIKHMHDe5xSFRq0XI/CztCzz/l7r7ZkBZorSbxq721baxZpKkEoGWMYPeaKmTnUEeBgZHcAUSePFa+L9fazYKHtB7mIVoFYS14oP8FKDow/nEPoSdIRPi+2rMtu+06flUPhzDtaAmfr13mq2C7G+CKbAGYeTkJjGooEzoxqCcCN7yAXWzlDI3ca0pFrgeQk9ZU1xMCcCpnFhGWMvUJE4ZjEeHS5JzOzipGptPsAwpQ5KpaspMk/xETbYejrpjwTlbZSyKSkZJ7wbkU2PMtp676UfIV3xQvwpahx1nGEexS975qk82hHtBzq9V1jHE79GHGRtm9AZZS04IZrxGet8ObSLTAhAS0+R3ijzhAk4IbpuBdBERZwq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7773.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39850400004)(376002)(346002)(396003)(366004)(451199021)(1800799003)(186006)(2906002)(4326008)(6916009)(66556008)(66476007)(66946007)(6486002)(52116002)(6666004)(66574015)(83380400001)(5660300002)(41300700001)(8936002)(316002)(8676002)(38350700002)(38100700002)(2616005)(478600001)(36756003)(107886003)(26005)(6506007)(1076003)(86362001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RS9zMk5TMWtXZGJrazg5RVlHenlhZ1VyL1BkMVFsVjhZRWpYajBTYmdsREZB?=
 =?utf-8?B?c3pQTFo0MnMwOW1FdFpMdWVqdVp1UDh2T0hUSGJuWjR0KzdGRWhmR3g4c1Ur?=
 =?utf-8?B?Wm0zR21Gd2FqMTNlSCtCZXJwOTBaTWQvOW5YdWtvY2tKMW93TDRvN3d1OFZC?=
 =?utf-8?B?eWtNdmJXMnJnUUdXQnp2NitGVUdkS1RTN3F2ZG05VTM1Y0lQR0RHYkNFNUR2?=
 =?utf-8?B?Y2ZNZ2lIRG9YaUF1WUlPUVpORTVCeVJnKzVBZy9FWHNEbU5TVVo4Wm1FQ0Vk?=
 =?utf-8?B?a3BLQnpaV0dLSThaZ2FNSDR1YzAvYTJLNkd4SmFOZ1F1ckovdWxVVkV5cFlI?=
 =?utf-8?B?MytRTzgvOU44Z3FZdXV3Qk5pK0d2WjE3YmVLK05lSHlpVlc3UGJEcGowSEZq?=
 =?utf-8?B?RTdKQ2ZXMHhnU1gwVnZ6YWpzelR0RWVibGo5NHF2dFh1M3RkTVdvMnJPVjM1?=
 =?utf-8?B?YUZQdDdHaHRTeFFFMVF1WXByS3FrRWx0OCsrY3J4WWdqVTBsMWp0dy9ZWUF4?=
 =?utf-8?B?eHBtL2tFK3ZRWGpuZGpmOWZoUkZjazZPeWJnaVhNR1RJbU0zNzZYZzMrZmdj?=
 =?utf-8?B?Y1ZOTG5MSlh2V2ZDV2lZVXVPcldsdHZ5YzRzaWY0MDZiK2FtaWlpbjFHQllI?=
 =?utf-8?B?a0FsWDBXMGRMZDhOS1VueEllREZpVnR3MEV5RDVIL3VYUmpyMEZsV3lDV0E2?=
 =?utf-8?B?M01MQlpHRlk2bVV5R0hjV0xkdWtDR04zT2FXMXpWY1FuTldWL2Yra0VtUmVI?=
 =?utf-8?B?ZnRNaXNkSU96N3FaNFVMMy80OTU3OUNnMlVqZ0NhYVdmZ2x4U0o0WnM2SjM2?=
 =?utf-8?B?a1RiMmN3MktMR2dIMHBzbkZRYzlNamgrT3FrbVRKUlBzU1V1Q3o3dzREZ2ti?=
 =?utf-8?B?bUFNUDZudUtKTGdQYTF3cHV6cmZMem9iTUUrYlFBS1FPR3NsN0d1bXJ4d3BH?=
 =?utf-8?B?VEkrMHFKOFNkVTBDVzA5aDNCbFEvUEFRY0xXSG1LMk1aamFYRU9CdlZoT0Uw?=
 =?utf-8?B?TGpCcmhZT0pNU3BaT1haTmVDUEdWQ3VWaG9SMlJNdTJBRk5tQndiVEVtQ1hq?=
 =?utf-8?B?ZktHN2MvSzF4aU5iNjZpZUV2bStwd0g3bXV1Y1ZwZ3RvWVkzUVVBNWdQL3Ju?=
 =?utf-8?B?UW1RMFRGbHJwQXczdGxvZEgwMVUxWVk1SnpjQVhyOWN2V200UWxyOVk0SzVj?=
 =?utf-8?B?bkx0NStwVk9BM0I0Unl6aDh4L3QxS2w3MXA4NjNQODUxYVhxYXh6T1pFYis5?=
 =?utf-8?B?M2FDRHpQMGNSY3JZaEx1SHAzdThiWDRXMmFRdG5XWDNDN0x0UktzcXVpVkNL?=
 =?utf-8?B?eVliekowaVZPcXZXdHYzUTE5L3hHL3hqRkdGQXE3OTZGQjFKVWUyWVRjb1Iw?=
 =?utf-8?B?SVZTQ3BLbVdybjJuYjlHVEVqc3BuZ3dWUGVSd0dZNEIwc05KK1dvdDZxTnRZ?=
 =?utf-8?B?RWVjS2IyelZTdklpOGRJdlkxT0ZidWxJOS9GN1NsNkFYZlRkSE1HRXhlN0ht?=
 =?utf-8?B?R292eGxuU0I1TkpQWXpHcll6YjBLS0dJS3NUOU1qb1kzRXpVaVo5d2I3VkFU?=
 =?utf-8?B?cjdCYnA3RWRVcGpudWxoNlJndTU5dlRUb040TnZZUHRhUFBTSkNKcHNLZXNN?=
 =?utf-8?B?Um9paXpjT0ppVDRjaitGcU5lOFZmWUppeVd0NzkxVkRqQVAwaG9XWkhxdkZs?=
 =?utf-8?B?UVdRQnNqVHJqTWhGM0s1eENwdElwOWgrMFNmYWltRTNpWHRpOHExdE9NTGdI?=
 =?utf-8?B?V1RBNVVXSHdXcXhnNnlJbDB5eHlsSXFhaDZQbHlpS3p4djhOVjl0TzFYZHhG?=
 =?utf-8?B?RjI2WVFFMWJHT3k0NzhqOVMwM0Vza1Ria29EUTBUK3hzVC9xWFNFWHlQbnhV?=
 =?utf-8?B?L1BVQlc4TUJwVHp0YVNrNEhRRTNkNytmelcweUdPd3c3MUk2R0FiT2Njb2sx?=
 =?utf-8?B?b2dIUUFJS2xFZC81OGxBM0docHZxMUtWOWtjSW1wa3JPa2tVdTMrSTlrVmcy?=
 =?utf-8?B?K1ZEbWtrU3hoOUhVUTNKeEZpemtpNlliamcxMldnNWROZnVhU2o3S3RSR0xU?=
 =?utf-8?B?bGl4Y2E5MDdnOVVjMnM2M2VKbHpiUDBRYmFqWDh3YUtvQU1GVTFkK3M1ZEFI?=
 =?utf-8?Q?QYlcO9Sg/pDs9wjxCBwhOFesH?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1919d4d8-34ba-4d34-3363-08db9757d274
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7773.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 15:06:05.2821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u4JIqNpD8Q/HOVrtcP4AAaCACA5BezAuCJoGe5q8wyh510gqzY+1Y6zNfpPNqCrG3UaLA9v8moFjEyAD1I+4ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7590
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
