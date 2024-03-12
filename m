Return-Path: <linux-kernel+bounces-100475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C7B879859
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1DAD1F22EF0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C2D7D06B;
	Tue, 12 Mar 2024 15:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gTb7Z3Kv"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFF67CF29
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 15:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710258681; cv=fail; b=VebACWEPvnzvibUTNeQdBi1RaCfPgZRAsg2TUDJh2yErDPbupX7bfvaHhQm83SepLw/qkUKCS/q8LstykZaBQ3EnUQ0efU80WmLObLk+u3nIlCO0HnxXogLvPnunfE2FHe9PfcDnw7Efz3U9uh+i0eDTyXsyBt00tyLhpBMd4gs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710258681; c=relaxed/simple;
	bh=sXmlE+h2zlqYQPFxeQLCqDTYLYNMuMfTKH8xPwvpSqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tteRsrytnFhH1SPnkofQvkBY4p3XtWErLjDoCYmSwGGN27Vum90BbYyzdjhCgiDO97DkCO72Mp4/rSsP7qfU/em2RyN3ej4UE2/i1eJ1Suss/zIDa6nUWEEto0V4zm3/IgX2SlaLodxnGYq90X5qbjNQZw8o+NGx5Y6faQ2N2dU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gTb7Z3Kv; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k/RLNARwQ0Sj6rVKHXR4I6khrdcEgSAW94pHE/yIth7oLD4jW8kJTvUqEN1i8evYrCTvnR/77vfzOICgn6Q/DTux3qxng3aumnXhnrBbeUeuT9DFtlD1dqbANFSzi7iL5H9/dTGaTDot8svVL8HIlSjQJnf0blyRr132uug4NZdRRJlTZHWclgIJyz3BtS8Wc//0x0/GexfojKtdncaXE0tEV8AuqEuE6fGdX6Age0fAW9ZudjvZ6A2fStHyLdjREg3XMAwPGWqiYxQzUcHSebFrJZKbv4mEIrfwGjAeFqR8KFJ7DkNXuzSadWfZvhBNQUgUZhLvu7CXJhuQegO4Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lHTFi/9mNltXP4awjYXC8cdvG565x7FwaxSfm+Dhonw=;
 b=h5sIEt9CupL3XQYAUeQnEyRDKDKL2dMLzkOnafzwiKwGvzJ6LX2imrQMLJt66JZp87LVuyBu9CyhnJA94Obb6pPIaqIV5SQmh8Ce3qDKzZcGL8fPv3IxTHoSOwB46EmzuHr32c+PPFbCXwvYorAm2s9lXWFqc1Mlj6g8HiQenTWVepvVhML1T2xmABbwXrvh0Epf8ww+lvCGBgEEIBfmA5Rb0Hz8Vsa5nG5tSB2BLhUa1mazp5rqtuFMLcOxZMN0AMJFO/WX+GJgBFF5zGUozIBQvaTgo1JxUDevdXQe0yiWmIhto1bG8jcgn4fTfV3zPB8jimaGtmWyUwNBV4XGxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lHTFi/9mNltXP4awjYXC8cdvG565x7FwaxSfm+Dhonw=;
 b=gTb7Z3KvxLyFdzEmy1UbufDXLAtg9lWTnSOV/kTBynLpJxDQoEu4T0FFsER/7ElaSRVBDO71rt0rY7vd9/J8se9AZIQGomfnPnaD+Gm0t1m8N0574txDF8O4kzDuzSzqXqYgHj2xHPLSVxOzh4GimtxBuD+RQOC0cInzD13G6CM+3KIrQ1+LitPQX+5qNxXE02VWq4X/ogSRkAQDQNvZB3nDO0Uy3oWi0MSsaK0l4sTgT2jXdUwd6bI4W5+I742RE798NhQAbSXRtQyiOsW0kLZhfOr2OMUuAuUXogRRedtipsWWKbjxnonWCu1gjx/aWmja6qLu2tVzpsWosBULow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 IA1PR12MB7616.namprd12.prod.outlook.com (2603:10b6:208:427::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 15:51:16 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 15:51:15 +0000
From: Zi Yan <ziy@nvidia.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Yang Shi <shy828301@gmail.com>, Huang Ying <ying.huang@intel.com>,
 "\"Kirill A . Shutemov\"" <kirill.shutemov@linux.intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/migrate: put dest folio on deferred split list if
 source was there.
Date: Tue, 12 Mar 2024 11:51:13 -0400
X-Mailer: MailMate (1.14r6018)
Message-ID: <DFA2B8B7-C690-422A-BE95-82F7E112BB95@nvidia.com>
In-Reply-To: <ZfBkjf4z-jpaNk6c@casper.infradead.org>
References: <20240311195848.135067-1-zi.yan@sent.com>
 <Ze_P6xagdTbcu1Kz@casper.infradead.org>
 <74AF044A-A14A-4C66-A019-70F8F138A9AB@nvidia.com>
 <ZfBkjf4z-jpaNk6c@casper.infradead.org>
Content-Type: multipart/signed;
 boundary="=_MailMate_0D4F97BF-8CEC-4487-B1E3-647E3C31FD51_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0363.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::8) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|IA1PR12MB7616:EE_
X-MS-Office365-Filtering-Correlation-Id: 55f7bd9d-aca0-45f5-cd27-08dc42ac400f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HGgrL0JBDY0KavnunboDfowawvpFeTQUdAtcaW2Tjg4eAAytBM/0mVO5LwgBQVpi4nOcF5OpM1mE8VHIWMwfGqs21rv8+pdT9tRg0GxIEE6M8HqXjnF9Xx3l7T+tjeaOmMUc69O4aK7K+F1lb9KPNbd6YRopYgazJzJa1EoAiqdGjhGf/lArHMEkWnhmplJMgfVfeg9uR/lJRRxyotbIPmOORr6ZVIGcUlNa3FBfG5QE8fm95VpSogVwd0pDaw/N5P0Fofmrylm41UN6kQH8/5niOUTyb76+m8BFbThdMI+UH6Q4cJh1S0op1+vxmdZofGi0m5gZmhISB+vnYDZlpm2muY0Eq2ctSJo9U6My325XJ9WvC6Myx4YK+mTn2ZNfLRzgkMrNxUDxyH/Qvcl6g5WOyoO3DET4si8CfvuCCpLFL9GU+bI9c9nnNN/12tQjWk8BPZck/QAj/8Oo6fJQPVjcoBlyKoodTBHwndOtAC5URy7sdYC/ZM2uO3kIznMLGSUvUnghnFtbZgqENMvOzSwfegTlzyy9JRYzvdbEubwXGG1v5/O1hrBALzbvRkw9c/KuOAfTZ6x4EDWsmCINK+5k6WZ++MzFjMBftobTdsN/d6inGF8dLJe9ULVEYq7ZvqWVWWNTUCeioqM5ybeX9XFD+KuVKz4LsVKv5Lh2JUk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b3s19Z82eIAtUB1MzzVyxfsKb5Fcp/EN9fDorhm1I3zv/GfMBkJ8N/pstcMj?=
 =?us-ascii?Q?H/FDDK8B223RKdIwphAj8CJOyKjOEQdF3L/kJgRmbJoQ7mF3EQFCaxt27xHZ?=
 =?us-ascii?Q?n6UAXfyzDiqKbxoGvlWJ4hjRIkz+i4JptjEhCnEDc42N7GCzw08HeK5OtQ84?=
 =?us-ascii?Q?wjWCd30ASU6Mf6oaAXT0R6FbzKzWMTnRwabCBmSRA8peKMf0lcZnEdFFWeOB?=
 =?us-ascii?Q?/B/QVIbSFvYPPgRz9C/S4Y2M5+E5z8LZubjU+Dq6UPUtWdY/rXlnlLHzYd/D?=
 =?us-ascii?Q?Fa5GgjBzU+kSNuShimtT6JU2rf9XOETdgY/UYTEHDLsS8luXTIeI7tWCaXeC?=
 =?us-ascii?Q?a5Yjp2mWwcTSQzx3ZmVDvVhmDZSK0RZdvBQGaiQAVF60P1zV8MRmMLvucJKC?=
 =?us-ascii?Q?CraQg3MapLutF6Kk4EvQHwRsBMnLo+enWjxJURqGzun+UEga3a4OUeiKXVL1?=
 =?us-ascii?Q?wCr0OF0UDAQRXzpbb8+gncENTEDXmScuZgR4yL1x90ZU12tMNhjmoGohJgdK?=
 =?us-ascii?Q?wi4CXWYkFgcirnlMSFg8ve5R5h3Z//kKV+YQ0jpYywDVP5abMbPnlGj33rHH?=
 =?us-ascii?Q?EJ0+iSGwVlaZtf+To54WtGg2M0Z7OLyN4yhNEfyi3rX2j5IRthXIFcBz6Nmb?=
 =?us-ascii?Q?PJDVUUtpUc1o9+Q8TJ8m8yqH9z3nTgn4OrKXE18paNM0/JcX3Ae7v0dj8r/X?=
 =?us-ascii?Q?pQzlgkxdcQwB2ujH0xSky6Nh05boLQDNjmYhau89jWBOITc9PC0N65/NmJq0?=
 =?us-ascii?Q?sUPnOXJo4Ih5JQwrZlkqb8+LoRZAJS5IKgNfCu6DnEUdq9tiaBTjkuyBGx+x?=
 =?us-ascii?Q?BlGumHJO5GXXp9cFExSMMod8PqZPLcvnn27E0UvsXGbhPqzNiO6aeknLffed?=
 =?us-ascii?Q?BQCbwFYmhHM+NSpPjeoLoQt4xM5mUbWbH3GDqbT+jwUo7VSD7G1cPKOp05cb?=
 =?us-ascii?Q?QKweBfhuYxZ+XEeEiVePGgsR54SSxO4brDbNG5y5ZnAQNJImjDw+fztyXhCa?=
 =?us-ascii?Q?LSxNUuS246TgtNFJwXNREWzllsCx5RUUxBuU7g0PoGVxe/gmzm8E0KZJYM+C?=
 =?us-ascii?Q?k/rGFkvaSbuTeMGxWKZ1eIz0l4RB2iSyDL+0NeMKnlgqQ8+HzWRYBaqjtENt?=
 =?us-ascii?Q?A5JtwoT7hYN82YnE8uYP9V+SMID1UEs3Jy0F+KYjzuAjizH/3sDHqMkPVVpd?=
 =?us-ascii?Q?Zf80OOt8pnQTxhY2VkVFyD29OIGTIK/qnb1J6+umcH6kfA6hkovaCH/XGh8v?=
 =?us-ascii?Q?t/Tx5o7H9TU41CGE5zLmIyt3si+0TDB1Y1MPaU2CWslj+IHpgE/N/Tr6kggU?=
 =?us-ascii?Q?4GJSA8LIBaCsn+6zk2HLG18gxCHeEZtrRR/9IpYTk+gKPdoCP6gXwWsIv7Ls?=
 =?us-ascii?Q?bg2GVCi1qcFK8ehv3/T5vM2cy7zJH3nruU3s4zGN7anpVtMQMPWt8TMnESVv?=
 =?us-ascii?Q?b5cL7dkTG5Q2AxN58J/p9l8FeUl/sQPo/Y19OSTUIN5wYA+aeWqrfn2lG8ZI?=
 =?us-ascii?Q?5wqY+tnt4bPHZVPT3LpH08ADyIvzHtNnQa9Zzr9WWJYDK2fVZf0I/LKf4FQV?=
 =?us-ascii?Q?JS99/c4vL0PC+kP7Q5I=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55f7bd9d-aca0-45f5-cd27-08dc42ac400f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 15:51:15.7961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9g7EJLy4lhsre255zMHtfraC8tzLjDTIuEUPDo7Q11WFp4cFZvmuHyX7c6x0keUB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7616

--=_MailMate_0D4F97BF-8CEC-4487-B1E3-647E3C31FD51_=
Content-Type: text/plain

On 12 Mar 2024, at 10:19, Matthew Wilcox wrote:

> On Tue, Mar 12, 2024 at 10:13:16AM -0400, Zi Yan wrote:
>> On 11 Mar 2024, at 23:45, Matthew Wilcox wrote:
>>> Much more important: You're doing this with a positive refcount, which
>>> breaks the (undocumented) logic in deferred_split_scan() that a folio
>>> with a positive refcount will not be removed from the list.
>>
>> What is the issue here? I thought as long as the split_queue_lock is held,
>> it should be OK to manipulate the list.
>
> I just worked this out yesterday:
> https://lore.kernel.org/linux-mm/Ze9EFdFLXQEUVtKl@casper.infradead.org/
> (the last chunk, starting with Ryan asking me "what about the first bug
> you found")

Hmm, like you said a folio with a positive refcount will not be removed
from ds_queue->split_queue, it will have no chance going to the separate
list in deferred_list_scan() and list_del_init() will not corrupt
that list. So it should be safe. Or the issue is that before migration
adding a refcount, the folio is removed from ds_queue->split_queue
and put on the list in deferred_list_scan(), as a result, any manipulation
of folio->_deferred_list could corrupt the list. Basically,
!list_empty(&folio->_deferred_list) cannot tell if the folio is on
ds_queue->split_queue or another list. I am not sure about why "a positive
refcount" is related here.

That makes me wonder whether ds_queue->split_queue_lock is also needed
for list_for_each_entry_safe() in deferred_split_scan(). Basically,
ds_queue->split_queue_lock protects folio->_deferred_list in addition to
ds_queue->split_queue.



>>> Maximally important: Wer shouldn't be doing any of this!  This folio is
>>> on the deferred split list.  We shouldn't be migrating it as a single
>>> entity; we should be splitting it now that we're in a context where we
>>> can do the right thing and split it.  Documentation/mm/transhuge.rst
>>> is clear that we don't split it straight away due to locking context.
>>> Splitting it on migration is clearly the right thing to do.
>>>
>>> If splitting fails, we should just fail the migration; splitting fails
>>> due to excess references, and if the source folio has excess references,
>>> then migration would fail too.
>>
>> You are suggesting:
>> 1. checking if the folio is on deferred split list or not
>> 2. if yes, split the folio
>> 3. if split fails, fail the migration as well.
>>
>> It sounds reasonable to me. The split folios should be migrated since
>> the before-split folio wants to be migrated. This split is not because
>> no new page cannot be allocated, thus the split folios should go
>> into ret_folios list instead of split_folios list.
>
> Yes, I'm happy for the split folios to be migrated.  Bonus points if you
> want to figure out what order to split the folio to ;-)  I don't think
> it's critical.


--
Best Regards,
Yan, Zi

--=_MailMate_0D4F97BF-8CEC-4487-B1E3-647E3C31FD51_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmXwefEPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUoWkP/2o98M7I7xOCTdsIyfpY28uff9HIZGhCHQ0j
g4r8l0QReZE8GorqIjBUwnJ4InqjcCXjih0c523qWiiXcb30ha8A11TRLQxCAaih
dNlXqE1HMirY5chwkE/pv5tt0uIT3ztZub+L28HfUqciiPxoGnLeK/J57kgSN3tY
U4auGApTyNCPDUyRaIwn4ckUhOjoe2BvFLN3bxsDBFd6+0ulbp7BnP59KPjOF+J9
H5o/V81utknXoG3yH1TA3AvP2cnPcgLqbYME6mjPxwQuXLOLLT/rlsY/yS0RZVbF
viN5J50V2JHna+fD6N2AR6W256adFKP4rN+3jt7BvwfXYsA6TzKqh/UZf/cUnXTB
y0cImkRhCpScoqaJAPAmz+GFEZ9IK2vNA2laLrl9r9XNJLSLeW2nFQXbXpBN9K+f
YfDSEXSOb2F4JbPwOXuGlzOXi7LP0vq/pxn7lyr9C0zjs3ywaD2XZ9qdSVkEi0n0
3+I6Ox5LgzGD20xGMv3/6EBbIwV9eZ0S1ZOcQixdg9jGquG/CZ9UB16sYOLQM5ir
Eqb0ILGxrCm6k9IUgsbeeL6YunLuvBzJDSvWlMfbyF3jo9gg5n8l6/1fYpTjIml6
YAiED1QPugd5oiLE3k4dgKzL6fkUtNQoa6/ZAKTteITmmCrKpFDJzi9uttKZa0he
jfEGMrRc
=ExKy
-----END PGP SIGNATURE-----

--=_MailMate_0D4F97BF-8CEC-4487-B1E3-647E3C31FD51_=--

