Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D6F75685C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 17:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbjGQPxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 11:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjGQPxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 11:53:46 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C9619A
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 08:53:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W+LctvUOA1yf1PrbpirpKE9X423JC/yOcXNcM5++LsoMzH1b2H0Ua2L1vGUqkzjJG1mUUT/DgCsQQRw9uk2M08iO+SM/Y9rH3BOkIjSlo0bOZjKHwCQw7Gs6f0ze5Ms59KR2rhpPaDSEdSVmjuV/9opoWZGkW3q7dhFhxbWVmZGpHvQQAx5YZrAfTVCuSm+uLEniGjBKyWRIMqpm2oTm8ePKCg5aUACXEd7GpBG4Af86xCDdITS0Zs9ShSt+QWbCCyB78uh7WLsQjg9LnFDJPbhYdCy3NvlCzIL7ceZy+yQ6b+b39t4gSoeW6PwJQGsAdo1MzAH8iwyDkPsU36xizw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UxEKUziuon+PTtLydmEJMo0YVSJzVqoaQdDLnDOT1YQ=;
 b=oFs7cCgmcnM02qbBN9vcL/z4ntHFYfQAMktTo+XfgNFzUkE3CD3fji/H0Vh6HII5qh9DPHQ/6zYpeFK9LlCno/PzO5rjBb9EaNfS/lje2yHPaT35XrDk5SBTAcHr380NjR02vJVRJWXUqoli/SijtH9d2SRroJGWQZG9aol0/zdbsrCNuPfG6Qfpo9TuiQ7fnIMTUaJQ1G72UZiu5re/lhY4fVyyfc4eY9uEgXF5J3gPruUCFZVIn3DDTnG+1W+c1x2VDn7OWFP0HA8H8+TnHatxpZinGe6vXc3nAFXS2jT5J4Eg8/oJSPWOK+ZBRsiU80maVui38rF3Qc8jVdcMsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UxEKUziuon+PTtLydmEJMo0YVSJzVqoaQdDLnDOT1YQ=;
 b=MLSnvZdak3kLE/AhwsCCDy7nGbUbQjdvcF9XlF2oOkSPW9CZdSmLsyXn1TIQXD4y10Y2Qk+wxQhDTfM3kSRC04cvJowl3O81ClUtuFcBEKNVW5FB7uF+LXWoZV8rNqrsS4RYn7UvSjEfZLt4/6VPlzZTbR824FPaDpc/AaD33YVKe5PnorULgw+efmHubTMPJh5S5cyUpaQQGV6n0vPXVb8kSdKPBXDIL9za5BhppUr5qGlDtQF7YaIGzPUa5tfzNv5dKZ0TrXJmmpKCsNZn9A9FOGp68LRy7COC0dmICUJ9wzDy9Wrtw6DgFL8LLZaWQI3oUn8MTz1hQrnsqpAMgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 CH0PR12MB8485.namprd12.prod.outlook.com (2603:10b6:610:193::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 15:53:43 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::12b7:fbc0:80e1:4b8b]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::12b7:fbc0:80e1:4b8b%3]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 15:53:43 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v1 2/3] mm: Implement folio_remove_rmap_range()
Date:   Mon, 17 Jul 2023 11:53:40 -0400
X-Mailer: MailMate (1.14r5964)
Message-ID: <7C2DD864-8779-45B5-ADBA-DB49DDF503DB@nvidia.com>
In-Reply-To: <a3422139-8353-5fce-8cae-f17801cd76f2@arm.com>
References: <20230717143110.260162-1-ryan.roberts@arm.com>
 <20230717143110.260162-3-ryan.roberts@arm.com>
 <B4A5CF00-73E3-4AAA-9D39-1E7ABCCCFB06@nvidia.com>
 <a3422139-8353-5fce-8cae-f17801cd76f2@arm.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_DFFA6698-2D28-4905-AB04-0180CD33656B_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL0PR02CA0033.namprd02.prod.outlook.com
 (2603:10b6:207:3c::46) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|CH0PR12MB8485:EE_
