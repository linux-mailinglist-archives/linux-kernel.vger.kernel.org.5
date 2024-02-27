Return-Path: <linux-kernel+bounces-82773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDCB868977
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 08:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C69D1C211E0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 07:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9237453814;
	Tue, 27 Feb 2024 07:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SLrDeGZu"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C57C2A1DF
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 07:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709017356; cv=fail; b=lMFvNKztPlnqIfpdLx+T9XRZaWjxtpFOxXVTzYlfVy860OIxKzr4xBc2dNR4WGbqsMLSVTwgZDyMbNcK3XWK2LNhaxmSjcdI+vG93CW2kq9ZOVJKDp0J1ejCUGq1iTV5A6pQpseK1g81+fup+HSPxayMo5BtI0jMd1bPkZQCEgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709017356; c=relaxed/simple;
	bh=3ef8EO8fW2bmTWzMWodhS6rsBYfvBN3FW3cGgbeuK8o=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eiHAFIns8QTRTXxJfbYGNbUMvhLIH2omp+a2OpqhjlijjDz8Gm8v8nVQA2IbBNvJoPwvj9DB/gMYzNV5ilvpz+97I/t7HCXJUzBFM8Dt+QHCtUzSwlGz0cv+1ppBRK3Yef3RRYZjJt3cSKObYg0OI+CWb+hoFiFG5RmYdCKRqDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SLrDeGZu; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709017354; x=1740553354;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3ef8EO8fW2bmTWzMWodhS6rsBYfvBN3FW3cGgbeuK8o=;
  b=SLrDeGZupdciK4sMPrxVxTadks3Ed0I9tkbjPXR+2iFye0jAU5dMosAp
   PsPttnfcPA3uK/T/btCoIiN4RWZWuXV6v5KroDwbEGt812nQS22AIP+mD
   UlOcaf4dUCNhnS8p7MXvkEg33KRVtinHvYgR/EyQR8pI7ssvepNdxKoqO
   L0XUsClnDUQc3goKiGNIeq/FrtgZl4AZeb7axNmNojR/xWyiMiu3ozY5q
   Miq85oWKJo28W2yk+HY82xqaVrKpHiPw5Hj5K0wHZBsyiPsHoxRAZHGGm
   YhcNg1vwZRgTkeuy2wKOA0oLk+jhufvvXRv2pCTVIlx4yp5DhTW4qxL7R
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3214314"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="3214314"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 23:02:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="6813138"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Feb 2024 23:02:33 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 23:02:32 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 26 Feb 2024 23:02:32 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 26 Feb 2024 23:02:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bS2w/+DbuWudaT9eCYIX6FXIPj98gnOlPupuofTPKW5+DdPsz3JLjBo4UHDk5n7+Soh/a7dCnSs3SOHJdAEFc0lnToFtw5Po0F7cO15/9Sq5BjV/dqPv2V0a+2cou6ikiHNbhpAodmkZWAseW02wVZ4hJdKoRj7I2CownMiKxcb0M3Vmb+BMO43lZxa2OsE+C11MAKK7YQEQB9mZUok9BRg0xABj1D4hxqMeMSeUewseGu/j9iWrXHn2OxhYiv54Lq1FCNUnjMmTSMxP+HVqj7/qiTkth3FeF7/ontj7JZ8T52iQXT7MbilnwirUet2EftRiglntXvYJIXt8MKsanw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XQhoBiB4hfzp+Crz/4NMQoHCXVgkgsRAe/IOt/Csnmk=;
 b=MxpDCUKQL4m+zuAAhJx5CyShGT4Gx8F1ZP+FshLlEGHwqW/LG7vpUoGSpFC0J62HwQDL2DPaiR/4xhRIup9sNGBF1pmZdvdrGIMPu4wfNM2RjQMqxwRCORi12jtCMqSpeUD8hebMvNuqV2E3NHVbOSoVcb/fbePJm99KuFguEHMjo3FzW4sb1Nw7HSBxj5kG3PnOqU4yLeR2eCKK8l1RKzAVUzzMxXjtdNsQkSXsxM/PEiCaqr+q0mYa+SHIKbYAEsH3QL5ldXwXvuj2OnAwwDPgHvOU0YQVxmexFcJyPurni4kekSR/7E0MP5OUrS1WYMuPXfStNoajh+qlMYSNmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by PH8PR11MB8062.namprd11.prod.outlook.com (2603:10b6:510:251::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.24; Tue, 27 Feb
 2024 07:02:30 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::65ce:9835:2c02:b61b]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::65ce:9835:2c02:b61b%7]) with mapi id 15.20.7339.022; Tue, 27 Feb 2024
 07:02:30 +0000
