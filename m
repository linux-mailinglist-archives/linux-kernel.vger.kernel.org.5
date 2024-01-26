Return-Path: <linux-kernel+bounces-40838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC0B83E6C2
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 00:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 120351F2A880
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF60258ABE;
	Fri, 26 Jan 2024 23:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cZ7nfvDx"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADAF56779
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 23:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706311119; cv=fail; b=eHNtBvmwlA7PYgsP1WMamYInlCkZ0MK3szG2kZt0EfdP6mtD3wId2g2y2u61809VYAupRtnkymG5gQkHHBwBecN8qci5v6oa3bOcBG/2UkpNCzuKluOr4shQjz0cMx3D97b7eMnFuHtMNayPkzP7ITyDGIhEWOkt5b0cRxWE/hM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706311119; c=relaxed/simple;
	bh=hlWUDytQYdIglIHI+NfBnFDkbS0xFndrDx6LXldjUYQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YOWrt9vHyoTQfP61B2LkXJjyNUeCbNP+/PNf0tkrBnVJyKME1umr0uOkIECjS6NlBuo21yzDL6IeYH3od5dwqzYbDrlyr+HHDbV4izk4KgLwd+STCqHtbR7SQNIO2YySs5Jz3SyUTwbyDTpGS+9e0X3SgHhnukGUWL0/4IVi9Ek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cZ7nfvDx; arc=fail smtp.client-ip=40.107.93.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HM2dnq74GI4BYlY1009TK8nbDHY81aaNJxRoPHQzwwbtooslPoF+fmqEqAHD1XdgK/5/W7K9IQ70SCAg3ytXWrsN5zQiy7VLykvVwRZVCyws3okweyx5BtiS7iSprwsLJPB8y7Mv8pm0gUfFxDbTriAF7WfKiFnp42pdZ2hj/h89OhK0LGBuZz3Fgg+VMLm+/DL/3ySDKuapvuS1+9ZQ6UX12dV6zHp5UvNkKVxuyCOlF3mXuCxEaizTePGp4n2767zjNP5CXL/OaNmj7TsP6gwNSYwGsWwFE9d7qTNk9dORpw7tE3cx5Ja9SOlyN30X4/qzJSt+i2gxSxBwSuTAzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hlWUDytQYdIglIHI+NfBnFDkbS0xFndrDx6LXldjUYQ=;
 b=muNlagqLHGecOcPtj5tkkVDX94VnsGju9uwtZlOG+mpoUH9/H4nSyUvUthXGsNMXg+jf6+swF0KCe8iL2LyZkZMe7orbvP0yWCpjaPTVVZCV8/sqQvOXIK1P0gzoXypz0e7VfoYJeDhiF9dsM9khEBC8plAcoF28a09xZGsFgDNsSdtf7fj57AG655Ip3oz5rexr+NBXP38NTqZnJOxQVjoAOPYBnEroaoQUx7dLUkvB25q8pnOre8MDeB9Q1uPBoWh5IE1rwrmLMAES8V1o2nUiCjE15A6ItGHKiRg+tx+ZYFFVoUHmMvqYoFdqA5RMpj1ou95yl5l+oAx7dQ4Dqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hlWUDytQYdIglIHI+NfBnFDkbS0xFndrDx6LXldjUYQ=;
 b=cZ7nfvDxRrSjZN5EGoLA254BYGOCPOCTq8+Cy8+alT09tsVwN4Yq8hbf9QkrVU8Cc9EMMSTBIVcM8HeoZAos+4yxPshQA3dBu6nAmYeIjELYj/l47e6C7RrEh1N6xXqCjRYaG3ELJDold0RAv9M0nq9R6FGn9foYAYPZOAr5s8k=
