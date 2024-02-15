Return-Path: <linux-kernel+bounces-67414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A966F856B13
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3162A1F232AE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACDEA1369A1;
	Thu, 15 Feb 2024 17:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L33WtJAg"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05992132491
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 17:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708018365; cv=fail; b=Tamz2TuLSxUGlDul3wuV0XzDC/eT3MgtJ0QNvRGztHZY40QEtD4P5sWuD6jzuQS0AQkh66bOiVvgCmSPBU122N1tsW0PSnJQzJUEMeoeKdpQQDjNcMgq0zzS6ojGV6PHa922x0wvrAoSj8pkUqPesmkN3i0i4Ah7Hw0VEhj0P+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708018365; c=relaxed/simple;
	bh=Z4K+DqhL0JuPYO0xAz98iaIFTF0ySnlFGewnX6AxckY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fTCQUQrRl8ZRMMD6uQdGW1e99ej/HvmfNBsis/tU+5UpJeDNGedKLvmmalBYIeXw9NBHmt/QXYFUctEoRLSxvYpl/K3fps+M5DvvVY3SN6vXsYy9sPI/dVpk+1yghdi8mSU8nVtq7WfEPaLpFevX1QV+6it8MgbHVAputmQbndM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=L33WtJAg; arc=fail smtp.client-ip=40.107.243.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KmBE5ejNrnP9msnz73E+Q3XidHIqFKMoXkseyuUVYtiysq6B40583JNBN9E8M335O5F7phfQ8YsiOdVbfSuHZs6lhCsDkpJxoYfecXxVrzOD21mVyoY/kr89wfPKht7z5ufkdwu1Lpttku1mOVsQEQgWlCXBmkWRBTkjOqp6D6NBKoGeOWx3Wx9Bkj9VMFP1h/dV3DkjWZe3qcMd4Ca/rFJCH+hQTagn3vScTJ8ZtbKkCW5A+edr1B4idQfnG1GAV3aiXSsMfSDHvtnWUO88PcMk+LPfyl96/pXnokU8adnzOx5EJcI1Z8bYi+X75AYGsgpLHXYZQdBnSaktaUZtew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2sVJj5poaidBE2oCZr4NSJcUHUJPmUa/nW+UukKB/Zw=;
 b=gwUbx7l0XojAO8x+N1WEIExo7+xkaLmQGC3VZBjyJ4o+lc7ToM/FejaxA/mqYe4LC8V/FYoz6I/dyDNssvhV/Wtqs7l05sh3LGvCWE8qKl9Z3yHxIsuUTAybxF14Rpm8Yu2TJ/Pw3xVR+Z40byPGGK0Fht+/UL7KUp/VBir7tt9coooVd7dmzYm4t7mIj0j34bYKZJLVc9lifybvwRwVj7Yq06sUNwF4FUxRZ1cue9pGlon7giSIZQTbNI+2q2LFmap5E9JxFk5R08YpFnysyTAjQt5edCkwj1kEZvTlBCG3IiP7wsN9zM9RIfHmekNzyG6IyNOlSPCx+s8Wp82nqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2sVJj5poaidBE2oCZr4NSJcUHUJPmUa/nW+UukKB/Zw=;
 b=L33WtJAga0B0jT08gmkLL8y44v64aGwDXFHzqAI7I4QJATTIfYbycatPQIn28rIPVJBovWBwocKIPa6qxD02uycZS39wGgi23ewMv2zYnr6pvElWUuNHeWTTO7gOqFXeYk17VbKX7sCvCiup/B6nxAEsJXp5nLi8UjEicixLQLrLmogpNAl4GI0PDnsPtxOevYFjdbN2gBkwBp2LM0Z3UXCSPzaLwxn6/ujyDoZYI3WMqh1NVZeT5s+J/NjisVlC3+Ili+87lJsxAW8bGaCuiYWE+Cvzl9mdUyBkxk6RvIuNoYI1Erk/YcQ2J+MwbcHShdDRLhlUK0yFxxKOTqoAIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 MN2PR12MB4221.namprd12.prod.outlook.com (2603:10b6:208:1d2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.12; Thu, 15 Feb
 2024 17:32:41 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::db3e:28df:adc1:9c15]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::db3e:28df:adc1:9c15%5]) with mapi id 15.20.7316.012; Thu, 15 Feb 2024
 17:32:40 +0000
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
Subject: Re: [PATCH v5 2/3] mm/compaction: add support for >0 order folio
 memory compaction.
