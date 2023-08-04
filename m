Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81BEE76F7B0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 04:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbjHDCSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 22:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233000AbjHDCRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 22:17:34 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8960D49E8
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 19:16:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qv5expNeWkkR3Lw1SA8cqmn/hjuHQGVPZr9JUOVxXR1IuCGa70NEB6rAtltjNaTQpjLgln2m8m0JFbD/919/19OroWBX5uSSX13kGGSJed3v4Qlh70LlPGviGJ28s3AKr/k4Tia62fDBTL+a3c2woYV/DhWtsE3aSTOP2MoxGsKNSbumVnR1zbXkwjsPDfweS/adN63+DH2qSxADtaPqRPUEQXFoxuglSFm0+ao2LSMqCI5cBelay9shqSDLDXitCQogFe9NU9c++NcQBPCyoiJljJCfkEyWm+s/7Hi+c55X/zccK3T/G+hGsLfhzqp+5u7WWQYIPi+EJCbqWQjiXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OaipHmz0E+kfKDppy7T/2H/bR1Xmbe6k6ab+/FrW3NM=;
 b=XnxTQDCgASErgSsV6RJY73vRMK5usVxsoAGYzWgMjS1GCGhX8///yyzU8Ngo6hk+6gQ8HX/M+sfIRucCOBE7/AT0WxMsLZEQ4VzDF64uLMSIBRkMmvExl0it2iR9FUQfmXcYPoJZaNCo5M8nUXwxv1I/wow+ool6cM3/VW6IXyS1ZjWs/5Qy6ujg0o1WAkZfm/BiaX/Wp8fvPYBJPT0fGyVSU+GthbFH8XVcJhWA5r0t6bUZMBgcHngpttqK6CWkAyZdSzaccRLfSsfHCpImSWs18fXjRWQxZC6y+ufgIzqaTA6RLPqPtDcwPkBnMReW+NEOxv4+Eoor9YgO0y5pmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OaipHmz0E+kfKDppy7T/2H/bR1Xmbe6k6ab+/FrW3NM=;
 b=qzPz9pYR2AgcV1MlXd/H5MlAuZXZOwDGQLNx7fkn+a7w5q2CbVKqYKbe0ce75BtsshXDGyivT+bUZrt5vQ0GcbcXNBUy5keV7mb98m9hVBJ+fvN5TCIIh4SaGSX33GxjhOhz9aEPAEkHc62r3Hld5OoaH3Vm4jkqpFkUu/tWWYvy2jSjqUREnKuEMKmmDo3cIyycvFL7X6EiPpjMLiW3eJV/H4q+Mth0vg4uQd5KP4VHkUMF8Nq07qf31LdL1JSI7JPo4Ct9ObAeGEshZFMPvpEOf2vmPeDmeBI762DN/QLd4YHWV9AxQb3D8SgYIs6SwrqfZqGE9288x4KIUL5zDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 BY5PR12MB4966.namprd12.prod.outlook.com (2603:10b6:a03:1da::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Fri, 4 Aug
 2023 02:16:09 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::c166:b535:d93:641e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::c166:b535:d93:641e%4]) with mapi id 15.20.6652.021; Fri, 4 Aug 2023
 02:16:09 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Yu Zhao <yuzhao@google.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 2/5] mm: LARGE_ANON_FOLIO for improved performance
Date:   Thu, 03 Aug 2023 22:16:06 -0400
X-Mailer: MailMate (1.14r5964)
Message-ID: <44C394AF-A9E1-499F-AE3F-7EAEA03B19DB@nvidia.com>
In-Reply-To: <CAOUHufZWTdpF0vdPkyOafVNFOOY7Wui+Q-O83=SZcfv4KZcHbg@mail.gmail.com>
References: <20230726095146.2826796-1-ryan.roberts@arm.com>
 <20230726095146.2826796-3-ryan.roberts@arm.com>
 <c02a95e9-b728-ad64-6942-f23dbd66af0c@arm.com>
 <20230803142154.nvgkavg33uyn6f72@box.shutemov.name>
 <CAOUHufZWTdpF0vdPkyOafVNFOOY7Wui+Q-O83=SZcfv4KZcHbg@mail.gmail.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_93025D9F-BE11-4FB9-B62B-0A2468E5BFB5_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1P221CA0026.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::27) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|BY5PR12MB4966:EE_
