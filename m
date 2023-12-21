Return-Path: <linux-kernel+bounces-8790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F5481BC58
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 299F31C240F7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB9A5821E;
	Thu, 21 Dec 2023 16:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I9CrHcoY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5014F20E;
	Thu, 21 Dec 2023 16:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703177450; x=1734713450;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HGosPVuQ0Z/ek73AsVn3Z1XhHrrh1BQyx7iHuxp8TSo=;
  b=I9CrHcoYfTCsPsEOEvqDg0r6ZKF96QQNdYAZq95k5v1jXpGfPyxq71TQ
   5l2+YODq6h34HIdRxynup6gpBHtJJFQxBeHkMby2Slnmn5iZqgkGBfc/h
   GCldFqDF4Y1vfmkt5ponGRuPgIlTbs10OSxMrRSrZpMuVm9XY9yQQ8FDY
   595nmf9w9yvuh9k/5WdmuKg8FMgOm8m8IrGw3bfi4BcZNhJS+SP8d1YtH
   Pvp6b68jpZtOoWE1BgC1WPBUzAe/RkXCvSRWEvD+zAs4+RzbRWyPG5IZQ
   CTbHsIEUSfTd3VSGEMlg6DaO0T9ZEmO3rVlbzUYKPKi26s4V76RWaveZe
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="386426903"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="386426903"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 08:50:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="770003870"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="770003870"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Dec 2023 08:50:49 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Dec 2023 08:50:49 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Dec 2023 08:50:49 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 21 Dec 2023 08:50:49 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 21 Dec 2023 08:50:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CWb1VsIpJ1+rj4c5hWhdO61MmUFyYtvbs4Dh5LvsdOVO2aMMsp83Rp+kReZ1Jgh8ZP1J5tc0IbgIh7TnDrx8njJDBV1t1GdW+BaU63SGpRyYIt/nyMDxEvjMPnp0gubTc2ZAZXDLXT7EoldDWyMC3iGUxQGx2bEWsetgb1VeyZpd94wIIDtjdchqwMiUYdO7cFvWQ+u0o11iF3DYWuZfyt/FqA/KyK0j20GpXmgsLYwveFSt2FefOEVdqUvSyAZTwuv/ayNvE3XZpAqdGpJSgpMAKIeDV3GOCi357QgL1i3Hfv2QFgiw2z5kXVpuqSK+8NqS62liw+3tqWXYMQa6KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HGosPVuQ0Z/ek73AsVn3Z1XhHrrh1BQyx7iHuxp8TSo=;
 b=eVPd63pEGrt/jAvVcPNrr99bwwAHwhGdZki39n7bkBArM+YkN6GxazFJyj0IDM9HEzdnMlLWjBT3yspXVVNVTPJ0vJ3OYvmT/m/XB1lyWKlylvqPzd0bn1c48RLQOp3skHP1Njg2lyGiqJ/ydkdZSMZ3NYc9ID1kJAQGr/kJt2pPqRqJInwIudhbaylC5+h+yaLCugsBPL5g+Sr8v9PTgInlL0ayqafLbK1Kd4cQbKSmYciFgZ55FtE58jqWSm7BhAC77rJ6MpyMLhgpJOC6n5QMnZciVCLR7ZmUxdO413vfLaKRIoxo1ybwmbrHXjpRm8bAkAebbaujtbF3C5fReQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5483.namprd11.prod.outlook.com (2603:10b6:408:104::10)
 by DS7PR11MB7859.namprd11.prod.outlook.com (2603:10b6:8:da::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Thu, 21 Dec
 2023 16:50:44 +0000
Received: from BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::6da1:a4b7:4771:14e1]) by BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::6da1:a4b7:4771:14e1%5]) with mapi id 15.20.7113.019; Thu, 21 Dec 2023
 16:50:44 +0000
From: "Chiu, Chasel" <chasel.chiu@intel.com>
To: Ard Biesheuvel <ardb@kernel.org>
CC: Simon Glass <sjg@chromium.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Rob
 Herring" <robh@kernel.org>, "Tan, Lean Sheng" <sheng.tan@9elements.com>, lkml
	<linux-kernel@vger.kernel.org>, Dhaval Sharma <dhaval@rivosinc.com>, "Brune,
 Maximilian" <maximilian.brune@9elements.com>, Yunhui Cui
	<cuiyunhui@bytedance.com>, "Dong, Guo" <guo.dong@intel.com>, Tom Rini
	<trini@konsulko.com>, ron minnich <rminnich@gmail.com>, "Guo, Gua"
	<gua.guo@intel.com>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Subject: RE: [PATCH v7 2/2] schemas: Add some common reserved-memory usages
