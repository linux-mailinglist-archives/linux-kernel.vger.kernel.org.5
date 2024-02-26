Return-Path: <linux-kernel+bounces-81135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84AE08670CD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A313E1C232F2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3DC249F8;
	Mon, 26 Feb 2024 10:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nSZOpiea"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF581BDDC;
	Mon, 26 Feb 2024 10:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708942220; cv=fail; b=j3wIpyuULyTgDKqhAb1jWAB6lL8PaNQPUCuhNPXx8epmX2nC9VBfvYHgv9c2j9/nSayGClDHrdZDOI7HQtRnZYgMEb3n1HL6qGAa3oQeHp1U883TWw+fgMon89lEm5EpnHr69/jbCu9Bm0TyyTdObY9JgXKMixyPeuVuh1SjUPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708942220; c=relaxed/simple;
	bh=Ap2Pty0fauq3EqvuUhCgiFE8rSDwZJ/Y0j+hIXG3thY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tixNPWmB8s4yKWX3WkDYqwUKcXvf5jKTeEWTAelanEduJ3ZCdipG+3V1rWbm4pl7OczozQwhT0eLzuGZTtiR7IVarvg/gwogWngEEvSQrVfl1/vGuW1IQtJBKLo0rZAd9WPugXRYkPNahLH437sptjQ6+Z3hMpru48DYTjipg8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nSZOpiea; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708942219; x=1740478219;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ap2Pty0fauq3EqvuUhCgiFE8rSDwZJ/Y0j+hIXG3thY=;
  b=nSZOpieaheOpHnDJKmDu4jKLqUrGTJ7IbGaTeVTiX8JfbHOqbTSk4t1c
   PRI5EqkXPaUJMyk5K2TD2pmKq0dqrnizu+WHaGZZCEFXDOAA76pH1LiD7
   24HLrZQtgNXq8BGFfuLnutLhGcOldQmPVEoopdZ1R2WNnvAEFq7k7GPp4
   q64XQdb1tHAZdWMMKxzlt/HkVfarmz3aB+RBHPkUL5kdcO0bIOQm/ATep
   VmgpBbUhqLtSNbkXTzShjBFuvYjQ0XKQv7HvZ/ZBhQxKiimUaof1JHKoK
   6eV9FdsDRMFLghXXXJWmTvEPp/icBLxsBjVvVSPjg9vrB+xt8wmQ27WJV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="3087867"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="3087867"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 02:10:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="6511128"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Feb 2024 02:10:18 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 02:10:17 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 02:10:17 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 26 Feb 2024 02:10:17 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 26 Feb 2024 02:10:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L5bQWOTCIehaHZhqNpPNgDLMHVNduqEZWn4KrZIXXd3MoSA8qME2XZIAtAQJLjwSVWcThWdVppyrVH2v/BfCZAOszyTFvd2aE18G3r5dX14K1adAs757AZshrExuAHL3F9DXyFt/tE/KS/7l911H0U1vHMCtdpHiu8ezMpjWQZVmztfF6D1dURjV1AElQVDICd9TZciMuoecQsFFIkioINT7/cCnVbIblYpWqFJOpnYEhOeSqbh86b3IaB2A6OfWBgIl+YM6hfO3W3i8XojFKajUGTenYIhSpjDpPtG0pyTaDEGJU31ADnUQUKVhTNorPI/sHAGW99X9NYto7GlX2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZnAeImvCKABDbxfCRnkMR3fIHwMtbsTobi0MIGWJeI=;
 b=jZIAxV5XqPdN+s1qlhjWMq99vBGm4KbwfjZ8Wb2QxsCyVYbkmvpWdHJ3go6CDbph0Ih/JVs1YWwZHE8aaoPyUaUHIypHS+ixN5YWt8bLIpvEQ20Dx/506oEVARIEDo0zJcyATPkTVOudi8hdkqkFW/gM55fAOpqt5zNOKy+zWAf49HdT2hcgQ1OK4DR8yf4Qr0QbZpwPV5HlumdqqXIx5eQau7Gy/qjSnqghZ6gl0scapg/FHvaZTrVJelfPUyPVoIUY9egE+1fU80ZsL1glqorTTEoaaniXaqqheH64QoTHh6YSp/Z60ccocSS/eQG9m90NJlWvCqg93m1B1kelSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by CH3PR11MB7251.namprd11.prod.outlook.com (2603:10b6:610:147::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.24; Mon, 26 Feb
 2024 10:10:15 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::f082:826a:7761:7aca]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::f082:826a:7761:7aca%2]) with mapi id 15.20.7339.022; Mon, 26 Feb 2024
 10:10:15 +0000
Message-ID: <de696b4c-bda5-4ab2-a0c0-490b4eba8163@intel.com>
Date: Mon, 26 Feb 2024 11:10:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: skbuff: allocate the fclone in the current NUMA node
To: Huang Shijie <shijie@os.amperecomputing.com>
CC: <kuba@kernel.org>, <patches@amperecomputing.com>, <davem@davemloft.net>,
	<horms@kernel.org>, <edumazet@google.com>, <ast@kernel.org>,
	<dhowells@redhat.com>, <linyunsheng@huawei.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<cl@os.amperecomputing.com>
