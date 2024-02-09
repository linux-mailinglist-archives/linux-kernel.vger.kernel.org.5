Return-Path: <linux-kernel+bounces-59844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C0E84FC6E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D37DA1C248CC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6F083CB9;
	Fri,  9 Feb 2024 18:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TXf4Fjf/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065F780C0D;
	Fri,  9 Feb 2024 18:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707505036; cv=fail; b=K8i39f3bRKkNDG5GCeF9aENUgzbit6KiIPEqENV9wK3jntzxe0Wgu5KttjhVIYqaO6FJPkL2mwRr+CUlJYG1Kj6Z7xxYXvMSMsBHnl18teGSjAGblXh3CFuWOdzWUyRbXfpiZ02WrfpGcHBgtW9o9r6mUi9dOMPXaBA1V46oDdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707505036; c=relaxed/simple;
	bh=AHfGpZ6upRjRtoG1aMFfarFiD0DV8mm5UYDBmcWXONk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZIE7CJ78IKN1tkK/ouxbswwPKE1f9B3EHFyIpoFaXB8ICuhrTEDOVN26s1jFU6MXehAhlDf2+1RLioKI6zQaEt3UzrXkkGeawCAYoNBlxFgf927418Ju9iWuQyNmTbxqnoafs+6ZQ18wrlnYeR7fw+Na9Hav/GTMgJ1/TVUR/Kg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TXf4Fjf/; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707505035; x=1739041035;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AHfGpZ6upRjRtoG1aMFfarFiD0DV8mm5UYDBmcWXONk=;
  b=TXf4Fjf/+xZx9qgBoSmuSgxPR8nSUUo9UYJiQEhK9cJv23xbkLthGmbK
   i7xPDsiKb2TACTFV7X62sakXrSy15WnB3ZkpdRXCDtynOl7VvjzNLRJJn
   YB5AD+ofKVSeNtn9QCR1ITsDCU5nsdCjHy/wt2n+15eNIUtWx+yvxFy40
   mFeZwJvDQECC7kj/dIYdx/S7oszovOX9ogXBMFAdTFFOrf0TOIPqERXES
   SwrXuj9rOtbMGUmRFH6/NTez/OykQG0dVYfvQN0/b1jSskm+PH7LHqDt3
   qOuruotiH1sPxvW3EpKTbYku39pYbral6pvn9ijy7SLeTJ0gdD7F2W8Fh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="12053290"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="12053290"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 10:57:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="2392716"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Feb 2024 10:57:14 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Feb 2024 10:57:13 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Feb 2024 10:57:13 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 9 Feb 2024 10:57:13 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 9 Feb 2024 10:57:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X7Ew370hNkoKDioDBRqD9+lo7APk3G0Rmdm1eETNoEvUh7P4ytrCjFyB4Aos0wgkRe39uxg60tksKGgo48elkz8aOrs+s+NZsJ6ZnlOSmy8uTWeghPql4pKq4Ub0L2V7nBby0csXlQR8rzhpmRHoEhBRtcURLOi/RKBZGpeI0pu+3UUONX2cjHRfAFqasyBUn+WXymQACIxhSYgjBC5gC0Iob1vS2p3pbFwi7MUVJOPtpzLaIrNEFVYndKIxLLCoopktsOUFEUaSLTy+lb1QkDqV/yfEdMh51i0CBPXae/f2EgGD12LmgkAUsTmxsWIeleKU56Iz8roOnhQ5rzilCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fvWhbIjjJ3luGodJrr8nIHqlKHjp6fvZgvCeQGlfa0E=;
 b=DfnCuid3xydmCRBlSJZwhEu7wea5Zuz49MGaiR2MwKMxTiMghPCR2So9Ymy5tDnFj9qqVVWjvdL2pCtjkg2iXltvxnR5gEE8vNEt+bGUGyy2nMmEcZSWv5VukfUXpJKw4wLdhc68njjdnkiuAVG+rbWQNQEwFEy7yrn6xHreFMAcbiSpqGPUbmej+V8KW17x9TFXzVOX0fhcWf0Tusgnls6qc8sCQzx0JzmplYgj8+KVnhoGd0duXVP36N30adaU+/3/7EhQOa2JKDkxYp4WcynAfH6TaiPJ1J+JOtaSh3uUcn3Fk+KIr4gn/ddlXr4xDmGqyXzZPy8wlV0stvtXrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by IA0PR11MB8378.namprd11.prod.outlook.com (2603:10b6:208:48e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.39; Fri, 9 Feb
 2024 18:57:09 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::5fa2:8779:8bd1:9bda]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::5fa2:8779:8bd1:9bda%3]) with mapi id 15.20.7249.041; Fri, 9 Feb 2024
 18:57:09 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: ivecera <ivecera@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "moderated list:INTEL ETHERNET DRIVERS"
	<intel-wired-lan@lists.osuosl.org>, "Brandeburg, Jesse"
	<jesse.brandeburg@intel.com>, "Kubalewski, Arkadiusz"
	<arkadiusz.kubalewski@intel.com>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>, Eric Dumazet <edumazet@google.com>, "Nguyen,
 Anthony L" <anthony.l.nguyen@intel.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
	open list <linux-kernel@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net] i40e: Fix wrong mask used
 during DCB config
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net] i40e: Fix wrong mask used
 during DCB config
