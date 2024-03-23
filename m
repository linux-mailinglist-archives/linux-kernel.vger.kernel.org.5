Return-Path: <linux-kernel+bounces-112433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE6A8879BB
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 18:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C266B21013
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 17:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1734A5336D;
	Sat, 23 Mar 2024 17:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ajfCZL3v"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33D453368
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 17:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711214659; cv=fail; b=U4QbYsFXL7lkR4jhwARqz3vVZWWDK9CnKCT6ZuRxKy82I9yRehvv89XIkXJTJnqZToh13QRYVuramseAO+OjzBhwPdTCLTeCUDYhBHXLzMZLrQdIojCfR98/nMoaKv2ZuGu76hfFPWFFBJL/B8Aw/M/ylCGNMmwNfYWiG36ybm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711214659; c=relaxed/simple;
	bh=xi4/iDpJwyNMRaxBF9IyEevIzqsOzjLy1rglQNuvS8U=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=imTTgftGoLqJ7tVq4OhsTV2r7BiOnhQhsPNMTRX7tLAnyC/NLWd1tUuUbCOdSa0rGo9Pi1wb5xS/PiVC5skvB7GFYqNBxZLjy2llCHZqIAmxzJ1vKSaEpZC35359cFV9JI2myyJvcLSLUtqNd9WsTlKDCuu2TcwwkUSIUFLVsN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ajfCZL3v; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711214656; x=1742750656;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xi4/iDpJwyNMRaxBF9IyEevIzqsOzjLy1rglQNuvS8U=;
  b=ajfCZL3vtWE/II+aHsaXqfhqEy2cwnMCu2tBv3s70WeXpPU+M6pEuVtG
   k0reco+8AwbBz8Qn/j6eXeL84WMuwU5WFWfkidhwZ3eQw55yPs3WtxH7Z
   2nim8BGEgRd4oVtyKg1vy/mjcAZ5rSZGKoy99MBEF46bJA4odM5C7+cb5
   8BkZOy1zTzAbzmwhUGkKJ2vOgI+pqdVY2s/pceKqrjLJ6XN/gD9Z+lz75
   AKtDpJG9kbj7Qx/fYcxioR+CVQbI59PE8fFz031NAPknnKxVJ4eQv7AE2
   LrRFhn+wET2m9xiuIibWSF40HYhfSYEVCRiH4LqzTwHlYdwW+hytwtVVK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11022"; a="23706879"
X-IronPort-AV: E=Sophos;i="6.07,149,1708416000"; 
   d="scan'208";a="23706879"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2024 10:24:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,149,1708416000"; 
   d="scan'208";a="15652792"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Mar 2024 10:24:16 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 23 Mar 2024 10:24:15 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sat, 23 Mar 2024 10:24:15 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 23 Mar 2024 10:24:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Je2ls0rYrq+6gLzIW9vrQQa+s64JWr/+7PYyMBHrPIQnwli9EcpkhMXCbzCBxYXGgnUr16BItNr0trzPgHTpb2o9Fcn30GUvpPIRaIu/doJJS9qZJAoOiDwWiLt8SHRYS5uXwvAJPoIEFjynR4GGt1xfbdTSLfLL2zNH9jljtbdgY6qvy/5uL/rN/OYzcXvN61IM+89YeAGMOo0M6/MfiEA9m+RGifQx/u1gT7pLQ+6cb0ehF+nJuQtZvHvBfw6eJJkivBtQwtDQ6jyAsH1+/eFNpYX9xKjvG7D764rikVC6yFXNoCrYBDVeii3c16XzHc6WFezFfnPqKrXW17RaCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E4JYNodgU0AMHPSKtujgoJD6VmQTHilfnpTnc6A4JMo=;
 b=O9uMxccPwvSlTnAVtw6Aeoj0FpttMLA7nFjGNI6CY0ICGHXhBGgRRWDKrIzqbzoO98m11fDj9mxF3b0UU3gKuFF2f3jur8BvrUAMKi8o/JhWVcWh90xMLpQHEoLFsrgk0AqD+uJlWBs68lnmgJndNREFl11Zh0UBTY6OxyuUX9M2GZCyXgd/ITwlLiy4JNgp0E0VH76ssLQal/91wrE8+w1qXknDlWZPeGpPKHFT/cVCDO5e4LCqojg/NUtum7zAJPvOQsv4RWw8JTgT5igBJfdjsJV7RIlRuRUXzljGouApKcNJYuDPKv7DRkiNBgGhkr0tYZie/PkMAy6V5aXzFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8279.namprd11.prod.outlook.com (2603:10b6:806:25c::10)
 by DS0PR11MB7631.namprd11.prod.outlook.com (2603:10b6:8:14e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Sat, 23 Mar
 2024 17:24:13 +0000
Received: from SA1PR11MB8279.namprd11.prod.outlook.com
 ([fe80::a196:98ba:164e:99f9]) by SA1PR11MB8279.namprd11.prod.outlook.com
 ([fe80::a196:98ba:164e:99f9%5]) with mapi id 15.20.7386.016; Sat, 23 Mar 2024
 17:24:13 +0000
Message-ID: <fff67373-9c46-4023-8af9-70e62b9ab97c@intel.com>
Date: Sat, 23 Mar 2024 10:24:12 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/14] x86/sev: Hide SVSM attestation entries if not
 running under an SVSM
