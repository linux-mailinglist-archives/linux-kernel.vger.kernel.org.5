Return-Path: <linux-kernel+bounces-160375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A998B3CC8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AD231C21DAA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2102156F39;
	Fri, 26 Apr 2024 16:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="YXfGWECl"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2018.outbound.protection.outlook.com [40.92.40.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2530118C1F;
	Fri, 26 Apr 2024 16:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.40.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714148979; cv=fail; b=AC2WXYnuldkdJGPrHiGc7bFB08PPoftRoRAOEcp6AwLYdK7R87DcTTcn3j5WEm0xwZL1ztp44XyVSuV6yRVIICKx4iNudBK1KyNxAmf2iMhsrnILefWWJl1FbOw/h9txzJeisn0XT28y4vvK13tqgtanbLHB3X7wuEfXNT/A2DM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714148979; c=relaxed/simple;
	bh=a0lmqdfOZlymevaO+BzDCdhWvc/QFvn7gqQxkXDvaRQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eT+7F0F1fwPv2KF/Eji+Qqd+T4qSmt1rMZMXp1xEBVea+BHkK1VKl8773kx9Gp1dpNiej8uhGhnDoJADUIbzEqGr98V2RvRe/T7jlYmSL7j/ciIdUiVmVSZwGi8iSzZlL+4asIcmNQV0ovzWp8ESxpa5RGjB2TQkPNWuw3IRKyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=YXfGWECl; arc=fail smtp.client-ip=40.92.40.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XZ4pIzoZioP/7G5XZ27I9q4RMP4kB2JIgBkkdQh3EpOXvdUSEvL3oE3qd6vsNWeFa2/eQKRRhzfnxPBZt7ct92nbiRGe6B5sIvx0cdvxeB462bQ630x6WnkmDlwSTcN1ZepdIv4EpgAq06JinFCNf85LnZ6bbYQawsnkMen0bDRtsvMaUgQM/LUU5Xl3vdpAsdYO60izQd259ua4k4CzXNIaGPTSi2nmYrJQLMtcziBnXZ3RiFlascB/mrsFFQs0g9G/y2EV4/MPb78f82d5fBkHDxT6AY78pdCjLDKRjoAzbJrP8qaU5naLpFe0SYSBPIRxE9iEEkupyOvUi0ZhqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZliPVJaz4ZJL7xQ9Z58tYJvxc0YUmiET9/Uly9gG1aM=;
 b=SBGAR1J9tV0p/MrTfktmXuxcaXx8qdLLLwNMs/suoiI/273KBC+tjvVAqOkYcgQiAZ2ClAEnAXW3udjvWMV/ramA6Mrw7lr5bcTfJqw0OyXNX2JP4M4KVw+GqjGgU3XzNeWO1GsiKiBPhdexYP7gdp+q0EiHC3hwWMiqNLJY7MQVw+0e1qh3irCHBrIWnfg3XSGf2QyDkqPGUos23qXC9TEJbetdZONXldm8qViDsh6BsH/nB46clse+WtRHYiK3ibM9B4fyqJcmabyXLLk0UxC0mMf0rozLW/GG8yf1iUGBOVdliVzgAa9MVaNXuELmSWy3IjZJrubPR4FWkt1fcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZliPVJaz4ZJL7xQ9Z58tYJvxc0YUmiET9/Uly9gG1aM=;
 b=YXfGWECldM+O09p37Qv0/Y7HIstBZneRJkqWbGgJuxnyAe55rY7yYKjCugp3G7/dRHV0nWB1G0ae1oAq+QnVI7IrsP5fHSNiz0GpQNttvDeU2e/uwTN7s4RYhLB6TF8bDjYLax9uvYwUYYqGriAP63ws5drBytNwQH5PK6mUs0hzdYeGD8gdhrLUeWnG4Rwq/F44KdKeBMTZ5kFiD/+8mgt6rtecWHFUljycQEZF5IxW+YlwtqSionA6XOSvbGJv9tbYeAyf8HyJgyM6lrmz8JAQ7o/8szgICSO+wxD6oMkZnTih/IeDyUkH+4hyc4M3KDS9YgiTcb8K12yjQMQRNQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by MN2PR02MB6639.namprd02.prod.outlook.com (2603:10b6:208:15f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.23; Fri, 26 Apr
 2024 16:29:35 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::1276:e87b:ae1:a596]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::1276:e87b:ae1:a596%5]) with mapi id 15.20.7519.021; Fri, 26 Apr 2024
 16:29:35 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Christoph Hellwig <hch@lst.de>
