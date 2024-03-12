Return-Path: <linux-kernel+bounces-100662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDE6879B72
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 19:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 935312850B5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 18:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A061142621;
	Tue, 12 Mar 2024 18:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y+Betv2W"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC1F14199F
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 18:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710268373; cv=fail; b=p7Cu6gphLP4trIDhCBEeYibd9srCejPwqAE3FUczcSeI/09yDnvg7ZeElqIn+usvfDnpHgLEPlubn/HeBDCuUWp6oBZne0TNRIecmv+uMrN4mDiAshHkOIjPabT6CysynjwNlxJXxov1v97ZZeLVbdox20MP9QTDj5xUA7lUiM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710268373; c=relaxed/simple;
	bh=W15J7Rx2J+KWNwxqoq7u5eWsV4h9/AAwP8IyhhhwBL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IZZJpv8Xj2GZnQyrOpd7Z+IdaIeimjWzB51DbTR2foStwaIgmxkKDrKdCJpWmyUijQIRKOG16wd0NSGYmIsr5jy0+AI9SIH4fOLVRigAZVE1WCFY+YaeRc/3YWQ6erp/2tAUErnwQFw0EOmkIywO2WvXLu7o+zw+PojRlIPXjkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y+Betv2W; arc=fail smtp.client-ip=40.107.92.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hp2tEN4Zu6NN6NubJARLBeypmljr1TKpHCDzNh141CqOYlRXpy6vl7nc0hLarzgh7SIb5rq9Q0USwDlC9iNq58K5K3ULzRpSBUWz/QqqDfuDL8MY3/xzL60ByCqnHLMAJi9wV/4lkIa9BJs+CGgh+GVWTFjsHZe/HBpHO9lxMfTSl1wK7TPuGcG5VlG9TG7DjCcKTt5AXfTkSql6Gg9ayPpU8M/jfRd+e/PRaeWmwmYBEP9jhvTrRJHZDh1duU//734XW5fKMGQ4TaZAlY1vvRiEaFnyDsOVt/EeRx6HEZoL4z0a1+4KZ0zjPdsFK9L/oTQ9efaWVN7sK9gAHOovCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o918r8xaZAC+BzGrwJG212SGZ9QNHcBEJ0p6oLwRyE8=;
 b=lPwpgoUe0DXNx7j5T6OkkqO2u0ZLZSC6XQM5euBmm8x9wyk5aSxXvMsS6/Pft9lr5VQoXawcEGhBavpD3LtsSYxHlaQnN5An9QxliwD5WLU7Lh3DEPSXev2n9Cf5Z93keWiNyfW0PUvrHyjsT8bqvCIBqU+MK4DBWUtQntEaeWDbOnrlPsHvvn8Xu+F3WGhOrBsKEwGQxY05/RYSjaOdjELXR5cG06ZxuXYbLGCvWgesiZcJ2U0zTRlKpXQ6kwmvGGbhRvEBbuk5lzzOS9FcdiDhavV/N7cdoylX+Ji++WSL5J4Ie1xsrgaH65mJO/RnOyq76wkltC2G9/mGanZPjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o918r8xaZAC+BzGrwJG212SGZ9QNHcBEJ0p6oLwRyE8=;
 b=Y+Betv2Wn0gHE1GvgSYvUv9ZAsdeGHhznEDyv33q6LhRBW+ngiMljcuMLaJOUwDJYigKBebkX8lboFfal9vgq6wCr0lArETpntuardYNkDyRQzvCVjGhIWCjMX0hYw8Qu98ZLM/SlsEOi75CsoRN75KI82Dur42AS9ObMkcmRQIc4NXOpCxXNpyxBId2lazDq7dUoasl0X5xSZS/MycYYzkBtCTI2zpD9X9sb2l+qE49XTAvw7guY7ceT1haXC3ZBpYy5RUMz29LaEvPPgE3++E7I/cZwTtnKuxaJEOj0P1pnWYrCxyk2G5Xis2qjs9BxIlU9/p+urWGOiAzZywBdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 PH8PR12MB7302.namprd12.prod.outlook.com (2603:10b6:510:221::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 18:32:46 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 18:32:46 +0000
From: Zi Yan <ziy@nvidia.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Yang Shi <shy828301@gmail.com>, Huang Ying <ying.huang@intel.com>,
 "\"Kirill A . Shutemov\"" <kirill.shutemov@linux.intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/migrate: put dest folio on deferred split list if
 source was there.
Date: Tue, 12 Mar 2024 14:32:43 -0400
X-Mailer: MailMate (1.14r6018)
Message-ID: <76BBDB5D-9D40-44EB-A996-767404B85BE0@nvidia.com>
In-Reply-To: <ZfCFCGkrLVpySa6X@casper.infradead.org>
References: <20240311195848.135067-1-zi.yan@sent.com>
 <Ze_P6xagdTbcu1Kz@casper.infradead.org>
 <74AF044A-A14A-4C66-A019-70F8F138A9AB@nvidia.com>
 <ZfBkjf4z-jpaNk6c@casper.infradead.org>
 <DFA2B8B7-C690-422A-BE95-82F7E112BB95@nvidia.com>
 <ZfCFCGkrLVpySa6X@casper.infradead.org>
Content-Type: multipart/signed;
 boundary="=_MailMate_9FA95A4E-3296-4A51-8878-D2196FA15765_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0151.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::6) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|PH8PR12MB7302:EE_
X-MS-Office365-Filtering-Correlation-Id: 3600a474-87e3-4d93-acf0-08dc42c2cff8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	362K7qy/WkQq58ywWRHFzejaaFMPdCi5HcMxeMs9fDOHmI1NyVJFm4QjkgRKHWIA8jsU02hqQ/CoV9t/x14MbrDOFBWj0fiYQEtDpAWCt9maqOGdR+BzuPhQohAhQBhFsuGrFTb3XXQMQ4nVkgd3wTOYeWY8gOupSPzv5sYJg/JAlZCUG+jtjZixavxAqaj6qqPy+gYX3z7X9KJHxT3jF8DVDP8PnbBwIV+mCbAyXqTEZbAdQ9rpIxyLO+rydRw6/X/8arfoEvc3dOeubsOzzgeqZ7lOkye4Ft83xlcgMH9ec7RAzaUsOGWt27jBCgN5TraiaU2LhHWxHeRKyLonFnDXFCBLhtk2/ewgWCy2suh1qj0QKY52QvoKrtfD/W18t8dn9ngXNBomQFOW1dyWtrW5CdUScDZW0X3iAjRU11D1xS/69yO/luN/STKRn86ihebl2W8tzx0RQ3Rr15Js7vV7z5ooHMFZW+exE5BLHADzRz/UzQtaWD1hgxGsQqbtv7UJcw5IxeIhUOjgCgDjYizk1jDbdX+rS2GqXmYwk3ShqX2up2uFfLiOM2uTv6VWAlCPow3MTk4JKaSsEhIYWWg5AATXt2ih9W+6p5CthHzFDZKFFJKO++qMqUrnCEE2EvC0H9Qym19Nz7YOtJy16GccdXQ99+a6QC4t34A/1h8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O59RucQhybpobHOwOj9T4P6VVxJATPnml0U3IbpurROjwIn2rV9LsQNlzNd/?=
 =?us-ascii?Q?QeFQDyw+NQOFSsJhuVtuGZ+mwCYY2auqv1Qp3fGIhwkVwv3KPVzDJXANbtc1?=
 =?us-ascii?Q?9gsIrplPVDN39nCFkpDzrGwtmf61xRc1WkjRTZLgfmJvMJRgW2RdPLkIXtrr?=
 =?us-ascii?Q?t+m+OjAoRbZmidCxvOrFDvhgU6AiH8dpHZ3ZKXCTUBRKgotcrBMcPG5y4EJC?=
 =?us-ascii?Q?SusS1Y0ph4/8hBU3HZ2qXSTu+IsCQzCpFnfiFC+oNdRbttquITdO0HMvl0i6?=
 =?us-ascii?Q?C/YQeN1HZMkTrHbKNshw6RippSJkgCvJmpoRI42xdLPjQmDk2emTtunMkKdC?=
 =?us-ascii?Q?XR47XQdHIrbyK7Q4iRm4LNEI5Zo66QEiL0veO7ctCVRiYUer2eT9H0ZM1w38?=
 =?us-ascii?Q?kTAmUNOdNmvDYT1eqMLDV3H98iyvMtY49QqhKqY/IQrZgAVLeMR+ltnfatoL?=
 =?us-ascii?Q?liCX3Hynn/sFWt+D2Zalym47XvgjEnp+2rJ4TvwQdOgkVMLViLhuD+pUZTIp?=
 =?us-ascii?Q?k8L/9hGqNXC04+Mqsml2p7r6jc6IrC+vBjlDpMbiAXOUoh+znDHm8iPXLAlC?=
 =?us-ascii?Q?5y3t/p9XDt3r99vspUKh5EC7BTI8JxA3PZYk8gHPJzlZnHYADvcJQDIQJXeM?=
 =?us-ascii?Q?RUh4D3f0cvqcTqt5yyILZWPGlLkYx43PvZLVo8gaxlz1KEhDKsHIGjbEQ/f3?=
 =?us-ascii?Q?L0Uy8XHzauU87b2cRk4WdSQ+ylMjHTMurFFvZjlb3gsX+Ww6V8kiD53mW154?=
 =?us-ascii?Q?mhDbi3GiYQUmQR1pRE1uUv+HRYSa7GDUKZ5VfFCE/mZ2Hw3uwFUvHZxP+U5C?=
 =?us-ascii?Q?IzBnDENu+w82cCEi8cyEDfflSu9IsGaTFCSVgB5bJoMLbRPqPlnpnp+Hfr6b?=
 =?us-ascii?Q?Gm7RBpS8cgOVgkPGn5c0rM+QiISEXg/vpsMN0qyGoHuIgiZOgUM69DtOg7hl?=
 =?us-ascii?Q?wAhLnhlI5UQbGo+MyK/Is7sglGbR4tHgkFvtSFl9ek+r3F1Sb9XKjGrpQ92e?=
 =?us-ascii?Q?UeMIDFIbVCirUrlgl7vJOBP3SeT+yEl77XwrTei4NhNJOQI6J3D7HMHhv2eZ?=
 =?us-ascii?Q?9g6CSsDzS8yyd9w2J2MKNUJJpMAX7XouZtJqRspw2QjZP9bGsQuHKJp52gk5?=
 =?us-ascii?Q?j6i12J4833/oTrmVkW+I5ivmXbGxIQ5lyfjr6APC9EHpMRY7GDvZMa/9eRCN?=
 =?us-ascii?Q?2bD/6HjVHAQrdqohWGcrWoAYqKvtCMJT8Vo+xHfPWF90a0hdYX2OL5hXEyLK?=
 =?us-ascii?Q?Y1fv0vYnqVDdGGHVgh0tZrhVkZ0OxO2+eFXQOJjrgf0ugjltECawPOnCKxYP?=
 =?us-ascii?Q?TXGdzPaPiaShLKbUN/fM7x3UNBqCF/FwdodEJHK/0PbJ9xxS+bn68z0lEBi7?=
 =?us-ascii?Q?tEcQO1KQyLhRfwY6jUSsPUY8pl4tLLAPGnuv0i3AmHSrTpU9VuQFrfGTdZrL?=
 =?us-ascii?Q?V8Q80uR7I5nPgL04ucncGfBtgxQUPsgtixogXQlrW6Wp7RcdiXRDd9kMZfZf?=
 =?us-ascii?Q?qkLXNGDYX4vS+jvNeKlbfeTZSinZCu8u9ahpnmtwIyKIm0/p3D5Zjfxudzyq?=
 =?us-ascii?Q?H6kOLHgnn9SEDezYjhs=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3600a474-87e3-4d93-acf0-08dc42c2cff8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 18:32:46.1501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EUxASGNWLfVwnsqhcrWYqMTm/OMSEDAwkzki+psxAOwKxxUDzHY8Q6V67K6+Yo5d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7302

--=_MailMate_9FA95A4E-3296-4A51-8878-D2196FA15765_=
Content-Type: text/plain

On 12 Mar 2024, at 12:38, Matthew Wilcox wrote:

> On Tue, Mar 12, 2024 at 11:51:13AM -0400, Zi Yan wrote:
>> On 12 Mar 2024, at 10:19, Matthew Wilcox wrote:
>>
>>> On Tue, Mar 12, 2024 at 10:13:16AM -0400, Zi Yan wrote:
>>>> On 11 Mar 2024, at 23:45, Matthew Wilcox wrote:
>>>>> Much more important: You're doing this with a positive refcount, which
>>>>> breaks the (undocumented) logic in deferred_split_scan() that a folio
>>>>> with a positive refcount will not be removed from the list.
>>>>
>>>> What is the issue here? I thought as long as the split_queue_lock is held,
>>>> it should be OK to manipulate the list.
>>>
>>> I just worked this out yesterday:
>>> https://lore.kernel.org/linux-mm/Ze9EFdFLXQEUVtKl@casper.infradead.org/
>>> (the last chunk, starting with Ryan asking me "what about the first bug
>>> you found")
>>
>> Hmm, like you said a folio with a positive refcount will not be removed
>> from ds_queue->split_queue, it will have no chance going to the separate
>> list in deferred_list_scan() and list_del_init() will not corrupt
>> that list.
>
> You've misread it.  Folios with a _zero_ refcount are not removed from
> the list in deferred_split_scan.  Folios with a positive refcount are
> removed from the per-node or per-cgroup list _at which point there is
> an undocumented assumption_ that they will not be removed from the
> local list because they have a positive refcount.

But that sounds very subtle if not broken. As an outsider of
deferred_split_scan(), only !list_empty(folio->_deferred_list) is checked.
The condition can be true if the folio is on split_queue or
local list of deferred_split_scan() with elevated refcount. In that case,
the folio cannot be removed from the list (either split_queue or local list)
even if split_queue_lock is held, since local list manipulation is not under
split_queue_lock. This makes _deferred_list a one-way train to anyone
except deferred_split_scan(), namely folios can only be added into
_deferred_list until they are freed or split by deferred_split_scan().

Is that intended? If yes, maybe we should document it. If not, using
split_queue_lock to protect local list, or more explicitly folio->_deferred_list
might be better?


>> So it should be safe. Or the issue is that before migration
>> adding a refcount, the folio is removed from ds_queue->split_queue
>> and put on the list in deferred_list_scan(), as a result, any manipulation
>> of folio->_deferred_list could corrupt the list. Basically,
>> !list_empty(&folio->_deferred_list) cannot tell if the folio is on
>> ds_queue->split_queue or another list. I am not sure about why "a positive
>> refcount" is related here.
>>
>> That makes me wonder whether ds_queue->split_queue_lock is also needed
>> for list_for_each_entry_safe() in deferred_split_scan(). Basically,
>> ds_queue->split_queue_lock protects folio->_deferred_list in addition to
>> ds_queue->split_queue.
>>
>>
>>
>>>>> Maximally important: Wer shouldn't be doing any of this!  This folio is
>>>>> on the deferred split list.  We shouldn't be migrating it as a single
>>>>> entity; we should be splitting it now that we're in a context where we
>>>>> can do the right thing and split it.  Documentation/mm/transhuge.rst
>>>>> is clear that we don't split it straight away due to locking context.
>>>>> Splitting it on migration is clearly the right thing to do.
>>>>>
>>>>> If splitting fails, we should just fail the migration; splitting fails
>>>>> due to excess references, and if the source folio has excess references,
>>>>> then migration would fail too.
>>>>
>>>> You are suggesting:
>>>> 1. checking if the folio is on deferred split list or not
>>>> 2. if yes, split the folio
>>>> 3. if split fails, fail the migration as well.
>>>>
>>>> It sounds reasonable to me. The split folios should be migrated since
>>>> the before-split folio wants to be migrated. This split is not because
>>>> no new page cannot be allocated, thus the split folios should go
>>>> into ret_folios list instead of split_folios list.
>>>
>>> Yes, I'm happy for the split folios to be migrated.  Bonus points if you
>>> want to figure out what order to split the folio to ;-)  I don't think
>>> it's critical.
>>
>>
>> --
>> Best Regards,
>> Yan, Zi


--
Best Regards,
Yan, Zi

--=_MailMate_9FA95A4E-3296-4A51-8878-D2196FA15765_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmXwn8sPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUu1UP/2+SSwlKRhMeL1wMvzijDwafX70idrgMfeUi
2NyV1reVb8xrBJKLrglEn8Z/Yg9/2CpxYpgBZBiiftbCuqkqnqnrRRD1MvIbW6tk
0s27rk4pHS5Rua02zO1UtUhi0M4sfKSh8O/9bEipSibfpr88wqzp5RhJnH+2tGxG
fjKTSYj+l8OCkLv8H0us2yFfWBxIRXdueAAAdrQu2/qhFl/Rsxsa6AisNrDpqjMm
WWzGV+ZLmohPxRMw9ti2ixWtLIMZ7G0T7g6JGJaFwfXcO69+Tlcak73ZxM41QHKZ
EKI9kBcQbi9GzPwyWvkt7d1XWosBNDfUXPkDP1WCUux2CPW7/ViF5D1XmzjQ/c9f
eXFNyI+E6MUo68f/ivEp5vA7DZGrPMdLTEP11l9mVHp0HEolhzqDiXsAIAn+L7YP
jlIQb/wI88Duno8dr3stQINeA1qjfP+Zi2JIbEd6IK3hNpDbk9ygoqD/9yxWmvUT
AMcEH0ySyNI4rp2MVKqozDLxW3xRvbYXS8vWTliY6+jnd7aTuWFGgWDQwwJygcKb
SHr+N+8O0u51wHY5NFd0EXDvRz3P1l70G1FVldDqmJt+lC/H0UYJYQv+XUvwzmGf
IKX7CC9HVsSzJ3PT+Fn8PzrIuOCBt4TaAPffeamNb+5TQ9SWrHMTkjibhRn1E75U
L0VIuH81
=rU8n
-----END PGP SIGNATURE-----

--=_MailMate_9FA95A4E-3296-4A51-8878-D2196FA15765_=--

