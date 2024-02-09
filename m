Return-Path: <linux-kernel+bounces-59976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C381D84FE1B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D04D1F22AD7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D94C168A3;
	Fri,  9 Feb 2024 21:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hYPO50jE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58EE11196;
	Fri,  9 Feb 2024 21:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707512558; cv=fail; b=ILGn88+hFR9P+H4AeDVNSVaks4OmHxdQVtyyWCfFkPBvgPHGbRuSscGF6eQMgnQCYEcnFUnPO0khssr6iomsLOz0N3IHpf1SwQmbk5iamTQG2KlA7B8sM6By86DK14lq8HqzCqpcYXFgBg2IoCtevI5yAZjV3E6LCrft+LooQ30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707512558; c=relaxed/simple;
	bh=dQBohkvJ+TYD/Nf128C2b4kYV82VxsVVhLmwmNrq7FA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mL1dVUbvgWSIizM6hMEnJbAsVtC7qx70+hkDUkjRxHFwIj6ZffRQ4M+AmpfgkrRBp2kBupuuAKtb49HDZU2QHl95u1I71OU7fiXZnA8gwlzF6UAWWmSlrOC8QoAh3mjCFM5uFIkhywFJ6cReYqM0gshW9Iwsd+lnWFaKywo6KJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hYPO50jE; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707512557; x=1739048557;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dQBohkvJ+TYD/Nf128C2b4kYV82VxsVVhLmwmNrq7FA=;
  b=hYPO50jEHijWvLuUBaKAliOSOodhFebfX/rQKkaUxDkMswvr4FWO8CXk
   Qf/iAvfwRK3noxB9vgswHyDAjEOdM/u6xQsba+iQ+FQLV8gTMnAv2PrJy
   YAKKaadZrWEOFciwt3adMdHzH1/gQANeZCBcdnW7XEeiBKoJ5X5IoBj0y
   yWMw+79dN5JI+bcQEVaOzxki49b+2nAWW3YVu5pFys+yax1/UvqUqiPUW
   vCLCBFQWnlyvWYMvW+ei6hYe5kvZQB8YXQY5b3chWyFvQO2igE4SHxob/
   HTUSMUVf3pKr4gX4qka2eL3lLfKAUBdSKw1PMtd30b3Ph/8ILfelTuZaj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="1634399"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="1634399"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 13:02:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="32820026"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Feb 2024 13:02:35 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Feb 2024 13:02:35 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Feb 2024 13:02:34 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 9 Feb 2024 13:02:34 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 9 Feb 2024 13:02:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ikPZjxiM72+oPh7tuP7Hv7XUEdHggvERCXAhEO/pQ4KnuRbvXqgzCEg7xO2PbcayemHg7J1tWisTpUT1X06KhCyMF3bUQMZq65S+F6sYW/YNgfDA27tzINgriNVixMjDSBF97KwwS7wdZFl1b7XZXu8xlRPwqcoY/m7kxou0yyjTTBFQQheXFSTwb006P8Uw4R+37trpanAnOcldZWbeVYy5tUpC/K+H2DTXHysH2JnnBbw3B/d2QgWzI2pcvWnJmKzX7lgBJYF9nRkSA0hDbNL2OdpWGDUbPeMOnZVj/wZiTwTiSDkB0PzXvOS8yGkn4FaLyV5Ep0KiNozsPffI7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oaBmlcggZrwziNxHkE2EGTiq7aYKAwAq4n0PqnRh2BQ=;
 b=R3XC2+9Cps1J2dFsYOXtsQhLqRUmo3YaptJFMNffMDoYFHCmQ3DcjCcslH4JYQJZTNBMkXVSaZv2hJYqIuc71bseAhi8bNQ+tQGOSBBlRZwD8dzXtyO8d1T0DL0xZ8UCuE3Pq/wwpsbEW7SABQ9pfZpPpyaw4W234IiorP20XoH8vkaPkL92VuZdAo2NTJNfHW7mq8JdhoD8eypDcxWY7fjyZYSKXpU8aEGEqD07uz5wTH8w9XRvybNx7WeanDU9A70bkX9qoqS+ygS+0xmMe6aXYZUFlfX7aaNvAzshUp0n5TUVzHlagFjZOVda2tqFnaOyUeblZBOt5MAyK6p86Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by IA1PR11MB8174.namprd11.prod.outlook.com (2603:10b6:208:450::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.27; Fri, 9 Feb
 2024 21:02:32 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::c3aa:f75e:c0ed:e15f]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::c3aa:f75e:c0ed:e15f%3]) with mapi id 15.20.7249.038; Fri, 9 Feb 2024
 21:02:32 +0000
Message-ID: <4850ef1f-db20-4fb2-8658-51f27330c343@intel.com>
Date: Fri, 9 Feb 2024 13:02:30 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] x86/MCE: Add command line option to extend MCE
 Records pool
Content-Language: en-US
To: "Luck, Tony" <tony.luck@intel.com>, "Naik, Avadhut" <avadnaik@amd.com>,
	"x86@kernel.org" <x86@kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>