X-MS-Office365-Filtering-Correlation-Id: b272b435-1af3-4be3-6f5d-08db9490c436
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xgISEpVNo5v88cb8qiAKuWNE+QhIAQ9za4E0OFLeLGdPXB4x+H0KRinS30UZkaMeVOs/PFp6dBbWv/BItjoivLw2IDqD7VvWpxRKh9fj8y5/72cR3TUGn/Xlfu0aCUlZnTmF9gJcNRVhGQ2qapD95rXea9+4ZSVGIEWhMiEhQb91JfXXvqq+4LqQH2TyXAzEfsNEedfXK0QLiGHyFz+IxZ2ueBTvqjCCzKJlIIhe8yHOoZfhDfWDCFiWy1+O6PrEmxkReeUXV+++HiBIWbwLUoasjJhkdY/tmvfGRmj4iwAP1Tb1UVSOHO91jSG7tX/csIg048xXta20b49pxnqPbsWyACX2V2lyWw/gE/qkDLFfQfmaW8uiDIyjSr2Wyl9scw8OE/F3QTzQyUwTj8xX9N6FQntqsOXVXxtFJ0I9iT9ZZ2bbDXzEGtj3NprmKLL9OFRr170WB/iAx4hPd4YBuB042BeWI2pnz7evmHN1YdjfLcHc6jcWUUDAta359x7Eol/2UyxNt8XqkAfkljJw8ibqS3DkbhBEC2ws4YiSOQB2hyF3aDD6fX2y3Wpl8FjKp/EmaFEvLWb5aZhicJKK+K9vj7+uBSlr83CquiE6ufz+efY38svO1raCxszPW6RmiRCO56r2GWxqYdid/TdDhA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(136003)(376002)(366004)(451199021)(1800799003)(186006)(2616005)(83380400001)(53546011)(26005)(6506007)(8676002)(66556008)(316002)(2906002)(66946007)(5660300002)(235185007)(66476007)(6916009)(4326008)(7416002)(41300700001)(8936002)(6486002)(6512007)(6666004)(33964004)(54906003)(478600001)(38100700002)(33656002)(86362001)(36756003)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEhESlF3S1MyRWZUenFmMVBiUzZTU0pmRURXVDJpSEErSGpabjBYMzVRekdh?=
 =?utf-8?B?OS9qcDZ4OGVJR2tKY0kvQU12UWhhb3dFWEZYclJnSDFxTEZFSHBkNTVvaE1M?=
 =?utf-8?B?YXRUNWk0ZWhhTWZQb3pTcWtSWG1pMDhNSmhUZXp4Q0Z6K0pSVzZuanAvWUFn?=
 =?utf-8?B?M0dvcXBZZFl0TEYxNzBlVG5IRER3L1VGcGlIdGZ4elFGa0ppV0t4bXV3dC9E?=
 =?utf-8?B?eWN0Z2lWck5Ic3gwbGRYSVQxTC9CK3dRTHV2cWluMmFEMlVIa29NUzBMbTBr?=
 =?utf-8?B?Z3dJR24wR05mQUlzMUFtdnZwb1BnY2dMVitwZHVKOGwwRTErcldvYVA1OTdt?=
 =?utf-8?B?VnFGMFkzZWZzQzhWZFRoVndRSlFXR2w5TVFBWnBIbE1IY1FEZGlnNlY4TGxH?=
 =?utf-8?B?clZQeUcrVXB3UmpJNGI3ZWVHVis1eW5sZWJRVlR3ZEVwOXY1cCtQV3F3Y3BP?=
 =?utf-8?B?U3lwbDlDeVhONThRQzJIRERaMGhsK1owUUFJdGh5bFhNdmwyUzJLN1JlMGtl?=
 =?utf-8?B?YlVmMzRwVVNYOS9QcXpqUzkxOHRUbys5TCsxdFJJVDBKbWdHcFVtWm0yWk15?=
 =?utf-8?B?TThVVk03M1VhR3NkQTNjQk1qOE50d1B2c0JEMVR0ZEVCdVg2T2xsa0ltU1BK?=
 =?utf-8?B?aE0rVHVvVUUrekNoOVJicWNGUmRUNWF6bjhGMHR3Uy8zM1lNY0hscFZlbkNn?=
 =?utf-8?B?Um1tZEFiQlFXQVRWQzFHeXdvWXJVOWMrM2pXdWpZRHVjVGFOTXZlV1NLVkZ2?=
 =?utf-8?B?M2pnQ2pKSFBvTEhrZm9oVTFJdW5wVEhsOUN1TTFUU2kremp1QkozZU9mS3ZY?=
 =?utf-8?B?akZRQ0Fmdk9vQXBQWG1kNTV2UFJvb2tRMjUxMUdiMzhjeFNOL3JMKzh0b3Yw?=
 =?utf-8?B?dDZIcExFWGlydlJaUWdDbVBPMlJra0hQb2cvUHE0TEl1OXg1ZkU1WGw5YVlZ?=
 =?utf-8?B?REdQb0FHTTZGVUlVd25zaUl4MUFmeU1SUVFQbENRb2dOY2FsV3hoMy9TcmtR?=
 =?utf-8?B?SXFCVnFPU2JzNUdCQUd1V0JneEpQVzlTeGZ2S0pLRGpzU3BnR293VENBd1A4?=
 =?utf-8?B?bGV6NFEvYmRlN2FGWW5nVURCSGtmUWlNM1ZTUjY4bDNCSnU0UUx0TExLQUsx?=
 =?utf-8?B?UjlmWG1LaWdlajlNbENud2lPUmJ0c0Viak5JRG9ISW5qY3h6U3pVeWtsdmgr?=
 =?utf-8?B?QTlBbm1MaXVvcTVocTNDcVF5SXhwQyszK3E2SlUvc0Jkc2EwK0JKNEpCSm0y?=
 =?utf-8?B?LzVzRk1TUmU0KzJISmNkV3haNFFDdFE2Z1NXTS8wTFRuYTZlVzBkeUpDOHZ0?=
 =?utf-8?B?NUc2eXVTTUhzME5tbXZOdDNIYWRxVElFbFlLYUpDWmtZbTNpcDQvTVJJK3Jv?=
 =?utf-8?B?Nkg5TURwNGF4M2JpUG9UR0hnSGFKd2pvN2hJaVdHWG5qMTZkL0tBdVdyNHAv?=
 =?utf-8?B?OC8zWVprblRKaGpJbHNjUEc3WmE5TWJKeVBtYnpaTTllWUxaZHkxYTl2RnZo?=
 =?utf-8?B?TEgwVWgrQTVySEJ3NE5OWHkzakJ5alYzZUZrdCtvM09NMnExQUc4VG5FcFdY?=
 =?utf-8?B?T1hmNkoxSStxSkJCSUI5YzlHanFVWjN6YXYvenBuY2htK2hCZzk4MWZvamc3?=
 =?utf-8?B?a1NWVk5CRWZKUWpQaTByZUN4YTJlVi9rbUg5SDdBaEUwcWhDOVBVaGZFa0NJ?=
 =?utf-8?B?LzNGUk9JYUY4SDQ2eVhRMmltSFpPUWM3bmFyRXlXQW53bkoxM29nWG9yZ2RQ?=
 =?utf-8?B?NHYyUUlla1B2aGF1R1RoZTlFMEl2N0F1eUhENnNPVG5EcE1iR2pFN1JuZkFX?=
 =?utf-8?B?N2hIMXVERVZlUGI3K0ZtcEkrN2ZwSzM4NHpqU2Q1MXBadDlRL2NpNXk3aGhx?=
 =?utf-8?B?bXhWaUpCUUdpRHU1UGZhTTF4YW5hVXJpVFFlN0drd1hWYUtydWFjN1BTSzZK?=
 =?utf-8?B?QVBuV3VsRlA1YkxVZHJoa09Zc3NIbkNjRXN0Szl0azI2bDNsQ2Z5WmFtVzht?=
 =?utf-8?B?YWh0SlpSR2loYTh0L0RGUy82eUwrZENYMDNmbGdjallLQXZYWE9weldtK1VS?=
 =?utf-8?B?WGJFREZpalFWOHpYZ1d4RjY2a3Mrem9mcWxqY1NKQUlBYjlTV01wS3lDekhh?=
 =?utf-8?Q?Qpw4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b272b435-1af3-4be3-6f5d-08db9490c436
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 02:16:09.4355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4s9zrrW2WREQ+ckrIKdvVsE6Gb43mTCXgzLXvT7XqZc8IC83j8g93z0HuQ+MieJ1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4966
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_93025D9F-BE11-4FB9-B62B-0A2468E5BFB5_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 3 Aug 2023, at 20:19, Yu Zhao wrote:

