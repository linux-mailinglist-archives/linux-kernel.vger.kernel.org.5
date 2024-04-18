Return-Path: <linux-kernel+bounces-150038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FA38A9978
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAED21F21E7D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9605615F410;
	Thu, 18 Apr 2024 12:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iNHix+fM"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFCE15E5B2
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 12:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713441964; cv=fail; b=qbKhBc6Zgapsdo4r+R7u9vtFa2FPkrcEOluUsskflwxfIBjyWSJVASX/Et6D+RX5UGWlvBrWyq06rQYjabHVFhuYzGkSxl22KY8OOcTrZABLHLBAnYNFdC/0ifGy2k/WQt4Q2MVLijVS+lyq3yso2ZnH0pkgVM7GomonBNPsduE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713441964; c=relaxed/simple;
	bh=5bomFa9lXv5Z43gx8vWRwtZFs8vLTmn1tidGh3fld3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q2Vn5Om5NyhJZz4WbNZZKkfK6EnWAlKpmx+eTUVXD0ckYqLTr2Emz6KeJt4qIFdgceyJsAfDzoXUaTiXQsT1AtVPhqWR+/PshPXVIHR8a0QVm766VsrRlK6eikhXTUKNdLZ77qq4tWGMXZm/3TuywcuUbPlXAuvN58495Khavdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iNHix+fM; arc=fail smtp.client-ip=40.107.244.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dVlAGcTrhwBnKloHnrGEmt5hwVCy3Sj6Zeon8M2kHBYFVJNKruswPdmRfU4zrRF+DpSOFIrIsXBKskZtSQiOQgfuDfIbvLErOPMT5uvdkebgVZHVUqkNW0VBZdydDI2cg27W9Nru6Bl4noMNL3aSM6KZxGxvrd6fHwD/Hy77jFFiKiAzc9EuTReswi1c77Jr+PCe34erb6/9ezrk7RGoyMZCE0GtGyDWZIBGlCAFlsA9vbwD1A5H6rL2l38Wgmp0MS0crbEZdhyqcxKFIjxizdGWI2qHzMBoY4uxxmyXaEFQOpGjEmw5SeXN5NZOIjqGKmvKdNLgBtNvwDQMjvaQbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QITnup423DPxcArR2zfby0c9mBpl/s/nXjrq3xDTUIM=;
 b=J2Pngmn0jXmFM1iAkfINIVefvP03P0aAdM1or/+noWobOdQhxNikOZf5JZDLA3NUBPKpAXTTyrtHePW9Vk1PCxPXkv+d3hqvCRVDNNj9rAVsbxT6O/inUvV9jQCuz+ZKVM+aFUcpBGk00xmhky175DeM/OJ/inTX0T9XXmpwfPooSXU/zRgipKb6Yb4Sh16jU8osoq+GdmIO+OxCRyelyJBNFGuvWcjIrIExDF3y3Z+08hwHfeFgX5reFsxp1RAodm0ChEpSMyTg7SBucAeFh2n4DVeu4rHPECFlXO9LkgGCWyIBVLfKvUOpAWEfI9lIi7RTVKOw//j/j/7tmYC3Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QITnup423DPxcArR2zfby0c9mBpl/s/nXjrq3xDTUIM=;
 b=iNHix+fMW5dz/honntxAI7pO4p2OoMZWjonLY7yaQl42oA1nY8EV5wsuK2xQYCf7+967WBfHLMc+IQ44pZXNrljm0PdfyhLBqc05KHaELWbXcYZqiuUfrF6eUshvY2X4cX6ml6ass8G3+c1HkIDbIJQqltVadD6ya7uuYbuz/MA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by SA3PR12MB7974.namprd12.prod.outlook.com (2603:10b6:806:307::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Thu, 18 Apr
 2024 12:05:56 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::7ecf:eda6:7dc7:119]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::7ecf:eda6:7dc7:119%7]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 12:05:56 +0000
Date: Thu, 18 Apr 2024 14:05:49 +0200
From: Robert Richter <rrichter@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	linux-kernel@vger.kernel.org, jgross@suse.com, tglx@linutronix.de,
	x86@kernel.org, Kim Phillips <kim.phillips@amd.com>,
	Robert Richter <rric@kernel.org>
Subject: Re: [PATCH 2/4] perf/x86/ibs: Use CPUID region helper
Message-ID: <ZiEMnWaHkn99_oyW@rric.localdomain>
References: <20240403153508.7328E749@davehans-spike.ostc.intel.com>
 <20240403153511.75CB9DA0@davehans-spike.ostc.intel.com>
 <20240416151242.GGZh6VaiO2gC4ej2BT@fat_crate.local>
 <f142e9c4-4829-4ace-8757-485246ad3572@intel.com>
 <20240416174850.GEZh66AmnDjrLxoXaw@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416174850.GEZh66AmnDjrLxoXaw@fat_crate.local>
