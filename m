Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB6D7784BA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 03:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjHKBEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 21:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjHKBEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 21:04:08 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D57F270C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 18:04:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UgxlojLBAr+QWfx8IiTb4tRSi/G/1mJ5DELhBKaJVR3w1qL8sZCAaK4l190wdg5DA1T55XMjkjNUxExpOaZYt4d1rCoOGTGzQdGysxTJNjKv1+Fgw5+cybd7K227lKFlA7yEW1K9ekLmVA7yH76DGpBmDzoyP91w2+6sQMbByACJrDxtdDxttbvxizcVtxWzoxLgEboLHZRJh2vtSDTKfWZHGlVusaBwcb/oZ7ZzyhfS2Fjb4Ak8TdPC3yqOC3ta+gq2nudtHuXOAA02Rr8RrBTnGerWCkSQz5Q4aFAkihpPJ+h4u1CidY1fVlV0jL9e3OaWLd3v25NAnLmvWNL4OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZhHpLyYqGrA/0ATli450Qu2FdPlZBqRbIF74PbtC0KM=;
 b=CFBxPBg2BCU86TwHYaZGr/UKG17CGHM7NGust2VtN/MTaEUYNPUJUHq398IMfH2lhTGnS7W0OSYLYEfAQP8xkJ3clvyH1IaCp4Bgktz054ACefMhY+9CVMBmsx0nAWhnVMA4ZSNHqVBZC8UqZTr9nWmXmiqy3dxlqIUL3QinQLOevjAEokf4WhHp07LPAFhYec+na8tX7u9Bw6qluZROXglwPrs2Rsgx7ViSRXX+u2ShTDespH+rGby2RMojy2sUatrcU1j2c+0dpPW62dgDC5mnngedwrU+3vVxIp2iwJjJ/zVkqnaOKVccBNQAXDEzkXYRRhXFBGgSD0IYU2yumw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZhHpLyYqGrA/0ATli450Qu2FdPlZBqRbIF74PbtC0KM=;
 b=m+f1y0mqPxFC8Z+E7IhZyBiwq+8wf5+lbUPTZgH/QCdzJEumJATLdmKLCXmLkPjB7kx0e+DrLAt4WZZ20XY52j6uUp1JRySEwvg96kmebxX/hy3uGyi5KCfZBgGrKtXouiezRilkqrpQOG4ddMppG8O6wVnqWvDVZi37Hidng2ySMd/lTWgE3iygcZY4cH6nPYSJ+M5NGLj+qzcLCDfuyR8rZ49vnqzyrMhhqEVwc2jDAJ03OcuCz3YhVvDReRSw3CHlOytBX1/hl13nysEIaUQL7UDrzdAuwaJSL1jZN7eVplyG77Ctdq8PWSUPJZSdNawoo0s6lmIjG4cCV+bnVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 DM4PR12MB5039.namprd12.prod.outlook.com (2603:10b6:5:38a::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.30; Fri, 11 Aug 2023 01:04:04 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::c166:b535:d93:641e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::c166:b535:d93:641e%4]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 01:04:04 +0000
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
Date:   Thu, 10 Aug 2023 21:04:00 -0400
X-Mailer: MailMate (1.14r5964)
Message-ID: <E657B3C2-6E44-461D-9AED-D37FB708FD4D@nvidia.com>
In-Reply-To: <627c9081-68f6-49df-a270-1a5e47741d31@intel.com>
References: <20230810142942.3169679-1-ryan.roberts@arm.com>
 <20230810142942.3169679-4-ryan.roberts@arm.com>
 <CAOUHufbUGwc2XvZOBmTCzMsOHxP-eLB60EdysKYzrkRMScOyMg@mail.gmail.com>
 <f97446e3-85d8-4d14-9fc0-683b31925325@arm.com>
 <16B84D1E-F234-414E-BA54-5893B6318E57@nvidia.com>
 <627c9081-68f6-49df-a270-1a5e47741d31@intel.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_EE453860-98CB-4AE9-ADF2-C217ACEFB388_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL6PEPF00013E11.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:17) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|DM4PR12MB5039:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ad619a8-45eb-4574-1047-08db9a06db09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jJaQU7/1a2gUZDnyeC5NePn0HpQ4Fsqgiklf5rEJal8mZ3mJGCsmlplnWIrWfnB4iOrK1gbrzgpgixIITsu932Q91ju/+36iHqhrkNCU4uacRVQMAYF2GFd+teUlpQEvQYU8YMfSvqpiZ0j11t8WNlGhxSNZthLsVUmd6k91NISl5GHvzMR7uz5ZtF8jVLAWkd0ayTODuNdSnA3n6rN8Lym99js0r0XzKoBl5DiYUdNly+ffnxk3So5uj7lbOlec/g0KoldejklYkwvjUaFKHDFq6tmGX8Uv7AAupl7RYVVz5mZhdwkoIVN4N46ljypcZbobSCh+rVoJKyLtHkGrM9z9zyEjb++rZtbU7U8nrjYyiriCg1+cUPiIhIR9hjY56NWsZ9WmV6SEqVIULMQkWYQ4SX+nsQHv8+zdLVYkpEwEXdCXSSmRYLmAvrJpMjZzd3ojDRcWXC3yyKl6BKK5OLcbVRy0PlJAJXZHX4q1tKgiMJbGZ0YW3CiT5qsNR93dVBxZioLv67FkoeETuumeSI204IhmahYZ+72S9L0RlEs7ZquHrXbtF/bsonYWCVq7c6Pv7Oq+ccxATmO/L4StnQr4jG88kBWm35A14ffMiMo3LUgfX3HqTzzDMbgwJxCOG8v6LTKP8OmHtNthMNo1B+4uGOKwmMcWBr1hK8Bm+WHSnGJc9w1g9kxwMP4CXxs9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(376002)(346002)(366004)(451199021)(186006)(1800799006)(36756003)(6666004)(86362001)(33656002)(478600001)(6486002)(33964004)(2616005)(2906002)(54906003)(316002)(38100700002)(26005)(66476007)(66946007)(6916009)(66556008)(53546011)(41300700001)(83380400001)(4326008)(6506007)(966005)(6512007)(30864003)(5660300002)(235185007)(8936002)(7416002)(8676002)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjlOSVhlT2MyNkFjOURhTU5IZlViQmF5QWs3ZDVweitLeWtrZXg0Tmdjbito?=
 =?utf-8?B?K2U2OCsxSEhoYlhrZkdmamF6WjN3USttUytmUW5WUXRWa0t6U2p5VVJWZlUy?=
 =?utf-8?B?Rmo3ek03Q3N1NG14aFRObStYaWp0QzlONUtiRXBuR0lmYklRNytEOFZEb2VY?=
 =?utf-8?B?dzg5VzhnejQrQlNKaVlxNWszWTFxWldsNkFSeHJkVXNMVmhjbjVWMnEyd2Fs?=
 =?utf-8?B?T29LUWhBa0dTWVdEMEVOQ3NpS2pKK25SSEUrQzhLUzcyKzN3QUQrZlZWbGwx?=
 =?utf-8?B?Q002Q1lFYXZBcEx6aHV5Rzl5SW9zQkREYnRhWDJBNjJmZFVEYkxqSVVUMHZw?=
 =?utf-8?B?U0RpRFlaVFp3Q29ZVUpWVkhoblAzWENtNEpqM0FtWEpaeXVRbzNRUTRsMDEr?=
 =?utf-8?B?TDNJMVA2a0g0Z05BeThwZlVZNnZ0cWhRcnBCQmFXeG9LdGtlMXdkRHRIbTlR?=
 =?utf-8?B?RVYrL2pIUlNsaVNudEUzNmhaNzVmUzBBK3BpcUg2Y2VkRm1TZzhzVDlSblRM?=
 =?utf-8?B?dGxocjFTV1VLdzJGNXJ3MUhXRFVidEtaSWFrYmxLYUlTVytxRjhpaFV1TmRW?=
 =?utf-8?B?QitvSE1ZTnZpOFhGMHF3SkdwUkpxemxYYlhPK24rVFlpUTBoZ1ZuSnZVS3R1?=
 =?utf-8?B?Y0pNbTZyTlpHWDVWZFVYTW5hd0FMcWNHaUxDZ1Nia1RXTjU1N3NwK3UrdVpL?=
 =?utf-8?B?VXJKaDBTNXlGKzFhQUpzaTV1WnVia3R2aDZFcFR3NW5NNWNPRVJrL3Yyb2s3?=
 =?utf-8?B?WFFXaEZUWW5aelFrMUNMMTdRNHZYKzd2NDc4dzdZUzlDU1lqNm1FaVluVTdS?=
 =?utf-8?B?YlhPaVpVRjV0aFpET21xMHR5Znh2S2oyVndPQWkwZ2l1OGZzRFEvRjNWcU9I?=
 =?utf-8?B?Qmh1Q3NqSmVtR2gra1hQUlJNNHBmalB3ZHFZbGxSYXhjaEw5RHAwd21TRzhN?=
 =?utf-8?B?SUovWnZsL3NtaGlBMDBKOUdXNVdqTkJUcjlselRLNGRoQjJyeTdpUjhoNU01?=
 =?utf-8?B?d2xXZkxReU50ZGFFeHhHZU50UmNqM1J4NW4zZS9NaGc2SWZ1c0o2Q0Y3aGRn?=
 =?utf-8?B?RzF4Q2pvd3VMbjdyZUhhUzA0M0ZqZ0ZRRUtlUXhnWVg1c1lDWjhhck9TZ0Ri?=
 =?utf-8?B?S3IrNE01WVp3RWlQVHRac0s5NjFNTDYyZVkrZ2VyZnpHMDFWMDBJbnRMbDRG?=
 =?utf-8?B?dWVxdC8rZTNBOTRJaWxlME9zOFhGK3pDY2lkOURCUkZHZ0FDT255eDE2eS9z?=
 =?utf-8?B?NDlaZEllMDcrYzMydDZ4NzJaVlF5RWFZKzVmMlY1eWNJcXhuRER2eExjdWZG?=
 =?utf-8?B?VHh2UTBkNlZxS2ZzWjRyWkNDNk40LzdHZmFsbGM5ZC90MlFrSlRBbGNENm9v?=
 =?utf-8?B?b1kvanF5U21TcWVEZkR5VmFOa1grRmk1K0h3K2V2Rk1YbDdPc0hibVlVYTdH?=
 =?utf-8?B?NDMxVFFFb2dWakVPVWVJeVpPYnRVQjUvazZMQ2E1ZGtKWGsreTFFc25ENVJY?=
 =?utf-8?B?djNBL2tleUJuOXNaVUZUQUpVaTZJbzhYTWhJRG16ZTVzKzVhdWJIUGxWTEsz?=
 =?utf-8?B?cFNITXRyVDJ4SXBab3RCMGJqZE5rYklpdkdQdnJWemRXVVU5UDdOWUlQbFJE?=
 =?utf-8?B?VEs1Qnd3UVlhTE1sR01zYS85aC9LMkNkeURwQlhPcGVYaUZCQWs1NWw1dnh4?=
 =?utf-8?B?S2lqK0xaUHBpQTlZUUEzVm5JeEQ4M1lJZlN0SEIwTDdjNnpiQW04T1JMZHJ6?=
 =?utf-8?B?WmM4cHhidVVaRS93VzZDcW1ZczRLOUJka0RMR3puWUJEOXY3T2pKc25adVZQ?=
 =?utf-8?B?Skl4Mk1jY2lqVm1lOGhYRWJDOXo0djZOanVRTTlNL1pSd3cxZ0FTaDVsQ1Zq?=
 =?utf-8?B?Y2VYZjlYdjdaTmgwYzlXNHJpRUpCV2xOOEdnSWMzZHorQThOaU1qQ2VycmYz?=
 =?utf-8?B?cVBGR2FhSTE4bERjZm5Cc25lbDZOVVEvNnBRM3FEK2VENkVsVWlrR1ZWaFVE?=
 =?utf-8?B?WjE5dnVvUEt4ZmRvTjBNWVpSUXc5Q3hQOTlyajR3K3V0M25OMm5wUEZFeDVs?=
 =?utf-8?B?VldSWXRmTGdPMmx3SVZQQVBHd3FXTFpEL1dONmhzMkMrbmRia2tmSHVYY3hw?=
 =?utf-8?Q?GyMu6bWU5XwvDkOQOTNbn8EP+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ad619a8-45eb-4574-1047-08db9a06db09
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 01:04:04.0089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WoRE7fQVAaKWinDUi4XyKOmV5nruwxyONaYwuvTK1vFQ1N/ert10PYZ22q+2ockT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5039
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_EE453860-98CB-4AE9-ADF2-C217ACEFB388_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 10 Aug 2023, at 20:36, Yin, Fengwei wrote:

