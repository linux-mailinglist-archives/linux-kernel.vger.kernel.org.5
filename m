Return-Path: <linux-kernel+bounces-50227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F0A847605
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACAA7B285CB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D56314AD04;
	Fri,  2 Feb 2024 17:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N0djKm9k"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF3B14A4EC;
	Fri,  2 Feb 2024 17:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706894619; cv=fail; b=lzhmszYww3y2q5T58D+5TLDT9dn8JPXK1MOSaDC9KOVvv059rf0FED0R7m3XKTviyag5/Nqq6sK/nleaIPXIAOFlVw4zW+P9GqfhNs5FPwpK6Knj4EeIw6dTxkoTQLtZOckw4RyguaBdWK3I7ZlPfUjjEsb9l+u8yvBJV/LIdxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706894619; c=relaxed/simple;
	bh=naC4HmCsO14Bq2Fm7v/Oi+3V+Nsv6/vUp4nhUV7TZTQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VEl07KC9Rrp+IA8uxe55z2zepTtf4F1z5tqcT4PnbBerY8QOiKAsjuXYKKKJ023eAb/dXZt5+7SOssKyXCJ9GT/IX9sgJImeek6Ypn+L/QKb85W55E0Hq8wPpXojhQh9x4bdI1xoBa3laUlaA5nbMIDWPF7pcRR3rJmtpJyG3dA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N0djKm9k; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706894618; x=1738430618;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=naC4HmCsO14Bq2Fm7v/Oi+3V+Nsv6/vUp4nhUV7TZTQ=;
  b=N0djKm9kcViCyU2Zn8SnfIuFCk6SI/xT4R3CW4pg2Slbw3EiYc47A+45
   XenUDe4O+EvmsZjPE18/+CzG9hhV9sn+GxXB5PtWpnQmYgyPDvlulgq0+
   R1uTBXdh3ZJQILe2KkQjEQj+eBogG/BmcI8PN6y/yNBjMkhDVlq7ST6zH
   Xn8DIGjQUV8xOOXjf0EuHJYkgRwSMQNWgRSyI1ozbQpAnAiAwX47Guif4
   afcM8NovdBzyqq7rIwA+EEhc2I4nztb5HkDNU5yeDaaUUadenMCxIdYN8
   wadTCJyfJ4uW/1Isz3euYJ1j1q+me1IsZkmM7TlWxHoKJo4ThdH9wMZmq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="117240"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="117240"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 09:23:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="130718"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Feb 2024 09:23:37 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 2 Feb 2024 09:23:36 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 2 Feb 2024 09:23:36 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 2 Feb 2024 09:23:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DfJIPQJBUQ+I5N1+tlOXvV1sk6WVQ9BU07tUsHwn8K5CYq6mntvHxYGP0ozZAygqv9vmA0kKiRHHW2IIGASxnsGViEHXb1ISTskG7mAEe04ZLUeOADcJbTOQ2PpkAoev5FJ8K8G+CVnaSsgfYXvPQsj4HmqjUbt75O6KfhmUf1EH6oiYxoNQk64uSgnDQ+b8Slr+FQZpRQnCjM+OI8s/m+Ah9Eb5lpy+65O16loFjkS2E73iliGPVvx3MywSxNAUS33MShWGuk5raBS312SnRWjJIKoa31WiZOS+qy2hrvcBhjvantoB+cEp0Kjgt/TE5Ub4eNtUrf4nUV3v1Li2yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+OgAfljyFAODX8C06SHp1smdPcLr+6CIz4rNIgIh7Go=;
 b=eMcR1663FWn36uFEOx+XNuw6ZDn+JvgigKWCuu7nWIa3XrmXem1pqvKaYIYiSEHhIE5tenek/FykV7MPiwdGMxTDd1H60mvkzPLzBNVtMtiu+I8afoU5rG7N47DZ2upruh4iCxr0NszbBDfiOXydfONQEBEzitK7MsIyuiCKcbNkai753AU7oS7NxTDr2TrJEtDqnlxnxfBb4v/Tn5Fyp75D6KQmphaewjoaEjaQmsvYeUg7k0RyE9YIvi5NYR7EiJcf4n3awn7UO5qBLMnsL+s6UL6nuWb1NTJMo35E97ixI6joakJXozYS3jstLyOIyMXiWPdT1HQkKyNhCEzScg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB4893.namprd11.prod.outlook.com (2603:10b6:a03:2ac::17)
 by PH7PR11MB5914.namprd11.prod.outlook.com (2603:10b6:510:138::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.30; Fri, 2 Feb
 2024 17:23:32 +0000
Received: from SJ0PR11MB4893.namprd11.prod.outlook.com
 ([fe80::ad31:79ae:4d1:80b4]) by SJ0PR11MB4893.namprd11.prod.outlook.com
 ([fe80::ad31:79ae:4d1:80b4%5]) with mapi id 15.20.7249.024; Fri, 2 Feb 2024
 17:23:32 +0000
Message-ID: <f0b4d813-d7cb-428b-9c41-a2d86684f3f1@intel.com>
Date: Fri, 2 Feb 2024 11:23:28 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next 0/3] Per epoll context busy poll support
To: Joe Damato <jdamato@fastly.com>
CC: Eric Dumazet <edumazet@google.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <chuck.lever@oracle.com>,
	<jlayton@kernel.org>, <linux-api@vger.kernel.org>, <brauner@kernel.org>,
	<davem@davemloft.net>, <alexander.duyck@gmail.com>, <kuba@kernel.org>, "Wei
 Wang" <weiwan@google.com>, Amritha Nambiar <amritha.nambiar@intel.com>