> On Thu, Aug 3, 2023 at 8:27=E2=80=AFAM Kirill A. Shutemov
> <kirill.shutemov@linux.intel.com> wrote:
>>
>> On Thu, Aug 03, 2023 at 01:43:31PM +0100, Ryan Roberts wrote:
>>> + Kirill
>>>
>>> On 26/07/2023 10:51, Ryan Roberts wrote:
>>>> Introduce LARGE_ANON_FOLIO feature, which allows anonymous memory to=
 be
>>>> allocated in large folios of a determined order. All pages of the la=
rge
>>>> folio are pte-mapped during the same page fault, significantly reduc=
ing
>>>> the number of page faults. The number of per-page operations (e.g. r=
ef
>>>> counting, rmap management lru list management) are also significantl=
y
>>>> reduced since those ops now become per-folio.
>>>>
>>>> The new behaviour is hidden behind the new LARGE_ANON_FOLIO Kconfig,=

>>>> which defaults to disabled for now; The long term aim is for this to=

>>>> defaut to enabled, but there are some risks around internal
>>>> fragmentation that need to be better understood first.
>>>>
>>>> When enabled, the folio order is determined as such: For a vma, proc=
ess
>>>> or system that has explicitly disabled THP, we continue to allocate
>>>> order-0. THP is most likely disabled to avoid any possible internal
>>>> fragmentation so we honour that request.
>>>>
>>>> Otherwise, the return value of arch_wants_pte_order() is used. For v=
mas
>>>> that have not explicitly opted-in to use transparent hugepages (e.g.=

>>>> where thp=3Dmadvise and the vma does not have MADV_HUGEPAGE), then
>>>> arch_wants_pte_order() is limited to 64K (or PAGE_SIZE, whichever is=

>>>> bigger). This allows for a performance boost without requiring any
>>>> explicit opt-in from the workload while limitting internal
>>>> fragmentation.
>>>>
>>>> If the preferred order can't be used (e.g. because the folio would
>>>> breach the bounds of the vma, or because ptes in the region are alre=
ady
>>>> mapped) then we fall back to a suitable lower order; first
>>>> PAGE_ALLOC_COSTLY_ORDER, then order-0.
>>>>
>>>
>>> ...
>>>
>>>> +#define ANON_FOLIO_MAX_ORDER_UNHINTED \
>>>> +           (ilog2(max_t(unsigned long, SZ_64K, PAGE_SIZE)) - PAGE_S=
HIFT)
>>>> +
>>>> +static int anon_folio_order(struct vm_area_struct *vma)
>>>> +{
>>>> +   int order;
>>>> +
>>>> +   /*
>>>> +    * If THP is explicitly disabled for either the vma, the process=
 or the
>>>> +    * system, then this is very likely intended to limit internal
>>>> +    * fragmentation; in this case, don't attempt to allocate a larg=
e
>>>> +    * anonymous folio.
>>>> +    *
>>>> +    * Else, if the vma is eligible for thp, allocate a large folio =
of the
>>>> +    * size preferred by the arch. Or if the arch requested a very s=
mall
>>>> +    * size or didn't request a size, then use PAGE_ALLOC_COSTLY_ORD=
ER,
>>>> +    * which still meets the arch's requirements but means we still =
take
>>>> +    * advantage of SW optimizations (e.g. fewer page faults).
>>>> +    *
>>>> +    * Finally if thp is enabled but the vma isn't eligible, take th=
e
>>>> +    * arch-preferred size and limit it to ANON_FOLIO_MAX_ORDER_UNHI=
NTED.
>>>> +    * This ensures workloads that have not explicitly opted-in take=
 benefit
>>>> +    * while capping the potential for internal fragmentation.
>>>> +    */
>>>> +
>>>> +   if ((vma->vm_flags & VM_NOHUGEPAGE) ||
>>>> +       test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags) ||
>>>> +       !hugepage_flags_enabled())
>>>> +           order =3D 0;
>>>> +   else {
>>>> +           order =3D max(arch_wants_pte_order(), PAGE_ALLOC_COSTLY_=
ORDER);
>>>> +
>>>> +           if (!hugepage_vma_check(vma, vma->vm_flags, false, true,=
 true))
>>>> +                   order =3D min(order, ANON_FOLIO_MAX_ORDER_UNHINT=
ED);
>>>> +   }
>>>> +
>>>> +   return order;
>>>> +}
>>>
>>>
>>> Hi All,
>>>
>>> I'm writing up the conclusions that we arrived at during discussion i=
n the THP
>>> meeting yesterday, regarding linkage with exiting THP ABIs. It would =
be great if
>>> I can get explicit "agree" or disagree + rationale from at least Davi=
d, Yu and
>>> Kirill.
>>>
>>> In summary; I think we are converging on the approach that is already=
 coded, but
