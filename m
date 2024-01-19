Return-Path: <linux-kernel+bounces-31631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D366383319D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 00:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAED9B229C3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 23:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081715A0F2;
	Fri, 19 Jan 2024 23:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eAIuOeTd"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEFC59B48
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 23:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705707506; cv=fail; b=hNRKbIOUE8Zz9bUj9W44VGVhaNTZ264bgpNCcVijlHRSaRYt+OlGrqudB+AEIQBeImp39642MJIkZQ6TpDpaohE/vpeYdwwqIC6LdIKr34tDn1xN/S2YE7kZnrju13Tz4FfNSj476dwjAYBNrTsTcci7YdiWmxxAojixbMcmj+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705707506; c=relaxed/simple;
	bh=SjYpAtfHACTb7UGBg8jq9UKQPNqpvuG9Iu3TMZh6mAo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Bm1m8jitGslcj7SZtNUlbOFBJn17LD4JugChIJZecysHIgPx/fIfyaXqnEaZ5BlqwKqHsXitNSgCNDkNx5o1b6FMHCzAvZo6oGo3jYn4hSQX7J+f7oPkLNQg+SttXvyfxYfpsYmw9JstCiJKbYiGYqhp5HqEijivUb+oPgqLJuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eAIuOeTd; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705707504; x=1737243504;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SjYpAtfHACTb7UGBg8jq9UKQPNqpvuG9Iu3TMZh6mAo=;
  b=eAIuOeTdl8Q+sF/P285AyVvzVGOw6TtQ7S1c2tP5CpbEW6JIXkHMCaIF
   oQcEcity+g7WpQEhIo9j/f1nxLj9lOJkttDA/nZ7C7ufBaKP8XHht6h+m
   ECbvp//yLlVaLgGV4RbD4wYtbZGnWhs19HTcWh5ilBBnKu66F6OuxXKGM
   Vzy9CgBxRLerfgYRMFnHpHflRDC1sf8fUUoiX0zN9aHA4YTQPhdX7psmx
   ibtRh/Ajymrjj7WCfkONetzftub3l+0WGiw8CVun6q4g3rhdHUSQVbEV3
   +FFTopRTjXctz+l8rRgUs6kBB88L4a2gD5eEjgpz5/osSYKWh49lt/1ZL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="773651"
X-IronPort-AV: E=Sophos;i="6.05,206,1701158400"; 
   d="scan'208";a="773651"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 15:36:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,206,1701158400"; 
   d="scan'208";a="722380"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Jan 2024 15:36:26 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 19 Jan 2024 15:36:25 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 19 Jan 2024 15:36:25 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 19 Jan 2024 15:36:25 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 19 Jan 2024 15:36:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OiqYNqiKNZ3cyXJExHpeHAmh/rsp74L7ybtZL+AzvenzObZJBSGIQhA9PYKVjS4ntogX/Ui8goiF6bUlzcT7HBj2vSDNwloX++1F1IW6vZwppDYjYa+ZqZ6IeIAEIIOfafobPLS7lxuT95e8JDqfoQS3n29mVgJJTqI4xXb0sZqB2sur81XATutGEn0u3L5akBDWXt91UendhRSYf3ihacJGUSAr5DraCewp8UiuRWQIJfA41FmaL2n7HFxVtM/CJm2B+LbRAcIXDjOpKuvrQaHh0eJSRXIOmGWI+4ivbwLeKn75IJ1Qs4aHShvZgqITWE8+p3yeSuJOm9YQy65t2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SjYpAtfHACTb7UGBg8jq9UKQPNqpvuG9Iu3TMZh6mAo=;
 b=gedGWaif0tdGe8wPPhXtGyvnmocbZMKzwX+OFWWDqDt1VQw3Cp2ix7mwaLZBQRP1lQXqG6Fq9aHDZ15ViLn/bb2v+yqqK+gzk8vnVvVGTEZywto/hDMWRmdvHzQeGiA+XmepAlOswLP5+qvvVqL4RW2gU7xEZLfAbc9LXmezxHICsQuEkvVC5bgHi712qSNeMCyCR/NDd/lbwTYZskPJrXHuZx57u4DLnbbBgf3OtWXOrV5+qplC7sDCdnximekRA3KuWLQbYkK7Y/533gVaxy8UktnGck9eLEVVfA60UyVlP0AmUB1ak63KArce3Vig0h2v/5uVwEtIzcGcrNNnCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by SJ0PR11MB5086.namprd11.prod.outlook.com (2603:10b6:a03:2d1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Fri, 19 Jan
 2024 23:36:23 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::c3aa:f75e:c0ed:e15f]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::c3aa:f75e:c0ed:e15f%3]) with mapi id 15.20.7202.024; Fri, 19 Jan 2024
 23:36:23 +0000
