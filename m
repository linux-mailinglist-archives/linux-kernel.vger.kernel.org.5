Return-Path: <linux-kernel+bounces-37633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C25D483B2DD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 21:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71DA128305F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 20:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3544913343C;
	Wed, 24 Jan 2024 20:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gupOIfzC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8544E132C34;
	Wed, 24 Jan 2024 20:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706127017; cv=fail; b=cWboA3DNcJ2gIJC+9CA6E+oBdp6V80IBK9L5+NrNHjoY+MX8uduSXfDEWPL3lEpMlE0YxKLXKwu7HiBT/1pa5Kxz2bExQI9jnF6ZAu0nOSJzC92IIvA1jmTZmbi7X3GDE0F8spztA8YX8hPI5S0P9uwir2rKw8Z/RMod6n5IFb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706127017; c=relaxed/simple;
	bh=unUrIJ0Kk8wehCoZtNUED4KKSz6OGuQppH3rrqygVfA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cTGmqdTdxOfivUdK4vAnVSTCOCt/M90AmDcZj9/dx1xvWrWUZ8a6xxIcbMbm+mcFQfEANVoZpWTOLLQQHuhWeoCbkBLM98rMfESXhENj+B2b78MF9j6pystgU49sgd1hvI2TgbZt1mL+NZgdp4eFRRRgcxnlgP4STRayUbTN//Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gupOIfzC; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706127016; x=1737663016;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=unUrIJ0Kk8wehCoZtNUED4KKSz6OGuQppH3rrqygVfA=;
  b=gupOIfzCcBgq+xE9WY+b70vALglPuN+UAFiPWBd0hw0wQd4GwBRb+Wex
   ZUGEh52lyaXVwGZkvSb/4svUf7C+tF9PUudyKqe+aqwyE8bz2L+XBRb6S
   GGqUW3tvI09eCC5o9BhL2eE/f9XM2zbTQzTDb5W2DUFts5RWxxysM5/cK
   jc6/YQKESrwRuaVlzv6osTNMWMyvHQB1V0kSliJJvgeLu8B17kDFabvZ9
   7huRF/wZcOcu7Y38gy0faYlBmp8HNiVBMm4/H8U/1t8eQ5Lfw6piL6Sok
   pwDfdaQ93eRTiy1PyUW0kFc1NGJhjEST/GYe3g/pW5NxN2ZNnYVHGB/Bq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="1853223"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="1853223"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 12:10:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="856820758"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="856820758"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jan 2024 12:10:13 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Jan 2024 12:10:13 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Jan 2024 12:10:12 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 24 Jan 2024 12:10:10 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Jan 2024 12:10:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=go+p8Q9TlXIzBDlUHH7gmGrrcJxzQIu5mntsOvnjuJnNq/AejHUrtYHBmw9VOBxPpFS1Z+5+6DH2UDTXH3GGiCDDD+VTSI3rdvGZkfs1X+Pfi0KCupesImg7Mf+iHylSqroZbscQzUHY77lxBQzmcM7ol6kKGgzTcAQsWyVJqHCKiKzCSsKV6urwSR27dMOdEu0SJpmJiPfruGlk6XW4sA2YIlq5k3cELTl+G4C7EMNtRACDP+DwfUMhSBavbRWC+a4QhKSNzchPBmKSolELQH0ByohdF4/COhFamprxbYhGX9kePD122pMUQLK9Ijf82/w1TAM6c3Ny46EDFRIsbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=unUrIJ0Kk8wehCoZtNUED4KKSz6OGuQppH3rrqygVfA=;
 b=cdxlkonXHtMsC+pGiOsw8cM52gho//QLCfnRjZqHo4jlUe4GyRAdUb/kPCLa5UZ9PGrsXIRmnJ5CDVfkhz5liUHRL8N2EKW+JNiK/Sf9untjT76gKA2b0duyBkklwS0GJl4JS57zH7qs7V5BnmG6Hyol6bVoBWcGbyjxYpj1q4PF1DfWq6zg0278X2mhbEFtzVqMOMDzdvD7d9G1NGsrrU7Y5h/4VyCt+ByPDUDehV6wrIcp1gaFJGj+thX11GtUFpPGWR3YUaZTptrt+FTzk4n3iU4fBr1KMoS3JX3oBRSsD1d0L6ldO4nmbWYBb+m5DOhPP5FViok08ay87EQrVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB7125.namprd11.prod.outlook.com (2603:10b6:303:219::12)
 by BL1PR11MB5304.namprd11.prod.outlook.com (2603:10b6:208:316::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 20:10:07 +0000
Received: from MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::e28a:f124:d986:c1d0]) by MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::e28a:f124:d986:c1d0%4]) with mapi id 15.20.7202.027; Wed, 24 Jan 2024
 20:10:06 +0000
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "zohar@linux.ibm.com" <zohar@linux.ibm.com>, "paul@paul-moore.com"
	<paul@paul-moore.com>, "jarkko@kernel.org" <jarkko@kernel.org>,
	"dhowells@redhat.com" <dhowells@redhat.com>, "yaelt@google.com"
	<yaelt@google.com>, "serge@hallyn.com" <serge@hallyn.com>,
	"nichen@iscas.ac.cn" <nichen@iscas.ac.cn>, "sumit.garg@linaro.org"
	<sumit.garg@linaro.org>, "jmorris@namei.org" <jmorris@namei.org>