Date: Thu, 15 Feb 2024 12:32:37 -0500
X-Mailer: MailMate (1.14r6018)
Message-ID: <CA1FC23E-A652-4DD9-8E79-4956B2E11921@nvidia.com>
In-Reply-To: <6a011e7f-4e21-4e31-a9a2-52cba3181337@suse.cz>
References: <20240214220420.1229173-1-zi.yan@sent.com>
 <20240214220420.1229173-3-zi.yan@sent.com>
 <6a011e7f-4e21-4e31-a9a2-52cba3181337@suse.cz>
Content-Type: multipart/signed;
 boundary="=_MailMate_205074A5-792A-4557-9DAF-47AA18B14C18_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BLAPR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:208:32b::27) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|MN2PR12MB4221:EE_
X-MS-Office365-Filtering-Correlation-Id: 3112a652-00f5-45ac-1dbf-08dc2e4c1c0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cjM5lrJBLNJdfCm325xxZ+O1M9yrgb+EIyQF3+kfxGKMOOtx+6Za2PBnG2+7K/N1VF88AIZ/2z3RcaFM9sAB4aQana09WLEwaAuRPXoWAlRRtko/48Pgwq/igrCLGKgABPM771KYV84/lg8TPlvFDacHfaEXvb5iwiWLuWbSFOSLZXb96zuILBDq5MqE6zPot+xqbR1UUutk8X8vs1JLmPavB97b66M3GMEO+JK766n+nj/qd228oq0bmZIggaRSfHI8hWFFHEuGs5KVh6PN/NoqotDnDESAPdNPDIauz7au/9Gbpt87yNK6SvaQmk++LLQCVrUqocW6yr1oHF6Zbv47VwNEJuW6PlKLKshQt/Jh1oSFPankicgZUh6M9t+WFJ4DQKP728fto2/DJJFQ2/U/TcZOeQbz5F8UeypZIMbxwhaYwCm1uW6+m+2m5De+yh7ZKn+AUkbrJnDYigDIis7i30a2LcuaGtfKvJFFv9BK8RvVpUvI3lezLc+qjG/TQOkMT7h+AqyO7JlsA0HeRJUSka/ZmsijtYICTdF3RV1rDiHJlGoaFz2fwLACVy5e
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(396003)(39860400002)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(235185007)(7416002)(2906002)(5660300002)(26005)(83380400001)(2616005)(8676002)(6666004)(4326008)(6916009)(8936002)(316002)(66946007)(66556008)(41300700001)(66476007)(33656002)(478600001)(6512007)(53546011)(6486002)(6506007)(54906003)(86362001)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+PoENVJ0SNMNUQyzYMwQWvIah49jbfPieFh/5K9ewFlacjGKqsvv6FALPKa4?=
 =?us-ascii?Q?bUtDuWv51YJjfni/d5DhlTXIhtQys7Rvb1r4EW53kIq88tS6Y+UPQ8Ix7QeQ?=
 =?us-ascii?Q?14ANPl7tCLxgcRzy1NzT1AQHyWRmyl2b4cPUxdU13p5NABsGqAR5Rbw5ckNw?=
 =?us-ascii?Q?5GE0rM7HkDG2244oUFFts4mnvA2dKbEEAxM4409Efh3EoLmiz71mmYNkA04B?=
 =?us-ascii?Q?c8D3TIV6cQPeQQs8pji3IVLppTy43YW0kKXvSfXsb5/wA6KXazCnTvE3Bxnq?=
 =?us-ascii?Q?Xv/NXnrwAD1zbyRPjzTFE0XywwOUzjXFWTTtmz5zRmNnca6MifQ8JjRR6jd8?=
 =?us-ascii?Q?SzW89zw9kZAMbyPsKXbKvnHT0m5AQhP947Z4IoBbUlRcZr9rRd8UsDdStRVM?=
 =?us-ascii?Q?Mv6oDrB23B4CsUS+WnreFoaML7Dnrb5MiEMXJV/R9luNuI3d+vkzGV4RQeBm?=
 =?us-ascii?Q?fpbtDBFBgs4nvKTqel3FOgv4XP70OG6JCE37id3cXF6aA1lJAu/ppaxMQ7FE?=
 =?us-ascii?Q?X/gLZVne9RqAbgXfNlyxMufBJ9FQIdu6AfbpJUiZfiLX0NPfud4txQpBYvn+?=
 =?us-ascii?Q?+fRVPtCgBUWvvjO5AZ0xPdOBwxOCBJ1HHVw3Z39BSpVnxcnGsi2vrtnSbQdC?=
 =?us-ascii?Q?0RkeyafV2RljxRXP+j4pqzkCArewlg0SEbcLFSNF/RLY9OUMoSDQGTU4LWQJ?=
 =?us-ascii?Q?HZx5NsznELGp8cNzl+taREZCIPCwK9cwW60PrBa9qSJ+/3FokVZ9PWAabstK?=
 =?us-ascii?Q?nzM38hXXxOZIYgR6OZQtWLd+ZM/PiMcgWTsRukux5nhnOeE3VGHO2VIUaETn?=
 =?us-ascii?Q?4TSpjStcD8frB53I0siXrMttcJNXom/mSWe7KuVQODOPzxEeumtsPhYF33IV?=
 =?us-ascii?Q?ufSKpWI8qr2P6khOaJQ9ez7FExXk6v9K5G3Yw6nNvCsj5qQz0IqTZ7p6H0rC?=
 =?us-ascii?Q?CbNUqkJOxa74zbtZPL4Mva20TSwvIq6LGeUmdq1566uMa2uVznnZN1twCJSn?=
 =?us-ascii?Q?ttdjH+iGtftXORAiYSUDPjJK47Q9BP4whTtg+WsdLAjTQiy1LPfsvAKDCNyz?=
 =?us-ascii?Q?tovCGR0kMTtMA1M7tEuPfsPOvmsKzWZZX4yaqVTf/NFXzdcFZ/d2Nb+y438V?=
 =?us-ascii?Q?RimViVKp3j2HGRhHlMr9vEtPu0xWU8yx4kXkKEXlUfW4Tsa9pBxeSQnYoTO2?=
 =?us-ascii?Q?/SWqilfqwXuZ4wWSZN7fxFQTZhTiJmW2piLY/HUl4Znd06UlBEFdysieKdwf?=
 =?us-ascii?Q?awpr2cH9+TEqG4JyLz6pZXLvWH+MRlFBwnW7YBkUGb1KzQMTmHSHanoS0rbu?=
 =?us-ascii?Q?4AeQSTx4fbRmWvzGyi/X5w91Uz5zPgPwF3/MYsKl3Smtd4uQX/Uo4ia913/q?=
 =?us-ascii?Q?whuKIcVu3LYFlFCtLulaVCvk3UeHEIoLMuJ/OYHvYjMIkRKw/qT8LtEAmh9R?=
 =?us-ascii?Q?AG7ikD7F+dtDNQGhtcphQqu6emHrzTYC8S7ZLzJK0fEhJSXrec3YRTfeuyO2?=
 =?us-ascii?Q?ZGUFN7J5ptanP1nrLcJ4sTs5W3Co3e87eGBO4A4QHDomFfypHTWkjxiHZMkZ?=
 =?us-ascii?Q?4uEMIq+G64UEA9MtuegAQEcKiHql3+nehWJyXzDK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3112a652-00f5-45ac-1dbf-08dc2e4c1c0d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 17:32:40.5472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1D2iLpT0HoLCQ73bmfaY8eORxcDLCo75JOkOsrRAS8xhLWJRcifrMSH6gSTZ4a5y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4221

