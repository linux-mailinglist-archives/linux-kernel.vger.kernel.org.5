Return-Path: <linux-kernel+bounces-48828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21597846221
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 21:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A449B28CEC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 20:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B74A3BB2D;
	Thu,  1 Feb 2024 20:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UwVpOCKH"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C2C3CF40;
	Thu,  1 Feb 2024 20:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.55.52.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706820429; cv=fail; b=nRnGOQd1cHEmR9kvSCutaivfZJyw/TMCYUibaeMTHOTq0CJe9tNympHxl13rgJZDp+SfxCL0db/X020tUkCNq8W7YHro6MaQGCNvaKh/Bc1y0UUUHc6XnKt9CkeQMdlS+EUumtkIG2N6FdgF9U8LizxnI9iO49T8lo0U7WxQmfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706820429; c=relaxed/simple;
	bh=wT3xf3UrUlUUfc0Ty6ggosFPVbzK2GV7tXxCxW2yHgs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J9MmFy26gP+oRHsVZOOR7HFPylRDOl/PlyNSQ80KAGX5150XFM7BPw5y5Ih9Pg96jkwtpH/KuOY32E7P8ce8tS2gB11/GFMF3HYTh5WTJ8cspMjDEDQND90dhHIY4h6s6bEfOcETs/yJnWlvD/UBO69EMXJCqcogrO84rglmBTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UwVpOCKH; arc=fail smtp.client-ip=192.55.52.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706820427; x=1738356427;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wT3xf3UrUlUUfc0Ty6ggosFPVbzK2GV7tXxCxW2yHgs=;
  b=UwVpOCKHjX22rc1QWCK1Bd9bzNmFwFU7qZ7A00c2HXbOFZYBeWB0uGqj
   VaVMOcFa/w+8jlB87x/Kn2xyJQOEBZSvGO7q0j70Shl3sRKCK2PhlxRdz
   PaEU+CGiGqzA7oYdP869E97KPzuRlW4EKX2QJFKK4GK+DLYossedUgAeo
   Ntm+2ExTUy7X7DX1dRDQltLExLcepnm/K0sa9Wwsw2CnhLUegOAxAjb9a
   52RZyv4LfE7gjSsh59q4U7QwVooLITEuTspErVMppNDSmvNjH2o2O7h8j
   JCpcUawKA8LGGLb4sGMvGPDMBuQ6t44l8eBgsiMXWCyIcqIQIY7ux1YZg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="402844189"
X-IronPort-AV: E=Sophos;i="6.05,236,1701158400"; 
   d="scan'208";a="402844189"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 12:47:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="908367314"
X-IronPort-AV: E=Sophos;i="6.05,236,1701158400"; 
   d="scan'208";a="908367314"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Feb 2024 12:47:05 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 1 Feb 2024 12:47:04 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 1 Feb 2024 12:47:04 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 1 Feb 2024 12:47:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cv1XTt/lIrl2fKrN1da3e33U72q+rGH4/zP1K2ijAWrgwDZG8EhCtIdX5HCpJ0s3ZGC4P1ng7d9h2/mwolqOSo1cdcO8s1Iry8d8CdZvOzJutauvj+BdvdKPgESAjnCb2BPV0xomjO1lKTjl5nPC5ezOnjBZjfOUrCpSlb3UQ7Xt0mokJ84yzQVjZoPuORYxxVzlV5CPYavwtfZBwifU7duU1+5dXCwhrhXAhhkj0138xFQix3QoM2y3NzotOXqIwumskHpjYHw16xga4Cph0rPNZh6uVDnVGrqRG1Y4MkSVpbZ5low6ehTAdtxV4rzh7TfBPfhUv1GzU9w8YBjrOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B3Cv+JjVvYaJc0G+Pv1rdEkr67p9d41tPR3aSNHSbhE=;
 b=fXIC6kvdRT+LzQVVJpUHAHSuUEmgWD52PO467v+1kUKZyDV6i9HN/q3t6qgbwM4EMZt5ZOT6iT41gf8DzXRbESJG0MSDHas/0wE1+8nRQ9vvoeyudfUP//83VtDYWD6CqONuHd6HBC42y0Dbuam2J9phiCIVyrMbwEB21vgbGJsQyultuG4rqQfVM5ch2oNtUNRGKlRWHJnEcZQx8dX8aPgaT05UYyEyDBWLqzThIjwKZrBncD4fTI6H+xFlDdL5Wz6BM02WHSt6HcNmidZit9A3vJzNbMFiJXwrXTPwkyPrk4Vy1+98iGp5u/QsZiqWgZm+V4Le95e5G6q0EnFVZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CH3PR11MB8384.namprd11.prod.outlook.com (2603:10b6:610:176::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Thu, 1 Feb
 2024 20:47:03 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::7103:9cf7:fcc0:e802]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::7103:9cf7:fcc0:e802%3]) with mapi id 15.20.7228.037; Thu, 1 Feb 2024
 20:47:03 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
