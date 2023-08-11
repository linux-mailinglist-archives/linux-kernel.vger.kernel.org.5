Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 034927791F4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 16:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236103AbjHKOdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 10:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233850AbjHKOdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 10:33:53 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2068.outbound.protection.outlook.com [40.107.101.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3EF130
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 07:33:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PLIqqP+HU32JZUAlcHg62w6gx9x4zXAKaFdrwUWThyvRfo+soGBgkyAr4RigrClJI61G58yWCSrks8OgjG8bXJ59SMZqACV9YTRIIQj26OxNgqTkaJv/cajAoaqCY/s80weJ62HeLDAeBsPHoimqmd+kheFChqI1z6pqAyL/YZzV8tW1rMVBanLga8lTj7TaTNFIcOwaWDyj84xSUHD236ZwiMvakXxpw7tbKp4SdU3hn5UIYLWmlL1bQeaLjhqdffT8ReqNkN0JwCLleWs1v5toyInO6+3NSX6+weND6bCT3MvfrQpUU0CjM3849W4WSDEZWApz73cMfM6fodoLrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DpF3eLTrkJ/USHQ6AWVoOeaHh4pBxeoIyncmDz+Gj7w=;
 b=OAMNmlOLTYzD1v+K3Ix1y/Ngmpq++3EwAitv0RVsEqqMeeiseXXC3EAuTqklPdf9oOL+X5E/cKA5mJGUjrpuz67VD64sc/XqCqNuQIkmuT1HqhjmTTcpVDggrI52GamU53HIiWmSr2YX9R3GmWZR4it0wjs3A4D0ISlrjKJB79r6jXrcSnXKa4uT8EVw7b7W0XZXFVIuWkeYqpC2BMopLgOR3OgvNkGVPII1TvpUbBlmvDE5BmYnxPjOCTX5JWhjGEH/qQ6dycym5SDaEaW/zrAhpyxYfopGA2jzMitT+kXPKyR+zpanwx11qmOP1tWlDsasOJzJFE1RQokQh+CuhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DpF3eLTrkJ/USHQ6AWVoOeaHh4pBxeoIyncmDz+Gj7w=;
 b=PFmrkwa2m8+avtKm6lmRASW2Ko+xvxddmnPwy7aDHGX/USkmp8Y671E/PGSQWkBShhFFOwSE+8mkZzeIvaca8ulLlh9aTCr+90j0Ps98rq0Gpt1JI0y3nCpsfiys+oONvEff2gG+91skoQMefPcGuw5idIeB4TVpK0Su8PowAf5sItozUBY5JyyMx2lDP3woxe7/V6Zt4cBtSw9EIxPTPqIubKsv8K92pGa6FBxTkjFbYtjOtfD2HP8/cJC+WB/yuU0YJOezSdFv/pVRizzVtQbtEBZkh7cyLwJi62armom7vwSVkFZn/QOA6DFKkm0jMbTlwSQiAExiYjo8bO0XeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 PH8PR12MB7182.namprd12.prod.outlook.com (2603:10b6:510:229::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 14:33:48 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::c166:b535:d93:641e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::c166:b535:d93:641e%4]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 14:33:48 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     "Yin, Fengwei" <fengwei.yin@intel.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>, Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 3/5] mm: LARGE_ANON_FOLIO for improved performance
Date:   Fri, 11 Aug 2023 10:33:44 -0400
X-Mailer: MailMate (1.14r5964)
Message-ID: <0514E8BE-4510-4DED-A50D-147211ED0CEA@nvidia.com>
In-Reply-To: <6f9c7746-6081-4eb5-a98c-575cebd09617@intel.com>
References: <20230810142942.3169679-1-ryan.roberts@arm.com>
 <20230810142942.3169679-4-ryan.roberts@arm.com>
 <CAOUHufbUGwc2XvZOBmTCzMsOHxP-eLB60EdysKYzrkRMScOyMg@mail.gmail.com>
 <f97446e3-85d8-4d14-9fc0-683b31925325@arm.com>
 <16B84D1E-F234-414E-BA54-5893B6318E57@nvidia.com>
 <627c9081-68f6-49df-a270-1a5e47741d31@intel.com>
 <E657B3C2-6E44-461D-9AED-D37FB708FD4D@nvidia.com>
 <6f9c7746-6081-4eb5-a98c-575cebd09617@intel.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_F11991D7-4B75-4597-B8CB-8FF7945255E5_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR02CA0008.namprd02.prod.outlook.com
 (2603:10b6:208:fc::21) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|PH8PR12MB7182:EE_
