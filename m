Return-Path: <linux-kernel+bounces-154881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF8E8AE269
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93F842818F7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2C063099;
	Tue, 23 Apr 2024 10:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="V3RrfzJd"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9C01848;
	Tue, 23 Apr 2024 10:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713868819; cv=fail; b=WuFMt6mD1xGK02prLQihugRWAeHJ3ojSchZiaf/HEE4CDdfYCNHAP52iVVTlobsdfRjfyGf5blJyStDwn7keSpTD+2T16whqk8npNm3pdwLtuIPEx1YJCxGlj/LfIJPxs6ffjc04DLR0DekUEVuz2R1uQtui0F4ff+ZsMJXpG04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713868819; c=relaxed/simple;
	bh=S5KDhoDWUA4dTxxOsZJ239L40cLFNZ5T6e4Pi5fLEBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lI5yA2mS0pxikS8k7fkiMp+0oPlltYKm7KRAeXr3SWu3oHqNI8nqRyaccxXhJZjNMqhF5lJYOc4liovHHO9dssObxyZa/p7Bywmp4fXXlpQfphEdO/KW21SHKkJW/sZnh56JkwL6bemi/gduNVmvwozhbWI21HHIs/+09CCn1Vs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=V3RrfzJd; arc=fail smtp.client-ip=40.107.244.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ni9WySVeF1fRDsszvWVm/qN2eE6ozjs3jSexzs5Ye/9DO3x/IzCbMRIE0Fb7omvg6aQF5sg/0pcWcjbVvPNGarH/8HhA9YjqY/+Mf8XlgVxI2S2dfBMM/d0+pOL7kN5th/YrLKttBz6Wag3QQ89O4v/NntbfwDHHGjBq1IB7IMZ6lDnVB4of68+UZjWOWiFJpRFTntpW5jc/lUnrtU8dVS9l6vSgOXg0MoXwS5Di5R6ND12yrTuBSWS1kIBMXljTVL2/k5gz1J+Tu1wZuOGVrpTvkN5hUKY8MNCYusbChw1ZptLMJ2jnj8giCqoHBIQ0swtpM+Xx1lo653uRsJ5PCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ghP+Xqw1L8qi1djupnzhyhs7ipLZCWiyZa0M1kZdbL4=;
 b=Xk30e5PnN9UOeZtxDmVUedgSPHaOXIWOAwGGcJjfIlTI8lWoPu41DFoFzG3++NXQ+DhW1boR3rk1W9mRX5kGuX4YMi73/eIoWxkLtjFFyDk4xK6fVKD+4t1AyfE4iXnm7/g2Voavc3q2+nZHZWVoHTXx/3axAHj5jew55YVf092WQud0tJU8QkZKd4bYJ/8AhCBzBIsF8Tl15hgZnn0mgN7ULO2km4yKqvwb+n3K5JPmTJKFZgsi9P0QtIP5yMH1dvHeCKO+DWEBNA+XIU/DZDfjbU1tZYWIPSXzzMaVVW1VHsNGJk2IKhAUDvQwDLjZkHCMqcQC/Byn84gNYO7JRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ghP+Xqw1L8qi1djupnzhyhs7ipLZCWiyZa0M1kZdbL4=;
 b=V3RrfzJdiVIRkYfBcN5b47+LidDbvYZmIgSaHDVCTGVFpjqEzi1O8MpIbMx36pCd1W3WR+dR2vYLgTk03a9ZhrAw6iMf4toz0/JiLE5SsA6GpvBi9ZEmlp62v8+QalrI4W7RcHWQ+xWMGTXc6FEhsMOqOTbdkXcg5jH/ygo9B3A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com (2603:10b6:a03:540::10)
 by SA1PR12MB8724.namprd12.prod.outlook.com (2603:10b6:806:38b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 10:40:14 +0000
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::966e:5ccf:b22b:d972]) by SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::966e:5ccf:b22b:d972%4]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 10:40:13 +0000
Date: Tue, 23 Apr 2024 18:39:51 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Yuan, Perry" <Perry.Yuan@amd.com>
Cc: "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
	"Limonciello, Mario" <Mario.Limonciello@amd.com>,
	"viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
	"Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
	"Petkov, Borislav" <Borislav.Petkov@amd.com>,
	"Deucher, Alexander" <Alexander.Deucher@amd.com>,
	"Huang, Shimmer" <Shimmer.Huang@amd.com>,
	"oleksandr@natalenko.name" <oleksandr@natalenko.name>,
	"Du, Xiaojian" <Xiaojian.Du@amd.com>,
	"Meng, Li (Jassmine)" <Li.Meng@amd.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v11 0/8] AMD Pstate Fixes And Enhancements