Message-ID: <3c65826f-d313-4455-842b-da9fc4a271a5@intel.com>
Date: Fri, 19 Jan 2024 15:36:22 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/lam: Disable ADDRESS_MASKING in most cases
Content-Language: en-US
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
	<linux-kernel@vger.kernel.org>, <kirill.shutemov@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <antonio.gomez.iglesias@linux.intel.com>,
	<rick.p.edgecombe@intel.com>, <alexander.shishkin@intel.com>
References: <919b6370a908bb091779ec2eca7ca5e369d57847.1705631230.git.pawan.kumar.gupta@linux.intel.com>
 <8936e2c6-93b8-417e-9151-041c5f2e1102@intel.com>
 <20240119162104.4ehgnj4ptjrfwyhf@windy>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20240119162104.4ehgnj4ptjrfwyhf@windy>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0097.namprd03.prod.outlook.com
 (2603:10b6:a03:333::12) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|SJ0PR11MB5086:EE_
X-MS-Office365-Filtering-Correlation-Id: 948d24be-c12b-4674-0b05-08dc19477259
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fOKAQsTLkSxstjMX3sjZ23eMDAZdLVuIueTLSuRAy2RYAh8MdIuMsoApU3rHhuP8f3odSazjN8JEmPf3NmvCQdGIgM8AHt+s0se02EwR0xx9cpo3xrA2SqYXuXsJ/eRXix8T1MCaSoDoIvFjvsEh8rIvQW9U2ubzMNROHVRgUUX45YMmKV0ZX/GTTAPO2YMEO8V09IVx3XcC6QZeYPl6uyyF5Ij8S52BYVGxCjPdLe5V7hYFcqNdiv7Y9wCxmsqwMCEYLd5PbmB3/bz/o7err5yT4GGS+q6DpfQ0vd3msGV2zwAocvANUhRNjMhjMRTZJAu9czao8hzVhQcPBihhBcGxPMAjaH+9+ArT9ZHJDGY81ca9n8m7SIgFfOne+EOwGsO0z0e+/AGMfOUGTNfyvH0lEgPdHPaVShKqkrCOOQVC1pPTyNmN7TNRBCA1A0Mo+QCYU+j6a41J2XsGI1pU7K0Yb6uZuHx4zkZkPP+ekhHkUwjnubVE5vdAxnJQDvOzTebAi7OF7hg5QSAfbul3/bNZORcN/mZPXbtNzNgzhCh1MeSCagXqfKltV/nFW7WUooKhxw0YTkDruT3wNjawplDYCEXrOdso0T14SN4o0yNEClGW5jrGamClIm5knq3IDpegtfAGxUF5ishL7fgZRg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(396003)(39860400002)(366004)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(53546011)(26005)(6916009)(6512007)(2616005)(66556008)(2906002)(38100700002)(4744005)(8676002)(478600001)(7416002)(66946007)(8936002)(316002)(5660300002)(41300700001)(6486002)(54906003)(66476007)(4326008)(36756003)(86362001)(31696002)(82960400001)(6506007)(44832011)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUF1YzFzSmFGSC9GN01lMUxnM0hrc0h0ZWM1S1VVMnhrN2tzUjhCcmJjbnRE?=
 =?utf-8?B?OWhQcmREY1dDL3hkVC9jUUtPUFJGNC81ZTk3R2tYSGFPZGJKZC9kdVJ0Y203?=
 =?utf-8?B?OVJuVWlaNlNvcHFqR1BJMzE5eXFETXp0SnRoRzhUMEh1Y0hZbUpRSlF2UFVC?=
 =?utf-8?B?MDh3TGk3TE5jOHdkbi9wai9ON0tmem43bjd5NTQ5dnNTNGdIcWF3TGg3aGlR?=
 =?utf-8?B?UVJsNEZFdVNWVDJlckZqSS9RYjExVjBVK3hrSzRuampMa2RvLy9CZkh1K3lR?=
 =?utf-8?B?ZjhnemNSQUZuM0o5RWNuRFRJYnJZTmNLbjVhc1FJSVZob3gxQ2NNOTlIMnZk?=
 =?utf-8?B?RldqRGFZMGhnUTY1V3BnU1BjdHdrM0tadWxWaDQxaTB1TUFxZm1vaEh5Skhi?=
 =?utf-8?B?YzU3SDNPM2hGdmN2MUlEdUpSU0dVeUVGSk4rcVN3V1c2TWx4RW9jKzh6NUkz?=
 =?utf-8?B?eE82ZW04RkRKOWFCY2FNbzdrSHZOcnJzS3FPanZqWWNJK2YzNGNPbmhKSHpP?=
 =?utf-8?B?OE55cThWdnVpa2tGYVBhQVFXTlhCdXo0bXp1alJSaEE4RXhsU2EremhqYU5h?=
 =?utf-8?B?aVoxTmZKTk9Vc3BMOEpnaWsrUW5Odk9teVFqZit1VWQ4YVhiU2dxN1ZnZXIx?=
 =?utf-8?B?ZnU2RmNnMnorM1YvcVlTZjZVT0QwblU5Rnk4Qjd1UkxoTm1nWnNma1hJcUVP?=
 =?utf-8?B?NmNmTVg3aHBvUTZQZks1U1JRdXkvblRzd2JheCtjWWxkZjZjNjdIU0d0UEtW?=
 =?utf-8?B?anJXWlR1V1hINEZ4MXVybUVDNVdFME1iaEFhcXJpQ2x0MnAzekMzUEdCWjR2?=
 =?utf-8?B?eWRadkJGd2xkM1hzcWs3RnhsMFdXNGZkRFZkK2dPb2J3STZPTnh2MFYySG56?=
 =?utf-8?B?Y3JvQVhON0JMN1EyYlNZNXE4dDFxZjd2U09VQTk2bDNQbWNnYVpTejF4ejQ3?=
 =?utf-8?B?c3RaZ1dOSG5heHltYzYyUzNFUkZpTldXcmZRYlNTNGhhUmxvTzBEZndDbWN5?=
 =?utf-8?B?MkJzaUtORlFUaURGQXkvNWoyaEZjNDFNanBLaGR6WGNUcHdvdXFNNlFZa1hV?=
 =?utf-8?B?REdaMGxvNExyTXkrSmMwamVWMmNjNzRoeFhVazV3bjVWRFI0YTd4UHE4em1s?=
 =?utf-8?B?RTlLWENTRzVyQUVwbjBFcHIwQUNLU0JXVlAwNzJ3ajA4bERqTXhsV21KNjVn?=
 =?utf-8?B?Wit6RWxmMFY0ay9uWWZONDBML24wZDB2SUtiZzRWWDJDSmN4bm1nLyt6OWZF?=
 =?utf-8?B?eVl5aDVyVzBJSDJ0QTlDRUtHOURqVHJyUU51NW5jaTZ6d1o1SnAzcG1QSjVj?=
 =?utf-8?B?TTBISXBLZmp4RlRneHRsdCtNQ2tOTzRORDNWdnJyUERpVENHdVJVcUl3NDBu?=
 =?utf-8?B?eDY0ZW1qbHhMU2lDOFRGdHhJd1hxdXdVY1JqeXB5dTlQTWJpOFd2WUdZQ0Uv?=
 =?utf-8?B?TGpUK21LZG5aR05Ja2RacG13MGNpajloYmFTNEk2M3NPNmpva0c4anVpK0FH?=
 =?utf-8?B?VDUweFFRSXFVenN5K2YzU2VRQnZ6QncwYU1SWlNYTFhpUGRvM3lIYU1ZRkt3?=
 =?utf-8?B?SnlqbnJDS3FFczU4VzFSNzZYZHArQXFNUkhUL2dWSHd2S3V3ejJ2b0Q4N29y?=
 =?utf-8?B?UDhmZWlVellYL0ZpbDlYajBGMVNQQmdpZDNiMWJwNEFMV0lUY0FkQXc5ZWE4?=
 =?utf-8?B?QUF1d1duZWZlcHJLS0FDT1FDcHAxMHpuYXltSVpKenRLdHVacjhQRHN2MFlZ?=
 =?utf-8?B?N3MzcDJVVmNvOXJFbFE4d2RRREQxYm5kdTBSajRFNUY1R0pFMjlmSkFwWDd2?=
 =?utf-8?B?aTlYZWFGT0Z3WU94a0VrWFJod2d4cEVhMEQ5b3ZjZGcvcDBhK3lYRHBybzVS?=
 =?utf-8?B?V0l3cFpjTlE5VzZKKy9KekdPSlZIbm9INktzSUZIZnpjZ2hYbnZhQmYxdG05?=
 =?utf-8?B?WTByR3NSK2FUUVB3bHlTR3NUOEpWbU9BUWh5ZzFCclRzc211WW5scUR4L2xX?=
 =?utf-8?B?R3BXcE83VHREd1JyQnUvRURMSURYUkVLaTZ2V0pRWlpWNE83R1RodC9HQ3NZ?=
 =?utf-8?B?Y1ZSN2JlT0ZUTFNTRERpdHVDRVZjdEsyTHRnM0lwMWg0NHhjWFhPamtBNzNj?=
 =?utf-8?Q?usRr1kJWCFBbqCQD3nwnHY0Kc?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 948d24be-c12b-4674-0b05-08dc19477259
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 23:36:23.2786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3BqzpGvs89thawYJnxjOavNDng8Fx22BLe5EE8u8Dk8fU1YHwdTj32RvOlnV+CIpUVBN2BUs8ZMe9Q0S/lY7KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5086
X-OriginatorOrg: intel.com

On 1/19/2024 8:21 AM, Pawan Gupta wrote:

> The goal is to compile test it whenever possible. As
> SPECULATION_MITIGATIONS are ON by default, it wont get tested for most
> configuration.

Sure, that would help increase the compile coverage. I wasn't sure how
much of a difference it would make. Anyways, the restriction is expected
to be short lived until LASS is available.

Please feel free to add:
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>

