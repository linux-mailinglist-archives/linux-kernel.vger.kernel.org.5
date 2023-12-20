Return-Path: <linux-kernel+bounces-7619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A9181AAE2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 00:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D95911F28685
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C126A4F8B9;
	Wed, 20 Dec 2023 23:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YLipYn8g"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47244F8B2;
	Wed, 20 Dec 2023 23:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703113503; x=1734649503;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gv9tT9KOvj+v1VZrR9RSWCebyvndE3WEfs3l9KawhrQ=;
  b=YLipYn8gzjcKF+BtkGMaloStfvi60NiDuRqPo1Dd4tECJxa/Hd38l8P6
   Z7/TJwohhHJcdEcPSpkceNSGRgf531IxT9wr0aYBnyD71CQL+A319naZe
   KW/NuU7ta4Nsmg85jFArR6+Ivi4I5iyoZQi+hqymJjglsTkZzyOOqHPqe
   e/P4hE+tzYspyG4XSuKmDYQAwdKAMQzBY2ETYE/3FAmq4k3YC6Ojbj4GJ
   O4VS8J1krSGYfb8Eq695syVOQKKkmHqT+f9+XMWlS4JItFg7loN9DE5m3
   ljSRuMVHR1iXOeUEymvNRvSHF2n+TQV0e5MmjqTXL5FR0r42g/fwE3iTq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="9269595"
X-IronPort-AV: E=Sophos;i="6.04,292,1695711600"; 
   d="scan'208";a="9269595"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 15:05:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="846895803"
X-IronPort-AV: E=Sophos;i="6.04,292,1695711600"; 
   d="scan'208";a="846895803"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Dec 2023 15:05:00 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Dec 2023 15:04:59 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Dec 2023 15:04:58 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 20 Dec 2023 15:04:58 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 20 Dec 2023 15:04:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TyXx3oQxFiGL99ivNH+iFgEcakXl3gOvpJmtT6wXr//l8IZc7oBUy5Ts08/dZsHf84iTYnRMp518u8N0DRu2kGYGbG5TJAys0Vx3sl6wQ6I9j7Gc5E3KVZY7OPYsmzHThspX+uaWQ28dSi6cxc0ATy/Pn0tHvCqDMJPofWw9f10u3S3yBelmYuq7SwgC/wrv6rcJ79gpNAy5ee1QbB9gtxxaMrNdbOsODBalMVX75xp5q1Lwglw33hTPggVKyvIsKrt+ijJrvaUxPD8cZ8np+ibYWgX9tsuh8l6nE/bdmB97glXyfwxeSTEEriAUR/sxNoaKURTVAW2yy1/lXD0KyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lpqo59JeEc+Vu8vPXe/uQu6oKGVTc7ey8pNb1oKo03w=;
 b=Y/va3zBYakkqTeUFRxe+AnxV0gL50VcbWeMz7XRERRD+iZDS9DMuQ3YoPo2U/hUY+zp+KfgY6vMEbIYDd9Whi4PIbEr1kZj7n1b941fjB2Z+GIE+bFtfpDwVvpocNhI/RPqdV6M2QV8apdIoRoiMtPxsTKF7iV/0mD19E/cVC9eDaiPG/sHi8ec+t8WJ1HxCDeSE5o2/6niifb5UkJ5PDUVTlEmN++A8ijVk7xzleP0eK+k6gSISQidl61lYChnz+0bqxQH/ZvII6mo9b1jiV+4F7qAh4WTSOojajEokOcAIb8qEwJRwoJc7fQJ0PBRdR+ach2cBAuP/lJ/Sved4XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14)
 by BL1PR11MB5448.namprd11.prod.outlook.com (2603:10b6:208:319::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 23:04:54 +0000
Received: from PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::ea27:681d:ec93:3851]) by PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::ea27:681d:ec93:3851%5]) with mapi id 15.20.7113.016; Wed, 20 Dec 2023
 23:04:54 +0000
Message-ID: <18c39111-1cee-429d-a9ff-ff98e1ed27dc@intel.com>
Date: Wed, 20 Dec 2023 15:04:51 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 12/12 net-next] qca_7k: Replace old mail address
Content-Language: en-US
To: Stefan Wahren <wahrenst@gmx.net>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Stefan Wahren
	<stefan.wahren@i2se.com>