>>> I'd like confirmation.
>>>
>>>
>>>
>>> The THP situation today
>>> -----------------------
>>>
>>>  - At system level: THP can be set to "never", "madvise" or "always"
>>>  - At process level: THP can be "never" or "defer to system setting"
>>>  - At VMA level: no-hint, MADV_HUGEPAGE, MADV_NOHUGEPAGE
>>>
>>> That gives us this table to describe how a page fault is handled, acc=
ording to
>>> process state (columns) and vma flags (rows):
>>>
>>>                 | never     | madvise   | always
>>> ----------------|-----------|-----------|-----------
>>> no hint         | S         | S         | THP>S
>>> MADV_HUGEPAGE   | S         | THP>S     | THP>S
>>> MADV_NOHUGEPAGE | S         | S         | S
>>>
>>> Legend:
>>> S     allocate single page (PTE-mapped)
>>> LAF   allocate lage anon folio (PTE-mapped)
>>> THP   allocate THP-sized folio (PMD-mapped)
>>>>     fallback (usually because vma size/alignment insufficient for fo=
lio)
>>>
>>>
>>>
>>> Principles for Large Anon Folios (LAF)
>>> --------------------------------------
>>>
>>> David tells us there are use cases today (e.g. qemu live migration) w=
hich use
>>> MADV_NOHUGEPAGE to mean "don't fill any PTEs that are not explicitly =
faulted"
>>> and these use cases will break (i.e. functionally incorrect) if this =
request is
>>> not honoured.
>>>
>>> So LAF must at least honour MADV_NOHUGEPAGE to prevent breaking exist=
ing use
>>> cases. And once we do this, then I think the least confusing thing is=
 for it to
