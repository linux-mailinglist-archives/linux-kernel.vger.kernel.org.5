Return-Path: <linux-kernel+bounces-44971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D433E8429CF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F1E3B21190
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F02E1292D4;
	Tue, 30 Jan 2024 16:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DRIzDpdW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AD112839A;
	Tue, 30 Jan 2024 16:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706633067; cv=fail; b=hpuguPbZU9vj0ddJVyH13dAqNdVy0T4YRGaXhgHyllzVoodK/kjK55WGxNAPy+aQQ3UCe7+jTMAiwt2Icx1JapKAsW130h5gB/EqxbF+8HxUCJcpfI+A+bksT7raiPYyJ5Gatmmf4oSMgXMWt6mRYyvNbDUfeCTLzDSsbwjN+ew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706633067; c=relaxed/simple;
	bh=QTSnxFVQPF03ByhUb4GxT9UrGhyClaZ/FDKa0gVcVLQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BnL8TusgYxlEgz9yi3xmPFwFq3kqPZjAApllQXHD6s3GA3ta3LRHjqRMVEmUUhpiVVuVfSKcym+pap+jr3gSbxBhFrXdMNI2P9onj7IrDMS7jiZz7Qv+HJYLrL/zEEdKOJh1gh3a+PVMNusmPkQgcRAQu/IYdPy0yx1kDCYld58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DRIzDpdW; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706633066; x=1738169066;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QTSnxFVQPF03ByhUb4GxT9UrGhyClaZ/FDKa0gVcVLQ=;
  b=DRIzDpdW9bL+enh3ooTIf86Of7AM106TbrgkhAdQCir5NnzcL8AjwV07
   MsrNAQ3g33MYqZtbBlxDASu8pFiVkNZXw4IrhA1XoFlOCKST13yKDRPfg
   f1r4Rae0RwH1W6a6E+VFPv0fWBOXWnf6r629Qw6yM63bl256G56+C/EBL
   J5227WbipHOXMTy5Zb19ntqVu2LmrFgN9AjWIsq3/4P4bskPDKPh7QHnG
   aI5rhrIdePh+5wXdQ1r48nKunfwHyb1uLy//bq5JyX9bxTd9rVuDHT3QU
   2iEEM11haMNclM/mpTOTbP5Y0pxSxXs+DiJ/7MXE4yHffuL9fS5V+Ps2+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="21851977"
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="21851977"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 08:44:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="788252015"
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="788252015"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Jan 2024 08:44:25 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 08:44:24 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Jan 2024 08:44:24 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Jan 2024 08:44:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IVBqK0URJAHjRjj0zK9jjJyycJ2QoQJ+mGPZAiA9jeW3XwVxSiqN470LQaDmS0gOXcERU+amkp/bYMk2rbYQ/liPFiNzn1p/wFk+4D7ds1P0EJrjnAo75TtGyiJRkTUDVZF3hixx96DzdaXWNqxKmSgpPbNA7vSZLiSEfieK6YyWWXMNA3addYrOU43Sx7Vpr4RxyPASzkFdX0jmjKpBiDTHxI5J2ukwJPEWgr0zT3nhURJyGHu2xde9xrFb+5uDhJv/q7nd2v2uyybQ6v/Vdl64SX3J0HYKFgzShng8AfPm0IMu/X7bVtgUOMcXPyCWuWyAK+LIreBJVm7KNLGR8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QTSnxFVQPF03ByhUb4GxT9UrGhyClaZ/FDKa0gVcVLQ=;
 b=eyq972nIIwibVVbUWgtYv39vcl1fqq9fNyxK8KWiGv1tDHKGOu0l+pDb8MVEuWJre/aCKoL1gQmfStFILdHdliXZrTY0fORLnSegSDN0JcLp9fhtM2Bjten2F/NSZVAMW85Wb7Mjow1bY2uG+R5djmEVBlTeyL9I+kojc6CPaYdnZylOWdT4yb7VzdI5nuP8UZAdJNi97sZ8ZthCVJQqe3lanrFinJAJyMKhxTlaqAxDZNL2mHvF0e3SctIZX7f3cLp5bjGnqkAn89RS+KoEyoC4PNyBxcBUaR25w/eneS7dBreLbdIGK2UdUyKSICH2n8z+15tTEhdZepEl2zutRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6734.namprd11.prod.outlook.com (2603:10b6:806:25d::22)
 by PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 16:44:22 +0000
