Return-Path: <linux-kernel+bounces-31461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1CD832E9F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 19:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C702C1F25E02
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 18:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2675644A;
	Fri, 19 Jan 2024 18:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ry2cEYrq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A621E525;
	Fri, 19 Jan 2024 18:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705687548; cv=fail; b=MUaufDNabaY3WH6W3S9/JscLNH4mMYTLS4A5+ntMPhu1KqQYM1aNrcHutpozmrRYG2PNDurA1E/rvXn0t6TrGBGwzUWYrXPnSRQtKSwF4Peb8mSyZ/k82+40Bko99nwesUbcSEVctBo9O3ijiKp5jjx+qb7WgHypYSAjAhRLs5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705687548; c=relaxed/simple;
	bh=VeXsu937QBBV+AxMcCuYB+DXdV6Gqm6H+acbjMbTHjU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=P4HFft/Vm9EVbPjqsQPhfnVlU1By5/ZwYqrTiG9U6y7EKRCbTXpDTCybkKmmsw5yP1R9iBKhPRHNnIpBDwN2bkwybmqwLK7QATJvjWBbTutlq5wUIi00yUunZmmWQIOQGukepQthZr4xLviexytW1Jl7YMv27LQOEzRt6Q4FpgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ry2cEYrq; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705687547; x=1737223547;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VeXsu937QBBV+AxMcCuYB+DXdV6Gqm6H+acbjMbTHjU=;
  b=Ry2cEYrqIMG7dzzH4h+lfwtYDuO+avy5gJgvMYI7l7/ikYQBTwdswKUW
   S7Zrv3y/HGClYh1WOmpnwIjCLFT3HUkQI6neh4zJ1ejowZ6FM0uwdxe5A
   4KqZvR8Us00MmPFI7C8LD4weH5N++GcgJuIj/P51GuM8KcF6CHlDDa/mU
   AVW7eMwCiltEevqwjBFd84I7Xm53VejdpnwFK7FutYj6xeKK+4+XgGXIF
   xSjpLwivQbgiTwF0FyvDTHim3+50M/GgmSUMyXRgdtXxgq7uh11Zq//CR
   BX92LfxAbmtM4CQDd1z7TPq/oKiCKsfz2Ez7bUXGxu9LOqbynEj2OtTgj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="8202305"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="8202305"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 10:05:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="33453704"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Jan 2024 10:05:45 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 19 Jan 2024 10:05:44 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 19 Jan 2024 10:05:43 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 19 Jan 2024 10:05:43 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 19 Jan 2024 10:05:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y/WgsRj4WlM0evWLgj+W+RThAwZ1jQaRZLR2XkzQmMfmSdKL7hWW7/fxqjbPBbEbo3RH7B6I5eWB0gmOsRQ5HNQx8pdAXmkOJdHVhxtKCw5wAEFKlbqvylaRTThGoW7lw8qz2OUBOKqojJ/FOUGVu2dOVf4gQLLFoTNJ8NjTprt6ykqty3BtwoAbEVSN0MRaJNelJz3clk+1p8dP0JJonOeXaFLEcpGUQS/iyccXLrjkCSmDECvxh5KyNfgGaeu5H/OxfJbFWPXND5gTIfMb0LTbrq6tX8R7DSCCWC9uo399ewkzVgWVcOIbNL8xGOcvUy8AA4d98yDyDdkjpJnETQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CoZFBO8SjdO3g1raqBpu7DTa9npil3ECxXGUKIMISZA=;
 b=bEGsk8kuqD4LR4KTps6SWqMuEPuC4M3S7jYDAAzIDXNjzzcWinTgDw5B5BXRJ28kSR96yZYdd1nZ8JKErOib47wdEq+f6hFl3zjeA1VZI66znwWJ8bHSvIueFdd3ET9NFum0wpweVNEA09JZpvSKz8nT/RAFCb9d8isR8dW9ZxOgpDUgTK6utLR2qoAyIqmjiQ9dU+lue0qw+QtUG/wACzh4M0MKFS5qyf96deSULvQMMHp0rJurVTddRyA/sLTTtspbCDhKNnvGC4qfLojyJoD5/iUGU1bSMskddp05/c4dyGeKclbu1uHzePuRPsNpxKgbD/QWiBX8zTA6qqjp5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by PH0PR11MB4854.namprd11.prod.outlook.com (2603:10b6:510:35::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.26; Fri, 19 Jan
 2024 18:05:41 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::780:d536:ff24:3e4c]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::780:d536:ff24:3e4c%3]) with mapi id 15.20.7202.024; Fri, 19 Jan 2024
 18:05:41 +0000
