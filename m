Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A179876EC84
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 16:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235140AbjHCO3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 10:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236434AbjHCO3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 10:29:08 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2073.outbound.protection.outlook.com [40.107.100.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1451728
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 07:29:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NHAjjTEUvdNwb+z+i0A+jlNMkswwmPRMMwPfWZ4OCKVz12fCmHZosCd/9+yv0GThgx59KVhXnpg+BvRxXGoUqTk50NPF8otHlkE77fd7URDFpegfvrZGqdik0exOVumh6vdDWBDYfdyr98f32ji0zIzVh/o6KaEm9+/zvsjfVbuRrn36euRBkwnbBj+W0DtF7KKUQm5XFpAsGRMO4IPrT6k6qZYzjLgHKsjfTn1vNVPGgo58bW+Am80dvDrePNPv0dBq21lc0tyWdidf05+uZyL9GpdeM99ZifgPahBBANz5xWC2GdAqz4qjW3TN2bYUvMla6YK9ybCZ8j/YxG7uAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r8sviviOwaQgtmnHZ+846fCXEqrQh+oiZ3LbeCI91LU=;
 b=KqlUWY1zLbGZPxOJUvPc0zSQvWV2pc6fa7/u37hus49YsOXgfbARj2GSITiCqxPDg/q1GkC6Mbuu3Js58cmo/d9yO/etkTfkQQ8nmOlvenY9ozOkyvaJ4lo2dnwp7hs7va8BlzhMyJhEkti99TEkhGnwD+Ml13uq36KH7+JbEHYyUcpea9H0iUmRDWy/xN2k07xCNpAHMOH7ijNfFfSrZEsXAwzDVFvhjXv5b8wkmaIU79pKFLYjyaaL2ZzbJEQGVzwDedCBjp8rtIAgWfb3xSHgvQzlkPvY+Sqo2Qp8BRYwLx2WS6a8ZeGSgsrrOU9Hobs2mYV3+Vf8HK6tOsFnow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r8sviviOwaQgtmnHZ+846fCXEqrQh+oiZ3LbeCI91LU=;
 b=qvKHTAtAfHSmxhcVhSx1ay0ab9PSozp6oePTzBR00UUVLYpWB0adlXba+wknVXFinxPGvdUf61aZXRmx8OS3I7F2gwMikGlal0mxTRJuO+lTHbTQiIhObbJfu268ZYauFT6NiW94ThRfy+SbWr6R1Tg8a6+sozCQY1QCEhAE798tRrHA4pwfTNafu3yFe9KQ+1Vd5bqbC2WnXtuKWLyEOc7cFRQY3bYc98eudT5c5rV8LFahZzTuaqgi4NbJdWNJWeE/ZEi5tkbbkxRWr2Y19YvQevKV0VlQpaKl1bWnLGuD6QQQnkXqwiVeZlYAoj9gCyYQYr6bk82phFWlUe8NhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 BY5PR12MB4066.namprd12.prod.outlook.com (2603:10b6:a03:207::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Thu, 3 Aug
 2023 14:29:02 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::c166:b535:d93:641e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::c166:b535:d93:641e%4]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 14:29:02 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 3/3] mm: Batch-zap large anonymous folio PTE mappings
Date:   Thu, 03 Aug 2023 10:28:56 -0400
X-Mailer: MailMate (1.14r5964)
Message-ID: <DFF7C190-A14C-49EC-B31F-9D9B8783C604@nvidia.com>
In-Reply-To: <bb871b52-526a-d4aa-5249-6105bc06aaba@arm.com>
References: <20230727141837.3386072-1-ryan.roberts@arm.com>
 <20230727141837.3386072-4-ryan.roberts@arm.com>
 <6cda91b3-bb7a-4c4c-a618-2572b9c8bbf9@redhat.com>
 <4255e71a-63c9-b2f9-5e97-e46834f7837c@arm.com>
 <b54e7885-3e49-150f-cf8a-36a880e5dfc9@redhat.com>
 <bb871b52-526a-d4aa-5249-6105bc06aaba@arm.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_16E27F0E-0944-4853-A171-530C03DE7AEA_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL0PR05CA0019.namprd05.prod.outlook.com
 (2603:10b6:208:91::29) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|BY5PR12MB4066:EE_