X-MS-Office365-Filtering-Correlation-Id: 8036a33a-0d0e-49aa-2752-08db86ddfee5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B5mMCDxAX/V0AL+pqhUWTuy96EJnEKSRRU1nDXpC90Ki5Zbo2/J3KUyGOxiMReUGaDJKaqaZcTVb0VGukwNozhGiQoSK1D9YKUo9od2m3mWM3anW9V2heuXdWoJdfWbRrAWHmqXLKVIQ9Xp4OSDaNXgOiXnL6IYX/a9gQVwm+N/JoXv3vXBUe3WtnIx30lwphWqPNEV8M1Me+Czfh9kMbSeOQtBl3JhvbXb9mHBSFHXWxGeRaBjzQOZb/r1s5h7C+JVxj8L+9eE6E4OV51KBhzkBmhGmCCzwn0zrOawxmDqHjiI4cVr0ShlVMxM9TcsoVM1aWHfWEI5fAtPSJzyhChpWZEg1SPO7iEHNbI0/XU6Y5GKs3gpArnNegLuqInr5GK7iNBHg1XOLFeJv2+cWOOwyQEoGOXwNfv/EHFD9nyg4aGX1Yz2qIgi5fuB8Ed00ayTobdGfvNSoTn+YdJ3z6n59S/TBlJmMgrAdmyN8rUpaEXWUCkG/aWPvMn/UTM0V2K0mrPaUPsR/OpOi4mJNcJyZ5dBNgoDGPPLiXm1bpUFEC4nPUo7gP6r2EMWxyd9OhkPVBXl85ubRSwtDidxmqskYBOH3BFU9LMtaTbeOi8rXIYTKTTF47VGwMoB12yGsqWwzIYEOQWVL//yyvyPkVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(396003)(376002)(39860400002)(346002)(451199021)(8676002)(41300700001)(7416002)(66476007)(66946007)(6916009)(2906002)(66556008)(8936002)(6486002)(54906003)(86362001)(4326008)(316002)(235185007)(2616005)(36756003)(5660300002)(6512007)(38100700002)(6506007)(83380400001)(186003)(26005)(33656002)(53546011)(478600001)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xGxRhk6QoYuJkcMRWuo6t3NLVGIbG5ZdKMuRRYbb10tVNtMpeeTUynQbVhC2?=
 =?us-ascii?Q?nQZnOeUOOVWvs5MZ/AzaZ63BUKkPD3xhdpuRWc3bWOGotp7i/kyPNLHeXj1Y?=
 =?us-ascii?Q?z0tC2FJqyqgunrDFnEjqBygmExnY5TmHil1bZaIQvr1ImWjL9qyyjq3XnutQ?=
 =?us-ascii?Q?e4fW82FRNzu64ICeKeSile5Z8hs11Ilbv9R/b16vKNuV74vGqI54bTWTdqlq?=
 =?us-ascii?Q?h/0FkENyMKlarnc7vUkHV8VvhXLfKgaGFZqWc+e+YLH5zUNaeLoW302hLJl4?=
 =?us-ascii?Q?EuQmOOBG3OBlkitkjulXoP2RJfUL7vBA8mRuoiZdf55NwYp1P4jp38D8TtaK?=
 =?us-ascii?Q?RfraUSxLhPD9+1XP/pt9LFTWxzrP8JMIyQi72FFqwWcBN60KjVdFSCVTyhtg?=
 =?us-ascii?Q?v+VZb9Bbg9MxWDUScbF7MB+3QQ5LHgU4qmPXQe+d/GgEt5qr7DCpQAQL+hDj?=
 =?us-ascii?Q?4MLS3n7pzjqgpSQLWDe6L7US75oYVDJ51kqD9xN4X9Pn6kmTgGqNrCTCIY8q?=
 =?us-ascii?Q?p9zXZ/QmXKp5FErnj1QPPJhGx0ASQWjLGGFwX+S/dwzma1S6BNblMJ7FKDAE?=
 =?us-ascii?Q?CYXTVqdiKYW1bc+1BlNoz2TcJl5JV5rXrl/9nuZ1KFmUi3ZXYHnXKsyOk3qk?=
 =?us-ascii?Q?fbGpLqH++IRbudBXjn0lFe++fzJXSnWpDZyLxdM6CtcXbyx1vA9sa+E0Ck+H?=
 =?us-ascii?Q?TASrGQ2yhjVgNBhThFh5UfVh7kFohfMSofXebHdyiFHc+1Z4qaeSD9doBSbQ?=
 =?us-ascii?Q?HVSG7MDhO3o5y15oIU18kzylrfuMI+OGsyKkMaIMejDolcHVpwXDfvoFtGxs?=
 =?us-ascii?Q?KfUL6O2KgreyCDViBAFB9Lky7l+NXV7i6j1mXjU/sPh/UE1WHWqvvKZ+9edU?=
 =?us-ascii?Q?Al5jNbZHo+zVook0wE84DGGBrZAbfqTdNx6a65xaO+6daHhn2fYFss7SILPy?=
 =?us-ascii?Q?i3WxmxoP9OS0zabKt2sX4efcwSUraqCQvz3CqvnR/85a1yM7OVZwbWb6ULF8?=
 =?us-ascii?Q?xwpEZ6jNtFxT4SWoJ4Wg58HlvnAoyW9MWPWegQS69VP+EPW+yLtGyl+X/7WP?=
 =?us-ascii?Q?tjo6qQSSncyf/YvMR3y9FcupMPokNOInbpq7mpSMilTBl1gZ9FbbCob6TqvS?=
 =?us-ascii?Q?3qAyvfOILaqT84V2O758I5eIVGyFcDEGmUu7Rc9o9iB9ZIeEUFDnWFkFDHxR?=
 =?us-ascii?Q?ckcc8KdIG6nyQ5aY21QRHD/wxOMjFYujbg68MR8VZJu+x2RHiwUFsHNSKevl?=
 =?us-ascii?Q?2e506KnPFcOGCl3QvSTJDtAhF4knMsV36+A4s6SeIxtEbrHF9//i6mHxDze8?=
 =?us-ascii?Q?ZzK8MSJRSYGKLXOqauxwmDx7Sx/d+FD33ILqNc4E/ZyE3vvoq3heNagpkZ0m?=
 =?us-ascii?Q?KYC57O+z3aoI56TIBgbfzkMlqKM2v9JXUS6pw54n20Sjo6rzPuvxYix0iX/g?=
 =?us-ascii?Q?5LwZRKrZ48TeQiAaFz7uUxT1mdiB5Ty7HIp7fYTZCdG/kBuVscU4KULEv/pl?=
 =?us-ascii?Q?huyVSkSVjJBozuGkUpXS9ErIUhJz4keVqim0hX5qHLnb8Ax5sYZ7pla1EMdq?=
 =?us-ascii?Q?QVPWKN/OJKr/8R0Gkly1w4/gOS73iu3oEY8SKwja?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8036a33a-0d0e-49aa-2752-08db86ddfee5
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 15:53:42.8462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZJhEf+KyQapaDo5LwfdBilP0TybyXrjqTsy9mYaQbBgTqmbXvHkJMUZd7W2rd06y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8485
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_DFFA6698-2D28-4905-AB04-0180CD33656B_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 17 Jul 2023, at 11:51, Ryan Roberts wrote:

