Return-Path: <linux-kernel+bounces-142812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C298A3064
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9200AB2389B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CC586262;
	Fri, 12 Apr 2024 14:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Thehb7Ag"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0088155E4A
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 14:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712931688; cv=fail; b=r15+WqQkh7SvCn7oLzrK86NVYfozsg1XVdqbVBOxwEc8mP0YuKmF+cKxWP9W73YABroLn96ZjpOBtxN1O2eyv6jxDCjO/oxCf4ifdzgDKiJcs9I7q6e2aY7Rbf0ZgeVYUe9QfnH8wAAaNyObRsiGOI9p+vm2jks5W2TDLQuuyCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712931688; c=relaxed/simple;
	bh=FdJGG09QtrXJFUieG/DSKW/iwsDKteowDR0bCmC3zgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t1dmjpLGX1qLwFzHuUFCs+qEkFTX0v1m4dXpAI5Hiq0aqCCdh0btgSLbTkA40hN9aGHk+vcmWEXeSRuZwrXuIUQ/d8gSk/j5BO1C+BCpxmEQpM0HjocLTYLKht6VfBkkiWADXYygrZ6yF8MNsxOLsobOSkMwck/bjJ/XEE5wsKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Thehb7Ag; arc=fail smtp.client-ip=40.107.236.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DnnUfPsMOtq1hQIsRta+tfHP6V3pu0M6+HQ7nmWKn2+n6vqQbbVjE/wOElDGF5N/3xLFs5ixBB8aCCtXLFOoly6pn/N24yGZtf4Tcx92v/QZhIwjeVcgC4D/IstTkdpYrH0At+veAdlP/8AootWuGAeEoTub0+gJEvznvDrhrzOLkhrzjAemepBwlygwsyekPEvYGEJLktbYgVh5BrMJQ2koMF0QEKfqYWXviou1omvItDo5zk6MABO8iDKDqOHIDMq86InP2Nxajo0vX97HmunwGB8ecSfiyZmF+ipFtfUT41CYgvDNL1R+jrUlR1IcETzRVON1KfGxI5VrK4OTkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ve0QDaWAYMhFXllK0v4tMP8raDe7dzJHUN7S4LfqzlY=;
 b=S7f3pzWKJ3CxkcfnOWVvUvGlPvcF0UKuj9Yll2PtDA8XUZg/TzHDNGuf3/jr2en5rWH3WUHt1DAzjSeLnMsDhM7TRqS3JThGM0GbPhUT4XK4RvupRPTN8QkgdEZ9NhbbuYDGA9XSGWSg2jUAdp/a2NrfZOS13CzgX4Vd1g+a9yFe4f2jeQb2tcyoGxDqShf1NFJBM6dgnMDdAEButj+xcEjTSdAgRxopg39AlMWTVqyPFVBQv93jxuRCOhQvMp3jnSA3h+kJHhWDnsoJ65qDzMf1AvciUtfxQ45+HcoaSfOWtXZo3javelGHgyPGLwerdZk+1tclT1nVpE6GAR5B1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ve0QDaWAYMhFXllK0v4tMP8raDe7dzJHUN7S4LfqzlY=;
 b=Thehb7AgnyYSbxC9iKo5q1kr1/thoIfexw3rl3MbeSzSr5APEFJqZ1eUsNHez8HV0wmldzZ/T6pivk7s62FsatspKIa1v/qYKme2oIVm326kL142HJeD06TN9KR4mDixK5JKWNWrEAQmmcTAz4jIa0kLuVje9jhFZ8cNKx5mMA00g3BypvNd2DEiF3F/ajBSoqoLpKG5GX8X0mEiHDrbMnJHGc42YNcNXo0FoqoH6VIHtUEY/WUXmgSMke9VCRfOKw5/bOdJVben2fdWpcfqdUZ92d1pr/eDhMVFYSFHzi/Tpk4LvBh0mg9l3cMOn52uTEX7cpU/ttfTQO1xf+54ag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 MN2PR12MB4333.namprd12.prod.outlook.com (2603:10b6:208:1d3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Fri, 12 Apr
 2024 14:21:23 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7409.053; Fri, 12 Apr 2024
 14:21:23 +0000
From: Zi Yan <ziy@nvidia.com>
To: Yang Shi <shy828301@gmail.com>
Cc: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Barry Song <21cnbao@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/rmap: do not add fully unmapped large folio to
 deferred split list
Date: Fri, 12 Apr 2024 10:21:20 -0400
X-Mailer: MailMate (1.14r6028)
Message-ID: <0A4D2CA1-E156-43E9-A1C9-E09E62E760A3@nvidia.com>
In-Reply-To: <CAHbLzkrxR_cpVd_KF1rz9CTVmr4q0KX7T=SseOo8X5u23-5ZJQ@mail.gmail.com>
References: <20240411153232.169560-1-zi.yan@sent.com>
 <ffbbade3-2de5-4bbe-a6e4-49d2ff7a2f0e@redhat.com>
 <CAHbLzkr99knWKZvE4WCWKKr=eezkg89idpE59oo_oBneAQynAA@mail.gmail.com>
 <86722546-1d54-4224-9f31-da4f368cd47e@redhat.com>
 <CAHbLzkrxR_cpVd_KF1rz9CTVmr4q0KX7T=SseOo8X5u23-5ZJQ@mail.gmail.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_8B18A513-34CB-4D0D-B1D9-08E3D10E2574_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0324.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::29) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|MN2PR12MB4333:EE_
