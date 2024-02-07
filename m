Return-Path: <linux-kernel+bounces-57004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4788084D2B1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 833A41F2440D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 20:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744C2126F00;
	Wed,  7 Feb 2024 20:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kwu6DaHX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1D785C7A;
	Wed,  7 Feb 2024 20:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707337030; cv=fail; b=ZsjuOM3m8iTh8crIaFyx4+zNgvaLeKza5oN+heZ7bk72Onn5V75VjCPDBgOoi753BVJJkeSSuI0XFIzALWJKP1Uu8IqQbRpiJlENFXavq6H+pk2ob/qWL/3c7NdA8txW46vhH9n66OOAabAXXJqzXK11KLCRaqTFSBVKx053I18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707337030; c=relaxed/simple;
	bh=yXsfYsv/oEFm9yeRKBscTrMH9Uv17sjzrASExda4nmc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hZyokIgfqV5tslnRL1SwhTA0TX8taMDeWx1edUjLUlnx6DhMZhd35tIWljMlMrvSndYTOTs0twGicu0MmBJBrktxDkJjk9mNU/EcNLcKfLFuk5Jk5Awfw3eJrrdADaj62gCil67F7+uf3Lm1M4/j1U+wrP7jNawkSRC+kyKkRL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kwu6DaHX; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707337028; x=1738873028;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yXsfYsv/oEFm9yeRKBscTrMH9Uv17sjzrASExda4nmc=;
  b=kwu6DaHX2BqCraCOnkhr6GF6wEnGqCf7AePIwe5cuFs2LnL/mEKsXjOE
   6PLz4RvZyK3s4Ypxy8pJaQqVgvKuW2qs/ABgjgtuxhv6Lv02m1Aq340hB
   TvIi/v4y32ZCxxovqFVl2J9dsyK1V8u4K0AY8ngnEWSBgZlgAHVXs7F7k
   bL/g4tLVGVsSb/k5Cf913ATW5J5rUlpQl/6EIusMMHO9LGS26qZKvNa5I
   XcnnLcpVSDst0EoSXSLu4+AiBkw5mowLc0arlY+ZkwqfmPET01iMVHeLE
   tjb5n0PvP01kOX5AO65XQl7jcPUba9jO7csIh5T4FJdTc59kHXh1kk3Za
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="1231087"
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="1231087"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 12:17:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="1426222"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Feb 2024 12:17:06 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 7 Feb 2024 12:17:05 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 7 Feb 2024 12:17:04 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 7 Feb 2024 12:17:04 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 7 Feb 2024 12:17:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aNSTLU/r0qCdGNXLPP1pKf6rw8e8Efbh2PfA5DS1wLnX9KKZQ3pZ6Xs8TpG7CpQyoCAsJ/eXaJubUF/7uqwvrRz9+7qIwNlHMIKNPwrqrzadtVqmWr38GJfoJ9ySKdUeuPbCIlKIodeIHJ1RQB/KzS+ni2s9IDh0QuTmPRngcXZrGDpAbwFV8+CQ9keWSltRWk1/3vO0XPFrdvoIrGTI5l/t4G1Y4G6V8Yyv5/Bc9ZI/hBPAXUTecwnIdNCIyJL8iHHWaFSdLoQrIC5Kkiyr8pfep3wgIKpd8zCyC51KQq2RW0VbPa+taHe65o7orw6de/uPtq6kJwp8kok3jfka1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a2eLwDRDSiDlmhOB89IOnm6+Cx7RuPAS3cTchufp6I8=;
 b=b0haq2FmIJhtNypkz9AQd3Z9jjTQiubiIZulXA14gSvQ3NCpmk+/5BU2QxeZKeeyESZ/q+zWgsHQIjFfGhgqhVAFnxbkSh9Evtc1WmalGwzfql85DtZvWgpa35R46RAffK/J3Zvsu/cgA0HVKBGYwA5l+wg4PlozutE2cAJH1KNwoyQVeOwsqJy90e1yFLY1VSypTLP4zoPJIOogubvdluHK0vNshdOUCodbZVbU/V98EB/k4fdurSzOVCnuiOmsYWknfWUg9kc5IimfsztynzM3BVjYGfCER9ptJEGcSGUm+yuR1q2E9GxLTHeTdlty67iY7PxX/EeeUS3o9/8W8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB6269.namprd11.prod.outlook.com (2603:10b6:8:97::14) by
 PH7PR11MB7964.namprd11.prod.outlook.com (2603:10b6:510:247::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.38; Wed, 7 Feb 2024 20:16:57 +0000
Received: from DS7PR11MB6269.namprd11.prod.outlook.com
 ([fe80::52c6:33d7:27be:28c5]) by DS7PR11MB6269.namprd11.prod.outlook.com
 ([fe80::52c6:33d7:27be:28c5%4]) with mapi id 15.20.7249.038; Wed, 7 Feb 2024
 20:16:57 +0000
Message-ID: <22088ed3-51a4-415f-932c-db84c92a2812@intel.com>
Date: Wed, 7 Feb 2024 12:16:53 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/4] tsm: Runtime measurement registers ABI
To: Dan Williams <dan.j.williams@intel.com>, James Bottomley
	<James.Bottomley@hansenpartnership.com>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>, Dan Middleton
	<dan.middleton@linux.intel.com>, Samuel Ortiz <sameo@rivosinc.com>
