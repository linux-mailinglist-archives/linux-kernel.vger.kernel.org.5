Return-Path: <linux-kernel+bounces-100349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D1A879612
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 255291F22AFB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 14:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1E37B3E5;
	Tue, 12 Mar 2024 14:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XevwYBsS"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8900779B97
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 14:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710253604; cv=fail; b=rrQoqYSvDv8JWAITDgVoad0PrPZxCNJnXmt4Qz4wqqA/o70/pdNK3CMuYUbKZpoxS5HLiL5nf3baWo15pEH4nE+MePFrGrohH8TNeeFp6rp2pSYEDgbJgcFPH6VICpMRl1rlD/q25rFBDUs7ESe81f1zCRsWQf0uDa3YBewhhpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710253604; c=relaxed/simple;
	bh=U3d7bKa7G3+IqdniFm2Po7zFBhOlr/rQBNL1d9dMnVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K40eZAKxcycK3ILM+jVO26MAic0m+2QEQCzPiDQCVVTGjspOXpd1QGrrJTsREPAgfVmsjzFPr9J4ojIGI9QE8JNEZ/OqFmQfvBKf6tvcwY3ds8FW7/EePTc4nhzLDBZOsvaHdwvV3n66BWb7pZSXuh+VgOTyAes6P4LQynrhy6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XevwYBsS; arc=fail smtp.client-ip=40.107.244.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e642f+yFtSwE/5M29s5eG6d066ZwseGrAYXrRDbS0jh4vvXyb/u0MndJT73drDSA3G/tB/q7lCOSdt3KOZzLl522/R935Y7ozZmL9aYxJcciamr6LA7scbhfyFIrYi5pwK9xW0lZQeXjGjv22XzNafftWfQseNl2bcLqReritDFFRoUZv5KQiwKfl3atkdKzrPqys/w5OgctKP/D681WfWQFviNlZgjlNiKFn+tRK8cR3JQ6VJukuJejip4B32/A3j+7cRXqQjHIz7Hi3OGJxCLSGsUuS7f1dE+Am6BcTI5tYPIjFFMrwfi5GdAxL3mjaN8ed2vp4onIoKtDOePFQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OcChI5XAuzBbXZ+hTqRwtHw/rMsPY+Y2jk2iMIbVAAY=;
 b=hdUCKFBJ9sgExM7ZHqShTchdKXFd9NPfUskZ9FJFs2a9k+R2r4Mzll2Jw7Vkw0z2esyxaXylHH/QlyblzIwXN3L/wa21iA0jiQEc3ibMGdNFsy5ol2VDuL9M4Bxj6x+mhqpSTAxAF6fRR3K2YMogSmjiVTz/mkRavQ+x5wdtnqb/+KhYCf9+JrwgGlBYftWc11SSvB9q7eHIriGLTal2LHkDdGRURN1V1MznOHQUE3utgh5mn8vPn8h8HayRuhIWMYt7p0kzQaQm9UBnNZlqfeQVPLmsdF5MDrreQyAskxt3wXULfAugLhe4i33aewOVY5vbUmQO4VJ60UN3lsRArQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OcChI5XAuzBbXZ+hTqRwtHw/rMsPY+Y2jk2iMIbVAAY=;
 b=XevwYBsSsCYcsU3QdVPwoN9+HbD4z1GUFxJ89ejrlYjCvPAwtS2dCVj+uKntWXujNgVSRkCDdHMzFJEx7kEU7rkCbk4vOXsPCkWq5RsamR2OEdtiEfUf3LUc2cBnhQhqALJ7ZZuJXnV8M/p4pGAe3Ct2MNZflTdKwmnOQFtIKv7gF1z/tPWoKFrFUIDErwTDzBWqe19P0ukgRQZkjpovX4VQcZMG/sfuqpw89QJB/tyjE45q9eJFJiypJRd5EVywXIpS71SFeZRcqIj3iZlS8fKTOaVGrAoWK4KtSwSyej2yBp6p8AYHiNYQTHIPLZFiEWElAXnm4jg+UMJ/+mtOHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 SJ2PR12MB7868.namprd12.prod.outlook.com (2603:10b6:a03:4cd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 14:26:39 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 14:26:39 +0000
From: Zi Yan <ziy@nvidia.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>, Yang Shi <shy828301@gmail.com>,
 Huang Ying <ying.huang@intel.com>,
 "\"Kirill A . Shutemov\"" <kirill.shutemov@linux.intel.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/migrate: put dest folio on deferred split list if
 source was there.
Date: Tue, 12 Mar 2024 10:26:36 -0400
X-Mailer: MailMate (1.14r6018)
Message-ID: <373F606D-4A90-4514-8C31-775557B494BB@nvidia.com>
In-Reply-To: <e3e14098-eade-483e-a459-e43200b87941@arm.com>
References: <20240311195848.135067-1-zi.yan@sent.com>
 <Ze_P6xagdTbcu1Kz@casper.infradead.org>
 <e3e14098-eade-483e-a459-e43200b87941@arm.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_A38E795F-10D3-4815-B38D-7CA08003ABBF_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL6PEPF00013DFC.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:21) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|SJ2PR12MB7868:EE_
