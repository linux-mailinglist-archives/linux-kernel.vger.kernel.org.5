Return-Path: <linux-kernel+bounces-55371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 192E484BBD7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF4F2286FEC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13641B67E;
	Tue,  6 Feb 2024 17:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mkPI3ZMR"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4176F6FD7
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 17:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707240498; cv=none; b=MmeeeeDrQxappEztc+kZBFlDDeIb4JsEWdLPpGZJtHsobI4x6/M8zEWo8TuwGhg7saTxOJQLzGkIslzM1sJ/jOqccAzc1JaUxDjEQ5wz10E0Y6Ez/1TW510aZ/iIsoTAMYZd63ueivlHXHUfe7PwVmsNiB6QCzCgoO5RNx1CnKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707240498; c=relaxed/simple;
	bh=j4/bW/bI/ZcA7Qd0wUBY278a5vLp4PS6zp2OrSC2R68=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S0aeCuee7p79Yfod33tYgpQwVB2eNmEKTSnFqQIF2elM0bn4aPezPzwhfI/MiYGfJXlJhohTq6OgDAtskPPF0OXBG1p3ZMxQRhte5AhCCdETQwk2LDY+nKHlOGPNel7vbRrv8Q8GduqwDwbVSIpTTotV2/NePNSWP1UL8DQzu3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mkPI3ZMR; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707240492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=r9uhU/1Yz/BW8+krzY0IV0p01k0UZCjjcXxxC+SD40E=;
	b=mkPI3ZMR2+Ejg3nQwG10cVmFX2ad4xarkRG8WbSPJSmgWd53tJUl7EqvZE5DNXePt8H7HR
	/2xiVkyr2QInskx6V13CHoNGkEuSiCnQfLGT92/Ms8NzGtRqV0RHgn9iVNBXd5KVtURZpS
	xkOc1GIg9rXIAiA7gKzuIi4buS6d1M8=
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Russell King <linux+etnaviv@armlinux.org.uk>,
	Christian Gmeiner <christian.gmeiner@gmail.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org,
	etnaviv@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: [etnaviv-next v13 0/7] drm/etnaviv: Add driver wrapper for vivante GPUs attached on PCI(e) device
Date: Wed,  7 Feb 2024 01:27:52 +0800
Message-Id: <20240206172759.421737-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patch adds PCI driver wrapper on the top of what drm/etnaviv already
have, with the expectation that to keep component framework untoughed and
to preserve code sharing.

drm/etnaviv use the component framework to bind multiple GPU cores to a
virtual master platform device, the virtual master is create during driver
load time. For the PCI(e) device who integrate vivante GPU ip, the process
to going to be reverse. Create virtual platform device as a representation
for the vivante GPU ip core attached on the real PCIe master. The master
already there by the time the driver is loaded, what we need to do is to
devide the big MMIO resource and assign it tp the child. All the virtual
childs are bind to the master with component framework.

v6:
	* Fix build issue on system without CONFIG_PCI enabled
v7:
	* Add a separate patch for the platform driver rearrangement (Bjorn)
	* Switch to runtime check if the GPU is dma coherent or not (Lucas)
	* Add ETNAVIV_PARAM_GPU_COHERENT to allow userspace to query (Lucas)
	* Remove etnaviv_gpu.no_clk member (Lucas)
	* Various Typos and coding style fixed (Bjorn)
v8:
	* Fix typos and remove unnecessary header included (Bjorn).
	* Add a dedicated function to create the virtual master platform
	  device.
v9:
	* Use PCI_VDEVICE() macro (Bjorn)
	* Add trivial stubs for the PCI driver (Bjorn)
	* Remove a redundant dev_err() usage (Bjorn)
	* Clean up etnaviv_pdev_probe() with etnaviv_of_first_available_node()
v10:
	* Add one more cleanup patch
	* Resolve the conflict with a patch from Rob
	* Make the dummy PCI stub inlined
	* Print only if the platform is dma-coherrent
V11:
	* Drop unnecessary changes (Lucas)
	* Tweak according to other reviews of v10.

V12:
	* Create a virtual platform device for the subcomponent GPU cores
	* Bind all subordinate GPU cores to the real PCI master via component.

V13:
	* Drop the non-component code path (side-by-side implement), always
	  use the component framework to bind subcomponent GPU core. Even
	  though this is only one core.
	* Defer the irq handler register.
	* Rebase and improve the commit message

The whole patch series have been tested on X86-64 and LoongArch platform.

Tested with JD9230P GPU, only brief product overview is available[1].

