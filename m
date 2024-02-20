Return-Path: <linux-kernel+bounces-72217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7518085B0E4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 03:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FA09B22AC5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 02:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA53522618;
	Tue, 20 Feb 2024 02:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BCUbK/cf"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2088.outbound.protection.outlook.com [40.107.212.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0411C4A3F
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 02:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708396298; cv=fail; b=LB1o5xj4j21BKQP1rmiTYA1iJvD0IxSaJVkQPbDRwmVGxzuUIx08BHhhwb6j2j2pZoIJbFMrbmqMCWtss0HjbTrDpbWrgLKaOtRNIATIhpCrTNrv4cX+DkrM7Bkgk9XJDcAtKF6YS2ceaaN96kNmkPNgt4Ozi3zpfeKVHBRooEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708396298; c=relaxed/simple;
	bh=dduce0s9WiphsSqhBzcU8Rz1K24/K1c4a3NRZvqQhlw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OH4zw6B9nkl70c7/i6ALFr0ND5UL40jF68fF+QQm0YzpHuGuxd4QpcpsHBAvJC7Z3dojSGDb7RuUjaB4IJiadf2S8IX3QWH7KKb3XexVTY9Jss73nROVMthzhESB5El39vVusQheoADfWYoDJRD6mQiVtbYAjJPGfte73haVWMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BCUbK/cf; arc=fail smtp.client-ip=40.107.212.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GDhoG8801zgwG9KUcO0raGadEINWaYIB8HYBiAdrg5RRxtjVdVKgFbFNYzEntIEIRLufSywsUJCDznJAX22UNu1afzDVNuJWESL9eBauk8Uf0qyHrX+PR3KX2Cc17UItOyYCqrj0GQI9gcuXxTPop18Sp7RgXTSGi0NN1KyVn4LiNWl8BPMoqyEsjssq5CRrBVo0HipgIqi3PRuGyE5Wqz1aLaOrNRUobVErE4EuAvIrCSgsUbf1fD108CRV7Tu30hrjhWQ9ilK95govKO+Mf431EMIgwFRXSTmUfgxUYRelPNZTjsBuKMom11rfAbGr1IME945kV5fc0EE0ymXHyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yBFOAxsRkClfoOHxHn0KyDPP/bm0reQmRDNhdWi3FRI=;
 b=kcSc4MlCCnoAfhO3/UuRMypuO7y2qByn1n6SK05yxTD89Rn5fLbwmvnlLfI4mtYiizhIJ3wZJuGcub6Ggiu6Oa3DmpsEYCw2JrELth7nezRkmpD8nWyhR5lWGi597KFf9WumjD4wBF3NxuqB5uqJaXbclYPK0X0RxCy0riJtCltA7/EW1PjjrGq/J29/eQvvwYnXJ1NjguGyRDzoOZw6cBT/nCoGcczaum7b4ngOFBbTv5yUiIhJSCNyxvYZslZTyxiDVer+aqNHEnioGbQQ3ZYDmksEI+tB3FGmmLRIiqleYtI4srJwAdNXYdXRkz5K/zv3Mg+ZUp0AGX6208QDPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yBFOAxsRkClfoOHxHn0KyDPP/bm0reQmRDNhdWi3FRI=;
 b=BCUbK/cf/1MOC576R5dB4uwkKu7FwTN+uud6iQWTL9OkrJihtKRMuZ+1Q4I24Laz6x80YWSY1OfVtHBtNrWe7qO1bwF29a2vj2SLoweRwHp1gCIibQUv10UBQmKaFjZWlruS6yUWYAv1xZ/htMVZHMYVrj6JmzSR/ih2D3Y5avGz92UFzmnJwqEFlut+pqhWBtfg9GaCIk7WLWENYSy86nJpGZ5/sF+KIPvYIrWFtkChlU6hPnJlYEL+uANR6bT5y10EkpIP9sNU2QyPldcZkoDmjuay49jJbK1r+IX+gtu5d5iCf51KWpAeGg4sR2Wd7q0GgbiGCpjuOfhvAxkKFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 SN7PR12MB7106.namprd12.prod.outlook.com (2603:10b6:806:2a1::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25; Tue, 20 Feb 2024 02:31:33 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::db3e:28df:adc1:9c15]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::db3e:28df:adc1:9c15%5]) with mapi id 15.20.7316.018; Tue, 20 Feb 2024
 02:31:33 +0000
