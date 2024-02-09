Return-Path: <linux-kernel+bounces-59910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A65E284FD3C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 625DD28B0D2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659CB8612E;
	Fri,  9 Feb 2024 19:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="l3G//wBh"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96ABA84A44
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 19:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707508633; cv=fail; b=HUiSx5EPFQFDl+Rs4FuIBi7BmLiuVR+NIavZg8bpV+r+11XmllS1KWfAkAF2C0bXQMAE8sP69r4HtOcr54lZlOhtNQcWLo0XD+Q+IxtCdAsrE4zHfwT5T4DSs9jgPHg4SkblJx24+DX4NIO1AJP2x2CgLp+bsMIByh8TlzvwkTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707508633; c=relaxed/simple;
	bh=AYAejrBP9XjWccl/sQzgMNbrRC68Tjubs0L+hQQIiP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hvLZAKAlW5sTBjg6+fHYj6NIceik4aLJHeV0dLyQh21rKpwljT/Rmfwg8Vnc4GSFGH8dIhEsQnU1eeapB1xTAT381iWF3MBMIE8dWJIfYCgPH8tJVQ3jo5dJfCTi7mXP5D8fXe1eL5yzut163X5st13Cjo8kv2An4EIB41uFhAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=l3G//wBh; arc=fail smtp.client-ip=40.107.223.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h22tqOGH+DQkr04ggKbC9fL4k9ydBQ2+ymiGhz0d45Wv/TeqCv1k3Lw6L00o3jcXGa2gzRh26QLnuqX11MlJI8lN5ftxTiv/iueWlOgyUMepVsukNMc0rijFpxq9JofZrXq2bTTKvdEo0q0mz7J+i+U7V2UtGOvJYfOK8y44mbyORXDV4KF7NfPoc3e5uIEWXJom/FKcug1qNt2MXkuxVoPooE5ifrv9a+M75HhlFJ08gJgniO+f0NxVI7P6tpmG2Oo6a6XPUJyVMrPUXMfF8UchVj11bvuFcSdJutWml0zcx5kObS6xD12iBmQE5wp1BKq9yeAYk2V2aeD15dhVpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oxwbNiKFAEsPky6jcC+oCmicaipOztG46V7j5ialtrk=;
 b=iPXihTix7wl+o7bBsNYBj5my/T6hu+GHx5TcIGu/4mE1OwAZtGclm+jl8Z1RTeL3aHuByY7SCdC047fx7rcv4xodJAEmC1qXOV41kXM9mTPfzHEdeBoclcJeRalwyzdt1uboZ2AHvETAk64C67YqADGUGEV2hfug1tbGfzvPtf6VfgUBVoUx3MNYOS8JLv+t0AiW+5Au/pkjcnYjGXWajLKs+Bo07+1xCc6D0vxya6Iw/gK8ZRim3tIozDayPDdNAWo1HKD5JqL/OqzIpmcfiHopKmqAlIkhTU77j/b0HPF+iw8xNPwDczD4zAnLvL/PmD0yFWH6+w8BPzUQ5i41Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oxwbNiKFAEsPky6jcC+oCmicaipOztG46V7j5ialtrk=;
 b=l3G//wBh560anuf3XyApvddL+8jmzGzMmgzMl1NKzXY76y8nURTRlcnrozJZvcGmeaF9T+gucjurqtI6szx+j60pKFhz4pYX5aA6Y106i8x7MWtkYeYWF7ucEVd7kfbJn2PeV5UVARJUXZ/87lPUkEumppuVYEf4MfHKBnd7Kuk7Z5JRcEGtCF1W07tKC+H5vfpXa288eoxpYl4bJ7azIjcezv78lJfWGN7scd0DaQYrz+COgToc0Ia6k9QlcWvmNNhM7IUeFFQZvxEJCI1AGQtW8wJQcH4tCg8CFRkoRDSy4WAQUXcpCex0M+hlFuPEbfiMGOqNeSrCMu+FERjf7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 BN9PR12MB5132.namprd12.prod.outlook.com (2603:10b6:408:119::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.14; Fri, 9 Feb 2024 19:57:07 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::db3e:28df:adc1:9c15]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::db3e:28df:adc1:9c15%5]) with mapi id 15.20.7292.013; Fri, 9 Feb 2024
 19:57:07 +0000