X-MS-Office365-Filtering-Correlation-Id: c98f2ba8-d730-4f5c-2bc7-08db9a77f995
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OTPYEot4V88XOkollrcnw5+q7kbW6sxxPlo0q1DoTT8E3OHcX4IOm2s9hBMkGXgCteaFTWt/03DLDvQm0kmioV2LauE9JEj9l414MVzm8MbF57EoORs1bbx6k07VHPp5gLpFtw29EdgfaNl4yzN4CXor0O2HwuHMtRe7GbTC+JLMp9Yo3Pa0p/os/3In3OXJHXdWlXbpKItq4lnt/NHmvlr0yNaND9s7CIsStEQL/tStagZU0244ZoFmtzDJ+y9kcgfqJ9bn0UupLBTCKQZeviISktjDae/wCpE3m9wNRh91dECAphxj7XAkbhhz4hPcFglyYr5vW05DViWFDKjdFfi8Sp9UnU2kslMQKn2zEMoOysZ+W2W0P8pjTRDsM4CKkiCquKzAGPmkMSvBe+QcHNOSTa8oUsg/8VsqHed3N91crLeYHg48vBjSLPNZG/JiyhySpk/jHOj9OmhTafnawq/BoQ/0ubzPLYMvBikCv1rkGJM1vgZOdF2qR8Me/O+uJV5BjVEjlUhZg/fRMX9Gwcxw2qhR4XqX5+Ty2y3UJceMXaEcmb4OBxcbFvrABy7RIwJnn6Yo6slbRJQSL1qu6ta5HVVV6gy8ppDgBcOKf90sNPBLIgPmsN1sV0tWmr3bOmxnLxvYq87NE3/svc+FDuZZX3ymi5aX4jnASEFJH0bJ6YKLRN4XmDuazeL7nQ0h
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(366004)(376002)(396003)(136003)(186006)(451199021)(1800799006)(26005)(8676002)(6506007)(8936002)(41300700001)(53546011)(33656002)(36756003)(83380400001)(2906002)(30864003)(38100700002)(2616005)(86362001)(7416002)(235185007)(5660300002)(33964004)(966005)(6512007)(66556008)(4326008)(66476007)(6916009)(66946007)(478600001)(6486002)(54906003)(6666004)(316002)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3dDNW1yVDd3RG9wd1ZhYnlXSzJUa0hGa2d5V3R5SVp0Z1pjOTVZOFdENEhW?=
 =?utf-8?B?cldUaFZTazU2aDRnWWcrUW1DVXN2b0hDOCtPYUFqdjZxakIySGQ0cnozQTQ5?=
 =?utf-8?B?cXZQZWpsNTBvamNCWGhyZTBDSXVqYXpVa3BBcjZOMXRqeDlJcm4vWVA0RXhU?=
 =?utf-8?B?K3U0cEZUeHQxdWVaMVk4VFU5WGtibTBiUHdxUEtraGxUYUxTNlpzazVXTEVU?=
 =?utf-8?B?L2hCS1dQd2tDV2Iwem94Yys1Vk9xWEgzVkF3VVNiZG43VDQraklzS2RqQ3dS?=
 =?utf-8?B?Zkp6b1orcjVHdHcrSkRXSEdJNVpRRm9jK3p1YnBsbldHQitHQnlhRDF6NVdY?=
 =?utf-8?B?UElIaWsybHVSY3krQUFlbFZMQncvSUZrb1pjY2ZLVVM2NGZheWRIZXBnVzJz?=
 =?utf-8?B?NldObml1QzlCbldxNFc2K0NRblBRcWEzcW5VZFBYV3Rlbk44cTFTZVNFT3Vk?=
 =?utf-8?B?RHVJUmFOYWpPYTdQOW5iOFNRY3B3ZGdLdG9XckpUL0crZlhYWWRFSDlKK0p1?=
 =?utf-8?B?UUhYbmxFVUYwaGwzTHVxSUFqcW5hdlYvS1lSVWdlRUNFR1FITnhnU1RJVjNZ?=
 =?utf-8?B?NWhhaFdic3Bsa2xnRVVyN3VCTi96N2IybFB4SDFmT2pLM3VucHVvcERUb25m?=
 =?utf-8?B?WGZPWjRra3dhNFZZUU9ROFlhZGt1TWp3UEd4Skt2SGM3bjlzcnpuUk01dUdj?=
 =?utf-8?B?K09NYm0vQ0twWnpyOHYrY3RZUlJJS2VKYllhUlNzdUVJRStIb1h6RksrVUVU?=
 =?utf-8?B?eGwvU0RTSE1ndDM3Tzh2bFMzbzRtdEV1TjJTUlNpZ0RMdDdUTkZhUENSQ0tF?=
 =?utf-8?B?bktOWHhsV3FTZVd5dGRzZnM2OVh3VHJlLy9iUUEwWHcydU1Zek1GSG82eVVj?=
 =?utf-8?B?ZG1NZ2pvYVllNlBXYzlBa3FGZFoxMXMwL01WRFlvZzFZZHkvSHMvUW9mdi95?=
 =?utf-8?B?c0ZBMWlCcWMwU1JXM3Q0QnBnSFY3MmU5akNVd1JLeUFrWFdlcStER2VIa2tX?=
 =?utf-8?B?Q1hndy9IOGw1YjhqQW9ScGZ3Q0UyaWZtODVic2dOUVAwMFlXSkZlV0twL2V3?=
 =?utf-8?B?OGdRaTIxS1VJSUlhQzhLSzh4YVBvUy9qMHpMdzJtOUk3QW50eDhnK0EyWWdq?=
 =?utf-8?B?THV6cmRUMFRFRDR0cEtQSFpQS1hKUVMvM1VKTDkvaC9Xb2gyQmxkejNnNllW?=
 =?utf-8?B?SGNZaFpYQVBDUmxRaFdGTUFJTHRNb3hZQjhqUXNPdi95eVNoamVxcW9ENVgz?=
 =?utf-8?B?Rm51Ujl6Vi9NSUNEa0Jpb0wzenM4MFd4UXFWOGVtOVZMSlBBVnoyTG5RQm1C?=
 =?utf-8?B?SVNvNU0zZW43R29sR2dnSHRVMUxqZHV5ZjhPU3hYTUlIeEhQRllrMlA1bDBH?=
 =?utf-8?B?UFFBZWdXK3VBY3BTQzBsRWNTeHB3a2pDOGpacUhocDlheUtTMXFqaXlnRnht?=
 =?utf-8?B?K3NQb0JXV2dreGJCTnIxQmpRTFpneXZWaUJzdktvVUtVOWxxRjRUVXk1Z3U1?=
 =?utf-8?B?a3JseGQwcWVLNkhFRVczeGprYmJZVzBIZGsyZ1RzVUt6Zy8xclpFeXNPM0dv?=
 =?utf-8?B?d0hvTE9mMkhMVWpjcVBYb1RiWE1CdTBXY2Q0NjR2YlE5Wkx1dElKSzU2UjBJ?=
 =?utf-8?B?TFZlTzhXQ0IxV2laaGNOZjc1WndGbEtBeWJKSkNpcjUvd0F3b2JFYkl4cHdl?=
 =?utf-8?B?UUZzQXRPYlFCYnhBamw1NC95WVZVTStOdCtCUHRrYkxzUVBBRzU5M1cyV0tx?=
 =?utf-8?B?TXFPcHZ2Wm1OUEFJK1NIb2ZXd3JvZ1FQQUJ6cjV2dXIrWkQzSHhCVjBOR1hh?=
 =?utf-8?B?YnNsYVlXeXB4cW53VkVxazVvZkVqeVMwTCt3a2dXc2ZQS2d6UXNsR3dSbDdo?=
 =?utf-8?B?YWgwZVVlMGk3NG54QUZlY1o5eGdlN2lVdUhoM0Q2MExEUThMTXlCN2k1bXRw?=
 =?utf-8?B?NVQ3WXhDbG5jaVIxSGhqU3NRSWQzc0JZa3k0djdwRzZaNkZ4Vzh4dHZrVEZq?=
 =?utf-8?B?UVMwMEtKRnVWcUdPTmhvb1k3L2tCRUoxekd0STU2aGhsTXY3MVhXREJKZURJ?=
 =?utf-8?B?UGJEYkNrWFIvbko5Z21sakFGVW5vTzVHTTk5ajQ2TXBzSXpLNlRldW40cGZn?=
 =?utf-8?Q?8XWbxL6BvPMmmksjyVtTTR4oH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c98f2ba8-d730-4f5c-2bc7-08db9a77f995
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 14:33:48.3263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KxzE0HYo4ZD3GM5JLFXYzPCGfuLBr/7ekLx0Ji6hLAslM9CHp3jo4AiSlIDu+GzJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7182
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_F11991D7-4B75-4597-B8CB-8FF7945255E5_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 11 Aug 2023, at 1:34, Yin, Fengwei wrote:

> On 8/11/2023 9:04 AM, Zi Yan wrote:
>> On 10 Aug 2023, at 20:36, Yin, Fengwei wrote:
>>
>>> On 8/11/2023 3:46 AM, Zi Yan wrote:
>>>> On 10 Aug 2023, at 15:12, Ryan Roberts wrote:
>>>>
>>>>> On 10/08/2023 18:01, Yu Zhao wrote:
>>>>>> On Thu, Aug 10, 2023 at 8:30=E2=80=AFAM Ryan Roberts <ryan.roberts=
@arm.com> wrote:
>>>>>>>
>>>>>>> Introduce LARGE_ANON_FOLIO feature, which allows anonymous memory=
 to be
>>>>>>> allocated in large folios of a determined order. All pages of the=
 large
>>>>>>> folio are pte-mapped during the same page fault, significantly re=
ducing
>>>>>>> the number of page faults. The number of per-page operations (e.g=
=2E ref
>>>>>>> counting, rmap management lru list management) are also significa=
ntly
>>>>>>> reduced since those ops now become per-folio.
>>>>>>>
>>>>>>> The new behaviour is hidden behind the new LARGE_ANON_FOLIO Kconf=
ig,
>>>>>>> which defaults to disabled for now; The long term aim is for this=
 to
>>>>>>> defaut to enabled, but there are some risks around internal
>>>>>>> fragmentation that need to be better understood first.
>>>>>>>
>>>>>>> Large anonymous folio (LAF) allocation is integrated with the exi=
sting
>>>>>>> (PMD-order) THP and single (S) page allocation according to this =
policy,
>>>>>>> where fallback (>) is performed for various reasons, such as the
>>>>>>> proposed folio order not fitting within the bounds of the VMA, et=
c:
>>>>>>>
>>>>>>>                 | prctl=3Ddis | prctl=3Dena   | prctl=3Dena     |=
 prctl=3Dena
