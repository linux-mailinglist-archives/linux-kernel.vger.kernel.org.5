Return-Path: <linux-kernel+bounces-158726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C64D8B243A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA3421C20EB3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F9914A08B;
	Thu, 25 Apr 2024 14:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ettlneXh"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D30414A087
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 14:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714056057; cv=fail; b=Ci3EOFO7cm+3KO6fRHvUvpztCW856WC/HmiBR0llBS/P3ERwdoiEjsY5UwQR0wx0/IzYj24vvatNSDzGd4Y4JrfHJf0aMhmlEFcc9zMMZ/pfLSGJHLy88i3xkstPAIDnwLqJWtzDZpzFHQz+4+UhlQtL9P2yIsF2qxNz32aec1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714056057; c=relaxed/simple;
	bh=mRcLYHTbGzejYa5dnG/FXqJ6zHpBfoxXt4TxPg5LBas=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FqydLQsQXWcyxd/0KRmqEG6gGlS2x3U72gqXEdmtCsnme5PnZI4alv88dIfOWzbiLCKKnJarpt33juivfBXcNXT4ZMKpznYIeTw6/ujHOlqCFr+xTatCQjNXiVnm/fTF7DpjvrkFTRa5gRTNX12LmD8leaLV1Gf4THBxbzcHSlQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ettlneXh; arc=fail smtp.client-ip=40.107.244.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qw26yzkkfFBOIKKuLXE2q56hN1r3F+6LfXDbB444zRv4W1pRJRWihK4t19FwR8jMXKBg+hZKEKXixG8Ul138gBoDK9WAdBKF/eRBUpaifesqCtpvJZFgBzMpuG3Gym9vY0tmevCVyEqkDHjVnf+BsKQW+7cQQTjz7w1Jh9o0o9PTr1L1v8gLZMnVYdD4VeIXdgpz05Bn1N0Dy5eg0mteKb8dAzv5Ta4e/g1Ef2ilk/ApEZaKS5sH3oT6ScNQYWds+1nVD4yUf4kI9XC+z5G06ESf8+fzfj97eq1ZLF0fTIflFaQerk55AOGB9PIF1Q1ki7X9uKVFwLxGOsvoJCcM8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jqturu/6k2jmrw794rpK18ZISgtxZ1YXo6gul51/X4c=;
 b=f/UfHIt8k491XTx2JvvYrTOX+wOPFEqQFtKweVb8BrO/hG682xwKRTKjSvv0QcGybEhbKeSi+cXbMP8e1Jd7RNsoom0m/XvPdDwMYEoED3YX2fgXWAgn9QwNBnbjrAR2znCod6dHTnRqd/0w5aAmrQbzmB8p2jjp3MmvQjMlj5KkprBvW/oMDPbOiuCiCIyRHI5+BpvZcnrOFHhlCqSxC+FQGAMIydaYmGeiOyp81w/tcsPB7WEc1IixbW1I5e2BNEEk3MQqzNoF781q7tIXb7lMbxlnCqFEIx74AvgWucR20qfUqz5QKo82W/H9JXKiTWA8Nkkl/h1jh0QlIPd4uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jqturu/6k2jmrw794rpK18ZISgtxZ1YXo6gul51/X4c=;
 b=ettlneXh4kvPxvIoEHcfKO/sN5mysGSZ9TnVaxO63RdjD1jVh3GCBJGfQ1e+2PJDAr/GAkSwsH+ZDxFtnvs/m6R0MPPWr8Yy2EiQmK6ps4TEBNLvk5S+CEGXDEpai4X4M4EHPE5EZD4aUatRQuRlagnAu07Wfkn+t1EW62hR4zU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA3PR12MB8021.namprd12.prod.outlook.com (2603:10b6:806:305::16)
 by LV3PR12MB9186.namprd12.prod.outlook.com (2603:10b6:408:197::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Thu, 25 Apr
 2024 14:40:53 +0000
Received: from SA3PR12MB8021.namprd12.prod.outlook.com
 ([fe80::2a50:1b4e:1b53:281d]) by SA3PR12MB8021.namprd12.prod.outlook.com
 ([fe80::2a50:1b4e:1b53:281d%3]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 14:40:52 +0000
Message-ID: <1ce0b581-4613-4899-ada1-5d322f006890@amd.com>
Date: Thu, 25 Apr 2024 07:40:46 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: [PATCH v3 0/3] mailbox: zynqmp: Enable Bufferless IPIs for
 Versal based SOCs
To: Tanmay Shah <tanmay.shah@amd.com>, Michal Simek <michal.simek@amd.com>,
 shubhrajyoti.datta@amd.com, jassisinghbrar@gmail.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 gregkh@linuxfoundation.org, ben.levinsky@amd.com
References: <20240410170825.1132324-1-ben.levinsky@amd.com>
 <24bd320a-ba89-4ad0-a905-6915e00b705d@amd.com>
Content-Language: en-US
From: Ben Levinsky <ben.levinsky@amd.com>
In-Reply-To: <24bd320a-ba89-4ad0-a905-6915e00b705d@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0052.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::27) To SA3PR12MB8021.namprd12.prod.outlook.com
 (2603:10b6:806:305::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB8021:EE_|LV3PR12MB9186:EE_
X-MS-Office365-Filtering-Correlation-Id: 7307370d-4e23-4fa1-02f4-08dc6535b507
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eVJxZDU1U0dnaFo5allRbnJWdjdkUFVEZjBIUFM2ZXRibTFNdjhtOGlidGZT?=
 =?utf-8?B?UU5tMHJuNFo5L0RSYmdKbFllQ2c0aE9Od21CQ3VMYkVsdGpHdFo5VDBGM1N2?=
 =?utf-8?B?Q1d6U3NlUlV2aWJnWC9XZ1RNTVg2MHIrS3BrOWttUjZsM000NmgvM3hZd25I?=
 =?utf-8?B?cDVxMkY1cDJqeEhPMVdpeElrWXVLN0VTc29zNldjK3pjOGpMdmVseFMzTVZu?=
 =?utf-8?B?RklZVE1xMjJ1T0dTR08wWkJUY1RLcjVnaDl5WTdhWmhxVk01VHhXZ1RJZTIy?=
 =?utf-8?B?TzAxZERXa2dIckR4bnhzdExiUnpNaXZXZmFJOTNoclVNZExHMG4wbTJzTnQ3?=
 =?utf-8?B?WDVBVGY2bGtRT2pESjJNTkM3YUtuL1QxYjBidFdzekdRR01zYlpEMUNUOUFM?=
 =?utf-8?B?OFJMeU9tQllMemlGYytjc29aU1VDa1RDMkUvYktjVmJxNUE2UFlpbmY5SWFj?=
 =?utf-8?B?N0lqQ0NTVjZIYXJ3YUxJczVvbVhlQy9FaEs5c3JiQ2o2V293TUNRZ0hzalUv?=
 =?utf-8?B?TkVNNjJ6M1hQc3lwWVp6WEVkcHpoemZUWnpaQ0RreUY2T2xnd2M3VVl1bjBr?=
 =?utf-8?B?T1lkL09OcXljMGRYOWQwL0VsWVlHSmJ1SjBWaFVCUURpU2JzMFZkMXdrSm4w?=
 =?utf-8?B?MENJSU55R1dkeTJjV3RKZlRlLy8ya0xSdWNza0Fnc2NRUmtqZ3hvcWZ4YmtK?=
 =?utf-8?B?ZFk5cDIvVlVvN25ZdzhTYnovOTh5OFhNcEtrYmtsaitjOFR5S0hYcDhHbTg1?=
 =?utf-8?B?R3lnZHlTekF5c1dXVEJOYkxnRzhCaFpyNDZqNnhURVZGMEZLTHlqa3kyZUNY?=
 =?utf-8?B?akV3Qmx3RVM4d1VSYzZaZk1BeTRzNmhQMmpLSENNTGthQXVMMVVvMzM3VzR2?=
 =?utf-8?B?a3R3NzBhVTVjaEVzZGd3ekQ3ZFRtbGh3L0cyNDRLSXJacVBwME1QUE53RWxD?=
 =?utf-8?B?YmQ1NDVWNGUwT3k5REFhYzkwU1JlZGM2dW16UnhVTWhDelYxK0p3WURYVVVv?=
 =?utf-8?B?QVlOYmNPK1ZxL0REYXhHWEc0djAvTDZ5UzBreFZWazRuMUlhcjczVXByQU53?=
 =?utf-8?B?L3FUNjdLYi9YaStmc2tXOCtQeFdsQ1lYNVRRTjErVXY5dGdMaHVOR1lBQ3RE?=
 =?utf-8?B?YTRMNW5UQ2dCVnBxTXkxSDlrYjRsSktVNTFaZ05tdVFKM0pxOVJwTWVIUStF?=
 =?utf-8?B?NFh1L2RRVE1iNFdIOGJNNHBlamNIM3lmTjZOUGs4NnZ3Nm5NcHFOM1BlZlRj?=
 =?utf-8?B?RVlUVHpicG44S2k5V0pqbnpDNGxya2tjWnhFVUhzUVBTbHV6dmc0ekVjbEtI?=
 =?utf-8?B?VzFIcmhpSk5qYWhwLytTZVNkRnBXZ1RlaGJ3dlZ4eTFBZEhXSTdLZXBXRVFr?=
 =?utf-8?B?eGI0WWh6SFpBYWRLNXMwWWdoaDFUNDc2WWFZZC9yMmQ1ZUdhb29HQmVwZ2RU?=
 =?utf-8?B?amszZzROdHpmUW1KQzJWQmVIMWp3cmh5M0h5Ym5LMFhwWDFMblNDNlZKTmhK?=
 =?utf-8?B?U3ZsNldzOEJlMU5LME1IM3lZSEFFMkVubFZiMEhoSWRseVFnQTJDUGV1S0FZ?=
 =?utf-8?B?Mi9pUzlSblRxVEtSNVoyc1RjaXhTeVY5TGs5RGpWUkVoNTdocVpLOExNYnlK?=
 =?utf-8?B?TXNMTVZWU1IyVXNwVTVQOXpaeWtvY0hzczlsWnZKSWR1aU1ncktHNWppWU40?=
 =?utf-8?B?L2liS0xRTGxtREFURWM2UjNucWIxZlo2TCtRaUJZYUJnL0F1TkRyWU93PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB8021.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aVlsSVBOV1BGL0lCWkZvblEzaGxqc0I2NmdoL296NmlpcWhHdWJSOWVneFh3?=
 =?utf-8?B?UGpWeVEzNjkvWVZ4a1YxdW1taTUxK2NZc1lrZ1JxaHhjbmZ3NnpZcEtpS1Jh?=
 =?utf-8?B?dmJueDlGS0cvblZMdmRPZVBnek1OeUZ3NDJ6dTY3UTdGYXVEeXQrNkM4dUVT?=
 =?utf-8?B?SEJ6QzBTa3Nmb3ovZ2Z1Q0RsQ21OdVJvNWRQd3NsWC9rdStHSHgyYlc3OGxp?=
 =?utf-8?B?c0k1dThra0xhZzBGNXduRURUWHJmMUpJWXBvdWM5alZ0cXVKS2NJZzZwb21V?=
 =?utf-8?B?QU5qOWNIZm1TYUFTK1hZTm1JS2FYejBPcUlhS3lUWDlQNDNmUm9IZXJXcWIy?=
 =?utf-8?B?anRFYkRmRmNMYVVqbHY0VkNJdnN3UmY1anpjNHFiNUdqbUo4MHQ4dG5jSUFl?=
 =?utf-8?B?ZDU3aUdVU1FUWm1yTEEwR2NndW1zVjhET3pranB5QndjOXpKckVpNEZHbVpq?=
 =?utf-8?B?TzBtQ1VZWEZhdjFPZlJ0eWU0UXlRSVRVbHA4RjJLV1Bsa2R5TFowSmNBU241?=
 =?utf-8?B?NzNQUHl6eFkvUmlpcTU3OVJpOWFtV0UxOWVteUY1UzY4YjdWNElBMTF4bDlS?=
 =?utf-8?B?aVNSclBPcllqMkJEVE51a3kyb2VXTk9JQlRyRXNoU1VKQXVnbkJCclJ3UzhS?=
 =?utf-8?B?UVd0N1IvN1RyM0JZNnAzZFpYSGlhK1U4ZW1PcUVBOWhDcmdXUS9xcUF4NEZ0?=
 =?utf-8?B?dXh1SkdEenVYejVsRWd5NXMwZUpIY01tWW9aNjFoejNYclk4KzdnV01GRUdn?=
 =?utf-8?B?WlVwOEtkcXBjaWV2NnFaTGhUMG1YQm10ZEtDbHkwakQyS2VUTzcvQW1zYkIr?=
 =?utf-8?B?S1dpRlRuOHZjRjZlOGlCVHNpSkVUMUl1RWF4dmZPR0FIM0FnR29XaFNlN1FZ?=
 =?utf-8?B?Q0o4ZkdJczR4cUVsd094OXdUY09aZ0h0ODZuampjOHdDMnJxUVlRQUUvVkd3?=
 =?utf-8?B?d25CYWhtRWxCSjdXNm94NGtyTDRsWllPWXgwYjFFenEwVzRJSUoxQXVLWnV1?=
 =?utf-8?B?cVA2MDROZjFVdExnMXNTVEhZLzZoWEd1TEJ2SnpqVnc4QTBaYVdJNGtRYjlm?=
 =?utf-8?B?bjlTRThoZnlyd1FsUktIbW5GRzd4b3p4T1lRODJRZjBjSHZVblVpeFl4Rjdz?=
 =?utf-8?B?RGVuMXZqck9DWkhxZUdsVDhMeHFaNlUrQXA1VWZ5Rlp0b09ISFNTTkE3cHU2?=
 =?utf-8?B?ZDRiNThPdHR1U0Y4c2NZYXVFYnhjUFgwcmtWYzN6eFhSVi9yeEdDcHNOcTRF?=
 =?utf-8?B?ZkRpOE1oKy95NG5XL0lHUDdFYlR1ekNTY2hzZCsxdDdBUTkvbzNSLzd1RFI0?=
 =?utf-8?B?N1hnbVlvd3U2aG15b0Vod29LNmhMZWxXU0Q1bXBjMjU0TnBDTDhMTW5rSUh6?=
 =?utf-8?B?elJydE9JYyt3allmemxkaU9ucStSS3RUNDFLL0JjMmYrQXVrR1ZEYnl6ZC9a?=
 =?utf-8?B?TklYU0RTQVlqdHdyWHo4dE00MVZFektqZy9uYWdiMm9pdzJzVDZmUGNzMWlK?=
 =?utf-8?B?angxRUdYUmxRVFRZREFsdjk1bzFKcVRDMEg5b1RvWjFrYitGUmM2cEdDNG55?=
 =?utf-8?B?QUtLbkxQUHMyT2tMSmxLRkYvdGNzaVhaZlBRZWZXQmFMVENMWmFNdUdrQU9k?=
 =?utf-8?B?dmVtL1dBNEpOT2VqbkhUUzFvSkZxRW1WQ1hnUFE0bHMwZGUxV2xWaXRHZGhl?=
 =?utf-8?B?N1RlYzNRaFMvTDdKTHdJNmhGVDVEcWJIekJxeWtnemdlUHlUbkJBZS9EVU8y?=
 =?utf-8?B?dHRHVm1aK1BUQXNmTGRVM2RpQzZGOXdiWXYzenhJdGFlbEpHdGF0RlV6TXl6?=
 =?utf-8?B?VHpkNG80aTZYb3o1ZWE4Q1dMV1lGSjNabVVBNmRWTFJnUXA1Y01BcURhL0tl?=
 =?utf-8?B?Z2QrWk4wVlk3cFZUd05iUXZQOXVxeFZaUVpHdFA5MXpJc1I1eUtPNGZyK2Rm?=
 =?utf-8?B?b1lLMWsvWWN3MUVwRktESW1GK0FHcTlOOWlwckNzRElvQWs3NVd2Z3hmbEUy?=
 =?utf-8?B?Qjh4clo3TjlrWTRHdDRwaE5UUGFkYklqd1VsK29aaVBmUEROUXdWdnkyWEVK?=
 =?utf-8?B?Nks2WVcza0lQYWZKeFBoM0tzRzFWRHFaWndFUlVDS0EySWxJZFhHZFZhOGZn?=
 =?utf-8?Q?WStuhoOtkpJqwdl/a7hXL0gjM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7307370d-4e23-4fa1-02f4-08dc6535b507
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB8021.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 14:40:52.5599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rbJxk7icmoIkXlC82tSpxUZB6PrIDQ1i3LRcjRcX+RYZh+jkCJMFGi0xxhWxdOiAlr8yEfuKALlU2MqAHA+9EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9186

Ping For Review
> -------- Forwarded Message --------
> Subject: [PATCH v3 0/3] mailbox: zynqmp: Enable Bufferless IPIs for Versal based SOCs
> Date: Wed, 10 Apr 2024 10:08:22 -0700
> From: Ben Levinsky <ben.levinsky@amd.com>
> To: jassisinghbrar@gmail.com, michal.simek@amd.com, shubhrajyoti.datta@amd.com, tanmay.shah@amd.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
>
> For Xilinx-AMD Versal and Versal NET SOC's there exist also
> inter-processor-interrupts (IPIs) without IPI Message Buffers. For these
> enable use of IPI Mailbox driver for send/receive as well.
>
> This is enabled with new compatible string: "xlnx,versal-ipi-mailbox"
>
> Original, buffered usage for ZynqMP based SOC is still supported.
>
> Note that Versal bindings are already present in xlnx,zynqmp-ipi-mailbox.yaml
>
> v2:
> - formatting in 2/3 patch
> - remove extra handling in 3/3 versal_ipi_setup()
> v3:
> 1/3 - removed additional newline to avoid
> ./scripts/checkpatch.pl --strict -f drivers/mailbox/zynqmp-ipi-mailbox.c
> CHECK: Please don't use multiple blank lines
> #434: FILE: drivers/mailbox/zynqmp-ipi-mailbox.c:434:
> +
> +
> 2/3 - remove unused variable dev
> drivers/mailbox/zynqmp-ipi-mailbox.c:565:24: warning: variable 'dev' set but not 
> used [-Wunused-but-set-variable]
>          struct device *mdev, *dev;
> 3/3 - remove unused variable dev
>                                ^
> drivers/mailbox/zynqmp-ipi-mailbox.c:666:24: warning: variable 'dev' set but not 
> used [-Wunused-but-set-variable]
>          struct device *mdev, *dev;
>                                ^
>
> Ben Levinsky (3):
>   mailbox: zynqmp: Move of_match structure closer to usage
>   mailbox: zynqmp: Move buffered IPI setup to of_match selected routine
>   mailbox: zynqmp: Enable Bufferless IPI usage on Versal-based SOC's
>
>  drivers/mailbox/zynqmp-ipi-mailbox.c | 257 ++++++++++++++++++++++-----
>  1 file changed, 212 insertions(+), 45 deletions(-)
>

