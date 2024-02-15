Return-Path: <linux-kernel+bounces-67636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06158856E43
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 21:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A43F5281D29
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E75313959C;
	Thu, 15 Feb 2024 20:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GPyBycqk"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2083.outbound.protection.outlook.com [40.107.100.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B894139594
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 20:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708027450; cv=fail; b=t9G+H7o5PoI3YTe7Eq6+/8m2CN1C+Ef3mlY57TUedk0KsSONynG32tZEqFc+bdEV/enJAQZ0y7i72aegaRCsN0AcF0uLOtOdfYEcGd4qPmPfdV3wizkeEkhEqjPNkulChltPNpXeM2RK8Vs67xA+yUD78RZYvXudZFx0OK7NJPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708027450; c=relaxed/simple;
	bh=yvZlK7ijXLozky7Xvs9xEeyWJl4K0Ggio7TADHQfZHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f7DvMUV0LnV5hYbWGtFIfNez9MvPaKTi65dhEaTVinqVs9MMOa7iNXvl9xNB+1ope0IHWliurMoE7TN06fFC5/VdbIScTVmci+LLQlqUL3R2VD5Qt5bimW71TyqZpOR8Dprv7L33jxd47f2hrMSArTMYTIqWrJllWJXDnKjZK04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GPyBycqk; arc=fail smtp.client-ip=40.107.100.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CqMqGf51Cl2kc6bUm9WC+hqH/96iAhN7nKbiRXyQABSbDX5wD2PcN0PY2h3EfDHlgRaNXuUkIhnKINyUMqTcqWG0XWwUOwy+yifjw2XzNs4fcHt6iwauduBuqcRWJZYz8/ge17W3ROUVCdl3Fx8ettZaSWJ+AJwTnKlnNMR8DxymFWSJNw3bxoeuca48hNW5JiGsr3l1eRrkhjYesiV4X8xvOHNzkXubSvS+41Hikjql7faxmPqWUJAt9nhEfGW6rA6vfEd6syvMaw7EUSyHsqiAWbbCIAM8zoFmlXdI6xX128KodcOpevpsgd6BecqiOnP1Hp8WyO9U/R6PSNDcQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yOm3O0NLo0/gLtHchoIkW4qWCf8MGvQFJDaUUBOgnSo=;
 b=BiRxDmVbb7npcR+LjCcXToVgc4OiXIZBfVE3414+aRL+jit1ImUJcmeXBEDWO+QD8WD1GlZjNZoAS6jk6VizdY0K2JLMkoK2aSAoiosFbM1Q6464zhseJNXKsIVuqfb4qzaXb1T6PcupZiS3FvNiHsov0gVm4DTwXqUKaCLZVUY7garDU850JhCSt/317EHdzpQOGnfdrMx/TxQm/kRceJc/I093mFI89tQRraTcmaauBI5YLsqDWrDSpnZYxzfXPDThNmf33wHY69lFGnm+rBoxcItOWdipre+CCrdmxMBxKXeZvWcYxBEHjA9UqEYJxXouT+dw5iPKmZH8TGua1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yOm3O0NLo0/gLtHchoIkW4qWCf8MGvQFJDaUUBOgnSo=;
 b=GPyBycqkFrtCRGnYwzdsC1P2w08SYkyX2KKQkYX8uMlMgggQfYsSvfYVFsgzzjeHPs4ilS0oOZtEFm6Yodxd5MIUq/g0BJwHVQv/8epugUzwU03aQlBpz69ryHN6Y014hO9k0vobgauHjs5WFP4vB5UMb4rYBHVsJhDqEzqbk25w8uFDlU7ELgeE2J5fKdyNS+OGverGqUtDQzczLAZjavkEqnPVSQdq+zZYGV8yD+SZpQMHKDeyVK052HlwZ1MzcevfyoD461ji1c8CVymwxZDn58PQ933v3irYmh4Xvd+NkSRt0/GG/pvqpKQjsVJDDKQbfZenwNAGd3jnIHqWZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 DM6PR12MB4249.namprd12.prod.outlook.com (2603:10b6:5:223::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.14; Thu, 15 Feb 2024 20:04:05 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::db3e:28df:adc1:9c15]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::db3e:28df:adc1:9c15%5]) with mapi id 15.20.7316.012; Thu, 15 Feb 2024
 20:04:05 +0000
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
Date: Thu, 15 Feb 2024 15:04:02 -0500
X-Mailer: MailMate (1.14r6018)
Message-ID: <8FFA6A77-59C9-40E1-B999-C5C9EB5A2643@nvidia.com>
In-Reply-To: <25a80b95-93e6-4d68-a3b1-35cd3ef9c421@suse.cz>
References: <20240214220420.1229173-1-zi.yan@sent.com>
 <20240214220420.1229173-3-zi.yan@sent.com>
 <6a011e7f-4e21-4e31-a9a2-52cba3181337@suse.cz>
 <CA1FC23E-A652-4DD9-8E79-4956B2E11921@nvidia.com>
 <25a80b95-93e6-4d68-a3b1-35cd3ef9c421@suse.cz>