Message-ID: <ZieP98CqLI48r58z@amd.com>
References: <cover.1713858800.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1713858800.git.perry.yuan@amd.com>
X-ClientProxiedBy: KL1PR01CA0003.apcprd01.prod.exchangelabs.com
 (2603:1096:820::15) To SJ2PR12MB8690.namprd12.prod.outlook.com
 (2603:10b6:a03:540::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8690:EE_|SA1PR12MB8724:EE_
X-MS-Office365-Filtering-Correlation-Id: cafd1aab-14ed-4af7-333e-08dc6381c1b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l6kUQf2QYQuCIErQky7oVIY8aRixmnrywa5vISjWFfpK4SkemSx6CBjutnaQ?=
 =?us-ascii?Q?ILlDgyyqtV6HB/3SPN+M6d9TEa42hjJZTwfSxaLmbeqoEiKYeez7vTsVf/y0?=
 =?us-ascii?Q?vdTmHydNO+ksk2MdYcD7pxA5vbLt5GXrtcjqfHmJPQuuNJ5+ruOzv0DCDXhD?=
 =?us-ascii?Q?JJCLtn94jxt4jZcQAMZTmwWwzsAG1SFd/N0gAFeopD0K0Yn3Fml9HFGyrUSG?=
 =?us-ascii?Q?1MrH2vRjrYOck3froXIakKkehEml9kmjePI36VueaN/hgumnTZcr/3ysPV4p?=
 =?us-ascii?Q?ucqRHH8qOOXs4QFpRLdvfbh2yrKXA3fSwoLkRXClzUYtk5fGM1GJmbKJlDRx?=
 =?us-ascii?Q?1C2bLxiS+0OcSSCkskK4kfBgJUeHToNcXTTPmfhjzMUiJfweM07zPof+Pg6J?=
 =?us-ascii?Q?GB5JHTLo3CGQU1bt5e/6Zd7rtIB8C+q/VZdesNxta6yvFJTOw70gen/ZhNYx?=
 =?us-ascii?Q?l2FnKFv1qXA5ncVLljmC07ZUuyfNmI0VsSxh3rsl1L4J/yeKFcWqgbKlAEm8?=
 =?us-ascii?Q?WSg2QyIa+KRwJM9rC+B/8VJRGAr5qjg3T2sH2m75/ktI1dwFnZmkdRLJGErh?=
 =?us-ascii?Q?pGC6soNsuI1tdCTQgFNvM1aE9mKNXnH2XrAw1Q/wF6T6FQnOu/NxFU0ioe8B?=
 =?us-ascii?Q?kljph6eGDOETZ3fUQ+CaoqI518EuSffUTy37tSY1VKvKKUxV1sTWUpyQLGOV?=
 =?us-ascii?Q?uY87u/KLljOGmQUvzJMx58yZkIVWFZaH5e+9jNQ+C1Xdy/JTSztnW2wQwdKp?=
 =?us-ascii?Q?N4ATaH/0wLI9hIbS09/UVKLYUiyvBp1NzYaYNHeaOdRxhpVtPKrBgY62UTNL?=
 =?us-ascii?Q?u5uAQ6vl1/ovrp6Whqyi7sWLOXW6iq7jrt8cCFlMXmuvqGw5LSF3e7iSLcPu?=
 =?us-ascii?Q?at21k5yv2F/nQp6jmTOImpOgAnfVhep5/jHsWCdmEVlZW0Am8v3F2wsHmLRQ?=
 =?us-ascii?Q?IMllAYnUlzlj+O1MpWuQ4a0fLhP6ix2zM+stpT8tfw50CjS40G9TtQ+g3g+e?=
 =?us-ascii?Q?UZB6enYVueMKsJZJpJgWczqsxzXXJygcI6m6cRBqeDAZwRE7XisHB6bqtKz9?=
 =?us-ascii?Q?ITnvE1wPH7i5S0gq6SEPTNpe3sj6baHm8tKvE6S8rRmIgbN4uFD3OvP3gcEO?=
 =?us-ascii?Q?4f2+gTh7Ka2hJYteI+W2TzIe7qwjatghCiVx1ncGmC1pmNOwXzEOS+bKP7zM?=
 =?us-ascii?Q?hwbIBCHGOfXNVWSQyhpNdFyOmIHVxxnYaD+EZAJrK9fA/SBIlfBXeKTI+8qf?=
 =?us-ascii?Q?doj/mNGH0Qg5e3/c74SyWhb1EkWaWMPt/BuyvN/jIWH8uMxjcIDm2fUTaA7z?=
 =?us-ascii?Q?4lc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8690.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E/qTcgpjJPGYZWBKeg7P7kwKEInie6vjUrtUzIG78CFy7HyKJaT+l9Y9w944?=
 =?us-ascii?Q?WgEKhgqQRKppdlbZdkSipIEG6TkmpC9wW/VHBqmiX/pt74zr0TAwBTrwi/Kp?=
 =?us-ascii?Q?AEQi+N0yEsCsFzxkNW9rIO8wQp6wZDfe9hKT+Y6uOZFHdhlvqJ40sxyf0ait?=
 =?us-ascii?Q?wTMwVFjSrot9TCLl06KqUxYmNggTnOO50QDsTT2Fp0dH19c5KQdvcHNWiR27?=
 =?us-ascii?Q?cwDYGGatNqud/bshyyadX3yJSnKBHej0+mhCtheaLrpIkNVXcGwJ+MbTDeqa?=
 =?us-ascii?Q?CjqjaC516Nvi+GhsEkxEsxLehfbVOTVL/lIvsupmTJT+ebCecWun+UY5wa1m?=
 =?us-ascii?Q?vL/QwrXCJ2JJkDfQktUy5iBFXXc51MfMSbUbWuh+EHluRVk5M4iqu/CsI8dl?=
 =?us-ascii?Q?p4dSGM77iiaPtiRq9fbokcDE8r8PsPUOmUioxrUsZ3kxeQL3aq/YFI8Y53xH?=
 =?us-ascii?Q?RnWYqxFBMgvX4iVEWUBVjkEt+TMGV/IO7aZ6w9WwoEebo+2tD9JRq17kAf1f?=
 =?us-ascii?Q?9ynGqcVjUnKx1GuIoT8COxsrWq4rHFlIZP+wrovs3YJ0oAirKRrsr8gMDCme?=
 =?us-ascii?Q?3YZoEH10MXzuNZw43C9bzi0E2lNGNXYg7iatejHjqbAVIbYrAKuzLBfF6dH/?=
 =?us-ascii?Q?1WmncaMwvhSbbFZbqgG333TGK7Oe9cbFKLqG14Wux7MsMnySlhWXAusmmBLq?=
 =?us-ascii?Q?1L6NxJzW0Wsufxh7vMBAiU1I6YtZjA+1ewUuZt8ctIcvqwsC7Oauo35GViHK?=
 =?us-ascii?Q?dzYnfbqeEemEeZFIyLDtUQx9nL5RQKYrPJE3bKTJdN/+nV2AArmEszEhpduC?=
 =?us-ascii?Q?o3KywyIjpc/IFEC0if/6ALx7cfaiRkeQR6UbHwzfJIdx46UVSv+Vi80ZF6b4?=
 =?us-ascii?Q?BfCRfSn5+2t9DxQ15bE8PuWDwuUMCnT1YlYDtR2zEu6Vu1jFNuV3WqT367r6?=
 =?us-ascii?Q?uea+v65AWJghT/rf/7i626XEpSboaPWY1gi8tNcbS2OATzUPmQwwiSFYeiAM?=
 =?us-ascii?Q?7wCQK7YNTu2j1IzEEagkf0KfW3Tw2ndwjwNNNIx9Q7h/iuvGU0BDtVogSAqT?=
 =?us-ascii?Q?ZhyoyU40dgbpvVlEWvKDwuKPN4q3pZk+NkHwqPWMI4fmz+G4GuXiAJpk1zny?=
 =?us-ascii?Q?SiQceO7P0S5IKTlOwpXGiKB+TGl84g+OeTCrTWdCdZ+ac7y9jOajRcv3gM3S?=
 =?us-ascii?Q?uJI2oIniE6pP+8L7UBZ+QvHYHbm5/tXJH+adaZ/4IEbzeXPA6KMS5dvUMxEP?=
 =?us-ascii?Q?2U+H5+AFZLquGVhVGLLZOLKH2ia4fo5BtLocmeId3gCVGH+2V+y/653bnXMR?=
 =?us-ascii?Q?s91TvJMONnyMQ6kasCX1Lacv1trlG8M3QJ5aI5RgwZs1DruJMgKxUZRWbEzF?=
 =?us-ascii?Q?/B2SXBS2K+HwUSIvx7bBy1Rp1Td41j13lNK66JDm9bQtuGuKe7mpflZsX6UW?=
 =?us-ascii?Q?CMtiLeC+x24tFx9C+pZHxRHWe++r9Bohqzdyeiln3Gcuzy6Oas6LPuiccWX9?=
 =?us-ascii?Q?SjiHZ7HZ0/IR+PUnMtuJHc7KxyckOxxKog6KY0xQJt/DTvU4Ahi/X2YfQoFw?=
 =?us-ascii?Q?E6JNV+UqHOZVn1YObyqIn9jg36AV7A9aabqSSQ9o?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cafd1aab-14ed-4af7-333e-08dc6381c1b4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8690.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 10:40:13.8799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: crQTgOBN7uPCHIBbvfUOv2tQSsQVVf3+VVqgc5LloK+5u9XQCn4VToLOwWgXZiIMIp/iZOnciEJdFuRiPEFmhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8724

On Tue, Apr 23, 2024 at 03:58:16PM +0800, Yuan, Perry wrote:
> The patch series adds some fixes and enhancements to the AMD pstate
> driver.
> 
> It enables CPPC v2 for certain processors in the family 17H, as
> requested by TR40 processor users who expect improved performance and lower system
> temperature.
> 
> changes latency and delay values to be read from platform firmware
> firstly
> for more accurate timing.
> 
> A new quirk is introduced for supporting amd-pstate on legacy processors which either lack CPPC capability,
> or only only have CPPC v2 capability
> 
> Testing done with one APU system while cpb boost on:
> 
> amd_pstate_lowest_nonlinear_freq:1701000
> amd_pstate_max_freq:3501000
> cpuinfo_max_freq:3501000
> cpuinfo_min_freq:400000
> scaling_cur_freq:3084836
> scaling_max_freq:3501000
> scaling_min_freq:400000
> 
> analyzing CPU 6:
>   driver: amd-pstate-epp
>   CPUs which run at the same hardware frequency: 6
>   CPUs which need to have their frequency coordinated by software: 6
>   maximum transition latency:  Cannot determine or is not supported.
>   hardware limits: 400 MHz - 3.50 GHz
>   available cpufreq governors: performance powersave
>   current policy: frequency should be within 400 MHz and 3.50 GHz.
>                   The governor "powersave" may decide which speed to use
>                   within this range.
>   current CPU frequency: Unable to call hardware
>   current CPU frequency: 3.50 GHz (asserted by call to kernel)
>   boost state support:
>     Supported: yes
>     Active: yes
>     AMD PSTATE Highest Performance: 255. Maximum Frequency: 3.50 GHz.
>     AMD PSTATE Nominal Performance: 204. Nominal Frequency: 2.80 GHz.
>     AMD PSTATE Lowest Non-linear Performance: 124. Lowest Non-linear Frequency: 1.70 GHz.
>     AMD PSTATE Lowest Performance: 30. Lowest Frequency: 400 MHz.
> 
> 
> I would greatly appreciate any feedbacks.
> Thank you!
> Perry.
> 

These series look good for me, thanks!

Only a minor comment in patch 1, I would prefer not to use short case in
the comment.

Acked-by: Huang Rui <ray.huang@amd.com>

> Changes from v10:
>  * pick ack-by flags from huang ray for all patches.
>  * run testing on AMD Ryzen 5 7640U without regression issue.
> 
> Changes from v9:
>  * pick review by flag from Meng Li
>  * pick test by flag from Ugwekar Dhananjay
>  * picl review by flag from Gautham R. Shenoy
> 
> Changes from v8:
>  * add commit log for patch 1 and patch 2 (Rafael)
>  * add missing Perry signed-off-by for new patches #1,#2,#4 (Rafael)
>  * rebased to latest linux-pm/bleeding-edge
> 
> Changes from v7:
>  * Gautham helped to invole some new improved patches into the patchset.
>  * Adds comments for cpudata->{min,max}_limit_{perf,freq}, variables [New Patch].
>  * Clarifies that the units for cpudata->*_freq is in khz via comments [New Patch].
>  * Implements the unified computation of all cpudata->*_freq
>  * v7 Patch 2/6 was dropped which is not needed any more
>  * moved the quirk check to the amd_pstate_get_freq() function
>  * pick up RB flags from Gautham
>  * After the cleanup in patch 3, we don't need the helpers
>    amd_get_{min,max,nominal,lowest_nonlinear}_freq(). This
>    patch removes it [New Patch].
>  * testing done on APU system as well, no regression found.
> 
> Changes from v6:
>  * add one new patch to initialize capabilities in
>    amd_pstate_init_perf which can avoid duplicate cppc capabilities read
>    the change has been tested on APU system.
>  * pick up RB flags from Gautham
>  * drop the patch 1/6 which has been merged by Rafael
> 
> Changes from v5:
>  * rebased to linux-pm v6.8
>  * pick up RB flag from for patch 6(Mario)
> 
> Changes from v4:
>  * improve the dmi matching rule with zen2 flag only
> 
> Changes from v3:
>  * change quirk matching broken BIOS with family/model ID and Zen2
>    flag to fix the CPPC definition issue
>  * fix typo in quirk
> 
> Changes from v2:
>  * change quirk matching to BIOS version and release (Mario)
>  * pick up RB flag from Mario
> 
> Changes from v1:
>  * pick up the RB flags from Mario
>  * address review comment of patch #6 for amd_get_nominal_freq()
>  * rebased the series to linux-pm/bleeding-edge v6.8.0-rc2
>  * update debug log for patch #5 as Mario suggested.
>  * fix some typos and format problems
>  * tested on 7950X platform
> 
> 
> V1: https://lore.kernel.org/lkml/63c2b3d7-083a-4daa-ba40-629b3223a92d@mailbox.org/
> V2: https://lore.kernel.org/all/cover.1706863981.git.perry.yuan@amd.com/
> v3: https://lore.kernel.org/lkml/cover.1707016927.git.perry.yuan@amd.com/
> v4: https://lore.kernel.org/lkml/cover.1707193566.git.perry.yuan@amd.com/
> v5: https://lore.kernel.org/lkml/cover.1707273526.git.perry.yuan@amd.com/
> v6: https://lore.kernel.org/lkml/cover.1707363758.git.perry.yuan@amd.com/
> v7: https://lore.kernel.org/lkml/cover.1710323410.git.perry.yuan@amd.com/
> v8: https://lore.kernel.org/lkml/cover.1710754409.git.perry.yuan@amd.com/
> v9: https://lore.kernel.org/lkml/cover.1710836407.git.perry.yuan@amd.com/
> v10: https://lore.kernel.org/lkml/cover.1711335714.git.perry.yuan@amd.com/
> 
> Gautham R. Shenoy (3):
>   cpufreq: amd-pstate: Document *_limit_* fields in struct amd_cpudata
>   cpufreq: amd-pstate: Document the units for freq variables in
>     amd_cpudata
>   cpufreq: amd-pstate: Remove
>     amd_get_{min,max,nominal,lowest_nonlinear}_freq()
> 
> Perry Yuan (5):
>   cpufreq: amd-pstate: Unify computation of
>     {max,min,nominal,lowest_nonlinear}_freq
>   cpufreq: amd-pstate: Bail out if min/max/nominal_freq is 0
>   cpufreq: amd-pstate: get transition delay and latency value from ACPI
>     tables
>   cppc_acpi: print error message if CPPC is unsupported
>   cpufreq: amd-pstate: Add quirk for the pstate CPPC capabilities
>     missing
> 
>  drivers/acpi/cppc_acpi.c     |   4 +-
>  drivers/cpufreq/amd-pstate.c | 257 +++++++++++++++++++++--------------
>  include/linux/amd-pstate.h   |  20 ++-
>  3 files changed, 174 insertions(+), 107 deletions(-)
> 
> -- 
> 2.34.1
> 

