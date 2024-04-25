Return-Path: <linux-kernel+bounces-159200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C368B2A95
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 23:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DA051F21159
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 21:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7956E155729;
	Thu, 25 Apr 2024 21:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="22jkGQSW"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C328149DE3;
	Thu, 25 Apr 2024 21:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714079857; cv=fail; b=KL0NLXfm+xQS09XieE66vty45LbAS3jDn0GdQCJ9vPgznvenL9IqR1RcO2Incibai1IcxULiF9sbL2ofLnYZLdIDObzJesqstM3BEKUc4cZVscHl6tNNT+qGB6zy7UXxEl30QWe/AYMVSB3SoO1ZXLuH/EDKsVGL96q9oL/I2NI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714079857; c=relaxed/simple;
	bh=ABL/7cIlvD+J841FKlStXskcCBVxVgXkzTL25C02GEQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Dvyo/TXglmU6CWZINiYXMs789GOfA2Y68+kseJbAHr5G/etx3owbT4TGRmr4ES4kFTJuf0/zFvuwRXLJvK0n6/agMtV7aNW5MJchVWkIkEeltdk94ApdAgnaz6sBry9YBd2e9FbBga7tOzI3sTueP2TNFND3IX5QUV0GGQcaRr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=22jkGQSW; arc=fail smtp.client-ip=40.107.223.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bts2c2h4UddW8svP1EaPqKHqn3yI7UO1Qezyi6OQRtthCbzAyij5fI2R3PARvp4dy4yn4oGxWhr33IMw5aZeuFicPISxrkzAmGaqlc1FSRc+QL3DLPl7CLKermdZ0t9TGuFuhiOi0tMjFiDdvI+SvFg3esfRWjaSuCw5Sh+CbUgY+02hfdu4CVeisZ5I+VSl+JmTO+0T/NeGjJX8JszqggpAPvIsASyJH/yXrvS/5zms571dMVdGsOCdHPPVF3s9865pi/OsCjma3HWikSTuc3nSzs9FnNTtDiuBm0qv8XH+bS2QEu6Astdkwh92Xnv5vGEoOR7kWSLyYJCIr5oBQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NrsCVeG7DtzbIoUnRuU9pRzBKoAHei94TPFe0zuaTUY=;
 b=IAmRXOcC7zPcQmYneQTj0Wq5uF7AaqN6ESIFJ420k4fjBSVEqUXdNyzS0ZfENT7bzZdyUjQZaXWzFM3ID03xnw34DcsNCSiAeTeXyTXxTQkHdJualRiJX2nTGj7IoEjbs9ebG4m9mIO8G9bv7eIJ6OwmO7DRJq3YauO/eBiVLJXXq1DZuUrw+YDLHarnliaVpGiAtYCBq68Kk58DBZoQcU6Ml9BLvY5AWS3zMChSSrO/NzJeVDXJpFeeWQ7l9UNFm618s2Ajx4pEItxq+5cX/IPmEEhqYOKaCSngu0FaT/On6KVDRu6tJf2fcDUYFiVN0PjD6tyS7agiRm7L1bk3Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NrsCVeG7DtzbIoUnRuU9pRzBKoAHei94TPFe0zuaTUY=;
 b=22jkGQSWBj3pK/muQ2V3dGmMhZryNnqKmTSXHnAy7mkpkLLvYVIW4xkiPoZRTHrK+tV1zy7YQ7X61SHm2TqJRBG6/hbk7h2hH6NXM6F+o6A1ZVmY9xbA8c+CWob+r+iWkkvZ+5gqVVjrqRDP/w6tJ3xO/YqPeGUJCbldczuLtmM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH0PR12MB8030.namprd12.prod.outlook.com (2603:10b6:510:28d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.46; Thu, 25 Apr
 2024 21:17:32 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.7519.021; Thu, 25 Apr 2024
 21:17:32 +0000
Message-ID: <6c2470ba-e883-47c0-a75d-7d1b4c918aed@amd.com>
Date: Thu, 25 Apr 2024 16:17:29 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/6] cpufreq: amd-pstate: implement cpb_boost sysfs
 entry for boost control
To: Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
 viresh.kumar@linaro.org, gautham.shenoy@amd.com, Borislav.Petkov@amd.com,
 Ray.Huang@amd.com, Alexander.Deucher@amd.com
