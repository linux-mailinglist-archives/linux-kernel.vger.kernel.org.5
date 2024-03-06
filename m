Return-Path: <linux-kernel+bounces-93508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C7F8730D2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 851641F29231
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97545D750;
	Wed,  6 Mar 2024 08:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bk/z0L3L"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65183241E1;
	Wed,  6 Mar 2024 08:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709714073; cv=fail; b=fRK53idpCWHELHsrTgli72SjIZz1/uWM5tTqSV0rHc8wGmCxayATFiYl8zH6wtbctrAKkgBnxqoonWw6AKkk8qhgHCm7q3r8vesZxFfR5SJRVf1n5t2OesknbUr78Bu+L8BqJeVVGKkFYMUX/iTvP0YjfTtofo31b14AGHWDL+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709714073; c=relaxed/simple;
	bh=tZmTF6m8eWqP7Cqb9D0YaV5AKy60sqx82P7bMCJ+VWQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u+rk0ryegWA43oT53Iat92lf9x+bTvyqElPxUjmKRy2/EmBdQDI80Lcso1ZXuPJH0sYWfmNn34BLoh+7BQ93DHZjjcoVryM/RXmCDYZ7ASKqPkC2wDu/DhgnOMo1vpUqEcJ0/GHF4szeCE3rRr7QAx1tkhrrWOfAOJ6tkeMgGSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bk/z0L3L; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709714072; x=1741250072;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tZmTF6m8eWqP7Cqb9D0YaV5AKy60sqx82P7bMCJ+VWQ=;
  b=Bk/z0L3LiTElgsFL3UnQf06x/Xjh9IYBL0IobnEiNcx0i0gzDluGyPMH
   sYmbK2n8lbKQ4yVlMyG4aG6/3H9fg9/gzuB9Zc/AbOHPjfFNOJbZm0iwM
   h3WBcO2ubxN0MBr7Up5Lb0S53U0Bl/gqoLWfg8MQqGxueC2MmjpNnN1To
   uQ60GSUcrCz73I9jFO1hGDLVusecrenUiZR8G92xfobJqLbwx3wMeLSa6
   lWgHouX0T0/Nj6dk8RnG4ZmRAsFVEdDGTrw3fejy0s2OXfPuetYa4Tsa9
   s+gRc69Y7Wm1ES/IFcruMJrL8DHEPbe48BOG6hOgbx1Nm/OFyrAWBpo7L
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="4467068"
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; 
   d="scan'208";a="4467068"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 00:34:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; 
   d="scan'208";a="9574076"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Mar 2024 00:34:28 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Mar 2024 00:34:27 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Mar 2024 00:34:26 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 6 Mar 2024 00:34:26 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 6 Mar 2024 00:34:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m71UNPlpYUqtKlSDsgTqS1UiIyJJIihpwAGg7Yx6X99P1V9w0Es03F995/qLk+iVKSiAYQlw/7RaO4vkJlHvmCImw8RuxJBD0gDesuGdcHUokymlP/WFInSKWWCW8yV2Qtp7pdvp/6Fz37X9MNxo7jXyPJ4wMo1bb7Qz+s1qv6sWHKErl6M3jcIquq9wlDZutgBghoV4Stz5yaq7lkeJrG30ZqBB9Y/sCxbRa4suFMGVq9eBDvRd54fKdNe1sgKYTJCKJ0luV6HV5RYnXlG2nKiLNxkp/u+6LYIMZR87sssVz6dbipTpM9lxwiOQLY8zCwyZgrPy9Qurx65uAMMMag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I2Omz6wwpla8w0fBQU3jmQvrs5GmhpEppnMVixLz5Io=;
 b=ckbC+dz8D2ylMp3ppX9cCDdoGWSnpgPlo+7z/363ue1uP1mKoeTaXhWkbZNFjg0vFgTPvfMNkk/vOHbwT31Ka6KoE9KDBge1kqW2sd0KeBLQ0AI7K045xAPS0d12MY9mOriWGfYtg7W1ix4ozsQWiwHopwhdB0HopYQ0JvMepjEcdXKdmY5FQNDBHbuDYBZc4rpEWFPzIk3roesDkIx7qWbl1MzEqATiOEA9fCRgCMl5ujTDIxtK0TxCpyygluJ9BXAElAQw3lCjcz/4fXePZE4qSwQWzQMEhCN4dsfzpPbmHDU6HjGYmtpzRouqnT/O+/iFq029PvqyLrG7vLimwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by SA1PR11MB6896.namprd11.prod.outlook.com (2603:10b6:806:2bd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Wed, 6 Mar
 2024 08:34:24 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::8079:6172:11ca:5fe9]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::8079:6172:11ca:5fe9%3]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 08:34:23 +0000