CC: "bp@alien8.de" <bp@alien8.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "yazen.ghannam@amd.com"
	<yazen.ghannam@amd.com>, Avadhut Naik <avadhut.naik@amd.com>
References: <20240207225632.159276-1-avadhut.naik@amd.com>
 <20240207225632.159276-3-avadhut.naik@amd.com>
 <8b4f8ec2-7534-4f77-b44f-6728c699ff64@intel.com>
 <51255499-0b5d-45c6-9c72-f353bae83c0d@amd.com>
 <ad674def-f129-4470-b07d-b1ed809da4eb@intel.com>
 <SJ1PR11MB6083D8390032B7072443F83CFC4B2@SJ1PR11MB6083.namprd11.prod.outlook.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <SJ1PR11MB6083D8390032B7072443F83CFC4B2@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0048.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::23) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|IA1PR11MB8174:EE_
X-MS-Office365-Filtering-Correlation-Id: a68b8bf5-2840-4728-b715-08dc29b26f1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SFIgHUXtUYHBi1c3VOtsR+Qixvc4Yd0rfyA1b+sBjYgaFGUHZjcn0+1/vFa3AcDGyNUb5TtyvyB3vfOwSoYzBY+N92idNMO4X2k3OMPNkXPEXLUxM+Msg9FlKfF0GfSBX/9OpZ2c2eVMV/IHn9Vyrfnj9wgCMkpdxduIQ+r7N4eEjsyofAPtG3G0CxI6n2MXTGmH8sD22ekEiUI+l4Io3tb8AUrnci35FPsFS2U0DScw6I1PRiQ1+tfS8nun1uTPbXxiKMABttNPTCr+xn9r21eDkZFgUk1FfacJPocWs0A1bixdU0cKlbe9WFkmFhLk7L1AcFHCY4CtqsowlQZcWXK1olIastPq/972O4g/xwrJ/5UsC1vfseYsu3Q8BzY6iVTKKC0Hd25+UGH4epOGJZOfR8Nr3Uafof9vMce5mq/Uds+ugFLu+GK11Abkyy6jvWFrNtSoHVGiyGgt3hG5kAPjWb3bfSxkv2EhGhHI/3byakxzoWn2FWS2AsvaqA761WgdRKVregsEpvZOrYhbrytSbsR0ZJswofBZiF812Nc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(376002)(366004)(39860400002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(41300700001)(6506007)(478600001)(2616005)(6512007)(966005)(6486002)(53546011)(31686004)(44832011)(2906002)(5660300002)(4326008)(8676002)(66556008)(66476007)(66946007)(8936002)(4744005)(316002)(110136005)(54906003)(26005)(38100700002)(36756003)(86362001)(31696002)(82960400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUFPY0JMcXNPcGx6bXJmT2xkRlYraEl0VldpeTFkUVkvSUZFTTNmZHhDYyts?=
 =?utf-8?B?QWxwSm1ONFoyMHgrcGVadGhoN1d2NjRtVlNlTVBaN3lNMlRKQWVKSTViaUY2?=
 =?utf-8?B?eG85K0lQY29xd09lUlg3aXR5TWM5ZWNEUlp6cDYxckYrZ2pkb2dEM3BCM3l0?=
 =?utf-8?B?dHQ2RzIzMTJGaS85OEh3YWxCek0zRnVsYldVOWFPVnUweEkxM2plUzZONnl1?=
 =?utf-8?B?a21oWHNoRmViNS9KU1RZS2VWbjNVa1MyTnFZSXRzT3hDMDVYWU9COGZhWmJQ?=
 =?utf-8?B?WjREUDlERGJOQzYzZkY0cTNVOWtORTJKR09lZ2RsaXdxL2FVekErL0g0cHhw?=
 =?utf-8?B?RWR0S0kycGk3aUNVTEdkVlY3ZTh5L1pCZ1E5TXRBK203alQ3WklqMEtFdmlB?=
 =?utf-8?B?cDhNUElxU3ZFQUpZUTFhakFKWHRlNk8yaUJaVTFINGdoQ1JFWUU3b2xpM0Ju?=
 =?utf-8?B?NEFoeEhpWlhpOWtaSmhmSFZnTHNyNmdQVUk2aTRHK3d0eG54U3c2SGRnN1A5?=
 =?utf-8?B?aFlNZFlJM1FydlZtdmZvT3VHSlozNVYvOGJsczhTV21SWXNteDk2K09KZlVD?=
 =?utf-8?B?QUVvRWtqTXdVUXcxR2dUMEdId2tVb3d6elVVMG1ycFo4S3BOTWJqS3NONERR?=
 =?utf-8?B?ME52SFdrZWRleUNvUnIydnl1Q3BFN0hGUUNlaHpTU3EwV2xXRVIwOW03NytR?=
 =?utf-8?B?M3JMdlVtWE1UUVNwcmhjK3JqUlpVeklGdEdqeDUyMWppektaUG45NDFYa2ZI?=
 =?utf-8?B?dTFDdzArcHZoWHJjMFpURGVMV1dsSUxPaW5PL1VRaDNSR3B2eVhrT1ZUZmFk?=
 =?utf-8?B?ODdxcFBoTU1PY0ppL0lMbjBIckxoYVBSbW9sTFIwSURyTVlsdzBqVXV3Y2FB?=
 =?utf-8?B?MHFTVEwvREZGamhuM2pvbUVQK2RsYnhYODg1ZkpKOFFDUTk0RTRxOUZDbEpI?=
 =?utf-8?B?TEpoSmZPNGxuL3ZaV3B6Z0hvcGNYWWViNWgvSUFDa2Uwak9XL1pNcitCci9l?=
 =?utf-8?B?WFBWdk1oRXNpdVJLa2N1SXF0SDg0dTQ1c253eWZWeHFQTmovRW9Dd2JBRnk0?=
 =?utf-8?B?eTZxQ2s3RHFaN24zM3Q4YXlMOSs2MllYcnhTYnZ0MWlHK0lKYmhiazhsSmRr?=
 =?utf-8?B?aStPUnlYYzNydzN1YWs0cDNjZS9CY2l0aS81b3ZDMUtXc01WVndVdTR5d0Fn?=
 =?utf-8?B?NWE2UGhVK3lNcXRCeDdsV1cwOG82MHFPdWk3UjNHb0VQeGYxNlFObU5oclFC?=
 =?utf-8?B?Q1BVRUU3SnVVRjFCTDQrb2FqNlAvOFNVeFpwTnlYYk9TVHlHdXp0a2dYSjA5?=
 =?utf-8?B?NnlKUnc2bk5mVzY0RGgzOXZpWWFmaU9tMC85Q0hWaW5XTHNXMHNmTFFqUEVy?=
 =?utf-8?B?RXdFV3Y3c1VQc3ZpNlZtUk1qT21WWGpMMEZjbjk3RmxSMUQ3d3IzUUNQaXRy?=
 =?utf-8?B?eHlRdlhXSitxdFJwWkhlRW5wNnN4T2o1TXpiV1NnTXM0Y3pGb3U0VTFwaHNS?=
 =?utf-8?B?bEplVXNqU0w1S2ZzQ0ZSWlUrQjJkeVdFeHFGUnE5Um5MZ3JpMy9YeEpmVS9Z?=
 =?utf-8?B?Z0RwSUJYT25hajRvcldMMmhTb0RBbHQyR25kRG04cTBRNUg3NDBJS3VVWnNi?=
 =?utf-8?B?YXkvanhDU0Uvcktob3l5L3EwelptSHV5S21PS0I5TjJ5VmlkYXNramN3NzZy?=
 =?utf-8?B?dTZQOWdCYlE2SG9ZUUZ3d0k3cDkyYU5wV0VKcWYraVVEd0VoRjZRNng1ME9m?=
 =?utf-8?B?MURram1zUDRSTFdNOUJJQnZqZURrUXBnTkhEYW02RFA5eTRpR1NVZ3FLRWdI?=
 =?utf-8?B?RjdEdVhHOGZDR2xBczZXZ3hsMHFDZWNDQlA3cCtGb2YwWmNLYllwNk54SzVh?=
 =?utf-8?B?cFNDenBEckk3UjRxRWJoL0VhSUJWeXFZTytOUG5wODBuSGZlZmEvRjZXWlZu?=
 =?utf-8?B?ZEZTN0VCUkU3SUtxT2ZFVGtKNjlreFN1WHdjalVIV2plWS9MVTE3ZFlWNS9H?=
 =?utf-8?B?MnB1cUFwU0ttUGxiQnpkQjZkM1h0eTNFTWhWVEZkVkdWcEFtMVY3MVFuQVZB?=
 =?utf-8?B?cDV2NVNPU245SXlEeURadjBRN0gwMkFDVXk5S0ZVaEZCSzFBWlZNY01GVjhp?=
 =?utf-8?Q?govREL5ziPjzcPsTE+HNnMegf?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a68b8bf5-2840-4728-b715-08dc29b26f1c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 21:02:32.5813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n//RjBe1SajwMsIcG+wRHRt16WUxRv/SChMu7IUFw4rUDMi0t0VYG74XqDD7ImpR3+Em5D5sHJ9HDxQ5yFo+/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8174
X-OriginatorOrg: intel.com

On 2/9/2024 12:28 PM, Luck, Tony wrote:
>> How about being more conservative with the allocations in the previous
>> patch so that we don't need to introduce this additional mechanism right
>> now? Later, if there is really a need for some specific usage, the patch
>> can be re-submitted then with the supporting data.
> 
> There used to be a rule-of-thumb when configuring systems to have at least
> one GByte of memory per CPU. Anyone following that rule shouldn't be
> worried about sub-kilobyte allocations per CPU.
> 

I meant, to avoid the need for this second patch we can always start
lower and increase it later.

256 bytes per cpu seems fine to me as done in the previous patch. But,
if that seems too high as described by Avadhut below then maybe we can
start with 200 bytes or any other number. It's just heuristic IIUC.

https://lore.kernel.org/lkml/8d2d0dac-b188-4826-a43a-bb5fc0528f0d@amd.com/

Sohil