>>>>>>>                 | sysfs=3DX   | sysfs=3Dnever | sysfs=3Dmadvise |=
 sysfs=3Dalways
>>>>>>> ----------------|-----------|-------------|---------------|------=
-------
>>>>>>> no hint         | S         | LAF>S       | LAF>S         | THP>L=
AF>S
>>>>>>> MADV_HUGEPAGE   | S         | LAF>S       | THP>LAF>S     | THP>L=
AF>S
>>>>>>> MADV_NOHUGEPAGE | S         | S           | S             | S
>>>>>>>
>>>>>>> This approach ensures that we don't violate existing hints to onl=
y
>>>>>>> allocate single pages - this is required for QEMU's VM live migra=
tion
>>>>>>> implementation to work correctly - while allowing us to use LAF
>>>>>>> independently of THP (when sysfs=3Dnever). This makes wide scale
>>>>>>> performance characterization simpler, while avoiding exposing any=
 new
>>>>>>> ABI to user space.
>>>>>>>
>>>>>>> When using LAF for allocation, the folio order is determined as f=
ollows:
>>>>>>> The return value of arch_wants_pte_order() is used. For vmas that=
 have
>>>>>>> not explicitly opted-in to use transparent hugepages (e.g. where
>>>>>>> sysfs=3Dmadvise and the vma does not have MADV_HUGEPAGE or sysfs=3D=
never),
>>>>>>> then arch_wants_pte_order() is limited to 64K (or PAGE_SIZE, whic=
hever
>>>>>>> is bigger). This allows for a performance boost without requiring=
 any