CC: Borislav Petkov <bp@alien8.de>, Aristeu Rozanski <aris@redhat.com>, "Mauro
 Carvalho Chehab" <mchehab@kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Li, Lili" <lili.li@intel.com>,
	"ricardo.neri-calderon@linux.intel.com"
	<ricardo.neri-calderon@linux.intel.com>
Subject: RE: [PATCH 0/2] EDAC/{igen6,i10nm}: Add EDAC support for two Intel
 CPUs
Thread-Topic: [PATCH 0/2] EDAC/{igen6,i10nm}: Add EDAC support for two Intel
 CPUs
Thread-Index: AQHaUntqeLPIHg/x00SS/sl6ntrMbrD1+jZg
Date: Thu, 1 Feb 2024 20:47:02 +0000
Message-ID: <SJ1PR11MB6083A37E3A43C7055B5B4203FC432@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240129062040.60809-1-qiuxu.zhuo@intel.com>
In-Reply-To: <20240129062040.60809-1-qiuxu.zhuo@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CH3PR11MB8384:EE_
x-ms-office365-filtering-correlation-id: e4690d72-84d1-466d-831f-08dc2366f1c8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MpWA1CxpRVjl0wcpsscHHTeu6JHuv/GBaN/b+ybtkWpKZ8cjytgvWaysABu+zM4K3qBw7+vL1k2ryOT4fU22B6JHQHy8N/0e2xwzuIvdcE8uQw8+INAjOQucBTgP3zysrbO8Ipq9jrOFMfyQ0lq20fCIWVpu7SwNC+KZ5fkYpAXB4oe+wcPKm50NN1sE+hshrDTRWjogU4zRT27HV8/COV2Li3Y4DxQzCuuGNuAcVafuJmzU/nNQ+Gc0H298qudOBEWO97TfURqvZ6PHmRwxCXDFxPTunwxb/7fajWeIONoSdxK+pFevv7yv40hiZKlR2w5dC4LNr6+P5ggsqPlmSumQjxloCkBqyixA5mtlJg5cPkUSizrseMx0Lh1e0WD3gZ7Kxdygx5gaZuRK0BFfzu8U3oFSsfrjvEjvKR8rSPJL51xcqiYEdxJ44cNvq+4JaWKvb8SsgiZXXlDdA6Vsjp7F8A/3WF7x4VYzysWxPFORYAq47eknK2xXFIc7yaaTreQGSmNTnkA/eSirb6Ke07//W5q6skzgMIfInuL6tuk9kNZrmt/pT7IJBSRBCwwU0HIYIDnZHAoAYcp0rRL+j6bslLGeMIzUHbJ3SGxw+7tcxpLBfrafWBm/e4UtFLLS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(136003)(39860400002)(346002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(71200400001)(55016003)(86362001)(316002)(64756008)(66946007)(54906003)(66556008)(76116006)(6636002)(66446008)(66476007)(38100700002)(122000001)(52536014)(4326008)(82960400001)(6862004)(8676002)(33656002)(8936002)(478600001)(9686003)(6506007)(26005)(5660300002)(7696005)(4744005)(2906002)(38070700009)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ijVOrzbR6tUgeFF5aDbMPvJe2LIKMaanhkSw5ORan+P/tp610emgJLbxyItc?=
 =?us-ascii?Q?Go7T0UTU6jlzSqq6gWt8Epz9SDk4wdxAocKX1gzNzQW8pdlQTg+Km4coGAdw?=
 =?us-ascii?Q?fq6Gwl4eW+j5jQVtY4y2842FSsY0+T0uOSWE5/k09f/+EiqrTuE3bC4VeSZs?=
 =?us-ascii?Q?Wc3Xfshhl3pHA2p5mEr09I0I68H91o2VQaqO4V0n+zHkXrtDaow8+eq6YTCW?=
 =?us-ascii?Q?jddMjcAntyamuTh4oBS6Z08y4Cl2cIAIqnZPCTnFhWizZtWA/DYQl3PxxK3b?=
 =?us-ascii?Q?689UYQt0j8KfxTryHclYvoyOVasjvx1PIjaE8fl0VSGN1wCCn0L1sXAhZ7Lc?=
 =?us-ascii?Q?GvfTFjIubdobp0mek4ZkTuzEutTxnW/QSfp6TFa70b52unAnH3/JvO9iKUw8?=
 =?us-ascii?Q?q6S1ukS8xuglqzlRJcso40M05D3pSpzXm9Mc/e7cyI5+xuKDwah+K1oIscW/?=
 =?us-ascii?Q?6T66/32UAAsLvT5TPYhbdYG1ky5RrDLMk8RS8fpv5/nwB7Gj4rFQAHOhEf9d?=
 =?us-ascii?Q?jxmYsM6XRqG3b7yguU5oJ2gii01/6FyHZ5PnDLYXqtEMlQv9Dq/IRoFPdYaJ?=
 =?us-ascii?Q?7ib7w4puCB9GORv998TNL8cWWctF1dZnsXNqBRRIltLufSvck9vARuDYM+su?=
 =?us-ascii?Q?h1maGfGFe28atzK6Qn0hRd59nJyR5hlPxKZYEttYDltJnlH+WHMrvL0bjD9u?=
 =?us-ascii?Q?GLzw2MIuTdkn/y735wb7PJ4UZTdVqSQLFav3HJiCJENMvPEPIOyikv68Ldl1?=
 =?us-ascii?Q?jjsnPIe/cwPvoAWWzkUSqM8DPBYLKUeY/LDjWvksAe8qkU2IToemYYOKu2ZD?=
 =?us-ascii?Q?qCJzONLaNFTMBm3dCFUG2/a9885XopuTPxfh0nxpcnRRkjO/QKTHqyeVa19C?=
 =?us-ascii?Q?9u+T2lNgclSCW8uSEKtOYX6JqMMtCINztwmaWlKSbVwAL6sD7c1+CT5jajSS?=
 =?us-ascii?Q?H3zBdvRikndgp1xFksrQyi13hL1AkmuN4y0P4tSXWn1/zIwiw80EEdMwx16A?=
 =?us-ascii?Q?joDdnDilE9qVd4/qEh77gouMp6s4COW+RGjz4/jYhgsZOpv0/IbddNnb+ehO?=
 =?us-ascii?Q?c7KAR4OkrIx/F65d1UN8NfJoH0NHF7nw78go/jqU92A2SajHUZX24Zbd5vn8?=
 =?us-ascii?Q?xuDsgeyhUYmsCLffDHAPoIA1klKCp0KJeGTo5OFr4mPfCjmyUjHlF7EJK1Px?=
 =?us-ascii?Q?ObrWB8BVc9cUavkvMw42Co4XFwscdoN+G9SU7SWlTOjt6MUXIIDOF6L8iZLg?=
 =?us-ascii?Q?ev8Re25pQagEBQGny5VfGVxeFIxr4xigoZef/Oks+rBlleiLChD7JYl5KdSL?=
 =?us-ascii?Q?3A2K7bl41oHE48gab0gvL7LtukVF38XTPgESd4fTzLRxfcsTdkPkzOoJGohg?=
 =?us-ascii?Q?tmDOuWBo1WC5VSKtb7DdQg+Qns02ThKWyDsDjd4Ro1G/fjvZsFVavFRE8Iqi?=
 =?us-ascii?Q?w4chmKuwTYDfyMt5dch5VBgJ7H+o0CupBjA9QgDm0xqQnAsUr3DiVV+Loo9+?=
 =?us-ascii?Q?cUGLJz0L+65jCImfniJdA5Lhh8Hgi4cMnDaXqaaq7PJdoe5YSt9U8OmWG6SL?=
 =?us-ascii?Q?odzUwiD5GQn0BNxpsU6xtEfZJwIhmOIEq+fpbE2N?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e4690d72-84d1-466d-831f-08dc2366f1c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2024 20:47:02.9771
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cQWHxckEJVJNnx9CBBfTgbgjqL+JUIl2c+gT5rpTqVo9NTVkpErAglhq0P5Hn5cOsv9N5WQ+4tLjYFx6qI3K8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8384
X-OriginatorOrg: intel.com

> Both patches solely add CPU IDs for EDAC support.
>
> - Part1: Add a new Alder Lake-N SoC compute die ID for EDAC support.
> - Part2: Add the Grand Ridge (micro-server) CPU model ID for EDAC support=
.
>
> Lili Li (1):
>   EDAC/igen6: Add one more Intel Alder Lake-N SoC support
>
> Qiuxu Zhuo (1):
>   EDAC/i10nm: Add Intel Grand Ridge micro-server support

Applied both patches.

Thanks

-Tony

