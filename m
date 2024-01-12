Return-Path: <linux-kernel+bounces-24839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F7482C346
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 17:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 657B2B22B4E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 16:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C011B73164;
	Fri, 12 Jan 2024 16:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gr87F4fd"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF946EB52;
	Fri, 12 Jan 2024 16:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705075555; x=1736611555;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZiqSVUf82CR55TWUkVSfhK+GZ+0vmc+rRuBTia354gw=;
  b=gr87F4fdyxW9dmGu4knGSI1bziu0hw/zxkTnLCAlT0XtB91F7Hfcd3iV
   iiTSm25mKfFNodEUmBFLKIK3fmNPCDv9b/XQKE2szofGqxtEti9gPoeYq
   FtP0U+qYIVJrbhMWtWtkem2+EHUpaW3h1zwh/ToJpopJEq9JHpxICgUrL
   IC0jiqMF8FvlXiND6AsaKKOonIaLZSXOx+mxrIe+PSof66DEhkL/ZPt1L
   5JKIRYf9U1EWmpIWB1v9E9dZvtxQul4lCS+tSHIdxSsPEtJPLWCP2dLcu
   BsMNlaoeq3TWZi/MzyQ6OqoLwTuQi2JPSluwl/S7Dy2FPyu3xS5ib5Anc
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="398087673"
X-IronPort-AV: E=Sophos;i="6.04,190,1695711600"; 
   d="scan'208";a="398087673"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 08:05:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="817112332"
X-IronPort-AV: E=Sophos;i="6.04,190,1695711600"; 
   d="scan'208";a="817112332"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Jan 2024 08:05:53 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Jan 2024 08:05:53 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Jan 2024 08:05:52 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 12 Jan 2024 08:05:52 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Jan 2024 08:05:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EEBh3EhWmrXlZAR61qARYT8uUrmSK0+UrcgVumYJ1ghQkggmQcKbiP7czzAFop5vUud9fWIrnggP8uT9jiLnkwUyaFELe0Ka+tTtxeT/mRbMlPSJ3nm2QfAmZ94eT0qyGvFPVkmhqiZyxPqC4PTdXB1pKp6WIkwvLF/VYXzh1wTg+aCW161tExPbqDVlnGWvCal3pbxUdOIDxbRo3NKzduFw95dAhp4g9E5hChsp6aLm+96R4+BouDu/NMlToQwIFK0hQELpxvoncFEo51l+ghGxIbR/qpS4ufNqud2ys1gLW0R/jVMDqcGNRN+D3NadbgpJmMHIbQ68bceEBIg7IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5niT+Vew9uBMBKLrcrFqrfoZwyjoXAWZRF7MEUHJOeg=;
 b=RTUv9fcAouUaFmpR0Ho1zcXl4hp/Ep+nu/I3FY0gppcVI8MzwE7qjsA/H2wtaTCrE5tXqW+m/sBiaXOeOMb9BRX6Qp51x9KElccnT6qY8EfHTrcg/kf95+/lc2etCikhhSBg5gwzcmxvGSl7DGkOJIhhpsCMSrlkJZsXj22cuH+r4o7gv2kpCZKeLPbe8kW992XuLqn36YtUzXlClK/3rSxcV+4G91xr8V32h2dpNBe/f2UYDyC74VCO0j1q2dHoy8tmUltBeapoZX+QKma8HwL/I9JG5QeaL/6YwMBNwMzA/KFJhF3jRxcHHA76pThrD7KQfalzbCFlfscO5JzgFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by DM4PR11MB5295.namprd11.prod.outlook.com (2603:10b6:5:392::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Fri, 12 Jan
 2024 16:05:50 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1%4]) with mapi id 15.20.7181.019; Fri, 12 Jan 2024
 16:05:50 +0000
