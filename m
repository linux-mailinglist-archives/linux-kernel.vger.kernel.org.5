Return-Path: <linux-kernel+bounces-596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A47C581435D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 09:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D082FB20AB6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78DD011723;
	Fri, 15 Dec 2023 08:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HhhBZjnq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BBF11192
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 08:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702627917; x=1734163917;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tVfno1fn4LuJCmS/xRb6Ji150GwcSheAY4uaN5345hQ=;
  b=HhhBZjnqyLIlI4Lti+xjO2X59A43hJ2EORLZ09aVOx9JFF37zI7FLlTA
   Or78LmjZ96f60++at3l14vTnCzcWyO8Vl4QQ3TMQOrBBJOg4XEC45Tb+m
   WFIH/sgLFQ9xJGfJBMp+BvAciWMowZF6ZWU2YsTPm/T/BtjyialIYieae
   fu9k0SqbL6xw3jDzAsOPYWS3qylXcHKDzDUfzDAGmrSgwSTPd7FBH4Sft
   jn9/ewn1/+gBGPxm4MfXFYLUeVaMioU1d5PxFXRdC7whBnUYOadr3zFVn
   uTEUlyycZZVWlNInH0zkn0U56cYmxpc2YGqKk51O3iC8fevxNYfot7wdQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="8658006"
X-IronPort-AV: E=Sophos;i="6.04,278,1695711600"; 
   d="scan'208";a="8658006"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 00:11:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="840585427"
X-IronPort-AV: E=Sophos;i="6.04,278,1695711600"; 
   d="scan'208";a="840585427"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Dec 2023 00:11:56 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 15 Dec 2023 00:11:55 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 15 Dec 2023 00:11:55 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 15 Dec 2023 00:11:55 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 15 Dec 2023 00:11:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cPrP/29V+Ac/WoDe3zmu6NUg4VggQ5xieOF+nxw9FVM0WAc79GexcVYea+0MK9PfT5TBTQF3UPdvW1cIkRkdF/BcfAKTc7kEhnmRhTw979OcK+H3NHAgq7fCuiy3PzihgfZs8iPyYZZAq/Gn3a2UZwC5u0grD6jY9cEHushbroVTFfYlS8FgCtFed9QjTuzu+g8nedUnzq0/RUpOKuS2oYkmFzeakYecTKHf6TI5jhKhiNDinFPuUumqMDlRp1CzgIbbLvOmqy9WTSZfOFudTB88Jvnsq3o7citYuj/IgoJ/OOuG23nwh+7ZIISarT3ADKFdcWwZ4vdOeUHt/LUauA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jI8Mwu58TZZ1wemaFnZZyUyq/HerofTRHsMlyvFUmBY=;
 b=ETcm7f/lVJkqBOz5rUAYuEgmyq3fW1Sn+uPvAYoMyI6uxlBHe/ZzdakfqF6m/NSZf7FVOmu1lnRgiynbkWg1olYJ7AeHFXOkoj4ZeU0kSVjG+yUf/cQQFID0RjmigQbqaBq/gcIY4FI6LJ6c8gMbx7NYkE2//m0dJRib9IrBgHIm4btCxDLXF5pB1Mx3cIw7r8AeQNhxSOEm0pAcRb+YXkHh30KAar6JWQWPBvjTBqYeIzmtsx/AQ39TihnshclMTiznU/pRBgSQqSd6ZVewHiMdKss23uR0U7ZdOr2IP6zfNvzTKUfCrP7Hp8yMdxv0Feg82qu3FR2V0oVfzwNv9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4316.namprd11.prod.outlook.com (2603:10b6:5:205::16)
 by SA1PR11MB7014.namprd11.prod.outlook.com (2603:10b6:806:2b9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Fri, 15 Dec
 2023 08:11:51 +0000
Received: from DM6PR11MB4316.namprd11.prod.outlook.com
 ([fe80::2738:cbf0:1b80:8a78]) by DM6PR11MB4316.namprd11.prod.outlook.com
 ([fe80::2738:cbf0:1b80:8a78%4]) with mapi id 15.20.7091.028; Fri, 15 Dec 2023
 08:11:51 +0000
From: "Wu, Wentong" <wentong.wu@intel.com>
To: Arnd Bergmann <arnd@kernel.org>
CC: "Winkler, Tomas" <tomas.winkler@intel.com>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sakari Ailus
	<sakari.ailus@linux.intel.com>, "andriy.shevchenko@linux.intel.com"
	<andriy.shevchenko@linux.intel.com>, "Usyskin, Alexander"
	<alexander.usyskin@intel.com>, "Teres Alexis, Alan Previn"
	<alan.previn.teres.alexis@intel.com>, "Ceraolo Spurio, Daniele"
	<daniele.ceraolospurio@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] mei: rework Kconfig dependencies