From: Zi Yan <ziy@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 "\"Huang, Ying\"" <ying.huang@intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>,
 "\"Matthew Wilcox (Oracle)\"" <willy@infradead.org>,
 David Hildenbrand <david@redhat.com>,
 "\"Yin, Fengwei\"" <fengwei.yin@intel.com>, Yu Zhao <yuzhao@google.com>,
 Vlastimil Babka <vbabka@suse.cz>,
 "\"Kirill A . Shutemov\"" <kirill.shutemov@linux.intel.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Kemeng Shi <shikemeng@huaweicloud.com>,
 Mel Gorman <mgorman@techsingularity.net>,
 Rohan Puri <rohan.puri15@gmail.com>, Mcgrof Chamberlain <mcgrof@kernel.org>,
 Adam Manzanares <a.manzanares@samsung.com>,
 "\"Vishal Moola (Oracle)\"" <vishal.moola@gmail.com>
Subject: Re: [PATCH v6 0/4] Enable >0 order folio memory compaction
Date: Mon, 19 Feb 2024 21:31:30 -0500
X-Mailer: MailMate (1.14r6018)
Message-ID: <9E3E6CD6-45DD-4E7F-B6DC-0897F38D5E81@nvidia.com>
In-Reply-To: <20240219180617.89a0daaba45ce124ef01be50@linux-foundation.org>
References: <20240216170432.1268753-1-zi.yan@sent.com>
 <20240219180617.89a0daaba45ce124ef01be50@linux-foundation.org>
Content-Type: multipart/signed;
 boundary="=_MailMate_91B4B6AA-AD54-4061-880B-E976DD907551_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0263.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::28) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|SN7PR12MB7106:EE_
