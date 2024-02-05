Return-Path: <linux-kernel+bounces-53982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 558BB84A8C7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 23:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A3411C28D00
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB485A7B8;
	Mon,  5 Feb 2024 21:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M8K9s0US"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED59848791;
	Mon,  5 Feb 2024 21:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707169688; cv=fail; b=iSRIr2T37qYEnNQNvtlFcJaHzcJDvYvnBaM47YnuME425YJALO2Q4i+zHFGj6fBDpJ7HtINrljJrWPF9O7UMK5RhMPDhJGdJt5s5w3DdpM3E/WMTeW12c2tSmiLAvtAMy1hYAMP68UYXLMqIRIom4GQ0fxA7czyeXbbOx+HWhb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707169688; c=relaxed/simple;
	bh=nJX5VlXfQ01MoChsP1Pj9DjqXec7MVvwVibxzVQYZfQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KHPyHp0qK/56FO49n0xmAbQrHqJoswxD4OSFc9FqUKqYUTAi8BC0GlxbUo2b3z66HHHQKpGwbmbMeHsuvx5ObNpwSi5273Gl/iB4H161x3tAKoi/hTn2MQWR7aFxmJssu/5rPCmvO7YvyslEN49GEwVAzq3hy6tQuRSp91y35ho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M8K9s0US; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707169688; x=1738705688;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=nJX5VlXfQ01MoChsP1Pj9DjqXec7MVvwVibxzVQYZfQ=;
  b=M8K9s0USQU6YBqDnnUgIQgqm2BwwlILV4ixXdiyTuUUDCF8MjxaGfbQL
   uKESkNoAmzknOPOZmHTRYax65Y5lnzv4iaQxl2vusWWwh7QFiVs+ExjWT
   Inpn9fh9Sv+tvQQ3rsj61uicj+IZbSe23xyQdqKTabmxmSvx8n4pOFIWz
   KP+5nQjgFXB7sjr5oy4pI2vdQ9c0J7W6ngpk+7bj9slslsIZADiKC471H
   WrMivPUkB8+JIbnkh839FntVEB2xVK+wQt1e52TtSpJoYmd/Xe3Eiaj68
   p4r3Do4TlcQ5BoaURZH0dnplWQTYrfxe1XhPVjnU3gCb0Guu0hXnQyiSN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="519661"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="519661"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 13:48:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="806224"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Feb 2024 13:48:06 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 13:48:04 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 13:48:04 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 5 Feb 2024 13:48:04 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 5 Feb 2024 13:48:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CencW7StstQ1YT6mEqzORqYGoPdJs0AXKQl+OwaRxlqAHltCo05twCzM6opeY5uT44wuXeafmcZiTk8py1LIjs7bSK9MtMcmQvwU9Q4wuSkzjQop8I69EWTYS+vfc3AVDxBFLHbe41APH21BbSyayVbeotYV2O7RBim8WH78BnDWX/wmsqh1XB2CD/IVe68UPRfNG55G4jdvVOAMUur5+10RpyroZodVWyPhtuN0LJXdxMpKS7N9LU/PXwyZv0VJFJdGuGwcgbQBGwbqDNz4mdATMvHGrvCjvN7e4jyCAdoWka6YIYDvNWQpXKVuHp6lNQn6fWsvDwEeYndI7r7cqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JZ4RCibk0uTFIqW2V5ECaS70OiLxQJ0Ar/ao/Z3Fm1E=;
 b=lEKEBCR0NQtbjzOUsbImt7PxDR1k7/096zFPfo6674oNwRj8sIuvmBHKdl1Tstz5erBOavaab2D5Vv7361dXnjgLFeAR3mytsHVSX0720WojMAViOXIsN9QZzxRCXKBdaqJKeOtfqRK5Sdb0nhDH0Dq9eA842aolDjJGZosL3NFzU9CnrfLlG6qYNs9/MgzDJW+kR7speGEQZF/u+lGqUQ5p5fRxwUjbnxYQ60ZMMgUFgqNwmilBumbTbfMOuXdcunTDks9nSrWP2NsvHHJqrwla1dDQlECVnzK8rb59MbnSSFNRyK8nleKyKMVg0IXey3lsV9QDycXCWYXlhvMoeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CH0PR11MB5347.namprd11.prod.outlook.com (2603:10b6:610:ba::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Mon, 5 Feb
 2024 21:47:59 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::9f17:e1f3:d6f0:3d59]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::9f17:e1f3:d6f0:3d59%4]) with mapi id 15.20.7249.035; Mon, 5 Feb 2024
 21:47:59 +0000
