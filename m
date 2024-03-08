Return-Path: <linux-kernel+bounces-96823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5FA8761E0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A7761C21B3B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8940654776;
	Fri,  8 Mar 2024 10:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="OvPI/VYG"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2085.outbound.protection.outlook.com [40.107.249.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462085380F;
	Fri,  8 Mar 2024 10:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709893266; cv=fail; b=s/AmhSvnTPGNsbCO5lBu8PjPgPBA8twQ5SUqumXQDk/UEuTGDCYuOH/HCgidbPjPXCIZwlG9nyVvfrSixEsbFTTU+IYGRb2iSM1atWuo13dixSqIEsvhIQ9Uq+iWKszqZudE7JgQYIw6sin8mNIlhhWvhLGCHtl/Z445/0aLA2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709893266; c=relaxed/simple;
	bh=SmLp/zJwj4/bZCIFeQbbmnX2VI3Kwlh8WvwR3EC32vo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Wr78YYb7uzTig0RMP0Wl235GH12GI+4tdxBQWJNbfH4txMpb8vsK/dU/A8Bgs4naIGxHC7CNpuBgJQGf1yRBt1800yb0c3RykbtaQuN023rl+hKITE5EJJoMaW98EgQnmTfgh6bv+VF5phQ809Hi0HXAU5kfwbrDLRzb8wS1yfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=OvPI/VYG; arc=fail smtp.client-ip=40.107.249.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gQcrnemzTornTPjbDzUNWRM11nRU5aRd5TPp4NjIRMqf9ezF1k7vGHxTxJgdfR5JNIidhN5fa3x0mN+g1ew/D1L3aiHXBG+3Ufr2JhIW9/jSvg5dwcdOFPToSKdImD6q2WjPT7JcIPJxPNK7VW06FmzfoU9CGW1OLoR4Be1icW3GkVMSveTADdey/GKK5g9RehBaYyJz1uvXLgs5FANCZGDdNvNLqq3pbVsESerK90EWhVAqR/Azyfj/jgtkLyIIUDa5LpupzAUSiNCCgrd3TUqEraPUeotCtjNnPr3hL9erU57kd2/n1TM/Zp6mH4NfQkCINODO4blmjHOXT/RE0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SmLp/zJwj4/bZCIFeQbbmnX2VI3Kwlh8WvwR3EC32vo=;
 b=nssZCMgqFqGbkFRggYRdT02FWKGLyrSBFREQi3M524VMrxAkRHoTqGPDDyhUOs8P8UUeEOjJjs11rKvxrEjHKLThmv6xAKjW4iORjGtYSrVD1o+S+8/D2Y8mvzsfL/o/MauweLzlRtZVJvWJml+OCayOXppCg0rU9j6Nvy9eV2nP75T6YMUeYaSn5EyD9P5cfjG8erJo0i/ZhM3B8CqwoLXSm4jNduruFtBt+aky1S61z2TAwraYhZIS6pCGFMFLyIflx9NG+4KLFap26XO5/N3psFGJVTjzCnC6aths6KeV5p822oO6Urc4GzMLOc3RAa2UJsqMGfj1U7tOndx9Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SmLp/zJwj4/bZCIFeQbbmnX2VI3Kwlh8WvwR3EC32vo=;
 b=OvPI/VYGj72OMJ3HJH129hlT4XSa54SM+4CGAXTkq40T/7IXInB2hJD8oK5WcmPRj4WOTFw07cxIBSqDJIMOD3/+y7zpfTCgUj5W9XKOJjb88k5xWiM6F5FaV5wYiy7keUGK4aNxUalmmJo/JWo1TvGmdtvZ6j/7xLvAD2+xbUveWBHW0IMHO/JvKsj/WNIKgrF9501cpPkWk7K0qCflXN8Mn4u3BzTTebiCBNLk8SqU04svsCgEPwxPOrQ4J95ULNlICf+M+A9C3isMsyEwAFRbD29vse5zujsImI0FPQwlZN5reke/B6cyNDHZjUDhvu7dG8X9uc3rcqoqmX7u4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com (2603:10a6:102:383::17)
 by AM8PR07MB8311.eurprd07.prod.outlook.com (2603:10a6:20b:32a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.28; Fri, 8 Mar
 2024 10:21:01 +0000
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::995b:5be7:51dd:e540]) by PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::995b:5be7:51dd:e540%4]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 10:21:01 +0000
Message-ID: <c567c622-1ee1-4828-8730-62bf6bfc2ecc@nokia.com>
Date: Fri, 8 Mar 2024 11:20:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: smp: Avoid false positive CPU hotplug Lockdep-RCU
 splat
Content-Language: en-US
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 linux-arm-kernel@lists.infradead.org, rcu@vger.kernel.org,
 linux-kernel@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>
References: <20240307160951.3607374-1-stefan.wiehler@nokia.com>
 <ZeoMRfy9ISBOVMsV@boqun-archlinux>
