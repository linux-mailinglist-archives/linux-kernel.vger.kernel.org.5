Return-Path: <linux-kernel+bounces-20763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D258284E9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 12:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22A141C23EDE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 11:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEEF4374E3;
	Tue,  9 Jan 2024 11:22:10 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCA736AE7;
	Tue,  9 Jan 2024 11:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0DF4FC15;
	Tue,  9 Jan 2024 03:22:53 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ECB5F3F73F;
	Tue,  9 Jan 2024 03:22:01 -0800 (PST)
Message-ID: <fb25afab-9586-455a-b8c1-47949035c95a@arm.com>
Date: Tue, 9 Jan 2024 12:22:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] sched: Take cpufreq feedback into account
Content-Language: en-US
To: Vincent Guittot <vincent.guittot@linaro.org>, linux@armlinux.org.uk,
 catalin.marinas@arm.com, will@kernel.org, sudeep.holla@arm.com,
 rafael@kernel.org, viresh.kumar@linaro.org, agross@kernel.org,
 andersson@kernel.org, konrad.dybcio@linaro.org, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
 vschneid@redhat.com, lukasz.luba@arm.com, rui.zhang@intel.com,
 mhiramat@kernel.org, daniel.lezcano@linaro.org, amit.kachhap@gmail.com,
 corbet@lwn.net, gregkh@linuxfoundation.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc: qyousef@layalina.io
References: <20240108134843.429769-1-vincent.guittot@linaro.org>
 <20240108134843.429769-3-vincent.guittot@linaro.org>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20240108134843.429769-3-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/01/2024 14:48, Vincent Guittot wrote:
> Aggregate the different pressures applied on the capacity of CPUs and
> create a new function that returns the actual capacity of the CPU:
>   get_actual_cpu_capacity()

   function name                scaling

(1) arch_scale_cpu_capacity() -	uarch

(2) get_actual_cpu_capacity() -	hw + cpufreq/thermal of (1)

(3) capacity_of()	      -	rt (rt/dl/irq) of (2) (used by fair)

Although (1) - (3) are very close to each other from the functional
standpoint, their names are not very coherent.

I assume this makes it hard to understand all of this when reading the
code w/o knowing these patches before.

Why is (2) tagged with 'actual'?

This is especially visible in feec() where local variable cpu_cap
relates to (3) whereas cpu_actual_cap related to (2).

[...]


