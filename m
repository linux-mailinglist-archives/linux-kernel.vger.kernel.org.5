Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9190177CD88
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 15:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237260AbjHONtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 09:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236924AbjHONtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 09:49:12 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2071.outbound.protection.outlook.com [40.107.101.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB91F138
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 06:49:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CYE4wUdIGM/W1WU6uri3+KBU4HeD7wAfKvgJagXyT+IkCbuHGiXqr0+RaaZJph8EOw5sOnuBQGCRm/2VmAg06qBxXN37vXNqWr4eq2ZlfzqR3/QUm87B1XqDkOpszK9vkCMCmDyJARBy2f8vMhLpdG2wzRve139AURE9bl09/XSRjVCqlcPwxx+FgLfcnbtd0hYNRepxRV6BWEwgjjsYyljyBHv8jAZt2UXoT9KuCSLuqlK3Vv+UkHJUvRtIJ0BK1e/6htEQj2jcvNimjcbd/PX6xGDdRJZy+JbcFDXX1z6ureVcAve8eeLbozv3bH4foaJf3CPDdAqY2fRI1YX0nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4RJlTOlvQ+3hGmoo9gNCK55MEUyL2ojnqLex0jooa3U=;
 b=mePkfLP1AvvvHEw6E5sZas6vuodedeg4qUhkew4IM9mNcFni9WAakLf/IaV4IErvJR1I2TDbj0aDDRRHo7ZsqhujFUNdH+VM+dTaL7Q8JpHY6PwXnm2kJ8Hq90mh978VBI1CCMBm/byUELXAyuQONmIsW4oegzoMxkHdQZ+947wIe/V/hjSdvcs2AHydLKXHVzN/4kAoxNXB+qF06gUvMKZX0a4jnZhnlkfePiF8vbKLuLm1nOtC7tCm1FIOPb3tj1no+hccEGX5M2t1wuFg1mXAC0uOylnGt0DrLiaosdbUY3ST8bVdMACoR0YKRPDJTbLL7KgbCOgnosI3D5G9bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4RJlTOlvQ+3hGmoo9gNCK55MEUyL2ojnqLex0jooa3U=;
 b=g7Gap45OzS7v+7bCVsTe+LohIz6BfmPDBc3DzazjKKNiI1gKgERU6icv2OuFraJ0s6Ue5U3d1EaBB8jYHekARBqvFRtLoXnZeBFAYUDwSTMTvDnMmdjJFbEI9R2VUD8gzEYdoaHnRkkEqH+MZE5o3jmbNa268bjo5HAZ68zUfsABk0azHFPxoKLMc9agPZ/dulOgR54sVOdrOUQksE05C9VXKtT1NPK8Spci1fpGnp6YN1j2lulezg3u2jaTx/K9MUme5UJ4Snt8tkfOkpaxgHLNSDRUI+TgnZiJcZytnNGzYJZL3KDqQg1y2nlkKS6K4LZTEDAFkBkNOb9lThqZHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 PH7PR12MB8177.namprd12.prod.outlook.com (2603:10b6:510:2b4::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.26; Tue, 15 Aug 2023 13:49:08 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::c166:b535:d93:641e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::c166:b535:d93:641e%4]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 13:49:08 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 1/4] mm: migrate: use a folio in add_page_for_migration()
