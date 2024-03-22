Return-Path: <linux-kernel+bounces-111921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE85D8872AC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 19:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B3F41F2148E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6330629E3;
	Fri, 22 Mar 2024 18:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="trxkjJ1T"
Received: from NAM06-DM3-obe.outbound.protection.outlook.com (mail-dm3nam06olkn2038.outbound.protection.outlook.com [40.92.33.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D3F62800
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 18:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.33.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711131117; cv=fail; b=aYkx+EAPLbEfpA+FKFosbzcMGyOX4PfqbedBtNfLPWz9O5sfeixDt9qufCF3srWBT50Ky9OTxZ498Unhecgi/gW5hetXrb38BAw5bja8BoVMk/bIytbzubjPDukbJNm/QJgoVCz71CXq93ewANkPuHsf+EHwwkQeFM6Wc21t+F8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711131117; c=relaxed/simple;
	bh=xXxsVXr/QzT3qAnDFcSeXvdOH77CWqI/U89Ht/ZOH8Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V5rZslrXmiDDnDV/syCqVgvRFDr8AEmIGgCNermXidrJb2xjtIOSYJ5OaGxcwYJzD3+okuSvVdp9X37n/XDkVxfPTO4pH9k597vzyJJuwbx6kBvcoCFgc1467tu3v9SCW8ZqPIW2QOttGVw5xge70BOTpRJ0E92IT9fgtKxjt10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=trxkjJ1T; arc=fail smtp.client-ip=40.92.33.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LSxmSbxi4YsYcciZRTn7JYZLbBpmghrRsNYV/tCB1xtnNuBOCe+NSuLa4HAVR02nm5C5fdxwcZBLdw7q0cY2TjfEI7FSHNN1slpW7N/qqMV14cE5iqxc6znRTi9NvtTo2b82KQOSsZ4QZ5OG45Hc+2A07eZ9PJUQLL9FDhUk82BJ/TwcLwuz/BehIZfWSV7oWkuX9klpoz0sNpuKmlwZju4JGaSBkgNPNcYvyi9Em11cObkiog1rRR6EA8cx9oXWRR19BxPksvoPDVPfssAXTGw2J22y2TScOKraZqOCqjFtT/Lqgyzdv4fWRapYrzelH0paa1rgm2TJZcYd8w/TqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aTvLV3U94Q11Y4CESr0zXsak/18u+4rZXZVbtHmCJSY=;
 b=lmuk3YbnhgQFtdY1UOjbiXKR1pE3qwhLoxAtFaDHaxhBqYzWQ4hSUzZqzfJKsboKj7KqujfmV3gDg61CERWAY3zwxjZSIOe9UsBjoLdOCcQjcCHlUkA2f+N3tODOkOqK7dD4vsMAyNswa7NJKBiF2gcY0OsbMiFDgKTa/e7Dts5x4nYww/aODiSwysAWfRRCt1GqPn13jl/SxFpSnS1g2lw+rgkf9g2MLLMJCBba5IUMVuk8q/3FLPuFjQzpYP5On2j5VwVB4vpN2wUDrtxRWf5zItIoV4ZZtIDhixHLYMqLyHK6h1D/Iqpm7sIWznxfynGq+ssanaDoQetbzp0sKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aTvLV3U94Q11Y4CESr0zXsak/18u+4rZXZVbtHmCJSY=;
 b=trxkjJ1TCq89/+lwm0eFrH7ur52ukCYsQUhWS42RJDafcRHhCLB2JTlXF25+KjuYfF0oEVQWAfbT2AOUDYINjv/X1p5rq90esuz4gdiDTXEZem+63+zt3dmlbXt65dIoApqsaM5/YJT4pzfKe657+uawKrGkePchUSVbNY1MKjUvMxZyLgL86IYuMm1ViIS13cqV1fd0aIaJuXbwY+X+dsBwNtimoyJ+bHr1ovNLHR1jDY/yILpQxFBh+UrlJR+KMBPcANKizrtGAL4Xk6jrV3bq7mYmByVq7FasL8rFRODM+CGHMBBqIW69QMKMB8ly8l+XMDkI29ViTg7Or3Fo7A==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SN3PEPF00013E2A.namprd02.prod.outlook.com (2603:10b6:82c:400:0:3:0:a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Fri, 22 Mar
 2024 18:11:50 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::1276:e87b:ae1:a596]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::1276:e87b:ae1:a596%5]) with mapi id 15.20.7409.023; Fri, 22 Mar 2024
 18:11:50 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Will Deacon <will@kernel.org>, Petr Tesarik <petrtesarik@huaweicloud.com>