CC: "robin.murphy@arm.com" <robin.murphy@arm.com>, "joro@8bytes.org"
	<joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"m.szyprowski@samsung.com" <m.szyprowski@samsung.com>, "corbet@lwn.net"
	<corbet@lwn.net>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "petr@tesarici.cz"
	<petr@tesarici.cz>, "roberto.sassu@huaweicloud.com"
	<roberto.sassu@huaweicloud.com>
Subject: RE: [PATCH v2 1/1] Documentation/core-api: Add swiotlb documentation
Thread-Topic: [PATCH v2 1/1] Documentation/core-api: Add swiotlb documentation
Thread-Index: AQHalliRlUgD/49j1UOuP13GtHeQebF6FoYAgACpi6A=
Date: Fri, 26 Apr 2024 16:29:35 +0000
Message-ID:
 <SN6PR02MB415775F2F7B865162D7A534DD4162@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240424150253.560999-1-mhklinux@outlook.com>
 <20240426061852.GA5645@lst.de>
In-Reply-To: <20240426061852.GA5645@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [JBeJ6XqPXkusfbEAgovGSHNCziqL7npO]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|MN2PR02MB6639:EE_
x-ms-office365-filtering-correlation-id: a14c2a9e-da0c-4f26-e053-08dc660e0f70
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199019|102099023|440099019|3412199016;
x-microsoft-antispam-message-info:
 BXKQP6sztaeCIsYiMkkRh4+1tKJRRlW4JYEf0N69T5t5BHthtAp3JYZ01sAhTs8VUyjqQd8Tk0Y7bbu7he2YwfkMbG004IBQwLdtXtOxZ0S8o/EnKPzYAQJceId1gg5GmNHjY9C1EoT7M8zvBL/KGG3OU9rfYeOshdWuYFiY5F0Ig/z2tj6nrGDXhFjvnkpyWEToblmfUEg169vNlV5ior/ZPUZzQ0PQKNBhxEUvAfln0f1pdLg83Y8yCPyfjeh77Ah4pZpYNTjt+K7dLbiC4mAGIfF4teIZAHXoet6S2bI4HUdJSGBz2jvBmQ0z1xXjE2aX+cyznyBT/8ax1qMTJ1srhs9E2rN4+sK6x3Vu5ygJUuH+s9h9PRHDvILc2b8XHsxcGjv4JVscty+OW0jkpWR0Hx7lIWof93R7jW0Cqj7NBdmMi7ziYa/yS9MzmpZ1bK5Fhim2vqKSwtxKuxl7gFY77ZXeFQQDKX9YB7XQIUNJjZfOq5T0SwFVVOK3b3xIPQ4s5trNoiaer0M0qP8QssHehHq25ABhrqs2bbqghqllyjhw8WRECDdxmL0wUUEi
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?3c57xacJzM7lM2ogUW7jCKGQ+AlBxtPPrVedYI3Hr9cOZYs1IwMYY8oV1n0C?=
 =?us-ascii?Q?u5aaNO4MYo0kG+chdfgBA9PSXtUkUYuiEJ2PdckM5JNf+ICVLlww4ceFHT58?=
 =?us-ascii?Q?lRi7SakxWqQiAWWqFq48hDK3YPGJ3Qn5QVV4TwE65iShlkU2/nTT0tI8iFct?=
 =?us-ascii?Q?o1IJjtxrbTz1kObvseCGUJxdaX86v/Qp/4gtShYPirJVen7PSd0j3yJuxuur?=
 =?us-ascii?Q?hPGm+hsZ3tWwKcBIIbE/BerHMuwjaA3brZwi7eLXviHc4KWpDlPXq5cJ97x3?=
 =?us-ascii?Q?zSBQWcHx3P7fkjyPVXMYzgVRqmxCw9ksdPIKfE3ZozvEjQpU49ffW7PYfEDE?=
 =?us-ascii?Q?ac+7DQa9BDP/JB/+aKD2aoVkb9OG/c5VmF6iEIOcVLP2rzvNPV7HyM0RrPuP?=
 =?us-ascii?Q?aCherdgF955awyN8Zu8eEHk+/lh2juy/wIRvLIa5wV89Bd2S1SmOgNERDfoo?=
 =?us-ascii?Q?tSMrW9E8dfE/gLvoSWmbJ6tY4D3RfaFbp4PyJIZKGGZ+9WAoZFN5y43AMViA?=
 =?us-ascii?Q?0Y+oxhvxvs3d/yj6YmcgA5NTiT3QkjCmv9y4Du1fFk2N/VA2CJmo2JUmdbnz?=
 =?us-ascii?Q?e3zjDQ2TKfgNPk0GmIC5oQWkJoXAtk1z/rme8P7wf8QL4x4mKzy0Zpluvyx8?=
 =?us-ascii?Q?UXkJX/MBw+lF7oiw4btzNOWtwLrhhcy5ym34rp2ntGiSCQrYbEVIunuIUmQh?=
 =?us-ascii?Q?WNCskkL3DOa4z/k/bEs1f/lo04VWWiZ1oErEhPG0lO80Ug7ADvCDHVuDS12T?=
 =?us-ascii?Q?rGbWSeH1gQVszR3kNTxWQWIzVtkrEZoQk/Y4LOHkH3i2ZFtmk4A6a1mnVuNS?=
 =?us-ascii?Q?boyNmu18KZn601rHwtgNkQUXf3QJj4qV3TBDw2UMCkus4Z2g0cSwDCxX3NH5?=
 =?us-ascii?Q?K8zK24NIvFOELHQLMIkn7H/uI0Sn9M8kcV6r93SbTRNqUqi+WnC0jxIs7BHY?=
 =?us-ascii?Q?pR2xFrtGu0pktBnvFexJKiYgXViqxw+zm8hC2J+9IwcB4CEbYvWjg1lY/RJH?=
 =?us-ascii?Q?N3kHf/2L4DHlvpecUPSKCu/+YvRMTukNMuZKXoJllYOpueKrSgsXaw/pF+s/?=
 =?us-ascii?Q?LKuQlK0y+iZF7v0rAsLVGU7zj6d9fih7X+FwQNSzLtwrkxAGFlsqOtHNn400?=
 =?us-ascii?Q?ylvRppJsVj5u4de6SmIGmPP/r1uXQeHArwVhLQGJuSY9tMEs5PeGGX58DC7M?=
 =?us-ascii?Q?OGDaEeMAvc174n04occTrS+PozjrQe8hby0YTQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a14c2a9e-da0c-4f26-e053-08dc660e0f70
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2024 16:29:35.4320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6639

From: Christoph Hellwig <hch@lst.de> Sent: Thursday, April 25, 2024 11:19 P=
M
>=20
> On Wed, Apr 24, 2024 at 08:02:53AM -0700, mhkelley58@gmail.com wrote:
> > From: Michael Kelley <mhklinux@outlook.com>
> >
> > There's currently no documentation for the swiotlb. Add documentation
>=20
> s/the // ?  (note that this is used in quite a few places)

OK.  I'll drop using "the" before "swiotlb".

>=20
> Can you use up the full 80 characters for your text?  As-is it reads a
> little odd due to the very short lines.

Will do.

>=20
> The other thing that strikes me as odd is the placement in the core-api
> directory together with other drivers-facing documentation.  Swiotlb
> is internal to the dma-mapping subsystem and not really what is a core
> API.  I don't really know where else it should be placed, though - nor
> do I really understand the "modern" hierarchy in Documentation, but maybe
> Jon has a good idea?

I also wasn't happy with it going under "core-api".  But I agree with Jon's
comments.  The affinity with the DMA documentation is strong, and in
the absence of a better place, I'll keep it under core-api.

Michael

>=20
> Except for these nitpicks the documentation looks good to me, thanks
> a lot!

