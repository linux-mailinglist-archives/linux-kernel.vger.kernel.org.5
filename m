Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B96157C00CF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 17:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbjJJPxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 11:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232441AbjJJPxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 11:53:13 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA94A7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 08:53:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CwLciAhgdZyfCgxE5Fqnf82G6alysP/pAzuxLiAbi9Slzu54wBbagqCEsKajn89V0ih9YgxHlLq0FLtgmYPfmdTRcIi3Rfol3sVmx170GDfDpR8XdbRFvQXO4G8QeKUhbEi0nFyPEYmx4tIMDjfdAf9QCYBORBJ7OdR9NlIY2M9ORp+ICfWMhZsEbZABbyB4STxD00//9evA8JbB8UVvbUZGY4+tLEh0Hj3ZufZ+5Ve/IGf/Pxcjl7zcSJh5Bi7OtPdjLI8WWMc18//Xn6OmnxKa3MvC7yJcszC+mEXtTac6pD9EBZ3x8tQmLpCXDQAXDexKO3nFh0GcJibCDwJpvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XRbgofZn0mb4sqr3q7YpJAbfxUUOm8JVxXmXyIiZ1YE=;
 b=gHWTA+1WNMcNSgIC4GoVM7zUtiA84e+6zx+5cK+VQicGJuYOezHM9C8rTLuIR+iVABl/hLi6AZYT4uS1VaqwjyfuJwKSVXD9HC5r14kHFsjDSPU+2YnSfigfj7y/lfGnCGxsE33wCPcuedVGCN9jFuuCQK0j8+fZ0SkI9SiNDMau4lJkrKNaiwezPRqvAmGocbsdKSK2LuDZyxLkgUmay2FrSsy/fCMOPN56mJUBVyfMhJ/2Jv5ZawY6/Wb7oaGuNvM5Hx+QEW0bqCT2f4Jw08p4ZM/j+oC4r5ZR3WMW2a4UiW93CT2sF+ZpMlw4Lb4XyL8+FeyGfHPy2BUKh9Fvwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XRbgofZn0mb4sqr3q7YpJAbfxUUOm8JVxXmXyIiZ1YE=;
 b=dGWVPj5rjVxFu21Vcj5igtFh9UzL/Z4i8bh459wIF6TdFMjuJDlptL8dXeNU5MTQLXRN35M5J/A1iCLf7CDi6uUpLXDnf+8cpEXToEnLiKTs+h0z2GUyDrngzWpJ4tmHdSkgtlJuUxw0KF7STCFVZIt4aeK1uh3nBkXRMeurNAmks6t+7DGSBIt/cnW2WuCPDpIrZ/gD2zf1UZA1GKOYouOmTOSlaZvuawtHrjVWEInNPGyxFAnc+Rlthl2xcbX/h0/adG3kk+vZDSMjsE4NtFGdYl/JqdXL/g/izRfj/J3Mm2iOCIluARsVz2P8+h8OhXIeAgrwTtvYKGLi8nH+Jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 SA0PR12MB4511.namprd12.prod.outlook.com (2603:10b6:806:95::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.38; Tue, 10 Oct 2023 15:53:09 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013%7]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 15:53:09 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     "\"Huang, Ying\"" <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "\"Matthew Wilcox (Oracle)\"" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: Re: [PATCH 1/1] mm/migrate: correct nr_failed in migrate_pages_sync()
Date:   Tue, 10 Oct 2023 11:53:07 -0400
X-Mailer: MailMate (1.14r5994)
Message-ID: <CE866D48-D92B-4E06-84F4-7330AE47CBD9@nvidia.com>
In-Reply-To: <87wmvvi1x9.fsf@yhuang6-desk2.ccr.corp.intel.com>
References: <20231009203231.1715845-1-zi.yan@sent.com>
 <20231009203231.1715845-2-zi.yan@sent.com>
 <87wmvvi1x9.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_A2367D0F-4CF8-4EBA-AD36-BB47EDA6A030_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL0PR02CA0089.namprd02.prod.outlook.com
 (2603:10b6:208:51::30) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|SA0PR12MB4511:EE_
