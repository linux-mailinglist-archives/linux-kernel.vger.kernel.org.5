Return-Path: <linux-kernel+bounces-127367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A965894A63
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 06:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F9C8B21BA3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 04:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCBF18637;
	Tue,  2 Apr 2024 04:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DEAgKs8b"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2016C18628;
	Tue,  2 Apr 2024 04:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712031635; cv=fail; b=WMrJz9OHmbQczsdknvNyRT8nw9MqyT3gc0UM48JkZv0CRV7DfCz+/RF8K2ZSkhwZRDduNsztc4MsPhLKhebttjAUm6u3xl8BV3Usw/cCuOmq7sMAB351P55p4X6e+T96JQEBUeuC6S2mO0Ua9yQdIOEpBMuilaFaKfc8VOJktpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712031635; c=relaxed/simple;
	bh=wpqneH5Uve4joqXxxlWNR/bGtbuwl2gCxKQbnBIHBo4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KFXOOtT40b/4ISnQK9jctjTdeFZeDHbKZLv2G4F8RQKOheZh9qDwOsVV+2XCjEdg2wgIEM13c0pO2bgv0+/JVY+7JQelBOANm+8X9KhK6SxD0Q6NCCNldNtqFY+OEUXyQYKOdL+BLtP8UKR7qMvZkaEmqbue2jHZng+2T5OctDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DEAgKs8b; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712031633; x=1743567633;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wpqneH5Uve4joqXxxlWNR/bGtbuwl2gCxKQbnBIHBo4=;
  b=DEAgKs8bZFXK3P3PjnUfuR3uYv4yb7xDczkpYUqCpG8PtPWWYY+JuqX8
   u1njCfStCX+ebJY4wG1gZ3neZ/ydCo1/T1anyqTAz3Oy31SxikHh9rCLS
   MC5Gs0ubRQK59uks6X09U436EHDDMQUGYsX6JSeuUS6ovXxI6NuyYToGU
   jIUgNMwJ+cbekS2zfaHFSGDVPCx3hjf7PO8GhAVLtDv/LI2s7EXude7Jj
   1Qv1H20yu2MV0lYo3LyICuUz2jYmHz3SQAe7tSOcVqOEms+3tH1EAz/et
   z2r1eo9u1qF8MRjuWAOvharYjyJ6MPNnCqlK3q2u29wOG1kVboOswkbwJ
   w==;
X-CSE-ConnectionGUID: iasi7crBQTaFqG9W19LbOA==
X-CSE-MsgGUID: xNwtq7yETk++gwEr3Jen6g==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="32582185"
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="32582185"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 21:20:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="18004354"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Apr 2024 21:20:32 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 1 Apr 2024 21:20:31 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 1 Apr 2024 21:20:31 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 1 Apr 2024 21:20:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FvLuHEApo5aBuvz+82oUp1085i1hQwETQKk+pc15yoZiJTio5zd/4Tf+XJhtazVmfH0Lw+EA3avClCByPT11Tt3RcazuDaaf4Gk02erFCXiepJ4ged9rOkiy54HG2e//NBtdMg/SZZeMkATO+g4sS0IyS/01qa7LoJ21mJE+W8JlqpqmepAMD2GKi5us2MSASwWWuxR1ENMWJkpJcQIu1iDpyKlqt6ECqIC9NI5KPIpWnZFEQ+V5/sZaylSOwb6F7ekvzvSCotlP7V8sPmPaCumDWuX2asrUpXOXeL/leueYUDvB8qlc3xVCt9C4Zd5amggUbXI5Rlv33fIxlKnHCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C7kIpmeKdlPXm4Nf2nusbRhIgpFUhSlSKmILMy8y4u0=;
 b=WvfwYmNlkXgdpXu1qp/aSfTPG7D2TlppC//ENZpV36xf+1lTAd82RMw68iJcyeInC5w161eVhAzQMWb48PWM416CADHnzmf6lMYn+FNxiA6mCr328ixzCvrHKvHFGW5nKqTGa6ZtWBP2+UEhtJ8MAxWIMQroWtNwIhZyJzX2NYfaK8pNInyOnJEjkqBQZ5K3uHSMO2aVNEX7/S31x4bPp8CWnpMni1/Deyfh6SwzH9gNTzEeW+gKGUsub6szDmYaJ5drznB9gwGSaLP2SX1nTm3CwyO7CG06NYNdMu3vd2LQ/WfJ+N87iHIrk6Ue0/XzLVP2X5Ob6aKuVL49dJYllA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB8419.namprd11.prod.outlook.com (2603:10b6:208:48b::22)
 by PH7PR11MB8455.namprd11.prod.outlook.com (2603:10b6:510:30d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Tue, 2 Apr
 2024 04:20:29 +0000
Received: from IA0PR11MB8419.namprd11.prod.outlook.com
 ([fe80::f1cb:2c2f:e082:c0d]) by IA0PR11MB8419.namprd11.prod.outlook.com
 ([fe80::f1cb:2c2f:e082:c0d%4]) with mapi id 15.20.7452.019; Tue, 2 Apr 2024
 04:20:29 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: ivecera <ivecera@redhat.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Loktionov,
 Aleksandr" <aleksandr.loktionov@intel.com>, "edumazet@google.com"
	<edumazet@google.com>, Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"davem@davemloft.net" <davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v2 1/7] i40e: Remove flags
 field from i40e_veb
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v2 1/7] i40e: Remove flags
 field from i40e_veb
