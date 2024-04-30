Return-Path: <linux-kernel+bounces-164302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A98C98B7C10
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A485283EE3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8DBA173344;
	Tue, 30 Apr 2024 15:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="EA6jFVNs"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2014.outbound.protection.outlook.com [40.92.41.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6D2143732;
	Tue, 30 Apr 2024 15:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.41.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714492127; cv=fail; b=E6990kJGw7DAWYTg3eP5qHWk7gtVytApRhNpaGlJJg3ppT3Ty6ZW0UL7sfrzrAfvOtR0QOaXEHCM0W48N8sv/L+zCl+ThAtbVeSXCJjC2GG2E8dYTLnKjfMxsI8qqhr1A6mh7QGhM+Ns8SlqtnXJppjdpeE+gEDSqUU/mEmmAoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714492127; c=relaxed/simple;
	bh=Eh2R/H/lQtHdiqMoR71mmKuFpamQ8PXw/+AbNMEALoc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HrpwIhq4O1zSfgleWnSRkHSkeMJ8nEBh7Z+qG1cyCKg18Kpi26iMX1z5TbLW8i5tFxYDEv0xyDdDuAiNgznl2Fx2QgRohT2EW8el1WiDGz+ZBGH9bX1sZ+R1Nf4mEt02etwDnUxe7g/z1tPy/5k1O+catLxgDMbp6TgQ2nNGkTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=EA6jFVNs; arc=fail smtp.client-ip=40.92.41.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h8Q5Cfrod1kIO3NTna6PDs+uoncxrM/Zpo7klwzOYIPhazjYVIRjnm3Jh5ZB13DO6OGXEaAoCHjkBFyqacNImuO3ULwWK1kFxjb7J21g+lMSpxrE6RCY0mt9KaTLHLZ/1sRmzxQBEfb4AX998Runw5iF/i5qShdRtAnre4RyBaAZk5zD8L6KwIEuRTS9U5SEr5H1BbdSpgqP7ar891OjZgQlXQVlKlkqmJbAc4S1tw6YiXt/R8moCiidsCfQmLx0okWWwl958YQkyWi0hCj21blVqQdkX7KCDuMI43qKrbj+OB5CnidOx/wfXUheYIOXjq73a0HfFIBOMiD541IPeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bJoSWYSaVSMu7pKJ6SdtW30EOafw2ORINXbPpKnw95o=;
 b=foWq+E17oLd1sLnD506lGnwxb7IJuVM1e5CtF+s5MgDyGZ0TjlrEBo8z5zRCCagyUooQ2z1pbascb7RnBud7h0Rq1mJ+54rSe3rVgN2r7npxflZatpcr1ucRDgiONO77i0ye3l9vsfLT/ti+odncGjSDarDObt6vbKwqktD/m1CqG1WLC8hoFYn5cK8dJxqaZtIzfIMMJtHpLU/SIkboOb4iCAwqlEry1fq0VmOQANkXldyCxlGMP+28ObSRU9gcGOWQZYzMX7zHmu7a7xRNOxsFInFR/Z4F0QYzsGep+09Ut3bI6QxHP28IkMYGPr8nsThb8k4//l4O0ROwQqyXpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJoSWYSaVSMu7pKJ6SdtW30EOafw2ORINXbPpKnw95o=;
 b=EA6jFVNsH5kMWymn6o0aMBRotCdIrTyEK399MesdPQ7pG9Up2ucJvwAfN/j8y5dHeRWSXtqfwYAt5Afto+DewCelipsupeq3Gm15SxQIdUxWf8fjIjY3fxcTgTZRCjJxiixAWmt+8a0GT0sAFEnqQHT0fjurHF9qQL2G3AaW5oP7nldB7d5iEpNxTIgcC8wbS7zh4P5t2RCxMmWoBkAg21RFBl36rdtV5PPSTBNDEPjYzrN9wdqZ6YGzneCxC4gZ0k1wzbdP+ys/czGtcyo5DmUfsCMqI53l64Olvq4DRDZ/tvzf07LADA3FBoK9DUATLPWjKmtAQS65ZGSDEeI8bQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by MW4PR02MB7426.namprd02.prod.outlook.com (2603:10b6:303:66::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Tue, 30 Apr
 2024 15:48:43 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::1276:e87b:ae1:a596]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::1276:e87b:ae1:a596%5]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 15:48:42 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: =?iso-8859-2?Q?Petr_Tesa=F8=EDk?= <petr@tesarici.cz>,
	"mhkelley58@gmail.com" <mhkelley58@gmail.com>