Message-ID: <6ea0020a-8f4b-44d1-a3b2-7c2905d32772@intel.com>
Date: Tue, 27 Feb 2024 15:02:22 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mm/madvise: enhance lazyfreeing with mTHP in
 madvise_free
Content-Language: en-US
To: Barry Song <21cnbao@gmail.com>
CC: Ryan Roberts <ryan.roberts@arm.com>, Lance Yang <ioworker0@gmail.com>,
	David Hildenbrand <david@redhat.com>, <akpm@linux-foundation.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <mhocko@suse.com>,
	<minchan@kernel.org>, <peterx@redhat.com>, <shy828301@gmail.com>,
	<songmuchun@bytedance.com>, <wangkefeng.wang@huawei.com>,
	<zokeefe@google.com>
References: <CAGsJ_4zera4+bWuXHKjdU3QdiR3sqcUQB3gF08DPD49OCT4S9w@mail.gmail.com>
 <20240226083714.26187-1-ioworker0@gmail.com>
 <9bcf5141-7376-441e-bbe3-779956ef28b9@redhat.com>
 <CAK1f24mdwjz2J5VmeYSDwb4jMbrXUVCSF_0pOcWSVt1cfa0FhQ@mail.gmail.com>
 <318be511-06de-423e-8216-af869f27f849@arm.com>
 <CAGsJ_4z+0yXUDYwxKNAqYwxAAYpfKpKd2u_dVTDP3b-KPOQT1g@mail.gmail.com>
 <19758162-be5f-4dc4-b316-77b0115d12ce@intel.com>
 <CAGsJ_4wx72KOazANBvnGcjdZse8W9+PW5_fspP9=QuX3X_7msg@mail.gmail.com>
 <3c56d7b8-b76d-4210-b431-ee6431775ba7@intel.com>
 <CAGsJ_4xu1kz5VD-CcNFvP0A1nPKDojV8Gy1HPvNKuQ_RAw=26g@mail.gmail.com>