--=_MailMate_205074A5-792A-4557-9DAF-47AA18B14C18_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 15 Feb 2024, at 11:57, Vlastimil Babka wrote:

> On 2/14/24 23:04, Zi Yan wrote:
>> @@ -1849,10 +1857,22 @@ static struct folio *compaction_alloc(struct f=
olio *src, unsigned long data)
>>  static void compaction_free(struct folio *dst, unsigned long data)
>>  {
>>  	struct compact_control *cc =3D (struct compact_control *)data;
>> +	int order =3D folio_order(dst);
>> +	struct page *page =3D &dst->page;
>> +
>> +	if (folio_put_testzero(dst)) {
>> +		free_pages_prepare_fpi_none(page, order);
>> +
>> +		INIT_LIST_HEAD(&dst->lru);
>
> (is this even needed? I think the state of first parameter of list_add(=
) is
> never expected to be in particular state?)

There is a __list_add_valid() performing list corruption checks.
>
>>
>> -	list_add(&dst->lru, &cc->freepages);
>> -	cc->nr_freepages++;
>> -	cc->nr_migratepages +=3D 1 << folio_order(dst);
>> +		list_add(&dst->lru, &cc->freepages[order]);
>> +		cc->nr_freepages +=3D 1 << order;
>> +		cc->nr_migratepages +=3D 1 << order;
>
> Hm actually this increment of nr_migratepages should happen even if we =
lost
> the free page.

Because compaction_free() indicates the page is not migrated and nr_migra=
tepages
should be increased regardless.

Will fix it. Thanks.

>> +	}
>> +	/*
>> +	 * someone else has referenced the page, we cannot take it back to o=
ur
>> +	 * free list.
>> +	 */
>>  }