>>>>>>> explicit opt-in from the workload while limitting internal
>>>>>>> fragmentation.
>>>>>>>
>>>>>>> If the preferred order can't be used (e.g. because the folio woul=
d
>>>>>>> breach the bounds of the vma, or because ptes in the region are a=
lready
>>>>>>> mapped) then we fall back to a suitable lower order; first
>>>>>>> PAGE_ALLOC_COSTLY_ORDER, then order-0.
>>>>>>>
>>>>>>> arch_wants_pte_order() can be overridden by the architecture if d=
esired.
>>>>>>> Some architectures (e.g. arm64) can coalsece TLB entries if a con=
tiguous
>>>>>>> set of ptes map physically contigious, naturally aligned memory, =
so this
>>>>>>> mechanism allows the architecture to optimize as required.
>>>>>>>
>>>>>>> Here we add the default implementation of arch_wants_pte_order(),=
 used
>>>>>>> when the architecture does not define it, which returns -1, imply=
ing
>>>>>>> that the HW has no preference. In this case, mm will choose it's =
own
>>>>>>> default order.
>>>>>>>
>>>>>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>>>>>> ---
>>>>>>>  include/linux/pgtable.h |  13 ++++
>>>>>>>  mm/Kconfig              |  10 +++
>>>>>>>  mm/memory.c             | 144 ++++++++++++++++++++++++++++++++++=
+++---
>>>>>>>  3 files changed, 158 insertions(+), 9 deletions(-)
>>>>>>>
>>>>>>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
>>>>>>> index 222a33b9600d..4b488cc66ddc 100644
>>>>>>> --- a/include/linux/pgtable.h
>>>>>>> +++ b/include/linux/pgtable.h
>>>>>>> @@ -369,6 +369,19 @@ static inline bool arch_has_hw_pte_young(voi=
d)
>>>>>>>  }
>>>>>>>  #endif
>>>>>>>
>>>>>>> +#ifndef arch_wants_pte_order
>>>>>>> +/*
>>>>>>> + * Returns preferred folio order for pte-mapped memory. Must be =
in range [0,
>>>>>>> + * PMD_SHIFT-PAGE_SHIFT) and must not be order-1 since THP requi=
res large folios
>>>>>>> + * to be at least order-2. Negative value implies that the HW ha=
s no preference
>>>>>>> + * and mm will choose it's own default order.
>>>>>>> + */
>>>>>>> +static inline int arch_wants_pte_order(void)
>>>>>>> +{
>>>>>>> +       return -1;
>>>>>>> +}
>>>>>>> +#endif
>>>>>>> +
>>>>>>>  #ifndef __HAVE_ARCH_PTEP_GET_AND_CLEAR
>>>>>>>  static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
>>>>>>>                                        unsigned long address,
>>>>>>> diff --git a/mm/Kconfig b/mm/Kconfig
>>>>>>> index 721dc88423c7..a1e28b8ddc24 100644
>>>>>>> --- a/mm/Kconfig
>>>>>>> +++ b/mm/Kconfig
>>>>>>> @@ -1243,4 +1243,14 @@ config LOCK_MM_AND_FIND_VMA
>>>>>>>
>>>>>>>  source "mm/damon/Kconfig"
>>>>>>>
>>>>>>> +config LARGE_ANON_FOLIO
>>>>>>> +       bool "Allocate large folios for anonymous memory"
>>>>>>> +       depends on TRANSPARENT_HUGEPAGE
>>>>>>> +       default n
>>>>>>> +       help
>>>>>>> +         Use large (bigger than order-0) folios to back anonymou=
s memory where
>>>>>>> +         possible, even for pte-mapped memory. This reduces the =
number of page
>>>>>>> +         faults, as well as other per-page overheads to improve =
performance for
>>>>>>> +         many workloads.
>>>>>>> +
>>>>>>>  endmenu
>>>>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>>>>> index d003076b218d..bbc7d4ce84f7 100644
>>>>>>> --- a/mm/memory.c
>>>>>>> +++ b/mm/memory.c
>>>>>>> @@ -4073,6 +4073,123 @@ vm_fault_t do_swap_page(struct vm_fault *=
vmf)
>>>>>>>         return ret;
>>>>>>>  }
>>>>>>>
>>>>>>> +static bool vmf_pte_range_changed(struct vm_fault *vmf, int nr_p=
ages)
>>>>>>> +{
>>>>>>> +       int i;
>>>>>>> +
>>>>>>> +       if (nr_pages =3D=3D 1)
>>>>>>> +               return vmf_pte_changed(vmf);
>>>>>>> +
>>>>>>> +       for (i =3D 0; i < nr_pages; i++) {
>>>>>>> +               if (!pte_none(ptep_get_lockless(vmf->pte + i)))
>>>>>>> +                       return true;
>>>>>>> +       }
>>>>>>> +
>>>>>>> +       return false;
>>>>>>> +}
>>>>>>> +
>>>>>>> +#ifdef CONFIG_LARGE_ANON_FOLIO
>>>>>>> +#define ANON_FOLIO_MAX_ORDER_UNHINTED \
>>>>>>> +               (ilog2(max_t(unsigned long, SZ_64K, PAGE_SIZE)) -=
 PAGE_SHIFT)
