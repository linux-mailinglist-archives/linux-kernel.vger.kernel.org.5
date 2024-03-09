Return-Path: <linux-kernel+bounces-97829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4780F877011
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 10:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC10528203A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 09:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D18E381AF;
	Sat,  9 Mar 2024 09:21:39 +0000 (UTC)
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1A837143;
	Sat,  9 Mar 2024 09:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.243.71.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709976098; cv=none; b=cIpPgkFsjtlz8vyV33NuA0JYO560wwi3l1QYGWoui3RpQt49yZK1RvQhSQ0jokSQiYe7Q+S67fNIucLePnzolHcwJ1GVKGzQSLALskI7ZKWabz9lX0fwiqPCQci6H1+Opwj0BDUMFkPKs/XrEtFrriRtPlZVMN3Qy/bYW5Eyv9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709976098; c=relaxed/simple;
	bh=qu1SVhckDWVGJDdfG0lqncAupnFVlU4EWMvXGIuWYIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YOYJaYGWk2WFOnjL+QtTK7aJKjl1ULhYrn0F4JWagUhn3B891pNMxPZLH8jtY1KMgBkBO8ALV7og7TgDoH399Kfi8rEIUyz/JA9pyLezogQN18bIXuxLKQSLqNnkUmxL9C8b0WsqK4XeEadMLOMlmDbVOHigJ3QOq9JOToRlQL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dominikbrodowski.net; spf=pass smtp.mailfrom=dominikbrodowski.net; arc=none smtp.client-ip=136.243.71.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dominikbrodowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dominikbrodowski.net
Received: from shine.dominikbrodowski.net (shine.brodo.linta [10.2.0.112])
	by isilmar-4.linta.de (Postfix) with ESMTPSA id 916AF200307;
	Sat,  9 Mar 2024 09:21:25 +0000 (UTC)
Received: by shine.dominikbrodowski.net (Postfix, from userid 1000)
	id 2A548A006A; Sat,  9 Mar 2024 10:20:08 +0100 (CET)
Date: Sat, 9 Mar 2024 10:20:08 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: "Wu, Wentong" <wentong.wu@intel.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	"Winkler, Tomas" <tomas.winkler@intel.com>,
	"mchehab@kernel.org" <mchehab@kernel.org>,
	"hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: v6.8.0-rc6: mei_ace_probe / mei_vsc_probe: do not call blocking
 ops when !TASK_RUNNING
Message-ID: <ZewpyJ3d7gx3dSvA@shine.dominikbrodowski.net>
References: <Zd9wUv1zSJ59WS8i@shine.dominikbrodowski.net>
 <Zd-BVmoFOiCxA632@kekkonen.localdomain>
 <ZeAwhhW7DSEazs0F@shine.dominikbrodowski.net>
 <ZeAymVVsI-CNj6Pc@kekkonen.localdomain>
 <ZeC2jss4IAM4aPWy@shine.dominikbrodowski.net>
 <MW5PR11MB5787E3A96C8EFF3C9F8BC8908D272@MW5PR11MB5787.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW5PR11MB5787E3A96C8EFF3C9F8BC8908D272@MW5PR11MB5787.namprd11.prod.outlook.com>

Hi Wetong,

Am Fri, Mar 08, 2024 at 11:45:44PM +0000 schrieb Wu, Wentong:
> Did you try master branch (v6.8) without IPU6 driver? There
> should be problems with the IPU6 driver you use as below:
> 
> > intel-ipu6 0000:00:05.0: Found supported sensor OVTI01A0:00
> > intel-ipu6 0000:00:05.0: Connected 1 cameras
> 
> If not, could you please help try it on your side?

Branch master from https://git.linuxtv.org/sailus/media_tree.git/ causes a
WARNING during boot; some extracts from dmesg:


mei_me 0000:00:16.0: enabling device (0000 -> 0002)
mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops)
mei_pxp 0000:00:16.0-fbf6fcf1-96cf-4e2e-a6a6-1bab8cbe36b1: bound 0000:00:02.0 (ops i915_pxp_tee_component_ops)
intel_vsc intel_vsc: silicon stepping version is 0:2
------------[ cut here ]------------
do not call blocking ops when !TASK_RUNNING; state=2 set at [<000000001b97ea26>] prepare_to_wait_event+0x54/0x1a0
WARNING: CPU: 5 PID: 124 at kernel/sched/core.c:10099 __might_sleep+0x59/0x60
Modules linked in:
CPU: 5 PID: 124 Comm: kworker/u24:2 Tainted: G                T  6.8.0-rc2+ #2
Hardware name: Dell Inc. XPS 9315/00KRKP, BIOS 1.1.3 05/11/2022
Workqueue: events_unbound deferred_probe_work_func
RIP: 0010:__might_sleep+0x59/0x60
Code: ee 48 89 df 5b 31 d2 5d e9 24 fd ff ff 48 8b 90 60 15 00 00 48 c7 c7 a8 3e aa 84 c6 05 6f b3 47 03 01 48 89 d1 e8 b7 6c fb ff <0f> 0b eb d1 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffbd3ec1287a98 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffffffff84a07d0f RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000ea5 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
R13: ffffa224892a3028 R14: ffffa22494ac1028 R15: 00000000c1287b00
FS:  0000000000000000(0000) GS:ffffa22bef680000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000557ffdf03148 CR3: 00000002b645c000 CR4: 0000000000f50ef0
PKRU: 55555554
Call Trace:
 <TASK>
 ? __might_sleep+0x59/0x60
 ? __warn+0x80/0x170
 ? __might_sleep+0x59/0x60
 ? report_bug+0x182/0x1b0
 ? handle_bug+0x40/0x80
 ? exc_invalid_op+0x17/0x80
 ? asm_exc_invalid_op+0x1a/0x20
 ? __might_sleep+0x59/0x60
 ? __might_sleep+0x59/0x60
 gpiod_get_value_cansleep+0x19/0x60
 vsc_tp_xfer+0x177/0x570
 ? __pfx_autoremove_wake_function+0x10/0x10
 mei_vsc_write+0xe5/0x1d0
 mei_hbm_cl_flow_control_req+0x84/0xd0
 mei_cl_read_start+0x23b/0x330
 mei_cldev_register_rx_cb+0xf5/0x140
 mei_ace_probe+0x11f/0x390
 ? kernfs_add_one+0x146/0x180
 ? really_probe+0x166/0x300
 really_probe+0x166/0x300
 ? __pfx___device_attach_driver+0x10/0x10
 __driver_probe_device+0x6e/0x120
 driver_probe_device+0x1a/0x90
 __device_attach_driver+0x8e/0xd0
 bus_for_each_drv+0x90/0xf0
 __device_attach+0xac/0x1a0
 ? process_one_work+0x19c/0x500
 bus_probe_device+0x93/0xb0
 ? process_one_work+0x19c/0x500
 deferred_probe_work_func+0x96/0xd0
 process_one_work+0x205/0x500
 worker_thread+0x1dc/0x3e0
 ? __pfx_worker_thread+0x10/0x10
 kthread+0xea/0x120
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x2c/0x50
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1b/0x30
 </TASK>
irq event stamp: 1166879
hardirqs last  enabled at (1166885): [<ffffffff81cb6348>] console_unlock+0x118/0x170
hardirqs last disabled at (1166890): [<ffffffff81cb632d>] console_unlock+0xfd/0x170
softirqs last  enabled at (1166640): [<ffffffff81c1333e>] irq_exit_rcu+0x7e/0xa0
softirqs last disabled at (1166635): [<ffffffff81c1333e>] irq_exit_rcu+0x7e/0xa0
---[ end trace 0000000000000000 ]---
mei intel_vsc-5db76cf6-0a68-4ed6-9b78-0361635e2447: deferred probe pending: (reason unknown)
mei intel_vsc-92335fcf-3203-4472-af93-7b4453ac29da: deferred probe pending: (reason unknown)


Best,
	Dominik

