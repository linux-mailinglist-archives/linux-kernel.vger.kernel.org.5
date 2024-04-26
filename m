Return-Path: <linux-kernel+bounces-160124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E81708B3978
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 178041C220D8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 14:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36481487DD;
	Fri, 26 Apr 2024 14:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="h2gX//mn"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66B61487C3;
	Fri, 26 Apr 2024 14:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714140481; cv=fail; b=bRtYCH5wMz7gYTW+ChO3W1WF7SOaUYjLnuq4CvS9ky2q9uVBKDqDWWV4iBVPkY2UZNsMzin7z+hdy7N387aklQl9vT4Iw802I6vef0uGr3Jvx/8NP3UqUjQIvse0AMbP0ill5+ABpf0mhY5GS1pB7kPfwukE/TX92RnOaCUBwKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714140481; c=relaxed/simple;
	bh=+j/AjfQ9k5EFb+SBgs70vtBQWgTDWZpT9ldKXNAsvzM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dzAbS9W90I8681YVLbk1IBJDo8sFO2hXeo7jdrQbEHOt+dIk64gmhtNaCbeyL1fOJeQQUzprpbNrDMbdWbW1VK+By/bToWYcB2YTrhxDD+Mqr7J4AowdHeyVWECvSUu8UyuoOFPATeZ9iJLsrdHLZ4FzvLKg+mOJQFhczt32n1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=h2gX//mn; arc=fail smtp.client-ip=40.107.236.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SJurcZAe7HrLqk2nqEpAtn9Iu9w6ZKoJcnZCP/UMdRoTj9ABTtDxljW1AzsrcUnJNlIN+OJYyk+2On2mS5JhnV46qpXwUiHOnpyfd8bmnzW7sTa2kiyqCqrlJ3JYcQgVqF/FEfIlvUzgYJACBIUcNBmuJwkRYu7YS8VpEnwJhsGF+UEZsQLTm+I67cCLHSUHsWusWtz9eZ2KxCNcGz4e+nEWo+u13ozJoBuM2Io6+cCdAMiEoZWX5wn0i6gDErJZji8EE0306wCBcAk1ID1EVpHXXlM08QfDIAk3mx3HbBs0efwodAfqua10TPKUaIMHG4Fjnhqv3PVdTe/EFtSKDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/C6fBdY51yaqr6XlgksuhxwFGtLOBWo4bLpw6r5HFk=;
 b=TmYrmBcsrD3bFn5Lpx2TAgikX+oyyFmzacPFrA/uYMpUdAckbZjwxsBEtWzMo4s82yvlPFVSRlbqmHDkeWlCbMmrH4onuzocSOfKkIznWLTXPiR/8GAs0ekOwn6WJgqn6WTXNKzM/YQlZIuYLKl9L0VbgKX64X8iQEKN4Ei4+q1iPkr8HC9ky2MifXFnQD7xE6dhJoJqeipil8pfDHbAC9l1adsAyYrMa0ay44U2855ObAuXGma0HCXG0tAqu7tSL3hp0C5CjTkHoF4Caknd7fKMzOY5l6H4cchDMy2VqmeeOD1XoRaYgdKuW/jVvhMIXeteIcvWUJ9giIyv3FI9QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/C6fBdY51yaqr6XlgksuhxwFGtLOBWo4bLpw6r5HFk=;
 b=h2gX//mnoLCDqYzUE+gzJWC0+Q9NfXJQ2NIRE4/KimVFE7SHc8TIpoTmU6Su7cRgLEX4cArGQyx/NwvrKJsERKZk5YcuqPs8oWzzYOFdNB1RHZHGFMQAEymDJr5+VN1MZG8uMmXfvFtBMpFKlZaVy9DGgSFM0ZZaU1UafhMkDPQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SN7PR12MB7812.namprd12.prod.outlook.com (2603:10b6:806:329::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 26 Apr
 2024 14:07:53 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.7519.021; Fri, 26 Apr 2024
 14:07:53 +0000
