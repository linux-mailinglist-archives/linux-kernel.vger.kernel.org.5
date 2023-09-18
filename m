Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B037A50D7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 19:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjIRRVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 13:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbjIRRVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 13:21:07 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB5212A
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 10:20:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NSg7mfxeG6AUfMPKulutX4rQLo+ZEuOGaN6GdiGaBeJNa1Aj0NB7voMOJVjPmSYovdmixL+iLRnifQH/Irn0RjYHi3P1ESItn+uqgiAawVsPe56etF2U7enJQ2xJV+y49hWJJYmcsaLgdm/vu+irOewBefx4ZETnVqUWJr1Qg0QZoxac5d0eXu5N51mRaxTodvO1wNXMc3lNRTC5XHS9oGr9rP+RkXAzAWkQy9mhHg4vc6se7aHNcSkTMoa65BAl5tkUIrnFZprZNcASlxfsuAVS/Zuza3Rn6Cm8qMrouzmk8dS+0VQYBZOVIAhCfLT3521EXEJp1Ep+APOjW6tFlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bMBc0d7X9Urb0zjEANIbFGp9yv/53DOacvhjGi9qsQo=;
 b=Odd4KEG4iHFOEYMf9/uVfI71Dy/f71mt5poBrI9D8E+q/JJxkywF9/fPt9n1X7KDKjYdXraT8qwDZNKgfY60bFXHHqb2rDPhVWR7dTMGwV2BWr00n0onlTOqh4ZQTSDJxny7fRDaHPOE+VkCvNbaROPrlpbbHgQ0fGN3dg2byoCt0kV8q6C4FhKyVgFXjNEJhRh8yKVoiQUjPor1pkqj7mDLryBJ4cDbeJY70NuEsgyW8HxTV6+kGQy0wAUSN8KAhFhifnDjG40xhONZyIqIrdBQbZpdNdTY/3znh32/a/4p5CZFrLck+Fxsc44HtqRlmfzmol6FWU6YSlBsc+Mpfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bMBc0d7X9Urb0zjEANIbFGp9yv/53DOacvhjGi9qsQo=;
 b=FqtmMzY9n8eIT+AYW45+hebKTSLKmGmvnFun0fdtjPyEIq+LaZYj7F1K0MfS2V2KCr/kFCI7iwW7YfZaGVVi/8vY7iqiCdjtjof5uiL8Hhr+qnqDcsKl182KINtpXuyBIdtY5lsswpmLmyErAkxcFgYCUGyZETtrET8k/LBRntQRgchtwIsezjLUU3SQYiFDuQpNPrFueNoUhhBTcrb9jGi3ManjHIo8X7We1AEWB1IMe/8G4vJTCtYM7k0B92FQCShbQgwN5reoE/hA0OmdxiQcjSlpYI3k7F+TJVP+VoVsDw+syp25qolqqfd/5539nrv+7tRM8z03zzRhLMJDyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 CH0PR12MB5057.namprd12.prod.outlook.com (2603:10b6:610:e0::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.26; Mon, 18 Sep 2023 17:20:54 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013%7]) with mapi id 15.20.6792.020; Mon, 18 Sep 2023
 17:20:54 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "\"Matthew Wilcox (Oracle)\"" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        "\"Yin, Fengwei\"" <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rohan Puri <rohan.puri15@gmail.com>,
        Mcgrof Chamberlain <mcgrof@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [RFC PATCH 2/4] mm/compaction: optimize >0 order folio compaction
 with free page split.
