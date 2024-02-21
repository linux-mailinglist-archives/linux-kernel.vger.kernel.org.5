Return-Path: <linux-kernel+bounces-75349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA1F85E709
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 20:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C62E1C24922
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0714385C44;
	Wed, 21 Feb 2024 19:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zof+2Q4B"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE45B79DD6;
	Wed, 21 Feb 2024 19:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708542864; cv=fail; b=g95lHo38wX7fVEdgyldhOLeescmuVQ046Lh72tTKGjAGHsWc+Q6g9BUTbe2Ux2xmdI6s5zVyCf+DfhLTYud+2lxpjZJ8N922+zfyOAl1GlGxJvqo7gOLpCI+YzH4CvSCzTIMEZaaXwQUNCGTurSQfJ5eo9jXqTLLvxKBZYnOP/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708542864; c=relaxed/simple;
	bh=gV25uEMkzckEJf1p7fuBOHDB5eEY0GLP1btKxd1Hy7c=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kW2F1bM1pp51mD0cpI/C3FQK0Yi7kkhSOlst1jdii3Afm82c2TMXQBPQaFHPFFfUOsohE7Wi079v119GGxA63Z+Ssiuj76kufk1eHGjdLBgcG5JNtHYkImplBEkdDdD4ox8sEUcBzFgSpOkTRW1vPYbab3WKhtabwOqBl5i0uOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zof+2Q4B; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708542862; x=1740078862;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gV25uEMkzckEJf1p7fuBOHDB5eEY0GLP1btKxd1Hy7c=;
  b=Zof+2Q4Bu5B2kan1Fuyu7PT2gp5YF9o07F3bhmbJFGxz5FtPPFysCAhO
   /XW7tvMtjS6wpfPTnmsrKLxATp0upG+DIXdFcFOS0rfRwTL9hvAp7tRcF
   uyn0GPgCVmMEiAkY2BfFlAqzPObKsu5TlgRSG//A7HpaMywBuFIAWbyp9
   tLZ3Zllz1IZUm3greQq+Ga3qdm4SvVVYYptjku94v/IeEEYKtIm5Tu6Ua
   wV3s5Tfun+RlFMQ5hjMbk3OFYnd4o6v5IPt4Tu1zd9XrlduYE/JLjuvyI
   tm4YPeeU0OI/k4kGqcj5XV+CWNIaKi3+80wufWEZ52K4QIpLTQ3uYiysF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="3211069"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="3211069"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 11:12:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="5529127"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Feb 2024 11:12:55 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Feb 2024 11:12:54 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 21 Feb 2024 11:12:54 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 21 Feb 2024 11:12:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n/RQz5Rvnfnj2laul8Rk8uHU4tdkXbBjyqBYi593S1IZgAgXM/EIImUj1o9VZNt4G9XOip3KoeW2NvgE4qyNQmEMBqh33L4nrfJMKAZjh8zYOyqhnXTCU7R7hEcIXYBngeWW9zWcmF7DvUSrRExxRGebAIz5H3FNgFNOySqbTYteMK694T6bZSqNZDFasvU1dS4UGLYt8WuxSSSqew74zM9pADEcEbPVyqMUYFjR8CSHLEpzhWWc1Kp62e04N6HNdKbBGd/d/JGbbxRZQINT/IPhYh6UTABbbFGYPmiDviYd53cR3hb6R9iY4oNEfhC9s+ILNMHxXepPYktnxh5+1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/+SVa2V/I7YoRisT4L7YaZePHIiYd9zLeEVyzy7sbuE=;
 b=KENFAZ7ccyMX3AwO1/A2E+kwr5CtdyQ/KBS/+GxojnedDrzaOuU3eVxdzBFxXzLe5taz+27SiHJfUuLWBlK+rYz/XzM9Jne3n8hmjQUfC+fUxSNU/AD75aA+CQKwYMnS9R6ADox3xcVJ3+qPgPalrhlIIdTQZbcunv/YW8i8QltkqHMXKlp5tJocqtdHy53TCdG92eD/Gw5AFrFHsjdhm0ySYEe2iV74bYZ07DI3OvxbwVoB1xehgUI5hdoDKIWcgltkUD4pYP2f0yDzUfFA8zKLQ5CFqj9QRE4ztMRT4zdP4Iqa8Nd3kWR1ROSxlPVDcxABbyG/AZfR39HS9u1NIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7)
 by CH0PR11MB5394.namprd11.prod.outlook.com (2603:10b6:610:b9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.22; Wed, 21 Feb
 2024 19:12:51 +0000
Received: from IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::e851:5f31:5f0e:41c]) by IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::e851:5f31:5f0e:41c%4]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 19:12:51 +0000
Message-ID: <8d34d621-421b-40bd-98ab-c93783408d74@intel.com>
Date: Wed, 21 Feb 2024 11:12:47 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] netdev-genl: Add ifname for queue and NAPI
 APIs