References: <20240124025359.11419-1-jdamato@fastly.com>
 <CANn89i+YKwrgpt8VnHrw4eeVpqRamLkTSr4u+g1mRDMZa6b+7Q@mail.gmail.com>
 <5faf88de-5063-421f-ad78-ad24d931fd17@intel.com>
 <20240202032806.GA8708@fastly.com>
Content-Language: en-US
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
In-Reply-To: <20240202032806.GA8708@fastly.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0080.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::25) To SJ0PR11MB4893.namprd11.prod.outlook.com
 (2603:10b6:a03:2ac::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4893:EE_|PH7PR11MB5914:EE_
X-MS-Office365-Filtering-Correlation-Id: 97a9b235-c979-4c13-f5e1-08dc2413adbf
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2xVSmBE416Ib0UB+5hrNFqWW4xtEQyTQxlDLaa1YWgZsBBs5pJSNbBzQrYFTDGjR091i/6+zqysL4mlrrMga+2Xv5Ku6k8oUhuv/8zTh9hSwWQZjPDPTxAr6aQ/DtjUf9ISNQQivSM3o7hEXLAS89CS+Ger6L/tgcXwgpQAHAAIc8SOZO/VxcfemD1pdPXHx578YuXtHXyugKubJ83u4fifTELuaof9gshHm2g1MzYD+uRFxUqlggnCyRMPviTWAy2Fujjg9tEnRiS82DO20o35XKS0ESNR/xgAHk8VzjvWIcVkgw989nz7z8e7bJNpuIdEvDrCj6aHeFBkD3gyou7CLmrMBJrdrs1ZXMcN7f1C+OS9TbftymeTGz0XMY4ePrL2ZqjckXStfVIiNzjr/ZnwmZLulBGcO8ZeVJAcI6lu8OJCr5z4tJgItSBKvlQkdMq9/9oFXi2ilYw67bcAzbT7mYJ+PbGREFDU83/dKKCXXWywgBJxaj4qCw3nWyDzlsJpNGK7yO+RG+Z5sYQ7kxnokySb3gd+A5EfgmeUZdsIwhmFsHZrGKvqacRtVvC2q3+NDuZxwgepnJxeqvGQk9eQE2J9dxPx9UFXdC0NCucgz2La3BTz2fP4wmkXdKseb2Tv1PiKoIzUSBNqgdymk/I9VEW6ZI9MNPRzz+RN8elw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4893.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(39860400002)(366004)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(66946007)(66899024)(36756003)(6916009)(316002)(54906003)(8936002)(8676002)(6486002)(66556008)(86362001)(478600001)(66476007)(31696002)(4326008)(5660300002)(966005)(7416002)(82960400001)(2616005)(2906002)(26005)(38100700002)(6506007)(6666004)(6512007)(83380400001)(53546011)(107886003)(41300700001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXdiOExmYzhrMlB0SGhUVkxwVy9MVmlUWWltSXlDVS81ejdOY1RuL0JYUXNY?=
 =?utf-8?B?U3JaelN2MmpDcUwvVndRcnV4TnhSVlRuUXVWZnFsb3AxMDBtcUkwRUtKQjEw?=
 =?utf-8?B?TUFiM0I2bjRWcWpNakFWMm1FREMyMlg5WW1qbXp2RVhERXpqZ2hYMjk3bU9q?=
 =?utf-8?B?NnlrU3gzeGhjVVJoblFwVWJIcVpCN0dpTG4zUkpDOFVOMFdLK3h3cW9FWDJq?=
 =?utf-8?B?SzlwUzJIUCt5T1FpN2tnWnVXeTMyaGJqZ29NR2luNzBsTjIzTmVDZmdOeVFx?=
 =?utf-8?B?RkttNmh1TGJDUUh5L2tBWkZQZmxRYWk2NnJISUt2U2MyRVY5MlFLRU1EbkF1?=
 =?utf-8?B?d0RDUlJ5WXFicjF4dk1oNm0xaHJjUU0xTVdncHhZOGs0TWRuRXF6TFhGOTY2?=
 =?utf-8?B?TDZGVDVBYXFNdjNXSDYzeXpXREIxZDRXT0FmTFFjUnFNTjJLSjJtaWoxaWJI?=
 =?utf-8?B?bjgxa3BLeFFncGNlL2NaR0FLSGRJUTROSjU4SDB4NVA5aTZFRUVRTzFhaUxI?=
 =?utf-8?B?WTR3dU9ISTFjQ1J6TDZqVzdmTmNrZTBwM3VmaDNuWEVEYW1BVWpjaE9RWE9w?=
 =?utf-8?B?U24rOCtUQjRCb3UxbStVeXZMNEJDR283NzJ5THhMTWJNdDV3ekRCTzRDYkty?=
 =?utf-8?B?TkVIZEtWTW5BZlMxK0w5WkltRFgvTUZLbjI4eGZKOFkyRGY3UmlWNTUveUFT?=
 =?utf-8?B?bWNGZ1NUWnpqT1VjRmVCMDllVDk3bFN3RFFMbEV0Z3EvcnJ3MU5YVktWaHJ2?=
 =?utf-8?B?SURMN0pWa2E3VHM2TC81WEk2K08xSzNhQjRxaVNqc3piSHNRS1FKR2I5aUQw?=
 =?utf-8?B?U1NpN0tPREtGQkxTblZiQ1VmVnJ3N1VFVVQ2TmtMcE40aFN0RmNzVk4wczlv?=
 =?utf-8?B?SlFvQS9EY0RGdXVmZmZkZFZUcWlXSHhDaVJxOURXUUh0SWJISHdrR2FRczJ4?=
 =?utf-8?B?b3ZISDkxQjdmcllXc0JiQkM5bjlyOUNKMUtrSTZoaUlraW5MdlMxbmpUT050?=
 =?utf-8?B?RjVRZ0piRlFkSVo0aWxtbkt1UDJHK3VkNFJYQ1IxWFFBTld2UmdacFV3Q0lK?=
 =?utf-8?B?RFJDcFJXQ25lN09zWmhSUlBsUm95UTMxcVRxVkhiWXFGTWRTTDNWVHdMdjNK?=
 =?utf-8?B?QzkvdmdCLzZGMThuZCt3Q2RhR2YrTktKQjhtTTh6R2JTQjI2TU8zZzdYeXBB?=
 =?utf-8?B?NGhRVUt2Y2ZwU09PR28vbCtBWjdpQ01QSUR4a0VTMHZFbE9MRjdUSmRFWE5y?=
 =?utf-8?B?N21SNEozSmZNYWdLa1JaV044QWJCS3lpM2ZzaXQrRUNaMkx0ZGoySUJRaHdK?=
 =?utf-8?B?MGRpMHFzYy9tWXZhekNUSjFvU0lmV1psSExTTG1tUk5hYjIwVDlaRXkvMjZy?=
 =?utf-8?B?LzdWSXVCNG9WK2pkZnRtUjhFK2l6NzMxdzlGaUlwMTVXd0tuYW5NdVcyZXNQ?=
 =?utf-8?B?MnA1YVJPTTU0bTl2dTdBTkNQR0YyVS9keHVyYXN2WkdROGZDS0R4cEV4dkhK?=
 =?utf-8?B?ZDlxK3JSSTBVcktCY2VxcmJOM1dZTnRDdmQyeForSHg2ZUNwcGxSZjk0Rkg1?=
 =?utf-8?B?dXAzcVkwcnlFVXhCOU1jVWw4NDN3ejRGYmlpTy9BN2w3cUkyOEw1TDJ2S1Ar?=
 =?utf-8?B?SjI4Um5DRi9ob1NLTllDejVLMWRKNm4rUDQwbnEzWVlOWWV3d2pHU3ZyS0RT?=
 =?utf-8?B?cGFhSE9hZkZBQTRZcFEvYzNoc0huQTlvRDFMVmIvRUlaK3NsbmhSa0JZYmxo?=
 =?utf-8?B?d28zeGJma2dTckFZbXR0VFA3ZlpFaVJKbkdVZkRobFpaZXI0QkRIM3F4Qm83?=
 =?utf-8?B?ZmlHNTJSa2lMQyt5OEd2c0Q2ZmJrTkhtSFhxc0QwYUZEaVQ4QWgvVFVsS0E5?=
 =?utf-8?B?cFhPRDRkKzRQc2FJUVFRckNhR2haYWhiRlhtTlpyZjNSVUQ5Sm5BSi92cmJH?=
 =?utf-8?B?ZHQxeG1jd3d3RjNucmkwUWpHZ29ZSnpMSy9WVm1FU1hBUmtBckZORS9MQ2hj?=
 =?utf-8?B?WEprVFh5Mm41VFdMR2czazhyN2NndGZRM2lsQ1BCMk5MQmlFN0dkUTk2M3hS?=
 =?utf-8?B?UVJla2lReWRQTTdZdG5FeEw5YmlQMUV2MitSLzJWditmeVFTd0dKeE11czZP?=
 =?utf-8?B?OThwbEtSeGRkd0Q4QWxSMmR4MFVPRHpVcDcySktzajZFamhmM1ZWSkZ3UkVj?=
 =?utf-8?B?TXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 97a9b235-c979-4c13-f5e1-08dc2413adbf
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4893.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 17:23:31.9271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gRhr4STavLWSfrSZMFa6eJIl9WtZ++jLtr4FvcQoASOiUlrk01vxoVgYnKzUGtDkXE1ZNjbfIVd62rW60l9f2s8NoYKu1w/TeiV5Xvq8g6Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5914
X-OriginatorOrg: intel.com



On 2/1/2024 9:28 PM, Joe Damato wrote:
> On Tue, Jan 30, 2024 at 12:54:50PM -0600, Samudrala, Sridhar wrote:
>>
>>
>> On 1/24/2024 2:20 AM, Eric Dumazet wrote:
>>> On Wed, Jan 24, 2024 at 3:54 AM Joe Damato <jdamato@fastly.com> wrote:
>>>>
>>>> Greetings:
>>>>
>>>> TL;DR This builds on commit bf3b9f6372c4 ("epoll: Add busy poll support to
>>>> epoll with socket fds.") by allowing user applications to enable
>>>> epoll-based busy polling and set a busy poll packet budget on a per epoll
>>>> context basis.
>>>>
>>>> To allow for this, two ioctls have been added for epoll contexts for
>>>> getting and setting a new struct, struct epoll_params.
>>>>
>>>> This makes epoll-based busy polling much more usable for user
>>>> applications than the current system-wide sysctl and hardcoded budget.
>>
>> Agree. looking forward to see this patch series accepted soon.
>>
>>>>
>>>> Longer explanation:
>>>>
>>>> Presently epoll has support for a very useful form of busy poll based on
>>>> the incoming NAPI ID (see also: SO_INCOMING_NAPI_ID [1]).
>>>>
>>>> This form of busy poll allows epoll_wait to drive NAPI packet processing
>>>> which allows for a few interesting user application designs which can
>>>> reduce latency and also potentially improve L2/L3 cache hit rates by
>>>> deferring NAPI until userland has finished its work.
>>>>
>>>> The documentation available on this is, IMHO, a bit confusing so please
>>>> allow me to explain how one might use this:
>>>>
>>>> 1. Ensure each application thread has its own epoll instance mapping
>>>> 1-to-1 with NIC RX queues. An n-tuple filter would likely be used to
>>>> direct connections with specific dest ports to these queues.
>>>>
>>>> 2. Optionally: Setup IRQ coalescing for the NIC RX queues where busy
>>>> polling will occur. This can help avoid the userland app from being
>>>> pre-empted by a hard IRQ while userland is running. Note this means that
>>>> userland must take care to call epoll_wait and not take too long in
>>>> userland since it now drives NAPI via epoll_wait.
>>>>
>>>> 3. Ensure that all incoming connections added to an epoll instance
>>>> have the same NAPI ID. This can be done with a BPF filter when
>>>> SO_REUSEPORT is used or getsockopt + SO_INCOMING_NAPI_ID when a single
>>>> accept thread is used which dispatches incoming connections to threads.
>>>>
>>>> 4. Lastly, busy poll must be enabled via a sysctl
>>>> (/proc/sys/net/core/busy_poll).
>>>>
>>>> The unfortunate part about step 4 above is that this enables busy poll
>>>> system-wide which affects all user applications on the system,
>>>> including epoll-based network applications which were not intended to
>>>> be used this way or applications where increased CPU usage for lower
>>>> latency network processing is unnecessary or not desirable.
>>>>
>>>> If the user wants to run one low latency epoll-based server application
>>>> with epoll-based busy poll, but would like to run the rest of the
>>>> applications on the system (which may also use epoll) without busy poll,
>>>> this system-wide sysctl presents a significant problem.
>>>>
>>>> This change preserves the system-wide sysctl, but adds a mechanism (via
>>>> ioctl) to enable or disable busy poll for epoll contexts as needed by
>>>> individual applications, making epoll-based busy poll more usable.
>>>>
>>>
>>> I think this description missed the napi_defer_hard_irqs and
>>> gro_flush_timeout settings ?
>>>
>>> I would think that if an application really wants to make sure its
>>> thread is the only one
>>> eventually calling napi->poll(), we must make sure NIC interrupts stay masked.
>>>
>>> Current implementations of busy poll always release NAPI_STATE_SCHED bit when
>>> returning to user space.
>>>
>>> It seems you want to make sure the application and only the
>>> application calls the napi->poll()
>>> at chosen times.
>>>
>>> Some kind of contract is needed, and the presence of the hrtimer
>>> (currently only driven from dev->@gro_flush_timeout)
>>> would allow to do that correctly.
>>>
>>> Whenever we 'trust' user space to perform the napi->poll shortly, we
>>> also want to arm the hrtimer to eventually detect
>>> the application took too long, to restart the other mechanisms (NIC irq based)
>>>
>>> Note that we added the kthread based napi polling, and we are working
>>> to add a busy polling feature to these kthreads.
>>> allowing to completely mask NIC interrupts and further reduce latencies.
>>
>>
>> Good to know that you are looking into enabling busy polling for napi
>> kthreads.
>> We have something similar in our ice OOT driver that is implemented and we
>> call it 'independent pollers' as in this mode, busy polling will not be app
>> dependent or triggered by an application.
>> Here is a link to the slides we presented at netdev 0x16 driver workshop.
>> https://netdevconf.info/0x16/slides/48/netdev0x16_driver_workshop_ADQ.pdf
>>
>> We haven't yet submitted the patches upstream as there is no kernel
>> interface to configure napi specific timeouts.
>> With the recent per-queue and per-napi netlink APIs that are accepted
>> upstream
>> https://lore.kernel.org/netdev/170147307026.5260.9300080745237900261.stgit@anambiarhost.jf.intel.com/
>>
>> we are thinking of making timeout as a per-napi parameter and can be used as
>> an interface to enable napi kthread based busy polling.
> 
> I know I am replying to a stale thread on the patches I've submit (there is
> a v5 now [1]), but I just looked at your message - sorry I didn't reply
> sooner.
> 
> The per-queue and per-napi netlink APIs look extremely useful, thanks for
> pointing this out.
> 
> In my development tree, I had added SIOCGIFNAME_BY_NAPI_ID which works
> similar to SIOCGIFNAME: it takes a NAPI ID and returns the IF name. This is
> useful on machines with multiple NICs where each NIC could be located in
> one of many different NUMA zones.
> 
> The idea was that apps would use SO_INCOMING_NAPI_ID, distribute the NAPI
> ID to a worker thread which could then use SIOCGIFNAME_BY_NAPI_ID to
> compute which NIC the connection came in on. The app would then (via
> configuration) know where to pin that worker thread; ideally somewhere NUMA
> local to the NIC.
> 
> I had assumed that such a change would be rejected, but I figured I'd send
> an RFC for it after the per epoll context stuff was done and see if anyone
> thought SIOCGIFNAME_BY_NAPI_ID would be useful for them, as well.

I think you should be able to get this functionality via the netdev-genl 
API to get napi parameters. It returns ifindex as one of the parameters 
and you should able to get the name from ifindex.

$ ./cli.py --spec netdev.yaml --do napi-get --json='{"id": 593}'
{'id': 593, 'ifindex': 12, 'irq': 291, 'pid': 3727}

> 
>> I think even the per-device napi_defer_hard_irqs and gro_flush_timeout
>> should become per-napi parameters.
> 
> I agree.
> 
> I had been contemplating implementing this until I tried a different method
> similar to an academic paper I was reading [2][3]. I think per-device
> defer_hard_irqs and gro_flush_timeout would be extremely useful and a
> better approach than the one I'm currently using.
> 
> Is this something you are currently working? I may try implementing this,
> but didn't want to duplicate effort if you are already working on this.

Not yet. Please go ahead and work on it it if you have time.
napi-get and napi-set can be extended to show and set these parameters.

> 
> Thanks,
> Joe
> 
> [1]: https://lore.kernel.org/all/20240131180811.23566-1-jdamato@fastly.com/
> [2]: https://dl.acm.org/doi/pdf/10.1145/3626780
> [3]: https://gitlab.uwaterloo.ca/p5cai/netstack-exp/-/blob/master/kernel-polling-5.15.79-base.patch?ref_type=heads

