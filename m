Return-Path: <linux-kernel+bounces-62180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA5C851CBC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC2481F2175C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CEDB3FB3E;
	Mon, 12 Feb 2024 18:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lw/3O30b"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2051.outbound.protection.outlook.com [40.107.102.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CB83FB28
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 18:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707762588; cv=fail; b=aXE4wYc5j7EF6raJXjyyP9oZpv9/XsYz/4ZZGHAgP3p+SdHKQpNFgx59Sg1WYMhbldazLNVeaHGyeR5dualQEM7cQbwD/IMfV3R3GTsXLWvpRa0fdAZ8VkxjhNv3CjQuZ2S37W097e2d95836P1l8syYND7AVuCyAxuiYuyh2Zo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707762588; c=relaxed/simple;
	bh=loTJ6VfSHDnyJxdQMRkVybRxJZ18kLMDlTxg3J1Oui4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dAKJXjXb2tDbdRxOXG0Y/MrrKwUHKtmteWrw2ADNZ16eFYqAcT9t2IMqiMEzsNyeu644PWVi8dD/o5vFMviqHVZ29MXiccUXNMRRt2S/jnSAgFg7q/cTF3zu20sWnbs91zrbv/nNfcO1yfnv2I894+gYDWCt77K2aP3d4efK9tA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lw/3O30b; arc=fail smtp.client-ip=40.107.102.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GzTx9uAE8eNgDWZ9eULiuU5F8soO2CwqvPcKay2zrjwgTWypC2w4XuNyb8LUZgj+9ZhpBQUTDrjfnEfEiGPEEBKVNUwvNKPNu6qNxUl54c2W+hbfRJ8P+uZDHs1lasFkun6ZiEt8fxw5YKhp+jVlrrnBovt1AVXt6L8Vj63KjD2FED0CWEafNCSRyKSgsxZtt69NlfZrsE5NgHYRSt/85Vxwobw1zhtLRB7B7/mMs1BzfjwMRjSQVpI5KIENdAwlui9sL5M/Hg0a4qZcUz6nOGWYZ6rM9Eho1c6cJV4f9c7VvthRrBgj4RExjdhHuyLuLjBEjzi5E75deHi6J6rZXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FE2jy6BL4eKIhD8wcJcq+Tfd/mAdUYG3chSUpuVU5nw=;
 b=GbHr5cH6Z5TLEW0N48JoPPjcVk8B+zQDbLV2Q6UMwYNUsu2x+U0o7VR3WirjlFOydO7EaBWSu4AbFOG7MfkPlCcfpPf3YFm9GzoWtPnErm8m3fUxLEHDSmOPHXYun7BXMHj3O9fCwt6dqd88sSy6sRHRQgyFqpNH9QwOTxUPJ1EgzLJH9fnfjWl7hPqr8cNdTueHXAsow8Gx6lIReafOsBeiA4inkHuuI7MC1SKdlU2nuFHkgKy7ilhu0qPArJ7GcVVsYopZ4p9agy5GEsfkwawumWIbserxjIFyDeRmbaLbNPXKrUcNKabe/udDcTicFsGihusmq8+EjfKf6JBrEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FE2jy6BL4eKIhD8wcJcq+Tfd/mAdUYG3chSUpuVU5nw=;
 b=lw/3O30bBlQGsy8d2OvPmKr2J8E1h1+N4UMT4ye3nJL8eOD2Jephte+Ki86iRUErt0Om6WtSHZA7ZhhRBhCwjnnaGDM8ALwbtS6voKW3ttPQrCp+KC+LuhYKtCtR9HA+/GPKdE5o9rccgT39bL18UpZS2JsKDuOaPOt9ACbdNmQsb6MJGu/ouH5o6PimRzWdGcHnXJoUkh6/4saJjh+5HbDnOF/D9NvS9eDym8SBHFW6KT+kXwX0EHph3V+xJVByw1cMVBequjBbuWznlpJmi5jCzLrApm1bveqYGRhh9C+jzWdo93GRg3+s6m26VIKf2J0p9j9tmQVI4Q0o3aLeQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 LV3PR12MB9214.namprd12.prod.outlook.com (2603:10b6:408:1a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Mon, 12 Feb
 2024 18:29:42 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::db3e:28df:adc1:9c15]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::db3e:28df:adc1:9c15%5]) with mapi id 15.20.7292.013; Mon, 12 Feb 2024
 18:29:41 +0000
