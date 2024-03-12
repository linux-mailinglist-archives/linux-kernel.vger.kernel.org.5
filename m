Return-Path: <linux-kernel+bounces-100721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E99D9879C5E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 20:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B926B213DB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 19:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687ED14264C;
	Tue, 12 Mar 2024 19:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aN4yluCz"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864AA23A6
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 19:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710272728; cv=fail; b=qHsg1OJwCod1iZthspEfJYNbKYXsPKD7UrFbGLUB+1G3gq5U1RIFXL9VqFDrua684WaUjgeeyeL6ZE5iToDptNHB45DnZ185vwDz5uLy1uN1am/EJl9DBVXPyd2LqFdGaKwqbePJZO/zuJLT8B8H/0xRJNvoGJcN2LVI1uA2/Cs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710272728; c=relaxed/simple;
	bh=zcEnvltYZQApVBnVdtutlOnfeZRhDjVb8jWybfESneo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GeYniEzftdu/MgSwXL8scuW6r5xF5UioNLAS9TrgzZHGEcG4xoENtA6yHlqfvWAbBuf171cUCQvVWRw2RX8eGrAX9DkIbGynO79Mc1vSdyNRASzuYN2oKeM3UW2ThzxozlZw0WDdncfZOsk9vYE/KsPhu+oXYm/+B9Bx8gaMhUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aN4yluCz; arc=fail smtp.client-ip=40.107.244.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AG9aK95MrVNugXElJd+0pBZwebrwc6v7y5XK4twHlRCuZ36E7cq7FzJV9oGuhuUJbl3QTt0HcacNGYpNDVCJs2eUNDgXguGqUseylbsZMA1TzxJb8a1UGloPjytv2fGF1ue1PyqJ0NRo+sKq9+BmjFfVg3dLY6Fwz/zgRKSN6yZekeMAg8n2fC8dunrVEGJCxWKlI6/dKoOHPUrulkwfJChmgfMDsGDRqyfa0oxZwCdJ6DoFYXEEsTZC2w/oANj7r6ScU42ThVViWKXbuZKLeZ25bwT7HRgeiWQGfL6Gg75T0zV6UIGIGUnD8n1UXd5GzAmFZn50tIZMOEAZ2VHFJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iGv2y1P88mSrN0dqliM55wBZPbBoFsL27OkBhr2PJLU=;
 b=TBCpy8LIM9rDbi7s5vE2grczVV7fCcHcBWIC6230/K39xi1OqpcWBceXA/9ZqC0g23F2tdrUOXIzYOltWyvZiGbXSkDkUZTxogpja5+rm4zhrkabcYDsh6wUS9ncDulG3si5wSNMX4PMNP7KSARKudq9nN4Q4jCCWfyXAat7OAP8fOj39C0rMKdSYnfIny5IDABcn1u4ldY8udPOt8n96RJ0bvUneGag6FhtuGvEiLtxRfSbdoGwHcJQ/xIF+rKN4ewq1ypSmeUClDebutskrwBN/3QlfKW945ovZ62noBh5T5Drwdr1GN3EmlaqJ3TbWx4G9fC3EP1uHpyRkU7qhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iGv2y1P88mSrN0dqliM55wBZPbBoFsL27OkBhr2PJLU=;
 b=aN4yluCzNmSAz1MT+Bh4NBEdn+nfwkruyyfOKMdb7SRo5SUl+e6OwqvU3K5hvfasNWt1NAgoejMOgYbRgp7NMnQn/ldxdwAUDlqxQ8ka3dPQX9lapknDTqKyy05sxD3pH1WK8Ix6uBkbSm9ljM3j0t4xP91EJXClwS0ZyKEnWOqYpdMoHvTYs5aTNJtf+Vw/lYH1kp2CgIgyS0qvDsEywI7FOKA+PYXHF0UNoJ3dIOXOqpIdH0poUDbZ4Hv/whzO7F0GhdyT8wPvHgfZSW6Kb0cVWbTlaT2ww1dcVte80UmjTjyW9fm7v9ADI+NeV8xize5wfTguvrMueJfarVPggA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 CY8PR12MB7433.namprd12.prod.outlook.com (2603:10b6:930:53::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.36; Tue, 12 Mar 2024 19:45:23 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 19:45:23 +0000
From: Zi Yan <ziy@nvidia.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Yang Shi <shy828301@gmail.com>, Huang Ying <ying.huang@intel.com>,
 "\"Kirill A . Shutemov\"" <kirill.shutemov@linux.intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/migrate: put dest folio on deferred split list if
 source was there.
Date: Tue, 12 Mar 2024 15:45:20 -0400
X-Mailer: MailMate (1.14r6018)
Message-ID: <A425ACE8-2432-43D4-9386-2CBD7FD2D906@nvidia.com>
In-Reply-To: <ZfCi7kvLoBvUnARz@casper.infradead.org>
References: <20240311195848.135067-1-zi.yan@sent.com>
 <Ze_P6xagdTbcu1Kz@casper.infradead.org>
 <74AF044A-A14A-4C66-A019-70F8F138A9AB@nvidia.com>
 <ZfBkjf4z-jpaNk6c@casper.infradead.org>
 <DFA2B8B7-C690-422A-BE95-82F7E112BB95@nvidia.com>
 <ZfCFCGkrLVpySa6X@casper.infradead.org>
 <76BBDB5D-9D40-44EB-A996-767404B85BE0@nvidia.com>
 <ZfCi7kvLoBvUnARz@casper.infradead.org>
Content-Type: multipart/signed;
 boundary="=_MailMate_3D7B9E41-B08A-428C-BECD-A241AF434C13_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1P223CA0009.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::14) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|CY8PR12MB7433:EE_
X-MS-Office365-Filtering-Correlation-Id: 623cb486-a97e-4719-c1a8-08dc42ccf4d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WDfKCXqPbpCInJ7fJGgjYxP57M42xvbrfaS1G+Ft9AM3V2hbTc+l8waqD4MNVxAY4g34PeyLpByKH2D09O1yBLpArL86gs3p6WmUZiOLJ0Tsi9ZYdJ0p6F7SNYFvwBL2uCJlLGVB4VsOQvSdDuhJK6egNkUNK/ngOll/o64boh5xJhiAIxY4ok/6KU7xXf0BhXIBCCEsWwq8zWY2AwQmc8rT9A/FWc608lztQSLalXk28B9U4trEJcFwhSVs+7gR8qPaUdI9yvs0sszK7ICV8RL4QHN2vvNuNP17X48B0mVafvF3iH27UmniDek6aSaaYMPrnUouRu54DDrT86EEnRvxxvhYOpLhqe2nOt9f0JlZa4/J8ipZ1w7WdYOdRT0CM3zIu+tYRmbHhc/lJB8B12aEuAAO9Oi6KQblSrMZs6da48XG3Gij7ZYZGITnv0ZJSUCTJXDIolsk6fIYaiudNuSOfCJTUzX3VUnz+wLx2fhsb5LidVtRjI7rikCnJGEuuwv/rZF23BUHkzkM18zR+TKX2wd/fKNhsy2iMgZs05XbhBGP43EsZgyb1tzKtz2cpzHUG642KtxnfndTH+0G4kLkalaFAvd75TEGdVQVqa/NnuXy9Papn9R2Qzp2MYKdoEr9OTekB/JF1i38j7oBQ5fRhl12lLmEXC9hr+oGG6M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oTSVdRqpLrFmYGan/c+2y6rD/V/wgfLGwHQm3f8wXIm+sfbssnRBzdJpDssW?=
 =?us-ascii?Q?yZKpAUTbFXk59QN6gLNl7MNK4/4rY8TsJ3RGLtrTZxP7bVmVQyuG2K3ZFuBB?=
 =?us-ascii?Q?CuxN1EZ6Jo+Rpq4A1b22wZkgAel1g2Qra8AVKl2iBoJxwtJCHXbUarwroFXm?=
 =?us-ascii?Q?3xvPwcHlwkOn/MN/JZoyf+siEgWUKHySiMFLwC/aajRfYCz2+j/VKCkywO3W?=
 =?us-ascii?Q?PDzZp148sb7MK6dxtjeeb2jBxyCxxpJgB3KMHzT/CcnbcNlp5zjZOAOFjiNR?=
 =?us-ascii?Q?nluv3w4fKJ0gmm0vaYffHlYcmJMYQmPdUlXSQU+3GhApYOR9glGcBqi0Gcyx?=
 =?us-ascii?Q?3NdoWx6GztMrLRZfdz6wQuXyAcfBYsZl5lFA0zwvNr4kFSfsjRDtI58++9Ou?=
 =?us-ascii?Q?PFOOScF0hM75yAm9qQx8e91Ww+NcBvBCaHeq+f11OKBlKUzqd7i3lY8HyZck?=
 =?us-ascii?Q?S1uOreEmWjGOXRSB0GwJwj8jj0omNN3pUS7UEJat5YWK31CCPuzE6UhOtG/l?=
 =?us-ascii?Q?gE7wLX4RgCOlhWtEZjTpXZuu9h87z/8oZjdU2jShvRwqBerwX6dc1ZUKFYjR?=
 =?us-ascii?Q?7y334JO2G2BgjeOIkHPIgP+XB6/QyuXqsP+RWXS4jwd+tu5mEc31nNWw4wwn?=
 =?us-ascii?Q?k/Bn+PEUYFLMC67LXUccKybGhDkeYoQ/qH2Ihps1uZyvn4GUD7MfEh9YPYqh?=
 =?us-ascii?Q?/Jg+Lz3gXdpJaabCzvUpFniUvJbrTA9iwVHC23o+csxkYKuUl+4Z09ITnPu8?=
 =?us-ascii?Q?0rX0nfowUa4+rCrD4syAjdqUhvLhgx1Bl99pjUa0Phg+OCgxJTWxRPHQ3F98?=
 =?us-ascii?Q?5Zkt0ffZOPUb4+XNwd+cn5csKtQO+iROwk/crGgiYKK0cX8S5n1L8xSb5vDS?=
 =?us-ascii?Q?rZ0LwTUlYfHEF51xgh5/gTMivzZ+DHJUdcVXkQNFc8H6UCBiMh96MxtkEcQm?=
 =?us-ascii?Q?EeFrNmtuRBasRRHZQH9KnzC9E9SbnjT+CgKUwjG0kxsECqL8dWAS+Ms3b6a9?=
 =?us-ascii?Q?1SpaVgyIxxJpFnjqUQsDyB2GMzHL9+jpk2d6MuIoPZU1GPci9kufs8sITmXK?=
 =?us-ascii?Q?GKAs5R++Gw0NeURxLSCxXElkbyxzdwv+OAPJELdAkuN6zYBBPeUsg1MLC1zw?=
 =?us-ascii?Q?w/gSOQZfEfGs7mH22FuQItNglvMmfZ+vUQEQNLu1eu/T/9HaRQAmHCFQkh8A?=
 =?us-ascii?Q?WB7Tu44zeuyCVppoWwMIJKy0OxJLZha/rBrufit3lFGpf+E38TA5oWzZYlgX?=
 =?us-ascii?Q?0xV4rKAQ6qjTpWA6qoEYTLOkl4DiWTssg3UIX83XEfFmOX3Of0Mz90QvZc4Y?=
 =?us-ascii?Q?ZWL9pNPfVxbNLClyaN1WDyQ5cIh3mBqaD9H15vK4/NWV8QH1D4DYICRsL3Qb?=
 =?us-ascii?Q?pDevHNmPm4CjevbU14yVA/VtdmEXooCzSdVDTo6TExlLagvJ0hLw0uKCCcvZ?=
 =?us-ascii?Q?6/X1Frj0RKkpzuT4OinKQlf6A7BoPOv2HYGKgMk7+027g69TW6cl8brl8hY6?=
 =?us-ascii?Q?iw/ndIl2VdVKXhObsmBgVsWrfHNgAY35P5Z6iCoT5yqsAHE9oTl5s3El7iu+?=
 =?us-ascii?Q?Z48A6UsbPdA4D3WBhLg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 623cb486-a97e-4719-c1a8-08dc42ccf4d8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 19:45:23.0159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Ji61e7xk3GLxRZxO0xEqNRrBHLchBGs1biSZ/dSTKYq5bXKoEcQB0uf16W9/PvO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7433

--=_MailMate_3D7B9E41-B08A-428C-BECD-A241AF434C13_=
Content-Type: text/plain

On 12 Mar 2024, at 14:46, Matthew Wilcox wrote:

> On Tue, Mar 12, 2024 at 02:32:43PM -0400, Zi Yan wrote:
>> On 12 Mar 2024, at 12:38, Matthew Wilcox wrote:
>>> Folios with a positive refcount are
>>> removed from the per-node or per-cgroup list _at which point there is
>>> an undocumented assumption_ that they will not be removed from the
>>> local list because they have a positive refcount.
>>
>> But that sounds very subtle if not broken. As an outsider of
>
> I merely deduced this requirement; I didn't come up with it ...
>
>> deferred_split_scan(), only !list_empty(folio->_deferred_list) is checked.
>> The condition can be true if the folio is on split_queue or
>> local list of deferred_split_scan() with elevated refcount. In that case,
>> the folio cannot be removed from the list (either split_queue or local list)
>> even if split_queue_lock is held, since local list manipulation is not under
>> split_queue_lock. This makes _deferred_list a one-way train to anyone
>> except deferred_split_scan(), namely folios can only be added into
>> _deferred_list until they are freed or split by deferred_split_scan().
>>
>> Is that intended? If yes, maybe we should document it. If not, using
>> split_queue_lock to protect local list, or more explicitly folio->_deferred_list
>> might be better?
>
> To be fair, the folio can be split by anybody as
> split_huge_page_to_list_to_order() is careful to only manipulate the
> deferred list while the refcount is frozen at 0.  I'm still trying to
> figure out where to document this behaviour of the deferred list that
> someone (for example, your good self) would actually see it.

Yes, split is not affected. For migration, hypothetically if a folio on
deferred_list wants to be migrated without split, it needs to removed
and the dst folio needs to be added during frozen phase. That seems
to be very heavy operation to just get a folio out of deferred_list.
But we can change it when we want to do that in other scenarios.

BTW, s/_deferred_list/_deferred_list_only_removable_during_scan/ works
best for me in terms of documentation. ;)


