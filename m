Return-Path: <linux-kernel+bounces-21731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32BD3829371
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 06:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8826CB25B3E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 05:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB6C2A1C0;
	Wed, 10 Jan 2024 05:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UpslpNkl"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5370DDDD9;
	Wed, 10 Jan 2024 05:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704865523; x=1736401523;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aKVdjvARZYDTia9ly2nTZADXvqPYQoiIvKnIZeIPTS4=;
  b=UpslpNklj9J1cIYJjrdJBESfc1zDfT4L+HzYxnB4ojDzY1ZLr2mmAtV2
   a5dV1uMxXOHreB+1bkaM0aRfunyBpDB0QC5hVZTyAaotwNeJPVYetOq+6
   oHr4PnwxBCHEckQxleTAuDeaF/Wi1sfafaYW2mbg2SwYwnqVgBuA/1k7a
   7JgXE1n5vskkC5A24/X/rhJogZyVuiXTG2vHgjwkqsuGyxnDGdVWUMSFD
   WCaKiYqifSpY8vTINDZQWW98BLU5k+8/8vr0CVwG4pr4h/FZnCtoqbB5C
   HeFmHTxIs7ij6Fe82j+IpkxNhBNzWaNjV9sriwSj8Vnjo2twf4SqDrCbd
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="397271389"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="397271389"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 21:45:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="24137458"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jan 2024 21:45:22 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Jan 2024 21:45:21 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Jan 2024 21:45:20 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Jan 2024 21:45:20 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Jan 2024 21:45:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hfNEDJ/PQQy9QBgvegZLnXWTzT5sspOVYSNjT/skdcRBcBVB4TykThw4+mFyyZRD16eInPwWvDnQXk9Z66DdKBhs278nN0LUA89/MFBn+BLc2sJN6J5T69/rDnNd3i5yvztbee5m2GodF+ChRCTigCRiNNT3Ggdufa6jBtZUmXOfS7xY3xZE/LDVh98jbAQcaEis+Kj31C6AeaWSmvLz19tmdxOr0Ektx3RIBPo+rdiyf4HEPWvQi3NtOrVESpkoTVytFZYg31/niK8BSzi7V094Y6vY91fR/nFABLsWzcTE56zXliNoy1ggpyiy2vSotWioCW/F7ZMYEALmMUAHTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6axTThPtTenSZkTtAWGyuX+sV+HRsY7UOq10pZ/2aHs=;
 b=KaV/fOuer9kqd3gOXLAtyTHBdYuj1CBHA3Nnf4aL/W+tHKI4ou1CV2/e1dd9r2Ia9EPwDgS4j7d8AHjnhMJ3yLKh0GOEKBM3kWX/edRS5NHF4wAfuRBeCGoeD934WJEh+lgK311jhYBGhD7pbCQ7A6pSWEDVvzRW39EYSkVP4jddzM8joDuOoMWH5NLp3p4Ep1uwpc9oZQBVPBEeQ87itnWkAoe2aBGWpnmjLo9ikiuXIE6Tb8JlqHSOcbhUkPfshZA0PrYwXpxxTfuHFSxv67nob4xSPlrW+hNc3P2k9Zzu/GZNHXVloXECd4IQ1zFa+Dbe1NnEsKjIGUEywQMuTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH0PR11MB5490.namprd11.prod.outlook.com (2603:10b6:610:d5::6)
 by BL1PR11MB5239.namprd11.prod.outlook.com (2603:10b6:208:31a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 05:45:17 +0000
Received: from CH0PR11MB5490.namprd11.prod.outlook.com
 ([fe80::9afc:fa9d:5f42:8fd7]) by CH0PR11MB5490.namprd11.prod.outlook.com
 ([fe80::9afc:fa9d:5f42:8fd7%7]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 05:45:17 +0000
From: "Swee, Leong Ching" <leong.ching.swee@intel.com>
To: Serge Semin <fancer.lancer@gmail.com>
CC: Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	"linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Teoh Ji Sheng <ji.sheng.teoh@intel.com>
Subject: RE: [PATCH net-next v2 3/4] net: stmmac: Add support for TX/RX
 channel interrupt
Thread-Topic: [PATCH net-next v2 3/4] net: stmmac: Add support for TX/RX
 channel interrupt
Thread-Index: AQHaP6Y7sC4xQVBFpEuN3if/vsfTLLDO07kAgAO85HA=
Date: Wed, 10 Jan 2024 05:45:17 +0000
Message-ID: <CH0PR11MB549071EAB3017E244DCC2F71CF692@CH0PR11MB5490.namprd11.prod.outlook.com>
References: <20240105070925.2948871-1-leong.ching.swee@intel.com>
 <20240105070925.2948871-4-leong.ching.swee@intel.com>
 <xybq2523vgod6rbefw4zjs2kb2xtfmizecdwdjzyl6l2iovjqq@o3q4t2qny55o>
In-Reply-To: <xybq2523vgod6rbefw4zjs2kb2xtfmizecdwdjzyl6l2iovjqq@o3q4t2qny55o>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR11MB5490:EE_|BL1PR11MB5239:EE_
x-ms-office365-filtering-correlation-id: 408e0935-fc0d-4d7e-4c43-08dc119f5319
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8QiX7fHvN9OXYJJ18Lr7q5lFBSbZxCY7ovfNFmVhCR+Vw/SScQAwnmKQq+Rq0XGBvhCWgIaXlUcA9tPBqO1xpmIMVLdu75pgUbG/PhnNPX/fWw6UyEtI2NmFkTr94eqFflT4z8nqsE3SEeP6LunZs3UoXfrWjNDflCK6DP4yBnwPyuMY8kAt6uNffSH2sCnEFpWt3aQwIKD/mxRpey8Re9O7TSdGpl9Uv2MWioWKWvkbrHsawzfNXc90uVBqmjQSYRvhBalvvoDEX0rLMkdzSzeyERZzdpxp3ikYYxh5Y9xga5mL+zeiZyisFBBjLAKR5XMmJE8IHSPwybylBXtQ/f7KQgP5XCUCO1bg1gPPTHMenzrbGdZ5cUB4DNwH7b8ze19WJsm7UhWMp6o76JuqjCP1hsJ/exVaIdOhty52FMw46aGMZ3/I/bXcADkF3Ww3BGfZNAIpuCfqDS/sm3vIZdxriRN60NOgtUpYf8lkCeQQuRSM8xhAe98i4wUGNeANffEIZPprrBvdwzoK14SemAKJVeRBYd+/yrnp6Nu9yFCAZgnC5R5oXOsroK2NfWSLkzoKej5qI4fJX1A/O/kdlTkV22yWo5PyCaH2Iz27G2a9cbfAbDdoh68b1zz7sESd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5490.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(346002)(39860400002)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(83380400001)(26005)(53546011)(6506007)(9686003)(107886003)(122000001)(5660300002)(38100700002)(8936002)(4326008)(8676002)(7416002)(52536014)(2906002)(66446008)(478600001)(7696005)(54906003)(71200400001)(66476007)(66556008)(6916009)(316002)(64756008)(76116006)(66946007)(41300700001)(38070700009)(82960400001)(86362001)(33656002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gMqkq9XBT7KGnjhQUQHxjs2baS+MELtd7kN1VDfkMQN1b6JkZF+++PQ63Afa?=
 =?us-ascii?Q?U0oPusmJ2JurbCiN3dFA0ng4Vj00upQXeBlzAsUd7Aly6Q9cLNsl+g0DcVfR?=
 =?us-ascii?Q?syKYsrIAyFdTLJF61Jd/SXirAhJFttEd0omo6bN9+nSMfXHebqAQf18f+609?=
 =?us-ascii?Q?yVRUPETPOgUhfk3zT6v1Lpy3+zm8T3zJOrcYSbosN6AsXUBHa56hzx1a6BuX?=
 =?us-ascii?Q?3gUtokexmyH24S5A9pROkQHI+zmoyBFGzAbtqAC4W88dbocE91GBRGqRo6kh?=
 =?us-ascii?Q?B63O+PaHXaQizP2lBtctKlTLYaVdt8NET+rr/V+beorHlA6Ok8vOH/kFVeDw?=
 =?us-ascii?Q?jASQSjEMgAbsNy8un3EfF2wAyJUj8n4Xno2PM+u3ZQA8pMClzGoq8LsUrXeC?=
 =?us-ascii?Q?B6qM4YeDAW+M14JrwdBkKBuA74g30G9rPejQr5Ggioaz4R+y7OxF8WOYwuGA?=
 =?us-ascii?Q?f+ilG8msDdNoMpXxQdriyhz7eHuLDNHhJ5rGqs7KwKtuVQ8RO/pUZNh+ml70?=
 =?us-ascii?Q?GVq4Rz4o4hHEw8BbnhH+R2QIwbUW+4gwhmDeAAeeKlo3RSKN0inwPHH2lob6?=
 =?us-ascii?Q?RSERhSaPixsUhS+2fNqwrBRiIVuYSDrw4Vt6BNc+GdDl6oN3v+6xzvH/louH?=
 =?us-ascii?Q?qUOPntaecqUIKrInAAcX1qXXwDasU1x68VOQSwvsjR8HVtTkNIFahWnCyIrz?=
 =?us-ascii?Q?cvPEbuU2A9oi2g3kLvm73XAAc+kn6Dwa9vXOIuv+RG9RSUPcxxjbFOvIUzdy?=
 =?us-ascii?Q?36eGDNJ+NVmZ0rjGie2f/GkG/LUjtPNM2um8KMGxYodLSOCvGa4KWz8yRKPf?=
 =?us-ascii?Q?da3M9heXB5Zxbqwzi+Tt0/18PRmSOEAfv4N9KbVta1BrapMzUS4CKZQsZbrr?=
 =?us-ascii?Q?5/v5jWbdpUwtrZMaphtrAbjuV5kOMDqkwI2NG2UHzd3+Ba19OS+m50mA+XLd?=
 =?us-ascii?Q?5pNxzvx2hKmPdAODviF0IV6V1xJtByp2uGCMJcIOV9ZBmFXpTf6FY7MVEW56?=
 =?us-ascii?Q?YpMpDjSJEwibDPyMrqAQkMI1aiGifv5m1uT7uEBba5EYkACmXPQWr93VHZB+?=
 =?us-ascii?Q?teNyWBDB4aa8V0I5eSrLQkeSsFsVW8N8Ut7lh5Z9YahOXLA+D+m5RCUzcvSj?=
 =?us-ascii?Q?kZZkMzlqy4E97h9YwvDqcVpvyTn77Aw2yEBYwjagvkgZOYslSGJ6jdHmP769?=
 =?us-ascii?Q?cf0r4aUKd9uMqowwDSF15f7TxoC8hyJdFZbOwgqc6tm7vxjwE1uKh0zgUTFD?=
 =?us-ascii?Q?8U3ty2cijjZ6Z3GBMe+BrRxD3EtYTJHxSI/6dM36OeBpQ83T4aX95NdAZv1v?=
 =?us-ascii?Q?ZUJD+bunI7GFaKQROXozLuKOPPLdgDG3ZGgj400G/6ZHG3dub1+N9i62J3PK?=
 =?us-ascii?Q?PIDN6y0x4FdfEzMAV9S3mxi5gBkWWkjU/z6PIK6iDLL43HOEvqWHid91C1B8?=
 =?us-ascii?Q?Pob4pwJ90dBZfk+8KZ2czsNcTZ02XkFA2BGqjuRiPne/47hVLH97wa7eg3eR?=
 =?us-ascii?Q?pCEAdpuA876H8jObNUN+EHP05LRD96/Ru7CiPvzCYL1uJxsnH/Usw5rzOg2R?=
 =?us-ascii?Q?d2BWwT3M+eCz5qyu55GS6J+KUmh+y/2AFDfqnwRvYwylnitzFBr3P2jNp+hZ?=
 =?us-ascii?Q?MA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5490.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 408e0935-fc0d-4d7e-4c43-08dc119f5319
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2024 05:45:17.0823
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TA5TeHYesHAjLYgeaifiWVatp5P3sq6jpHrkBNnwhYM3PHQNF5EvKPugx4e9IKgUZmQeTiEefaM7UFYql40vBIwEzWYIchv1ar6Mn0FKXgI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5239
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Serge Semin <fancer.lancer@gmail.com>
> Sent: Monday, January 8, 2024 4:39 AM
> To: Swee, Leong Ching <leong.ching.swee@intel.com>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>; Alexandre Torgue
> <alexandre.torgue@foss.st.com>; Jose Abreu <joabreu@synopsys.com>;
> David S . Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Rob Herring <robh+dt@kernel.org>; Krzysztof
> Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley
> <conor+dt@kernel.org>; Giuseppe Cavallaro <peppe.cavallaro@st.com>;
> linux-stm32@st-md-mailman.stormreply.com; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> netdev@vger.kernel.org; devicetree@vger.kernel.org; Teoh Ji Sheng
> <ji.sheng.teoh@intel.com>
> Subject: Re: [PATCH net-next v2 3/4] net: stmmac: Add support for TX/RX
> channel interrupt
>=20
> On Fri, Jan 05, 2024 at 03:09:24PM +0800, Leong Ching Swee wrote:
> > From: Swee Leong Ching <leong.ching.swee@intel.com>
> >
> > Enable TX/RX channel interrupt registration for MAC that interrupts
> > CPU through shared peripheral interrupt (SPI).
> >
> > Per channel interrupts and interrupt-names are registered through,
> > Eg: 4 tx and 4 rx channels:
> > interrupts =3D <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
> >              <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
> >              <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
> >              <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
> >              <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
> >              <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
> >              <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
> >              <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>; interrupt-names =3D
> > "dma_tx0",
> >                   "dma_tx1",
> >                   "dma_tx2",
> >                   "dma_tx3",
> >                   "dma_rx0",
> >                   "dma_rx1",
> >                   "dma_rx2",
> >                   "dma_rx3";
> >
> > Signed-off-by: Teoh Ji Sheng <ji.sheng.teoh@intel.com>
> > Signed-off-by: Swee Leong Ching <leong.ching.swee@intel.com>
> > ---
> >  .../ethernet/stmicro/stmmac/stmmac_platform.c | 28
> > +++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> > b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> > index 70eadc83ca68..ae6859153e98 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> > @@ -710,6 +710,10 @@
> EXPORT_SYMBOL_GPL(devm_stmmac_probe_config_dt);
> >  int stmmac_get_platform_resources(struct platform_device *pdev,
> >  				  struct stmmac_resources *stmmac_res)  {
>=20
> > +	char irq_name[9];
> > +	int i;
> > +	int irq;
> > +
>=20
> Reverse xmas tree please. Also what the point in having "i" and "irq"
> defined separately? Wouldn't it be better to merge them into a single
> statement:
> +	char irq_name[9];
> +	int i, irq;
>
Will rework this in v3.
> >  	memset(stmmac_res, 0, sizeof(*stmmac_res));
> >
> >  	/* Get IRQ information early to have an ability to ask for deferred
> > @@ -743,6 +747,30 @@ int stmmac_get_platform_resources(struct
> platform_device *pdev,
> >  		dev_info(&pdev->dev, "IRQ eth_lpi not found\n");
> >  	}
> >
>=20
> > +	/* For RX Channel */
>=20
> Why haven't you added a more descriptive comment as I suggested on v1:
>=20
> +	/* Get optional Tx/Rx DMA per-channel IRQs, which otherwise
> +	 * are supposed to be delivered via the common MAC IRQ line
> +	 */
>=20
> ?
>=20
Sorry I missed this, will rework this on v3.
> > +	for (i =3D 0; i < MTL_MAX_RX_QUEUES; i++) {
> > +		snprintf(irq_name, sizeof(irq_name), "dma_rx%i", i);
> > +		irq =3D platform_get_irq_byname_optional(pdev, irq_name);
> > +		if (irq =3D=3D -EPROBE_DEFER)
> > +			return irq;
> > +		else if (irq < 0)
> > +			break;
> > +
> > +		stmmac_res->rx_irq[i] =3D irq;
> > +	}
> > +
>=20
> > +	/* For TX Channel */
>=20
> * see the comment above
>=20
> -Serge(y)
>=20
> > +	for (i =3D 0; i < MTL_MAX_TX_QUEUES; i++) {
> > +		snprintf(irq_name, sizeof(irq_name), "dma_tx%i", i);
> > +		irq =3D platform_get_irq_byname_optional(pdev, irq_name);
> > +		if (irq =3D=3D -EPROBE_DEFER)
> > +			return irq;
> > +		else if (irq < 0)
> > +			break;
> > +
> > +		stmmac_res->tx_irq[i] =3D irq;
> > +	}
> > +
> >  	stmmac_res->addr =3D devm_platform_ioremap_resource(pdev, 0);
> >
> >  	return PTR_ERR_OR_ZERO(stmmac_res->addr);
> > --
> > 2.34.1
> >
> >