Thread-Index: AQHagByhBIXL4j22B02VcpXgGLIvQ7FUaaMQ
Date: Tue, 2 Apr 2024 04:20:29 +0000
Message-ID: <IA0PR11MB84199C38B6938720089D261ABD3E2@IA0PR11MB8419.namprd11.prod.outlook.com>
References: <20240327075733.8967-1-ivecera@redhat.com>
 <20240327075733.8967-2-ivecera@redhat.com>
In-Reply-To: <20240327075733.8967-2-ivecera@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB8419:EE_|PH7PR11MB8455:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HzFPyYUM3ic+WwSlVI3dMZrfYiLXoTTvKiBIeEGryAFI8pIZi1VRq8lmN4wackxhWd52nzhSlrVGyLZpvu6GCNWUfGRuiudx8lWBPc1Rf4N2QfJt94M/maNplMfDD/1DHrBBtccyG+btGLmR6wqNRsbmeYiilvO8lj009T8xsn+G7pXn1VB1zpGnKRYzjJHw4FhBH3VbhqFc17G4Lebik7nkbg/4t3/8HKRSyh3M0dv7iW1pv/bFB3pBMQ0RM3lNKgpeTFdHSuVHeUxvBs1HVsxg1D2VSbcRyLlS27LlPwMf34iOlL2pTsSvKMAj27TJhfAjQFGLePeHpshNFrEvWTRdmyZHjt8p8MupiIyqpKkftZp+i/TvUhqTxYFw4fy8hqHeMt8hPCXMo0PQLoaLNKAZLukof4xMatOmUiLxnyDJcvcLJPTme2hpIF9bVc3Ns2VgIhLOhIYEunt2pX+4+jfukGmqYyFic1ZvHCm4rvNi8rOr4XKjRnjInofEG/YmZmtqH5MfFEmDUUoGIBULAQHzRbxNiTd7RsPWqAFZwJYFHMcuRRUbGqrDKDtKdm2UthzPS09ABDdnKqerU8rXLOWp1mjvEwSBf9AsAiV87wWsVMeep/Ro/ifDjdu1wKlrt+ndlGv9/oMGWpdxK1oqozreK8x839ALcBylLJA1suU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB8419.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EltiDJ/0+5wBizVCcp9c5rr2rJv4Rcus96ekCoa9FN5zvwl6OX1ZF4uhA89+?=
 =?us-ascii?Q?q1oN9faMymmDNCPNyJFkMedDvZ4pRQzdlWe4rgoco8AOjMHaa1x7YqLY69js?=
 =?us-ascii?Q?VwzfuSJzP3JjeydC5k6cHK12SiMXmD4WQL0WCplYyvCwWla/poqODQDAojDs?=
 =?us-ascii?Q?Ehm1Drm84guNdF6yVt+efnTeSyav5tSxln4Fb92WwhH4w+vSeVisGBaSfZax?=
 =?us-ascii?Q?3WrwPnSjlX5VQXlVB26jw3k12ooC2OayCtrf4C55QEIAm3J2sP0B4C2mNwxt?=
 =?us-ascii?Q?c0nG/FbJTl9pq2hx0CF9Kak3rSEzY1oC0SoFjojJFhhy+MIShAheScgPyOXO?=
 =?us-ascii?Q?Wsn9sVfKvYFjMnknrovHnxSxtv3qwl0AHJUPlIvDEftke1hEsN/+JQmsnPSD?=
 =?us-ascii?Q?JLhF4+A4jaarMkoLz2+K/7CfA6C1skytIuNvDgphq5cUp+RNJt3l5DG8Ndth?=
 =?us-ascii?Q?9F7PBX1ijNvo50k/zWu6jUChNJyhdc5B/H22+MKKcZBAl/5pHOoGjS6aDat/?=
 =?us-ascii?Q?qZlcJ4JSLDnPaYTdV+RRhL2FB8J5KYyAxk4BUckAvIhOTuakfFIlR/+mZ4Ll?=
 =?us-ascii?Q?Zj66EkwRFvDmAIw7zuGuIG+nBMmP/xC0tZFndgDGEpH1KEDRXjImL4EtZM/j?=
 =?us-ascii?Q?tJbUg4k16gABYB1kC1sxUfY0wcp8NL8CRhir2FkOY7o2Nvgoe6zSIMsXGU7+?=
 =?us-ascii?Q?98w2ALzPWGFLd98NfYL9+csjv9zr844AQRsKgm8zSmIBPYFRxZnmwIf4ZM8f?=
 =?us-ascii?Q?zL5Xsy6uMesgPV0RksASNuQLgpcB5Zct9Cyh7AdilicK0IaTKXIntlEt7W9j?=
 =?us-ascii?Q?tYf2k8shHm9hXnz7hilJWREoG19H4gfB6V6JjaNyqcTEf58ZehnSxwCRzUBy?=
 =?us-ascii?Q?Kz3zg4rTQaLp0RXUJPfrukfogQs8SPebp7lE13eOfaIVptlnTin7814N26OW?=
 =?us-ascii?Q?2WUwKIcn5TyqhfaqP+1AuKG9ekVIxOfoOQaKIFTO7pNLwPArz2JNwR584hyA?=
 =?us-ascii?Q?LO941hsml3bVAIPGVY6cn6ee+sZThi90elLsYohJrKJSMQc6ZXCvpB9CmMpi?=
 =?us-ascii?Q?3l5fiT24hhhYR6EJwKKzftO8adGJEQIERJMbchMhxoDWPBhhkHcjQQK5PIuG?=
 =?us-ascii?Q?2tcFOpM+ae2X+rBkRUsKxl/bv+23m3NfNUXUY+aHmBEfQWHPE16bS08PskV/?=
 =?us-ascii?Q?Hbm8R/chHPVTYbUfqTKXFh8NF/2nM9NDfxL4DsGIF2zCzlGDgYnzVlgMAVPl?=
 =?us-ascii?Q?Cej8c+03/Eal8I5yFFMhHS4bSFJk/H8QwxIa7fghIXB4U5rIdf5wrdY48nYM?=
 =?us-ascii?Q?QYsb/0It+HrW1/CLfQeLkQ6lLZvfEnXJSWlaIW4XrVbOjQJ4toCYwZEYLT58?=
 =?us-ascii?Q?7B1C48Exr5bB2j6oQm6DLAuHbcn8a5v2ofvAlUR6ZxLLgUMM+TiM0SP84MtI?=
 =?us-ascii?Q?aTLn1RIteey8+OhBs5nwGnPl5Wpu6Tuj8YJLlU1k89ltFwE1i89BhdpGdOr2?=
 =?us-ascii?Q?nfkP1IahAPsGAx5QtdpOSoFoX/NjOgUTnewXEej/bq3rCvyPfhl8YnkYSXrW?=
 =?us-ascii?Q?mbmWrhX5JTI40KvvYFkXjz/j+5arAcFwo61yK+t4pgFFMBOg8CFOf16DbhT+?=
 =?us-ascii?Q?gA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB8419.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8ea9013-5380-4672-bad7-08dc52cc3ad6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2024 04:20:29.3428
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6gbefLLawhxNbn5Q9JZ2JUJV8XCCtHerwVbfl9csCC7O9ah/y7jxG1crBP7rrVzyRP0466IZ5LSw7dYwzkQkHNoq0hAA+rHvCouZQL7OLtjE1QKi1cAvLF+wr5i81LZl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8455
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of I=
van Vecera
> Sent: Wednesday, March 27, 2024 1:27 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Loktionov, Alek=
sandr <aleksandr.loktionov@intel.com>; edumazet@google.com; Kalesh AP <kale=
sh-anakkur.purayil@broadcom.com>; Nguyen, Anthony L <anthony.l.nguyen@intel=
com>; kuba@kernel.org; pabeni@redhat.com; davem@davemloft.net
> Subject: [Intel-wired-lan] [PATCH iwl-next v2 1/7] i40e: Remove flags fie=
ld from i40e_veb
>
> The field is initialized always to zero and it is never read.
> Remove it.
>
> Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h         |  3 +--
>  drivers/net/ethernet/intel/i40e/i40e_debugfs.c |  2 +-
>  drivers/net/ethernet/intel/i40e/i40e_main.c    | 13 +++++--------
>  3 files changed, 7 insertions(+), 11 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)


