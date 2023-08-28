Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1787D78B27F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 16:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjH1ODt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 10:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbjH1ODm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 10:03:42 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E6B106
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 07:03:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ys3/lgDslG9ZJHXvZt04pI71468Iw5fD1xmZhwFfd2wT5v56YJMj4eYq3CQ5pjWthL/TbZaB3WYQMQha1PZZnREpJi0vX9UXxfqTYPgj9pZwLraxlQGgJVHYZ3TGz1v0aZQ89x2uv/t82kow7uw+y+RnTS3FqIVyZAlc3uFxtY8B9DWTXCelghKyoLUEOG1xnCcVm723WWwUUXBaENW9+alpM2bxdQoxKnnYl9OEmovP8QUi9leXkwFDEltyi34i2Ss9x4KoQplThg9lZqQZ0+Xqug/C9uvxFvgCawq3rjh71QZCtx2HpYOkXK3+lOac1Wd+Fy/50AEGJCGous7dqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=suyy/SU46CeJpEvOmgudZjN+TV2MOt2KjhNPUGV8TRo=;
 b=Yfml/qu7H534FF9I/8d6MKte0OSc6kvhEMNLSWxb2gg+PMFVRH5+hiCTU6AorvlMcWWcp+4ZPnCxWU0lcFd6yOt8jvDd8AlAVrveaNK0cXQTLY3ohsNr47zZStT5AJawJGGCReUDj8ABP5ZMEZnUoi2vHvUx5YFXSBrRjSK5VxEaQwQa021OSvvBxpccFv/7UH5+Urs7lvlzD5y4VVqe2omWSh9gULatpAD4+21nd+/hUDKWC+RS7cC+68AvBJ8AFg4BFtmjSECrC3TIPnIxCNn8uGilyxKMiyFHKoFKQcvKpGh1JR/mtEMdPRc7zYOohqdpEp5SeQBxzD8cmefuHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=suyy/SU46CeJpEvOmgudZjN+TV2MOt2KjhNPUGV8TRo=;
 b=mFwf36WW3ue/HgGTMHVRi5fMynZIE72Vlzha3I4Ru1IrEkQjTiNtiwhukrgil8pFwoAryxu47MCeXsiIRPOuwzT/945/ZL6EJvzu3V3LHTSTtKmZfb9KdVy7p72UmlteiXu+FVt4NkNM0YTOCTClDU/ut3s/LGR0MMZPPXyPHDDREXsoUAvAX47ALUeVor5NoUwn9kOSYNX5x9V8y0L7G+RR9u8LEep4OKdid7u4CBYil26/yt7lFalEAskC0WSTv9OSTOg7hG4WJ8ooJP8/oSXPlkctoc7VYf9X4R7y1pH3paWAHPurs2GIiNzwvNlx8N/XPTtjHYaBYWeA01p10w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5730.namprd12.prod.outlook.com (2603:10b6:208:385::9)
 by PH7PR12MB7355.namprd12.prod.outlook.com (2603:10b6:510:20e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 14:03:35 +0000
Received: from BL1PR12MB5730.namprd12.prod.outlook.com
 ([fe80::926c:4184:7e6:de25]) by BL1PR12MB5730.namprd12.prod.outlook.com
 ([fe80::926c:4184:7e6:de25%7]) with mapi id 15.20.6699.035; Mon, 28 Aug 2023
 14:03:35 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, willy@infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        ying.huang@intel.com, david@redhat.com,
        Mike Kravetz <mike.kravetz@oracle.com>, hughd@google.com
Subject: Re: [PATCH v2 3/8] mm: migrate: convert numamigrate_isolate_page() to
 numamigrate_isolate_folio()
Date:   Mon, 28 Aug 2023 10:03:34 -0400
X-Mailer: MailMate (1.14r5971)
Message-ID: <5B21664D-3D87-4D2F-A306-548100D46E12@nvidia.com>
In-Reply-To: <20230821115624.158759-4-wangkefeng.wang@huawei.com>
References: <20230821115624.158759-1-wangkefeng.wang@huawei.com>
 <20230821115624.158759-4-wangkefeng.wang@huawei.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_0D186E49-2E1E-4D30-ABA4-0D1D913CD588_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR14CA0022.namprd14.prod.outlook.com
 (2603:10b6:208:23e::27) To BL1PR12MB5730.namprd12.prod.outlook.com
 (2603:10b6:208:385::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5730:EE_|PH7PR12MB7355:EE_
X-MS-Office365-Filtering-Correlation-Id: e8031dbe-e314-46d7-dc14-08dba7cf921a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tQshAGxbRn0PPVRfXLiGx3tH6shTh4znYislTMZSrkyBl8JuIAdg0ZvQTND4UOi3MLoobKkqtS0XyWtDey9AqmGknAhrycmzSLRH3dkF1MVr7S2eWZdQ11E7lkFN/UFvMo0hUCbIkT9larq+bk1gNvBDj8TWVz+018CAxpPs7YPMlJ8JIMb0Yzx1o055FDEOfU7h6VKBC8JugZI1f7GZmlq17qZ/2LVJK7aEul9xC6aGOCSXiyKtGIiUYL+Y3eWtlVDZASW6lglST6RbBJPlELAje3li4+MWw1R4O8AkcDHKfZmqRGkzaHEBT/u8DqlX3MgpmcI+OXw4gsBLnh/NpLlLKRFuwR8+XUBmrmLsCrfZar+B4OdbTvHmOHEAK5kY52yQ6JqmCYrz9JENzQ0jk0LF3t3OVSDGULuwar8SZ86KDSUxD8XfUDZvUnH2ij40MJ11qaVpeePTEVC/GmK+m7VEhZmxvShEgQKtu/mRt+iJC0YN9ylgjNJn0Fiof6Y2fz3F0XVdjx5Iqw7bpQaeeyZaFq3XWxgDJRn3cwhO16RlKhkDD9kZQrXZAbJB8+dWndEn+37yq1uWlxhGtpNcnrsCqAU0i5KQ/lGuUgeUinO1rux+gGR74kLiYdDWsgDD+T37+UDKTyrcw4j46H1GGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5730.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(39860400002)(366004)(396003)(186009)(1800799009)(451199024)(6486002)(6506007)(6512007)(33656002)(36756003)(86362001)(38100700002)(2616005)(2906002)(26005)(83380400001)(53546011)(478600001)(66946007)(66476007)(235185007)(8936002)(4326008)(66556008)(5660300002)(41300700001)(54906003)(6916009)(8676002)(316002)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q6fDpiMqCO3YxEFNS4Vdjabvk/vED6hArX6PLOazrG/o3fNVyH1VAG/rHNxC?=
 =?us-ascii?Q?UEltMocB8nGUATpwWMvQhclf+lJ0ROrvwX4k/j8B0FFWOrQlplOYlr/uQc5H?=
 =?us-ascii?Q?/DX9KtuD6a6Zcg42q/aba0v7NasHvSUfcc9hmRQPE1irqkAH3u+8FU1iViGX?=
 =?us-ascii?Q?7qbAUrBaX9VVJDTA4++pF2xw3sCMphNLRo5uiYAsrwkKENhqqRZUQeKkLwzm?=
 =?us-ascii?Q?GAYrwxMXtCSqvJgPb1JIYXiYWzJDVyibLbFQY7+UOBz4iBSW1SQLrS8leEuC?=
 =?us-ascii?Q?JyCwPi2iOLkkb9WkE45fPlvgJJK3KRnYkIVluul+bUIm0E6r3LJHG9o5g/lm?=
 =?us-ascii?Q?mx9evhP0KnFS4R41RZd62BqWT1hPixShJ2QOCZt/hSU1jNyhc7XDFhweCeRi?=
 =?us-ascii?Q?UuH7O/wp/FEiaOV7qhsVuyyfW2bSmE5AxnohvpDbo81XJz7ZGjvzwDNQEn/V?=
 =?us-ascii?Q?A+aP+tLmECQ7htNF9JCFEaaDH0gnLIVPuX98eO//YyamGHJlDIuZHaelXk/2?=
 =?us-ascii?Q?CXfmLTHGvCkIhTMnqetYtRuqRAtduhEOqYORygBcWrqGEWDDDIiupM6Gzeg5?=
 =?us-ascii?Q?7cD3JTBU6keyDxT1Jmtb/AsFv6lRifrXjAhcixAYS2SMayjwpbxa7iXMHB7t?=
 =?us-ascii?Q?aly3pTpflXstD5gBFLyA8ceumfbNaz4EeKifQEdCuUYzNCcbukNkkKSHpwuu?=
 =?us-ascii?Q?lQzxKXNgq7wRg9YdNpVZnyp1ot8wqa9jNs6aQCtvlnSpX6ZFs8ytDUpJWUeo?=
 =?us-ascii?Q?RcXlTfk3p1knamUQDMCTuckSKiDI7bJQYX0zCWyQFwUtw/Qa6vWLWDViE4DQ?=
 =?us-ascii?Q?G/9W31cPfWjm6b7xc4jQef2EwDz0jwH5KgxCSua0E1qz2O+uMMgg2ZBJ+Y7I?=
 =?us-ascii?Q?X/lGKs96XAMT3qQCBVVSCuFOmgPUTkeM52HLT8Ys6nvUqloFm0eghR196EAQ?=
 =?us-ascii?Q?vpjLmayfw4qybrFssxxJLjozpxZGiSP0jeT61HxvRzqKeFU7mV04KqL2Mj71?=
 =?us-ascii?Q?IHub+/s28zURFUHsiQGemd1sUFOxaXxaN2UjN7VYCXn0JHZTKMOHkL2j6aQK?=
 =?us-ascii?Q?z6RKJBzrhC28bTmqeFFLfTkIwqOB6jUHR+1TF9SEW2Y9EKaQL2N4eqXWqH3Q?=
 =?us-ascii?Q?D7dKRCDAXQoDL01jEkk+lsjt7Ibm+BR5ScFT+SRWosbZaPH0ONT1Mvrw1tJE?=
 =?us-ascii?Q?mRCGa1b0sU2Yo4IUWBo65ecc+eW+LxXqml2tV9stEDEkuI2EC1IXjVbOitpU?=
 =?us-ascii?Q?FvM4GIxgX5SVkn+p8d5DuNDeFperALaUclfmr3SErokDNwwpOWFDZ7/vihTX?=
 =?us-ascii?Q?ZiPOXYjVdW8FWsuquSr1IHHCH4akumhkApkch8/MxX8oBanS7lP6DYI22Gus?=
 =?us-ascii?Q?Gga2M3/29mckkzeoNNObifIhyUBU8q+bqu24pP8fJWMoCzZk/lLGZQ3NVQfg?=
 =?us-ascii?Q?Y1sgjQx+RHg0VQBYHpIqqvWJ0kWTl6E8aNN4bTqeBLdDjy2RuIE/ztSdGJI7?=
 =?us-ascii?Q?s5TRN1HwEEMKjPcAPZLskShJvJ0lRHejmuuEer1HmhKoOtLFdHyxrWaIG+Cs?=
 =?us-ascii?Q?v3cs8vTMYv1W7o4CHSnNkvNxJ+IksYVgBGlqt5m7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8031dbe-e314-46d7-dc14-08dba7cf921a
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5730.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 14:03:35.6304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E2L1oSsXIz6Cn1gojdrHHcCCq8LIvKVg6eIL0leItS5SEUYqmOENVDOFmvQKecbs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7355
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_0D186E49-2E1E-4D30-ABA4-0D1D913CD588_=
Content-Type: text/plain

On 21 Aug 2023, at 7:56, Kefeng Wang wrote:

> Rename numamigrate_isolate_page() to numamigrate_isolate_folio(), then
> make it takes a folio and use folio API to save compound_head() calls.
>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  mm/migrate.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>


--
Best Regards,
Yan, Zi

--=_MailMate_0D186E49-2E1E-4D30-ABA4-0D1D913CD588_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmTsqTYPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUK7UP/R0VlbNR/SQGLYYGclnQNOQHxZwzFf65ObRo
vWi3ZnvVJWzpnqCTO40QmW8/Jfg2fBmipCHlYvAzJ3kFeB7lZvdbDtCCzAiyNdPB
Xo85v8GNxhsm9EIS9h+BBjzUxjqHniITBXDGInQSUcz+nIuf030iLLA9Cp9kWBFf
/T2vXu7TDlc3+RY5bVrELJW79pmSyXH5KjWBEDpjE3oS6vff5VcP8vxzkFbWrp9k
RtGCBXHPvhNITuVfRyw9fdbCFNbtWzGbuehG7yWButfcy1/+O5b1kjjntgvjQgVN
UFBj3jWhOQ9XZybs7b/r4vuTkiFrpQgW047q6gPY3jEvxI1K/bHo52baRMJBUubR
ueDL36ISlpBF324+fP9QSp6k8TUDEWpDUhtZunBIoIWIpkbY4Yh2oQz1PDt3ILIN
6yrMxNB1qDomx7iZw5TJpyb775KM524emLexLCtXrtLw7kWJIFzJ3hB2A+jLbFKI
MoVK97BR/QNdj6advNn1ipBQuWpGkg6AurY90eGP33aInL6yoFP//MI+QnJzTTJL
5hbbKN34JMiQowxtFTpsjPsVFLdjgCBrB7fhgtlTAAnmOIF4pjHEoaxCT0nI4riN
uuOY6ZjlBj9O+r/OMeGfiBcTpith/veQViTpup/os/HstrPogs/H0z5K+RnA6Ntk
rhx2mdNV
=ROyq
-----END PGP SIGNATURE-----

--=_MailMate_0D186E49-2E1E-4D30-ABA4-0D1D913CD588_=--
