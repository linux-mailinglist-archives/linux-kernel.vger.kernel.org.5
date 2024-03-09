Return-Path: <linux-kernel+bounces-97798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10EEF876F88
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 08:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD2EC28203D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 07:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD5937169;
	Sat,  9 Mar 2024 07:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="kgiZuphv"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2073.outbound.protection.outlook.com [40.107.8.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC88B2103;
	Sat,  9 Mar 2024 07:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709970344; cv=fail; b=u/jNxiVn9JAm4uxXQU8oxDYBxjGQ/YDx1Yfarkr/JiH6UkIrF/tekW05/+Z5gBhFajfRiPKZsMQH6OynT+Sw75bTU3MX+T6DtemUFfQ4NVyNVz5hrV2li72UalTceXeI/triMjJPyYbDu8r8hII8Ni69E9Ye1CCQm/EIBQOwPTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709970344; c=relaxed/simple;
	bh=iEo63V2tkkDX2R3C2nb6NyPbm5qjMALpf74fhW6jpZQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qYfmxycU6IKW2MBTqYLnDD8fh5b5rHB38O6aSEpyH4xP7FfudvRF1T9uuBxD3mbQ2C/UsFczh8xgJB59gcxU/BFkKrURcDj8eQa5gdyBGbG3I2/Fmt+Hwa5nXZ/0DkhVxEs5BwWE55mPUGBjSyp0kjOhX0vU5GfFMj/4oPp8b7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=kgiZuphv; arc=fail smtp.client-ip=40.107.8.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QmC8N9XYruCqLP1WMqhhEA0jp9cUSMPrpsClSMBpct8N8gdzfxEqnJbZlWSbYLjs99/eOURy87JfrLhZzV3rBXFfh2tQPA3M/zAoZE4NIjaTJznBIFKGp6g6wj/MF9ikWZwb9YpC2Ghi1mwvszvQ7B6dWX6NKR9wv7Ru6+MqYuIPb178kGdHVKnBqSvHD+qUeDC7UN+4uFlmYfr6nvoOuoY3QbdpipzGdgfKf6dBg738m5Mhh+gwTUR8HSvOwXWZjnQ767ptPx3ENafJTNw9FuhnsjchVttbVhvwPigqEBzxBPT50ZtArMUXtoXHPWqBCNmLuNvApVwGJVDs3XuvEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s8QMtjGRVgHw7Iyy7rPMkowb+dmNNCdz2QJOeRotc4A=;
 b=J9DUgVfipdoPOvlF/FxvwjPBcK7Nmp8d3+lX6sbBHpypxLAnVbCyLvxMcCsreBoBhS9kSWLflDu8CZxP6kYx9xvAIRxDFNubtC5ARFozO6gbYABXfHD3rqOoKvvJxDp2YnlIFc1rz5CEs1Z46e6waSYXWj0LZKS2Uxf2MpgIR7/FRVv4rf58QP3BrxuAPRSaHRH05ikdBUUVFTrLIJL89TpMCqA5H1cv667e1AkwFrQ/xjhpK97PIRWxnmDp/a5yWipGOfZrYB1JJkpivc7dZmXN6AzprC4TaV3SVcUbJea2VqaTvzK6sMOMoSmdRLNIuPD0wpXchiCMhjmL5HIeaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s8QMtjGRVgHw7Iyy7rPMkowb+dmNNCdz2QJOeRotc4A=;
 b=kgiZuphvqKZ6etjvLmlbIWwmdVOI7XTpQYUXHEZZi7jfx/iSmXyeGXjfW0bI5b/lCJomd3XGV6IuN1fiR5eWMHtGYZHB0ybQnm6UA79Wb71UDQ/KQJw7Ny2nEIvHUm/c5fM/xf1WEveU36lU95Qtvh2LZGmfx7UkYC1/aUxv5EyjuYrOPjiFIn8vlu0BKJXvCyfdfYCYSoC6if6pV/0We9UkpfXa6dTolkh6LpOWarKD/YO6tItp7hQ+jczmDPxQbyWwAkiSx98B/DBCAogPgwhk3t+GRRJ2pBt+p0swUsqH5N/qebSnkGcy5h1Vz3ol0kayoJ/nZwsWMtfEz77XYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com (2603:10a6:102:383::17)
 by GV1PR07MB8997.eurprd07.prod.outlook.com (2603:10a6:150:a2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.31; Sat, 9 Mar
 2024 07:45:39 +0000
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::995b:5be7:51dd:e540]) by PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::995b:5be7:51dd:e540%4]) with mapi id 15.20.7362.030; Sat, 9 Mar 2024
 07:45:37 +0000