>>> also honor the "never" system/process state; so if either the system,=
 process or
>>> vma has explicitly opted-out of THP, then LAF should also be bypassed=
=2E
>>>
>>> Similarly, any case that would previously cause the allocation of PMD=
-sized THP
>>> must continue to be honoured, else we risk performance regression.
>>>
>>> That leaves the "madvise/no-hint" case, and all THP fallback paths du=
e to the
>>> VMA not being correctly aligned or sized to hold a PMD-sized mapping.=
 In these
>>> cases, we will attempt to use LAF first, and fallback to single page =
if the vma
>>> size/alignment doesn't permit it.
>>>
>>>                 | never     | madvise   | always
>>> ----------------|-----------|-----------|-----------
>>> no hint         | S         | LAF>S     | THP>LAF>S
>>> MADV_HUGEPAGE   | S         | THP>LAF>S | THP>LAF>S
>>> MADV_NOHUGEPAGE | S         | S         | S
>>>
>>> I think this (perhaps conservative) approach will be the least surpri=
sing to
>>> users. And is the policy that is already implemented in this patch.
>>
>> This looks very reasonable.
>>
>> The only questionable field is no-hint/madvise. I can argue for both L=
AF>S
>> and S here. I think LAF>S is fine as long as we are not too aggressive=

>> with allocation order.
>>
>> I think we need to work on eliminating reasons for users to set 'never=
'.
>> If something behaves better with 'never' kernel has failed user.
>>
>>> Downsides of this policy
>>> ------------------------
>>>
>>> As Yu and Yin have pointed out, there are some workloads which do not=
 perform
