Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C8675FA46
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 16:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjGXO6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 10:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGXO6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 10:58:15 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AAE910C0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 07:58:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z673yg4A+6JJWxiJE9/PenW2OHMKNqhQvrawJO2yNign3h53b1WZO6Fo7A/j+Nyy237cqpE59ZpoaxaUx6aNb+S8xjLRpqhAFWUvK11HXpsfPTAa5AV94Y4j0FrhYwsdbQxmWJ+xtdtAfElw79tvjzbO/hJAUMvyTccl9qJti3rtl4xmfDcKtoap9aSHtTzh0WAyKQU38BArNEiRLyG0cebfGZ3zeDZc+LOl+9NHMgER1rXH2YSVx01w1o08Y6PihjZcJfUY1GRxv3zEMp6Or7q+AXTNDvW2AcntcFjIntt5vg4R560aMEWo038Luf092i64kkwBTIK+0Rkl/iwIyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OFBtNClghiH8ebYZvgzi0cmk1iuOkNYCTYiwsb1afxE=;
 b=M0B/G0f1KYkaokTgrWf2S2tBjuOgAvhsjXXLnT2tVQl/ObYpaoZ9WGPuO7TfGhUgfV+l7E3nyYmobfuF8UB7jA+EbErSA1TgMAQ3iQXMSj/XD5qJBa/wOM6GlfMBxO/Y4jEyeOCxxQgaxGcPz6CqkJ8JbIogRBiDgt4DELEfLYbIyN3MSEMmEd3FAP8AENNLTAbm9otfDZu4+O/ot80I19RpPdL0qtBeX4/a2z9sYzZJ1bowzvry0XafLzpH5JV4fqACeN3QMeuw+ASfWTELaCtWfiYgAns8E93K5S2AMWRXaqto3DY4vRaqjX52lczOLuh/vBMqPkgR8eEMcEyaCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OFBtNClghiH8ebYZvgzi0cmk1iuOkNYCTYiwsb1afxE=;
 b=l2O90T50rFdtnYVW7bm8UOitySQX/jNKIe9fNXqmffdskvoa6fTvkNCY6MCISPSP5nGYLxmeMWsc7h+1EYZuv0YhUNZExGYx4PvTWCA+Fi7cffHlQ5bCul2MSoLMJoi5Sz6OBNZ6oKjLjY8Zcet4+bNIn50yd1/9WEJ4HeKE3fjyKWVrpUIsLxL5BKd9+al7ZBlIPTRNbgTSnIwjlEkqVa7mXAZvNcBo5Z/oQkuB9xlQ4Spud8EyIGPMDItbNpRpu36FFAKNDSkTvhH8zBVgugSKI3pDwKGMXWQxX1kYwNG/DyNuml4xuPghnF8quox9z2EIcfoTt6LaP0qIISlodA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.32; Mon, 24 Jul 2023 14:58:12 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::c166:b535:d93:641e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::c166:b535:d93:641e%4]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 14:58:12 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v3 0/4] variable-order, large folios for anonymous memory
Date:   Mon, 24 Jul 2023 10:58:09 -0400
X-Mailer: MailMate (1.14r5964)
Message-ID: <2FCD9E8A-D38A-40C4-9825-AE7ECEEFC715@nvidia.com>
In-Reply-To: <83bb1b99-81d3-0f32-4bf2-032cb512a1a1@arm.com>
References: <20230714160407.4142030-1-ryan.roberts@arm.com>
 <83bb1b99-81d3-0f32-4bf2-032cb512a1a1@arm.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_77471788-4D23-455F-B4DA-D236594F4141_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR20CA0018.namprd20.prod.outlook.com
 (2603:10b6:208:e8::31) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|DS0PR12MB7726:EE_
