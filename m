Return-Path: <linux-kernel+bounces-3141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE06A8167EA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A9E9282EA6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 08:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AAFC101DB;
	Mon, 18 Dec 2023 08:19:31 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF2B101C0;
	Mon, 18 Dec 2023 08:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B18F1FB;
	Mon, 18 Dec 2023 00:20:12 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3EE383F5A1;
	Mon, 18 Dec 2023 00:19:26 -0800 (PST)
Message-ID: <c34df726-33df-4188-8010-3b268dfbb607@arm.com>
Date: Mon, 18 Dec 2023 09:19:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] sched: cpufreq: Remove uclamp max-aggregation
Content-Language: en-US
To: Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>,
 Rick Yiu <rickyiu@google.com>, Chung-Kai Mei <chungkai@google.com>,
 Hongyan Xia <hongyan.xia2@arm.com>
References: <20231208015242.385103-1-qyousef@layalina.io>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20231208015242.385103-1-qyousef@layalina.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/12/2023 02:52, Qais Yousef wrote:

[...]

> ===
> 
> This patch is based on remove margins series [1] and data is collected it
> against it as a baseline.
> 
> Testing on pixel 6 with mainline(ish) kernel

How is the Pixel6 configured in terms of per-policy rate_limit_us and
response_time_ms ? Is this the now default 2ms and whatever the systems
calculates for response_time_ms ?

Pixel6 is still a slow switching device, rigth?

root           297     2 1 08:58:01 ?     00:00:13 [sugov:0]
root           298     2 0 08:58:01 ?     00:00:03 [sugov:4]
root           299     2 1 08:58:01 ?     00:00:05 [sugov:6]

> ==
> 
> Speedometer browser benchmark
> 
>        | baseline  | 1.25 headroom |   patch   | patch + 1.25 headroom
> -------+-----------+---------------+-----------+---------------------
> score  |  108.03   |     135.72    |   108.09  |    137.47
> -------+-----------+---------------+-----------+---------------------
> power  |  1204.75  |    1451.79    |  1216.17  |    1484.73
> -------+-----------+---------------+-----------+---------------------

What's the difference between baseline & 1.25 headroom. IMHO, we have:

 static inline unsigned long map_util_perf(unsigned long util)
 {
   return util + (util >> 2);
 }

on baseline?

By patch you refer to the whole patch-set + [1]?

And I assume 'patch + 1.25 headroom' is 'response_time_ms' tuned to
reach 1.25 ?

[...]

