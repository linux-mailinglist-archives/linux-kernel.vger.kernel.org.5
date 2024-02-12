Return-Path: <linux-kernel+bounces-62503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 556088521C7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 23:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16C4E284D57
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 22:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3474EB2A;
	Mon, 12 Feb 2024 22:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fq8wSSB9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BC54E1B5;
	Mon, 12 Feb 2024 22:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707778439; cv=fail; b=m8NqtS994/lmcjdHKBZj2jMmAkaFKHEO8ZfhOH13Yv/JBDXWtAipA9CuyING6UdOiVXbl0Uysg1a0U/roeIgZ9WzFa7lf0stCkUmvFYm4YYQlYndtRRHMjqGbVfAa/BC4z/RmTjSKDdB/HS7cd34wZVebbPIdnEBZjBVNryAqm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707778439; c=relaxed/simple;
	bh=Y0aPg+BrsTBs3ISBKlv4rk0DG7my+UsKIM2QtXix060=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WzlsJBX6E1akGJJfGDMkQTzP7QbphQMPgMdiKvCcbQaAZzDIJaBCXIAcouHpDQq3XvGv7+yMhP+4TgOnPDmz67twWlkD4ABsPbAecuLUoujZH0HdWmM7VUt+dt4Q9qUt6BbxUGMSpbxMQBFFdAKnt3DYGZW7B6H1wY2gdEV65Lc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fq8wSSB9; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707778437; x=1739314437;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Y0aPg+BrsTBs3ISBKlv4rk0DG7my+UsKIM2QtXix060=;
  b=fq8wSSB9lVRDPVcflv4oUt1bkWd7lOict2AccAuyzeoRroKExr1taHih
   XySL5stt/02yZEBij7cC51vgtBknI18D2Ft4Pss6Z4hak3WKM7yOvGJ15
   XeTgzC7ZtZoBwkAPgUmfebe+TJwPq6hLyhojIug0UV9vyW4U96E/eXZH8
   fA2UDdfA0Po4e6OfQ0GCNYz7NnVxjfj/YhXrTiyhAonNOl1JAiR2txq+r
   T5OHwDrDCOSG1kD4XiURzzrbBzxio63J7sbFfT3ivwTKUA8XQO0XFcjpZ
   IEuHbgDGoTNhKXZ/VnjVBsTwjlIA7UzZdUxCWA9hBCRMIj1fFoMIJIs1E
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="13170519"
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="13170519"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 14:53:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="2697309"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Feb 2024 14:53:56 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 12 Feb 2024 14:53:55 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 12 Feb 2024 14:53:55 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 12 Feb 2024 14:53:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IoFphbF0wb0s9ZgiZgseQOKgjC/AL7uveZ2rR5Bw5iqWmJPK7nN5ITD60/QyQbta3JRbgaxrqdC5TSyODSXy4k3R7x/82TIrjWR+bgjIOyEQXHl20v+STtYbqeRI15UZB7xSE52cgK1YeVKcTiB1IONykADZwyXqSYYaI4MykaQK8/cpQdK+dCKu5F9dBGDi8MB61j1kOK2GAqyLmz7SCAk0O3VI7BBjlnTCRGT/54ers/c9x4MLKPcx/f5J9g4YaOHEPHmRy9ogCQ+aueseF8bjKT0qBNKRiXWXA4L1guMoDn2VTSe4GJFwXNnegb6eY+UoWFM6VVTUr+2TPh458g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0cfPQqnRbWp6rQI+Kj2ZyXA9SVzW7w8EjwHXe8p0ifw=;
 b=I5h3NLbTVNrXDU49WKTbAbiMGKg0RcJWGIW0UC30ByQgLPFKYKanP/ypmACXO1g/WTmXisiHz4Ydo85mnf//jePOnUdpq6JVH9/R3bXGic/+Z8AcR/2KJeEf2AB4P099ZOjWjKB1UFffOUinEz+fDmM3pNAWyQonnm1efb0GCJqt+mSqv+tLv8n7BplLCK1DoZREH0pd4EB67/xbgpLy+nlED3a6ti/LQRqPj3Y30EutoGxAeShguWN8GPYClo+c+LPPGFN2KiNCtEINyWjTUj1I/uV+9l6IzqisIRdUnMrMsyqlMAt4E6tXs7qkAd4kLOtQUqcdMz729pZKgaYcfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by BN9PR11MB5371.namprd11.prod.outlook.com (2603:10b6:408:11c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.38; Mon, 12 Feb
 2024 22:53:53 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::7103:9cf7:fcc0:e802]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::7103:9cf7:fcc0:e802%3]) with mapi id 15.20.7270.033; Mon, 12 Feb 2024
 22:53:53 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "paulmck@kernel.org" <paulmck@kernel.org>, Borislav Petkov <bp@alien8.de>
