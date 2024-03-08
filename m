Return-Path: <linux-kernel+bounces-96479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCC6875CB7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 04:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CEE71F21E05
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 03:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB942C1BA;
	Fri,  8 Mar 2024 03:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YvjcdoD9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717782134A;
	Fri,  8 Mar 2024 03:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709868563; cv=fail; b=TmXkO+Szof+fpjclbzjXsd9vecu1GbFVyOeo3vW37iRxubXObfeu8Q29qSHYw6Mxto6c4Va9v464HW6fyYY+DR1+A/SSIXM+dMvddWAsR507y2TcOLLye6HQXwHT8X2HJvR4nHBg0i/Ijul1jz7/MEjTNX94MT7fbfik86vStuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709868563; c=relaxed/simple;
	bh=XOgc2KcSME/nT/ESALCyRcp2dYlmuqybCZt0PGeVacI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nJg4JfaaU40G+bhFZIVi1iP8Ygcw80ZQckkkUan7ymzCxeV3RpEKxEy0qPJUwDFn8M8BQPVYIAPwDmTGXjrR30yxUJXP1pbjcflY525fitr+r7lxuhVf30PrBRgx154+H89BhbBKN5wl+3ywCn+J53izjwtxL8JpcHHQFtMRY6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YvjcdoD9; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709868561; x=1741404561;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XOgc2KcSME/nT/ESALCyRcp2dYlmuqybCZt0PGeVacI=;
  b=YvjcdoD9ZbIIFaoUvGFuHynKnlpcvyJWEqiOKJqeztYF5/IWf+tmmnIc
   lNyJlDFxROu7L602U1ngxsM/K1pqj/jFsy+jBW9EyEn637jaYM0c4cmqu
   4ANzeiTcWTM4SvOde5HlQ9TcPEPpsCGyszVvYMsFPsFMKJ+KYfabFguCc
   zhxvZaRXspuLfqv6Jr4OSjlLFYWEp5wWqkMLOzZlGiR/Y9eUqDCHcx2vD
   smVNKaFn6Xxj+Bx3RlDkz48rrDOYG49SdWSyq0A0yb44aBZ/CuaiPOgV0
   XT9JiAq84OOwRCwa7mFwfY8DTPPuUqfXsB6O82hkXgfQbBWk0mX1VFBCJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="27047808"
X-IronPort-AV: E=Sophos;i="6.07,108,1708416000"; 
   d="scan'208";a="27047808"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 19:29:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,108,1708416000"; 
   d="scan'208";a="14920406"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Mar 2024 19:29:19 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Mar 2024 19:29:18 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 7 Mar 2024 19:29:18 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Mar 2024 19:29:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gf5ifLyGWmyS0lZhnFjU8owx+Ni0s/VsDj016fLKabt8ApzKTGII2HxB3E714DWqStVKgNclcLoWykVs1FLtFHP+PrdDPDqnaFX5VuptxCP1sC4mCZqCzaf9/IzEEQ1NnSfrMxnSTiKuOjMPAUS2bDT8NQ3bW2nE8O9/S/IqjaXB/B1FGniDMBk7fziolCuHxeb8JuC7rQWQbTmRmN9PYQ/PfECZ1jJoWujUX0ITjUSmi7AeNytVqGAR5PZwWPRsAMG3K0bMGn5ghCJH2AHPWF10UQORKQ8AuoXV0fDeMpjbhB/EegYM+4jdTmDV9NtJ89LxnjLCciuKTrJtlT5OFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wa7BEsFe4k5h4wzGNPjpxODOsDiCuKyUPIgXDWOLCw0=;
 b=bYIq/3KP4gFOLYgd7vURTsbaWxyhgTEkQzXZGE+Tj/Ivg8ITlL0Qwc6+WMRnkZliFLmMvx0/HZRb0HaN4aanSZs8+0qZ3CH7pDR5DsJBdJcArZ+c/ullKJ9aEgSlvnrW4vunzNOPPa+CeOvePZn3JribPdzMJNOZ7u7wR0r1Vxhzl1YkcwhBvHsgu8AOYrpCYskSzcXGLyTU6MNRSOgRkkvIWAtAT5JWcp0/jvO+igwa6gJbk4GcCCTQdd6GFsxQYM7Ni/vacbf8jH4B5D6Ex9LmdQF69G3IuiwWtHqKI06HrVFk5ntkQL7cvKhEzpDgcWHXDVZi8ecMEhajEarEKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA0PR11MB7258.namprd11.prod.outlook.com (2603:10b6:208:43d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 03:29:11 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a%5]) with mapi id 15.20.7362.019; Fri, 8 Mar 2024
 03:29:11 +0000