Thread-Index: AQHaI8Pmj61FH32w6k69yTcM4d3wCbECy4Jw
Date: Fri, 9 Feb 2024 18:57:09 +0000
Message-ID: <CYYPR11MB8429C9D869C69C249F02AC5FBD4B2@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <20231130193135.1580284-1-ivecera@redhat.com>
In-Reply-To: <20231130193135.1580284-1-ivecera@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|IA0PR11MB8378:EE_
x-ms-office365-filtering-correlation-id: 3594366c-8511-4408-98ef-08dc29a0eb13
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DoTQ4V4grBRnEy4kKR4glAtYh4JSCPErw980zanGzXWwBwpv4skqksVOcAMAVYjW/KczFd7atEg+ytfbAD82155TxPRn1OelP/ZkW4qiJk9u7n8ySoZfRxd7x2V0UDSIhd9UzMvKKLw+Z0rIckt1soin5MaityxX4ZYGVEi9rJfTYLmI1Z4rBwKrgi+dGAHxjXU2XrAw+dAvwwCn+O4e01wj8hIy6cr0oaM522uJHEmFLloJSxS7aytnkWuOV3O5CKPG5qmCSUlHgCYmwsBlFGty9jUwA+Zc8uyLQyczsk+TH5oT/8+qLGw3rR8zOIejjJnyROgIJIyRWGre5xgKdfWT9hiKlZ8+s/dCbFVYfymqsfM0XgGwkwscYQJjiPEJSyh5Zro++kWIel5t3SEUfQ+O6oWVys5m/jukzPeqLTIhqPkMeopp7P0/WI+81Vp09TWT7CChyeD0IH1XrZzSJMPl0PpyJmLK++QyTRA5KcZFViR1fNpTstpSIk+KFyM93ez45LIr5K5XRQteSermdEY/bol5fZyOixYt1OWDVy4ujLxXY7jdubXk4cxIbzlhfSZ5QkVx00Y0hE8DFaqJ6QcWiENCX39le1FaOjURrdZlsye9m/lJ1ZR25+M8g6pj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(366004)(39860400002)(136003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(8676002)(41300700001)(8936002)(55016003)(52536014)(5660300002)(2906002)(4326008)(86362001)(83380400001)(82960400001)(38070700009)(6506007)(7696005)(64756008)(66556008)(66446008)(66946007)(26005)(53546011)(122000001)(38100700002)(316002)(110136005)(478600001)(66476007)(33656002)(54906003)(9686003)(71200400001)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fZregm2As0nNMzgxTpggFUhjWm0LEYpy/jTP+xmZIylyvC8IxsFBYBfuIF+8?=
 =?us-ascii?Q?sUSI0fj9viXkGGfIZsCQs8DN9uepnmViijguSipm2xpXyZICNJq0YMjk31ov?=
 =?us-ascii?Q?Ha3x9n2RB8uw4Lrtimka5fVLOzCs82SEr2hIg56lTQitW86ObAR9sP6NZwb2?=
 =?us-ascii?Q?UHbrQH+IXeRLJhTX/DXHgxqjBLUoFLmtnM0Btt4HLFFXLjPfJe9EHErFozB8?=
 =?us-ascii?Q?3tebigkxq4DARRtiWK1EHaBXru/0v94Y01fL3XePn4OUAzj4A4imZhX4DUAJ?=
 =?us-ascii?Q?pxrfmQlAe+4Kb/RCIcHE1jdEIQYzn7RofKoINazsrjQpLLxCfVLDsICHZ+Eu?=
 =?us-ascii?Q?9PM+4SOyxFV0W8uhMaH72WnEDwD25IUmGztISTtnXWtKmyCuSNqsWW2L8TFe?=
 =?us-ascii?Q?fhVkIJbldUBKC+YA3moEdcbc7ju6HNApk69u+qoM3dqaVzNh2X4GtiYvNTgT?=
 =?us-ascii?Q?Z3deo9ee6Nrvv60ame0QqsAq2ROcxVuj69kHdcpuuo88sVfaFw3t6LmEawup?=
 =?us-ascii?Q?LhbAyXsvD4TAyAjoO3lBoOCsxEjIb9WKnjrdBlQLRTNAtyyUsVSD5Hol81Cc?=
 =?us-ascii?Q?TLc44N4hweVQJsSNTErhc+a+xl6+DC1TQK2t4jcivV4Mvj1Cjp9zk4GcvpF9?=
 =?us-ascii?Q?/9RbR/39l2xSBJE/t8MLfavlDFzyCCE6ZgVC7FglBLUFaaXuGfSEVQ1eDKnt?=
 =?us-ascii?Q?4+QyNmNCr8Ka1tbIT9Lcgv3whTYBzCBtO/kblHkaU6moCzdfW9XUqebJbRtb?=
 =?us-ascii?Q?Cp1940MKoVw+M/esIUpzMKVLGNIhRW/y/YMJ9gDtbnMMGzmvPOXKRaf2LKsI?=
 =?us-ascii?Q?u0sOTjfAO5s7XOJacJG5964pZrcXqvx8OloywNJ65Gzv8d2/5Z1EuKVpKRNM?=
 =?us-ascii?Q?D/z9Mp43L1Y+8KZe+tX6kSenq8v5TRFPPIul81Wqt18Pn80sZvlmkYU1O0YX?=
 =?us-ascii?Q?TKn5P4jBQiBIbTuUCChqCZaBbxOp04MKvm2WLx7WT+mjppJBYZtYLqVxeI1Y?=
 =?us-ascii?Q?ghg+3bVt0o6mjzOQPAv0sYWXSaLtZ2J5kiBhfAMdcE6XHwl54VoI9gHrWBqL?=
 =?us-ascii?Q?0+uRS7kMpdFhk8etjel+sMhfpR9aNFUDzbHnT9uLRGv8riCnqvJan/ntjs7o?=
 =?us-ascii?Q?CZriSpM4WJFVpxoqe/pnH4n7G15VIMd8+apBcMlpdGsqxmVlNpal0aq9oqKc?=
 =?us-ascii?Q?UsQCLEoWdaGlD+WV5DAMaIGBFutMqs1qNfZRvpNOq52oYYISE+L0ZS5aq7XX?=
 =?us-ascii?Q?vapP8AqascF9QJ24X0gYVVps4W5+0Y1a7oPhtW0tHxzyibkRZsJ9DxodM81u?=
 =?us-ascii?Q?4W4AJbMirzL7LZVUtMJll8MsKN+TA7QuswvfTzIg+UajrOVF13zXK3b9Mc3H?=
 =?us-ascii?Q?sf9UUzFg0MWTR4sYH9sDyO3jRP9cyE2tRCUNyHNW/FyUJE7xfhL6/e+hM+PD?=
 =?us-ascii?Q?FP0TLQgTZLhTrL6QmugJJc73vwxkFWWDXYpP7qCApRcMFoNZLsSwEgu+9sam?=
 =?us-ascii?Q?EG7QIJrIv7Fq/k1c99req9iCGJwQPBRM5xFyerHDOemnRtcofOGnhlsb1aXh?=
 =?us-ascii?Q?MZDwu+uI2h+hZ9ll9Tq3izIrOGgYGiawsff9Ii2VlZclIi2aB9nfFXpPjyV2?=
 =?us-ascii?Q?RQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8429.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3594366c-8511-4408-98ef-08dc29a0eb13
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2024 18:57:09.4775
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bwrxEK0FAFR+yYAxcpEov89ogAoZDCzZX/NZo+Tl8SWf6DB0FLJmaBmzbJi8JBizwWqKdKVynYJYU5VbMu4JhsJ2Q6VmIyuaqGX5BrdbzwvpuUuzzo0XokKhQXhXpV8c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8378
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of I=
van Vecera
> Sent: Friday, December 1, 2023 1:02 AM
> To: netdev@vger.kernel.org
> Cc: moderated list:INTEL ETHERNET DRIVERS <intel-wired-lan@lists.osuosl.o=
rg>; Brandeburg, Jesse <jesse.brandeburg@intel.com>; Kubalewski, Arkadiusz =
<arkadiusz.kubalewski@intel.com>; Loktionov, Aleksandr <aleksandr.loktionov=
@intel.com>; Eric Dumazet <edumazet@google.com>; Nguyen, Anthony L <anthony=
l.nguyen@intel.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni=
@redhat.com>; David S. Miller <davem@davemloft.net>; open list <linux-kerne=
l@vger.kernel.org>
> Subject: [Intel-wired-lan] [PATCH iwl-net] i40e: Fix wrong mask used duri=
ng DCB config
>
> Mask used for clearing PRTDCB_RETSTCC register in function
> i40e_dcb_hw_rx_ets_bw_config() is incorrect as there is used
> define I40E_PRTDCB_RETSTCC_ETSTC_SHIFT instead of define
> I40E_PRTDCB_RETSTCC_ETSTC_MASK.
>
> The PRTDCB_RETSTCC register is used to configure whether ETS
> or strict priority is used as TSA in Rx for particular TC.
>
> In practice it means that once the register is set to use ETS
> as TSA then it is not possible to switch back to strict priority
> without CoreR reset.
>
> Fix the value in the clearing mask.
>
> Fixes: 90bc8e003be2 ("i40e: Add hardware configuration for software based=
 DCB")
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_dcb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)


