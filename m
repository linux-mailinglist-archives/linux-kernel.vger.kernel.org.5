Return-Path: <linux-kernel+bounces-52087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3AA8493F7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 07:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C34E1F2419F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 06:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0464D10A25;
	Mon,  5 Feb 2024 06:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RzZflf+t"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940AE10A0F
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 06:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707115518; cv=fail; b=Nt3UpEOleMzuJ05lgdpFcFWu0+5L1yPFoGBETvNSS+mdIpCfzHNUzw5bhzCyCO3ndVWMoZQN2czFLRDezG45LObP01WeZIyyF/IOfNTVNtJpnnJ04j0hLByxwcQxQ0+oDp0f82zsqLu9K7KTZfAfnH7H2IPKzbp80BKoeA1URuk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707115518; c=relaxed/simple;
	bh=Mt+punBhGatZXIRmdHxZsS858UVLNlug2rC6kP3vrR0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Xyn1JYt9kmZlCuSagls7F09P40BjC6Cg8qLdAL9wEaxk+4x+YgX8t6T79ej6zL6gK/k2lgRWFQv+L2ztu0KYjKUAEed1hF/h5feRmaxKLDE7l77Zm/fGKqPz5KBp3QsYNzgZg8Hc6xIlkaQDZZvN8gVwe0o5ddFmDhml2iz4wIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RzZflf+t; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707115517; x=1738651517;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Mt+punBhGatZXIRmdHxZsS858UVLNlug2rC6kP3vrR0=;
  b=RzZflf+tSenxdcRH6Bw9ZqL4mm+vTP2wJwSpZ/nTGhkVHENIutd7+BeM
   yQeHDzzshuZus00Hw5YzKgJh/vWJJrUzlV6dIlKtceNmQFYUOG1K0awBP
   nYudkqKnXvnjdF+qGvUAXFLnl56REAdqdJvBhuEc1Pfc6SR+Qehna8geK
   oBqXu/+iFaLpZC5btTx9SHwHmtqbBFTw6aSa9kGpj0EOy/PcSZjrW18Qh
   zQPUtRKaMaGAQVdB6SiwlHBUY2r+UDO7KXSFrpeda8xDToLPP1VVSxuMr
   igvA85pWSwj5kEOTjTVPdoOfzLYN1514V2DEXo/RE8wxhfwlMvRUPENA9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="614527"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="614527"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 22:45:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="5379658"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Feb 2024 22:45:15 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 4 Feb 2024 22:45:14 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 4 Feb 2024 22:45:13 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 4 Feb 2024 22:45:13 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 4 Feb 2024 22:45:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gyQg6Fv11xSoGQ5vJmU+fXtZNkPMcTlvWUkEV9GrvHdCTOQYi91RdmgdELzRZtBVUiv1lpyPJbSb41NEV6fh02q/MixsQKLwUa/CVpOEydHVXNpznrXHB6Lab4HwgLRs5qFhZ1rHFqYrp3PowECB5Wjm/DzFGfMCA3E2Mpbh6W5Dj/uuwP2f7E49yPK0F88Pi6XW/GFMmspkYI1xJnH05UU2Fur9ADxEt+j5Siq/gE4JDGEtsIn3DyIwbma7Ks7VpaiIbHcJiHX6FHoJWb5eUL/8nj3jVWQ/R86OuIQGo061T10AwFmGTLGISDsK/nAh3bozDVIsj+SKBGYbH+3bXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H3sHpP61YZ9q8016lyZ040TMRpuFGzJn88TASiKzq20=;
 b=eYzc40XqQ0X0xBkZ6joNb53p9M3nXVpGIynpu7FF/XZ68jMCz6g1Lnptkyh7vMoyEYLtW1UREy1+NBBOfdGoWa+kWmuyPwD93ZbFJIQL1epTfYoi2LWv0IJVdzXy2cGNAYdrd7a1ms+Q/KBj+FWoCDh0Rolc1TGZ4GtXyVKEsOMGX+u3oKxmIn6ZBcxuIS4Rjn935rNvDS8rBmx3i7vH9k1Q9JcM4N69bFP6GoCtw+miRnnQAbN7EjupGYLKIQdPWgNthE/WeBbtiZw7PU1uShY88gGaKXHZrZ0LlgRb38EjGNhmjmFl4pJYb9A3wE4iBd75flBuANTBHnCdQtUqJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by MN0PR11MB6034.namprd11.prod.outlook.com (2603:10b6:208:375::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 06:45:06 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ff69:9925:693:c5ab]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ff69:9925:693:c5ab%6]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 06:45:06 +0000
Message-ID: <86ad296c-7af0-49ba-a22b-9bcaf355311e@intel.com>
Date: Mon, 5 Feb 2024 14:44:51 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] x86/kexec(): Reset TDX private memory on platforms
 with TDX erratum
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "Gao, Chao" <chao.gao@intel.com>, "Hansen, Dave" <dave.hansen@intel.com>,
	"luto@kernel.org" <luto@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"x86@kernel.org" <x86@kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"bhe@redhat.com" <bhe@redhat.com>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>
