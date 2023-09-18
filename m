Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A057A50CE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 19:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbjIRRSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 13:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjIRRSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 13:18:04 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4707DDB
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 10:17:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PuV+3fT/XG1jGcb3Cd2bDc6vyAbxT618bQUvoLbqyr10tHapFtErx0cFyV2OBmC9Eq1UlOZdfiAUocooTv5ha+4eihzlchMY4e34d/BBrozUpI8Mj7+iRQehuhJJwRlT4gEmemdspCtQdJt2YI4Izf4pMIfGSUiwFTjLvMvsb35DG9JXwbVmdvB57xt3kqNi9Q+i9v9rM2P5HKsEv7BCiD7tnCADQVOMpwQYoeZNWc5ZQ6cfwxKWkQY2aJ2WoNbbht/SNHlL6sv6fs0MO65mn+833u7xxWuHVE+CaHt9vrj4SO7E2Vng6v01StUvarHAyBoF1GwyrjQOzDVRyrJjuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AWsZBtLO6h8nNhggurK4oZkii5DiHYSCbRp42/V8dQQ=;
 b=T1bFVO0+frYDcJilbYX7UM1EmTVpUAOAn48B/+s3LiDfDIK48oIFefNubPMIkJuQJjVuMuOWOsj/ftRqvJDGPAqBrf6OSa1OfzcoGbWS/vjzCh+sW6V5lKmlDUDZy3Zzbk3rs9v6WMssDKYGwDvsoZ5IHF2B7DnMQDVT2TjQ+YXObpUryU+bSINcg1T2SS8RWKb+3fc7KsDeplODgjaBl/tPfcN4FQvIQRzysiWWRIXLuFnAJlzLbJeeVi+0XAYMmKF9jis+4VhWCNbm4w9aCe1zvr0XrYa7G8yI41N/o/Zs3WnI8+cICnvWxwOYkhe1VodeC8SH2vgI5mfSUNegNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AWsZBtLO6h8nNhggurK4oZkii5DiHYSCbRp42/V8dQQ=;
 b=FCktYorMo1dinhdKWwUt0OsXCGGPthf3VhpokZMrVQ0wvQJyN1RcpiTRzjl3NpRtbepdMGxq32ru1BNSIpIQMKd9DKUYJd22E9ZwuWSZLMV6QmyxPRr5y+xPhgwvXE2PQfGTvRcRbpDK4yqM1J4wAnJ+94TDYTsQmpC3QXgtgCkTHr1tnPkhUkdaciP1kIjIfDqp20UWWzRbwNz3STxnAxpDMYa5EH1PYeySqD3fzD00cvIljwTnCiwa8XdZuTK4Ameurlgq+AyD0kb/+L7W5g1iLDqVkPsIbGzuoCQRohOSefinuzVOvhxB4Xbm20CHbEy2E9rE4JYQJraDXEx4tQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 CY5PR12MB6228.namprd12.prod.outlook.com (2603:10b6:930:20::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.27; Mon, 18 Sep 2023 17:17:56 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013%7]) with mapi id 15.20.6792.020; Mon, 18 Sep 2023
 17:17:56 +0000
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
Subject: Re: [RFC PATCH 4/4] mm/compaction: enable compacting >0 order folios.
Date:   Mon, 18 Sep 2023 13:17:52 -0400
X-Mailer: MailMate (1.14r5984)
Message-ID: <31320BED-0B77-4962-B155-AA09FA3D1E95@nvidia.com>
In-Reply-To: <d9a0d268-3547-a976-d88e-4120dd36f4de@linux.alibaba.com>
References: <20230912162815.440749-1-zi.yan@sent.com>
 <20230912162815.440749-5-zi.yan@sent.com>
 <d9a0d268-3547-a976-d88e-4120dd36f4de@linux.alibaba.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_DA6783EB-83AD-4FA1-A3A2-A403DFC46416_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL0PR05CA0008.namprd05.prod.outlook.com
 (2603:10b6:208:91::18) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|CY5PR12MB6228:EE_
