Return-Path: <linux-kernel+bounces-156722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24CBD8B074A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD631283435
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53AC415959F;
	Wed, 24 Apr 2024 10:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SNAZOfQw"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353E4159562;
	Wed, 24 Apr 2024 10:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713954379; cv=fail; b=SGPCYRIDrnPGCShGbdFqozoj2m1W81gFv8UbXdBCli+dG/VsFm6r+EVhHEqUTiCHrQmCvC1Zms5iwmVlstl7Dr5oq6vLYiJtSVg58RvkT7gFhFH5Iwuj6BnAQ7/U1HPGQYWh5UfuClQo8sfEZJHsU+Ea/Cn+8q8gsSKapE/FrzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713954379; c=relaxed/simple;
	bh=WogJM5tQJeMRiR46FxpEQkIGNVUBHjOEYY2BnDRZSHI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L14rIHBUaxp64p3lAYkDDnbA1WJoz97VIG+O17cfN+80IUrtNfhCf95NtXmAZWraaO3ensb4SI5PrYcWS7l/q+97NWCE63vQuu9ZwDkcRC1/vDgKVw/cUkAo2HmpPM5RoHei/rlbeq1xLwQnBoUAOepuw9y8MjRRYEi+PGqR2zE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SNAZOfQw; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713954377; x=1745490377;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WogJM5tQJeMRiR46FxpEQkIGNVUBHjOEYY2BnDRZSHI=;
  b=SNAZOfQwzuKwG82koUeQt4Ru8tOw+5D+2Ys7StxOVLnvKflUAGnu+L2z
   tywYjU3aFug5dXpoijiBeM/ViFb4zJ9yT4Vh3yj20pqfG2xXalM9gyDia
   vXi6X+FgHOxkvcA6T4wpNqTpQEpcWz/oWYB/pscbOYpLrP0+Na2IDKkrt
   OG5l1MpMahqLL44ETagQZEqdW4z9GRUqEtLp3jvQKFLVE6Wr8nBQof/wE
   yU+dzYtjlVf31uwZ9TdetuutWGlJHcw4s6Y3RBycpVSqBpgDDIde2p/Qw
   S94/Ax5LAmQlukJSw+guyrvjODYDN8rSM2aSlMDqBeqibj0gDEI7vOsPc
   w==;
X-CSE-ConnectionGUID: fFQHdUgnQ7SeFc+HMcJCmw==
X-CSE-MsgGUID: WzRK27/9RFqUc47EhKUmKg==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="34979063"
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="34979063"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 03:26:16 -0700
X-CSE-ConnectionGUID: aIxN7gFJTcavimadS0gIhw==
X-CSE-MsgGUID: KdW+Y7Q1SKSu/yC3oTDl+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="24731945"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Apr 2024 03:26:16 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Apr 2024 03:26:15 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Apr 2024 03:26:15 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 24 Apr 2024 03:26:15 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Apr 2024 03:26:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LYo/Kq0x86RUdmGE037L3jjs7VaIFn+dCLpb1MJ262lb0yp7tOk9Z6gFNbu0oF/zjH0R780OWt9Hye3rdVChtoSkI35IWPQrGbmtL1mVVKaL9q4NnQYeoVaMK2zcp/xieBOaeX2TqQrqWZqeBEKT8EOM7eDaY16F6gnnUA7/ET+d+yuaO6oy0is2pj5LSaVF/BCsc8Wjpr+g/8Np9mEDcOoZs852sN9Lebu7fjWnyoxeLtRH++JyhibZJPjp7WJBL0YjUZkuJazzeBO+Nijf7aMiHnMzaEIyAppfZ7SdocaaT4blFEuA0t0tg+AWGyn1U3b7TL6MiAGhK0ALe1O7VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8PPty72U7xZLWlJtE+PRFPQhE4amxUKeOdwHw0PaA+w=;
 b=bJ5Tf7Y0+Y37eWXZXw4fwsdmgrYctK/pzMLqftiEFCiIjaCJnTg6CE+APYmuhQUa3uBhZAPZgo1qIcbEx10VlvfxpvNsbd41cr3v/SIwsaqmNaSxlA5aq4kBAj/uxDLl8YT6MEXkYvCK4KwCubpKCXh+sbWL4aWKx4aqmvTnaOU5KC7nFk9SI2Z6NyaC72m3nTYOx5J+gsZ4yXZJlvAYyyQpZ40MZDNNRS3lV+XpycQe7fWryFnC+oD3PW5XPVNumveeaJRCTmBONtuIVyW2Q1wEmB2Jli1B9Nh/vawxOn2mBtVYtk079DQ84OJXke1YCNLuQhXdgoB0kqXOM6OZ0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 SJ0PR11MB6813.namprd11.prod.outlook.com (2603:10b6:a03:47f::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.24; Wed, 24 Apr 2024 10:26:12 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::7d7c:9a51:767e:730a]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::7d7c:9a51:767e:730a%3]) with mapi id 15.20.7519.021; Wed, 24 Apr 2024
 10:26:12 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"davem@davemloft.net" <davem@davemloft.net>, "rrameshbabu@nvidia.com"
	<rrameshbabu@nvidia.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"kuba@kernel.org" <kuba@kernel.org>, mschmidt <mschmidt@redhat.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>