> On 8/11/2023 3:46 AM, Zi Yan wrote:
>> On 10 Aug 2023, at 15:12, Ryan Roberts wrote:
>>
>>> On 10/08/2023 18:01, Yu Zhao wrote:
>>>> On Thu, Aug 10, 2023 at 8:30=E2=80=AFAM Ryan Roberts <ryan.roberts@a=
rm.com> wrote:
>>>>>
>>>>> Introduce LARGE_ANON_FOLIO feature, which allows anonymous memory t=
o be
>>>>> allocated in large folios of a determined order. All pages of the l=
arge
>>>>> folio are pte-mapped during the same page fault, significantly redu=
cing
>>>>> the number of page faults. The number of per-page operations (e.g. =
ref
>>>>> counting, rmap management lru list management) are also significant=
ly
>>>>> reduced since those ops now become per-folio.
>>>>>
>>>>> The new behaviour is hidden behind the new LARGE_ANON_FOLIO Kconfig=
,
>>>>> which defaults to disabled for now; The long term aim is for this t=
o
>>>>> defaut to enabled, but there are some risks around internal
>>>>> fragmentation that need to be better understood first.
>>>>>
>>>>> Large anonymous folio (LAF) allocation is integrated with the exist=
ing
>>>>> (PMD-order) THP and single (S) page allocation according to this po=
licy,
>>>>> where fallback (>) is performed for various reasons, such as the
>>>>> proposed folio order not fitting within the bounds of the VMA, etc:=

