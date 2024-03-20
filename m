Return-Path: <linux-kernel+bounces-109252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 847778816CF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B77AEB21CF6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC746A359;
	Wed, 20 Mar 2024 17:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dZVgSgSx"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563521E516;
	Wed, 20 Mar 2024 17:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710957026; cv=fail; b=dptwgsCs/JYOX5JoNU8sZdtuTuW+xKhYxjbWn5bfALjaQgU40at76nPyXKtnwdArpDEOiXKaD1V8JLRr9fxwBs6Ih80IkYuxFWNZH4Dp/4FPuBXFh0kUdO4G+6aomEDsg/MkMNfgY3PljooiQlyEzXGSxJJA0iinas9COwGSkjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710957026; c=relaxed/simple;
	bh=YgdLAPw1w+bR0B9drNL4kTgBBfIPXEeVPRbmhd4xzc8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r0C2g2o4uZuoHkM5i1WflXJ6GlJ+SQfKK699vNhkSd0MH18o0WonWHcIuYuSf+wiU5iOKtuPDPDfZYHwo/PCXaqcl12C5TkDDE0lGF8ZIi92j5ccvTG5IwYMAa4s7oH7DBbtsp190y0EYEs8VTRXjF2sPhCVHmzbpSitce+KzLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dZVgSgSx; arc=fail smtp.client-ip=40.107.237.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jQ1Lqd3Fn8MuG7g6EmIa+4cVJMwLCX/crnYGI5635dzKkJP3Cl3fqbGvAw+m2cfHqfWINeBF+iUdOx8YXkebEBkNueqGWNwDj5MBtcKT/qncQqR2v1C2TSng/grbiI79igV3JwTGvUq9RDHe1lnYORmhd5OOOPXwWX5VnslAhA9M47yiPsDJkUnojH3BRu4a3uSb0QGsDt2z+F0qKki2LmcXPxRjcc6H0DQpkDlZ9cxS/xM68/v/0qhXqSo6r3rpffyRQ6DV0oGi+fC6YJSnmdxP/JlIrBmeopFYpLR9ZgdXdJVjSMH98ElHhiM3dcbDa1s86X4oRGOEpHeypteoMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vtqbt90lXGYUsq315/bJOO7FwYsUFLC96geFQCIOJwY=;
 b=SJqcIucg1GPtTSvR4cTVrTVa0W3JTpdzESy3K6k/6VTd6Og/e/bud940WCFwVHHHnXHRnu+WXJIRyqE8Sksemtxfaunn3viw5UUgR0bBhRcB+LYpvc6nmkBpGVhg9xuMno8PUPwoL6ZsOg5XBIW9FeEXsyw+xoyRt0zplCSlIJwOWyJzmU+UG70L6YUoasgzxPnVfW2nSRm8iT0QHh68gHv2mm2kB9ayTwRbCTkA1VSMxO9EAjE19ovW46SDT6kP8/NZlrjNV+EA+wdxY5aBAxp0crEnr2tJcoR1Raggi7E9/C40QPgCLXug5h3ekwSJy1CLNJXFceb9tbW6aqeJPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vtqbt90lXGYUsq315/bJOO7FwYsUFLC96geFQCIOJwY=;
 b=dZVgSgSxNNgjwqmLfLUHpdmwCASFx73XqBwHgMHSWHKaMf0RSct1EMpKFxGC6JY7EYCy8XUyz49Mq/k1OO0V8/5/Y7Ze4/Q42nvlOpjOf9RH+p1iWxH/KL41equ60Ux0U/6v2cSvo8jjRHFd1g21FOzK1/sqxQVME5E3PkNEc5g3pk2qDsNcinE0Ba6Mg/tg/B7lRDCNnEFNp4te+637N6+Ga3m9vh3DLRd9XgaOowH1TQ66UEx/XTQe6wFm94KBzAx0qor7wDi1EkwboiSzXGlAqq5gBrYB3mU2XlYE5EoHm870+YPwrrgomalg3aJTiGdTka9XX+yh9AkaorfZAA==
Received: from DM6PR12MB5534.namprd12.prod.outlook.com (2603:10b6:5:20b::9) by
 IA0PR12MB8280.namprd12.prod.outlook.com (2603:10b6:208:3df::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Wed, 20 Mar
 2024 17:50:20 +0000
Received: from DM6PR12MB5534.namprd12.prod.outlook.com
 ([fe80::4578:4ad4:b52f:3b0]) by DM6PR12MB5534.namprd12.prod.outlook.com
 ([fe80::4578:4ad4:b52f:3b0%7]) with mapi id 15.20.7386.031; Wed, 20 Mar 2024
 17:50:19 +0000
From: David Thompson <davthompson@nvidia.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "u.kleine-koenig@pengutronix.de"
	<u.kleine-koenig@pengutronix.de>, "leon@kernel.org" <leon@kernel.org>, Asmaa
 Mnebhi <asmaa@nvidia.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net v2] mlxbf_gige: call request_irq() after NAPI
 initialized