CC: "robin.murphy@arm.com" <robin.murphy@arm.com>, "joro@8bytes.org"
	<joro@8bytes.org>, "will@kernel.org" <will@kernel.org>, "hch@lst.de"
	<hch@lst.de>, "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
	"corbet@lwn.net" <corbet@lwn.net>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "roberto.sassu@huaweicloud.com"
	<roberto.sassu@huaweicloud.com>
Subject: RE: [PATCH v3 1/1] Documentation/core-api: Add swiotlb documentation
Thread-Topic: [PATCH v3 1/1] Documentation/core-api: Add swiotlb documentation
Thread-Index: AQHamkkjbWfDkycKIE6vEiaFEPOMJrGArUiAgABBPQA=
Date: Tue, 30 Apr 2024 15:48:42 +0000
Message-ID:
 <SN6PR02MB41579F43DD1ACB401EEC9E7AD41A2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240429151337.1069470-1-mhklinux@outlook.com>
 <20240430132413.69797af1@mordecai>
In-Reply-To: <20240430132413.69797af1@mordecai>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [azARVQVzykjFHO2OATFbPw99P/0HDTWV]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|MW4PR02MB7426:EE_
x-ms-office365-filtering-correlation-id: 77b4c3bd-48fd-46ff-fd16-08dc692d0349
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199019|102099023|3412199016|440099019;
x-microsoft-antispam-message-info:
 /H7cp6VjUSDthuRDR8U2BT9UhOF0Eh5ZlMREwJezBrJD/qx2ZoDe2LVKg8Sspl+MYqEMlhyNmqlNRcLJt6acUQS9cjK2wpFvWFM+kwBwJ5wYr32Dj/TF3rSZIvfYB86hLQi8jgwS8eOuDZEcPEEbs5HV7lVdoKuDpN+0EtpESrdr7SYj1IaXdauW6oJidXoxdhH82vrzSVcy/W914XqEXcIOnfH1gyGbxaXib4YMjH7TOa4ofX2CIVV6UikX1+8wqs7jAqfsFvKbT1jrROOvGjtVRrTin8jV8zkUnLc4bCH+3USQhhTkCkD3114d6Z0bUjySquf4ZTz8acHw6KWYIvXk1lx+xqWwaPRSnHeFO/ozmHCr6BToO8WQLNGS9N0DZktOslGL6B72z7OCdN6Bxt3wt5MvubfKjHinMlhowYIoMJ83UpVNL7KelNCdoZtxXo/LRm98veGTFQ7tNiq6kiIFE55vciY4bSNfX5bAwrY5Q++e4o8CDjVwtk/2iVVxE9HBNY6GAoIEYaINN9Qip7em8LK9ATHnE+zF6/1RPLEOhi7Tfv+mGaI2Z7oddNGv
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?ZuPBs8COkKbA7MeUIFktcALLTgXpwJ43LQtTbEODSk0a6/8nrUVd92JNgr?=
 =?iso-8859-2?Q?rCRBA2zv8GmmtbEczv9yPfK26Wn1zaaQyVU/ugeO2qgXZBK1atXRGzFD14?=
 =?iso-8859-2?Q?19h4Z8T5VV1ZdZYILN3RLY0zo8lJkf3hunWstUcgD/WiJbFRzLE7IPQOou?=
 =?iso-8859-2?Q?uFMwVFsoRDpPDWQxC0iFqRZtMIQQPghwkbNXhquq2pZsnWimRWIfxfCP5b?=
 =?iso-8859-2?Q?n7SemHcn0Q9Y8R1ed8LiT+0+8rM7PqOM3qHSegnL/8LEuvwlZa9MBfuEVh?=
 =?iso-8859-2?Q?6bOUqmBs0lL/hXqFJyRPLwQD2M+Dgn5HcFk+ml3YSc4JA3phODPvgsDxjc?=
 =?iso-8859-2?Q?vGzOCKCPEqQOdrvVXclXZwQsODbzE21kEUf6vtwDrFfZ/LDeho+NDvo1ru?=
 =?iso-8859-2?Q?YgFlcMNO0T8dZuZOdfMywE1yXdTWN1tJ8A7nrxa1jl8uAqkqU8lzKM1AEB?=
 =?iso-8859-2?Q?1Mdd4718asEAxufNg4/ZcC+bUXKRkq8EmF7mCVJhQqQas3upKv6mSnmMqw?=
 =?iso-8859-2?Q?hb7ooSfkyReA4eHap220pJ8DWiehMnUtoA1fSk1HjwFQkoDUEHTpbz8eqs?=
 =?iso-8859-2?Q?ysoZ3R93AbZaWQek2NsZEN6vIwhygXA0OYrGQru7VkppGXIAg2IrbkB9El?=
 =?iso-8859-2?Q?+nBw5N9S2gqY+dsH48/Q4Cc731cdbh8uO6/pJJBrAyqpY4icU3q1HTWb+X?=
 =?iso-8859-2?Q?69rnypDa+5MVTED5NT7jxdYf1WZdvnfqWgJSyPRV0/RLJ3ZLdCxtwHHses?=
 =?iso-8859-2?Q?uv7yC7EDvwxkDbwmj6kV8IgGbRAsYeXTS62UwzYjDfX+CAKaY0Vr2nH5zR?=
 =?iso-8859-2?Q?c7OgdqGYwkgI2Dff7sd4il1MJ/j7ViFU3/oe8Rmg+zdTpgKxmmGogphfpf?=
 =?iso-8859-2?Q?LB3CL4UbYgoJ8x29UFsppNOczIWGZj2F2n6tElOOqiw+NU0Jls+OmP6+mU?=
 =?iso-8859-2?Q?/bHqgCOCYnCONQzSUKeDnyXsN8AAdDXbBPIRSKOLmizNyvGW1aGHO0QYvF?=
 =?iso-8859-2?Q?pkwrL8K5u3wjrpo+VARyI6M9pMymkMKMLBO2ys2FD+sW0Bx4dGd6qqb9w7?=
 =?iso-8859-2?Q?M5NueqBu5PS9No2L471Jza0bAI8POthPEF8xAC2FYXMhpWXrpU+T0it0zZ?=
 =?iso-8859-2?Q?LFpv4znrXeKN3vS/CnLf+7MAUL3G+3S0c/V/V+AlcpwavSFS/K749+1SU9?=
 =?iso-8859-2?Q?ZwlbgdTtpte3TWu2JKTGEulf0lUbwPKj1+UH6T+15U0EsLkHbzcEE28GoZ?=
 =?iso-8859-2?Q?53hPWTNmg4NDrwf7zr3w=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 77b4c3bd-48fd-46ff-fd16-08dc692d0349
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2024 15:48:42.8934
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7426