Message-ID: <d490068e-ad6e-44a5-902a-b2166448b6bf@intel.com>
Date: Wed, 6 Mar 2024 09:34:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH v5] ice: Add get/set hw address for VFs
 using devlink commands
To: Karthik Sundaravel <ksundara@redhat.com>, <jesse.brandeburg@intel.com>,
	<anthony.l.nguyen@intel.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <pmenzel@molgen.mpg.de>, <aharivel@redhat.com>, <jiri@resnulli.us>,
	<cfontain@redhat.com>, <vchundur@redhat.com>,
	<michal.swiatkowski@linux.intel.com>, <rjarry@redhat.com>
References: <20240305152641.53489-1-ksundara@redhat.com>
Content-Language: en-US
From: Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20240305152641.53489-1-ksundara@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0028.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::23) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|SA1PR11MB6896:EE_
X-MS-Office365-Filtering-Correlation-Id: 2680232f-4e4c-413c-2a64-08dc3db839f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3MkikKn6LbE1bRT8AeBYmkKdy5kUwH1O1LRcmhBw72un36gI/P9RM8frCg789omNGI89bZwJxNbI6232XqRaHfJBpOaoDmYeU0CXuakAcx+R8zlTdVLMlp8Fyz5pEgLSmESUZ7gD+3SCtpWcF8BbeeeNq5pkXvAtnpwM3Rwg/gZkHje32NLb/k/nlJKJidyMF/WcnxNknlQE5reQwSc/VEZV/P/T8UEtl+Xms8YIHTdhzFLbJh/WX0549rgc9t4GrWo7Fr0C6z3s3vvjd7kfYaIPRCeISJnAa42M47/Wb5sX3GZL4AW4i8S6iuqY8ZS9dpdJrj1N6VgvD6j+hd9yKmVw+qPrzptmaNvsZ6UPcleMtkvQ/WoUmD3ECFzXwwmBU6qDKWQ7k70lcAACvlVs8/bGRpPzbvS/QOMYPgTCj0SNAVNGFKvUgo8sBDRD/whCB8RUhgY858e6B4IbsDOBnNSBXFFhieqYIJCVV+0asarzZ7sk2nUNkjyze/O/fEwNG3ioAr3bOOkURbX0iRJauwJGsOoihNyu4CCl+eoGXJIB74Byu2rILN+JJgQc2BVTvpfQMh1bdX3110gwwpIL1WZ+Y2V/b08Zr6kT/KXLBv3+vBqj3TVJb2MBU9An9Q/OruRBrayY/yMpN6WgXSbGzy0Cko0EE08Be4S8p+6/Ysqb8+uQqI1zjV93/CC018YOwwCtO6qJLGiZpmSXqnOf6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDl3Y2tXZUs3S2Z0bHYzQmNDc1lGUGV6WTVib1ZvRk9LNmg3R01mTEk2RWlQ?=
 =?utf-8?B?blFaQkhQUWpFTU9oazZtQy9KSGhqRStCdEhVdmtwMTdzenFXaTlCWTRSTm9S?=
 =?utf-8?B?SmR0Qk5DU3JWdW11YkVzeW9xT3MxaHdFVDZZZXlVMklHUndMVE1pTXIyelhK?=
 =?utf-8?B?MVFNYjk5Y2I4Q0tXdS93MjR4a054SEJTSTdabGZNSU1NNjUxdGxJcDZJOFNH?=
 =?utf-8?B?d1ZoKzJhN2lYTjhxaTVrQTh4SS9mS242NVNaYzZONzNONXYyUWF1U1BlUUZx?=
 =?utf-8?B?TEZ6VStaS21VaTdad3I4SHFwbVlDZlNwbTlmM3B0TmtIVE03ZjVwQUxiSk9B?=
 =?utf-8?B?SDJmN0h2YVNFeXJLejdSeGZ2UERJNlppcm1zMjlFNHlpdEwvNmlYbTdLUndE?=
 =?utf-8?B?UlJublEvckFnVUo3RzVXb0xHbkNGYUk1R0R3SmtLY1hGVWxwMDQ2a0VxZ1M5?=
 =?utf-8?B?M1c2UldrcDNLN05QVjltS28vRkVEYW5vT3d4OXdNbWF4a2hXN2d2Wm9kUk5l?=
 =?utf-8?B?RGVkZklwbldxdUkwcndtU01tbUhiV09zSDRVemlZbVliRHBya01WQ3dTajNq?=
 =?utf-8?B?dm9iaWsyZzZlaTVrQUE0OURqWm0wV3I0bEM0dzFVYmp6UjQxNHQ0Rmk3aVNQ?=
 =?utf-8?B?TkUwQ0dEYjZiVDZNRjNrS0ZGeGlFSFlpLzkvS0VkTjZucnZZVGpQTktud1FO?=
 =?utf-8?B?YlZlSXlwUVhEbS9qQnpBa3dNUThOUlp1cHQ1YkRGeXVzRGlHL2VISjZtZVBa?=
 =?utf-8?B?dUtrVHZYQk4wWWFnaXRxZFhiU2FXZlhhcnZhekU3bjljbGpKRjlLU0c3S2FO?=
 =?utf-8?B?SE5VSlJWM1o5Z0xmOG9kUkdlVnlvMSt6YjRyUmZwUEhHc1JJb2l0YytoVTB4?=
 =?utf-8?B?WmR0WG9hWXBqMEdnL3RnQmhWdkkrK3h4K1lLVW5DamRvN2JKMG5BbkRtRmZl?=
 =?utf-8?B?a3c2Q01YME11V0lZR2xlaWNXTlRzQk1tOWx5dnJQeFM2MkQxVHU2a0I5dGRN?=
 =?utf-8?B?RTZGK2Rtb0FESGNkVUlxSzhqYUZHbWYyZHFJYmRCNVhnOU1BMXFnbXVVY0M4?=
 =?utf-8?B?MUhTNDJRWFBUTTJTYTcyT1k2bGlaUTQrR3FQRGhSOFJnNlZRUVlRaVNpRlhC?=
 =?utf-8?B?NFR0RlgyU3gvZVYzZVF1ZGJMVHFNRUJvdWZ0VkplZFVMZDFsd0pDb1RaTEw5?=
 =?utf-8?B?cG1qcmJrSjRtVGthTE0yR0xGMHlJVU1wakRCYndCMlVtYisxSTdkQkhaMi90?=
 =?utf-8?B?eTFrQ0xrMXVmd0lHeUpURUVQdzkwNDhUWTJscHUwUVVQQ1lFbnBlYnNXbUg2?=
 =?utf-8?B?Z0NvNEVsa2tiUjRaMFV0VUxzRnFPZUxOY2M0WFMzTWVDaW1XN2RYVXp6eU9S?=
 =?utf-8?B?Q2piWVFOc1krOFJFUTdrNHRKR2FnUTVHaG1JVEM2YWpNRmJyZThuQkY3SkdQ?=
 =?utf-8?B?L1QwZit0NWVObjBkR0NUMndOSkhuWktOQnpUVm1KNTRmZHFEMFlIM2tuSkg4?=
 =?utf-8?B?dTFGVGhWQ05QRUN4UitUZEN3ZFJUTWtiTUY0SFJXS2JYZUNRZDRMRFQwWVRM?=
 =?utf-8?B?K01mSHFWVWJwZFRIdDF3QkFMaDJ5S3NIaTREMi9lYURYaGZhWUxhQmpOYkF4?=
 =?utf-8?B?VXFHZVVKb1QwbllmMVJqTW0yV0IyajBnSWpDaFRlMk9PUlVxNHJRNUZtMDJQ?=
 =?utf-8?B?WWhLK1hxMXVsS1ZYQVFSVldHQm5WYldtYWdrbkNxMjhBUTNxbUhwbmNkY3pI?=
 =?utf-8?B?YVdTcnJIYmNFMStLTkdHZ25UWVlXazJkWmY0QUhHWmFUdjFuMExtYzN3dkdo?=
 =?utf-8?B?M01BbVd6TDArdXowSDRCcHlZODRRMmJTL3QyTVJjZFhYOHM0Syt0YWcwTW96?=
 =?utf-8?B?YjhWbXM3Mk5mVlFHZDduQmpiVS9jVEN2OURCZ3QxV3pDTkpoTTR1ckZET3Uz?=
 =?utf-8?B?dTIvUDdScENxTnBWcWdoK0dVRSt3ZW5ZcTJ0eUhBSUtZWW9kQlhoVGJTM0Yv?=
 =?utf-8?B?Ym1iRk9XYjNmdVdsejZLUXFxOHRLSThyWGtoWmNJUC94SVY1TkpIZTM5NStJ?=
 =?utf-8?B?Qks3YktMbzVEc21mS2Z4ZXJEaHRiZnMxd2JzWjRTODFYMmMrVjVjU1U4bFcr?=
 =?utf-8?B?WXdXNnRuVzg3RFcxZGdoNmo0bWM4U29LVjA2RmdlamRLN1hnbTAybTF5ZFFX?=
 =?utf-8?B?Qmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2680232f-4e4c-413c-2a64-08dc3db839f2
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 08:34:23.7638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a3algK36EhDOq1KcwLI3uIh2bBmg5PBHnt7ZoWqkHWL01fsRywwNoBhw6bVHafbsGZV333r81btVxGTFRWRBq/iBJowky0I4lMlgI+BzHcM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6896
X-OriginatorOrg: intel.com



