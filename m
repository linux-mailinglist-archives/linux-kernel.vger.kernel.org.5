Return-Path: <linux-kernel+bounces-75994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D4E85F1B7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECF661C22AE0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 07:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D912917743;
	Thu, 22 Feb 2024 07:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HXo8kNGP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387BAA47;
	Thu, 22 Feb 2024 07:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708585436; cv=fail; b=tFqwPmhF8HBN1joRiVs4QylOhl88rKT3A0j6Uu6h4QvstejO3iGPZUcIRUENYhRilf0e3Z3IdmIfzMdSvUA6dftheVxur4x1sKtl2J15coeJuPVqx/Wehiu4+cGGHdeP8fIe+5LYoJitCRAOl+MOIDQBLEXs7WrMPA2/oMfiXTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708585436; c=relaxed/simple;
	bh=xkFsfdwTo7LXa+TTdUdPApwzYYxabKLIEo3Q5l07Ad0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RhZ6B9+FzhGSjdvXWi7dhKWmCHnOHKl8rxA6GgybXcyLPEolcLmnUWDW6vVMPRjZDygYCrYCsHiBiB9MP6fsaqX/c2VBmdzNyG71+TteAjp0aNdXdkBmPX8g+Y3Q08ed7Z8wPqFfcZTqGnB+1ny8OFtWYxLghPDrBTi1YmVEKmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HXo8kNGP; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708585435; x=1740121435;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xkFsfdwTo7LXa+TTdUdPApwzYYxabKLIEo3Q5l07Ad0=;
  b=HXo8kNGP1s/LTheqpHLcuNjekuSRCxyKi/Va84sZSFfiAWf/X4b/Z+0x
   nIJPs9hDIo9E3ns6dWFpUX+6fLAR/fDTVcLap7g3PaFIxs6ierAe+dLbc
   uNrY8EPAq4HXS1zlSNbWR9ytlvgmJ6/xx7PDA6kjQgSo6gPTQ39euM5mf
   wcCm0X5KMaTUEsixyi2JFri8DQrd9z77LW14Gy6ZjTHx7POm5ocSfu5uL
   m+GAelrIxaiypLP7t15x3fDx8JElOawE/R0Gt7RlslQd9wD9DLtJcszcj
   Rte+NOyru3HTr2B14jBhL/PXsXEC4kd/E1C/OoD/RMdM5L+f33jFXjxwq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="20342845"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="20342845"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 23:03:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="10080581"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Feb 2024 23:03:54 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Feb 2024 23:03:54 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Feb 2024 23:03:53 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 21 Feb 2024 23:03:53 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 21 Feb 2024 23:03:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Foze7x8X43GI1MHbVU+Z+yPWEackm6ZQiv6yZTzCQq2ch2gqZfeqvYSQHNo5VxJmgb4dYSJpZTYNlZ8NgYoJ1XuVqJ7wGE4NSl/DqnLS5k03gDwwK4tZtqCWTDYp34GMjbVs4BBH0V9UHYPCtG7h/KQ8r28RDNmcFmk4HdloPPUcKZfCpatFSvYV7umfAHDlArdtoCXgFb+X+W9UwtnSBYWEgN+Xn0CRvBBVjV3559ZAChE9iwLJsDaQfa3F5WkDa4f96+IWmiBeCY4KBuBmnRJ5Ypp7Syur1+gsINe1XUQgMhfzhf45H3VCpTEbuAPVGOpnSTzzijMf5Ugf7Z/Afw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LNxBOAjFUcXdHlaNDF4FGMT0Mop78ksFi0yVuC0VXOI=;
 b=ePoX0vUpQdz0dJm9cwF+weJV+uqPiEWrm1jFRXJHUA/ubV70qLbe5dRYqYfUOm9xyuDSr0s3BhPlNwe89yIYnOxJfHLS0OiFX3jLx4LmPaxhZdHIfXaWOlmONoJr+WoDkfM63SE8gw71ELwQOX0iHpTU9GWgFb7yi5IKOt8lBXsw2amGRQRg6ksvGtEu0urDLRzcZNk1Ey4XruWk3PuaVWHofT6OsomZ1+C/GWQ8mtzQ38Nh4zP0RHknOlFueQ0naJuRR0l82SGrvvP4BY7jgyXS4EyP1oOlxASKHAj/1iqssU7u8N1xlEJ8EYs88/toyYwJT5X0WYAD0zS9hWusVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5787.namprd11.prod.outlook.com (2603:10b6:303:192::7)
 by MN0PR11MB5962.namprd11.prod.outlook.com (2603:10b6:208:371::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.22; Thu, 22 Feb
 2024 07:03:51 +0000
Received: from MW5PR11MB5787.namprd11.prod.outlook.com
 ([fe80::9b79:ed7c:6689:13fd]) by MW5PR11MB5787.namprd11.prod.outlook.com
 ([fe80::9b79:ed7c:6689:13fd%6]) with mapi id 15.20.7316.018; Thu, 22 Feb 2024
 07:03:51 +0000
From: "Wu, Wentong" <wentong.wu@intel.com>
To: Ekansh Gupta <quic_ekangupt@quicinc.com>, "srinivas.kandagatla@linaro.org"
	<srinivas.kandagatla@linaro.org>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
Subject: RE: [PATCH v1 00/16] Add missing features to FastRPC driver
Thread-Topic: [PATCH v1 00/16] Add missing features to FastRPC driver
Thread-Index: AQHaVaLTQb0BbylwmECnc+VpaWctyrEWDpxA
Date: Thu, 22 Feb 2024 07:03:51 +0000
Message-ID: <MW5PR11MB5787AB2459CBFB0DF1E43BF58D562@MW5PR11MB5787.namprd11.prod.outlook.com>
References: <20240202064039.15505-1-quic_ekangupt@quicinc.com>
In-Reply-To: <20240202064039.15505-1-quic_ekangupt@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5787:EE_|MN0PR11MB5962:EE_
x-ms-office365-filtering-correlation-id: 0e8e83cc-e7f4-4dcc-02da-08dc33746cb6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QvU3vzlUKAma4vh0GdsabfR4FjTIkzmkXS0+3eOW3PT/mscjaegg2PMnWX5xcp4iFfFFnprN7YEOQBUcswz7Sif7G+O2uKI0rVvCkb+C1mnC9oN4GALG7TXYyicYBg+nmaYauRVrn55c1AZ01YA1pVfD7kIGb/udx9cCI1m4f3k1LjYDOqv0XFCgPsljHGSz2UKEtOqn5aUs0PsMFAzVnn+0UUe5DGtCnPyLcdDx+WlGKRTGVBsd2rMhA4RGTPKoYrHdlZ3Lw/4xCC7n904u17Ehb0J2Fi2NV9VbJvWMt/YfzfFf7hJD0UtSBUbVmGEFE8L4Qb4VOV2JEWfe4FPtohpPfead29xW85IXiPzR1ajhb4qvwwmgEZMuA35tfXFBhekZKGYSiz//bOFSzQQlwJd/TJIoG+NiaDm6WovtAcPhz3mI4nf+hO2dq1r1+Z7LLU9dXbGsmOAu3HGFPWfF/txb+0io/A8ngv25oUKwLiYOGX9CQDRyp7adi7J+Mby+cUTqA4yunmLmg28Uws5TWP7QA4AnxD4FapCy5BSio1or0f/hjCLp/B7kju3cRb5HlFJJrzfFWpo8KigIcgMDP/w8OQZLvAv7l2KcPO/QBbDJO08TqCjOMohyHehYptsJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5787.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4o8BbvP+bE3eB3AKY7uyVq2iVJlHYShCQJCnV7qZARsqjvev6IyAdZQn8FQ7?=
 =?us-ascii?Q?SmLF2/CJonfKvqqv1zN+2RXzbnKiUeAHamcnGAAG3mIMQgdZds4vq5w7jZPx?=
 =?us-ascii?Q?ZbY3YSeZLt5Xt2XP069vHaRSkqyyh5manX8t/WMKWDUxSyhgeVePk4hTXcVW?=
 =?us-ascii?Q?BsTUa21qoIppXw7zOFlkhKmrwXQC/cT1nGW/SivCDjQB9M3TXcdeO/kWANO0?=
 =?us-ascii?Q?iM5SCcPA2oJIF2DE2avgQCHEY/MeggGPb95bJhHXQiSZk+DvljX48aSDvDPE?=
 =?us-ascii?Q?hbAZkBJSqB07h/0V7cAGtu7CDGTXBqpKsdRptuUYPOy2Luc5t1Qeg4jSWOqd?=
 =?us-ascii?Q?G1c2PmZT5zQfVWnVrPPMf1n9GEzk9nVK5bi2fAFzHibnhzqeXxRgwPFf50tp?=
 =?us-ascii?Q?3VQT2+Y0W5RerITKvqaILoH4UBrGr8sj/B1gWERVBFaT+2V7QZx0VGnghy1m?=
 =?us-ascii?Q?96CgeWaRsCtRYuzLMvzBrERJqwalmbqoVJhqR2qKfXPRBNKween2Ech1iFQV?=
 =?us-ascii?Q?r4BLUpSmpF0jpCVkhhQn8yXk1XmW2zsJpkZcK9Q8kj5jrlQu5VvFO9ZS8NCe?=
 =?us-ascii?Q?t4Bbs8DuG3fYamw3N4Qu2t/6/63cyRT1IG1vdczoU7V+fqCdhNvR+edbhf5w?=
 =?us-ascii?Q?Xu0BELNetCVFVxnO3c0ckgVzYRHyM0c9VY6gtz5nUtV3s1XtWDtbR89xHhn0?=
 =?us-ascii?Q?GzOoID4TFTJ5D7gwsMwKLnHUP6WeW4S/4btDJn/riUX1iianF3zwcINgX7aD?=
 =?us-ascii?Q?M55cIOJYpC9xo/60jhIt9Gf9S7Y3aMWJDZUbV1cGIDYtRjlYF7g4N3n6Dlou?=
 =?us-ascii?Q?mv+m5Ceo8ZzVwMqepCEQwtgGghSOrPKVEnkmHGv4TJ3gOqVAvgv2/8uTYcjj?=
 =?us-ascii?Q?yYtmbvldcaJMQRCGHmH5ViFCeM6bzVVLW4jrs6iaXE2I7lj+eM2LLVxHnxTj?=
 =?us-ascii?Q?fT1paQOlH/ZvLntQvhpa4cCIZ7/U6Q5Ifg+8v89w1Ua/MKB7WFu0hX+DFb1i?=
 =?us-ascii?Q?sPn41MMeU6RNMm+zKEB6e2JCiKeu6z1Y6YX0mjKgrPXg0FROI18O5OsihgpL?=
 =?us-ascii?Q?8f5ul7MIKFAvdzbxyUr8oWdoiGLF7azPUf8ptSVNq9gePe6EduspaqFEZ/fM?=
 =?us-ascii?Q?Ak+ca9P7IUSwkoHbdrSrb8kyObNvv+yFgYVOCrRoz5Dwc2xor3gfsUghzZRu?=
 =?us-ascii?Q?3gAaA/xPfIbmElSkgu5NwNFNAj1ds/U7cJtD9LcHJbbSaYr/bc+JNQIBCB4q?=
 =?us-ascii?Q?slnW/6YZdQ/Ouc4z9waHwZ2NhmY9R3Dz1RalD2P9g1BvA5BaZMWthwQomNKe?=
 =?us-ascii?Q?U3GsfDUwkSO3Yi8Ele4ApkTQk/jq2XoN4u0QeQpYWTvmpkCeryU0ZMi9qqh0?=
 =?us-ascii?Q?a8uopre7xQOZv0H7bNLQGzzV+Pwm2lJnMejeBAoX8d6qScEj6QupDjVtNMAD?=
 =?us-ascii?Q?RAYEPb5K2SARs5BUmLC/lDHEO2v+TgqASNVmWw3syZsiMzurU8NS1TX8xTw0?=
 =?us-ascii?Q?rXzVw77zpNvx5clhJgvE/g3FTc/TsVIoSBKdbxC3HqGES2EzI+0mLlHJDSle?=
 =?us-ascii?Q?NYhEx9ebDAvlc5L+I3NIaxORxtS4UYzPxb5pQVxp?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e8e83cc-e7f4-4dcc-02da-08dc33746cb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2024 07:03:51.2463
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IWVNXDXW4hpgXeRJeFCG8jBWO2/15fGKh+LRMopKOLpR3SXsqknp9nbGKjFLF0fiG3BOT8BU0JI0WFMaRN+kHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB5962
X-OriginatorOrg: intel.com

> From: Ekansh Gupta <quic_ekangupt@quicinc.com>
> This patch series adds the listed features that have been missing in
> upstream fastRPC driver.

Thanks for the patch, and is there any latency data on driver side?

BR,
Wentong
>=20
> - Redesign and improve remote heap management.
> - Add static PD restart support for audio and sensors PD using
>   PDR framework.
> - Add changes to support multimode invocation ioctl request. This
>   ioctl call facilitates multiple types of requests from user including
>   CRC check, performance counters, shared context bank usage, etc.
>   This series also carries patch to save and restore interrupted
>   context.
> - Add early wakeup support to allow DSP user to send early response
>   to CPU and improve fastrpc performance.
> - Add polling mode support with which driver polls on memory to avoid
>   CPU from going to low power modes.
> - Add notifications frameworks to provide users with the DSP PD status
>   notifications.
> - Add a control mechanism to allow users to clean up DSP user PD
> - Add wakelock management support
> - Add DSP signalling support
> - Add check for untrusted applications and allow trusted processed to
>   offload to system unsigned PD.
>=20
> Ekansh Gupta (16):
>   misc: fastrpc: Redesign remote heap management
>   misc: fastrpc: Add support for unsigned PD
>   misc: fastrpc: Add static PD restart support
>   misc: fastrpc: Add fastrpc multimode invoke request support
>   misc: fastrpc: Add CRC support for remote buffers
>   misc: fastrpc: Capture kernel and DSP performance counters
>   misc: fastrpc: Add support to save and restore interrupted
>   misc: fastrpc: Add support to allocate shared context bank
>   misc: fastrpc: Add early wakeup support for fastRPC driver
>   misc: fastrpc: Add polling mode support for fastRPC driver
>   misc: fastrpc: Add DSP PD notification support
>   misc: fastrpc: Add support for users to clean up DSP user PD
>   misc: fastrpc: Add wakelock management support
>   misc: fastrpc: Add DSP signal support
>   misc: fastrpc: Restrict untrusted apk to spawn privileged PD
>   misc: fastrpc: Add system unsigned PD support
>=20
>  drivers/misc/fastrpc.c      | 1949 +++++++++++++++++++++++++++++++----
>  include/uapi/misc/fastrpc.h |  112 ++
>  2 files changed, 1844 insertions(+), 217 deletions(-)
>=20
> --
> 2.17.0
>=20