Message-ID: <f4cabd98-2759-4cd3-81ac-4afdf9aadf56@intel.com>
Date: Fri, 12 Jan 2024 09:05:42 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH] cxl/pci: Skip irq features if MSI/MSI-X are not supported
To: Ira Weiny <ira.weiny@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Dan
 Williams" <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240111-dont-fail-irq-v1-1-802c22a79ecb@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240111-dont-fail-irq-v1-1-802c22a79ecb@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0222.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::17) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|DM4PR11MB5295:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e31a4cc-984a-4c7c-78ea-08dc138858c1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lARdt6AaRZWrXYtvw3Hhv05rT3KkFLi9hbZrmG04fPsgLFT5iR4EcXHka+gOKH/mJhwfOyV2eTq4bRmkY08IxrJKIhP+CQsX58PZPJqabwyOASD1Us/C7ZO8Yr4xh/GD1xaXz8atwv5FyA6LEO2RSYomFTQhvtndFfcl6ktivBgwOZUMa6cTrZjCSd5WwdLNFpCzFAdCM2Gz6oRzfckJ2kv1dkdGw22eQKKTRxrpmlE84TOQntwF3xDGJXiy41yMzYJZGrDAp8UZQy9iUKGget4MClWCVXiDmyZmzmRF0Z1s3c7Rr2HQD4nGQVYC360nypExEdWHklPmBGad36xMSPAstZOFSsz6LG7n5uPR5PoQ82dm6Vv+CTeTeB+XhtycQJJk2pFwdxMWmoAjlhoiv2sZqBSOKI166l2FnM0T0a8ZjMsnmG+aSQKTJQBdo2DmvUfYdVQn5FKLxYFaBgQDhhybHUXfS5MlA19cROmMglWdheS/te04wfort4NAu6eYrUAU7JkSxCgJLp2lTaHQWQwFhSMz6FOondxmGkGVZPQN3tmVYgPKfFPQASlrUyTAqAGPfMyZ4bZRAU5qxBiSPeN1SakRUk7FOW/pbmJmMdY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(366004)(136003)(39860400002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(31686004)(83380400001)(36756003)(31696002)(82960400001)(86362001)(41300700001)(6486002)(38100700002)(110136005)(478600001)(4326008)(26005)(2616005)(6512007)(66556008)(66476007)(6636002)(966005)(316002)(2906002)(8936002)(6506007)(66946007)(8676002)(44832011)(5660300002)(6666004)(53546011)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1AxaklFS21YSk02d1k0WXdmMGl1NzBFTDlKdnhhdGxKOUhUVkgrRnhwSFcw?=
 =?utf-8?B?SVlmaTBYd2hReU1SL1lrSUlzQ1NJOUFnUFRlNG9WSEZRVTVCSDhrdHp6YW04?=
 =?utf-8?B?WC9zVkVxZitxQnorclVGcWM3eEdqNVJZN2lwc1VsdWlhT0Z0bFVWdTBKVVd3?=
 =?utf-8?B?SkVsUWJOMEJ0Vnp0SHVndEFNbVR4d1hqTmZ3S3RnUzZWdk9HS2p0c2VPeW1m?=
 =?utf-8?B?OTBXM0dXRTREei84QTFwTW40SXZ5a2E0d0RSZS9scnVxd0MzUVNKdjk0TzJv?=
 =?utf-8?B?bnExOWw5KzFzU2lja1hhd0ljMnBpTFZ0aXRRWnMvc0NxOEphb3BTVER5b3ht?=
 =?utf-8?B?di9FSTlqRzJrT2tTOTEwTmF3eVY4YUVOSzJlS1A0TSt1a3JBRmdBNGZjT3lB?=
 =?utf-8?B?UzFYK1FFSUpDQTIveFREV2xYTWdKc05YWFhSdm1nOXR6d0pPY3hVbGZJMXpV?=
 =?utf-8?B?T016U09RT3gyeXhBMlVod2E2a2RyQlZiNk9FcnNSV2JBMmd5NEg2c3ovWDFl?=
 =?utf-8?B?SDRBaS9tTHBxM25RUVdPL08zR1c4Nmh2dWFtNDdtTmhpcHYzVnhsTzBOV1dH?=
 =?utf-8?B?U0xMSEtvbUEySDZqalY2di9lK2cweklyYlNFaXlOaDlzcXNLVjJCaU1TK1Fo?=
 =?utf-8?B?Tmt3NnJ5c0VBOTJBUzBKZWJ2ZDlWTWc0S0tERkJ3d1lNVnRpazd5MmNTOUda?=
 =?utf-8?B?YW5scmluNDhTK29vVWVFM25YKzlhNmdOd1Z0aC9RSWlLa0Jkd2RuNWZyNDJw?=
 =?utf-8?B?TDZvclIyTk9JNmFBZWF4TXJzbEpTeTFWeFNQNHowWUJmd3ZoYnF3Rzd0eEFV?=
 =?utf-8?B?bU94Ylo1YTNWOE90S0NwN1NpOTdXUDRZNC9DZm1xam91RytlTGM5M3VMOGU1?=
 =?utf-8?B?UTlzdS9Qdk5DOVdrS1ZwNUNtYUdDbUhWYjdVOXZkcm9BZno5RkxhajlScDNG?=
 =?utf-8?B?WFQ3UFRYL1pMNzVwcUhoRitBUnJaMWVTVEV4dVNmelpRZkJUWXIrbUdJYWs3?=
 =?utf-8?B?Y29LVjFqeHcwVlBQVk5QSk5wWkhBaUlia051MGVUR0R1VXMrUjVTc0lCcTZ3?=
 =?utf-8?B?R09yVVJXbmhnUUN2RWFzSW9aTTc1YmhiTU9hR2ppaHZRWWtKNzhSSUNVZ0hQ?=
 =?utf-8?B?SnQ5cW9JTXBIUkJnUFptNEYvNUJ6THErT2FncE9UUFFRQVJsL0hCZ2k1UFNT?=
 =?utf-8?B?L0pnYS96UzdHc2xzV0d3S2wxK3dWb2FHQmlneE1vMnp0aWRLR0k0M21STi9y?=
 =?utf-8?B?cFFRU0VKL0FQSnBSSFduQTRPbHJZakRZSC9yR3F2YjdUb3N2clMvQlk2RUdD?=
 =?utf-8?B?WTNuOHIvZ0lWKzR5ejVheDU5dWZqanB6ejdIbm9JR05pd011MzBVZnpGWUdp?=
 =?utf-8?B?dUxlVkkzQmYyQUlYcmtLa3dKTkRoNkpacDd3ai8zcU53TGpxMGhVNGVtRkgr?=
 =?utf-8?B?aExOMlRtOXErcmRVMXp2dG93UWJ5Wk1zOVBROC9jNWlNb2ZHLy8vQUMwb3JK?=
 =?utf-8?B?MEdVQS9XTVY5ZFQxY3VWZnl0M3ltU2RmaCtHZDZUMUdMNnU5VmRYUEJxWGVL?=
 =?utf-8?B?SldWeWl3TVY4QWxRdXlKeWt5WDZsZVp6Njd4MVc2SlBJSGJlZEsrb2RRRk5L?=
 =?utf-8?B?NjNRSjVhT0tVNDVPenlYU2ZoVlh3YVd5M0tDZXUrcE1MNmlFWGpscjF5YWpt?=
 =?utf-8?B?T0lLWFhGTnh2bHRkcmRWUlB3SENveUY1bDBBN1JhYUpEMmg1Szk3d3B0bFdW?=
 =?utf-8?B?Y3JmeTB1aS9vMU9HZWVHenU2WHFrU0VyTTNmUVFyTTRKK0I0OFZ4aUFQR0lX?=
 =?utf-8?B?RlY3dXZUY0NNbmhwZVBlOVV4NXhlQmlFWDc0M2N1VWZmczZSWWtld3ZoYUZB?=
 =?utf-8?B?MjdZckhrOTBCNjlOK1ZGV0JHMkFBUDJwOENTV29QYk5DOE1HTlhsREVIUkcy?=
 =?utf-8?B?Uk9GUk9vMGNQMGZWWlBENjgwMUR0UjBHc2RqUTFQeEFqeVE2TEpiQjhCbmZs?=
 =?utf-8?B?VTBFaUJsOE5BM0pMVzNWMjljTkl6eEhVMjcyQWl0a3VYMWM5Zm9BV2Q5U094?=
 =?utf-8?B?WEkrME9EUW1OWVd1V3pFWDUzVmk5RjRyc1NyVUtKT0RPSDRMTmxkVnd6dmpY?=
 =?utf-8?Q?9lVNunKkfgOHp9jbyC8UGwnYc?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e31a4cc-984a-4c7c-78ea-08dc138858c1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 16:05:50.6739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XR2EXAN7vvBl4zQhwf94fjP3R1Q6WU93vcBm29BnlNjFYbjXylPkpNp8IJQ30R0blLNmagW11951k2inOxHtjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5295
