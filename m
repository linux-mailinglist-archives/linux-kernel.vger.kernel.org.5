Return-Path: <linux-kernel+bounces-112210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B828876F0
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 04:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 002761F2419F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 03:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1914D46A2;
	Sat, 23 Mar 2024 03:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SYAWOZzl"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F141841;
	Sat, 23 Mar 2024 03:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711165824; cv=fail; b=LBN3NYkFbtX9vdflGsM2JMjAFUUEFd6paju2NPl7JCQeozSHMPXOrkAt7NTgR1K3YOXpZ9pjxljyw3qqOTu3/7Ag3NXTIom0H/YiWkRb672jworOih57+M9kSdwJYjpiux0OEwvwudg1WVgaDhf0eKyLEkUtWFz/8eUG+AMKFz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711165824; c=relaxed/simple;
	bh=hm0Zec3jCWm2s4TTmPO4QuyrMVBSKRdAoL4iDSha5iY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k5t1kNID6Z2Lmg/pLjEKASeVaJYqjCSNFbpUjvKVwpWVlZeLxiz3rftu3zIUJ2egd30mY7ZZMh8PkdneqTL5OTbg/Dq7lr6Nj1YLw1gN8bEm4UjRJoi6fjGbXuyxxkIhZL3zS7DBKXeUXpqTnrQfRAqxAoNl0MBgRIGxCCskelE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SYAWOZzl; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711165823; x=1742701823;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hm0Zec3jCWm2s4TTmPO4QuyrMVBSKRdAoL4iDSha5iY=;
  b=SYAWOZzlWRsw9WP/m8jcLVGfo+S9CoZkIYRampagrWdw5l/PIrABMmzM
   zKlj4+B6v+0KRvMZaBeAMoAI2GsPHmjbdVvHCLX3GB57PudDh7oht/N5Z
   kZeOe9EtP1GdbN+O2TmdsLC7G1DL/rJkAJuGoy9o6cYmvrAio2uBPerG3
   88nZBFs9bcm+hg7wW3aPuiuOwJ9DElazi7OVMou0XL738qcVSAD2NLnWc
   bz8QqQ4ISwU6J1heyvAbQUG4Tm0coOQsEknE6W22T8MQe+J9bGhHBxE1U
   Uo1oBVHdlyAwn7dX82wL6cqwo7QhfoiOwWkEAGG8Y6vHluzfWsB42fIpr
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11021"; a="6127498"
X-IronPort-AV: E=Sophos;i="6.07,148,1708416000"; 
   d="scan'208";a="6127498"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 20:50:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,148,1708416000"; 
   d="scan'208";a="15103874"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Mar 2024 20:50:22 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 22 Mar 2024 20:50:20 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 22 Mar 2024 20:50:20 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 22 Mar 2024 20:50:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IjJy0ADqMy/Hb0nhCsgOBRzKNyuNXDYeo99WMZFwBQe47nzv4rgBNP66JLzF3XWRhpqflK2+96MZ9NZB5iIqaOLe0CZXl4LksRnR7ksHE4VqpSDpSTJ6cAJJnCdJreHLdBdFloeDRTirOOwQdoOw3RzoxsauiVex7iCQ2upk2KORd7cs6Gh3iDyqiPeMZS4KnUkx+M4xDpE3kA4tbjVXhne1IG4t3Vl1cMOO5wTfWNOOKd1SzrVFvFDDsBSLMAlkgcE8JYBomizJR+npF5zryKO3EanOrQ/sxWFxqZDWWD/jr42aRTvJo3s3LH4nz7rw26z9nCfJgPcxYSc/+AlLvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4cuoVRwX+ZF8ogYMRd7b9lqy8jBN0Dt+Ru0K5o+B44E=;
 b=BiaIy5sfEnqQxuklCVdLEsc/xdAaOHUH631TbvpVhAfF6XMVmGhNQxekf5V2T27QzXbr6sJPxKDCZ8tfV2CadovrDRbRwpEmUa4j06kE92et++S4eoZV/vpXtGkC3Wi6RqoH2AJHa2V5H6UOPDO9vdiiHwz3BYNJgMdIGnsxVf0TMUlSkMK1+1/zcyAOvzc5B3ALvOEn/mPiqT833VlXqz5A+IDPtmGMK1UGPPjQHHejR9XxS1SYBId2ytuilZxuupcW8hoR+gsgiJcmN15I8FLQ9umAaco3mlh9bVWgcgC+iQKcvAOMypavH1Gc2cNJ4uGOnfHy/gCff8/y2tKqCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5787.namprd11.prod.outlook.com (2603:10b6:303:192::7)
 by DS0PR11MB7958.namprd11.prod.outlook.com (2603:10b6:8:f9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Sat, 23 Mar
 2024 03:50:18 +0000
Received: from MW5PR11MB5787.namprd11.prod.outlook.com
 ([fe80::8814:40fd:3adb:8de2]) by MW5PR11MB5787.namprd11.prod.outlook.com
 ([fe80::8814:40fd:3adb:8de2%6]) with mapi id 15.20.7409.023; Sat, 23 Mar 2024
 03:50:18 +0000
From: "Wu, Wentong" <wentong.wu@intel.com>
To: Dominik Brodowski <linux@dominikbrodowski.net>
CC: Sakari Ailus <sakari.ailus@linux.intel.com>, "Winkler, Tomas"
	<tomas.winkler@intel.com>, "mchehab@kernel.org" <mchehab@kernel.org>,
	"hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: v6.8.0-rc6: mei_ace_probe / mei_vsc_probe: do not call blocking
 ops when !TASK_RUNNING
Thread-Topic: v6.8.0-rc6: mei_ace_probe / mei_vsc_probe: do not call blocking
 ops when !TASK_RUNNING
Thread-Index: AQHaam3EvCzE5l33CkGR0g/9d0yezrEgGjAAgADQ1wCAAAJ5gIAAnU4AgA0EQNCAAKILAIAAdXAwgAEW1wCAFBaiwA==
Date: Sat, 23 Mar 2024 03:50:18 +0000
Message-ID: <MW5PR11MB57871E08D9A7C05CDB7226AB8D302@MW5PR11MB5787.namprd11.prod.outlook.com>
References: <Zd9wUv1zSJ59WS8i@shine.dominikbrodowski.net>
 <Zd-BVmoFOiCxA632@kekkonen.localdomain>
 <ZeAwhhW7DSEazs0F@shine.dominikbrodowski.net>
 <ZeAymVVsI-CNj6Pc@kekkonen.localdomain>
 <ZeC2jss4IAM4aPWy@shine.dominikbrodowski.net>
 <MW5PR11MB5787E3A96C8EFF3C9F8BC8908D272@MW5PR11MB5787.namprd11.prod.outlook.com>
 <ZewpyJ3d7gx3dSvA@shine.dominikbrodowski.net>
 <PH0PR11MB580859671B2F9EFAD471F76C8D252@PH0PR11MB5808.namprd11.prod.outlook.com>
 <Ze12NB4XQaIydr0t@shine.dominikbrodowski.net>
In-Reply-To: <Ze12NB4XQaIydr0t@shine.dominikbrodowski.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5787:EE_|DS0PR11MB7958:EE_
x-ms-office365-filtering-correlation-id: 8bda0b1c-216b-4af7-0a66-08dc4aec5b5b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fh3DJcjasF6kkEniTc8x/+otK24iVdz7W4HyX65jgGR6unC2zccNBG4YKlNnqm2ejW3JQjS8BrXbmZL28/OLGAych+pwLP9mb6OnKIAPbXwX+bL5kTC1hgi+UHjl22uQCsrCNBENNyw1VVykg/G8u1zVglfiNFlt6cyz/dFRPZWtMKgV967UAiJCc3tgDlxfOyjLNq8Myjk8qEzWSEUeY8ZkDdlr4RWRLDzzkwRZQj2vLbVXNgAW930SsuTDp3sQ1jRyhCcH6dzKj5RGKvhsEPn0miH88CT4yfoF9J0eDwxaJLkWx/byQquVIbSgXMzsOLIs27c2i8DE0pV+OfLvowV3GY+NBE+iIU1mKbxRTOQkAcYqoW/04Ga6/fXUULK6Mlo4ycrTCzfDnhysXGp+uRvP+S1fP+h2QXJZY3S/IbdAwGYbRiJ4HpbDtwwisjGwyawz3Nu6cvPZnIa2LEkeCY4fuMWORLilSzNJZITFYjBoM9dFdMN78ZMTJyBMt16IgVsrOChyvdht23GSpCLdnaofpAhPEffM+Oz9UGccPOwMESBr/Hd+4+aLx88Q/HipN0NXE7lQvziPF6JdmEiYkTHGm3MEZNdIdB9US0Tm3XI9x0iENAgIu2IFJWeZofEQyYBGuAf3X4o24GMjaKRCF6AaYJKj9yn6qtGnqBfsdS8wHd9vGDvUXi2Zockqxnz0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5787.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LZqQn2cnipkcuMMRaqED3g75K9BZHcXh7NOkjWAjnxjVaXAQyBcS6D42zoCV?=
 =?us-ascii?Q?YM3/toyqH6bt8zONxHtgkU/1lvmAp8E+jf9d284nmg3qZLDT9A3NwLDtkX55?=
 =?us-ascii?Q?ds8TOMArJPftfzEuiHPKWjSjdj70yG2hnTHJ9GTIz6B0GoaJfv55hV9ynu3e?=
 =?us-ascii?Q?tV6u7kfLj6rZqfWqhwVpgH76v3qtork9WaE0WSb2uBpN7e/5lhaobnLuSvIr?=
 =?us-ascii?Q?ashJ7TtillHqUbimrKbfg0bncbJQbwdUPpKjdpaCuU5QmncCszCXjGihuWLB?=
 =?us-ascii?Q?QP5ofTCBm4v+73xaOALNHc3KJd3eO1RbgtPRYRUhz8C1D05VGpiqYo+hqU5Z?=
 =?us-ascii?Q?9MjTxJ5k6ie5hG35SLgesIYkzkAvd6Iyk6XLxElNVJMxvheGEaaC2yj+jBno?=
 =?us-ascii?Q?Ns5BO/8ZEhH3vf6YKjfG0hRXgAiT0k3otaccoflzN3uF9NeHOfjcDG0u0vqG?=
 =?us-ascii?Q?5WqgZ2jGdjX4zu/nDi0ZkFw+Xr9dU77Iik/oL1Kt13coRogURAlzJzhbyYq7?=
 =?us-ascii?Q?3zDAbgsnxSjBw2btEADds3oPpW0jz8QFDFC85d9NLFRXa5NqEKinrXRxqn+D?=
 =?us-ascii?Q?wTw62kO9Tk/8XT8j/jdII2qtXfwOL6JijsoFp9jn5acevJu8Okay/gQ2mRNi?=
 =?us-ascii?Q?vc/OpyM4x2ptsgr6KSHj+x811EBtAeqxrimxkujFABCU+7cHjQ9NdjWrgrR6?=
 =?us-ascii?Q?Lz4RLp3loyUZdj5/z1/I6QqWq9SbmDy+BfPJaXAxUwNUvwuvm7Ywsc1l/ROf?=
 =?us-ascii?Q?6AGKK3ANma/OFt/rKPMkLeF7YXSvwz3sJPM5x0qgHWg2i0J4e7l75wX1O+ZN?=
 =?us-ascii?Q?ZVDiHiVsK+4LcyYgXEMxLzGbuFTmzaSYdkLIK2YKbSHl123oFcmrIniv0L7U?=
 =?us-ascii?Q?F1/f040p29KG2xAZXNT+GIwGEshPL53wyOgorWcwFV2hYxe/qpF+MVnAuLhJ?=
 =?us-ascii?Q?cJssez0SgswphvBYKGMp+lv9D6g8EAvmAjU3OrZGWDxBuc9JztnJBdCKBjFd?=
 =?us-ascii?Q?l+9bmtuluWRkBRMC+tKOkzCm97C08zZwhx7ofznnFr4HSN+WZCj7kZU2Iihx?=
 =?us-ascii?Q?P7iZN7Gsiga5+OObtE1V1Hf4PeyvXFpqU14Ft0Iaa6q6E+pajEwobiDZAyH+?=
 =?us-ascii?Q?S/sd5vQXuF21hVymdHXpvBdUIw4w26GVvJOXf7nana09yR8mpgGyakGA2sSC?=
 =?us-ascii?Q?98J1O6P7fBCkZS4oxJMK3AsNzhxU1gO1FizxPqzZfSdZgaYOtqPQNx03XShB?=
 =?us-ascii?Q?0hVOqayUVlFwVRe/6UZqQ0hfR1QnoVY1MHd46sPeiIShfMAWAchy+QpHtjQ2?=
 =?us-ascii?Q?ngbcWvEsfQSfCdASzqIMSPVTmYi4UZGM4wkAXxIJyT5bhoDIiABjAk7MKAD6?=
 =?us-ascii?Q?kilHQ5xF8RFRz6SioaHA1XhkuNW2EVkE69lXs/O4ghffo4Mv9QpTE0O+1Xmf?=
 =?us-ascii?Q?A4dgB4WuTnX2BHmez4Lc9U+MrRSuNfhsRMKBOrjoMsZ3Warbq55qRYIruhyo?=
 =?us-ascii?Q?SEHWfcweQssdpzln/73zcwyK+HApKdft2EqeGIPeOaHPp6bUFP1ssL4tK8sE?=
 =?us-ascii?Q?TyMkHouLpobyXK4Injgq68R5ccTmEol+LlIHLwge?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bda0b1c-216b-4af7-0a66-08dc4aec5b5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2024 03:50:18.5087
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dtHKNvoth9J59vZoGhHx4s0Jc2xIEM8qLj991WxVXnIdoj+XxNP53sf4165q7Hx1DfWtlcCD+RusSCvbz5o6Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7958
X-OriginatorOrg: intel.com

> From: Dominik Brodowski <linux@dominikbrodowski.net>
> Am Sun, Mar 10, 2024 at 01:33:49AM +0000 schrieb Wu, Wentong:
> > > From: Dominik Brodowski <linux@dominikbrodowski.net>
> > >
> > > Hi Wetong,
> > >
> > > Am Fri, Mar 08, 2024 at 11:45:44PM +0000 schrieb Wu, Wentong:
> > > > Did you try master branch (v6.8) without IPU6 driver? There should
> > > > be problems with the IPU6 driver you use as below:
> > > >
> > > > > intel-ipu6 0000:00:05.0: Found supported sensor OVTI01A0:00
> > > > > intel-ipu6 0000:00:05.0: Connected 1 cameras
> > > >
> > > > If not, could you please help try it on your side?
> > >
> > > Branch master from https://git.linuxtv.org/sailus/media_tree.git/
> > > causes a WARNING during boot; some extracts from dmesg:
> >
> > Thanks for your help, I think this has been fix by below patch:
> > <URL:
> > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/co
> > mmit/drivers/misc/mei/vsc-
> tp.c?id=3Db8b19acfafdeacbedd4e2795cb18c81c4d8b
> > b6cc>
>=20
> ... which isn't in the master branch of git.linuxtv.org/sailus/media_tree=
git
> . I've now taken Linus' tree of today, merged in char-misc-next, merged i=
n the
> media_tree, and applied a fixup patch (see bottom of the message).
>=20
> Booting this kernel, there is no WARNING during boot, and I can suspend
> and resume. However, please note the warnings/failures and the long delay=
s
> between suspend entry and exit during the first (two) suspend/resume
> cycles:

Thanks

I believe this has been fixed by the patch
https://www.spinics.net/lists/kernel/msg5146202.html

and I have tested it on my setup, could you please try it (without IPU6 dri=
ver)
on your end to double confirm and ack the patch?

BR,
Wentong
>=20
> [  107.696067] PM: suspend entry (s2idle) [  107.701258] Filesystems sync=
:
> 0.005 seconds [  107.818367] Freezing user space processes [  107.822954]
> Freezing user space processes completed (elapsed 0.004 seconds)
> [  107.822979] OOM killer disabled.
> [  107.822980] Freezing remaining freezable tasks [  107.825672] Freezing
> remaining freezable tasks completed (elapsed 0.002 seconds) [  107.825834=
]
> printk: Suspending console(s) (use no_console_suspend to debug)
> [  108.186987] ACPI Warning: \_SB.PC00.SPI1.SPFD.CVFD.SID: Insufficient
> arguments - Caller passed 0, method requires 1 (20230628/nsarguments-232)
> [  108.192890] intel_vsc intel_vsc: silicon stepping version is 0:2 [  11=
9.661371]
> PM: Some devices failed to suspend, or early wake event detected
> [  119.696726] ACPI Warning: \_SB.PC00.SPI1.SPFD.CVFD.SID: Insufficient
> arguments - Caller passed 0, method requires 1 (20230628/nsarguments-232)
> [  119.702358] intel_vsc intel_vsc: silicon stepping version is 0:2 [  13=
3.493790]
> vsc-tp spi-INTC1094:00: wakeup firmware failed ret: -110 [  135.541436] v=
sc-tp
> spi-INTC1094:00: wakeup firmware failed ret: -110 [  135.541823] intel_vs=
c
> intel_vsc: wait fw ready failed: -110 [  135.541832] intel_vsc intel_vsc:
> hw_start failed ret =3D -110 fw status =3D [  135.543616] intel_vsc intel=
_vsc:
> unexpected reset: dev_state =3D RESETTING fw status =3D [  135.580522] AC=
PI
> Warning: \_SB.PC00.SPI1.SPFD.CVFD.SID: Insufficient arguments - Caller
> passed 0, method requires 1 (20230628/nsarguments-232) [  135.584170]
> intel_vsc intel_vsc: silicon stepping version is 0:2 [  135.635935] OOM k=
iller
> enabled.
> [  135.635940] Restarting tasks ... done.
> [  135.863803] PM: suspend exit
>=20
> I seem to have pressed the power butten often enough to initiate a second
> suspend/resume cycle immediately:
>=20
> [  135.864196] PM: suspend entry (s2idle) [  135.875238] Filesystems sync=
:
> 0.011 seconds [  135.879306] Freezing user space processes [  135.883869]
> Freezing user space processes completed (elapsed 0.004 seconds)
> [  135.883881] OOM killer disabled.
> [  135.883884] Freezing remaining freezable tasks [  135.886107] Freezing
> remaining freezable tasks completed (elapsed 0.002 seconds) [  135.886112=
]
> printk: Suspending console(s) (use no_console_suspend to debug)
> [  149.173274] vsc-tp spi-INTC1094:00: wakeup firmware failed ret: -110
> [  151.221491] vsc-tp spi-INTC1094:00: wakeup firmware failed ret: -110
> [  151.221784] intel_vsc intel_vsc: wait fw ready failed: -110 [  151.221=
793]
> intel_vsc intel_vsc: hw_start failed ret =3D -110 fw status =3D [  151.22=
2752]
> intel_vsc intel_vsc: unexpected reset: dev_state =3D RESETTING fw status =
=3D
> [  151.256758] ACPI Warning: \_SB.PC00.SPI1.SPFD.CVFD.SID: Insufficient
> arguments - Caller passed 0, method requires 1 (20230628/nsarguments-232)
> [  151.262174] intel_vsc intel_vsc: silicon stepping version is 0:2 [  16=
4.853425]
> vsc-tp spi-INTC1094:00: wakeup firmware failed ret: -110 [  166.901441] v=
sc-tp
> spi-INTC1094:00: wakeup firmware failed ret: -110 [  166.901772] intel_vs=
c
> intel_vsc: wait fw ready failed: -110 [  166.901779] intel_vsc intel_vsc:
> hw_start failed ret =3D -110 fw status =3D [  166.904282] intel_vsc intel=
_vsc: reset:
> reached maximal consecutive resets: disabling the device [  166.904290]
> intel_vsc intel_vsc: device disabled =3D -19 [  166.904665] intel_vsc int=
el_vsc:
> reset: reached maximal consecutive resets: disabling the device [  166.90=
4712]
> PM: Some devices failed to suspend, or early wake event detected
> [  166.940695] ACPI Warning: \_SB.PC00.SPI1.SPFD.CVFD.SID: Insufficient
> arguments - Caller passed 0, method requires 1 (20230628/nsarguments-232)
> [  166.946175] intel_vsc intel_vsc: silicon stepping version is 0:2 [  18=
1.045504]
> vsc-tp spi-INTC1094:00: wakeup firmware failed ret: -110 [  183.093514] v=
sc-tp
> spi-INTC1094:00: wakeup firmware failed ret: -110 [  183.093898] intel_vs=
c
> intel_vsc: wait fw ready failed: -110 [  183.093912] intel_vsc intel_vsc:
> hw_start failed ret =3D -110 fw status =3D [  183.094507] intel_vsc intel=
_vsc:
> unexpected reset: dev_state =3D RESETTING fw status =3D [  183.129467] AC=
PI
> Warning: \_SB.PC00.SPI1.SPFD.CVFD.SID: Insufficient arguments - Caller
> passed 0, method requires 1 (20230628/nsarguments-232) [  183.132830]
> intel_vsc intel_vsc: silicon stepping version is 0:2 [  183.135905] OOM k=
iller
> enabled.
> [  183.135909] Restarting tasks ... done.
> [  183.372915] PM: suspend exit
>=20
> Subsequent suspend/resume operations continue to emit warnings/failures
> related to intel_vsc:
>=20
> [  341.554095] PM: suspend entry (s2idle) [  341.559387] Filesystems sync=
:
> 0.005 seconds [  341.673175] Freezing user space processes [  341.679061]
> Freezing user space processes completed (elapsed 0.005 seconds)
> [  341.679069] OOM killer disabled.
> [  341.679071] Freezing remaining freezable tasks [  341.680652] Freezing
> remaining freezable tasks completed (elapsed 0.001 seconds) [  341.680656=
]
> printk: Suspending console(s) (use no_console_suspend to debug)
> [  341.861251] intel_vsc intel_vsc: reset: reached maximal consecutive re=
sets:
> disabling the device [  342.065565] ACPI: EC: interrupt blocked [  342.85=
5083]
> ACPI: EC: interrupt unblocked [  343.039446] i915 0000:00:02.0: [drm] GT0=
:
> GuC firmware i915/adlp_guc_70.bin version 70.20.0 [  343.039458] i915
> 0000:00:02.0: [drm] GT0: HuC firmware i915/tgl_huc.bin version 7.9.3
> [  343.064550] i915 0000:00:02.0: [drm] GT0: HuC: authenticated for all
> workloads [  343.065807] i915 0000:00:02.0: [drm] GT0: GUC: submission
> enabled [  343.065811] i915 0000:00:02.0: [drm] GT0: GUC: SLPC enabled
> [  343.066305] i915 0000:00:02.0: [drm] GT0: GUC: RC enabled [  343.12462=
8]
> nvme nvme0: 8/0/0 default/read/poll queues [  343.385084] ACPI Warning:
> \_SB.PC00.SPI1.SPFD.CVFD.SID: Insufficient arguments - Caller passed 0,
> method requires 1 (20230628/nsarguments-232) [  343.389309] intel_vsc
> intel_vsc: silicon stepping version is 0:2 [  356.946491] vsc-tp spi-INTC=
1094:00:
> wakeup firmware failed ret: -110 [  358.996072] vsc-tp spi-INTC1094:00:
> wakeup firmware failed ret: -110 [  358.996432] intel_vsc intel_vsc: wait=
 fw
> ready failed: -110 [  358.996446] intel_vsc intel_vsc: hw_start failed re=
t =3D -110
> fw status =3D [  358.997008] intel_vsc intel_vsc: unexpected reset: dev_s=
tate =3D
> RESETTING fw status =3D [  359.031049] ACPI Warning:
> \_SB.PC00.SPI1.SPFD.CVFD.SID: Insufficient arguments - Caller passed 0,
> method requires 1 (20230628/nsarguments-232) [  359.035795] intel_vsc
> intel_vsc: silicon stepping version is 0:2 [  359.051336] mei_hdcp
> 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0
> (ops i915_hdcp_ops) [  359.051432] OOM killer enabled.
> [  359.051435] Restarting tasks ...
> [  359.052195] mei_pxp 0000:00:16.0-fbf6fcf1-96cf-4e2e-a6a6-1bab8cbe36b1:
> bound 0000:00:02.0 (ops i915_pxp_tee_component_ops) [  359.056184] done.
> [  359.309627] PM: suspend exit
> [  372.188053] vsc-tp spi-INTC1094:00: wakeup firmware failed ret: -110
> [  374.364551] vsc-tp spi-INTC1094:00: wakeup firmware failed ret: -110
> [  374.364749] intel_vsc intel_vsc: wait fw ready failed: -110 [  374.364=
755]
> intel_vsc intel_vsc: hw_start failed ret =3D -110 fw status =3D [  374.36=
4778]
> intel_vsc intel_vsc: unexpected reset: dev_state =3D RESETTING fw status =
=3D
> [  374.399149] ACPI Warning: \_SB.PC00.SPI1.SPFD.CVFD.SID: Insufficient
> arguments - Caller passed 0, method requires 1 (20230628/nsarguments-232)
> [  374.406099] intel_vsc intel_vsc: silicon stepping version is 0:2 [  38=
7.747776]
> vsc-tp spi-INTC1094:00: wakeup firmware failed ret: -110 [  389.924474] v=
sc-tp
> spi-INTC1094:00: wakeup firmware failed ret: -110 [  390.045250] intel_vs=
c
> intel_vsc: wait fw ready failed: -110 [  390.045260] intel_vsc intel_vsc:
> hw_start failed ret =3D -110 fw status =3D [  390.045294] intel_vsc intel=
_vsc:
> unexpected reset: dev_state =3D RESETTING fw status =3D [  390.045297] in=
tel_vsc
> intel_vsc: reset: reached maximal consecutive resets: disabling the devic=
e
> [  390.045324] intel_vsc intel_vsc: device disabled =3D -19
>=20
> Best,
> 	Dominik
>=20
> ---
>=20
> Subject: [PATCH] media: v4l: async: remove unused variable
>=20
> ret is unused in v4l2_async_nf_register()
>=20
> Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
>=20
> diff --git a/drivers/media/v4l2-core/v4l2-async.c b/drivers/media/v4l2-
> core/v4l2-async.c
> index a722c5eb3230..3b43d6285dfe 100644
> --- a/drivers/media/v4l2-core/v4l2-async.c
> +++ b/drivers/media/v4l2-core/v4l2-async.c
> @@ -620,8 +620,6 @@ static int __v4l2_async_nf_register(struct
> v4l2_async_notifier *notifier)
>=20
>  int v4l2_async_nf_register(struct v4l2_async_notifier *notifier)
>  {
> -	int ret;
> -
>  	if (WARN_ON(!notifier->v4l2_dev =3D=3D !notifier->sd))
>  		return -EINVAL;
>=20