[1] http://www.goldendisk.cn/index.php?s=index/show/index&id=273

$ dmesg | grep etnaviv:

 etnaviv 0000:05:00.0: JingJia Micro JD9230P has 2 GPU cores
 etnaviv 0000:05:00.0: bound etnaviv-gpu,3d.0 (ops gpu_ops [etnaviv])
 etnaviv 0000:05:00.0: bound etnaviv-gpu,3d.1 (ops gpu_ops [etnaviv])
 etnaviv-gpu etnaviv-gpu,3d.0: model: GC9200, revision: 6304
 etnaviv-gpu etnaviv-gpu,3d.1: model: GC9200, revision: 6304
 [drm] Initialized etnaviv 1.3.0 20151214 for 0000:05:00.0 on minor 0

$ cd /sys/kernel/debug/dri/0
$ cat gpu

etnaviv-gpu,3d.0 Status:
	identity
	 model: 0x9200
	 revision: 0x6304
	 product_id: 0x92004
	 customer_id: 0x49
	 eco_id: 0x0
	features
	 major_features: 0xe0287cad
	 minor_features0: 0xc9799eff
	 minor_features1: 0xfefbfadb
	 minor_features2: 0xeb9d6fbf
	 minor_features3: 0xedfffcfd
	 minor_features4: 0xdb0dafc7
	 minor_features5: 0xbb5ac733
	 minor_features6: 0x00000000
	 minor_features7: 0x00000000
	 minor_features8: 0x00000000
	 minor_features9: 0x00000000
	 minor_features10: 0x00000000
	 minor_features11: 0x00000000
	specs
	 stream_count:  16
	 register_max: 64
	 thread_count: 4096
	 vertex_cache_size: 16
	 shader_core_count: 16
	 nn_core_count: 0
	 pixel_pipes: 1
	 vertex_output_buffer_size: 1024
	 buffer_size: 0
	 instruction_count: 256
	 num_constants: 320
	 varyings_count: 16
	axi: 0x00000000
	idle: 0x7fffffff
	DMA seems to be stuck
	 address 0: 0xccd2a7e8
	 address 1: 0xccd2a7e8
	 state 0: 0x00000000
	 state 1: 0x00000000
	 last fetch 64 bit word: 0x08ddbdb6 0x85ec1955

etnaviv-gpu,3d.1 Status:
	identity
	 model: 0x9200
	 revision: 0x6304
	 product_id: 0x92004
	 customer_id: 0x49
	 eco_id: 0x0
	features
	 major_features: 0xe0287cad
	 minor_features0: 0xc9799eff
	 minor_features1: 0xfefbfadb
	 minor_features2: 0xeb9d6fbf
	 minor_features3: 0xedfffcfd
	 minor_features4: 0xdb0dafc7
	 minor_features5: 0xbb5ac733
	 minor_features6: 0x00000000
	 minor_features7: 0x00000000
	 minor_features8: 0x00000000
	 minor_features9: 0x00000000
	 minor_features10: 0x00000000
	 minor_features11: 0x00000000
	specs
	 stream_count:  16
	 register_max: 64
	 thread_count: 4096
	 vertex_cache_size: 16
	 shader_core_count: 16
	 nn_core_count: 0
	 pixel_pipes: 1
	 vertex_output_buffer_size: 1024
	 buffer_size: 0
	 instruction_count: 256
	 num_constants: 320
	 varyings_count: 16
	axi: 0x00000000
	idle: 0x7fffffff
	DMA seems to be stuck
	 address 0: 0x5756fef8
	 address 1: 0x5756fef8
	 state 0: 0x00000000
	 state 1: 0x00000000
	 last fetch 64 bit word: 0x68de88ef 0xcffa3d57

Tested with LingJiu GP102 GPU, only brief product overview is available[2].

[2] http://www.goldendisk.cn/index.php?s=index/show/index&id=3028

$ dmesg | grep etnaviv:

 etnaviv 0000:06:00.0: LingJiu GP102 has 2 GPU cores
 etnaviv 0000:06:00.0: bound etnaviv-gpu,3d.0 (ops gpu_ops [etnaviv])
 etnaviv 0000:06:00.0: bound etnaviv-gpu,2d.0 (ops gpu_ops [etnaviv])
 etnaviv-gpu etnaviv-gpu,3d.0: model: GC860, revision: 4601
 etnaviv-gpu etnaviv-gpu,2d.0: model: GC300, revision: 2000
 [drm] Initialized etnaviv 1.3.0 20151214 for 0000:06:00.0 on minor 0

$ cd /sys/kernel/debug/dri/0
$ cat gpu

