Return-Path: <linux-kernel+bounces-90508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF30870064
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB8561F2421E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B88D38F9D;
	Mon,  4 Mar 2024 11:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="yes33q77"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2121.outbound.protection.outlook.com [40.107.20.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02F21B965;
	Mon,  4 Mar 2024 11:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709551617; cv=fail; b=WysLUCKRjtZilmMCqUP93teRdrlGnghUxwATzN/LqBNO/fZUPiK1N70wt3R9gMY2+xGfV6fszgeoEqdaRfYDUDA95YmGOdnPbWu7mUrzX3TEzT7rTpgXB2G1xGtfEnsn+X49Zup9U8Us9yehD9qGwM5FK955AVUSCXiEUsxk/r0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709551617; c=relaxed/simple;
	bh=j5YQxIDLEfFf7xqfnGU8B4I/W5vBPzhG7i3bgae1ZY0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TVJ6L7+93aX6yTuyc4cebIMQUM/PaPpojSYG/qiQqOjakGyel/GzIMCr9v/nzTa8UDcDwRG73KgoFuO585qBHzxA+X51NzhH14nysrWs0Ol0I7fdQOhqEnMcjpBdQqLMjSFGucfA9TikYFyE8sXrsNGPwFvZlKr1h2g2GTQ0NUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=yes33q77; arc=fail smtp.client-ip=40.107.20.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ifG3D/+2OgNdV8YAN+QnpXeOZ2CVePvb+iLlGQayTaD0DrJx1J2veza7Tat31tcra4HYIQ5fYGKY1f8qNKc59S+XPoUoKxRD4FcB58gI/mOikBppNzeq1Lx9Avybblg3j7izKjQvoYu1CWtCiTjAoQw6XHIM0hC1obawmFV5PFyyS2ZRihfbAkG5r1DJUcxtWnNbScIkMqnCq22+ThhU7aZiVd6ysnZjllWGtgjCSwNug3lxLtAmOJqDBHnT/iJGyJYnPMMRUDEmZiASullVUy1B4SsnTbovlrf3ksPGqv8FpIgftQrJN9FUZFhYunMuD3jcDvRVjLh/UaYJkY8l2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BNTfJxFgEO9CtF1hHmBaENIoGSBRFpJAm2prjvzBgH4=;
 b=XbY+k/m8cHubAgPcTx38qwL8gbEVp95PbnycEMSgJlHWC6j3AO5WLmVMqoqqkCXhj7MTecxQO4bwz+vsbKLJ6fAxPcG/WWR0T05GP4s40y4tUWrbFvNUyyduU117JUIzZ/QixJs0rpnMbwHJ+X9O2W9Ri70HakyDUswIYI8cp70HGIeVBCgfjou/akPPQmvJddlQcQ9jWB0OjLGXuJD1PwKrFFx4C0VaXwwFrLkq4aNE+Saq2bkm7FwI4mzkcEv5ckyAdx6WUjQYyUIzTQl8Hz1iApNilxgrfkgFHfg4WwsTIe7SprmfTGZbvdPSphgFGvvT4oYMwxmaWDEizI6q/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BNTfJxFgEO9CtF1hHmBaENIoGSBRFpJAm2prjvzBgH4=;
 b=yes33q77cAsUJB1JHrGnGe9BXMFdP25jjQJ/yxj617R+1bfZ/zC2xkV6wf9MOx9PfGTsL2ipAxdykbL/4ECDvkP3li63md/w9u5q5fM/YcuhZ+uKU0aKIoR1GOPA28MMqg8EAXw4zzj37a5i248MP2c1i2m6V/M5iGrmzbid1SU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by AS8PR08MB10315.eurprd08.prod.outlook.com (2603:10a6:20b:5bd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Mon, 4 Mar
 2024 11:26:51 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::9e35:6de9:e4fc:843f]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::9e35:6de9:e4fc:843f%7]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 11:26:51 +0000
