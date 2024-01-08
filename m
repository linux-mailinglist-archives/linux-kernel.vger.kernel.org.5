Return-Path: <linux-kernel+bounces-19815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 870778274A0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 17:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 104DB1F234FD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF97524C8;
	Mon,  8 Jan 2024 16:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FCIaXYOR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC94524A8;
	Mon,  8 Jan 2024 16:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704729869; x=1736265869;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xd6o43AwuD2WheFOXOv/eGi66IGhiL2oq28GRslw72A=;
  b=FCIaXYORhTbQKcx2DNPU1BfFyvphBnKQcccU5axg+f9dHLBWLvy956lZ
   llWApE/cRfKbcfsViwHdFVNFfrSDhN1YSoMN1MefI6jr69yeTFlQCjeRz
   +YUd/MecTbCEK4nHYRqXuIRzbaKiCRYGmqPVx2tXZ6HWHzb3JWEeyJzOd
   XNCzLIvkKDBdu98zWNGPG+y6Adhg1VH/X/BadZorytoya2Ij8OWYORUt1
   D3C3ERO7vHWWcYdp7IRA012oovIYMsipnwJRb1iYLEE3l96TzplpiOdNE
   cwVcUuiiim25x8gOhAoO/ioIsVBBSMwXb9tbVYeu0u1vMFDsbyLlvr3r2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="388370536"
X-IronPort-AV: E=Sophos;i="6.04,180,1695711600"; 
   d="scan'208";a="388370536"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 08:04:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="784894803"
X-IronPort-AV: E=Sophos;i="6.04,180,1695711600"; 
   d="scan'208";a="784894803"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jan 2024 08:04:25 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Jan 2024 08:04:24 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Jan 2024 08:04:24 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Jan 2024 08:04:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BvJKJrI9H/RIW9uJM01QbRkGkNqU0v650hLvjKgBLE3NdBhs70uJa+DR5iNGxVqGkZ94N5M3ZAZ1zyBgZhqkLG1bZW2SBpd+AQCWAmHK+ZTZ31Y9W64gNgCrdDLbPMfH2nUj6V/T4UBXjwDtntrvvRXYRpFSXURBEZD5727yt740qxT0qYfeg+bqG0bHfWiuTmBDUhE6OfsQbWUOcxr898gUdYIXzdItistNxBQSlnil6jeS05xwrTRUq7jJg4QgQGPnYjQTltkdlBMQVEGOjjcWFOMjpNOCiKQppplSUXnoUXvb0CU76NYJE5/eqB+vrD2CBID5XYbt9y3S4pLZUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ciOwa4a9MTDP1044neyYnEzSy9BSXnJbZZxrY2fmU8=;
 b=QXMrPCZOuQ24nJN6MtdX9sMtfGfrEu1/GX9uFue/8iQa0HHwuA2MR65AfMzDtWU7Wq5px1B++ONgnZX4EWxWjBcJb5LCxbUYUu50yirfl93S80IURTdC5OXDrLcZEOxJa7yoKxevKxU9TjiKBDHuk7cfY/LByJ8Y0hyIm9Vcz2nkyfw4vwQd3cPwot8g+gBPIRdyI3St+A0HP20+l1rwGNnGl2tQJWUXY2iT6al4hb+KZv9/i/NKTZiO7POLjyLM8fMrWwmJWQRwz4mK+eP1emhWPLv4lsVMN8GuoqwTk8O4sNy9x5GloeA/WLn8IQYa8Q5wHXhIo64nPku4uJDCjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SA1PR11MB8594.namprd11.prod.outlook.com (2603:10b6:806:3b1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 16:04:22 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::8760:b5ec:92af:7769]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::8760:b5ec:92af:7769%6]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 16:04:22 +0000
Message-ID: <9e8e8b47-24ab-4947-8f22-f2a07c2549ca@intel.com>
Date: Mon, 8 Jan 2024 17:04:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next 01/34] idpf: reuse libie's definitions of
 parsed ptype structures
Content-Language: en-US
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Michal Kubiak <michal.kubiak@intel.com>, Larysa Zaremba
	<larysa.zaremba@intel.com>, Alexei Starovoitov <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20231223025554.2316836-1-aleksander.lobakin@intel.com>
 <20231223025554.2316836-2-aleksander.lobakin@intel.com>
 <658c46269aa52_a33e629442@willemb.c.googlers.com.notmuch>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <658c46269aa52_a33e629442@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0502CA0005.eurprd05.prod.outlook.com
 (2603:10a6:803:1::18) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SA1PR11MB8594:EE_