>>>>>
>>>>>                 | prctl=3Ddis | prctl=3Dena   | prctl=3Dena     | p=
rctl=3Dena
>>>>>                 | sysfs=3DX   | sysfs=3Dnever | sysfs=3Dmadvise | s=
ysfs=3Dalways
>>>>> ----------------|-----------|-------------|---------------|--------=
-----
>>>>> no hint         | S         | LAF>S       | LAF>S         | THP>LAF=
>S
>>>>> MADV_HUGEPAGE   | S         | LAF>S       | THP>LAF>S     | THP>LAF=
>S
>>>>> MADV_NOHUGEPAGE | S         | S           | S             | S
>>>>>
>>>>> This approach ensures that we don't violate existing hints to only
>>>>> allocate single pages - this is required for QEMU's VM live migrati=
on
>>>>> implementation to work correctly - while allowing us to use LAF
>>>>> independently of THP (when sysfs=3Dnever). This makes wide scale
>>>>> performance characterization simpler, while avoiding exposing any n=
ew
>>>>> ABI to user space.
>>>>>
>>>>> When using LAF for allocation, the folio order is determined as fol=
lows:
>>>>> The return value of arch_wants_pte_order() is used. For vmas that h=
ave
>>>>> not explicitly opted-in to use transparent hugepages (e.g. where
>>>>> sysfs=3Dmadvise and the vma does not have MADV_HUGEPAGE or sysfs=3D=
never),
>>>>> then arch_wants_pte_order() is limited to 64K (or PAGE_SIZE, whiche=
ver
>>>>> is bigger). This allows for a performance boost without requiring a=
ny
>>>>> explicit opt-in from the workload while limitting internal
>>>>> fragmentation.
>>>>>
>>>>> If the preferred order can't be used (e.g. because the folio would
>>>>> breach the bounds of the vma, or because ptes in the region are alr=
eady
>>>>> mapped) then we fall back to a suitable lower order; first
>>>>> PAGE_ALLOC_COSTLY_ORDER, then order-0.
>>>>>
>>>>> arch_wants_pte_order() can be overridden by the architecture if des=
ired.
>>>>> Some architectures (e.g. arm64) can coalsece TLB entries if a conti=
guous
>>>>> set of ptes map physically contigious, naturally aligned memory, so=
 this
