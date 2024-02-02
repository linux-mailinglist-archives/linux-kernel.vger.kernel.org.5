Return-Path: <linux-kernel+bounces-50554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C373847ABA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 21:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C28A61F24384
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4588C8063F;
	Fri,  2 Feb 2024 20:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c186vFLb"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5CC6310E;
	Fri,  2 Feb 2024 20:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706907078; cv=fail; b=l6YRIW0Z27wQzPdWNCN4P4eC8PW55uf7LpJnCCKsuNuyttxtYJPzIse2YgtVIsJL8aVZOx4wa/FeLR7t8qN0EP1Gs57sw/n1eU2ML0Obw+0sp68U+Gh9HZNn+5c1G0bItuhVswgC0BLfYZNYdcfhA9k6xilA6jjM3pL4lM2j4hU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706907078; c=relaxed/simple;
	bh=KyFkk7BZqBsjtIsr/LnXlgJkg121uJMZvLfXbI4gs4Y=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bDxeiGgZe9I7/6MPGAUE6GC9wbwAcLw0M1GBQKPpt9PX/nPO1VYYpTtsxDvzLgw6BwvjXpawpuf71FqOlc4QiGciZNN04lM/FlE5ObP9teun4/N2KVFid+0cifLQVNZYzvwy7WlvDRA/yRVPYkYlV1vrbwdwRFH5Bs3dzLXw85Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c186vFLb; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706907076; x=1738443076;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KyFkk7BZqBsjtIsr/LnXlgJkg121uJMZvLfXbI4gs4Y=;
  b=c186vFLb6s6g+gm2uTjqA4QlIMhveGMDH8jSnUE0QLcpyBEocwtLYeBl
   OD1XrKh0VTXx50/8YiPuipg3HOOuQHTzHv/X3gh2KIwXik77pf142FtnC
   7PcLyEEHVhewFIndGoiplU6LTz3/RaISPOux53aAvpzaj9nN2kO/I/wBw
   nvxcu0r30CE5nhpge5XnbEtl6s84iYn1nLYTZ7QBxqKtKvXTzPVkH9DIS
   FRsO06c+BV1MFGEmVxUn19GHKkPMxJUqDA7jGsTMqG9z4yBGLd7MGAuX9
   d2Ml9a71l/uTf0B64E55p7pV6mdzkAzBNXZRCNkj6Ynce/Bg7/j87I7Ih
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="25696345"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="25696345"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 12:51:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="37583581"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Feb 2024 12:51:07 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 2 Feb 2024 12:51:05 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 2 Feb 2024 12:51:04 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 2 Feb 2024 12:51:04 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 2 Feb 2024 12:51:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GxLrc5o0MgYi2ok/FH4VdylUQGnDDI7VLMq9w71CSn1Eag0PbdZL5U0Xrg7WXfzgOgCOs2TEUxuPs355KP+7tXzcdV10THXThiDhcjhmmWvg9GAxveQgVT7TBRxZTHLPqokzHHHUryBmG2YSj3Iy05WtSA5E//c/jyl8eMKJMoVRoiG4vFNxUc7aCZ8gwozV7WTsZBk0lovavjTmaaac2Lh/PiBnWD3EQ1fZAdJ4CFdgOBu154fHr3WH6NsYSMarWWEq145rjGIpaDZlAg7G6vDEtcWSD5s208nscnvmvIEw6te2ce/LBTZ7v8eX2p9evI307F6KDiwCLc6Rkz0p3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=heDtTeRh73H1TgLNcAOS55NauZMVyNR+qJaaty6Vzxo=;
 b=VClQDV80d+gP9K409bl7SJrDA5b3FaNn/OsWJxaKPjYBgh+z5kfefhrwQXu8VhIr5HlzNIiBLlX7Th+VWfnylJXTvd5JIYz2oxa2L9wVhDLUVxxQ4osylQ/iZCYQ8USOHHH2yzR82f9QVLOTT4x/nUrkMFqKgJ1hLTfyzq/QOsEMtcHkg/dGch82o+I3aurbNsp1oEpY2S1O809si1X0bDCPmmh7r0hSV1BYY5o5YSwGRdvdLrAU5XyMCVYPm5lfJqRXjcICDRjrAxtuxO8CdOEgMiGmM8tuEQSpNfk8akar9MfXARwB768jzY0c3BTXjBKGGCIf7HaY593OUUwCgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB4893.namprd11.prod.outlook.com (2603:10b6:a03:2ac::17)
 by LV2PR11MB5976.namprd11.prod.outlook.com (2603:10b6:408:17c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Fri, 2 Feb
 2024 20:51:01 +0000
Received: from SJ0PR11MB4893.namprd11.prod.outlook.com
 ([fe80::ad31:79ae:4d1:80b4]) by SJ0PR11MB4893.namprd11.prod.outlook.com
 ([fe80::ad31:79ae:4d1:80b4%5]) with mapi id 15.20.7249.024; Fri, 2 Feb 2024
 20:51:01 +0000
Message-ID: <0d030b68-0371-4460-8d76-cad129888496@intel.com>
Date: Fri, 2 Feb 2024 14:50:58 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next 0/3] Per epoll context busy poll support
Content-Language: en-US
To: Joe Damato <jdamato@fastly.com>, Jakub Kicinski <kuba@kernel.org>
CC: Eric Dumazet <edumazet@google.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <chuck.lever@oracle.com>,
	<jlayton@kernel.org>, <linux-api@vger.kernel.org>, <brauner@kernel.org>,
	<davem@davemloft.net>, <alexander.duyck@gmail.com>, Wei Wang
	<weiwan@google.com>, Amritha Nambiar <amritha.nambiar@intel.com>