On 05.03.2024 16:26, Karthik Sundaravel wrote:
> Changing the MAC address of the VFs are not available
> via devlink. Add the function handlers to set and get
> the HW address for the VFs.
> 
> Signed-off-by: Karthik Sundaravel <ksundara@redhat.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_devlink.c | 78 +++++++++++++++++++-
>  drivers/net/ethernet/intel/ice/ice_sriov.c   | 62 ++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_sriov.h   |  8 ++
>  3 files changed, 147 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_devlink.c b/drivers/net/ethernet/intel/ice/ice_devlink.c
> index 80dc5445b50d..39d4d79ac731 100644
> --- a/drivers/net/ethernet/intel/ice/ice_devlink.c
> +++ b/drivers/net/ethernet/intel/ice/ice_devlink.c
> @@ -1576,6 +1576,81 @@ void ice_devlink_destroy_pf_port(struct ice_pf *pf)
>  	devlink_port_unregister(&pf->devlink_port);
>  }
>  
> +/**
> + * ice_devlink_port_get_vf_fn_mac - .port_fn_hw_addr_get devlink handler
> + * @port: devlink port structure
> + * @hw_addr: MAC address of the port
> + * @hw_addr_len: length of MAC address
> + * @extack: extended netdev ack structure
> + *
> + * Callback for the devlink .port_fn_hw_addr_get operation
> + * Return: zero on success or an error code on failure.
> + */
> +
> +static int ice_devlink_port_get_vf_fn_mac(struct devlink_port *port,
> +					  u8 *hw_addr, int *hw_addr_len,
> +					  struct netlink_ext_ack *extack)
> +{
> +	struct devlink_port_attrs *attrs = &port->attrs;

You can get VF's pointer using container_of:
container_of(port, struct ice_vf, devlink_port)
You can even create helper function/macro: ice_devlink_port_to_vf

> +	struct devlink_port_pci_vf_attrs *pci_vf;
> +	struct devlink *devlink = port->devlink;
> +	struct ice_pf *pf;
> +	struct ice_vf *vf;
> +	int vf_id;
> +
> +	pf = devlink_priv(devlink);
> +	pci_vf = &attrs->pci_vf;
> +	vf_id = pci_vf->vf;
> +
> +	vf = ice_get_vf_by_id(pf, vf_id);
> +	if (!vf) {
> +		NL_SET_ERR_MSG_MOD(extack, "Unable to get the vf");
> +		return -EINVAL;
> +	}
> +	ether_addr_copy(hw_addr, vf->dev_lan_addr);
> +	*hw_addr_len = ETH_ALEN;
> +
> +	ice_put_vf(vf);
> +	return 0;
> +}
> +
> +/**
> + * ice_devlink_port_set_vf_fn_mac - .port_fn_hw_addr_set devlink handler
> + * @port: devlink port structure
> + * @hw_addr: MAC address of the port
> + * @hw_addr_len: length of MAC address
> + * @extack: extended netdev ack structure
> + *
> + * Callback for the devlink .port_fn_hw_addr_set operation
> + * Return: zero on success or an error code on failure.
> + */
> +static int ice_devlink_port_set_vf_fn_mac(struct devlink_port *port,
> +					  const u8 *hw_addr,
> +					  int hw_addr_len,
> +					  struct netlink_ext_ack *extack)
> +
> +{
> +	struct devlink_port_attrs *attrs = &port->attrs;
> +	struct devlink_port_pci_vf_attrs *pci_vf;
> +	struct devlink *devlink = port->devlink;
> +	struct ice_pf *pf;
> +	u8 mac[ETH_ALEN];
> +	int vf_id;
> +
> +	pf = devlink_priv(devlink);
> +	pci_vf = &attrs->pci_vf;
> +	vf_id = pci_vf->vf;
> +
> +	ether_addr_copy(mac, hw_addr);
> +
> +	return ice_set_vf_fn_mac(pf, vf_id, mac);
> +}
> +
> +static const struct devlink_port_ops ice_devlink_vf_port_ops = {
> +	.port_fn_hw_addr_get = ice_devlink_port_get_vf_fn_mac,
> +	.port_fn_hw_addr_set = ice_devlink_port_set_vf_fn_mac,
> +};
> +
>  /**
>   * ice_devlink_create_vf_port - Create a devlink port for this VF
>   * @vf: the VF to create a port for
> @@ -1611,7 +1686,8 @@ int ice_devlink_create_vf_port(struct ice_vf *vf)
>  	devlink_port_attrs_set(devlink_port, &attrs);
>  	devlink = priv_to_devlink(pf);
>  
> -	err = devlink_port_register(devlink, devlink_port, vsi->idx);
> +	err = devlink_port_register_with_ops(devlink, devlink_port,
> +					     vsi->idx, &ice_devlink_vf_port_ops);
>  	if (err) {
>  		dev_err(dev, "Failed to create devlink port for VF %d, error %d\n",
>  			vf->vf_id, err);
> diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
> index 31314e7540f8..73cf1d9e9daa 100644
> --- a/drivers/net/ethernet/intel/ice/ice_sriov.c
> +++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
> @@ -1216,6 +1216,68 @@ ice_get_vf_cfg(struct net_device *netdev, int vf_id, struct ifla_vf_info *ivi)
>  	return ret;
>  }
>  
> +/**
> + * ice_set_vf_fn_mac
> + * @pf: PF to be configure
> + * @vf_id: VF identifier
> + * @mac: MAC address
> + *
> + * program VF MAC address
> + */
> +int ice_set_vf_fn_mac(struct ice_pf *pf, int vf_id, u8 *mac)
> +{
> +	struct device *dev;
> +	struct ice_vf *vf;
> +	int ret;
> +
> +	dev = ice_pf_to_dev(pf);
> +	if (is_multicast_ether_addr(mac)) {
> +		dev_err(dev, "%pM not a valid unicast address\n", mac);
> +		return -EINVAL;
> +	}
> +
> +	vf = ice_get_vf_by_id(pf, vf_id);
> +	if (!vf)
> +		return -EINVAL;
> +
> +	/* nothing left to do, unicast MAC already set */
> +	if (ether_addr_equal(vf->dev_lan_addr, mac) &&
> +	    ether_addr_equal(vf->hw_lan_addr, mac)) {
> +		ret = 0;
> +		goto out_put_vf;
> +	}
> +
> +	ret = ice_check_vf_ready_for_cfg(vf);
> +	if (ret)
> +		goto out_put_vf;
> +
> +	mutex_lock(&vf->cfg_lock);
> +
> +	/* VF is notified of its new MAC via the PF's response to the
> +	 * VIRTCHNL_OP_GET_VF_RESOURCES message after the VF has been reset
> +	 */
> +	ether_addr_copy(vf->dev_lan_addr, mac);
> +	ether_addr_copy(vf->hw_lan_addr, mac);
> +	if (is_zero_ether_addr(mac)) {
> +		/* VF will send VIRTCHNL_OP_ADD_ETH_ADDR message with its MAC */
> +		vf->pf_set_mac = false;
> +		dev_info(dev, "Removing MAC on VF %d. VF driver will be reinitialized\n",
> +			 vf->vf_id);
> +	} else {
> +		/* PF will add MAC rule for the VF */
> +		vf->pf_set_mac = true;
> +		dev_info(dev, "Setting MAC %pM on VF %d. VF driver will be reinitialized\n",
> +			 mac, vf_id);
> +	}
> +
> +	ice_reset_vf(vf, ICE_VF_RESET_NOTIFY);
> +	mutex_unlock(&vf->cfg_lock);
> +
> +out_put_vf:
> +	ice_put_vf(vf);
> +	return ret;
> +}
> +
>  /**
>   * ice_set_vf_mac
>   * @netdev: network interface device structure
> diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.h b/drivers/net/ethernet/intel/ice/ice_sriov.h
> index 346cb2666f3a..a03be184a806 100644
> --- a/drivers/net/ethernet/intel/ice/ice_sriov.h
> +++ b/drivers/net/ethernet/intel/ice/ice_sriov.h
> @@ -28,6 +28,7 @@
>  #ifdef CONFIG_PCI_IOV
>  void ice_process_vflr_event(struct ice_pf *pf);
>  int ice_sriov_configure(struct pci_dev *pdev, int num_vfs);
> +int ice_set_vf_fn_mac(struct ice_pf *pf, int vf_id, u8 *mac);
>  int ice_set_vf_mac(struct net_device *netdev, int vf_id, u8 *mac);
>  int
>  ice_get_vf_cfg(struct net_device *netdev, int vf_id, struct ifla_vf_info *ivi);
> @@ -76,6 +77,13 @@ ice_sriov_configure(struct pci_dev __always_unused *pdev,
>  	return -EOPNOTSUPP;
>  }
>  
> +static inline int
> +ice_set_vf_fn_mac(struct ice_pf __always_unused *pf,
> +		  int __always_unused vf_id, u8 __always_unused *mac)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
>  static inline int
>  ice_set_vf_mac(struct net_device __always_unused *netdev,
>  	       int __always_unused vf_id, u8 __always_unused *mac)