Date:   Mon, 18 Sep 2023 13:20:50 -0400
X-Mailer: MailMate (1.14r5984)
Message-ID: <40CD5F50-FC29-46FB-A3E2-76C6D14D390E@nvidia.com>
In-Reply-To: <28f76c7c-4b84-5e08-2f27-07592d8078a2@linux.alibaba.com>
References: <20230912162815.440749-1-zi.yan@sent.com>
 <20230912162815.440749-3-zi.yan@sent.com>
 <28f76c7c-4b84-5e08-2f27-07592d8078a2@linux.alibaba.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_4D9D963B-37A8-44C2-8939-97A8E0BD5334_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR22CA0013.namprd22.prod.outlook.com
 (2603:10b6:208:238::18) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|CH0PR12MB5057:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b8c4701-e893-40c6-cfa3-08dbb86b9cfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wVabPPXFsFwdYLeaHnFVEeBHsPMYE0M+Md6766SdumatFdjAes/QNqqMPPmFQHXV5MlVgT7uvcFWu6iow5QNZOKEU6p3lpRz1KTPgOX3qiEgiVeLzuDhtUT3a7mog+WUXZ8AUj3sacT99R/HLZiNA8FLvAvOYOYotBt3Oc+Qdf+YgikilgBNyeK+TdA+tbP4GhMWClQjkXm3a4xuZOsgggTBaSH2RI6GCZTtDdTgIHeA7U3ISe3+sF1Ye62LUaubeXwjzIIE81tHHapQjAbrEUFE2v6BzuWRhtoFEp3XDzXhvpkh+mXq4fM/yIIUK5MSi25xcP4D+vcmua+3eb+xOSXtFH3nDd0NqtfyTqG69zCrs6r6nvpdSqfMt96YNAtQpik7aFvdAy9GkhwOi03ybaGfNzhBr6WQcBd7SDEz+EWfRNEZMJb+nzu5sW2vQgaCObp1nEdBieqtiw7TZqMm2kAr9NysIT2w+dh5WmkdRAzFzOHPmDzGhAvxK0MxdZtjE6TdxURrBFTAp6KqJIsY+tVqLFqL47RpZZ+tmoAirF8k0Zo56Ue7/nNP8rVCES+dqK8gFm6SZFdOMtXJltA2qxS9J/2efZ+WYPm+AhHGosVrNAjP9AKEc04i7V8EKbrR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39860400002)(376002)(396003)(366004)(1800799009)(186009)(451199024)(66476007)(8936002)(54906003)(66556008)(66946007)(6916009)(316002)(4326008)(8676002)(41300700001)(6506007)(6486002)(53546011)(6512007)(478600001)(6666004)(83380400001)(2616005)(107886003)(26005)(7416002)(86362001)(235185007)(2906002)(38100700002)(33656002)(5660300002)(36756003)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UbHeqitoDTD7PnJGyT1hZwL8R7wniytuuQt2XnvqQ2D5OCNfkwCkTB1Y5qG8?=
 =?us-ascii?Q?bi2X73xO52JEpYkKjdSWi+1upBVyRXNjq3EKYLVwwQ+eufqr+T9XxHOeCEzK?=
 =?us-ascii?Q?Iia361uAif5HFmBF/N+bWEMijo+xdaHnkKZqJUghxSG1ZH/gRuc6rvwOwqMG?=
 =?us-ascii?Q?UM2NiDryn6zLfxbwAdrPRD2IpctAclgkWJuAYgOMGwGWq2eVVvslIiuNMIKb?=
 =?us-ascii?Q?Djsfx/iZOn6jiZ4SVFlRAjgTsQM5hqfpmsp2Hjc9bETxQH0IU1pTVds7Hqj3?=
 =?us-ascii?Q?iS6MaAnqTYNgYpWEoWczdrfzPY0EHDPsXS7afRANB9Gn57R+fJjDtsJp+1i+?=
 =?us-ascii?Q?EVkMAbLjZwKlVTNLuh9UtknxeO8WdU3uNycPgtk8F10QnQ0mDrtHQ8XpKjPk?=
 =?us-ascii?Q?cX+aIYuych03YAOJrc/UveXqacsauBKQtbYxdcT6UrMFsKJE10BwwX/f23qG?=
 =?us-ascii?Q?0NI6HF+wu/5Nc6z82T+6AhVZJyuvQZ55b8Yy0g1MdmK55XWm5xtmsvYNdcbj?=
 =?us-ascii?Q?OpVSJHudtRY1rB647oNro/09Ry/ywm4rqyCd8qSCmcqrEBX70991Je5z7AY0?=
 =?us-ascii?Q?CSEriPBt3crEsqZOWFOGLer8jqCjFdlEnRrnWYu524dfJElDcYWdKR+xGLWY?=
 =?us-ascii?Q?SnDGjdbl8X5sGT+Fww+VMOFd4YMzE/pGm3g/bEu3usUxmWbs2BaSTy2y0VRJ?=
 =?us-ascii?Q?WyzyMP4Cs/RJcufwHyijcJHBigpH7DzLJaarRwZIsRuStLkBb/ywyahJXaJm?=
 =?us-ascii?Q?T3vk0fDyO9uxP9d/DLjtnSivzaM45GXdxhuZzlsSYLlJmEUjcdACSu7T8gYr?=
 =?us-ascii?Q?YumuzhNvRrV8N97x+WQiUEuQNrGRJe9M05f/jgpq30V4B8QXU6GHTTcR5VrP?=
 =?us-ascii?Q?OZtnOxbHtDkmqNwPu1yjGEul5BxsURX2Z825lT9XHt8F9vWP2WGjTAhng9uZ?=
 =?us-ascii?Q?S2ZMn0pdtUxcvf9J+jYXaK93eaDfY+/ljld+EG6iE/+sldk9lMFTRs3jP9jP?=
 =?us-ascii?Q?9kmX1Zoqx1papK7cK8ou/JA9cSe+vYiTScz7JNxhjGXi/bhztFUdEKEwiHdE?=
 =?us-ascii?Q?fKUuOOieVEA1qWcL00svBnTwa5HRYt61MQHpsMneQlCrqn7/RUXICS7T2Q22?=
 =?us-ascii?Q?jmbckXbiqf9CGxLiE/0VPvy94tRmECYC5ammeGEsD0nFJFHYRnpLO9AArZy+?=
 =?us-ascii?Q?SlP5FI+Ffv1JDs4Qv/CusZIOXqHALoZoBLb8LJ0Esg8Io1AHbunFdoVuxlkK?=
 =?us-ascii?Q?C8ImRA0POIXbXoIvdJAzSrYRrhukp2f64ET1wxTNP6/mOwvtOkZLk6eNnGCs?=
 =?us-ascii?Q?TBIWcUA+y1A7AfRtiaXilX3HzOe3ycLBbXUZWWu0ClFBrZtkatWxNxgjK469?=
 =?us-ascii?Q?WEizgw0/axkBIj9zdo7/MZq7OL3uZkx+NU2hAwHNaDwEAPySNUZX0kuw+rZJ?=
 =?us-ascii?Q?nEgR9fibiCQkhJfwRhTg0u4pm0quI+WtGoWAFNa1sn27nNWA5V7jPSnh9kfb?=
 =?us-ascii?Q?uLYMak4edMVudZv/EEwwAjchpzPPlqf0EQOX++Y4xYZasWZ1xBeRZfVTWeNW?=
 =?us-ascii?Q?MMQeVOlZA9ANt9PSXMM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b8c4701-e893-40c6-cfa3-08dbb86b9cfe
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 17:20:53.9371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DGS1Ayq2OJlYe2Z7aKqE4g9MoRXTtIWVswZQNoOawAbEzI3hLJ2yHmvwjVB4CZLp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5057
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_4D9D963B-37A8-44C2-8939-97A8E0BD5334_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 18 Sep 2023, at 3:34, Baolin Wang wrote:

> On 9/13/2023 12:28 AM, Zi Yan wrote:
>> From: Zi Yan <ziy@nvidia.com>
>>
>> During migration in a memory compaction, free pages are placed in an a=
rray
>> of page lists based on their order. But the desired free page order (i=
=2Ee.,
>> the order of a source page) might not be always present, thus leading =
to
>> migration failures. Split a high order free pages when source migratio=
n
>> page has a lower order to increase migration successful rate.
>>
>> Note: merging free pages when a migration fails and a lower order free=

>> page is returned via compaction_free() is possible, but there is too m=
uch
>> work. Since the free pages are not buddy pages, it is hard to identify=

>> these free pages using existing PFN-based page merging algorithm.
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
>>   mm/compaction.c | 40 +++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 39 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/compaction.c b/mm/compaction.c
>> index 868e92e55d27..45747ab5f380 100644
>> --- a/mm/compaction.c
>> +++ b/mm/compaction.c
>> @@ -1801,9 +1801,46 @@ static struct folio *compaction_alloc(struct fo=
lio *src, unsigned long data)
>>   	struct compact_control *cc =3D (struct compact_control *)data;
>>   	struct folio *dst;
>>   	int order =3D folio_order(src);
>> +	bool has_isolated_pages =3D false;
>>  +again:
>>   	if (!cc->freepages[order].nr_free) {
>> -		isolate_freepages(cc);
>> +		int i;
>> +
>> +		for (i =3D order + 1; i <=3D MAX_ORDER; i++) {
>> +			if (cc->freepages[i].nr_free) {
>> +				struct page *freepage =3D
>> +					list_first_entry(&cc->freepages[i].pages,
>> +							 struct page, lru);
>> +
>> +				int start_order =3D i;
>> +				unsigned long size =3D 1 << start_order;
>> +
>> +				list_del(&freepage->lru);
>> +				cc->freepages[i].nr_free--;
>> +
>> +				while (start_order > order) {
>> +					start_order--;
>> +					size >>=3D 1;
>> +
>> +					list_add(&freepage[size].lru,
>> +						&cc->freepages[start_order].pages);
>> +					cc->freepages[start_order].nr_free++;
>> +					set_page_private(&freepage[size], start_order);
>
> IIUC, these split pages should also call functions to initialize? e.g. =
prep_compound_page()?

Not at this place. It is done right below and above "done" label. When fr=
ee pages
are on cc->freepages, we want to keep them without being post_alloc_hook(=
) or
prep_compound_page() processed for a possible future split. A free page i=
s
only initialized when it is returned by compaction_alloc().

>
>> +				}
>> +				post_alloc_hook(freepage, order, __GFP_MOVABLE);
>> +				if (order)
>> +					prep_compound_page(freepage, order);
>> +				dst =3D page_folio(freepage);
>> +				goto done;
>> +			}
>> +		}
>> +		if (!has_isolated_pages) {
>> +			isolate_freepages(cc);
>> +			has_isolated_pages =3D true;
>> +			goto again;
>> +		}
>> +
>>   		if (!cc->freepages[order].nr_free)
>>   			return NULL;
>>   	}
>> @@ -1814,6 +1851,7 @@ static struct folio *compaction_alloc(struct fol=
io *src, unsigned long data)
>>   	post_alloc_hook(&dst->page, order, __GFP_MOVABLE);
>>   	if (order)
>>   		prep_compound_page(&dst->page, order);
>> +done:
>>   	cc->nr_freepages -=3D 1 << order;
>>   	return dst;
>>   }