X-MS-Office365-Filtering-Correlation-Id: e19c6057-4884-4000-d5ec-08dc42a06e09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KNzzp0xmTsvnL/EWtYTYP6dkHz2umev9mxUsYtHrJF5uFDWo5LN2P++9PZWn5CnlckiXZvsU5wD3AsahyPppa56mNtMtGvW7BzvPaR0URR2NHZmQUHtq9E6ZcdHvm9wK2DuK4nDq3Yb7KWVnOQjsr7reVCcmlzAEDA1FQIrssSPCYt3K0M5iUe9DgdLajpomqJTL2kWyKA2dfHFHYWPSXzZ4MnQbCq5KqbzvCCtHACRBtEL/jVh9GXZzZ3F63k24Z6al76Y+Evhcmms0RVX/rGYAzWtO4QpaV8xmijr9glHMXumQEFZIslEMDRoV736W44tzJtrOx8Qr8De9hny2VRCf09Bf3kDfhtPqtBdZ8s7Peh8YEt05OXIMA8hEzh/kmObLLoGBpZRscAeBf2u6X1kFpuF7zIOWRvVEHoVMK7GRDsI/tcL8VY9OJe7mOCojQVFOiw/m+w1V/Iu1WkIA9Y0ucy+jnDwt+3bPjhYHcJmGCFJ2Dw4u9RQ0sRLeYyYpOpDBjb0ozHtZwK76p9Z5hhRo/0wuFhGt6Gk+n3Qrq5iNiTGIulHUr5OTssHgJIkYfTYqJD4+aI53RrEgithHc/B5QKYjFd1SVCb/DYjbWOFUlZ7IjVvbVM0ELsP4riq7kePwYS1uaN42D81UkXpl40GL6Fb3c5SMjONcGc55u0U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+3n+JW3W71IIbjVGluFTA/srvVr0K802xUBAfiqM39pi1pHTjb+N6YA9vcjm?=
 =?us-ascii?Q?NGPWoA9UwCmTMAWudnGj2pVunWQWtXZDy+E2fCeJHUjscnI8qDlYTSKr/7Wj?=
 =?us-ascii?Q?zmSQzuGcT0rJ7XPXqZtW3mlLN5W9UgEwT/Y8JjIYYAm5PIphhd9dum15aMwZ?=
 =?us-ascii?Q?Ws2htfLyQMEyS1C0UV7fCwnFc5b/4XL7tV+zJtKLr8KjxbwT91L43KXr8odk?=
 =?us-ascii?Q?FND4oUDh7WN236KctHgisKxCL6rYfa4f1Qk+NZIcIZ1oKSQ6pl/nEUTrIzBs?=
 =?us-ascii?Q?vGdSkZy8w6iLwQTzcY5TBjXds5nBpfBC+shxbvkxtAfcP+GPUKYkImjyojmr?=
 =?us-ascii?Q?YEerVLBkhVbdYfVli8fwUeEClek00r0ySE1UqqEsAyWgW3XdflJTuYRS1Jc2?=
 =?us-ascii?Q?erEFhMqzt++pvy/QUzL8TV85Edn6newflF/3NfO0qb1R7wSd6Qqth8ev4RUD?=
 =?us-ascii?Q?5KKnF+Hfnzh5d7XSfIrm0PgLMT/ZeQmXlJZmenPoCGDXyLJCok8sGbG+V9O5?=
 =?us-ascii?Q?tZOWdslgGRhOYCV4JXUlLOtg5zDxn4pKcvSJEOWu4hi1fctyJ0PnS8aAtHF/?=
 =?us-ascii?Q?47lQXhBwwsfaSb2Pd4Ub2RsQ0824tHtK3xvmnQUja32VH/2XMKYxwrRBFL38?=
 =?us-ascii?Q?/KVNcgA11VByDYT7cADTXXusVFloGxHrTUnmMrTtB2JdH20ra7ov2tlJktnR?=
 =?us-ascii?Q?+vAynxBB32NtOVRUbrP2v5fZe81p+XSM1dP173GpcPDwNpU2XTAfhTE3iaYI?=
 =?us-ascii?Q?E05FnID0kXk0RIaBU5zt0/+s9PhFXf+dBIx3tWs5lyqRrugnE86QIxOQZUhI?=
 =?us-ascii?Q?cm4eQuRJaA8FKoiJDqwtP83e9SIMXOQSN1XhARK3BgIs+HgokDpYkQnd7cOJ?=
 =?us-ascii?Q?XgDCu8rzc59x7GrNgrrYpiQjr8/CSd8pEVsGpiGw1qeH2aCRxA+MI2LRutB9?=
 =?us-ascii?Q?V5n7bQ30P89C9nd+Dl3skWCQlweBppQl3nO/kypbqqAzSOCfAwwZpheGIGyD?=
 =?us-ascii?Q?YIZfjFTJSd7T9ZYTR0nLLb2JQxJVcnhTKNuAKvsb70NSbGUlKOUd854i1Cr/?=
 =?us-ascii?Q?gPlaG/fMRmYsU7mGgOVeFUdjBtrhaBaZe4jRrKJiwqyDMZKH3YrKybPx3rQ2?=
 =?us-ascii?Q?Vrd0/nRPI8Z3C8xFvukuh9oNz0iE4OEOE+lMKKvwkKM/41Qewe3AGnZqGbWu?=
 =?us-ascii?Q?H95+Z05ErSZSM65mJ+nwQ94veSjBsJh9tpZcl+C2n7+RE1jHaYipwTrQXc+H?=
 =?us-ascii?Q?zKkrXqPa5hfeXGGfL/rIk8zx97Vc/sqkMgBzG2qpmIKggsNOInPLm2VZji9l?=
 =?us-ascii?Q?5fyIocdZg4kDe83YOMHKe8lnNP8Vd7AQ1EtXDOcdAN2V8mwIV/Ii/K7iB37A?=
 =?us-ascii?Q?cOq17j66YCGofl5+vo9PPkzXfpG2WvF2yPRLiEnFFM86Nxx1SlBf4+sezo2h?=
 =?us-ascii?Q?WgeczUe4q+bGBqPGG8B2MLDZIug06BbepgWuBrt+B70xymNHWIKszuiFjJvy?=
 =?us-ascii?Q?fS22eL8orkHLcuoc/pT4GIMeqqrA1kXLmEhpST9FyyshN2aEBFNr9CkzSBqN?=
 =?us-ascii?Q?bqe8Tp5OKvGOcw1sR+sGpRaNsYZ1d5aEds7NrXTd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e19c6057-4884-4000-d5ec-08dc42a06e09
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 14:26:38.9395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rgeCr+H3Eqb5EvWDUJ420kdPf8PA0IZf8QUJ7GrynCIePVWIBYYORdi3CW0EkyKS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7868