X-MS-Office365-Filtering-Correlation-Id: 64e3e360-6389-4485-dcde-08dc31bc0d7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vxaORMCl1iaOBuLQSISgVh4dMsG9NchocgfMAm84vTUFrP1gYDUXflA/554hZFg6ubdz318Nz5cORapH8IwU2DYHrsIjEjDdYYjrgy5fANVxPVYy7cpjUXV9weXxo9+Xcdcgmswlj8y/cbJIDExpl7EvPGLYPWEeRk0wvSh0QIodipcHOMkNhmRbKUH+g45XhwZv375dpfzLmkFCanGlTEsTm6f3lzOo22cSf2MFg0d5urkKAtw+YhiwVOJ059bg4sHktZCXViT/GbGHBHVsV42YWT4w9SL0JGxV5SNVn9d0APZmMwFARW4tw0TKHLv9+2h3Yxx+mN3spmrlYfEQKLzMDHJQULqvFVQk4GdreKbGvmo2GSb2piUr0jm/IubSyalqfco/4e8Vo+rhhjUzOhY0jOY2X7Y6Lzbz8Wu0Kuhnq2DvJv8gDmN92kia9hAERMnlF1h3WUhM4bhvAU/WuOlKavOLL9v0ZnWkIONphPsJJGvwhxNk7pOdRXbkqNsrsH+KBxissRC/Oj4yVDE1sIGlR6tsRjaFaywwTDfVUOUUQUjrOUPcDsOsW6TTdU2CODaJXcODsmp6X27PwnlXGw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r9ur4OKCLEIqGJw47cIAlDdLWnAtHyciVCtFycj2+ki7u7hlJAXrOmXTExit?=
 =?us-ascii?Q?9BkKsePeC/iEThK+nvvXvqrDxvEGahoEUHIaqxBmgyTdDnujkqfClrB+6qIG?=
 =?us-ascii?Q?hXyUivNtpPVpzYhmVsf3vmRSOHUk9B+1/0QM6hIhm2NxNwOFo6znSm7x0oCc?=
 =?us-ascii?Q?6PUoAh1Fhs7jRGpGGn3Oj0hCh9NWM/l2RQMNwlGaAOBAT2nacSqS12vfaTMA?=
 =?us-ascii?Q?XIqQVDFEpvS2k8LQwc1k1U7GuOFzpxQMGDJrECyRl9FBHLNWW9463WQ8k+s3?=
 =?us-ascii?Q?uade2F/79dfTshD0UE7d0E12jrzpmsgWB090JRIEGk1n1EzzHULk0U5Iya51?=
 =?us-ascii?Q?ChspX+uZiUeCy9lUPCuo48jbWIgIepDYV7aFWuK4IFt6mIx6iRVLg9JDGtx/?=
 =?us-ascii?Q?HcSgU6WN8mK05SW2OnIx2fe8jEqcVl8cuDuXlxu0adr0O9oEwTRrusIuOlnE?=
 =?us-ascii?Q?ingpUAB6m1SydN4auvyW7ZP/LZimtbmahd/FJJMSogyq6UbqLLCGZZf2vSIc?=
 =?us-ascii?Q?IWnPJtpQ5QRITVzXih1eluD2jTu9qhRb70Ust4mqt2qpUWpUp//Vhdm5z/E1?=
 =?us-ascii?Q?SMMhJ8YgHhJweXlHGvtj8+x62JGL2R7uZJazr1s3sK2dXC0UY4P9hjnapmJ0?=
 =?us-ascii?Q?iOSqeQWkaZcGSmCSJ/qXCQ8Pq7LGKhbwS9JIAu1nLRcS7FIs0v1TGlnqPdGq?=
 =?us-ascii?Q?JjEe1HGY4lb9gpHqm5YFcMjsmp4rCTUsDot/7tlhzGwG6fIUVw6UcAk9b3Q9?=
 =?us-ascii?Q?+Ql6+N813zLSIKIXDXlYR3Gg6PZd1oe95RtKFo+IXTFtVme2BBmw+ArjrJ9X?=
 =?us-ascii?Q?/JWipCiF1fxrtps5m6evKVljDg+4nBYQ5TYGRjpkw7UAbgndGDPgjiLNbEJC?=
 =?us-ascii?Q?7OJY+7KgXYoeUEpMCylyXSCVa1si5wEJWnjDUgKI/22uNYeaHExwq8Hy1xSy?=
 =?us-ascii?Q?ZTcFRr70BtUaTmm9UYHvxzkUHHmGSyOmGnNLPzZ3Kxad1Rmf4SzuEiLX0xdA?=
 =?us-ascii?Q?4xwiL9DExsmCV9Y45QO7a2Pcfton4eFDii8FfE4CHKfjgdcKRDFgF6aUkS5h?=
 =?us-ascii?Q?p5i9TZRvqE75fVSOPZVenx2NM3b62biL06t+Or0Bl0KGpvASR/fbaQXDiJSX?=
 =?us-ascii?Q?+1i7pFfj8ngPh5mn8sJcPeKVcU3GTfnGyCBUzBQOFlwBRghy02Vu98++v4iF?=
 =?us-ascii?Q?RaWTAezH2XgcaXhleQ6ikgJATR5TS+5a/AxBl629XZjcikQxgvpFxWmgx9HG?=
 =?us-ascii?Q?/jr6nTWhaj/sUwG4w+m1L04Rijao3QXC3Jtr5ZPWa9AzC+pXV+pPPf/J/wgY?=
 =?us-ascii?Q?o2V/pdvygKZHSOitdkskgSHlUSH0Cib7uQHCMN+rq3kb//P5ACLIGPzaTkdW?=
 =?us-ascii?Q?o34o+WQlx/Ldz8mn9kG81c8pLdTFPCAsVRRs2uRtsWJ6im4wn/VKT6hxamLA?=
 =?us-ascii?Q?haGkPfm8bc3y0svFPOiC9P/zDqEQkPf/4wDtpNpob/tIBtaqAAXvAHUmo5ju?=
 =?us-ascii?Q?C89GHBsTwo2zFuHKuMzm3H5gTt9NaWbHFzh6dml+3sxlqx3eq36mRHg/tYs0?=
 =?us-ascii?Q?rnog2fBm94clRtXmtDg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64e3e360-6389-4485-dcde-08dc31bc0d7c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 02:31:33.0796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HzMmeWq78eXtzeQ1ggCMmogmMLQy+Q4u6u+keYb2nrXHh15CSPCFHUwMguTQUxFC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7106

--=_MailMate_91B4B6AA-AD54-4061-880B-E976DD907551_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 19 Feb 2024, at 21:06, Andrew Morton wrote:

> On Fri, 16 Feb 2024 12:04:28 -0500 Zi Yan <zi.yan@sent.com> wrote:
>
>> Baolin's patch
>
> Baolin writes many patches and patches have names, please use them!
Sorry for not being specific. I mean this fixup:
https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?h=3Dm=
m-everything-2024-02-16-01-35&id=3D97f749c7c82f677f89bbf4f10de7816ce9b071=
fe

to this patch:
https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?h=3Dm=
m-everything-2024-02-16-01-35&id=3Dea87b0558293a5ad597bea606fe261f7b2650c=
da


The patch was based on top of my early version of this patchset, thus
uses "cc->nr_migratepages -=3D 1 << order;" and
"cc->nr_migratepages +=3D 1 << order;", but now it is applied before
mine. The change should be "cc->nr_migratepages--;" and
"cc->nr_migratepages++;", respectively.

>
>> on nr_migratepages was based on this one, a better fixup
>> for it might be below. Since before my patchset, compaction only deals=
 with
>> order-0 pages.
>
> I don't understand what this means.  The patchset you sent applies OK
> to mm-unstable so what else is there to do?

Your above fixup to Baolin's patch needs to be changed to the patch below=

and my "mm/compaction: add support for >0 order folio memory compaction" =
will
need to be adjusted accordingly to be applied on top.

Let me know if anything is unclear.

>> diff --git a/mm/compaction.c b/mm/compaction.c
>> index 01ec85cfd623f..e60135e2019d6 100644
>> --- a/mm/compaction.c
>> +++ b/mm/compaction.c
>> @@ -1798,7 +1798,7 @@ static struct folio *compaction_alloc(struct fol=
io *src, unsigned long data)
>>  	dst =3D list_entry(cc->freepages.next, struct folio, lru);
>>  	list_del(&dst->lru);
>>  	cc->nr_freepages--;
>> -	cc->nr_migratepages -=3D 1 << order;
>> +	cc->nr_migratepages--;
>>
>>  	return dst;
>>  }
>> @@ -1814,7 +1814,7 @@ static void compaction_free(struct folio *dst, u=
nsigned long data)
>>
>>  	list_add(&dst->lru, &cc->freepages);
>>  	cc->nr_freepages++;
>> -	cc->nr_migratepages +=3D 1 << order;
>> +	cc->nr_migratepages++;
>>  }


--
Best Regards,
Yan, Zi

--=_MailMate_91B4B6AA-AD54-4061-880B-E976DD907551_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmXUDwIPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhU1xwP/2scW31WY6BuNDH32GynKkspeF9kNCW4YCoo
QrzuNJ14FyqKisu2X8KkYm6EmXd57DPMZBjDJgKeDQk6dpTqBLq+9KYP5yz4xkVP
k2Qe32kRt/rVKQQ8LIhRylo8ZqN9zqA2JTDCpFlA55ZX6kp1abRk9LHbRfv/5tMO
Wb6pJQ591TCRltTs6tIyNys6xRr1/5LTpEg2RsiJroSjfxQJyjlpke7XfxROUOan
IEaUejo2lGaXxeOkYmdKeHPefsdAN92j8m5NIhz1vV377D3MZ/i81obR3hlbB3pD
wS0gTBIKOFypyRf5CukisbwtrpgkVZ6pSI2ktsYRjoas3EtjO8n4KtdCNyEbmIeD
Mmve29L74+7H6uM/oUSDDnZ++LtXWF2q9+2056qoQbGvVpwMVrSSxVZchM+v3oid
0YnEG9k0UOTN0YPlNedHtpLUzVmrIgit+TH1QyNAK0BHbCn9x2DN50PNeQ138r7X
wwilQfgPfobCxpR76r+vrYepmJpNw/fIg+cNKjEreZMQTPyOxgpXEcQiQZqqF+j0
JyV86mJxYRpKq2HrgEB0sSv89/QAsJZgXV+l58Rx+2YmGhAINt557Yctixs9/nY1
+TtiaplOlJt3GCZV4JO/sNvT6fUOa5HKvy4xBA/VF4oCd5rSIatyrxhr1QgeQtRL
MlYLbDgY
=h6ca
-----END PGP SIGNATURE-----

--=_MailMate_91B4B6AA-AD54-4061-880B-E976DD907551_=--