CC: Qinkun Bao <qinkun@google.com>, "Yao, Jiewen" <jiewen.yao@intel.com>,
	Dionna Amalie Glaze <dionnaglaze@google.com>, <biao.lu@intel.com>,
	<linux-coco@lists.linux.dev>, <linux-integrity@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240128212532.2754325-1-sameo@rivosinc.com>
 <c17a31e4fb30f5f9d4a337e5bd8d54cc6f99eef7.camel@HansenPartnership.com>
 <a255bc36-2438-41b7-b304-bcf7a6628bef@linux.intel.com>
 <42e14f74d3819c95fdb97cd2e9b2829dcb1b1563.camel@HansenPartnership.com>
 <1557f98a-3d52-4a02-992b-4401c7c85dd7@linux.intel.com>
 <85b7a4a679eada1d17b311bf004c2d9e18ab5cd3.camel@HansenPartnership.com>
 <b8140cc8-a56b-40f6-a593-7be49db14c77@intel.com>
 <fe1722c3618a8216cb53b8fd3f1b7cbb6fdff5a0.camel@HansenPartnership.com>
 <65c2e4aa54a0_d4122947f@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Language: en-US
From: "Xing, Cedric" <cedric.xing@intel.com>
In-Reply-To: <65c2e4aa54a0_d4122947f@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0044.namprd16.prod.outlook.com
 (2603:10b6:907:1::21) To DS7PR11MB6269.namprd11.prod.outlook.com
 (2603:10b6:8:97::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB6269:EE_|PH7PR11MB7964:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dea2f86-1f07-452e-a9e9-08dc2819bba0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tVif9LL97DcdOjIMSvw8XysyYOm5wEdw6d8oadrudnpqla0zaayeU3bdcOOfcNA9AsV35rx8j1RTHSg2ijP0aiUR4aBhJ/lD6ijh9DETSZTUx2bGFmNm/Mf+eFCvJYqZAI6YVyWhVrxkgAkRalVO/gnfI6lkb9LU1/ynohfJFST8K+MxHfwcpdFT+Vh0B5pPm+aK2AjJfhZVoTVeiWVNjJkTuETG1RqHingJx5CFyIj78nfkNTALStAntNcgFXeH+Db5XZklNvA3sK7MQTKhJ4+8DTpqq9JAAWwwju9KdxpepRxHKIsGFmAoHEYgZ5NXKvG50xMLyWup+buKHXY5mPWjq3DLb0Xpi5BSm4rtoL4vtiMiUCUoPm8ovBlYh3JcnJHO+m+J9itq5hEq+ZjSISgYYzjyn8lO1wY0NYlF7BzJbRhs98igQrStEINw9u6+k9rWNiwHQzAA3bjnjLTpQi+my2aPBz7vk4VHGxctyZs+TV2XMSJsm48LnZVz48kM0L50Z+j7g5Oy45VGHvqdSKu1Ra234yAReK93QXvc81cz9F5sx4gNHAsMu5HiZsEw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6269.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(136003)(366004)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(41300700001)(478600001)(36756003)(6486002)(66946007)(53546011)(66556008)(110136005)(6512007)(316002)(66476007)(6666004)(54906003)(6506007)(8676002)(8936002)(4326008)(82960400001)(26005)(2616005)(86362001)(38100700002)(31696002)(83380400001)(5660300002)(2906002)(31686004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3ZnMnI4VFZoTkwraCtPY3VSL0RSVy85T2tnRWNXZlllWmRWYmVRd210dlhB?=
 =?utf-8?B?MTVWQ2dmc0hYbkswZ3pGSThLd3Mza0RtbElNTVdodmxJK2Exald1VjhvT1NF?=
 =?utf-8?B?bmZ4SjlqOXNlTlUxZlY1UHNkblJLdlU3UGsva2VJaEd2OW5XZ0U5T1YvVkpm?=
 =?utf-8?B?bWxGM0Q2eHUwbm1lbFRVVDZmajFLVEpYb1IwelFIc2dBQ29GNS9XL1VkR2xa?=
 =?utf-8?B?ZEwwL2ZJWXFDcS9UWDJQVUpZTTR2Zk82ZFBoUXYzTHE0YWExM2tLSzl6UkR0?=
 =?utf-8?B?dnk0ZWpRN3RMeFp0VmpraHBRaE95OW1oVS9yVzArOGZZSC9FaW1YS2JXaVZG?=
 =?utf-8?B?N2laUGsrS28yeFY3N1pweWgzZjVNanlXR1BYZERTUmIvb3JPdkpSQUJCejBm?=
 =?utf-8?B?UkN0dlpqRDBYcEJBRU5sMUdEdVpENWpsSUluU0t5dWJtbmpKckNNMEF4aHMy?=
 =?utf-8?B?ZE9VMzlMU2tGdHVzLzdTRFM0NGE1V0dWOXpBbDBlRFRGNWx0eXlMQ2c3eGph?=
 =?utf-8?B?aTREM1M0V3JiZnhETVVDR045b3AxRXl6S0VxMldLdkdDVE1BVjZra2tpcWIx?=
 =?utf-8?B?SWF2QjhKZGYrYnU5V09mVVF3cE9MdUJERWpsTGVKVytlSFFlRHNCYWxGdzly?=
 =?utf-8?B?eEI3UEcwSGNtRS9iV3pCMGxRUXJsYVUwNGVhREFCSEEvQWh4amxXd0pxcCtW?=
 =?utf-8?B?WmtCa0daVEVwSEtyajNwLzdTN0VGekhTczAvenh5WTVFQjVmYlBvOUdEeTRG?=
 =?utf-8?B?Wnh0enFhWHlhc0c4cmFMRThrc1E1ZXpSRERRKzNwSmtpLzNDTWJBVjVwUGl6?=
 =?utf-8?B?Z2dpdU5uc2J2QTVoMFBQTVZSenhYWE4rcTlmVTlyVlJuVFJaUEtmTmEzRW1l?=
 =?utf-8?B?UmIxTjEzbVVwemprY2pQd0tZajdDOWhOSGlEMlI3Tk01Y3BtTm90R3duVlE4?=
 =?utf-8?B?cHVuOU9aZ0swUE53Rk1KS3NQVEtjays2bHM1Mmptd3JzYXIweHArcWJndzBU?=
 =?utf-8?B?UWhNaGNzWDR5UmZRZjdiOElaT3Y1NWZnT1FDTG9oTW1MUDlZanpCMjRsVm10?=
 =?utf-8?B?ZDc4OWVCOFAwRk10UkN3azV2U29HSWNXbDJsSGxYT2QxcnpFejFURytMaVds?=
 =?utf-8?B?T2NZWEY5dTZvOUtEeHRPQmVpV1NSb1lKSU5CUmVYVmhZa3JxUENFRjVFK0ZU?=
 =?utf-8?B?RFgzamxBMFByVVVjWFZMWXpiY2JJZHp5R2NHZWszMHFtdGJNVHRRdXNrc0Qr?=
 =?utf-8?B?SVpkR2x1dVdPNnE2dTk2UEw0b01TUlVaaWxKZnZHNzZLQXlWNnpNMUVNSmNh?=
 =?utf-8?B?dUJlTEtmTmhEblFuWG9Rbll5YXpoVFozQXhjaE5XS1dFS3ZFWXVVQW12SjEz?=
 =?utf-8?B?UWpKakNSK3F6YlhjdG1qbEVaQ3cwVHBWdnltUVJOQlM5QXBpaERaRmdBUTVV?=
 =?utf-8?B?eHJGNm9rdE1DTFNORnRueC9BeTZxV1hhNEpBMlBteFlRYUZ0T0NhdWlBbDEr?=
 =?utf-8?B?bEJEa2ZPR3JjaHhESkcyOVY0Rk1TMnh1bHdLMXV1clErRUVocFBuaDJOdWp1?=
 =?utf-8?B?b2wwaTREMEhDbzFKWm9PNU5lb203QWxTbFFiZG9JWmRsdDI0enByS3NEK3Rq?=
 =?utf-8?B?Tk00QXRXNTl2aGtiR2tTcEpXbHF2bE9mZFpwMUVjTHArU3N1c3ZPbWZCR3dM?=
 =?utf-8?B?U1loNVN5dTIvT1YvWEpZbEZzY201ODRqcFJDRTBDYlFsT3A1dXpxaE9uV2ZP?=
 =?utf-8?B?VVNicHZHQUovNi95MnpvRE1EV1kvR0o0dFQ1bnpQS1ZvWENpYXJUUldrc2Vx?=
 =?utf-8?B?dHgwU3FvVjlHMXFWSUtWbDIvQ0ZCeUt5aDVodGhQUUthTG1RVEJENy91MmFv?=
 =?utf-8?B?ZjVsaXB1VjA3ZWpSVXg0WnpYZmMvcWtnN25hQ2trWDZLRzNQOWZieXZyUUV1?=
 =?utf-8?B?V0xsVFhsOW5jcFk1QndNZHRSdXdCcm8wZENDZ1pRTm9VZS9YN0dwWU9nMkRn?=
 =?utf-8?B?MHdEZ0QzQy9DaWp4eDNxd05oV3czNzRzdzlEbXh0LzZPWFppV1JzQzVWZGNX?=
 =?utf-8?B?UGlTdlJiVHdZMXJrMUhjSUhXVGJLSDg2N2p4RzJFN2ZKbjBpamxBb3lId0VZ?=
 =?utf-8?Q?T9J8UDNUMlU5Ttg4Drs2GP/br?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dea2f86-1f07-452e-a9e9-08dc2819bba0
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6269.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 20:16:56.9529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XI2zGJEozEWSFsuUZg8EmxrnCa5cl8ZftaiMMv1NRf1llEeuqN9rHVy+ACcpiQNukuSF76S3vUqPRR319n7iig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7964
X-OriginatorOrg: intel.com

On 2/6/2024 6:02 PM, Dan Williams wrote:
> James Bottomley wrote:
>> There isn't really anything more complex about an interface that takes
>> a log entry, and does the record an extend, than an interface which
>> takes a PCR extension value.  So best practice would say that you
>> should create the ABI that you can't get wrong (log and record) rather
>> than creating one that causes additional problems for userspace.
> 
> Agree, there's no need for the kernel to leave deliberately pointy edges
> for userspace to trip over.
> 
> Cedric, almost every time we, kernel community, build an interface where
> userspace says "trust us, we know what we are doing" it inevitably
> results later in "whoops, turns out it would have helped if the kernel
> enforced structure here". So the log ABI adds that structure for the
> primary use cases.

Dan, I agree with your statement generally. But with the precedent of 
TPM module not maintaining a log, I just wonder if the addition of log 
would cause problems or force more changes to existing usages than 
necessary. For example, IMA has its own log and if changed to use RTMR, 
how would those 2 logs interoperate? We would also need to decide on a 
log format that can accommodate all applications.