>>> well with THP, due to large fault latency or memory wastage, etc. But=
 which
>>> _may_ still benefit from LAF. By taking the conservative approach, we=
 exclude
>>> these workloads from benefiting automatically.
>>
>> Hm. I don't buy it. Why THP with order-9 is too much, but order-8 LAF =
is
>> fine?
>
> No, it's not. And no one said order-8 LAF is fine :) The starting
> order for LAF that we have been discussing is at most 64KB (vs 2MB
> THP). For my taste, it's still too large. I'd go with 32KB/16KB.

I guess it is because ARM64 supports contig PTE at 64KB, so getting
large anon folio at 64KB on ARM64 would have an extra perf boost when
set contig PTE bits patch is also in.

On x86_64, 32KB might be better on AMD CPUs that support PTE clustering,
which would use a single TLB entry for 8 contiguous 4KB pages and is
done at microarchitecture level without additional software changes.

>
> However, the same argument can be used to argue against the policy
> Ryan listed above: why order-10 LAF is ok for madvise but not order-11
> (which becomes "always")?
>
> I'm strongly against this policy for two practical reasons I learned
> from tuning THPs in our data centers:

Do you mind writing down your policy? That would help us see and discuss
the difference.

> 1. By doing the above, we are blurring the lines between those values
> and making real-world performance tuning extremely hard if not
> impractice.
> 2. As I previously pointed out: if we mix LAFs with THPs, we actually
> risk causing performance regressions because giving smaller VMAs LAFs
> can deprive large VMAs of THPs.

I think these two reasons are based on that we do not have a reasonable
LAF+THP allocation and management policy and we do not fully understand
the pros and cons of using LAF and mixing LAF with THP. It would be
safe to separate LAF and THP. By doing so,

1. for workloads do not benefit from THP, we can turn on LAF alone to
see if there is a performance boost and further understand if LAF
hurts, has no impactor , or improves the performance of these workloads.

2. for workloads benefit from THP, we can also turn on LAF separately
to understand the performance impact of LAF (hurt, no change, or improve)=
=2E

Ultimately, after we understand the performance impact of LAF, THP, and
mix of them and come up a reasonable kernel policy, a unified knob would
make sense. But we are not there yet.


--
Best Regards,
Yan, Zi

--=_MailMate_93025D9F-BE11-4FB9-B62B-0A2468E5BFB5_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmTMX2YPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUQQkP/2w6OBIuNvivJ8AnqoE2YGFxwKfbhYOwQlzj
pYrD7MjaKj6jdTuwn+ZiwOiFs99wZeQ20hnTtXaFUTxi3vNiWR4wGXU3IqzfzDh9
5T4gMqH6HonRJVFIS01ojGYyyul+ml0lA+uHvCGkxSHLUMkcqSd07WUaXvtFVOmQ
tbODx5K+jYaUnsBHn/aGEut6hv/LurdYyBRpQHiRHHgV6Fl9DYw+sYqwxYSGg4oy
EjGVjqzA7OhWCAj9WBZnf40BOTrdWmKRw+WVVzvZiasyn9o5P+bLsxPEECfIf7nu
1l/Z3FSoiZC8ek8j9DmjOz6Vk9ALdAE/0nITlJrd4lquynhlJoi8sPvq31ACH6Pf
m5HjoBwyH19FiY+KD7yCK46ZawPqfW3Q+WraqxoNUJzwja4op4yuaEyQW6A4oxFs
Ox3EusmCfbGsg5rHBu3GUZ/+w6VSIMC7v2HFiSXzFHGGddfIG24e26BTMwQP7NU8
qWVksUSgEkcDaCWzhO94traXT+VhTfgf3qUKNWNVhM98PVVQiXqQvbcEbeVGFv1n
1DzGNSe7XFV/c0fhyHFZ5wlJwKRuzGXmPDxt3V/3ymEo8iHd0T9F38XhGTzy0z6b
l/fS2f6jDJuxS8QBdw2VbSjYiRKQA86EkRUTEwbpL9ejuHoiX/8aDYhBNJnAG6tv
cmEVWUnf
=PKV6
-----END PGP SIGNATURE-----

--=_MailMate_93025D9F-BE11-4FB9-B62B-0A2468E5BFB5_=--
