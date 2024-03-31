Return-Path: <linux-kernel+bounces-125957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4947892EA1
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 06:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 597EF282310
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 04:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D82B63D5;
	Sun, 31 Mar 2024 04:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cas2xeq3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDF96FA7;
	Sun, 31 Mar 2024 04:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711860740; cv=fail; b=mBD0WBUr5Regj9xswbj+dbyAh34iSPP7+yBli2FzQc4VnRQkyMoayrOoL6ueyxfUH3wNvUAvNNvFGz4c2bxnvXrLM3XmkYiii+cn9WDoCPp3A1iD6TxwaqhqpCgk4Dtw6xRSf65htobJmfqgeUt93XtvHpjZ4/uTQHhlIMUHhVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711860740; c=relaxed/simple;
	bh=1245MyKWdVfLwajvBieL7XtlsB58ck6/DBL4zcV/r3A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Jx7MBVbrF6IuHLVppi1YOEhU2EHOTGXZKAqgOoVxJaUHojQPZ0D3gkhawJH8KHtq1W6LV8QzRAwQcN+V/eEz/MDZjHTUJ9q5hsusgaAwIR7VmA84vdLspFrgS+LNXV8BwujiNf5I4IFLrdh4413TFWltU3Fzj4AaNMtR6wZb2Mo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cas2xeq3; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711860738; x=1743396738;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1245MyKWdVfLwajvBieL7XtlsB58ck6/DBL4zcV/r3A=;
  b=Cas2xeq3iqJCWLri8a2TCRTOGdFAODQErSrfAC1f5oGQ11YvVzKF99hx
   F16OT64HFOxHOfl9Ef6EMI1L5Z0ZV8ObSdc09IvAPl1Xjaz4skGDGjgCo
   spnVwDVSU9n6m7rcObRHK29IFu683IDJuexUKraNf97YUEBGcbx+xspYq
   6qdhkiBnhOzYsF4A9af55Zbsu69iNSTf9W+L6MoksTKDSwHxSu0xKGL5K
   qSw/b08KvSfyPvRk46u7i6Y00AOgbtKOiaDPZX374Jn7NfTH7Vpy1SZgx
   FL7yv9lAfCN8OPdqBllFR80R0bj8lMFjWtnGqyF5msReWd7BTaxTo9Adk
   g==;
X-CSE-ConnectionGUID: B18CKVAMQ5i4MJngUmROAA==
X-CSE-MsgGUID: V/lYWF0hTGW52Zhf4R4HQw==
X-IronPort-AV: E=McAfee;i="6600,9927,11029"; a="6896164"
X-IronPort-AV: E=Sophos;i="6.07,169,1708416000"; 
   d="scan'208";a="6896164"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2024 21:52:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,169,1708416000"; 
   d="scan'208";a="17189604"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Mar 2024 21:52:18 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 30 Mar 2024 21:52:17 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 30 Mar 2024 21:52:16 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sat, 30 Mar 2024 21:52:16 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 30 Mar 2024 21:52:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nKfUqDfB/VrMbfOksax4GnbvGKbLof+oycc46jmvuO1YX8dtx6huSJwf5cvpPEiUJ+LbsbqHULVbMXQ9fWZpwWOBF5TJ2ciXYhB105yN6Qsq8D5iBVFwocR5qgZDW1g371yLddSDbkZCOEVAMV6oOcKtLUS/85xDujBjxfstRU/yqhNHZz5wginjoK6aZjYBlaXpAcxNp0A2wyOmt1/HAbd+mhc+c0h9SgfIG7dCmDjhBajoWqycQ263kOM53VPnxYUHOT9OHqYz3dzdtkK+mvgliBTsk4UMyCH6uqFbHbrvNa1/Qo04wH/OL5tfy1mGbtTTg19i8h6rAkew8iTq0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2w/MohsOxPm9h4ZQciexnP1P4zaUurlcLlakaqtzOLA=;
 b=oNsa7uqmFyVT23UVeF2LQzZ28WR3JaH/alFq8n6C1xTyX4kVhL6N/1FDUdm9j/F9aLvqC17SPB0zVcEnwD86J/DGSPbXc2lAKoqbmlY+wcDhXW/v6jNfa8lM3WNBOPe/s8kIFZhV2n+Ksmq7D2j57YLdjYNk4ZatgLerWFr8fT+6ndVnhixvvzXMxumycWwX8zH7tSa9M1y8rlpssLGOQ53vnkUmgVA93/VYFBxhZH4W+3C8VSHaW1G7xDbM2/LUI4+LHSEuyw6MvaLvDy8fq+WMSqG3HQpaPveZi/HEJn7fgSzpDKM5C5Ncn+yr0y1awaNhzPb3PdVU6g/yGr74Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10)
 by PH8PR11MB6976.namprd11.prod.outlook.com (2603:10b6:510:223::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Sun, 31 Mar
 2024 04:52:14 +0000
Received: from PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::d6c2:e80d:7256:8a15]) by PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::d6c2:e80d:7256:8a15%6]) with mapi id 15.20.7452.019; Sun, 31 Mar 2024
 04:52:13 +0000