Message-ID: <d030d02d-150d-4337-a063-69da28049548@intel.com>
Date: Thu, 7 Mar 2024 19:29:08 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next v1 1/6] ethtool: add interface to read Tx
 hardware timestamping statistics
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>
CC: Saeed Mahameed <saeed@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Jonathan
 Corbet" <corbet@lwn.net>, Richard Cochran <richardcochran@gmail.com>, "Tariq
 Toukan" <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
	<hkallweit1@gmail.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"Ahmed Zaki" <ahmed.zaki@intel.com>, Alexander Lobakin
	<aleksander.lobakin@intel.com>, Hangbin Liu <liuhangbin@gmail.com>, "Paul
 Greenwalt" <paul.greenwalt@intel.com>, Justin Stitt <justinstitt@google.com>,
	Randy Dunlap <rdunlap@infradead.org>, Maxime Chevallier
	<maxime.chevallier@bootlin.com>, Kory Maincent <kory.maincent@bootlin.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Jiri Pirko <jiri@resnulli.us>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, "Dragos
 Tatulea" <dtatulea@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
References: <20240223192658.45893-1-rrameshbabu@nvidia.com>
 <20240223192658.45893-2-rrameshbabu@nvidia.com>
 <abbff26c-c626-42ce-82a9-4dc983372de3@intel.com> <875xyex10q.fsf@nvidia.com>
 <a84df9ec-475d-4ffc-a975-a0911a57901e@intel.com> <87il2evhtk.fsf@nvidia.com>
 <ec969f62-a1bb-4287-a4eb-083201134bae@intel.com> <87le6tvpq8.fsf@nvidia.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <87le6tvpq8.fsf@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0042.namprd04.prod.outlook.com
 (2603:10b6:303:6a::17) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA0PR11MB7258:EE_
