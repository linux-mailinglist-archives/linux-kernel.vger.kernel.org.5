Return-Path: <linux-kernel+bounces-52092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5864D849401
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 07:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7770B230A0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 06:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D420F11197;
	Mon,  5 Feb 2024 06:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bgs6x9Po"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A46B11184
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 06:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707115872; cv=fail; b=NrfWM3+GyjZJ7K9KFffY2x1t7AkpKFreQw1Mx1gBZz+TvJoj/GdTKMuhI4F7a0lxFA3iqPwWmkwb9LO7YeFhAro4KlPH72QsgLnzNtRhQ6DZpMHUFm52HHRU0jbKJDzN/CHeAj/7g0KoIwLGruZ3lXElSqg8E78yw65fpy7HI+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707115872; c=relaxed/simple;
	bh=wWw+KXPuXIsjXzQ+ByUPuHt66ljZr0rX71zCGTQA+Ko=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Pc2m0gqugO3soWSH8eYmkKQSxN35evVmakS9uYjmTz2aC3mXnu0SsW/0HMgpQO6j1YBwm1cN4u/WGLiqQ0nB3A6zInzGEeqOgLfIdbg3uO5KJxE69cTdLX64hgefsjjXUErJv4fKxoNHEys2PXuL+3d1n6gL6JMiPKF34ikjmwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bgs6x9Po; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707115871; x=1738651871;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wWw+KXPuXIsjXzQ+ByUPuHt66ljZr0rX71zCGTQA+Ko=;
  b=Bgs6x9PoaBKxUBiAzsIN3+WyG/5BAGmGoyGE75+C2J3XiXWAJrC2rmCQ
   S7E+Z3vemMfsXMDANFaU/XVxdX3IM105uz4HZrf27ss3pHQb4bINw9fty
   hbd4iYFCciAt92rRE8dn12JhQevyXXk9Yc0WgQ//UOnamyHc9UtIJ/lnJ
   x2FsIhcruKn+ZoWN104QY8vWNpcA3HkhB2HH347uz0z9pAC4fSeeOIivr
   dcPUIhF3nmBNw8xnvpUAWu7P4MPESTWjlUmhurZswRgBfomDan3/HejV9
   fEPUwqquF+9n3o1oN45bqZ0IuncDMjuS1zByMi74n089ODl5gUL7KH64+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="11819049"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="11819049"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 22:51:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="689117"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Feb 2024 22:51:10 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 4 Feb 2024 22:51:09 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 4 Feb 2024 22:51:09 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 4 Feb 2024 22:51:09 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 4 Feb 2024 22:51:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UiFZ9ZxwNI0/s7ndX+hXqjaO3PSZoZoUIfnsu7UZHYYwEBT5Y3rmDx2R2bUYrJf2Iz3lk72NNEqeu69ByEFcERi3aBm9eva0IYag1A4MlUjSD28tvrZhfR8EhuDNFeMk04Fi0YGr7MbVJA/eLxcnvoEC50unFAurAkVfgWrs3SI3Zo0z+MbyxhrgrdKs5/+q2LemXALfCz5iXaw9hDq3y5yQ+9aNFKvV+Yg66onlDhW7qdiF9AvzR0196cDqp0iy4G+PFg50omv8AnAlYfcBXE1DxhGVaMFYOuWHsCwC0QtTKL6KN324lNWu0egwAzDmInPNeHzLQ7IlTxiijCuxFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OYWlWCDbtpYhJFU43UMb6rgBE9uYSOqdA3GEZtvW0mg=;
 b=Afqqj6ufjKCNz1vnkh4nD0p3qi3ceBia2wETAQzFVQALh4V8rCfnE+xWozHceT7I9YJ6o14IaUaQnj+RS1ymjteQpiGWzrNrXMQcRxMQsKn/MLmxCAmamDd1vMDsX8P41tQXl4hk3dh28VBrEN27HSDd6PlhrJepsfw0QnZmWdpQCDQu8qgTnyWicbSf/pd/ZkbBZQdKFFdDLUJzaI6slj/R7vT+j7ONndMlDvYlZ5JCxgolnjyzOZbpI29aterK8sX3Ji5K4Q34lTkj3EGuSZRiDR1HsDblXR8Lq2iQbb39KK+wDCTVwkIjMdDx0PW8eD75CeZX3u5zFG2VSUu46Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DM4PR11MB5567.namprd11.prod.outlook.com (2603:10b6:5:39a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 06:51:06 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ff69:9925:693:c5ab]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ff69:9925:693:c5ab%6]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 06:51:06 +0000