Thread-Topic: [PATCH v7 2/2] schemas: Add some common reserved-memory usages
Thread-Index: AQHZ8LGvpttG6mvEz0WlU57NBrVnTbB0GT1wgAEi2gCAA4/1oIALktuAgADzAICAABvkkIAABCKwgAr4SACAABVGMIAj06wAgAAR7BA=
Date: Thu, 21 Dec 2023 16:50:44 +0000
Message-ID: <BN9PR11MB54837EEB391CC2A8FA6C0BF5E695A@BN9PR11MB5483.namprd11.prod.outlook.com>
References: <20230926194242.2732127-1-sjg@chromium.org>
 <20230926194242.2732127-2-sjg@chromium.org>
 <BN9PR11MB5483FF3039913334C7EA83E1E6AEA@BN9PR11MB5483.namprd11.prod.outlook.com>
 <CAMj1kXFG92NpL7T7YocOup0xLKyopt3MnSCp0RL8cLzozzJz7A@mail.gmail.com>
 <BN9PR11MB548303B09536EB1577472029E6B3A@BN9PR11MB5483.namprd11.prod.outlook.com>
 <CAPnjgZ36t8g7E=0MSJyaV8-QKv9RVYe47Jd5E=NU-mFM4LWBQA@mail.gmail.com>
 <CAMj1kXHAEeK7x2f13k_JV3Xcw61nNLasyvXQf+mKwKekQ48EpQ@mail.gmail.com>
 <BN9PR11MB548334E0DA6495C438FBFDE1E6BBA@BN9PR11MB5483.namprd11.prod.outlook.com>
 <BN9PR11MB548314DDE8D4C9503103D51CE6BBA@BN9PR11MB5483.namprd11.prod.outlook.com>
 <CAMj1kXHbM+ArLgNZgnmiok4gOfv6QLYxzyB9OCwfhEkJ2xGK_g@mail.gmail.com>
 <BN9PR11MB5483C2FBCD07DE61DCCDB523E6BCA@BN9PR11MB5483.namprd11.prod.outlook.com>
 <CAMj1kXHmu=ykgBMRiFqG4_ra3FJtHa=GASoMUJswdMFa9v4Xgw@mail.gmail.com>