X-MS-Office365-Filtering-Correlation-Id: 69ea6d69-b0ad-4f3b-3928-08dc5afbd4a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1xSIn2Ged5qr559/PZBjFCy8e2q6RsntphIBhUKM9qQ6oUAiUrdht71ri7Z85nBKHPH9JklfaFSrix4G2GILHAFSDL9z56zi3OA+tTsMP6LezeXfyjWSgvy9vY/hBc9384lPsj3JK7Lxybv3JoR1iXk1+YqXtqUqZ+nhT5nhDaaFz9rmWlCGtHVtEOV4K3OqLKAItsCkwmhYbtKuIHDzP//m5HZ+6qhgxoEtsDPd0U+JgzkQqq0MGsQ/GiH0Jdja0+cva2jCOBOn14DmQTl7wQoCurq5cDmGoCGNGh/wWumBgXnWvsCRDm/J15fsWgTAfj78u8FGGBWvrRZB61mKO6rTirrq4Sm8sYrFHUyJ2N8POKlo9own73DCbO05EIwlUD6geJTL8fNu9JIKGaa6Hec5DfsDyUi6e5kU1ws13G3//BKyWQEZO7wOs9G0bPxO17STeuZJrFnSezXMBLYLznZw+jUXdBFs+9WK0sihMPmpXqMuN7H12sNY4BF1nAcwWCpX7BPzNs5JomhJQQKVr+am4QJ+ObAYwKCC1CjuVuM5u8Z0TFwsFK1fNzuoMWyeBRzWLxxmOY1vvygV4xfwANBaI46rKxjvj5sPMeFO4r5ifytY2c74p5Q6OEaaL9elcFfkbtlcRHXYfMsTMeAhJnzugHfx1tZIz9YMMj4fv4w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dDE0WkJpUS9rNkNhZ3N3RDR2TkFDcndmWGdJZzk4Z0RzN2tucVlNTVBndmlJ?=
 =?utf-8?B?ZmU0N1UwRDlKaTJnQlcyYWpjc205Yk1mdm95dmtmcUt3d1Z5dFNWaFpOWlhE?=
 =?utf-8?B?SFZpUkF3YUh0VHZucUF4b3Jlemw0NUZBNk8vVG5UQXdaRTc0ZEtsdWlQeG9k?=
 =?utf-8?B?RGdBV1B1RnczcmdUSEVLRWoxRmsvOXJZRTRlWUc4a0cwK3VyWWlQV2FYbVkr?=
 =?utf-8?B?VzJnWHZGRWZ6WEd3NWhkNk05dnFNelIvUW5YNTRFNjRPMFR3OHc2dGFjQ09V?=
 =?utf-8?B?MVQwREd0QWN4dFltVGdLUDE5djUwN2NDWGZSM2VKOERVamVoN1MzbUFOaW5u?=
 =?utf-8?B?a2Nsc05wM0UrcTVDMVY3cWFMMStQdWx1cTRkcXdaUGNlN0E4d0EzZ2FkYWFv?=
 =?utf-8?B?aTJoOWJqWHViS1c0RlFOV3hQVjduSEl3TEN5TzVsaExwM3hXV3JDeXkxY21m?=
 =?utf-8?B?cWpPZ2RhM0tPbERod1Zmeks5K0U2NThtR3RHNWZLWmhqYmh0ZEsybVExeGcy?=
 =?utf-8?B?T1BLdXlUSCt4eDgxMVdaK09tYk5GejY2SE0zelowRkh2RTlhT08wLy9JL2tR?=
 =?utf-8?B?TXlsK2JMRmwzUG8vWWxvZVpONDdHVDVKTjVFNmJhcFpVVk9WY3J5cFZHUnJ6?=
 =?utf-8?B?U0svT0ZVRkdMYVdKckFoeE1KMStBVFJxaEY0TjRIcGtUZTFRaE8zd010Wlg1?=
 =?utf-8?B?cmE3SS9VenNCYjdLbWRqYUxTZWJBYjJiRm9BaERwc2dnbUxQanNoWThlV0Fk?=
 =?utf-8?B?UDVWa3lIWWd4MDduNC91aW9BSHA3eFNJN0tVUEVsZUVUektqNXhDbmJtd3Ir?=
 =?utf-8?B?V0pENGRIVFV2ekRDc0ZSZU1CMWRQb0NnK2FmNi9LMG9naXV4M01CNkZyY1lD?=
 =?utf-8?B?OEJrb2wxWHQ0MUNtTjQ4UHlDSmtmRUtIWlJhbGEvOUpBV3d6ZTcyMWFkOW1M?=
 =?utf-8?B?U3hwd1hzeGdpVHkwck8wZ0t0cGZrWGVaN0RoUERQQlVJL05LR1BkcWM1TVh6?=
 =?utf-8?B?MzRTcUNHaEo3ZnJXclUxOHlDZTZTdklwdmMvOFgyWFlaWTcrTFh6d29LU2tj?=
 =?utf-8?B?dkhhNCsyZlNaMUtYVk0vWWw2cWRaRGRKTkMwaVhhY2JLT0tEMnBhSnRYZkx3?=
 =?utf-8?B?cGxoL2syRGJheEF1UkZ5MkVud3Bkd3MwZWhQcTRLa0J1RU1zQkVKRFdFUnVi?=
 =?utf-8?B?alhUOFpkREkrdnpUcys0UGcxYWNJVlErVzhFOHRtMG5la2t3TlJ6enhSVXp4?=
 =?utf-8?B?ak9mcEJheGVMUzBCbVg3dXVJZEpSMEt6S0pWVjlpNDFrdyt5TVpQV0JPNVla?=
 =?utf-8?B?a1VvSU55TWlkMk5JRkcvZ0hIYkVtZmdiaDZkcVM4RnVBaHdQVThCVnA2Skta?=
 =?utf-8?B?dURRcVFNQ2tQbk4xOVI4bHAvUTRsV25YRUNWdnMzalBESmpsK2JqRVQ1SWV3?=
 =?utf-8?B?WW1lUVBTY1VNZ3MwK0VlOC9YTkhYWDRFcldWV3ZCUkQ2RUlsM0RTZXRSRVVV?=
 =?utf-8?B?K0xhcWp1TVR5MDM0MWREdS9uR05RMW5HZ1IwL3NiMHBZYmhPd3FwY3lpMWd2?=
 =?utf-8?B?MjRjelJEb2l2RnJOdmQ1VDFsSnlhb1d5Ym1VejJlYVB1OFErdjFPK0RNY21G?=
 =?utf-8?B?bHlFMFlSWmNJNjB4ZkxuZVVISFVoOEF4SDlDR05JK09kVW1mK1dPaHIvWTRn?=
 =?utf-8?B?dFpHWEkyR0Z2ekFOMVFxR0w5ZXZpdGdjNWl5Q1paSUJ3NGdZbW11MTVzZ2Zj?=
 =?utf-8?B?ajBMd2FlQ2FaeWRNVmpPOTU3bmkxUWRndS9qRlltK2E0cWJITkFNNnVqMEVV?=
 =?utf-8?B?djZ3akVVUTVDbXNTWWE5Ly9xWVZwaHN0WUw2M0RlcSt0dm4vRnM0MFhDbi9T?=
 =?utf-8?B?RWV3NGloeWNHdzFWc1BNZ3VOL3F6aWM2Rzl3TDJpZ2lqeXcvR3Q4VGtWbkRH?=
 =?utf-8?B?V1RNL2VPM0h0SDhPSzhhMUpkRTVPYUEveC9BcW45dCtYYmc5eThGNUE1OGRJ?=
 =?utf-8?B?QndNSW9UT1EvNEcyVHhaT1dhSUtxd2w1KzEwb2NUTVNpK1I5N2h2S3UrcUpJ?=
 =?utf-8?B?aUd1bXVvVW1MbDBJdkVCRGJiL1dPWEh3NVpyWE1pTVV1N1kwOWp1RGd3cVpH?=
 =?utf-8?Q?Kn0BXhghlTB7HDqaVqfUO7ilE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69ea6d69-b0ad-4f3b-3928-08dc5afbd4a8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 14:21:23.2602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S3+kOgtkITrHaZMuNcOD2wJMLCKutQoWJPO2Qdb082WXTvZFm0Fqe2/L+LZ7vrhH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4333