X-MS-Office365-Filtering-Correlation-Id: 5925c01c-82bd-4bcd-ebe1-08dc3f1feb9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uF9/K8uhTrY2/DnsRRnkCP76U4QjzoJz3HiwJff5sHGfB5ePFXd1bq9mp7FSrdHZUdGy+Crcoi6AZmLugQMt9L1fN15BatJIadaVzboGxEi+KL/9ZnrCD6+OhVpLPLoCtgxMh/5xGKFRrswvj8yQvT7xFeQf2LO0XgDffDvDj0HJzeekgvkH44r+dt3nafTwpMmvkq6r5diUS7Q2c7JgUusQWWZzz83VyVDBqcSLOPHjaS8DL+rencoZAqk5014Pw+/63DMfzELxvDU3fjgDQVKsM+z7x7V7OtnOYbPEkPxitdetAn3O0zMltaV0dZxRCzfV4CP2F93hs9nhGKebg8I43LUSK6YnR8Rm3qeTthqMKz90guQXqYlPzK6Qq+woNMQW+drXLjI9hUwXh8g5VTZlAhjw9UBJftE+zbAqRJMKbPchLYhq5EbGvg9MkXhoVguyxVb6gcwQW8sBE/1Whj1OS6ynO9lkCuTuW8uzFbAVAhE9D/vbJGumS6GqeWeIF56oNh7QKtwPan9gNQJ4r/J+KxaN60xlCI42TvROFfHmPyzl2TzHu2q01LAGv81eUTyGBI8OSCpw1F8pue2uRXdHHyIGZhYxgfolpPwRgUw6ePHIf7GV2vFJQNkfqCOqY/dJNlX/hgl+ieBR6YTLRZ6RsX1ZcRuzXb0NPXRvpgs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzVCZ2VSVTFvb3VWYzZXSGhxL1dGVFZJNGZwdUovQkc2bUlnNXpLU21kRjNX?=
 =?utf-8?B?bjdpWC9tVUJHSjdXZ29sODhMSkFVb0xOUU95U1E1OEViVldCQTBZTHROL042?=
 =?utf-8?B?WmxmdTF0MFhON2lzZ0M2ajlNMHNNTjdVa29DR2huN25ENEV1U1I4dWs2Vi9h?=
 =?utf-8?B?SVNWK2xXU0kwek5QU3A2WkZrazNnMEtTRnZIcnhSTGxYSGQ4L2E5VEkzSXNi?=
 =?utf-8?B?NlgyY3NuZzdZLy9VZmRMSS9JSGQzcnoxbFp2QUVuRno5V0pBaU5tZ3FCdTEw?=
 =?utf-8?B?RTMyY2dpeFR6NGNGL3h2cWJRMTlIa25GMHhUckRRa1kwWWhtNzRvcFNWb2xP?=
 =?utf-8?B?ZHZORmVqaWdwUkR3MHpXT1hERTVZSUdJNHk2Qzh6NDA3Yk9EMEFGMDJidE9w?=
 =?utf-8?B?cG00Q3N5Zy9qTU5EUHNNV2JVYlNxU3grVVNMZWtrRStBcEdIbFFOZ3oxYktL?=
 =?utf-8?B?NzNVY0FXV2lCdVV6WWlKRk5ySEcyaUpuMDNSSU1FdjlQUVBHUm03c09IMWRM?=
 =?utf-8?B?Q3hZUlFzWFppZFE2RXFHV09XTjh0dXRzZWgzQ3QxV1ppVUZ0bG41VW93VHZu?=
 =?utf-8?B?OHJYQm1MNDdmdHVKb0NiT3lPekcyQURteURuWktKUFVSRjM0NlMrSVk1bDBD?=
 =?utf-8?B?L3AyMU45ekt6Z0U1Vnc5QndUWDlWLy9iK21KR0ZHdEsxby9KN2JOZldPKy9C?=
 =?utf-8?B?cE5PQ3Q2RTJRVnpqd1BrMmRyeVlPRXhSaVpQelZFb0NjK3VNSHdEUnJ1Rzlo?=
 =?utf-8?B?T3VraG5FeWJCbHA1Zmw1YmtkT0dQZEdpQXdHSlZoMno4UGJMcENQdVA2L1RR?=
 =?utf-8?B?WnFDdDB1bHd5T3BHQzNmMldseUUzcFh1dzc3MUJXdTN6cEVINHc2Z2IwelJl?=
 =?utf-8?B?WnR1VnpQN0VEVVpteWcrNmhSYXVvU3JLM3NFcnhpR0Y4enMzQnB5RS9XWito?=
 =?utf-8?B?WXNKNzluNlVFUlFFaDZxcW1YWTVlVzVXa01Nb0J6ajJzOWFjTzlDWEdFVm9H?=
 =?utf-8?B?emxWWnNPcU1LLzM1Z2NmN0d0Q0JYdzJ4Sm1nUUVyMldHazJqRHhDektJUzdI?=
 =?utf-8?B?V3NxWXREWHMzVUZKd0Rjb093ZldlWUhwZXdweTBDaHpNSXFZalRJRVdVSWht?=
 =?utf-8?B?VFl3K2dqZDc0OUo2T2Y3OVJoTmRoQ1NwVTdXS2JLSnpRRzJrMjZla1VDSWp3?=
 =?utf-8?B?TWUvU3dWNVQzS0M4eHNIQm5nWlJwWTA1MUxBK1ZFcjhMUElRWSs5c3VOSGRw?=
 =?utf-8?B?c3QyOTFkMURWckZsbUpjNDRpckVLdkRNRmtBMmM0WkdheXpnY0dTL0RoOERW?=
 =?utf-8?B?TEpleXJFbkh4MzdIeFZjUTNoQ2YzeUcyd3dnUHJJZ2RIU05ORWdqMUdXVTBO?=
 =?utf-8?B?UEZ1eXZlMXdQcnRXVlVoelVUWW5lSFRyK2J3V2dkM2JONk9ndGc2c0p5Z3U5?=
 =?utf-8?B?SzhMU1kvaXZLbkpSTTFVUnN0RG1UVGRGTGdpM2cvRG5QMmwyblIwdG55VW91?=
 =?utf-8?B?dHkvb2tFL0o4Yldhc0FaTVpMUjRDZjdqR1BvbnBpLzd2bEI5RkxjdkE0alZT?=
 =?utf-8?B?eDhyM1RkRHI1VDFYeEZOUXhsTnZ3d1lqdCs3WXdKRFJOS2IwNlBwUjlQc2VE?=
 =?utf-8?B?ekNUNVF2Nk5mTzJ0OW81ZmJyVmNSVTM3ODdZZXRsZ1NnYXhBNUdhUEpiL2RF?=
 =?utf-8?B?K0g5NkV1SGJXbHRzUHVVaE45WW81QndrU1p5QUZMSFBBRGs1ZlgvWTIyQXhT?=
 =?utf-8?B?aUFTSS9hT05vYUwrRGdqaHVVbHJzUTM1RTh5SG9UTTFWcUN4SysvVnJxNTFj?=
 =?utf-8?B?Zm5wYTBKWWQ4TzF3elNvM0NpeEFub0RYUi94VmNTcGJvNWpvK3FaY2g0NStK?=
 =?utf-8?B?dnlmMi9sNmhJOEFVS1RrRGpsbWdzZHRiTDhJc0FLRElWYldrdWtqZnpIdGJQ?=
 =?utf-8?B?eXhxdmRXOVplci96K0gwUEdTOEQrUDYzSUd2UHZJcStGd1l5VmdFakJsaG5Y?=
 =?utf-8?B?STdTQk9FVE1Yem5rTlJvaTNod0NGNUwwMVBTV3JCc1pWWmtBMDVkbU9VSWcw?=
 =?utf-8?B?eXo2VFZpckt3WTVhSzY2TmJ6bTUwYlpEUnl3M3NwNjVEN2k0UDM0aU5QNDJE?=
 =?utf-8?B?SnFLeXdSV2FaSlE3cXVmazRkYjBFcmlxMUlnV2xLazIydVZBQmk4Y0wzSVRk?=
 =?utf-8?B?K2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5925c01c-82bd-4bcd-ebe1-08dc3f1feb9c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 03:29:11.0384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k/4uVmhblBOIuHjKQS3un7dHfLH3sc3ml3vUIb7liM17QzxG1zLO/dsUJfTCqxHQODs0Vi8OzFHJCF3z2b4kb4efgrhgZOCWxhL22UXFjLw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7258