Message-ID: <66fdce3a-c7f6-4ef4-ab56-7c9ece0b00e2@nokia.com>
Date: Sat, 9 Mar 2024 08:45:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: smp: Avoid false positive CPU hotplug Lockdep-RCU
 splat
To: Joel Fernandes <joel@joelfernandes.org>,
 Russell King <linux@armlinux.org.uk>, "Paul E. McKenney"
 <paulmck@kernel.org>, Josh Triplett <josh@joshtriplett.org>,
 Boqun Feng <boqun.feng@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 linux-arm-kernel@lists.infradead.org, rcu@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240307160951.3607374-1-stefan.wiehler@nokia.com>
 <bce79497-52c5-4241-aaf6-2a95dc459041@joelfernandes.org>
Content-Language: en-US
From: Stefan Wiehler <stefan.wiehler@nokia.com>
Organization: Nokia
In-Reply-To: <bce79497-52c5-4241-aaf6-2a95dc459041@joelfernandes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0185.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::18) To PAWPR07MB9688.eurprd07.prod.outlook.com
 (2603:10a6:102:383::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR07MB9688:EE_|GV1PR07MB8997:EE_
X-MS-Office365-Filtering-Correlation-Id: 35f590dc-ac5a-4e83-ff87-08dc400ce90d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qYhbUHawrRXkyrErgTbKPO1RefIN5iW+RXHbWHyaw8IUZrgtDfg6yqhXGzJFWP2NkKRK//eK8VNgORrEwhg0+1OgGBLWtV5oawGPmUmzxcwsCkQbjwkQC48DO1e3IyT160l6g7BwmVlNgpa4ldIntUmg1J4haZjOg2ojYKI3uukaLpmfkPcJS1C7AmMmc8gAoLFidTVddquWoqeETx7R+lEXUHgb/rN+6tnS1Ls1GT5O8PdfLrGuRtchQ6Zc7K6zJPcdU6In8wCT0N0X8SKswulPXABMXAw7yWzV451RUH7kGAuytOUwUvgizAqs3RL1Ez78BUwRmZO5aXGQy0/Zdm1eyqGtk34vIrzs9UDC/tI9JlDXcrdagL00Qe4G50XbaMME2bkctCn6hbAj4s2/7m+Vx9FRjtpq9n+Jg59tMSxhrMDcCZ0bKkLiEOe7QpSqxvJSg2V652bmT4/PjAQGPqHnzZ7I62rucdyzk80j/ODjMAmvVbkCVg38DGcy9izKtZ9636RAimWkAXd3OsUiaZWcFtTFcyurocFjU+pWIZb7gQGBB2glOkpMmMpAkycExTKodulHo1G/Gl6ejzPIHOsfSKnmGlXcXqtnskVZCmQLypvwVlIXpv9YtFJp2dUvlAwx3GAbz8YtEiz/CIr/OSNTNSm85lIKxZuKp46WEuM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB9688.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dXhQWm1RYmVHQkcvRi9laTBsbStPZ1BrTUluQ0JsUm9hY3lDd3B0ZDZLNnhT?=
 =?utf-8?B?OFVaVUJ3eEV3YTJFVW0wS3J5ZkYrUGRYT1JtcHo4MElnSFFDbEVMZGVML2hz?=
 =?utf-8?B?S0l0Y0JJY3RDbFlMK2l1bzlwMnpmSGw4bnI1cGxhYkkwSXd1ZjdnL3VxRjdo?=
 =?utf-8?B?SW14K3p5cW9tUlZURmkxeHNTa29JWXRNb2FScFlxbTlyYWVpejBRSkR1VGRn?=
 =?utf-8?B?dHY0dmZENFVHdGNzNkc2MHpRT05HejNlRzhFSkl6QzNUNG5DMk84V0VtMnc2?=
 =?utf-8?B?NTFWK1lQMkxORzVNR2I2ZFlVN3E0eDRTbTl0djhRV3BkRVY4QlZSbGVXTHNH?=
 =?utf-8?B?cFFoY1dJdlNSNXVGZzlseXJhZytsdDRLQllLb1RITXkyRHNjbUJGR294Umg1?=
 =?utf-8?B?WGdvdHoxTU5CYU5CUmhsckNTTmVOZVVRdjZnNFVJelRXaHdLekMyamt0a1cy?=
 =?utf-8?B?Snk4algvdDFtY1pSNm1VVlZmOThkei8rYjl6eHhZQkR2dzE0WXNaTm95cldH?=
 =?utf-8?B?THhTMmh0ZmVCTUE0ZEFPUmZ5WWpjdTk5YzQwa0lFVUxURWhCVWQrRER1NGZ0?=
 =?utf-8?B?RFVHWmQ4RzBlZGtpOURnRG9yVVNjNHpmZllJamIzTVFLT2tkTjZhL3NzQW9Z?=
 =?utf-8?B?aHcvdnBGNWQrdEVRS0UzOFZSaWdzQ3pnazJDMXVGb0hlUG91aVhKVXNmVVQ3?=
 =?utf-8?B?YnlvWG9PKzk0aHUrZ3ZQZzdWVUx4VHE3U2dkTmZRV0tOWVhGRU80aFkra3Ra?=
 =?utf-8?B?TXFoVHk5anpYWWlwdUo1NGpHdVg3bXJ3cUdtcXRHRXo2eGU5QXdWZ2MzNHdR?=
 =?utf-8?B?OGU5a2h0QmdKaE1xMmxWSG5lVVFPalRSVXhPQThDRXVWK1BLVlBMcExJNnM1?=
 =?utf-8?B?bEhPMURud2N6MjgrdWw0MUZsWWlUT0VaZC82elk1TXpwRkRZUmw4ZVNFZVpm?=
 =?utf-8?B?VVRKU0ZqZUFCQi9VTTN3YlFyVFljNndNZmp1WTRhK3NnbzZTYTc5TXY0bkZu?=
 =?utf-8?B?cGF2cFI0STJ2L25Demc0aGxERWJiOWZ2cmp4WHZKa2pPcVNKWVEydE1Xd0pv?=
 =?utf-8?B?ZEI2eFNRbmRwa0pMajlLWUJPblNsUW5TeGNoM1UwZ09iTUE0QnY1NE9uSWxV?=
 =?utf-8?B?YWhjbXN5V0xORHVFL1BqZkxEbjZ2eXJ5ZDhISFdVOVJJZjIyR3NibnpRQ2hW?=
 =?utf-8?B?RldXVlNyRDBpTXFEUjJHNlNTSmorQ2NGemFxeXN1UWdZc1hud2EyN3lkbHpm?=
 =?utf-8?B?WVBOeDVPdUVlamdkcnlGUkhHNUlZY1N0YU43VUJCT3ZDQjZOQTJkSVN5bFps?=
 =?utf-8?B?MUFTdE52WkcvSXNFc0tUTS85MDlUMkxnYVl0bVhNTVZqRlpnaTdWaDVGbEFw?=
 =?utf-8?B?RlFqczhBWjRxZDd1VHVibHovek1GcS9BK3VtZUxyQnUyb1g1NU9NRmc5Y0xz?=
 =?utf-8?B?ck9pRllxSi92cHZaN1Y5d0Q4S1I5MW1nR2ZRcTRlYkFzS2R2L29RSVpJbm9w?=
 =?utf-8?B?bklLakQ2L3R2alMyMTUvampvTW05WVdJTEJFS1hSZjIxZkYvenhTRjU0bFdw?=
 =?utf-8?B?K2xielBkTjlzN3dTbFQ3WHRTWkI3d3QwQUJ4WDQremUxVEtKZFV2aEcvbDl5?=
 =?utf-8?B?MGt1UEFLVjIra2lEaXQwWlA3RnRhNFU5dUdJeFZqN3N4cEhacWhnUlJvRGxx?=
 =?utf-8?B?bUp2cGFxVll3WXY5Wk5pUnV1RlJHWjZuOUhZdCtienIwK3U3RCtuVmZjakpK?=
 =?utf-8?B?UVFWQTlvYkNjcWl5bjhlUkloWUdtS3MxS25RdmdNblU4MjhIVVZWNlNqQThV?=
 =?utf-8?B?MThrem02OVdVYzc0SWdEMFg1bnVJQXNCYzVjK096akUwUHQ1TFdRM0NkUkIy?=
 =?utf-8?B?TU0vbUx0eFZkbTBtaU82Tyt0ZWYyekJmVTZCSTlsUUF2OWhIZTBXeUY0NEJs?=
 =?utf-8?B?cDIxYlFLUXBIVzhEZHRwUllWVFZxUlVsQ3dvK3p5N1d2dlZWcFhqa3kzdm1h?=
 =?utf-8?B?NEowQVFiMHVZc08rZDFacUd1UzJzZ3E5YU1KdUNlL3oyMnJnUGRSSS8wNUhI?=
 =?utf-8?B?aGF3MThzREg4ZzRnVXlCVkY5cUZUQkM3cnE4RlZEUGhla0FHUTd3enRISWFs?=
 =?utf-8?B?RU9Pazh4TXlZWFhybnViTWhVdU12ek9CRXRPZm5hUmMwRmdraktaVlpCMEZ0?=
 =?utf-8?B?WVFBS0tFdkJLTVVZUDV1U2R6cThzTDg2WmtHTUQzNnh0ZU9jWURVTzVxdnNX?=
 =?utf-8?B?bmx3SXRlUm42UnVSRHpjaHpVbm13PT0=?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35f590dc-ac5a-4e83-ff87-08dc400ce90d
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB9688.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2024 07:45:37.4633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W7ZpP+NTMbC+6bHqRSTVMjE0aGYoZ3EypEAG9Eh3Rdk30iXsBL2HrAZHitNqHgvvOl0Zb0CynwtoEvD4imTNQMggjOR3lJ0wiREVuIwQD3Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR07MB8997

> I agree with the problem but disagree with the patch because it feels like a
> terrible workaround.
> 
> Can we just use arch_spin_lock() for the cpu_asid_lock? This might require
> acquiring the raw_lock within the raw_spinlock_t, but there is precedent:
> 
> arch/powerpc/kvm/book3s_hv_rm_mmu.c:245:
> arch_spin_lock(&kvm->mmu_lock.rlock.raw_lock);
> 
> IMO, lockdep tracking of this lock is not necessary or possible considering the
> hotplug situation.
> 
> Or is there a reason you need lockdep working for the cpu_asid_lock?

I was not aware of this possibility to bypass lockdep tracing, but this seems
to work and indeed looks like less of a workaround:

diff --git a/arch/arm/mm/context.c b/arch/arm/mm/context.c
index 4204ffa2d104..4fc2c559f1b6 100644
--- a/arch/arm/mm/context.c
+++ b/arch/arm/mm/context.c
@@ -254,7 +254,8 @@ void check_and_switch_context(struct mm_struct *mm, struct task_struct *tsk)
            && atomic64_xchg(&per_cpu(active_asids, cpu), asid))
                goto switch_mm_fastpath;

-       raw_spin_lock_irqsave(&cpu_asid_lock, flags);
+       local_irq_save(flags);
+       arch_spin_lock(&cpu_asid_lock.raw_lock);
        /* Check that our ASID belongs to the current generation. */
        asid = atomic64_read(&mm->context.id);
        if ((asid ^ atomic64_read(&asid_generation)) >> ASID_BITS) {
@@ -269,7 +270,8 @@ void check_and_switch_context(struct mm_struct *mm, struct task_struct *tsk)

        atomic64_set(&per_cpu(active_asids, cpu), asid);
        cpumask_set_cpu(cpu, mm_cpumask(mm));
-       raw_spin_unlock_irqrestore(&cpu_asid_lock, flags);
+       arch_spin_unlock(&cpu_asid_lock.raw_lock);
+       local_irq_restore(flags);

 switch_mm_fastpath:
        cpu_switch_mm(mm->pgd, mm);

@Russell, what do you think?

