Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4B17FE28C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 23:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbjK2WCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 17:02:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjK2WCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 17:02:35 -0500
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4ECA8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 14:02:39 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1701295358;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=RLAcIG7DrDYypYzsFppXBpqZl05gQ46VwnMNIqYQGr8=;
        b=aySVSQC/qOBzYjj6LL5tP0Osi+QYDtcJ1H12hd9bxLKq7BwReNfr/py8gTgyaDamsUUs+0
        LMhagYO1FPpmM5qbPPHQa7A+jWIKiws8CUobklca2zJeuHA3C7r7XDSbZt8v4WiJg/uGI+
        dXN0ZP9HyayRy3m7oTlHm68Ay3Dy3o0=
From:   Sui Jingfeng <sui.jingfeng@linux.dev>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Christian Gmeiner <christian.gmeiner@gmail.com>,
        dri-devel@lists.freedesktop.org, etnaviv@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: [etnaviv-next v12 0/8] drm/etnaviv: Add PCI(e) device driver wrapper and instances
Date:   Thu, 30 Nov 2023 06:02:23 +0800
Message-Id: <20231129220231.12763-1-sui.jingfeng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is add PCI device driver wrapper, to support the Vivante GC1000
GPU in LS2K1000 and LS7A1000.

The whole serie have been tested on X86-64 and LoongArch platform, only the
kernel space driver are tested, basically normal and run stable!

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

Sui Jingfeng (8):
  drm/etnaviv: Add a helper function to get clocks
  drm/etnaviv: Add constructor and destructor for struct
    etnaviv_drm_private
  drm/etnaviv: Allow bypass component framework
  drm/etnaviv: Support for the vivante GPU core attached on PCI(e)
    device
  drm/etnaviv: Add support for cached coherent caching mode
  drm/etnaviv: Embed struct drm_device in struct etnaviv_drm_private
  drm/etnaviv: Add support for the JingJia Macro and LingJiu PCI(e) GPUs
  drm/etnaviv: Support binding multiple GPU cores with component

 drivers/gpu/drm/etnaviv/Kconfig              |   8 +
 drivers/gpu/drm/etnaviv/Makefile             |   2 +
 drivers/gpu/drm/etnaviv/etnaviv_drv.c        | 189 ++++++++-----
 drivers/gpu/drm/etnaviv/etnaviv_drv.h        |  27 ++
 drivers/gpu/drm/etnaviv/etnaviv_gem.c        |  22 +-
 drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c |   2 +-
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c        | 187 +++++++++----
 drivers/gpu/drm/etnaviv/etnaviv_gpu.h        |  10 +
 drivers/gpu/drm/etnaviv/etnaviv_mmu.c        |   4 +-
 drivers/gpu/drm/etnaviv/etnaviv_pci_drv.c    | 279 +++++++++++++++++++
 drivers/gpu/drm/etnaviv/etnaviv_pci_drv.h    |  37 +++
 include/uapi/drm/etnaviv_drm.h               |   1 +
 12 files changed, 639 insertions(+), 129 deletions(-)
 create mode 100644 drivers/gpu/drm/etnaviv/etnaviv_pci_drv.c
 create mode 100644 drivers/gpu/drm/etnaviv/etnaviv_pci_drv.h


base-commit: 5ce7ae0a6faece18d91ce807026197cface429db
-- 
2.34.1