In-Reply-To: <CAMj1kXHmu=ykgBMRiFqG4_ra3FJtHa=GASoMUJswdMFa9v4Xgw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5483:EE_|DS7PR11MB7859:EE_
x-ms-office365-filtering-correlation-id: 5b298432-2998-4bc7-b910-08dc0244f926
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y9M22/91Jw3isR2AILdNx2hGP73KqqyFpgAQGD8Sb9Qq7j2bb/WyyH00UZCoA32guZXAzFdGJ1a86SfjyOpu1PT2bk5TH+rz7QB/uCMsr3Rs3XBYBBvdD6h08SmMNZxLBadSFQRGKM+HnkAxTnOxGQw1G9IaQ15UOz1o6U8ThedZ07a0TbJ2MzEtWJaPR52S91FcpkenXzLsRGkjfCDkEdg/LcAe/qNAbumL4nmOFdtxTDA2dD7tn+uu8Z2TsX98JV9rdrJ2EP5tliqGB6yiBSEiNcA3tHSZlhR7dSSFhqcUFmM3122B9x590fYb7ziHOmJWTN+DUJp/92AbkXF6Ha0P/LyHdh/7+8OPqtL+Z3facr781BpO/WC6T5NAnH/wnXDeCa86qtbb7KLQFadrzjAnH09uGGhC0T0COWK8IUV9Vq0CAjZ3nBG52+wR2rVlHxoGBanukzVBxXplz/Papj5SsmzXigX1Oee/Pw7eptWKc8k20Fdioo4b7Ac4CgVcvm+yPvhN7slqwAr2KNcFbvtkQG0ADlxdQEEjpB8CSv47lQuU8AnkaT51fuZnylN11XNEiWpMhpqI8nmhGl5ZqEqdREf7qxcv5hwXTnlmH4g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5483.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(346002)(39860400002)(376002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(6916009)(8676002)(4326008)(8936002)(966005)(26005)(2906002)(478600001)(316002)(52536014)(54906003)(66446008)(66946007)(66476007)(66556008)(64756008)(76116006)(71200400001)(6506007)(7696005)(53546011)(55016003)(9686003)(5660300002)(86362001)(83380400001)(38100700002)(33656002)(122000001)(7416002)(38070700009)(41300700001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TDVtR3QxMlYyMHdaYkhyTnJaMEFBL2FyMkd4bnFJcGlpZTRPN1l5NkZBZFd5?=
 =?utf-8?B?SWs5VDdDS3JpMDRTQmpzL2FOSEJXVjZSMjByWUVYRlRiNk9KaE1RRE5EZWNZ?=
 =?utf-8?B?TlZwMzZnL2paem1hd2tSWWx4OGZ5ekRJZHN0blIwdVJaU0RpZEREUmZ1enZj?=
 =?utf-8?B?U1ZEMWtBRkloUnFvY2JFRnFXc0J0ZGlzRXFINDNxSVZRcll2R0Q0aWZKNm1a?=
 =?utf-8?B?MkVMamJBQ2dkdkJYVU9JQUp5SjJ5MEZEZW9jN0FqM0JIUUVUNk82d0NCSlNJ?=
 =?utf-8?B?NzJzb25WcFFYVWNNTFNkYlRxVCtJZFBPUm0yWm1FaklUVHZFNDJ6eE05Q0dn?=
 =?utf-8?B?WE5mbml3VXZnU3VjYU9vY0Z5UFNaZXJCTGlXRnY5bTQ0WG5iTkE2eC9NVGd0?=
 =?utf-8?B?dHkzcG8vU3FzVVZmV0JqenJnZWdiY3MremtxNGYvcmFkOHgwRFVXQkF5amJi?=
 =?utf-8?B?WTlaamwwV1pZSWx2V2g0VkMwRXFmeG5BT04yUlRCcmtTMUdEYU5yclc3Mzcz?=
 =?utf-8?B?L21ZdXFOTlBFcVF5T3BoOWYvL0tVUlV0aU1GMzQyKyt3NCthbllJYkM0NFBn?=
 =?utf-8?B?alhmMktEVUZFRmVUazhmWXBXL3Fwei9JRmZuN1VsRjExWnErOXlKNjJSeUVv?=
 =?utf-8?B?QVVZUWdZYTE4ckhzU3BMZHJMRHgyKzRGNjR2amNnNDByUjhSekFTVWJTZC9t?=
 =?utf-8?B?aTFzYVdFcE5mWC9iWk5DOUVBY0Qva0tnbE5ucFZjZDFsUmlDQ2pmR3VpRUpq?=
 =?utf-8?B?MjFxM1lhaUpVZXdKWHJ3ZnlJQytnOEd2bXJraDJWK01qajdtVUtRQ0ozRGNm?=
 =?utf-8?B?Ly9oMWlzR0Y3NXUxVUx0RjFxeVRqMVV0b1lEZU55dUk4V0FjRjJVWnp3WUdY?=
 =?utf-8?B?d3pWc3ZuQTd0SE9VQ01iU1A4U2QzREhLVy9OYUhVcGJaQ2FIbnJQNkh1TnRh?=
 =?utf-8?B?eTJMaC9QcW5FQVFocVY2d1FzaUlhdHFrQVFzWXFZQ0daTXdLUmU4Zzlid2dF?=
 =?utf-8?B?L2x5NmRpRlJiQWNBUmMrYmNyYnoyWkcwZGlBangrakRGU014RnNFQk10RXRP?=
 =?utf-8?B?dmNHWnNmWUowSnk1UWtqdDA5ME5saUdlQWRWRGNYVklCMzlRaHR4bnhZYjhX?=
 =?utf-8?B?c1dyK2swc0VJdDJpR2hMTUxTTHU5L3dYR2hNVC9RRFZEejdjbTlwNU5GQmNn?=
 =?utf-8?B?QTZXOEpoQnJEY1VZbG5HRlpQRGpDc3lTWEFKNFZZMkZOcmFCbnFaZ3VkRnBI?=
 =?utf-8?B?Y2t2NXl6U2JZN0NBQzVZTzhWR0MvdUhBdVFXQjh0SkpXNE1odURBckliOC9w?=
 =?utf-8?B?VlFaRjdXTVVSc01VNk9mRnN6WVBCdFlTUDJsMVVjR2tRWnZvQUZYeWp3U29U?=
 =?utf-8?B?aXcvcVpXZExjUjRTV1JQc3NTaGlxdjVkT1FUcjlSOU05aUVUN0h5Vm1xZklS?=
 =?utf-8?B?ZTgrSUtoM3pveGxrT0tyK0F5dWp0MTMvZEI5VDZpazY3R2d5Ukk2WHBNUFZa?=
 =?utf-8?B?ZWphMFRrQVpZMHg5MityMFZRekNGTkF5OXorUnpIeXhKQVFScEdWditXREUw?=
 =?utf-8?B?cWpmdnFGcWttb1kya3pjT3lTM1pFVE1OYXdZQVRGc3RhMWdPMTk0bW9iK3lD?=
 =?utf-8?B?c3J4ZjNKaVBMY3NxYWJ0NHZWZDlEZWlqTWExVjlFL285dDByd1dWQTJSM3Mz?=
 =?utf-8?B?cGNERFEvZVJ3Nk45cWRSTXhHMk45VlA0YjFWTDd6YUNRcHBnVlZPRHgxYW5L?=
 =?utf-8?B?VkV5UlROSTI1eG5yTnIwaUI4NlUrSFp2L2ExMmJEV1luRW1PK1dlV24zMGcy?=
 =?utf-8?B?WkRYNmk2TlRzSmYzc09hK1R1VDVCU0Q0dEhFdTFVKzcyL2RZb2N1a25BdGNV?=
 =?utf-8?B?RTBuanJvZXJhcEVNRG5aRDBQTmp4VUtFVXZzY080OExCdkJuZEZXT2xPYXJV?=
 =?utf-8?B?ZUU3QVpKWGZobmt3eDl1eFdhWGV5SU85b1hBN0k5MWEzM3I0RHBIL3lYdVJE?=
 =?utf-8?B?UWs2ZDJWUkIrcjJrRG5hMlZ3aHkvTlFxZUtidXpFNUdDbEhoZ2hOczZINWFo?=
 =?utf-8?B?Y0h0dVVOaUVOZGRBMHQzRWg3dmdmMDhWL0FTOTNqVFRCa3piM0ZMRGlJbEth?=
 =?utf-8?Q?87cACjajqJpASLmIaKUGzkQMR?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5483.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b298432-2998-4bc7-b910-08dc0244f926
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2023 16:50:44.0510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3LXD1i6EmRGGSNGFJet4EzZo2jN38RUdYMFOX/WEhREHdDPCgAtvVNINMIrSDz6l2qXXpMNAnNotdcvHPF7sqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7859
X-OriginatorOrg: intel.com

DQpIaSBBcmQsDQoNClBsZWFzZSBzZWUgbXkgcmVwbHkgYmVsb3cgaW5saW5lIGFuZCBsZXQgbWUg
a25vdyB5b3VyIHRob3VnaHRzLg0KDQpUaGFua3MsDQpDaGFzZWwNCg0KDQo+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFyZCBCaWVzaGV1dmVsIDxhcmRiQGtlcm5lbC5vcmc+
DQo+IFNlbnQ6IFRodXJzZGF5LCBEZWNlbWJlciAyMSwgMjAyMyA2OjMxIEFNDQo+IFRvOiBDaGl1
LCBDaGFzZWwgPGNoYXNlbC5jaGl1QGludGVsLmNvbT4NCj4gQ2M6IFNpbW9uIEdsYXNzIDxzamdA
Y2hyb21pdW0ub3JnPjsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IE1hcmsgUnV0bGFuZA0K
PiA8bWFyay5ydXRsYW5kQGFybS5jb20+OyBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPjsg
VGFuLCBMZWFuIFNoZW5nDQo+IDxzaGVuZy50YW5AOWVsZW1lbnRzLmNvbT47IGxrbWwgPGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBEaGF2YWwNCj4gU2hhcm1hIDxkaGF2YWxAcml2b3Np
bmMuY29tPjsgQnJ1bmUsIE1heGltaWxpYW4NCj4gPG1heGltaWxpYW4uYnJ1bmVAOWVsZW1lbnRz
LmNvbT47IFl1bmh1aSBDdWkgPGN1aXl1bmh1aUBieXRlZGFuY2UuY29tPjsNCj4gRG9uZywgR3Vv
IDxndW8uZG9uZ0BpbnRlbC5jb20+OyBUb20gUmluaSA8dHJpbmlAa29uc3Vsa28uY29tPjsgcm9u
IG1pbm5pY2gNCj4gPHJtaW5uaWNoQGdtYWlsLmNvbT47IEd1bywgR3VhIDxndWEuZ3VvQGludGVs
LmNvbT47IGxpbnV4LQ0KPiBhY3BpQHZnZXIua2VybmVsLm9yZzsgVS1Cb290IE1haWxpbmcgTGlz
dCA8dS1ib290QGxpc3RzLmRlbnguZGU+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjcgMi8yXSBz
Y2hlbWFzOiBBZGQgc29tZSBjb21tb24gcmVzZXJ2ZWQtbWVtb3J5DQo+IHVzYWdlcw0KPiANCj4g
T24gVHVlLCAyOCBOb3YgMjAyMyBhdCAyMTozMSwgQ2hpdSwgQ2hhc2VsIDxjaGFzZWwuY2hpdUBp
bnRlbC5jb20+IHdyb3RlOg0KPiA+DQo+ID4NCj4gPg0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogQXJkIEJpZXNoZXV2ZWwgPGFyZGJAa2VybmVsLm9y
Zz4NCj4gPiA+IFNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVyIDI4LCAyMDIzIDEwOjA4IEFNDQo+ID4g
PiBUbzogQ2hpdSwgQ2hhc2VsIDxjaGFzZWwuY2hpdUBpbnRlbC5jb20+DQo+ID4gPiBDYzogU2lt
b24gR2xhc3MgPHNqZ0BjaHJvbWl1bS5vcmc+OyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsg
TWFyaw0KPiA+ID4gUnV0bGFuZCA8bWFyay5ydXRsYW5kQGFybS5jb20+OyBSb2IgSGVycmluZyA8
cm9iaEBrZXJuZWwub3JnPjsgVGFuLA0KPiA+ID4gTGVhbiBTaGVuZyA8c2hlbmcudGFuQDllbGVt
ZW50cy5jb20+OyBsa21sDQo+ID4gPiA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47IERo
YXZhbCBTaGFybWEgPGRoYXZhbEByaXZvc2luYy5jb20+Ow0KPiA+ID4gQnJ1bmUsIE1heGltaWxp
YW4gPG1heGltaWxpYW4uYnJ1bmVAOWVsZW1lbnRzLmNvbT47IFl1bmh1aSBDdWkNCj4gPiA+IDxj
dWl5dW5odWlAYnl0ZWRhbmNlLmNvbT47IERvbmcsIEd1byA8Z3VvLmRvbmdAaW50ZWwuY29tPjsg
VG9tIFJpbmkNCj4gPiA+IDx0cmluaUBrb25zdWxrby5jb20+OyByb24gbWlubmljaCA8cm1pbm5p
Y2hAZ21haWwuY29tPjsgR3VvLCBHdWENCj4gPiA+IDxndWEuZ3VvQGludGVsLmNvbT47IGxpbnV4
LSBhY3BpQHZnZXIua2VybmVsLm9yZzsgVS1Cb290IE1haWxpbmcNCj4gPiA+IExpc3QgPHUtYm9v
dEBsaXN0cy5kZW54LmRlPg0KPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2NyAyLzJdIHNjaGVt
YXM6IEFkZCBzb21lIGNvbW1vbiByZXNlcnZlZC1tZW1vcnkNCj4gPiA+IHVzYWdlcw0KPiA+ID4N
Cj4gPiA+IFlvdSBhcmUgcmVmZXJyaW5nIHRvIGEgMjAwMCBsaW5lIHBhdGNoIHNvIGl0IGlzIG5v
dCAxMDAlIGNsZWFyIHdoZXJlIHRvIGxvb2sgdGJoLg0KPiA+ID4NCj4gPiA+DQo+ID4gPiBPbiBU
dWUsIDIxIE5vdiAyMDIzIGF0IDE5OjM3LCBDaGl1LCBDaGFzZWwgPGNoYXNlbC5jaGl1QGludGVs
LmNvbT4gd3JvdGU6DQo+ID4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+IEluIFBSLCBVZWZpUGF5bG9h
ZFBrZy9MaWJyYXJ5L0ZkdFBhcnNlckxpYi9GZHRQYXJzZXJMaWIuYywgbGluZQ0KPiA+ID4gPiAy
NjggaXMgZm9yDQo+ID4gPiByZWxhdGVkIGV4YW1wbGUgY29kZS4NCj4gPiA+ID4NCj4gPiA+DQo+
ID4gPiBUaGF0IHJlZmVycyB0byBhICdtZW1vcnktYWxsb2NhdGlvbicgbm9kZSwgcmlnaHQ/IEhv
dyBkb2VzIHRoYXQNCj4gPiA+IHJlbGF0ZSB0byB0aGUgJ3Jlc2VydmVkLW1lbW9yeScgbm9kZT8N
Cj4gPiA+DQo+ID4gPiBBbmQgY3J1Y2lhbGx5LCBob3cgZG9lcyB0aGlzIGNsYXJpZnkgaW4gd2hp
Y2ggd2F5ICJydW50aW1lLWNvZGUiIGFuZA0KPiA+ID4gInJ1bnRpbWUtIGRhdGEiIHJlc2VydmF0
aW9ucyBhcmUgYmVpbmcgdXNlZD8NCj4gPiA+DQo+ID4gPiBTaW5jZSB0aGUgdmVyeSBiZWdpbm5p
bmcgb2YgdGhpcyBkaXNjdXNzaW9uLCBJIGhhdmUgYmVlbiBhc2tpbmcNCj4gPiA+IHJlcGVhdGVk
bHkgZm9yIGV4YW1wbGVzIHRoYXQgZGVzY3JpYmUgdGhlIHdpZGVyIGNvbnRleHQgaW4gd2hpY2gg
dGhlc2UNCj4gcmVzZXJ2YXRpb25zIGFyZSB1c2VkLg0KPiA+ID4gVGhlICJydW50aW1lIiBpbnRv
IHJ1bnRpbWUtY29kZSBhbmQgcnVudGltZS1kYXRhIG1lYW5zIHRoYXQgdGhlc2UNCj4gPiA+IHJl
Z2lvbnMgaGF2ZSBhIHNwZWNpYWwgc2lnbmlmaWNhbmNlIHRvIHRoZSBvcGVyYXRpbmcgc3lzdGVt
LCBub3QNCj4gPiA+IGp1c3QgdG8gdGhlIG5leHQgYm9vdGxvYWRlciBzdGFnZS4gU28gSSB3YW50
IHRvIHVuZGVyc3RhbmQgZXhhY3RseQ0KPiA+ID4gd2h5IGl0IGlzIG5lY2Vzc2FyeSB0byBkZXNj
cmliZSB0aGVzZSByZWdpb25zIGluIGEgd2F5IHdoZXJlIHRoZQ0KPiA+ID4gb3BlcmF0aW5nIHN5
c3RlbSBtaWdodCBiZSBleHBlY3RlZCB0byBpbnRlcnByZXQgdGhpcyBpbmZvcm1hdGlvbiBhbmQg
YWN0DQo+IHVwb24gaXQuDQo+ID4gPg0KPiA+DQo+ID4NCj4gPiBJIHRoaW5rIHJ1bnRpbWUgY29k
ZSBhbmQgZGF0YSB0b2RheSBhcmUgbWFpbmx5IGZvciBzdXBwb3J0aW5nIFVFRkkgcnVudGltZQ0K
PiBzZXJ2aWNlcyAtIHNvbWUgQklPUyBmdW5jdGlvbnMgZm9yIE9TIHRvIHV0aWxpemUsIE9TIG1h
eSBmb2xsb3cgYmVsb3cgQUNQSSBzcGVjIHRvDQo+IHRyZWF0IHRoZW0gYXMgcmVzZXJ2ZWQgcmFu
Z2U6DQo+ID4gaHR0cHM6Ly91ZWZpLm9yZy9zcGVjcy9BQ1BJLzYuNS8xNV9TeXN0ZW1fQWRkcmVz
c19NYXBfSW50ZXJmYWNlcy5odG1sIw0KPiA+IHVlZmktbWVtb3J5LXR5cGVzLWFuZC1tYXBwaW5n
LXRvLWFjcGktYWRkcmVzcy1yYW5nZS10eXBlcw0KPiA+DQo+ID4gTGlrZSBJIG1lbnRpb25lZCBl
YXJsaWVyLCB0aGF0IFBSIGlzIHN0aWxsIGluIGVhcmx5IHBoYXNlIGFuZCBoYXMgbm90IHJlZmxl
Y3RlZCBhbGwNCj4gdGhlIHJlcXVpcmVkIGNoYW5nZXMgeWV0LCBidXQgdGhlIGlkZWEgaXMgdG8g
YnVpbGQNCj4gZ0VmaU1lbW9yeVR5cGVJbmZvcm1hdGlvbkd1aWQgSE9CIGZyb20gRkRUIHJlc2Vy
dmVkLW1lbW9yeSBub2Rlcy4NCj4gPiBVRUZJIGdlbmVyaWMgUGF5bG9hZCBoYXMgRHhlTWFpbiBp
bnRlZ3JhdGVkLCBob3dldmVyIE1lbW9yeSBUeXBlcyBhcmUNCj4gcGxhdGZvcm0tc3BlY2lmaWMs
IGZvciBleGFtcGxlLCBzb21lIHBsYXRmb3JtcyBtYXkgbmVlZCBiaWdnZXIgcnVudGltZSBtZW1v
cnkNCj4gZm9yIHRoZWlyIGltcGxlbWVudGF0aW9uLCB0aGF0J3Mgd2h5IHdlIHdhbnQgc3VjaCBG
RFQgcmVzZXJ2ZWQtbWVtb3J5IG5vZGUgdG8NCj4gdGVsbCBEeGVNYWluLg0KPiA+DQo+IA0KPiA+
IFRoZSBQYXlsb2FkIGZsb3cgd2lsbCBiZSBsaWtlIHRoaXM6DQo+ID4gICBQYXlsb2FkIGNyZWF0
ZXMgYnVpbHQtaW4gZGVmYXVsdCBNZW1vcnlUeXBlcyB0YWJsZSAtPg0KPiA+ICAgICBGRFQgcmVz
ZXJ2ZWQtbWVtb3J5IG5vZGUgdG8gb3ZlcnJpZGUgaWYgcmVxdWlyZWQgKHRoaXMgYWxzbyBlbnN1
cmVzIHRoZQ0KPiBzYW1lIG1lbW9yeSBtYXAgY3Jvc3MgYm9vdHMgc28gQUNQSSBTNCB3b3Jrcykg
LT4NCj4gPiAgICAgICBCdWlsZCBnRWZpTWVtb3J5VHlwZUluZm9ybWF0aW9uR3VpZCBIT0IgYnkg
InBsYXRmb20gc3BlY2lmaWMiDQo+IE1lbW9yeVR5cGVzIFRhYmxlIC0+DQo+ID4gICAgICAgICBE
eGVNYWluL0dDRCB0byBjb25zdW1lIHRoaXMgTWVtb3J5VHlwZXMgdGFibGUgYW5kIHNldHVwIG1l
bW9yeQ0KPiBzZXJ2aWNlIC0+DQo+ID4gICAgICAgICAgIEluc3RhbGwgbWVtb3J5IHR5cGVzIHRh
YmxlIHRvIFVFRkkgc3lzdGVtIHRhYmxlLkNvbmZpZ3VyYXRpb24gdGFibGUuLi4NCj4gPg0KPiA+
IE5vdGU6IGlmIFBheWxvYWQgYnVpbHQtaW4gZGVmYXVsdCBNZW1vcnlUeXBlcyB0YWJsZSB3b3Jr
cyBmaW5lIGZvciB0aGUNCj4gPiBwbGF0Zm9ybSwgdGhlbiBGRFQgcmVzZXJ2ZWQtbWVtb3J5IG5v
ZGUgZG9lcyBub3QgbmVlZCB0byBwcm92aWRlIHN1Y2gNCj4gJ3VzYWdlJyBjb21wYXRpYmxlIHN0
cmluZ3MuIChvcHRpb25hbCkgVGhpcyBGRFQgbm9kZSBjb3VsZCBhbGxvdw0KPiBmbGV4aWJpbGl0
eS9jb21wYXRpYmlsaXR5IHdpdGhvdXQgcmVidWlsZGluZyBQYXlsb2FkIGJpbmFyeS4NCj4gPg0K
PiA+IE5vdCBzdXJlIGlmIEkgYW5zd2VyZWQgYWxsIHlvdXIgcXVlc3Rpb25zLCBwbGVhc2UgaGln
aGxpZ2h0IHdoaWNoIGFyZWEgeW91IG5lZWQNCj4gbW9yZSBpbmZvcm1hdGlvbi4NCj4gPg0KPiAN
Cj4gVGhlIGdFZmlNZW1vcnlUeXBlSW5mb3JtYXRpb25HdWlkIEhPQiB0eXBpY2FsbHkgY2Fycmll
cyBwbGF0Zm9ybSBkZWZhdWx0cywgYW5kDQo+IHRoZSBhY3R1YWwgbWVtb3J5IHR5cGUgaW5mb3Jt
YXRpb24gaXMga2VwdCBpbiBhIG5vbi12b2xhdGlsZSBFRkkgdmFyaWFibGUsIHdoaWNoDQo+IGdl
dHMgdXBkYXRlZCB3aGVuIHRoZSBtZW1vcnkgdXNhZ2UgY2hhbmdlcy4gSXMgdGhpcyBkaWZmZXJl
bnQgZm9yDQo+IFVlZmlQYXlsb2FkUGtnPw0KPiANCj4gKEZvciB0aG9zZSBhbW9uZyB0aGUgY2Mn
ZWVzIGxlc3MgdmVyc2VkIGluIEVGSS9FREsyOiB3aGVuIHlvdSBnZXQgdGhlICdjb25maWcNCj4g
Y2hhbmdlZCAtcmVib290aW5nJyBtZXNzYWdlIGZyb20gdGhlIGJvb3QgZmlybXdhcmUsIGl0IHR5
cGljYWxseSBtZWFucyB0aGF0IHRoaXMNCj4gbWVtb3J5IHR5cGUgdGFibGUgaGFzIGNoYW5nZWQs
IGFuZCBhIHJlYm9vdCBpcyBuZWNlc3NhcnkuKQ0KPiANCj4gU28gdGhlIHBsYXRmb3JtIGluaXQg
bmVlZHMgdG8gcmVhZCB0aGlzIHZhcmlhYmxlLCBvciBnZXQgdGhlIGluZm9ybWF0aW9uIGluIGEN
Cj4gZGlmZmVyZW50IHdheS4gSSBhc3N1bWUgaXQgaXMgdGhlIHBheWxvYWQsIG5vdCB0aGUgcGxh
dGZvcm0gaW5pdCB0aGF0IHVwZGF0ZXMgdGhlDQo+IHZhcmlhYmxlIHdoZW4gbmVjZXNzYXJ5LiBU
aGlzIG1lYW5zIHRoZSBpbmZvcm1hdGlvbiBmbG93cyBmcm9tIHBheWxvYWQobikgdG8NCj4gcGxh
dGZvcm0gaW5pdChuKzEpLCB3aGVyZSBuIGlzIGEgbW9ub3RvbmljIGluZGV4IHRyYWNraW5nIGNv
bnNlY3V0aXZlIGJvb3RzIG9mIHRoZQ0KPiBzeXN0ZW0uDQo+IA0KPiBDYW4geW91IGV4cGxhaW4g
aG93IHRoZSBEVCBmaXRzIGludG8gdGhpcz8gSG93IGFyZSB0aGUgcnVudGltZS1jb2RlIGFuZA0K
PiBydW50aW1lLWRhdGEgbWVtb3J5IHJlc2VydmF0aW9uIG5vZGVzIHVuZGVyIC9yZXNlcnZlZC1t
ZW1vcnkgdXNlZCB0bw0KPiBpbXBsZW1lbnQgdGhpcyBpbmZvcm1hdGlvbiBleGNoYW5nZSBiZXR3
ZWVuIHBsYXRmb3JtIGluaXQgYW5kIHBheWxvYWQ/IEFuZA0KPiBob3cgZG8gdGhlIEhPQiBhbmQg
dGhlIEVGSSB2YXJpYWJsZSBmaXQgaW50byB0aGlzIHBpY3R1cmU/DQoNCg0KMS4gV2l0aCBzb21l
IG9mZmxpbmUgZGlzY3Vzc2lvbiwgd2Ugd291bGQgbW92ZSBnRWZpTWVtb3J5VHlwZUluZm9ybWF0
aW9uR3VpZCB1c2FnZSB0byBGRFQtPnVwbC1jdXN0b20gbm9kZS4gVGhpcyBpcyBiZWNhdXNlIGl0
IGlzIGVkazIgaW1wbGVtZW50YXRpb24gY2hvaWNlIGFuZCBub24tZWRrMiBQbGF0Zm9ybUluaXQg
b3IgUGF5bG9hZCBtYXkgbm90IGhhdmUgc3VjaCBtZW1vcnkgb3B0aW1pemF0aW9uIGltcGxlbWVu
dGF0aW9uLiAobm90IGEgZ2VuZXJpYyB1c2FnZS9yZXF1aXJlbWVudCBmb3IgUGxhdGZvcm1Jbml0
IGFuZCBQYXlsb2FkKQ0KDQpUaGUgZWRrMiBleGFtcGxlIGZsb3cgd2lsbCBiZSBsaWtlIGJlbG93
Og0KDQpQbGF0Zm9ybUluaXQgdG8gR2V0VmFyaWFibGUgb2YgZ0VmaU1lbW9yeVR5cGVJbmZvcm1h
dGlvbkd1aWQgYW5kIGNyZWF0ZSBIb2ItPg0KICBQbGF0Zm9ybUluaXQgdG8gaW5pdGlhbGl6ZSBG
RFQtPnVwbC1jdXN0b20gbm9kZSB0byByZXBvcnQgZ0VmaU1lbW9yeVR5cGVJbmZvcm1hdGlvbkd1
aWQgSE9CIGluZm9ybWF0aW9uIC0+DQogICAgVWVmaVBheWxvYWQgZW50cnkgdG8gcmUtY3JlYXRl
IGdFZmlNZW1vcnlUeXBlSW5mb3JtYXRpb25HdWlkIEhPQiBiYXNpbmcgb24gRkRUIGlucHV0IChp
bnN0ZWFkIG9mIHRoZSBkZWZhdWx0IE1lbW9yeVR5cGUgaW5zaWRlIFVlZmlQYXlsb2FkKSAtPg0K
ICAgICAgVWVmaVBheWxvYWQgRHhlTWFpbi9HY2Qgd2lsbCBjb25zdW1lIGdFZmlNZW1vcnlUeXBl
SW5mb3JtYXRpb25HdWlkIEhvYiBmb3IgbWVtb3J5IHR5cGUgaW5mb3JtYXRpb24gLT4NCiAgICAg
ICAgVWVmaVBheWxvYWQgdG8gaW5pdGlhbGl6ZSBVRUZJIGVudmlyb25tZW50IChtYWlubHkgRFhF
IGRpc3BhdGNoZXIpIC0+DQogICAgICAgICAgKGFkZGl0aW9uYWwgRlYgYmluYXJ5IGFwcGVuZGVk
IHRvIGNvbW1vbiBVZWZpUGF5bG9hZCBiaW5hcnkpIFBsYXRmb3JtUGF5bG9hZCB0byBwcm92aWRl
IFZhcmlhYmxlU2VydmljZSB3aGljaCBpcyBwbGF0Zm9ybSBzcGVjaWZpYyAtPg0KICAgICAgICAg
ICAgVWVmaVBheWxvYWQgVWVmaUJvb3RNYW5hZ2VyIHdpbGwgU2V0VmFyaWFibGUgaWYgbWVtb3J5
IHR5cGUgY2hhbmdlIG5lZWRlZCBhbmQgcmVxdWVzdCBhIHdhcm0gcmVzZXQgLT4NCiAgICAgICAg
ICAgICAgQmFjayB0byBQbGF0Zm9ybUluaXQgLi4uDQoNCg0KMi4gTm93IHRoZSBwcm9wb3NlZCBy
ZXNlcnZlZC1tZW1vcnkgbm9kZSB1c2FnZXMgd2lsbCBiZSBmb3IgUGxhdGZvcm1Jbml0IHRvIHBy
b3ZpZGUgZGF0YSB3aGljaCBtYXkgYmUgdXNlZCBieSBQYXlsb2FkIG9yIE9TLiBUaGlzIGlzIG5v
dCBlZGsyIHNwZWNpZmljIGFuZCBhbnkgUGxhdGZvcm1Jbml0L1BheWxvYWQgY291bGQgaGF2ZSBz
YW1lIHN1cHBvcnQuDQpOb3RlOiBhbGwgb2YgYmVsb3cgYXJlIG9wdGlvbmFsIGFuZCBQbGF0Zm9y
bUluaXQgbWF5IGNob29zZSB0byBpbXBsZW1lbnQgc29tZSBvZiB0aGVtIG9yIG5vdC4NCg0KICAg
ICAgLSBhY3BpDQpJZiBQbGF0Zm9ybUluaXQgY3JlYXRlZCBzb21lIEFDUEkgdGFibGVzLCB0aGlz
IHdpbGwgcmVwb3J0IGEgbWVtb3J5IHJlZ2lvbiB3aGljaCBjb250YWlucyBhbGwgdGhlIHRhYmxl
cyB0byBQYXlsb2FkIGFuZCBQYXlsb2FkIG1heSBiYXNlIG9uIHRoaXMgdG8gYWRkIHNvbWUgbW9y
ZSB0YWJsZXMgaWYgcmVxdWlyZWQuDQoNCiAgICAgIC0gYWNwaS1udnMNCklmIFBsYXRmb3JtSW5p
dCBoYXMgY3JlYXRlZCBzb21lIEFDUEkgdGFibGVzIHdoaWNoIGhhdmluZyBBQ1BJIE5WUyBtZW1v
cnkgZGVwZW5kZW5jeSwgdGhpcyB3aWxsIGJlIHRoYXQgbnZzIHJlZ2lvbi4NCg0KICAgICAgLSBi
b290LWNvZGUNCldoZW4gUGxhdGZvcm1Jbml0IGhhdmluZyBzb21lIEZXIGJvb3QgcGhhc2UgY29k
ZSB0aGF0IGNvdWxkIGJlIGZyZWVkIGZvciBPUyB0byB1c2Ugd2hlbiBwYXlsb2FkIHRyYW5zZmVy
cmluZyBjb250cm9sIHRvIFVFRkkgT1MNCg0KICAgICAgLSBib290LWRhdGENCldoZW4gUGxhdGZv
cm1Jbml0IGhhdmluZyBzb21lIEZXIGJvb3QgcGhhc2UgZGF0YSB0aGF0IGNvdWxkIGJlIGZyZWVk
IGZvciBPUyB0byB1c2Ugd2hlbiBwYXlsb2FkIHRyYW5zZmVycmluZyBjb250cm9sIHRvIFVFRkkg
T1MuDQoNCiAgICAgIC0gcnVudGltZS1jb2RlDQpQbGF0Zm9ybUluaXQgbWF5IHByb3ZpZGUgc29t
ZSBzZXJ2aWNlcyBjb2RlIHRoYXQgY2FuIGJlIHVzZWQgZm9yIFBheWxvYWQgdG8gaW5pdGlhbGl6
ZSBVRUZJIFJ1bnRpbWUgU2VydmljZXMgZm9yIHN1cHBvcnRpbmcgVUVGSSBPUy4NCg0KICAgICAg
LSBydW50aW1lLWRhdGENClBsYXRmb3JtSW5pdCBtYXkgcHJvdmlkZSBzb21lIHNlcnZpY2VzIGRh
dGEgdGhhdCBjYW4gYmUgdXNlZCBmb3IgUGF5bG9hZCB0byBJbml0aWFsaXplIFVFRkkgUnVudGlt
ZSBTZXJ2aWNlcyBmb3Igc3VwcG9ydGluZyBVRUZJIE9TLg0KDQoNCg==

