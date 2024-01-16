Return-Path: <linux-kernel+bounces-26939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EEFF82E839
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 04:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9BE2284D4C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 03:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8DB7464;
	Tue, 16 Jan 2024 03:26:58 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15DD6FC8
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 03:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4TDZCF1jR4zvTrP;
	Tue, 16 Jan 2024 11:25:29 +0800 (CST)
Received: from dggpeml500004.china.huawei.com (unknown [7.185.36.140])
	by mail.maildlp.com (Postfix) with ESMTPS id 8349614053B;
	Tue, 16 Jan 2024 11:26:37 +0800 (CST)
Received: from [10.174.186.25] (10.174.186.25) by
 dggpeml500004.china.huawei.com (7.185.36.140) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Jan 2024 11:26:25 +0800
Message-ID: <a481ef04-ddd2-dfc1-41b1-d2ec45c6a3b5@huawei.com>
Date: Tue, 16 Jan 2024 11:26:08 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US
From: "sundongxu (A)" <sundongxu3@huawei.com>
To: <maz@kernel.org>, <oliver.upton@linux.dev>, <yuzenghui@huawei.com>,
	<james.morse@arm.com>, <suzuki.poulose@arm.com>, <will@kernel.org>,
	<catalin.marinas@arm.com>
CC: <wanghaibin.wang@huawei.com>, <kvmarm@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [bug report] GICv4.1: VM performance degradation due to not trapping
 vCPU WFI
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500004.china.huawei.com (7.185.36.140)

Hi Guys,

We found a problem about GICv4/4.1, for example:
We use QEMU to start a VM (4 vCPUs and 8G memory), VM disk was
configured with virtio, and the network is configured with vhost-net,
the CPU affinity of the vCPU and emulator is as follows, in VM xml:

  <cputune>
    <vcpupin vcpu='0' cpuset='4'/>
    <vcpupin vcpu='1' cpuset='5'/>
    <vcpupin vcpu='2' cpuset='6'/>
    <vcpupin vcpu='3' cpuset='7'/>
    <emulatorpin cpuset='4,5,6,7'/>
  </cputune>

Running Mysql in the VM, and sysbench (Mysql benchmark) on the host,
the performance index is tps, the higher the better.
If the host only enabled GICv3, the tps will be around 1400.
If the host enabled GICv4.1, other configurations remain unchanged, the
tps will be around 40.

We found that when the host enabled GICv4.1, because vSGI is directly
injected to VM, and most time vCPU exclusively occupy the pCPU, vCPU
will not trap when executing the WFI instruction. Then from the host
view, the CPU usage of vCPU0~vCPU3 is almost 100%. When running mysql
service in VM, the vhost-net and qemu processes also need to obtain
enough CPU time, but unfortunately these processes cannot get that much
time (for example, only GICv3 enabled, the cpu usage of vhost-net is
about 43%, but with GICv4.1 enabled, it becomes 0~2%). During the test,
it was found that vhost-net sleeps and wakes up very frequently. When
vhost-net wakes up, it often cannot obtain CPU in time (because of
wake-up preemption check). After waking up, vhost-net will usually run
for a short period of time before going to sleep again.

If the host enabled GICv4.1, and force vCPU to trap when executing WFI,
the tps will be around 1400.

On the other hand, when vCPU executes WFI instruction without trapping,
the vcpu wake-up delay will be significantly improved. For example, the
result of running cyclictest in VM:
WFI trap           6us
WFI no trap        2us

Currently, I add a KVM module parameter to control whether the vCPU
traps (by set or clear HCR_TWI) when executing the WFI instruction with
host enabled GICv4/4.1, and by default, vCPU traps are set.

Or, it there a better way?