From: Zi Yan <ziy@nvidia.com>
To: Yu Zhao <yuzhao@google.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 "\"Huang, Ying\"" <ying.huang@intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "\"Matthew Wilcox (Oracle)\"" <willy@infradead.org>,
 David Hildenbrand <david@redhat.com>,
 "\"Yin, Fengwei\"" <fengwei.yin@intel.com>, Vlastimil Babka <vbabka@suse.cz>,
 "\"Kirill A . Shutemov\"" <kirill.shutemov@linux.intel.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Kemeng Shi <shikemeng@huaweicloud.com>,
 Mel Gorman <mgorman@techsingularity.net>,
 Rohan Puri <rohan.puri15@gmail.com>, Mcgrof Chamberlain <mcgrof@kernel.org>,
 Adam Manzanares <a.manzanares@samsung.com>,
 "\"Vishal Moola (Oracle)\"" <vishal.moola@gmail.com>
Subject: Re: [PATCH v4 3/3] mm/compaction: optimize >0 order folio compaction
 with free page split.
Date: Mon, 12 Feb 2024 13:29:38 -0500
X-Mailer: MailMate (1.14r6018)
Message-ID: <7026A932-5750-4CFD-B370-80A46E47434E@nvidia.com>
In-Reply-To: <CAOUHufYz2P8w_kqxSjmOghbEG8CZmO2cfb4UzP7dkduBQbHhQw@mail.gmail.com>
References: <20240212163510.859822-1-zi.yan@sent.com>
 <20240212163510.859822-4-zi.yan@sent.com>
 <CAOUHufYz2P8w_kqxSjmOghbEG8CZmO2cfb4UzP7dkduBQbHhQw@mail.gmail.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_1E7BBDBC-5FBD-42DE-9213-BB83A3F74918_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BLAPR05CA0033.namprd05.prod.outlook.com
 (2603:10b6:208:335::14) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|LV3PR12MB9214:EE_