Thread-Topic: [PATCH net v2] mlxbf_gige: call request_irq() after NAPI
 initialized
Thread-Index: AQHaeinA+nVQDKBrM0eX1paqrbZKw7FAkM2AgABYTRA=
Date: Wed, 20 Mar 2024 17:50:19 +0000
Message-ID:
 <DM6PR12MB5534C61A0BE655B4BE072D9EC7332@DM6PR12MB5534.namprd12.prod.outlook.com>
References: <20240319181732.12878-1-davthompson@nvidia.com>
 <ZfrXL8yKhxduWm9D@nanopsycho>
In-Reply-To: <ZfrXL8yKhxduWm9D@nanopsycho>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB5534:EE_|IA0PR12MB8280:EE_
x-ms-office365-filtering-correlation-id: 49c81b5f-d74a-43d5-1393-08dc49063596
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 jhhym/iyC9t1Sn6rlZUsGEhH4rJQzVSRtyByPIoCT9Q+tLDbq9f200+QCDOoUN/k1KF9z+DEAzWLGUOhphzL5vMyo4VXpBzJTL4jXQ5yA5azIf7b1F3BxUizx4X2MkN9G2tN74GXgxm6hVXQ16TusE1VpX0H30jqMSYmChHKGyInfDa8uLrFfm9RpzNYJWhuTX45O59luWkwr9reaQj300XTE+CwaJnr9qLW1x9/+TzBLwpvH+wgAB+w/sftHC8ygI/g1SA7Dn5R/WNEmaU95nVrnaNgmlkII34gQOo4PFbk+OGvt35Y2jiCdPGia0kdHY8Ph/Xew0LADKRVeMv/dwcur4QjmLm2OAjHZNZYFu5ExL4hQThCLW9P+IQ3X62ggKoBliqEkpNvfJ6Jhmr/evGCJsLoA13SSLBFvvOluu22SFCt1OAQv96iZNjQPGb8FaJErkB9L8/v6lZ91kVXpQBSKg27I+vAkZcrnR89B9Qhf+ZLXe0INrGEjoO6GyzRT7xdJQej1IRFOr3OhUOO0A5c1iojygRyGwy9S8CbEmWgD9S9rSF7g/th0ra88ut5kJrJGxQGwjJakbM7d7CcaAsYRci7OFk4/YrJc2t0QssNvSdvSjP7NVQ09EGeJrnLSwEBI5RFJGPx1ddONZiHGq3oSTdgtj5TdE4eKRm6lIZLbMClh0xdkzmIw0LHol4i417KD0/x0RHOD6RMm6vQeMrmWpF5l67cgN2zhPGOuUQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5534.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?/24vc1Oq0iJAREdhLu+GaHm740FPQ4FY0beYdDAmP5ZZ1zSx9Lt6icWBNAKf?=
 =?us-ascii?Q?6/9ARLnZ7eMOsDbckx0lOFLfuGNyJCyNFiuDjCeO4UHpZaLDHox3jw6jwOHL?=
 =?us-ascii?Q?h3tx7t3H3+qGO0rAgFa2hOSCnn0xdNZKkKW+gCLUVlDUbOOeP3KkkNx6AXkH?=
 =?us-ascii?Q?3xOyI7HwgcinjRKbAKAlgiFnNvLy30XJxsqKzWk0E7azX1rA1bED5brDktRY?=
 =?us-ascii?Q?LXFkHwo5AGYRM7ywNWYOgxJhsi2JwsW+eoUfRCcHTdrIt045yI2UItob1/m4?=
 =?us-ascii?Q?iEOXtAeZaO5gArBJDqU2c8emVZ69KlSS/J0m/2ksq1fLA24fvHy6PN9Vwwrz?=
 =?us-ascii?Q?8HfK4mvgkgrfRnY9gVnnaCieMq1ECW/qnx+cG6mIYFjr2NbKQdodMbb2gwYD?=
 =?us-ascii?Q?cjSbLIug4wU0zHaS8ZQl9UhjV+dvG8pLocxfbooF3eweyUwS1NvWNH+lLEw2?=
 =?us-ascii?Q?tvBMGmTnn8GaDms+LVLgAujTcz75twYDcsP8A7BEvyU1pA2aBiPfdp3tfNJn?=
 =?us-ascii?Q?sRMdBDRSIHSOiXRY9eL44+s7naMXm/2fSn/7jOEY5VmXuojaCAAMY9x7uFJh?=
 =?us-ascii?Q?GOn3uMWWjDmdvSGh5W5UpoW08IG2Bx8MIVXYXfVo8m3h7hWyBRfHamrFkQ+D?=
 =?us-ascii?Q?oRFUvNMMZqwhkC+hhrSq4a5R02UUXzegRtQFRMqkrW1SBXlaHHN+lNNSjufD?=
 =?us-ascii?Q?nQv8ZZirVQ9P3sec2SfFvOTr0/e3/KCroVbDlcf4rue4EDg1REtjuiPOOP/k?=
 =?us-ascii?Q?CadHzzl/5NuFLMmsZV9nDM/wBQmBGwZQygmfOdzKstHgHjgyxhscbIBMfp3+?=
 =?us-ascii?Q?rxK0OYl/rAUIEo/vdnpztwniCU15ysMAgHyKQ3xKM9VnFStuo7Aq3SpJVXjT?=
 =?us-ascii?Q?sUT/4Yhux5KvIwSqJ0Xs+JDGT5wdPMBmLG7ZkwmVReMZ7E9ZYADdY95Oi/nK?=
 =?us-ascii?Q?2oRH8h3To7Df/v7jYtT6XzmMloiWt5KUrebQZ+ZPddGiZwz+woCxBeY8y8eg?=
 =?us-ascii?Q?y4Ycuv8xxBDdgZSJW+xSk8ib9uvZQrquPVnrDxQp9TT1q/gWmDBd6eyVigXZ?=
 =?us-ascii?Q?eMvoAG/ezU2X5epKK1KxOVI8j1CAH6e9tlt6Ou2MRJ43XfbP56fLON9jDDGr?=
 =?us-ascii?Q?v50C8dDT2sS5kGM6nR/sHkeZXbPAMAZTOpbDj6yMw9QGNJTPDcOFKdTI7/N8?=
 =?us-ascii?Q?JNZVhz9wgrTdf5f2TH0Qd7bfBET5CDIO6/iJ1I5sLbSKWa7wnOxgf4nxI0bZ?=
 =?us-ascii?Q?HKifDTwczyLlp582EhiZTe2tbq6NY4y1lKUVC1YL5TZA7k9b2WGMprBzsIlV?=
 =?us-ascii?Q?TbLXAuA1mIGCWwR4h8khXC6XKhn3evvFDUj+iPIsNJEJ2tAKEmB9zMMus6TT?=
 =?us-ascii?Q?E1k5Rzc994yNarE4GTAgBzF21+ed+Z8cK0Xs1kIGZTeHyJtcka9J0WmhORVO?=
 =?us-ascii?Q?bTL7nPz9nu9hG+Otv2Vx4NrPxnjY3/58Wb3yXVtpX19v3/P8Y6vUEHjjIjXc?=
 =?us-ascii?Q?kqhgEoFhhLWK8mKk/uONRbJbvbUclzF6N1WJ3V4vZrETsUuF+IlvPXUExPTX?=
 =?us-ascii?Q?3fpkQMPqJq2Rtu5bBF6XxdOUMtxfJcg38tb/TvnP?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49c81b5f-d74a-43d5-1393-08dc49063596
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2024 17:50:19.7131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8TkdHtdrlez5TAtvdBDcu9a7HvT4MdvdFudgUYC/WyYc5nqE2zrxY5BCdV+nkKL6i58rCz7aDsoopj/CuKeuwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8280

