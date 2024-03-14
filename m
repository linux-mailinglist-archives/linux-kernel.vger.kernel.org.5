Return-Path: <linux-kernel+bounces-103057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C8687BA79
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C24BC1F22BED
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52646CDCF;
	Thu, 14 Mar 2024 09:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5EBQ3VFz"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E4D6E608;
	Thu, 14 Mar 2024 09:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710408744; cv=fail; b=csBQO/r2plDooX9e4lTOqRoyASY49vnyziNDqsQFeGGjqVgTAuCjIDdp3xXIZOmTQ8tJfn62VkaSyycT41HdNSHGMASR6HQltM7jeL6UCMpUEGA1aX3E4Y42VE3oe8ik9t1kBffBK6zHHxyKOpe44NeUgAHA/nZYDmFu+NsQAc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710408744; c=relaxed/simple;
	bh=oDYVf0XSbUnKOFmJh4BWwQk53HxPqG93s2qRllfrX4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ac/oIvU4MVWjGPgwyCfRcXJCSAk9M6c0c7APLy5MPTO1QDNlHt6q/+j2Q3z+LBrDs/P2f4j/FOuK0d4D69N93QM6mneuoP1ey0U7conDEp3otsEt/4CYTbcqambdOBmpwelabwsbmqKLBxchYNllfMW0k3aSJru4nx0rnnAWuas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5EBQ3VFz; arc=fail smtp.client-ip=40.107.220.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KAtCkSHk0AK7HE7VnygBQ1C9IGptYIpJxWlEhEYAzlbdWFFFJqW7F+Id+rTcolA/pjlsHmB4w1LMh2NXArNqdmPNrsdDNXUqA06rhnOtbqjv0wEkQJg+T04ktLEc7W+I1uSqyokVQq8cGL8g1Z6gFCPtO+ODVZK6uC/i33qEpEbItBYsRoVopTAjaLlGgCjQ14mSRtdSfE502+ws++911MDT4DBZz3S2K+EteYiK2/NZATA7SaNhHAsWdGIUjJBafT+hs67TfhWf0d9aIKbTnNUHVZGfIN/taMcRhVUlIk0f7Dcf3TiOX4kJinToss7r84f3i7rscALX+vMlzYT3kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tR2Ifuv18cB2wI3PDFKoWfMR+Oz+/WBdvBgB20tl7YE=;
 b=Q8Y0FzO9sWI2D6e6M0VDV17wYqQC+x9VYj8G5lhpRMCc3or5C6szxfmIlYqprlpv1bq3c13JXyGM542ousPPu/tZv8jO285RQ0QKao2HkWH8513RLQ1gjBRo4Ku/dCTeRjCNeF+CGgDRjXdgJ/+UZ4qdmbxlxogm9BOiZ7WW589QpmkgbaDc8NaMvHiFGOU6HtPcNgcJZoOTagy/VvEgu5esydcKwOOufMP9chs1zJGTxN0odsHQ6lisykl6lTk8snr7ZtwTiBksqSrY7D2jAYCEBgLfUs8FkNLi3gae+tkurgMJFtLuUeyB7siZTrEtFvEqqtrlEQyg+Sm8K234+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tR2Ifuv18cB2wI3PDFKoWfMR+Oz+/WBdvBgB20tl7YE=;
 b=5EBQ3VFzC+jIQ7zPY8RJlNct6t4/S8J21F4i6gJYVCuVOxVNfGw7BOQ6oWpjbFMdLju5do0GvHlqMSx5go425xTlGV+2hJQabx0Fpj1wIJMZBPs+tutpUqFU7a6XlVPTltUFJsCAggxUahyKoxlJbUlic2mga6zK3w75i3txedU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 CH3PR12MB8970.namprd12.prod.outlook.com (2603:10b6:610:176::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Thu, 14 Mar
 2024 09:32:21 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::d725:ec0f:5755:769b]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::d725:ec0f:5755:769b%3]) with mapi id 15.20.7362.035; Thu, 14 Mar 2024
 09:32:20 +0000
Date: Thu, 14 Mar 2024 15:02:11 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: "Yuan, Perry" <Perry.Yuan@amd.com>
Cc: "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
	"Limonciello, Mario" <Mario.Limonciello@amd.com>,
	"viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
	"Huang, Ray" <Ray.Huang@amd.com>,
	"Petkov, Borislav" <Borislav.Petkov@amd.com>,
	"Deucher, Alexander" <Alexander.Deucher@amd.com>,
	"Huang, Shimmer" <Shimmer.Huang@amd.com>,
	"Du, Xiaojian" <Xiaojian.Du@amd.com>,
	"Meng, Li (Jassmine)" <Li.Meng@amd.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 1/6] cpufreq:amd-pstate: fix the nominal freq value set