X-MS-Office365-Filtering-Correlation-Id: 8800d3ef-0bf0-4e46-3b55-08db942dfb94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kFUCr7/M46g78a0ekSIf0v0ShK3wEqvS1LhroTeh7zkuPYLhNHJwTuC9XoK7XMrTRsDrEsDUEHR/kBuAOe+66tnUYgXzHDBkJvELK3gj8I73bpzUzAYF3EJAoAZFtR1ElMKlrewd/eND36L1aH0A4Zm77dI/qiIHqmauVXJOunFiBdQtT8cLNUOqpTx/0gHwhR3DaNE/1Hv3P88d+s9mJoArf3FpFHdRC9LrHWapGEEmikM1B6vujPvWFHhKVsEoRCJqzuuVipwZIsX2Kyll+gANfw2Er4b3XeGVLC0PFSX1n+RN0NMTOCro/Ae6NagmihJc1eLdfX2kPiyMdf7Dot9wLjFHvffKPIkqAB46LT2T5HSG7wbTwZeCkOQd2mkvUEdbGGLIm8VjMdhrJvw4epUdVO+4auHBrOnNOx/QB+6b9ElnMz6XGZgkUdoM3VJTTc5ogcepyJfeGcosIl6NiOXLvIeVS9g0ojqjAoTP4oPqyx/tFMgu4g65rgQ1ttVDR+1f8pezoh88AYEQ/z9yc3451/+q6A/1lpOaliZ86Id194dqxrOXfoRgLwFaPbPayKA5H5b6ZzZaI3KuqicbI9UXMTWFmLCYD/NM7fO4xju5yPNNJY5BDkz2hEaK3NXqA7Zj5+so+qtSdjXokRCPoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(39860400002)(346002)(396003)(136003)(451199021)(36756003)(86362001)(33656002)(66899021)(54906003)(478600001)(38100700002)(2616005)(6506007)(83380400001)(186003)(26005)(53546011)(8676002)(8936002)(41300700001)(7416002)(6512007)(33964004)(6486002)(6666004)(316002)(66556008)(235185007)(5660300002)(66476007)(6916009)(2906002)(4326008)(66946007)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1hTTlNRZmhVclJjckVSSFp2Z2xUTDREZTVDM1JVL2xzKytVRm9EWDhmQUZz?=
 =?utf-8?B?ZjhkczJ3QnpBNGtEZEVnaXl2RVd5Umk2UFk3dVZZei9Xb2FqWUJHSVNnRXBC?=
 =?utf-8?B?d0UxOHdNeTlIdklXcjlNR1NXbnhSL1lZNHNDa2JpeFZWYU5UQWJFRE03c0xL?=
 =?utf-8?B?d2lCL1hYRXovSHBhTjBKR3BCVHlMU1hVaXVYclNMWHFLMDJTd1lMSzNXS0xx?=
 =?utf-8?B?YnM3STVEOWtRdkIveDVzV3pldkxreWVIOFRvS21TSXg4a2I0MVczSk5UR045?=
 =?utf-8?B?RmU0V2N4NVV6U3AxOVRQWjVVRGhRQzhsbXRIRXpVeEsxN3kwN0RFcVlpc3gx?=
 =?utf-8?B?SVY5a0I1ZGFlQlZqaVM5MkVhOEFmWlcvWW1vWUVubEYzZ2VmMWVnbkJQVDBk?=
 =?utf-8?B?VUdVUkppZ05HdDF3VUVKbzBKWlNtejFrcnY1aG5RMXRtNFRUcjFPQXpydGk0?=
 =?utf-8?B?KzZjUmtaVExObTdGS0EvenpiUjFJSE9OZzBuc1J4ZWF0NjdsRGJjSm10aEo3?=
 =?utf-8?B?YytRWXJZRHBIZ2gycnV6MFdBODFKeW01S2EyYnJjMlNpOUlYVlFPdHY2bFo3?=
 =?utf-8?B?dUJLVUNZRURmdDFDa1ZTTkFsWlU2bkFzSWlWbVk0dGpxUFlTbTl5MXB1cGRx?=
 =?utf-8?B?RWFIZnBGWWliaUVPMThLL1ZNd3d5eUhiamtmeWlJOC9kR045L3NLQ1hvU2xw?=
 =?utf-8?B?K3VpeFRRaFlibG1SWm0vWExISnJ6QjBDVHFoSHNFT1NNZ3lyRW9Hd3VSdWl4?=
 =?utf-8?B?azJMdVZKVVN5ak1iaVJra25EOGdsUWZ3YjVXSDN4LzlOcUFsU24wRHJYWUtS?=
 =?utf-8?B?aERoZVlLQmFnRDZDT014WGFPM2sxdnNxbmlKR2V5QWc5NTcyNUZvbEV5NGZJ?=
 =?utf-8?B?czV0STZkbTdqUHgwSUNCa0ZNLzU3SW9Wa09OSGNXa3BMd3BzUm1zWk5xbzhz?=
 =?utf-8?B?K1V1d3ZvRTMwZnYrb0M0TUJFQTI0S1N0dFJKY3dnS0Zhc3lIanhjMEgvZkpX?=
 =?utf-8?B?d0JIb1dqOFRxY2NrYWZQTDV5RndycDlWT2xMQjY0b3UwRGtFemF6K05rakYv?=
 =?utf-8?B?QWJJbGxKY3YxYm9Ud2lwd1V4YlRpSTBTUkhOenJKTnhCMlVRT2JqNWx0U1Zu?=
 =?utf-8?B?MjJVWmNUZDBOYmtIZWo2UWNobXNLRVhYY0NLNVUzbnpPcnhoaVhvOFBnUXhN?=
 =?utf-8?B?LzFMWWQ5ZkhlZEY2TUdmampQY1NZR0RxRU1BaXBSMHg2alFScWpzb1U4OW5Q?=
 =?utf-8?B?bkdXdGQwTE04NTBQNGxVNUUya3g0VHVwTFpPZWpldWpHN01Ua3Q1WkEzM3c0?=
 =?utf-8?B?TnprY09uanhERTVlYmlrTlF2VmgyM1hTenZIbEZzNmR1amg5OVFKNHkrMitR?=
 =?utf-8?B?Q00vYmZLYVVBTVJNb0JkN0hmdDhGZzdBeW9aalo2WkY4Y3BJQjVBR2lTTVg0?=
 =?utf-8?B?THpMOENWYytiRlNTQ3YzWnczRkNZWVZRZXAwbFdhYll0dnZKdzlWcjBWNVNK?=
 =?utf-8?B?WThoWEZ4R0ZjYUs4NXk1RmlhVnlGSEUxTlpxTkNIbCtFRWdkOE91NjRDbVJj?=
 =?utf-8?B?K21HWXExUmVldHNkWGw3dldjWnowaEdrdXRacUttclEvWHhsUEtvaUFWSzBa?=
 =?utf-8?B?UGx6czlnRnpXSytWbmdXZXY0elIzTzF6dWVqZUtZT3ZSSHZuQU9CTDhnbnNX?=
 =?utf-8?B?bFVtdkZHN1h5WlYxZ2Z4RFdZS08wc0MrZ29kSzVvQ1VkUWF6TUI1YThZbVNV?=
 =?utf-8?B?TUY1eloyUmpaUVFqdjVSaGlpQXd0QjR2V3VjOFJOMkEvQzhiWGJ5WUxUK1Y4?=
 =?utf-8?B?SGI0amhydmF1Sm9CVFJYMlZWMVpvY08yN3EzVk9nL2toYUtCNy80SUN0Wmwx?=
 =?utf-8?B?T2ZGU2Z0UEJJVHV2c2FsZVNpbE1rZTlLaEIzMmhON1ZyYVNLQ0xBT21mOFNU?=
 =?utf-8?B?R0xzUlNaOU1mK1JEZWFwNHBacDN4alFYYVdmVG5ZYkx3T20wZi9wM0JEMDc0?=
 =?utf-8?B?V1RZbi91ODI4OWF6TWYzSmo1OGdlZEh3R3lLZDkxczJ1N0RzRzg0cjgra01s?=
 =?utf-8?B?bjU5Q0pRMXpJakdmcEdXU0hVSjhNMTZiNytMQlFYQTRWd01zU1VycmVDMU4y?=
 =?utf-8?Q?POIk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8800d3ef-0bf0-4e46-3b55-08db942dfb94
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 14:29:02.0056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XF3YlVcI0yzydeO9CXaM3rPHGlJVphDxWWeVBxCmStDKVk4YOv0Ou+8nYC/D8VD+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4066
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_16E27F0E-0944-4853-A171-530C03DE7AEA_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 3 Aug 2023, at 10:15, Ryan Roberts wrote:

> On 03/08/2023 15:10, David Hildenbrand wrote:
>>>>
>>>> With this patch, you'll might suddenly have mapcount > refcount for =
a folio, or
>>>> am I wrong?
>>>
>>> Yes you would. Does that break things?
>>>
>>
>> It is problematic whenever you want to check for additional page refer=
ences that
>> are not from mappings (i.e., GUP refs/pins or anything else)
>>
>> One example lives in KSM code (!compound only):
>>
>> page_mapcount(page) + 1 + swapped !=3D page_count(page)
>>
>> Another one in compaction code:
>>
>> if (!mapping && (folio_ref_count(folio) - 1) > folio_mapcount(folio))
>>
>> And another one in khugepaged (is_refcount_suitable)
>>
>> ... and in THP split can_split_folio() (although that can deal with fa=
lse
>> positives and false negatives).
>>
>>
>> We want to avoid detecting "no other references" if there *are* other
>> references. Detecting "there are other references" although there are =
not is
>> usually better.
>>
>>
>> Assume you have mapcount > refcount for some time due to concurrent un=
mapping,
>> AND some unrelated reference. You would suddenly pass these checks (ma=
pcount =3D=3D
>> refcount) and might not detect other references.
>
> OK. I'll rework with the 2 loop approach, assuming I can calculate the =
number of
> free slots in the mmu_gather ahead of time.
>
>
>>
>>>>
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < nr_pages;) {
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ptent =3D ptep_get_and_=
clear_full(mm, addr, pte, tlb->fullmm);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tlb_remove_tlb_entry(tl=
b, pte, addr);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 zap_install_uffd_wp_if_=
needed(vma, addr, pte, details, ptent);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 full =3D __tlb_remove_p=
age(tlb, page, 0);
>>>>> +
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (unlikely(page_mapco=
unt(page) < 1))
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 print_bad_pte(vma, addr, ptent, page);
>>>>
>>>> Can we avoid new users of page_mapcount() outside rmap code, please?=
 :)