X-MS-Office365-Filtering-Correlation-Id: c88c0b60-0b90-465d-674c-08dbb86b3316
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +lI5uZz6DCMeXYXFj6dKf2/cYHnOYJUkBms4AiiQ4ksYFkCFRGGzg2d832Jpzybao8JUM2mcQEh1abNzHZLsU5igoc4HpstAaiDFzLhRlpeIDPg4x4o23DLE6LXVQts74y+l0K86+EipiU+rVhJVpH/P5Mt8havMt8rofpxEAxuBF5ANPpONuoP2ZzBb2JyryocGRKY4eTBn7xLWo31gh760HZg1a24vx22DqiXG7yQEkZ1kTyP+q0hIvHlwJ+cy9u4PkFmwFaAVI+wdaZfb3QRxw71+t7mpDo8PR88LH3Cr7Py8fB9XutMFC3GSbPhr3zunmgwduaSdiFna5cdSEvEprYTwjsqyJgnTcGjopRp+1odtzNBiR053xuHFGpuXU/gK2Agq3ehouLizYu+zPdloslP3k893JU1/zVqlYQj0F1ACcB5iTcS7oTOuu2GQEG/iAPZ+gJ4Vt2EstcviBS75pN85DLItNQwx8Uf5ibLXvjyrjk8Yr21PpwTgCvLujNrdwcwCrnc0TWs2WhqlWrmwx0pQJaI1FPiOQnhh4knjdLL7BlSopxK1Qnx32vScJ8Njg7sDZlM5TH59lXEbb76i4gZT5mi/ZP2mes3ZVUPVUvsUohSesuBxzFtHLPci
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(396003)(136003)(366004)(1800799009)(186009)(451199024)(53546011)(6506007)(6486002)(6666004)(6512007)(478600001)(83380400001)(26005)(107886003)(2616005)(2906002)(7416002)(235185007)(66556008)(66476007)(316002)(54906003)(66946007)(6916009)(4326008)(5660300002)(8676002)(8936002)(41300700001)(33656002)(36756003)(38100700002)(86362001)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PEt5Ss4BWOyR8k0/wn6ucHbNgO3sla8hHgGLvTahjpsVrjZeHOFQuKHnwj0C?=
 =?us-ascii?Q?RSIPWvY28kMvHQTaqfqlnNw0GU1WW/nupyxfUG+SWvkCez9nwdHomsJB4pTq?=
 =?us-ascii?Q?72jy+FexO3zVCeE52xpK/sIte9w5wsmf2rcpdvrtLKVVd5VN0XdSwztAv14B?=
 =?us-ascii?Q?mepaRMyfLL3oOuUXkdDcoTYPrGuA9a9RGhGMYmAF3PM70MzsZ8KB9oXt0zky?=
 =?us-ascii?Q?EZUS7T1HKl63ZzoschblZ/Y/fnLvnG6QmWKMR+/hQZChDpkEdWkWmadEiSnZ?=
 =?us-ascii?Q?PCGZqOEfA4Fw/tAWGaVeEUaBl0YS7Rxlydpxf8GjUQu99iss3Ek9cy1bK3NQ?=
 =?us-ascii?Q?agVZ9YQhNCfZfZ6tbA3ukW8y0YhE5X4lExgE3RJIjW4S0rg/VjAVAj7Dqx3L?=
 =?us-ascii?Q?AUCE0WilZM5Qv33M7NW77TLo+Kan0EhWWl+ltOBrrla99V8qA2dZLKSIRVUd?=
 =?us-ascii?Q?YKYJw/9lMAYGTzs/o8Q/z/iE9y8ImXr4Km7CjfTyICpf8giS+vCql0GrWgSH?=
 =?us-ascii?Q?z3xI4jIYL3i3pdxjcmLzWYa8XtgE5udwx1JNYkFrbOBt/NHWaeZAsxwH4z5s?=
 =?us-ascii?Q?XNvIaM+4+g/1j3y7F+WYI/dqM9EIqVyxvYbeMB7/2QfC73QmIzF03uvJqA0Z?=
 =?us-ascii?Q?+JgDT/DQ9AfYSK3h9aAAuI23wkQUfwOgYIpycxdZC9zk5BuwpRL+Dd46DUMw?=
 =?us-ascii?Q?9p+axWM984Jr1YlwE2iFxhxDluu70CGXVsLJtone2C0u1Jhg0zaaXcFrs2se?=
 =?us-ascii?Q?ypiCt2IrC0XleOgugPnIlPrEZhiZgncrAKKQU1X4tPHNzdl6H4v/utaXxLb+?=
 =?us-ascii?Q?S90xkgRXyy0oMIX2iJvSyZW5wUVzKJZH/po/3bCM0dAcF1rLGRjehNoSBTXJ?=
 =?us-ascii?Q?bWNN8uziuGFhhp4WjEs6K6ahSpPgntEZ7S/09s5bwDF2qlRZitv9feq9FGuS?=
 =?us-ascii?Q?+N0fbMO1uMU5MSZh7B4kYgULQQKMK/sefG+G8XyCTO1wf/wr/ki+9IbYmJJe?=
 =?us-ascii?Q?B0oo9RCZnqwtRZeyAHPdVzQVaYVUMWkV0hZBDbQVWGLV144KjjWO3QLphiAn?=
 =?us-ascii?Q?aG0cY7+jCIB7DW4+wT2PDx0LKD+06gxs1lSnoRDEK410jSuh0IQktmy/cauV?=
 =?us-ascii?Q?M5XqTk2lrSnkGQ7kkakm7rq1b5DopmOxCpRuo0nvRufEaW1tkEouhbbBkuxk?=
 =?us-ascii?Q?tNeOJO/YWyGMAmrU6Yu/wxEZKIIrmfEMrckDhXoIW/fp58Da2TPUPxGqm0mC?=
 =?us-ascii?Q?qknnCjh24tDfZZkvVHdVyzv4IYfoFQOe3a3dEt768T4+TtV7QAaLmQS6+pR2?=
 =?us-ascii?Q?leDBh+jdLlbsNC1j2d37Xby3TgYvdpm9pyODphKU4QwhcT0CUgrxLwrXPdUW?=
 =?us-ascii?Q?BH7+7Oymylsbz3U8j2JupjSU2Sh1Qc7LexI+eVf0S8feOGzEDgTELwYyjIWJ?=
 =?us-ascii?Q?lBSm4+HQgzz5Uv5fvcAzTEwnkKmEh2zD4u5m4VlqpqPSqbAsGsvGUhYbFxNW?=
 =?us-ascii?Q?vBKWUS8iGQoL7L0h2BCJN4OBsYIX7xcvYie65+VdwKSTVngTbQL7TFDHN/3M?=
 =?us-ascii?Q?6xau053IhMazsa4BVs8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c88c0b60-0b90-465d-674c-08dbb86b3316
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 17:17:56.2858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: de8IUNZaGdlE9jpSbJXAMP6ODZGY92ZrQothNEICiboWDn3AIc2Yd/D3WyJ/IFY+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6228
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_DA6783EB-83AD-4FA1-A3A2-A403DFC46416_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 15 Sep 2023, at 5:41, Baolin Wang wrote:

> On 9/13/2023 12:28 AM, Zi Yan wrote:
>> From: Zi Yan <ziy@nvidia.com>
>>
>> Since compaction code can compact >0 order folios, enable it during th=
e
>> process.
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
>>   mm/compaction.c | 25 ++++++++++---------------
>>   1 file changed, 10 insertions(+), 15 deletions(-)
>>
>> diff --git a/mm/compaction.c b/mm/compaction.c
>> index 4300d877b824..f72af74094de 100644
>> --- a/mm/compaction.c
>> +++ b/mm/compaction.c
>> @@ -1087,11 +1087,17 @@ isolate_migratepages_block(struct compact_cont=
rol *cc, unsigned long low_pfn,
>>   		if (PageCompound(page) && !cc->alloc_contig) {
>>   			const unsigned int order =3D compound_order(page);
>>  -			if (likely(order <=3D MAX_ORDER)) {
>> -				low_pfn +=3D (1UL << order) - 1;
>> -				nr_scanned +=3D (1UL << order) - 1;
>> +			/*
>> +			 * Compacting > pageblock_order pages does not improve
>> +			 * memory fragmentation. Also skip hugetlbfs pages.
>> +			 */
>> +			if (likely(order >=3D pageblock_order) || PageHuge(page)) {
>
> IMO, if the compound page order is larger than the requested cc->order,=
 we should also fail the isolation, cause it also does not improve fragme=
ntation, right?
>

Probably yes. I think the reasoning should be since compaction is asking =
for cc->order,
we should not compacting folios with orders larger than or equal to that,=
 since
cc->order tells us the max free page order is smaller than it, otherwise =
the
allocation would happen already. I will add this condition in the next ve=
rsion.

>> +				if (order <=3D MAX_ORDER) {
>> +					low_pfn +=3D (1UL << order) - 1;
>> +					nr_scanned +=3D (1UL << order) - 1;
>> +				}
>> +				goto isolate_fail;
>>   			}
>> -			goto isolate_fail;
>>   		}
>>    		/*
>> @@ -1214,17 +1220,6 @@ isolate_migratepages_block(struct compact_contr=
ol *cc, unsigned long low_pfn,
>>   					goto isolate_abort;
>>   				}
>>   			}
>> -
>> -			/*
>> -			 * folio become large since the non-locked check,
>> -			 * and it's on LRU.
>> -			 */
>> -			if (unlikely(folio_test_large(folio) && !cc->alloc_contig))  > -		=
		low_pfn +=3D folio_nr_pages(folio) - 1;
>> -				nr_scanned +=3D folio_nr_pages(folio) - 1;
>> -				folio_set_lru(folio);
>> -				goto isolate_fail_put;
>> -			}
>
> I do not think you can remove this validation, since previous validatio=
n is lockless. So under the lock, we need re-check if the compound page o=
rder is larger than pageblock_order or cc->order, that need fail to isola=
te.

This check should go away, but a new order check for large folios should =
be
added. Will add it. Thanks.

--
Best Regards,
Yan, Zi

--=_MailMate_DA6783EB-83AD-4FA1-A3A2-A403DFC46416_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmUIhkAPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUv20P/iGUaI0Chn3mfJNu0hlrkPX59Ld+0pDWG5bN
ZrNFi05Q426Z/QcBAMRFPCu+WMIlQlMOXRZUm07dGPqx9OQE2Qt6My4VtFTLsgae
4pCtpISi5nHde2IzmKwO2PV79UZaMSY7SHd5KI8FcA9fhQZSzSz0/WSSwcl68rgQ
XeaATdhBmLb8kRqD9hGjtoa++KojCDllocij3FZl7SZB+QtMMxFvq108IB3eEzHo
k0MLbcYqzZqntNko7f6cErG+GXSTxdokf7KUqtcLG6DFErDM7wrvd9oEBwwMCb/3
OeoPTH/lBPMOl072CjQ/goDD+ixSr26q3zSEWi4suj3YqwUmuM+T8FT1NlWEBaSd
SJSw2JroiEZ2SOfDMHgqet04xEurV61kS9h79iFVaMn5WYorG8xD12CoOWNZEWs2
ui+n5cLpIEGWWUlAdVOXhvwbP58pOoRMRPWE79uXGs4ReOjkXlJHjM2XkDWybpGh
Mef4ScZYuHI5Wdxet0qpFr3HEPvmHKPB+7Fb+EqUe2TdzeNwbz9q2PTKZptVgZe1
CPSuLJmUWenNjqB8RfcwRcWfSA2YnK+hYNNHdcG1FFx8Xk9QpR3dHBBGfaBgvqAl
mq5B+qLczhPItSdOkY9nZPRlCjdlDJtwsjwqfEbrrBZIAuFrHMHfQyJ833rZTS9d
dBLw8hFC
=n+KH
-----END PGP SIGNATURE-----

--=_MailMate_DA6783EB-83AD-4FA1-A3A2-A403DFC46416_=--