Message-ID: <da4f6145-9279-4501-98d3-b8ab1bc53f19@intel.com>
Date: Fri, 19 Jan 2024 11:05:37 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH v2 1/3] cxl/pci: Rename DOE mailbox handle to doe_mb
To: Robert Richter <rrichter@amd.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Davidlohr Bueso
	<dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
References: <20240108114833.241710-1-rrichter@amd.com>
 <20240108114833.241710-2-rrichter@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240108114833.241710-2-rrichter@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0203.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::28) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|PH0PR11MB4854:EE_
X-MS-Office365-Filtering-Correlation-Id: 471e2ad9-6d88-4dc4-6a4a-08dc19193f85
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1rqrnG53Dv1SelVallUFnGkSG2W8XQY1+bGElhZxMC8gMFdDh8a6s1n3LSvA3M2BHgm6Lrdp6Ab/PLzSKtYvbZh1nhth8MFDQVvZIOc7oaHqFmuDnjbWFSjEj3KNNOjAHmCCA0u7OLLjMed5WcemMIv7/HsBP2jmpEgVGqqXGh0nQv0uDzKHeUU+ugDErsIXQBF4IwBNEbPedbxIrVRdA7wat4YLc0PkqHea1pklRthASekvgud36Pw1IJNk+YXEi5cQO5j86fQoJxPQ8IUZhshWAlaO7IHrCjnq0Kh89IRnqsquodoqz8VI3GYJAuVwgb07IdZyHt6wpKAvzmXPkmv067UOz8PTO9//y/T3ZkZUAT0Pz8o4p2Ss/tdgSqW24uGAIzGYJbQqITq4t72XExw+QM9GfRpUPJLV7rZZDmvlJM93R7dJLvlawJgf42zZAHjwAOPlptpcjaCh65W4YE3+ebd1w9qP9LVxlWgbxORp9+IpMLRZYeb4cNMNBKIPHdYSbi847CQSXE1s4Lc+YLJawRScPargnB217F9gMk/XM5NlVDKn3L+HgtevWAN9xd/Es6tqOr62zbeyiZv+IuXeWEsKcqCQgj5SfJp7Hyqd3WtVHpsuTJWXU9xgONNq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(376002)(366004)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(38100700002)(478600001)(2906002)(36756003)(31696002)(86362001)(41300700001)(82960400001)(110136005)(316002)(66476007)(66946007)(54906003)(66556008)(6506007)(6512007)(6666004)(53546011)(6486002)(8936002)(8676002)(4326008)(15650500001)(5660300002)(83380400001)(2616005)(26005)(44832011)(31686004)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTlLOFBRblhBdUd4MHhENTBsOHl4eGVwRTRXZTgrN2JsTStVYzJURnNNSUdu?=
 =?utf-8?B?ek1lelpoUkxiRHU5aGZoUDJ5SzZkWlpjdWF1K2pmci9scm9hU0pUMXo1anZu?=
 =?utf-8?B?QUFxZndBNlRuckQvOTJLNzZFcFVocFFzdVdGSy9jNmFxbEJVZzBCRGtLUlZK?=
 =?utf-8?B?a2JGNy82cUZ4TGdmNFZVZ29HVmpCSEVQbFpiQTBLT3pWWnQzdDFacmw1N3pl?=
 =?utf-8?B?cVE4dnRsWXBZSTdscnA1M2hnOEZaYSsrdzF5T2ExNW11UUloTFpteXlrdCtT?=
 =?utf-8?B?NWszVUZoeHNjQ1pKNFNJZFh5ZWNXNVMzakVWQjZSazRWeTZwM3VrMzF2K2Zj?=
 =?utf-8?B?K3lCNGZicUREMGg1cHNaRG5mSHFUakcvSjJ2OW5BY0NtZVF2dkNPNjZUb2c2?=
 =?utf-8?B?M0w5N3BHVUNHL3kxMWtMdTBZZHhyK2V0SGtza2NwVVR3R2pQemFqeDRvd2N4?=
 =?utf-8?B?MURuYW52eE5DQUxwSlo5ZUc3TlB5d3E1VHlnRGF5dko4UmtsNlR6UmlQd2Ri?=
 =?utf-8?B?YiswL2dMOTVlanM4Tm9rMjc5ZXhld2g5Qnp5M3BhRmplV2lFRk5PalZOL3NH?=
 =?utf-8?B?WUdXaE1LdTBNdVhYK2VlVDR3WTBBMHdYeWJINlJ6QW9CNXV2Q3lJTUpyaDQ3?=
 =?utf-8?B?YTM2OXJpRTZSb3VWUXc0Z0U1ejgySGNPSmF4bEFLN0ErQUVlS0lRMlV4Vkxs?=
 =?utf-8?B?dUFoV0llWWF6dzdsREU4RVAxSHNyVkF1Y2ZqNnlZUzhqNFdvbm5yMVFmSnor?=
 =?utf-8?B?R1BLeTZqNDZVeUt1SThndVl6VHh0WlltaG4yTWNyR0QxdlZTRkhrN3NqU2lp?=
 =?utf-8?B?UTRDQWgzUFBJNkdLNFhuK0dVcGxMWVN0ZVF2bFdHSUM4TGZxVE9UV29qR2Ix?=
 =?utf-8?B?alJlZFNsRDcxc3JMdzlUYzVyODRIL2xYQzZSOTg2c1dkYXliY2s5eXVTaWRE?=
 =?utf-8?B?aXU3NlBpOG56RkRkWXV6Zm5UYSs2WlRxRHZwbldoTDk3MlhZWC9nU0t1TTBF?=
 =?utf-8?B?ZkdnR0M3Q1NzT1B1L290YkRBOUp5NVNCRzVleFJ2ajhVTHhQYmowYW9qU2VZ?=
 =?utf-8?B?ZWhLL2N4WE0rV09BWGhra3doUHNJZU1qeCtpRTBrV00wNUY4Q3FML01FeWxP?=
 =?utf-8?B?c2xiSnpaR1RUaUJtNmdMNU1rdHJ0cS91Y1V4QllFamFwWXNKaXVSb2M3WE1h?=
 =?utf-8?B?elNmazRhVGFEbWk2YWNhN3k3c05UYkdZbWtlbVJRUld6ajA1Q1llVnVhTmJV?=
 =?utf-8?B?Y2xjYU54Tm1sMTNqSE9WUVNrc2VIcGxubDZFY0hFR1RTWGFCMzI0U013cVdT?=
 =?utf-8?B?N1dlY3V5WkxXREw1cXpxRTZGVlBrTHlVcFcxT1NMZ3BMRDNxVlYyb0s4TTFw?=
 =?utf-8?B?QU9tSGdsMHhPczdJRFhKWkI2dHNDczA1MXhmR09NVGRJWXBHYU9LN3JDUGJV?=
 =?utf-8?B?VmhhL2Q5eUdPOWtrRUtnUUJaZ3lUQXhub3lsUkY3enNQVDNlUEtVN05YdEM1?=
 =?utf-8?B?cFVELzNvdFl4M3lNZlBBaU9seHIvV25nbkNqUUdmU1VZejh1TDdZZlVuZFZP?=
 =?utf-8?B?b3I3dTE3RHVQSldvdUxrNjRJZThKaisxMlFBdkhNeUVSdkxGRUlpckMwQ1Vj?=
 =?utf-8?B?ZW9lN3hqKzhmTjJHTTFKWEhEU2F6UHdTeW5lTU91K1lUVHZDZUg1THF4U3Yz?=
 =?utf-8?B?NldBSy9yNE1mOTRZd0xISkNGNDRGK2dBaUNPd3h2ZS8zbG5TTUFsb0MrL0Qz?=
 =?utf-8?B?SHY4eXJ6RHFvNHN2YWVMZnpIdk0wRnFsRkVra3hSRG5LOCtnUmlyZVRQeTNl?=
 =?utf-8?B?MFMwdFpFOVZIRWozWmxHYlplZE1tT25nU1AzYlNxSzMrd2kwOWppOStvc2tW?=
 =?utf-8?B?ZVNGbVBsSEZNNytnanhDVC9MSnNMRCtqekticW1kWEU2V3pZNkJHeXlTOHp1?=
 =?utf-8?B?aUVXY204SjR2eE5ZNzZSUlJXa0JGTWZiNWkzSUVsTituU0NiYU5SNEhPUFBt?=
 =?utf-8?B?a2tFQWh2TzQwY0tsWTVYa1hESVpUUnpVZVJRcHd0eFpYSC91SS9iLzJlWnlo?=
 =?utf-8?B?R3lzSEF2bWRLZHhoTzlOZlhnSFllQmRVSURFRWhmSktmNmlpcUlUVTZURXJ6?=
 =?utf-8?Q?YEdFuWYWEnZnH6TITLH54UxaT?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 471e2ad9-6d88-4dc4-6a4a-08dc19193f85
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 18:05:41.2682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kh8+yLk6ekKKM6v7IDH5MW/4uWNfFvYuvSQ4mHnKqS6AMMp5Gx0VdUZr1XPcaNptmZGCsVvea5SaIO9FXvws4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4854
X-OriginatorOrg: intel.com