X-OriginatorOrg: intel.com



On 3/7/2024 10:47 AM, Rahul Rameshbabu wrote:
> Hi Jacob,
> 
> On Mon, 26 Feb, 2024 11:54:49 -0800 Jacob Keller <jacob.e.keller@intel.com> wrote:
>> On 2/23/2024 3:43 PM, Rahul Rameshbabu wrote:
>>>
>>> On Fri, 23 Feb, 2024 14:48:51 -0800 Jacob Keller <jacob.e.keller@intel.com>
>>> wrote:
>>>> On 2/23/2024 2:21 PM, Rahul Rameshbabu wrote:
>>>>> Do you have any example of a case of skipping timestamp information that
>>>>> is not related to lack of delivery over time? I am wondering if this
>>>>> case is more like a hardware error or not. Or is it more like something
>>>>> along the lines of being busy/would impact line rate of timestamp
>>>>> information must be recorded?
>>>>>
>>>>
>>>> The main example for skipped is the event where all our slots are full
>>>> at point of timestamp request.
>>>
>>> This is what I was guessing as the main (if not only reason). For this
>>> specific reason, I think a general "busy" stats counter makes sense.
>>> mlx5 does not need this counter, but I can see a lot of other hw
>>> implementations needing this. (The skipped counter name obviously should
>>> be left only in the ice driver. Just felt "busy" was easy to understand
>>> for generalized counters.)
>>
>> Yea, I don't expect this would be required for all hardware but it seems
>> like a common approach if you have limited slots for Tx timestamps
>> available.
>>
> Sorry to bump this thread once more, but I had a question regarding the
> Intel driver in regards to this. Instead of having a busy case when all
> the slots are full, would it make sense to stop the netdev queues in
> this case, we actually do this in mlx5 (though keep in mind that we have
> a dedicated queue just for port/phy timestamping that we start/stop).
> 
> Maybe in your case, you can have a mix of HW timestamping and non-HW
> timestamping in the same queue, which is why you have a busy case?
> 

We don't use a dedicated queue. The issue isn't queue capacity so much
as it is the number of slots in the PHY for where it can save the
timestamp data.

In practice the most common application (ptp4l) synchronously waits for
timestamps, and only has one outstanding at a time. Likely due to
limitations with original hardware that only supported one outstanding
Tx timestamp.

> Wanted to inquire about this before sending out a RFC v2.

That's actually an interesting approach to change to a dedicated queue
which we could lock and start/stop it when the indexes are full. How
does that interact with the stack UDP and Ethernet stacks? Presumably
when you go to transmit, you'd need to pick a queue and if its stopped
you'd have to drop or tell the stack?

I think I remember someone experimenting with returning NETDEV_TX_BUSY
when the slots were full, but in practice this caused a lot of issues.
None of the other devices we have with only a single slot (one set of
registers, ixgbe, i40e, igb, e1000) did that either.

If this queue model behaves in a sane way (or if we can communicate
something similar by reporting back up the stack without needing a
dedicated queue?) that could be better than the current situation.


>>>
>>> The reason why I prefer busy is that "skip" to me makes me think someone
>>> used SIOCSHWTSTAMP to filter which packets get timestamped which is very
>>> different from something like lack of resource availability.
>>>
>>
>> Busy is fine with me.
>>
> 
> --
> Thanks,
> 
> Rahul Rameshbabu

