Return-Path: <linux-kernel+bounces-159096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D35BB8B2966
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49ACA1F221CF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A516152533;
	Thu, 25 Apr 2024 20:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oIFLqJU+"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE3F21101;
	Thu, 25 Apr 2024 20:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714075658; cv=fail; b=TREAi/T8/8WgvrVUFzbRtEgvc70v/3zVxr2fuliJY8kbUwhC93AsmXzGa9oDzKpFuFNriupUBR8noEWEHWnqx+nv9nzJGfAQ0FV70g/E5O2ghrqi6tU+NnnA0d6MH62kOifnjKe5MNtTP+Q6WfcWK0UXrywH5UxNkaDmKpghreI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714075658; c=relaxed/simple;
	bh=qgLc3YACXr09Hc35+e38q6XgWvtXwp1aizZ1MHelzKI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a1++Cwq6YZ5oYD3fW9I7QBc7f8ei9gOAUXH1BUeP8y4j3rGSIsq81+HB+dh+cWLMiYuHUy8aIkmJDdy3lhNR9537j9kMRKW1cdomJHu2vlBFsR2zqttgtJq2dxFu0JQeUtKPy2+kIQOqyFJVUa5PEr5jPoVvlNIn47ZKz8GUdk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oIFLqJU+; arc=fail smtp.client-ip=40.107.94.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MuJkvKzFAFzs97O73rJwlEYIqbGznFBxay9uH5WPFlKuRsCq5SjltCyGnMr28yg0FIdUCnX/ScZCMmtXgRSZojV0UNcpQxEdITHxDiO7CpoIuDOcefkAnOzgKEugykpE3CbG5IqR/quNm/1yq5xiWQbLuXB6AqvegSPMKWNZTQiJtljpjZAhKUaLODJsE67hBZVXtvr7NJp8L3XUUjhlcD3o7wfRMxFutd0GwIlxWXAAcwop0uoTzT6+GX/ab/CDKZGIWdaR8lFt63jSUk3eP8xBjddf73laWGK/Cw3P57J+9n/aIpjNjJOO8EMIi0YbCbthvGdAGyOMRm+rHXA6Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bdt+8IyAwkGYQR7PvSyT7fEzDuC9IlWPHs5a+Jc+ERo=;
 b=lZ4Hm7P9NgiiuGu+UdeTcBurJyF357BMKKdAootc2UH8Use51aCoS6o3Ze0TrWEJ1zNwCUZ47EjerCN4OQ7hEG6zVBubOY6oo4IZl1IWiTMNTQGwIY4kkLCHgwYZ/Oi7nZS0zXAkuzcvJtBhk7bgmMEKbU2PWlQOvzei7P06n5MzHn8HCkIz2IfwSQK8Yw/UWl55z7RgfEfu7F1owD5wfL4T+MEojU8bq5ztZR6q2byWxB2+8WY8YVSNfgy5l33Dc0ador1fKzCKUKPwgB10MmtBSq9IWgT5ajns+GHtw+8Rvbx6E8Sxyjg2G/N2A8Q/uiH1lE60bxnFlHN/0PpXyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bdt+8IyAwkGYQR7PvSyT7fEzDuC9IlWPHs5a+Jc+ERo=;
 b=oIFLqJU+HFob6HoP9364fWzb3WR3Wobwuii3H3Rkm7P1MkB9SBl0pGVoLdbdnHL002vXZd1u5AjMKVjagqcmk/5TZ0UuaXtDPhZuKhpfh0dmg1JAugmL8XuQ+h3u/f3DkMZNlZ+0ADB/63w+6joq/bXSdWk7X/EyUc+Z5VRQAzs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB5841.namprd12.prod.outlook.com (2603:10b6:8:64::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 20:07:30 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.7519.021; Thu, 25 Apr 2024
 20:07:30 +0000
Message-ID: <a6009bed-aa34-4a3f-91f5-23937e915132@amd.com>
Date: Thu, 25 Apr 2024 15:07:28 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: dell-laptop: Implement platform_profile
To: Lyndon Sanche <lsanche@lyndeno.ca>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, =?UTF-8?Q?Pali_Roh=C3=A1r?=
 <pali@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dell.Client.Kernel@dell.com,
 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>
References: <20240425172758.67831-1-lsanche@lyndeno.ca>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240425172758.67831-1-lsanche@lyndeno.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0019.namprd05.prod.outlook.com
 (2603:10b6:803:40::32) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM4PR12MB5841:EE_
X-MS-Office365-Filtering-Correlation-Id: 112e603f-18fb-4517-b98b-08dc65635670
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MzA1eXRJN2lQRk5qaFpYbDU1V0loc3RGa3RMdUl3QjFhTFY1R2NOZ09EMFFs?=
 =?utf-8?B?Vk9IZXhNNUJDckdqTHBuejZtVWJMdzR5QU50bzZRcGVkYWU1cTdXOGpraXp3?=
 =?utf-8?B?L0hLcVJ5WDBUN0tWRk5zYlNqcTJ0UUUrZHRUNDVPRjRXR1FacXg4K1JkUThQ?=
 =?utf-8?B?US9zRCtCV2tMSm0xM1ZwMFFzcnk2alV1Y21lNE1hU3ZZaGNQVGJJK0U5MzUz?=
 =?utf-8?B?Y3R4MS9YQ05XMjN1UEk0Y2d2OFVUeExPS250UnpzUHdwdW1QbmJZay9TeW1m?=
 =?utf-8?B?YjdqekZTdDV3c21DRUhKN1pDT3M2OVB3c3J4Q2JFT1c0aWtNdXpNMWRMOGd0?=
 =?utf-8?B?MWEvcXEzeWdlYVExTUhBWDRDaXVJdmpSZXNUQ0lubVpvY1dwVWh2M3NwUHY2?=
 =?utf-8?B?SVVRaVR5U1VvVTFvYnRhRVh6OWNUb1NrNm5ja1Z4U2tOM0lLMTBNcnNKdVpp?=
 =?utf-8?B?T3FXVllTRDFCbkRQNXhURHZsOUl6NFJ2THBaZnFqdnhPS3R2N3dOZjFZTFQr?=
 =?utf-8?B?cFpqWGo1SVQrQUV3Q3IyajcrNWlFbFU3aVE5ZWVPbFF0VjBGUjM1RmNsSldw?=
 =?utf-8?B?ZTVyOWc4SkY4RmJwZ1FIYnBzSEdXbjgwbkhqL1JJUFFROWw1RkZaYTk2SDB2?=
 =?utf-8?B?a0QrSG8rS3BHVUdiYXVJcU50Rk5iUlB5MXFGUXdKTzZ3RG81NUhuQlY2eURy?=
 =?utf-8?B?RVNpSlJreFBnN1FCb3RKUmN2bHc5TUlTY0locS80eTZ4ODZQSUxJMFo3ditI?=
 =?utf-8?B?M3c2WGJBRi9zNlJzMDhVZHQyT0t0cVJGTE1NNGREcGs2VEJuUXljbDJ4S2lq?=
 =?utf-8?B?elVNcXhLQ1VvMC9mQWRtYm9vUmsxbmJUL0NKeHRQdnN6S1h2b3kyTTFFcnlP?=
 =?utf-8?B?bjNqUkdKSHAwajZ5cGFVNWdpZ0dUNTdpbnpTUXBWQTM3MXlOYmxFdmpma0E4?=
 =?utf-8?B?V2NYaW55RUp1YVMrc3c2Q3pnZmdtSFlKei9EWExjNkNTOEEvWUFHSjF1OWtV?=
 =?utf-8?B?VmNpWjRFcmxlSG9TSGo1QWFFZTZicmR3NUdOSjBPRWM2TjY0Z2J4b1AzbDhB?=
 =?utf-8?B?SklFQ1hsb2Y0cFRXUmNYc0VsZkY4a0w1eFFLb3cvQzFiYU5xOE1VTHhhbVU1?=
 =?utf-8?B?Sk80b3lUcXpEV3F1NGhNTFNMV1YrV3JhMXp2NDB6QlJSM1JpVVJXRFVQMitp?=
 =?utf-8?B?MExUZ2NLRVVpcFpJUGVxZVlpZ0hrQUYrWGk3eFhZckg3L1hwc3UraERjQ2lU?=
 =?utf-8?B?U1UrYk0xc2hPdnIrY3Azb3dPQWt3R2QyTGVpa0ZmZzlaQjBKbTF0V2F3c2tG?=
 =?utf-8?B?V3lqZlYrZ1FObHdiZGRISFMwdm83Zkg0dkhPSGhuTC90STdYTmtBRHRlY05a?=
 =?utf-8?B?SGZPV3dEMmtwSDl4djJHR2plY0tUQnlON1RYQmZjZi9Ta1Zub1B6UUYwMGNJ?=
 =?utf-8?B?eHJ4UWc3bm9DeGJxSHJpNkp3UkQrVmhnM0c0N0xpTVFFQ0poZmF5OURmN3lk?=
 =?utf-8?B?UkhkUmtBeDJYYXdFWVJYMmVRbUdiZmFLblVQQjlTcFV2T3ZQVkdRa0dQMjdD?=
 =?utf-8?B?Mkxxck5QYmhQR3AxV213dUZKVUJzZzU2aHdENUJ4UFVXeVd2TnJWMitqNUpu?=
 =?utf-8?B?aWlkK0ZodmtVTXJ6bmFJMGRGU0xJaVg4aUxLM0VKWUlXVGcrRStzNWhSUTE0?=
 =?utf-8?B?YytrRFRtdVZtUm5zd2xQVHVKSzNKeUNKUDU0eTZIRXZuNFJBRGp6ekh3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eDVmRXEzMmlOS3VTa1d2WVhBVmZzTUdYRUc2S3h4dlVQZzJlOHdSVXVFdGoz?=
 =?utf-8?B?TWFNQmxabDF1K1ZlZjRnYjB6ZjhNQ2d3TElXdEhzS0xxOEZrS3dzdnBUVmR2?=
 =?utf-8?B?RXhQNlN5TU9tOEhrRldWQzZvbVQrR0l6VStLV2h0NnN1YTh4OUdBSVJkcHFt?=
 =?utf-8?B?aVJlTEd3Y0pFMm91Mktuc3lIUjJsQVY5VzNGYncweWFMQ0NtdmpYRVJKVy9t?=
 =?utf-8?B?UWZGaGMveVp2dFpCYnV0MG9hMFFDczhhTmJlTWhEc3hJdTk0bDk2ZkhTVTFy?=
 =?utf-8?B?SjMvRU1JVGx5Y1lCYnh0UWJXMGtLOUFOdFpJNXYzN1ZIZGwwZDcwcTFPV0xN?=
 =?utf-8?B?V0NvK2RaK3JaelJDd3hKNlM4eWpkWHg4WHdLYUQzc1NEdHcrMXdZVVBDaXRl?=
 =?utf-8?B?UENtZkRMSjRTUVZLRWlyVTdwNW5OOEVXMVpmMlpoMlpXTkVidHl4bjR1WFdD?=
 =?utf-8?B?aDV4NDhrRHk1ZjBNa2NBSjNpdVNpN1FYQmdCSlIrQXlObDF5aXQ3dkpOMHhv?=
 =?utf-8?B?Zkt1SFkyc1UwcVRPZWY4blVpMnp4R05NRmlKWjlyZEtmWFRaTG5CY3owTitp?=
 =?utf-8?B?Vk5EU2VkVFhGazhvMk92ZmliMVVabDQyNEQ1SXJWQ0tTSmJ5dUQ3bXIxTXZw?=
 =?utf-8?B?d0ZHa1pJNlZuK0ZPMVN3WWo4M2ZmQVkxRDBsRG0vQzZ1VVh4Uk5EMnpIajQ5?=
 =?utf-8?B?UWhoRlNQalc2RC80WnRybXpqdFFaNTVNVk04TTlaeU1iQWJ0M3RwTDI3OS91?=
 =?utf-8?B?MGVSbU1Vb2dXS3kyWEEzUVgyenhCclVERjdncFFqR2RpRWRWTkp0KzBTclFD?=
 =?utf-8?B?Y1ErVXZ0M1lnS2hTODNPbDJRNU1OejFNR0hVOWFpWXI2K1ZPN2ovTCt0cEZt?=
 =?utf-8?B?MDltaElyUGp6KzZKWUtyVUJxckVzbkJGaUZYN1FTR2ZnQzlkYlQ1MFdhTFJL?=
 =?utf-8?B?Z0g4dmpOb0tMdm9YaHF6QzFnMmI0WHBHdUMvM3JEM0ZVRE5seklKNkFuWlJi?=
 =?utf-8?B?SjhGMXhRQzdUczgrTXdyNlkxNkFFZnpTZEd0WjVLZVVibnhRdzljNkhBRGFr?=
 =?utf-8?B?eDc2U2RHZ05NeDYzdWN4Yk9LcXhYNE9XOXlLMDQ3RW1yOC8yQUs4clppWkt0?=
 =?utf-8?B?bG4yY2MwdUlTVG54NmVlbnErbDVjaUZmMk9nZzVZaFBhNjFkQ1ZCbS9xWXI1?=
 =?utf-8?B?VzBuT1dWZHBnZU5nUWJFZWxta1FEQXI3RU41QW0zVjB2YjJOYTRyd0VqNUdQ?=
 =?utf-8?B?bFU4Uy9MUFpTNzE0dTBXTFQ5WWgvUlVVMnVCQnpKTm85dlpBbCtzeFhTa004?=
 =?utf-8?B?NnBvMGNILzhEOHQvdUdqakpqTTJXcEM5bjllWVJWQXd0Ujg2VmRJd2d5ZmtH?=
 =?utf-8?B?YXlwNVh1a0RNUmxBa2hGVC9UcUlLVldzVVc5RGpkRzRvQzZkaUEvdlkwNUxK?=
 =?utf-8?B?T1lIWklUd0VyaWtNRFIwU0JTVmc5TjdqVmFDcFI5ZHJWRFRCV2tzRFRKd2NE?=
 =?utf-8?B?ZXlHRHYwdllLRC9LM0Y4L2Q5VGx0TmdJYkJMTFRqeEFKZWRkMXhvVitqWDF2?=
 =?utf-8?B?TC91NHVZZTl0NnZoSXhWR3l1UmplSGU5UFJJd2hERE04WktzVktRK3FNMGZ1?=
 =?utf-8?B?a05yTUFGaE1nT1JuY2hZSi9KdGlkbnVmRFVXNkhkdVl0SEFYT3pVQnIwTVlY?=
 =?utf-8?B?aHZLQ0tkeTBURHR3VCs4UFgwSGhnZEVzMWVMRlBOSWxyekF5YUd3RUN6RUNL?=
 =?utf-8?B?cXFPWlZMeDNTMkhqY0ZncVBGVSs0eDhScTcxRHpUY3h2NVYyeHJXb0o4VHpR?=
 =?utf-8?B?Z3JXZVE4VXNwQmUza0c5Uk5DSVdwRUNtMUNDaUJvS3hkb3BWVWVkemRhbkwz?=
 =?utf-8?B?ZURGcUwwcC9HOU1paytHUTg3L1NVZlhIQkNGczJlU2lwazgxdzdkdHFZb3Vj?=
 =?utf-8?B?SFVBaVRQcEEwUzFBMkVKbHNqT3RsZGsyLzhONGFrc2tUT3J5aWhWWk5ZdjNF?=
 =?utf-8?B?c2UzaE5jSlVhRit1RUtFQVQ5Q3gyRSsxVUwrMTJvWTFqWGJWU1ZmbjFmRVpI?=
 =?utf-8?B?aTdpNVhnaEp1K1FsUXd0d2JETDFmTkMrMmFWU0Y0V3FVaUlVekNHYTE3T3ZC?=
 =?utf-8?Q?ftg04LBQzz/WPhRFuivaABqba?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 112e603f-18fb-4517-b98b-08dc65635670
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 20:07:30.7357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2J6RueKQb9Vui48BCRu4lI65spFK3lkZV+2aEWQVbMMg7Qf6AyRwxhzqpCP+01QsvK+BGQK4TKbJutpZ60n7/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5841

+ Srinivas

On 4/25/2024 12:27, Lyndon Sanche wrote:
> Some Dell laptops support configuration of preset
> fan modes through smbios tables.
> 
> If the platform supports these fan modes, set up
> platform_profile to change these modes. If not
> supported, skip enabling platform_profile.
> 
> Signed-off-by: Lyndon Sanche <lsanche@lyndeno.ca>
> ---

When you developed this was it using a Dell Intel or Dell AMD system?

If it was an Intel system, did you test it with thermald installed and 
active?

I'm wondering how all this stuff jives with the stuff that thermald 
does.  I don't know if they fight for any of the same "resources".

>   drivers/platform/x86/dell/dell-laptop.c | 220 ++++++++++++++++++++++++
>   drivers/platform/x86/dell/dell-smbios.h |   1 +
>   2 files changed, 221 insertions(+)
> 
> diff --git a/drivers/platform/x86/dell/dell-laptop.c b/drivers/platform/x86/dell/dell-laptop.c
> index 42f7de2b4522..7f9c4e0e5ef5 100644
> --- a/drivers/platform/x86/dell/dell-laptop.c
> +++ b/drivers/platform/x86/dell/dell-laptop.c
> @@ -27,6 +27,7 @@
>   #include <linux/i8042.h>
>   #include <linux/debugfs.h>
>   #include <linux/seq_file.h>
> +#include <linux/platform_profile.h>
>   #include <acpi/video.h>
>   #include "dell-rbtn.h"
>   #include "dell-smbios.h"
> @@ -95,10 +96,18 @@ static struct backlight_device *dell_backlight_device;
>   static struct rfkill *wifi_rfkill;
>   static struct rfkill *bluetooth_rfkill;
>   static struct rfkill *wwan_rfkill;
> +static struct platform_profile_handler *thermal_handler;
>   static bool force_rfkill;
>   static bool micmute_led_registered;
>   static bool mute_led_registered;
>   
> +enum thermal_mode_bits {
> +	DELL_BALANCED = 0,
> +	DELL_COOL_BOTTOM = 1,
> +	DELL_QUIET = 2,
> +	DELL_PERFORMANCE = 3,
> +};
> +
>   module_param(force_rfkill, bool, 0444);
>   MODULE_PARM_DESC(force_rfkill, "enable rfkill on non whitelisted models");
>   
> @@ -2199,6 +2208,211 @@ static int mute_led_set(struct led_classdev *led_cdev,
>   	return 0;
>   }
>   
> +// Derived from smbios-thermal-ctl
> +//
> +// cbClass 17
> +// cbSelect 19
> +// User Selectable Thermal Tables(USTT)
> +// cbArg1 determines the function to be performed
> +// cbArg1 0x0 = Get Thermal Information
> +//  cbRES1         Standard return codes (0, -1, -2)
> +//  cbRES2, byte 0  Bitmap of supported thermal modes. A mode is supported if its bit is set to 1
> +//     Bit 0 Balanced
> +//     Bit 1 Cool Bottom
> +//     Bit 2 Quiet
> +//     Bit 3 Performance
> +//  cbRES2, byte 1 Bitmap of supported Active Acoustic Controller (AAC) modes. Each mode
> +//                 corresponds to the supported thermal modes in byte 0. A mode is supported if
> +//                 its bit is set to 1.
> +//     Bit 0 AAC (Balanced)
> +//     Bit 1 AAC (Cool Bottom
> +//     Bit 2 AAC (Quiet)
> +//     Bit 3 AAC (Performance)
> +//  cbRes3, byte 0 Current Thermal Mode
> +//     Bit 0 Balanced
> +//     Bit 1 Cool Bottom
> +//     Bit 2 Quiet
> +//     Bit 3 Performanc
> +//  cbRes3, byte 1  AAC Configuration type
> +//          0       Global (AAC enable/disable applies to all supported USTT modes)
> +//          1       USTT mode specific
> +//  cbRes3, byte 2  Current Active Acoustic Controller (AAC) Mode
> +//     If AAC Configuration Type is Global,
> +//          0       AAC mode disabled
> +//          1       AAC mode enabled
> +//     If AAC Configuration Type is USTT mode specific (multiple bits may be set),
> +//          Bit 0 AAC (Balanced)
> +//          Bit 1 AAC (Cool Bottom
> +//          Bit 2 AAC (Quiet)
> +//          Bit 3 AAC (Performance)
> +//  cbRes3, byte 3  Current Fan Failure Mode
> +//     Bit 0 Minimal Fan Failure (at least one fan has failed, one fan working)
> +//     Bit 1 Catastrophic Fan Failure (all fans have failed)
> +//  cbArg1 0x1   (Set Thermal Information), both desired thermal mode and
> +//               desired AAC mode shall be applied
> +//  cbArg2, byte 0  Desired Thermal Mode to set (only one bit may be set for this parameter)
> +//     Bit 0 Balanced
> +//     Bit 1 Cool Bottom
> +//     Bit 2 Quiet
> +//     Bit 3 Performance
> +//  cbArg2, byte 1  Desired Active Acoustic Controller (AAC) Mode to set
> +//     If AAC Configuration Type is Global,
> +//         0  AAC mode disabled
> +//         1  AAC mode enabled
> +//
> +//     If AAC Configuration Type is USTT mode specific (multiple bits may be set for this parameter),
> +//         Bit 0 AAC (Balanced)
> +//         Bit 1 AAC (Cool Bottom
> +//         Bit 2 AAC (Quiet)
> +//         Bit 3 AAC (Performance)
> +static int thermal_get_mode(void)
> +{
> +	struct calling_interface_buffer buffer;
> +	int state;
> +	int ret;
> +
> +	dell_fill_request(&buffer, 0x0, 0, 0, 0);
> +	ret = dell_send_request(&buffer, CLASS_INFO, SELECT_THERMAL_MANAGEMENT);
> +	if (ret)
> +		return ret;
> +	state = buffer.output[2];
> +	if ((state >> DELL_BALANCED) & 1)
> +		return DELL_BALANCED;
> +	else if ((state >> DELL_COOL_BOTTOM) & 1)
> +		return DELL_COOL_BOTTOM;
> +	else if ((state >> DELL_QUIET) & 1)
> +		return DELL_QUIET;
> +	else if ((state >> DELL_PERFORMANCE) & 1)
> +		return DELL_PERFORMANCE;
> +	else
> +		return 0;
> +}
> +
> +static int thermal_get_supported_modes(int *supported_bits)
> +{
> +	struct calling_interface_buffer buffer;
> +	int ret;
> +
> +	dell_fill_request(&buffer, 0x0, 0, 0, 0);
> +	ret = dell_send_request(&buffer, CLASS_INFO, SELECT_THERMAL_MANAGEMENT);
> +	if (ret)
> +		return ret;
> +	*supported_bits = buffer.output[1] & 0xF;
> +	return 0;
> +}
> +
> +static int thermal_get_acc_mode(int *acc_mode)
> +{
> +	struct calling_interface_buffer buffer;
> +	int ret;
> +
> +	dell_fill_request(&buffer, 0x0, 0, 0, 0);
> +	ret = dell_send_request(&buffer, CLASS_INFO, SELECT_THERMAL_MANAGEMENT);
> +	if (ret)
> +		return ret;
> +	*acc_mode = ((buffer.output[3] >> 8) & 0xFF);
> +	return 0;
> +}
> +
> +static int thermal_set_mode(enum thermal_mode_bits state)
> +{
> +	struct calling_interface_buffer buffer;
> +	int ret;
> +	int acc_mode;
> +
> +	ret = thermal_get_acc_mode(&acc_mode);
> +	if (ret)
> +		return ret;
> +
> +	dell_fill_request(&buffer, 0x1, (acc_mode << 8) | BIT(state), 0, 0);
> +	ret = dell_send_request(&buffer, CLASS_INFO, SELECT_THERMAL_MANAGEMENT);
> +	return ret;
> +}
> +
> +static int thermal_platform_profile_set(struct platform_profile_handler *pprof,
> +					enum platform_profile_option profile)
> +{
> +	int ret;
> +
> +	switch (profile) {
> +	case PLATFORM_PROFILE_BALANCED:
> +		ret = thermal_set_mode(DELL_BALANCED);
> +		break;
> +	case PLATFORM_PROFILE_PERFORMANCE:
> +		ret = thermal_set_mode(DELL_PERFORMANCE);
> +		break;
> +	case PLATFORM_PROFILE_QUIET:
> +		ret = thermal_set_mode(DELL_QUIET);
> +		break;
> +	case PLATFORM_PROFILE_COOL:
> +		ret = thermal_set_mode(DELL_COOL_BOTTOM);
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return ret;
> +}
> +
> +static int thermal_platform_profile_get(struct platform_profile_handler *pprof,
> +					enum platform_profile_option *profile)
> +{
> +	switch (thermal_get_mode()) {
> +	case DELL_BALANCED:
> +		*profile = PLATFORM_PROFILE_BALANCED;
> +		break;
> +	case DELL_PERFORMANCE:
> +		*profile = PLATFORM_PROFILE_PERFORMANCE;
> +		break;
> +	case DELL_COOL_BOTTOM:
> +		*profile = PLATFORM_PROFILE_COOL;
> +		break;
> +	case DELL_QUIET:
> +		*profile = PLATFORM_PROFILE_QUIET;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +int thermal_init(void)
> +{
> +	int ret;
> +	int supported_modes;
> +
> +	ret = thermal_get_supported_modes(&supported_modes);
> +
> +	if (ret != 0 || supported_modes == 0)
> +		return -ENXIO;
> +
> +	thermal_handler = kzalloc(sizeof(*thermal_handler), GFP_KERNEL);
> +	if (!thermal_handler)
> +		return -ENOMEM;
> +	thermal_handler->profile_get = thermal_platform_profile_get;
> +	thermal_handler->profile_set = thermal_platform_profile_set;
> +
> +	if ((supported_modes >> DELL_QUIET) & 1)
> +		set_bit(PLATFORM_PROFILE_QUIET, thermal_handler->choices);
> +	if ((supported_modes >> DELL_COOL_BOTTOM) & 1)
> +		set_bit(PLATFORM_PROFILE_COOL, thermal_handler->choices);
> +	if ((supported_modes >> DELL_BALANCED) & 1)
> +		set_bit(PLATFORM_PROFILE_BALANCED, thermal_handler->choices);
> +	if ((supported_modes >> DELL_PERFORMANCE) & 1)
> +		set_bit(PLATFORM_PROFILE_PERFORMANCE, thermal_handler->choices);
> +
> +	platform_profile_register(thermal_handler);
> +
> +	return 0;
> +}
> +
> +void thermal_cleanup(void)
> +{
> +	platform_profile_remove();
> +	kfree(thermal_handler);
> +}
> +
>   static struct led_classdev mute_led_cdev = {
>   	.name = "platform::mute",
>   	.max_brightness = 1,
> @@ -2266,6 +2480,11 @@ static int __init dell_init(void)
>   		mute_led_registered = true;
>   	}
>   
> +	// Do not fail module if thermal modes not supported,
> +	// just skip
> +	if (thermal_init() != 0)
> +		pr_warn("Unable to setup platform_profile, skipping");
> +
>   	if (acpi_video_get_backlight_type() != acpi_backlight_vendor)
>   		return 0;
>   
> @@ -2344,6 +2563,7 @@ static void __exit dell_exit(void)
>   		platform_device_unregister(platform_device);
>   		platform_driver_unregister(&platform_driver);
>   	}
> +	thermal_cleanup();
>   }
>   
>   /* dell-rbtn.c driver export functions which will not work correctly (and could
> diff --git a/drivers/platform/x86/dell/dell-smbios.h b/drivers/platform/x86/dell/dell-smbios.h
> index eb341bf000c6..585d042f1779 100644
> --- a/drivers/platform/x86/dell/dell-smbios.h
> +++ b/drivers/platform/x86/dell/dell-smbios.h
> @@ -19,6 +19,7 @@
>   /* Classes and selects used only in kernel drivers */
>   #define CLASS_KBD_BACKLIGHT 4
>   #define SELECT_KBD_BACKLIGHT 11
> +#define SELECT_THERMAL_MANAGEMENT 19
>   
>   /* Tokens used in kernel drivers, any of these
>    * should be filtered from userspace access


