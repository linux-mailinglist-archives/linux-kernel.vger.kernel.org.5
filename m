Return-Path: <linux-kernel+bounces-69445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC51085890D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65D9B282708
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5704914A0A5;
	Fri, 16 Feb 2024 22:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bk3VB+WW"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F5614A08B;
	Fri, 16 Feb 2024 22:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708123308; cv=fail; b=t+bDjURJquWVJ3HsPLjHDSvkrUSEyCMSQfUfHBAtuekedUWHaOLLAVsFtPDCt8I+ZGN1PQTbFbKVaHKOfh0DesW4KMMoI1PgGHbj+CR73LHJkVbgGRnjvMk1YrB7AOrVK//U2R2hUqNrZUVcMprqFoJUQUEl4CoimJSnX8iwiOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708123308; c=relaxed/simple;
	bh=2CBYE0TG0FpiW2Jmnjf1AYBh+E8fKVcP06WEVDnVe1U=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XFJNlynO+CXxAPrf+FI1/VGMwFS4oaYUCl8BbIkBaOVqm7L+3/0cOg1crwz/C1RUECM14YQQL3MGD6uIURGv2AC6oFzCRRnaX+ghMHwUWXS66uxM6cvBz+zNL+jqbzDxg2ESm8TzJU5ErMrYJWatXtrj3rY0/JDLeNeLU7E5+tc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bk3VB+WW; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708123307; x=1739659307;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2CBYE0TG0FpiW2Jmnjf1AYBh+E8fKVcP06WEVDnVe1U=;
  b=bk3VB+WWPTaxwhV7OyixNeaRnpRFON9THIEl07YEpcxrmH/zKdYFwZD3
   IX/Np/JsQvla7JWw4b8i4v8KruM0AbSbxD1J3RZbLcYa3Kh4BiTCnyhQ3
   ebS5+Zys+pdk+uLCR/7sRxVdfRvzwymgwv4NP9QvJx3VWWigN7+dtxQLj
   WKHXY5qeG/EW+YuWI8FGSkElOahNDmLW+YPpdUTSWhpLqmK5VUKr43QrU
   bDJ2qbOz0jcjg+19emQ1VLoEJ9Ehu5i7dji4SPAbc196QzFhnZBg5Nx+b
   dD8Acd7rS3rLXRc53Tifwkx2OgGNjEI9Kf3P2fyWPq+hoCwjDWL6uCi5c
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="2146127"
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="2146127"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 14:41:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="4013612"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Feb 2024 14:41:46 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 16 Feb 2024 14:41:45 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 16 Feb 2024 14:41:45 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 16 Feb 2024 14:41:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ha3XL4ggPOgsXtc//Kn+tg5olZEd+4nzRl4PyieaMTbUjupeZj5X0OVGDNetpmegknv+4ZliBtNsOmWaKbbI3nn5qGM5hTG+WuqUx1UfjkhSBFFdCOIA6HAFwty7nRzFGRFlXx3vZS56LAqmSsbkZTnc+ei5gNoF9YjTYdbFk2EcV+3oq938dvuXgpwi3h1ckKKBz1G7eWvaOCAEVWpvHfKGyWIO7b/2nWdy3oWiSbc8WmGyNx89Nk4UOWGQC4oGat++RZejk74v03MM8JAwUjWczh74pIY1yo+EZ2abfvBacwZiPOT1jgjVAUXsKCtJ2oSQsfppF1tZYuIL1kmWIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GkQPVr5xov5tb0fAgEtjeNSytiQJ+1USHPhzaepkCoM=;
 b=IdhSmSMIUBvBi++Z88Ir8hFq/4BbiOuipvc/omG6eH8iGAP7dylw2Vu8lcRjfhp1Ml8FCSVwMgOs454A3E4OnCGDH+eYLKRG+TdwXKREScAvrZuDkSUsz0kwaC0icbH54LpBc0+BrpqVyeKFpmJRa3BLh/vIsEJzpCynuvTHiPMk4/Np5d5yx1LC98XbcoFRn32mqEfYf8mNL/kdisiC7abdITzkYSeZxh80z8oBlTPIb3OXhBo+u1ck629iRrAL3ier3P3G8Nun98zhT3Jo5zIu8w9t+TQpblkPGse159VVdgx3nBMFE68ETdp7n5/2g92WO/0prLmI3nwrWm7FFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH0PR11MB7495.namprd11.prod.outlook.com (2603:10b6:510:289::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Fri, 16 Feb
 2024 22:41:38 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::d543:1173:aba6:2b77]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::d543:1173:aba6:2b77%3]) with mapi id 15.20.7292.029; Fri, 16 Feb 2024
 22:41:38 +0000
Message-ID: <bdfea458-6fd9-4118-aa9f-9caec2237923@intel.com>
Date: Fri, 16 Feb 2024 14:41:37 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] Revert "net: bcmgenet: Ensure MDIO
 unregistration has clocks enabled"