Message-ID: <6ef6c5bf-e6e5-4711-81c6-6ae41de2e61e@wolfvision.net>
Date: Mon, 4 Mar 2024 12:26:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Missing bcm5974 touchpad on Macbooks
Content-Language: en-US
To: Takashi Iwai <tiwai@suse.de>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, regressions@lists.linux.dev
References: <87sf161jjc.wl-tiwai@suse.de>
From: Javier Carrasco <javier.carrasco@wolfvision.net>
In-Reply-To: <87sf161jjc.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: FR5P281CA0007.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::17) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|AS8PR08MB10315:EE_
X-MS-Office365-Filtering-Correlation-Id: 60590d7e-0bf8-4af2-cdf1-08dc3c3dfcdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	k/cjpEPPrYsrrZssfS9nZTNpQ/pZlZGd4nC5/E/5nr/S6fMJh+SDPmnvBrcPqPrz1xDx4jf48c8fL9gTQMNAj9IO5ZNlUupct5WMDq/EGbKWMq31cVaE60pQ7pRJLMZVetAcFfXaqyGo8FKiG0I4XlxS/8mPlpTxz7sQZwcl0rAztfsWwRGqZPJfXhsoD8r7qyKzDsCJTPLJHlqX/zYKqq2MU8ed2ROAfsAZbzsgfmvdcPxachpj6IdpZGKaNWCPAJEReEImR9gRy0GbgmMBPP4a/d3acySLbrhUWLEmM8Mb3N8+ccaJ3UvC79tz6B++N/jd5e8Z4Nor2+kV+8OI4lf9paBPDggysCdskgoFwOoeTcdlHU2OMVuQfb5UwmFcbPmOuhb0cC1iPc0PAV8AqJGZEp6eEtlRinF8qU9qzBkMHDysAeOK9hTmwaUt8qOAVTsledffvBjH+lCFR+ekHxoflmAH4EZWNZS7eXNGEw+cVnVhIhVzuI9UOLFpRYhF5eJn/4+bCYM/PW7RbofCXYyx1TwSwZij/YxMO6MLvpOhIRRaZioNBOTE8IE4s826lxfcT+aSEWcN6zY1z8e48UOjRrf4Jl1Rl+eJ/8b6oGw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QjA4NkFmY282SklETFRvSFpqMm1MYlQwdzY1N2lsRkJsQkkrUWVDUDU5ck1m?=
 =?utf-8?B?ZUR6QXVoYUQ1WFZuRzk5NFI4M1J2eUhOQVNuSnIxS2I1MUo0bzJVYWJzR2xU?=
 =?utf-8?B?NlkrT3k5V0VkMUtFMCtza1ZCWGNYdzVkZng1RDlUeklOR0EreGZQaDN5SDNP?=
 =?utf-8?B?SytkZjJmQUlpZm1qOGM1cE15eUFNMERqYnJrTTZyV2k5S0Jnb2FYQmFQdzc0?=
 =?utf-8?B?ZjN2bzdXY2tleitkZTZJNFBQdVQyNzY4dVAxcXVERURIcUZsRm4zUVRmWVNr?=
 =?utf-8?B?UkRSbG5QWTVmb0xVUmRyVUl4NzZDbVVpZmh3YzdyeEcxZUhVcXFSMFJqeHRE?=
 =?utf-8?B?d0JTNFkvRmJrNVd6ZGZwS00vL2J5Vkh5NmZKUG1xWEVqay92dk1TbmcvTnN5?=
 =?utf-8?B?NnpnMUZuRkd1d0o3emVzMEZ1M3hwL242T29WRmRseVdyL3lXSG1ObmZCYWNX?=
 =?utf-8?B?RGFGNVYzdXlJS0RrOVdjSjZrOUVWS1hwb0dqZmRiUkNQNUNnTk9MbmNxNmtB?=
 =?utf-8?B?dTkxSmJ1QWI2Qy9rbHJPcmZqSEcxZ2hFemtDZFVWaTFSU09ZV1ZsYWFLSThD?=
 =?utf-8?B?YmNQK1NBdy9zc0xtY0VHOUZOUWVWS0hOdVM5Y0VkdUxpOWc1QmNibHNNS2Jw?=
 =?utf-8?B?WE9yTW1RQ3ZBTVEzWlkzUTcwcitTS0VNL055bVArby92OUJDNUpTdE9GQmQ5?=
 =?utf-8?B?WWd0MmJWYTNXeVBzNCtLcGNZb1NtdnVDNHlMSTBOUVN5dEgxT2hNYUNnWlN1?=
 =?utf-8?B?NThJUlRweWVCRjJhTEVHWGU2NWN6d3pPQVZZdEFDWkZsOHBXN3RVY0NuNFJS?=
 =?utf-8?B?ZDZkaytEL2NRQUVVemJDQjY5YUxCTDJGTHBZYzlFbUpKL3BQSDdYZUlkOEFr?=
 =?utf-8?B?dFpxMFc5d29JbnpzNm1veEU1VXMxQ3piczdoQXpzK2xMT1BSOCtEVlNDa2Fx?=
 =?utf-8?B?bG91Y1dyWFhyLzhRMUhsakMvb1R6a01qWTkvRE02NHJDaUV2S3piRDFxc2Ux?=
 =?utf-8?B?U0dqK2prek9tTENVTVhTMnlqVzRhQk5rUHBINGV4NUpxSzF0b2ExbUhzN2ZT?=
 =?utf-8?B?ZDZOTjBFNVYyd2xiYTFWbGZmQ1RYdlJDRXJ6RFFQSjVaN1BkWlZYRUVXSU85?=
 =?utf-8?B?WHV4RDcreTNibS9vQncvMkNXWUlkc09xL05kbkJMbXZHOHV0a01uYVZqODNU?=
 =?utf-8?B?ZkcyUTZycHY5aXdhNy9malkrS1BiRGwwQkxCS3Y0OUVKaVhuTUk3NTcwLzJu?=
 =?utf-8?B?MDRKOVF1MERTZFFScmhRMkVTMlg0VkZjM2hzU05kd2RiMmpKMWpFMnVqaWtP?=
 =?utf-8?B?OTdrWlVUc2ZYNmw2V0dGRFB6T3AvRVVtRW5mTkh1MDU5QWNIa3RIRHVPVzhq?=
 =?utf-8?B?UWJQazc1ZUN5UGhaWFltQmZvQzYya2piR2lYRUFhRElocFI2Z1B3RlR3QWxr?=
 =?utf-8?B?eUtQMzVXalIybCtNZmdqY2JuRDAzSC9zWmtuazlQb0VhMHptTlpTR2owNnND?=
 =?utf-8?B?MUM4T1YzRW4zT3Q5dEM4SW1XeTY5eVJSVXJ6VmptMjJtaUM5dUhpUVlIS0U3?=
 =?utf-8?B?eEo4cWxlNDZLM2pndG9KdXRucjZCSU52ZDhCbE5BS01jbTQxQkFvSWNSWUZ3?=
 =?utf-8?B?N0hVa1RERll5SmlFTGRsRG9ycnNycWxrZVNMNkZTQkd0MTgrUVZqelBKK1A0?=
 =?utf-8?B?YitGYVhWd3hzZGVra0V5MmwrLzhsUGZWU0d4SXdnQ0JEYnBVdTdLODhyYXBn?=
 =?utf-8?B?bTJ5SzR5ekhTTGZGQWw5SFNTL0daRWJGWWUra0VrNEhJaFhUVDMzNFE2RGo4?=
 =?utf-8?B?N0hSN21MNHVUMENjYkdiRXNoU3lMa3gvSnErS2E2S3J1M1NoOXRZTUdaUkNK?=
 =?utf-8?B?ekY1dnA0SGR1d3JtanJMNDg3T3kvaSsxc0dVb0ZvaWE0b0I3VHM2ak4vcmVW?=
 =?utf-8?B?d05qQUh0UmZ0ZGJNT05zZFlyRG9Cb3BuTkJ1cWJqM3RuNEY5cG0vNGRxSFEx?=
 =?utf-8?B?MTRQSWZ2VXVDUmIrR2E4WUFTaE91eU10WTZ1R0tIV01hNzdlNVJ2UFpQenV2?=
 =?utf-8?B?blBGRG9abS94eVBhQ2NxdkNOQi93WHh1a0VNRGtzSE5tSi9ncis1aGsyalZK?=
 =?utf-8?B?Y2U1UFVsUnhkcEhLeE9ncXdlN3R4b0V3REtITnBZRnZ4eDFKY09BT3BscGF3?=
 =?utf-8?B?Z1docGdSakxjeU15SFlIZ1RETXdXeUJkaHJYdjJ4LzVHTVAwL0xpeDRxWE9q?=
 =?utf-8?Q?8Yzz8dSUMCpOhx2hiLSAtmmgKLpmSs+8ctRDH1XP6o=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 60590d7e-0bf8-4af2-cdf1-08dc3c3dfcdd
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 11:26:51.4248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j5blr7XNyZiYVW1qbfEFuBf5q9c7cFW+10uxvQmaieZ1sM0DdbTXG11k9rLAWV2gFBNXwo2Dp+xpA1oxCWB0N1j/WI5iODusCm3ecQFRcgk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10315