Message-ID: <ZfLEG7tBk7aeETbc@BLR-5CG11610CF.amd.com>
References: <cover.1710323410.git.perry.yuan@amd.com>
 <08ed1f9f76a6a1c401efd8f426bdeb9681c4b4e9.1710323410.git.perry.yuan@amd.com>
 <ZfKPy7hlwiYm++AM@BLR-5CG11610CF.amd.com>
 <CYYPR12MB865539EE324D834EF5051A679C292@CYYPR12MB8655.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CYYPR12MB865539EE324D834EF5051A679C292@CYYPR12MB8655.namprd12.prod.outlook.com>
X-ClientProxiedBy: PN2PR01CA0047.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::22) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|CH3PR12MB8970:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ee05ee2-1e2a-468c-a998-08dc4409a59d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uqF+ihAsJfwp5aIQlFDpLrn1irDVDGHN2GPpuCvbOZhNSQVT/CT6A+rShdZhWmUhgL2ZxDQLYrKv+nz91UefNLsQ4i1myMstqDzxqBEicB3V2CSB1eB/qFia8ywGrwfr8fy+OvrdZ8kk9c5LEoFd9EutBDb6G4mDo2CpTXWXNolu/9uczBqHUl4RvfdAETRkvsnd1du9ONbw57KtXYPuvx2gJ54i8F9i6vXOaRQJhTexrchSz/A3Z9moLmlnxpnt8tAYn+UDDDLiCIv8djQxOEUW5OxjY/FHDwScI/m6gu19J2sSmlxi8w7XajnUUxSdS/6/ojz4U4Yst9CBS62mcXcx+3WojKwdzObv4E5nbC2+GwsgMmBwNwWYtHNCQAHZA7RRpe/r+G2zFJctZK8yhIQvF5wF5SCUjTctU/Z2AZB5oN57SnG/P4Idymo+pfOqevgQHlJV32Jjih4ob/lp/fGK/RBxAQHN28emoY5JrPOB4/XR3Q2oXfheEUmSL4BNUGjgX5QLSVVFNAfYwlbU33DowOOKIQPRi1wrIMIGwOUSlrMY65KC/eZIIrERzlezMtkiYyun3OyQQY8p+wRjYv+tLQ8hCpVbZoFXFUgUj+wNyYKuxQWtbe/6pUNLreE0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m3IbofF0xAkLFw6u6aR/ItT3GkzspbaQXuEmuZtuU6mxYs71LBhPeNEnXFal?=
 =?us-ascii?Q?Jx3fObnFkpJu0zXlqaXsGgEV3TffgsGV03V6TAx7dsk7JOn8bdJWYbuvIGb0?=
 =?us-ascii?Q?0SUijGbvMIzukHBlNckmlte/utEBXQn1gqlSfYT35VkAK+2WGC4juDcJjBHo?=
 =?us-ascii?Q?5RylkG0qDicIyeKhZqGISJJN596MQuoEoZHvAc3RcstHKYOIaq4uD1mYREEM?=
 =?us-ascii?Q?TMt1g19zKEtaN1SoZ77usBhl3EMuB8JhiHPjBxU1o+CTZT5z0M/82thwKlrI?=
 =?us-ascii?Q?pNm7xYDKUrHPPVnGsx58h7Qb5NmY9evBxJrOLKCbqa1N3RfY0joK0kvZ0dcY?=
 =?us-ascii?Q?cQL1iRqCV3S4xht6oapxRemLCejpy2OJz1L5VZ3siTPjF1SknzsQMsU6Vwx3?=
 =?us-ascii?Q?u5H2YFLb+LkmV33LtXHFYoDTqjdctOIMWaXngCmQl4Vzvlpze4EceQiYilF8?=
 =?us-ascii?Q?jTW1acNc2EegPXqmcqGCZGFIYYAKszBXraNA3j3mI8UFLhsTz5KbWlWYYgGs?=
 =?us-ascii?Q?75bCX9wFBqM6x/azVvpIHxEwPQwFwvDWaDZBVY35pPyal8BAaT4ef/OZaJnN?=
 =?us-ascii?Q?nxKh8EZMpNeQRGbkX+QKWYzrZqZuF0GdOAHSyEIMnFIz2lln5AxUNk+sldnQ?=
 =?us-ascii?Q?g8fq5LPov091sIqbW7pRPIu/unzu6fPvrO2vmv/6K3jiSeVn1j8slK4v/NYM?=
 =?us-ascii?Q?qh/p//KaR+wTTXlyRHo3c/HnBvjIj1qbafUKbNtbx8gj/j1M7GeUt5jS2GlS?=
 =?us-ascii?Q?L3Qo+xZqyg3PMRcX2rvtIV3Zb39T052LVaXwo+5o5sySulzNyUUZ9jqoudcA?=
 =?us-ascii?Q?i12/qVCKgdcCoHpvPLAu/IIO/30YUvBqUnYtY/75p4mKHYDod3dRz/8OrK8g?=
 =?us-ascii?Q?vFrNoZIAPOqWiJjkQ0Ipqnk/mca9Sd/5XnsGH0gjDAhXMl206FD07PaRYxjR?=
 =?us-ascii?Q?+AA6mMdeb2EU9zWYP2whImElgpCJXedB8XIapeF7a6VD8rg6oL11OyfixyDp?=
 =?us-ascii?Q?arfQnPyQL0MU8MbJypcBYmyCX1HXlNXY6JcTfq24IyddS1QU/MjVoisshluU?=
 =?us-ascii?Q?2/jYRvyfy1wIy4RYZVO9K/tiZ3qkfPbw5osynTX1DBd8TOPL6cDuNx03GTt3?=
 =?us-ascii?Q?jU3cZOX0odegVn/WXw6ZfgnGXTu5XksQyp5BCiOecmEbZFo92MrWnqYkn30E?=
 =?us-ascii?Q?BNY39Oz6A7ul212N3abEA0N0+DRcEIBOR+VAZBvWSJlL8C3nRoko+yy9isYP?=
 =?us-ascii?Q?rWBkZCQXuQOwctvAQ8duyeCENFGh31KpiR8VMU2cw1coIQmEGrwGHnEAP+z3?=
 =?us-ascii?Q?ZC9Xi2k2lhzF6JlBoUbhsK69zOfJMLxz5/1aX1WzMqqQABUdtn7Y6nCxFNau?=
 =?us-ascii?Q?rBe2i8Uc8SjMNQ5+a/dGlf4y9QpPIAlIatINtQgMO1jwKmDPlT5X/u9JEGnH?=
 =?us-ascii?Q?XF34MLK7SpJzmt/Bi/TBExq6j8XZ2ybdjnTb6psfDCQ/iFC9AxJgb7u7zblM?=
 =?us-ascii?Q?J/wBpN38S3cFxQ0GfGNO4UfmkDLo4BT2QyY6u2KXbvTmYfuZuZ0/zn7T7nly?=
 =?us-ascii?Q?TlMtDh8Ga5Kr4dLC7MVjZH793riLxkd5oNDdNnI/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ee05ee2-1e2a-468c-a998-08dc4409a59d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 09:32:20.7539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gEtxUAA0UYD8uGyV/hVtUOSH+GPUsjpR7M8wlyl38FfYOLKz1Cw9LuYInjioaTUtJauhGm7ZMfVQYy09kDjgaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8970