>>>>> mechanism allows the architecture to optimize as required.
>>>>>
>>>>> Here we add the default implementation of arch_wants_pte_order(), u=
sed
>>>>> when the architecture does not define it, which returns -1, implyin=
g
>>>>> that the HW has no preference. In this case, mm will choose it's ow=
n
>>>>> default order.
>>>>>
>>>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>>>> ---
>>>>>  include/linux/pgtable.h |  13 ++++
>>>>>  mm/Kconfig              |  10 +++
>>>>>  mm/memory.c             | 144 ++++++++++++++++++++++++++++++++++++=
+---
>>>>>  3 files changed, 158 insertions(+), 9 deletions(-)
>>>>>
>>>>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
>>>>> index 222a33b9600d..4b488cc66ddc 100644
>>>>> --- a/include/linux/pgtable.h
>>>>> +++ b/include/linux/pgtable.h
>>>>> @@ -369,6 +369,19 @@ static inline bool arch_has_hw_pte_young(void)=

>>>>>  }
>>>>>  #endif
>>>>>
>>>>> +#ifndef arch_wants_pte_order
>>>>> +/*
>>>>> + * Returns preferred folio order for pte-mapped memory. Must be in=
 range [0,
>>>>> + * PMD_SHIFT-PAGE_SHIFT) and must not be order-1 since THP require=
s large folios
>>>>> + * to be at least order-2. Negative value implies that the HW has =
no preference
>>>>> + * and mm will choose it's own default order.
>>>>> + */
>>>>> +static inline int arch_wants_pte_order(void)
>>>>> +{
>>>>> +       return -1;
>>>>> +}
>>>>> +#endif
>>>>> +
>>>>>  #ifndef __HAVE_ARCH_PTEP_GET_AND_CLEAR
>>>>>  static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
>>>>>                                        unsigned long address,
>>>>> diff --git a/mm/Kconfig b/mm/Kconfig
>>>>> index 721dc88423c7..a1e28b8ddc24 100644
>>>>> --- a/mm/Kconfig
>>>>> +++ b/mm/Kconfig
>>>>> @@ -1243,4 +1243,14 @@ config LOCK_MM_AND_FIND_VMA
>>>>>
>>>>>  source "mm/damon/Kconfig"
>>>>>
>>>>> +config LARGE_ANON_FOLIO
>>>>> +       bool "Allocate large folios for anonymous memory"
>>>>> +       depends on TRANSPARENT_HUGEPAGE
>>>>> +       default n
>>>>> +       help
>>>>> +         Use large (bigger than order-0) folios to back anonymous =
memory where
>>>>> +         possible, even for pte-mapped memory. This reduces the nu=
mber of page
>>>>> +         faults, as well as other per-page overheads to improve pe=
rformance for
>>>>> +         many workloads.
>>>>> +
>>>>>  endmenu
>>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>>> index d003076b218d..bbc7d4ce84f7 100644
>>>>> --- a/mm/memory.c
>>>>> +++ b/mm/memory.c
>>>>> @@ -4073,6 +4073,123 @@ vm_fault_t do_swap_page(struct vm_fault *vm=
f)
>>>>>         return ret;
>>>>>  }
>>>>>
>>>>> +static bool vmf_pte_range_changed(struct vm_fault *vmf, int nr_pag=
es)
>>>>> +{
>>>>> +       int i;
>>>>> +
>>>>> +       if (nr_pages =3D=3D 1)
>>>>> +               return vmf_pte_changed(vmf);
>>>>> +
>>>>> +       for (i =3D 0; i < nr_pages; i++) {
>>>>> +               if (!pte_none(ptep_get_lockless(vmf->pte + i)))
>>>>> +                       return true;
>>>>> +       }
>>>>> +
>>>>> +       return false;
>>>>> +}
>>>>> +
>>>>> +#ifdef CONFIG_LARGE_ANON_FOLIO
>>>>> +#define ANON_FOLIO_MAX_ORDER_UNHINTED \
>>>>> +               (ilog2(max_t(unsigned long, SZ_64K, PAGE_SIZE)) - P=
AGE_SHIFT)
>>>>> +
>>>>> +static int anon_folio_order(struct vm_area_struct *vma)
>>>>> +{
>>>>> +       int order;
>>>>> +
>>>>> +       /*
>>>>> +        * If the vma is eligible for thp, allocate a large folio o=
f the size
>>>>> +        * preferred by the arch. Or if the arch requested a very s=
mall size or
>>>>> +        * didn't request a size, then use PAGE_ALLOC_COSTLY_ORDER,=
 which still
>>>>> +        * meets the arch's requirements but means we still take ad=
vantage of SW
>>>>> +        * optimizations (e.g. fewer page faults).
>>>>> +        *
>>>>> +        * If the vma isn't eligible for thp, take the arch-preferr=
ed size and
>>>>> +        * limit it to ANON_FOLIO_MAX_ORDER_UNHINTED. This ensures =
workloads
>>>>> +        * that have not explicitly opted-in take benefit while cap=
ping the
>>>>> +        * potential for internal fragmentation.
>>>>> +        */
>>>>> +
>>>>> +       order =3D max(arch_wants_pte_order(), PAGE_ALLOC_COSTLY_ORD=
ER);
>>>>> +
>>>>> +       if (!hugepage_vma_check(vma, vma->vm_flags, false, true, tr=
ue))
>>>>> +               order =3D min(order, ANON_FOLIO_MAX_ORDER_UNHINTED)=
;
>>>>> +
>>>>> +       return order;
>>>>> +}
>>>>
>>>> I don't understand why we still want to keep ANON_FOLIO_MAX_ORDER_UN=
HINTED.
>>>> 1. It's not used, since no archs at the moment implement
>>>> arch_wants_pte_order() that returns >64KB.
>>>> 2. As far as I know, there is no plan for any arch to do so.
>>>
>>> My rationale is that arm64 is planning to use this for contpte mappin=
g 2MB
>>> blocks for 16K and 64K kernels. But I think we will all agree that al=
lowing 2MB
>>> blocks without the proper THP hinting is a bad plan.
>>>
>>> As I see it, arches could add their own arch_wants_pte_order() at any=
 time, and
