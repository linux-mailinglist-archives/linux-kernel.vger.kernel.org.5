Return-Path: <linux-kernel+bounces-63958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9748536C4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F1811F25343
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0165FDD5;
	Tue, 13 Feb 2024 17:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O15FhJno"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E0322319;
	Tue, 13 Feb 2024 17:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707843831; cv=fail; b=J5279nOl7itpq5QdAOs6usdr/oF/NYzoXzkXQfVLFpymFlX9BNd6sS0V37m9ShqqtR2wftjMiSEwVIBR9x5KDw+lBB3Ubv8U7QbMcoFVGOkgJhBtQF1IUzKf76LQk6DsIT0rLtuip8g9FMJxh/pnWjEQGaeZ14cVTszuPabyOQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707843831; c=relaxed/simple;
	bh=hh73DxEQwR8ktHQyZD/bFzjpdtJ2UZ2+vAypx6BZtTk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pJ+gPhOw+q1PYG99J6FyhDuk9Lh3N3XAg1KRJiuLDSmHpUWsmFyxh9ZbGb2xkxNRhjRyk6kLhZJpGHEPdbJjk5N5173EBh5OAc45GtHY19BQXlgSv7X9bREg2LFPoS1+hesVT62HCBPrpsO4Jy/rCh8u5r6HmgQa3NnFiMdzYII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O15FhJno; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707843830; x=1739379830;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hh73DxEQwR8ktHQyZD/bFzjpdtJ2UZ2+vAypx6BZtTk=;
  b=O15FhJnoqGTEh4d8XWl8AoRKIwkFk90uQ5htg3dR74mlc0XMLNINo7W/
   UXmEy5KNh2SyIJglhg5COhTN4RpV/LPnAzGoYao4YPrMm4BBlKD5k8K+5
   vdcRB7hnLjQ/vHd39V5ixp20FcGY880GLFnFurYkQ9DRCvf/vyFTWZTuE
   eLLk5SstaYmk8f1NbxBbiqOCgHQApEcG45UK2qmulmRlFMTGyiShs3ivC
   f+PQcfe0F+B09yz33FyHBEbvgL0RMzxl9h4kLWhHulJTGzkdVGd92JDKk
   Z+cSnCF2UsEBuEHLW+TC1WiuATXeXSpRsDVYxlP1um+jKfEUYovRK6jNS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="2218116"
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="2218116"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 09:03:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="7691571"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Feb 2024 09:03:48 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 13 Feb 2024 09:03:48 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 13 Feb 2024 09:03:47 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 13 Feb 2024 09:03:47 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 13 Feb 2024 09:03:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YP5wZ/cbvrbBvnznJu6ZY1E5dXQvAfYgSVBuEVPIbOZLHm/mMk274t40MO1tEPMK9FvwqskLQDGR3ZIJGXdrBtjBdNsGsTa57wQdoFjbbrfPmbO3GrJngTOyd/7dFkUqAr5AVCnMnH8t4Av5iEi3ZDc7ZpOG9rMLzISvrSrJ/cKQS/DQ0v7YaDI/QANBsM+iW5BGuLHQtbLtq3GS5I8cLxPD2MX3KHjI2Bk/dk8tzon3CPvtKEZLO0iMYZX4xWkXHXjY3ul/SWXlXUKrmVsUCa7fzuEfQVat4vEIq++ucsv5Bo9h99GKBc2GjwPxTotYpQY+PRZBNgR/eeybvMD8HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BsICa1egkQ4FJgMHV3tZfKkh5OhtqfpYmAJxcjb+K2U=;
 b=LdSPzxsU0zmfwYlGYbxxrKPP5d8Q/z2Vdc8tcsluzZaZ1H6guZu19+SmNYTC6sIss6E2p22jymxPTuCEjF5bYU69udK+VMBr/jqUbxhDg0WDl7fZYYdMcgZ2ILsg1nIwZ/FI1bKsysw36apsGG2k9FE4S93KOgMJ8bWnFRE3JDwD/wS+M6X8oudXQvogqZMZhCIDxBm2EX/DdaSD35cOuyF575fQ3rIitwph8uP4W0avieIwskqroFwEhOnBhNvg4fEayBo7kgLKFhZEUy1UV/i5DsDVdYRLa/MUDjQfEjycGk4sUaeQEPgql70xTQA6QNPKzDQUAY2zDxzQ7CYXhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by MW4PR11MB5871.namprd11.prod.outlook.com (2603:10b6:303:188::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.35; Tue, 13 Feb
 2024 17:03:40 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::d140:9bf1:fdca:b206]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::d140:9bf1:fdca:b206%4]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 17:03:40 +0000
Message-ID: <e15b25c2-2ced-4f79-b541-61980a31f947@intel.com>
Date: Tue, 13 Feb 2024 18:03:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: manual merge of the wireless-next tree with the pm
 tree
To: Johannes Berg <johannes@sipsolutions.net>, Stephen Rothwell
	<sfr@canb.auug.org.au>, Kalle Valo <kvalo@kernel.org>, Wireless
	<linux-wireless@vger.kernel.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Linux Next
 Mailing List" <linux-next@vger.kernel.org>, Miri Korenblit
	<miriam.rachel.korenblit@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	"Rafael J. Wysocki" <rafael@kernel.org>
