Return-Path: <linux-kernel+bounces-54500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9697984B007
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE7131C244AA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36DC012BEA1;
	Tue,  6 Feb 2024 08:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UjSBI0YT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D03F12BF14;
	Tue,  6 Feb 2024 08:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707208507; cv=fail; b=Ms91zboZcWLfCJZTBr8TIpfv/LSLYQJJRGMvOCFey0d6EjcLWVkMyyJk/k/jW6XCoEKqhflDWoFo/rAe0BrTHQnyQhksJv8/gMHJsTFNSmFn4VoZw2mGYB3J3WuOQgs5OptqQeg6W/FbdeFN7TSbP0fwDlddIPslIgXR/dzIW08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707208507; c=relaxed/simple;
	bh=BTT6SWhbbRoYsUw/Agc7Q3eU3mbHC+pPXGuk7WLskbQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TrNZYWBL0bm+/mQcVvwoRBzTMDTxhdZhZjZspG+q4cYqrYDET+rXCwrP4vsXvrUCHI4gwH5vWbtBRrR1neFkfYBerlBPLdG37IRG9hCXAF8OfIcxTfA+/S4jn8/u4anJjulIgizp/0FSda3vkV2MrHvhrq/2TQeC+1IZNzrTdc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UjSBI0YT; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707208507; x=1738744507;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BTT6SWhbbRoYsUw/Agc7Q3eU3mbHC+pPXGuk7WLskbQ=;
  b=UjSBI0YTXkC9RjwZrnJaOiIChovAwyKtQvAmktp/bQe0Blw/cyap81Z3
   tUvE1ViQ1ikiTUZFltfKrFX4cKftNywvOAWVdJ1tqBWGzxXGrjjzra7FJ
   +E9c7+cxqyIxtMySW3DUCTaJqr1aGa2bXyYryAmRNgEUXOfT2isHyhRxv
   YJtjDhoqjf3eAwpCqbleA4kehTLVc41SzfanvLGKA64quBmfNdVsf6HBN
   fDSWzv5F6CTY4UqkvPf+HsxmA0LIIEnitt22S4aNcZWZAmkobUxlpK1BS
   Lx0uR7Lduo7LF9YSMoRVdjQYmyMkzic13nP1aoK8frTMgmfxjqOosP3TC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="11436721"
