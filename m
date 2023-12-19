Return-Path: <linux-kernel+bounces-5611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6345818D16
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85B322832E7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E2D20DC7;
	Tue, 19 Dec 2023 16:57:51 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0631C20DE7
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 16:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A2C51FB;
	Tue, 19 Dec 2023 08:58:31 -0800 (PST)
Received: from [10.57.85.119] (unknown [10.57.85.119])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9BD333F738;
	Tue, 19 Dec 2023 08:57:45 -0800 (PST)
Message-ID: <daac75e5-bb80-461f-a77b-939a184d3caa@arm.com>
Date: Tue, 19 Dec 2023 16:57:42 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Could external jtag debugger trap page fault instead of kernel
 handler?
Content-Language: en-GB
To: Hsia-Jun Li <Randy.Li@synaptics.com>, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
 catalin.marinas@arm.com, will@kernel.org, sumit.garg@linaro.org,
 daniel.thompson@linaro.org, liwei391@huawei.com, ayaka <ayaka@soulik.info>
References: <b8ccbd62-7a0d-49eb-bc32-c48e59adeae6@synaptics.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <b8ccbd62-7a0d-49eb-bc32-c48e59adeae6@synaptics.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2023-12-19 7:47 am, Hsia-Jun Li wrote:
> Hello
> 
> I am trying to debug an illegal memory access problem for a kernel 
> driver. The JTAG could trap the kernel function likes 
> die_kernel_fault(). But it won't provide a context environment in the 
> place where this bug happens.
> 
> I know such page fault is more like a software interrupter, is there a 
> way that I could move my debugging context back?

Right, you don't want to be looking at the current running context of 
the exception handler itself, you want to be looking at the exception 
context that's stored in "regs" at this point. I've never used GDB for 
that, but I'd hope it has some command for inspecting a stack at an 
arbitrary address other than the current SP register.

However, if you haven't already, it looks like enabling 
CONFIG_DEBUG_LIST might help catch this particular issue sooner, as 
you've clearly got some LIST_POISON values there.

Robin.