On 1/8/24 04:48, Robert Richter wrote:
> Trivial variable rename for the DOE mailbox handle from cdat_doe to
> doe_mb. The variable name cdat_doe is too ambiguous, use doe_mb that
> is commonly used for the mailbox.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/pci.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 6c9c8d92f8f7..89bab00bb291 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -518,14 +518,14 @@ EXPORT_SYMBOL_NS_GPL(cxl_hdm_decode_init, CXL);
>  	 FIELD_PREP(CXL_DOE_TABLE_ACCESS_ENTRY_HANDLE, (entry_handle)))
>  
>  static int cxl_cdat_get_length(struct device *dev,
> -			       struct pci_doe_mb *cdat_doe,
> +			       struct pci_doe_mb *doe_mb,
>  			       size_t *length)
>  {
>  	__le32 request = CDAT_DOE_REQ(0);
>  	__le32 response[2];
>  	int rc;
>  
> -	rc = pci_doe(cdat_doe, PCI_DVSEC_VENDOR_ID_CXL,
> +	rc = pci_doe(doe_mb, PCI_DVSEC_VENDOR_ID_CXL,
>  		     CXL_DOE_PROTOCOL_TABLE_ACCESS,
>  		     &request, sizeof(request),
>  		     &response, sizeof(response));
> @@ -543,7 +543,7 @@ static int cxl_cdat_get_length(struct device *dev,
>  }
>  
>  static int cxl_cdat_read_table(struct device *dev,
> -			       struct pci_doe_mb *cdat_doe,
> +			       struct pci_doe_mb *doe_mb,
>  			       void *cdat_table, size_t *cdat_length)
>  {
>  	size_t length = *cdat_length + sizeof(__le32);
> @@ -557,7 +557,7 @@ static int cxl_cdat_read_table(struct device *dev,
>  		size_t entry_dw;
>  		int rc;
>  
> -		rc = pci_doe(cdat_doe, PCI_DVSEC_VENDOR_ID_CXL,
> +		rc = pci_doe(doe_mb, PCI_DVSEC_VENDOR_ID_CXL,
>  			     CXL_DOE_PROTOCOL_TABLE_ACCESS,
>  			     &request, sizeof(request),
>  			     data, length);
> @@ -617,7 +617,7 @@ void read_cdat_data(struct cxl_port *port)
>  {
>  	struct device *uport = port->uport_dev;
>  	struct device *dev = &port->dev;
> -	struct pci_doe_mb *cdat_doe;
> +	struct pci_doe_mb *doe_mb;
>  	struct pci_dev *pdev = NULL;
>  	struct cxl_memdev *cxlmd;
>  	size_t cdat_length;
> @@ -638,16 +638,16 @@ void read_cdat_data(struct cxl_port *port)
>  	if (!pdev)
>  		return;
>  
> -	cdat_doe = pci_find_doe_mailbox(pdev, PCI_DVSEC_VENDOR_ID_CXL,
> -					CXL_DOE_PROTOCOL_TABLE_ACCESS);
> -	if (!cdat_doe) {
> +	doe_mb = pci_find_doe_mailbox(pdev, PCI_DVSEC_VENDOR_ID_CXL,
> +				      CXL_DOE_PROTOCOL_TABLE_ACCESS);
> +	if (!doe_mb) {
>  		dev_dbg(dev, "No CDAT mailbox\n");
>  		return;
>  	}
>  
>  	port->cdat_available = true;
>  
> -	if (cxl_cdat_get_length(dev, cdat_doe, &cdat_length)) {
> +	if (cxl_cdat_get_length(dev, doe_mb, &cdat_length)) {
>  		dev_dbg(dev, "No CDAT length\n");
>  		return;
>  	}
> @@ -656,7 +656,7 @@ void read_cdat_data(struct cxl_port *port)
>  	if (!cdat_buf)
>  		return;
>  
> -	rc = cxl_cdat_read_table(dev, cdat_doe, cdat_buf, &cdat_length);
> +	rc = cxl_cdat_read_table(dev, doe_mb, cdat_buf, &cdat_length);
>  	if (rc)
>  		goto err;
>  