X-MS-Office365-Filtering-Correlation-Id: 78655759-4e42-418f-6b80-08dc2bf89418
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EfvXDcoysNWu7kox0uHY2yRfhcJMTYIFAiNQrZMXt8G30sq0N13+GTieqQsNyMRC8AUXOGelGk+q+KvkoO2kdVQguj4Us9bmO5olF8BwgGi8dpDpUiyg5UXVlo2D8/7q5EvV4CtSJzJ/B3et1a+zCG9nmFUxhNZr6VqtFf5PcOIFIA9eLQvRLfkMg70uzF7l2m8X4Cl9WCTAcvJzkXUTcIsx0GdLL2Z/prMkUcSnZI3dai+zfwLaeD//NzMGBZTTzlnybj4dfRalBbifi7OsV1pCaBU5cKUmSrxk0VgObR8maby5oX8O+gCh8OZBohXiKCh8nT4SbyMuO1JqDQOa0qFZB1+iAy1VklSke6jB1NEKmxQe5/p+RFkTo2pNvcnauEKdr/b8vWTFA5hiAE2c/JNXuCsiVgO/iKZyFsdFde+wivJ/T2eZkO6bDjOGhcUekOQtev/t0evX3dm9RXMJlWWZT1y2kr8xOnqHfVleaXXh8y47mu8u6TcSNH670diGuc+dnTb60eZimTDtE4CTU/IzDOc2CLBOFg+JzpufB0Tf8dVRTRXpUoCXEmDMEMus
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(136003)(346002)(366004)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(4326008)(8676002)(8936002)(5660300002)(235185007)(7416002)(2906002)(83380400001)(26005)(2616005)(33656002)(38100700002)(36756003)(86362001)(6916009)(66946007)(66476007)(54906003)(66556008)(316002)(33964004)(6506007)(6666004)(6512007)(53546011)(6486002)(478600001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V2FhREtqMmF4RVdNUnQ1T1Aza3kzaFNUV0E3NStid0JkUjFSYzhBV21MK1lM?=
 =?utf-8?B?VldaekxxWXNENWQ0ckNFMjlNRDA2Mk9tTEoreE9sT0VxY3RtSHFyMEd1eEw2?=
 =?utf-8?B?S3pzcFRkK3R3TUZkY3E1TkZNVmF4eVkwa3U5UGJ5MktSMzcrQ1c2dmNVSC8y?=
 =?utf-8?B?T1c5WVZzbm9xcE9ZUVkxZ0x0WlZlU2Fya25xSVhkd3JybUlPSUc1ZlFtM0Jl?=
 =?utf-8?B?aGtwanhZaVB2aGxzZ1h5T2doSW5WZnB6ZEEwS0N4VkhubzJSb0JubDI2TFY3?=
 =?utf-8?B?bDg4UTFaZjQvQ2xyMGIxN3FmYUxMaHVjYzF1L0F1NXNJTUNUM3FiRHNWWUha?=
 =?utf-8?B?QXNsdStmZm9XcXY1OFdkcDdrYzljSlFUWDJkZ0hMRGJLb1RRSXgzbm0wemdm?=
 =?utf-8?B?Z1pNVWEvU2hvRW5LNDliNDhZU3BiUkhqTzA3ZVVIbWsrM1NRREZ0c2xzbnRj?=
 =?utf-8?B?Vzdmc0xMem5xYlJIaldrQVZMT1B3ZmI5aTBIRXJnRDdDcDJiaGxXS01JbjBi?=
 =?utf-8?B?MDg3SFRjWW1XUUpqallNaStsb1BIZjVOdjA1Y3RXQ29Ic0tubWkyeGtEb1B0?=
 =?utf-8?B?bEVHQmgwNnY4VWlocHVXTDcyaVVCck9BL0Q1TmUrMkkzbXBHVEVqek5PbjFo?=
 =?utf-8?B?ekVnVjVuNk15QTc5SG1iRUR0TjdTa3lpbHVta2xWUk5TbnREazlHMDhOYU9Q?=
 =?utf-8?B?TnpjaGpMeERjb1FsczlDV01WaUgvd0N2ekJSNmJ3cUl1Sko0OTQxcGxYVy9u?=
 =?utf-8?B?NlhMenlGVEo4eS93MmFJNllCU1VLLzdMOE5MaU92cEIvR0FtYXBpYVFSWnV6?=
 =?utf-8?B?QlFGWjlzbDVTeFNOSW1IRERVcTFJbm10UmYwNmY4T2JhWTVwcEpzcUU4UDRO?=
 =?utf-8?B?MERQam9icmVqdFFDYjJVMkxqY3o0Si84Nk5Ccm9vOTBsb2h5RFcxTmVON2hh?=
 =?utf-8?B?SG1VRHJ6YW95eC9MMlFkQ1owd1plc1BUbDhKaDdROStuK2hHNzFoZUxHYm90?=
 =?utf-8?B?eUR4bG03QmoxLzRrRDNoSjZBY2xSWVVGbExTdXVWWGJYT0RaZEVyd3FyMGhZ?=
 =?utf-8?B?UCtoODNPM1UxZFcxbzZiUUhhbjg5b2s5Y0tBcVcwcDZ6M0dwSWlWUUdsMEV2?=
 =?utf-8?B?aUxZKzdPbU1DS0lLTDBmRndNVDN5RHBuWkZIT1d0Tk80VUtML09RWUNHQzR5?=
 =?utf-8?B?NytqMWhTckIwZVNRZGtLTGJYSm5jbTR0b0ZoVEZvREJ6dHZxRVE0ZE9pRmhi?=
 =?utf-8?B?UnhMYXd0Ly9KY3I1c3g0S1UzaGNCVUJyaEh2UlQwU1RraVd5UjBxY0plb2Zr?=
 =?utf-8?B?RVU1M3VaTWIxaElFZWtUM24vWVltU2cwdTRGNm9scFNGYVFtYlYxS2xZTXNh?=
 =?utf-8?B?eU56ZU9haHJQb2tsN2JoRkp1cnN3QjQzeWZRU2ZGbmdSVFNtSDhCbzd5Y1Ey?=
 =?utf-8?B?TzRDcVpveWk5UFNqTWJ0WnZjQkxMenlWbUpic1RvNWFDN2pGMjMwOFRCaW5v?=
 =?utf-8?B?bUhSQWNZemlvWjRoYnNwN2o5YmNHVGRheU9jdEY5UzlPa0lKSnRWOTV5eWNV?=
 =?utf-8?B?S2s3RSs1WGJVd3lDc09ONU1xcGFzUjg3cUVudFUrZjU4VWFHNTg0ZDB6Z05M?=
 =?utf-8?B?NlRFZU56OHdFM0VUUHAyb3VzZW1qZnZnMElKc0J1NzJCa2x6OUJzdXdaT1M1?=
 =?utf-8?B?blFGeklVV2JPVFliaDh4WGFGZVJDWVRxZktkUGlvc1B3a3dJNDRCeFB3ekts?=
 =?utf-8?B?WVZBSkd6Q2xNdHoxRzlvdmdQT29NWTZZL0ZFQVFnMXIxcXBPNDBCekZOM3Vp?=
 =?utf-8?B?M1d5NE9TeXB3M2dSdmI5TUtYWnJiOFhWUUVYWVhFYlNWZndVQ2Mzd1QvSWpi?=
 =?utf-8?B?SXc2b1UvS2FNd1lBcVNKWldWZ2cybjVERWJCQ0xrcEVVb2hMSU5ZQUxyL2VU?=
 =?utf-8?B?bldPTEpwcjRHVHVGSWlVUHh0ZWxmY0ZHQklIT05WelFObjRzN2xYRnQwUVg3?=
 =?utf-8?B?Rll4V3ZxV3NkUVZlYy9ZcUFDQ0FmK0gwc1NtMzc4eXBCSy9CZWcvVGF3bzc1?=
 =?utf-8?B?ekhBMkFMQVhHbWtQTGdwQlJVMFg5eXp2ODlsT0ZYc01EVnRucGhGcVAvL09L?=
 =?utf-8?Q?bORO+8OP7mDpY2mtSMupMcOns?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78655759-4e42-418f-6b80-08dc2bf89418
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 18:29:41.8039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8QiH4qRzmLkHkQpO0QrJkrqIVTUNUPFt6anXs+GCdI+ZEiPYXKtC/y/upxi1CK9e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9214

--=_MailMate_1E7BBDBC-5FBD-42DE-9213-BB83A3F74918_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 12 Feb 2024, at 13:27, Yu Zhao wrote:

> On Mon, Feb 12, 2024 at 9:35=E2=80=AFAM Zi Yan <zi.yan@sent.com> wrote:=

>>
>> From: Zi Yan <ziy@nvidia.com>
>>
>> During migration in a memory compaction, free pages are placed in an a=
rray
>> of page lists based on their order.  But the desired free page order
>> (i.e., the order of a source page) might not be always present, thus
>> leading to migration failures and premature compaction termination.  S=
plit
>> a high order free pages when source migration page has a lower order t=
o
>> increase migration successful rate.
>>
>> Note: merging free pages when a migration fails and a lower order free=

>> page is returned via compaction_free() is possible, but there is too m=
uch
>> work.  Since the free pages are not buddy pages, it is hard to identif=
y
>> these free pages using existing PFN-based page merging algorithm.
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Cc: Adam Manzanares <a.manzanares@samsung.com>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Huang Ying <ying.huang@intel.com>
>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>> Cc: Kemeng Shi <shikemeng@huaweicloud.com>
>> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>> Cc: Luis Chamberlain <mcgrof@kernel.org>
>> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
>> Cc: Mel Gorman <mgorman@techsingularity.net>
>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>> Cc: Vishal Moola (Oracle) <vishal.moola@gmail.com>
>> Cc: Vlastimil Babka <vbabka@suse.cz>
>> Cc: Yin Fengwei <fengwei.yin@intel.com>
>> Cc: Yu Zhao <yuzhao@google.com>
>> ---
>>  mm/compaction.c | 36 +++++++++++++++++++++++++++++++-----
>>  1 file changed, 31 insertions(+), 5 deletions(-)
>>
>> diff --git a/mm/compaction.c b/mm/compaction.c
>> index d0a05a621b67..25908e36b97c 100644
>> --- a/mm/compaction.c
>> +++ b/mm/compaction.c
>> @@ -1832,15 +1832,41 @@ static struct folio *compaction_alloc(struct f=
olio *src, unsigned long data)
>>         struct compact_control *cc =3D (struct compact_control *)data;=

>>         struct folio *dst;
>>         int order =3D folio_order(src);
>> +       bool has_isolated_pages =3D false;
>> +       int start_order;
>> +       struct page *freepage;
>> +       unsigned long size;
>> +
>> +again:
>> +       for (start_order =3D order; start_order < NR_PAGE_ORDERS; star=
t_order++)
>> +               if (!list_empty(&cc->freepages[start_order]))
>> +                       break;
>>
>> -       if (list_empty(&cc->freepages[order])) {
>> -               isolate_freepages(cc);
>> -               if (list_empty(&cc->freepages[order]))
>> +       /* no free pages in the list */
>> +       if (start_order =3D=3D NR_PAGE_ORDERS) {
>> +               if (!has_isolated_pages) {
>> +                       isolate_freepages(cc);
>> +                       has_isolated_pages =3D true;
>> +                       goto again;
>> +               } else
>>                         return NULL;
>
> Nit: remove the "else" above, or just:
>
>         if (has_isolated_pages)
>                 return NULL;
>         isolate_freepages(cc);
>         has_isolated_pages =3D true;
>         goto again;

Will do. Thanks.

--
Best Regards,
Yan, Zi

--=_MailMate_1E7BBDBC-5FBD-42DE-9213-BB83A3F74918_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmXKY5MPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUsIAP/RqGJ9+gFo9jGU0wF5yn9bfE0qvreZ1r5C+s
P9HL+0WYqk5rCakXbCJQkTmKcpadf/F+0VYD8tjM+hYDtPJteZCSu9UvsB9cTahz
kU/57uQ8xqvhjfnWflrn9bqeW011BAADUvOoYITiYGPFZ4zJJx2Zt4LzvBlqT14C
e7Sfx6cFlKf2pATZNH1QgNFPRmQhif8gXNLWBhxz5kCwjR/ZZ0W9GxELZJLOOtlU
a3hELvbPTUVm1fMFXc52NNRdWvfJOb4ffisBGvXQAIvCkA8Lkwx6eBQZ2oVbHRyh
p8izFFgDe3ayHJ+cvuau+Aj3y4wN0IMeAUnV9SYKOwvadOS5ieZB58Wa+hUUpE4F
4QND2Tt7ssqBb0IxTe/muFt5WsXAX8A4ccNc/tFiRkfn8cGUC/JogspTCsKXRm64
Nl8aLj5n95D7Zb+cg6kuQA0orbG1ukeGligOp55JF3cDXQs271GXb8rU3cjnCuam
QIr1WqzYbJ3XNwzcS+03x+VGTuGvIdlmeV+wpwiy7688167+Ve+Uy5xu2SrMH4ne
FlL2F2llL1R8vlC8eaK92TvY0ydikZAYZbLb080mIWlIeSR0ATz/H7v+1sJhuZjk
0RSddKiztUTZ5bBgVEN+1jnOHi/aqqsAQy6OenPb5lZF8vGNqZk+hKrceU41WhdM
oHPcdrPQ
=/7Qn
-----END PGP SIGNATURE-----

--=_MailMate_1E7BBDBC-5FBD-42DE-9213-BB83A3F74918_=--