>>>
>>> Sure. This is just trying to replicate the same diagnstics that's don=
e on the
>>> non-batched path. I'm happy to remove it.
>>
>> Spotted it afterwards in the existing code already, so you're effetive=
ly not
>> adding new ones.

I agree that we should keep the original logic flow and use the 2 loop ap=
proach.
Otherwise, the (unlikely(page_mapcount(page) < 1)) check might not work a=
s
expected, since the page mapcount is decreased after this check in your c=
ode.


--
Best Regards,
Yan, Zi

--=_MailMate_16E27F0E-0944-4853-A171-530C03DE7AEA_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmTLuakPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUGvgP/RUyzGCaTdEczOg5q3BLJ3uUnTnCnyCURRFt
Gr+pU5JHTZHmcedpvtRr3xiyyvu8BG/vENLgUIg80Wdc1XU6NWo9dv/5i6B+J5vM
ja0PgDOxTqpllW2Z01jyskyfW8wHXJ1MmQYg+rRK04WyMActp0CuJwKjYymVnrWd
HAq4kytptLQ88I+4BYi7Q5OfVRreyxgOK0HA+RkAgXyqykRO4n7JSwCjw+8M7irW
MPTzVad/v/a6SgQ6q8JKqDGeXLhYJp4R+PMwY/BR45fBNsj0ZvvUDMH94/8sYcBx
WSEuQcWw2H8LI9lgSqIKvYLKDxSJdQxV3t4v4WpF3mzMVhWu3+0twYG/+ZOvbxKD
n04UjRN6F3xp3J3zCahRW4XG4G5yEUdFL+ggjQHv7hmAKO3OF+TCN1NrnZIWC7BM
1csSjLr1foeiQGU/9SV9JdV2gPr8GmVhOuV5iurH3cEy7tfmjtPGS5Or3pBqrxFZ
rJI5JsxKm59IowKxRxm6CsUj/ROt5lzuFUsf5Bf9rlKwSm9PwfWtswdWipH2E9Gn
jglNWFBI6vZ4WQb2MUHcXN3+oeC3C4iPJj83nuM1sEObQWyTT7FW+nynNZlT9hMR
9iTzIBB7iTRrvNSvctkBLTZZFmk8Zk1BRc8ujho5PGolI24kTNDFUG89LjRVhG55
Z9q0ToEu
=AW3O
-----END PGP SIGNATURE-----

--=_MailMate_16E27F0E-0944-4853-A171-530C03DE7AEA_=--
