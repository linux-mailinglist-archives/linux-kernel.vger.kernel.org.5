Return-Path: <linux-kernel+bounces-140124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F15768A0BB1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E8ECB23A92
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25DDD142E90;
	Thu, 11 Apr 2024 08:55:43 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545472EAE5
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712825742; cv=none; b=sH6stboTqHRIH1ParlkHRHRgY1qt5TSf75eeWs6PkFDxP8XLWcUvyN1lMirsWIeUEj8TyxIg5ASDJa4thDKrN1dmub2622L9rAJL/SRf2TrDqNgUw1da6pQ0D7ewZcOCPJdF6tMuVcI3SAyxM+lHIM/ePlcrCQ3JFGXDDG/4yNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712825742; c=relaxed/simple;
	bh=/F2m2TcZQeZHqIXCrq+XIQWAbfaXkaeM+fYeFhkYw1U=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=T7GxOujW4/fqhsZC5xn+qUA8EOAY84L+848Ktlju5abk19en3yVWsXmTHNQN9ixlfKJg61lOL1z54+1PF71uuAZwF5hop1E3hcNX+kwuc1vIbK9eutE6x8lWl68IVKXDJJv8wbBkVL9+Xn8awLD1Rx4gKpeAWlv5YhKJDyIGkBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4VFYPq4HzRzFqVS;
	Thu, 11 Apr 2024 16:53:19 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id AED6A18006B;
	Thu, 11 Apr 2024 16:55:36 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 11 Apr 2024 16:55:36 +0800
CC: <yangyicong@hisilicon.com>, <mark.rutland@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<jonathan.cameron@huawei.com>, <prime.zeng@hisilicon.com>,
	<linuxarm@huawei.com>
Subject: Re: [PATCH 1/2] perf: arm_pmu: Only show online CPUs in device's
 "cpus" attribute
To: Will Deacon <will@kernel.org>
References: <20240410095833.63934-1-yangyicong@huawei.com>
 <20240410153419.GA25171@willie-the-truck>
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <d7c4da97-92ba-4cb7-ecd5-5edc4f52fd8a@huawei.com>
Date: Thu, 11 Apr 2024 16:55:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240410153419.GA25171@willie-the-truck>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd200014.china.huawei.com (7.221.188.8)

On 2024/4/10 23:34, Will Deacon wrote:
> On Wed, Apr 10, 2024 at 05:58:32PM +0800, Yicong Yang wrote:
>> From: Yicong Yang <yangyicong@hisilicon.com>
>>
>> When there're CPUs offline after system booting, perf will failed:
>> [root@localhost ~]# /home/yang/perf stat -a -e armv8_pmuv3_0/cycles/
>> Error:
>> The sys_perf_event_open() syscall returned with 19 (No such device) for event (cpu-clock).
>> /bin/dmesg | grep -i perf may provide additional information.
>>
>> This is due to PMU's "cpus" is not updated and still contains offline
>> CPUs and perf will try to open perf event on the offlined CPUs.
>>
>> Make "cpus" attribute only shows online CPUs and introduced a new
>> "supported_cpus" where users can get the range of the CPUs this
>> PMU supported monitoring.
>>
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>> ---
>>  drivers/perf/arm_pmu.c | 24 +++++++++++++++++++++++-
>>  1 file changed, 23 insertions(+), 1 deletion(-)
> 
> Hmm. Is the complexity in the driver really worth it here? CPUs can be
> onlined and offlined after the perf_event_open() syscall has been
> executed, 

Yes. So we have cpuhp callbacks to handle the cpu online/offline
and migrate the perf context.

> so this feels like something userspace should be aware of and
> handle on a best-effort basis anyway.
> 

Looks like it's a convention for a PMU device to provide a "cpus" attribute (for core
PMUs) or "cpumask" attribute (for uncore PMUs) to indicates the CPUs on which the
events can be opened. If no such attributes provided, all online CPUs indicated. Perf
will check this and if user doesn't specify a certian range of CPUs the events will
be opened on all the CPUs PMU indicated.

> Does x86 get away with this because CPU0 is never offlined?
> 

Checked on my x86 server there's no "cpus" or "cpumask" provided so perf will try
to open the events on all the online CPUs if no CPU range specified. But for their
hybrid platform there do have a "cpus" attribute[1] and it'll be updated when CPU
offline[2].

The arm-cspmu also provides a "cpumask" to indicate supported online CPUs and an
"associated_cpus" to indicated the CPUs related to the PMU.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/events/intel/core.c?h=v6.9-rc1#n5931
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/events/intel/core.c?h=v6.9-rc1#n4949

Thanks.