Message-ID: <83f93e72-b03a-4167-ab96-0a6f8017e54c@amd.com>
Date: Fri, 26 Apr 2024 09:07:50 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/6] cpufreq: amd-pstate: implement cpb_boost sysfs
 entry for boost control
To: Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
 viresh.kumar@linaro.org, Ray.Huang@amd.com, gautham.shenoy@amd.com,
 Borislav.Petkov@amd.com
Cc: Alexander.Deucher@amd.com, Xinmei.Huang@amd.com, Xiaojian.Du@amd.com,
 Li.Meng@amd.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1714112854.git.perry.yuan@amd.com>
 <64eb440fd48d10a55525253bce2e9143db872f67.1714112854.git.perry.yuan@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <64eb440fd48d10a55525253bce2e9143db872f67.1714112854.git.perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0149.namprd13.prod.outlook.com
 (2603:10b6:806:27::34) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SN7PR12MB7812:EE_
X-MS-Office365-Filtering-Correlation-Id: 01e05a96-975f-4615-b97a-08dc65fa4384
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UlVhTnFDOTFIZWYrR1B1dmdLa2lzVHNJQ2IxTkUzbWk2d1NxLzRIKzhzS0ZI?=
 =?utf-8?B?WVNkeThTWDFIQVRrNHhDZmtBOEpUSmRJTUQ0N0U4RDd6em4rWUhTbDNOWUsy?=
 =?utf-8?B?d0wxL2p1MjBXSGx2SXYveFRXL3JTZkFPR2c3alNLK21QZFJjYjN1WVNSZFI1?=
 =?utf-8?B?S2xSQ0d5eXlJdmNsNWtoRHdpdjNucDFlZFpJK0xYQk11VG1EVHFxRTBpdXNk?=
 =?utf-8?B?QW1hVnhvVUEvenFrdEZuQjRYN0NlRzlWdkNFOVJNdDhnblZuczJESk1CRTNK?=
 =?utf-8?B?T0FUT1p1YkNxcWVKSWNNbXlPQjNWdTQ5K1NLZnVhM01pS3c0eWlYWGgwdnA2?=
 =?utf-8?B?Y1ppYnhkSkRrKytWeW5lZGU4N1g5NzdhKzNXYlhRQVMrVms3TkxMS0lURmdD?=
 =?utf-8?B?ZE9JQnQ2clJrTXZySElvRkpDbGhZZCtCSTNNakZKR1J3L2ZtWWJhbmN1Q1Yr?=
 =?utf-8?B?OVN6cE1lYTEzdHYxdURURXBaWklhY29aTWlYajFPZFBSaDYrZDZPUHY0OTNE?=
 =?utf-8?B?cUJIQ3A0bm9Ea29CcTdzN3FqYUxmakt4UjVDdVRudG8zNFhWN0VqTHl3RWxn?=
 =?utf-8?B?T3U1UHptKzVoRTFxb25qd1FJeWc3MENNN0tRMU11dndIbVZZbXI5RURMQXVR?=
 =?utf-8?B?TGEvaWR1cDR2N25aVDBJM3p5ZzJ5ZCt1WU4wZWg1elk4MW5SMU10OGdSaGgy?=
 =?utf-8?B?L1d4K3o4RGZGdVp3K012WFo0Q1RNZVFuRXpXSXZ3MEVRUHlXR1VlNTRqYUhC?=
 =?utf-8?B?OTF6dUNYV3E1RllOWVlvTkRtbU8wVkFsc3hNa21VdmtpZ0huZjNndDM3YUZx?=
 =?utf-8?B?RjN6TnBZeTE3WEZndTBkSEMxZklNNFNrWTFFVktXSm5LVXRDV21PS0pyTlZz?=
 =?utf-8?B?MDNURkorUHNTczcycmVqOC9NRlhjczV4UXM2UWxyVzluQTB6VWF5OHFuZ1Bs?=
 =?utf-8?B?UnBvZHBRZFhReHg2QWJPMEM1SW9jOWVpMThMZHNDcC81dVBSbFpwc1JoMnlK?=
 =?utf-8?B?VE5ScS9UQXA2NERRK3BkdDEwenB1MGtOSktBUWpyRXJVMzBYOGg2elVEcUFF?=
 =?utf-8?B?Lzdtb3VQY0lSUmFTN0NBWCtiOXRBb2dvWVRueS9PUGdxWkE1b09MUUtuNy9V?=
 =?utf-8?B?N1AyZFNtYmJWdE9NcEdUcXpIeVZnUUQ3NmZsVm5NUGxJRDltQzFZNW9GQVhY?=
 =?utf-8?B?VzYvVlRHaXlSM3MzTEJaQVoxbnNHeDE3ckZsbmVHRTZ4K1BZcnE5bXRaTlpy?=
 =?utf-8?B?bng1SGlBb21aNFEwOTlYZWdaWkdETW9PN1c3bC9STXBpMXFpaVhHdHJkY2sz?=
 =?utf-8?B?R1pBdmh6Vkd6MVFWZzdJd3d4S2dkOFc5eU9hMjVQRU8xd2xsWWRIeEszY1JG?=
 =?utf-8?B?cnJsa0c0ZklPSlVGcDlGczNmWjVvaTNMYUNlYlFSd09td2hacEFvTm8vVFpw?=
 =?utf-8?B?TEF6N2kvZnY2K2F4MlZ2RUdWTUlSaWhEazJUUGtEbzAyd0NUVFdmL3daL0tK?=
 =?utf-8?B?Qzd6M0VCaE9KbVkyMWZYV1hxSHRaZXBETzdMUEZvZXl2TU1LOC9MdVRIZTEr?=
 =?utf-8?B?Y2FlVDJZcEMyS1UyRVNPeVJjbm51QlZ0NjJEZitlM2xpbVpOWm1ydVVEekJV?=
 =?utf-8?B?K3liZVhYS2JMMDF5UXNVa0hnSjlRZWlBUUpnT0NoYkIzVDIyT21Wc1llQlZH?=
 =?utf-8?B?TGlSMzJDbDRIR0IxZlVEMzVGVFBiWTJhT3djMEczR1Zuak04dUFqNC8wU09U?=
 =?utf-8?Q?cGBXzSWs5J8VLqwybY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUxjRjd0ZGlrMGYzdmk2aHBzR05lV3B6NjBnYzZNVldtRlA1YkpPWU16MFky?=
 =?utf-8?B?WE5lT1VDUGJKVHVaVkY2L2x0aTJKUGl3N3FKa2NGNHZ0a0VGVDI0eG9lS2hQ?=
 =?utf-8?B?UGVWa1RrMzZIaUg5UUJpd0NUaDFQQ2F5ZmRIdC9aekNRL3NKdkdYRUVRbjRj?=
 =?utf-8?B?NnBveVV3Umc4ZjVRREtON0Z0M3dMdGRPWTRJUElMckE3RFRlbUh6c0tjdDlE?=
 =?utf-8?B?SkV6V2hZTFdOMlZqamlqNzlLNUlNeG1ONENFTnQxL2FZUzhvdGdqWEhlenps?=
 =?utf-8?B?dm5sSTVCdHJMcWFoeU40Q213QWk4SExENUQvRTdyMngzTzIrMitZVnk4Sk0z?=
 =?utf-8?B?V0R0NEtETzhRUFo4UkJ4dnVHQUJKRFdTcjVRSzYvb2hidkxxcjlhT2ZSekRw?=
 =?utf-8?B?cEhLK0N1YmxsWWlNUnNKSFhEOEhFcHBtalFhWnlSa0hwYkRCelRiTFoxakhu?=
 =?utf-8?B?Z2xCVTROT0l6ZlBtcjRzRzV1ZWQ2OE41T01BS0NDNW5rK211V3N0UFlTY3BX?=
 =?utf-8?B?SCtSL2dhd29xcXd0V3IxWEdHcEVBaGRHVGhwOThlU2VRZmNKbjBWOXhwUE1X?=
 =?utf-8?B?K3JiUkN6R2lpQ0gxa0FuRUgrY09Vd0ZnL01Td25hV3E1d0VNUXFIQ01rc1hw?=
 =?utf-8?B?TlhBSUl3ODdCRS9ObGFSb3ZxcTFNMEQwMFM2dDZyNk5tVXN0cC9JRzRrQWFC?=
 =?utf-8?B?RWJYWWUvU2lKaFpNOS9ndmk2WWkzb2ZjZWNiSktLeEMyZFdSbUFvYUdNaFlO?=
 =?utf-8?B?Z0lmWlZLbEt4TmlwNTJwQ05xTG1KclRxKzQ1VFlMUXV6Q3hBWHlGaVRqeHI3?=
 =?utf-8?B?MzBIR3J2T2ZFZDhlSm1kT0M3ZVBlelRLYWl6ekU2OEZ1N205RmdpOEFhRHZE?=
 =?utf-8?B?Uk81cUY4UlJmRE8rZWZqRDRZeVZiR1d5cGZHUUVFUTZYR1BXK3pvcGROU0Y5?=
 =?utf-8?B?WVVVTVE2RlVwS1RTNUxLakgxMHV1VHMyM3RQQUUvNkcxdnY0aXQvZWxvNnRP?=
 =?utf-8?B?QklURnAzRkdpOTdSRlcvMnF6eWkzaDJTZEw3Q2dGQnpTNzgzZlE3cWRUbDdY?=
 =?utf-8?B?UVNkaXo4MERtMG5SNlhTM1lZRUlmSGVTK29IVHZ0aG91cEdXekZPWFZZRkFt?=
 =?utf-8?B?ZUQvdHkyOFNlZVNlcDFyYk14cHh4dkJtL2k0UmlIUitZdmE5WVVLSk9CRDN2?=
 =?utf-8?B?Wmd5VDd3bnNFNzVSZHB1S3NlaGhPSmYxemZ5MXNRdFJoSm0wV1RicDBTU3R1?=
 =?utf-8?B?T1JyTGdRRXpET214OGszcVkvblk2MWtRcmE4Wi94a2R3cjY4K2c1b085Rmtk?=
 =?utf-8?B?L1VSMmN4ZzBtUkFMOFQ3NGI4ZGxMb3Bkc25VcTIrSHZnTDRpQnU3ejBUcXJo?=
 =?utf-8?B?VkFmcS9vVnU3NWFNZWF2bHovTG84NUVzN2lCNkNJdENnY0VFdmhiNDNpSGk5?=
 =?utf-8?B?UUZVM1piaFh6cyt6UFRNeU5TSXI4U1BMZThaN3ZUb2piTFpBd3FjUWdyMWhN?=
 =?utf-8?B?MjA2OGpFdlJuWmtEQ28xQ1UxbWxKUnY5VW9qdGhSd2lRZ1N0clVhR1c4TkdW?=
 =?utf-8?B?L0RwYnNmZ1B1WDBPRlVLOGd6U0tmODBSWHg4LzNIS2tXUk1OejF0OVUyd2Vl?=
 =?utf-8?B?K1JJODdjT3o4T0lTUWFkYVQrck01d3JxV1pKQk1BdisvSEtUenVjMnRyZ3E4?=
 =?utf-8?B?OXpNc1pBVGJWeGJsbExKSG5oWjZHZGhsWWMxY0d3d251bFhpSUk2R1JhWTRS?=
 =?utf-8?B?cUJMbG9Ec2RpaXhFMnEzZ0ptNmJWUlcvZEt1ZmF0Ukc3bWgvbFcvNHRlZXlr?=
 =?utf-8?B?Rm5tT29sRDI1cnhwYVdHd0FpOURneFB2bm1sSDlpd2lpelhvNnZ5bllVUGlZ?=
 =?utf-8?B?WDY3czVuVzNCSXA1elUvOG5wdGgzazRlRVVvbEdCUTJpUjNrcytYOW9xeDZO?=
 =?utf-8?B?RWhVdy9qR1hobVRsZ2d5bEZXNkNmd3VNK3NOWlZubzlTdDczdFBlMnlXWG1T?=
 =?utf-8?B?RSt1WUZ2UEpUMTVaNlJuUjZWK1QvM00vYWFrUGJMSHVyTTE1VXdXaEorckFJ?=
 =?utf-8?B?WS93bklXWCtvQXZFeHpCbHkwVEtmSlZQWjNrU1IxR1pyRXJXejJjbDRUVkJV?=
 =?utf-8?Q?bun4NJvXDAEVovetENKtaZ1F/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01e05a96-975f-4615-b97a-08dc65fa4384
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 14:07:53.0191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h6sgOxUucJJ1UFNyIx4qx7MqBan9Wn902xnOhcKwChf81JfOKVStDhpgZH34BsdlfxDShmrpLuOUfACm2vAXQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7812