Date: Mon, 5 Feb 2024 13:47:56 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Peter Zijlstra <peterz@infradead.org>, "Fabio M. De Francesco"
	<fabio.maria.de.francesco@linux.intel.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
CC: Ingo Molnar <mingo@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>, Ira Weiny
	<ira.weiny@intel.com>
Subject: RE: [PATCH RFC] cleanup/scoped_cond_guard: Fix multiple statements
 in fail
Message-ID: <65c1578c76def_37447929456@iweiny-mobl.notmuch>
References: <20240205-cond_guard-v1-1-b8d597a30cdd@intel.com>
 <65c131c2e2ec6_4e7f529442@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <65c131c2e2ec6_4e7f529442@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: BYAPR11CA0077.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::18) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CH0PR11MB5347:EE_
X-MS-Office365-Filtering-Correlation-Id: b9b576e1-b8eb-4927-3f4a-08dc26941f01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sRn3DSmW5V4GqwAyfCpe1SvE4SJ5WzgPqqBmUa4ixKL98s8QWf1kO/A8SIntN4nRCzFuAiNELhooLWtEex6fbth5rh/gE5Voxlaxrg0OcEokIiwrlJiwI51J5NbYuylvZhTA9u6NZliaanjTiNWfU4sNqut0zpDqCzrKTr8P1CQs5a0xurGyFsh0lwY1rLMW8jODDGG0Envlh0G3JLK7kT9Ld6NmwR5E85YItsMzuXILE7QJlErefhNmDGs4QG4PiHuoollXD4J5gf+vQ5FZqLaIbtrku+bfavQJ14WWL41uzasYQ0yRyVmS2NugcSxhxv0DdE6Td/v9Yk9lq3usOQ/H3ZarGFiSc29/bAD+WT8KGCsJJt17EwU2t95zgzUyocmEiRdmoPVjBb1B9bg7l3P/gdRzby70WZmkDKtQtmucsymlMd1zG751WKonLM3NNOG2rgcXMM/FRgkLp8x0ZHwKtUApIytWQfmylnfNhnSBoYJD0TGLi8C3iKoWZKbD7VLCvo9fkebm0I7ZaFMHLd9RQgz+t9D7Yvs/ZeQrgyxz4zXOlsRJ7Kd77BHRFDFX7TjzApASdXfwFbh8HdWZ4A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(39860400002)(366004)(376002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(316002)(6506007)(6666004)(82960400001)(38100700002)(83380400001)(26005)(86362001)(41300700001)(4326008)(8676002)(8936002)(9686003)(6512007)(2906002)(478600001)(6486002)(966005)(5660300002)(54906003)(66476007)(66946007)(66556008)(44832011)(110136005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RE5OS3NDT0Y5aFdDemIrZWJOckpkMVdCelI3UXBtUVF5UUJRZk9XMkxSRGxa?=
 =?utf-8?B?TFpwcndveXh4SU9DUUp4ajJWNlRCa2tyTWQzMVhQd2FHL0ZHVVB0akpSbi9v?=
 =?utf-8?B?c1REYzdZMDN1SFpGSFZNTCsxSHo2MXlleVdXd1RqR1UwLzQxdlBMVWhUZk1j?=
 =?utf-8?B?cC9JYWpnekd5RnBCL29RRnRBbmhmR2pEcDEwWkV0RkgwWHZiZVR4bStMM1V4?=
 =?utf-8?B?dmU5ZFpzYTlGOVF4VUlZbHNxdnVyN0JyWXAwR2FLTVgvVDNZMmYxeVdBOWtH?=
 =?utf-8?B?azBSZWw4NllscFd3NWN3Y0pGdE1aOTRFbEpiditFODBQeHpBYlVEWG1zSFBj?=
 =?utf-8?B?MmU1TFZpRDA1QlJTNzhES05heUZxWUk3OTBFVnRjczhTazhPYTA4YkVnOHFE?=
 =?utf-8?B?UG0xMFk5ZWQzdlV2T1ROS3FZK05La0xCZFplV3Nqb0JiQ0hVRGM1dE5oUWdM?=
 =?utf-8?B?MjlHWUxaUXFrT1MzRTNseHkrOUI5c2I0aTVESm14c1M2K2F0QU1NSVI3c3Vp?=
 =?utf-8?B?aFgwYWl1MTl1L212bHlYeGRjS3ovNUlUREJwMzJMM3E1U1k5SzRZYVg4ZE9L?=
 =?utf-8?B?K2JFVmdXTzNuVzBpazZjZkYzWkZiNVhRRlBEb0JNeXJXcFg4c0tLVjBqelZv?=
 =?utf-8?B?VWkvRjFoOGo0UmFaKy9xVmtrQnF1QkhhYWlBN2QvV1ZwNTg4V1VYdlJmalNr?=
 =?utf-8?B?YXZoVUZJT1l0UVNKN25IMVN6amQ5c2YxVlZWb3dSRVZ5VE91L3N1VkpVWnE3?=
 =?utf-8?B?WkJ5anFSZi9DYmxqQkJYZHVQb29keFl3OUdzU09TQ1hJRXk5WmJFQzNsOGRR?=
 =?utf-8?B?TWVVR096VkFtVlJudlg5WVhEWWU5UDZkMjJCYlozdVFrZVpqaGZyK2JuakJM?=
 =?utf-8?B?eklHdWFmMGU2SjhFSFc1WDJUKzN0V2JJbExpV3VsSThHNE54aXN3U2cvdVhU?=
 =?utf-8?B?dkdoL21uNVVBZ0habjZYSXNvRFgybmdzKzc2cDJXQlVpS2xOYVNqK3M3aHV6?=
 =?utf-8?B?d1VtaUdsTGdLbC9yN0JzOFl2ODFLeXA0QWVIWlRER2xmaUZ6QTBITzBwQ1Nx?=
 =?utf-8?B?Z2w3a29rTTBpVjc2aHdoSEZVbytBWW9GNUZGaGlldFQvNllnQ0xQZElQU0FV?=
 =?utf-8?B?bHNYRy9sRGRCeDZBOE41SnMvaDA1T0NuaEhEMFY5SEtRQmRkbS9QU1ZyN1ZV?=
 =?utf-8?B?SVRTK1NqZXBCUTRCeWFTd3htMTJSQ1BieExNYzVtQXREeEdVV2lRdnlPa3hQ?=
 =?utf-8?B?ZDVjN1czUEpvR1hRWnpaZ2dBb0ZMYXFtdjNjWnczZDY1VXU4R0xTM3NVL29x?=
 =?utf-8?B?RDJZQk92T1NBeTlpdnpvUVVpMmNWNW40VGMvT1pJMjBRMGFnWDU5SDVqR3hH?=
 =?utf-8?B?N1VHcHZoemVVRW1KczRLVFl5QnpLV29uOFhDQlR1alBzczAyTlh3OVFQYllz?=
 =?utf-8?B?ZzJvdERnc3BaU0RyRm9pVEdiQk9lS1A5WGRjcTlsWkFPZkRqbEVFRXZKVXlY?=
 =?utf-8?B?b2FDQUpSWmFrb1A2QzhxTUVmNUxuZUErMnk3YlliWkl2UGVyYlExYy90WEhS?=
 =?utf-8?B?RW1vRGFPK255U1ZQU1ZBNmE2bytVT0xKYmphZ2VXY2F3R0ROZE9PRmFnQ3Ft?=
 =?utf-8?B?dmMwK2RqN2gwcU0rbm9NR0h4Q0J3SGV3ZnduazEyRHFPQllnbXUxenFRRjFV?=
 =?utf-8?B?d1RMVHlWeTRPd3g1UG9UamZVaC8rSlllTFcrU2Zzd1JxRUc4RldWNDZPY0k0?=
 =?utf-8?B?cGlWaGlObVpwdzZKVEpsOVAwaDVxTCtqb0xBOUNFQlhzcmJWODNSWjBvbGt1?=
 =?utf-8?B?MTVvaVV5ZEJ1c09SMjZwNUdJait1Y1paRGxjUkkyZUJPKzE0ZXJlZVdTUiti?=
 =?utf-8?B?YWRhTFA2Y3JWVjRoQUJKdDRaTll2UVJqdm1NaU5xVU5OT04xN2VJMnZuVHNk?=
 =?utf-8?B?S0U4dXhqdHRRaHd5R0lCREJsb3BCVXlhWXF1dmJRMTIrMWJoVzlPc2s3dC9S?=
 =?utf-8?B?WmtGL2k3c1Q1RUw5dk1HYTltWTVwOFpZY3dsN1Faekk1VFZFM0k1NVlTa3E1?=
 =?utf-8?B?MlBwTTNiSHIvSjJ4THdEWk5TUEZYUlY1WlR4VkJHY2thblhyQ28zY3pGTmN2?=
 =?utf-8?Q?eGqAZHv6S7IpFroRd3dHjXy8F?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b9b576e1-b8eb-4927-3f4a-08dc26941f01
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 21:47:59.8721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rx45XoN74GWH5+lsFU6LXL8Zl5SXaVLP7bSw9i289AXYYdH1GJXjEtR/OjUfR3ScJlTNyB9U7t7+DxqGZ+26NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5347
X-OriginatorOrg: intel.com

Dan Williams wrote:
> Ira Weiny wrote:
> > In attempting to create a cond_guard() macro[1] Fabio asked me to do
> > some testing of the macros he was creating.  The model for this macro
> > was scoped_cond_guard() and the ability to declare a block for the error
> > path.
> > 
> > A simple test for scoped_cond_guard() was created to learn how it
> > worked and to model cond_guard() after it.  Specifically compound
> > statements were tested as suggested to be used in cond_guard().[2]
> > 
> > static int test_scoped_cond_guard(void)
> > {
> >         scoped_cond_guard(rwsem_write_try,
> >                         { printk(KERN_DEBUG "Failed\n"); return -EINVAL; },
> >                         &my_sem) {
> >                 printk(KERN_DEBUG "Protected\n");
> >         }
> >         return 0;
> > }
> > 
> > This test fails with the current code:
> > 
> > lib/test-cleanup.c: In function ‘test_scoped_cond_guard’:
> > ./include/linux/cleanup.h:190:17: error: ‘else’ without a previous ‘if’
> >   190 |                 else
> >       |                 ^~~~
> > lib/test-cleanup.c:79:9: note: in expansion of macro ‘scoped_cond_guard’
> >    79 |         scoped_cond_guard(rwsem_write_try,
> >       |         ^~~~~~~~~~~~~~~~~
> > 
> > This is due to an extra statement between the if and else blocks created
> > by the ';' in the macro.
> 
> A statement-expression "({ })" builds for me, did you test that?

I did not test that, no.

Would that be the syntax expected?  I'm not familiar with any macros like
this so perhaps I misunderstood the expected use.

> 
> > 
> > Ensure the if block is delineated properly for the use of compound
> > statements within the macro.
> > 
> > [1] https://lore.kernel.org/all/20240204173105.935612-1-fabio.maria.de.francesco@linux.intel.com/
> > [2] https://lore.kernel.org/all/65b938c1ad435_5cc6f294eb@dwillia2-mobl3.amr.corp.intel.com.notmuch/
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > ---
> > NOTE: There is no user of this syntax yet but this is the way that Dan
> > and I thought the macro worked.  An alternate syntax would be to require
> > termination of the statement (ie use ';') in the use of the macro; see
> > below.  But this change seemed better as the compiler should drop the
> > extra statements created and allows for a bit more flexibility in the
> > use of the macro.
> > 
> > diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
> > index 88af56600325..6cc4bfe61bc7 100644
> > --- a/include/linux/cleanup.h
> > +++ b/include/linux/cleanup.h
> > @@ -186,7 +186,7 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
> >  #define scoped_cond_guard(_name, _fail, args...) \
> >         for (CLASS(_name, scope)(args), \
> >              *done = NULL; !done; done = (void *)1) \
> > -               if (!__guard_ptr(_name)(&scope)) _fail; \
> > +               if (!__guard_ptr(_name)(&scope)) _fail \
> >                 else
> > 
> >  /*
> > diff --git a/kernel/ptrace.c b/kernel/ptrace.c
> > index 2fabd497d659..fae110e8b89f 100644
> > --- a/kernel/ptrace.c
> > +++ b/kernel/ptrace.c
> > @@ -441,7 +441,7 @@ static int ptrace_attach(struct task_struct *task, long request,
> >          * SUID, SGID and LSM creds get determined differently
> >          * under ptrace.
> >          */
> > -       scoped_cond_guard (mutex_intr, return -ERESTARTNOINTR,
> > +       scoped_cond_guard (mutex_intr, return -ERESTARTNOINTR;,
> 
> ...otherwise, that semicolon looks out of place and unnecessary.

Agreed.  This is an alternative I considered but rejected and was only
mentioning it as part of the commit message.

Sorry for the confusion on this.  This is not the patch suggested.  See
below.

> 
> >                            &task->signal->cred_guard_mutex) {
> > 
> >                 scoped_guard (task_lock, task) {
> > ---
> >  include/linux/cleanup.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
> > index 88af56600325..d45452ce6222 100644
> > --- a/include/linux/cleanup.h
> > +++ b/include/linux/cleanup.h
> > @@ -186,7 +186,7 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
> >  #define scoped_cond_guard(_name, _fail, args...) \
> >  	for (CLASS(_name, scope)(args), \
> >  	     *done = NULL; !done; done = (void *)1) \
> > -		if (!__guard_ptr(_name)(&scope)) _fail; \
> > +		if (!__guard_ptr(_name)(&scope)) { _fail; } \
> >  		else
> >  
> >  /*
> 
> Why 2 changes to include/linux/cleanup.h in the same patch?

Sorry for the confusion.  This is the patch itself and my suggested fix.
It does not require any changes to kernel/ptrace.c

The diff above was just an alternative I thought about.

Ira

