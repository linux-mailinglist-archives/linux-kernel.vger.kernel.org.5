Return-Path: <linux-kernel+bounces-104197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B07D87CA8F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 10:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEB6F1C2177E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 09:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B9217BB9;
	Fri, 15 Mar 2024 09:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=criteo.com header.i=@criteo.com header.b="vfIWnh+e"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2065.outbound.protection.outlook.com [40.107.241.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1F718032;
	Fri, 15 Mar 2024 09:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710494281; cv=fail; b=Ry6r364YOm7ua5B0eLyblwwLpWtc2a84UDrbG/rnoGrVNEmNJEl63Axgg6aCdoct2JwWr5rluOEURD26hesIsr9ip+Ny8cIb/EcYMKhWgLAGJe5oTvxIG/Tbz8KMDCAB29EA/Tp15f04qKrtGWpxGK+4guQY/bUAl986LSX2HrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710494281; c=relaxed/simple;
	bh=WRkRfJaWTgRVTw02SDRLDEvuBhXVCCdJzp++63WgzkE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=frlTo/9j0UuBPWn4ssnRyRVWo44/4QZKposuxcsUI0CmZI56lI/3Ti4Vvkeidp7Jp/29lpz5phuh1UNQcVNDM7p1UBslMgmAs5HsRC6hDBeUPaFjYjEEp4T1r+2EtZJDS66eWoZy29NiG9SZmy/taOoCW9107uCIhpjYGw3hR9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=criteo.com; spf=pass smtp.mailfrom=criteo.com; dkim=pass (2048-bit key) header.d=criteo.com header.i=@criteo.com header.b=vfIWnh+e; arc=fail smtp.client-ip=40.107.241.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=criteo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=criteo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KJcU2/EZT3C5FBj2nlpVjCpsOhmBCDNnz8e0CWxuGV7Nlbf61xsdxzfxF8l7nqCA1F+zR45Yw/GU8KFJ+3Prxc3P3CoO6Gux4bmEPxmpce9qGmxB/nmq1Fz/NMOtHDtNZ6jHs+M1dJLkJI+Gzh3JuX1I75/ugBjPO3zX6/PbZVV0tqUtX0K26zwemT/1yqH7uhyw1eEQ8B0uwYmvLf/R0LcJGUdxy1pwKuMPHI/ntEQGPvp2fN83gy397LAQ+3jDmSuV4wanbtF2ETNAFI+tbmuqJiIjf/XRr7G5nXNTi5nlYjAQIHpZWaXC40WD3BiHoDb3cGidTNkH+gvV4l8rQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a06yrk26/9+TOFyA44NllOLBtarfJ636tqL0khrX3jk=;
 b=RWJy+qWijePAlwAOhMvFif8uT+nls7HpL4FPaml4XCi9WsxWBlhYtjeN9L5gk86Q8xD8urBKAqu50qX5N3jB4xaTeHVPgaACIzKhBTAiyJXx7Ox++JIjKlVb7IykXbzOJ4/JUJ2d6SQnt6AmTNOrCIFITNFfWJgIKzFB0yffc19STZJUNVtrQbfyMB673IDn16mn2pE5aRBE2BY+JgNslHk2GcjJsX4XpraJo3BWW1Z1j1asSW+PLL7FjHOTjmrDhZecWPbUuR7fU6Vf1P46vfGc+OVqbnDQBbxdatLZ6YTerH2HeOH+HaRR9fjpezbuCWC+DAdinMJMYxCkYNp/Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=criteo.com; dmarc=pass action=none header.from=criteo.com;
 dkim=pass header.d=criteo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=criteo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a06yrk26/9+TOFyA44NllOLBtarfJ636tqL0khrX3jk=;
 b=vfIWnh+eLiqYvRUe4lwqtxtF1FrJ8Wh6NHZsBtJZB1ToMcTqTBK4nN2p9VGHGHDplxOFdsZ450K6pc0HGdP1Tp6kZaBOKVcaruqIOgphUrBa58TyBPYRpuh4d7/ZdHS8q5hRi0VbuBJUkUKDHhHlgwIwt6kvrfLg8i7xRN2SkzJ1DmHe/pZEjHNBFzMH/HV08Q2nEZY4ixpGR8srvZzUpgBcOxakN+nDNTWn2fO8DHEdFy6GMwgIYqEoK9Q8DKjta5jcYvC9rbi3I34vAIGwHYA7O7AgeupydsRtLX6EyfOZZ0ogNT+WGezsSz/9bgaYQA9QiDOoG+1N4K7O1txqww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=criteo.com;
Received: from PAXPR04MB8989.eurprd04.prod.outlook.com (2603:10a6:102:20c::11)
 by DBAPR04MB7351.eurprd04.prod.outlook.com (2603:10a6:10:1b2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.22; Fri, 15 Mar
 2024 09:17:55 +0000
Received: from PAXPR04MB8989.eurprd04.prod.outlook.com
 ([fe80::c508:de0c:3808:6f2]) by PAXPR04MB8989.eurprd04.prod.outlook.com
 ([fe80::c508:de0c:3808:6f2%4]) with mapi id 15.20.7386.020; Fri, 15 Mar 2024
 09:17:55 +0000
Message-ID: <4cd04119-8a93-4304-b1ce-88110788c8ef@criteo.com>
Date: Fri, 15 Mar 2024 10:17:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 iwl-net] i40e: Prevent setting MTU if greater than MFS
Content-Language: en-US
To: Tony Nguyen <anthony.l.nguyen@intel.com>, Brett Creeley
 <bcreeley@amd.com>, Erwan Velu <erwanaliasr1@gmail.com>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240313090719.33627-2-e.velu@criteo.com>
 <4e203331-62f7-44e7-acd9-f684c30662de@amd.com>
 <c0ccaef6-44eb-4851-b336-cdb06647e1d2@criteo.com>
 <d16ff01c-4a01-4871-93de-a5c26a352301@amd.com>
 <7b612db6-cec6-4873-8a38-fb4c97192aa2@criteo.com>
 <8f4724f8-e831-12f6-d4e1-4700ea47b2a0@intel.com>
From: Erwan Velu <e.velu@criteo.com>
In-Reply-To: <8f4724f8-e831-12f6-d4e1-4700ea47b2a0@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR0P264CA0120.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:19::36) To PAXPR04MB8989.eurprd04.prod.outlook.com
 (2603:10a6:102:20c::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8989:EE_|DBAPR04MB7351:EE_
X-MS-Office365-Filtering-Correlation-Id: f2e65f96-9559-4e1b-5ce7-08dc44d0cc9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LYbLFJAb+s2hfl3vSW0XHgKb9E5InHknQKgM9BPEwXIyu4QQ1/tPN0eFTVhuFbrkvNevSHFR+s9oFNXvo6DxLNTMmwMpUOQUZlrYNDyETSiDxNN7b00/O981xW+KR0EPW80USGOoer7bE0dE0KnE/Smml102RxxiZtGVedmBVk4Ep4v9nHDUpPOYvSy6iOxfkwNrNzf5pPrdSFD/J8/liTZvDLiFKYL8VqSauy6pzEsIJIXUFsO0lfWZfYzyt6PRnYHSgZ3xnbGCRrQV0YCuI4Ow8PDbNvpcQjkmXAxL+Xm+O7J+TMMqZ4n1oktDog4xB6y/rvQrUF32jEFIHoS1jH6XSqb36BQpB34ynD2HXQM8h0MNcE6va1Ln6G/yDtpg/J6BN3yJq/8/lVKTr18q6BMI14sLYh25/68w41N4sPWTAYhTGHC9w/LarsqwSc74eG0ndTyiVaSDzkLORQac2kJKI5Tm6bNhkA9N0jAKV2+YZkFAAHlncyYKJ79Ht+oC1001HkZpHMeesWybMiIawidxrxnZerFBqdjs85JRlHmHoJcyvAw8+fsvivX0qv4yYS66BCmvORDh+azT7TyudJsLfvKfHgRE3GKyqHTBUOewIC3LPY9/bpExulca78VkAL5X8Fi5fNNhrkXijkWa1cbP+Z/QWKtWyMDuOq2H73Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8989.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dGM2WW82Y1hDeWVNdS9OSldCWHlUc2lUWDFQcndESTJ1Tnl5WE9jSlJiWGpr?=
 =?utf-8?B?NnhMc1g5eGxuak1xUmhwckVnWHZ4KzdrK2NRalBDWmtmcmxFZzZ1TXdHL2Fm?=
 =?utf-8?B?Um5ud3VIbDREZ3dwSkdyRVFzQ0p3UktpWFFHREFBMllUY2VwY3RabkxFajhR?=
 =?utf-8?B?QXR4OThkcCt4TzFzbXE5ZUl6WUtVeWZOcjBlQkNRRkxLWU9LMXNTZHBOZXF4?=
 =?utf-8?B?clhOQzNkemNkN1R2VE1aM0VLc3RzK0JXaVBPWm1OSHdubmJIcjNmdEFYNERM?=
 =?utf-8?B?cTNrNFdud25MRDZaYy91TU13MUp0U3pvejBsalJ4ZWtqdElydlhxQjBlRTRh?=
 =?utf-8?B?QWYyTEU5SW1xeS9SRVJXSEhSNFlEOGRETFQ3N0ZZWE1TaFlBaC90QWErNm1I?=
 =?utf-8?B?ampQbjd1VnV0NzJZY2UybmRLUHZuQ01hZElLbnJBSkhtSm9KT21acE9vUXlz?=
 =?utf-8?B?WFJjWUZPbHQvUUMwbzZLQzNsWlFDd0huTXArRGdMUTB6OUdTWkFmdWd3US93?=
 =?utf-8?B?TjdsSVlldWlkYW9rOWpoSzJlbzc0UkVqck1BZ1prTU5CZ3ZpS0VkMnJ2NUls?=
 =?utf-8?B?M1M0OEs3ckpmNzF0b0p3UDliVlp5TmFPcU9Ed0dKc0dLdjdLaURZMFJzSW5Y?=
 =?utf-8?B?L3k3VXplWHlmVlFyOXVvQndoWTN5QmZtbHdHaHBiVU1DakkrMmk0RXlVVTVn?=
 =?utf-8?B?N3B6SENMZ29sd01MT1dBTzlLcHRURmFkdEs0V2JuZVE3ck1vNkwyRjRxRjRZ?=
 =?utf-8?B?SjdmOUJPWGxYYWU2bmhmbTJhWmRzRTA4ajNnQmFTZWJMREQxdDBWZUZyL2VM?=
 =?utf-8?B?VEIrblpTNDZ3L01Kck1naDlXTzBpMVhpZlZ1WlF5N3R1ek85Ynd3cjdSTXR1?=
 =?utf-8?B?Q213VHJ2TFN1UXozMms4aExMbElTR1pnU1hlWDRuOWhNMnFuQVBCMG52dXA2?=
 =?utf-8?B?N09sSWl2ZlF4Q0NDcEdrampOZ3ZoNnF1NEVkYTh6Z1N4N0QxVEo3UytkNGNV?=
 =?utf-8?B?bTdpTm5sRnM2OFQxU3FTb3MvcURoMEMydTlEZE9Mbi9yMVorQ1BZMFFOTE81?=
 =?utf-8?B?alBpYUtsendBWWZWc3p3WTVYYlBIWWNWUGZjZFNJU0UvazN2enB2OXdHUnUw?=
 =?utf-8?B?Um5aZ1RVRGdGQ2Vkb05KYVhRVk9NVWJXMjVHUkV1UzZuWGdxbFpVYmljNmY5?=
 =?utf-8?B?OGs1UTdqMXlDNlFrekxPNTlYUGo3b0R4MjlITEw5QzZZV25DcXBZdVBsMUVk?=
 =?utf-8?B?OUp0NmpXR0x1NE9helRIWjNuakpNM3lhUHFRbmVIR0I0cmJJckVCVWFEVVJS?=
 =?utf-8?B?UUU2VGpORU54c3pnWjNpQWl5QUtlMEpJWEVIOXRHbzRTSStCbGUwWUZkZktu?=
 =?utf-8?B?QUNpSENLM0lYdGczRVY3NWhGdStGME0zc2tFR2NkaGJZa0RQTUhzMXBqNFp6?=
 =?utf-8?B?c2czN2NpYzI0b3lYYndjVHltU1cwU0F4Z2V3WnlXMzh3VGdvNStDZ2lSOUgy?=
 =?utf-8?B?SGliNVE1U3RJOTVHMm5yZmJxamRhTFF2ZlZCdzE3NWRranBXeEZnRktqK0NN?=
 =?utf-8?B?SVZ2clE0N2dHNHFQd0hDTm5xUUR2NURjeXhuRy93Rzh0K3dBblZCS09NN05F?=
 =?utf-8?B?bjh4dXdEeFVqRGtSSXA3bGR4Z3liWkxSQzNlNFg3Y1BWN2MxT2FIRWMrQmxH?=
 =?utf-8?B?OWo2d3E1bmtXcmswSUpSWnRNbCtEOXNIbU1nbmxvZzRibFZZaGIyK2FrNVl4?=
 =?utf-8?B?cGRKYXZVRitSdmVVZ1FaQ2NhVmRDRlhLRG5LUnB0NGlVeGFKaDF0MVZJaFRm?=
 =?utf-8?B?ZkY4TFdTS1Vsc2pUeDhoZGhOdUh3cHlSaXpzOWJEeXBldmdERmhmZXM5eEVw?=
 =?utf-8?B?QzJ6MlFqdlhxY1RINEdNRlJDQVBnMXVOV2VlbnhoNmhUM3Rpckh6OTJxWWIv?=
 =?utf-8?B?NUVsaTQwaDk4enBnWFo2Y2tQUGxwdzNvKzlLUEJocmh5OERXTU50d3diOHVx?=
 =?utf-8?B?ajIyeWlSbmdHYUNTOWJwVnZ2MU14QU9rYTJ0dlRGSnVrbzM4TFU2NGl3OUs1?=
 =?utf-8?B?VExFQzBmbi9MVGVUSitBYXMzT0ZNRkNLOUgxNnlsWjVDZ2d0ZHVHL1ExK3Nh?=
 =?utf-8?B?K0NqY0pVTzJML0ZLN2FHNXV6aURFQ0dFUlBsTkhudURKYkdMbGdGektKNzZN?=
 =?utf-8?Q?oJPJonkULuT3iaexW6dp8C5X7vK0b61/e+etp1MlEk3Z?=
X-OriginatorOrg: criteo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2e65f96-9559-4e1b-5ce7-08dc44d0cc9e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8989.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 09:17:55.7725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2a35d8fd-574d-48e3-927c-8c398e225a01
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DV19MAaeRuOSlBz0UFoPG+bQC+A5YkugwH0lmzHS3z4jmjA+ZVdXITjxGvLAeOv4RkBRjgUZfnxJCXe9X/5EdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7351


Le 14/03/2024 à 21:31, Tony Nguyen a écrit :
> [..]
> Setting the mfs size to max values during init and reset would better; 
> this is what the ice driver does. However, this would take 
> implementing new AdminQ calls. IMO this patch is ok to prevent the 
> issue being reported and allow for ease of backport.
>
That was my first intention, ensure that no one else get stuck in the 
same situation.

It would be nice to backport it to all stable releases once merged.

Erwan,


