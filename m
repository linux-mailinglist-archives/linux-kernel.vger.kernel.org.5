Return-Path: <linux-kernel+bounces-73978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E43585CE4C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 03:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 618421C23296
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 02:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF11D282F7;
	Wed, 21 Feb 2024 02:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bmUknH6o"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C4E46A4
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 02:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708483698; cv=fail; b=u0ooOuK7ghGFlMfA6lu37JGyIpwJQiKsihBa2GeQ5glQp8u4sCTW3PG1hXjwjopalJhMRR2W6XxdgNAGtz6BSsRvJbs25SZ62DuXUJDw4CVMP0+CvOJZFeqVNHsI5nXD0dZpBSfgP8QE5h65+a7kV1rN/68dtb/Z+gWgFocrjEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708483698; c=relaxed/simple;
	bh=2lJ4CAnVurDPYvDqmoXOibLpVCoR4/R2XNw+soOu1Ss=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p17gDlKs5kkYZUn1o9XhfbU9CDUtsr5ZNtIW2TeNBf+uaxJuNIURzGgxnaXPHcIBiZFEOw56MLvRqZET8Uk2W/RMijH5xivCe0FektZK0xT04cecA+XOJmuV0AFGINx9vxg3Y5K4Ra2CM366qkRrZa4BhXJaUuOQqGwwTPC12V8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bmUknH6o; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708483697; x=1740019697;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2lJ4CAnVurDPYvDqmoXOibLpVCoR4/R2XNw+soOu1Ss=;
  b=bmUknH6oF89FIvvPK1dmRt3bo4nn/qWnFCy3OFUBruPLAX7pfS89hCjh
   VK+mN6kok8y7pOfVCvDqokgglIVjm/5S4ljoGdR7tXNtwhR+kTS+Ux1+9
   +psIudvBIpfLO3vA0t1W377l5ul8TJr4hDhfvjMide0+1tKlgB8+U8ouX
   IcGvgB1KFclrErqu6W/wqJuRpFskCQGT984Vj6IzaMJlU9nIFZAG18zAB
   FME1FUNxaJlAQpeuME3+9eOJO0i60L7qbm56/Ro7k+w+koCfmPuwiiWyZ
   ZY49Z6WhcaFOPF4n+xYUC3RgZHnacW8E5rXYATBR2seASAS+uL/Te8FRh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="20058011"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="20058011"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 18:48:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="42467633"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Feb 2024 18:48:16 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 18:48:14 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 20 Feb 2024 18:48:14 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 20 Feb 2024 18:48:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SkD/eEMUIJc9RnKDXl5AHK7pf1BjYAHRHCoQGCo9dBN+NwhxcS8UleXBRgRIPDLhUkGE6LBlbGFSgtWMfj6zG9P1czuCQzVKaxmK9sJegFlFGGs1KxUpyWgmfwJa+iKa3bEC7XOqD+apnWgMaofyv+FHF3Y7Xr4d0dwNENf2g122iLJcMYN9+eDgIjQ9UV6Ea2o/KSWGwlY4LiaSNQ2gVnmbAlGkYZXtl21XZGc7l7S8EsPWa2SMJIe9lfwg2BOQ2SFVv5/NPP17/sJB7tYa0bnAmXv9b1pzYV1UCBhNvUZe41VBrFk3hFo4147H9c3dAfCOnRToQ5247uZTy52Vhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2lJ4CAnVurDPYvDqmoXOibLpVCoR4/R2XNw+soOu1Ss=;
 b=TsaiIRO34uwVUx+4FWxH60t+Ine8RrmhokTSELqyQM6xPx/ObJtJvUt7mTsbeEV3Vt6RtjRHYnd2F3VPLWThRmpNB2z0GVB+HZcZA+6mWmy/BBD5e79WvsI0y8vDZYXbKoKF0E0lwrISXb13ZId92XsnS+Xi93wxH34zsk54rv9xdNenO+kzy+KEmmkptHw1jXAc1rWtHZPN5fJGNfaoyjT/LSm5Dr8kzn3jE3fgXGN1MtPn6YXOSEOFU59EzFlJX8urbwWBMKd3ZNbiCKmNoFyGl/M82rPwjgCvYin9GGuE+zZJhVLOMI1nn/cCWR0jRMQsnH6hR1ZJbu+Lo0AqWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5808.namprd11.prod.outlook.com (2603:10b6:510:129::12)
 by PH0PR11MB5673.namprd11.prod.outlook.com (2603:10b6:510:d6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Wed, 21 Feb
 2024 02:48:12 +0000
Received: from PH0PR11MB5808.namprd11.prod.outlook.com
 ([fe80::53e1:ca40:13ff:a23a]) by PH0PR11MB5808.namprd11.prod.outlook.com
 ([fe80::53e1:ca40:13ff:a23a%7]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 02:48:12 +0000
From: "Wu, Wentong" <wentong.wu@intel.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "Winkler, Tomas" <tomas.winkler@intel.com>, Sakari Ailus
	<sakari.ailus@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mei: Add Meteor Lake support for IVSC device
Thread-Topic: [PATCH] mei: Add Meteor Lake support for IVSC device
Thread-Index: AQHaWV7S342idETh5UKss3/1MOC1P7D+bxyAgAAEDYCAEWapMIABs52AgAKgLhA=
Date: Wed, 21 Feb 2024 02:48:12 +0000
Message-ID: <PH0PR11MB5808A92C697D9B74F10792258D572@PH0PR11MB5808.namprd11.prod.outlook.com>
References: <20240207004304.31862-1-wentong.wu@intel.com>
 <ZcMmg1f8975whpno@kekkonen.localdomain>
 <PH7PR11MB760526EBCB4CFCDB19A03E40E5452@PH7PR11MB7605.namprd11.prod.outlook.com>
 <MW5PR11MB5787BC32B9E7C3F818B6B9D98D522@MW5PR11MB5787.namprd11.prod.outlook.com>
 <2024021924-mashed-hankering-348a@gregkh>
In-Reply-To: <2024021924-mashed-hankering-348a@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5808:EE_|PH0PR11MB5673:EE_
x-ms-office365-filtering-correlation-id: 7795698d-f9ca-4a2a-d8f0-08dc32878b7a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fmjcqiPYfDQKmCMZyBpq5pw9FkNJzHGIN+8RTytla3+KNa+ZOe2AKCu4K/EwjvVzS+qFtG4Sb/IQRLTcM0lDbIr0j6mGszF8leTBIT/rCQIrFXPDNVBJcfhBSdpwoPaoConO2913ztUCc1Pi+XRYhPC5Og0gj2Tg65pLsa9VT9+9JhnxWRiDhHScFuSPPcenlpcy1dbOnRvIkGPvXrG3mZug8o9WOecMp/O0xXMngO3BVaah9vqsfCcB6g3xLPERupvj/aQqAULN6VJPRqNrY9aJF1spe2LuBKtD9tnPTKz6G+Xg121qQMuQNOUu4MT1sVZJhMaobLjIPrARxvu6Le4Px5oK9UXOw7e8iOvLadg+QQBHtPHA/rxB2V293TAgeu2Avnq4nDuhE+glqiv1t2lmFTvuLOhAQIjiy2Sgo+jLfDm9NrXgu1svp6muzhM1tC2sukOW2DpQZadKfU/8qeTLtHho5DGrPOl78uzH7riGd8FzUX/uTrh4DLdQME05gwgsQ9dz9EQFsgwwDhEvYsu5d4tI5cXQhII3Odi3+XMHdOvcMZnALgHVJA+DrZynmnpD4BOLfHF+kt8YmLY3eP6hZ1+l+8fIDx2hbXWwXkKtN29wHUs9O9m2c6jbOjQN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5808.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nGHCnG7/SQ3UQhl9Og9Da/VNYDXEj0SF2MPI5lxrWIhxp6AzkAET6/cCcKyO?=
 =?us-ascii?Q?yoxntYESKbSBcpYDUOa0FHyQwcqxyuHIJ5v0mQYX9SqwM2hNQaM/yPY73SEn?=
 =?us-ascii?Q?3hT9biXbNsmf6HodDD7jMvgBMpPTD6PcTiuHJKGMO5VaPTSx63yoavH2S20o?=
 =?us-ascii?Q?MBHjZFNfmK2OeC+/BOK8mt1+rXS0hk6cDEX2NThAkbB2WDw3hxgrAryUhPkz?=
 =?us-ascii?Q?pq+ZCFGI/j603CW5zB1Xxi3N5ehDS+PhhJ71PCJPRBmablPfkN3JZBXnmtGb?=
 =?us-ascii?Q?0hlIvPqnzHLtFHPih21MeKmfuZOZYMuHMvsair1z5IqdDi6NRbGPoEGMbWcX?=
 =?us-ascii?Q?//3ix+fQ5UgmfOzMt+Hky4WVObzDimWOoEOHBZ3ZfTjeAFuh8cQ3J2SQ/wCl?=
 =?us-ascii?Q?kaeWVHfUNbEJErrLponRoCxD18YzT8aDDhkg6bxt1xAAocI6TB3ysUB4Edk2?=
 =?us-ascii?Q?fiuGgwbOB5PCh5jabwVMusCP8JCB9aqcegBu2wV73VYgiWCCgqb7TM1JufWP?=
 =?us-ascii?Q?nWzsoa07FXHVrHUUxdLMQGyedcp9GQjyRMeQV98NVJIavMmOfzE2HAYLS1zJ?=
 =?us-ascii?Q?cy7rVgA7T9z+3EXRTraz5ZZT2IzJBV9X8snVcSgQfdX49vfquguNwNTiAa78?=
 =?us-ascii?Q?0u2qkP1Ze34JMv1oA7OiKTGHlyeM3LotbbxUyWp8/PusjYE5BwjmD1e4B3Vo?=
 =?us-ascii?Q?nrNtoaltVFX4F6LIc8bIN1Sw3txM7E1v2BKYZzbL9rYFU5l7Wwx5K4kZQ2US?=
 =?us-ascii?Q?eHMrmwop2TZroWcVtmdL/+b6mbBGQtPfocXiIKC+YYADEfD+cczBEbXa0PZl?=
 =?us-ascii?Q?aPQPErX6SmfknUQ4ylY7aHrwum0jOT9R6xknSsL4HgsU7dDShQm5Y4elLOMU?=
 =?us-ascii?Q?syXCYzHMLpf7Zjgg0rrpl7Y3uA8nzFvxmYDtCp5M0IaeXQpNLwBreo4o/eZT?=
 =?us-ascii?Q?6CHuI2+dKMTX9BjsypKuH24gHzsUkiUVJSeYbz+woIwbkPi/gn8y+8+VP5rO?=
 =?us-ascii?Q?cfaUgPXqzkRN61+JvODYwlv+bE7lr9hPWih7HjYjwohMoDi5X8Lin+FGLEiB?=
 =?us-ascii?Q?T67XSj6SHztFG2xekO5UoGNP9kUB2Yyi6DNHlWrRZNRKAH5sHMrqURPQUCB2?=
 =?us-ascii?Q?FuIse1e+SB3rzrB+nlbM8Yx3aeotdE1FJRTJCpl8MBk2S74tHMHG0ysAO92d?=
 =?us-ascii?Q?XiDgV5+HWSB1gCRwbCbA2kqKhz/1Gw/fYwuZMefgEVnTpsGWtT5X2LFjEkBL?=
 =?us-ascii?Q?BQdbatVGJAVZltfiDxaAOC8dQfFjSJWLbQd2y8EddjMqcSenShOwAbme9znq?=
 =?us-ascii?Q?ROOGhVcNv7feVtGBUkNEkF/8GehQPH3aoUCKdDhbJ2Mp5i4L9JRdkogtMjW7?=
 =?us-ascii?Q?9d709G+5q1cCcON/zlMZ724YeMbRs0bfhbjt0/FI1HOtWE9ETc8xXTu+PJRe?=
 =?us-ascii?Q?iGXeG6jWkPt7bkBGx/W6A9EBuUThJ/oAQTtnnImLx5aRAIH9lG6CwsvhwAnK?=
 =?us-ascii?Q?KflyvwTUGYhJaJr+4uyJ3+3d6IBgco7ACus+Pu2tYZA6NVyAjblhToCCSiAq?=
 =?us-ascii?Q?NxKbbCI6HruodXovns83AmzvYC02IEY0uRF7RpRu?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5808.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7795698d-f9ca-4a2a-d8f0-08dc32878b7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 02:48:12.1411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XXd6FTfGLRnKqm+OiiUlPtkRbU6tbApXFG3fFatdY9dLbCNRUVNrCDT+YWsN5yInlWAgMxep4UOentVNlqtlYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5673
X-OriginatorOrg: intel.com

> From: gregkh@linuxfoundation.org <gregkh@linuxfoundation.org>
> On Sun, Feb 18, 2024 at 08:44:58AM +0000, Wu, Wentong wrote:
> > > From: Winkler, Tomas <tomas.winkler@intel.com>
> > > > On Wed, Feb 07, 2024 at 08:43:04AM +0800, Wentong Wu wrote:
> > > > > Add IVSC device support on Meteor Lake platform.
> > > > >
> > > > > Signed-off-by: Wentong Wu <wentong.wu@intel.com>
> > > >
> > > > Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > > Acked-by: Tomas Winkler <tomas.winkler@intel.com>
> >
> > Thanks, Sakari and Tomas.
> >
> > Greg, could you please help take a look this patch? Thanks
>=20
> To help make patch review quicker, please help out in reviewing patches f=
or
> others.

Sure, I will, thanks for your help=20

BR,
Wentong=20
>=20
> thanks,
>=20
> greg k-h