X-ClientProxiedBy: FR5P281CA0045.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::12) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|SA3PR12MB7974:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b6d9e4f-2f36-429a-7b12-08dc5f9fe6c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	h3jev8kCsJ95xCfaDI5gzaGHssuK4c0IAVFstqfZo5bgpAGACQD+UrJW0R+CiSuOhN0BLlM62AMMi0Y39a9+R6AnoSspFuzqKTfI/1V7bMMUaDzgJS716VTcxUt+gxkkY+ZFjRv3opLVU8PvcqLYxX/MdawJFhLCpe/w86BrOEowjzfgJ7ZiCKSLA6FKmkpIJSsj+e/w6DgeXlDGIlNo41uvSXrBwBJx+LFoekIwt1MFLVbw69bSb/70rluJtTIW2eT9repGRg45vQQg09rrzoHBuK/gy7Mgw8U6ESgAhkDm94vcXyGEI4PIgw6D/0uIDsn4V8q1lmfZ3nlQrX0ppcgBzVSzzdFeSM8/izttrSucnfHWhfDYT990V94qzTU/5Ui3ErxFJa6JYGg3xki2k/MZWHcXvU5dBIXrVK7ECkCGe81fpgbrkR21B52BXAWbmKU7mpxesx3u2uEV787Mynpf+FnImN5eMUWy7XHCqIOKkSW5NRqNNdk2B9BCoPi2NmQ/E388ZpZwVbmjreMDxuXJT7uDjiUgoN1cqPcN7HyUAz/pb8kQfv8iA/WOw0US3ld2UaY7wyXkn32VUekvqE9SxhrDttUBSbyTn82Q+347SFIe7TL9+U4H7gpaWbhzanWkVw3vLkbG0X8IlJdfjWCFf08ZlTNW2vx4MnYAQ2M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cpD/o1f8xc1D2kAwW96ixjVJwVNEGWmY3FixT1NP2c5n356AYNBtnMs9PRw0?=
 =?us-ascii?Q?eGvJv7d1qOIi8EgctiPhZyKAA8OH+D11c7S1L1g0VAMOLWiXDyDIVxifANS1?=
 =?us-ascii?Q?c3VVl1hAZF+r9OwQMUtPJU6R4PmE46aWoQKBPtRdcqGlfQqdGW2+4qQTck3K?=
 =?us-ascii?Q?7yrsVaJZqPraTtKAZ2SmfEq6rTFL27VUkbu51seKF6FCGA6V3kaInXPtZe2U?=
 =?us-ascii?Q?31EfyDDX8B+ttxLOynKi2IsgXziOJ6VjyJxJ0YtSqdYpsMEOmR2GEyZJ820z?=
 =?us-ascii?Q?5ozHcS9X3QfBL+EMTNi1O02PNhrkmdfUTunKUx1JVsWQ1lnKqvfcKVwU5w6v?=
 =?us-ascii?Q?vsBOlbAEoXFk6u/6HNPQNfIX5frfoVVsKwVABpvTAnACEd9CH9UfOee3F8UG?=
 =?us-ascii?Q?TNWdTrXXpKHwdB9RQ/9vrCRxDNC3N195AMd8D1P0bpbCtaAL4GWQZSL3OE2o?=
 =?us-ascii?Q?X3/MHbIubrtyPmCyTW2BgQHZh8oYv+vX7a93Hwr8zT3s5LRRRWzzdyHaN+RR?=
 =?us-ascii?Q?HptrCUIL1qR6Aj71AiqJbV1Zx1Ee8KyPzYAtqmqMvwLmkIoSPAPNe3OTSH5M?=
 =?us-ascii?Q?IqKGElHpK0FOK2RVbarsrzFPOsQWzROAxbjUdr3zc2JU+NGgJEuar5f5E1i0?=
 =?us-ascii?Q?yoLf6wkapH5lhffG4t58Qt1VLyiPe2foYpswFq/RPlBUpNzqRIa35+fbUnJo?=
 =?us-ascii?Q?qDms22I0SUl61D+ob1wrPEaWhn3bO4AmhmcaqBD/yfAkPAiS+lhFtVI4v+iR?=
 =?us-ascii?Q?oz+ohpjCnvmQCgVNKusAsJ8HDRei9IBSfQlcqyXevT8ZSgX637A+AmHUVgPr?=
 =?us-ascii?Q?m5ntlsJAP7hJDT43ypek4QXaG7YfMRP3Mzi5VSFoUEtavNIe+oKW5xZQSChm?=
 =?us-ascii?Q?CUPeS8AFCKpcK1v7JubC8fMu+zc+sY+Me49emIbo1fbOeYOijhURoaBzytVB?=
 =?us-ascii?Q?+IU4joirGTHoKfCDFJuCPCxshBH3Sil8Rd7oF8G4FVH1krwmrJ1tf+GdLt6I?=
 =?us-ascii?Q?onA8AayqG/nmyGxvLsEciq15VA14izCsfV7pyQh0ikSLoSP+clduBMmsMcuK?=
 =?us-ascii?Q?5Fw3g9lGfH39mJNpqpvRNEpRKDogz/3+AW2XzQt9OBSr1s6+l8/JinCRLE8g?=
 =?us-ascii?Q?Vc5sJdmPpLn38rOv0fcKT53zJBv8ZuzeFsf6+CDZibp0QvqiKNUNLT1OaKdZ?=
 =?us-ascii?Q?kf0Qx/uMbehzuHlpmb0eyMPTXOiDO+nLO5T2dDgrOSAzounp2E7kM/Tc0uoE?=
 =?us-ascii?Q?nJZv2ptTAr8sQlZG7lGsGsNrgZwyom0kp5N4IavgqO/ROux5akdip635SH4x?=
 =?us-ascii?Q?YXmPbE5LS8aogESC4mkqpGVL1nwO+hGlwXcEAe46NL5V0qVcdCqn+vmwSRRL?=
 =?us-ascii?Q?Y2YtP575TGc9chIilXQBN2yguz6iI7/HPU7PzsfXiUSCiK1QV0j+XkiWvU1Y?=
 =?us-ascii?Q?3vdyt0MXymVuvg9iGCfJH7Es/VZXalkRizuVkn3jwAq6BF6fEjYjl0+ZwOot?=
 =?us-ascii?Q?0hu+DItW9oJ/5squTGxu9rYxnc9ZwqR6ZbgQnYKn/lsocciG0zzWhPqmalNJ?=
 =?us-ascii?Q?Axjclop7YxT4IuiFkOECkiLGvbiFdZhYyt6ELWA7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b6d9e4f-2f36-429a-7b12-08dc5f9fe6c5
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 12:05:55.9247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MtFTUDQ/hjDE6+h+1gzntQEpweZn6ALVDWHOtY6IFwS5L1yWx5qTXhwQq8j6tHMjprF2SJFS6taaYFFbuOjzZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7974