--
Best Regards,
Yan, Zi

--=_MailMate_4D9D963B-37A8-44C2-8939-97A8E0BD5334_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmUIhvIPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUzIwP/iHts1iUGGZgxSAatzKKu50VLI3n4hRLo9bp
YJJK2WB3uaQFMyL/XeL+pZ2cCv94o+pCkS5KttBcP0B7dBY++RXIzEHhhqyYE/N7
cMVfQBG91YolYw7kX5/6NHK1Xfh3b6bgTX+0iPLm/JWuqTx6h44T6n330dBlseCJ
rhfxE31j1RloqQWJYvkKf/UTJVfujq/z99fsrc/z0bvw0sEaeMoZ5rKJ6wotC5s9
S3D3e+Zhht95VxYIE6bUAA+5f1BmqnQNTmdzGjc+F+HAQRevb6nWJ8iRw0l0NCo/
OkzC3aPXu6hPVIqdvjPiceydDe/dOEd+lK/lof+Hr65hW6BTHGmUSaZFknLvLOS9
VGrFJJgPixp3QPoLmhnWLZyZGorCSRfzEF2BgP+mMOoTgrBWhSMZNH93uFNSp/JS
avA6li7Ga6Fi6p/F8zbN0hgP0XiWafKjMuLfx563FdKdPLG+w8SUtgxubCI+vik4
svEbzPpHk5E5JxECTXaNWzah/A91t5YbXRsWmYyfWNCkMyf1CHtm0aA14TBSPGD0
eovS3yOs++M+gHi8hYMuTrlpzKxwANQquYEJklEs1dXsnBJaDmU8B/gJLnyOwkSU
9Qh813/nDkXR57Prsdj3tuMtGhZdwnQ4BTYsBYNSDDAbyX+pQHeiZe8QVY/YIBPX
QBf8coJG
=PMRN
-----END PGP SIGNATURE-----

--=_MailMate_4D9D963B-37A8-44C2-8939-97A8E0BD5334_=--