Content-Type: multipart/signed;
 boundary="=_MailMate_B0F46FDC-2DBD-49E2-B04D-46C9691AD48E_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0063.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::8) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|DM6PR12MB4249:EE_
X-MS-Office365-Filtering-Correlation-Id: 319520ca-b749-49e3-e4e0-08dc2e61430e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DkRH67bqgZtmuOpoUbpAbAfI76Xsqyd2hUMdNeRLSiEYDNl19MeX7B5QCSnbdDOsnTfzOcHAyRuwuExuqvXfdjjLr5lISTDGfwMDieoetKaBxE9BhFWsCD5RaiOpkRaZ4LhqTmv0L4ucNaR4YjrT00uP6Tg7eSHNk3ndYvdOVd760a/z74cSpiLiQmKtyzIOfm+Zn6cSlQ7iksCCchOlIymNST98KMd/CGIYyiN9wQNOCAXfgdLGiAOKXR/20IlJ3TsBlYe5zsq6y6NIk2np+AxVpzYCnBvYj+nx9oAMOqokP+RPVkgXXyr3wgnzTRPpTmKXxFgYnkwLBxirv8PE6pqUSBiSCzVqYTPfPj8jK+lkSNcGTMVE+eS/iN5ACi+rbSZVRUnJ1WHCpzs3+nIX7DB8/lkS52XutQDEiOSeMB51dJif2Pzh2aUYC9QhrFSPx+mQL06uqTXVK1YQzi+/lYQTh2jr5emirLDbALJVTa0IpRPZyEx/bXPon2x6Dk85/5zAhEPev7dPD0inggNksbJnCNMYJEjXplb5hMZqXbqoA3s7nX8VyXxEODWhNLRJ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(376002)(136003)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(2906002)(7416002)(235185007)(5660300002)(26005)(83380400001)(2616005)(8676002)(41300700001)(8936002)(6916009)(66476007)(478600001)(66556008)(4326008)(66946007)(53546011)(33656002)(54906003)(6666004)(316002)(6486002)(6512007)(6506007)(86362001)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LpQ75dr+Rz2Ysy3CeF7cglTp+kB9HlVrXFQHiuGUWDgcGlQJGLeGbSoNKC7I?=
 =?us-ascii?Q?bLcJ5tlfSsx/Rkqr3oMhlkeJxCy8ssMMGd+WVeU6oi16cLQr1rMCJqk/Q0CX?=
 =?us-ascii?Q?VTR0+l8syAP75x3HB5haAwEcFJO5tp035/s87tZGUhg68XKWhW5oQfwuEcek?=
 =?us-ascii?Q?k90rSttHrSRrFVZz757Ur3m/570bf6zq29Iy34w20W+EHvQ79ub6qBCgMDBa?=
 =?us-ascii?Q?5lB1QsW9dNz23j52FNe5BsRB9SxCQ9fyrOhwDwrkhRiPecgojQ8LIl33xZ/L?=
 =?us-ascii?Q?T9HwPUX0dSywFFyCvEBa4tfrUHwhiyr80K418iJ/y03/Ra5O7Vgl8lB49syk?=
 =?us-ascii?Q?D+iM71Ok1HkPOgb+3p2ubBLETc/2bASoP/e+NDvBArHdPMapOE/4gfzMmfaK?=
 =?us-ascii?Q?ie7wLuvRT3aRLweTY8Jn3TyeWq/7I/i3Gmh6hS9ewU1KsLiGmbtHdPY/8U5Y?=
 =?us-ascii?Q?lJLxnLFlHNLBLsYebNDt6r5bOjVauGqjzoaUiwLXx+Zc5B+VVZ/e4LGJdDZg?=
 =?us-ascii?Q?GzVTKyXd+w+EkGi3VvVLxlVhXyi0olGDLKtE4DuHaFttQVLx+pYtaACd4hoj?=
 =?us-ascii?Q?8Q2AO58lXvSwOHmusfJDTEzhkmSMP8qWNLHSYlCLtRofRH88rRb2Mlx8VAUM?=
 =?us-ascii?Q?c2ut6RG1V7rQgrW+E/ZF/uLw+6FVDc62krNWQmtTVjVxfoNPk/L6Whzs8Y26?=
 =?us-ascii?Q?LGC781cK3w6SZ32TDPiAC+mhpF8aXuYMFhpVIYT2OsGkIuKK3BbLXN0ViUBW?=
 =?us-ascii?Q?v4jsOHTz5Hzop7OnnWAFKt+qLYRr2i+JN7k2sT0pRPAD7wqnGHVDHwTR8lrR?=
 =?us-ascii?Q?cByzK7eXEr8OIuU9dgAKSw8hwwdeogHYZQRXzMWgTmRHpKuq/jA+Pu51YXB8?=
 =?us-ascii?Q?e3vqdTllATGgZskoOHU7wei+UPY2WZAwTHMKmp++jncgRl/SWcr/fqb3a4F7?=
 =?us-ascii?Q?Luqu+L6JyH7Jwo8scKpNiNXp5VcB++CzL4Xgl8SUvEKqZwM6OoR1dfA+1t+U?=
 =?us-ascii?Q?GrK5eXobib5lkfcDqwr2CO0ufJK7mVFyHnCyMKmJ/+Qo7JuWmMJQtcIRGS9Z?=
 =?us-ascii?Q?AmBk+6iCjfhfAmSrEGgTKb5vKg5sKga4WfU+TVXCLV7kH9yw6uXuUnv4sYjV?=
 =?us-ascii?Q?A+e+3CG1O0E4iVpLMdudg6HCrUZSELPcNtnvReNzRMB+0oJpTpfZghboStkT?=
 =?us-ascii?Q?LLvWcyj8jdriemuu6SPTbH5SJCLCSALUgH9fR8XNdU00oJ0Xu38AnFupFUYL?=
 =?us-ascii?Q?/qTHnsgpcFibQmjQwPCdwn+8PjbpffxSk/+F1cgwp6AxvGiWhCpd3tuQknnE?=
 =?us-ascii?Q?5Us5j6NdfFQguYdC5bnflZzF5sc0Ee5SZ9fVZe09SYg3hM16cIFa6YiLMybJ?=
 =?us-ascii?Q?FcVT4xuN5aLxoHz5FKo5mgMB3Wzz1c9tR7vSK130f/WJMyPyD9uRBVEjQkaR?=
 =?us-ascii?Q?A9GtVzHFsjgdIkbfU/kTZNPxZGS5zgi624y7UDMMrwrNus6PBr0zge3UGqyf?=
 =?us-ascii?Q?NSn3xLE/A07ZF3wCCcMhPywKYvZuJ73zHfl7W+Mki7ti50Cq5XuEuyjt0izR?=
 =?us-ascii?Q?MVZgUq0V45UHFEwEkZA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 319520ca-b749-49e3-e4e0-08dc2e61430e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 20:04:05.3139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YyzpSxljkvbJPCUH9218L8waJoO4SIrGRXhtiIKGBAFht/RoT7AISbFdEGDcJSN7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4249

