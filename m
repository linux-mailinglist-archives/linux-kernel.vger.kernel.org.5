Return-Path: <linux-kernel+bounces-53871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A9584A776
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 752BA1F2A81A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2368289D;
	Mon,  5 Feb 2024 19:50:06 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81484D5A2
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 19:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707162606; cv=none; b=ufK7dBO/86WrjvEPrRh6rVV6NuOT579ZOrak8A0BCY8qjh/dKFdmMs6/zyKKDajfg78W2py2NJCENrR4DbX2gVN90+1jEZXbdSPeZJ0vqSEQhiEF6wNOc2i3QxC4ERYw8o/frrh3VM7jNkgkaWDT/tqP5NIypABaobbKz9zVzQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707162606; c=relaxed/simple;
	bh=DZhDeBDCMf8yO5J3qJ1WtFftyp3OTevkIY224ie+zuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UrW3Kb+tYsZbKXl/e0ytjzaWr4xDiCLi2pPkrbnPleoPbN/E0EXor1VHVZ+S0ACK2kQOYr6HlSxWfAU1IxMpf5rLVcoDlSmt0witvsENmbDvuZaAEIjMpM5Ap6zEY/5AtBlLA6AmnjKvmxcghYREAIC9RzdRM3fPRWU4XSZv9ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D91C12FC;
	Mon,  5 Feb 2024 11:50:45 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9C45D3F641;
	Mon,  5 Feb 2024 11:50:01 -0800 (PST)
Message-ID: <5249d534-d7ac-4cbc-a696-f269cb61c7d1@arm.com>
Date: Mon, 5 Feb 2024 20:49:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] sched/fair: Check a task has a fitting cpu when
 updating misfit
Content-Language: en-US
To: Qais Yousef <qyousef@layalina.io>,
 Vincent Guittot <vincent.guittot@linaro.org>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 linux-kernel@vger.kernel.org, Pierre Gondois <Pierre.Gondois@arm.com>
References: <20240105222014.1025040-1-qyousef@layalina.io>
 <20240105222014.1025040-2-qyousef@layalina.io>
 <CAKfTPtBYcVWxYOhWZjzcQUB1ebUBA-B30hvToqGBq6JnfRUZNg@mail.gmail.com>
 <20240124222959.ikwnbxkcjaxuiqp2@airbuntu>
 <CAKfTPtDxqcrf0kaBQG_zpFx-DEZTMKfyxBu_bzCuZ_UZhJwOnA@mail.gmail.com>
 <20240126014602.wdcro3ajffpna4fp@airbuntu>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20240126014602.wdcro3ajffpna4fp@airbuntu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/01/2024 02:46, Qais Yousef wrote:
> On 01/25/24 18:40, Vincent Guittot wrote:
>> On Wed, 24 Jan 2024 at 23:30, Qais Yousef <qyousef@layalina.io> wrote:
>>>
>>> On 01/23/24 09:26, Vincent Guittot wrote:
>>>> On Fri, 5 Jan 2024 at 23:20, Qais Yousef <qyousef@layalina.io> wrote:
>>>>>
>>>>> From: Qais Yousef <qais.yousef@arm.com>

[...]