Subject: RE: [PATCH net] dpll: fix dpll_pin_registration missing refcount
Thread-Topic: [PATCH net] dpll: fix dpll_pin_registration missing refcount
Thread-Index: AQHakpL1PxeMlLmpYEyEiHJJwvzNZLF0TZAAgAFoi2CAAAQgAIABguYA
Date: Wed, 24 Apr 2024 10:26:11 +0000
Message-ID: <DM6PR11MB46573DA3B0B44BAA25F2CF759B102@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20240419194711.1075349-1-arkadiusz.kubalewski@intel.com>
 <ZiZmpg7GF99Ihxk0@nanopsycho>
 <DM6PR11MB465781953B5600F67C96AA809B112@DM6PR11MB4657.namprd11.prod.outlook.com>
 <ZieYjuoRl61WCVZg@nanopsycho>
In-Reply-To: <ZieYjuoRl61WCVZg@nanopsycho>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|SJ0PR11MB6813:EE_
x-ms-office365-filtering-correlation-id: 7ced1df6-d2b4-4d11-7a70-08dc6448f6cb
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?bui/Ox5dqPQOXmTWjFzDwY4GFo9q4MjLtwdUUvCM09zQ4rMuyWX3XEV7bu2S?=
 =?us-ascii?Q?ZpIjYl05zrY3aV88NN7aBDfMJCVKd0gOYzcBFBSATyu723SI/CxKWYVzbnyN?=
 =?us-ascii?Q?f5oTc+BeWTVh16vxrUGGkkiaNNmbxly3AotK5UOujbtHuzZs4wNmdKo9YHkZ?=
 =?us-ascii?Q?+76qVnFeTWgsYQgHgfz4Rz9+m6PKT9mJqke0LYvBLvdjqSf4EApAhqf4sGwF?=
 =?us-ascii?Q?4SgaSPxHoSTAylrP1MWlt8xu9AVlFRiZnmuAZR/iGASvE/3HUGdxfv68Ww1Z?=
 =?us-ascii?Q?IMxfhJL9XdWaSEywtbNJI8uQKf9+aYwASyFVaJo+QV5ANezA6voNhM+eMve9?=
 =?us-ascii?Q?2XD5zYFWVtCdcOc5SWOtwWwKAMxbAGQKoasTuIPua5JEuzdx1Fy0nZjazZt4?=
 =?us-ascii?Q?/ujrRwSPGRtB8I2rf2IzkLD0vrrnSNUyTVOvZOrgyI+amVTu+o/gN5O+CvY3?=
 =?us-ascii?Q?d4Kca+AVJgOOFq/KaHKjBR7GrxB9EZ3rZsd0WSjhY1EgPCzKitiNaf5EertP?=
 =?us-ascii?Q?PsDUAdVqC3LTo8iVs3zBnO6eCrfm+MzNrg06E9pyHE9yOl5WfzZdaCu5c/c8?=
 =?us-ascii?Q?b07Pxtys36FdwFexSBf6EjcA9wIMALYK5+83fEbzX39ij0eQopso+1zmAKV2?=
 =?us-ascii?Q?okm0wB88+rhHJw2aj4pDTBBY2OSIn5xK40PetvbI/NOOvot0nLGojudyrgal?=
 =?us-ascii?Q?UaAlfkkK1Zu5daqduKIZjqOS+vGpHHpzYHQQJfA0ZZ2FaQ+ereMtbpRaQZSI?=
 =?us-ascii?Q?pXR9nNYlCxQ+HQYUJEerc5n2jcP0vmaGxTLMwIYzE7c48dZdUUrtN9t3+TT0?=
 =?us-ascii?Q?WrzkQCpEQQZYwKN2i3qwNzTWozD0RQ60Mjt1dmsmACGSMPGSoFkXfZTIoFBt?=
 =?us-ascii?Q?Lz0TWKISL91ei6mBBqXB4cSKOoqzKQAiHSGZQ78GRWEGPBIx6NRN+ASnLZiV?=
 =?us-ascii?Q?s6mfbTMTNfC2LonQLMsVUvTSLsOmFmhuXU1dv21ziix+6reDFcEf8uRcXQzc?=
 =?us-ascii?Q?B0fQ5Nbd0LaIq7Y/Gz8fUtWLxrRWRTTkWMSWYvIhPiMijt9UTeaeJHJwT4Wn?=
 =?us-ascii?Q?eOe+E9saAgj0QrnXLEyRdzpP8XrBPMaiCpXdwCOQCHyKvTi+kfHDliPQ2k6H?=
 =?us-ascii?Q?hZkNMeeaRyxv1eCH3t6KAa67stHBbrnYnrUR/Ob7txGe/jewHzFBPHbhzg4z?=
 =?us-ascii?Q?HweoqIKapky6xMLJgo055KfLaqu1jgQe1HuXL1RRUHs2d2mmx3wx51Zk/kn+?=
 =?us-ascii?Q?EmHTDZMMs6QyXdJo2GCq29gM+61U+97MicvW+krgA5IU25AmGb/bhxMZUhLf?=
 =?us-ascii?Q?jXiuRPLLJAeCwVHKqtUio4jIaJjpqv3nKIowZCxUHORMSw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7p73h/dbQUT70jcE3hGW8GOuXVCYwgn1t/rLZxH46YIguDdMRsW2Mu218HbR?=
 =?us-ascii?Q?QQ6MsssRAd7/19CAJrmRLyX4HN5MTgz0lLweClm7a6HWG0RvYvid91/eP1w7?=
 =?us-ascii?Q?Erzxp9jidSu2uxp3gaGI1ALf3/wrpfwPd+4Idq1Jho7QID8dI2IOVVKt5IZw?=
 =?us-ascii?Q?LnDLRueFVmnsGlaUFXI5cQutfkJZjtWQXLGk0oBLQ6lvheumWjOJXiOxVBf0?=
 =?us-ascii?Q?EO1rteZLCOPsRa0dqNFUk6BwQLexBvJSNk6HH4DFl0Qr/RPUee6+rU8uwg2e?=
 =?us-ascii?Q?YYtGZti9l3pwfAO7RCC/fto4MUupLX5mPlcMb5pLXrtiVnW37F9Zqjg++ZQF?=
 =?us-ascii?Q?sziKeWQdbGo+e8xHLXPXExHNjxpC6PtMCtzRedIeMFSnRSmyWl5NmVQMU5pd?=
 =?us-ascii?Q?a19GykEqiSURfBjmcN9nIK9VhMMpvDGN4QQCw8Zb8heUpVCkGbbjHeQ/j5uN?=
 =?us-ascii?Q?WlDXRXv6Lx6MNT28TuZ8G3ik8bk/MqGAnr5BSSt7LxabQuXyWF1eFsdBjS1q?=
 =?us-ascii?Q?TaYYAGgMQCRv1UVSTgl2oqtxG8lzJ9JBmOO3YA20UfZF1rGc2fT89zlG9JKI?=
 =?us-ascii?Q?NUNCOiTx0rP8zm4Lnlo/axjPemC+hkk8+K2DgdVMirmH1oeUyuMWMDjn9gSL?=
 =?us-ascii?Q?Vw5AMMqvPraaiIS/QmpRmOXw7ApaMEHcKRNaoAzGFE1CojWW/A3/hXqOHfLH?=
 =?us-ascii?Q?6r+G3nWFbAHm/DSxXmHoC8aPHH6NGjEr6diTegu7eR0h3Z3JOElfOCgxUXzb?=
 =?us-ascii?Q?YiL/A181XEviDBh0/RzzylgL093WW4pwly4rWFwy3n9GwSVpCx022xiqMj3J?=
 =?us-ascii?Q?ZxN9770dHtpZ0k2lvgT7iorTLYXqDfpeo9EqKS7vhFi5Fxv0sIARxLYGeEmy?=
 =?us-ascii?Q?quxpoia5/u+7fXn+UqxEcTI8GLcePk9RGE8vajaGJ+yZkQkBSdypmfGglqRc?=
 =?us-ascii?Q?U5LtRULAQO9ZXWM51DoLVcocCxOQeusmYbBbVZU2xyeG1TUcagwQM6CEMyDF?=
 =?us-ascii?Q?QROZBtIdnML31xu0YcmmH6mMJkEreXmiVzQMcEmAMrUwwgN5eH0pN/h/AEW7?=
 =?us-ascii?Q?MLIGRGNGipMewUxFv5XBaqw0RE55oTc0THxTjO3/VdI3y8gZ6bZJEmAqfA3E?=
 =?us-ascii?Q?w+flz/XMS9ztroQTfK0CXr7IsFW4Z73yowcCD+sVNgLahUijvYzv6aSf6zSh?=
 =?us-ascii?Q?Vu4pQoZnd/BD+CW8grlvuWsJDzoriDYFApfxExCjACd8ClkTbi71I9dtPeno?=
 =?us-ascii?Q?qN/wy+sAwbH6RXiiaZG70Ggn1Zu9Jl9N0ZZioZSPOdwvpCSXXPbgX1AgqGFA?=
 =?us-ascii?Q?VpFnn/7f44Wzp0O2ORWqQHKDHN7Rw4Pw7j73fW64M5dzEWueLUe9mlEM9Fv3?=
 =?us-ascii?Q?S2+a0yUa4un4fQ/oFUKftk2Bjv45eDDGt1vWddY1t4RhAAExnTZfvpqpL8nF?=
 =?us-ascii?Q?fxEypoU8PFRcWLZkgN1neJdJlkx8+5Q70EGXsHh1VMveMnZ9FxyYROWb0fw2?=
 =?us-ascii?Q?yPbV8D59ZTs1i6DQK5v0qZF1Y5w9Ps2yff/RmRoQbl0D361Xql1S0NlRuOsd?=
 =?us-ascii?Q?nLElJqSNwtl1AxEXfyeK9pP+rthQPxW/RxwpUDjvYQMtnw2ngXP0CZd05aIP?=
 =?us-ascii?Q?lQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ced1df6-d2b4-4d11-7a70-08dc6448f6cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 10:26:12.0504
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iuGvlr4uxxG1XuGYpsUXEF56lU/948BqhzZFibb9v2AwMt6RdGrikz3A8bCLeYMOOTyY+YsGg8MY53muVX0kA4/RfkqGMxs583pgAStp0Ak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6813
X-OriginatorOrg: intel.com