On 04.03.24 09:35, Takashi Iwai wrote:
> Hi,
> 
> we've received a few regression reports for openSUSE Leap about the
> missing touchpad on Macbooks.  After debugging, this turned out to be
> the backport of the commit 2b9c3eb32a699acdd4784d6b93743271b4970899
>     Input: bcm5974 - check endpoint type before starting traffic
> 
> And, the same regression was confirmed on the upstream 6.8-rc6
> kernel.
> 
> Reverting the commit above fixes the problem, the touchpad reappears.
> 
> The detailed hardware info is found at:
>   https://bugzilla.suse.com/show_bug.cgi?id=1220030
> 
> Feel free to join the bugzilla above, or let me know if you need
> something for debugging, then I'll delegate on the bugzilla.
> 
> 
> thanks,
> 
> Takashi
> 

Hi Takashi,

The commit adds a check to ensure that the endpoint type is interrupt.

According to that report, the issue arose with a MacBook Pro 5.1 (no
button, only trackpad endpoint), so the check on the tp_ep address
(0x81) returns false. I assume that you see an error message
("Unexpected non-int endpoint) and  the probe function fails returning
-ENODEV.

Do you see any warning in the logs when you revert the commit? It was
added to prevent using wrong endpoint types, which will display the
following warning: "BOGUS urb xfer, pipe "some_number" != type
"another_number""

I am just wondering if for some reason the check on interrupt type is
wrong here.


Best regards,
Javier Carrasco