From: Zi Yan <ziy@nvidia.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 "\"Huang, Ying\"" <ying.huang@intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "\"Matthew Wilcox (Oracle)\"" <willy@infradead.org>,
 David Hildenbrand <david@redhat.com>,
 "\"Yin, Fengwei\"" <fengwei.yin@intel.com>, Yu Zhao <yuzhao@google.com>,
 "\"Kirill A . Shutemov\"" <kirill.shutemov@linux.intel.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Kemeng Shi <shikemeng@huaweicloud.com>,
 Mel Gorman <mgorman@techsingularity.net>,
 Rohan Puri <rohan.puri15@gmail.com>, Mcgrof Chamberlain <mcgrof@kernel.org>,
 Adam Manzanares <a.manzanares@samsung.com>,
 "\"Vishal Moola (Oracle)\"" <vishal.moola@gmail.com>
Subject: Re: [PATCH v3 3/3] mm/compaction: optimize >0 order folio compaction
 with free page split.
Date: Fri, 09 Feb 2024 14:57:05 -0500
X-Mailer: MailMate (1.14r6018)
Message-ID: <8E042D2A-B4B1-4538-946C-A63A0DB64FE0@nvidia.com>
In-Reply-To: <84dfedc4-a0a2-4e02-9be4-2cffc6e9fd06@suse.cz>
References: <20240202161554.565023-1-zi.yan@sent.com>
 <20240202161554.565023-4-zi.yan@sent.com>
 <84dfedc4-a0a2-4e02-9be4-2cffc6e9fd06@suse.cz>
Content-Type: multipart/signed;
 boundary="=_MailMate_BD14FE1B-E5CC-48E5-91A1-105DB631D11D_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:208:23a::12) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|BN9PR12MB5132:EE_