Content-Language: en-US
To: Florian Fainelli <florian.fainelli@broadcom.com>, <netdev@vger.kernel.org>
CC: Doug Berger <opendmb@gmail.com>, Broadcom internal kernel review list
	<bcm-kernel-feedback-list@broadcom.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
	<andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
	<linux@armlinux.org.uk>, open list <linux-kernel@vger.kernel.org>, "Justin
 Chen" <justin.chen@broadcom.com>
References: <20240216184237.259954-1-florian.fainelli@broadcom.com>
 <20240216184237.259954-4-florian.fainelli@broadcom.com>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240216184237.259954-4-florian.fainelli@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0278.namprd03.prod.outlook.com
 (2603:10b6:303:b5::13) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH0PR11MB7495:EE_
X-MS-Office365-Filtering-Correlation-Id: 47ccace8-1cd3-4d36-99d0-08dc2f406fd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /R8sm7dRmCm1tiSuuf5OKj+h3pk8qsENyhPsm82Z3ArqxDO1nWhvn09mA+02dC/dQI5XsAfBSRbOUkuqvpRVnYiXZfe41kXH0jvtwfFVH0D1zlR1fiK/LoUgylNZRNpXI6htGrPJKIgZwd7xRPm2ylH9Q29NQ0IDJ2hRoNi+CLyghAAqbvs9/cDRC8ZjHBOQibuk4vW1ujWB8d5XEdLqDIChcV3UdVFUfzwbW7fpixEQn/YBASu9de7mXHToe1AleN7TxbHHUkh/30geT4mTAImHhUr7W7Agdw0YR/OyBVSjk7DG7ZDvk68kmmbimGg9Odg1TMTQVp3PyEs1Erl4jnTIj4BpShmWTr2FEYaknX4GCy/LeB3zrFRvtA+RChtnLhKf0I6JJGAtrcp0VJ3LYAQXJr4B0i5fQIXPyHpN6yHoOn/UkTNTOqMe7t5A6uA9zUUYPwGK/qPKzLZGGw8Cg94MYIbfO/SvTdH5/Db3TdyfhLejzkyA5y/wCtJJtE0jF8s1AAimK7XF0CjqxVlHLx3UPL9o3q6UTIQFpiGwymyIHX+BjuT8JZ/9RmGpfvJC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(376002)(39860400002)(136003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(54906003)(478600001)(6486002)(36756003)(38100700002)(86362001)(31696002)(83380400001)(82960400001)(6506007)(2616005)(26005)(316002)(53546011)(6512007)(7416002)(66946007)(5660300002)(66476007)(41300700001)(66556008)(31686004)(4744005)(4326008)(8936002)(8676002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGNDSXJDOFlwVGtESmlyUGZ1dVBVU00wMVBtRmlRTmhTQjJDSlhhS0VBekl0?=
 =?utf-8?B?RGp1cGs2ZXFma01ETUZHT3dSOTkwZHJJNVRFczFtcnYxbUgwREt4b213NUNN?=
 =?utf-8?B?S3VwTXMwMGZwYzVRSkwwckpVdGczWXZXRGIwNlJmNlY2c0FndGI3U2NWQTda?=
 =?utf-8?B?L0FJU0Z6RGcxMEVFQVp3QlhQMXc3R3k4bjZXajlldlExc3RMYmlqNnJuUWRs?=
 =?utf-8?B?TEZWU1owMlNNaFRWRE5jVFBEUC9XR0plNldZVjhzZVpBcnE4Q3I0VmhoV0pI?=
 =?utf-8?B?UnMrZ2pXMjlMMlBzWFdGUkFxTFNVRGtrTGdVS21MMUZJTGlTT3pHVU5RVVdY?=
 =?utf-8?B?UjFVTmVGSmJWeTlqbmRqZjB1ZTFqWkFmSE85ZVRjTHdDdDRjcnR2dk9PUmtK?=
 =?utf-8?B?Zk5XSjY4ZmlaQ3Vsb051VkNNRkd4ekxrVlJ2QTZaZ2ZkNEU1ZEJUdExEMWw0?=
 =?utf-8?B?SUxlT2xsZjdKYnZaVTBxb2x4enpzNzlWVVQ5WE4vcDFTclE2cWViblhOYko3?=
 =?utf-8?B?YWx4TEtRNjkzSUhVU0srZkd6RjhkTDc3SXpHZ05VV2JMeXp5THdOOTZnSHAw?=
 =?utf-8?B?MlF4Sk5HZmNmK3VDMkcyV25ETUxFSGNzSkpOUU9iVkFpYnZtY2JvMFU0L1Ew?=
 =?utf-8?B?cEpDMHVubjgvSTF3Qk1CeGxXS0lZNzROd2V0WDkxdC9Ic1hWRXBsL3ZUNXVW?=
 =?utf-8?B?ZGdEbXFtenFKUzlMS1VrZDV5NHkybGVLWTgxblFhcGw3NlVQNkJjSHhmdUlR?=
 =?utf-8?B?N0FZdzI4WU16eXg3bmg5elI2THdsR25INUVrNEtPNHloWC9oTi9MeGwzUDc3?=
 =?utf-8?B?T1RKc3RWRGpjV2FoMGVEeU1VdllNTE0wTm15ZDdTOC9iZVVRWmM1R1UwMXVF?=
 =?utf-8?B?RktDKzBranR1b2pYVkpHNW5xNTFhNCtlTnNEOTYxTzZyYTdsZGVjQUVkcGhQ?=
 =?utf-8?B?azZzMmtBdzR5cE1lMWJMcTdPWU01a1VZSzNCUFkzUUVybzg5OXp3TDR6dHVm?=
 =?utf-8?B?ZEoybjIxL3dFcE1vWHJuc29nKytBUk1mT0w4SksrSm1mMnZJWVJvd0lnT2Jh?=
 =?utf-8?B?WTU3VFNwMjQraG5MSVJBSHhzM0hkVnNzVGZWQTRyRHRZWHFuTXlpdGYxbDJK?=
 =?utf-8?B?a2pCQ2prckJIMXVqQ0JPRXo4M2l0MDFPZ2prWFdPSndsUmtxSXZ3UHU4MTFz?=
 =?utf-8?B?Q244QXd1eWdOTE5ENnBySHBabFJjOWFDOWxRMGtRQ2RTYnI0cEZMczZNTGkr?=
 =?utf-8?B?U0Q0L0FKMVJHb21aWnhMT2I0L1JkNlhnQ2lCVWJmazI2eDNabHVyN3JsMkkx?=
 =?utf-8?B?SmsvUUpYTytXNW5EbnpiVy9iM1pFSldrWXJVdDlUWGxKOHc0QlRsQWpDUkZW?=
 =?utf-8?B?SnNPbVl2OC95Sm5BVlh6NmJkT2JLbGlSYXM1ZnVZUXhmOFZqU1NpdFp2WE9G?=
 =?utf-8?B?c09zbUUwZU1IZGlFWjFSdi9oN3RURHJGV0lUemJoYmlBditkUXJISXFuRkNM?=
 =?utf-8?B?WkJ4dGxCcjBibExoaC85c0daR0hBTTV3TllxdWRibm1nSnlldURGcGhxS1hs?=
 =?utf-8?B?VkRvNXZPRjczNWhSMkI5K3ZKTUZiTTN2Wkt5TzR5UWpvRWNFbDdPRjJTMzJP?=
 =?utf-8?B?ZGJtUE5hVmFUY3VNd1hjTWkrMmRvZ2VoMXpoZGR1a09iL3Q5Qlc2ZlNPcFZl?=
 =?utf-8?B?ejNjQXoxRmk4dmpRZkJ1SEJuZmlqWFQ4Y3VqTWoxeFF4ZmR6RStRdDZhVWxv?=
 =?utf-8?B?VWFOSURCTG53R3pCc1BxaXU1cWg2UkNwS0ZmZVVsdnVGZFQ0NEdLeTdtRWZU?=
 =?utf-8?B?QmROUHBULzFrZGdKR28zTzhaZkxuMisxY21Ed3RTZkhNU0lXUWt6VDdyN2Rp?=
 =?utf-8?B?dzNabmpDanRBQ2xSaFlTTkNxb1Jld3dKUlNTU3VqTWFTdGRLZFphaytodmJG?=
 =?utf-8?B?TmU3WXRBTys4OG9XRHJETEFvUFhlNVFiYmJJeWh5bzdFcDFUV3p0c1FQeWZr?=
 =?utf-8?B?MzVYeHR3THR0S3U4MFhvSUY0TW80RWpEbGhxdjd3elpxc1o2QzluWlhBZ2pj?=
 =?utf-8?B?ZmJoRXdWRWJSdU4rRmhFSldicnYyUGFma3NUeDlJais5MjFCdFFKaE8rcEhh?=
 =?utf-8?B?VnBMRlp0bkkwUkY2OUxIT09WbnZma25lNmFlbVcrZ3VtK0tBSm9zUkE1eW9T?=
 =?utf-8?B?a2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 47ccace8-1cd3-4d36-99d0-08dc2f406fd8
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 22:41:38.1331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hdetjvAT73rdwKeRg+j3J8XwWIFzP2d8pPciqcKeR4DnQ++5SIXmEtrtDP5wToYLTSnEDsaCmVfUmhhjZRwf2aOZIlIZYdI/e7jawDIyvuE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7495
X-OriginatorOrg: intel.com



On 2/16/2024 10:42 AM, Florian Fainelli wrote:
> This reverts commit eac0aac07f6af47b8ba57c8064bf04ed6df73d1d ("net:
> bcmgenet: Ensure MDIO unregistration has clocks enabled"). This is no
> longer necessary now that the MDIO bus controller has a clock that it
> can manage around the I/O accesses.
> 
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