>>>>>>> +
>>>>>>> +static int anon_folio_order(struct vm_area_struct *vma)
>>>>>>> +{
>>>>>>> +       int order;
>>>>>>> +
>>>>>>> +       /*
>>>>>>> +        * If the vma is eligible for thp, allocate a large folio=
 of the size
>>>>>>> +        * preferred by the arch. Or if the arch requested a very=
 small size or
>>>>>>> +        * didn't request a size, then use PAGE_ALLOC_COSTLY_ORDE=
R, which still
>>>>>>> +        * meets the arch's requirements but means we still take =
advantage of SW
>>>>>>> +        * optimizations (e.g. fewer page faults).
>>>>>>> +        *
>>>>>>> +        * If the vma isn't eligible for thp, take the arch-prefe=
rred size and
>>>>>>> +        * limit it to ANON_FOLIO_MAX_ORDER_UNHINTED. This ensure=
s workloads
>>>>>>> +        * that have not explicitly opted-in take benefit while c=
apping the
>>>>>>> +        * potential for internal fragmentation.
>>>>>>> +        */
>>>>>>> +
>>>>>>> +       order =3D max(arch_wants_pte_order(), PAGE_ALLOC_COSTLY_O=
RDER);
>>>>>>> +
>>>>>>> +       if (!hugepage_vma_check(vma, vma->vm_flags, false, true, =
true))
>>>>>>> +               order =3D min(order, ANON_FOLIO_MAX_ORDER_UNHINTE=
D);
>>>>>>> +
>>>>>>> +       return order;
>>>>>>> +}
>>>>>>
>>>>>> I don't understand why we still want to keep ANON_FOLIO_MAX_ORDER_=
UNHINTED.
>>>>>> 1. It's not used, since no archs at the moment implement
>>>>>> arch_wants_pte_order() that returns >64KB.
>>>>>> 2. As far as I know, there is no plan for any arch to do so.
>>>>>
>>>>> My rationale is that arm64 is planning to use this for contpte mapp=
ing 2MB
>>>>> blocks for 16K and 64K kernels. But I think we will all agree that =
allowing 2MB
>>>>> blocks without the proper THP hinting is a bad plan.
>>>>>
>>>>> As I see it, arches could add their own arch_wants_pte_order() at a=
ny time, and
>>>>> just because the HW has a preference, doesn't mean the SW shouldn't=
 get a say.