>>> just because the HW has a preference, doesn't mean the SW shouldn't g=
et a say.
>>> Its a negotiation between HW and SW for the LAF order, embodied in th=
is policy.
>>>
>>>> 3. Again, it seems to me the rationale behind
>>>> ANON_FOLIO_MAX_ORDER_UNHINTED isn't convincing at all.
>>>>
>>>> Can we introduce ANON_FOLIO_MAX_ORDER_UNHINTED  if/when needed pleas=
e?
>>>>
>>>> Also you made arch_wants_pte_order() return -1, and I acknowledged [=
1]:
>>>>   Thanks: -1 actually is better than 0 (what I suggested) for the
>>>>   obvious reason.
>>>>
>>>> I thought we were on the same page, i.e., the "obvious reason" is th=
at
>>>> h/w might prefer 0. But here you are not respecting 0. But then why
>>>> -1?
>>>
>>> I agree that the "obvious reason" is that HW might prefer order-0. Bu=
t the
>>> performance wins don't come solely from the HW. Batching up page faul=
ts is a big
>>> win for SW even if the HW doesn't benefit. So I think it is important=
 that a HW
>>> preference of order-0 is possible to express through this API. But th=
at doesn't
>>> mean that we don't listen to SW's preferences either.
>>>
>>> I would really rather leave it in; As I've mentioned in the past, we =
have a
>>> partner who is actively keen to take advantage of 2MB blocks with 64K=
 kernel and