References: <cover.1706698706.git.kai.huang@intel.com>
 <b52ed259e0d487b3a968b98da91cb4f55a28ae82.1706698706.git.kai.huang@intel.com>
 <b083d901a8be0597e311d29fa6cc01046c37db69.camel@intel.com>
Content-Language: en-US
From: "Huang, Kai" <kai.huang@intel.com>
In-Reply-To: <b083d901a8be0597e311d29fa6cc01046c37db69.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0024.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::11)
 To BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5978:EE_|MN0PR11MB6034:EE_
X-MS-Office365-Filtering-Correlation-Id: e765e653-3cc0-4751-f1e1-08dc2615fc9e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OK0BOwenpizLq9vi+XXNEC5m1tfZSsm3rq0GyiOXztdAmlFkNXpSw+r3w3YEoieBL9raSga8NkY0VPFNmB5sBrXAZg1TlbuBw1dYAomDZhFGI9a3A0zSb4bIWWTVp3FIU+dao2WI80sJ8P9NRNr+C2GBg5TN84zPlduDZK83rhzWOvd3bTgul1XlNHURRNoxdwBpGBL1NTYsI1skBMtJupfVKtmjk+/jyXU3JVWjvNhQrfCWBrGcyRiCL5lW+Qn406Z1FYuf0Tm04fmlvt+DVrMBI7O9c8VoXmvOAGG3obxDbJLfzcDHolSWTdXgFjDkvV+PQJTnMBnPfzQnxvcTSnpLJgygKcQGUowKK5d2dSVNVNoRIHTFCPmtj2BkXbJybQkSvU4qM0Ei32jERDqPtJ963jfaNwahEE2hu3qXxp0TzWj8d2irgEzzm1Uh5UNnjKuVr+o5mDOCymQCKzY6owTsYKgdStJePbF8A2d+Ud7APjXU4sWIlseJzDFST+NzDPbrkEVxhVkvSHIrLFrA/YEHKbxN7BLpk8JSIF1Zk0Z2pYsEWeKSlBAKK6R/wBIAPIhPAxxIBTg4gcDBjeKglHlM2OahicCAyDcGR0QMDB5Nb7uh1YGdcBGMBirh0h7vqda/zBxoRYfKswjfvBrFoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(366004)(346002)(376002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(316002)(6506007)(6666004)(53546011)(82960400001)(38100700002)(31696002)(31686004)(26005)(86362001)(41300700001)(2616005)(4326008)(8676002)(8936002)(36756003)(6512007)(2906002)(478600001)(6486002)(4744005)(7416002)(5660300002)(66556008)(54906003)(66946007)(66476007)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dW1pZkpHT09sWmQ5RjBFeUk5aUVtUGhoeXZJclBnd0xjYWIzVis1RElkZjli?=
 =?utf-8?B?dlJlTlp5d0dPWjg1Lys3d1VCUitFWU1qcWNLRzh5clpheHplK3dKZmFqRmcy?=
 =?utf-8?B?VllFOG5McHhGM21ybi9DWEkzeklkQlFtZDE1bEN1NU83SklqVVpic3dweGdY?=
 =?utf-8?B?TkVmSTdDbkZzQkFkU3VGalpwTDJ1Yk5qRTUyT09vVFJZNHhsaXpjalR3TXRZ?=
 =?utf-8?B?eldWUXpIVDRoWURlRXhPTGQrc1JJYzcxR0txRFZsUWJ2TE5LOWtBbStGaGhK?=
 =?utf-8?B?UjhGVjVHcE5TRjBRb2V2ZU9MOFBSSk1QYmVtQlJGRGMycWcvRThPeXJzREhQ?=
 =?utf-8?B?QUU2UEdYRFRnV2RCTkhIbjdscHQ4eWpIN085bjF3UmZpWHlsSFZQcVVkSTI2?=
 =?utf-8?B?eWdOeGFiS3FhVXg1RFF4YUNYTlFqY0FDM2xaR3NYTGRDSlZoTnpWcGlxaUJa?=
 =?utf-8?B?enlCMm1BNnRES3NJMTZsTEsrQ2cvRmFtblljTWlteHZPMkVIbFNUdkkrNnZh?=
 =?utf-8?B?bnBKMXRmVUlBeVBwSzRKcUo4dll3ejdZWE12N3l6NTc0ZElHSDBqb0s1MHU4?=
 =?utf-8?B?ODdiRkZFY3JvakFOR3IxNkF1dENiY2p2cFhoSHk4VEZoRE9pRVpsTnZEZ0l3?=
 =?utf-8?B?VFZ1U2hIRjRMMTRLY0JjRTJmT0R3bUZ2Q2dWeGljcmlhR1JUNldkRTFwa1dZ?=
 =?utf-8?B?ZUxrTVRsTXJzV01pSnA5L094bGRPeW1LK1d6TU5nZndCTzVkb0tMQUJQYTlP?=
 =?utf-8?B?WE1ndFNsa0hCNll0bXF5bFZkcWhlVUYva2ZEOGpjb1ovQm1KcC9ZSXZZU29S?=
 =?utf-8?B?UmFvYzE2YjZCeUxtWm93d2hkZGowQnY2ZUUweE5iOTEzTlFjMklxUTVnMVN4?=
 =?utf-8?B?Z3pScWNRbGZlNjJMSVVBeXpFL1pSU3FSN0tFQVdQMWlZaUY3VXAyV0pOa3hZ?=
 =?utf-8?B?aStRV1hPbHc3MURkcTBJVXprVkNNNjRmRFlrTkZndDZpOXREQUZJQm9SQU16?=
 =?utf-8?B?aGFIcFRXcXd1R3FYV3MwOEI4R1h1SWE0dWZDc2pWRS9DY1Z2bnQwMjdPTkVH?=
 =?utf-8?B?M2pTeW5SaStIWkFSa3V3OG10dDhHT05BRmxkeTdPTkkvMGNESDJ5NXdaS212?=
 =?utf-8?B?bWIyMDUwL2V0elp3SmtyUllPVHh1c3h3dGFpQnZFWUVuT0NjbXlqR2swV28v?=
 =?utf-8?B?UmN4anM3SmFBNEc5R0E5dndEa2hIek5TalN2RmJ2U1BBajVlejIwVFFGbkc3?=
 =?utf-8?B?eFN5STUvajJjVWZMN1I0dHJvclRBQk5uTGRZYVFuaEovaFZUdVVaL1JkSnBl?=
 =?utf-8?B?RWdka0NHZW83QXRUVlo5UUxGTEl1UGpZTWFSWmlNMk9sZ3YzL0RHeHVqNDFD?=
 =?utf-8?B?Q3NOY3ZEM2c4RFFYS0tkL3hQVWZ5SXFUMHExK1crNDFiTVhwL0czV1BtWjVE?=
 =?utf-8?B?UStwaGFZd29MTDZvVVZIY1FEbzJBeVFLb0hOenFXaThrb3JNWHc2bTlJSzhE?=
 =?utf-8?B?TmVreUxBaTB3ZVd4cmhLb3VjdkRaMjdpc2xuOGZCKzYrbmxFZlhsbkh1bzc4?=
 =?utf-8?B?d0k1V1JZQ1MyK1MxRGMxWlB5elBZREVwUncyWEVzWmw1bUl4OENlZXNMTWlo?=
 =?utf-8?B?UzdZVmo1VW8zQnpEcVZMdGJQY1ZJaWozcDdDT043ZHQ1ckNqdmRucElKZ0Ix?=
 =?utf-8?B?Q2NpM1didUJnaDN0U0VZUy9lYzc5akgwT1ZCbE5hSjdBTzBYM2NDaHp3YWZ5?=
 =?utf-8?B?Z3duVkNadmZpU3BseWZmYys3SU4yVk5DOHpOVUtDQTBKNVl4ekh0d3I5U2NE?=
 =?utf-8?B?Vk5UU0pyZGQ0YVhwQi9tdUZCT0hqQVFZNlk4Z0ZKNzE1dDVqcDFPczRMcTRs?=
 =?utf-8?B?NXJqd1pEbkdIdkd6bnY0QkwxV1NDS296N1F4UkJMaDRPSy9CT21PL0o0NFYy?=
 =?utf-8?B?MWZveWlkeGo0YmFuK2dlWTFseHFlaVVBSnk5MExwVGprMlVnczFnaVdqWVU3?=
 =?utf-8?B?YmQwTUhQZjZ4eFlMcFlTMlJPK2M2ZzY0UlVoSWpvQ2ZiS29IaXR0RXA4QndI?=
 =?utf-8?B?bDhZL0FSVVpzS0tlNjEvU1JGYVRrZlprRmNPclRRNUMzdWh5bmx5UXpiYklU?=
 =?utf-8?Q?Bo4sryDIcPRR+aWiyns42FjU5?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e765e653-3cc0-4751-f1e1-08dc2615fc9e
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 06:45:06.3872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2pSU6a5xRDJ56gsXJnM2r84yQH4HOTKPWfuoXw8HX2UtipvuyBzghd28t2A76Jj0ziRuBt+u6o5SnrnOM21ZMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6034
X-OriginatorOrg: intel.com



On 2/02/2024 8:54 am, Edgecombe, Rick P wrote:
> On Wed, 2024-01-31 at 11:31 +0000, Huang, Kai wrote:
>> Note kexec() can happen at anytime, including when TDX module is
>> being
>> initialized.  Register TDX reboot notifier callback to stop further
>> TDX
>> module initialization.  If there's any ongoing module initialization,
>> wait until it finishes.  This makes sure the TDX module status is
>> stable
>> after the reboot notifier callback, and the later kexec() code can
>> read
>> module status to decide whether PAMTs are stable and available.
> 
> I don't see how this works with the crash kernel flavor of kexec. Did
> you look at that scenario?
> 
> 
Hmm right this doesn't work for crash kexec.  Thanks for pointing out.

We need a way that doesn't depend on the reboot notifier.  Previously we 
used a variable to indicate the point where it's possible to have any 
TDX private pages.  I'll switch back to use that.