>>> And to be honest I am not sure if flattening of topology matters too since
>>> I first noticed this, which was on Juno which doesn't have flat topology.
>>>
>>> FWIW I can still reproduce this, but I have a different setup now. On M1 mac
>>> mini if I spawn a busy task affined to littles then expand the mask for
>>> a single big core; I see big delays (>500ms) without the patch. But with the
>>> patch it moves in few ms. The delay without the patch is too large and I can't
>>> explain it. So the worry here is that generally misfit migration not happening
>>> fast enough due to this fake misfit cases.
>>
>> I tried a similar scenario on RB5 but I don't see any difference with
>> your patch. And that could be me not testing it correctly...
>>
>> I set the affinity of always running task to cpu[0-3] for a few
>> seconds then extend it to [0-3,7] and the time to migrate is almost
>> the same.
> 
> That matches what I do.
> 
> I write a trace_marker when I change affinity to help see when it should move.
> 
>>
>> I'm using tip/sched/core + [0]
>>
>> [0] https://lore.kernel.org/all/20240108134843.429769-1-vincent.guittot@linaro.org/
> 
> I tried on pinebook pro which has a rk3399 and I can't reproduce there too.
> 
> On the M1 I get two sched domains, MC and DIE. But on the pine64 it has only
> MC. Could this be the difference as lb has sched domains dependencies?
> 
> It seems we flatten topologies but not sched domains. I see all cpus shown as
> core_siblings. The DT for apple silicon sets clusters in the cpu-map - which
> seems the flatten topology stuff detect LLC correctly but still keeps the
> sched-domains not flattened. Is this a bug? I thought we will end up with one
> sched domain still.

IMHO, if you have a cpu_map entry with > 1 cluster in your dtb, you end
up with MC and PKG (former DIE) Sched Domain (SD) level. And misfit load
balance takes potentially longer on PKG than to MC.

(1) Vanilla Juno-r0 [L b b L L L)

root@juno:~# echo 1 > /sys/kernel/debug/sched/verbose
root@juno:~# cat /sys/kernel/debug/sched/domains/cpu0/domain*/name
MC
PKG

root@juno:~# cat /proc/schedstat | head -5 | grep ^[cd]
cpu0 0 0 0 0 0 0 2441100800 251426780 6694
domain0 39 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
domain1 3f 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0

(2) flattened topology (including SDs):

Remove cluster1 from cpu_map and A57_L2 $ entry.

--- a/arch/arm64/boot/dts/arm/juno.dts
+++ b/arch/arm64/boot/dts/arm/juno.dts
@@ -44,19 +44,16 @@ core0 {
                                core1 {
                                        cpu = <&A57_1>;
                                };
-                       };
-
-                       cluster1 {
-                               core0 {
+                               core2 {
                                        cpu = <&A53_0>;
                                };
-                               core1 {
+                               core3 {
                                        cpu = <&A53_1>;
                                };
-                               core2 {
+                               core4 {
                                        cpu = <&A53_2>;
                                };
-                               core3 {
+                               core5 {
                                        cpu = <&A53_3>;
                                };
                        };
@@ -95,7 +92,7 @@ A57_0: cpu@0 {
                        d-cache-size = <0x8000>;
                        d-cache-line-size = <64>;
                        d-cache-sets = <256>;
-                       next-level-cache = <&A57_L2>;
+                       next-level-cache = <&A53_L2>;
                        clocks = <&scpi_dvfs 0>;
                        cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
                        capacity-dmips-mhz = <1024>;
@@ -113,7 +110,7 @@ A57_1: cpu@1 {
                        d-cache-size = <0x8000>;
                        d-cache-line-size = <64>;
                        d-cache-sets = <256>;
-                       next-level-cache = <&A57_L2>;
+                       next-level-cache = <&A53_L2>;
                        clocks = <&scpi_dvfs 0>;
                        cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
                        capacity-dmips-mhz = <1024>;
@@ -192,15 +189,6 @@ A53_3: cpu@103 {
                        dynamic-power-coefficient = <140>;
                };
 
-               A57_L2: l2-cache0 {
-                       compatible = "cache";
-                       cache-unified;
-                       cache-size = <0x200000>;
-                       cache-line-size = <64>;
-                       cache-sets = <2048>;
-                       cache-level = <2>;
-               };
-
                A53_L2: l2-cache1 {
                        compatible = "cache";
                        cache-unified;

root@juno:~#  echo 1 > /sys/kernel/debug/sched/verbose
root@juno:~# cat /sys/kernel/debug/sched/domains/cpu0/domain*/name
MC

root@juno:~# cat /proc/schedstat | head -4 | grep ^[cd]
cpu0 0 0 0 0 0 0 2378087600 310618500 8152
domain0 3f 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0

[...]