--=_MailMate_A38E795F-10D3-4815-B38D-7CA08003ABBF_=
Content-Type: text/plain

On 12 Mar 2024, at 4:05, Ryan Roberts wrote:

> On 12/03/2024 03:45, Matthew Wilcox wrote:
>> On Mon, Mar 11, 2024 at 03:58:48PM -0400, Zi Yan wrote:
>>> @@ -1168,6 +1172,17 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
>>>  		folio_lock(src);
>>>  	}
>>>  	locked = true;
>>> +	if (folio_test_large_rmappable(src) &&
>
> I think you also need to check that the order > 1, now that we support order-1
> pagecache folios? _deferred_list only exists if order > 1.
>
>>> +		!list_empty(&src->_deferred_list)) {
>>> +		struct deferred_split *ds_queue = get_deferred_split_queue(src);
>>> +
>>> +		spin_lock(&ds_queue->split_queue_lock);
>>> +		ds_queue->split_queue_len--;
>>> +		list_del_init(&src->_deferred_list);
>>> +		spin_unlock(&ds_queue->split_queue_lock);
>>> +		old_page_state |= PAGE_WAS_ON_DEFERRED_LIST;
>>> +	}
>>
>> I have a few problems with this ...
>>
>> Trivial: your whitespace is utterly broken.  You can't use a single tab
>> for both indicating control flow change and for line-too-long.
>>
>> Slightly more important: You're checking list_empty outside the lock
>> (which is fine in order to avoid unnecessarily acquiring the lock),
>> but you need to re-check it inside the lock in case of a race.  And you
>> didn't mark it as data_race(), so KMSAN will whinge.
>
> I've seen data_race() used around list_empty() without the lock held
> inconsistently (see deferred_split_folio()). What are the rules? Given that we
> are not doing a memory access here, I don't really understand why it is needed?
> list_empty() uses READ_ONCE() which I thought would be sufficient? (I've just
> added a similar lockless check in my swap-out series - will add data_race() if
> needed, but previously concluded it's not).
>
>>
>> Much more important: You're doing this with a positive refcount, which
>> breaks the (undocumented) logic in deferred_split_scan() that a folio
>> with a positive refcount will not be removed from the list.
>>
>> Maximally important: Wer shouldn't be doing any of this!  This folio is
>> on the deferred split list.  We shouldn't be migrating it as a single
>> entity; we should be splitting it now that we're in a context where we
>> can do the right thing and split it.  Documentation/mm/transhuge.rst
>> is clear that we don't split it straight away due to locking context.
>> Splitting it on migration is clearly the right thing to do.
>>
>> If splitting fails, we should just fail the migration; splitting fails
>> due to excess references, and if the source folio has excess references,
>> then migration would fail too.
>
> This comment makes me wonder what we do in split_huge_page_to_list_to_order() if
> the target order is greater than 1 and the input folio is on the deferred split
> list. Looks like we currently just remove it from the deferred list. Is there a
> case for putting any output folios that are still partially mapped back on the
> deferred list, or splitting them to a lower order such that all output folios
> are fully mapped, and all unmapped portions are freed?

I probably would let the caller of split_huge_page_to_list_to_order() to decide
whether output folios should be put back in deferred list. The caller should
determine the right order to split. Letting split_huge_page_to_list_to_order()
change new_order will confuse the caller and complicate the handling of
output folios.



--
Best Regards,
Yan, Zi

--=_MailMate_A38E795F-10D3-4815-B38D-7CA08003ABBF_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmXwZh0PHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUg3EQAIaNBPi4Mi7uXck8YkY+emCL2MNP8lsfMjRd
C7Qq3v8xffXlvOKuTMeB28805xE0qvQX1dbuZlcwGPz56OndG7Adhuo8EEjcbawZ
oLYUNTMrfoFARSQrcxablilUkzpLw8kz8Ir9rdIZDR7L5GzV31zfq8AoiIL1PVor
ru7IcpEdHfXy+mOg5e8otXfjqI675wHf4TXu+W1zod+JYWXxsaemhCxfyjjapui5
/nz78aOdJkL+LiE8lFv7GCMgvHkHDi19+1KiBcVSoTbNRi7eHmpdCu4yuW7xJzkH
KA1dBRvjrEAU8+1JSyo9NKxWv09RklPt14GsueU5WXYb6WkLjDuSt+uV1xTw5b1o
SxhbSbca4A0UC0dzUg9u04gnzw6RzH0rz4IQ8SHYouqcHY691AdsIx1LUmvTINs5
nBeFnaYN/JdtRogkRyv2WqAsRbQGJbk4rbjl5zJYw9yQ1WDjeR2ghbMcrBBiw3Hg
8vgZszEe68t7EJg8PGRjtxOWzx5UEYK++cP27T3F6P11ESlrihwkBOeWJ3Zl3vnP
dI5b5bnn8B+Uoam1Iry2JXVHWZkPrhv6twlrnbIF59AF8ldrO8bwJPUVm+3vroVA
6ETXqHmXLq7EWcXBnGmXTNwQ8zctm3leY1/UNa3JM0ceOslnLtjLFBlnOiSkZ+vF
nKknmwTL
=vpEP
-----END PGP SIGNATURE-----

--=_MailMate_A38E795F-10D3-4815-B38D-7CA08003ABBF_=--