From: Petr Tesa=F8=EDk <petr@tesarici.cz> Sent: Tuesday, April 30, 2024 4:2=
4 AM
> >
> > +Usage Scenarios
> > +---------------
> > +swiotlb was originally created to handle DMA for devices with addressi=
ng
> > +limitations. As physical memory sizes grew beyond 4 GiB, some devices =
could
> > +only provide 32-bit DMA addresses. By allocating bounce buffer memory =
below
> > +the 4 GiB line, these devices with addressing limitations could still =
work and
> > +do DMA.
>=20
> IIRC the origins are even older and bounce buffers were used to
> overcome the design flaws inherited all the way from the original IBM
> PC. These computers used an Intel 8237 for DMA. This chip has a 16-bit
> address register, but even the early 8088 CPUs had a 20-bit bus. So IBM
> added a separate 74LS670 4-by-4 register file chip to provide the high 4
> bits for each of the 4 DMA channels. As a side note, these bits were not
> updated when the 8237 address register was incrementing from 0xffff, so
> DMA would overflow at every 64K address boundary. PC AT then replaced
> these 4 bits with an 8-bit DMA "page" register to match the 24-bit
> address bus of an 80286. This design was not changed for 32-bit CPUs
> (i.e. 80386).
>=20
> In short, bounce buffers were not introduced because of 64-bit CPUs.
> They were already needed on 386 systems.
>=20
> OTOH this part of the history need not be mentioned in the
> documentation (unless you WANT it).