Cc: Xinmei.Huang@amd.com, oleksandr@natalenko.name, Xiaojian.Du@amd.com,
 Li.Meng@amd.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1713861200.git.perry.yuan@amd.com>
 <5a357c1ac3504f8a69def8834a6d9557b5d592ed.1713861200.git.perry.yuan@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <5a357c1ac3504f8a69def8834a6d9557b5d592ed.1713861200.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR06CA0073.namprd06.prod.outlook.com
 (2603:10b6:5:336::6) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH0PR12MB8030:EE_
X-MS-Office365-Filtering-Correlation-Id: c8535ebe-9f29-4f4a-7d39-08dc656d1ed1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TTMxWWgrc2xmYndWME05VWJCRU5GZkw0dTQ0L3RJbDM2Vjd3bHZnUXB1VGZ5?=
 =?utf-8?B?elJkeVhwTHNLazkwV0laRGhIQVF2TUhOcVoxUzBtL0hIaCtwNGFPMnVZbE5w?=
 =?utf-8?B?U2lqV0xNWHYzdVFQT0U4MngweVVYa3FibXpFY1lPY21vNGV4QjgyTXlBY2ds?=
 =?utf-8?B?R0hCTWVkZ0QvbmZ3a200UlJYcWxJaUl1aWxFWGdYTEZOanVQODQ4UVRIWk1a?=
 =?utf-8?B?KzNrY1AvalgrWVRTajdqNlpDanhVNE5MZlc2Tkl1ZU9hS1J1aHBGUS80SndJ?=
 =?utf-8?B?dlVCU1I5WlhzL3YyY01QTWpWYXJUTFBnZENjYncycEtEVXhxcnIxUlU4WGsv?=
 =?utf-8?B?TUg0VWNzc3hWanozYXAwamVSZ0phTCtBYkh0NXRWRllUV3lkZUFjMTY5Smw1?=
 =?utf-8?B?ZVd1Umg3dnRQSkNCY0htTHV1ZzM4WnZKaUw2VGkvYTdTMG1BcDNJU2pja0Jz?=
 =?utf-8?B?WXFZZ0hOZjJ3dVlJdzNzM0xVNGpLYml5NEMvY0JOcjIzcWRYR1FQVTcrdm0x?=
 =?utf-8?B?WmRESUR6WVNwY2xoOVJFeWZ5b1dWaXBJeDJXU2lmMjQxT0lZSVJsWGdiOEsz?=
 =?utf-8?B?OEVKM0JXVXFLSXFZNDlXUkhrOUI2cGlnbTU3SHh0b2t6UjNMLzlGc3RZTDQ2?=
 =?utf-8?B?dWxiYUNVSWJ2cUhDcXR3Z0xvd2VzQUtxMVJya2dSNmlpTi9LMS9mQ1BwTElM?=
 =?utf-8?B?bWNpSGR5UVE0RHdkcnJROTh4VVJUOVVKUjQxWE9WMkJUQW5mMmMrYVNOaHFX?=
 =?utf-8?B?bDJGVzVOamdibGUwUUYwMFBSSUNPaUljZEFxaEJXdzRyR0h2NmhaOFA2YVRo?=
 =?utf-8?B?ZnBVa1N1YndBRzU3aUhwd21Wbkh3V0hKWDZSM0U3MXBudEFMVDZiNjUwMjRW?=
 =?utf-8?B?TGo0aVNndUNkNlIwRksxSUx5Sng2TUFGWTFibmU4dmpoRFFVN0pweHp4QXB1?=
 =?utf-8?B?OGRzaTZVSGxpZlBBQS94cjdWdUZ4cDJxNG5aRUZOV0pLWDZTS2lJY0MwZ3dF?=
 =?utf-8?B?R2JRVnN4VklTdTR5ZFp4bS9IM1NzMG1CNWpHK1JDWnhVajIrMXRHSUJtazVV?=
 =?utf-8?B?L2VaT1g0OWl4ZjFZc0lEd0JKbjM1V1FQckdkZEZZaXRSTEJXVUdtcGhXUFd0?=
 =?utf-8?B?MERiTURBTVBuTmtCRXJMMmR5QlMwOXJyQ1hsK0ZFNDRJMGF1L1JVYmFuYkNB?=
 =?utf-8?B?QlhKVXB5OUhsNzFwbGE4bjVlUzNjeWtIZEd5S0NqaTZmNWlmd3IrdWU5TTlV?=
 =?utf-8?B?bWZxb2wvNTg0d2Y2WU1zbENPTVpHVGJRUGVESGh1T2pUcHEyZDRhZWI2OE50?=
 =?utf-8?B?dmk0YnZZQ2Z2MFdHOGdtMU9vL0pmQk5XSG90TytpV21yQTFlblV6Ykg2Y3RB?=
 =?utf-8?B?RVYzSlNEYUQwR2dLUHc0cUpBcEZReENTZTQ0UFpWS1F4NldYbnJqWnprSkVu?=
 =?utf-8?B?QSszWVN3RHl1UWdzSURQY29tRTI4K1F0U0xYYmdSOUhHTXBRTGVzN2xYdS9O?=
 =?utf-8?B?eHB4b3R3amVKSElkSE5HK1ZFbzdlYytOWjBWNEJSMlhPRkllNXNRdmpTeUVM?=
 =?utf-8?B?M2pQc3FnTFk3NzNQQkNpYW1NaDlMcllvWHJPUTdyOWpNSW1BVno4eUNOTGY3?=
 =?utf-8?B?azI5d2Z2MENnYlF1YzlUQzlxZ3hTUlpaZWIzTXJ3Vm5KUG9oOVFUaUl1NkN4?=
 =?utf-8?B?S0puQnZyRjJWT0ltLzVNdzZoNkdIakpwMHRZc1h3U3lJNis5dVFTYmFabTND?=
 =?utf-8?Q?5nxDlbbuGh7+6f568k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?czBDNjY2cEI4RitUSjdYa2YvN0dWREVtekZSRnJNZzVoaW81QlM1Szg3cGRp?=
 =?utf-8?B?OXlINFhTZElpUEFRa1IwaVpFL1ZrR2N2YlBjemhHVjMvRDlDYlNiclBpOUVw?=
 =?utf-8?B?Wllpdm4xVTlPZ3BQYUE5TnVXWDVJVDZhU3JBZkxUMHhPS01nb3ZZWG9yY1oy?=
 =?utf-8?B?dzdCcXZVbE1zWlpNRUNTN3NPMmx1SWNlejVBYllhUDRLNVVCVUxpTTJxV1N0?=
 =?utf-8?B?eWRmZ2p1SlhwTDJPekNSdHdBT2MyVlVoSVo4NlNnWWp2a2x0OWdka2FNaHRC?=
 =?utf-8?B?V2hrV1pGeWFSMzZKc242R3hxeUpwN211bnh6aVpabXBZY1NBcUF1alJXbzVV?=
 =?utf-8?B?S1FoQmQ5QUF4c2pZS3dwVk9UY01QWE9sSTEyT0VJSlF5cnRXVHlSWlVGTUIv?=
 =?utf-8?B?QjVCVkwva2FaVzl3cU5zaXdBSVJMQ0o0Y2xJRE1DeWR6TTNtanJHZG5Fd0Vp?=
 =?utf-8?B?dFpQdUV3eHNidTh5TFpkem5CZDJtRWJVTzZ5V2I4MEhHYzFQYjZaL283OHYr?=
 =?utf-8?B?S2ZwYWJVYWZkM0hGb2lZdmlOMENxYnEwNDN2Qk5VaFlDeFdlL3BwQndXWDI0?=
 =?utf-8?B?U2svWTA0WHVqdHBjbkd5MlFNVkdtZWJXc1IyNVJwdnk0cmxSaVcyM3RVNmJK?=
 =?utf-8?B?NmE0TjdqK290QnhYMCsxSy9uQjg1WkJSV1hXOVY0SlkycXM4MW9ibVhUaEdh?=
 =?utf-8?B?eGc1TXBmYmh4TlAzOFpQQ3JxSWVHRDZEQm4rSGUwK3l3RktwSHh6RG16TGlj?=
 =?utf-8?B?alg3TDFMQkJDUktpckpPUi9JRnkvTjBPVnlQMy9zRE8vSUtFQ1ZwNjB6eEpq?=
 =?utf-8?B?NGkvY1JldjBuZ1poRkhuM0JHL08vVzBDVDJkdWdYM0paeW56Ly96KzZtakcw?=
 =?utf-8?B?TzFZR1JGR2lETjduaktUUjVMZ28rYVFJS3lSV3JKRkduQUFxQmNaVlBnblZN?=
 =?utf-8?B?S0tuQVJERnV0clp5b3I4b0VnQ1dBV04zd2FHQ3pZdS85QWZ1MG9nNnQ4WTdr?=
 =?utf-8?B?RnQxVnN1S292VGlhUXVOOXNkVGRPSzM0ZXRyOG0yT3JSNW9VMEMyVHMzd09R?=
 =?utf-8?B?YjVERXpCM0hxVDJ3b1dmZ0hrVzBYMytLclRPdTZwaWJQR2lOb2NSUlNOQUc1?=
 =?utf-8?B?c0toSWN3YlB5RGdvY3lMOWlDclpXditSWWZwQ0VLWVFEMktwbU9aSk5RTEor?=
 =?utf-8?B?WWZZMGIrb2pUOVNqaUo4TGFyZTRVL0NER05FVktYNTV0K0tVSzNsVGVPckNl?=
 =?utf-8?B?ekNXUzVPN1dGZEt4RHFScmdxQi9QV1VuTVhsZXNZQ0RpVEJlN0pqOGJqWTVG?=
 =?utf-8?B?b2FWcGJiVzFCUmxOVldvRlpqV3hxM0dNTEVqUGpxZzAwMGhhZjVNdnVKTTh3?=
 =?utf-8?B?djlycWtGYXZpeUlaNVh5V1djc1NSSzJyVVBQdjFxWlEwNWNNbGJ5NldtTldK?=
 =?utf-8?B?WitUbittd2RmWHFSaldsMDlGMjFBdTJ5MVdKK1NKVGlpRWE2a3E1UHBXUVhD?=
 =?utf-8?B?VDBzSWFxOEZ3Z1ZWYzEzT2JSN2dYL1JwTmNZU05ibTZma1EzYlRMRTdENmRF?=
 =?utf-8?B?QzBXbHI1bmZCMDdCYmdMVThnYnJNY0hoVlQ0ZHRFaTRDcW9XSUV5K0h1KzdQ?=
 =?utf-8?B?TktFcUxFU3F2dXJRYXY3QWhKNGppSlFTdUN4aWJzSTF4ckJZZWlCM0ZXb3Y3?=
 =?utf-8?B?cEMzUEN6NGdUVzBPdlduRWw2WEtVcjJDTGJvK3pmb3ZNSW1HRXF3bVNGL3Iw?=
 =?utf-8?B?d2VEY2ZoVXlxWkcyZWJIV3laZmxnNWpPQTNPSEVteVhKWHorV0ZXUnRYeitI?=
 =?utf-8?B?cUtaWkVTMGF4NmVaOFYrVFNYendDNVNxSU9CaWVoRGg1MFJWSG5nOUkyZkth?=
 =?utf-8?B?Z0FkSklCMGtLY2ZQczRrNXQ2UDZnYXpvVGJKeG1sUEIxa2duVFlrcWFrNkwr?=
 =?utf-8?B?S1lUNkR6cmxLZVBqeE5DWHdwT1FiRzZRV3FBdVRnMHBzdmg1OEJhRjR3RVFs?=
 =?utf-8?B?ZXloQ2dzYkRGVU9FblFoVTlDc0FaZlRFL0owbFBwQmdNRTMrZmx3NjdTWWor?=
 =?utf-8?B?a3dTeUE4ZmhYVkxmWEFXdS9YSlNnaGlXRWRWd0dwWUEva0xFVnU5OWd5SkZF?=
 =?utf-8?Q?a65ExTcMzDpV5acUHzMO7seCn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8535ebe-9f29-4f4a-7d39-08dc656d1ed1
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 21:17:32.3966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 80PbZfnY+9vNYjQIx6Jk1oYbvLKw0jAnSxBTxjM8xU/N18dQkhAqWXvEd19C7f7vqQVq16Y1qWp7W2ksFVEwEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8030

