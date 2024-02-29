Return-Path: <linux-kernel+bounces-86188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A766586C12E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 07:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A0D8B21C8F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 06:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B044744C67;
	Thu, 29 Feb 2024 06:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AzU2eWdu"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19ABC3D541
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 06:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709189080; cv=fail; b=XJdJcG7tigap01tIgIk3qQpShJ0Stwf+i/r2D7h/aVway1K9lIEVwOswR0xtAk+MlfALFB/OjKd2fek0LHAayy1rE0LFnRkPmAV/FV5wJvHnq+pkL0Sx/XeMLqHNrJJdNkx+3FyfJTIO1+WGeGeyMJZBWXFGD9ezHDb+s2Sa778=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709189080; c=relaxed/simple;
	bh=ryE+uUapXIL+VQeyyRD9FVAYCwXOFL+yvYK2nJsWAW8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LdVkgcItqWywFXXqUdSwANkmv3KmO614PdsrlYVQKsjh6zLDycH6KCg2TMl8iwWv65r2F/pGWp5+j/0TILtAstgSBx9W/k9Dp2b1G+YwuTacE6j2b30ZmfOTUju1n8hrDQQQdIuHk5c1UULDQRbQYJkm9YAht5zKmt235FaLCtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AzU2eWdu; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JSU11H6wPvhC7OUHcrGs0gK2eNzp7cTWviiRvXWBo8tXZMlcjK2Zrx8d0Tvr/j9Xy3PTtQrK1CrgA1GzIcZMl3irBRqspqHtWb7FhiU0D9FHOmgAmpWqqhoSNYT+1slOLB2hue57O8DIbOXzOxFumk86gR9VoB81911Pd8HWVoK8+2ML+5AhwGXjmY92prRhJGw/yGXmQraNG8SiO2qflDa8F7t78+2XkYCYBXnohPUiio7c8H7/s9XlaGevOv/52KQGTO2LE9a/2FVr5FfdLBlTnWGi8/9nHtJbdl4KByhZoZfFRyWAzbx96xZxLbY/qTWbVlKeFGX7eZjSDy8pCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jUIK2ltfHuJ8MwKKJRV92+1qVSd4Y0Lhd3Dtwky7MNY=;
 b=RL2IyXeudgu3ShYOUgfNBV/9LMTlOzbvJQ+pBEOzP2wAPz0xw0UG2ixCwli7EbovEY/JjZ/tzooG4krdW8YD+Bf84kLF1Rte7PVVxIGnSTrlWTDkMCsS3FAmeOGUZlwudaTnuzywBBkgmvjaA2mkebMkKQQMYoy58cpJCkhGJGyBMBL6otiY+fMY5Xphhid3xnADKlSXkACsOeOVUDNliDQpO7Klj+E78ISZKc5QLRAXxWIDl7MknbhrFLQNDkbLG/4qlcYG2OAG65CkuyDIl9Xc5r8Y2wwKNJcKbaHj9T22LbZI/zs+wNZPGHM2S6SmdOm2xt+jPx5IHH74mABFXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jUIK2ltfHuJ8MwKKJRV92+1qVSd4Y0Lhd3Dtwky7MNY=;
 b=AzU2eWdu7JmHY8arxayFeshXsAKor18nGX7uOL77EjRrgTvHOIRr05DzFM3n4Bd/mKTuVQJHsTb5U2H5Hp2SfWIkabHFbWnSbxVTUL3iHovkzlyqxxHw2KiaRllHVvUhdDTLctCP009RNd5vHF3ezfrsNM+yRdqE5jaSDVcAjDo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by DS7PR12MB8346.namprd12.prod.outlook.com (2603:10b6:8:e5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 06:44:35 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::3150:d50f:7411:e6bb]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::3150:d50f:7411:e6bb%4]) with mapi id 15.20.7316.037; Thu, 29 Feb 2024
 06:44:34 +0000