--=_MailMate_8B18A513-34CB-4D0D-B1D9-08E3D10E2574_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 11 Apr 2024, at 17:59, Yang Shi wrote:

> On Thu, Apr 11, 2024 at 2:15=E2=80=AFPM David Hildenbrand <david@redhat=
=2Ecom> wrote:
>>
>> On 11.04.24 21:01, Yang Shi wrote:
>>> On Thu, Apr 11, 2024 at 8:46=E2=80=AFAM David Hildenbrand <david@redh=
at.com> wrote:
>>>>
>>>> On 11.04.24 17:32, Zi Yan wrote:
>>>>> From: Zi Yan <ziy@nvidia.com>
>>>>>
>>>>> In __folio_remove_rmap(), a large folio is added to deferred split =
list
>>>>> if any page in a folio loses its final mapping. It is possible that=

>>>>> the folio is unmapped fully, but it is unnecessary to add the folio=

>>>>> to deferred split list at all. Fix it by checking folio mapcount be=
fore
>>>>> adding a folio to deferred split list.
>>>>>
>>>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>>>> ---
>>>>>    mm/rmap.c | 9 ++++++---
>>>>>    1 file changed, 6 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>>>> index 2608c40dffad..d599a772e282 100644
>>>>> --- a/mm/rmap.c
>>>>> +++ b/mm/rmap.c
>>>>> @@ -1494,7 +1494,7 @@ static __always_inline void __folio_remove_rm=
ap(struct folio *folio,
>>>>>                enum rmap_level level)
>>>>>    {
>>>>>        atomic_t *mapped =3D &folio->_nr_pages_mapped;
>>>>> -     int last, nr =3D 0, nr_pmdmapped =3D 0;
>>>>> +     int last, nr =3D 0, nr_pmdmapped =3D 0, mapcount =3D 0;
>>>>>        enum node_stat_item idx;
>>>>>
>>>>>        __folio_rmap_sanity_checks(folio, page, nr_pages, level);
>>>>> @@ -1506,7 +1506,8 @@ static __always_inline void __folio_remove_rm=
ap(struct folio *folio,
>>>>>                        break;
>>>>>                }
>>>>>
>>>>> -             atomic_sub(nr_pages, &folio->_large_mapcount);
>>>>> +             mapcount =3D atomic_sub_return(nr_pages,
>>>>> +                                          &folio->_large_mapcount)=
 + 1;
>>>>
>>>> That becomes a new memory barrier on some archs. Rather just re-read=
 it
>>>> below. Re-reading should be fine here.
>>>>
>>>>>                do {
>>>>>                        last =3D atomic_add_negative(-1, &page->_map=
count);
>>>>>                        if (last) {
>>>>> @@ -1554,7 +1555,9 @@ static __always_inline void __folio_remove_rm=
ap(struct folio *folio,
>>>>>                 * is still mapped.
>>>>>                 */
>>>>>                if (folio_test_large(folio) && folio_test_anon(folio=
))
>>>>> -                     if (level =3D=3D RMAP_LEVEL_PTE || nr < nr_pm=
dmapped)
>>>>> +                     if ((level =3D=3D RMAP_LEVEL_PTE &&
>>>>> +                          mapcount !=3D 0) ||
>>>>> +                         (level =3D=3D RMAP_LEVEL_PMD && nr < nr_p=
mdmapped))
>>>>>                                deferred_split_folio(folio);
>>>>>        }
>>>>
>>>> But I do wonder if we really care? Usually the folio will simply get=

>>>> freed afterwards, where we simply remove it from the list.
>>>>
>>>> If it's pinned, we won't be able to free or reclaim, but it's rather=
 a
>>>> corner case ...
>>>>
>>>> Is it really worth the added code? Not convinced.
>>>
>>> It is actually not only an optimization, but also fixed the broken
>>> thp_deferred_split_page counter in /proc/vmstat.
>>>
>>> The counter actually counted the partially unmapped huge pages (so
>>> they are on deferred split queue), but it counts the fully unmapped
>>> mTHP as well now. For example, when a 64K THP is fully unmapped, the
>>> thp_deferred_split_page is not supposed to get inc'ed, but it does
>>> now.
>>>
>>> The counter is also useful for performance analysis, for example,
>>> whether a workload did a lot of partial unmap or not. So fixing the
>>> counter seems worthy. Zi Yan should have mentioned this in the commit=

>>> log.
>>
>> Yes, all that is information that is missing from the patch descriptio=
n.
>> If it's a fix, there should be a "Fixes:".
>>
>> Likely we want to have a folio_large_mapcount() check in the code belo=
w.
>> (I yet have to digest the condition where this happens -- can we have =
an
>> example where we'd use to do the wrong thing and now would do the righ=
t
>> thing as well?)
>
> For example, map 1G memory with 64K mTHP, then unmap the whole 1G or
> some full 64K areas, you will see thp_deferred_split_page increased,
> but it shouldn't.
>
> It looks __folio_remove_rmap() incorrectly detected whether the mTHP
> is fully unmapped or partially unmapped by comparing the number of
> still-mapped subpages to ENTIRELY_MAPPED, which should just work for
> PMD-mappable THP.
>
> However I just realized this problem was kind of workaround'ed by commi=
t:
>
> commit 98046944a1597f3a02b792dbe9665e9943b77f28
> Author: Baolin Wang <baolin.wang@linux.alibaba.com>
> Date:   Fri Mar 29 14:59:33 2024 +0800
>
>     mm: huge_memory: add the missing folio_test_pmd_mappable() for THP
> split statistics
>
>     Now the mTHP can also be split or added into the deferred list, so =
add
>     folio_test_pmd_mappable() validation for PMD mapped THP, to avoid
>     confusion with PMD mapped THP related statistics.
>
>     Link: https://lkml.kernel.org/r/a5341defeef27c9ac7b85c97f030f93e436=
8bbc1.1711694852.git.baolin.wang@linux.alibaba.com
>     Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>     Acked-by: David Hildenbrand <david@redhat.com>
>     Cc: Muchun Song <muchun.song@linux.dev>
>     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>
> This commit made thp_deferred_split_page didn't count mTHP anymore, it
> also made thp_split_page didn't count mTHP anymore.
>
> However Zi Yan's patch does make the code more robust and we don't
> need to worry about the miscounting issue anymore if we will add
> deferred_split_page and split_page counters for mTHP in the future.

Actually, the patch above does not fix everything. A fully unmapped
PTE-mapped order-9 THP is also added to deferred split list and
counted as THP_DEFERRED_SPLIT_PAGE without my patch, since nr is 512
(non zero), level is RMAP_LEVEL_PTE, and inside deferred_split_folio()
the order-9 folio is folio_test_pmd_mappable().

I will add this information in the next version.

--
Best Regards,
Yan, Zi

--=_MailMate_8B18A513-34CB-4D0D-B1D9-08E3D10E2574_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmYZQ2APHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhU5w8QAKgu00zj04/v7YMTxzQHxEYKHABIGpeFN2cf
IiA7Sm+JMJMG/sg66ySkSearE+3D4/1XwA25o4FBg9qNZFi7fq6mePNZAoJElIGp
Kyh3k9G67Y9qopCJ87YoUV/OGuKUEY5dydPL7AhT7G0AxZWKyikBMGdHZe8+zMqx
40ZCeLJfx2sRd4DNewl/MI7F0AVP07FgQ47QQ6XiFzh9we0x8y0Ix8S9nCYT2rU5
P4POPPYFB1SXb9ZbsgUnIUSg1VP881GjN4YSC6r841OzqBJPNJqBXR6DCgA92GOE
d7bqectmwKWiVx6S10rttoApt6gi9wqK3bH8dmu/XMAOG3Wyah80mDueOKYa6HZd
OX7lIu993+buovZar7+bzDwYcp4ou7G7RKzo1xqC3YdbyWJWTsZkJj2c6fG6wjQk
pbyuLpwE8Om792UswPNKdmbXByKZhUSFQygvlSFYjmRNZo/1Vp1l+XQV8OtBx3Lp
7BGy0IZtsHgGGUgrE1aIOEjnbMZq+znAUHhMEmh3fhYQ3zRuAek6ZujlpRzUoeB7
hjnix/vV1BHeqVqGECe/QnQztmBT0+TDCygsLmWNreH1OHjLZKjQ1TsMB1m0u8RA
ZYNSB6x/QXd9WV28U9LBdj+JKmz65/y+fK3L1mflm6DVIsIeLLRLF8iASf5npX4a
IAqz2noF
=GyDM
-----END PGP SIGNATURE-----

--=_MailMate_8B18A513-34CB-4D0D-B1D9-08E3D10E2574_=--

