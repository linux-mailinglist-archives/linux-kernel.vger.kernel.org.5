Return-Path: <linux-kernel+bounces-91511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AB5871274
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 02:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7848828667F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 01:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0C517C95;
	Tue,  5 Mar 2024 01:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZsxH8pMf"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAE517C6F
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 01:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709603329; cv=fail; b=CtIZFB/V/R45ghkUmMsHYHb6VxexEwrLfhOaeV+J7qXzruNnyO35jLUynQRaGNlo+DyVWeJXZCDctApUJg8SnI1m7Tpgb2y4QBxberlpd584WQqlIk86xbhWoHzWJoW6axuwEddwCzsMrkUa6akkT75jcdW2eWd0CjBpjerbCrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709603329; c=relaxed/simple;
	bh=z9daCFsEBWialfg3PNQp/4oXetcZHGwvszP0CMAOuXs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IrUT8X5eM8VjaGjpy4g5jhTM/xHezRowOaSiyH/3gxcMS1PNR3h+8zBw0GoZT3KOS+4wOcBmQYgVj5vDk5AnwGN9ge6erzEdia9cWTvzjFmRSxdHaPGQRvIpIoMFLInrxGtPQ7sK3XJ97eiKDmDgXfJ2fwe+VHykri0xXIrYiR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZsxH8pMf; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709603328; x=1741139328;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=z9daCFsEBWialfg3PNQp/4oXetcZHGwvszP0CMAOuXs=;
  b=ZsxH8pMfpD15KoRgVEzAN+rh2PKdbf5giAgMiq+wOXNUN6lx7sz/gJwS
   ImZZZFdsy0zNgb/x8EY2ST/QNeGxrdPpxg6w8B8qzOHsDt95r+0nqjSEh
   KflCcXSPmpF/gaPXIYIReiT9+fIv/TbqaOP49qK8Rk5xqZn6U+wQON6ew
   18Ow18lNJTcbZAUgzyJyTKRfDD8SfEAjNbbEIV7/vefAMNvXlQHGsAUyl
   I5tnftoMDwymwSKxyBTu3sF4GEMAlIuBhgfKWL+jWYK1L5chXlD6aECIa
   zZKpi609xQHs+4au/DrqLGj7lhrYycI6+Tmh4RigNmueiwLLZn22GdhsZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="4010888"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="4010888"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 17:48:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="9139792"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Mar 2024 17:48:22 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Mar 2024 17:48:20 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Mar 2024 17:48:20 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 4 Mar 2024 17:48:20 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 4 Mar 2024 17:48:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bVshctjnTFIVMUVUwEM0Xk9F1wb4T2Ti5oO8dkcQnn4aFVZ1F3XRmHgHBs2rEsGKBhi2/DM77cLN7j4FaYtkNa2yNIqjng1OoDn78bjENGme6RuWsK4pQ25TNMRrI/RFWezGZup3LxN2fVrs/16oe44Ck1+S9A42GRHRqqKHJV8PgxjZY8AFPioV8rOP44lkx9sUkL3TQjoqSlmodvKIbyB5UFznZGRplj+/9UXvqWAXvtIX+YFMArhcHRT9ZaTXaZ01/IOMfWhUQ23SfgNp9jRU3JjgOoEtf1n2BjzymotbUwwkyyMljPlLWjItxH8ZmclxsIH+TH8+sCrRqJ1e1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3exoz+kGAN4SbaVgfgD86TycMZpb4IVE4LgfrEDSkbQ=;
 b=cs/qDn8SqtIMh3AnJj2mvdamCVWOxzr8LT6/aRunt0Nn1Uy5dYbDnqXVeKMXQL8w7BlZZbSjad4XHBhC+LD2mbvKOR7L/Z12fI49a8y/t+EAUiY9glWFf8v0ccaZN9ACPRqCDICYUDhW+6BXjArctjQbA3j/4xIe1iOm1HR16GEqNMEP6J7FXJH7K7rAxBUU0fd9D0HKkvZl1a/GrHpwu95A6x46SXSkYQXOLpw/aSu5zlfLpwbF1DoehdOi2SBgoAzKOgwLdzOcgAVCdTKArtQYGyjBOeL7hbO+JcuPJdoXJm32fge7u3OHIAPzP8Wba+WXrBrSRGQGZGWUdVc0mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB8059.namprd11.prod.outlook.com (2603:10b6:510:24e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.23; Tue, 5 Mar
 2024 01:48:17 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::39d:5a9c:c9f5:c327]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::39d:5a9c:c9f5:c327%5]) with mapi id 15.20.7362.019; Tue, 5 Mar 2024
 01:48:17 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, "Badger, Eric" <ebadger@purestorage.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 2/5] iommu/vt-d: Fix NULL domain on device release