CC: Yazen Ghannam <yazen.ghannam@amd.com>, "Naik, Avadhut" <avadnaik@amd.com>,
	"Mehta, Sohil" <sohil.mehta@intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Avadhut Naik
	<avadhut.naik@amd.com>
Subject: RE: [PATCH 2/2] x86/MCE: Add command line option to extend MCE
 Records pool
Thread-Topic: [PATCH 2/2] x86/MCE: Add command line option to extend MCE
 Records pool
Thread-Index: AQHaWhj+DLVtkWOA50OiEqZPMnN2ZbEBPHkAgAE1PoCAAAHSAIAABzoAgAAEd4CAALjhgIAA4DsAgADqjICAAhC1AIAAAfPggAANwwCAAACQYIAABwgAgAAJWQCAAAwugIAAFiWAgAABj6A=
Date: Mon, 12 Feb 2024 22:53:53 +0000
Message-ID: <SJ1PR11MB608354A42EBA295ED904A509FC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <5DB0FF8D-C6DA-45DC-B287-201A9BF48BDA@alien8.de>
 <75ddf61d-8dda-47fa-9da0-24221feb22a2@amd.com>
 <20240211111455.GAZcisL09LeFPWa2EI@fat_crate.local>
 <b5904910-ed58-405f-9425-566383b48068@amd.com>
 <SJ1PR11MB6083CF3400AD2F2047D65E17FC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <34b19db5-bd72-457c-9b6a-c2089f6be83c@amd.com>
 <SJ1PR11MB6083E7E11F6C7BCC8C6C7F21FC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240212201038.GNZcp7PuIqIJndpDM9@fat_crate.local>
 <47901422-ac07-47db-bf44-3f4353e92b1d@paulmck-laptop>
 <20240212212741.GPZcqNTXfU2OX7uRtx@fat_crate.local>
 <2d8b17f2-c22f-478f-b407-9d2dfd2064f7@paulmck-laptop>