--
Best Regards,
Yan, Zi

--=_MailMate_3D7B9E41-B08A-428C-BECD-A241AF434C13_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmXwsNEPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhU3DQP/jaFpxjHK3HgO1Tz67v75vReC8kVsoRKxtIf
35DtoNjnqjuXxlH8b/6eh7V4lEanyFCW5L/5E2/2MpGhdiEaW/P/aNLlX4bT+9py
6NISZR7IXOyosifqRvwuItmLHsrHwdbFfZGEGOObou+mtLxKQaTq2fNFHd69wehx
fiBq6zAeOlExRDm3dKswMRH9qUkZT6mgK9O0SAMUsPPpl9oHJtTGEP+LwvzGE+5B
gqBuFEMNdi5OHAFFc7re8h7h/pTSIN/sBTbMP91hvqcLozvhbs9/z7YwCCECKjiF
vDDLH4+BP+aJ/Q7vomGRVgfkhwA8c+fmlVOcEUnGlg9OQVZnUaUBWgPptMyszPsC
Rl7oPLH54ps7l4He9ixdGp6Jyp/D59nesSx33NDwriqtJMLxPFVbRnkOc1GgXhsC
Dkg8mH5XyrG4DT0lA98964jC0urkowsZ0dHSeMHV7oU2QG3wdsHogqQVy0bCds3M
8y8pHQMPn4Yq1XMatMarH6g68WMGIU+/4uBYh5YWF8X2qIE11dSCZ/o1RFVVYLxN
Al6VF26HAicW9FuhuBlqWs67dJtxtYSSspmbM2WljHACeq5y/RfMGc1D1K5E+skN
0aKx6htA+ZXHHp7Ixlj0gm4+Oq8I83254NynrPx0NGlhSyBkyG/W0sk+rj+yNhpw
ZxeFyCKb
=uR2Q
-----END PGP SIGNATURE-----

--=_MailMate_3D7B9E41-B08A-428C-BECD-A241AF434C13_=--