--=_MailMate_B0F46FDC-2DBD-49E2-B04D-46C9691AD48E_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 15 Feb 2024, at 15:02, Vlastimil Babka wrote:

> On 2/15/24 18:32, Zi Yan wrote:
>> On 15 Feb 2024, at 11:57, Vlastimil Babka wrote:
>>
>>> On 2/14/24 23:04, Zi Yan wrote:
>>>> @@ -1849,10 +1857,22 @@ static struct folio *compaction_alloc(struct=
 folio *src, unsigned long data)
>>>>  static void compaction_free(struct folio *dst, unsigned long data)
>>>>  {
>>>>  	struct compact_control *cc =3D (struct compact_control *)data;
>>>> +	int order =3D folio_order(dst);
>>>> +	struct page *page =3D &dst->page;
>>>> +
>>>> +	if (folio_put_testzero(dst)) {
>>>> +		free_pages_prepare_fpi_none(page, order);
>>>> +
>>>> +		INIT_LIST_HEAD(&dst->lru);
>>>
>>> (is this even needed? I think the state of first parameter of list_ad=
d() is
>>> never expected to be in particular state?)
>>
>> There is a __list_add_valid() performing list corruption checks.
>
> Yes, but dst->lru becomes "new" in list_add() and __list_add_valid() an=
d
> those never check the contents of new, i.e. new->next or new->prev. We =
could
> have done list_del(&dst->lru) which puts poison values there and then a=

> list_add() is fine. So dst->lru does not need the init, it's just confu=
sing.
> Init is for the list's list_head, not for the list entry.

Got it. Will remove it.

>>>>
>>>> -	list_add(&dst->lru, &cc->freepages);
>>>> -	cc->nr_freepages++;
>>>> -	cc->nr_migratepages +=3D 1 << folio_order(dst);
>>>> +		list_add(&dst->lru, &cc->freepages[order]);
>>>> +		cc->nr_freepages +=3D 1 << order;
>>>> +		cc->nr_migratepages +=3D 1 << order;
>>>
>>> Hm actually this increment of nr_migratepages should happen even if w=
e lost
>>> the free page.
>>
>> Because compaction_free() indicates the page is not migrated and nr_mi=
gratepages
>> should be increased regardless.
>
> Yes.
>
>> Will fix it. Thanks.
>>
>>>> +	}
>>>> +	/*
>>>> +	 * someone else has referenced the page, we cannot take it back to=
 our
>>>> +	 * free list.
>>>> +	 */
>>>>  }
>>
>>
>> --
>> Best Regards,
>> Yan, Zi