>>>>> Its a negotiation between HW and SW for the LAF order, embodied in =
this policy.
>>>>>
>>>>>> 3. Again, it seems to me the rationale behind
>>>>>> ANON_FOLIO_MAX_ORDER_UNHINTED isn't convincing at all.
>>>>>>
>>>>>> Can we introduce ANON_FOLIO_MAX_ORDER_UNHINTED  if/when needed ple=
ase?
>>>>>>
>>>>>> Also you made arch_wants_pte_order() return -1, and I acknowledged=
 [1]:
>>>>>>   Thanks: -1 actually is better than 0 (what I suggested) for the
>>>>>>   obvious reason.
>>>>>>
>>>>>> I thought we were on the same page, i.e., the "obvious reason" is =
that
>>>>>> h/w might prefer 0. But here you are not respecting 0. But then wh=
y
>>>>>> -1?
>>>>>
>>>>> I agree that the "obvious reason" is that HW might prefer order-0. =
But the
>>>>> performance wins don't come solely from the HW. Batching up page fa=
ults is a big
>>>>> win for SW even if the HW doesn't benefit. So I think it is importa=
nt that a HW
>>>>> preference of order-0 is possible to express through this API. But =
that doesn't
>>>>> mean that we don't listen to SW's preferences either.
>>>>>
>>>>> I would really rather leave it in; As I've mentioned in the past, w=
e have a
>>>>> partner who is actively keen to take advantage of 2MB blocks with 6=
4K kernel and
>>>>> this is the mechanism that means we don't dole out those 2MB blocks=
 unless
>>>>> explicitly opted-in.
>>>>>
>>>>> I'm going to be out on holiday for a couple of weeks, so we might h=
ave to wait
>>>>> until I'm back to conclude on this, if you still take issue with th=
e justification.
>>>>
>>>> From my understanding (correct me if I am wrong), Yu seems to want o=
rder-0 to be
>>>> the default order even if LAF is enabled. But that does not make sen=
se to me, since
>>>> if LAF is configured to be enabled (it is disabled by default now), =
user (and distros)
>>>> must think LAF is giving benefit. Otherwise, they will just disable =
LAF at compilation
>>>> time or by using prctl. Enabling LAF and using order-0 as the defaul=
t order makes
>>>> most of LAF code not used.
>>> For the device with limited memory size and it still wants LAF enable=
d for some specific
>>> memory ranges, it's possible the LAF is enabled, order-0 as default o=
rder and use madvise
>>> to enable LAF for specific memory ranges.
>>
>> Do you have a use case? Or it is just a possible scenario?
> It's a possible scenario. Per my experience, it's valid use case for em=
bedded
> system or low end android phone.
>
>>
>> IIUC, Ryan has a concrete use case for his choice. For ARM64 with 16KB=
/64KB
>> base pages, 2MB folios (LAF in this config) would be desirable since T=
HP is
>> 32MB/512MB and much harder to get.
>>
>>>
>>> So my understanding is it's possible case. But it's another configura=
tion thing and not
>>> necessary to be finalized now.
>>
>> Basically, we are deciding whether LAF should use order-0 by default o=
nce it is
>> compiled in to kernel. From your other email on ANON_FOLIO_MAX_ORDER_U=
NHINTED,
>> your argument is that code change is needed to test the impact of LAF =
with
>> different orders. That seems to imply we actually need an extra knob (=
maybe sysctl)
>> to control the max LAF order. And with that extra knob, we can solve t=
his default
>> order problem, since we can set it to 0 for devices want to opt in LAF=
 and set