From: "K, Kiran" <kiran.k@intel.com>
To: Werner Sembach <wse@tuxedocomputers.com>, Marcel Holtmann
	<marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: Christoffer Sandberg <cs@tuxedo.de>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Bluetooth: btintel: Add devices to
 HCI_QUIRK_BROKEN_LE_CODED
Thread-Topic: [PATCH] Bluetooth: btintel: Add devices to
 HCI_QUIRK_BROKEN_LE_CODED
Thread-Index: AQHagRJtjB3I30JBLkySJS/7E0PyG7FRS7pg
Date: Sun, 31 Mar 2024 04:52:13 +0000
Message-ID: <PH0PR11MB758500838CD30B3F0BFB8397F5382@PH0PR11MB7585.namprd11.prod.outlook.com>
References: <20240328131800.63328-1-wse@tuxedocomputers.com>
In-Reply-To: <20240328131800.63328-1-wse@tuxedocomputers.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7585:EE_|PH8PR11MB6976:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bc1EmvHNBzlTklXn3wXfeEzHQVUBFiXg3QPa0se9V/xxf/ddxPlLvrPCiX34xCgKzoVD/A+M2n7PrdxNDLvFsdphPed2OV6Er4ekPJvRg/wH+UqwG7bHJg8wvAk9pY6tzfEp2gUnEUJ5idFO3v2QEexa56R9UyyD8imt2dK5on80wE1q9uohQFbkcQIuttB9x+SfAm1emSHGh7z/QShaXsuKmZbcwG1eGvIOoQLu1dxaAOrl3o/lUBGGeTNfbaoirfkGLuXkXOH0FoYDl/J1SQsgUC4ixhcOX5lr83i3YTzdD86pJNM8GDZmfeiu13AFpH1/aFTf4Y4Ul9xBgX+l8uIzvXhwanDx4s+6RSjvmfqLrecHZHlCZBR6wPZ72EBwlJtLRKN9RbElLHjLIK/jn2yMqNTK7Vut8jMODkzRIuxKdYUOyiU0DHAoPSy94gmZAzxnXHuUWRxZVlBbVXore2Ew5grs8g6VXzXIcbcjUV4BzXm+whMDv8i9nvt+uOip39yim+KnFBseRmrjAcfrjWxAB6iRw5MvzQX+3uAPAgbGyWY3IpKAxI9Y5y336shqySmcFNUf6OtqwjS8lbnS2AvgsVOrHufyk4stCzpjO0EgykB7N6aQK6mk5Y9OfKiO8Y7SLbr0T0nSyAkwLiX9y4qbizYG/PTFzg+nOnoCFhA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7585.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RWWOipOhaKiQ3wap2WiT1T9n/k0pGeN9emEmYf4nNlnCPzMFwbDbq3FnZwYF?=
 =?us-ascii?Q?7FB605f26QfQEQ7cKjK5CaWT0C7sdq8LXnbFms7h1TOf0yV5oVzlnaHitlUx?=
 =?us-ascii?Q?R8WrCo72KmW44EQ8NFJqI0XE4n3XJZ0edOLXYBgcffFbo62RGX60VxLsLe81?=
 =?us-ascii?Q?+HODr43x//qKQjGEQaw97dfYAyL0/3Y8Qjj8XtyYaXc4DoVjS+Yha55tTc21?=
 =?us-ascii?Q?ZiNYbOEB/7NDjCUAEjIHZtbhJ4HTRMGE7CIr1SutR6+a1sUyQxudIjNJfDFz?=
 =?us-ascii?Q?16T5zNDZe/u5HVRZK3AWqOzCvFPa15VVifwzGginBeL+p0NHGh3OgZoF54Wj?=
 =?us-ascii?Q?MhkbXkWfl5CdyZKIEml7LDJ2WThE+0tulKcTHrEN2STgnb2dop2kxsqweL4l?=
 =?us-ascii?Q?ugysRTJekLzQa09R3OggJMrRX78pw1W/XoArfPk6/yWnA+Mp/iOgzJwrhM75?=
 =?us-ascii?Q?OpB/n7wyMxqUgCvoHbzK3TpktqBji+9PENUOK9HxNs093q7Y1CFsT/V45Bdp?=
 =?us-ascii?Q?NG/Wi4jsw1SA0r7mIhxQ6Qd+L0IcGWTwIObfW4Tt5WugPz/7Z+gAzvNL7/Fx?=
 =?us-ascii?Q?D6e0sJ6OUEUsOloA2KmsyjjhfvTiqtlClPQMoGaKlk/acHS6AXRx6ExxPYW0?=
 =?us-ascii?Q?vNa5mxGfSDSgYb7YPYaHHRZypTp8ZiaF8ny/XqHjtHBE9EJHX+9ikil1EiOU?=
 =?us-ascii?Q?zNftazMG/IQ17f5BrfyMLkdwQRLn+ski0gDeXNS+zKSn9mIVKerNCWLHldeY?=
 =?us-ascii?Q?zTKflMqbmX60JP9WUJDtSyhYCarQYacyXSYfe6fpQCz+tVdBneLA2cmN1bRM?=
 =?us-ascii?Q?USzywFdoDE0ORc+vJEqgJdQeEF5PtyI7AU2ViZDCDiXZgcZ7Cn6DLXsiWhI+?=
 =?us-ascii?Q?UHj2R9zJbu4QJEX6khh7NNEfe8HezItnfvIGx1iLATElM25Nd5MePY/WasTy?=
 =?us-ascii?Q?r/oE/Zii1e/RZynv9ccBRnU2rMhjJLjl+GB4uiFgZw0qHtgC5Cem+hETZ5VH?=
 =?us-ascii?Q?5MzcRZel6IMmm0ZlpLi7aIlURxagrOjU27zjJzHppB8u3sQ/9l2tGykvFxIi?=
 =?us-ascii?Q?zTL6E4X250seO8xKaXg0JcKpRuQf/zKLjvceVH4Fc1GgqEC8hjmbzAt6Xg2N?=
 =?us-ascii?Q?fKmh4KBWHkHMnxLpvojn4QoIII3It10t2RTF0kQ3Jkr+RlO3PD7F1TnW6dVX?=
 =?us-ascii?Q?A3lO69MnSwq5RWP2jEYHLOS3aENTUWHEl6v+w7KIHeqF3J22lFImV9sKYAhA?=
 =?us-ascii?Q?vDoe2Jr0p+djh2VDfUfie3oohLzSjeQS5QwjZfmhJ0tN0qSISFvSAU/ULX0L?=
 =?us-ascii?Q?l11+DPbk391e2nYq5LLgwfuYES+K5Qa4y3WOmCu4ZQhtgee1nWUlLRgV865w?=
 =?us-ascii?Q?UM8yi43uqX1V/zwhzyf2UYgoz504Cr7KgaVO25AuaFwjHjO69aeB1bnnyk0m?=
 =?us-ascii?Q?gWpg09C3noVzResCB92wX5hP3y2+GzOhJM/uQKdjSyHJk/OXti35pfFL22hs?=
 =?us-ascii?Q?+EZrs2dc35ZWzZRtg71rghQz2182R+MbhH9FhStFzYnu0RIQaNHe1m2vjWgq?=
 =?us-ascii?Q?RnB4FW/wbRR8w1+e2Es=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7585.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da702966-9ab8-4cef-bb3a-08dc513e54ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2024 04:52:13.4127
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1ngI/qRtj4EzZKZ60mLCp5NbgHAPITPAN+N2IPFeOoiF9JQBRd12FdRtrAaAtgbRqGS4zjS6N7NZg7LD3+FIpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6976
X-OriginatorOrg: intel.com