CC: Christoph Hellwig <hch@lst.de>, Marek Szyprowski
	<m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Petr Tesarik
	<petr.tesarik1@huawei-partners.com>, open list
	<linux-kernel@vger.kernel.org>, "open list:DMA MAPPING HELPERS"
	<iommu@lists.linux.dev>, Roberto Sassu <roberto.sassu@huaweicloud.com>, Petr
 Tesarik <petr@tesarici.cz>
Subject: RE: [PATCH v3 0/2] swiotlb: allocate padding slots if necessary
Thread-Topic: [PATCH v3 0/2] swiotlb: allocate padding slots if necessary
Thread-Index: AQHae7Pv4SNgrMIt8ky2VYTC2f59Y7FD3oWAgAAqOwA=
Date: Fri, 22 Mar 2024 18:11:50 +0000
Message-ID:
 <SN6PR02MB41574F4837E875F3D158B329D4312@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240321171902.85-1-petrtesarik@huaweicloud.com>
 <20240322150941.GA5634@willie-the-truck>
In-Reply-To: <20240322150941.GA5634@willie-the-truck>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [XGqVcN2MdnpUDOuHikYKfkhi5SkWfctk]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SN3PEPF00013E2A:EE_
x-ms-office365-filtering-correlation-id: 99a20e44-2544-43e2-5cda-08dc4a9b8bab
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 394aM7hl/5n3MOq79lG5YwpcSBvRIii3bzGi2ZnFbkzUMMsgFZRKXrNJSimr5irPm42FxQdxr0KwfLILG20AG+T2TQKNHoxPCAvsDttt//vpQ6aGamZiSeq+pHDR/KPLL6MxUnvM/m9DLXd1vS/jy9czB0jYR3H7do9roudgFFIvmHR3Eo7kvNWcwwSGTqbObyh8boVotaNdmcf55Z6e4yRbEZf+TWLJ7a5KzBmSwjBz+AfrkdC6mHIkOYnrmf2O5nDvEtk1F/Un7TX0Ue65yhzDcLN3WJkVedHFLmpdnmbMNhNZzIiv0ZNZSaeK19lZzGEE996rDTZ7bDq+5occoiRhi4xj5ZiO7eAhWd5I/8wSTr01hgz2iKy/FRifIBB3YUyk0o8L50p1vM47NgheGdWM6g3q8JACEbXsGTaM+DGi8ZaVIDPV9Qf9Q+oK6lxAbpnwjiNrYXT4YX3pf4wxg59VsrMq7O1GYjcS/5/RU0He4u74Tz+TZ48JZtONtMXmtuIvzNFXWyVLkMnfW/XsyL0S3fwzGJ/Xv8lTWk5HwX+1F43aWnjuQzNjMh6mF4Xp
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?iShP3LE8mZfp8+FO6QJPouqCjfJkbqIZyGs34gzKyd96GC+AkrdkjSWexyTz?=
 =?us-ascii?Q?ukHz7jx6XkrkiqcuOGa78qB6oAFntqYIxmt0VD+H/jhrcRvA90nlTFQMDi7G?=
 =?us-ascii?Q?XNpzfxw05590mWkWJMC9DHV22v2f39Lv1abc4uq+bME414iXF440/xmhdD2j?=
 =?us-ascii?Q?yMK4fyMJvZNF2Wpn9g1/buclher6pSWsT9wasQeMUsgfRTsO5+wE7SNbQ3jt?=
 =?us-ascii?Q?msFrbPu5op5I9drMFr5n6Hsp6FJfXzpGoURBa7rIpbpHH4LT0XxjJXhcPr2p?=
 =?us-ascii?Q?ohcrNe/VQkj6uIrU1vfr+om5Y/l3tSmn175FIlbpR00TuC7TFGPv8dYM4GK7?=
 =?us-ascii?Q?X35P23jV/lw8U/WKi8fPmq+xqbTJKmXLWp8vqCIYxCXpqFjdMjAhL5Fpr5H6?=
 =?us-ascii?Q?VAkL7/bnJJNXOkcb7tTLw1R5BfdyF9oXtJc3hSrD3sATuMsV88liiPE6v71X?=
 =?us-ascii?Q?BYEw3KWOfc9n4OQgy0xfJAFT4SDLQnv6LQmdODZjsvkhFO68e5rgBEPGv/aH?=
 =?us-ascii?Q?wtz7skUng0i42dFSh3zn0ThwxH7kH2I6fvSZdufuWJZ0bjEDjwVkFfRQnjjq?=
 =?us-ascii?Q?tyH7z/Llx0nUaVDC54NjpHZN+RXlMWAmds8IN+dVOAP0nOhALdsJvLRz2lAc?=
 =?us-ascii?Q?aRgEZs7TkLtctAw7Wl+5yNg4F6RAsEXaXKDWXHnWvrqWwvy5bw6coslkEfm6?=
 =?us-ascii?Q?LLn8qBHBqOYNI+OGiISEmVr9omjF0M1B4VDHdp6dcg1wj3y7ufUViVamUP5t?=
 =?us-ascii?Q?FshK2/5YCcVFtmptEfE/MEI5IQSnSRvEmHLQU6jvy1wGKxiU6G2KO4PMSjwO?=
 =?us-ascii?Q?vKHlCt51acZ32VtUqm4k0h3m/iT1OsC+9sF2ukrxBNwIL0hW2VrmHNCE6dtq?=
 =?us-ascii?Q?oSJy0y3aI4eVLzc4WCSTng1uvV0MfbZ7kTAX1AdnmWbh713+/j5yenegRvm1?=
 =?us-ascii?Q?e4lejrFRIvOG7nFysSWay3HIWRDAmmBNTPsvLCuqnh8206w8qeoj6ApbhNdF?=
 =?us-ascii?Q?umguan7eAKNAuEwG6j+JYtfoYaTgPaCNDD4n+KVL+fNp4uHCacpYKfPE906s?=
 =?us-ascii?Q?lFcY0G8WUf+7P6QrkgB0HislKnpKFAVG4yUQv7/sPRkKQ1MLIrV+k1cgnDVo?=
 =?us-ascii?Q?/XK6vPaeWidHzRuRD1Nq8L7794j2jUD0RRD/r5wD/bvAeT5cWAn4V99Qclts?=
 =?us-ascii?Q?GTk23h4rUOkHxXc5WIoeqQIa+Hua+2QdarrZZA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 99a20e44-2544-43e2-5cda-08dc4a9b8bab
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2024 18:11:50.3402
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN3PEPF00013E2A