--
Best Regards,
Yan, Zi

--=_MailMate_205074A5-792A-4557-9DAF-47AA18B14C18_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmXOSrUPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUSIAQAJEvcVHhEFlZmeB/Y6ktqtrrE610TjJAWxSX
xdSZg+jo32D1FtrbcdaofYxbUvmqHHCFDR+KIZTLXni4iT/49L/PgYSgOTs6Pktc
dEPBnGjuM3E2tQds0FeD+iCxyIliDAdw8o2RlTvdhtU/8XBvTWSJGPB6qFtajGGs
xHSD+MsPNKd0Ju8eLRFbJxjE5/kbczVYEb33oL5NSZC2/JkCiqnf7JD+FBWXHqT6
AH+uuECA3LLHeYdh/Q+S3wsZiXeFsfPXzhSIWU6DWRj3Re/URCytHHYFFn3QcEXK
cwH9SjYJdLrL6/AElVJuiEtAElEMKJga296H1IMmVL0SfEx6X/D98Gjm+U3nrZ+b
Q/fDLcXQHvJr+V+zourb4qQucmtkB3IP7NUPt73Axd086xQKUgS9wJhk9eOlc4fE
nUQUsiwyO0+Mx1WrHQFMHcFs4ZGSRhZ0SbLXcfbHE4/JrgL2NhWWFruBME09z4G+
nlRrlq9Yl0V1A/RkxqVWOu5Z+XjVGU3RAE9zRHEvnz9b0RRCt8OtCRYs4ZENNMYK
rDfQd4Kqkh7vnQ2/LeST93OE8xyOHxqilaXefm9C+6Pnx3GTt15Ycy9UCbqV9mQP
dgBa/vl1zxRkoYXLH9ZeNCG5H/2GeN7BwNrkui+/EbiRTPEhmUuU5R3QX81SB8Lu
pwip5S20
=7clm
-----END PGP SIGNATURE-----

--=_MailMate_205074A5-792A-4557-9DAF-47AA18B14C18_=--