>> it N (like 64KB) for other devices want to opt out LAF.
> From performance tuning perspective, it's necessary to have knobs to co=
nfigure and
> check the attribute of LAF. But we must be careful to add the knobs as =
they need
> be maintained for ever.

If we do not want to maintain such a knob (since it may take some time to=
 finalize)
and tweaking LAF order is important for us to explore different LAF confi=
gurations
(Ryan thinks 64KB will perform well on ARM64, whereas Yu mentioned 16KB/3=
2KB is
better in his use cases), we probably just put the LAF order knob in debu=
gfs
like Ryan suggested before to move forward.


>>
>> So maybe we need the extra knob for both testing purpose and serving d=
ifferent
>> device configuration purpose.
>>
>>>>
>>>> Also arch_wants_pte_order() might need a better name like
>>>> arch_wants_large_folio_order(). Since current name sounds like the s=
pecified order
>>>> is wanted by HW in a general setting, but it is not. It is an order =
HW wants
>>>> when LAF is enabled. That might cause some confusion.
>>>>
>>>>>>
>>>>>> [1] https://lore.kernel.org/linux-mm/CAOUHufZ7HJZW8Srwatyudf=3DFbw=
TGQtyq4DyL2SHwSg37N_Bo_A@mail.gmail.com/
>>>>
>>>>
>>>> --
>>>> Best Regards,
>>>> Yan, Zi
>>
>>
>> --
>> Best Regards,
>> Yan, Zi


--
Best Regards,
Yan, Zi

--=_MailMate_F11991D7-4B75-4597-B8CB-8FF7945255E5_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmTWRskPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUD/oP/0LRMrT5y4OxFc/pjyjBELohvtBhGqsJBsjb
sKZl1aTp0zQnMbGT0xq+usLtIr0eTmCZ9hs3fZH7ztFMSGT7UxSrJsZgmDTOOhsP
10Tqcu/A3gw+etJgS3/gegajmCLi4FiOvamE2ahEBu41gDS/PfhUsuU4IK82TxYv
4iITC1tF64LyLMBKVhcAK0iIXS4JXdo+pjFoRBP1EE0mehN2AblimVxAzqWNdqWO
Tud9QAvrJafXdeM/pm4oIVmq1EPdL3hOYYc30mGKWuEUn0yFihdxzwlHjVhYYl3h
rSiXD4rv6JuYyuG2yxBQQKSofc4gUmVTsAL00VecappfGIyyDVo0SYHBMdBId3v/
5jZWjOE8F25NC2bFDZgd2zVz1YEd3MWp6Blh7RMUmKOLOVfMFzujHWEnRAStf/xb
IncCCexWD92lfJqjcuuDqZ2eIk00XN9D1kPv5WndsIooN9BIR9L0CiBZqS+6f1K4
z+FP0YdXIaWYXl8InBMV9JTsLFKITgiyibLBLsAQ/nCJ4grZdcmxeaugz7HPBIfx
dARmGkRxs6PiQToenY05VB2+JXScQNdHEbuQwfoILWJBX/vWXVRnIjmyWyO1sIHf
OACq9j/bdP1EPmZmSlGJY1hRd1aw1HVfJkMJMCSMWPV1rxlwytvUfzfV3rl4x+jB
XwCjyqGE
=Rnch
-----END PGP SIGNATURE-----

--=_MailMate_F11991D7-4B75-4597-B8CB-8FF7945255E5_=--