On 4/26/2024 01:34, Perry Yuan wrote:
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
> index aa17a3134497..53ef39c6dbfa 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1295,6 +1295,103 @@ static ssize_t prefcore_show(struct device *dev,
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
> +	} else {
> +		perf_ctrls.max_perf = on ? highest_perf : nominal_perf;
> +		ret = cppc_set_epp_perf(cpudata->cpu, &perf_ctrls, 1);
> +		if (ret) {
> +			cpufreq_cpu_release(policy);
> +			pr_debug("failed to set energy perf value (%d)\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	if (on)
> +		policy->cpuinfo.max_freq = max_freq;
> +	else
> +		policy->cpuinfo.max_freq = nominal_freq * 1000;
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
> +	if (!amd_pstate_global_params.cpb_supported) {
> +		pr_err("Boost mode is not supported by this processor or SBIOS\n");
> +		return -EINVAL;
> +	}

As this is information that will be known when you first probe, I feel 
it would be better to affect the visibility of the file than let a user 
discover it doesn't work when they try to write it.

Thinking down the road software like power-profiles-daemon and tuned 
will probably adapt to this new file and if their contract is that the 
file exists means they should write it that's going to turn into 
needless errors in any such system's log on every boot.

> +
> +	ret = kstrtobool(buf, &new_state);
> +	if (ret)
> +		return ret;
> +
> +	mutex_lock(&amd_pstate_driver_lock);
> +	amd_pstate_global_params.cpb_boost = !!new_state;
> +
> +	for_each_present_cpu(cpu) {

It seems to me that by making an attribute for every single CPU this is 
wrong.  It means that writing boost for one CPU's files applies to all 
other CPUs too.

If it's going to be a global attribute that is shared by all CPUs it 
should be a single file.

Otherwise this is going to be a problem if (for example) software tries 
to turn on boost for only 1 CPU.  Think of this sequence:

1) 16 CPUs, cpb_boost is currently turned off.
2) Software tries to turn CPB boost on for the "first" CPU only.
3) It reads the value of the first CPU and sees it's 0.  So It changes 
the value for the first CPU (which causes a global change).
4) It reads the value for the second CPU and sees it's 1.  It tries to 
change this back to zero, which again causes a global change.
5) It checks all the others and they're all 0 and it does nothing.

So you see by having a global attribute which is shared with every 
single CPU you now have a flow problem that userspace can introduce.

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
> @@ -1305,6 +1402,7 @@ cpufreq_freq_attr_rw(energy_performance_preference);
>   cpufreq_freq_attr_ro(energy_performance_available_preferences);
>   static DEVICE_ATTR_RW(status);
>   static DEVICE_ATTR_RO(prefcore);
> +static DEVICE_ATTR_RW(cpb_boost);
>   
>   static struct freq_attr *amd_pstate_attr[] = {
>   	&amd_pstate_max_freq,
> @@ -1329,6 +1427,7 @@ static struct freq_attr *amd_pstate_epp_attr[] = {
>   static struct attribute *pstate_global_attributes[] = {
>   	&dev_attr_status.attr,
>   	&dev_attr_prefcore.attr,
> +	&dev_attr_cpb_boost.attr,
>   	NULL
>   };
>   