To: Joe Damato <jdamato@fastly.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Jesper Dangaard Brouer <hawk@kernel.org>, "Stanislav
 Fomichev" <sdf@google.com>, Larysa Zaremba <larysa.zaremba@intel.com>,
	"Lorenzo Bianconi" <lorenzo@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	"Sridhar Samudrala" <sridhar.samudrala@intel.com>, Alexei Starovoitov
	<ast@kernel.org>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>
References: <1708531057-67392-1-git-send-email-jdamato@fastly.com>
 <1708531057-67392-2-git-send-email-jdamato@fastly.com>
Content-Language: en-US
From: "Nambiar, Amritha" <amritha.nambiar@intel.com>
In-Reply-To: <1708531057-67392-2-git-send-email-jdamato@fastly.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR06CA0015.namprd06.prod.outlook.com
 (2603:10b6:303:2a::20) To IA1PR11MB7869.namprd11.prod.outlook.com
 (2603:10b6:208:3f6::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7869:EE_|CH0PR11MB5394:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b18379b-342a-4db1-5d5f-08dc33111955
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YNcGayW1Gn2JdafnOcULNk+kNFgK5si+6WWr30TyZ8kAJ0Bosax/PvnkreElSpgWYtLR8UydAnSDaH535r5elFj91hsh3ljcDyZpvIP5BIh1LCz9bxRRgNd3PDc1QrFIgr43EJNGABe8jncX63l3gUQNCk4nIfRjFtZJ0mv0SoqpPbmLp+fJsvFxphZb6bgghys+bLbIaAgbKWPIcHBHRf6OXjRO2ADZ8G+grQFNupY6sQc20dTifs5srrE+oxchRalE/C2R17n3vjVqk2EgnudQkq8wU0uj+WlxoRXAj++4vUNg88J3/AIfzxgyXm/3irW3n4cQJcyoAVpGxUl/GPBJbvVA7ZPyCjS+lOmUUuCbNjR9IzxLvUr6LxbqFrxAzC8FBysFI5P3iktdAWT3bbPPaCiWmVG/lDDpw/YjxmnoLgejOJbDyaXFCqkiyzXnq7GkqZbGefVpFzvQcFOVDgmmHejM6QVpDcqL2MB9nJk4MSVCzenri7JYRghHsGSn2WAkyTDe1fBwkcXQnbdQu3fEKT9yUnDShRj+Ht3VnJU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cm5jV1JxeXo4WE8yK0V4NUNSaDYvdjZCSExiV08rNnl1eXBxbjNzUXRVUVIr?=
 =?utf-8?B?SDI1OG1tRktncERMNWd5SC9hSzNqdHhSbXZHSFg3eHIxdVhheGNaZk45aXVk?=
 =?utf-8?B?TTBSdVk0bFQraHEvdlhyejZLMXZqcnhIOTk4Q3NpbjNvOW9ZcnE1NDdqb2lE?=
 =?utf-8?B?a1pkak0xcVRSTFFIM2RZaFhPRS9ld0l6eSt6SXZkdWtxVDJGZ1lBd3h5Vm9j?=
 =?utf-8?B?b0JvT1FIcFROSU5MLys1RkNBeERrVTBkaisxa1lCNXdRZi9vb0dYeXdiYWJO?=
 =?utf-8?B?RFYvMHY4cUgzK0Y3Tmc2SEJkNFBPMVZBUzlFM01nWUZtLzVSdHUvOWl1d1ZV?=
 =?utf-8?B?cmdsK0p3Qk1pM0pzRjN6ZVBIb0lmcmdzbEV2WkJ0MlB1aWNrNVhDL3dMSHE5?=
 =?utf-8?B?NzFnUWsxcUhKa09SMDFTNWx5WUZkN3lGQnAyeU1PQXhobjBOV1JoTnQ5R081?=
 =?utf-8?B?NmRRa1cyTkp3MW05RUhBd29xVE82SVNKMkc1MjBtUnk1ajZmNjYrUGlTUzA4?=
 =?utf-8?B?RDNLOGNzSytNalJnUFFITWRBMUVnUEd2UVVYbjhHL2QyNzdEbHZwTHg3Vlpt?=
 =?utf-8?B?TGswNmlwZzdJbGd3ZnlpeWxmZHY2UzArY1NMdzZ6eDN6dGZOWHJld3dNTGl5?=
 =?utf-8?B?QmVqVVFyeDZzVFYvYUNVVUd3RGpUS285cFhFVDVmUUxXRVdZTUJsYUF5cmFr?=
 =?utf-8?B?ekpJcm95ZXpoUTNhL2ZhQUY0bG1nT1BXV0hTY0hQUjNVNjF3Y3Y5dm1TZ2U0?=
 =?utf-8?B?NkhIQjhxa2JKNElKWDNvNWJSUDJNRDNOUkRNYnpZdDlmYmZnaG9TZkFBV2RJ?=
 =?utf-8?B?cDdHZDA4blp2QU5uOUNHL0NZR0dQcFlsUXNjOWhSbGM5M0NMUWJLSDN1Y2Vx?=
 =?utf-8?B?bXFoY0prR0IxeHcxWDVRbFBENUF6ZmZKSXE4dmhRLzhVOWNNMGZ0WUU2ckhp?=
 =?utf-8?B?WWs1bzg0VXc4L3N0a3lZejNzUi9KYW54RUMzTkVGYXFUWEF4NW83TW9OYVF4?=
 =?utf-8?B?dlh0MVZvanFrd2VXV3lSR0lRZEJEenR4L2x5Ymk1MGN1SG1IUkI4aklhdWhp?=
 =?utf-8?B?elZFSWFBWnYvSFFBZk9JMlBEVWlnRWdyOHVuZ291aFNzMDRwbU9sT3NDbmlp?=
 =?utf-8?B?S2JSVDI1cGdQdmdTSlVwT1RaOGpRWWxudk5rd2NLQ21JSVZUdFMrckFjOGRO?=
 =?utf-8?B?d1VBcUVBQVBzTGxUUkUxQnB5c3ZXb25hU1ZNOEd6ZGhpVFo2bERkQXFjTmFG?=
 =?utf-8?B?S0xkK2x6eG4wTFVna0ZvVUVEazAxSGJFU0IwUlRybXRrdkIwUUtmcGtLZkd4?=
 =?utf-8?B?TXArelpuTllObEpzL2dpU01McXFTb0ZSWEhLd084L3Q5TkZ3cFAwaXR5dUhN?=
 =?utf-8?B?TTI5RTZ1UWRVeUZtN3kveExzUlFFS1N3dmRXYVNHZXhKaXFEYy9CcTZ3QmdM?=
 =?utf-8?B?dnl3OW14cGc2TWZudmJOQ2pQK09SNzg3YnN6ZVpKZHlxSFowRHM0KzNzMXZo?=
 =?utf-8?B?dHRNS0lpUEVMOHluYmxHNEVjVG1PR0V1MUhsRElGNjlMWHhpNUNRSDB1YzR1?=
 =?utf-8?B?U3lqRFpSRjZWb1R2UnZhUlN5QXhTQlRWMHRjMXAzMlhCZG1QSWlUY0YxMnN5?=
 =?utf-8?B?TExyOWhUSENQV0JlbHppUXhWbmVickZhbkNQeDBzbEsrOWRFOUMrMGhucG1x?=
 =?utf-8?B?SlBmcnp2bkZhczI0eUQ3bW9BUFFML29XSkhIc3B5b1RkSXhKcVNJOGxpQ25P?=
 =?utf-8?B?SDdLdlZNZWwzZ2xiYXkvbC92OTlvZzA3czJINWdxcjI0TXhPSFBBSlZjTXZr?=
 =?utf-8?B?MzdYMWxRekVXcXBYdUNVUzlubERNcGdlODRZV29aTTc0VkFFcVh4NzFMbWFP?=
 =?utf-8?B?K3Q5UnBHeUFvMU0vMVhxdzAyZTl5cnU0Tmw3VFJKTWhJbk9QRTN3S1JpM295?=
 =?utf-8?B?V09EOWwrbHdiUEtvUXNwYWVuT2hpcHhjWTVHTXVOUzF1bForR2xxK3AvZUFX?=
 =?utf-8?B?eW9ucXNrUXFpY0pBUndGMWVvWHRHalhSVG9lVTMrYjVDUGZsUW5tUmxleURG?=
 =?utf-8?B?bEJIaHFzaEp3MnN1a0xMRG54RWo0bUcyQmZJTGJLU2R2QWFhVDU4aXI4VUho?=
 =?utf-8?B?V1FSRWhWWGxnQTFNRTJtVHhCN2dZM0xwRkFjRGs3M1p6d0FaMmZrWUh0d0lt?=
 =?utf-8?B?Y3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b18379b-342a-4db1-5d5f-08dc33111955
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 19:12:51.4725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Aw0g+s09lS3kAFgl/dUh3AhZxQPy7Qh7gfMrRSULYKBs3kgNqETdwCnbAuPDWSJqqpvLNxULsQzjYkzPZzymTStZXR6llYW6GpbMHb8rJA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5394
X-OriginatorOrg: intel.com

On 2/21/2024 7:57 AM, Joe Damato wrote:
> Expose the netdevice name when queue and NAPI netdev-genl APIs are used
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---
>   include/uapi/linux/netdev.h |  2 ++
>   net/core/netdev-genl.c      | 22 +++++++++++++++++-----
>   2 files changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
> index 93cb411..80762bc 100644
> --- a/include/uapi/linux/netdev.h
> +++ b/include/uapi/linux/netdev.h
> @@ -117,6 +117,7 @@ enum {
>   	NETDEV_A_NAPI_ID,
>   	NETDEV_A_NAPI_IRQ,
>   	NETDEV_A_NAPI_PID,
> +	NETDEV_A_NAPI_IFNAME,
>   
>   	__NETDEV_A_NAPI_MAX,
>   	NETDEV_A_NAPI_MAX = (__NETDEV_A_NAPI_MAX - 1)
> @@ -127,6 +128,7 @@ enum {
>   	NETDEV_A_QUEUE_IFINDEX,
>   	NETDEV_A_QUEUE_TYPE,
>   	NETDEV_A_QUEUE_NAPI_ID,
> +	NETDEV_A_QUEUE_IFNAME,
>   
>   	__NETDEV_A_QUEUE_MAX,
>   	NETDEV_A_QUEUE_MAX = (__NETDEV_A_QUEUE_MAX - 1)
> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index fd98936..a886e6a 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c
> @@ -181,6 +181,9 @@ netdev_nl_napi_fill_one(struct sk_buff *rsp, struct napi_struct *napi,
>   	if (nla_put_u32(rsp, NETDEV_A_NAPI_IFINDEX, napi->dev->ifindex))
>   		goto nla_put_failure;
>   
> +	if (nla_put_string(rsp, NETDEV_A_NAPI_IFNAME, napi->dev->name))
> +		goto nla_put_failure;
> +
>   	if (napi->irq >= 0 && nla_put_u32(rsp, NETDEV_A_NAPI_IRQ, napi->irq))
>   		goto nla_put_failure;
>   
> @@ -307,7 +310,8 @@ netdev_nl_queue_fill_one(struct sk_buff *rsp, struct net_device *netdev,
>   
>   	if (nla_put_u32(rsp, NETDEV_A_QUEUE_ID, q_idx) ||
>   	    nla_put_u32(rsp, NETDEV_A_QUEUE_TYPE, q_type) ||
> -	    nla_put_u32(rsp, NETDEV_A_QUEUE_IFINDEX, netdev->ifindex))
> +	    nla_put_u32(rsp, NETDEV_A_QUEUE_IFINDEX, netdev->ifindex) ||
> +	    nla_put_string(rsp, NETDEV_A_QUEUE_IFNAME, netdev->name))
>   		goto nla_put_failure;
>   
>   	switch (q_type) {
> @@ -369,16 +373,19 @@ int netdev_nl_queue_get_doit(struct sk_buff *skb, struct genl_info *info)
>   	u32 q_id, q_type, ifindex;
>   	struct net_device *netdev;
>   	struct sk_buff *rsp;
> +	char *ifname;
>   	int err;
>   
>   	if (GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_ID) ||
>   	    GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_TYPE) ||
> -	    GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_IFINDEX))
> +	    GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_IFINDEX) ||
> +	    GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_IFNAME))
>   		return -EINVAL;
>   
>   	q_id = nla_get_u32(info->attrs[NETDEV_A_QUEUE_ID]);
>   	q_type = nla_get_u32(info->attrs[NETDEV_A_QUEUE_TYPE]);
>   	ifindex = nla_get_u32(info->attrs[NETDEV_A_QUEUE_IFINDEX]);
> +	nla_strscpy(ifname, info->attrs[NETDEV_A_QUEUE_IFNAME], IFNAMSIZ);
>   
>   	rsp = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
>   	if (!rsp)
> @@ -387,10 +394,15 @@ int netdev_nl_queue_get_doit(struct sk_buff *skb, struct genl_info *info)
>   	rtnl_lock();
>   
>   	netdev = __dev_get_by_index(genl_info_net(info), ifindex);
> -	if (netdev)
> -		err = netdev_nl_queue_fill(rsp, netdev, q_id, q_type, info);
> -	else
> +
> +	if (strcmp(netdev->name, ifname)) {
>   		err = -ENODEV;
> +	} else {
> +		if (netdev)
> +			err = netdev_nl_queue_fill(rsp, netdev, q_id, q_type, info);
> +		else
> +			err = -ENODEV;
> +	}
>   

This looks bit incorrect to me that the netdev is checked after 
netdev->name is accessed. Shouldn't this be something like:

if (netdev && !strcmp(netdev->name, ifname))
	err = netdev_nl_queue_fill(rsp, netdev, q_id, q_type, info);
else
	err = -ENODEV;

>   	rtnl_unlock();
>   

