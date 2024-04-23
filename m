Return-Path: <linux-kernel+bounces-154549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8798ADD79
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C886AB214BC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 06:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B71922F00;
	Tue, 23 Apr 2024 06:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Xr+h85FZ"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB05120B33
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 06:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713853560; cv=fail; b=ZqG059HVbCdje6/44a9BjYWKY0MmyPo2xXjFTldAzxn9JTNIJJPtyDtBerdG6223nZYcQYQQLyjI04ePXHAzOLEF/Ilwkm5MMHV7CqBMVGUXUmk993MSkhfOR21eM2tbwBqndvQEdqT5G9SIeEzyjCAkFfT5OpgeJuuY6XwKdjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713853560; c=relaxed/simple;
	bh=1qieh4aFqHLr2qhSDir1PtRV94Bm6OjcCDkWk/jY0kI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GbnkuBWjLy9WJOW8L70bQbbelo5y5VogGHgxUASzvChpllwrDyqpNOOFMHekluMJCvGoBhEWmXx5EIQWMtwfzKiSkwfgY8CqR8ibG3ugdGqeg6dWRd11sf9OdDD2ssv/LrV9Nd90+LHARXW6qX9MrMiubUJ/4wovgsSnkxoU+Rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Xr+h85FZ; arc=fail smtp.client-ip=40.107.236.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UfjHkWVk/q4U8rHdGkK6tVK3InSw2qq9+hJ8TnkBMmk9QS2SDWuSN14uj8kQAi01Gost4Fkay5dMSGLC1DnBiVqFMo95t+V/p/hRLrz5Iz19cUBYE8/TAZO8CZZtXdUcmjF11adKx0mFauHrQMXu1wRaJSD6oVUYG7XO6Y7V0kmm9Wj/bgMMzYCk198LqVrs7pf5q6nPGoGvtIqzYtwrDQZJmMoUGaXqJwlkgH/k+ACaOSdpnP+J7SOZe7mKVg8yLwl49D8+7cNQWPI0kZYFC4Do5QPJhPHZcxZocBedhmCJT+eWq4xeBUJXDR0gmO7FEbV2sqOUEsoGG6dqkeDSRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1qieh4aFqHLr2qhSDir1PtRV94Bm6OjcCDkWk/jY0kI=;
 b=LYaLNNlCYK70IYnMBzut1AoCLxc54zl0iTxRN1BB8VAsB0tpxdQg3ktWJsO3vHz6Qo8zfohQYjiw0hIUdcYomVgHMX7vyU/ZKJ8fLkbiFM+b9ekmSQ0TwMvcQKAhWY7qY6yVB/N+mpQSmIiVXj4zx4rbxskjtSc36nM2yaDRHQjbPQMHQQmDeFNjxf/kQU+YSinNR2YU1X9Om9Pv23bFXdCh0Y3mwekRSaEKdC+DBVVsJb9go5uogyA0B8bMdx5/SbJKuhZjm2PY2WJM2Z2CP/K8qD9LS9qaPM8G6EhJxYSlgxkogvFlARhvnOrYtaW6e61Ug7jrP/fQnlvor/+vcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1qieh4aFqHLr2qhSDir1PtRV94Bm6OjcCDkWk/jY0kI=;
 b=Xr+h85FZaFw93dHmMvfyopo7veR2eviddm3Soliyqh7x1j3+yQ/Bkc3CYXq7UcTPleD6i809jyDimslPoMj4YDGN+xdCgaaRRD2YcYd3H+XjoLjoqnm3XYwFw5Q1tOPxKR0bxRx6XKnnAB8Mn+Ii0z2OmgzJciDcR50ymBK5s4E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DS0PR12MB7701.namprd12.prod.outlook.com (2603:10b6:8:133::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 06:25:56 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::c3fc:3be9:dde7:745f]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::c3fc:3be9:dde7:745f%7]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 06:25:56 +0000
Message-ID: <691e50b7-1c1a-478a-815b-fb2a6bfdae8f@amd.com>
Date: Tue, 23 Apr 2024 08:25:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] phy: zynqmp: Don't wait for PLL lock on nonzero PCIe
 lanes