Received: from SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::8ccb:4e83:8802:c277]) by SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::8ccb:4e83:8802:c277%4]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 16:44:22 +0000
From: "Li, Xin3" <xin3.li@intel.com>
To: "Li, Xin3" <xin3.li@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>
CC: "corbet@lwn.net" <corbet@lwn.net>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "Shankar,
 Ravi V" <ravi.v.shankar@intel.com>, "andrew.cooper3@citrix.com"
	<andrew.cooper3@citrix.com>
Subject: RE: [PATCH] x86/fred: Let command line option "fred" accept multiple
 options
Thread-Topic: [PATCH] x86/fred: Let command line option "fred" accept multiple
 options
Thread-Index: AQHaUQqJS4fE2sDKxUu0vzmnS8GE5LDyk64w
Date: Tue, 30 Jan 2024 16:44:22 +0000
Message-ID: <SA1PR11MB6734365A1C02A91A831FDB9CA87D2@SA1PR11MB6734.namprd11.prod.outlook.com>
References: <20240127094912.1489-1-xin3.li@intel.com>
In-Reply-To: <20240127094912.1489-1-xin3.li@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6734:EE_|PH7PR11MB5984:EE_
x-ms-office365-filtering-correlation-id: c26cb399-e028-4c6e-e34f-08dc21b2b61b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZUwThRfHxIFuwB7pae9wzQ4W9MV7JVYbmnMDgRYqep1PWzWfeSpzuWkT35KQ6paDatxJ0w+yskRrop6kCQ3iBgJ1KBwniYUkpEbJ6XaNx88HQTx3peYRg73BAhkS7OyjBjb4ltoLTFNFrw2WjI/5INmFe2/tuYw4jBqejG30UZVszrLq26sXd1mVn+8vVmJ63L74ZBAJkDKqTy6FzGVhEU6Y/BQhLK4wugQuWHdQMJ86pClFUmOCqExgY3AJDq8acs80/p9L/PZdQvN6htczsCfrZLP/cdmN/rl79xXQDzMZK7my8i51nvcsnk8cHj/Yuua1veVFVn4Lrvmvd1m/5AlaVzBTDGYbrH46/GLaX7qZlHGHtmHBOdde76mK+JfnFDkEgEQx7Bqd21ns3G4VAoHvD4TbD4sEl2QZN1l/+iwiLf+QZUFjpR08a94M+iFqbMhY8HMJ3qLBz+Qgwd1o0aLG9pttJbKDwI3a0Cg9TWjTOWG9POD2jiy4OArToBGt5Y1d8PU74lSAbOlHp/GmKfia+DO1bjbZEGC6PqaeqJf8KaGjZ0aHX4JugxBP5c7LHbev7NV6VV8XIYizcoC6RNkFd6bGbOp1z548kUfAj9I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(346002)(366004)(39860400002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(54906003)(5660300002)(66946007)(8676002)(52536014)(86362001)(4326008)(8936002)(2906002)(4744005)(7416002)(33656002)(76116006)(110136005)(64756008)(316002)(38070700009)(66446008)(66556008)(38100700002)(82960400001)(122000001)(66476007)(9686003)(6506007)(7696005)(478600001)(966005)(71200400001)(41300700001)(26005)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?THJIZHhDVjNUOUkycmZvalVEWmUyaXIvdWhnYndMaEJuSXlzRzBJRHdTaDVD?=
 =?utf-8?B?a3RHWkpYY1pnaVc1d0FWZXRaNHZ5MHFJSjNYYjdsOHhwK1lhbkJmc2pzVHJJ?=
 =?utf-8?B?VDFpNFB2SG83L05qM0lMVS9TSTR0azU1R1dUeXRmaXpGNGZSWFdiR3RlRGN3?=
 =?utf-8?B?NG5FN0tUbm9mYWdYUkFISXM0UlRIdkEycmlzdm9za2RHbDlRaERUU1pNb0Zq?=
 =?utf-8?B?cllhUWhBY2pkelVQSy9PcHdBT1ljb21sSk1OT3JCZncwYVdDV3MzYVI3dEFZ?=
 =?utf-8?B?Q2NyV3J6RG43dWxMQ0hWMEZlUGV4KzRCbzJveFI0dk1TWEZFUGpWOEI1dWJk?=
 =?utf-8?B?RDVwejZpMXNBMmFyenh6dC9sTm0rRXNCZHVZR3hDMXJ0aHh4cWtkVVd3TXJw?=
 =?utf-8?B?VFFvMWN1by9TZ0Q5Z1B0TlAwQk9RNG0zc1M0SUMrSkVHMVhwV2V5UHlLZ01G?=
 =?utf-8?B?bC9PQmR0Uk5LQTBmSGtkdkhlZXlWbWRCNmc2dVRmMlF5VGYwNjBLaHI4dTBD?=
 =?utf-8?B?T1d5ai9XcVFBb1hzRklHRkxTb3VwKzlyVkFiZVE0NzJDMlhGL2c5dU1SclZQ?=
 =?utf-8?B?eEJ3cFV5dE5hN0ZNMVcrNU1sLytiaXl1aktlVTlXdGxObkVTYmZJeFVWWEl5?=
 =?utf-8?B?ZnBRN09BTTgyQkN2QnBaOVN5U3ZlRjk4L3g5bkg5UXBHdytCci9XbFNYR2lM?=
 =?utf-8?B?aEwxcldlRmx3eTZRcFdJNGJkR1N2N1p4YmQ4TFM2a0c5QnhhR1FPbS9yR2pK?=
 =?utf-8?B?Q2tQNE5IUERkSi8xYUFTVTlGTG1McnFxNFgyY0hYNE1SUWtQZWNKTjB2UkE4?=
 =?utf-8?B?TlIzcDFlT0FWWi9HaXVzOXA2V0RPYWYwT2FGWjhMdDBkTkQ0MXRaVEJVc2dp?=
 =?utf-8?B?bnFKVXEyOWM3aVMveEpqUG9YQXZiUHN6dUZYSElTdmF1WXhsYU82Y00rTi9Q?=
 =?utf-8?B?eXR0aGdYWnZEdXhlSzlKRlk1V09EYUFYWitaUnAxdzlsUHFpQXh1Wmx3dEEy?=
 =?utf-8?B?OEtkVzdNN3JYbE9RcStmeU1xZFMwVUc4b2d1WnF4TUZOZXJHclVQWHRYdGpY?=
 =?utf-8?B?cS9qNmNwUXhaKzBNcDM1Wm5oZEVMcVY5ZE9RSTRhcktUTFBKcGx6WDBvbERU?=
 =?utf-8?B?STlocHFZWXNDd3BrdWFEbkZCSURUd1owUjlzWFpJSzlXOGZNSklxdm9mRkEx?=
 =?utf-8?B?ZXZvVmQ2NzM3d3JiejdWUy9aL0RxTzlBTENXRGtTaisxT25QRUlyTURnczNY?=
 =?utf-8?B?anV3RkpBV2cwVGZDbmJ6TmM4QkJqYjdrYUJLUmNRRExNa01WNlBSb3BKdXFw?=
 =?utf-8?B?MzIzMWRYV1JIZG1Mb3pvV0I2VnVUUktBVEozRU9EWjFnQ2FCMDlQbUIxTXh4?=
 =?utf-8?B?dkpRaTBMR0xOeGo0TVdxZHdtQW9wTFZWclkwc1RweXlSMlllM2ZkaFpseXJ1?=
 =?utf-8?B?NlZIUFhSMUlqTklwNGR2UjNrWVR2TXJ3T1JnbWJIQTNSZWhWbVpEMnZ0TGlQ?=
 =?utf-8?B?dVVYeUxGWTNoaHVpRmxTNkhQMW9lV3o5dHNoUUZiMDFWamtWbDF1VkluSnUr?=
 =?utf-8?B?TVJjc1JtM3FYNVdVN2RtUzZNMDZVQ2tpamRMeE1aRVd2SCsrV0w4TUJMOExN?=
 =?utf-8?B?QVdKcnFoSXpVbUhDNHI2VnhSZlpEUFI3dXcvZytpNDZ3L3hFRFEwU2szalNj?=
 =?utf-8?B?NGdvNll6cjdEcUpTYmZ6QWwwVU5PSWRCMWpOeUE2YTNPYjVWcWQvcnBZQXJ2?=
 =?utf-8?B?cVJOTVcxRy9lMjRoRjZ6RlhPaFJmQTVYRkttTkwvZzh1UGtsRTFLZmhQb0l5?=
 =?utf-8?B?UFlzL2xMOVBkYzBUMXVvWVZxdUdDdGhZbnAzRHZhdEFkUXdFWEVYUVp4eDFq?=
 =?utf-8?B?RzNVanFLRlFLajVnMDE5clZLVEkxdU93MDYwcml5Y0s4R0xucVQxd21IclFS?=
 =?utf-8?B?UFJYa01KRDhrdUNGTm4wbXR2RlhNWEtlU3kvdHJKSlp1ZFpNcXNkbGdUblhF?=
 =?utf-8?B?RmNMVFYwa1l6ZTJ0aVQvL3hZNlY2Sm9aS1Qzb3dXNE9nOXVyMGVJSzBtNHMz?=
 =?utf-8?B?MVlGYzN4RTJSbHRGNEYzUktESHJid0I3RmVSUSt1eFh1WmtKSlpWTDdHT09M?=
 =?utf-8?Q?XVmY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6734.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c26cb399-e028-4c6e-e34f-08dc21b2b61b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 16:44:22.2563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BDYj0ioePCJhXmc3O9RFI/fCv3zInsbNjegp0Ss8M7wwDyC4Bc/vwrOlYSiMBLdxoCypfkhAkBnP0lBSMKSzxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5984
X-OriginatorOrg: intel.com

PiBMZXQgY29tbWFuZCBsaW5lIG9wdGlvbiAiZnJlZCIgYWNjZXB0IG11bHRpcGxlIG9wdGlvbnMg
dG8gbWFrZSBpdA0KPiBlYXNpZXIgdG8gdHdlYWsgaXRzIGJlaGF2aW9yLg0KPiANCj4gQ3VycmVu
dGx5IHR3byBvcHRpb25zICdvbicgYW5kICdvZmYnIGFyZSBhbGxvd2VkLCBhbmQgdGhlIGRlZmF1
bHQNCj4gYmVoYXZpb3IgaXMgdG8gZGlzYWJsZSBGUkVELiBUbyBlbmFibGUgRlJFRCwgYXBwZW5k
ICJmcmVkPW9uIiB0bw0KPiB0aGUga2VybmVsIGNvbW1hbmQgbGluZS4NCj4gDQo+IFN1Z2dlc3Rl
ZC1ieTogQm9yaXNsYXYgUGV0a292IChBTUQpIDxicEBhbGllbjguZGU+DQo+IFNpZ25lZC1vZmYt
Ynk6IFhpbiBMaSA8eGluMy5saUBpbnRlbC5jb20+DQoNCkhpIEJvcmlzLA0KDQpJIGtpbmQgb2Yg
cHJlZmVyIHRvIGZvbGQgdGhpcyBwYXRjaCBpbnRvIHRoaXMgY29tbWl0Og0KaHR0cHM6Ly9naXQu
a2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvYnAvYnAuZ2l0L2NvbW1pdC8/aD10
aXAteDg2LWZyZWQmaWQ9N2ExZDc1MDg0ZGYwODdkY2FlNzAzZDcwYTQ5Mjc0YTM5ODJlMzY4MSAN
Cg0KYnV0IG9mIGNvdXJzZSBhIG1haW50YWluZXIga25vd3MgdGhlIGJlc3Qgd2F5IPCfmIoNCg0K
VGhhbmtzIQ0KICAgICAgICAtWGluDQo=