From: Stefan Wiehler <stefan.wiehler@nokia.com>
Organization: Nokia
In-Reply-To: <ZeoMRfy9ISBOVMsV@boqun-archlinux>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0103.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::19) To PAWPR07MB9688.eurprd07.prod.outlook.com
 (2603:10a6:102:383::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR07MB9688:EE_|AM8PR07MB8311:EE_
X-MS-Office365-Filtering-Correlation-Id: a07696b3-0506-416e-fa55-08dc3f597425
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4HrW795lXSZXzhkupV0SMFzpzVZZDbtcJHCK3X1vlXpA40rOa5YFz+rdJbeJMDbRYKK+wZDASP23LsEkv+vE85WpvFleWCDAtoj0fxqZz1Kf8M0BEmLWdYKE+bWxZ3MdSlvw4V9ZEkfQ1KOCZKoKvq8O3BZX1bS99EPLdh1whUWTrMudkalaI7wdT31TncaAtT0/XgpRVeXmn0WrgxylAuDu8pgzcOIrVWoeGw13H0okBGgWyrD426SwiLy2XJ3f8DpcCp7zaKy9qNgmlQ5p05J59XVPtxg8Wcct2tSLRQFgx8R5iiVEp8LBObC8QkB+aMYJ7HX4mHpgq0EVFgGkuXuFjqhGG8NfZxjVz8UEx7bTwUzw1LT2MhWPhtzNd2hcVw0g5O/MDSF7kZ47AzYr8x38MXQ4oB/VlreWcstErZX2soCS1HgLUtEExaUhZVa0V6jdHko6DRpXXewaN+O6MJN5Kub4/LGPnXnGCX4tKaD29JX5m9f/8EyeEw290xfhgJoEk+2EBDXBgtKBJdihw90+HxRCGtP1Xf5+AdN56SYWgykHbVJ9F4WmXS7pV2KQMmB/UeiKObkbFxYj6aNu7IkoXRcK9C2SyubgY2WvhhNlWEAJALXQotgoDwNzSncTe7yCCMG8GE9Rptqu7gLw7zm26FRR5l69mVomJsQ5dTE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB9688.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dzhRN1JhMUplL1hLNzZ2MVFweXo4UXhuSXByQmJZOEpIbUJML0dpZERPN3E1?=
 =?utf-8?B?K3U5YWx3d2tMVnkzM2tXM1FocWdjV3ZpdjN2eDF4U21FQzRib21DUW9aZm00?=
 =?utf-8?B?WXJWaWRaczJHdTg0eWdSQmFiNTBIbEtLK0RPRG01TjlRTmUyT2lHRUZyMkgr?=
 =?utf-8?B?Wmg0UjFkbkVpalFJUEFpSnFWR0tvb0ZhdFhvdDNiNHdtN0ZNVEQ3RysxbGVM?=
 =?utf-8?B?MTdDalljbzljNlRNTFJJTDZaK0FVd3Nxd2l6VnJwejZPUnZkQXRFazN6SGJj?=
 =?utf-8?B?TnhCWjROQzl6a1ZRN1Q0TFpRRjRzSjIxODlqUXZOZTZkMkpEUUdRMXFmL0dE?=
 =?utf-8?B?K0t1M2JNcklZbS95cXFFaUFGdWg0SDk1ME5uT21Zc0VVRm8rOGdkSnRFbjVY?=
 =?utf-8?B?Z2lpNU5Sc1Y2Q1VZaEtKbFFrMks2OXZEOGk0eFhOQ0o0SnQ4V1VoNnVmcXZ0?=
 =?utf-8?B?dEI3ZEJOZVRhZnFveTlvTmRiWFhPeW8rU2YvbGdIeFIwUzlydXh0cE80Nm1n?=
 =?utf-8?B?YVZMMkFZUElNencvTXE5N3VlbGthbEMwWXU4d0VPeGhUSk84MGl0SmY0VzRm?=
 =?utf-8?B?Ny9HY0RjdzVFZjBhV0FTeDlnMFU0bFh2Sjd4czk4di9qS20wN3hwQ2VCV3pU?=
 =?utf-8?B?UmhkeTBXUm9acGNXQlR6N3FKL1FUZWlXQkVvZEcvczdBTXY1V0lVTk1oRkpQ?=
 =?utf-8?B?ZVNLY0hnRE41bWw3b01RRFlMcCtoYllHZm9ObjJxL3JuNUwyakV3OVhxOUs0?=
 =?utf-8?B?REVnK2VacVhtUmQ5Z1RlMjFCcXNsLzBxaXdUTERJclhWaFd6bTNsRjNNRDFV?=
 =?utf-8?B?ZWM1cFE3di9uVWtjc2pTR0RnZGJ5bW9iNTZIU0Exd2JiaCtwYkpjU2NvVWVx?=
 =?utf-8?B?WXl6ZnVRZ0NCbzJYd29iMTFqSFRLWjB2RGxJTHUzNzk2TXFySmVMQXlJUzJL?=
 =?utf-8?B?UmFBUmorY0lTR202elVRckd0MVVlQW05N2JHSnJXcElWaVdVME1Oblh0WGRo?=
 =?utf-8?B?aGxHNTl4SCtCMmFXRmtIdkp0bEdONzVaRWtwL3JrdlNMMXo0OXByVytoSnZo?=
 =?utf-8?B?ajROb2dOQmNPemVVOUxiN0xmdEYxNElXT1R3aktSbmdka09mMW0rRmlmUlM3?=
 =?utf-8?B?RnArazdXZ25oZml6elBHQmJoV1BlcTR0NlhMQ1dUSU1SaFU2dURXNGpRRGhK?=
 =?utf-8?B?RnplSkNENmc2RjcrblFxcGRuN0J3WkhReWNIRk9pSHJ1dVpJbkQxdkpqZDFx?=
 =?utf-8?B?RTZ0eERqc1VOMW1IOENWSE5tYVFWMC9tVW1aUGdreFFxajZRV1U0bSsvdVpK?=
 =?utf-8?B?S2xyZFdnR0h2ZyttN2MxYkk2MmRjNXV0UEFoYUE5QlhmSlkwYitQNkh2Tmhk?=
 =?utf-8?B?bE5MUWhyUmEySTRQcmpkSFUrUjVGSDdrMEN2N0srd1ZlcDlPMnp4Y0tJQmZP?=
 =?utf-8?B?NFY5eHNhSkhiblNmeE9jL0plaU42MnQ5aFV4azdsUVdJVmZwemFRUis5UmJh?=
 =?utf-8?B?ZFdjOC9NMG1OYWNiQzA4VGl1SzVZQmhNa01nTS9GNHBjZlZXWDF2NHQyTXRE?=
 =?utf-8?B?WFk0emJ0d0tmcmh1UmFtK2FoU3NVRXNTMTQvOTdJNEZtdEo4ZFpncFRDWWJJ?=
 =?utf-8?B?SkEwY3hWZmF1dng5ODcxNFYwa2VZU1lKMzN4aUxmVzBMVk9RWGFtUkRrTDlU?=
 =?utf-8?B?akZNYzMwNkRUZUE2YU1ZQnhZK0JwS3I4Y2xrT0cwd21obmk3RFJ1M0VtTTkx?=
 =?utf-8?B?RE83Zml6TFhnbU5FYXg3cnJLMmFGYy9sRktBbGJJOHFZRkplNG5ZRkFzQ0pS?=
 =?utf-8?B?b2tBazBRQU5MSE93U01nYjN2eUZSUlZ6d0VtTCtHZklCVzlMek9MWG5hSFBr?=
 =?utf-8?B?b3c4SGg1ams0K3ZKNTZZMFB4OWU5NGZrTndNZ0RseTE2cXRqRmhBU2RyUmpX?=
 =?utf-8?B?MW1SdnNINU0zWkw2YWdvVVN3UkZlSFA2ZStpSmZUdHBXeHAxNnIwWE0xMzN4?=
 =?utf-8?B?L0dpWEFwWENhYkR0MGkvVk5NY004czJJRnlnQXYxaGpDUkhUblFqSlA3SENh?=
 =?utf-8?B?N1RkSUZkRHhzNGdnR2dWL2dzUDNDZGhqbkIxRi84N2JwbDUxL0RDUWVpNHFm?=
 =?utf-8?B?eVB5b2w0endEWUVYZkpONGJKQkdjY1d3QlR0ODhkN1pIK1hBYTZORnE3MTB6?=
 =?utf-8?B?bTkwR1BzaEI1Y3FnK2JOYkhQZ2ZobGw5M3RPaHhrVlNwNzJPNjBwbEw4YTNC?=
 =?utf-8?B?SDNGN2ZIbEFuUjJYWFhJVHFSNzJnPT0=?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a07696b3-0506-416e-fa55-08dc3f597425
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB9688.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 10:21:01.3994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T7X2MtWPTW4Oyg6nlcKbLfDClR1UhLAp2/88HQesh9cW+b4nJrm7+R92jyXxarR7/cgY9LMdi//H429nlVGfs0jI3GwiuLtlgZycbo9xMg4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR07MB8311

> I'm not sure this is a false-positive: if you traverse an RCU-list
> without RCU watching the CPU, then a grace period may pass, the next
> list can be garbage and you can go anywhere from the list. Or am I
> missing something that a CPU hotplug can block a grace period?
Thanks for the feedback! Yes, calling it a false positive is probably not
correct, I will remove that. However, as Russell has explained in a previous
email, the spinlock is fundamental for ASID handling and cannot be removed.

@Russell, I will submit to the patch tracking system then.