To: Sean Anderson <sean.anderson@linux.dev>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 linux-phy@lists.infradead.org
Cc: Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Kishon Vijay Abraham I <kishon@kernel.org>
References: <20240422185803.3575319-1-sean.anderson@linux.dev>
 <20240422185803.3575319-3-sean.anderson@linux.dev>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240422185803.3575319-3-sean.anderson@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0020.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::33) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DS0PR12MB7701:EE_
X-MS-Office365-Filtering-Correlation-Id: 106e09d8-8858-4df5-c2d0-08dc635e3bd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eXNkcUJBOThtaW4wSWtVTXZpR29LNnlsV2tnbXVJcVc0QjlycTF6U1o0cGNI?=
 =?utf-8?B?N0s4RllURmxLYmNOUWplaGJHKzVGS3cwR0l3VHVJYUxFMFY3T0FyQnBhVkdv?=
 =?utf-8?B?SEZ6UlRzbkdlREhRUGRBeGptb04rME9CYnZOVEpPbWh1WCtYY254WkkyaVFG?=
 =?utf-8?B?MThGdjZySE5Ldmw5Zld1dWFlYnFkWGxhMUJHcG12Z3Nqc213UWduOUkyUEpn?=
 =?utf-8?B?amNLNUZXdWNjalh3Z3dlMW9Ib3orakVwL1JQYklZbFFHWEw1eUk2L3g4cGN6?=
 =?utf-8?B?UEF4ZDZOOTJBME5xVzUyVUo3bGxEaVo3bytsYmdWdnBPclFOaVNkT1VCaURu?=
 =?utf-8?B?Sk85dXZhQWgxNVFIV042ZC9vaWc2MnVJUHVYbVBNZDlyZWxGUEM0YW1NSUJD?=
 =?utf-8?B?aVJ0Qlhxak90MGpCV1RqclVJS3FlbU41NDRCU2NleFJiRzIydEhhWkRzYjdE?=
 =?utf-8?B?c3E5NUNScWRiUVpoRUZHTEFiK3c5WFBEdGZpa3lpOFdxZkRrSWsxQWlOT04r?=
 =?utf-8?B?cUpoQTgvUU8xMUxmbENVN0lIMHdCTTVHNlRFS2pJNi9BNSthRUlCK1dISklL?=
 =?utf-8?B?YnZKN1lkbTZSWU9TMC8wdlF0VGRWRVdLeVkvRFhMZ3dqQ09xODR5MXUzN3NS?=
 =?utf-8?B?TmlaT3ZWRUNnUjA2enlxY01rNTRkanVQZlZzTXhOQWc1N2h3cWZyZ1ZPQU5m?=
 =?utf-8?B?T1JKNGMxWlZSVnR1bDRqQzZoQTlLRDNOc1VWdkQvdFVsTFV6WGU0MXh3MFN0?=
 =?utf-8?B?MTQybkhtKzA3RktITUNBT245Y2pic0UwYlRwZStLak1wVCs4clZlRm1DNTZS?=
 =?utf-8?B?ZXNINmtuVjAvclByeldlcHhianVyK3lEd3JUQ1JTT0EvSmVYSGxkQ3NtUzQ0?=
 =?utf-8?B?Yjg2M3RWVUJla0pPSkJDVjJLSXJKWWM3UkNFU2pONThkT3EwbFBaUG9lYTd6?=
 =?utf-8?B?S1BxUkdtS1FmSUdudEI2WWM0YlZTSE55UzJkTXNtZzRqQk9Bd1Rod0k3WE92?=
 =?utf-8?B?S3IzNWJpTGMyMDYzQ3EvMXNhcjB1OHpleWhTckNmd0VGWnF1eXV3ZzNqd1Jh?=
 =?utf-8?B?RDFqN1kwb2NyNEg2VjQyaGgwZ2x3YURyeHRkQmRRTVhJbWZ3U2dkaTJZbDR5?=
 =?utf-8?B?dEhjRE56SjBKY2xZR3lyeEc1KzNKU3d3V2hxb2dPdjZBQkhySU13SThONjEz?=
 =?utf-8?B?OEs5TGV1KzVvc3hrMTYrNXhjejY5bVF4aGIzN29wWkEwWDhNYUNaQTRlMk90?=
 =?utf-8?B?WEpTTjFQMkpHaVJqY3ZubTljSWRUZjBBK3BxekJIYytKc2tBTmRpYlM0TnpS?=
 =?utf-8?B?ZjVYTUJjSUpWMit4TWNtU2kydEhtL25EZDNUU0Y4cFV1ZkxpWWdUblZEVHEr?=
 =?utf-8?B?Y3czZ2dWd3hpU2pLRm5Hb2NsMUp2V01BN2ZicytUb0hMY1hFV0tZUDdYbFc5?=
 =?utf-8?B?Ukk3TFpBeFlnT2FqVXliOUNWNE5Ba0lSMWo3RE95Zno5eHJ1QnVpL1lDa2Ur?=
 =?utf-8?B?U2FHUHAxbTJwQ0pQemFIWkEwMmZRRm05RzNNZVhwaFpDK0V6WXZXbzVjQVdw?=
 =?utf-8?B?Z0pFUXBSdk9NaTlZMEYzKzVmSjc1dGlSVkZBcWdXWWFsYmdQbmhUYXlmTzRw?=
 =?utf-8?B?bGw1dlFHWVZzMzdoRVlJampIQVZuZzFwY0c1MWhVaVpQUzFzN0t5QzRRbndM?=
 =?utf-8?B?RExyYnJGYmNVVUppVGtheXB0c2xLc1FGUnhvNStjVWwzbGRpY1MrV1lBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?anVFYlF6d0Nha0Z0bFFXanFnWjVjdG52UWZhRUxRK1VOa09kWjhHNUs4eVYv?=
 =?utf-8?B?Q2NWZUpSbkxucC90VmgzbDhoWUlsVVJ2QzhTUkZaOFpWUVY1VnJKWVVPaU1W?=
 =?utf-8?B?b3B5VHgreFhNUmV1allIVm5xWEN2ay9JSzJVaWprdVBpdlplU3hPVm1BYWpQ?=
 =?utf-8?B?N0o1K1VHRGdVSkQrQWtjSUw3SnVid2ZPUi9uMjFQTWJ2U2VXajlCSWljRXVy?=
 =?utf-8?B?VkFuaW82QnNFTFFzL05TMUI3V0lyVS9WZmdDa3VxdldmMDV0clM5TkkrT2dS?=
 =?utf-8?B?cFp3S2lLaGFQWm9KdjVGTEtLOUhXbGxPK0doYjR6SGlVUmxGTEU3U3Z4WEpV?=
 =?utf-8?B?eXFGV0lSQ2h3TXJ0cFdjbVA1eWo4aEMrWWNOZ0U1Z3ZoS2Z1NkRhMlFKdnNL?=
 =?utf-8?B?UWJXMlhRVkZWYnRoclpTaVFRaXJET0JyU1RieVdZa1R3OFZqWVFGV1B1d0kr?=
 =?utf-8?B?SFlMSGF1Mit6TDdJTjRjdFZ2ZE5ZZ3JqdW8wOGlBYXh1dHZjdEF3QlVhVFhw?=
 =?utf-8?B?SjkwOHU2OXNxQ1ZqMFZZck1SM2wxS0MrRGRCOUtMQ0FPUmhlWnRzWjIwS2lu?=
 =?utf-8?B?SGkyMGxaUHlpa1dJQ1JoaVE5aWJjOU9ZOEhwUUl6KzFZRFhYMlg4ejEwcXEv?=
 =?utf-8?B?MVdOQllERHR1Z2YrUE9WRlpPZ0lmUWZaQmZlY214NkptSUJCeHdZQ1o4OVFs?=
 =?utf-8?B?ZXJGVy9jTkF6ZHFxaUFLNVNmUTJkUmszdklzbmNlY0NhL2RyaEFFdThNR1F0?=
 =?utf-8?B?RFFoU3ZXRVVodndoV2RSZW1sN2pCOFlvbk5DWTdVL0E0dEtHd05rQmZOd01K?=
 =?utf-8?B?RDY0d0RXWVdjK0FySERENDF3ZGdLaXFWNUk2QUZwQm0rUnM3YkJ2bmVPTXFi?=
 =?utf-8?B?TlA1aDl0YURqQ2FYZGZYOGZnWnVPM3V1cCtQQ2trOGljSDJrVHEwZ2NpK2JU?=
 =?utf-8?B?ZGhiSTJXSEdmVyt6dm9Hb2E1NEZxVE9hb2prbVlxNGdaZE1OQTNtd2tkWXlv?=
 =?utf-8?B?QitwYmhtWWE3bS9IQUo4Nko5MnlUVFZhcnFvTGljTlBiRDBZMEhOTFB6Y3k5?=
 =?utf-8?B?dDNMM0ViSWJmYkxqL1llTCtEQm5aTkZWVGl2enVrRW0rY0IyL3pqc3lRR3lF?=
 =?utf-8?B?Y0RaZVlJQWE2dzZYa1F5OFR0UmpSLzJPN3g1dVRyYTl4OWY2bU1ZMXlSd0ly?=
 =?utf-8?B?bHBuOEVJRXhYbnEvcTNRcHp4bE9xMys5UXZhek5QMXhJNkhwWThDMWM3WnY5?=
 =?utf-8?B?V3hQOURKNGppQ3o4Rk1TQzJZaUdyTFFjZHF2b0ZwQmdjTVJ2bkRSdFl4ZnhP?=
 =?utf-8?B?K2pGem13QzRSMUVMZXhVNGxPZE1TNVZjOWt1Y1QrendSNk92MERWOVk4K08x?=
 =?utf-8?B?cEZIV2d6clR5T1Z5WUNpR3pLd2dPNVN6WnlpQW0yL0ozTVBkcU16Rk1XcVk2?=
 =?utf-8?B?NFRjWndWbXZDMWFOU0hnRTNRMWdhS3gzeFBwZE5FelZ1RFkwSnBLeHBLMjdF?=
 =?utf-8?B?RW5mZmJ5WGxwOGxuRmZ1MDJ2T2VzaUd5emlCSVhqV1JEY3JNMXNleXFsV3d3?=
 =?utf-8?B?WDRQeW56ZnA4dzBTR2I5OXB3RVd2Nkw2Q2hYcjNpTHRITGpSaHpHbU9IWUor?=
 =?utf-8?B?ZlB4NGpjYVNvUUxTeTZ0TlBsSy95VlRER2RuWTF3aXVtM3NwL2VSR0Frc2N3?=
 =?utf-8?B?dGJ2MDEvNCtXMG1keEJ5WlFvMzRwME5OaEZHMk02M1pwenBpSmRZdEJJTXFZ?=
 =?utf-8?B?R1ZtS09wend3OFgwS3VWRGp5aVpqU2JzaVQ0L1lyWllobnB5cU1qanlwR3A3?=
 =?utf-8?B?S05VaDVVL3J1OEZnKzh1RTRJdE1PSlBaOU1SbjhLSnhGc3VlY1pCRTB5ZWtB?=
 =?utf-8?B?TXhURXNHeEtCeUUxQ2FHcDAxSUtkQ3lTZnpueWFPY2dEMWFiZEFWdnVHaFpF?=
 =?utf-8?B?YkFGeFhtckRveERCTFZFOGZCdTV1bWgxdGhTRzZLTFRSb252WDFHcXcxZUgx?=
 =?utf-8?B?L3FCcVhnNEZFS3o2b2hsMGpLT1JrWXNrcVUxTGMydGpzQmM5YUlqdHZSSis1?=
 =?utf-8?B?aEVsT2VWNzNaWnY1OFY4S3hLU01OR2g4Y2tHUGFtL3RrUm9yS09ldG95NXpR?=
 =?utf-8?Q?ANnKZouMwtXbLQzgAChJzADdD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 106e09d8-8858-4df5-c2d0-08dc635e3bd9
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 06:25:56.4427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P3CEJk7Vz8AbAfIOHE1Tf9eeHxOWPsizWHKKz4y9ocL322vqydlxiJWLCMFfL5bP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7701



On 4/22/24 20:58, Sean Anderson wrote:
> Similarly to DisplayPort, nonzero PCIe lanes never achieve PLL lock [1].

What is this [1] for?

M