On 16.04.24 19:48:50, Borislav Petkov wrote:
> On Tue, Apr 16, 2024 at 08:23:58AM -0700, Dave Hansen wrote:
> > When I was looking at it, I (maybe wrongly) assumed that 0x8000001b and
> > X86_FEATURE_IBS were independent for a reason.  Because, oddly enough:
> > 
> > 	#define IBS_CAPS_DEFAULT         (IBS_CAPS_AVAIL         \
> >                                          | IBS_CAPS_FETCHSAM    \
> >                                          | IBS_CAPS_OPSAM)
> > 
> > So, if the CPU enumerates X86_FEATURE_IBS but has a
> > max_level<IBS_CPUID_FEATURES then it assumes there's a working IBS
> > because the software-inserted IBS_CAPS_DEFAULT has IBS_CAPS_AVAIL set.
> 
> Right, that's why I added Robert. I found this in a F10h doc (old
> Greyhound CPU rust):
> 
> "CPUID Fn8000_0001_ECX Feature Identifiers
> 
> ...
> 
> 10: IBS: Instruction Based Sampling = 1.
> 
> ...
> 
> CPUID Fn8000_001B Instruction Based Sampling Identifiers
> 
> ...
> 
> IBSFFV. IBS feature flags valid. Revision B = 0. Revision C = 1."
> 
> which makes this look like some hack to fix broken CPUID IBS reporting.

There is the X86_FEATURE_IBS bit (Fn8000_0001_ECX, bit 10) which is
available from the beginning of IBS (all Fam10h production releases,
revB onwards).

And right, IBS_CPUID_FEATURES (CPUID Fn8000_001B) was introduced with
revC. The capabilities of revB are set in IBS_CAPS_DEFAULT.

It doesn't look broken to me, simply the ibs caps field was introduced
later which can be determined checking the return code of
get_cpuid_region_leaf().

> 
> And if it is that, I don't think we care, frankly, because revB is
> ooold. Mine is somewhere in the basement on some old board which got
> bricked so I don't know even if I could use it anymore.
> 
> And I'm not even planing to - that CPU is almost 20 years old and no one
> cares whether it can even do IBS.
> 
> So I wouldn't mind at all if we simplify this code for the sake of it.
> I don't think anyone would care or notice.
> 
> But let's see what Robert says first...

My preference would be:

	[...]
	if (!get_cpuid_region_leaf(IBS_CPUID_FEATURES, CPUID_EAX, &caps))
		return IBS_CAPS_DEFAULT;

	if (caps & IBS_CAPS_AVAIL)
		return caps;

	return 0;
	[...]

Not too complex?

This slightly modifies the functionality so that 0 is return if
!IBS_CAPS_AVAIL (instead of IBS_CAPS_DEFAULT). The feature could be
disabled then by overriding IBS_CAPS_AVAIL by just clearing the ibs
leaf, valid even for newer systems.

Thanks,

-Robert

