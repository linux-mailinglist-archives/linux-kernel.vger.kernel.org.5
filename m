Return-Path: <linux-kernel+bounces-79307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 551C286209A
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 00:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0A0BB226A9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 23:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193EF14D42B;
	Fri, 23 Feb 2024 23:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CGKsffe/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E071DA5B
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 23:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708730650; cv=fail; b=jDZ8NQz/Ryu1L+duDUbImEY1Ig6aZZlnoAyNxI6F6K7xkUcxxHOJLtekk5VPMmHxe4ynOPEmtpfMN/9rTH9MAcaTZ/SzJ096AHxS8Q9fc5EhWwE4cGrw4pn/jxfOSwFD/VwaaqBmpQA7OSISkNhjB6Tm6ELbd9bEYdMrqFc6pOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708730650; c=relaxed/simple;
	bh=4669c7QeouETcllPG8FX2WpcvON7pJVe680Yyt6tWt4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WaAlzvPkdanUg0ojLW4Ou9N75TTKVLLMVDYrehWeVHnwKOKwMOLH9ANqbTDHiDz6iiyuhfBfrlPTnwcsmtVS1laZiv497mDvfIVSWReY+7NNlViVNLexe/Fus8L3kpO6Dm8UMKmNpP3JcEWORyJs+fU/bzDa6lZNKD40oIAfi/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CGKsffe/; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708730648; x=1740266648;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4669c7QeouETcllPG8FX2WpcvON7pJVe680Yyt6tWt4=;
  b=CGKsffe/BahMxmojmtlt2QaQRqyPXzOgnmMhgtpgimPbsHjOTRV7e7cY
   3RvDECU6xxHbGDUtuhj0zbFYxtA6EAhF97NEQ5DxZfEawvKL0Ir9J+BYL
   k2T+nmPGUYBk+f10IFyEpS7x3b8So83Pq1SDqkRgN1Jzk4eyx7GG6s0W5
   8W/RIa+XcDLIfUm52r+viuyxV2raAycCWwdfYQQJqmz9T9tDlBTZOiDZQ
   uxgN28/b1grEATefk8DYmpZyz50vtryi1RLN3E4ttriT6RYaj8Z6trsZd
   JpYibHYt/IY2TQAav8V2aAQsCyaDVlBJ3qYZev97cK1Rp1xwvJNcAqoMj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="13633697"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="13633697"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 15:24:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="10729686"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Feb 2024 15:24:07 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 15:24:06 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 15:24:06 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 23 Feb 2024 15:24:06 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 23 Feb 2024 15:24:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U1JvTj3fmRs4vQIbiM/ghY+Dpl+NRVZZGTNNagm/6QI1e22CNBBXr5f4//8JxKPih33P0HH9caHP5Wkc41JZ/JwPuK5Y4YrR3F/2T+yT4jVCYSC7WqtsgS7IcbhEQbCMz+Wv9YzdVkqlU3CbSeAN0iO2o/BlAQeeUT2dMxI2SE8vNUga/fK0zfFhk3vIUq+cSwA+QICPY2qXRwxXsDFgmQuCtyVNhO5ximJ1NzVzRg+EGf70x+FNDtDwYr/sVUZowKjoKhCs21dg7G00TQvUYytRzdmebjP+1KB+fqO+fauSv87leELAuwVxWKQVkFVS/shIcJsy59oeG+6OsYit7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qD2MHfFI64LmKVsH0Kzo6CBax3pkrrYBnUPICXVPGVQ=;
 b=dShAJuGTCzRk59cDRJN5hx/gzReb+VO9pOWiAqd29dToO1/KWofqUy8DHCNcCXMlFAEB6tmMQe8RsezqjlXAY8J649t2xeC3KBwmG4VJqBXZdw0YV0v4a/kjTz35nj8lJRXj/Osql2ymIS335pT94R0zE9F8qRr1CupLoKXXpYq0Z67ev0Q3FPw4kyV4DN8gJ6p8NwzHR0UE809Mv81+6IqWB881s1VOgXooIQ41hmbYZS74udxkMVHEwdZsvPO5QrG0pXWbZPLnLsCK0we43q7HrzD51TfKFy2fhbGvM++rBQW90MekrqEnwRTFrGat8oIDZgLNp5LSSi61SohmXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7566.namprd11.prod.outlook.com (2603:10b6:806:34d::7)
 by CH0PR11MB5348.namprd11.prod.outlook.com (2603:10b6:610:bb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.10; Fri, 23 Feb
 2024 23:24:03 +0000
Received: from SN7PR11MB7566.namprd11.prod.outlook.com
 ([fe80::5abc:23ba:d55b:2c2c]) by SN7PR11MB7566.namprd11.prod.outlook.com
 ([fe80::5abc:23ba:d55b:2c2c%3]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 23:24:03 +0000
Message-ID: <8513d475-3a3a-418a-9cba-75d640619f6e@intel.com>
Date: Fri, 23 Feb 2024 15:24:00 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Track llc_occpuancy of RMIDs in limbo list
Content-Language: en-US
To: Haifeng Xu <haifeng.xu@shopee.com>
CC: <fenghua.yu@intel.com>, <babu.moger@amd.com>, <peternewman@google.com>,
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240221092101.90740-1-haifeng.xu@shopee.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240221092101.90740-1-haifeng.xu@shopee.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0013.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::18) To SN7PR11MB7566.namprd11.prod.outlook.com
 (2603:10b6:806:34d::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7566:EE_|CH0PR11MB5348:EE_
X-MS-Office365-Filtering-Correlation-Id: c69ba48f-c532-41a4-af2a-08dc34c685d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RlWTU3HmSGDOA+9xckv4aRYeLVGAaE+W+mpWJrrkykFYl+lJhI751lBokBgW74aRczViAbd7otAjKDJlPX5P0n9pdhZv4TZxHAe2ixOuEfoXIogD3WvlZ4Z80VcMUm/T59AxSHnKbGbEujdSaNZ41gSmBrQjN09ZP5SLgCEZFcD3n46XarXgoHctgyCYxYgPwtQW3LzO5PpSJQ1Q+O7u7NzeGOA0ulpFktr5DKzi9zQ5gK2GLO4uds0GXyb79urfD/GsqQ6vyDDpuQ5GLiuY7qCURswVhY0GJyaGye0GkWj9ztq9cQJuegu5vs58+/QMCsKpAWajE+4F+eXmJMMH8jaItivieZ3VI81gObJ+yF0A0r+KYgVlTUrSFO8Ed5sye7iMRSbA+JGUPNgQAFGqZTqo1xEdDBBq+zJjbPP9Sy2ajOzG13vIr0nhIhwejKqy4HwbVMpSunl7cjWgXnzTL5GYEQ80oSFWEWl9SdvK+a+KzZzZNp1sDcA08S7MLIMEF363W47U0em9NnvhlOffFJKVDsK6oW2b7tO7uDX6nyE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7566.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czFLNGhtc1ZHSThBdnR5bU9pK0dDY0VsRHA1Tkd1L3ZsaTlRcGtBUm45ek4r?=
 =?utf-8?B?bFI4bjArdDI5NFhpeFg5cUExWjA0V3FHOUlqZGNYdmtBd1J4OGVkSUt3RVRD?=
 =?utf-8?B?cXd6dlNxWWJycGhnUDREZ0x5TDZqY2NmN3VlcFBPTzNOQTZ4Z0ZJejg1YVRJ?=
 =?utf-8?B?SUYzenJOZTBaTmNRWjdRYjhPRE5KVHo5VC9GNktuYkhhcjlRVlM0VlBHV0tE?=
 =?utf-8?B?VWNhenhxc2pBM0Vkdm1ldzJxME5jVEVnaFhCc0NoNTN0Vy95K1REL1dzb3FI?=
 =?utf-8?B?eUNiV0ZpekZWNTNtb0xyOTI5dzk5Nms5WkNTaFM1ejZRQ1RXTWpuSjRjNjdJ?=
 =?utf-8?B?WXVLK0IrZVQ5WG1TT2g5T3Q2R1d0blMybDFYa2diZlorZWJUODJQRVpwdVV6?=
 =?utf-8?B?akwxbTZPalVrMVJNTVB0UDZPNzZ6YWpTczMyOW91UUxTM1haL3JaUmtJUGhM?=
 =?utf-8?B?aWNSRjkvYjJVRFJGUStJWHYwejJLSVRuamNrc0tQTnFubnVSa0gyeXI4K3d6?=
 =?utf-8?B?M00wMFUreXE2WFllNklnMFl3QU5uZll4aUlvcGdEVTQvUXNhVDZrRWZheEtu?=
 =?utf-8?B?bGF2aHpIaVA0Yml3L3pCdnlnajRoWDhObVpEeUxzbTU2ZEF6V3hrNndPSE1s?=
 =?utf-8?B?Q0QzWm9Hc2ZyajhBQ2s4M0J0RnNjeW8zbUxNUnlNUUV5YzZpQ0pVNmNqNUJl?=
 =?utf-8?B?NTl3QVBCT09Sc1g5MDFXTzZSbmlMKzQxQm13OVZSSGZKMjdhdHF1K3JGR0wz?=
 =?utf-8?B?cWlUYXhIWXF2bjdpOXQrS3NkbzE1S05aZktpSlhTRWgwZ1ZXNHh6QVdVbklT?=
 =?utf-8?B?RjNoYjNjT2t5Sm55b3VFM3JiMnJRaU5qcnEzSnNyb2Rhei9qVjcxYVlEcDBz?=
 =?utf-8?B?RmdpQW9PK3B3ZUJoYkR4UUNBbDNXS1k3L1JqZWhGbXR2NGF1UFVpaHZmclNI?=
 =?utf-8?B?SUZJKzAzWW1oOVJMVVJaVHpEcXpSUUFnOW9wRVZEVlRqQkk0RFkrZU1aWnNo?=
 =?utf-8?B?OUs3UU9CSDJsbTVkSWo3YmpuNW5iM0FlMXQvSllIbk9CWjRvM2twbUZ2VDNY?=
 =?utf-8?B?ZDBqR2tzQ2EybDAramFKT0I5MnpqVXNUZmFRMDVYNFFNL2s3cElGdUgxVWdM?=
 =?utf-8?B?UnlnREhYQUFQdVljUzN4bjU4NWg0ak4yTkV2YjJWNjlvcnRHQUNPWFNLTXhJ?=
 =?utf-8?B?cjVlRy9NSWtSb0JVK0MxN1JsL2dzU0RZRWk0R2w2T0xNM1JIYzVzU2F1b3k3?=
 =?utf-8?B?WWJpdVR2TEIwWTV5ekZ5RlhIakhtU0hWa3FMS3hkb3Y4czk3cU1mQ3UxeHhW?=
 =?utf-8?B?WFc3L3NSUGtISzdZcE5EcWtBc0JyRW54cFk5YkRGeGx6NS93akhiUWcrb3A1?=
 =?utf-8?B?R0FTUVlSOFJ6TmJoRndKS0VzMy85c2ZodmVPMXNocE5aa2VYa3lsbHhtTm9W?=
 =?utf-8?B?RGlQa1hKMm5VM0NSdEdCQ0tPU0ovcmxpVzRXQW5RVERHWk1XTHVDYXVRSnRj?=
 =?utf-8?B?Q2RLVnYwMjEvWXQrTkZDNGdQazJhR2thaFZsYkl3NlExTWhhRDJlSWxpbjZx?=
 =?utf-8?B?ZVJKQk1YVVVMMTBrUW5CdEllNlJMUzZRdVlScmloVE9JOGNMM0xwL2FCbE9B?=
 =?utf-8?B?Z3FDYWg4WHRKeHkzMXFUZ0F4QWcyOEZjUS9tS2dlU2NacEtuVzBjTW8rYVdo?=
 =?utf-8?B?ZlRoMHZ5ZnM4cjZrQ0p3SThsOVRGWkdncjVPd2VzaW5ab1JMdnd0VzYzSXk3?=
 =?utf-8?B?R1Q2RjRZd2p0bjJCRHNmRzFhMHhDTHdTTVgwUGd0UnhMd3JOMHVRT3dEV2ZH?=
 =?utf-8?B?eWRnR2x1RTVDMjUzNnM0em9haWFIcEJiK1ZmRU5yMDg5YnJINUFJNEZ0aVM0?=
 =?utf-8?B?V2ltOVB0ZkZ5SnpSMUlqRk9TVXRIZEdhZzV3TTRqL1QvSlBHbWVURFRHWGYr?=
 =?utf-8?B?QXBwUGREQUt4RnN5a01FY042K09ZbEJHd1dXeFpPTVNJOUJxaHlDT2VPNTYv?=
 =?utf-8?B?Z0ZTRTJ0Zi95QjRZS0krcDZuYWxaay9CZXcyY1lZallEbVlRamlmWlJKb3F2?=
 =?utf-8?B?Y053MDZLNi9HTHh6SnN3R0VXcmh2SHBlUDE1bTQzVG5xNEs4WnlDU3ZJUHYx?=
 =?utf-8?B?WnM3dFd4ajdXYWNJMzBsWkpwUE5xR0wzaytYSEd1TVppRGxMb1BSVUZrQWor?=
 =?utf-8?B?VWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c69ba48f-c532-41a4-af2a-08dc34c685d4
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7566.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 23:24:03.5097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1SXub+/VgTXYKBJoiYecXdn+Hmq2spA/J1nRu0mJgwtecrXa3AkzFWoISICnKDHsceKevqtJhrPakUsMOKR1G5RAxAOXipf21WnNONP7LBs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5348
X-OriginatorOrg: intel.com


Hi Haifeng,

Typo in subject:  llc_occpuancy ->  llc_occupancy
Could you also please use the x86/resctrl subject prefix in the cover letter?

Thank you

Reinette