X-MS-Office365-Filtering-Correlation-Id: 53457cc3-358f-4794-1652-08db8c5666a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OnxYaTgd/8fx/VctgP8wnr4uLBUdi6iHRm6CT5mGklkocJPwpUhy3r6tUeIPYH7wxxDzqf6T87G3th445xxQ88m5u/F4++x5TWbD5/OsZdjJtiX9jLw1w2HVY22UU3rQnh+tNAtJxr2z9K3eldDarCkqCQSoxkXMhMaG5cIYixgyA+x3uH7UKt8LAWh+bpsS+TgfK+1bw8zRdyk9kQWYbE8miLeKVYgIPeKO4wOXquwLMAjVHiK6tWTkrnJHBMBs01fc4xEhxsyjXBDu8gvqNe/lFXONxVvlguQGBu+vSfAF8bdIKLdVQIstAprwWXF6Kw4CJCd/DY/aiKAzIUh31Ox9yb0OnGvbYDyNn82WaBCRW9Dg6xzyu9etFt0xinxVcCCGqdb8cD6vcOA7uNChvxqKOkSU/Ka++QTTkbM6hF/ExlS11cgO23x9LNSECggue6/w9ns/u30lRkrVh4dNNqLrkGB/mjKpNY6FSRiaCv8OcHWTjYvHP6x8BJ1QuwDD9MfJV5Tevm6IrB2FMNT021HzQOUl5mPSWO1iRYuefnC35toXjKVD5MHmikDb0HTmL3CCrB1aDlPVfU7Ijyy2qEcRQKyks8/VmN72Xt6yH0M7eCdoySP+P98PZo5lbIwzJTyyBjWDegE0d9iI7NQtMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(451199021)(478600001)(6512007)(6486002)(6666004)(54906003)(6506007)(186003)(26005)(53546011)(2906002)(316002)(4326008)(41300700001)(66946007)(66556008)(66476007)(8676002)(7416002)(6916009)(5660300002)(235185007)(8936002)(36756003)(38100700002)(86362001)(33656002)(2616005)(83380400001)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cxpNfPJtC0uLabzaJ7Eo6rvt+U9P6TzC1s7yAb9fEmho1LoMtx2wpbLHaD8q?=
 =?us-ascii?Q?BMwuXjRhdZAkCgOZM0CZe+o+ChELcp7qfcXe2QJ+SWalWCTHks9KuXkKztHN?=
 =?us-ascii?Q?1+GoPXUX8EZs+Kh9kopwo3ClJGUd9FrBFycoj/lsnV52PanuwgbM3vovarQ5?=
 =?us-ascii?Q?YPxtzccq1Q2bDQMsVVeejsq/A647tzWzWqKnIaBFHc+Fsa5HmbiiWm5zpfEV?=
 =?us-ascii?Q?OV1uHtBOiCkrEMuUW5ojtVfA326aaWbTrq3M1NnJHXBcoAfQ2b4+wCzG5alU?=
 =?us-ascii?Q?cbhDo1M9kU0wnnNnuxQU7FMpVaHlzAvjQEmCfhdv10mYilb4ryqlRUmlvRKT?=
 =?us-ascii?Q?Wr9i5A6mmXEMxMp9u30gGISl4tTNWsJ8aLuwjsWsurHJIsShyYQQe+1dSho3?=
 =?us-ascii?Q?BudW4bp1dG1Bf7CUIh4k7T8dOypR/E/WlHFucHMtGx7J0/bvpOg1bFgX/oTz?=
 =?us-ascii?Q?VlHBgRzfail9FPgiX7CzPCBYyDjtpvXBJstpoLfezqc74fdFFs2O5akW2ogC?=
 =?us-ascii?Q?nhbxGsmiWKulqNhx4LsIUlPLDx6YTTpslDNibX9+QEFT87HIg5LWdTdxU3q0?=
 =?us-ascii?Q?tb05E1MpCQb7qtHwe1zqwHqp9gWhJhuIg+13JMuRKayL6ARjHYBqANbA64vL?=
 =?us-ascii?Q?WuRL5FBkurk+6h5UGvnEHLmbxvxDd4JUN7XvCdHrRpWgAkV7r54HFddFK0OG?=
 =?us-ascii?Q?3GdGQgFQ3+A3VDyF0Xk+4HtjrbX/Xi19dkJEE9dju3L09bUzg3OeznzfKmPI?=
 =?us-ascii?Q?Hq0NNskzJvqpxbb1N7oFprXVMQeMHmQbNdFt1hKofKpM5Kwfhte3Hcl1gpja?=
 =?us-ascii?Q?TSTD87xU6YLBem+eXHoX0Mo+cMKudneMnYOdtMaz3MatCMT9+54XGE72tNcf?=
 =?us-ascii?Q?wMnYwWokJhWwvbftB1xUJ9Dq2QLcaeMNYPWty9yMMM4ocViJ+hck88kWsUzl?=
 =?us-ascii?Q?FxJ0wgo7lCX51dzSpp+pVj0OX01BzYZWfYjkvRoGRKnYtKebvWSxZwHWZgLb?=
 =?us-ascii?Q?KZ7lNaY6zPO8NNT22MEQZdPp/3otx4bWxUx70tAWAQkW5WyMojchUEfRAuXs?=
 =?us-ascii?Q?ZdwzbkXnbl9Q1NViPIhWYLRhcj0ugahQ5BggW6rKgJmVm9e7ZG17UvMsuxGV?=
 =?us-ascii?Q?mSq5jdpobGTNiwPcgewjFEek2O0bgQWjgb0bkXKS6CTkvDsgdzBxIMWMzZGS?=
 =?us-ascii?Q?llG/Z5VL78J8LH7Xay5Uant83pS6QbWcJPkcIMgn2IAA5IJHA+m2ZLlqNOnl?=
 =?us-ascii?Q?+6qV4H53kVYXnaRyghEzYaejd28K4jTxwSZvlRWAdeywZwzLbWRyHFgkRMyq?=
 =?us-ascii?Q?Mexq4ElgPpKBeJ0jhGpJGGfdHNRBs48GoAgZSFDRst5B7jIRbECZWqwRr6Lv?=
 =?us-ascii?Q?FGDpSeineiDEGzJFN2CchEkycr7lN/cm8TZt0TmDcJ+OTUFZEn7jZA57vJbY?=
 =?us-ascii?Q?izwnzxzz74AO+AUJyE5lLY1/BdcgWMalG7+Vrc+g6c1OPA+dg3v1IXjHOY6I?=
 =?us-ascii?Q?fUK3iYU25IbN9tiZa57L/5U88GVGFzKKP1w8U1iyyJhmA1WHd4W9Bo6hAGE/?=
 =?us-ascii?Q?WkakVOS7VjGVA2IfZYQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53457cc3-358f-4794-1652-08db8c5666a2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 14:58:12.1463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gQquqMYYvTDt22UtsGhEU4Yf6bVE3whW1kWx/fAdbNxh35Rin5iiBPd+yf3B023l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7726
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_77471788-4D23-455F-B4DA-D236594F4141_=
Content-Type: text/plain