From: Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <CAGsJ_4xu1kz5VD-CcNFvP0A1nPKDojV8Gy1HPvNKuQ_RAw=26g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR03CA0104.apcprd03.prod.outlook.com
 (2603:1096:4:7c::32) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|PH8PR11MB8062:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a3814ff-974e-448d-daec-08dc37621077
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EJAGDMK57seJI5022K8eciNMlv/IVpER5RjQDuAE4rSJOd1C4Rbwj+1QlBPFpt8FhUXeAM4LMU8zCOcKqg6+KFSV5zUNCOSfc0yQr9BJ3cCW/MBNEHFYUF2FMX9l48TO84j2kDOt+acWLmYZfFtiBbErSSIH4eB+W4+if45RIlDaYC07zW1tOuJJrEbUJCfM0oeindeCwqGL0ijcwb/NoBITHzBBLp8pQw2NVDSG0j3TC5HWZfSAIZo6T4Y1poeJf5r/q4udjgDWpdKtWsJJUJJLUtxh9/vOiS1VTNaA2ZsXw37QHzdiuhrXDpHcxSQZeSI2gqzgzdS0sr8aSeIBTCkwpv+K+9t7Hhqwilm8FwBR/q4ImO9fDRFOL2yUQWbx+3B6c36g0royVtPIFWsQN2SNitsh0mTgZARCpuhitSkf5twKXgMog5eqE4WQ9Vh/slQDdrMdqQiG42fbwwVXyc6jp3RZCkoOX60c2FgT5mWi3M+ciegVWzbl6NNBQ459E/M4HZe5O3DByD6MkzBPp8Dm/VGijM3H8G608+oZKy+BCreis6xmM4eeI9/MURPUJd33xfv2v0UhITID37u0Nf+yNDTT4hGNMw8Vg5sHJVmrWdbdM7y+3MzLwTxtUbEm6VjFOFnOYOlw9/xCYZwYuw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjBhbmxyck9ERytOVTFsbzdjMzNDUmFiU1J5U0NzU1FDdCtrRHN6N3JWNHBR?=
 =?utf-8?B?dVJVRmV5TXYyTEQwdjUrNGJ1NExxTUhXaUtjbXZqS3ZKR0RjenRQVEJMc1gy?=
 =?utf-8?B?RHhZOVpEbUlkKzJ1THpuVm80Z2NCWlNFVTNKYzJobXZBOW1OOXFhTFcxVTQ2?=
 =?utf-8?B?ZWs4cm5pNzVOOEJjbVlySTcxOHdPT0JNZXpNQWZ3VTFJcHh2WDFhazZTUFJH?=
 =?utf-8?B?TmtUaWZ2NUx3SFZGczRrOGdWb3hLWWNFalFYNTZFRGIzOHB6NjM2a0tmRFp2?=
 =?utf-8?B?bUdqa1dicUxOZlpnM2gvRUZCUUgyYVlSa3FqbVJTSmt5MU5ybzRIS2o2NlRo?=
 =?utf-8?B?UEdVVXp4OW1wTzM4OUxueWJ0WnJmRVE5SkhCV0xWTkh3eVNpUTlSRDlxOURn?=
 =?utf-8?B?MG96Y3NySVRBZ3lXSEU3K1l6Nmt3aUY0QkZEck9nYjR4c3E1alNsUGN4UE9E?=
 =?utf-8?B?MmtJbVZKOFMzTUNnaWVMa05XYVl2cTQraVlaTWN0d1h6TmMxNTZJVEJvNG5C?=
 =?utf-8?B?bVNCQ2lQbkd0Z0x5YkR5OEllYVFZU1pnU3AzVmhkQ3huNHhvb2ZpSjFTNVJW?=
 =?utf-8?B?d2x3MGVmSDV6TkRaczJmWXBtMW1LdU94dTZEdkFNaVIrMHBCMk1NZ05vaytF?=
 =?utf-8?B?RnBCTnhMOUhTSm5ROU40ZHVkbC96ZHBZd1o1YklBK3hZQmZLcUh5VXNSdU1Y?=
 =?utf-8?B?R3ZWaW9hS1Q0aEpvVGw4d3YwMXQva05sdU85Y2VPbmF3eDRVaVpRTkRiNStQ?=
 =?utf-8?B?MGdnK0plYVNKQ0llUFJjZEtVbzltcGJSNWdXdlJtc29yS2NRRjJNNXF6ZFhl?=
 =?utf-8?B?NGtwN3dCdUV6VGdweEtPMndadVZYWitPZFlic2gzNGtMZ2ExV1pQbVp3U2U0?=
 =?utf-8?B?Q21SUEpaazNPZWlzemdzSlZXZE84eEp6NlhyV0gvMTNDdHVDL0x2bUt4UWdX?=
 =?utf-8?B?Y2hPOGhrdjlWdDNnQm1GbnM4RlowTVRJR2ZaRmR6OU1pWkdsZUtiQWpmVmxa?=
 =?utf-8?B?eGZ0WVhMQ1k2aFk0dm9VNzZJMnA5d21uRU1xSWJmK1lwSTVDMWorR2dhODM1?=
 =?utf-8?B?TzF3UnBtQnlQKzB6NzQwWURPZ2hCZkxwaVBITWhFQkxyYnAweUVPMnl4QnNF?=
 =?utf-8?B?Vnowa3RmaGxPNElwd3hCZGJoL3Q3eVV5NE8veUtsTTAzei9TcitmUENCTDVQ?=
 =?utf-8?B?eUtBRDdWWHBoNUJtbXNhQis0UXN2dWJrc1h4TXcwQTJPVVpSdGhWcXpId2FZ?=
 =?utf-8?B?VHJ3ZjVDcDhPckdXT2NEVlhXYWdXWkRiUS9FL0VoMGUwMkhUL21ZOWxlQ1dU?=
 =?utf-8?B?M0lBS0Z4b2VuakgrM3RZSnhybkl1T24zWUVCWm9uTnRhNXdVUTNGUmZBc0xp?=
 =?utf-8?B?VzFoTUJteXl1bUh4UzQ4bzRKMW1TR0ltQ0M1aVVrV1lWQU9rOHJuL3NPVzBh?=
 =?utf-8?B?UXpnMFBOVkFQNkQwaDR0RlRsZXBveXdKZlBab0NKZTdwT3grL0RiR2xjN1VE?=
 =?utf-8?B?dlVHZlZSZEJ3K21Ib0diajk3amUvdUkwYVRTZG1iZlR6bUY0ajBvbVdZMWZK?=
 =?utf-8?B?NGwzdU1oaXllT0h0cVNnRjJmdVNOSnlIakZhRXdKRG53N2gwM3RXbHZYSWJK?=
 =?utf-8?B?aDVsRWk1RHRuK2x2dDlpQjRvcEhBeklVMURYRSt0dDQxRjNaTVpkUXNGelpV?=
 =?utf-8?B?c1ZMcXZnWlRGR216YlhwUFoyTDMwTStpaXNvZ3FuN0Q2Q3JDUnBEU3FkRkNx?=
 =?utf-8?B?cEswVG9uOTV3UkdLVDRaQllHWXdPZ2FZN1l3djdqOTdWL1Myci9tNXlvRnYr?=
 =?utf-8?B?TjFINmZMUnBSU0owdlFSL1pCQVIzQ2NBbkpzUUVVdURFdXNnYTFXaXY4cEEw?=
 =?utf-8?B?WVU3aGJrcTUzODh3RTBBZ20yTHBLVFFsS2RnbkNwbGxWYTF2MFBrTFlHV0dF?=
 =?utf-8?B?STZQaU5pYXprLzVVdml5N1NDV2NnWkVTNmtrc1EwSmlvR0hKQXJwVnRzSm9v?=
 =?utf-8?B?N0xSTG5jNXlZdHhoUnBpU3FCMUZ4MmI1TXRsU2JCcFo5cDVZSzltdWIwck01?=
 =?utf-8?B?ek5kRlhLenlVamZpcmt6VE1VNU5FQmsxR2RSYkVGenh5SlROamJ6ZkFuTDdn?=
 =?utf-8?B?dGNCUHZHdkYzY1NJeUtLRnNJRGRRVG10SHNsZitRaGpQc0x3UUhTRUZHVlVO?=
 =?utf-8?B?QUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a3814ff-974e-448d-daec-08dc37621077
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 07:02:30.4812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /u5mZ7tfTF6gTsNQl0lcvNNRaIE/6u3yUKLJU8s8agP905iOaqI0J98VTjaKgszk2+3xzKsoEC4U3vsw900lig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8062
X-OriginatorOrg: intel.com