References: <20240124025359.11419-1-jdamato@fastly.com>
 <CANn89i+YKwrgpt8VnHrw4eeVpqRamLkTSr4u+g1mRDMZa6b+7Q@mail.gmail.com>
 <5faf88de-5063-421f-ad78-ad24d931fd17@intel.com>
 <20240202032806.GA8708@fastly.com>
 <f0b4d813-d7cb-428b-9c41-a2d86684f3f1@intel.com>
 <20240202102239.274ca9bb@kernel.org> <20240202193332.GA8932@fastly.com>
 <20240202115828.6fd125bf@kernel.org> <20240202202344.GA9283@fastly.com>
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
In-Reply-To: <20240202202344.GA9283@fastly.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2PR07CA0009.namprd07.prod.outlook.com
 (2603:10b6:a03:505::6) To SJ0PR11MB4893.namprd11.prod.outlook.com
 (2603:10b6:a03:2ac::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4893:EE_|LV2PR11MB5976:EE_
X-MS-Office365-Filtering-Correlation-Id: 274ede71-7348-4e13-2057-08dc2430aa5d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gHaMcxvneq3jhGDKplqujWp7xPJwsD1x+3FHsGJVlo0K6VkoO1YWVpz7xxE6/yaVWuJBTbIUp8y6MEAHNahiIREq/EUMHmTihFRDFJTKwNJ5Dc602AodDScqg15mp7xOnjibu4PMkZ1BvZBDYkEzG7MrxUMjeWRx2tmXExd1RwMNtpmqs6VcIUxQqzsIJz8/1vU6pva4C/tCi51HdWMKDlCrhp2jaJYf0qyEDY8BOy8wiN5qD7951lXaRSvYp9xcTUQU/FIu7OZjjZKB68ns6QHGrDGxW7y68was3srlW2lL1kBmEvDeKcOZZKNU3wrFTcWsdDj1+sard8PYQdnIGkgHjRRHFqUw90ikB3LqfS5ryCNJZjdd/1D5bDrbJbFGydfW6eQP83EAt9rw0znK9Ljm6kadyBsQsWuUmFFjpR3UUiJDE9mXIVO7L1v/dRGlYI+dFDWRZLHdvj9C11fK2+/cWNVXly9ynUjTN8+daL6FWktihQZQaKtp9nkrPxBWBy/+mt4OHOT8snc6ARwprs+ym9reezdKIUF+xXxra6KWikzkPszR0qppfOeLkmLgbptFfmfewomz7StBWXNjiYmmpbSAlgiW7kg/R6hfGYIukY/HfRlp9hzE5qhDs0QieXrebCOlsOZTPOQt98z5tA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4893.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(376002)(396003)(136003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(31686004)(26005)(2616005)(107886003)(41300700001)(66476007)(38100700002)(66556008)(54906003)(316002)(6486002)(36756003)(82960400001)(6506007)(53546011)(6512007)(6666004)(83380400001)(966005)(8936002)(86362001)(5660300002)(478600001)(31696002)(2906002)(4326008)(7416002)(110136005)(66946007)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1pxV2hjTHV5NFhjRnc5QTZBQ0hET200VERMVElUWkxiRUJTdWFoMjJ3bEYy?=
 =?utf-8?B?VzF5QjJhSG5yMFRTTHRyRFZTTy9RdSs2RTg5UzU5R3lxTXBiU2NjbXhsOUg2?=
 =?utf-8?B?dGJTalBJU1NmZ1VGcFYzWVQzWXUxd3BzRmR5bWxqckNOYWlSZGdVNzBsbmpC?=
 =?utf-8?B?VFdxZzZUd3U5dGFXSnIxUWZ4ZHdQSW1aQkNRbk9HaS9iVURXWVJvZ1owTklx?=
 =?utf-8?B?SXJ1Vy85czRicHRkSUozNm9Pb2xsSnlQZmZWNlJOeC9USlRhOU5tcDVRRHg5?=
 =?utf-8?B?M3JEY2d3cU9lRlROVUZpS3ZZaVpCMFpMUHkzMUhUT2JxdXhMcWMra1JrU2pL?=
 =?utf-8?B?YWtiaEt4ck11L0gyNk5MZUVjaVY1Z2lpMGZ3bnE5NzNQSnYrRVpMZlZyRitt?=
 =?utf-8?B?c3NocG9lQU51WjJaK1RzR3JEdE4wNHFxbVpSRmFvQ2ttNUNMNlNDYlBrZExB?=
 =?utf-8?B?REYrZFdRbDVVZEdpZWR4U3JTaE95eHovbHBlTTJvVk5DbDlmclg2cEJmblpa?=
 =?utf-8?B?RzBJcS90SW9QNlJ6VkNDQlBhVlEwNDB4KzYrbno5SUFjbGJrVEpRYTN2RmdY?=
 =?utf-8?B?ci9UeEUvRlhIaWZidE9NdkVpMTNrZFNRWVJJQzhIeUVlR3hUekxMSXY0TFVu?=
 =?utf-8?B?S0FneDAwUTU0Y2ZvbjlMMDJrOW52Vk9MRFV6NUFlSjU2YjJBbTVVQjY0cVBM?=
 =?utf-8?B?b3UzWkNSbnYxUER4WXVqb3UrSEVWc2FsMVpwM04wbVJZVkdSdGVPSkt6cWRX?=
 =?utf-8?B?dEtrWFVvT20wZkpEVWRTS3hqVTRsUXdkOWkzeVhtcFV4OGh4TVdDaFc0a2tz?=
 =?utf-8?B?WnFRK1U4WGtGZFRZcnUzVDZqT1loZE8rSUp1emh1bEVsd3pEN296WnJBTGh4?=
 =?utf-8?B?V0VlRmJQOS9aaGlZZDZZZVVQelE1emhaaFB5eEI5N09aSFA0WDJQYmNkbDhK?=
 =?utf-8?B?YlI4bHB3aWhxMDhxZkhPK1FROUdxTExGTjhRMlhkSlhKWmRjS0x0bE0vR3p6?=
 =?utf-8?B?dmtGS2tLLzNDbHdNeDV3amMyZ1lDL21WblNNOVRIZ1BLcHNLNGtzUHVOaTd0?=
 =?utf-8?B?UWx5bjFRZ3UxREpSZ1pHMlBVV2RPc0g1d2Zzck1kQ2xOSUxyeTNNSUJTaVZB?=
 =?utf-8?B?aHVVcGNXYzB1ejBrQS9Sem9MelpJMVJWdTd5ei9WMmsxNU1nVUdnV0Y5eU5Y?=
 =?utf-8?B?cEZmUy81S2FxUXROSlIvUElFc3l2QWZUS29oTmtuR0NNMGRFMnRGM3hNdjd3?=
 =?utf-8?B?MlZtRkdqK2EyT01oV3BMR1hBN0tIeDRkb2tTUXRvb041TTJsdEtJYTlJc3VP?=
 =?utf-8?B?TVFJek9Cb3V0anlpMnAvTEF1am1GNjBiTTNJODc1NHZMSU0yMHBCQXd4NzJ5?=
 =?utf-8?B?OHFtUHhyNzM5TjNUU2lBelYxRnE1cXIycFloRG1GVEpuOVY2Smc3WWlrdlB3?=
 =?utf-8?B?amFCWFM4cWNFTzA4cmJFMnd5VWpuQkxDRDljcVdsYzJJSDZWUVk0cnVkd3p4?=
 =?utf-8?B?SWpXVGdldjhGZG5EVlpFZTFiLzZiTDd3Zm5KTjVTRFp3Q3F3cmh0MWVqQnVy?=
 =?utf-8?B?UDFGWXhOVDNSTktKeER2cndMRU00UjlKOTg1MkdmMUV5VjBkcVNPaFFGRGJJ?=
 =?utf-8?B?SWJ6NGVySVlDcnJPTmVNdHBjaGg3NlkrazlrQW95V1JHcW1xMzdQVmRIOFB1?=
 =?utf-8?B?OXU0NWhrSzZhckltdnMzd3hYMkVLdE5LekhPNWR0V2FGWDE5K2kwcC9hWTFy?=
 =?utf-8?B?NXhZS2RhMUxnS1NjVlhuUkdIS0ZUWEttMzVGNjloeEFWOW5BRjZIbk9VeSsx?=
 =?utf-8?B?UjMxaDhLTTFLNkdwN2MxY3FEZlhJay9yK2dmUVB0bHYyTkQ0ZEFvQm12RTMy?=
 =?utf-8?B?bjFMSWpIUVA3b1ZiU2RibDQvbWNBd1hkZlBqMmpacGtNdHlQUXJ4bXNsTEFt?=
 =?utf-8?B?MjdRYi8xMnpVSXV0YnRpRUt6Q2QxSnRTNUQ5RVNSa1BKTkNpdnhYREJyYjAr?=
 =?utf-8?B?RlAram9TU0NFeDBVb0pERnlnS3VWUU40SE9sL0lOVk9nKy9UMjhHTUlCcTBx?=
 =?utf-8?B?OGUyQkthY0swL2RRMXdDTndpckhORHNYK3dON1FNWTdrZDJiVFBxVndsRjRH?=
 =?utf-8?B?ZUhUMDNhNnpRRWxSeXFKaDk1eU1KNzQ4U0QwVXVPOHNyNHpNYzE5K1BnYjBP?=
 =?utf-8?B?WWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 274ede71-7348-4e13-2057-08dc2430aa5d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4893.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 20:51:01.6568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fja3dE733G3hxHyt6emRKOK8KGKWThIw64SMk4FA8uutFBMWapphcAioyCLuajVU5lGbJ8CNxKC1sseXazqoIo10Un1BhrlDs8H3S0MYa4I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB5976
X-OriginatorOrg: intel.com



On 2/2/2024 2:23 PM, Joe Damato wrote:
> On Fri, Feb 02, 2024 at 11:58:28AM -0800, Jakub Kicinski wrote:
>> On Fri, 2 Feb 2024 11:33:33 -0800 Joe Damato wrote:
>>> On Fri, Feb 02, 2024 at 10:22:39AM -0800, Jakub Kicinski wrote:
>>>> On Fri, 2 Feb 2024 11:23:28 -0600 Samudrala, Sridhar wrote:
>>>>> I think you should be able to get this functionality via the netdev-genl
>>>>> API to get napi parameters. It returns ifindex as one of the parameters
>>>>> and you should able to get the name from ifindex.
>>>>>
>>>>> $ ./cli.py --spec netdev.yaml --do napi-get --json='{"id": 593}'
>>>>> {'id': 593, 'ifindex': 12, 'irq': 291, 'pid': 3727}
>>>>
>>>> FWIW we also have a C library to access those. Out of curiosity what's
>>>> the programming language you'd use in user space, Joe?
>>>
>>> I am using C from user space.
>>
>> Ah, great! Here comes the advert.. :)
>>
>>    make -C tools/net/ynl/
>>
>> will generate the C lib for you. tools/net/ynl/generated/netdev-user.h
>> will have the full API. There are some samples in
>> tools/net/ynl/samples/. And basic info also here:
>> https://docs.kernel.org/next/userspace-api/netlink/intro-specs.html#ynl-lib
>>
>> You should be able to convert Sridhar's cli.py into an equivalent
>> in C in ~10 LoC.
>>
>>> Curious what you think about
>>> SIOCGIFNAME_BY_NAPI_ID, Jakub? I think it would be very useful, but not
>>> sure if such an extension would be accepted. I can send an RFC, if you'd
>>> like to take a look and consider it. I know you are busy and I don't want
>>> to add too much noise to the list if I can help it :)
>>
>> Nothing wrong with it in particular, but we went with the netlink API
>> because all the objects are related. There are interrupts, NAPI
>> instances, queues, page pools etc. and we need to show all sort of
>> attributes, capabilities, stats as well as the linking. So getsockopts
>> may not scale, or we'd need to create a monster mux getsockopt?
>> Plus with some luck the netlink API will send you notifications of
>> things changing.
> 
> Yes this all makes sense. The notification on changes would be excellent,
> especially if NAPI IDs get changed for some reason  (e.g. the queue count
> is adjusted or the queues are rebuilt by the driver for some reason like a
> timeout, etc).
> 
> I think the issue I'm solving with SIOCGIFNAME_BY_NAPI_ID is related, but
> different.
> 
> In my case, SIOCGIFNAME_BY_NAPI_ID identifies which NIC a specific fd from
> accept arrived from.
> 
> AFAICT, the netlink API wouldn't be able to help me answer that question. I
> could use SIOCGIFNAME_BY_NAPI_ID to tell me which NIC the fd is from and
> then use netlink to figure out which CPU to bind to (for example), but I
> think SIOCGIFNAME_BY_NAPI_ID is still needed.

The napi-get netlink api takes napi_id and returns ifindex, irq and pid 
associated with the napi id. You can then pass ifindex to the 
SIOCGIFNAME ioctl to get the interface name. So it is definitely 
possible without the need for the new SIOCGIFNAME_BY_NAPI_ID

> 
> I'll send an RFC about for that shortly, hope that's OK.
> 