>>> this is the mechanism that means we don't dole out those 2MB blocks u=
nless
>>> explicitly opted-in.
>>>
>>> I'm going to be out on holiday for a couple of weeks, so we might hav=
e to wait
>>> until I'm back to conclude on this, if you still take issue with the =
justification.
>>
>> From my understanding (correct me if I am wrong), Yu seems to want ord=
er-0 to be
>> the default order even if LAF is enabled. But that does not make sense=
 to me, since
>> if LAF is configured to be enabled (it is disabled by default now), us=
er (and distros)
>> must think LAF is giving benefit. Otherwise, they will just disable LA=
F at compilation
>> time or by using prctl. Enabling LAF and using order-0 as the default =
order makes
>> most of LAF code not used.
> For the device with limited memory size and it still wants LAF enabled =
for some specific
> memory ranges, it's possible the LAF is enabled, order-0 as default ord=
er and use madvise
> to enable LAF for specific memory ranges.

Do you have a use case? Or it is just a possible scenario?

IIUC, Ryan has a concrete use case for his choice. For ARM64 with 16KB/64=
KB
base pages, 2MB folios (LAF in this config) would be desirable since THP =
is
32MB/512MB and much harder to get.

>
> So my understanding is it's possible case. But it's another configurati=
on thing and not
> necessary to be finalized now.