On 4/23/2024 03:40, Perry Yuan wrote:
> From: Perry Yuan <Perry.Yuan@amd.com>
> 
> With this new sysfs entry `cpb_boost`created, user can change CPU boost
> state dynamically under `active`, `guided` and `passive` modes.
> And the highest perf and frequency will also be updated as the boost
> state changing.
> 
> 0): check current boost state
> cat /sys/devices/system/cpu/amd_pstate/cpb_boost
> 
> 1): disable CPU boost
> sudo bash -c "echo 0 > /sys/devices/system/cpu/amd_pstate/cpb_boost"
> 
> 2): enable CPU boost
> sudo bash -c "echo 1 > /sys/devices/system/cpu/amd_pstate/cpb_boost"
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217931
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217618
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>   drivers/cpufreq/amd-pstate.c | 99 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 99 insertions(+)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 3d86cd7c9073..49eeb38fcf20 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1291,6 +1291,103 @@ static ssize_t prefcore_show(struct device *dev,
>   	return sysfs_emit(buf, "%s\n", str_enabled_disabled(amd_pstate_prefcore));
>   }
>   
> +static int amd_cpu_boost_update(struct amd_cpudata *cpudata, u32 on)
> +{
> +	struct cpufreq_policy *policy = cpufreq_cpu_acquire(cpudata->cpu);
> +	struct cppc_perf_ctrls perf_ctrls;
> +	u32 highest_perf, nominal_perf, nominal_freq, max_freq;
> +	int ret;
> +
> +	if (!policy)
> +		return -ENODATA;
> +
> +	highest_perf = READ_ONCE(cpudata->highest_perf);
> +	nominal_perf = READ_ONCE(cpudata->nominal_perf);
> +	nominal_freq = READ_ONCE(cpudata->nominal_freq);
> +	max_freq = READ_ONCE(cpudata->max_freq);
> +
> +	if (boot_cpu_has(X86_FEATURE_CPPC)) {
> +		u64 value = READ_ONCE(cpudata->cppc_req_cached);
> +
> +		value &= ~GENMASK_ULL(7, 0);
> +		value |= on ? highest_perf : nominal_perf;
> +		WRITE_ONCE(cpudata->cppc_req_cached, value);
> +
> +		wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
> +
> +	} else {
> +		perf_ctrls.max_perf = on ? highest_perf : nominal_perf;
> +		ret = cppc_set_epp_perf(cpudata->cpu, &perf_ctrls, 1);
> +		if (ret) {
> +			pr_debug("failed to set energy perf value (%d)\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	if (on)
> +		policy->cpuinfo.max_freq = max_freq;
> +	else
> +		policy->cpuinfo.max_freq = nominal_freq;
> +
> +	policy->max = policy->cpuinfo.max_freq;
> +
> +	if (cppc_state == AMD_PSTATE_PASSIVE) {
> +		ret = freq_qos_update_request(&cpudata->req[1],
> +				      policy->cpuinfo.max_freq);
> +	}
> +
> +	cpufreq_cpu_release(policy);
> +
> +	return ret;
> +}
> +
> +static ssize_t cpb_boost_show(struct device *dev,
> +			   struct device_attribute *attr, char *buf)
> +{
> +	return sysfs_emit(buf, "%u\n", amd_pstate_global_params.cpb_boost);
> +}
> +
> +static ssize_t cpb_boost_store(struct device *dev, struct device_attribute *b,
> +			    const char *buf, size_t count)
> +{
> +	bool new_state;
> +	ssize_t ret;
> +	int cpu;
> +
> +	mutex_lock(&amd_pstate_driver_lock);

This mutex lock should be after the check for cpb_supported and 
kstrtobool check.  Right now you have two cases that the lock doesn't 
get released.

> +	if (!amd_pstate_global_params.cpb_supported) {
> +		pr_err("Boost mode is not supported by this processor or SBIOS\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = kstrtobool(buf, &new_state);
> +	if (ret)
> +		return -EINVAL;
> +
> +	amd_pstate_global_params.cpb_boost = !!new_state;
> +
> +	for_each_present_cpu(cpu) {
> +
> +		struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
> +		struct amd_cpudata *cpudata = policy->driver_data;
> +
> +		if (!cpudata) {
> +			pr_err("cpudata is NULL\n");
> +			ret = -ENODATA;
> +			cpufreq_cpu_put(policy);
> +			goto err_exit;
> +		}
> +
> +		amd_cpu_boost_update(cpudata, amd_pstate_global_params.cpb_boost);
> +		refresh_frequency_limits(policy);
> +		cpufreq_cpu_put(policy);
> +	}
> +
> +err_exit:
> +	mutex_unlock(&amd_pstate_driver_lock);
> +	return ret < 0 ? ret : count;
> +}
> +
>   cpufreq_freq_attr_ro(amd_pstate_max_freq);
>   cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
>   
> @@ -1301,6 +1398,7 @@ cpufreq_freq_attr_rw(energy_performance_preference);
>   cpufreq_freq_attr_ro(energy_performance_available_preferences);
>   static DEVICE_ATTR_RW(status);
>   static DEVICE_ATTR_RO(prefcore);
> +static DEVICE_ATTR_RW(cpb_boost);
>   
>   static struct freq_attr *amd_pstate_attr[] = {
>   	&amd_pstate_max_freq,
> @@ -1325,6 +1423,7 @@ static struct freq_attr *amd_pstate_epp_attr[] = {
>   static struct attribute *pstate_global_attributes[] = {
>   	&dev_attr_status.attr,
>   	&dev_attr_prefcore.attr,
> +	&dev_attr_cpb_boost.attr,
>   	NULL
>   };
>   