Thread-Topic: [PATCH 2/2] mei: rework Kconfig dependencies
Thread-Index: AQHaLr0G6pwygARoCUeUOjB8AQesH7Cp/ZkQ
Date: Fri, 15 Dec 2023 08:11:51 +0000
Message-ID: <DM6PR11MB4316DD6B97A68DD07DCBC40C8D93A@DM6PR11MB4316.namprd11.prod.outlook.com>
References: <20231214183946.109124-1-arnd@kernel.org>
 <20231214183946.109124-2-arnd@kernel.org>
In-Reply-To: <20231214183946.109124-2-arnd@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4316:EE_|SA1PR11MB7014:EE_
x-ms-office365-filtering-correlation-id: cbf88ccb-55ad-44f2-c3a4-08dbfd457e66
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: syVYiclnS+UpYtxSVaWBxaPoh518oE0dG9rP4vkw+p4pM6FA9d58ZsHyup7h7bWTXJvpYJeUC8kWK9w3+GLfHA6Mwkh9bUJOLEuKp0wMQG84QLANQAolcltA2dHrMJc+3RwBIVPxRpCH4OKeWg8Afl+nZBwOYaLY9z6Sas20saS9GB+dMQSaLuGwL2etqpDfvo816CHzx4Nyd9YCymzNwIboaLB2pXUWTkrqeBllyKjbf4XD9wpN06rSwewDuohoxq7AQCCcRrBzI7xUQ2ov9YNNiDPqEPSfW/GJl3g/n712nY7CS/7Jq0gnKI+Cuv364UClFyF52r+FXlshbXqSRPFEfQM1eYeyMlIfqNZhgmfB/xcSIhxUY3P6HunNsQZmiewBTp+8SW0YsRMYmsE4Ges/eeIjqYhNWgy9yq/KKb365/E1EujwqPPzJey7HPnmNpZYvXj8yRSQ9pM7zeNKSnGpRVdZJ2iec2wDLgVRkwPSIRssKI3/KxttnCL3ER12EXaFg8JywJhTzz85kYLwGAgUEeroZ6yRFBOMXpI2pm4m0M5xELs2sgKcR+M3xSpxwIbf7PaeK+znTbjdXWlKbLLi7dsdzaQviRHY+xXcYZo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4316.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(376002)(39860400002)(136003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(86362001)(38100700002)(122000001)(52536014)(8936002)(8676002)(2906002)(5660300002)(82960400001)(33656002)(83380400001)(55016003)(316002)(71200400001)(26005)(4326008)(6916009)(54906003)(66556008)(66476007)(66446008)(64756008)(66946007)(76116006)(41300700001)(38070700009)(9686003)(478600001)(7696005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kg5/WkmK028F0YZ8HUX7n1iJ2c7QDSNJAyeeOrpsFqoS2bNiRYZcQOe/rl5j?=
 =?us-ascii?Q?1GacZHD0z5NN4Q1rdW5CLP02EcKeTvduoan9dM3T08SkAV2H0P9YEBf3K3i/?=
 =?us-ascii?Q?gxOPRv5W1NAj4Or8n5H1mlYJPjjaQmArA2DqH2a1LtW9pGAiAS/kloBhYz+T?=
 =?us-ascii?Q?cN9jl4c/9jLh++234d/p+2I1ONBx64udBRB9LTIUDiPNsk8yVs59NU4tTIyj?=
 =?us-ascii?Q?HEcEBwCvUJqXgLb1R6YtHD2PCVNzaLo2qCWo/PNoxasnayCug1a24tGDgysn?=
 =?us-ascii?Q?8N/QkgPQYBsvRpmQXMHQDlRXO0nrxGgC5WzO5QvZZpDbheYx6/zlTS7pJK6S?=
 =?us-ascii?Q?3yS5cp94Qw+/fZRLFi0L+D+QlKMQYDWLujPS6yTSCNZzy1BCaZ+GBSOMZPSf?=
 =?us-ascii?Q?TOJ94MC7WK/twQ0icryu6wRwG3DRAGKodLtn8bvJXh0uM6tk3XLJc0j6o5Ly?=
 =?us-ascii?Q?4GqaTQRR95aKcOq83upB/wBM6GPLOViujb4dBSi61qXeXnZzcfziwjkvDQxV?=
 =?us-ascii?Q?TDxah6/mEC/8AbM/ITyhQ7Pr+ARJ02b+Qp3G8b5s8mioze0Wvb+euahkfpKd?=
 =?us-ascii?Q?C8GMFG5s3JggwiI3zTBLiUe1QlMDLxdwDnWMQAvaKX3faFOYyXtwNl2d+zSp?=
 =?us-ascii?Q?G3eGZOwh+D8o7OBaCS9W8BQLIaEty31thDb2/EvabNTVrqr5t05Kv3yPcp+c?=
 =?us-ascii?Q?hVXw5y7/vBbz3gJWUog42ZBFLLOu9nmsCK4+cLgvgt91iaYv9/N2HHwR6T2d?=
 =?us-ascii?Q?1XGsVYsEnr1lCx4txARrpxXOgF/muPbZo3T7KQUaE1EoWIrd1mxDoDSnZ96y?=
 =?us-ascii?Q?f/U2qNtRrseED1rkU4zwGuiuK26p5ciKTG+7sQVxR1QHWpY5YlQ02MrJUH7K?=
 =?us-ascii?Q?sD25xP83jx3quDn3r5DkZkgaf0Ddvu5ijIZLcLsOCDe29hYp6T0q2O+V7TSA?=
 =?us-ascii?Q?MUuDNJ23wkjCS4TudixF6d7PT6cF1dAqZFAjPAC0Zo6w9ebM5EHzk0zWGQA5?=
 =?us-ascii?Q?VbNzGKKmSxzhpZaFgRzzKbihItqlSUTDEbURkLcYm1uODxgzXTnDZnSs6oMa?=
 =?us-ascii?Q?tSBGpYzym/JOyn01HpTMJsSO0KbXDOEyoRZbSkPqUMifAFUzQfR3GBNaamX6?=
 =?us-ascii?Q?gU0rCtV+bz1toMJNz/747oXYxonzvOJa6WrsDRfEXtZnPxmEE3T6vVH+sLoI?=
 =?us-ascii?Q?4mJGxQBIqFnv8icHO9wbMTw9kfNkLUYH0knrA5xAa8b792yZN8hSzdeQdrvc?=
 =?us-ascii?Q?SZg2keLiNCjpeZ8uaN5U8DP2mrWZhw7XgBG8bkL32bssYzhUkDpktKMpW4no?=
 =?us-ascii?Q?j6xTt9eKd922XFeiE1vECO6cxbsCKczUZ3MqVYxRFedUcbn+HiVFiRWn/paB?=
 =?us-ascii?Q?hyjIFClWK/9YZlHDBwaB5vjrLknLTeOe08aFvWbHfaL1CV1rdAL+lnWjiZ+S?=
 =?us-ascii?Q?iDJGONmjYaAEW3yjyBUzrI64K35Vd8vVR2TcfVjkorsmrddK2FdL9S8RsvDd?=
 =?us-ascii?Q?hWvGd560MTpHrIgOjlOjHgWhu3dAv2KJqt1iQYBFMIep7tKCbVlV6lddigIB?=
 =?us-ascii?Q?G2hScibhwBFzWJoBLbMLETmn7ayhv5VoeA8STzsG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4316.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbf88ccb-55ad-44f2-c3a4-08dbfd457e66
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2023 08:11:51.7870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G/n+3SHO/kbn7b0SAdBeRWa+dErayKstQ45F75YWdgi0OfOLxEDW5TvrrETmFaaMOuEos7HqZ8PO6zZUaFKGdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7014
X-OriginatorOrg: intel.com

> From: Arnd Bergmann <arnd@kernel.org> Sent: Friday, December 15, 2023 2:4=
0 AM
>=20
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> The dependencies in the mei framework are inconsistent, with some symbols
> using 'select INTEL_MEI' to force it being enabled and others using 'depe=
nds on
> INTEL_MEI'.
>=20
> In general, one should not select user-visible symbols, so change all of =
these to
> normal dependencies, but change the default on INTEL_MEI to be enabled wh=
en
> building a kernel for an Intel CPU with ME or a generic
> x86 kernel.
>=20
> Having consistent dependencies makes the 'menuconfig' listing more readab=
le
> by using proper indentation.
>=20
> A large if/endif block is just a simpler syntax than repeating the depend=
encies for
> each symbol.

Yes, I agree it will make future changes more easier.

Reviewed-by: Wentong Wu <wentong.wu@intel.com>

>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> This does not fix a bug, but seems like a sensible cleanup to me, making =
the logic
> less error-prone for future changes. Feel free to just take the first pat=
ch and
> ignore this one if I missed an important reason for the original variant,=
 or if you
> prefer a different method.
> ---
>  drivers/misc/mei/Kconfig           | 14 ++++++--------
>  drivers/misc/mei/gsc_proxy/Kconfig |  2 +-
>  drivers/misc/mei/hdcp/Kconfig      |  2 +-
>  drivers/misc/mei/pxp/Kconfig       |  2 +-
>  4 files changed, 9 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/misc/mei/Kconfig b/drivers/misc/mei/Kconfig index
> 1e28ca23a74a..67d9391f1855 100644
> --- a/drivers/misc/mei/Kconfig
> +++ b/drivers/misc/mei/Kconfig
> @@ -3,6 +3,7 @@
>  config INTEL_MEI
>  	tristate "Intel Management Engine Interface"
>  	depends on X86 && PCI
> +	default GENERIC_CPU || MCORE2 || MATOM || X86_GENERIC
>  	help
>  	  The Intel Management Engine (Intel ME) provides Manageability,
>  	  Security and Media services for system containing Intel chipsets.
> @@ -11,10 +12,11 @@ config INTEL_MEI
>  	  For more information see
>  	  <https://software.intel.com/en-us/manageability/>
>=20
> +if INTEL_MEI
> +
>  config INTEL_MEI_ME
>  	tristate "ME Enabled Intel Chipsets"
> -	select INTEL_MEI
> -	depends on X86 && PCI
> +	default y
>  	help
>  	  MEI support for ME Enabled Intel chipsets.
>=20
> @@ -38,8 +40,6 @@ config INTEL_MEI_ME
>=20
>  config INTEL_MEI_TXE
>  	tristate "Intel Trusted Execution Environment with ME Interface"
> -	select INTEL_MEI
> -	depends on X86 && PCI
>  	help
>  	  MEI Support for Trusted Execution Environment device on Intel SoCs
>=20
> @@ -48,9 +48,7 @@ config INTEL_MEI_TXE
>=20
>  config INTEL_MEI_GSC
>  	tristate "Intel MEI GSC embedded device"
> -	depends on INTEL_MEI
>  	depends on INTEL_MEI_ME
> -	depends on X86 && PCI
>  	depends on DRM_I915
>  	help
>  	  Intel auxiliary driver for GSC devices embedded in Intel graphics dev=
ices.
> @@ -62,7 +60,6 @@ config INTEL_MEI_GSC
>=20
>  config INTEL_MEI_VSC_HW
>  	tristate "Intel visual sensing controller device transport driver"
> -	depends on INTEL_MEI
>  	depends on ACPI && SPI
>  	depends on GPIOLIB || COMPILE_TEST
>  	help
> @@ -75,7 +72,6 @@ config INTEL_MEI_VSC_HW  config INTEL_MEI_VSC
>  	tristate "Intel visual sensing controller device with ME interface"
>  	depends on INTEL_MEI_VSC_HW
> -	depends on INTEL_MEI
>  	help
>  	  Intel MEI over SPI driver for Intel visual sensing controller
>  	  (IVSC) device embedded in IA platform. It supports camera sharing @@
> -88,3 +84,5 @@ config INTEL_MEI_VSC  source
> "drivers/misc/mei/hdcp/Kconfig"
>  source "drivers/misc/mei/pxp/Kconfig"
>  source "drivers/misc/mei/gsc_proxy/Kconfig"
> +
> +endif
> diff --git a/drivers/misc/mei/gsc_proxy/Kconfig
> b/drivers/misc/mei/gsc_proxy/Kconfig
> index 5f68d9f3d691..ac78b9d1eccd 100644
> --- a/drivers/misc/mei/gsc_proxy/Kconfig
> +++ b/drivers/misc/mei/gsc_proxy/Kconfig
> @@ -3,7 +3,7 @@
>  #
>  config INTEL_MEI_GSC_PROXY
>  	tristate "Intel GSC Proxy services of ME Interface"
> -	select INTEL_MEI_ME
> +	depends on INTEL_MEI_ME
>  	depends on DRM_I915
>  	help
>           MEI Support for GSC Proxy Services on Intel platforms.
> diff --git a/drivers/misc/mei/hdcp/Kconfig b/drivers/misc/mei/hdcp/Kconfi=
g
> index 54e1c9526909..9be312ec798d 100644
> --- a/drivers/misc/mei/hdcp/Kconfig
> +++ b/drivers/misc/mei/hdcp/Kconfig
> @@ -3,7 +3,7 @@
>  #
>  config INTEL_MEI_HDCP
>  	tristate "Intel HDCP2.2 services of ME Interface"
> -	select INTEL_MEI_ME
> +	depends on INTEL_MEI_ME
>  	depends on DRM_I915
>  	help
>  	  MEI Support for HDCP2.2 Services on Intel platforms.
> diff --git a/drivers/misc/mei/pxp/Kconfig b/drivers/misc/mei/pxp/Kconfig =
index
> 4029b96afc04..838eae556dd4 100644
> --- a/drivers/misc/mei/pxp/Kconfig
> +++ b/drivers/misc/mei/pxp/Kconfig
> @@ -4,7 +4,7 @@
>  #
>  config INTEL_MEI_PXP
>  	tristate "Intel PXP services of ME Interface"
> -	select INTEL_MEI_ME
> +	depends on INTEL_MEI_ME
>  	depends on DRM_I915
>  	help
>  	  MEI Support for PXP Services on Intel platforms.
> --
> 2.39.2

Thanks
Wentong