> Here is what I got from gdb connected to openocd.
> (gdb) bt
> #0  __do_kernel_fault (addr=16045481047390945544, addr@entry=264, 
> esr=2516582468, regs=0xffffff802937b940)
>      at 
> /Codebase_s/ranl/workspace/vs680/kernel/linux-syna/arch/arm64/mm/fault.c:372
> #1  0xffffffc00802c174 in do_bad_area (regs=<optimized out>, 
> esr=<optimized out>, far=16045481047390945544)
>      at 
> /Codebase_s/ranl/workspace/vs680/kernel/linux-syna/arch/arm64/mm/fault.c:485
> #2  do_translation_fault (far=16045481047390945544, esr=<optimized out>, 
> regs=<optimized out>)
>      at 
> /Codebase_s/ranl/workspace/vs680/kernel/linux-syna/arch/arm64/mm/fault.c:782
> #3  0xffffffc00802c2cc in do_mem_abort (far=16045481047390945544, 
> esr=2516582468, regs=0xffffff802937b940)
>      at 
> /Codebase_s/ranl/workspace/vs680/kernel/linux-syna/arch/arm64/mm/fault.c:918
> #4  0xffffffc00889738c in skb_dump (level=0xdead000000000108 "", 
> skb=0xffffff802937b940, full_pkt=112)
>      at 
> /Codebase_s/ranl/workspace/vs680/kernel/linux-syna/net/core/skbuff.c:834
> #5  0x0000000000000000 in ?? ()
> Backtrace stopped: not enough registers or memory available to unwind 
> further
> (gdb) info threads
>    Id   Target Id         Frame
>    1    Thread 1 "vs640.cpu_a53.0" (Name: vs640.cpu_a53.0, state: 
> debug-request) 0xffffffc008898038 in nf_l4proto_log_inv
> alid (skb=0xffffffc0086391a0 <psci_enter_idle_state>, state=0xffffffff, 
> protonum=0 '\000', fmt=0x258208 "")
>      at 
> /Codebase_s/ranl/workspace/vs680/kernel/linux-syna/net/netfilter/nf_conntrack_proto.c:62
> * 2    Thread 2 "vs640.cpu_a53.1" (Name: vs640.cpu_a53.1, state: 
> breakpoint)    __do_kernel_fault (
>      addr=16045481047390945544, addr@entry=264, esr=2516582468, 
> regs=0xffffff802937b940)
>      at 
> /Codebase_s/ranl/workspace/vs680/kernel/linux-syna/arch/arm64/mm/fault.c:372
>    3    Thread 3 "vs640.cpu_a53.2" (Name: vs640.cpu_a53.2, state: 
> debug-request) 0xffffffc008898038 in nf_l4proto_log_inv
> alid (skb=0xffffffc0086391a0 <psci_enter_idle_state>, state=0xffffffff, 
> protonum=0 '\000', fmt=0x9f2270 "")
>      at 
> /Codebase_s/ranl/workspace/vs680/kernel/linux-syna/net/netfilter/nf_conntrack_proto.c:62
>    4    Thread 4 "vs640.cpu_a53.3" (Name: vs640.cpu_a53.3, state: 
> debug-request) 0xffffffc008898038 in nf_l4proto_log_inv
> alid (skb=0xffffffc0086391a0 <psci_enter_idle_state>, state=0xffffffff, 
> protonum=0 '\000', fmt=0x20ded8 "")
>      at 
> /Codebase_s/ranl/workspace/vs680/kernel/linux-syna/net/netfilter/nf_conntrack_proto.c:62
> 
> And here is the issue I am trying to debug:
> [ 5478.863161] Unable to handle kernel paging request at virtual address 
> dead000000000108
> [ 5478.871093] Mem abort info:
> [ 5478.873886]   ESR = 0x96000044
> [ 5478.876938]   EC = 0x25: DABT (current EL), IL = 32 bits
> [ 5478.882249]   SET = 0, FnV = 0
> [ 5478.885301]   EA = 0, S1PTW = 0
> [ 5478.888440]   FSC = 0x04: level 0 translation fault
> [ 5478.893318] Data abort info:
> [ 5478.896195]   ISV = 0, ISS = 0x00000044
> [ 5478.900029]   CM = 0, WnR = 1
> [ 5478.902996] [dead000000000108] address between user and kernel 
> address ranges
> [ 5478.910129] Internal error: Oops: 96000044 [#1] PREEMPT SMP
> [ 5478.915701] Modules linked in: vpu videobuf2_memops v4l2_mem2mem 
> videobuf2_v4l2 videobuf2_common videodev mc synap(O)
>   pvrsrvkm syna_drm cfg80211 rfkill amp_bm
> [ 5478.929897] CPU: 0 PID: 6613 Comm: gst-launch-1.0 Tainted: G        W 
>   O      5.15.62 #1
> [ 5478.937988] Hardware name: Synaptics VS640 EVK (DT)
> [ 5478.942864] pstate: 204000c9 (nzCv daIF +PAN -UAO -TCO -DIT -SSBS 
> BTYPE=--)
> [ 5478.949825] pc : v4l2_m2m_buf_remove+0x50/0x90 [v4l2_mem2mem]
> [ 5478.955582] lr : v4l2_m2m_buf_remove+0x20/0x90 [v4l2_mem2mem]
> [ 5478.961329] sp : ffffff8026c4fa90
> [ 5478.964643] x29: ffffff8026c4fa90 x28: ffffff8026c201b0 x27: 
> 0000000000000000
> [ 5478.971784] x26: 0000000000000000 x25: ffffff8026c4fd28 x24: 
> ffffff8009774270
> [ 5478.978921] x23: ffffff8025f4c100 x22: 0000000000000001 x21: 
> ffffff8025e1f3a0
> [ 5478.986059] x20: ffffff8025e6d7b0 x19: ffffff8025e1f028 x18: 
> 0000000000000000
> [ 5478.993197] x17: 0000000000000000 x16: 0000000000000000 x15: 
> 00000055a1955a10
> [ 5479.000335] x14: 0000000000000000 x13: 0000000000000000 x12: 
> 0000000000000000
> [ 5479.007472] x11: 0000000000000000 x10: 0000000000000000 x9 : 
> 0000000000000000
> [ 5479.014609] x8 : 0000000000000000 x7 : 0000000000000000 x6 : 
> 0000000000000005
> [ 5479.021746] x5 : dead000000000100 x4 : dead000000000122 x3 : 
> dead000000000100
> [ 5479.028884] x2 : dead000000000122 x1 : 0000000000000000 x0 : 
> ffffff8025e1f3a0
> [ 5479.036021] Call trace:
> [ 5479.038467]  v4l2_m2m_buf_remove+0x50/0x90 [v4l2_mem2mem]
> [ 5479.043867]  vb2ops_vdec_stop_streaming+0x98/0x160 [vpu]
> [ 5479.049184]  __vb2_queue_cancel+0x30/0x210 [videobuf2_common]
> [ 5479.054936]  vb2_core_streamoff+0x20/0xb4 [videobuf2_common]
> [ 5479.060597]  vb2_streamoff+0x18/0x64 [videobuf2_v4l2]
> [ 5479.065654]  v4l2_m2m_streamoff+0x70/0x140 [v4l2_mem2mem]
> [ 5479.071055]  v4l2_m2m_ioctl_streamoff+0x14/0x20 [v4l2_mem2mem]
> [ 5479.076889]  v4l_streamoff+0x20/0x30 [videodev]
> [ 5479.081455]  __video_do_ioctl+0x174/0x3d0 [videodev]
> 
> Sincerely