References: <20240220021804.9541-1-shijie@os.amperecomputing.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240220021804.9541-1-shijie@os.amperecomputing.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0047.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::16) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|CH3PR11MB7251:EE_
X-MS-Office365-Filtering-Correlation-Id: 903b0b50-a2c4-42a6-70a1-08dc36b32040
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ElWLYHlDb8o1e4Twy/pgM4/cTjnHM7vxJSgNCgb7brwTU21Gz8TSu+8bqgKvlz+oNON75l1nASAcg+R25dReTnG0gRhOmdXEA5TedjEqV9iYdr4x3hOrj2KClbkvCealRk4oBvtH7OmBM873a7W5PTN137rZgOI1diWjqMC91q9jQZXnETtMrecMFRNKVGTuBb5TLdeblM/BzZH/5DyazgUtYpN81VpF3rwR18kTOktFw4b2eIPg0DYnyu8sYCtjYnatKMKGbswXXa7UBZpsMyjOgzEUwMfXGrXLla5ZqrkPIjdq2mLjcKOY0GuYodmAOh0YI+olHfh5+eNt/z+8cI2e3gCahp2l0NfEOIczLQwWngGFRXOUZyWDWXPbNFHVWEDmRjHp3wAhnAA+STOhfJLAgUyPcIFGrFl4EFF9tXVUzFjylt+VUp3qW46WbH+JHdnB53fUayPn/RXMQlhKMH2956KKpvxM4Vaa6hKmRzOzDR/B2cElDE63lkMufTliWg8s+BFFzMWxle9yD0B6qZr2AmFEj8Ab9VzHUSdDalgiBgOdCwR4wJpVM5Kdi11yCfcVualysHoadeMhcK5ADEDMX8WwiiOqZUCh9hHF7ssoIhYyiNHQNT1pPEVrRo1e8z63wQZ5jvZAMGz1Czg+zQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1FncGdkQXlqSFdJaTF5cWxFZXQ5Z3RCWFlhdzhaMVRCb1k5MmhtRURpVUFl?=
 =?utf-8?B?TXhxWmxoWkdNVFpzblpWUFdxQzBCSXdBdjF0Ynk5amx3V2hwMmxiOWZTVUEz?=
 =?utf-8?B?cVlDcUMwbVBWN3kybXFRK3FhZUhYZnFzYlZYTkRBK1VKaVB4KytEUnd2S0s4?=
 =?utf-8?B?L04zbTVGL0xkMXhWcTllTVNHMVVvMGp4WEplYkhHbFcvajFsSnF1eUN0cXl0?=
 =?utf-8?B?NUd6dHlqRng5SjFXM0NvMnR5bkF5WkNHQXJzeEwrYmpKS0ZBbU9XaXVuZkhM?=
 =?utf-8?B?NnZKVThqZnVWdmJWcG5PdDRpUUFkalZKTWJYVFA1UFAwUXFJTmpqRGZTeTZm?=
 =?utf-8?B?dEtlSXZYcnBDWFNidFdMS1VpVHYyTmxLNlZsRHpXQitVbzQxZmc3dnpZTU03?=
 =?utf-8?B?by8yaHFaWG8rMWZ5QVd0QVlsdEs0OEF2RHFEQ3RzR1JTVkJISGtMZC9Wd3lp?=
 =?utf-8?B?TWVVSzFVR0JzT3RZQ3cxTVlxUkZOWjBnWFRWL003UVlYWE10Wnl2cTZjUHBv?=
 =?utf-8?B?RUQ0M1VNcjJMZ0U5OFNpOTBqMmxhL1RXa29XamJwcWp6eFBRa203dVZiTCtu?=
 =?utf-8?B?NGZUajZCMUZTaWdRc2lBbjdKc245bkJuVlhtTENEWU1IMG9ZY1VtUHZ1Wm9U?=
 =?utf-8?B?YnNiNWFpL2NEcTg0NUtXRUY1S2dNOVBlb0VvdjNkMlFVZTdBOVM5TWlRMXB4?=
 =?utf-8?B?aDlzT3ZRSTZSS2hER20wemdVcXVUcVNGWG9wUjhKQkthSnlRYlM2TTNKUDN6?=
 =?utf-8?B?ZTNBMU8vUDB1dTczdFdSeGFKbXBNQWFDa1F4b2MvM0FBdGVZS0thbXJYUHlF?=
 =?utf-8?B?b3BzUEduNGJaaU16djV4LzlEdUltc2F0S2NWTDVXdDFwWG91cFJ3OHQ0MXVS?=
 =?utf-8?B?YjhpRHRmb1Z6MGQ5OW40a2tHV09qTVJ1ZzdydzN1MTAzWjNhamI3NkVwU2lO?=
 =?utf-8?B?ektidjBFM0NqaDc3NEVTbGMyQ1RnK2huN1RBZ3ZDLzZicThCWHBYaHZqdXZG?=
 =?utf-8?B?cFpLai9CdXhzSjdIeFRtbVF0Q1pyaWxnNmpWUmM1dU90bmxFbnozdStMUUdo?=
 =?utf-8?B?SGUrRkI3dUF6Y2d1NUxmY2J3blJCb1Q3UkJWZkFsNVNmOHBKRTFKdzN2bzdH?=
 =?utf-8?B?SXl4ckRHU254V1VJSmdnOUlrb3J5SFRSUnJPWTVwQUpJM2NwT0pGdEc2WEt2?=
 =?utf-8?B?TDdEL3pJRnBySHlMcUZCbnFiZnB1TFdSZklSZEVvQVpQdVM5cWJjZ1FsR21G?=
 =?utf-8?B?ZVhSV1B2bTIzZkdzVlE2VWJuVlJiWjR4byt1SVl1ZTlSaVZHVkhVZmNvckdu?=
 =?utf-8?B?bU5HeERHRitmV1BtTEp0VXpBRWIvYzE2ZUZycWxnbGovNENXL2kyV1c2YkZ0?=
 =?utf-8?B?dEtEbG54YlZBN3FZN2FjSFNXdEl6eXpFRmpFd2VqTWRhTjBqbStyYUV4aVhr?=
 =?utf-8?B?QnB3QVA1eFdNV1Y3V0lveWgxdDNZVjZRRG40TWV2Qno3NEpvWE5Kc1lZcjB6?=
 =?utf-8?B?dVBZQXgzVWRsUUliZ2ZmZFdwMnZQb3NnSmY2YzByeHBKZGxHMTErUXBWMEhT?=
 =?utf-8?B?dUs0SzlQTWg4QU51Y2xjaXA2dWFUSHAxREFuZ3B0VmpOVEloSlYxT3JUNnl6?=
 =?utf-8?B?L1VBTmVTM1FzMGc2VGZwMTdpdGJZR28rK0gxUFdHRDV2aVplV2lzV0tMbWR3?=
 =?utf-8?B?YUVBeHNWczFMYmRZVGpaNWl3YUFpN0gyM2RKMFhXeGZNZ1plUnRCNTU5ckE2?=
 =?utf-8?B?YjN1bDJmdmEwN291bUpCR1l3U1ErdVUyeFBSK0E4cVo5RjFCNEx2VE41bmhE?=
 =?utf-8?B?WjBnaWNDdGVzRmQxaEJqMHltOUNnY3ZxVXFnTStTb1JmQ3VONEU2QzVwb2hK?=
 =?utf-8?B?MUtQR2dsUlZCN2xoclVnRHUrSmJ5SWdnVmxseWdjUXlhdmJCTDBaNklaQTNH?=
 =?utf-8?B?Q3ZoaGNEa2ZBSTNUMURRVnA3L2YzOGpXRWVMRVN2L3VYdXp6ODN2QnVYZ3JI?=
 =?utf-8?B?WFRzVURWMW1Nb2w0NkwvY2xEYjhUSnI5aGxDR2N6MEVYUGljNFFHTUJ6MGk5?=
 =?utf-8?B?bDlySy94MnpndS9Qc09DczZTbmtUWXpnelFRc0dYeDdRRGFWV2NDSjRFR005?=
 =?utf-8?B?VFNlRjgraSttVkJDV2VPNEg1OU5NUXFFbEtObmFxV1ZlTm5GQnRrVGNBN1pU?=
 =?utf-8?B?cUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 903b0b50-a2c4-42a6-70a1-08dc36b32040
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 10:10:15.0119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RIyKpt+OepV8Ed0rks2Vxi6pIQwmUo/20PK69Kgg4Kppw5hHT/WaoU0Ds6P1RChhrqKtbtVhDXcAiNyO58i+7s+AxqSiUJ6Mmbf59eGunbk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7251
X-OriginatorOrg: intel.com

From: Huang Shijie <shijie@os.amperecomputing.com>
Date: Tue, 20 Feb 2024 10:18:04 +0800

> The current code passes NUMA_NO_NODE to __alloc_skb(), we found
> it may creates fclone SKB in remote NUMA node.
> 
> So use numa_node_id() to limit the allocation to current NUMA node.
> 
> Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
> ---
>  include/linux/skbuff.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 2dde34c29203..ebc42b2604ad 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -1343,7 +1343,7 @@ static inline bool skb_fclone_busy(const struct sock *sk,
>  static inline struct sk_buff *alloc_skb_fclone(unsigned int size,
>  					       gfp_t priority)
>  {
> -	return __alloc_skb(size, priority, SKB_ALLOC_FCLONE, NUMA_NO_NODE);
> +	return __alloc_skb(size, priority, SKB_ALLOC_FCLONE, numa_node_id());

Because it tries to defragment the memory and pick an optimal node.

__alloc_skb() and skb clones aren't anyway something very hotpathish, do
you have any particular perf numbers and/or usecases where %NUMA_NO_NODE
really hurts?

>  }
>  
>  struct sk_buff *skb_morph(struct sk_buff *dst, struct sk_buff *src);

Thanks,
Olek