X-MS-Office365-Filtering-Correlation-Id: a5112e0a-0a4e-4f9a-a545-08dc29a94bc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8GKKqU/Bs7K9ZbdCeppDPcs0lHHXPOWuqgOPoZ+Nj7pKR//LoAviVq0BBR/bhvSovanLc75LhysOU3Rf3OT1kFe3RM14tvslMGCzHBYADXYILWUvqc7WgG9YRiH7hyks5DDvd+qh4J+nXCmysZlZFhthRVjgZ4JP5kbaR9/1PQvsjbYtrRbcUl/uBXanD4QH+H6WdrV0RZH6Hhtl/gjZkKVY0xjfF0lSnCKdFyouVkPPTOk9RBZexAfUUbrkMx7UtYODd+JGmd+kPPSy+zA8dKY2A63KMYMA/v/Br2s9i/I7GM2+FY5CMmS3iL8fgRFC2D0+YNgeOt28NK+hKrbJEoxlJj6uP0wAD9P6UPUJ25nurHwuFTKjqzYHxxfL9eSXsgkW3VEYaOG7sPtLAziGNzjgXARhdxzbTLjzQYBNAGm14UApxGwP4LP06tpWPlcEyBLYYjyyc78J4dT/ACPUxe+XBPrp305Tfgi//jm5CqPOiR8fachWJ48pzqcn70v8D48N/60Rl/xF/kx50yFhQNPqAg/XJcPfvS/IDAMkFp9T8H807boEWBOUjwjR5Oi1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(39860400002)(136003)(346002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(38100700002)(86362001)(5660300002)(7416002)(235185007)(2906002)(6486002)(478600001)(53546011)(6506007)(6512007)(26005)(2616005)(41300700001)(83380400001)(33656002)(36756003)(8936002)(4326008)(316002)(54906003)(66476007)(66556008)(66946007)(6916009)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6dxJCiV73tF7zB63xtBc+Hm9F1EC0t2zZxxBcjlNzq6qJ8+TKHXGpq+8Ar1/?=
 =?us-ascii?Q?Ud7G+PZUzHlwLGCPPPLiM7BqXAfZzJrVnyzrcj03KZbfbQ1jmRuYA+y0t6Td?=
 =?us-ascii?Q?/EjnOVzxYS+77Nw1mcI3hQ2Xi0fQ0/zWkX55JLPUTD5E9WevTn5eorcE8pGr?=
 =?us-ascii?Q?G083NF97wbeTe3+dj6PhRo2dPV2O9HDh2lLyRozrhoAYQvw/JaE4SbE/fHWm?=
 =?us-ascii?Q?06Lz+Ores5r3NjRJcBqTvtR+7YJF4Q+hxCiNydakuVBLmeNEp4V55xDsm6a3?=
 =?us-ascii?Q?TE/F4gd7yve6kl1DbIcYTkFR728K0ATkkGXKvK8IkvW/6DdhzteaMYKH8hy+?=
 =?us-ascii?Q?IYo2rvhpyuoQ13CeBRBXdM2vvAJqiY00HjQb/yLaXfWDnNfGjv+6Iv9XJYmZ?=
 =?us-ascii?Q?ilrXbVDbzOdX7OvwDEsC475zmpXqANkfednC9Yy7+ip9kU/7S4o4A1Wccwve?=
 =?us-ascii?Q?1PRO24NE+KWcqxLXb62maFC4jUdHsRDJ07hAAJ8eI8r8O7wEQI+imk/zkH6y?=
 =?us-ascii?Q?bN+g4AcEz43Spp3+Ko0nFxZKRMvx2WcVbDHWTElz+dVr3oA3KkHm0IRyVY6t?=
 =?us-ascii?Q?4tAUufbvTgDnwGJW0Yqlwb267WW7YY3ElYGgVVKowmWJjOER2QAglEiC/a0j?=
 =?us-ascii?Q?d/kIipQu4vG0QQKGuR+F6CJ2P9PvOKgLfD6ZH1gDz4sDQv2mmxKkNUnr8qFM?=
 =?us-ascii?Q?DejWNwymEjMeg7+qS1UH1+3O3lNIZcDWMIFiIzB1+hdpQCGNQnp3P1650Psx?=
 =?us-ascii?Q?GFILmggmumtDCQ8m/Yy9XavtqxWshqzVogC3Uv0scjpnEuih5AMuant34uwT?=
 =?us-ascii?Q?+pUq6Ax5v7Gp891K4dQCay/v36zK0iM7tBWEbeCA6V4YZiAaWTIwgs/BvjxX?=
 =?us-ascii?Q?kokzENCxLAb/MwhaBzE9zffE/EzzmJMhudUeNpaMJ/XnqqDSxzwMhj1nY/5c?=
 =?us-ascii?Q?efsDYnsLGlvuuMR4kOPObEtiagB6HlWNtuz4MOKnQrNpq55sW1J/EshtQau1?=
 =?us-ascii?Q?HVb51bdRC5AeC40thGEcVOdUwKvecpUzbI4hqoMafHN/vHWPT/w7uzJDtkME?=
 =?us-ascii?Q?MNY0ZhdWQI0RM+XBoDFKcRR4F9e52DpfsQqr9g2T4fTz7mvOGUXHInS5GeKU?=
 =?us-ascii?Q?d+OHQRaKMID3C7iMCwZd9wesIlzF641mTQuKD8VJe6ZBGYxwsB8VsritRKuq?=
 =?us-ascii?Q?g+tf0UZK2twh9LMZLktQOu2uAPrmPwFpGgjQHfXTh6SK5gfDSy0z1KWGPEt7?=
 =?us-ascii?Q?NIEGdEFBof5FWfNor4ATTNDGvJE1IvTeKsknz9HttODNiXJFMzROQBS3Yb+C?=
 =?us-ascii?Q?DyJZAO0FonjL0HvBsNehOkTr06vegjR9wIuUr0x0wPA5PVUceoKOcISoq1i6?=
 =?us-ascii?Q?de3/UDK2RYJQiJj+3+XP7SdoJLrZW/w7Yj6qwh0sKWTdZBXA5Vb76y4+7BDS?=
 =?us-ascii?Q?EsiENkebEejZ4M9ec8OrN0gK1YU2+nGEgQHlhkmWoSdzomfdS+yYSkdWVUHX?=
 =?us-ascii?Q?CkxktpoKNOjwGQuii1yrFJh10dNRaHbSii+8EC9Er/G209NADZe64hb9oaeI?=
 =?us-ascii?Q?wk6eRFM6yWVKLdzGId94CS90GIxVmTm9XyX/9rmk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5112e0a-0a4e-4f9a-a545-08dc29a94bc2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 19:57:07.7979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M6xYthyBIqSIhiy3cgJjFcuwxjC8mIiBZU9gqI3YcKf25UuAJ4LSRpxEuWnZf80d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5132