> On 17/07/2023 16:09, Zi Yan wrote:
>> On 17 Jul 2023, at 10:31, Ryan Roberts wrote:
>>
>>> Like page_remove_rmap() but batch-removes the rmap for a range of pag=
es
>>> belonging to a folio. This can provide a small speedup due to less
>>> manipuation of the various counters. But more crucially, if removing =
the
>>> rmap for all pages of a folio in a batch, there is no need to
>>> (spuriously) add it to the deferred split list, which saves significa=
nt
>>> cost when there is contention for the split queue lock.
>>>
>>> All contained pages are accounted using the order-0 folio (or base pa=
ge)
>>> scheme.
>>>
>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>> ---
>>>  include/linux/rmap.h |  2 ++
>>>  mm/rmap.c            | 65 ++++++++++++++++++++++++++++++++++++++++++=
++
>>>  2 files changed, 67 insertions(+)
>>>
>>> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
>>> index b87d01660412..f578975c12c0 100644
>>> --- a/include/linux/rmap.h
>>> +++ b/include/linux/rmap.h
>>> @@ -200,6 +200,8 @@ void page_add_file_rmap(struct page *, struct vm_=
area_struct *,
>>>  		bool compound);
>>>  void page_remove_rmap(struct page *, struct vm_area_struct *,
>>>  		bool compound);
>>> +void folio_remove_rmap_range(struct folio *folio, struct page *page,=

>>> +		int nr, struct vm_area_struct *vma);
>>>
>>>  void hugepage_add_anon_rmap(struct page *, struct vm_area_struct *,
>>>  		unsigned long address, rmap_t flags);
>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>> index 2baf57d65c23..1da05aca2bb1 100644
>>> --- a/mm/rmap.c
>>> +++ b/mm/rmap.c
>>> @@ -1359,6 +1359,71 @@ void page_add_file_rmap(struct page *page, str=
uct vm_area_struct *vma,
>>>  	mlock_vma_folio(folio, vma, compound);
>>>  }
>>>
>>> +/*
>>> + * folio_remove_rmap_range - take down pte mappings from a range of =
pages
>>> + * belonging to a folio. All pages are accounted as small pages.
>>> + * @folio:	folio that all pages belong to
>>> + * @page:       first page in range to remove mapping from
>>> + * @nr:		number of pages in range to remove mapping from
>>
>> We might need some checks to make sure [page, page+nr] is in the range=
 of
>> the folio. Something like:
>>
>> page >=3D &folio->page && page + nr < (&folio->page + folio_nr_pages(f=
olio))
>
> No problem. Is a VM_WARN_ON() appropriate for something like this?

VM_WARN_ON_ONCE() might be better.

--
Best Regards,
Yan, Zi

--=_MailMate_DFFA6698-2D28-4905-AB04-0180CD33656B_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmS1ZAQPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUn2cP/jNZTbNhDRMx9fO+1v2pV2Inqdud/Y45Lgkc
Y6iEsU2XUKqg/bcQbHdHf8iFdFOgFtGEvh6jlx8EM1U7RzhVxtVNwIQHMBC5DKx3
njM8qmlvc9QxFwIRFDRRg7uL4nDuNUm7Vh2Nikso9qdNVdf3MML3gDmiodpjKvsB
0mU97LBnfOPt9KqQMNKrmYHlO4wLU6iTZrq8NR1ao7uORRimrRXQqzZoSmbMFchj
HAKx+fxp+u1oVUz+SP2kWLzSzWWVHIEW9+jY0n2k6KM1s4ttKrCXjZ7OUMzQ/GmY
4HD7zmV6Dyx1FfXUsKIlRtir+84T7t4UKD4L4hO6eMPyrJocwNhWYZ0UirgXBXXx
1mE1f5h893UFX6T04ymMw4GpVbkdf8vBrYyCEAGv7fzh9BPmWyaSOGB3Ojv8MVvz
BEgSqxjQ0mHupviezj4C8hiE4ejdjVU+i+KXZcoonqp3ppLBGdnLKmAoU26+8lJi
KEHoi++grbzWGzLUV9e4fe0hjzVVptLLCr9qzFYXotU25aNHfyloTxWJ9ERyXkmA
ade8SFR3/VLb83jL7fYLB+Sxs5C/5w5EC/pA02VRfvVG/1xafGNdL+25HuAD2BtB
C8/QffEbs7aat7I5nlqU57Ylh3bwZOnH80TLuiRLnPzfZNTCxvvuaY9WpIFV+pfE
5HtOg5JJ
=mG1i
-----END PGP SIGNATURE-----

--=_MailMate_DFFA6698-2D28-4905-AB04-0180CD33656B_=--