Thread-Topic: [PATCH v3 2/5] iommu/vt-d: Fix NULL domain on device release
Thread-Index: AQHabp35lKyVBX8uH0CQzss8KryOc7EoYQzA
Date: Tue, 5 Mar 2024 01:48:17 +0000
Message-ID: <BN9PR11MB527680BD6A1F4E55A0DC8E298C222@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240305013305.204605-1-baolu.lu@linux.intel.com>
 <20240305013305.204605-3-baolu.lu@linux.intel.com>
In-Reply-To: <20240305013305.204605-3-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB8059:EE_
x-ms-office365-filtering-correlation-id: 53f4cee9-0995-4517-3c9d-08dc3cb65404
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I+qPxLsuLGJTF5GSY+Lx5GiE3lSl3GoP1nVU1zhME7uqLHu+2cezmrSCzHe7vyVfUHNJiHDmHG22wygc73p/N+oQI1qaPO0CX1hGCUS1UJq5FNSsTAAPdGtaQDLvBRDu6MyJNYhN7EunN+CEESkho3CJoWqaC58Q3/OG9gg7hEMXgGK3j01jWP1UV2b3f2D9lYUzJAb+TnvitufCu3Xx07/7JlGgSiZliClkooyhZ6ATgFiVeUp/2mvxcABvaaIzMJ3m6oaLAShszLR9VLA3eVsdyDERGOiHGYbrh+ZIgevelQkMVG2LLaJEjfb85F0paEatUnWtboirbU75yQkO2Z1nUAEfsCXOz6lR9QdP/PGn5m0aKesseidZHDM5DL/Qj09lGtkEoTLaLnQDlmMvypqd7DVki4P9DoLrpvozGZztdSTdIRED8wtIu594/tzwvQq9RQgFquA835+7/DQzCCRgTA6mC+CVS0tGmMHK1GqgBsDrHi55kX7zCk2c4dUo7gyQ4L5UhH70lEnwvKZi8yUP/jWbXYYjdLvjJ0iB6EM8n1pTS48R7ZP15ynwd3TOct9zRhC/1XOr6nb5oRhAJ4PRTz9HsPmaUn327DDJ5lGPKk72ZV1Rw81ErDeTMYLNTFtOfGYUASvAyIGffFTtj/hPOdoWKzD6JR4BSsljnL4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RFKUINX83rbH24ilXhVy3pKf3UTpBkCHmWeJQ7S2Z8vzKU2UoEG0+xR9M9nw?=
 =?us-ascii?Q?fMygjblRQyg9lLCXvxq24LXZTjwNwk1SJW1CJVaJQxrtVfoHnnlf3vaNhIwE?=
 =?us-ascii?Q?DtPyYskdZmTwxi8Fz4QqJaJspf2wTu3YfD2BjO1LwZ1WDQv4EWxtbId9gAko?=
 =?us-ascii?Q?Ksm9sL/WD+WYq7xCOO+5YGvgnXtZkX1gxwm/PvyyLGqjj0DPOpPpcoK2QGeH?=
 =?us-ascii?Q?9lcsql5XbZcBcDeeZJV7jHLK+CdeAk51hwcwyEpo9/Bi9vSWuSHfwaiEtI58?=
 =?us-ascii?Q?o0z9qUhDo3XsrW582UHg5jgnFZIszNkWh35A+FUX2r8E1amFKlT0Tb4PXbwn?=
 =?us-ascii?Q?TpNLLjmmC22/M590ormx2H6ZnZIVFft102UOwRD2GLLVwk2r0b1rYfOhjtO/?=
 =?us-ascii?Q?byHXbB9oKoOyOkuJxnxQ5l/sAUQDAOvK2djbAGwrporjgCRC4Y7i1gCqWs40?=
 =?us-ascii?Q?Ng8qXJ+r3ZsX+ydZpaeoJwhgN88StsmmhM8Jl4ZEJlkKx4HfFGcJBGSEE7iG?=
 =?us-ascii?Q?iDTc19dCw+9M4QXXH/pIbZ9meV3bGWTqsvzTW5KAmQizo+Wv3N7yggPIwupT?=
 =?us-ascii?Q?ci7QdiZsnZu2yph8kWAWyGAZ2sMJ6ZY9f7fy2qtsBbcy+w6XrQtmBhZ6hSZS?=
 =?us-ascii?Q?VurDp2Fb71YQGDrF7DPVtaHD6GYbcOgia4JGM5+TG2SxEdg4VwATxIJPZxQp?=
 =?us-ascii?Q?oKWB8DkElmADoiJCCdF49OwgLq0iijorwkUqwjnAu/hmK/f2zCAgHdRNWE8O?=
 =?us-ascii?Q?AwnSyw1I3tBrmawckjQuc/qc4w3fXm7P5/jTwfbkxYdmGrxQerzQv/c7QBBW?=
 =?us-ascii?Q?hvbM/IUZ32x1Asn4M4WsIoz3qrEPSO+sZ2N+wBgk8lfhSlPm/wqsZJy+inRZ?=
 =?us-ascii?Q?pZZ1eat7pblISiyFno1WFlgAOr40EGMXVt6MUyrm/XaTcRQHnBFsxsC/yzHu?=
 =?us-ascii?Q?PdsOZAsWDqDU1/K6e0c/poyvKY+D5pH2+2P++7Sy9ZnJ3OzZ2LgvLRG8rKpe?=
 =?us-ascii?Q?fOKCQzUBMSmN3oHlQJEzAnYh4mlzdEbRh0JaE+Hr35leCg7UzHaaVGxe6DgQ?=
 =?us-ascii?Q?ZLij3bIFnGnlcJS/iMQuF3h8lTpi8EKir2krY0BFVju7ZfkSeavjVSIW63NF?=
 =?us-ascii?Q?d2PwfzqdPuoAn+kxEBRluowjUR9dE+Z8r8/ryRCrlZ/S6NlaY+/Isv9MKb77?=
 =?us-ascii?Q?4gkWZ9qHVUHMbNZ5033g2+B8z6SBPf7mnLJOBNsJYYxjSanrFxSZQcKZ70qM?=
 =?us-ascii?Q?h/2agakTvpbSHrRHz8B2N3QXHz1ht6mwcX1e0pYVh3C6KR/t7k8riUCw4oOu?=
 =?us-ascii?Q?WzAL06OfZgFuiQQdwg1eZIy5VfgTZFXMmEdzTDdZXPykaJ5GXCY5KLiowWxG?=
 =?us-ascii?Q?E8XHnqhU8rbtFsp/ebO8lo2MSZDTvOBKX/DdhF1mi1NQ6+ZvRdMGnZ0sp3K6?=
 =?us-ascii?Q?hSQ5rjrtvE+kChOiHIxzj0eJeyf4TS4m1K+vy17j5M1wtWkNKOqCHUyafoe7?=
 =?us-ascii?Q?DiQ4ZiDrbSJ2IePWF7SWiIoV3r/q3Gq2MM+jkEiQXCRsUmiqcKIzRW+0u0G5?=
 =?us-ascii?Q?i2+vhmWp9XRSWOFxwotkrHQjKKoQK7vY6aEwWs5k?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53f4cee9-0995-4517-3c9d-08dc3cb65404
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2024 01:48:17.0771
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IvDr7xYKxXSrxtMeDsdwuex5866AnGl/MvCeN0B/n/afApWbPoTZig99CY6G66fYoJISgZXe5X1Cgun3HhG9Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8059
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Tuesday, March 5, 2024 9:33 AM
>=20
> In the kdump kernel, the IOMMU operates in deferred_attach mode. In this
> mode, info->domain may not yet be assigned by the time the release_device
> function is called. It leads to the following crash in the crash kernel:
>=20
>     BUG: kernel NULL pointer dereference, address: 000000000000003c
>     ...
>     RIP: 0010:do_raw_spin_lock+0xa/0xa0
>     ...
>     _raw_spin_lock_irqsave+0x1b/0x30
>     intel_iommu_release_device+0x96/0x170
>     iommu_deinit_device+0x39/0xf0
>     __iommu_group_remove_device+0xa0/0xd0
>     iommu_bus_notifier+0x55/0xb0
>     notifier_call_chain+0x5a/0xd0
>     blocking_notifier_call_chain+0x41/0x60
>     bus_notify+0x34/0x50
>     device_del+0x269/0x3d0
>     pci_remove_bus_device+0x77/0x100
>     p2sb_bar+0xae/0x1d0
>     ...
>     i801_probe+0x423/0x740
>=20
> Use the release_domain mechanism to fix it. The scalable mode context
> entry which is not part of release_domain should be cleared in
> release_device().
>=20
> Fixes: 586081d3f6b1 ("iommu/vt-d: Remove DEFER_DEVICE_DOMAIN_INFO")
> Reported-by: Eric Badger <ebadger@purestorage.com>
> Closes: https://lore.kernel.org/r/20240113181713.1817855-1-
> ebadger@purestorage.com
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

