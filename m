Return-Path: <linux-kernel+bounces-295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D48813EDB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 01:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F31061C21FDA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 00:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9318A650;
	Fri, 15 Dec 2023 00:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SkMNNbA7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB4836A
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 00:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702601507; x=1734137507;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nDQ5Me63PcFGQ0dkAjlwCCFBlFLUsiM79a5knTU73SA=;
  b=SkMNNbA7exw3tDVsbeaCdGb478uUrds8zbv3pO1VsipIK0gfnlXFLBu5
   63ZyAXRpvuxY4wJefzg/RL6pZB7dYlDMATSmZQpSjWrhh0IcyKwYcdzmL
   ScAUCjnQPIFhcQbkpLyirkXarl6totWtCcYnDxmxhRihtSwle+Gm1RuFo
   zuhKAYckqvC7AS8/aXRFvXznjDEizvCi8e1u0VrR64F1NQhD0tXRxbjZ1
   SIfZqvo3SEH3OwH/lbkcEsWx1sbK2YBoFzmDBCJqP467cgRaAdKcBLexx
   EGMj90I8ND1OW1THT9GzkB9Pao53GcWxbL4Y0T4LVv5yJ2RF7sKkWxR0F
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="392386064"
X-IronPort-AV: E=Sophos;i="6.04,277,1695711600"; 
   d="scan'208";a="392386064"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 16:51:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="892689069"
X-IronPort-AV: E=Sophos;i="6.04,277,1695711600"; 
   d="scan'208";a="892689069"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Dec 2023 16:51:46 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 16:51:45 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 14 Dec 2023 16:51:45 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Dec 2023 16:51:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lXYYQ1mEgXIlbQqmkfeBeGEu0se9ytBTBz/0CjcDR2TeD2pzDT0rSp4g7VTnhUxMYcE0yK0ObGHa/fPbM1Q1yyAQ6UuvmT6d6wMo7OX/S4JRlbVM/kfZ0UXMEjnZgZHV5OodmoSGwDw5NmPQ0GkNFLbXNHpejWxj9/skWQS1dW2YkOhUCp4OIRm25sNBAUz0Y6Hq2tkMVjfq6GQ+muvH1NatblqpHZiHIsbNNmV2rSNmDGmizPQGhHjEyK2tBCfVraYbvCEIeLzgCbjljj+YQvwjHpaQYMJRcC+vw6gBcSZ/BFCOpvUqkTzACQZ6X1Wg+wpfoIoDGOdlYGuoSpY1KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7+YKF7H06TiMMGekhib/iS65gwrxMuZILQsCH+jjFDs=;
 b=dhaKFbE1DaCCs73KZWjOEI4vCxzYMMVD7xeE8P4znUD4XZ3U+SdNFRCYifrmiWlHDZ0iwcgutvqQiC3vxNc4YS9s4k7I17fHT9nV1CiPzoEoKFQ/c6jjs9eqbFLW91j/2E1epCgeBIALwjEedp4pmQe+9x7f+pkD6tkEjJsfLy1txMtdLHhj7IFrxUxBF2YWimsjq0Q/7Hfdhoo7/VHH1UapKj2xUX8/LKSjvC63sg9KwSkuRyTQATUyE6L6lEmQYEyZIiuA0ngb7yci6yvdQt1rOaoiKLUfvx0bM1tTzEHuSOmAA9mj18OfrH8AwLeJjicqDv9LoWdBO2z2UQvNwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4316.namprd11.prod.outlook.com (2603:10b6:5:205::16)
 by IA1PR11MB7753.namprd11.prod.outlook.com (2603:10b6:208:421::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Fri, 15 Dec
 2023 00:51:42 +0000
Received: from DM6PR11MB4316.namprd11.prod.outlook.com
 ([fe80::2738:cbf0:1b80:8a78]) by DM6PR11MB4316.namprd11.prod.outlook.com
 ([fe80::2738:cbf0:1b80:8a78%4]) with mapi id 15.20.7091.028; Fri, 15 Dec 2023
 00:51:42 +0000
From: "Wu, Wentong" <wentong.wu@intel.com>
To: Arnd Bergmann <arnd@kernel.org>
CC: "Winkler, Tomas" <tomas.winkler@intel.com>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sakari Ailus
	<sakari.ailus@linux.intel.com>, "Usyskin, Alexander"
	<alexander.usyskin@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] [v2] mei: fix vsc dependency