Basically, we are deciding whether LAF should use order-0 by default once=
 it is
compiled in to kernel. From your other email on ANON_FOLIO_MAX_ORDER_UNHI=
NTED,
your argument is that code change is needed to test the impact of LAF wit=
h
different orders. That seems to imply we actually need an extra knob (may=
be sysctl)
to control the max LAF order. And with that extra knob, we can solve this=
 default
order problem, since we can set it to 0 for devices want to opt in LAF an=
d set
it N (like 64KB) for other devices want to opt out LAF.

So maybe we need the extra knob for both testing purpose and serving diff=
erent
device configuration purpose.

>>
>> Also arch_wants_pte_order() might need a better name like
>> arch_wants_large_folio_order(). Since current name sounds like the spe=
cified order
>> is wanted by HW in a general setting, but it is not. It is an order HW=
 wants
>> when LAF is enabled. That might cause some confusion.
>>
>>>>
>>>> [1] https://lore.kernel.org/linux-mm/CAOUHufZ7HJZW8Srwatyudf=3DFbwTG=
Qtyq4DyL2SHwSg37N_Bo_A@mail.gmail.com/
>>
>>
>> --
>> Best Regards,
>> Yan, Zi


--
Best Regards,
Yan, Zi

--=_MailMate_EE453860-98CB-4AE9-ADF2-C217ACEFB388_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmTViQEPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUuuwP/1RCUm9yOgOKnjXZ6Nn9TmH7ctJe5tJRg0mv
9yRQr78w6lkI+Fy5euJwVoFamhHy0e6iaC0kY3SFtTx//HlVZcnSPCOnT1l3UO2+
Ljss0BvPLvOiX2EUbS02FTS40MhleEI6s651CTqakGlijWIcHUvGkiJhD8+Mo/gk
/rchgxDS2xuBKCM9nZwFq/Ghe7w6mn0ZLjSDQcT9oke9iF6JXBeLT4sfZ+fl3aP3
AwlpyZh2xHg/tN8CcAq63zivIfOOWznuaMxSGHubgHKsQOvXShaBS7N83/jkNWjQ
nEDHG0zrIxIneQvKGwDsyCCD4oG9oXkRNdwC/I5poBO9Dz5OtkaNOHmZZvHC0iwD
Ot9e0pASCt3+U1LWqYyoPWzwrrIyVzmwIb/oFt40i6Xq/8bZEoorpCD70Gvc/ZMw
mQM/6mreQdB3OiSCQha08gDV6kqtVe4enTqY7LegFSDffz6ot5iDHuV0XG/X9FG+
31Rl8ght9ryg4LQyQMV8DabYxFov1eDD26MXhycPjq1FnUBA1dbLkXIK5JIiC1TM
XWG2E3HAfP9uj+mlL3kFm+OxGnyzc//wiThdkpQEGHWTRAZisDDtFwj9RYyVU8TI
A0IuUgbYclfCpgNXTnKoeJJAFKonpHbhrfmAWgZL0IqxCNBAgaTASFrRfkr4zKXr
aFBndDm1
=nw0L
-----END PGP SIGNATURE-----

--=_MailMate_EE453860-98CB-4AE9-ADF2-C217ACEFB388_=--