X-MS-Office365-Filtering-Correlation-Id: e43381b8-c76a-4dc9-c61c-08dc10637aaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XCbZLDOqm0lZWhdgsagecz4qlMdLxQIWMEzyCpon6HbHQ/gQXzfnWfRPMnuEgIzhFgebZfaSzESsp57fwrREej5QP3+/rsAzLC4dJwfdt6BNnNPOY6FwJjqJhiCtN0AVhpO0EE69hQ9fZ0vlGNFVJvUDjnsxYEau3/aKeMmFkJdCr4PBDjz6kE2lDk1QDq+Vh67e8QW9auIsPgqWsTlaGuvGkegVM6UyWK6kh1eMIE1W9TjVdmx6L5eaclYlFLVwi9HfGyy8VZaj8FaA9GMuzEesUbq8Mo2hDJaTBQsX/tuTaBWh6MeEFpaEV20sxu5HNs4IM4s1AHSAU2k8cEK9ShejSXJHl3PWhH2x7C/7KElxiw1KFToLaFlVHxz0kyCEwQTr2anq7Dz2Tp+5yBbyHOlHIUezSpoGiYX1mbHldLjEPCA+zYWIPOJUVcS57Vtamte8nfs5ZWfwmlkX99BTSooi9Ac/hhqORDXleCkqNWHbi1v9yFPsbBAYPlDzl0zG8Mb/n58MGKyeSkD6uIdTjEVPWOVKAr9tyf2tJPSsbRQASHg80gBsrBnCLk+TCXukwA3CBh+frg06lBGcmDDDATWRiKOJ4KkFilYu9X2ucTiD4JZv9wTkaDjdMJSL++INx+sI9COUhTfGnrFdlXrITQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(136003)(346002)(376002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(7416002)(2906002)(6486002)(2616005)(26005)(66556008)(66946007)(66476007)(41300700001)(31686004)(86362001)(31696002)(36756003)(82960400001)(5660300002)(316002)(4326008)(54906003)(83380400001)(6666004)(6506007)(6512007)(478600001)(6916009)(8936002)(38100700002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXBTd2RKYnp6aWZSWEpjSHVHSVlMTjk5TXlJQW5TMEtZbGVDQjQzdXVaTjZs?=
 =?utf-8?B?MWdRNFNXTTB2S0lnSjI4YzFtRFVyM0phd3Y0QUVhbzY2MGl6c01ML1paUWdY?=
 =?utf-8?B?ZG9SZXBYeXZEZ1dSRzNmMDUxYWFQaDVXMW56SVFwa2E0ZlpXYnRINFlvYjQy?=
 =?utf-8?B?VzlXS3VGaWEyTmhiVnZyd3dIZGF5VkprSVh5ZEZQUVVaOFJQODA2V2g4THJk?=
 =?utf-8?B?TFhFN3Q2U0RrWEliNDY3UDFYOTVNT2lvYXg3UTFUbG8wblYvSXdZd01vOVZW?=
 =?utf-8?B?YTdFWGFEQmF6SkEzeW1OK2lnNnprVDBRYU4wMlVaSGVpS2Q4TklQRXdibU1N?=
 =?utf-8?B?Qkp1M1crMDhzOFZ3Uy9vcU9BL1Z3Y0JqMHNlZm5tN2Y0RDNYNVI1ZU9CQXJ0?=
 =?utf-8?B?WGIxc3grTGFIbDZSRHF3SFBPNmZHdE1HMlNRSC9WQkc3dkxlR09KWlY5N2s3?=
 =?utf-8?B?VzNCelpQN1NEbkpTODE4V3p4NUNIM2dXOE9BemZTaGY3Z3Q3emx0eTd4bGlo?=
 =?utf-8?B?MVZVOUhrTnZJVUhoRlpxSnFNSTJjaGRUMkJieFJ0aGk2VFBZVm92RlpkeWti?=
 =?utf-8?B?TncrOWpzc3o3TGRkTkt5MnZZRXcxMXFRYWhQL3VmMnRGOHVvQ1dkTldCMVJH?=
 =?utf-8?B?a3lMK1FnT2FRM1N1MzhrVFlVbm03a3ZuRW1qRHVkQlUrOHRzTEtueTdNanQz?=
 =?utf-8?B?NTFsVWczcnpmNEVDYlN0ck5SaGdxbzNmN2tsM2s1WlNFcGlOMzRvcWo3ZHpY?=
 =?utf-8?B?MVltMnJqa1ppT3FHTWJjRUxOdXovdlh5dE5Xb1kzM3A5aGxkaTFINkppdklh?=
 =?utf-8?B?bm5yZ2E2UjY3cmgzZTU3VWRwTDZkQ1p4QnlRNitpVk9pTEVNRXU3KzQweTYw?=
 =?utf-8?B?RkN5a0oyS1cyVnNCV1FDNkxJSE1uQWtvOEkzVnczNEgxUDUySDRhWEN3K0pj?=
 =?utf-8?B?RTNWL1Y5akk5TG44b0lXQXJCbVNKeVBBSklQQitTM1JMYWFoaFdqeHhQWXUw?=
 =?utf-8?B?bU13WUxZWVFxVGx2RG5EcDJyN256clY4TlZvNlI1cHJCbjlXQkY3dm5WdTBq?=
 =?utf-8?B?OHhma0NnRE5XUDZMTlZWZml3TlBPZ1ZTZzFYQlE0bDUyOWFwOEM2Nk9nZk9Q?=
 =?utf-8?B?VHdScTh2blFhaDRCcHRRS01KeE54YlAwbGRWUjJudmtVdFZZMVZ4bzg0SUxv?=
 =?utf-8?B?dE04ZHZHZHlzamF5aGpMcjN1alZ3bFZESWZXM1dpb3JwaWduN09sTVlqNk40?=
 =?utf-8?B?STd4bVA3b2dyMFZsVXdPU001TFF5Q0x1TnVrMXYrTXVrb3M2L3ZiTFVjaVhG?=
 =?utf-8?B?YlpNc1lycUJxa1hWclk4UmpmYmU2eVZtRnlVcVlVSTJ2N0tTZmVHY2F4Szkv?=
 =?utf-8?B?NytxWDRYbWhRT3l4QW82WW9hZktRdkJhcjdGMmp1V1EwT0xQYk5wUFJIYWo1?=
 =?utf-8?B?d1FUMnhXK2drUkxXanlSWU9ORzNOL1ZxUmZXL1hJQ2FodTRJRTNKZ2cwdXBQ?=
 =?utf-8?B?SXlhTjRVT2k2V05xYmxSRHJYcXBBa2F6Q051TlFSaHhLanprWDdwSlVEaXdT?=
 =?utf-8?B?YzlMRnM5UzNyM0htZnA2V1VLREsvanNhT0xZVEczVjloSVhZbWQzMkdsUjhT?=
 =?utf-8?B?THZ6cEg5S2ZQQTM5VnZBclZyWnZXck5wQXZkL21vZHE2ZWN5M1Erdyt2Y1Jp?=
 =?utf-8?B?WVRzVW5Oczd6R3dZSEo3d3phakFWVkRxYy9RMmVtcUprb0YwSjhLUFJETS9C?=
 =?utf-8?B?b0lnQ0tvREc3S2JjOVRRZndiaE9oQlVTNnZqM3U5N056WVZsT1cvVkxmODNn?=
 =?utf-8?B?T0VEUWZlamtFd24zbDNCS2NDV280Y3hnZkdUK2xMUHZDWmVvTUh5MERXR1Jr?=
 =?utf-8?B?djRITXJCOGkweUxPYmRWbHpjY0cxbXdobEZyRFJzV09ZbXFBMVFPYTUyTDdH?=
 =?utf-8?B?V2lVaUcvcTVkYWRaejF5aThqd3BNV3d0STFZcEJDbGNtTS91anFVVVByUnZ3?=
 =?utf-8?B?ZngyTlhOMnRKeTFENEh1YUs4L3NTVndIaGgxN3lMdWRYa2NVMmZyclcwY0s4?=
 =?utf-8?B?U245SCt3M0E2blYvZk5KanFXdlVZSmtMM056OG1HSUFXUWFtS2YxamI5Qmdi?=
 =?utf-8?B?NzJjdnBwWHVMTHRPaFBuaXRTa3REZVpZcHRTei9yS3ljZThTRUdpR3NhQmRn?=
 =?utf-8?B?VEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e43381b8-c76a-4dc9-c61c-08dc10637aaa
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 16:04:22.7161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nTBXT1eoRtpObhRvtbogYt2ctG/Ywy/QYmEIcr9RX7gSIr76vWvTy4btH4dACS2lJXqVRYGgSIVQOxYosS4zHAbcP65GuNIsm0I9zh/bFB4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8594
X-OriginatorOrg: intel.com

From: Willem De Bruijn <willemdebruijn.kernel@gmail.com>
Date: Wed, 27 Dec 2023 10:43:34 -0500

> Alexander Lobakin wrote:
>> idpf's in-kernel parsed ptype structure is almost identical to the one
>> used in the previous Intel drivers, which means it can be converted to
>> use libie's definitions and even helpers. The only difference is that
>> it doesn't use a constant table, rather than one obtained from the
>> device.

[...]

>>  static void idpf_rx_singleq_csum(struct idpf_queue *rxq, struct sk_buff *skb,
>> -				 struct idpf_rx_csum_decoded *csum_bits,
>> -				 u16 ptype)
>> +				 struct idpf_rx_csum_decoded csum_bits,
>> +				 struct libie_rx_ptype_parsed parsed)
>>  {
>> -	struct idpf_rx_ptype_decoded decoded;
>>  	bool ipv4, ipv6;
>>  
>>  	/* check if Rx checksum is enabled */
>> -	if (unlikely(!(rxq->vport->netdev->features & NETIF_F_RXCSUM)))
>> +	if (!libie_has_rx_checksum(rxq->vport->netdev, parsed))
>>  		return;
>>  
>>  	/* check if HW has decoded the packet and checksum */
>> -	if (unlikely(!(csum_bits->l3l4p)))
>> +	if (unlikely(!csum_bits.l3l4p))
>>  		return;
>>  
>> -	decoded = rxq->vport->rx_ptype_lkup[ptype];
>> -	if (unlikely(!(decoded.known && decoded.outer_ip)))
>> +	if (unlikely(parsed.outer_ip == LIBIE_RX_PTYPE_OUTER_L2))
>>  		return;
>>  
>> -	ipv4 = IDPF_RX_PTYPE_TO_IPV(&decoded, IDPF_RX_PTYPE_OUTER_IPV4);
>> -	ipv6 = IDPF_RX_PTYPE_TO_IPV(&decoded, IDPF_RX_PTYPE_OUTER_IPV6);
>> +	ipv4 = parsed.outer_ip == LIBIE_RX_PTYPE_OUTER_IPV4;
>> +	ipv6 = parsed.outer_ip == LIBIE_RX_PTYPE_OUTER_IPV6;
>>  
>>  	/* Check if there were any checksum errors */
>> -	if (unlikely(ipv4 && (csum_bits->ipe || csum_bits->eipe)))
>> +	if (unlikely(ipv4 && (csum_bits.ipe || csum_bits.eipe)))
>>  		goto checksum_fail;
>>  
>>  	/* Device could not do any checksum offload for certain extension
>>  	 * headers as indicated by setting IPV6EXADD bit
>>  	 */
>> -	if (unlikely(ipv6 && csum_bits->ipv6exadd))
>> +	if (unlikely(ipv6 && csum_bits.ipv6exadd))
>>  		return;
>>  
>>  	/* check for L4 errors and handle packets that were not able to be
>>  	 * checksummed due to arrival speed
>>  	 */
>> -	if (unlikely(csum_bits->l4e))
>> +	if (unlikely(csum_bits.l4e))
>>  		goto checksum_fail;
>>  
>> -	if (unlikely(csum_bits->nat && csum_bits->eudpe))
>> +	if (unlikely(csum_bits.nat && csum_bits.eudpe))
>>  		goto checksum_fail;
>>  
>>  	/* Handle packets that were not able to be checksummed due to arrival
>>  	 * speed, in this case the stack can compute the csum.
>>  	 */
>> -	if (unlikely(csum_bits->pprs))
>> +	if (unlikely(csum_bits.pprs))
>>  		return;
>>  
>>  	/* If there is an outer header present that might contain a checksum
>>  	 * we need to bump the checksum level by 1 to reflect the fact that
>>  	 * we are indicating we validated the inner checksum.
>>  	 */
>> -	if (decoded.tunnel_type >= IDPF_RX_PTYPE_TUNNEL_IP_GRENAT)
>> +	if (parsed.tunnel_type >= LIBIE_RX_PTYPE_TUNNEL_IP_GRENAT)
>>  		skb->csum_level = 1;
>>  
>> -	/* Only report checksum unnecessary for ICMP, TCP, UDP, or SCTP */
>> -	switch (decoded.inner_prot) {
>> -	case IDPF_RX_PTYPE_INNER_PROT_ICMP:
>> -	case IDPF_RX_PTYPE_INNER_PROT_TCP:
>> -	case IDPF_RX_PTYPE_INNER_PROT_UDP:
>> -	case IDPF_RX_PTYPE_INNER_PROT_SCTP:
>> -		skb->ip_summed = CHECKSUM_UNNECESSARY;
>> -		return;
>> -	default:
>> -		return;
>> -	}
>> +	skb->ip_summed = CHECKSUM_UNNECESSARY;
>> +	return;
> 
> Is it intentional to change from CHECKSUM_NONE to CHECKSUM_UNNECESSARY
> in the default case?

The basic logic wasn't changed. libie_has_rx_checksum() checks if the
protocol can be checksummed by HW at the beginning of the function
instead of the end (why calculate and check all this if the proto is not
supported?).

> 
> I suppose so, as idpf_rx_csum (the splitq equivalent) does the same
> (bar CHECKSUM_COMPLETE depending on descriptor bit).

Thanks,
Olek