Date:   Tue, 15 Aug 2023 09:49:06 -0400
X-Mailer: MailMate (1.14r5964)
Message-ID: <2E8CA295-CEA2-4093-8287-F68C3977A538@nvidia.com>
In-Reply-To: <871qg59cwd.fsf@yhuang6-desk2.ccr.corp.intel.com>
References: <20230802095346.87449-1-wangkefeng.wang@huawei.com>
 <20230802095346.87449-2-wangkefeng.wang@huawei.com>
 <ZMpKYfNWA/jNgEuL@casper.infradead.org>
 <001ee9b0-ea25-a896-e3ae-9a9b05a46546@huawei.com>
 <ZMud3RreEpsvFKuA@casper.infradead.org>
 <fb2a22cf-14ae-3594-f5f3-8680c2100d70@huawei.com>
 <F2621E68-F36E-493C-8619-ADFE05050823@nvidia.com>
 <d184ba78-97d1-a264-fc31-87dfdbe6fdff@huawei.com>
 <871qg59cwd.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_0EC9C18B-0D3F-486C-A60A-FED27DD40C6D_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR01CA0009.prod.exchangelabs.com (2603:10b6:208:10c::22)
 To DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|PH7PR12MB8177:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d538024-43ed-4285-3f2d-08db9d9665c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: piS8wxrvLkIdXoeK6QTRoC7CocDtOCY26eOSEA1z/idas7+dGn4fpUVJd+ipgJKjvscHVbsG6bqufg5xJ/7LyCNK3qnXfsB0vQjMCf2nMNgv79aACKgo/c/GI9xZYmx+DLtyc6ZGD2Gzor0SF1i83n7WnXgU9+vTzAaTnBtZ7o83Xygv1xu8t+7PNiBZpCE0nw1CIgkK/aUKsGtPlrKyhlTgqoXLSjXlwwFaBiPTcarqjaimx6ngZpBns0F4TyGIA8axRqxwcbNdVakvyxTnSk4CrsUjHhrLHAl68PDunRkN81HN+ldATJ/1D4DS7+PRNQ9LV8M3E9g+QTaun0lhHTzyx+qgH6lg3WTzo0x19bAQ6Xr9uJEj/lY73nR5oZJIC6FvErTDdkCpNOMLLu+dl3DNCJaJhdSeY+iqQ00HJFsiNMW2nRRuqqDavMiy8rwqAbzyjo84jM6f+ncm78WKZqMY0jruiSCujh9cfwhDRjVuJzuLawvEbOouMaYWgKiwBMd1r9UwtkOp3TU/zkiqsz+UgNC+BD883sbwbou51TaMHq0hqCIaSptdOeoYEkx73AWw22YrRmbH8kVqRhNs8ots8YUkYMkP/W25pPEEgMZgkP3WC9auVVUMSvGew5WlPAhLX4koh2vBYc//RfzT90UPlNG4mpO5L7NBUliOc7YZpYINZLruycTpRwP7FD0A
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(376002)(136003)(396003)(451199024)(1800799009)(186009)(966005)(66946007)(53546011)(36756003)(235185007)(66556008)(2616005)(6506007)(83380400001)(26005)(86362001)(33656002)(6916009)(5660300002)(66476007)(478600001)(2906002)(41300700001)(8676002)(316002)(8936002)(6512007)(38100700002)(6486002)(4326008)(54906003)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iTPwV1I8lw2KENa1Wjm+xxlQJUpanN0v3QgoJwNKnmWyIOjyu7GBrN79e/bC?=
 =?us-ascii?Q?kHQY8BDwOSWabp9vkQQ0pO/XdUUTPb2kWF6aSMzaLMkRGRTGiFJR+yrg83HE?=
 =?us-ascii?Q?cyJk4g3+dGeLFj1QdWlrnei8+RRfEgiAgSfkhHe4FxwATLUVBIbfMnf4jKhq?=
 =?us-ascii?Q?fMXGaOxcVFSI+G0UxSO1eorfQrivLTUatVPRXLvOeFJekvIccFqL/puskgkL?=
 =?us-ascii?Q?6G+4NenFV04UZ50wQczC+j0xrA0/0fah+EW0b3yObDQ4pdvPKMFyhe2C0Ro+?=
 =?us-ascii?Q?U6WVtN/+adHao/Gmttc5hMXJ+NiWz9e3BznYMZXIUlhZuMJdrRelDkjTo8kc?=
 =?us-ascii?Q?edYR5M1xitWfSUz41AIvBdUF3BdyAkUiIoR47J06fuCmtC8akc0TRs2osLWH?=
 =?us-ascii?Q?WmJqctmUHSlvIA+ia1u9IWPIBi2w8HQblvr5bRFMuDOeP0FuQkl2uaBgYQbV?=
 =?us-ascii?Q?294gwdpImkuFXZUORqYyj6xbHc+fXdLRJLGlKX7r0ROxF672/82qA6NaZDv7?=
 =?us-ascii?Q?u505/4nqTydgpM6RiZ72HyOts8ywv8ykvOWJWnnwxvmlx+t6Gr8GTMXytE+c?=
 =?us-ascii?Q?ByBKPASylzEPCAp6hUS/sE/jA+xgmBKj1gW6/VYzP4OCq9dHujn/06MHQJ49?=
 =?us-ascii?Q?Ag34bdGel3hupGg+9Jndn6kzGwO4md7J4U5YED8RAdljX2PGoJ6Mf4ceoT55?=
 =?us-ascii?Q?2hX9AM1itCQqDds3zTRJUGmVR4UszFkXw0Yb8hZ751HeLzaKJaDY9TEgea1M?=
 =?us-ascii?Q?r0OYtlJYpxod6nNrO3Azxb4r5f2Ld+inVeXfrJ1ncko5784Y4IznRt3XXbzx?=
 =?us-ascii?Q?dsewfbdL3Bt5ZWs4tmdNc2EZb4KHV7HZk1ezHkbG7ezE/2OUCV0jLPsXMjCQ?=
 =?us-ascii?Q?774roUcQ7itrgrmAioloTGBh1f3T6r1Bukd5RDq+GsnFw+siHJ1T0CK18WVv?=
 =?us-ascii?Q?6sDwXlc6B2f7o8FOflIFUdexDRbhfYeQWe2JV8omWtUMgTWNrulLNLfx+qI+?=
 =?us-ascii?Q?PmRAvRrGUx0NM1YXEeWLsOzArcx95u4FCd7iqOm+GCGyQV5GonB0EHnsSeqK?=
 =?us-ascii?Q?OobnoQZ51c9WMiArInNUKT3K2rAFxucYjr8TSiHBlaIjEGCErbLcYvMorLK6?=
 =?us-ascii?Q?oNvlwzpAqcAWBku7LR27ZzjzFXSvqOfiQ9W2n3akyqauyzmCzYrq7yI3ggzq?=
 =?us-ascii?Q?oD3XmQgFz1O2lpx42o0njNy25Vj7k0fX4EbbZl8jESMHFo2itJ8PimlnVaNO?=
 =?us-ascii?Q?Oga03Qkz5AS6FPoY0I240AnoDEGHSHEl+JZKJLB7bohwETOjwOR0v3pca3nm?=
 =?us-ascii?Q?dp5ud2ZcfdT2WybnngJM0w7D1jPcr/s8/YrvfGaynM9RxlAv04IygXryNkME?=
 =?us-ascii?Q?NjK9ArqQta3efDQcAf3IMQDxRz6GuxeL8PvJPTeupXiV4ez7P4TqaqAcII8G?=
 =?us-ascii?Q?MOjyK8mahw8N35B7XckaR3gtqRsKsRSZvaMmSrXaGyt7l4bafl6OUM6Xn20K?=
 =?us-ascii?Q?MsON+n1dZ8uEGZcv2ZZQwTLoRpLa4+jX6wjTSubYhVWSyo15WJ7HqdimVuMU?=
 =?us-ascii?Q?LchmmWq3RHzV11l54wkRLWfRDLxirxoPIG9nv0cy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d538024-43ed-4285-3f2d-08db9d9665c4
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 13:49:08.2822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n/xVHrmNNHwx8tEb5DCZmlxPowjSb0I3gHTr8TEOIs+R3QXZVeL9HpLUZ7jk8kIn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8177
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_0EC9C18B-0D3F-486C-A60A-FED27DD40C6D_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 14 Aug 2023, at 23:56, Huang, Ying wrote:

> Kefeng Wang <wangkefeng.wang@huawei.com> writes:
>
>> On 2023/8/4 10:42, Zi Yan wrote:
>>> On 3 Aug 2023, at 21:45, Kefeng Wang wrote:
>>>
>>>> On 2023/8/3 20:30, Matthew Wilcox wrote:
>>>>> On Thu, Aug 03, 2023 at 03:13:21PM +0800, Kefeng Wang wrote:
>>>>>>
>>>>>>
>>>>>> On 2023/8/2 20:21, Matthew Wilcox wrote:
>>>>>>> On Wed, Aug 02, 2023 at 05:53:43PM +0800, Kefeng Wang wrote:
>>>>>>>>     	err =3D -EACCES;
>>>>>>>> -	if (page_mapcount(page) > 1 && !migrate_all)
>>>>>>>> -		goto out_putpage;
>>>>>>>> +	if (folio_estimated_sharers(folio) > 1 && !migrate_all)
>>>>>>>> +		goto out_putfolio;
>>>>>>>
>>>>>>> I do not think this is the correct change.  Maybe leave this line=

>>>>>>> alone.
>>>>>>
>>>>>> Ok, I am aware of the discussion about this in other mail, will no=
t
>>>>>> change it(also the next two patch about this function), or wait th=
e
>>>>>> new work of David.
>>>>>>>
>>>>>>>> -	if (PageHuge(page)) {
>>>>>>>> -		if (PageHead(page)) {
>>>>>>>> -			isolated =3D isolate_hugetlb(page_folio(page), pagelist);
>>>>>>>> +	if (folio_test_hugetlb(folio)) {
>>>>>>>> +		if (folio_test_large(folio)) {
>>>>>>>
>>>>>>> This makes no sense when you read it.  All hugetlb folios are lar=
ge,
>>>>>>> by definition.  Think about what this code used to do, and what i=
t
>>>>>>> should be changed to.
>>>>>>
>>>>>> hugetlb folio is self large folio, will drop redundant check
>>>>>
>>>>> No, that's not the difference.  Keep thinking about it.  This is no=
t
>>>>> a mechanical translation!
>>>>
>>>>
>>>>    if (PageHuge(page))  // page must be a hugetlb page
>>>> 	if (PageHead(page)) // page must be a head page, not tail
>>>>               isolate_hugetlb() // isolate the hugetlb page if head
>>>>
>>>> After using folio,
>>>>
>>>>    if (folio_test_hugetlb(folio)) // only check folio is hugetlb or =
not
>>>>
>>>> I don't check the page is head or not, since the follow_page could
>>>> return a sub-page, so the check PageHead need be retained, right?
>>> Right. It will prevent the kernel from trying to isolate the same
>>> hugetlb page
>>> twice when two pages are in the same hugetlb folio. But looking at th=
e
>>> code, if you try to isolate an already-isolated hugetlb folio, isolat=
e_hugetlb()
>>> would return false, no error would show up. But it changes err value
>>> from -EACCES to -EBUSY and user will see a different page status than=
 before.
>>
>>
>> When check man[1], the current -EACCES is not right, -EBUSY is not
>> precise but more suitable for this scenario,
>>
>>  	-EACCES
>>               The page is mapped by multiple processes and can be move=
d
>>               only if MPOL_MF_MOVE_ALL is specified.
>>
>>        -EBUSY The page is currently busy and cannot be moved.  Try aga=
in
>>               later.  This occurs if a page is undergoing I/O or anoth=
er
>>               kernel subsystem is holding a reference to the page.
>> 	-ENOENT
>>               The page is not present.
>>
>>> I wonder why we do not have follow_folio() and returns -ENOENT error
>>> pointer
>>> when addr points to a non head page. It would make this patch more fo=
lio if
>>> follow_folio() can be used in place of follow_page(). One caveat is t=
hat
>>> user will see -ENOENT instead of -EACCES after this change.
>>>
>>
>> -ENOENT is ok, but maybe the man need to be updated too.
>>
>>
>> 	=

>> [1] https://man7.org/linux/man-pages/man2/move_pages.2.html
>>
>
> I don't think -ENOENT is appropriate.  IIUC, -ENOENT means no need to
> migrate.  Which isn't the case here apparently.

Are you referring to a comment or the man page? The man page says
-ENOENT means the page is not present. Or you think it also implies
there is no need to migrate? If yes, we probably need to update the man
page.


--
Best Regards,
Yan, Zi

--=_MailMate_0EC9C18B-0D3F-486C-A60A-FED27DD40C6D_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmTbglIPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUDIYP/3a4b8PzQJjFgyVU8iaAf/90DYBDr9hBR/5P
bVSYld85O1U3OgRFoEvwC+3rzvJKsBA8p9ZgTNr1Veuw9G13Dc0zCEGakdoFAp5f
X08QX1GXSToQCdnR4p0CdAFG33UOevV3nO+Yb1eUu96NPBg612E8ZRBJtI7Tue+P
vaFNNBq3cUcFU+PcNIazSyznrgouUCLz50yoXQIIx2EdH3XKx+OG8qy59FBk2RWH
0w+Se3qDJsAkS3eKVE4h3G1vlWelXrFdLbw5EEyZFc4thp5wjZjGhM7OwY2sHmIp
NfG9AcG6OQnWlNsBheSUEADG6T9e7/8L/t6YZakNnUTx8RycNAsshmcyTaS9eliU
AnX/ONMdys2AhEK1TEeWKi6LvGAsjRJCDaNT5et8CbWPtlkqRl0LC0VXbo6DZi34
9w9degPH2JDjuNK5Cwee03LNOjoI13atIOTWVFmCLBJC+tkkZ4n2BgMs7k3tVWvI
DaiXL9iusMYMNBrVmDy+tKdYFRrD1PlIU12spZH1V8kYYbited47L0x2ms1FxO7j
bqK5a81LVm6KOz5g8/YBxpLUbUlW8VNadjwyaEE+ega2raAAGqMqYdGVt28eo8xM
s3uieom8UhHo8liRts8Tg1iGHdaHjpv0H4ZE0yoXw49mEMhwkPar9EAFT0RFGbIZ
jVLslrPp
=cV7F
-----END PGP SIGNATURE-----

--=_MailMate_0EC9C18B-0D3F-486C-A60A-FED27DD40C6D_=--