Hi Werner,

> -----Original Message-----
> From: Werner Sembach <wse@tuxedocomputers.com>
> Sent: Thursday, March 28, 2024 6:48 PM
> To: Marcel Holtmann <marcel@holtmann.org>; Luiz Augusto von Dentz
> <luiz.dentz@gmail.com>
> Cc: Christoffer Sandberg <cs@tuxedo.de>; Werner Sembach
> <wse@tuxedocomputers.com>; linux-bluetooth@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [PATCH] Bluetooth: btintel: Add devices to
> HCI_QUIRK_BROKEN_LE_CODED
>=20
> From: Christoffer Sandberg <cs@tuxedo.de>
>=20
> For HW variants 0x17, 0x18 and 0x19 LE Coded PHY causes scan and
> connection issues when enabled. This patch disables it through the existi=
ng
> quirk.
>=20
Do see this issue with latest firmware ?  Can you please share the firmware=
 version you are using (share dmesg on system boot) ?

> Signed-off-by: Christoffer Sandberg <cs@tuxedo.de>
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> Cc: <stable@vger.kernel.org>
> ---
>  drivers/bluetooth/btintel.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c in=
dex
> cdc5c08824a0a..6dbfb74d0adf9 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -2881,6 +2881,8 @@ static int btintel_setup_combined(struct hci_dev
> *hdev)
>  	case 0x17:
>  	case 0x18:
>  	case 0x19:
> +		/* 0x17, 0x18 and 0x19 have issues when LE Coded PHY is
> enabled */
> +		set_bit(HCI_QUIRK_BROKEN_LE_CODED, &hdev->quirks);
>  	case 0x1b:
>  	case 0x1c:
>  		/* Display version information of TLV type */
> --
> 2.34.1
>=20

Thanks,
Kiran