Message-ID: <7daee7bc-bf4c-ab24-dbf2-467371ee72e1@amd.com>
Date: Thu, 29 Feb 2024 12:14:21 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [RESEND][PATCH v8 0/7] Preparatory changes for Proxy Execution v8
Content-Language: en-US
To: John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Joel Fernandes <joelaf@google.com>,
 Qais Yousef <qyousef@google.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Valentin Schneider <vschneid@redhat.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Zimuzo Ezeozue <zezeozue@google.com>, Youssef Esmat
 <youssefesmat@google.com>, Mel Gorman <mgorman@suse.de>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
 Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Metin Kaya <Metin.Kaya@arm.com>, Xuewen Yan <xuewen.yan94@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com
References: <20240224001153.2584030-1-jstultz@google.com>
 <3937e057-6b47-77fe-9440-ade079ee2cfe@amd.com>
 <CANDhNCqUrd4RNfKKMPRZj9ft1tTMNZq-XgYsU1dHpN4ixcZuJw@mail.gmail.com>
 <0c606d04-6765-d55d-61ec-c3625daea423@amd.com>
 <CANDhNCpb2Ve5saKtnBgTeAQXFbaWf84G_ky-509ddsfhOhdiLQ@mail.gmail.com>
 <c26251d2-e1bf-e5c7-0636-12ad886e1ea8@amd.com>
 <CANDhNCrkXF0R1Otu_EKY6OHxnAOYUQ+UjaQsJ_mW4Ys4ELPcYA@mail.gmail.com>
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <CANDhNCrkXF0R1Otu_EKY6OHxnAOYUQ+UjaQsJ_mW4Ys4ELPcYA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0060.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::14) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|DS7PR12MB8346:EE_
X-MS-Office365-Filtering-Correlation-Id: b19aa4d4-d1fc-4c2f-bc61-08dc38f1e412
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PUJ4ElkFFT7pclrv+meM0i0N7OErFOX4/lVTnwEmN1XeBIaa05Q6ULClV3XPju4Eck1sGRe8s8pyO5p3lDLdS98P3UcyOKbwiUGtAsIG2Semh9UuZEB/oDtPbUtVHe5vpOSBXhqHW1aR5/Q6ppAUVxBJx0hTOkYS/co+qHCX7sigvFTwXno2jSD+XJi8+QTdm9f6wAjpcmkrDRt9zko5yAsFGPuRyx+Od9IOtuGLWpX2Q3dcQG2bPE2KqtHigeNJTUfUH+8LaUqXMO8M06smGkYiqZ7KWRL754taU/HuItKTe0heHv957/jgXaiCwg27XkTovw7v/HgGJzBNW+I96SUZ8atkv57MF8W8DxgPIdeR1MGQXIftQQbs3vtkhs4HORQ4gqHgFUuUvOiT3IAPbQ5ARhxiTJVBLnZlGxut6G9TIhnn3pZc8S7wZVB/uTGX+dl33jSGL74/SwyjyOMlLUhm0u6vRX+shCIaTn5Kxqw6ODKESxGaGr7peYBiuT/UVu76JDNAa3eQtPPpumD+HOMycWocIkd24VVfQLNsYte95SnapwVOCH8iNcv9cZ2qhyBF3w60l/TOPqO7RyOyww==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MnJDS1c0Wkl6aVdRenhsdUlicGlTRU10Wmwya2ZLSktjWU1lTldjRC91blNX?=
 =?utf-8?B?RnJPckVaU28yMHhmeEF1SEdJUGI1Y21LazcxR3pLaHIyTUFpRDltbjhZc2Jr?=
 =?utf-8?B?MHppU1dEY3hRRDR5L3FhVThKQkVKV1JMOUdqVWd4aVVyd296ZUk3U2ZQbDVm?=
 =?utf-8?B?OWxzZTREMmFMSG5oaXpVdzlqRTQxMVZEak5WT1prZjFZQUVrMVhDMGhWMmZy?=
 =?utf-8?B?UU9uTjBmcU1GeUNoYXVYakdSRDN3eE9EdVVkNVVtUzJoOHdVQWltaEpqZzhw?=
 =?utf-8?B?Z245RzlVdGNPc0YvZ095UmJCNkZVWVZ3Z0UyLzM0V2ZDcUVTNGJOamk0Yy9r?=
 =?utf-8?B?S3JVTTlVMHhJZnRPNFdnWldHS05CSkxnYjdNa2ZFN3UzaG4xcmZ5cmdPdEt2?=
 =?utf-8?B?dklESVJqRE1GTEZtbUdsTG9ZREEvY3lZaVRhUExaYTl6aWx1dXBJZThGUWhv?=
 =?utf-8?B?TmcvKzIwK2g1Y0ZoRU5aQ2ppMStKUW9sV0szdHVhREtKRWJleU5yVk1qUVZm?=
 =?utf-8?B?UVFIRCtVRWJ2U3hZcENrWlZDTnlzMEIwaUN3NjdLRlJCSnFUaWpqeHl3aHov?=
 =?utf-8?B?RmdNL1NvN0RNcU1oL1hmTG5oNFZGa0s4c1ZNK1ROcUIxbXQ0MjFZMWVhVHFj?=
 =?utf-8?B?dUYzd2lNSnNjcWlJS2dlMVVqQjl1OFVUSmpabko0ZlhUcXdyL3pFMExJdm1r?=
 =?utf-8?B?Q0lZeWV0cWkvWmR6dXlRUXR2Mnc2OE1rRkpsTmcrdXJTczExU2l6T292OVUv?=
 =?utf-8?B?aVhjS3FLc0dwa1dXNGxMT3dWeXpJQjVSb1ptckxPdm10TFBNSHlneXhYWVA1?=
 =?utf-8?B?QW1MUEJ5andyVUEzNGtuTUh5U2RlQmorZjJkL3dvNUdpYTFzbHpadW9yTC9B?=
 =?utf-8?B?a1JrdExhRUcxcVFTZWhsQUhnc1p1VnI0VmRPYUpTQUcwR0RXSGgwL0JWRVFJ?=
 =?utf-8?B?SnQrZ3Y1SmRTRGRkU1RMZXBKcXFBRHRrTWt2RytobDdkdEhlc0JHUXVzWUZ6?=
 =?utf-8?B?UGRxZHBNNk9aTWY3UFpPNHRZUDNnbEREMHpQVERQMThsaTNDRTlsZ2NQZXJi?=
 =?utf-8?B?Y1Z6MndYQWIzTlE2RHpZM01oMHNnUkgwMjFMOXJKTVVXYU52M0RNbTRVMUsx?=
 =?utf-8?B?THg2cG45WXk5RFVXRXdnRGxkeDlqTnpDMVAxZHRlVExRU3c4OFZ1Z0pmVDND?=
 =?utf-8?B?MXV3dUcyRVY5Tkc5TzM1UTNFMFFRZDltK044N3lra2hONVl4a3hWSWJkQmQz?=
 =?utf-8?B?OEVjUXc5YnltWS9CUzVHa2hZcnZFQ0t4UEpxcDd3NkhCcGoyVEVoc251SVFh?=
 =?utf-8?B?VGJBK0Uwb1hOMVhURXpFZWt3T2d3cmh5SEpwMVJsTVZkR0VoVm5wOWNncDhV?=
 =?utf-8?B?UEN5aEs1bWVWeVRaZ0NWaUJwYU5VZm14b3Q3L0E1anZ2VnhzRTd4dWlyUXVB?=
 =?utf-8?B?cmZnK0ZGaTNnOEJrNnBGMkxCYnVyd0hsWTB3NVpKQ0pLQ0J2RWd4dWl5M1J0?=
 =?utf-8?B?WGxNbFcrdEY5YjBzUW93SWZxaVhoV0k5M2hMM2NwZDg1QlAyYWlHZ0x3SndO?=
 =?utf-8?B?K0NaRVh5VUNSVkhYS2Frb09uZWdWVEFGNkdzRVY1ZVJtZmR5RFBLU0dJQk1o?=
 =?utf-8?B?SXQ2QmR4WWxZQzVISWhPbUVLdzhab3ppeElDWkt3WUNubzF5Rml5d0Q5WDll?=
 =?utf-8?B?cEFMMnQ5MVFLZkQyU1RadjY5SGpDZUh1aC9UK2g0MVdKamxsZHN5THQwdWhX?=
 =?utf-8?B?bVJZMU5IM1Npek1ZSURiTnVMWVZvbFljU3lzdW5kMC9LVXNoSGMwSkFscTJE?=
 =?utf-8?B?cXh0aFFMNEZYVzhlM013bStjNERZbElpOWNFbzA5VGcxQW55aEVpZGdBVEhC?=
 =?utf-8?B?S1dxWTBUbUJLbDlYZVFPdXoxdGpLNUN0NEVTVDBEaTdaVlF1aDNnbk1UWjN2?=
 =?utf-8?B?WGNUUk9HY1Rpb1VDOVlyYWgwNFNmRTJXaWxXS2tLZ3l3Q3lGQ28rUURuSkpP?=
 =?utf-8?B?eXZnSXpMYkVjZ3NxK2RWejBzSUp3UkpRU29RaHhIdVNCYnAzWjlib241NDMr?=
 =?utf-8?B?aU42djdXTGZqQjQwUUVHMndTTDJoTnBOd1FzbFBoUGRITXJtZldZUEhQZFdp?=
 =?utf-8?Q?aZ9lhvIczhOQRmElHFVd+gGp2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b19aa4d4-d1fc-4c2f-bc61-08dc38f1e412
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 06:44:34.7687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vyr1rwTgQsBOppM6+enpnM5GnmKocg5XP62Wqm14JjUXKO8ggL1Bx/btDp2l5EaEmPqGE+poEKrzMaSdKlsxbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8346