etnaviv-gpu,3d.0 Status:
	identity
	 model: 0x860
	 revision: 0x4601
	 product_id: 0x0
	 customer_id: 0x0
	 eco_id: 0x0
	features
	 major_features: 0xe02c2ced
	 minor_features0: 0xcbf99fff
	 minor_features1: 0x00000001
	 minor_features2: 0x00000000
	 minor_features3: 0x00000000
	 minor_features4: 0x00000000
	 minor_features5: 0x00000000
	 minor_features6: 0x00000000
	 minor_features7: 0x00000000
	 minor_features8: 0x00000000
	 minor_features9: 0x00000000
	 minor_features10: 0x00000000
	 minor_features11: 0x00000000
	specs
	 stream_count:  1
	 register_max: 64
	 thread_count: 256
	 vertex_cache_size: 8
	 shader_core_count: 1
	 nn_core_count: 0
	 pixel_pipes: 1
	 vertex_output_buffer_size: 512
	 buffer_size: 0
	 instruction_count: 256
	 num_constants: 168
	 varyings_count: 8
	axi: 0x00000000
	idle: 0x7fffffff
	DMA seems to be stuck
	 address 0: 0x00000000
	 address 1: 0x00000000
	 state 0: 0x00000000
	 state 1: 0x00000000
	 last fetch 64 bit word: 0x00000000 0x00000000

etnaviv-gpu,2d.0 Status:
	identity
	 model: 0x300
	 revision: 0x2000
	 product_id: 0x0
	 customer_id: 0x0
	 eco_id: 0x0
	features
	 major_features: 0xe02c2ee9
	 minor_features0: 0xcbf99fff
	 minor_features1: 0x00000001
	 minor_features2: 0x00000000
	 minor_features3: 0x00000000
	 minor_features4: 0x00000000
	 minor_features5: 0x00000000
	 minor_features6: 0x00000000
	 minor_features7: 0x00000000
	 minor_features8: 0x00000000
	 minor_features9: 0x00000000
	 minor_features10: 0x00000000
	 minor_features11: 0x00000000
	specs
	 stream_count:  1
	 register_max: 64
	 thread_count: 256
	 vertex_cache_size: 8
	 shader_core_count: 1
	 nn_core_count: 0
	 pixel_pipes: 1
	 vertex_output_buffer_size: 512
	 buffer_size: 0
	 instruction_count: 256
	 num_constants: 168
	 varyings_count: 8
	axi: 0x00000000
	idle: 0x7fffffff
	DMA seems to be stuck
	 address 0: 0x00000000
	 address 1: 0x00000000
	 state 0: 0x00000000
	 state 1: 0x00000000
	 last fetch 64 bit word: 0x00000000 0x00000000


Sui Jingfeng (7):
  drm/etnaviv: Add a helper function to get clocks
  drm/etnaviv: Add constructor and destructor for the
    etnaviv_drm_private struct
  drm/etnaviv: Embed struct drm_device in struct etnaviv_drm_private
  drm/etnaviv: Add support for cached coherent caching mode
  drm/etnaviv: Replace the '&pdev->dev' with 'dev'
  drm/etnaviv: Update the implement of etnaviv_create_platform_device()
  drm/etnaviv: Add support for vivante GPU cores attached via PCI(e)

 drivers/gpu/drm/etnaviv/Kconfig              |   8 +
 drivers/gpu/drm/etnaviv/Makefile             |   2 +
 drivers/gpu/drm/etnaviv/etnaviv_drv.c        | 157 ++++++++-----
 drivers/gpu/drm/etnaviv/etnaviv_drv.h        |  24 ++
 drivers/gpu/drm/etnaviv/etnaviv_gem.c        |  22 +-
 drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c |   2 +-
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c        | 146 ++++++++----
 drivers/gpu/drm/etnaviv/etnaviv_gpu.h        |   4 +
 drivers/gpu/drm/etnaviv/etnaviv_mmu.c        |   4 +-
 drivers/gpu/drm/etnaviv/etnaviv_pci_drv.c    | 224 +++++++++++++++++++
 drivers/gpu/drm/etnaviv/etnaviv_pci_drv.h    |  18 ++
 include/uapi/drm/etnaviv_drm.h               |   1 +
 12 files changed, 502 insertions(+), 110 deletions(-)
 create mode 100644 drivers/gpu/drm/etnaviv/etnaviv_pci_drv.c
 create mode 100644 drivers/gpu/drm/etnaviv/etnaviv_pci_drv.h

-- 
2.34.1