--=_MailMate_BD14FE1B-E5CC-48E5-91A1-105DB631D11D_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 9 Feb 2024, at 13:43, Vlastimil Babka wrote:

> On 2/2/24 17:15, Zi Yan wrote:
>> From: Zi Yan <ziy@nvidia.com>
>>
>> During migration in a memory compaction, free pages are placed in an a=
rray
>> of page lists based on their order. But the desired free page order (i=
=2Ee.,
>> the order of a source page) might not be always present, thus leading =
to
>> migration failures and premature compaction termination. Split a high
>> order free pages when source migration page has a lower order to incre=
ase
>> migration successful rate.
>>
>> Note: merging free pages when a migration fails and a lower order free=

>> page is returned via compaction_free() is possible, but there is too m=
uch
>> work. Since the free pages are not buddy pages, it is hard to identify=

>> these free pages using existing PFN-based page merging algorithm.
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
>>  mm/compaction.c | 37 ++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 36 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/compaction.c b/mm/compaction.c
>> index 58a4e3fb72ec..fa9993c8a389 100644
>> --- a/mm/compaction.c
>> +++ b/mm/compaction.c
>> @@ -1832,9 +1832,43 @@ static struct folio *compaction_alloc(struct fo=
lio *src, unsigned long data)
>>  	struct compact_control *cc =3D (struct compact_control *)data;
>>  	struct folio *dst;
>>  	int order =3D folio_order(src);
>> +	bool has_isolated_pages =3D false;
>>
>> +again:
>>  	if (!cc->freepages[order].nr_pages) {
>> -		isolate_freepages(cc);
>> +		int i;
>> +
>> +		for (i =3D order + 1; i < NR_PAGE_ORDERS; i++) {
>
> You could probably just start with a loop that finds the start_order (a=
nd do
> the isolate_freepages() attempt if there's none) and then handle the re=
st
> outside of the loop. No need to separately handle the case where you ha=
ve
> the exact order available?
Like this?

if (list_empty(&cc->freepages[order].pages)) {
        int start_order;

        for (start_order =3D order + 1; start_order < NR_PAGE_ORDERS;
             start_order++)
                if (!list_empty(&cc->freepages[start_order].pages))
                        break;

        /* no free pages in the list */
        if (start_order =3D=3D NR_PAGE_ORDERS) {
                if (!has_isolated_pages) {
                        isolate_freepages(cc);
                        has_isolated_pages =3D true;
                        goto again;
                } else
                        return NULL;
        }

        struct page *freepage =3D
                list_first_entry(&cc->freepages[start_order].pages,
                                 struct page, lru);

        unsigned long size =3D 1 << start_order;

        list_del(&freepage->lru);

        while (start_order > order) {
                start_order--;
                size >>=3D 1;

                list_add(&freepage[size].lru,
                        &cc->freepages[start_order].pages);
                set_page_private(&freepage[size], start_order);
        }
        dst =3D (struct folio *)freepage;
        goto done;
}

>
>> +			if (cc->freepages[i].nr_pages) {
>> +				struct page *freepage =3D
>> +					list_first_entry(&cc->freepages[i].pages,
>> +							 struct page, lru);
>> +
>> +				int start_order =3D i;
>> +				unsigned long size =3D 1 << start_order;
>> +
>> +				list_del(&freepage->lru);
>> +				cc->freepages[i].nr_pages--;
>> +
>> +				while (start_order > order) {
>
> With exact order available this while loop will just be skipped and tha=
t's
> all the difference to it?
>
>> +					start_order--;
>> +					size >>=3D 1;
>> +
>> +					list_add(&freepage[size].lru,
>> +						&cc->freepages[start_order].pages);
>> +					cc->freepages[start_order].nr_pages++;
>> +					set_page_private(&freepage[size], start_order);
>> +				}
>> +				dst =3D (struct folio *)freepage;
>> +				goto done;
>> +			}
>> +		}
>> +		if (!has_isolated_pages) {
>> +			isolate_freepages(cc);
>> +			has_isolated_pages =3D true;
>> +			goto again;
>> +		}
>> +
>>  		if (!cc->freepages[order].nr_pages)
>>  			return NULL;
>>  	}
>> @@ -1842,6 +1876,7 @@ static struct folio *compaction_alloc(struct fol=
io *src, unsigned long data)
>>  	dst =3D list_first_entry(&cc->freepages[order].pages, struct folio, =
lru);
>>  	cc->freepages[order].nr_pages--;
>>  	list_del(&dst->lru);
>> +done:
>>  	post_alloc_hook(&dst->page, order, __GFP_MOVABLE);
>>  	if (order)
>>  		prep_compound_page(&dst->page, order);


--
Best Regards,
Yan, Zi

--=_MailMate_BD14FE1B-E5CC-48E5-91A1-105DB631D11D_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmXGg5EPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUavQP/RqgKMfm+7xK0zxvY+z6MYpwAT3ub4jOjWb2
ttzl25IopNd83ZobvW2SmJkdV/DB5BFL3kCv45Zn+go/fuk8uR7AldA4kE/S1s/W
QXDnNpmqvH8bN1+kHnEX4erwCvWqN7AXF0DqppLX3JI+bd3l65+MoW6gq0aWvz81
X32xr4yl826Ox5/3H0wT/u4xlccwSz1emXVcZYjdHit6CvC+1XthWFY/8kJVFQnF
05/Rz58qbBE4iBU9DjuYZQ9B2DU4U9DEwfvYETIaaVDv5OaQOGxF+QAG3UZO2eLc
gFUXQ8/Q18xCooo7fQUAXc6uIaVQkEsZWNsJ4eVzMVqgZzTK5gEEcIEd30NUNjBW
6aj7v+5gS3a3QeCfY+NqhwNXMulMua9nJDgGvppsmCK+ZQojZAY2nValPUXU4wtt
1p4Bw9G2ATay2LOV3CyfhQT29rMIZYZjjZMC3gnrv78jKNgWTg23otnTHJNVUGU2
CkGBbT2h7bmMhCZH53jaEItghtXNZsZ0Cv/eMmSN/UHzGUxSLtIfaAakTaP6rvPr
ibjskAjGPgPCcO/2Al/oRGJvsFM1OTsBAfsshLDp5+tW0sYUsb/FZVPz1864y148
qSYHAt8v70JrJKIorpQj7NWT/9zv3XJ4m+mo+/s3s89YbXT+i/ATsi/X+vo4Clwn
XtHTPElZ
=/ciZ
-----END PGP SIGNATURE-----

--=_MailMate_BD14FE1B-E5CC-48E5-91A1-105DB631D11D_=--