I knew there was some even earlier history, but I didn't know the
details. :-(  I'll add some qualifying wording about there being multiple
DMA addressing limitations during the history of the x86 PCs, with
the 32-bit addressing as a more recent example.  But I won't try to
cover the details of what you describe.

>=20
> > +
> > +More recently, Confidential Computing (CoCo) VMs have the guest VM's m=
emory
> > +encrypted by default, and the memory is not accessible by the host hyp=
ervisor
> > +and VMM. For the host to do I/O on behalf of the guest, the I/O must b=
e
> > +directed to guest memory that is unencrypted. CoCo VMs set a kernel-wi=
de option
> > +to force all DMA I/O to use bounce buffers, and the bounce buffer memo=
ry is set
> > +up as unencrypted. The host does DMA I/O to/from the bounce buffer mem=
ory, and
> > +the Linux kernel DMA layer does "sync" operations to cause the CPU to =
copy the
> > +data to/from the original target memory buffer. The CPU copying bridge=
s between
> > +the unencrypted and the encrypted memory. This use of bounce buffers a=
llows
> > +existing device drivers to "just work" in a CoCo VM, with no modificat=
ions
> > +needed to handle the memory encryption complexity.
>=20
> This part might be misleading. It sounds as if SWIOTLB would not be
> needed if drivers were smarter.

I'm not sure I understand the point you are making. It is possible for a
driver to do its own manual bounce buffering to handle encrypted memory.
For example, in adding support for CoCo VMs, we encountered such a
driver/device with complex DMA and memory requirements that already
did some manual bounce buffering. When used in a CoCo VM, driver
modifications were needed to handle encrypted memory, but that was
the preferred approach because of the pre-existing manual bounce
buffering. In that case, indeed swiotlb was not needed by that driver/devic=
e.
But in the general case, we don't want to require driver modifications for
CoCo VMs. swiotlb bounce buffering makes it all work in the exactly the
situation you describe where the buffer memory could have originated
in a variety of places.

Could you clarify your point?  Or perhaps suggest alternate wording
that would help avoid any confusion?

> But IIUC that's not the case. SWIOTLB
> is used for streaming DMA, where device drivers have little control
> over the physical placement of a DMA buffer. For example, when a
> process allocates some memory, the kernel cannot know that this memory
> will be later passed to a write(2) syscall to do direct I/O of a
> properly aligned buffer that can go all the way down to the NVMe driver
> with zero copy.
>=20
> > +
> > +Other edge case scenarios arise for bounce buffers. For example, when =
IOMMU
> > +mappings are set up for a DMA operation to/from a device that is consi=
dered
> > +"untrusted", the device should be given access only to the memory cont=
aining
> > +the data being transferred. But if that memory occupies only part of a=
n IOMMU
> > +granule, other parts of the granule may contain unrelated kernel data.=
 Since
> > +IOMMU access control is per-granule, the untrusted device can gain acc=
ess to
> > +the unrelated kernel data. This problem is solved by bounce buffering =
the DMA
> > +operation and ensuring that unused portions of the bounce buffers do n=
ot
> > +contain any unrelated kernel data.
> > +
> > +Core Functionality
> > +------------------
> > +The primary swiotlb APIs are swiotlb_tbl_map_single() and
> > +swiotlb_tbl_unmap_single(). The "map" API allocates a bounce buffer of=
 a
> > +specified size in bytes and returns the physical address of the buffer=
 The
> > +buffer memory is physically contiguous. The expectation is that the DM=
A layer
> > +maps the physical memory address to a DMA address, and returns the DMA=
 address
> > +to the driver for programming into the device. If a DMA operation spec=
ifies
> > +multiple memory buffer segments, a separate bounce buffer must be allo=
cated for
> > +each segment. swiotlb_tbl_map_single() always does a "sync" operation =
(i.e., a
> > +CPU copy) to initialize the bounce buffer to match the contents of the=
 original
> > +buffer.
> > +
> > +swiotlb_tbl_unmap_single() does the reverse. If the DMA operation upda=
ted the
> > +bounce buffer memory, the DMA layer does a "sync" operation to cause a=
 CPU copy
> > +of the data from the bounce buffer back to the original buffer. Then t=
he bounce
> > +buffer memory is freed.
>=20
> You may want to mention DMA_ATTR_SKIP_CPU_SYNC here.

Fair enough.  I'll add a sentence.

>=20
> > +
> > +swiotlb also provides "sync" APIs that correspond to the dma_sync_*() =
APIs that
> > +a driver may use when control of a buffer transitions between the CPU =
and the
> > +device. The swiotlb "sync" APIs cause a CPU copy of the data between t=
he
> > +original buffer and the bounce buffer. Like the dma_sync_*() APIs, the=
 swiotlb
> > +"sync" APIs support doing a partial sync, where only a subset of the b=
ounce
> > +buffer is copied to/from the original buffer.
> > +
> > +Core Functionality Constraints
> > +------------------------------
> > +The swiotlb map/unmap/sync APIs must operate without blocking, as they=
 are
> > +called by the corresponding DMA APIs which may run in contexts that ca=
nnot
> > +block. Hence the default memory pool for swiotlb allocations must be
> > +pre-allocated at boot time (but see Dynamic swiotlb below). Because sw=
iotlb
> > +allocations must be physically contiguous, the entire default memory p=
ool is
> > +allocated as a single contiguous block.
>=20
> Allocations must be contiguous in target device's DMA address space. In
> practice this is achieved by being contiguous in CPU physical address
> space (aka "physically contiguous"), but there might be subtle
> differences, e.g. in a virtualized environment.
>=20
> Now that I'm thinking about it, leave the paragraph as is, and I'll
> update it if I write the code for it.

OK

>=20
> > +
> > +The need to pre-allocate the default swiotlb pool creates a boot-time =
tradeoff.
> > +The pool should be large enough to ensure that bounce buffer requests =
can
> > +always be satisfied, as the non-blocking requirement means requests ca=
n't wait
> > +for space to become available. But a large pool potentially wastes mem=
ory, as
> > +this pre-allocated memory is not available for other uses in the syste=
m. The
> > +tradeoff is particularly acute in CoCo VMs that use bounce buffers for=
 all DMA
> > +I/O. These VMs use a heuristic to set the default pool size to ~6% of =
memory,
> > +with a max of 1 GiB, which has the potential to be very wasteful of me=
mory.
> > +Conversely, the heuristic might produce a size that is insufficient, d=
epending
> > +on the I/O patterns of the workload in the VM. The dynamic swiotlb fea=
ture
> > +described below can help, but has limitations. Better management of th=
e swiotlb
> > +default memory pool size remains an open issue.
> > +
> > +A single allocation from swiotlb is limited to IO_TLB_SIZE * IO_TLB_SE=
GSIZE
> > +bytes, which is 256 KiB with current definitions. When a device's DMA =
settings
> > +are such that the device might use swiotlb, the maximum size of a DMA =
segment
> > +must be limited to that 256 KiB. This value is communicated to higher-=
level
> > +kernel code via dma_map_mapping_size() and swiotlb_max_mapping_size().=
 If the
> > +higher-level code fails to account for this limit, it may make request=
s that
> > +are too large for swiotlb, and get a "swiotlb full" error.
> > +
> > +A key device DMA setting is "min_align_mask". When set, swiotlb alloca=
tions are
> > +done so that the min_align_mask bits of the physical address of the bo=
unce
>=20
> Let's be specific: the least significant min_align_mask bits.

Yes, being a little more specific is good.  I'll change it as follows:

A key device DMA setting is "min_align"mask", which is a power of 2 minus 1=
,
so that some number of low order bits are set.  swiotlb allocations ensure
these low order bits of the physical address of the bounce buffer match the
same bits in the address of the original buffer.  If min_align_mask is non-=
zero, it
may produce an "alignment offset" in the address ....

>=20
> The rest of the document is perfect.
>=20
> Petr T