Hello John,

On 2/29/2024 11:49 AM, John Stultz wrote:
> On Wed, Feb 28, 2024 at 9:37 AM 'K Prateek Nayak' via kernel-team
> <kernel-team@android.com> wrote:
>> I got a chance to test the whole of v8 patches on the same dual socket
>> 3rd Generation EPYC system:
>>
>> tl;dr
>>
>> - There is a slight regression in hackbench but instead of the 10x
>>   blowup seen previously, it is only around 5% with overloaded case
>>   not regressing at all.
>>
>> - A small but consistent (~2-3%) regression is seen in tbench and
>>   netperf.
> 
> Once again, thank you so much for your testing and reporting of the
> data! I really appreciate it!
> 
> Do you mind sharing exactly how you're running the benchmarks? (I'd
> like to try to reproduce these locally (though my machine is much
> smaller).
> 
> I'm guessing the hackbench one is the same command you shared earlier with v6?

Yup it is same as earlier. I'll list all the commands down below:

o Hackbench

	perf bench sched messaging -p -t -l 100000 -g <# of groups>

o Old schbench
  git://git.kernel.org/pub/scm/linux/kernel/git/mason/schbench.git
  at commit e4aa540 ("Make sure rps isn't zero in auto_rps mode.")

	schbench -m 2 -t <# workers> -r 30

  (I should probably upgrade this to the latest! Let me get on it)