References: <20231218232639.33327-1-wahrenst@gmx.net>
 <20231218232639.33327-13-wahrenst@gmx.net>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20231218232639.33327-13-wahrenst@gmx.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0357.namprd03.prod.outlook.com
 (2603:10b6:303:dc::32) To PH0PR11MB5095.namprd11.prod.outlook.com
 (2603:10b6:510:3b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5095:EE_|BL1PR11MB5448:EE_
X-MS-Office365-Filtering-Correlation-Id: ab2006b1-4a8c-491e-de23-08dc01b013cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RQEQ+yNxi0TQRn034FE9EhEyF4LjvxM8cr/CIygPO7T1w9bu8W/a6J5I+8SHIGO7R93gYL9+jSdbOjmQxUzH4EpvcPcCtii4p6I8tEq9S94fcjcHYCqjUapNILnm9SUPHbfLh6/2WMbBFZ2GEJmJ7USje0hs1Z0zu28JrdkGl3Co8M/wSbWzA1//FyYrMvAEQVwcrnkK75vYJGf+PQXPdDWGlMbpkKtWkNv400aqYVOKHquFSLQki5mLPRjqvaVMvkSwaAsJOHwSLDLaVviR9Nfu3fVf5t/gqamvr06pskRsVyE1anJf7+EUXeQ197/rPpEd1MQX4fw43NKcaKZDXP9R9KPFljjPVZPBG53cF95UI8PVo1/P5Aa03fRsrDRHqpl6Y3xJpxcGgv0t9cWt1kreWIGAlpbcUp7bK3lXlnkbfuzTI0fbU6Ei7fbwy7ZOplGcB7hCq26kEjjYx55dT1AWTo/JLQGbvkMHJhEmTOyOKKzFkT54b0UR5xsz1saIs6KYX3MgY5+6ad0wRKemqSA3JiSuXkUqNMZiYNltrgIWJXm5meBpGO5KnVZUN/p+/zlTbZ1a1goLC329u++UvWr7y/KTAIVI/ABkOBRSSIrET9N6CNxnifFK8XYRmhPgtVnTcQUI/66DUuBUzFtcAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5095.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(346002)(376002)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(31686004)(4744005)(53546011)(4326008)(26005)(5660300002)(6512007)(6506007)(8676002)(66476007)(110136005)(83380400001)(66556008)(66946007)(8936002)(6486002)(2616005)(316002)(478600001)(82960400001)(38100700002)(36756003)(6666004)(2906002)(86362001)(31696002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXoyRFdZb2s2RitMc0RyY3RvcCtpSVRCcGZNQ2orNUk5akwzUXhoTmlxVENy?=
 =?utf-8?B?QVVqWm1wbXA4WkxWenZHekdZQTA5VVdCVUFxM2ZRaHM1NXdRMlI0TjZXa2E0?=
 =?utf-8?B?TnE0aWo1VlFuc0pQN3krKzRldWk4Rm84L3ZodXFQZ2d5Nk1nTmcrdlZ2anZo?=
 =?utf-8?B?TFVKNlY1Z3hsZUdtWTJmbUFYMk1HQlBFeFJWV25DWDNsTHNuSFQ2b0g2VExv?=
 =?utf-8?B?RVRMZkI0YkJsK2tla0Y3SmxIMzcyaDVyeVhpaU8xYlNRMVZxbUlDMkk4bmNm?=
 =?utf-8?B?VEYvYnNZaUtFS0x2bmdBU2laZzV5Smh6SXFoMDdwNDV0ZExZK0ZCMlJPUkFJ?=
 =?utf-8?B?bUxoK1pFdlZueW5jTjk4VzBhSVFaQXRtekwzSVo2MUY3S2JSa21qS1VRdmNq?=
 =?utf-8?B?NGRXazBLb3VWNjVNWWR5eVpnWndPNVlzNEZ6WCs2cGE3NnRqZ1VMaFBmRjNY?=
 =?utf-8?B?MjZGY2ErVUFyVlRLYWViSENTUVZmN2FwTDBLMi9TUGFielJLYUFjZGQxK0hk?=
 =?utf-8?B?UUJxdHRlU0JMMERHV3F6eHhsVkVpS3dzeXNvL0N1Zk1CWVo3OFBQaGdBVGRJ?=
 =?utf-8?B?ZGprRGxXMjRGMkRxNkl1MDlPY2E5MHRNMWVyZ0lQRHA3RU9ibDg5eDdzdU9M?=
 =?utf-8?B?R0tvY1hYQ2s1aFpuYmZzaU5ySmFvNHZTc2NPRWUxNDhnS25QWUhOaUxuU1BU?=
 =?utf-8?B?QWU2aWhQQ1J0a1ZGNWlhclZRUGFBM29UT0cwZmRXZmMyZDZzRzFJZVBrcXJX?=
 =?utf-8?B?U0J4QXJROFA0Yk9LblpNbElRdnUyWHZ3cUQzY0U3RDFvbktONm9LSUVwTDlT?=
 =?utf-8?B?Rk5tbTNSTnY5YW9qbTRiazBDNDVFcFhBd0gwYnhwSFJBdDhYVmtvR0Z4cEFW?=
 =?utf-8?B?NEVTeEdaMkl6Q0hMblE1Z1VNTXBMZ1IwV3lOc25tSXhqSFEyMlAwZUpod29J?=
 =?utf-8?B?dXdLTHlhRDgySFlHQTI1ZGhkNzRJQ2hQTUNlcC9xcmtJNFBZK2ZEalhRa1d2?=
 =?utf-8?B?bkRhNHE3dzE3Rkw4cHF2amxxQ2pUVlpMNytGN1BxcXhNcUNVZzhEc01IVi9X?=
 =?utf-8?B?NnQ3U0YzNHlsUWhqUEt4cGFibjZxR3ZueXBjZ3JiUGZGMnVTaVJYUlBIK3Ru?=
 =?utf-8?B?S0p5cVljbysrODNZY0lEcTZ3SmsvRmYxbVBSL3RlRE1xUDdJNVFDU0tkcGRV?=
 =?utf-8?B?dWdid1Q0TEM5N0d3bTkvM28wZkY0Q1MvNDBrL042QnNWNS90MmNBbkpQaGt4?=
 =?utf-8?B?NW0vT2VtOFNEVDRrQkxNVzYrYVY0ZklMSk1QdWhaaWZMczM2ODZQNGhXZGEw?=
 =?utf-8?B?dVpnVHk3V3NaMk9XQ1dHZFRIR1pBaHYxQ3JXaVhiRFU0c0pwWG5mSGJ3d0Zk?=
 =?utf-8?B?ZndBRHprdTdyMmVpWkxyYW9rOWlDSVBQZS9Xb2c0bmswbmloTjFvSVEyVGhx?=
 =?utf-8?B?UUZqVUVtRkxCcExyMGFKMUZNM3NEUEZtQWdkUlgyYUhwRjFrNmF6M3VaczI5?=
 =?utf-8?B?ck5XcjArVDkwbjlQV254NWhCWFdpS2IwRWVIWDh0QkNFUHdjL0JrUEFvTEpy?=
 =?utf-8?B?ZEFOcDNmVFdCM05lclhvMGROb3NGcFJmMmNzVWRHU0g0TkZiak5ndldxbm0z?=
 =?utf-8?B?MERwRXdaR2lBSXJ3VkJNT0I0OFhkTWltWXdTTzV3cXJiRzNucDFSYVozV0F4?=
 =?utf-8?B?YWtIVmhuZWE2RXFNZ2VRZTFVQjRSUkt0ZmhBREVlZyswRU12a0ZRM1RhVmcy?=
 =?utf-8?B?ZlNNZlpDb3FxbmY2MkxxUk0rUkNvSWovNC9mdzJFVzIwQTdXZGJoY0UvMUUz?=
 =?utf-8?B?ZWN2Z2dPdnJIYjZidFJ4NXkzbmVsSyt5cDFMOU9MbFFNYTYxNGZkVnk1RjNJ?=
 =?utf-8?B?VFQwdlA3c1o5SU43disrTkxQakNlRjZ0OFRiaTk2NENoVGVwNnAxNzZ6ejlo?=
 =?utf-8?B?ODZuNTdjZXFnVnVtNTdjSHJlbnZlN1JWSDJvZmxPQzExMmRSWldzbmtsR2FN?=
 =?utf-8?B?bUMvazFCQVI2cGVqcXFpcDkzUDBmZHVQS3gxNUg2R0ZFRktWSXNJSzZFUlBU?=
 =?utf-8?B?T2VlcHc5TE8xZG4rMHhIWDgxTG80WDBMbVZ6eVJrak5nY0dWcVlRaGtDSy9P?=
 =?utf-8?B?eEJaK1d2MVBmSldmS0I2RDhJNmJlZCtRU3lPRDJ3R0VLcm9rNERacVFuNXdv?=
 =?utf-8?B?b1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ab2006b1-4a8c-491e-de23-08dc01b013cc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5095.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 23:04:53.9839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x1XsMc5RR6Bxhrs4weNudwz5sSPczElTCoSPy5edieJdwKNkrtNvVzktPkmoIoCm6B4HBuhy8iPIxKuVuTSSew+smf4w6apo7D2Hs1Uq86Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5448
X-OriginatorOrg: intel.com



On 12/18/2023 3:26 PM, Stefan Wahren wrote:
> From: Stefan Wahren <stefan.wahren@i2se.com>
> 
> The company I2SE has been acquired a long time ago. Switch to
> my private mail address before the I2SE account is deactivated.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>

You might also consider adding this to the .mailmap so that
contributions from your old i2se.com address would show up to the
gmx.net address and people might be less likely to try and cc the dead
address.

Either way, seems reasonable.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