Hello Perry,

On Thu, Mar 14, 2024 at 11:39:20AM +0530, Yuan, Perry wrote:
> [AMD Official Use Only - General]
> 
>  Hi Gautham
> 
> > -----Original Message-----
> > From: Shenoy, Gautham Ranjal <gautham.shenoy@amd.com>
> > Sent: Thursday, March 14, 2024 1:49 PM
> > To: Yuan, Perry <Perry.Yuan@amd.com>
> > Cc: rafael.j.wysocki@intel.com; Limonciello, Mario
> > <Mario.Limonciello@amd.com>; viresh.kumar@linaro.org; Huang, Ray
> > <Ray.Huang@amd.com>; Petkov, Borislav <Borislav.Petkov@amd.com>;
> > Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Shimmer
> > <Shimmer.Huang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>; Meng,
> > Li (Jassmine) <Li.Meng@amd.com>; linux-pm@vger.kernel.org; linux-
> > kernel@vger.kernel.org
> > Subject: Re: [PATCH v7 1/6] cpufreq:amd-pstate: fix the nominal freq value set
> >
> > Hello Perry,
> >
> > On Wed, Mar 13, 2024 at 05:59:13PM +0800, Perry Yuan wrote:
> > > Address an untested error where the nominal_freq was returned in KHz
> > > instead of the correct MHz units, this oversight led to a wrong
> > > nominal_freq set and resued, it will cause the max frequency of core
> > > to be initialized with a wrong frequency value.