In-Reply-To: <2d8b17f2-c22f-478f-b407-9d2dfd2064f7@paulmck-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|BN9PR11MB5371:EE_
x-ms-office365-filtering-correlation-id: 5222b374-bf6e-4482-3d1d-08dc2c1d7c87
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C0/Ga1/UoJqXW/DangtW5zx8CQnKKHZ6Q1AjDHOSoV1++uUyGb+K/WM3Q08IRazhxo0Eq7dOgctr2mpgl/oCbLtx96FXSzLYmqueLSl/yJynQgIZ17A7wOmYOg0ozovUKCGhV6ULQynLOfwn9QbfJOTRsu9gRm4SDbUoK4p6G1dZv19x1f1O1b6I+6RTS5tgn6qJbE+ZzpiadRFxKhkMTL43YZEF60DqjhYNzNirDck0oSfx/OTWHWHHBfqfju4rovGv/sGQCKsrMNPPIhcmdXcdWK41RP7aX59L/9s82Wy9BA5yC28cjE8D08LEQ0wzbOeifQ2XfunqPys09StUqBB30OB2Vk81zJn1C/zx41cXvgs9+QDqRURNxTkmgL/RmvwzBFOhHzm5w6YUu/JvQ0OaPhlhhckBvx7Hw0PV6YeeMt2b832K0fuUUzsYuYd0B8vmbf5LrkwR6iWVgLa9yNma0r32dKHbDkxtE9IJvcVnUH/kmbjk1itlwMt0T8XUzBFOkZbmjxB8g52K5FH4n3NV+jqd/cpwygVAujU6JSEWX+QjzRJpwaFgtLporAJJ41sjpOkMg3PyH3e5sCV++YLZ1B29lxMLzBXWnuQ+ZPa6yx8PrAfzX45PjSOSqCWB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(396003)(376002)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(2906002)(55016003)(41300700001)(26005)(478600001)(38070700009)(4326008)(71200400001)(54906003)(5660300002)(9686003)(110136005)(7696005)(64756008)(8676002)(8936002)(52536014)(66556008)(66946007)(66446008)(66476007)(76116006)(83380400001)(33656002)(558084003)(86362001)(6506007)(316002)(82960400001)(38100700002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TM/FTvR0xtXraYeSbyhBqy7rJFpbXK2LaiSTlTUDYV61RIF8X9RgQ9ebMlGN?=
 =?us-ascii?Q?TJ4dNAkvVBQPgD1eJu6OZH316QprUqBylVy45ZieWv//iwBPyLgRoF4SFms2?=
 =?us-ascii?Q?ZCQeDP9ve80TyCgffD4MO+nw31mZBl8OAgWNQxSntFtP9+a+YrMJG6s1F3Pp?=
 =?us-ascii?Q?Gib0izio4/aHEApf2gWqTCQRrfTwGAYRMI16xMFw4T/T77Rvlo/qKtoTn32e?=
 =?us-ascii?Q?r6AJowaovoW91c3qzTQWSppVAcmq52nkViJPXMzFZfIa7JXUoBJi+LejkgGv?=
 =?us-ascii?Q?aYdC0Rvqsd6JYWuLV6rSSOwvd6BlauJvSpHK0T/NaxzVHuvyGMYIORj5oiSM?=
 =?us-ascii?Q?/ssCS5zrpd4yBUO2/JuOQyRzAmk3cesdd9zm5LA+54YhXC7WGGaqnHiDsjQo?=
 =?us-ascii?Q?oDdimRXOl2/u0jl3aEq6dxow1zgwYawA7DuPLGyd+USeDyGNUG9LnCv4icks?=
 =?us-ascii?Q?P2CQdBWMt1fvBnt99n7jKEIUTNeuQ22UbYsQ0y7Nli4JVklSCwb4hvH3YFbe?=
 =?us-ascii?Q?8ZZKcW/yxaGW9PE2KjInyCg76nOs9Vq8TFXzkowfspIdvRec2hVYvTqssjW0?=
 =?us-ascii?Q?+9ThNiYTCSe1ioMmoaLw5bggTvgAh2oNCtLMdbn4wMqR0ZEZ6F3ohZLlv41H?=
 =?us-ascii?Q?K2cC5J1S5aPfTsiN/D3rBMJ4q77rP5MnKTCxJJN1lrmI2QSH0gywGdd/dV3Q?=
 =?us-ascii?Q?R3kra5A/Mc1dvrBqXnCLsedZDIPK/i+S+YX93zNSiKWy6mVLxukd4lstW1mu?=
 =?us-ascii?Q?6aWgTXXUDHN7lMJJhNmc3nGmiNkt14L/qsKWm16yVghNhr9l/h0nR16Dg3QG?=
 =?us-ascii?Q?SqFk4Nau8f+N6BHwQ7B90rk3OcykBFDxmW0TyWNn2+DzGrrlzo81waQypY6v?=
 =?us-ascii?Q?CTjOfkvBGXddi8uQGqa0PPG1PhfGCLn6wV+qzjtKvgMy8r6Fe3VgLsNcdFj8?=
 =?us-ascii?Q?LFTKoc0leEIyjJhtumtR8+H/sozXKuOCN+IulbtqXhOXE49fMIF3lDlJ6tce?=
 =?us-ascii?Q?97ZvYHQJEk8a5HCxFT3etOATrsu18A3v+LtKso159UZFQ/0Dr5rx1i1CU3Wd?=
 =?us-ascii?Q?GsDwz3WmMdhGAClB1Ymvw9bAzodpbOOMEvUFRcoq5BhjUTCXC4DhW2sCcARP?=
 =?us-ascii?Q?kzTZrotT40Tj7Ws+Ajq+KiQzfOUAnELXYW23ihEkg4BtTitdqI3rhR+q8aBK?=
 =?us-ascii?Q?+Bpm8Hl6yefqhYxLs1XOyxn3PCeONqwDoXRa8HeyRdzZkyS6L6IOEf/Bn97T?=
 =?us-ascii?Q?nJ00TbgvPmMIr9OURklg5j2tzkREJyV/KsouFbf1yLnEHLoW20NIHKNNRuNs?=
 =?us-ascii?Q?lgXU/YMcKw3TH4kWmgm/6OBIzy7x80W5R8KhemWCnjgPNRP/ckQGtBQYzJ9J?=
 =?us-ascii?Q?z+L/Wib3aoNwE1GjfBp56gcgepl2TU7ZkHhkMVV3C42OAt9YmNv3uksKLchQ?=
 =?us-ascii?Q?5oUO2hPEavWfjujlA0Kw/lSqztfRNASRlfGS33wLBxdB96UeH5gbMRVA8SKu?=
 =?us-ascii?Q?rHq0Ycgz/ECejwyVQy3aRDVsB2DCeWyR/xAQa2knj8Kj0JjOWtZdshdTxJfp?=
 =?us-ascii?Q?628eNUQ4Bl+2TrfKyAJWyomY/hKDxBSO+iY2n+So?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5222b374-bf6e-4482-3d1d-08dc2c1d7c87
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2024 22:53:53.4419
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +bkujaAOtkfSRkCF7a3lz6oSHnc7ln6ylX8DCngOvjSdkeUh+Zp3nQ7V+NzYgkDKQnKM2Je7tQLRAyyFVfqQnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5371
X-OriginatorOrg: intel.com

> The usual reason is to exclude other CPUs also doing list_add_rcu()
> on the same list.  Or is there other synchronization that is preventing
> concurrent updates?

In this case the patch is trying to do a one-time bump of the pool size.
So no races here.

-Tony