On 24 Jul 2023, at 7:59, Ryan Roberts wrote:

> On 14/07/2023 17:04, Ryan Roberts wrote:
>> Hi All,
>>
>> This is v3 of a series to implement variable order, large folios for anonymous
>> memory. (currently called "FLEXIBLE_THP") The objective of this is to improve
>> performance by allocating larger chunks of memory during anonymous page faults.
>> See [1] and [2] for background.
>
> A question for anyone that can help; I'm preparing v4 and as part of that am
> running the mm selftests, now that I've fixed them  up to run reliably for
> arm64. This is showing 2 regressions vs the v6.5-rc3 baseline:
>
> 1) khugepaged test fails here:
> # Run test: collapse_max_ptes_none (khugepaged:anon)
> # Maybe collapse with max_ptes_none exceeded.... Fail
> # Unexpected huge page
>
> 2) split_huge_page_test fails with:
> # Still AnonHugePages not split
>
> I *think* (but haven't yet verified) that (1) is due to khugepaged ignoring
> non-order-0 folios when looking for candidates to collapse. Now that we have
> large anon folios, the memory allocated by the test is in large folios and
> therefore does not get collapsed. We understand this issue, and I believe
> DavidH's new scheme for determining exclusive vs shared should give us the tools
> to solve this.
>
> But (2) is weird. If I run this test on its own immediately after booting, it
> passes. If I then run the khugepaged test, then re-run this test, it fails.
>
> The test is allocating 4 hugepages, then requesting they are split using the
> debugfs interface. Then the test looks at /proc/self/smaps to check that
> AnonHugePages is back to 0.
>
> In both the passing and failing cases, the kernel thinks that it has
> successfully split the pages; the debug logs in split_huge_pages_pid() confirm
> this. In the failing case, I wonder if somehow khugepaged could be immediately
> re-collapsing the pages before user sapce can observe the split? Perhaps the
> failed khugepaged test has left khugepaged in an "awake" state and it
> immediately pounces?

This is more likely to be a stats issue. Have you checked smap to see if
AnonHugePages is 0 KB by placing a getchar() before the exit(EXIT_FAILURE)?
Since split_huge_page_test checks that stats to make sure the split indeed
happened.

--
Best Regards,
Yan, Zi

--=_MailMate_77471788-4D23-455F-B4DA-D236594F4141_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmS+kYEPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUbMYP/jYQCAtM3vXevjCKaPGluNvG0+qGgfksFxwL
05OaavpK1h3BiXiTgOOz8EF77Xem/Cc/XL8iE+aRyEQ3DlXxbs1ybM3dfeIEBeVU
DBJajlS12Xn7lsbA8SeaO28Pwr6uusVj/btTlZ1Boq/Y5CafPDvcCdXiFqO9m8H/
EAi74WTamdUCDimr3/pv6MD+25dVcdBzVZTDwa5HqIUaaxeAU+a/sLMqvxPBLYYN
WvG4gllTiADKiU2qMNjAfGUfBtM+zNTa1dwxOII23K5pd8R9487FwfKmKONSjgG+
rRDFPRNgMbCsXck2nWCbDfVvRgh3TP7qvsQnPc63fGwC93lDCyQVDpORndsoatc8
lu9h/H6QBBs6BpdVpov7JmeLnrnc3EfKwyXpu5X+DkzMZsH3KYSmJw+jFCTTzQ82
5DgqLsH1uFZPUDxLneQGd7w+AVOLbs4rWaKLPrwzW3eAoXDc8Vt6HPEPiUsJurB+
DNRQk9Xpa6Rcco50VXzf4V2ztkUZ+CFIEEixEYt/xAIKOIEDJ8h2AjPZHUY3g0Wa
cLrzdaFcetFIb0KfEZ7FnbDFS1ARkQFjvyB7XUBdPdvbJJ9TsC9jrqD4dXXJggrs
G7RlVzcU+6byDZgjSd/e3LUTDdVAeqYu5gNd+bquTtpfJe77mt5xGe/WXTNlXSVR
0l/Kx35G
=XHzl
-----END PGP SIGNATURE-----

--=_MailMate_77471788-4D23-455F-B4DA-D236594F4141_=--