--
Best Regards,
Yan, Zi

--=_MailMate_B0F46FDC-2DBD-49E2-B04D-46C9691AD48E_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmXObjIPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUbRIQAJSqRDuq9E608suyLANOBkwzoy91swtR/YN6
cnfQ2PSPGvcddeapP+w85P5v5/CZm0pgA3cKU8y34nu6c95CLSvDSwNf3ZtSvvfc
KwVNdz6uAxcOEEkjkEkx6HBCg+4jH7eEBbYuRAjgwpyZGYuosOEaZ2AcLv2VmGAz
rX78GFykIE0ATq7tygglibHFbC4AF2GQ/fFL1XehwMXy+MrKr3FQahV4PnXXY2i3
LzqQgmHJmTE/qHhHorYHLR1SoDk8Om/yluRkvlD8I+6u1hqOSfuIgvG9wf/K2vVm
lVMnUTz+5rwPq9W3oABn04NwgSt42ZtQXbYamTzuXLOQyj9CLaWJO3B06fV219+M
b6d0VJf/tXdCuxQjCUogjjgE80YDs9WBdLLWYaWgU2/yNV+KXowyRBmzQRDKb9AK
LUJQjURm/3eNnD83YQ3ybKQyaV6cRLhM071IEHJPxbJK7uJpHAahZkMF6xyTV8bl
QPTrFkkYs+jcq9k07UIjfbT9ZKiszyJSzRnvyhS5qc/g3gvvVfPr4gfY9LNcRXhy
rEPxup4qkKuwbxk5W3j1LeDQDJTQkl2Y8YqcehKzpZwvftnWOZScXtUNayiF3Kj3
vNXaAnGIuChFFEqFcECGSDNXZUXbt++JZ0U3kNyIzMJMcC+GomWKu2Gk1680rZ6c
9fv3ob5Z
=QopK
-----END PGP SIGNATURE-----

--=_MailMate_B0F46FDC-2DBD-49E2-B04D-46C9691AD48E_=--

