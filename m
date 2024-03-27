Return-Path: <linux-kernel+bounces-120418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F9488D719
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26E12296EBB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 07:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CABAC28DD3;
	Wed, 27 Mar 2024 07:18:51 +0000 (UTC)
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net (zg8tmja5ljk3lje4ms43mwaa.icoremail.net [209.97.181.73])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C522C190;
	Wed, 27 Mar 2024 07:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.181.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711523931; cv=none; b=FqzJFviFJz4ci13A5GlNLXGrBB5vZp/z6LWy2pH3cfW+fW23ez/6DU/dFcPBXESRWt7Ih0hX41CNYErugSz4PAE/lCMSWAqQLaqaArkY22WubFwX2iMLTb39vIL/tHVtw8+C+zgYSKtbdSSXaObWgyf+vXpqUY39Bgx3hb2x8yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711523931; c=relaxed/simple;
	bh=Lc8RJTziSPVqWQBd4FNmq72R4WiUygStvibwOwIVHSc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=obz1FVadQn4Tb5whC/6eYAfQ35hAznsPg0jYbP35A2S3PEjKzhSfl6ByK+U22UrSG6lhEAuQbIk0kKYF5VdBneX89I+njPtBn5iXpp/0bZGhEZeLxgypTsEzezSTFX1+2NzHD+ozfeqEQrBZx1QIVOchtgfMxw6aNYigeeJKsaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=209.97.181.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwAXHkZAyANmkHcPEA--.19818S2;
	Wed, 27 Mar 2024 15:18:24 +0800 (CST)
Received: from phytium.com.cn (unknown [123.150.8.50])
	by mail (Coremail) with SMTP id AQAAfwAXpvU2yANmWkYAAA--.246S3;
	Wed, 27 Mar 2024 15:18:15 +0800 (CST)
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: dan.j.williams@intel.com,
	jonathan.cameron@huawei.com,
	y-goto@fujitsu.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	qemu-devel@nongnu.org
Subject: RE: Questions about CXL device (type 3 memory) hotplug
Date: Wed, 27 Mar 2024 15:18:12 +0800
Message-Id: <20240327071812.955794-1-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <646c04bbbd96_33fb32944b@dwillia2-xfh.jf.intel.com.notmuch>
References: <646c04bbbd96_33fb32944b@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwAXpvU2yANmWkYAAA--.246S3
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQARAWYDI2QDSwABs6
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxZr47uryDGryrAry5Gr1xZrb_yoWrGF1kpa
	y7Ja43KrykGw1UW3W0qa4kZa4rG3Z5AayUCF9rJw1xu3ZxJF17tF4rtayYqw1agFZ7Wr12
	v3ZYk3Z2g3WkXaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

On Mon, May 22, 2023 at 05:11:39PM -0700, Dan Williams wrote:
> Yasunori Gotou (Fujitsu) wrote:
[...]

Hi, all

There was some confusions about CXL device hotplug when I recently
tried to use Qemu to emulate CXL device hotplug and verify the relevant
functions of kernel.

> > Q1) Can PCIe hotplug driver detect and call CXL driver?

[...]

> 
> Yes.
> 
> The cxl_pci driver (drivers/cxl/pci.c) is just a typical PCI driver as
> far as the PCI hotplug driver is concerned. So add/remove events of a
> CXL card get turned into probe()/remove() events on the driver.
> 

1. Can we divide steps of CXL device hotplug into two parts(PCI hotplug & Memory Hotplug)?

PCI Hotplug: the same as the native PCIe hotplug, including initializing cxl.io,
             assigning PCIe BARs, allocating interrupts, etc. And the cxl_pci driver
                         is responsible for this part.

Memory Hotplug: focusing on enabling CXL memory including discovering and Configuring HDM,
                extracting NUMA info from device, notifying memory management, etc.

> > 
> > Q2) Can QEMU/KVM emulate CXL device hotplug?
> > 
> >    I heard that QEMU/KVM has PCIe device hotplug emulation, but I'm not sure
> >    it can hotplug CXL device.
> 
> It can, but as far as the driver is concerned you can achieve the same
> by:
> 
> echo $devname > /sys/bus/pci/drivers/cxl_pci/unbind
> 
> ...that exercises the same software flows as physical unplug.
>

2. What is the difference between "echo $devname > /sys/bus/pci/drivers/cxl_pci/unbind" and
"(qemu) device_del cxl-mem0" ?

According to the test, I found that "(qemu) device_del cxl-mem0" would directly
unplug the device and cause the interrupts on the cxl root port. It seems like this
operation would not only trigger cxl_pci driver but also pcieport driver.

The kernel dmesg is like below:

(qemu) device_del cxl-mem0
# dmesg
[  699.057907] pcieport 0000:0c:00.0: pciehp: pending interrupts 0x0001 from Slot Status
[  699.058929] pcieport 0000:0c:00.0: pciehp: Slot(0): Button press: will power off in 5 sec
[  699.059986] pcieport 0000:0c:00.0: pciehp: pending interrupts 0x0010 from Slot Status
[  699.060099] pcieport 0000:0c:00.0: pciehp: pciehp_set_indicators: SLOTCTRL 90 write cmd 2c0

Then I also tried "echo $devname > /sys/bus/pci/drivers/cxl_pci/unbind"
to check the behaviour of kernel. The kernel dmesg is like below:

# echo 0000:0d:00.0 > /sys/bus/pci/drivers/cxl_pci/unbind
# dmesg
[70387.978931] cxl_pci 0000:0d:00.0: vgaarb: pci_notify
[70388.021476] cxl_mem mem0: disconnect mem0 from port1
[70388.033099] pci 0000:0d:00.0: vgaarb: pci_notify

It seems like this operation would just unbind the cxl_pci driver from the cxl device.

Is my understanding about these two method correct?

3) Can I just use "ndctl/test/cxl-topology.sh" to test the cxl hotplug functions of kernel?

   IIUC, cxl-topology.sh would utilize cxl_test (tools/testing/cxl) which is for regression
   testing the kernel-user ABI.

PS: My qemu command line:
qemu-system-x86_64 \
-M q35,nvdimm=on,cxl=on \
-m 4G \
-smp 4 \
-object memory-backend-ram,size=2G,id=mem0 \
-numa node,nodeid=0,cpus=0-1,memdev=mem0 \
-object memory-backend-ram,size=2G,id=mem1 \
-numa node,nodeid=1,cpus=2-3,memdev=mem1 \
-object memory-backend-ram,size=256M,id=cxl-mem0 \
-device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
-device cxl-rp,port=0,bus=cxl.1,id=root_port0,chassis=0,slot=0 \
-device cxl-type3,bus=root_port0,volatile-memdev=cxl-mem0,id=cxl-mem0 \
-M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k \
-hda ../disk/ubuntu_x86_test_new.qcow2 \
-nographic \

Qemu version: 8.2.50, the lastest commit of branch cxl-2024-03-05 in "https://gitlab.com/jic23/qemu"
Kernel version: 6.8.0-rc6

Many thanks
Yuquan