Thread-Topic: [PATCH 1/2] [v2] mei: fix vsc dependency
Thread-Index: AQHaLrz0vFnOVTNi4EqVltp8uDeAP7CpgsvQ
Date: Fri, 15 Dec 2023 00:51:42 +0000
Message-ID: <DM6PR11MB43164A072AE0C0F8F49356A38D93A@DM6PR11MB4316.namprd11.prod.outlook.com>
References: <20231214183946.109124-1-arnd@kernel.org>
In-Reply-To: <20231214183946.109124-1-arnd@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4316:EE_|IA1PR11MB7753:EE_
x-ms-office365-filtering-correlation-id: 6c2a0288-cf2f-4369-3233-08dbfd08011b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hyBX/Fvc0hJ8xeEpLoWd6shb2HrSWgSziDxISt6dwfWE+3gLUGNBzMKwpt83Q2TpMcT5O4L6enQCsd3nlr2kApmiOK9S+Mx6efg3hsr4x417FxkRwE4/fPxdTE2vs1/nbMjx/rdDsSdVGgAhPCa1npYYOPgAo7MdW7QKVYbndSs1xtJvmA+8BL+uLfgRkXDLjF4fhKarL5ea2C0Q8d02+7VFrLSBgYnI6JSIV8HU1eX+FxyLyamrBfVVgzu3/kc6LP4HoVaOJLI7L91EGvDhDgT5MilBTLAQ3qfYuGQQQ3FqrIpU+i413ag+4gfWwReUt5geo/kkF3na3MIfn5+RSd/abW6QeXaHWe5tlF2BUk6f04V+io2KKg25Jm7xj9YfHk5uz1XxDjeEhwYc57ozMqCzR+fsN4dWfZlJT3wRN3bbSS/lPr5Xn5coLuNUVN8WItSyB+RRjHwNj5kQaNZ3M9Hmho31ry3rNX+16VbzRcz/KyO/IVEA3U8Z++0tpni6gIIu3Elu1LFDkphJSir3EweLrWWiceItqky7Z6bQMxGgxrLqY9KrS8+0AyD7HBE1Rn644ToGxBfbalGEvG7YgjRx+dv4MslCEcxjGV6YMBfdj0al+By35fm5qYrYmaEU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4316.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(346002)(396003)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(82960400001)(26005)(38070700009)(41300700001)(83380400001)(122000001)(52536014)(7696005)(6506007)(4326008)(86362001)(8936002)(71200400001)(8676002)(55016003)(9686003)(5660300002)(478600001)(38100700002)(76116006)(64756008)(6916009)(66446008)(54906003)(66476007)(66946007)(66556008)(316002)(2906002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?t+NUtCOj/vnyN5xHGipeXEEGIwpWIhSkTP88nkONACZY367pN/hr1rn4ybUR?=
 =?us-ascii?Q?owW7Z3MTVROfu2HapRjxPZvhL3wHRpOp9yF3wnBh+iEk3lr1pnwmRwLGJXI0?=
 =?us-ascii?Q?idcQz4e7r8nbP7xxqUpFpDL71bNAve4DlWWegRFCwAeZbvLi28LgnibQpXZk?=
 =?us-ascii?Q?DBUAHwTLNMqL5aky51Zvs3965ya+BmRAWEyxDQ1LZnC4MMpz62mR8rDZej3U?=
 =?us-ascii?Q?3FZ1r5SCr/5+EFrIWXzpFqJFxzyu3+GlC5T3WmKBmbI/SGBddboxUjfWc6h8?=
 =?us-ascii?Q?f0l6+rIpwrsaV0JB86HBVo73ZNWaojJo1uQWwhGlEawpthjtGvJgMDe4OPwn?=
 =?us-ascii?Q?rtytQ3pXOFdlz0+NzItrJOKGpblFi0zYKDD42BEXoB9Mbf4nbJP3HRQL9KpU?=
 =?us-ascii?Q?2FQaJ7WjG4vQvb7YLfNPDqM2LW2B+NzvNvDfuPauIpxiOwI+55h5gj647QHp?=
 =?us-ascii?Q?s9/bBbPclZ2MlPXh1Qm/lRWQbcH5Qje+FEn2ZqqmhZ8zDgm+7zWgQ1jkZ++s?=
 =?us-ascii?Q?nmpgz4nVvbJBg1gBVXRZx9nkp+pQKE82Msi6OwMOewzk33TwzuilWAkLAkXi?=
 =?us-ascii?Q?FB2+wwafr0lWMuEV+OBAMWz+Y2YgWnqkJBpkMqEipObrSiGMYGbtJuaLfhOY?=
 =?us-ascii?Q?qwRtiepdoxFZwQXxPmBCjZmgJCz88goYsEGKwhndD0bQbTGH50n0Xupm0J/Y?=
 =?us-ascii?Q?uAQk/fbWPr9fz8N7nbEpRekUFcG+TlpcK4xg1gVVWYFWUaa0OX1L1ToVe9wd?=
 =?us-ascii?Q?bIP9QG+JNe3dNf8rXa1q+2a1sbc98iepMte3BG+DVFEy+j9BTrkdI0kwzuOB?=
 =?us-ascii?Q?DpxyYYtIfONRnc0ul5npVq/ukeE7/OCSsc9j33tv45+eZcE8dVPu+8U9VenL?=
 =?us-ascii?Q?76xQoSlLjnSW2egHYp/zCZ1qwtpfBS7ElzqF38bvRoDmCWEq2xQxnrsOokRJ?=
 =?us-ascii?Q?qMlzbFRs51AiCaXiXk2tm1eNhpSYpJMWmAIEfJFlQjPeotRJVP9Ec0E+I52f?=
 =?us-ascii?Q?1mmuu/dqMoeWjzRAbo+d1G/pgN+Ic5NoC0YH/c6qsc17C+Kf5mD3Eeay6cy+?=
 =?us-ascii?Q?gWLxMY9FAXO6xNRKTJQXjQTYplPOO4kzrdE6EI2u1HvQicKfz93CkJuwOe/B?=
 =?us-ascii?Q?iU1vTAy0/OtHs3l691E2J2ankb/I7sgc796/bawiYqMCmajduczpYWM3xoWt?=
 =?us-ascii?Q?e9AUEO4jOWXG2i4hyA883notTZUxvCT/AjHduDkUzL4HKTlc0fRS1ep4XMtR?=
 =?us-ascii?Q?SgVgKULxUM8rsEEM+DHkUJluFgrDe7HYnAbnnzuhqAzRv7BtrPH2irf6g749?=
 =?us-ascii?Q?fo7Uj/GgKk5DT4o5KpF445Fc5tMYL7sYu24vyhEXmxSjiKbuUwIz+sP7dtRJ?=
 =?us-ascii?Q?g1XFf7HaZhfYVhS+bl7mIjwZvhIdpPNvEDCbzEYEDLNEiD2MPpzbuvcw3VKU?=
 =?us-ascii?Q?DqptbxhSb0o/nopIdpr2JcDjvblh1wVeKoS4mT/FQpm3K1NyJDvnf5C/W32c?=
 =?us-ascii?Q?IXWAykaY5y/Z/qO2DZRJmakjel7/MZhuLknbVFhGeMzrqywBVBVWZUwi7seG?=
 =?us-ascii?Q?5wuwcmDKD+KQsNqh6lFddjefsjlYwZVu0qB1exaf?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c2a0288-cf2f-4369-3233-08dbfd08011b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2023 00:51:42.2592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nPXgyJAGUifGj2mICsavDBh0GVUjuuWS+VdHCxfaEg6+R2Nf6K/fGs7bYhaCmdOUUTY6i1zjgPc3lGoXPFEDRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7753
X-OriginatorOrg: intel.com

> From: Arnd Bergmann <arnd@arndb.de>
>=20
> CONFIG_INTEL_MEI_VSC_HW can be set to built-in even with CONFIG_MEI=3Dm,
> but then the driver is not built because Kbuild never enters the drivers/=
misc/mei
> directory for built-in files, leading to a link
> failure:
>=20
> ERROR: modpost: "vsc_tp_reset" [drivers/misc/mei/mei-vsc.ko] undefined!
> ERROR: modpost: "vsc_tp_init" [drivers/misc/mei/mei-vsc.ko] undefined!
> ERROR: modpost: "vsc_tp_xfer" [drivers/misc/mei/mei-vsc.ko] undefined!
> ERROR: modpost: "vsc_tp_need_read" [drivers/misc/mei/mei-vsc.ko] undefine=
d!
> ERROR: modpost: "vsc_tp_intr_enable" [drivers/misc/mei/mei-vsc.ko]
> undefined!
> ERROR: modpost: "vsc_tp_intr_synchronize" [drivers/misc/mei/mei-vsc.ko]
> undefined!
> ERROR: modpost: "vsc_tp_intr_disable" [drivers/misc/mei/mei-vsc.ko]
> undefined!
> ERROR: modpost: "vsc_tp_register_event_cb" [drivers/misc/mei/mei-vsc.ko]
> undefined!
>=20
> Add an explicit dependency on CONFIG_MEI that was apparently missing, to
> ensure the VSC_HW driver cannot be built-in with MEI itself being a loada=
ble
> module.
>=20
> Fixes: 566f5ca97680 ("mei: Add transport driver for IVSC device")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks

Reviewed-by: Wentong Wu <wentong.wu@intel.com>

> ---
>  drivers/misc/mei/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/misc/mei/Kconfig b/drivers/misc/mei/Kconfig index
> 858bd701d68c..1e28ca23a74a 100644
> --- a/drivers/misc/mei/Kconfig
> +++ b/drivers/misc/mei/Kconfig
> @@ -62,6 +62,7 @@ config INTEL_MEI_GSC
>=20
>  config INTEL_MEI_VSC_HW
>  	tristate "Intel visual sensing controller device transport driver"
> +	depends on INTEL_MEI
>  	depends on ACPI && SPI
>  	depends on GPIOLIB || COMPILE_TEST
>  	help
> --
> 2.39.2