X-OriginatorOrg: intel.com



On 1/11/24 18:54, Ira Weiny wrote:
> CXL 3.1 Section 3.1.1 states:
> 
> 	"A Function on a CXL device must not generate INTx messages if
> 	that Function participates in CXL.cache protocol or CXL.mem
> 	protocols."
> 
> The generic CXL memory driver only supports devices which use the
> CXL.mem protocol.  The current driver attempts to allocate MSI/MSI-X
> vectors in anticipation of their need for mailbox interrupts or event
> processing.  However, the above requirement does not require a device to
> support interrupts, only that they use MSI/MSI-X.  For example, a device
> may disable mailbox interrupts and be configured for firmware first
> event processing and function well with the driver.
> 
> Rather than fail device probe if interrupts are not supported; flag that
> irqs are not enabled and avoid features which require interrupts.
> Emit messages appropriate for the situation to aid in debugging should
> device behavior be unexpected due to a failure to allocate vectors.
> 
> Note that it is possible for a device to have host based event
> processing through polling.  However, the driver does not support
> polling and it is not anticipated to be required.  Leave that case to
> the future if such a device comes along.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

v2?

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
> Changes in v1:
> - [djbw: remove persistent irq boolean]
> - [djbw: Simplify error messages]
> - [Alison: spell check]
> - [iweiny: test]
> - Link to RFC: https://lore.kernel.org/r/20240108-dont-fail-irq-v1-1-4407228debd2@intel.com
> ---
>  drivers/cxl/pci.c | 29 +++++++++++++++++++----------
>  1 file changed, 19 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 0155fb66b580..bd12b97bb38e 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -381,7 +381,7 @@ static int cxl_pci_mbox_send(struct cxl_memdev_state *mds,
>  	return rc;
>  }
>  
> -static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds)
> +static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds, bool irq_avail)
>  {
>  	struct cxl_dev_state *cxlds = &mds->cxlds;
>  	const int cap = readl(cxlds->regs.mbox + CXLDEV_MBOX_CAPS_OFFSET);
> @@ -443,6 +443,11 @@ static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds)
>  	if (!(cap & CXLDEV_MBOX_CAP_BG_CMD_IRQ))
>  		return 0;
>  
> +	if (!irq_avail) {
> +		dev_err(cxlds->dev, "Mailbox irq enabled but no interrupt vectors.\n");
> +		return 0;
> +	}
> +
>  	msgnum = FIELD_GET(CXLDEV_MBOX_CAP_IRQ_MSGNUM_MASK, cap);
>  	irq = pci_irq_vector(to_pci_dev(cxlds->dev), msgnum);
>  	if (irq < 0)
> @@ -587,7 +592,7 @@ static int cxl_mem_alloc_event_buf(struct cxl_memdev_state *mds)
>  	return devm_add_action_or_reset(mds->cxlds.dev, free_event_buf, buf);
>  }
>  
> -static int cxl_alloc_irq_vectors(struct pci_dev *pdev)
> +static bool cxl_alloc_irq_vectors(struct pci_dev *pdev)
>  {
>  	int nvecs;
>  
> @@ -604,9 +609,9 @@ static int cxl_alloc_irq_vectors(struct pci_dev *pdev)
>  				      PCI_IRQ_MSIX | PCI_IRQ_MSI);
>  	if (nvecs < 1) {
>  		dev_dbg(&pdev->dev, "Failed to alloc irq vectors: %d\n", nvecs);
> -		return -ENXIO;
> +		return false;
>  	}
> -	return 0;
> +	return true;
>  }
>  
>  static irqreturn_t cxl_event_thread(int irq, void *id)
> @@ -742,7 +747,7 @@ static bool cxl_event_int_is_fw(u8 setting)
>  }
>  
>  static int cxl_event_config(struct pci_host_bridge *host_bridge,
> -			    struct cxl_memdev_state *mds)
> +			    struct cxl_memdev_state *mds, bool irq_avail)
>  {
>  	struct cxl_event_interrupt_policy policy;
>  	int rc;
> @@ -754,6 +759,11 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
>  	if (!host_bridge->native_cxl_error)
>  		return 0;
>  
> +	if (!irq_avail) {
> +		dev_info(mds->cxlds.dev, "No interrupt vectors, no polling, skip event processing.\n");
> +		return 0;
> +	}
> +
>  	rc = cxl_mem_alloc_event_buf(mds);
>  	if (rc)
>  		return rc;
> @@ -788,6 +798,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	struct cxl_register_map map;
>  	struct cxl_memdev *cxlmd;
>  	int i, rc, pmu_count;
> +	bool irq_avail;
>  
>  	/*
>  	 * Double check the anonymous union trickery in struct cxl_regs
> @@ -845,11 +856,9 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	else
>  		dev_warn(&pdev->dev, "Media not active (%d)\n", rc);
>  
> -	rc = cxl_alloc_irq_vectors(pdev);
> -	if (rc)
> -		return rc;
> +	irq_avail = cxl_alloc_irq_vectors(pdev);
>  
> -	rc = cxl_pci_setup_mailbox(mds);
> +	rc = cxl_pci_setup_mailbox(mds, irq_avail);
>  	if (rc)
>  		return rc;
>  
> @@ -908,7 +917,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  		}
>  	}
>  
> -	rc = cxl_event_config(host_bridge, mds);
> +	rc = cxl_event_config(host_bridge, mds, irq_avail);
>  	if (rc)
>  		return rc;
>  
> 
> ---
> base-commit: 0dd3ee31125508cd67f7e7172247f05b7fd1753a
> change-id: 20240108-dont-fail-irq-a96310368f0f
> 
> Best regards,