From: Will Deacon <will@kernel.org> Sent: Friday, March 22, 2024 8:10 AM
>=20
> Hi Petr,
>=20
> On Thu, Mar 21, 2024 at 06:19:00PM +0100, Petr Tesarik wrote:
> > From: Petr Tesarik <petr.tesarik1@huawei-partners.com>
> >
> > If the allocation alignment is bigger than IO_TLB_SIZE and min_align_ma=
sk
> > covers some bits in the original address between IO_TLB_SIZE and
> > alloc_align_mask, preserve these bits by allocating additional padding
> > slots before the actual swiotlb buffer.
>=20
> Thanks for fixing this! I was out at a conference last week, so I didn't
> get very far with it myself, but I ended up in a pickle trying to avoid
> extending 'struct io_tlb_slot'. Your solution is much better than the
> crazy avenue I started going down...
>=20
> With your changes, can we now simplify swiotlb_align_offset() to ignore
> dma_get_min_align_mask() altogether and just:
>=20
> 	return addr & (IO_TLB_SIZE - 1);
>=20
> ?
>=20

I don't think such a change is correct, since we want to allow the
DMA min_align_mask to work if it is set to 0x3FF or 0x1FF or
something else smaller than IO_TLB_SIZE - 1.

Petr's new offset calculation in swiotlb_tbl_map_single() is this:

offset =3D orig_addr & dma_get_min_align_mask(dev) &
                (alloc_align_mask | (IO_TLB_SIZE - 1));

In the normal stream mapping case, where alloc_align_mask is
zero, Petr's new statement is equivalent to swiotlb_align_offset().
And I think it needs to continue to be equivalent so that
swiotlb_search_pool_area(), swiotlb_bounce()  and
swiotlb_release_slots() calculate the same offset as
swiotlb_tbl_map_single() uses after it separately processes
the padding slots.

Perhaps a better approach to maintaining the equivalence is
to modify swiotlb_align_offset() to be Petr's new calculation,
with alloc_align_mask passed as an argument.
swiotlb_search_pool_area(), swiotlb_bounce(), and
swiotlb_release_slots() would all pass 0 as the alloc_align_mask
argument.

Michael