Received: from MW4PR12MB7165.namprd12.prod.outlook.com (2603:10b6:303:21b::14)
 by CH0PR12MB5299.namprd12.prod.outlook.com (2603:10b6:610:d6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Fri, 26 Jan
 2024 23:18:30 +0000
Received: from MW4PR12MB7165.namprd12.prod.outlook.com
 ([fe80::374b:e99d:5ba7:1ec0]) by MW4PR12MB7165.namprd12.prod.outlook.com
 ([fe80::374b:e99d:5ba7:1ec0%4]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 23:18:30 +0000
From: "Klymenko, Anatoliy" <Anatoliy.Klymenko@amd.com>
To: Maxime Ripard <mripard@kernel.org>, Laurent Pinchart
	<laurent.pinchart@ideasonboard.com>
CC: "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
	"tzimmermann@suse.de" <tzimmermann@suse.de>, "airlied@gmail.com"
	<airlied@gmail.com>, "daniel@ffwll.ch" <daniel@ffwll.ch>, "Simek, Michal"
	<michal.simek@amd.com>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: Re: [PATCH 0/4] Fixing live video input in ZynqMP DPSUB
Thread-Topic: Re: [PATCH 0/4] Fixing live video input in ZynqMP DPSUB
Thread-Index: AQHaR4zbqultFCfObkKOHwb14YSQ3LDeEnKAgA4EJYCAAK6mAA==
Date: Fri, 26 Jan 2024 23:18:30 +0000
Message-ID:
 <MW4PR12MB7165D35189BEECA8769552AFE6792@MW4PR12MB7165.namprd12.prod.outlook.com>
References: <20240112234222.913138-1-anatoliy.klymenko@amd.com>
 <6jhwss2wego6yoo5mwmphwawhsj5bbj62gwrzcpapoixwkrkli@g4fbxdooopby>
 <20240117142343.GD17920@pendragon.ideasonboard.com>
 <u5mngxudtdgy3vqkfbpgqng6tdahijnet2jtj345hrowbt47ce@t3e7hul45mr3>
In-Reply-To: <u5mngxudtdgy3vqkfbpgqng6tdahijnet2jtj345hrowbt47ce@t3e7hul45mr3>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR12MB7165:EE_|CH0PR12MB5299:EE_
x-ms-office365-filtering-correlation-id: 23416a01-d254-46df-f278-08dc1ec51bed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 mPRafhycbg6oLcoL5DDk+hiMQc8b00N8QC1oejuF14loO9KwT7Ieh4bzouEd+Cx/FPvvm0lhR18IpTq1EYKLSXi+EdDx9OaLBxxuj8JwhMCxOaxWSu96bRM3zY6Fy0XZmOOD4z1MCFAHl2eeOJnFd6G1NqK+jPAjOixQ6EvXv5OQnWy6Y5WSUS9NteN5RPr1a4ymbU8gTgoF1KoQwAvlPhmmtLk868LVRGtzhFSIiIjJ1UL0HtWH3/KwBkrFvmPTAaGTfIn12nTAbUh/4Af/drcA08TCSiBQ5CLxkc68r2jqfLsIRccvOscQOC9mVaWUcsFxc67qsaqhZ87DLUQHfICYXjp2aUrcMEWWu+jXl+JqKqSj7TT+kZySQxtkAfRxd7tUoCzpTAo0YnjDlcmMFXFAJatC+xu0JCnbUpx6uuG5+K5akf6+rSGYnvk36yyouzWILPbbd+JJfqwKs4gxwNquY++S34SVeI4jxG1NiL23ZT1t5JRvVl5yLA1l2AliGTRG+tHlz5AHfnO2aTBYttwwpVSmePiOgOC7VnnDeyILWPf9IvMp79Vfu491ykMyb+8/RAzCIXuRBDIHRhnRSMq/o4Kx+BMQTdr4Ik5a+ck=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7165.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(136003)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(53546011)(122000001)(26005)(38100700002)(76116006)(71200400001)(9686003)(8676002)(5660300002)(4326008)(8936002)(52536014)(41300700001)(7696005)(2906002)(54906003)(478600001)(966005)(6506007)(64756008)(66476007)(316002)(66446008)(66946007)(66556008)(110136005)(33656002)(86362001)(38070700009)(55016003)(66899024);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?uSLc0DDOZ/TQ750Uw45BMKJDlbLwCPaa2O9fB7i1wH6XBN04vJU+33XJwhFb?=
 =?us-ascii?Q?nbAkFS04aeesViSMLVm1j3pwBRPmwbrQiamJV+VGtSQz+0G0/tQOY48r/S81?=
 =?us-ascii?Q?ZKmbKjpEVyx8/EFWn1MFV4aSNcV6RFL8uTBd4HRnFbH+7RWVMhSqT5ms9g07?=
 =?us-ascii?Q?ic6K2/DlTqgX8ctBTC42nyDvt+3+ZXNjJvFgSbo8LDe9c07IGwsiCOQvhX4y?=
 =?us-ascii?Q?4ieziWdfaWnUwitEomo9DyjM9XteKBPPmu6dfhN3qsFHYKTZvcwXsWDUH8Bj?=
 =?us-ascii?Q?LDKgriMMis2N6H47UaCra+xDAl9+OWT+Fu5H0rcrXWyxznr5R9GVcbIOzBHO?=
 =?us-ascii?Q?gbbU/WJPG5mjCrm61NYWatb8/C6Jfgee2J9+tmspnKHzYkqQHjAsf/npinK2?=
 =?us-ascii?Q?90g1HQe1oo/lq1mQHXgD89ZrpooqTDLX9tElPJkCwJ3u8a7CT61MQ33F6ZvU?=
 =?us-ascii?Q?vmrjb/+o/e/evED0qLrNW5Cb3vtNjxALHJF1YSYftRkEC26E6vAoxJXbq30R?=
 =?us-ascii?Q?3O2DtQNG5pUCNf7bu+xOdwuWWQ+gltOBm0P35xypRP9s+8eVUly+QscDSJAs?=
 =?us-ascii?Q?q6UOAFpQjyls9Lk6eYuMkmdNflth11kUovIlldmgQf1IxrlGkVxQGsD3KWeR?=
 =?us-ascii?Q?RMjJjx0F9Q60s67thFzfCArdlcKePQ/FDxTUNwe0Y0SkGLp3mXp+CsK5IlDi?=
 =?us-ascii?Q?BE04pN12k774YE9+fkXbkn9PIzeabrjgDYwaPPwf25IaJyiVop5shb2+NmMm?=
 =?us-ascii?Q?FK6XtVEyNHfTWpvZm9vLUl8e1/BPPdoaX33EWcdpk1eB7RO8ZgjNY6TNOVdw?=
 =?us-ascii?Q?ChsACU2pBqSygZCIzKxkIl7jSpbjkzLd3uy7rZejd7RJvCHy1bAlXt4XJ45s?=
 =?us-ascii?Q?9x6PVl2+6V6j0iJhQ7wEuIH0v9Kf5Kf4knvSm3kBF9XdsdLSt4oi8eetwH8B?=
 =?us-ascii?Q?amis3hT1kT89PjPJRJyRf/GLmRlDvg2k+MRY3xQ9KblaPoaJ6sVV1QIuEOCn?=
 =?us-ascii?Q?xcH4UhJxe/HaTbm3a9o2A4XVNfPt7LfKLVC/JEXQg2RpZxDEN12ep8YhESfs?=
 =?us-ascii?Q?RvbhI9EHkGD2h5fUMb7mci85WZG3CI1r7vo37UiNeQqMwdjL3Sa0gGeepIik?=
 =?us-ascii?Q?lU5W27Qu54uB/nt9HChIPcdgWuQVeJdcrV4BOgRrpn2qIX9CKknHKetvREAn?=
 =?us-ascii?Q?Nq0PKHlEyQIARsZsapYs9v7/JOX8Eyd3tBXJ1Wl2RnZX4wXwAMqMfj51Nnz7?=
 =?us-ascii?Q?zXPTMiFcLyNZtH5FX9iuXdPBYJpyWdzfqAdHL8BXIl6+uoTOnyMFWfvfvqO8?=
 =?us-ascii?Q?EmwotjvbID31udrVUbEgoXznODmq/XQLV+3Xrzo4POgrYrBSEpxGG1+zjI01?=
 =?us-ascii?Q?ZH+5SVyMCszsBa/fofWdVcrDF9Cc8wygl64UvNxLF7oTzGHLdHZM4sgmvowz?=
 =?us-ascii?Q?PlfGYoLVriCDcXVbCG3D4lUBo8hwL+S0NM1s6tzz15leSw+ZF6pvXQcb9T1X?=
 =?us-ascii?Q?OM0PttHdNmzML5ZIasDBGgxbBTd+2gIEl9IErv2d/SKLr2asTLS/mQJ00TAg?=
 =?us-ascii?Q?D+HGnzJ0UyRhCAHhnL0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23416a01-d254-46df-f278-08dc1ec51bed
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2024 23:18:30.5683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WUV6hdzcG3I8JZM4EgohRGPUAde9/vAJmJfJ9/If85C6NGDku+g+0SvCmTCAAInYmTvKMC6bjlpwCsvvSYbb/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5299



> -----Original Message-----
> From: Maxime Ripard <mripard@kernel.org>
> Sent: Friday, January 26, 2024 4:26 AM
> To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Klymenko, Anatoliy <Anatoliy.Klymenko@amd.com>;
> maarten.lankhorst@linux.intel.com; tzimmermann@suse.de; airlied@gmail.com=
;
> daniel@ffwll.ch; Simek, Michal <michal.simek@amd.com>; dri-
> devel@lists.freedesktop.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org
> Subject: Re: Re: [PATCH 0/4] Fixing live video input in ZynqMP DPSUB
>=20
> On Wed, Jan 17, 2024 at 04:23:43PM +0200, Laurent Pinchart wrote:
> > On Mon, Jan 15, 2024 at 09:28:39AM +0100, Maxime Ripard wrote:
> > > On Fri, Jan 12, 2024 at 03:42:18PM -0800, Anatoliy Klymenko wrote:
> > > > Patches 1/4,2/4,3/4 are minor fixes.
> > > >
> > > > DPSUB requires input live video format to be configured.
> > > > Patch 4/4: The DP Subsystem requires the input live video format to=
 be
> > > > configured. In this patch we are assuming that the CRTC's bus forma=
t is fixed
> > > > and comes from the device tree. This is a proposed solution, as the=
re are no
> api
> > > > to query CRTC output bus format.
> > > >
> > > > Is this a good approach to go with?
> > >
> > > I guess you would need to expand a bit on what "live video input" is?=
 Is
> > > it some kind of mechanism to bypass memory and take your pixels strai=
ght
> > > from a FIFO from another device, or something else?
> >
> > Yes and no.
> >
> > The DPSUB integrates DMA engines, a blending engine (two planes), and a
> > DP encoder. The dpsub driver supports all of this, and creates a DRM
> > device. The DP encoder hardware always takes its input data from the
> > output of the blending engine.
> >
> > The blending engine can optionally take input data from a bus connected
> > to the FPGA fabric, instead of taking it from the DPSUB internal DMA
> > engines. When operating in that mode, the dpsub driver exposes the DP
> > encoder as a bridge, and internally programs the blending engine to
> > disable blending. Typically, the FPGA fabric will then contain a CRTC o=
f
> > some sort, with a driver that will acquire the DP encoder bridge as
> > usually done.
> >
> > In this mode of operation, it is typical for the IP cores in FPGA fabri=
c
> > to be synthesized with a fixed format (as that saves resources), while
> > the DPSUB supports multiple input formats.
>=20
> Where is that CRTC driver? It's not clear to me why the format would
> need to be in the device tree at all. Format negociation between the
> CRTC and whatever comes next is already done in a number of drivers so
> it would be useful to have that kind of API outside of the bridge
> support.
>=20
One example of such CRTC driver: https://github.com/Xilinx/linux-xlnx/blob/=
master/drivers/gpu/drm/xlnx/xlnx_mixer.c
It's not upstreamed yet. Bus format negotiations here are handled by utiliz=
ing Xilinx-specific bridge framework. Ideally, it would be nice to rework t=
his to comply with the upstream DRM bridge framework.

> > Bridge drivers in the upstream kernel work the other way around, with
> > the bridge hardware supporting a limited set of formats, and the CRTC
> > then being programmed with whatever the bridges chain needs. Here, the
> > negotiation needs to go the other way around, as the CRTC is the
> > limiting factor, not the bridge.
>=20
> Sounds like there's something to rework in the API then?
>=20
Adding an optional CRTC callback imposing CRTC specific bus format restrict=
ions, which may be called from here https://github.com/torvalds/linux/blob/=
master/drivers/gpu/drm/drm_bridge.c#L935 would solve the problem.

> Maxime

--

Regards,
Anatoliy