What is still not clear from this commit log or the rest of the patch
is, which part of the kernel code expects nominal_freq to be in MHz,
when all the other freqs in cpudata are in KHz units.

If nominal_freq is in KHz as it is currently, how does it cause the
max frequency to be initialized to the wrong value ? Could you please
elaborate this ?

> >
> > As I had mentioned in my review comment to v6 [1], cpudata->max_freq,
> > cpudata->min_freq, cpudata->lowest_non_linear_freq are all in
> > khz. With this patch, cpudata->nominal_freq will be in mhz.
> >
> > As Dhananjay confirmed [2], this patch breaks the reporting in
> > /sys/devices/system/cpu/cpufreq/policyX/*_freq as some of them will be
> > reported in mhz while some others in khz which breaks the expectation that all
> > these sysfs values should be reported in khz.
> >
> > [cpufreq]# grep . *freq
> > amd_pstate_lowest_nonlinear_freq:1804000   <----- in khz
> > amd_pstate_max_freq:3514000                <----- in khz
> > cpuinfo_max_freq:2151                      <----- in mhz
> > cpuinfo_min_freq:400000                    <----- in khz
> > scaling_cur_freq:2151                      <----- in mhz
> > scaling_max_freq:2151                      <----- in mhz
> > scaling_min_freq:2151                      <----- in mhz
> > [cpufreq]# pwd
> > /sys/devices/system/cpu/cpu0/cpufreq
> >
> > What am I missing ?
> 
> https://lore.kernel.org/lkml/42a36c7f788e0fb77d4be7575aab9c937e1773de.1710322310.git.perry.yuan@amd.com/
> Changes from v3:
> * fix the max frequency value to be KHz when cpb boost disabled(Gautham R. Shenoy)

This CPB boost change assumes that cpudata->nominal_freq is in Mhz
which is not the case until this patch. So is the CPB patchset
dependent on this patch ?

--
Thanks and Regards
gautham.

> 
> The previous problem has been resolved by the new patchset of  cpb boost support
> 
> +       if (on)
> +               policy->cpuinfo.max_freq = cpudata->max_freq;
> +       else
> +               policy->cpuinfo.max_freq = cpudata->nominal_freq * 1000;
> 
> 
> The frequency values of cpuinfo are correct on my system.
> 
> amd_pstate_lowest_nonlinear_freq:1701000
> amd_pstate_max_freq:3501000
> cpuinfo_max_freq:3501000
> cpuinfo_min_freq:400000
> scaling_cur_freq:400000
> scaling_max_freq:3501000
> scaling_min_freq:400000
> 
> Perry.
> 
> >
> > [1] https://lore.kernel.org/lkml/ZcRvoYZKdUEjBUHp@BLR-
> > 5CG11610CF.amd.com/)
> > [2] https://lore.kernel.org/lkml/1aecf2fc-2ea4-46ec-aaf2-
> > 0dbbb11b5f8b@amd.com/
> >
> > >
> > > Cc: stable@vger.kernel.org
> > > Fixes: ec437d71db7 ("cpufreq: amd-pstate: Introduce a new AMD P-State
> > > driver to support future processors")
> > > Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> > > Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> >
> > --
> > Thanks and Regards
> > gautham.
> >
> >
> > > ---
> > >  drivers/cpufreq/amd-pstate.c | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/cpufreq/amd-pstate.c
> > > b/drivers/cpufreq/amd-pstate.c index 2015c9fcc3c9..3faa895b77b7
> > 100644
> > > --- a/drivers/cpufreq/amd-pstate.c
> > > +++ b/drivers/cpufreq/amd-pstate.c
> > > @@ -647,8 +647,7 @@ static int amd_get_nominal_freq(struct
> > amd_cpudata *cpudata)
> > >     if (ret)
> > >             return ret;
> > >
> > > -   /* Switch to khz */
> > > -   return cppc_perf.nominal_freq * 1000;
> > > +   return cppc_perf.nominal_freq;
> > >  }
> > >
> > >  static int amd_get_lowest_nonlinear_freq(struct amd_cpudata *cpudata)
> > > --
> > > 2.34.1
> > >