On 2/27/24 14:40, Barry Song wrote:
> On Tue, Feb 27, 2024 at 7:14 PM Yin Fengwei <fengwei.yin@intel.com> wrote:
>>
>>
>>
>> On 2/27/24 10:17, Barry Song wrote:
>>>> Like if we hit folio which is partially mapped to the range, don't split it but
>>>> just unmap the mapping part from the range. Let page reclaim decide whether
>>>> split the large folio or not (If it's not mapped to any other range,it will be
>>>> freed as whole large folio. If part of it still mapped to other range,page reclaim
>>>> can decide whether to split it or ignore it for current reclaim cycle).
>>> Yes, we can. but we still have to play the ptes check game to avoid adding
>>> folios multiple times to reclaim the list.
>>>
>>> I don't see too much difference between splitting in madvise and splitting
>>> in vmscan.  as our real purpose is avoiding splitting entirely mapped
>>> large folios. for partial mapped large folios, if we split in madvise, then
>>> we don't need to play the game of skipping folios while iterating PTEs.
>>> if we don't split in madvise, we have to make sure the large folio is only
>>> added in reclaimed list one time by checking if PTEs belong to the
>>> previous added folio.
>>
>> If the partial mapped large folio is unmapped from the range, the related PTE
>> become none. How could the folio be added to reclaimed list multiple times?
> 
> in case we have 16 PTEs in a large folio.
> PTE0 present
> PTE1 present
> PTE2 present
> PTE3  none
> PTE4 present
> PTE5 none
> PTE6 present
> ....
> the current code is scanning PTE one by one.
> while scanning PTE0, we have added the folio. then PTE1, PTE2, PTE4, PTE6...
No. Before detect the folio is fully mapped to the range, we can't add folio
to reclaim list because the partial mapped folio shouldn't be added. We can
only scan PTE15 and know it's fully mapped.

So, when scanning PTE0, we will not add folio. Then when hit PTE3, we know
this is a partial mapped large folio. We will unmap it. Then all 16 PTEs
become none.

If the large folio is fully mapped, the folio will be added to reclaim list
after scan PTE15 and know it's fully mapped.

Regards
Yin, Fengwei

> 
> there are all kinds of possibilities for unmapping.
> 
> so what we can do is recording we have added the folio while scanning PTE0,
> then skipping this folios for all other PTEs.
> 
> otherwise, we can split it while scanning PTE0, then we will meet
> different folios
> afterwards.
> 
>>
>>
>> Regards
>> Yin, Fengwei
> 
> Thanks
> Barry