>From: Jiri Pirko <jiri@resnulli.us>
>Sent: Tuesday, April 23, 2024 1:17 PM
>
>Tue, Apr 23, 2024 at 01:04:22PM CEST, arkadiusz.kubalewski@intel.com wrote=
:
>>>From: Jiri Pirko <jiri@resnulli.us>
>>>Sent: Monday, April 22, 2024 3:31 PM
>>>
>>>Fri, Apr 19, 2024 at 09:47:11PM CEST, arkadiusz.kubalewski@intel.com
>>>wrote:
>>>>In scenario where pin is registered with multiple parent pins via
>>>>dpll_pin_on_pin_register(..), belonging to the same dpll device,
>>>>and each time with the same set of ops/priv data, a reference
>>>>between a pin and dpll is created once and then refcounted, at the same
>>>>time the dpll_pin_registration is only checked for existence and create=
d
>>>>if does not exist. This is wrong, as for the same ops/priv data a
>>>>registration shall be also refcounted, a child pin is also registered
>>>>with dpll device, until each child is unregistered the registration dat=
a
>>>>shall exist.
>>>
>>>I read this 3 time, don't undestand clearly the matter of the problem.
>>>Could you perhaps make it somehow visual?
>>>
>>
>>Many thanks for all your insights on this!
>>
>>Register child pin twice (via dpll_pin_on_pin_register(..)) with two
>>different
>>parents but the same ops/priv. Then, a single
>>dpll_pin_on_pin_unregister(..) will
>>cause below stack trace.
>>
>>It was good to add a fix in b446631f355e, but the fix did not cover a
>>multi-parent
>>registration case, here I am fixing it.
>>
>>>
>>>>
>>>>Add refcount and check if all registrations are dropped before releasin=
g
>>>>dpll_pin_registration resources.
>>>>
>>>>Currently, the following crash/call trace is produced when ice driver i=
s
>>>>removed on the system with installed NIC which includes dpll device:
>>>>
>>>>WARNING: CPU: 51 PID: 9155 at drivers/dpll/dpll_core.c:809
>>>>dpll_pin_ops+0x20/0x30
>>>>Call Trace:
>>>> dpll_msg_add_pin_freq+0x37/0x1d0
>>>> dpll_cmd_pin_get_one+0x1c0/0x400
>>>> ? __nlmsg_put+0x63/0x80
>>>> dpll_pin_event_send+0x93/0x140
>>>> dpll_pin_on_pin_unregister+0x3f/0x100
>>>> ice_dpll_deinit_pins+0xa1/0x230 [ice]
>>>> ice_remove+0xf1/0x210 [ice]
>>>>
>>>>Fixes: b446631f355e ("dpll: fix dpll_xa_ref_*_del() for multiple
>>>>registrations")
>>>>Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>>>>Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>>>>---
>>>> drivers/dpll/dpll_core.c | 17 +++++++++++++----
>>>> 1 file changed, 13 insertions(+), 4 deletions(-)
>>>>
>>>>diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
>>>>index 64eaca80d736..7ababa327c0c 100644
>>>>--- a/drivers/dpll/dpll_core.c
>>>>+++ b/drivers/dpll/dpll_core.c
>>>>@@ -40,6 +40,7 @@ struct dpll_device_registration {
>>>>
>>>> struct dpll_pin_registration {
>>>> 	struct list_head list;
>>>>+	refcount_t refcount;
>>>> 	const struct dpll_pin_ops *ops;
>>>> 	void *priv;
>>>> };
>>>>@@ -81,6 +82,7 @@ dpll_xa_ref_pin_add(struct xarray *xa_pins, struct
>>>>dpll_pin *pin,
>>>> 		reg =3D dpll_pin_registration_find(ref, ops, priv);
>>>> 		if (reg) {
>>>> 			refcount_inc(&ref->refcount);
>>>>+			refcount_inc(&reg->refcount);
>>>
>>>I don't like this. Registration is supposed to be created for a single
>>>registration. Not you create one for many and refcount it.
>>>
>>
>>If register function is called with the same priv/ops, why to do all you
>>suggested below instead of just refcounting?
>>
>>>Instead of this, I suggest to extend __dpll_pin_register() for a
>>>"void *cookie" arg. That would be NULL for dpll_pin_register() caller.
>>>For dpll_pin_on_pin_register() caller, it would pass "parent" pointer.
>>>
>>>Than dpll_xa_ref_pin_add() can pass this cookie value to
>>>dpll_pin_registration_find(). The if case there would look like:
>>>if (reg->ops =3D=3D ops && reg->priv =3D=3D priv && reg->cookie =3D=3D c=
ookie)
>>>
>>>This way, we will create separate "sub-registration" for each parent.
>>>
>>>Makes sense?
>>>
>>
>>It would do, but only if the code would anyhow use that new parent
>>sub-registration explicitly for anything else later.
>>
>>Creating a sub-registration with additional parent cookie just to create =
a
>>second registration with only difference parent cookie and not using the
>>cookie even once after, seems overshot for a fix.
>
>Well, we have ref with multiple references and refcount, single
>registration instance per registration. Now you make that multiple
>references and refcounted as well, just because the parent is different.
>That is why I suggested to add the parent to the registration look-up
>if. Makes things a bit cleaner to read in already quite complex code.
>
>
>>
>>What you suggest is rather a refactor, but again needed only after we
>>would
>>make use of the parent cooking somewhere else.
>>And such refactor shall target next-tree, right?
>
>Not sure what refactor you refer to. Couple of lines, similar to your
>version.
>

Just sent v2 with your proposal, please take a look.

Thank you!
Arkadiusz.

>
>>
>>Thank you!
>>Arkadiusz
>>
>>>> 			return 0;
>>>> 		}
>>>> 		ref_exists =3D true;
>>>>@@ -113,6 +115,7 @@ dpll_xa_ref_pin_add(struct xarray *xa_pins, struct
>>>>dpll_pin *pin,
>>>> 	reg->priv =3D priv;
>>>> 	if (ref_exists)
>>>> 		refcount_inc(&ref->refcount);
>>>>+	refcount_set(&reg->refcount, 1);
>>>> 	list_add_tail(&reg->list, &ref->registration_list);
>>>>
>>>> 	return 0;
>>>>@@ -131,8 +134,10 @@ static int dpll_xa_ref_pin_del(struct xarray
>>>>*xa_pins, struct dpll_pin *pin,
>>>> 		reg =3D dpll_pin_registration_find(ref, ops, priv);
>>>> 		if (WARN_ON(!reg))
>>>> 			return -EINVAL;
>>>>-		list_del(&reg->list);
>>>>-		kfree(reg);
>>>>+		if (refcount_dec_and_test(&reg->refcount)) {
>>>>+			list_del(&reg->list);
>>>>+			kfree(reg);
>>>>+		}
>>>> 		if (refcount_dec_and_test(&ref->refcount)) {
>>>> 			xa_erase(xa_pins, i);
>>>> 			WARN_ON(!list_empty(&ref->registration_list));
>>>>@@ -160,6 +165,7 @@ dpll_xa_ref_dpll_add(struct xarray *xa_dplls, struc=
t
>>>>dpll_device *dpll,
>>>> 		reg =3D dpll_pin_registration_find(ref, ops, priv);
>>>> 		if (reg) {
>>>> 			refcount_inc(&ref->refcount);
>>>>+			refcount_inc(&reg->refcount);
>>>> 			return 0;
>>>> 		}
>>>> 		ref_exists =3D true;
>>>>@@ -192,6 +198,7 @@ dpll_xa_ref_dpll_add(struct xarray *xa_dplls, struc=
t
>>>>dpll_device *dpll,
>>>> 	reg->priv =3D priv;
>>>> 	if (ref_exists)
>>>> 		refcount_inc(&ref->refcount);
>>>>+	refcount_set(&reg->refcount, 1);
>>>> 	list_add_tail(&reg->list, &ref->registration_list);
>>>>
>>>> 	return 0;
>>>>@@ -211,8 +218,10 @@ dpll_xa_ref_dpll_del(struct xarray *xa_dplls,
>>>>struct
>>>>dpll_device *dpll,
>>>> 		reg =3D dpll_pin_registration_find(ref, ops, priv);
>>>> 		if (WARN_ON(!reg))
>>>> 			return;
>>>>-		list_del(&reg->list);
>>>>-		kfree(reg);
>>>>+		if (refcount_dec_and_test(&reg->refcount)) {
>>>>+			list_del(&reg->list);
>>>>+			kfree(reg);
>>>>+		}
>>>> 		if (refcount_dec_and_test(&ref->refcount)) {
>>>> 			xa_erase(xa_dplls, i);
>>>> 			WARN_ON(!list_empty(&ref->registration_list));
>>>>
>>>>base-commit: ac1a21db32eda8a09076bad025d7b848dd086d28
>>>>--
>>>>2.38.1
>>>>