X-MS-Office365-Filtering-Correlation-Id: d5682ef2-3a1d-4e2e-04f4-08dbc9a90068
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EWSiqMpz63qeqra2Es7qEVuC37Y6htxwejVuSJQwOjJB7NZfXqdtjX9b01dVbbQLDW/gMI7r8iUj5Hn7KytEZQS/jxK8e653Ja/hRlWnN+JFIy7Ry8VacsNHH3PNDAZUuBkT1ASvqGBhb9EdwcBdTOJh7Q2nrk925y3voLYDL+wXvkS6NEJCxFzLeckaihqtiIHtl0oehB1EfxrdwRWahittmt5LgnJ9dZTmD8wNg1C2QpU78z1Efs9TDYhCM4Pra8DdoOWyAM2L/95A3zr4KCnTK44/+7Fnr3ECH3c162BZCsxoKj7OYuZttrZ3fmr5gVZMBfUsUEeLLFzCROjyZ36iSAv698OEXeO5UcVHsJ74eJYhDGfFKV6rSqlKrD0YfhUdDUaUQI1eAWVFREZirsItNPIPQqsYYp4KyTbDNwryLR3lQ5TGFqe16uwPMnoKFgXoeawXA1HNhImcbU4c8Juru6eOSEt43t5HUQ4e8fX6kvSFLtmsIofJnS4bpW54FnovNO4ffYfixDO028HOW9n3dwJqxbWdasKnKIeC9vxzTlIhkIHLQ8zKFfzHYghqh7XkxX0O4LzjB8tRBsdm1N9A9aQDU1yDS1yqtXE5syVdO2fv14Jd1CJXna45djOQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(39860400002)(136003)(376002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(53546011)(26005)(38100700002)(6512007)(2616005)(36756003)(5660300002)(8936002)(4326008)(235185007)(66476007)(6916009)(54906003)(316002)(66556008)(8676002)(66946007)(41300700001)(6506007)(33656002)(6486002)(2906002)(478600001)(86362001)(83380400001)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VXMBGc+qp7m/w//hzTlhMGXejc3pvLVprW3T58G6ekAH3iGc1r8RE8hqD1/w?=
 =?us-ascii?Q?ysz4uhISZ3HsffOalAE3R53QI50NMetxuF7zDRM5Wu1LsE4cMyc67f8+G9ug?=
 =?us-ascii?Q?az6C5IZnVQNGB8ScD5l3ykpr8YTrWAklY9n8DDJW6fu4SHXuzn4VIuVaJ6D3?=
 =?us-ascii?Q?JgIby/mtJahwcxaJD5itYZCdS50kBIgeIJnxyaMzTKmMK8lTAwYhLt+Khkna?=
 =?us-ascii?Q?oqJJppVfgC4Mrr/z8B3TNlRw2Rxy6SpJ6w6eIY/CZugp1GlokLGWH8G3CWhy?=
 =?us-ascii?Q?5vBaOoFRUsqUUP9BRdigrItP1H4sD7i5kmh4HJsN5NYCc+xcxwYcPj6ft/Uy?=
 =?us-ascii?Q?FyjW3XbgNV1PdOdfPZy2V/DMORRqnOG/GClhqZXRWo4wv21rM5GhT3C2HP+o?=
 =?us-ascii?Q?vtfEB2W4cHQHnssoRbrzsKsELtywtxZrh6gDYBWJIefXzCx6vacAdMieRDy0?=
 =?us-ascii?Q?TAcAf89ceFJKhvCsAOnmMD+AEjYJ8P1TDAlYDzFZM832axpsCKdGndX5iAgK?=
 =?us-ascii?Q?eEuWNjYPMkW69h3/hVh7+1eImHSzzGe3936G7IvBMjOQFQhn5a85ti3GqgT9?=
 =?us-ascii?Q?qzGrKfFp+KV3AvQhYb0Rq1jNxOjdPOv9H23BSv2kfFtr7FQd96eOvbVcBtOR?=
 =?us-ascii?Q?LHDWEKoOp80e0FhTFBOj9IyX/HI/8ZFjKEcq00E9IkcZRclfpOowcX+34GDi?=
 =?us-ascii?Q?d5wbiKzdLHNfHRClRs6soMP7aGwiBxUMIm6CVz5FG1ATt3TLl2jfmg7Hd5bS?=
 =?us-ascii?Q?SFh8udV/afN1Ex1Odp/CgY6Bl1aXP9Esv8LqCJrcezD04HTLnKHVW2oBTRW/?=
 =?us-ascii?Q?SlnB0Hy/mGPx6u1wWw+CLJSuH12yC0trYH8epSUKMFXa2+wEcYrxJHfwn8kP?=
 =?us-ascii?Q?R9BpHv2VKg745KfxBUqEz/iS9l/YOCBk7IU6sdgsa/lie83LTQ9ZEWlAuQoV?=
 =?us-ascii?Q?hJRGrqMc1fbik1YUCQ0Xz/ZBapCYuXdFxe1QGBHUEkNwLx6E8WLt3q6EnX7E?=
 =?us-ascii?Q?pGU9q0hrhhN5dLfNFb+gHaph9OG/9ctbm1u7y/rsQJUMyQ4u6kPOCmWcl+BW?=
 =?us-ascii?Q?kNthwr9PprBdDH2wjRvlr69FtfvcHk6ClQsloAyo4FPhafqTu/lwU4qLeen9?=
 =?us-ascii?Q?yZP2zEIuHZep9nvX9bpESWTlaG4QLq6N59WcA7/GQmfRQhuXGo8IL+aXNEru?=
 =?us-ascii?Q?IH8n5mXZhw+d3gT/YTko28xUpKb2icf9T6bCu9qaLAYGX9pufcUXmVsqfYod?=
 =?us-ascii?Q?7e/gL6luS+nR5UZ2OiBecukimTd4bTatIoFNDpLwFI+wjgY79s8+CqzZKxWW?=
 =?us-ascii?Q?wNzepsS1DaRPj2Pv1BlUFfmvEH+QELcX7lHWiHMPf6Dwrq183uvedPRLqbd6?=
 =?us-ascii?Q?tOnm5SXWaeWJQSucuT8AZYRFV6+Z5CwdQjjuppZY+JbvinqB9Py8JKqX+Xt2?=
 =?us-ascii?Q?d2afDQVoOm6ltSWtE6MlTmVbnkS6HeAf3OfZe5nM/F+f2GhAEic31bjm1/GN?=
 =?us-ascii?Q?3NQP3McAfs65Z2XCY2bKGJIymj3yeORowlJMteqB0uaJ7Dg6Pmwz9TEItXjI?=
 =?us-ascii?Q?+551KKXZ9/J6EnWd83U=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5682ef2-3a1d-4e2e-04f4-08dbc9a90068
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 15:53:09.7653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kYqqzIlTsoPivyuhFf0+pVHIAAldlQTabZBONrJFEqU7bD44oqTfSk0i0IfIMgrL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4511
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_A2367D0F-4CF8-4EBA-AD36-BB47EDA6A030_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 9 Oct 2023, at 23:36, Huang, Ying wrote:

> Zi Yan <zi.yan@sent.com> writes:
>
>> From: Zi Yan <ziy@nvidia.com>
>>
>> nr_failed was missing the rc value from migrate_pages_batch() and can
>> cause a mismatch between migrate_pages() return value and the number o=
f
>> not migrated pages, i.e., when the return value of migrate_pages() is =
0,
>> there are still pages left in the from page list. It will happen when =
a
>> non-PMD THP large folio fails to migrate due to -ENOMEM and is split
>> successfully but not all the split pages are not migrated,
>> migrate_pages_batch() would return non-zero, but astats.nr_thp_split =3D=
 0.
>> nr_failed would be 0 and returned to the caller of migrate_pages(), bu=
t
>> the not migrated pages are left in the from page list without being ad=
ded
>> back to LRU lists.
>>
>> Fixes: 2ef7dbb26990 ("migrate_pages: try migrate in batch asynchronous=
ly firstly")
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
>>  mm/migrate.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index c602bf6dec97..5348827bd958 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -1834,7 +1834,7 @@ static int migrate_pages_sync(struct list_head *=
from, new_folio_t get_new_folio,
>>  		return rc;
>>  	}
>>  	stats->nr_thp_failed +=3D astats.nr_thp_split;
>> -	nr_failed +=3D astats.nr_thp_split;
>> +	nr_failed +=3D rc + astats.nr_thp_split;
>>  	/*
>>  	 * Fall back to migrate all failed folios one by one synchronously. =
All
>>  	 * failed folios except split THPs will be retried, so their failure=

>
> I don't think this is a correct fix.  The failed folios will be retried=

> in the following synchronous migration below.
>
> To fix the issue, we should track nr_split for all large folios (not
> only THP), then use
>
>         nr_failed +=3D astats.nr_split;

You are suggesting a new stats "nr_split" in addition to nr_thp_split? An=
d
nr_split includes nr_thp_split?

--
Best Regards,
Yan, Zi

--=_MailMate_A2367D0F-4CF8-4EBA-AD36-BB47EDA6A030_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmUlc2MPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUQcEP/RV6GUWJV+h7pAip6QSr9eh6AqoK2+s+moXa
YhK19szhkpg0YEC17hqeOnZ3RA5qxKPpe7Gfelf5gIWXmQgZiMZkJVew3hc/o9eE
Sp+XhA5kdto32DQl3IW0/BFdDF//cYhpUZhKUZHA2kLcmlsPweAlhGvc1N01lSew
llkacEzNb8W02g3JrcpApkjY0moHWavmW4iJgRNayVqXghk9Lfpb8SNEDuFTN5n7
gPY4qzm0ncO50H7RyrvC1gkDcfkIEsQTYHPbS039nRGqMKSjxdRUAdX04cdEVpv+
qRLKUpxuhQP/iOC5TiulBWrSQ27txqvLHpgJbG7KPPsD375ckpgKZZRIpW6BiX3q
PM6RWwEWv9lHQDgIp/IIhtqTjai5qVy819O5OPVf1g8QBiKdKwjUBUrWUyyT9pYl
XrfgRAi5cxqkZExIre95bgJisBuObhPmDZqSm32FN4UrmrZfho1aExLqeyWFODdf
hQNhG2bshsLeStjBgAqSZPAkRiGyPPVVCpNZblsObFoqQBDq8+TWXSxtN2l1YpJH
I9ZKj9h7rnNqh+598VxN6YXqBeNv8tnFdgolYX1RkpF3A6Wk3aR5+vQtRE/64xhH
xk1jW+w1cCTTa2BVECfS9RJ5DiX/1+QhhDBrg+2IuXRa6/32yqJzZnvxwTxELRFz
Yra6Zdcz
=ndEI
-----END PGP SIGNATURE-----

--=_MailMate_A2367D0F-4CF8-4EBA-AD36-BB47EDA6A030_=--