References: <20240213110852.51524899@canb.auug.org.au>
 <4044e07e87af766f643f89f839b332973819e048.camel@sipsolutions.net>
Content-Language: en-US
From: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
In-Reply-To: <4044e07e87af766f643f89f839b332973819e048.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0062.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::19) To MW5PR11MB5810.namprd11.prod.outlook.com
 (2603:10b6:303:192::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5810:EE_|MW4PR11MB5871:EE_
X-MS-Office365-Filtering-Correlation-Id: a9769d8b-a37a-4049-be2d-08dc2cb5b9bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kCB/QoaZ8vxRgt2GsZ3O6buqQexjZKGVLyB+74gFohSOl7te7dnqgv7zbkYYs+ZCUdJNJ7+tVvh3mTsKXDitZIUls6IOy2Uw3OWBnSHHgvoYZ04H0/LVyPvZRCXlkj3Uofof0cTJKWiJTyDHGg4AxiNoYzSJDo6CQ9KOb/rJq0WBTLEdOvFrDblW6dpf9AaJyZjmmj5NlTk9RyQJSnTrsFkCT5JveJMmlHZDH5eUuwAu0FQ5qNaJzhMBOutlFt6eaBPveTVRkG4HWtz6s/Aj8Qx38no+S9fyhxU6j/fcnB5qcAcxhqDEkPB1MCPNSmFOgXQ8wW7//BPWexUWZjJ2jil2ENfkjgts+MTKfTar2/Rpt9dmsQjC3fc5bHB70bt7jjjAqKojWo4FYdHOCzpSFiDT2AWmeIrK2L0/wssZjmt/TAMhidzHiAgf6ot5e6wcNQmnGKP0x0wND2GC5zWcVgb1N/4sYPzYB2nV/oC8AImCyCb+yEKDoYzjZUQAJ8oTGNIGGz98W/oGZO0EOljAZq2qvw/F3y1RnwfbwxIgEAEpr/6z4gau418k500KKi5k
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(366004)(376002)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(36756003)(31686004)(41300700001)(316002)(2906002)(6486002)(478600001)(4744005)(66556008)(4326008)(110136005)(31696002)(66476007)(66946007)(54906003)(8936002)(8676002)(82960400001)(86362001)(38100700002)(83380400001)(26005)(2616005)(5660300002)(6666004)(53546011)(6512007)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0Y3K1RNNkxYSUJYUkhkWVh1NkFzYnpsbEdyKy9rMzFROTdkN0FFb0xXY1U5?=
 =?utf-8?B?cHVFc09UQ3pscjNLbDJSTlNpTlpBUGdBd2IyS3E3aTVoUTM4VW1DU2paSy9w?=
 =?utf-8?B?ZHNkY21VUmdscjRUUVIvVjlxZGtzUG1SUEMvUUEvRFUzT1JqSk1LT1MxbGJQ?=
 =?utf-8?B?TGZPTUhEblhoTkxqUlVBVHRFWFRVbWZJcTBsbEFKblQ4SmlWWmsrWE14MU1t?=
 =?utf-8?B?QXVLWkFLQkd6V2dZSStyUlhPenh2QlBBWk5vM2h2VGRmVFVkQmJUb3hmQUlr?=
 =?utf-8?B?aEgva0hJc0NMeWt2OXJFb3RBTnVqY1pBWmdTRXBmcm54NjhhZko0RG5BYy92?=
 =?utf-8?B?SXE1RVVheFZOV3RranFyalZwN0dyRGlFNElZZmpyZHRqdHFCU01XdWZUZVEx?=
 =?utf-8?B?bUI5anB1NWEyR0hkOGtJWXljTGYxelFQTUh0VU1HVFlOV1BvZDhUOGcxZkVk?=
 =?utf-8?B?dVFQeHBXWmQ3UWtxMGhEdXJ2TGRMQ1ZXTlAwRnYzb2FXTGd6bllTOGM1N0Vn?=
 =?utf-8?B?QTRuZzhkY2FzTmxSc1RZRWN0VkorRGlQOUxiZHY2SU56NXBkemN1REVrN3lM?=
 =?utf-8?B?cWVQTmhpSmZ5d3dsYWF3MXpQRERDd1VNcC9KSXlvb04wcmxZM2JKT1EyYkpS?=
 =?utf-8?B?NWhIZDZFU1c2THJlMm5NcVZQb1NvQ1RhTE5nZWpwMU1rdXNtMTA5S2E2QnJm?=
 =?utf-8?B?NndIdnIwKzZ5Q091MFgrTnRSK1JhcW9DcElIeXpNNEppRzZva2U4a1lJQ1ZP?=
 =?utf-8?B?VHg5R1FLSll5NFpIa0NpbHRzd0VXakU0R3VBNldkZFZvZnpYZnhxdDlYa01r?=
 =?utf-8?B?T29ZdW9ja2J0QVJUbWpHYk9uMEcvRUUyZWpadTVhMGswVWFLcExnVDBkSGsw?=
 =?utf-8?B?bVFEeWVyekJFbWVlWG02aG0rclpadHE2SEswOEx0cDVYVjFSK1QyWFNEcFVw?=
 =?utf-8?B?aGZzbUg0NDhsMVRWdGxDaHE1bG8zWEg0VnpBakZCYzRNQ09USGljNmFiSzFF?=
 =?utf-8?B?aG1IVWZtSndTZnZ0NVVCUHZvYitSNTRKWDRGVDI2VmREb0pDTUswcHJvOGpJ?=
 =?utf-8?B?QVhZd0NkVHBSaWV3SUdRYlkxcEVZZGgvN0JycEZQTFp6eHo2a1Q1MlYxcDBE?=
 =?utf-8?B?bk5peloxSmQ0dHBxWWd5UVppU3o3WTNaTWE4RXl3cUlKVTluMWNMZFp4S1ow?=
 =?utf-8?B?SkNXUW45OUVJRUFCUWhRQUk4NEtodlFmUUwxWUFibG02dTBtM2pDaEkrY1J4?=
 =?utf-8?B?MlU2WTFsZFloZnkwNmtxWHZoWHpKZjl4ay9QYVdWOGlyS01yL1c3czBVWi9x?=
 =?utf-8?B?REpRWWU3OFlNeThGdVQxY0I2Y28zczUxS0N4b0w0dHd6OVE2NG9tdmpSTVBn?=
 =?utf-8?B?dStLYjE1elltWnc0cGFlbTlEbkc0ck42L2JrMTdERlh0YzhNTFF6YytlbDNw?=
 =?utf-8?B?eENKZU5LSlF3NVNQTEZKbFB6Q1lCamcyZnl4aXNodXJjWlFSdHBIa3BmMlY0?=
 =?utf-8?B?VzlwTlZZV1ZFczZNaG5sQ3Z3cWxoL2ZrN0tUWEMzZzdCa1U4Qk1VeFhQNTVn?=
 =?utf-8?B?Qk9aMnJxS1VYNHVxdFlwR1NEM1RMZXpwcnQvVVNGakhhWlFLUi9vcDVTWFZs?=
 =?utf-8?B?bjNaVXVrcjE1ZHRNWFBoU2tBUzk2VXIzdkU3UHpYR2t2ai9ja0FhWlFFMnRL?=
 =?utf-8?B?dE1FUWUyMHZwWGtYTVVxdkYzSGErazF4RUdRSnpRb0Q3N0lId0paeS9ORWZG?=
 =?utf-8?B?WTNXNG9hVTcvY2YrKzZCeTF3YXhsS0p0L3Q4TXB3em8wY0d5Z2c4N3ZmSnhv?=
 =?utf-8?B?K1ROUWExMGpiRm84MzlsTWNXc2RvTkVpT2h0dEdXK0dsYnovVUM2Q0V2M2o3?=
 =?utf-8?B?WXFFbHd6Si9adTFWaHJOZ3BFMjJXeGpQemJxNkFyOUt1UkNNU2w2WlN3SnBR?=
 =?utf-8?B?eFAzMlRwTG1FeDVhOE02RzVUUzY3Tm1jY0tydHRDUGtxYjNIWmFOUFJzVmcw?=
 =?utf-8?B?UUZOVisxOTcrNE13bW5NcVd4RE9KMWhkM0ZtQTFXMzl5eWNVazMyQVpSMm5o?=
 =?utf-8?B?NE9SZktUVkxwUFNzWUJVY2x1TnAwdUYvdS9SRDMwRDhWcTNzKzRRY0RVWE0r?=
 =?utf-8?B?M1gwd21wZmx1ZXJYajluTGVydXhPL040b2JYMFhLS1ptUGp6K3ZZbVFnSDBz?=
 =?utf-8?B?Z2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a9769d8b-a37a-4049-be2d-08dc2cb5b9bd
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 17:03:39.9621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tj/os9oSfQGDkFIqSk2KIYiZaBIx+I/QjIJLfzTx07C2+w9XJbz/dwErG5x0/LrZJEho1jc2TuAhQDJuimS7HCvYRvIKk0zCaL5AMpyg0oU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5871
X-OriginatorOrg: intel.com

On 2/13/2024 9:25 AM, Johannes Berg wrote:
> On Tue, 2024-02-13 at 11:08 +1100, Stephen Rothwell wrote:
>> Hi all,
>>
>> Today's linux-next merge of the wireless-next tree got a conflict in:
>>
>>    drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
>>
>> between commit:
>>
>>    2e171a57c312 ("iwlwifi: mvm: Drop unused fw_trips_index[] from iwl_mvm_thermal_device")
>>
>> from the pm tree and commit:
>>
>>    8cb3a308ceb1 ("wifi: iwlwifi: mvm: fix thermal kernel-doc")
>>
>> from the wireless-next tree.
> Hah, sorry about that. I told Rafael this was likely not going to
> conflict, but didn't see the doc changes ...
>
> I guess we'll have to live with this conflict, unless Rafael you have a
> feature branch for this I could pull in and resolve?

Well, not yet, but I can add one if that helps.

Cheers!