Message-ID: <23b05fe0-60c5-4cd4-bfe8-b706c34d23ac@intel.com>
Date: Mon, 5 Feb 2024 14:50:58 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] TDX host: kexec() support
Content-Language: en-US
To: Tom Lendacky <thomas.lendacky@amd.com>, <linux-kernel@vger.kernel.org>,
	"Kalra, Ashish" <Ashish.Kalra@amd.com>
CC: <x86@kernel.org>, <dave.hansen@intel.com>,
	<kirill.shutemov@linux.intel.com>, <tglx@linutronix.de>, <bp@alien8.de>,
	<mingo@redhat.com>, <hpa@zytor.com>, <luto@kernel.org>,
	<peterz@infradead.org>, <chao.gao@intel.com>, <bhe@redhat.com>,
	<nik.borisov@suse.com>, <pbonzini@redhat.com>
References: <cover.1706698706.git.kai.huang@intel.com>
 <c86203a5-0223-4824-888e-76ff9565e178@amd.com>
From: "Huang, Kai" <kai.huang@intel.com>
In-Reply-To: <c86203a5-0223-4824-888e-76ff9565e178@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0169.apcprd04.prod.outlook.com (2603:1096:4::31)
 To BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5978:EE_|DM4PR11MB5567:EE_
X-MS-Office365-Filtering-Correlation-Id: 1735d28b-14a5-4c08-ecd8-08dc2616d398
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZTE15myBlc9516+WWGWW9pHtg0uqnydo3A98GYKmUWJlA0L/5MD9wPzJInrYJFceRZtFCIMzTyNT4rN7sA3mqbtNztaNcPkAlWAX1ZDc0XIjIy6BRiZNInYpYnfacFjXYe820KTHTTlzdGSl0VwRzPtVioHuK6bRgUgt6hsGhLRn5o7J6RVnNOnhmtwSz++Eu0aHPKwoLY3z+BtrGpFCIWpk05YO+Ftg/M5Y1xKRZChiVLsXWtg0+SOHJho4LhDrR7J0YolEGaZGsIKQtLgURo+uFAZSHdXPeHtfr2iyC+7VzpWKrgnEVQJca4yYFOA4rvJwKy8+tmdTgg739cS157geyyirSFIM9WKePXcSfNqlBVdQWVWTxEUKOn2jVmpeSRnBQ71q0YOXC4ox2ig9mQmVEcCQoCBJAg8Tpot+rHvus8bcuKEbPzLeALv+xSZFOEPRUApe8aJFHghfb/WEms7sO0DYVhV3QuBV6MBPdD8AcAUgpMhJOhwopFWEQqyuYwi4j0NLUdFmZwWNp2Av4j9EVYYCeen9gjocUVVy+GErnbyeha41ZdHtD6Y+9+dCZ7CZ6QgP2yl4QsJg15MMlr5v9o3g9IuOKYnrnsXwAivjRqt7taEzrTNPnhvS9O7APyYqQdMLKVj7CSdmA/bXww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(366004)(39860400002)(396003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(31686004)(41300700001)(6512007)(6486002)(31696002)(53546011)(86362001)(36756003)(2616005)(7416002)(82960400001)(83380400001)(26005)(6506007)(478600001)(316002)(66476007)(38100700002)(8936002)(66556008)(66946007)(4744005)(6666004)(5660300002)(2906002)(4326008)(110136005)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekk5ekdiZjhxL1liOTBoMWdEQlZJNjVWeC9IM0VNUHhXQ3I3QTlwTlFRd2Z4?=
 =?utf-8?B?RGx2Qy9PQTh6SlNpRSt3aHBpV3ZPRUxXWEJVVGdtTlQ0WUxNRlhSbldkVHVC?=
 =?utf-8?B?dXlvalJNTmY1SXZJUVFpVmVqWnYvSDB5UDIvcUZkUkRSQ1p6cXBoTnJTWFNk?=
 =?utf-8?B?Zi81dkhtbVg0K2RPUjZXTmFwSGx5Ylo2V3BIVTNnZzlPdGFlazl5dUc0NENJ?=
 =?utf-8?B?blFiRkZNYzBQWTI2MCtEMFp2RHZOYXlWTnZKUmdsV29WaFVPcWJuZHRCWnNU?=
 =?utf-8?B?OVZRbjB0Q1h4MVMxeFd3T0orcUFGUWs3NzBrMmNQdmNpUnRacnl2ZnN2WWll?=
 =?utf-8?B?Z0JyK0lWTnBFWjYvcEJvZUxKSGJrYlBqbHd1YTBCU2pGOVFmSElRT1BMdGVq?=
 =?utf-8?B?WUJtK21XaHRRczlKc1B2UTd0U0pLOEVoU3dJS3NET1dBaCszbWdCbXh4cjlK?=
 =?utf-8?B?ZEpDOTlNT1B4MkMxbGhnWVhtVHA4UEg2Y0pCU1FzZXg3aHpzYU1lYnY3a3lm?=
 =?utf-8?B?TG1wcm1tc2ttd0F5RkhWa01IblVzYThuRzNGeGhWZzAzWW5TTFNtYVcvYm9Y?=
 =?utf-8?B?TzhRb3lhRDhlNEtSWkY4QkpWR3FpLzVDL0UwdmVxbGpMblNQeDRZbURZanY3?=
 =?utf-8?B?eWdNUEM2MUp4QWUyazBHVzdXRTJOemVjU3hUMTROeSs5V0dHTHR6TUZjQ3hr?=
 =?utf-8?B?ZFJSTS95bGZRQVhNQzlaSFc5TzVuQjFpRnFrWkE0R21XcHQ0enlXK1p3QUdU?=
 =?utf-8?B?aHcrdk9iV2MyMXJKVndKeUZ3ZGpCdFVvTFV0a0dxbHRUbTY5VzR6c013SEl0?=
 =?utf-8?B?OVI5a21uZ2szMzdPZXg0cGxnKy9UbUFCZzdZd2UxaHpXMHhSWFpGQkc1ajdk?=
 =?utf-8?B?akh4SDVvVHdQbWR0VHFWVXNvOHJORzlEdmo1UU1LUXpNdVR0bmVaLzJwUDN4?=
 =?utf-8?B?RWxWcjJsQkJnZkR5aWZzZklDV292SFU2WHZSaDl3cnRsTVZTSll0dEltSVNR?=
 =?utf-8?B?a0ozMzNKMzJtdTRmN2d3emh5V3kwZkJDSDBOU2FXMWtiNnA0cVAxZ2NvWkQ0?=
 =?utf-8?B?Rkk4YlFBdTY5TVNUMkthbkdLcU91N05zVWFSVGkxaFliS0ozck1CWlhpWEJr?=
 =?utf-8?B?R1FRYnJ2N05jbmhkV3RTSjdFS0xWaWhBeWRtYzdYZ0lia0tWei8yUG1KbGxL?=
 =?utf-8?B?aXBOaUJLTkZpRVRpcUlqWmhBQ2s1TDN5OTBsT1Jncmx1MWxNR0doaTRzd05N?=
 =?utf-8?B?Z3dxZ1pXNmZDaVhlWnpxMy9IL2lmblZ0OUZCcnhWeU9ac1ptekUxU2pkUndM?=
 =?utf-8?B?QjZXQVdrd3NZTnVscEtpdDdLdy9RRzBEVVhsVzhXTDcwTUpNU1RPdXBoSWc2?=
 =?utf-8?B?aU9aOHlDYk5nQXo1U3VjRnJhMzZ5WEtaOXZKSzlOOVk4c0J5QjBJMC9kK0pY?=
 =?utf-8?B?Y2tBK2N3Q3BnZ05EckFsMXV0dzRlZ2ZZQ1VGTHlSWGpMdEpsdEwrYTVTdUZP?=
 =?utf-8?B?TkthQzA0OEt4K2t3aVJ2WTQ3Z01vYkV0L2tmMnlJNXdFMllhczFFTklFM3pv?=
 =?utf-8?B?UXp1UG01cE0xV25Tc2FXbW55dk44V29RVXI0dUdmek42SjZmenZaTG00Tjd0?=
 =?utf-8?B?MmtrTnlLaURicThzK1lBN09ON1FPRENtUWVad3I2UURKcS9SaERLaE5jUHl5?=
 =?utf-8?B?MnNwTXN4KzEwZ2UxV2NyUjJYUVQvUWs0bVN1NHRSSU9RSGkvMThtUVcvTUhu?=
 =?utf-8?B?QnBtdTl2ZmFTYnl6Z2J1RXJCZjRWLzdUSDNvanhpWHJhUFl2R1loVStMdUZF?=
 =?utf-8?B?TGJnNFU2SEhscU5NOFlKSE5IN2F0Vk56Ym5JcjdwMlNmUkFUUDZTYkZMMnA1?=
 =?utf-8?B?YXJOR1RaYW1xYUtxcjdIVFRpeUFFeDdQRnl1bUxrS2pHMDF0YkFmT2c0WWxY?=
 =?utf-8?B?aXNGZ3QrY25HazBkN3VaeHhleGdaZVp4VzQ0dVAvMXh3dkpYNU1YRlJCdmxN?=
 =?utf-8?B?K2VuNUMyKzJkVURKWDVOd0ZwM01Hczk5S1VKL3J3cFVjbnNzYmN5MmlpK2pt?=
 =?utf-8?B?MWIvaWU1NEFJYzUzVkEzcGc0Z1p3eHBxQ3dYekdWVFNPR0dKVGprdnFveld3?=
 =?utf-8?Q?D5FKcApO4RZtFFVs8oAFg9vfL?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1735d28b-14a5-4c08-ecd8-08dc2616d398
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 06:51:06.4407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: clWb0xvJdPHTUjcFDft5bMCwL443fZSCTHbQobKY6lfPpRb63DPNU00wvgJvzg0jTw3nUmhyXYEmVLYyGbiBmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5567
X-OriginatorOrg: intel.com



On 2/02/2024 2:28 am, Tom Lendacky wrote:
> On 1/31/24 05:31, Huang, Kai wrote:
>> Currently kexec() support and TDX host are muturally exclusive in the
>> Kconfig.  This series adds the TDX host kexec support so that they can
>> work together and can be enabled at the same time in the Kconfig.
>>
>> This follows Dave's suggestion to add the CC_ATTR_HOST_MEM_INCOHERENT
>> attribute to unify both Intel and AMD, instead of having Intel/AMD
>> specific checks around [1].
>>
>> Hi Tom,
>>
>> I've tested on my TDX testig machine but I don't have AMD machine to
>> test.  I highly appreciate if you or any AMD guy can help to review
>> and/or test this series to make sure I didn't break anything.
> 
> Hi Kai,
> 
> I'm adding Ashish to the thread to take a look at this as he's been 
> focusing on kexec related things recently.
> 

Thanks Tom.

Hi Ashish,

I appreciate if you can help to review and test the first patch.  Thanks!