Content-Language: en-US
To: Tom Lendacky <thomas.lendacky@amd.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
	Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>
References: <cover.1709922929.git.thomas.lendacky@amd.com>
 <fabdf811d27a2539d1d016f75d95910b9bca24c4.1709922929.git.thomas.lendacky@amd.com>
From: "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>
In-Reply-To: <fabdf811d27a2539d1d016f75d95910b9bca24c4.1709922929.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0180.namprd03.prod.outlook.com
 (2603:10b6:303:8d::35) To SA1PR11MB8279.namprd11.prod.outlook.com
 (2603:10b6:806:25c::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8279:EE_|DS0PR11MB7631:EE_
X-MS-Office365-Filtering-Correlation-Id: 0426ee70-b4ea-43b1-43ed-08dc4b5e0f42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N2c/2h2n8AHbmWIVAXbUXhk4W6H4mmnbTlNjJmwiowv7ijui9A9PwuRrvG7fs41wxbLDERtX3tk0j8ZCUZbqF1yzAIVRA9Z9D+brNYYp93QFNOwjveFxfAqlft1GTzxOBhHUlfF+VGYMcZeyBprI39S/HYZgvj/MOJw+iA4ysK+feR+9uKgA/HZvJ745nL2Q0tv4V/WAm+KngwUPNudY8TvZ2XbHL7tp6GIeZ8yKJFq2Rh6aGbeeQZBZLaqwpb257bBS2l2+MFYDF5TH5m3MUUWXVaSWYS4LA9Lyrjhd0CxFpVO53xTfdwVD9r/AjWkHb3KpdRKYudIqRgOgi7PFp+rWJsw0tyF7LBGsdqzaRYNp409Md7rkBwcDVtpe8mgm7vRohrDDLyjtH3ARNaWu95dGnf7JNPztwmgLYPJR9S3aIhzfREEC7ru6I4FXwAiDYLtoOf0sVHs4C2qVRQo446SC6FtiUNIUeIGGto53iu9asFmtLVGIaHilQ810JX9XqE7RlGGg9z+dO2MBTEq4r68UPv1W9Mp7lzP7yG5/XCjhpY93fk5+t/CmGBu83YfJBoBu4FU42q2WCDZKjjpbb7wxLZsYsRlQ0oQkEAWm8W5jBc8Ol3RSsXlVf6VXdFqPcC7ZZIORK/+9iXAI6clBk1PukR084HrqJ3M2iYToZ/g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8279.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmkzQnNRTkMwaENYMXljREViRm0xQWUyMC9wS3IvajZNRUM3QkMyWmtKVUk0?=
 =?utf-8?B?TzhXYjlBMHR5aHdHYnBZWXFOR1JjOTBMUHMwSU5NM1p2YmFha051cmc4MVl2?=
 =?utf-8?B?bU5xQ3V6eHd1S0trM050MzRONkVqYlNMbFRHekI3dElOTlloK3lKZ0EwTHlW?=
 =?utf-8?B?VGlvcm5lTkxXaVV3YWd1Z01adWtjT2ZTbUc1VmpzSXk5Q0tkV3N3djRDZnZJ?=
 =?utf-8?B?RzZDa0ZWN0I0RmRIaXFUZmFDL3FiS1pXQ0thYVY5d0laNWV1Z09lTE1hRTVK?=
 =?utf-8?B?QzQvcG15L1dVRVdRdE1Da1hJS2Vxem84dFpWUHJ0dVFTeGYrdW5KWmlXVnBp?=
 =?utf-8?B?ZnhJbTY5QmR6TTdhemNUUDE2SXZ3eVJyUitKYkJxRFFmNFp4NVNiV3ltZzlE?=
 =?utf-8?B?d2NYbUs4ZVJ2Tm9QdGdzeUprQ2EraTRhQW1pQ3RiSDU1NjlLN0xta202Zzdn?=
 =?utf-8?B?a2pKZlFFeU0xNi9NTUx6a2tkUllpSlZGZXFWdEZ4ZnltWUdrazN1TnpaM1di?=
 =?utf-8?B?aytyNkRDcDdiNFV5QXMwQ0F5ck0rMUlBaTYzTDZMVUI1RUkzcFlSSS9wUWxG?=
 =?utf-8?B?M0N1OEJnVmdsUWVzdVpyZHlBbkhzSWpCOG5ySkV1b3YzSWVkbFE2d2ZCc1Ni?=
 =?utf-8?B?N2FMb0xDd2phbjRlaDI1Z0M1d1VITCswK2MzVDNtUmVzalNLSVQ2dzlQRUx4?=
 =?utf-8?B?cDBKNDVQUVdZend4WVRobzVIcklkMU9RVkU0VlR3MzI5S3JaRkRsR2R3eGNO?=
 =?utf-8?B?OFh3QzlreHIzN0NscWI5ZHVtQzdYa1pOWE1iSko4N2djT2VlRGEyMGZteWxs?=
 =?utf-8?B?VEo4d2ZnL0RZMi9ETVNsNzQ0NWhVM0VWNGwxaE9HSWJlb3hOZ2thaHpOVGFG?=
 =?utf-8?B?SkhIMWxOeXZHOGluMGt4bXNremo3TFZ3YnJkTzladTFhNktMOGgvU3ZSNjMw?=
 =?utf-8?B?TVV4VG93OWdsMlZ6ZTJxV0FOdW4xWFFiNDJIRjc5U1pWbityUDZVRUFiRU9S?=
 =?utf-8?B?Sk5OL2hiUUt3dlVxSnNuR0gxenJUNnBCZnRpRzVDcFNFeEIyQUFXZVFFUjdU?=
 =?utf-8?B?alhMdEhpazl2U1BzbERxKzNRbVlBTHNnVFlXLzNiYUg2WVFKbE1HZkNxTGlp?=
 =?utf-8?B?dWlYMmxScVJJUGhOeE5wbFdYYnJwNU9BZUpONDhhZGVIUVphQSs2aUIyYmhh?=
 =?utf-8?B?WkNUZGVYRmR3TE15YmtEYUt2aUltUEZLWE50VW91Nm04UHFTcHo0czBSMWJt?=
 =?utf-8?B?RUxjbzBRLzNHQzAxR0tNc2l6eUo1eFEvdHE5U2p6K2J5MTdNNVlFVXVQZ2NU?=
 =?utf-8?B?ZmwzT2JaZFUvZHlST2pzN0hKQWtJU1ExTmZKMURrSHZkS3JkMXMyZm9LMjBl?=
 =?utf-8?B?WkpCcmZBMGo4NUZWY3pCdVJaRTlFUkRyc2laS0p2Y0pqQ1F0MDArYzJ3UFdB?=
 =?utf-8?B?UmxHeEJEajg0cHZsc1NjVXcvblY0MFV1ZmZKSDhRSjMrM3I0aHlkQ1lCTlpP?=
 =?utf-8?B?b2tUVW4va1JSM3BlMTRWV2pvOHR6MnN4VjA4M1RMeDk2c0IrQXh4K21PM3VT?=
 =?utf-8?B?TnBaNDgySmlaNzVyNVhRTUd6bnMwNWhNbFhkbUhKMEVWOVJTUWQ0ejFJZkVG?=
 =?utf-8?B?NHpUemNKeCtoUUQwRFlhMDJoZUZ1aUFFTGhSRFRqWkQzYUFJd2dJVkI0clpV?=
 =?utf-8?B?VlkzVVlSM0Nkb2cxMEZ3ZHdNc3RBTFJLd01SZEVFK3FJSkZUMGl6NG43MlpY?=
 =?utf-8?B?NW1SamtHcTVnSkpZUHNQS2Nhclc5Z0svLzUyY0ZwWElSQTFiQy9RM3NrTFdH?=
 =?utf-8?B?elh3SUlUdTllQVhFZlhObThxeXBnOXo0SHBMTFpIdDRhQnMrbXNLS1Exa0t1?=
 =?utf-8?B?ZWc2T2hseld1bXN5eTZKN1MvdTRWd2dYcm1Lemw3eDlZSUVqZzVocDhQeFhw?=
 =?utf-8?B?enhiQThvQ2wydURxL3o3cDFUSllpWU1RMWpVT3JYVlR2V3FhOXpwVVZ5c2ZB?=
 =?utf-8?B?b1FVUCtQS2V5cG5rdGVJellqeDBiVUJiNndyZEJxbnF6S3lYUTcwdGxKQ2tG?=
 =?utf-8?B?YVZXSkFLQ0JiWVl2VVgzcG9CVnNaK0p1eFlIR0RLNTN0Q3JxZitEdWNCZ0lD?=
 =?utf-8?B?SXNlWm5OVDdSWG1qaGJzeVFYNFNLb1ljR2QwQkkxL2lOalQ1YzRTTExvcm9N?=
 =?utf-8?B?bHNEWS96dWZyc2JTZzVTTkY0aEQ3SXkzU0p5UUt5aFQ0VTNSdU9RL21NV1I0?=
 =?utf-8?Q?nPI95KtCWXtf+w2UglqvHtNeideNDgwhWiIGQiSG2Q=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0426ee70-b4ea-43b1-43ed-08dc4b5e0f42
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8279.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2024 17:24:13.5799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hqQAbdr7QgmjZC1Yz9wTUWnj9dAwajtcns30z7nPCEgnRGAh+TIBF7phjk4NUHXLczJdVTacVlGjCYjWuG+saonahLLaP+1xz7dgzgeebjDqgZfpxYUsFX79Hibu4y6a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7631
X-OriginatorOrg: intel.com


On 3/8/24 10:35 AM, Tom Lendacky wrote:
> Config-fs provides support to hide individual attribute entries. Using
> this support, base the display of the SVSM related entries on the presence
> of an SVSM.
>
> Cc: Joel Becker <jlbec@evilplan.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/x86/coco/core.c        |  4 ++++
>  drivers/virt/coco/tsm.c     | 13 +++++++++----
>  include/linux/cc_platform.h |  8 ++++++++
>  3 files changed, 21 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
> index d07be9d05cd0..efa0f648f754 100644
> --- a/arch/x86/coco/core.c
> +++ b/arch/x86/coco/core.c
> @@ -12,6 +12,7 @@
>  
>  #include <asm/coco.h>
>  #include <asm/processor.h>
> +#include <asm/sev.h>
>  
>  enum cc_vendor cc_vendor __ro_after_init = CC_VENDOR_NONE;
>  u64 cc_mask __ro_after_init;
> @@ -78,6 +79,9 @@ static bool noinstr amd_cc_platform_has(enum cc_attr attr)
>  	case CC_ATTR_GUEST_STATE_ENCRYPT:
>  		return sev_status & MSR_AMD64_SEV_ES_ENABLED;
>  
> +	case CC_ATTR_GUEST_SVSM_PRESENT:
> +		return snp_get_vmpl();
> +
>  	/*
>  	 * With SEV, the rep string I/O instructions need to be unrolled
>  	 * but SEV-ES supports them through the #VC handler.
> diff --git a/drivers/virt/coco/tsm.c b/drivers/virt/coco/tsm.c
> index 07b4c95ce704..2efa6e578477 100644
> --- a/drivers/virt/coco/tsm.c
> +++ b/drivers/virt/coco/tsm.c
> @@ -64,6 +64,11 @@ static struct tsm_report_state *to_state(struct tsm_report *report)
>  	return container_of(report, struct tsm_report_state, report);
>  }
>  
> +static umode_t svsm_visibility(const struct config_item *item, const struct configfs_attribute *attr)
> +{
> +	return cc_platform_has(CC_ATTR_GUEST_SVSM_PRESENT) ? attr->ca_mode : 0;
> +}
> +

Instead of directly checking for CC flags here, I am wondering if it would make
sense to add a callback to vendor drivers and let the callback decide whether
the attribute is valid or not? We can't add a CC flag for every ConfigFS attribute,
right? For example, privlevel is not used by TDX. If there is a callback, then
TDX driver can make this attribute invalid for it.

>  static int try_advance_write_generation(struct tsm_report *report)
>  {
>  	struct tsm_report_state *state = to_state(report);
> @@ -139,7 +144,7 @@ static ssize_t tsm_report_svsm_store(struct config_item *cfg,
>  
>  	return len;
>  }
> -CONFIGFS_ATTR_WO(tsm_report_, svsm);
> +CONFIGFS_ATTR_VISIBLE_WO(tsm_report_, svsm, svsm_visibility);
>  
>  static ssize_t tsm_report_service_guid_store(struct config_item *cfg,
>  					     const char *buf, size_t len)
> @@ -168,7 +173,7 @@ static ssize_t tsm_report_service_guid_store(struct config_item *cfg,
>  
>  	return len;
>  }
> -CONFIGFS_ATTR_WO(tsm_report_, service_guid);
> +CONFIGFS_ATTR_VISIBLE_WO(tsm_report_, service_guid, svsm_visibility);
>  
>  static ssize_t tsm_report_service_manifest_version_store(struct config_item *cfg,
>  							 const char *buf, size_t len)
> @@ -189,7 +194,7 @@ static ssize_t tsm_report_service_manifest_version_store(struct config_item *cfg
>  
>  	return len;
>  }
> -CONFIGFS_ATTR_WO(tsm_report_, service_manifest_version);
> +CONFIGFS_ATTR_VISIBLE_WO(tsm_report_, service_manifest_version, svsm_visibility);
>  
>  static ssize_t tsm_report_inblob_write(struct config_item *cfg,
>  				       const void *buf, size_t count)
> @@ -336,7 +341,7 @@ static ssize_t tsm_report_manifestblob_read(struct config_item *cfg, void *buf,
>  
>  	return tsm_report_read(report, buf, count, TSM_MANIFEST);
>  }
> -CONFIGFS_BIN_ATTR_RO(tsm_report_, manifestblob, NULL, TSM_OUTBLOB_MAX);
> +CONFIGFS_BIN_ATTR_VISIBLE_RO(tsm_report_, manifestblob, NULL, TSM_OUTBLOB_MAX, svsm_visibility);
>  
>  #define TSM_DEFAULT_ATTRS() \
>  	&tsm_report_attr_generation, \
> diff --git a/include/linux/cc_platform.h b/include/linux/cc_platform.h
> index cb0d6cd1c12f..f1b4266c1484 100644
> --- a/include/linux/cc_platform.h
> +++ b/include/linux/cc_platform.h
> @@ -90,6 +90,14 @@ enum cc_attr {
>  	 * Examples include TDX Guest.
>  	 */
>  	CC_ATTR_HOTPLUG_DISABLED,
> +
> +	/**
> +	 * @CC_ATTR_GUEST_SVSM_PRESENT: Guest is running under an SVSM
> +	 *
> +	 * The platform/OS is running as a guest/virtual machine and is
> +	 * running under a Secure VM Service Module (SVSM).
> +	 */
> +	CC_ATTR_GUEST_SVSM_PRESENT,
>  };
>  
>  #ifdef CONFIG_ARCH_HAS_CC_PLATFORM

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