> -----Original Message-----
> From: Jiri Pirko <jiri@resnulli.us>
> Sent: Wednesday, March 20, 2024 8:32 AM
> To: David Thompson <davthompson@nvidia.com>
> Cc: davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; u.kleine-koenig@pengutronix.de; leon@kernel.org; Asmaa
> Mnebhi <asmaa@nvidia.com>; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH net v2] mlxbf_gige: call request_irq() after NAPI ini=
tialized
>=20
> Tue, Mar 19, 2024 at 07:17:32PM CET, davthompson@nvidia.com wrote:
> >The mlxbf_gige driver encounters a NULL pointer exception in
> >mlxbf_gige_open() when kdump is enabled.  The sequence to reproduce the
> >exception is as follows:
> >a) enable kdump
> >b) trigger kdump via "echo c > /proc/sysrq-trigger"
> >c) kdump kernel executes
> >d) kdump kernel loads mlxbf_gige module
> >e) the mlxbf_gige module runs its open() as the
> >   the "oob_net0" interface is brought up
> >f) mlxbf_gige module will experience an exception
> >   during its open(), something like:
> >
> >     Unable to handle kernel NULL pointer dereference at virtual address
> 0000000000000000
> >     Mem abort info:
> >       ESR =3D 0x0000000086000004
> >       EC =3D 0x21: IABT (current EL), IL =3D 32 bits
> >       SET =3D 0, FnV =3D 0
> >       EA =3D 0, S1PTW =3D 0
> >       FSC =3D 0x04: level 0 translation fault
> >     user pgtable: 4k pages, 48-bit VAs, pgdp=3D00000000e29a4000
> >     [0000000000000000] pgd=3D0000000000000000, p4d=3D0000000000000000
> >     Internal error: Oops: 0000000086000004 [#1] SMP
> >     CPU: 0 PID: 812 Comm: NetworkManager Tainted: G           OE     5.=
15.0-1035-
> bluefield #37-Ubuntu
> >     Hardware name: https://www.mellanox.com BlueField-3 SmartNIC Main
> Card/BlueField-3 SmartNIC Main Card, BIOS 4.6.0.13024 Jan 19 2024
> >     pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> >     pc : 0x0
> >     lr : __napi_poll+0x40/0x230
> >     sp : ffff800008003e00
> >     x29: ffff800008003e00 x28: 0000000000000000 x27: 00000000ffffffff
> >     x26: ffff000066027238 x25: ffff00007cedec00 x24: ffff800008003ec8
> >     x23: 000000000000012c x22: ffff800008003eb7 x21: 0000000000000000
> >     x20: 0000000000000001 x19: ffff000066027238 x18: 0000000000000000
> >     x17: ffff578fcb450000 x16: ffffa870b083c7c0 x15: 0000aaab010441d0
> >     x14: 0000000000000001 x13: 00726f7272655f65 x12: 6769675f6662786c
> >     x11: 0000000000000000 x10: 0000000000000000 x9 : ffffa870b0842398
> >     x8 : 0000000000000004 x7 : fe5a48b9069706ea x6 : 17fdb11fc84ae0d2
> >     x5 : d94a82549d594f35 x4 : 0000000000000000 x3 : 0000000000400100
> >     x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff000066027238
> >     Call trace:
> >      0x0
> >      net_rx_action+0x178/0x360
> >      __do_softirq+0x15c/0x428
> >      __irq_exit_rcu+0xac/0xec
> >      irq_exit+0x18/0x2c
> >      handle_domain_irq+0x6c/0xa0
> >      gic_handle_irq+0xec/0x1b0
> >      call_on_irq_stack+0x20/0x2c
> >      do_interrupt_handler+0x5c/0x70
> >      el1_interrupt+0x30/0x50
> >      el1h_64_irq_handler+0x18/0x2c
> >      el1h_64_irq+0x7c/0x80
> >      __setup_irq+0x4c0/0x950
> >      request_threaded_irq+0xf4/0x1bc
> >      mlxbf_gige_request_irqs+0x68/0x110 [mlxbf_gige]
> >      mlxbf_gige_open+0x5c/0x170 [mlxbf_gige]
> >      __dev_open+0x100/0x220
> >      __dev_change_flags+0x16c/0x1f0
> >      dev_change_flags+0x2c/0x70
> >      do_setlink+0x220/0xa40
> >      __rtnl_newlink+0x56c/0x8a0
> >      rtnl_newlink+0x58/0x84
> >      rtnetlink_rcv_msg+0x138/0x3c4
> >      netlink_rcv_skb+0x64/0x130
> >      rtnetlink_rcv+0x20/0x30
> >      netlink_unicast+0x2ec/0x360
> >      netlink_sendmsg+0x278/0x490
> >      __sock_sendmsg+0x5c/0x6c
> >      ____sys_sendmsg+0x290/0x2d4
> >      ___sys_sendmsg+0x84/0xd0
> >      __sys_sendmsg+0x70/0xd0
> >      __arm64_sys_sendmsg+0x2c/0x40
> >      invoke_syscall+0x78/0x100
> >      el0_svc_common.constprop.0+0x54/0x184
> >      do_el0_svc+0x30/0xac
> >      el0_svc+0x48/0x160
> >      el0t_64_sync_handler+0xa4/0x12c
> >      el0t_64_sync+0x1a4/0x1a8
> >     Code: bad PC value
> >     ---[ end trace 7d1c3f3bf9d81885 ]---
> >     Kernel panic - not syncing: Oops: Fatal exception in interrupt
> >     Kernel Offset: 0x2870a7a00000 from 0xffff800008000000
> >     PHYS_OFFSET: 0x80000000
> >     CPU features: 0x0,000005c1,a3332a5a
> >     Memory Limit: none
> >     ---[ end Kernel panic - not syncing: Oops: Fatal exception in
> > interrupt ]---
> >
> >The exception happens because there is a pending RX interrupt before
> >the call to request_irq(RX IRQ) executes.  Then, the RX IRQ handler
> >fires immediately after this request_irq() completes. The RX IRQ
> >handler runs "napi_schedule()" before NAPI is fully initialized via
> "netif_napi_add()"
> >and "napi_enable()", both which happen later in the open() logic.
> >
> >The logic in mlxbf_gige_open() has been re-ordered so that the
> >request_irq() calls execute after NAPI is fully initialized.
>=20
> This should be in imperative mood so the reader know right away that you =
are not
> talking about existing code and it's history, but you rather command the =
codebase
> what to change/do/fix/etc.
>=20

OK, will update the wording.

> >
> >Also, the logic in mlxbf_gige_open() was missing a call to phy_stop()
> >in the error path, so that has been added.
>=20
> Same here.
>

Yes, will update the wording here.
=20
> Also, could you please have the missing phy_stop() as a separate patch as=
 Paolo
> suggested? It's a different bug.
>=20

Sure, will create a separate patch for the missing phy_stop()

> pw-bot: cr
>=20
>=20
> >
> >Fixes: f92e1869d74e ("Add Mellanox BlueField Gigabit Ethernet driver")
> >Signed-off-by: David Thompson <davthompson@nvidia.com>
> >Reviewed-by: Asmaa Mnebhi <asmaa@nvidia.com>
> >---
> >v2
> >- re-worded commit message and subject for clarity
> >- updated commit message to mention that phy_stop() was added
> >  to the error path in mlxbf_gige_open()
> >---
> > .../mellanox/mlxbf_gige/mlxbf_gige_main.c     | 21 ++++++++++++-------
> > 1 file changed, 14 insertions(+), 7 deletions(-)
> >
> >diff --git a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
> >b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
> >index 3d09fa54598f..77134ca92938 100644
> >--- a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
> >+++ b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
> >@@ -139,13 +139,10 @@ static int mlxbf_gige_open(struct net_device
> *netdev)
> > 	control |=3D MLXBF_GIGE_CONTROL_PORT_EN;
> > 	writeq(control, priv->base + MLXBF_GIGE_CONTROL);
> >
> >-	err =3D mlxbf_gige_request_irqs(priv);
> >-	if (err)
> >-		return err;
> > 	mlxbf_gige_cache_stats(priv);
> > 	err =3D mlxbf_gige_clean_port(priv);
> > 	if (err)
> >-		goto free_irqs;
> >+		return err;
> >
> > 	/* Clear driver's valid_polarity to match hardware,
> > 	 * since the above call to clean_port() resets the @@ -157,7 +154,7
> >@@ static int mlxbf_gige_open(struct net_device *netdev)
> >
> > 	err =3D mlxbf_gige_tx_init(priv);
> > 	if (err)
> >-		goto free_irqs;
> >+		goto phy_deinit;
> > 	err =3D mlxbf_gige_rx_init(priv);
> > 	if (err)
> > 		goto tx_deinit;
> >@@ -166,6 +163,10 @@ static int mlxbf_gige_open(struct net_device *netde=
v)
> > 	napi_enable(&priv->napi);
> > 	netif_start_queue(netdev);
> >
> >+	err =3D mlxbf_gige_request_irqs(priv);
> >+	if (err)
> >+		goto napi_deinit;
> >+
> > 	/* Set bits in INT_EN that we care about */
> > 	int_en =3D MLXBF_GIGE_INT_EN_HW_ACCESS_ERROR |
> > 		 MLXBF_GIGE_INT_EN_TX_CHECKSUM_INPUTS | @@ -182,11
> +183,17 @@ static
> >int mlxbf_gige_open(struct net_device *netdev)
> >
> > 	return 0;
> >
> >+napi_deinit:
> >+	netif_stop_queue(netdev);
> >+	napi_disable(&priv->napi);
> >+	netif_napi_del(&priv->napi);
> >+	mlxbf_gige_rx_deinit(priv);
> >+
> > tx_deinit:
> > 	mlxbf_gige_tx_deinit(priv);
> >
> >-free_irqs:
> >-	mlxbf_gige_free_irqs(priv);
> >+phy_deinit:
> >+	phy_stop(phydev);
> > 	return err;
> > }
> >
> >--
> >2.30.1
> >
> >