o tbench (https://www.samba.org/ftp/tridge/dbench/dbench-4.0.tar.gz)

	nohup tbench_srv 0 &
	tbench -c client.txt -t 60 <# clients> 127.0.0.1

o Stream (https://www.cs.virginia.edu/stream/FTP/Code/)

	export ARRAY_SIZE=128000000; # 4 * Local L3 size
	gcc -DSTREAM_ARRAY_SIZE=$ARRAY_SIZE -DNTIMES=<Loops internally> -fopenmp -O2 stream.c -o stream
	export OMP_NUM_THREADS=16; # Number of CCX on my machine
	./stream;

o netperf

	netserver -L 127.0.0.1
	for i in `seq 0 1 <num clients>`;
	do
		netperf -H 127.0.0.1 -t TCP_RR -l 100 -- -r 100 -k REQUEST_SIZE,RESPONSE_SIZE,ELAPSED_TIME,THROUGHPUT,THROUGHPUT_UNITS,MIN_LATENCY,MEAN_LATENCY,P50_LATENCY,P90_LATENCY,P99_LATENCY,MAX_LATENCY,STDDEV_LATENCY&
	done
	wait;

o Unixbench (from mmtest)

	./run-mmtests.sh --no-monitor --config configs/config-workload-unixbench
--

If you have any other question, please do let me know :)

> 
> thanks
> -john
 
--
Thanks and Regards,
Prateek