CC: "Jiang, Dave" <dave.jiang@intel.com>, "linux-integrity@vger.kernel.org"
	<linux-integrity@vger.kernel.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Williams, Dan J" <dan.j.williams@intel.com>,
	"keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
	"linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>, "nvdimm@lists.linux.dev"
	<nvdimm@lists.linux.dev>
Subject: Re: [PATCH] KEYS: encrypted: Add check for strsep
Thread-Topic: [PATCH] KEYS: encrypted: Add check for strsep
Thread-Index: AQHaTojqvjVIX7LD8kG9OsZOaef/FbDpRyyAgAAPCQCAAA9dgA==
Date: Wed, 24 Jan 2024 20:10:06 +0000
Message-ID: <e3b1a5e532ed86e674385abc4812c5a774f851d4.camel@intel.com>
References: <20231108073627.1063464-1-nichen@iscas.ac.cn>
	 <4d3465b48b9c5a87deb385b15bf5125fc1704019.camel@intel.com>
	 <e3275c0cfe21d75e0d71ea3fc24a31252efc9ad6.camel@linux.ibm.com>
In-Reply-To: <e3275c0cfe21d75e0d71ea3fc24a31252efc9ad6.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB7125:EE_|BL1PR11MB5304:EE_
x-ms-office365-filtering-correlation-id: e1f0041a-107d-4f2f-aa7b-08dc1d18754d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bzhWhq16SsQ1r9dKVA2+7s3r4ItJYxL/0xK32NEOR9ar41C/oHNet1xwJciWbpViFRNsnHP35kM9tLdWmz8g2x2+/gZ7iftXzf+Ke2knhtBpSIbh6kZHMEdFedhEmn/j2CfTKNOUvdIY5fFGPTpRdXArxDGqVM6PSKYHMr391VMvNrGQoZc6bHwqzZxOr6oi8/g6fbiKiXHO/f77WU1Q9fpSUz5WSPd/SIr4CDKLZEhunu4D8hitPbSvBtX0nEdXj0BVM7Epa0JJnc6SXYRZr/eAfw5biGjLtU0dc/MYMdPtbjKCrHrc5zO1vxDWdZ/3nPklTOeWMn8UKZdet0tVyOEDCzRiQfW+ctdgCHLmduwsY5ApZ0NXcbLmOwt/4vTexnwDgQ3/aoeStSswv4GSHljWUveURtCbqQmi0NO0jMS/0uwBqPpf7FG3p6eGHY8cfUnTKnFAoMr2OoPBjEiC9LT2frivltaucxm03D7Qabvv75FfU5403ozD4yxhJZm5medPumeLB9dEwFZXuOJHFB7JBgrUi65tjNzoCunQFOOtCCMsolgp+rINt9L1Wz44t8OgqJZvvd4eBUp1o1omxDx2gCc1bTLvO/3K/xb9taJKsDkCJTKvv8SiSfvHQ5Ic
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7125.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(366004)(396003)(39860400002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(66556008)(66476007)(76116006)(54906003)(66946007)(316002)(110136005)(5660300002)(64756008)(7416002)(8676002)(8936002)(4326008)(2616005)(83380400001)(2906002)(6512007)(66446008)(82960400001)(6506007)(478600001)(6486002)(71200400001)(41300700001)(36756003)(86362001)(38070700009)(122000001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cU16MG1raER6N00wQWZlVHI5Wmp5L1VnOEh5eFdsdG1pQzhLU3pVNDBkWHpq?=
 =?utf-8?B?R3V0ZnI1TnpndysvbkEyNFNwYTJSVGlydDFvMXZUNENnU25SRGViTkplbm5t?=
 =?utf-8?B?eU13dVNEWDNtVi9aZkN1Z0JyQ2ZIVFJVZmhKaUJhems4WXg3bXdybzFRcjZu?=
 =?utf-8?B?a2dIeW1wVVExUmhxTXE1RmlnVk5HcGF4TlUvcnBuQlB6Znkvc0E5SzM3OEMv?=
 =?utf-8?B?S25XMHRxeUlhR09NYUx4MmkwUVJQejBscG4vd3ZJMURpMCtkZHV5ZlpxUlV2?=
 =?utf-8?B?SVc5bVVhdE50OWRQMmgzK200YTZ0Szc2Nis4U3RiOTFZcFpLOVNuNnd4RGQz?=
 =?utf-8?B?dlM1bjgxMWl1SHVnZWdMYTVERnMxeHhST1dEZGF3TEJqN2pZOGtiL08rWnhX?=
 =?utf-8?B?YU5tdnc0QjJLaUF6YjRQUHJuU3JtLzR1Q3gwbHFGaS9qY0NQM2ptVExVa2lB?=
 =?utf-8?B?a1cwMXh0Nnk3SWpUYmZPQTFXeVBlQkkyaXQyT21MMC9GZTF5K0JESzFiWXpn?=
 =?utf-8?B?VXVPS1BUUVRTVHdiUEJlSCtHR1M0MlpBUnQraGg2UkxOcTI2MFYyYTBKbUxp?=
 =?utf-8?B?ZWE5bjNlcjBNSmJvcUxaSmRlcEU5VytDZWYybSs1K2p3WkNSL3U3cjNDaEN3?=
 =?utf-8?B?U3pTL2R3S0EvdXVOREw0bzNUZnltUTBNcDUwTlFMN0FmdGs4YzZQMk9TTmlQ?=
 =?utf-8?B?QUhCbmVVajhJSndXT3kyWEtSUG5CZnFWSTM4Z2dGYXNJdEdMcmh0MzhqWkJT?=
 =?utf-8?B?Q2dmNnd2RDBJbi9rczRndHk2YlNSQWhMRENCNktOOGdodi9YVk54eFhvRXp2?=
 =?utf-8?B?ejI4b3QvYys2ZVRLVFN1bDFSb084Z3d1TGFlN2RUVDNHdW5mbnhsRHArdy9F?=
 =?utf-8?B?TjRpMFpqUUoxWkhreXA0aDJINGllZnFILy96RkZIYUFpRi85c3hRUlFKT3p3?=
 =?utf-8?B?NjVXN245eGFRZU8vTWtiQ1V5K3BYSmtIQXdXTmNPbzZaNXRHbUoxdkxDYjRy?=
 =?utf-8?B?NmtDUG1oc1Y1aHBzREo3aWwyeHNXVHlTOEhibms4cUdicGVmVDM1TmxTa3pV?=
 =?utf-8?B?bC9wM01DS2NJK3Y0Um5CUVpZQ04rcjc4L1JFVldFMWxuckVJVDB6SVhBZGxR?=
 =?utf-8?B?Z0wrV0d2TDRSZVMvbmZSMUFZMEFRUXNpV0dCRDVhQk5DL3Qxc1FLTm52eFNP?=
 =?utf-8?B?dUN0TjQzWUd5OHM4ZlZPM1MvQmFkaTU5cmduQlJrQjNLN3BMc0ljQnNpTlFq?=
 =?utf-8?B?bjB4TVJmWko4ZEI0VGEvSlNJajVsSW0zSzdscThaeExmTlV4eWpIQWMrQmFp?=
 =?utf-8?B?cUFCWkRxV1hhSGxMUkRLTlFWZURLSzVva3BWOG9WQVlSK0tvcWVRUHgzRGp0?=
 =?utf-8?B?RGFlcEhzbUFwY21LVDNQWGNGL1JVN2xhVnlZMTN6LzB1MlhGK0NDY3VPSFRY?=
 =?utf-8?B?eDB4RUNmeEVJK25NdkdEdXBlWDJ1ZFdjWnlFcDlNRXhPRlBlbUVrcDNHSWNl?=
 =?utf-8?B?Wm4zd1FTTWg4UXhjbDVpaHBaM3dNZFdwQ2tXMzBTbm8rV3c1c1BkT29lVC9P?=
 =?utf-8?B?ZkcyM2ZISkpSUWJodTdlVkVVd1JMZlFONUQ3SjU4TEJxa0VMNENRZmZTMTA5?=
 =?utf-8?B?TDQ0aXVHZGpnSDVXQ0MxYzFXSi9aQjZCUW9xVGl2ZnMvNS9kWTRVYzc2VzZU?=
 =?utf-8?B?dlV2WVY0SXh4aHczTEQwMlp2UUVwVU5EbVB1T0lmNlVhMEZISFk4Z2dOaFIv?=
 =?utf-8?B?cG1xdWtieDkwRFBZcWNEaXQ3UWRrSitmbGd4R3NzSmNtbHNLdVNjTWNrd1dm?=
 =?utf-8?B?QWhiM0UybERyVmZST0lMeExqUTBvaGw1cXh4d3VadjBmUlVhcThJWW84T3Ev?=
 =?utf-8?B?MTBQZ1d4Q005dlBWejlHSTVlUmdZQW5PVE1LVlc2MDl4akNRbzc2eGw3MDJq?=
 =?utf-8?B?bXhGMWNQNHlqQ3BicFdsT3ZhTkplQk82OUxYZ3E0bWtCMk0ybmcyUEU3MHVz?=
 =?utf-8?B?STkrb1VCZU93TEdLQ1RrQ0o3SnFyRDBUQkYySXZ2djM5cUVCS01ERVZsNjBT?=
 =?utf-8?B?RnJBL3liUUdrK25LbGQ3UHEyaENNQUdreTR6aGZRNDhmcG81bkhWU2ZDV0N2?=
 =?utf-8?B?czVLbXhmSXRXVC9oRFMzazVqbTQwSjNZb0RNM3NtRjU5a3JwdDIzVXF4ZHVz?=
 =?utf-8?Q?yn6dGfMsP72TllsV6ZlV6hc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <21CE71AC7CE0704FBBC5CD44A40F4239@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7125.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1f0041a-107d-4f2f-aa7b-08dc1d18754d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2024 20:10:06.4134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FnFhLZA06gaLGgVGfmKvd/eFod3E5QaUlX2FwUGuEuTHrPmmpu1Hcdu+tHyLvhPL6FGE+M0sBZJpjosm8teKFxg4+ue7eM5+6+gg1bbERCM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5304
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI0LTAxLTI0IGF0IDE0OjE1IC0wNTAwLCBNaW1pIFpvaGFyIHdyb3RlOg0KPiBP
biBXZWQsIDIwMjQtMDEtMjQgYXQgMTg6MjEgKzAwMDAsIFZlcm1hLCBWaXNoYWwgTCB3cm90ZToN
Cj4gPiBPbiBXZWQsIDIwMjMtMTEtMDggYXQgMDc6MzYgKzAwMDAsIENoZW4gTmkgd3JvdGU6DQo+
ID4gPiBBZGQgY2hlY2sgZm9yIHN0cnNlcCgpIGluIG9yZGVyIHRvIHRyYW5zZmVyIHRoZSBlcnJv
ci4NCj4gPiA+IA0KPiA+ID4gRml4ZXM6IGNkM2JjMDQ0YWY0OCAoIktFWVM6IGVuY3J5cHRlZDog
SW5zdGFudGlhdGUga2V5IHdpdGggdXNlci0NCj4gPiA+IHByb3ZpZGVkIGRlY3J5cHRlZCBkYXRh
IikNCj4gPiA+IFNpZ25lZC1vZmYtYnk6IENoZW4gTmkgPG5pY2hlbkBpc2Nhcy5hYy5jbj4NCj4g
PiA+IC0tLQ0KPiA+ID4gwqBzZWN1cml0eS9rZXlzL2VuY3J5cHRlZC1rZXlzL2VuY3J5cHRlZC5j
IHwgNCArKysrDQo+ID4gPiDCoDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykNCj4gPiA+
IA0KPiA+ID4gZGlmZiAtLWdpdCBhL3NlY3VyaXR5L2tleXMvZW5jcnlwdGVkLWtleXMvZW5jcnlw
dGVkLmMNCj4gPiA+IGIvc2VjdXJpdHkva2V5cy9lbmNyeXB0ZWQta2V5cy9lbmNyeXB0ZWQuYw0K
PiA+ID4gaW5kZXggOGFmMjEzNjA2OWQyLi43NmY1NWRkMTNjYjggMTAwNjQ0DQo+ID4gPiAtLS0g
YS9zZWN1cml0eS9rZXlzL2VuY3J5cHRlZC1rZXlzL2VuY3J5cHRlZC5jDQo+ID4gPiArKysgYi9z
ZWN1cml0eS9rZXlzL2VuY3J5cHRlZC1rZXlzL2VuY3J5cHRlZC5jDQo+ID4gPiBAQCAtMjM3LDYg
KzIzNywxMCBAQCBzdGF0aWMgaW50IGRhdGFibG9iX3BhcnNlKGNoYXIgKmRhdGFibG9iLCBjb25z
dA0KPiA+ID4gY2hhciAqKmZvcm1hdCwNCj4gPiA+IMKgCQkJYnJlYWs7DQo+ID4gPiDCoAkJfQ0K
PiA+ID4gwqAJCSpkZWNyeXB0ZWRfZGF0YSA9IHN0cnNlcCgmZGF0YWJsb2IsICIgXHQiKTsNCj4g
PiA+ICsJCWlmICghKmRlY3J5cHRlZF9kYXRhKSB7DQo+ID4gPiArCQkJcHJfaW5mbygiZW5jcnlw
dGVkX2tleTogZGVjcnlwdGVkX2RhdGEgaXMNCj4gPiA+IG1pc3NpbmdcbiIpOw0KPiA+ID4gKwkJ
CWJyZWFrOw0KPiA+ID4gKwkJfQ0KPiA+IA0KPiA+IEhlbGxvLA0KPiA+IA0KPiA+IFRoaXMgcGF0
Y2ggc2VlbXMgdG8gYnJlYWsga2V5cmluZyB1c2FnZSBpbiBDWEwgYW5kIE5WRElNTSwgd2l0aCB0
aGUNCj4gPiAiZGVjcnlwdGVkX2RhdGEgaXMgbWlzc2luZyIgZXJyb3IgcGF0aCBiZWluZyBoaXQu
IFJldmVydGluZyB0aGlzIGNvbW1pdA0KPiA+IGZpeGVzIHRoZSB0ZXN0cy4gSSdtIG5vdCBzdXJl
IGlmIHRoZXJlIGFyZSB2YWxpZCBzY2VuYXJpb3Mgd2hlcmUgdGhpcyBpcw0KPiA+IGV4cGVjdGVk
IHRvIGJlIGVtcHR5Pw0KPiA+IA0KPiA+IEhlcmUncyBhbiBzdHJhY2Ugc25pcHBldCBvZiB3aGVy
ZSB0aGUgZXJyb3Igb2NjdXJzOg0KPiA+IA0KPiA+IMKgwqAga2V5Y3RsKEtFWUNUTF9TRUFSQ0gs
IEtFWV9TUEVDX1VTRVJfS0VZUklORywgInVzZXIiLCAibnZkaW1tLW1hc3RlciIsIDApID0gNzYz
MDA3ODUNCj4gPiDCoMKgIG9wZW5hdChBVF9GRENXRCwgIi9zeXMvZGV2aWNlcy9wbGF0Zm9ybS9j
eGxfYWNwaS4wL3Jvb3QwL252ZGltbS1icmlkZ2UwL25kYnVzMC9ubWVtMC9zdGF0ZSIsIE9fUkRP
TkxZfE9fQ0xPRVhFQykgPSAzDQo+ID4gwqDCoCByZWFkKDMsICJpZGxlXG4iLCAxMDI0KcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgID0gNQ0KPiA+IMKgwqAgY2xvc2UoMynCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCA9
IDANCj4gPiDCoMKgIGtleWN0bChLRVlDVExfU0VBUkNILCBLRVlfU1BFQ19VU0VSX0tFWVJJTkcs
ICJlbmNyeXB0ZWQiLCAibnZkaW1tOjAiLCAwKSA9IC0xIEVOT0tFWSAoUmVxdWlyZWQga2V5IG5v
dCBhdmFpbGFibGUpDQo+ID4gwqDCoCB1bmFtZSh7c3lzbmFtZT0iTGludXgiLCBub2RlbmFtZT0i
ZmVkb3JhIiwgLi4ufSkgPSAwDQo+ID4gwqDCoCBuZXdmc3RhdGF0KEFUX0ZEQ1dELCAiL2V0Yy9u
ZGN0bC9rZXlzL252ZGltbV8wX2ZlZG9yYS5ibG9iIiwgMHg3ZmZmMjNmYmMyMTAsIDApID0gLTEg
RU5PRU5UIChObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5KQ0KPiA+IMKgwqAgYWRkX2tleSgiZW5j
cnlwdGVkIiwgIm52ZGltbTowIiwgIm5ldyBlbmMzMiB1c2VyOm52ZGltbS1tYXN0ZXIgMzIiLCAz
MSwgS0VZX1NQRUNfVVNFUl9LRVlSSU5HKSA9IC0xIEVJTlZBTCAoSW52YWxpZCBhcmd1bWVudCkN
Cj4gDQo+IA0KPiBJbmRlZWQhwqAgVGhlIHVzZXItcHJvdmlkZWQgZGVjcnlwdGVkIGRhdGEgc2hv
dWxkIGJlIG9wdGlvbmFsLsKgwqAgVGhlIGNoYW5nZSBuZWVkcw0KPiB0byBiZSByZXZlcnRlZC4N
Cj4gDQpBaCwgdGhhbmtzIGZvciBjb25maXJtaW5nISBXb3VsZCB5b3UgbGlrZSBtZSB0byBzZW5k
IGEgcmV2ZXJ0IHBhdGNoIG9yDQp3aWxsIHlvdSBkbyBpdD8NCg0KVGhhbmtzLA0KVmlzaGFsDQoN
Cg==