X-IronPort-AV: E=Sophos;i="6.05,246,1701158400"; 
   d="scan'208";a="11436721"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 00:35:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,246,1701158400"; 
   d="scan'208";a="24207347"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Feb 2024 00:35:05 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 6 Feb 2024 00:35:04 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 6 Feb 2024 00:35:04 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 6 Feb 2024 00:35:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=myfjTp2Zh0hHMyBSgQ6juxSHwXCBYUN77nI2RWHJfCv2FLjCgJaFJzqsawmFn4s6po4bHGZ+y8nzYs13oDozYEn+yH8j8OliaNPEVplp/7TJztoauao8xo5f3IhLBFRSGlMVAHURF78bTM0nWTZzNH1dD8MyLFpyrAtt8OHO1/Tshb/c63Bs1lqxwJDp178FBjDnIINQc71hWNxtaxI5TNZKXwPhM5gYpzDNzt8wU28oFRdogwdpWnUQqFkG/vDrsLuQGptM1fNolwR673qUOXS5IHxZsj5XfdjSjgCeJuNcP8pUVD319BFWFzmxLCns6UOGmEvx/gipq4gWZpQlbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NO+4mFLEZKqwy03owlPREzxSEVoiSJlL5FT9vMUdwqI=;
 b=UDTkWl/7Ew6TGRiyYjFCkVcPAHyvoHfBR3ltSkw0PUgSBzvzyM4nmv3KSLl2IgTrTmt5vZ5Atj64X/y+w5jNFsqlXYEjgMtVKSdJX8gA3BKnbzQzFnWn2jVmt7HiQR8J5EHpx7Q4vBBO6iwB43llDkybb9q/YiE3A/pu73cMgTb8yNJYNtaxhp2RZUsx67Qzni5SZIq7LjDzUSg5ANz6HutMhzM8C+Udt2kJEWeDp08wJGrnxDJGk90hAe1BFoBulDF5zOBQ5GaDLZ0mEsodtl7q86injABcTrp5mrQDEKhiwIB6Nak7UjJz/CEnET99YqoOy2t4cWqPjC3+7NoQtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB6269.namprd11.prod.outlook.com (2603:10b6:8:97::14) by
 DM4PR11MB5535.namprd11.prod.outlook.com (2603:10b6:5:398::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.36; Tue, 6 Feb 2024 08:35:02 +0000
Received: from DS7PR11MB6269.namprd11.prod.outlook.com
 ([fe80::52c6:33d7:27be:28c5]) by DS7PR11MB6269.namprd11.prod.outlook.com
 ([fe80::52c6:33d7:27be:28c5%4]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 08:35:02 +0000
Message-ID: <b8140cc8-a56b-40f6-a593-7be49db14c77@intel.com>
Date: Tue, 6 Feb 2024 00:34:59 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/4] tsm: Runtime measurement registers ABI
To: James Bottomley <James.Bottomley@HansenPartnership.com>, "Kuppuswamy
 Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>, Dan Middleton
	<dan.middleton@linux.intel.com>, Samuel Ortiz <sameo@rivosinc.com>, "Dan
 Williams" <dan.j.williams@intel.com>
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
Content-Language: en-US
From: "Xing, Cedric" <cedric.xing@intel.com>
In-Reply-To: <85b7a4a679eada1d17b311bf004c2d9e18ab5cd3.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P220CA0029.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::34) To DS7PR11MB6269.namprd11.prod.outlook.com
 (2603:10b6:8:97::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB6269:EE_|DM4PR11MB5535:EE_
X-MS-Office365-Filtering-Correlation-Id: 67908461-9e04-4c6e-8097-08dc26ee8347
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nqlJA3w09oubg+pbQxpjjRnA/oyUKE3/Uhfh3E+s9WErwLQgD9iyj7y75JjrVONUHTx8xvsu8TvJTTrMPguFE/DBB9DU2OHozlYAn0y+f2yf+K6g1B7mBcifqg+xOghCul8XWeY+kowuVsVSWMRuDOeIz9OWCzPekiAPSwj07ie91Z8r0aoj1/O2hkt8TTSZOBa9c1AdPu49RLKQ9Mm4qzB9e73iKGo1+hvFhHnuyrXWNEYaVq1AG1CWbSfQ0YKK4B7l+rFO6t/UOlvvNy/Ax5nfkKUFoUBmsrlvXTBGct37Wed5Mj61CDyX2akZy5dhC0D4S73ZEysA6iTFYToGK7zfqAb6ofBwzB1kbfj72d/i0AN7+/6/hUmBSPGDFok2PjWcYWQRQ/9mdMb7ia+5XSw8vjyyaTXZzoPiLrdTX8bc11qlMCeBSFkRauklV3WkFMQh8TaV9XzfVsHZceXzTAcTJL+6RZFQdNx3sANHWsRyB6u6NEO6LjlkklXrlgqxEQUc2TOz45DWB7SGUlCRM7zvJ4g4Pququ0UrFdavVNAPL2Gil5GZnf0I26ULt1QQk48b+zhd4SjPHWpgf240zrjlyC4sDWop4WefM5nYDt+b+YUXEN6VyA9yx65I2eiLPGTD6dVNJO+vn3R9CShFaw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6269.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(396003)(376002)(136003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(5660300002)(2906002)(31686004)(41300700001)(83380400001)(38100700002)(26005)(82960400001)(86362001)(31696002)(2616005)(6506007)(6512007)(53546011)(110136005)(6636002)(54906003)(8676002)(8936002)(6666004)(478600001)(6486002)(66476007)(66556008)(66946007)(966005)(36756003)(4326008)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmdjK2gwbVJkSENCOStXQTNxWmNJck9OZ2pBaHl0L2UyQ3BpTVY4OEFvOVdQ?=
 =?utf-8?B?SGZTaUgzZWM4TEdIMGlqbVB2WmJTUHFmSUJRRDBQRWUxNHBjUmtQS1FBcy9h?=
 =?utf-8?B?REJjaVFkakE5eXlzNmYxYXdNazNqNkFrdVRucGVMR1hraUs3bW93QXlSeVRD?=
 =?utf-8?B?RnIrTzRiMzE5OEkxdDJ5c0w0bTYvZWVMb3IyNWNibVpReHhwMzg4VjA5TWsw?=
 =?utf-8?B?UWs0ckFzQThGZHNJRWR6clg5L20vaEowWGEzamNHZVNabjdZaktmbk1Cc29x?=
 =?utf-8?B?RVNCQTZERStNczNaeWNiczJwMi9ueDZkWk1kazlMZ2JjRmxHSllKR1ppVnM1?=
 =?utf-8?B?TTNBOTcrSmx4aFQ2Q1ZHVGZKUklOVVhhVFp3aTBRSjZqYjl2cVl5NVUybHgw?=
 =?utf-8?B?WWNGL3ZTN3A0cWR3bEhxbWg4UVFnNDlrLytQRktRcHVmbnUwMTE1QnJNZUl3?=
 =?utf-8?B?Q3lEUWtwNzBBSU5IZkdEaFBNcTNPSVJocC9XNkFSeWROdDMxNzE0bFd5YTZS?=
 =?utf-8?B?M3g2TkRvTE9FYzdqdkVhazhsWkRzMUxROHdqMFRlb1hpcTJiTzlaTVA3NzJ0?=
 =?utf-8?B?SG1Yb2hmRzRBdElraWpmLytEckdNMUtYZ3kwM2p4TXZlRmF0SlRTZ0VsQ3gy?=
 =?utf-8?B?MFNqRndhQkZWaHhJL0wzZTJMcFZmYUgvVjN1WGh2N0NJTWYwYWdXV3dsb1Jr?=
 =?utf-8?B?TzNQRkQyQTBaS2c5THFWVzhiRC9VZk1BNGNPOExseWJneGNLSkdCV0VQbmxk?=
 =?utf-8?B?dHo1cmtiTE5kS1NWY1VyZG1ENVV1R2JpQ0FlYnZ0NWVkKytnWlZuTWxxNHFE?=
 =?utf-8?B?ZUJLaEtpSE5GV1V3U0drbUdZUUI1ak9Dcm9YaTUwejByNlhvVnJXYUQyV3hw?=
 =?utf-8?B?bGd5a0wrb0k2d0d0RmxCSnVFY1N6cFE4a3duUjV6OFhwSHNLSDY0cUVINmxP?=
 =?utf-8?B?alp2TXkxSEFEMmc1eERKUWtlWHJZVThLcmRWc1dNaWpIbFZzdFFCSlJuRHZV?=
 =?utf-8?B?OUw3dGhnaXkreHRNdWNCaHhDQmlMMDNkOFVlOU5uVG9uY09ETXFLS1RjZjlh?=
 =?utf-8?B?NUxta1habkpXZmRrRlZlcEZER3pLci8xalJlZGdwWHNIcWNQWlQwODJDRjNL?=
 =?utf-8?B?K1BUdU56NGduOTVxRno1RURVcVpFV3JjTkkxczAyNGhxN0Vqb2NhMnkxRDdh?=
 =?utf-8?B?TnhWekNGcEIvQkxwbHNIRW15U0N0YnJXQVBNRi9Sa29zSlhaZE5kMU1SZVpJ?=
 =?utf-8?B?M0lNbU42Z3ZMckc4V0hBR09tUkpqODVIeDI2ZTdvV1Y2SFhlRURaZWhsQ2FS?=
 =?utf-8?B?cnFxWkVFN3Uzc1l6UTFxWkJnaHdEd215U0NVd3ZFOVBNZkV4SEpzeng3TUll?=
 =?utf-8?B?ck40MWJzNmZOQU1NSnc3dW4xYXFHZUpweXNrQU56NGYydDZuNk9Ya1MvZFdG?=
 =?utf-8?B?MTRDS2pCWmVoTkZnZFJCOHhvaURjN2xGcVBvS2lPVGtoU0hEaVl2MDVjTDJG?=
 =?utf-8?B?TTU2OXVxdis2TG1XSHZicDNneDZUa2NHR1BEQTcxOWxmSUJIcXd6d1ltcWJB?=
 =?utf-8?B?MlBFKzRZVThHVzk5MStnYTJXMndXekhsNzUxYXl4ektzZXliQ1RUaDgzQVZo?=
 =?utf-8?B?MWlpaFRQVHBWUTFEQjlWTG5FMGcvK3hkamJKWTJhdVlxWERIdkpPTXQvbHJH?=
 =?utf-8?B?QnFTaUNRY2NsTHdFVC9GL1BrS21FTVYvS1liVHJaaU1wbGRrK0k1d3BkM1p0?=
 =?utf-8?B?MW8yV1kvTStmNkpUdnVMS0o4YktiNmNRTUpjem9Vd0hXTHhKWUJNWWFEd0Fa?=
 =?utf-8?B?bnFaVkJMdzRMRWUySFA1Smw1anRiZUtISDFsQzZCTGhLMjg4UExCWForU2xX?=
 =?utf-8?B?alByZkNLanhIMDJpYXRtQjdBcmEyb2RlZVJwQ2w2c01nbGxsQnJEMXVsaVY4?=
 =?utf-8?B?NXRMSTN0V2hwdTJIb3UvNFNWUWlYSHVkMEhscVU3QXJhMmhidTBJdTQ0TnZC?=
 =?utf-8?B?TGVZVjNGSXRFOU5idnVsWjdUZmxkVTc2b0FPNDB5UG11R0ZZcVFQQ1BpK25r?=
 =?utf-8?B?SDBrck8zZ052d1FKNzQ5QkJGYkhUaFNpN2VXa3orK0VDc1lkUkJEQzhLUDJO?=
 =?utf-8?Q?GOh1yU6rMYwUHXUIo8YT5+SSM?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 67908461-9e04-4c6e-8097-08dc26ee8347
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6269.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 08:35:02.7964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bnVYdprOvUuVemnWdfksZBA8V9mMhPGRCBFcf1+rUla3Y6nOm3R82+gxk5UVM6PRLgum+F1VIXmZ8dxYmFYSgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5535
X-OriginatorOrg: intel.com

On 2/3/2024 2:27 AM, James Bottomley wrote:
> On Fri, 2024-02-02 at 23:13 -0800, Kuppuswamy Sathyanarayanan wrote:
>>
>> On 2/2/24 10:03 PM, James Bottomley wrote:
>>> On Fri, 2024-02-02 at 17:07 -0600, Dan Middleton wrote:
>>>> On 2/2/24 12:24 AM, James Bottomley wrote:
>>>>> On Sun, 2024-01-28 at 22:25 +0100, Samuel Ortiz wrote:
>>>>>> All architectures supporting RTMRs expose a similar interface
>>>>>> to
>>>>>> their TVMs: An extension command/call that takes a
>>>>>> measurement
>>>>>> value and an RTMR index to extend it with, and a readback
>>>>>> command
>>>>>> for reading an RTMR value back (taking an RTMR index as an
>>>>>> argument as well). This patch series builds an architecture
>>>>>> agnostic, configfs-based ABI for userspace to extend and read
>>>>>> RTMR values back. It extends the current TSM ops structure
>>>>>> and
>>>>>> each confidential computing architecture can implement this
>>>>>> extension to provide RTMR support.
>>>>> What's the actual use case for this?  At the moment the TPM
>>>>> PCRs
>>>>> only provide a read interface to userspace (via
>>>>> /sys/class/tpm/tpmX/pcr-shaY/Z) and don't have any extension
>>>>> ability becuase nothing in userspace currently extends them.
>>>>>
>>>>> The only current runtime use for TPM PCRs is IMA, which is in-
>>>>> kernel (and which this patch doesn't enable).
>>>>>
>>>>> Without the ability to log, this interface is unusable anyway,
>>>>> but
>>>>> even with that it's not clear that you need the ability
>>>>> separately
>>>>> to extend PCRs because the extension and log entry should be
>>>>> done
>>>>> atomically to prevent the log going out of sync with the PCRs,
>>>>> so
>>>>> it would seem a log first interface would be the correct way of
>>>>> doing this rather than a PCR first one.
>>>>>
>>>>> James
>>>>>
>>>>>
>>>> While we clearly need to cover PCR-like usages, I think
>>>> Confidential
>>>> Computing affords usages that go beyond TPM.
>>> Well, don't get me wrong, I think the ability to create non
>>> repudiable
>>> log entries from userspace is very useful.  However, I think the
>>> proposed ABI is wrong: it should take the log entry (which will
>>> contain
>>> the PCR number and the hash) then do the extension and add it to
>>> the
>>> log so we get the non-repudiable verifiability.  This should work
>>> equally with TPM and RTMR (and anything else).
>>
>> Maybe I misunderstood your comments, but I am not sure why
>> the user ABI needs to change?
> 
> Well, there is no ABI currently, so I'm saying get it right before
> there is one.
> 
>>   I agree that logging after extension is the right approach. But,
>> IMO, it should be owned by the back end TSM vendor drivers. The user
>> ABI should just pass the digest and RTMR index.
> 
> Well, lets wind back to the assumptions about the log.  The current
> convention from IMA and Measured Boot is that the log is managed by the
> kernel.  Given the potential problems with timing and serialization
> (which can cause log mismatches) it would make sense for this ABI also
> to have a kernel backed log (probably a new one from the other two).

I'm not familiar with existing TPM code. Per 
https://elixir.free-electrons.com/linux/latest/source/drivers/char/tpm/tpm-interface.c#L314, 
tpm_pcr_extend() doesn't seem to take/log the actual event, but only 
extends the PCR. IMA seems to maintain the measurement list/log by 
itself. Am I right? If so, why do we want logging to be part of TSM here?

For measured boots, I think UEFI BIOS has already maintained a log so 
what's needed here is just to expose the log somewhere in sysfs. IMHO, I 
don't think logging is even necessary because everything in the boot 
flow is static, hence a relying party can simply compare measurement 
registers against known good values without looking at any log. But 
please correct me if I have missed anything.

> If you have a kernel backed log, the ABI for extending it should be
> where you get the PCR extensions from, that way nothing can go wrong.
> An API to extend the PCRs separately will only cause pain for people
> who get it wrong (and lead to ordering issues if more than one thing
> wants to add to the log, which they will do because neither the TPM nor
> the RTMRs have enough registers to do one per process that wants to use
> it if this becomes popular).
> 
There's an easy way to solve the synchronization problem in user mode by 
applying flock() on the log file - i.e., a process can extend a 
measurement register only when holding an exclusive lock on the 
corresponding log file. A possible drawback is it'd allow a malicious 
process to starve all other processes by holding the lock forever, or to 
mess up the log file content intentionally. But that shouldn't be a 
practical problem because the existence of such malicious processes 
would have rendered the CVM untrustworthy anyway - i.e., should the CVM 
still be able to generate a valid attestation, that would only lead to a 
distrust decision by any sane relying party.

IMHO, if something can be easily solved in user mode, probably it 
shouldn't be solved in kernel mode.

> James
> 

