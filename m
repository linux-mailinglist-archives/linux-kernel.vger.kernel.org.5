Return-Path: <linux-kernel+bounces-46636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DFD844240
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FFD52916DF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03D912CD81;
	Wed, 31 Jan 2024 14:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="PHJrsEtX"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEECB1272A1
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 14:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706712623; cv=none; b=TOXg8qrZzz7mdJldvX8V+AXqTdmmWnSsLzcNPzr/fiawn1qtM7rZCwog6k7bncvs1V0vv0KXzzMkq+wU/D9nPS4NnfGb9s6VYoWgS5s9nNS6CmbKxJ044HcIc3asmttzDP3+OM77LgK7n4M35WIPVLhZKLxTmsI5KA1YlerSmq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706712623; c=relaxed/simple;
	bh=nkgyan5LRRzY0GtyCyWAwyMvzfoxhtTb69KUThlaJQU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L9Uh0kBItqtjfgVj2LB/5J+3gdvmuQgAjpZZ5ULzugRY7m9q7Hk+AdypTgVfbIk6/bGz1IbPgldcmF4uk7lYWuGxrJuCisCxNJ3he+RGXWxwg67slIGremnE/8Wub64JBfgq69XY04X7K/7e6hcsD2Tt5bHojTkr/WODXFwP9TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=PHJrsEtX; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40fb0c4bb9fso10062745e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 06:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1706712613; x=1707317413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JL25gfVD+Xh66b0Oiy5suGokKHBCK7lCSd/6cabj4sY=;
        b=PHJrsEtXw/Ldz/5wH3wVuygwmbvBCFZFM+47skoJ7sFNDuZUUJdam6GvwtAAWWyTYZ
         3KriHNxfspYL7lkSR37sEMzDvN011SUCc9I6MPY8MLE7Zi5Vimeiec24L0hN2AdQqe5M
         t8HlxSKLvYhivr8TZZYx4NjY+Xxr5Ybcxtn7a/XXMlwNETNEL5efJnttgTyukEJCQUHL
         Q/9aj1Av/NaKOIlM2Yw4Q9ERLvRyz+Qw+y2NXoT0ALVcQNe+vC5kp3f6oqC4RHKBLTGb
         nVyTrPnItH+gbEXfglPAnPcdkTlEs++kxW0aFdm5DUAVkLD+/lNP3hVgNQuoqGkWWV94
         UNdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706712613; x=1707317413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JL25gfVD+Xh66b0Oiy5suGokKHBCK7lCSd/6cabj4sY=;
        b=cUHjT12RIT/gOZ9lIvQrhKtKyc/HhLfehfYlFswCCcanHW4Jtie69SLd24dQrtAFK1
         vH5RY7IeLfKK2Ki8n5hvMS1IoznBfUMzS/2IIJ1u4qXxUt0ISauU7iezl4Yr1y7HT1pr
         QfgMcJk8NvYoS/OlqeNaddeZnpPD8Lreu5Cd5rOGHy7LN0Me7zOwWJdCuznqEb3r94UF
         oqpBie1KWloaDSwhBscgO48kN8MiIOkktnSjbJ3DXhdjk0DPKDdzsCDV0iBJvO37mzKd
         DTYDpqoS/n89PsN9/h3Q6eWm0NvxPJkgNQZI5y5AUdlNA7O8kgXiJrG5Us1urpRDEIVY
         NCyw==
X-Gm-Message-State: AOJu0YziAKb0gGUz1S4mR/fF6VVM2gJxSmWEC4W+ysxt0HbWwNPAzllA
	i8cw0EblU+n74JUGTEYRViBdzLIyNLTN9l8WDCIsZxmwzf03VcyMz6y9+d64tIGFB/6Hd64XJbo
	X
X-Google-Smtp-Source: AGHT+IFPx5b6xQz3cIkxGadIgDA3Qo8ZZ1Vc77lOPoJl5LFhvjLxaeCCW6NotZEsIQULkRqgROiL/w==
X-Received: by 2002:a05:600c:5487:b0:40e:6193:b1a5 with SMTP id iv7-20020a05600c548700b0040e6193b1a5mr1403691wmb.39.1706712611835;
        Wed, 31 Jan 2024 06:50:11 -0800 (PST)
Received: from raven.blarg.de (p200300dc6f2f5c00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f2f:5c00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ch15-20020a5d5d0f000000b0033905a60689sm13850173wrb.45.2024.01.31.06.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 06:50:11 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH 01/28] include: add missing includes
Date: Wed, 31 Jan 2024 15:49:41 +0100
Message-Id: <20240131145008.1345531-2-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240131145008.1345531-1-max.kellermann@ionos.com>
References: <20240131145008.1345531-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This adds `#include` directives that are necessary, but missing, which
previously went unnnoticed because the missing headers were included
indirectly by other headers somewhere.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 arch/arm64/kernel/cpufeature.c                               | 1 +
 arch/arm64/kernel/cpuinfo.c                                  | 1 +
 arch/arm64/kernel/ftrace.c                                   | 1 +
 arch/arm64/kernel/mte.c                                      | 2 ++
 arch/arm64/kvm/arch_timer.c                                  | 2 ++
 arch/arm64/kvm/hypercalls.c                                  | 1 +
 arch/arm64/kvm/vgic/vgic-mmio-v3.c                           | 1 +
 arch/arm64/kvm/vgic/vgic-mmio.c                              | 1 +
 arch/arm64/kvm/vgic/vgic-v2.c                                | 1 +
 arch/arm64/kvm/vgic/vgic-v3.c                                | 1 +
 arch/arm64/kvm/vgic/vgic-v4.c                                | 1 +
 arch/x86/events/amd/uncore.c                                 | 1 +
 arch/x86/events/intel/uncore.c                               | 1 +
 arch/x86/events/rapl.c                                       | 1 +
 arch/x86/kernel/cpu/intel.c                                  | 1 +
 arch/x86/kernel/cpu/umwait.c                                 | 1 +
 arch/x86/kvm/vmx/nested.c                                    | 1 +
 arch/x86/kvm/xen.c                                           | 1 +
 arch/x86/platform/efi/runtime-map.c                          | 1 +
 block/blk-cgroup.c                                           | 1 +
 block/blk-crypto-sysfs.c                                     | 1 +
 block/blk-ia-ranges.c                                        | 1 +
 block/blk-iocost.c                                           | 1 +
 block/bsg.c                                                  | 1 +
 block/elevator.h                                             | 1 +
 block/holder.c                                               | 1 +
 block/kyber-iosched.c                                        | 1 +
 block/mq-deadline.c                                          | 1 +
 drivers/accel/ivpu/ivpu_pm.c                                 | 1 +
 drivers/acpi/pfr_telemetry.c                                 | 1 +
 drivers/acpi/sbs.c                                           | 1 +
 drivers/ata/pata_parport/pata_parport.c                      | 1 +
 drivers/base/base.h                                          | 5 +++++
 drivers/base/container.c                                     | 1 +
 drivers/base/firmware_loader/builtin/main.c                  | 1 +
 drivers/base/soc.c                                           | 1 +
 drivers/base/swnode.c                                        | 1 +
 drivers/base/topology.c                                      | 2 ++
 drivers/base/transport_class.c                               | 3 +++
 drivers/block/null_blk/main.c                                | 1 +
 drivers/block/virtio_blk.c                                   | 1 +
 drivers/block/xen-blkback/blkback.c                          | 2 ++
 drivers/block/zram/zcomp.c                                   | 1 +
 drivers/bus/mhi/ep/main.c                                    | 1 +
 drivers/char/hw_random/virtio-rng.c                          | 1 +
 drivers/char/ipmi/ipmi_msghandler.c                          | 1 +
 drivers/char/misc.c                                          | 1 +
 drivers/char/ppdev.c                                         | 1 +
 drivers/char/tpm/tpm-chip.c                                  | 1 +
 drivers/clk/qcom/clk-regmap-mux-div.h                        | 1 +
 drivers/clk/qcom/gdsc.c                                      | 1 +
 drivers/clk/samsung/clk-cpu.h                                | 2 ++
 drivers/clk/sunxi-ng/ccu_common.h                            | 1 +
 drivers/cpufreq/apple-soc-cpufreq.c                          | 1 +
 drivers/cpufreq/cpufreq_governor.h                           | 1 +
 drivers/cpufreq/freq_table.c                                 | 1 +
 drivers/cxl/cxl.h                                            | 3 +++
 drivers/cxl/cxlmem.h                                         | 1 +
 drivers/devfreq/event/rockchip-dfi.c                         | 1 +
 drivers/dma-buf/st-dma-fence.c                               | 1 +
 drivers/dma/ioat/sysfs.c                                     | 1 +
 drivers/eisa/eisa-bus.c                                      | 1 +
 drivers/extcon/devres.c                                      | 1 +
 drivers/extcon/extcon.h                                      | 1 +
 drivers/firmware/arm_ffa/bus.c                               | 1 +
 drivers/firmware/arm_scmi/bus.c                              | 1 +
 drivers/firmware/edd.c                                       | 1 +
 drivers/firmware/efi/libstub/efi-stub-helper.c               | 1 +
 drivers/firmware/google/gsmi.c                               | 1 +
 drivers/fpga/dfl.c                                           | 2 ++
 drivers/gpio/gpio-tegra.c                                    | 1 +
 drivers/gpio/gpio-tegra186.c                                 | 1 +
 drivers/gpio/gpio-thunderx.c                                 | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h                      | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                   | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h                       | 3 +++
 drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.c       | 2 ++
 drivers/gpu/drm/i915/i915_perf.c                             | 1 +
 drivers/gpu/drm/i915/i915_perf_types.h                       | 1 +
 drivers/gpu/drm/i915/i915_scatterlist.h                      | 1 +
 drivers/gpu/drm/msm/msm_drv.h                                | 1 +
 drivers/gpu/drm/nouveau/dispnv50/disp.c                      | 1 +
 drivers/gpu/drm/xe/xe_gpu_scheduler.c                        | 2 ++
 drivers/gpu/drm/xe/xe_guc_ct.h                               | 2 ++
 drivers/hid/intel-ish-hid/ishtp/bus.c                        | 1 +
 drivers/hwmon/coretemp.c                                     | 1 +
 drivers/hwmon/nct6775-core.c                                 | 1 +
 drivers/iio/adc/ti-tsc2046.c                                 | 1 +
 drivers/infiniband/hw/hfi1/rc.c                              | 1 +
 drivers/infiniband/hw/qib/qib_file_ops.c                     | 1 +
 drivers/infiniband/hw/usnic/usnic_ib_main.c                  | 1 +
 drivers/infiniband/hw/usnic/usnic_ib_sysfs.c                 | 1 +
 drivers/infiniband/sw/rdmavt/cq.c                            | 1 +
 drivers/infiniband/sw/rdmavt/qp.c                            | 1 +
 drivers/infiniband/ulp/srp/ib_srp.c                          | 1 +
 drivers/iommu/virtio-iommu.c                                 | 1 +
 drivers/mailbox/mailbox.c                                    | 1 +
 drivers/md/bcache/bset.c                                     | 1 +
 drivers/md/bcache/sysfs.h                                    | 2 ++
 drivers/media/cec/core/cec-pin.c                             | 1 +
 drivers/media/pci/pt3/pt3.c                                  | 1 +
 drivers/memory/tegra/tegra234.c                              | 1 +
 drivers/mfd/abx500-core.c                                    | 1 +
 drivers/misc/cardreader/alcor_pci.c                          | 1 +
 drivers/misc/dw-xdata-pcie.c                                 | 1 +
 drivers/misc/lkdtm/heap.c                                    | 1 +
 drivers/misc/mei/bus.c                                       | 1 +
 drivers/misc/mei/client.c                                    | 1 +
 drivers/misc/mei/debugfs.c                                   | 1 +
 drivers/misc/mei/main.c                                      | 1 +
 drivers/misc/pci_endpoint_test.c                             | 1 +
 drivers/misc/vcpu_stall_detector.c                           | 1 +
 drivers/misc/xilinx_sdfec.c                                  | 1 +
 drivers/mtd/mtd_blkdevs.c                                    | 1 +
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c               | 1 +
 drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c               | 2 ++
 drivers/net/can/spi/mcp251xfd/mcp251xfd-rx.c                 | 1 +
 drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c                | 1 +
 drivers/net/ethernet/cortina/gemini.c                        | 1 +
 drivers/net/ethernet/freescale/fec_ptp.c                     | 1 +
 drivers/net/ethernet/hisilicon/hip04_eth.c                   | 1 +
 drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c         | 1 +
 drivers/net/ethernet/ti/am65-cpsw-nuss.c                     | 1 +
 drivers/net/mdio/mdio-mux-meson-gxl.c                        | 1 +
 drivers/net/mdio/mdio-mux-multiplexer.c                      | 1 +
 drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c        | 2 ++
 drivers/net/wireless/virtual/mac80211_hwsim.c                | 1 +
 drivers/net/wwan/iosm/iosm_ipc_imem.c                        | 1 +
 drivers/nvme/host/nvme.h                                     | 1 +
 drivers/nvme/target/fc.c                                     | 1 +
 drivers/nvme/target/nvmet.h                                  | 1 +
 drivers/of/of_numa.c                                         | 1 +
 drivers/pci/controller/vmd.c                                 | 1 +
 drivers/pci/pci.c                                            | 1 +
 drivers/pci/switch/switchtec.c                               | 1 +
 drivers/perf/thunderx2_pmu.c                                 | 1 +
 drivers/platform/chrome/wilco_ec/telemetry.c                 | 1 +
 drivers/platform/x86/amd/pmf/tee-if.c                        | 1 +
 .../platform/x86/dell/dell-wmi-sysman/biosattr-interface.c   | 1 +
 drivers/platform/x86/dell/dell-wmi-sysman/enum-attributes.c  | 2 ++
 drivers/platform/x86/dell/dell-wmi-sysman/int-attributes.c   | 2 ++
 .../platform/x86/dell/dell-wmi-sysman/passobj-attributes.c   | 3 +++
 .../x86/dell/dell-wmi-sysman/passwordattr-interface.c        | 1 +
 .../platform/x86/dell/dell-wmi-sysman/string-attributes.c    | 2 ++
 drivers/platform/x86/dell/dell-wmi-sysman/sysman.c           | 1 +
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c                 | 1 +
 drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c         | 3 +++
 drivers/platform/x86/hp/hp-bioscfg/int-attributes.c          | 3 +++
 drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c   | 2 ++
 drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c    | 3 +++
 drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c       | 2 ++
 drivers/platform/x86/hp/hp-bioscfg/string-attributes.c       | 3 +++
 drivers/platform/x86/hp/hp-bioscfg/surestart-attributes.c    | 2 ++
 drivers/platform/x86/intel/pmt/telemetry.c                   | 1 +
 .../x86/intel/uncore-frequency/uncore-frequency-common.c     | 1 +
 .../x86/intel/uncore-frequency/uncore-frequency-common.h     | 1 +
 drivers/platform/x86/think-lmi.c                             | 1 +
 drivers/platform/x86/wmi.c                                   | 1 +
 drivers/pmdomain/governor.c                                  | 1 +
 drivers/power/reset/ltc2952-poweroff.c                       | 1 +
 drivers/powercap/dtpm.c                                      | 1 +
 drivers/pps/clients/pps-ktimer.c                             | 1 +
 drivers/pps/clients/pps-ldisc.c                              | 1 +
 drivers/pps/clients/pps_parport.c                            | 1 +
 drivers/pps/kapi.c                                           | 1 +
 drivers/pps/pps.c                                            | 1 +
 drivers/rtc/class.c                                          | 1 +
 drivers/rtc/interface.c                                      | 1 +
 drivers/scsi/isci/isci.h                                     | 1 +
 drivers/scsi/lpfc/lpfc_init.c                                | 1 +
 drivers/slimbus/slimbus.h                                    | 1 +
 drivers/soc/nuvoton/wpcm450-soc.c                            | 1 +
 drivers/soundwire/bus.c                                      | 1 +
 drivers/soundwire/intel_auxdevice.c                          | 1 +
 drivers/spi/spi-stm32.c                                      | 1 +
 drivers/staging/fbtft/fb_ssd1351.c                           | 1 +
 drivers/target/target_core_fabric_configfs.c                 | 1 +
 drivers/target/target_core_file.c                            | 1 +
 drivers/thermal/devfreq_cooling.c                            | 1 +
 drivers/thermal/intel/intel_powerclamp.c                     | 1 +
 drivers/thermal/intel/therm_throt.c                          | 1 +
 drivers/tty/rpmsg_tty.c                                      | 1 +
 drivers/tty/serial/8250/8250_bcm7271.c                       | 1 +
 drivers/tty/serial/8250/8250_port.c                          | 1 +
 drivers/tty/serial/imx.c                                     | 1 +
 drivers/tty/serial/serial_base.h                             | 2 ++
 drivers/tty/serial/sh-sci.c                                  | 1 +
 drivers/tty/serial/xilinx_uartps.c                           | 1 +
 drivers/usb/chipidea/otg_fsm.c                               | 1 +
 drivers/usb/dwc2/hcd_queue.c                                 | 1 +
 drivers/usb/gadget/function/f_ncm.c                          | 1 +
 drivers/usb/gadget/udc/max3420_udc.c                         | 1 +
 drivers/usb/typec/class.h                                    | 1 +
 drivers/usb/typec/pd.c                                       | 1 +
 drivers/vfio/group.c                                         | 1 +
 drivers/video/fbdev/omap2/omapfb/dss/dsi.c                   | 1 +
 drivers/video/fbdev/omap2/omapfb/dss/pll.c                   | 1 +
 drivers/virt/coco/tsm.c                                      | 1 +
 fs/aio.c                                                     | 1 +
 fs/bcachefs/chardev.c                                        | 1 +
 fs/bcachefs/fs.c                                             | 1 +
 fs/btrfs/qgroup.c                                            | 1 +
 fs/btrfs/sysfs.c                                             | 1 +
 fs/buffer.c                                                  | 1 +
 fs/ceph/metric.h                                             | 2 ++
 fs/ceph/super.h                                              | 1 +
 fs/configfs/mount.c                                          | 1 +
 fs/crypto/bio.c                                              | 1 +
 fs/debugfs/inode.c                                           | 1 +
 fs/erofs/data.c                                              | 1 +
 fs/erofs/internal.h                                          | 1 +
 fs/erofs/super.c                                             | 1 +
 fs/eventpoll.c                                               | 1 +
 fs/exec.c                                                    | 1 +
 fs/ext4/sysfs.c                                              | 1 +
 fs/f2fs/f2fs.h                                               | 1 +
 fs/gfs2/recovery.c                                           | 1 +
 fs/gfs2/sys.c                                                | 1 +
 fs/hfsplus/wrapper.c                                         | 1 +
 fs/iomap/buffered-io.c                                       | 1 +
 fs/iomap/direct-io.c                                         | 1 +
 fs/namespace.c                                               | 1 +
 fs/nfs/nfs42xattr.c                                          | 1 +
 fs/ntfs3/fsntfs.c                                            | 3 ++-
 fs/ntfs3/super.c                                             | 1 +
 fs/pnode.c                                                   | 1 +
 fs/proc/uptime.c                                             | 1 +
 fs/pstore/inode.c                                            | 1 +
 fs/reiserfs/reiserfs.h                                       | 1 +
 fs/sysctls.c                                                 | 1 +
 fs/sysfs/mount.c                                             | 1 +
 fs/tracefs/inode.c                                           | 1 +
 fs/ubifs/io.c                                                | 1 +
 fs/ubifs/super.c                                             | 1 +
 fs/xfs/xfs_error.c                                           | 1 +
 fs/xfs/xfs_sysfs.c                                           | 1 +
 fs/zonefs/sysfs.c                                            | 1 +
 include/drm/drm_color_mgmt.h                                 | 1 +
 include/drm/drm_modeset_lock.h                               | 1 +
 include/drm/gpu_scheduler.h                                  | 1 +
 include/linux/backing-dev-defs.h                             | 5 +++++
 include/linux/bio.h                                          | 1 +
 include/linux/blk-integrity.h                                | 1 +
 include/linux/blk-mq.h                                       | 1 +
 include/linux/blkdev.h                                       | 2 ++
 include/linux/can/dev.h                                      | 1 +
 include/linux/dev_printk.h                                   | 1 +
 include/linux/device.h                                       | 1 +
 include/linux/device/bus.h                                   | 1 +
 include/linux/device/class.h                                 | 1 +
 include/linux/dmaengine.h                                    | 1 +
 include/linux/dtpm.h                                         | 2 ++
 include/linux/extcon.h                                       | 3 +++
 include/linux/firmware.h                                     | 1 +
 include/linux/flex_proportions.h                             | 1 +
 include/linux/framer/framer-provider.h                       | 1 +
 include/linux/futex.h                                        | 1 +
 include/linux/hisi_acc_qm.h                                  | 1 +
 include/linux/hrtimer.h                                      | 2 ++
 include/linux/iio/iio.h                                      | 1 +
 include/linux/ipc.h                                          | 2 ++
 include/linux/memory_hotplug.h                               | 1 +
 include/linux/mm.h                                           | 3 +++
 include/linux/module.h                                       | 1 +
 include/linux/mtd/blktrans.h                                 | 1 +
 include/linux/ndctl.h                                        | 2 ++
 include/linux/node.h                                         | 2 ++
 include/linux/notifier.h                                     | 1 +
 include/linux/ns_common.h                                    | 1 +
 include/linux/pm.h                                           | 4 ++++
 include/linux/quotaops.h                                     | 1 +
 include/linux/raid_class.h                                   | 2 ++
 include/linux/slab.h                                         | 1 +
 include/linux/socket.h                                       | 2 +-
 include/linux/soundwire/sdw.h                                | 1 +
 include/linux/spi/spi_bitbang.h                              | 2 ++
 include/linux/srcutree.h                                     | 2 ++
 include/linux/stackdepot.h                                   | 1 +
 include/linux/sunrpc/rpc_pipe_fs.h                           | 3 +++
 include/linux/trace_recursion.h                              | 1 +
 include/linux/tty_port.h                                     | 2 +-
 include/linux/u64_stats_sync.h                               | 2 ++
 include/linux/wait_bit.h                                     | 3 +++
 include/linux/writeback.h                                    | 1 +
 include/linux/ww_mutex.h                                     | 1 +
 include/media/media-device.h                                 | 1 +
 include/net/netns/ipv6.h                                     | 4 ++++
 include/net/netns/mctp.h                                     | 1 +
 include/net/netns/xdp.h                                      | 1 +
 include/net/tcp.h                                            | 1 +
 include/sound/core.h                                         | 1 +
 include/sound/util_mem.h                                     | 1 +
 include/trace/events/iommu.h                                 | 3 +--
 include/trace/events/power.h                                 | 1 +
 init/init_task.c                                             | 1 +
 init/main.c                                                  | 1 +
 io_uring/cancel.c                                            | 1 +
 io_uring/io_uring.c                                          | 1 +
 io_uring/timeout.h                                           | 2 ++
 ipc/mq_sysctl.c                                              | 1 +
 ipc/mqueue.c                                                 | 1 +
 ipc/namespace.c                                              | 1 +
 ipc/sem.c                                                    | 1 +
 kernel/bpf/helpers.c                                         | 1 +
 kernel/cpu.c                                                 | 1 +
 kernel/events/core.c                                         | 1 +
 kernel/exit.c                                                | 1 +
 kernel/fork.c                                                | 1 +
 kernel/futex/core.c                                          | 1 +
 kernel/futex/pi.c                                            | 1 +
 kernel/futex/requeue.c                                       | 1 +
 kernel/futex/syscalls.c                                      | 1 +
 kernel/futex/waitwake.c                                      | 1 +
 kernel/livepatch/core.c                                      | 2 ++
 kernel/livepatch/transition.c                                | 1 +
 kernel/locking/rtmutex.c                                     | 1 +
 kernel/locking/rtmutex_common.h                              | 1 +
 kernel/padata.c                                              | 1 +
 kernel/panic.c                                               | 1 +
 kernel/power/energy_model.c                                  | 1 +
 kernel/reboot.c                                              | 1 +
 kernel/signal.c                                              | 1 +
 kernel/smpboot.c                                             | 1 +
 kernel/time/hrtimer.c                                        | 1 +
 kernel/time/namespace.c                                      | 1 +
 kernel/time/posix-timers.c                                   | 1 +
 kernel/time/timer_list.c                                     | 1 +
 kernel/trace/trace_osnoise.c                                 | 1 +
 kernel/tsacct.c                                              | 1 +
 kernel/ucount.c                                              | 1 +
 kernel/user.c                                                | 2 ++
 kernel/watchdog.c                                            | 1 +
 kernel/workqueue.c                                           | 1 +
 lib/cpu_rmap.c                                               | 2 ++
 lib/flex_proportions.c                                       | 2 ++
 lib/group_cpus.c                                             | 1 +
 lib/kobject.c                                                | 2 ++
 lib/lockref.c                                                | 2 ++
 lib/objpool.c                                                | 2 ++
 lib/test_lockup.c                                            | 1 +
 mm/damon/sysfs-common.c                                      | 1 +
 mm/damon/sysfs-schemes.c                                     | 1 +
 mm/damon/sysfs.c                                             | 1 +
 mm/folio-compat.c                                            | 1 +
 mm/khugepaged.c                                              | 1 +
 mm/ksm.c                                                     | 2 ++
 mm/memory-tiers.c                                            | 1 +
 mm/memory_hotplug.c                                          | 1 +
 mm/mempolicy.c                                               | 1 +
 mm/workingset.c                                              | 1 +
 net/can/j1939/bus.c                                          | 2 ++
 net/can/j1939/transport.c                                    | 1 +
 net/ceph/string_table.c                                      | 1 +
 net/sched/act_gate.c                                         | 1 +
 net/xfrm/xfrm_state.c                                        | 1 +
 samples/vfio-mdev/mtty.c                                     | 1 +
 security/integrity/ima/ima_mok.c                             | 1 +
 security/keys/proc.c                                         | 1 +
 sound/soc/intel/avs/avs.h                                    | 1 +
 sound/soc/qcom/qdsp6/q6apm.h                                 | 1 +
 sound/soc/sof/sof-audio.h                                    | 1 +
 361 files changed, 440 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 8d1a634a403e..dc0642d35f5e 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -65,6 +65,7 @@
 #include <linux/bsearch.h>
 #include <linux/cpumask.h>
 #include <linux/crash_dump.h>
+#include <linux/device.h>
 #include <linux/kstrtox.h>
 #include <linux/sort.h>
 #include <linux/stop_machine.h>
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 47043c0d95ec..d30ad1215ab8 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -23,6 +23,7 @@
 #include <linux/seq_file.h>
 #include <linux/sched.h>
 #include <linux/smp.h>
+#include <linux/sysfs.h> // for __ATTR_RO()
 #include <linux/delay.h>
 
 /*
diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
index a650f5e11fc5..f6c271405c12 100644
--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/swab.h>
 #include <linux/uaccess.h>
+#include <linux/ratelimit.h>
 
 #include <asm/cacheflush.h>
 #include <asm/debug-monitors.h>
diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
index a41ef3213e1e..2b8abe086445 100644
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -5,6 +5,7 @@
 
 #include <linux/bitops.h>
 #include <linux/cpu.h>
+#include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/prctl.h>
@@ -13,6 +14,7 @@
 #include <linux/string.h>
 #include <linux/swap.h>
 #include <linux/swapops.h>
+#include <linux/sysfs.h>
 #include <linux/thread_info.h>
 #include <linux/types.h>
 #include <linux/uaccess.h>
diff --git a/arch/arm64/kvm/arch_timer.c b/arch/arm64/kvm/arch_timer.c
index 9dec8c419bf4..a5b47b400dfc 100644
--- a/arch/arm64/kvm/arch_timer.c
+++ b/arch/arm64/kvm/arch_timer.c
@@ -11,6 +11,8 @@
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
 #include <linux/uaccess.h>
+#include <linux/hrtimer.h>
+#include <linux/ratelimit.h>
 
 #include <clocksource/arm_arch_timer.h>
 #include <asm/arch_timer.h>
diff --git a/arch/arm64/kvm/hypercalls.c b/arch/arm64/kvm/hypercalls.c
index 5763d979d8ca..5aa0b3c106fd 100644
--- a/arch/arm64/kvm/hypercalls.c
+++ b/arch/arm64/kvm/hypercalls.c
@@ -3,6 +3,7 @@
 
 #include <linux/arm-smccc.h>
 #include <linux/kvm_host.h>
+#include <linux/ratelimit.h>
 
 #include <asm/kvm_emulate.h>
 
diff --git a/arch/arm64/kvm/vgic/vgic-mmio-v3.c b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
index c15ee1df036a..1dacc5612804 100644
--- a/arch/arm64/kvm/vgic/vgic-mmio-v3.c
+++ b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
@@ -8,6 +8,7 @@
 #include <linux/kvm.h>
 #include <linux/kvm_host.h>
 #include <linux/interrupt.h>
+#include <linux/ratelimit.h>
 #include <kvm/iodev.h>
 #include <kvm/arm_vgic.h>
 
diff --git a/arch/arm64/kvm/vgic/vgic-mmio.c b/arch/arm64/kvm/vgic/vgic-mmio.c
index cf76523a2194..bde2110e140f 100644
--- a/arch/arm64/kvm/vgic/vgic-mmio.c
+++ b/arch/arm64/kvm/vgic/vgic-mmio.c
@@ -9,6 +9,7 @@
 #include <linux/irq.h>
 #include <linux/kvm.h>
 #include <linux/kvm_host.h>
+#include <linux/ratelimit.h>
 #include <kvm/iodev.h>
 #include <kvm/arm_arch_timer.h>
 #include <kvm/arm_vgic.h>
diff --git a/arch/arm64/kvm/vgic/vgic-v2.c b/arch/arm64/kvm/vgic/vgic-v2.c
index 7e9cdb78f7ce..28adaf9ddf34 100644
--- a/arch/arm64/kvm/vgic/vgic-v2.c
+++ b/arch/arm64/kvm/vgic/vgic-v2.c
@@ -6,6 +6,7 @@
 #include <linux/irqchip/arm-gic.h>
 #include <linux/kvm.h>
 #include <linux/kvm_host.h>
+#include <linux/ratelimit.h>
 #include <kvm/arm_vgic.h>
 #include <asm/kvm_mmu.h>
 
diff --git a/arch/arm64/kvm/vgic/vgic-v3.c b/arch/arm64/kvm/vgic/vgic-v3.c
index 9465d3706ab9..dc6b5f5008fb 100644
--- a/arch/arm64/kvm/vgic/vgic-v3.c
+++ b/arch/arm64/kvm/vgic/vgic-v3.c
@@ -6,6 +6,7 @@
 #include <linux/kstrtox.h>
 #include <linux/kvm.h>
 #include <linux/kvm_host.h>
+#include <linux/ratelimit.h>
 #include <kvm/arm_vgic.h>
 #include <asm/kvm_hyp.h>
 #include <asm/kvm_mmu.h>
diff --git a/arch/arm64/kvm/vgic/vgic-v4.c b/arch/arm64/kvm/vgic/vgic-v4.c
index 74a67ad87f29..40ff8cc2b659 100644
--- a/arch/arm64/kvm/vgic/vgic-v4.c
+++ b/arch/arm64/kvm/vgic/vgic-v4.c
@@ -9,6 +9,7 @@
 #include <linux/irqdomain.h>
 #include <linux/kvm_host.h>
 #include <linux/irqchip/arm-gic-v3.h>
+#include <linux/ratelimit.h>
 
 #include "vgic.h"
 
diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 5bf03c575812..5c7af7dcff2c 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -13,6 +13,7 @@
 #include <linux/cpu.h>
 #include <linux/cpumask.h>
 #include <linux/cpufeature.h>
+#include <linux/device.h>
 #include <linux/smp.h>
 
 #include <asm/perf_event.h>
diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 7927c0b832fa..e1f6a2f3840d 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
+#include <linux/hrtimer.h>
 #include <linux/module.h>
 
 #include <asm/cpu_device_id.h>
diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 8d98d468b976..030629d12298 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -55,6 +55,7 @@
 
 #define pr_fmt(fmt) "RAPL PMU: " fmt
 
+#include <linux/hrtimer.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/perf_event.h>
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index a927a8fc9624..7c43587e56a4 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -11,6 +11,7 @@
 #include <linux/thread_info.h>
 #include <linux/init.h>
 #include <linux/uaccess.h>
+#include <linux/ratelimit.h>
 #include <linux/workqueue.h>
 #include <linux/delay.h>
 #include <linux/cpuhotplug.h>
diff --git a/arch/x86/kernel/cpu/umwait.c b/arch/x86/kernel/cpu/umwait.c
index 2293efd6ffa6..39bba722a42b 100644
--- a/arch/x86/kernel/cpu/umwait.c
+++ b/arch/x86/kernel/cpu/umwait.c
@@ -2,6 +2,7 @@
 #include <linux/syscore_ops.h>
 #include <linux/suspend.h>
 #include <linux/cpu.h>
+#include <linux/device.h>
 
 #include <asm/msr.h>
 #include <asm/mwait.h>
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 6329a306856b..035fca6e5ee0 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/hrtimer.h>
 #include <linux/objtool.h>
 #include <linux/percpu.h>
 
diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 4b4e738c6f1b..d2056ae8f34d 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -13,6 +13,7 @@
 #include "lapic.h"
 
 #include <linux/eventfd.h>
+#include <linux/hrtimer.h>
 #include <linux/kvm_host.h>
 #include <linux/sched/stat.h>
 
diff --git a/arch/x86/platform/efi/runtime-map.c b/arch/x86/platform/efi/runtime-map.c
index a6f02cef3ca2..a6c7a3480d1a 100644
--- a/arch/x86/platform/efi/runtime-map.c
+++ b/arch/x86/platform/efi/runtime-map.c
@@ -5,6 +5,7 @@
 
 #include <linux/string.h>
 #include <linux/kernel.h>
+#include <linux/kobject.h>
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/efi.h>
diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index bdbb557feb5a..2e99ac6d0c21 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -29,6 +29,7 @@
 #include <linux/resume_user_mode.h>
 #include <linux/psi.h>
 #include <linux/part_stat.h>
+#include <linux/hrtimer.h>
 #include "blk.h"
 #include "blk-cgroup.h"
 #include "blk-ioprio.h"
diff --git a/block/blk-crypto-sysfs.c b/block/blk-crypto-sysfs.c
index a304434489ba..233d04b9116b 100644
--- a/block/blk-crypto-sysfs.c
+++ b/block/blk-crypto-sysfs.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/blk-crypto-profile.h>
+#include <linux/sysfs.h>
 
 #include "blk-crypto-internal.h"
 
diff --git a/block/blk-ia-ranges.c b/block/blk-ia-ranges.c
index c9eb4241e048..4a6bb87a0143 100644
--- a/block/blk-ia-ranges.c
+++ b/block/blk-ia-ranges.c
@@ -7,6 +7,7 @@
 #include <linux/kernel.h>
 #include <linux/blkdev.h>
 #include <linux/slab.h>
+#include <linux/sysfs.h>
 #include <linux/init.h>
 
 #include "blk.h"
diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 4b0b483a9693..d154161b906a 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -178,6 +178,7 @@
 #include <linux/time64.h>
 #include <linux/parser.h>
 #include <linux/sched/signal.h>
+#include <linux/hrtimer.h>
 #include <asm/local.h>
 #include <asm/local64.h>
 #include "blk-rq-qos.h"
diff --git a/block/bsg.c b/block/bsg.c
index 72157a59b788..9e6635f423a0 100644
--- a/block/bsg.c
+++ b/block/bsg.c
@@ -7,6 +7,7 @@
 #include <linux/file.h>
 #include <linux/blkdev.h>
 #include <linux/cdev.h>
+#include <linux/device.h>
 #include <linux/jiffies.h>
 #include <linux/percpu.h>
 #include <linux/idr.h>
diff --git a/block/elevator.h b/block/elevator.h
index 7ca3d7b6ed82..6c107132d536 100644
--- a/block/elevator.h
+++ b/block/elevator.h
@@ -4,6 +4,7 @@
 
 #include <linux/percpu.h>
 #include <linux/hashtable.h>
+#include <linux/module.h>
 #include "blk-mq.h"
 
 struct io_cq;
diff --git a/block/holder.c b/block/holder.c
index 37d18c13d958..a9affd4757cd 100644
--- a/block/holder.c
+++ b/block/holder.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <linux/blkdev.h>
 #include <linux/slab.h>
+#include <linux/sysfs.h>
 
 struct bd_holder_disk {
 	struct list_head	list;
diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
index 4155594aefc6..68fe2b6c12de 100644
--- a/block/kyber-iosched.c
+++ b/block/kyber-iosched.c
@@ -10,6 +10,7 @@
 #include <linux/blkdev.h>
 #include <linux/module.h>
 #include <linux/sbitmap.h>
+#include <linux/sysfs.h>
 
 #include <trace/events/block.h>
 
diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 1b0de4fc3958..25dee768d2ba 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -15,6 +15,7 @@
 #include <linux/compiler.h>
 #include <linux/rbtree.h>
 #include <linux/sbitmap.h>
+#include <linux/sysfs.h>
 
 #include <trace/events/block.h>
 
diff --git a/drivers/accel/ivpu/ivpu_pm.c b/drivers/accel/ivpu/ivpu_pm.c
index f501f27ebafd..8484f7d3bb4d 100644
--- a/drivers/accel/ivpu/ivpu_pm.c
+++ b/drivers/accel/ivpu/ivpu_pm.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/highmem.h>
+#include <linux/kobject.h>
 #include <linux/moduleparam.h>
 #include <linux/pci.h>
 #include <linux/pm_runtime.h>
diff --git a/drivers/acpi/pfr_telemetry.c b/drivers/acpi/pfr_telemetry.c
index 843f678ade0c..c7d9208e78c0 100644
--- a/drivers/acpi/pfr_telemetry.c
+++ b/drivers/acpi/pfr_telemetry.c
@@ -15,6 +15,7 @@
 #include <linux/errno.h>
 #include <linux/file.h>
 #include <linux/fs.h>
+#include <linux/idr.h>
 #include <linux/miscdevice.h>
 #include <linux/module.h>
 #include <linux/mm.h>
diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index 94e3c000df2e..003faea3ad4d 100644
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/kernel.h>
+#include <linux/kobject.h>
 
 #include <linux/acpi.h>
 #include <linux/timer.h>
diff --git a/drivers/ata/pata_parport/pata_parport.c b/drivers/ata/pata_parport/pata_parport.c
index a7adfdcb5e27..b21ced9e0a3c 100644
--- a/drivers/ata/pata_parport/pata_parport.c
+++ b/drivers/ata/pata_parport/pata_parport.c
@@ -3,6 +3,7 @@
  * Copyright 2023 Ondrej Zary
  * based on paride.c by Grant R. Guenther <grant@torque.net>
  */
+#include <linux/idr.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/parport.h>
diff --git a/drivers/base/base.h b/drivers/base/base.h
index eb4c0ace9242..344e7e4012ab 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -10,7 +10,12 @@
  * shared outside of the drivers/base/ directory.
  *
  */
+
+#include <linux/klist.h>
+#include <linux/kobject.h>
 #include <linux/notifier.h>
+#include <linux/device/bus.h>
+#include <linux/device/driver.h>
 
 /**
  * struct subsys_private - structure to hold the private to the driver core portions of the bus_type/class structure.
diff --git a/drivers/base/container.c b/drivers/base/container.c
index f40588ebc3f5..8ef783dfd76d 100644
--- a/drivers/base/container.c
+++ b/drivers/base/container.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/container.h>
+#include <linux/device.h>
 
 #include "base.h"
 
diff --git a/drivers/base/firmware_loader/builtin/main.c b/drivers/base/firmware_loader/builtin/main.c
index a065c3150897..13bb529ddadf 100644
--- a/drivers/base/firmware_loader/builtin/main.c
+++ b/drivers/base/firmware_loader/builtin/main.c
@@ -2,6 +2,7 @@
 /* Builtin firmware support */
 
 #include <linux/firmware.h>
+#include <linux/string.h> // for memcpy()
 #include "../firmware.h"
 
 /* Only if FW_LOADER=y */
diff --git a/drivers/base/soc.c b/drivers/base/soc.c
index 282c38aece0d..45365cf04fcd 100644
--- a/drivers/base/soc.c
+++ b/drivers/base/soc.c
@@ -13,6 +13,7 @@
 #include <linux/idr.h>
 #include <linux/spinlock.h>
 #include <linux/sys_soc.h>
+#include <linux/device.h>
 #include <linux/err.h>
 #include <linux/glob.h>
 
diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 36512fb75a20..9ee5b270affc 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/device.h>
+#include <linux/idr.h>
 #include <linux/kernel.h>
 #include <linux/property.h>
 #include <linux/slab.h>
diff --git a/drivers/base/topology.c b/drivers/base/topology.c
index 89f98be5c5b9..0526c0ee6640 100644
--- a/drivers/base/topology.c
+++ b/drivers/base/topology.c
@@ -10,8 +10,10 @@
  */
 #include <linux/mm.h>
 #include <linux/cpu.h>
+#include <linux/device.h>
 #include <linux/module.h>
 #include <linux/hardirq.h>
+#include <linux/sysfs.h>
 #include <linux/topology.h>
 
 #define define_id_show_func(name, fmt)					\
diff --git a/drivers/base/transport_class.c b/drivers/base/transport_class.c
index 09ee2a1e35bb..902b2d74cad8 100644
--- a/drivers/base/transport_class.c
+++ b/drivers/base/transport_class.c
@@ -26,9 +26,12 @@
  * transport class is framed entirely in terms of generic devices to
  * allow it to be used by any physical HBA in the system.
  */
+
+#include <linux/device.h>
 #include <linux/export.h>
 #include <linux/attribute_container.h>
 #include <linux/transport_class.h>
+#include <linux/sysfs.h>
 
 static int transport_remove_classdev(struct attribute_container *cont,
 				     struct device *dev,
diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 293f24cc4122..6de94c111f72 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -8,6 +8,7 @@
 #include <linux/moduleparam.h>
 #include <linux/sched.h>
 #include <linux/fs.h>
+#include <linux/idr.h>
 #include <linux/init.h>
 #include "null_blk.h"
 
diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 5bf98fd6a651..64df47bbe6f2 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -3,6 +3,7 @@
 #include <linux/spinlock.h>
 #include <linux/slab.h>
 #include <linux/blkdev.h>
+#include <linux/bvec.h>
 #include <linux/hdreg.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
index 4defd7f387c7..cd4b4819825b 100644
--- a/drivers/block/xen-blkback/blkback.c
+++ b/drivers/block/xen-blkback/blkback.c
@@ -37,11 +37,13 @@
 #define pr_fmt(fmt) "xen-blkback: " fmt
 
 #include <linux/spinlock.h>
+#include <linux/highmem.h>
 #include <linux/kthread.h>
 #include <linux/list.h>
 #include <linux/delay.h>
 #include <linux/freezer.h>
 #include <linux/bitmap.h>
+#include <linux/bio.h>
 
 #include <xen/events.h>
 #include <xen/page.h>
diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index 55af4efd7983..bc1dcf40fd93 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -11,6 +11,7 @@
 #include <linux/sched.h>
 #include <linux/cpu.h>
 #include <linux/crypto.h>
+#include <linux/gfp.h> // for free_pages()
 
 #include "zcomp.h"
 
diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
index 65fc1d738bec..e358d192f0d8 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -9,6 +9,7 @@
 #include <linux/bitfield.h>
 #include <linux/delay.h>
 #include <linux/dma-direction.h>
+#include <linux/idr.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/irq.h>
diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
index 7a4b45393acb..8a1bf80b5259 100644
--- a/drivers/char/hw_random/virtio-rng.c
+++ b/drivers/char/hw_random/virtio-rng.c
@@ -6,6 +6,7 @@
 
 #include <asm/barrier.h>
 #include <linux/err.h>
+#include <linux/idr.h> // for DEFINE_IDA
 #include <linux/hw_random.h>
 #include <linux/scatterlist.h>
 #include <linux/spinlock.h>
diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index b0eedc4595b3..a35d6487867c 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -23,6 +23,7 @@
 #include <linux/spinlock.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
+#include <linux/idr.h> // for DEFINE_IDA
 #include <linux/ipmi.h>
 #include <linux/ipmi_smi.h>
 #include <linux/notifier.h>
diff --git a/drivers/char/misc.c b/drivers/char/misc.c
index 541edc26ec89..d141e0d4dc94 100644
--- a/drivers/char/misc.c
+++ b/drivers/char/misc.c
@@ -45,6 +45,7 @@
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <linux/stat.h>
+#include <linux/idr.h>
 #include <linux/init.h>
 #include <linux/device.h>
 #include <linux/tty.h>
diff --git a/drivers/char/ppdev.c b/drivers/char/ppdev.c
index ee951b265213..cb9546eac6cc 100644
--- a/drivers/char/ppdev.c
+++ b/drivers/char/ppdev.c
@@ -53,6 +53,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/idr.h>
 #include <linux/init.h>
 #include <linux/sched/signal.h>
 #include <linux/device.h>
diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 42b1062e33cd..9fab186d60ef 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -20,6 +20,7 @@
 #include <linux/mutex.h>
 #include <linux/spinlock.h>
 #include <linux/freezer.h>
+#include <linux/idr.h>
 #include <linux/major.h>
 #include <linux/tpm_eventlog.h>
 #include <linux/hw_random.h>
diff --git a/drivers/clk/qcom/clk-regmap-mux-div.h b/drivers/clk/qcom/clk-regmap-mux-div.h
index 4df6c8d24c24..49417def20de 100644
--- a/drivers/clk/qcom/clk-regmap-mux-div.h
+++ b/drivers/clk/qcom/clk-regmap-mux-div.h
@@ -8,6 +8,7 @@
 #define __QCOM_CLK_REGMAP_MUX_DIV_H__
 
 #include <linux/clk-provider.h>
+#include <linux/notifier.h>
 #include "clk-regmap.h"
 
 /**
diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
index 5358e28122ab..8860d7726fdc 100644
--- a/drivers/clk/qcom/gdsc.c
+++ b/drivers/clk/qcom/gdsc.c
@@ -5,6 +5,7 @@
 
 #include <linux/bitops.h>
 #include <linux/delay.h>
+#include <linux/device.h>
 #include <linux/err.h>
 #include <linux/export.h>
 #include <linux/jiffies.h>
diff --git a/drivers/clk/samsung/clk-cpu.h b/drivers/clk/samsung/clk-cpu.h
index 0164bd9ad021..39ddf58a0172 100644
--- a/drivers/clk/samsung/clk-cpu.h
+++ b/drivers/clk/samsung/clk-cpu.h
@@ -10,6 +10,8 @@
 
 #include "clk.h"
 
+#include <linux/notifier.h>
+
 /**
  * struct exynos_cpuclk_cfg_data - config data to setup cpu clocks
  * @prate: frequency of the primary parent clock (in KHz)
diff --git a/drivers/clk/sunxi-ng/ccu_common.h b/drivers/clk/sunxi-ng/ccu_common.h
index 942a72c09437..2edb4a23283c 100644
--- a/drivers/clk/sunxi-ng/ccu_common.h
+++ b/drivers/clk/sunxi-ng/ccu_common.h
@@ -8,6 +8,7 @@
 
 #include <linux/compiler.h>
 #include <linux/clk-provider.h>
+#include <linux/notifier.h>
 
 #define CCU_FEATURE_FRACTIONAL		BIT(0)
 #define CCU_FEATURE_VARIABLE_PREDIV	BIT(1)
diff --git a/drivers/cpufreq/apple-soc-cpufreq.c b/drivers/cpufreq/apple-soc-cpufreq.c
index 021f423705e1..f1bb29fc6182 100644
--- a/drivers/cpufreq/apple-soc-cpufreq.c
+++ b/drivers/cpufreq/apple-soc-cpufreq.c
@@ -13,6 +13,7 @@
 #include <linux/cpufreq.h>
 #include <linux/cpumask.h>
 #include <linux/delay.h>
+#include <linux/device.h>
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
index 168c23fd7fca..e67d33d3acb7 100644
--- a/drivers/cpufreq/cpufreq_governor.h
+++ b/drivers/cpufreq/cpufreq_governor.h
@@ -18,6 +18,7 @@
 #include <linux/irq_work.h>
 #include <linux/cpufreq.h>
 #include <linux/sched/cpufreq.h>
+#include <linux/sysfs.h>
 #include <linux/kernel_stat.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
index c4d4643b6ca6..d5f140c2b95e 100644
--- a/drivers/cpufreq/freq_table.c
+++ b/drivers/cpufreq/freq_table.c
@@ -9,6 +9,7 @@
 
 #include <linux/cpufreq.h>
 #include <linux/module.h>
+#include <linux/sysfs.h>
 
 /*********************************************************************
  *                     FREQUENCY TABLE HELPERS                       *
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index b6017c0c57b4..784bcd943215 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -7,9 +7,12 @@
 #include <linux/libnvdimm.h>
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
+#include <linux/device/driver.h>
 #include <linux/log2.h>
 #include <linux/node.h>
+#include <linux/idr.h>
 #include <linux/io.h>
+#include <linux/range.h>
 
 /**
  * DOC: cxl objects
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 5303d6942b88..25081f2cf5c4 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -7,6 +7,7 @@
 #include <linux/uuid.h>
 #include <linux/rcuwait.h>
 #include <linux/cxl-event.h>
+#include <linux/ioport.h>
 #include <linux/node.h>
 #include "cxl.h"
 
diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
index e2a1e4463b6f..35eeb63180f7 100644
--- a/drivers/devfreq/event/rockchip-dfi.c
+++ b/drivers/devfreq/event/rockchip-dfi.c
@@ -22,6 +22,7 @@
 #include <linux/bitfield.h>
 #include <linux/bits.h>
 #include <linux/perf_event.h>
+#include <linux/hrtimer.h>
 
 #include <soc/rockchip/rockchip_grf.h>
 #include <soc/rockchip/rk3399_grf.h>
diff --git a/drivers/dma-buf/st-dma-fence.c b/drivers/dma-buf/st-dma-fence.c
index b7c6f7ea9e0c..28e5f4cebf5c 100644
--- a/drivers/dma-buf/st-dma-fence.c
+++ b/drivers/dma-buf/st-dma-fence.c
@@ -11,6 +11,7 @@
 #include <linux/sched/signal.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/timer.h>
 
 #include "selftest.h"
 
diff --git a/drivers/dma/ioat/sysfs.c b/drivers/dma/ioat/sysfs.c
index 168adf28c5b1..32a0be07b034 100644
--- a/drivers/dma/ioat/sysfs.c
+++ b/drivers/dma/ioat/sysfs.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/init.h>
+#include <linux/kobject.h>
 #include <linux/module.h>
 #include <linux/dmaengine.h>
 #include <linux/pci.h>
diff --git a/drivers/eisa/eisa-bus.c b/drivers/eisa/eisa-bus.c
index 33f0ba11c6ad..40c5f7cecd6b 100644
--- a/drivers/eisa/eisa-bus.c
+++ b/drivers/eisa/eisa-bus.c
@@ -8,6 +8,7 @@
 #include <linux/kernel.h>
 #include <linux/device.h>
 #include <linux/eisa.h>
+#include <linux/kobject.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/init.h>
diff --git a/drivers/extcon/devres.c b/drivers/extcon/devres.c
index f9d52e8ec5cf..a22c2374fd7a 100644
--- a/drivers/extcon/devres.c
+++ b/drivers/extcon/devres.c
@@ -7,6 +7,7 @@
  */
 
 #include "extcon.h"
+#include <linux/device.h>
 
 static int devm_extcon_dev_match(struct device *dev, void *res, void *data)
 {
diff --git a/drivers/extcon/extcon.h b/drivers/extcon/extcon.h
index 946182687786..b2e0f715d81c 100644
--- a/drivers/extcon/extcon.h
+++ b/drivers/extcon/extcon.h
@@ -2,6 +2,7 @@
 #ifndef __LINUX_EXTCON_INTERNAL_H__
 #define __LINUX_EXTCON_INTERNAL_H__
 
+#include <linux/device.h>
 #include <linux/extcon-provider.h>
 
 /**
diff --git a/drivers/firmware/arm_ffa/bus.c b/drivers/firmware/arm_ffa/bus.c
index 1c7940ba5539..50914dd5afd6 100644
--- a/drivers/firmware/arm_ffa/bus.c
+++ b/drivers/firmware/arm_ffa/bus.c
@@ -8,6 +8,7 @@
 #include <linux/arm_ffa.h>
 #include <linux/device.h>
 #include <linux/fs.h>
+#include <linux/idr.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/slab.h>
diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
index c15928b8c5cc..4e63209e35de 100644
--- a/drivers/firmware/arm_scmi/bus.c
+++ b/drivers/firmware/arm_scmi/bus.c
@@ -8,6 +8,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/atomic.h>
+#include <linux/idr.h>
 #include <linux/types.h>
 #include <linux/module.h>
 #include <linux/of.h>
diff --git a/drivers/firmware/edd.c b/drivers/firmware/edd.c
index 55dec4eb2c00..1971ff720078 100644
--- a/drivers/firmware/edd.c
+++ b/drivers/firmware/edd.c
@@ -20,6 +20,7 @@
  * the list of BIOSs which have been reported to implement EDD.
  */
 
+#include <linux/kobject.h>
 #include <linux/module.h>
 #include <linux/string.h>
 #include <linux/types.h>
diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index bfa30625f5d0..944c69ab4683 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -9,6 +9,7 @@
 
 #include <linux/stdarg.h>
 
+#include <linux/ctype.h>
 #include <linux/efi.h>
 #include <linux/kernel.h>
 #include <asm/efi.h>
diff --git a/drivers/firmware/google/gsmi.c b/drivers/firmware/google/gsmi.c
index 96ea1fa76d35..ef6168516236 100644
--- a/drivers/firmware/google/gsmi.c
+++ b/drivers/firmware/google/gsmi.c
@@ -26,6 +26,7 @@
 #include <linux/uaccess.h>
 #include <linux/dmi.h>
 #include <linux/kdebug.h>
+#include <linux/kobject.h>
 #include <linux/reboot.h>
 #include <linux/efi.h>
 #include <linux/module.h>
diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index e6d12fbab653..ad5b11ac54df 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -12,6 +12,8 @@
  */
 #include <linux/dfl.h>
 #include <linux/fpga-dfl.h>
+#include <linux/idr.h>
+#include <linux/kobject.h>
 #include <linux/module.h>
 #include <linux/overflow.h>
 #include <linux/uaccess.h>
diff --git a/drivers/gpio/gpio-tegra.c b/drivers/gpio/gpio-tegra.c
index ea5f9cc14bc4..c632bd6d1adf 100644
--- a/drivers/gpio/gpio-tegra.c
+++ b/drivers/gpio/gpio-tegra.c
@@ -23,6 +23,7 @@
 #include <linux/irqchip/chained_irq.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/pm.h>
+#include <linux/ratelimit.h>
 
 #define GPIO_BANK(x)		((x) >> 5)
 #define GPIO_PORT(x)		(((x) >> 3) & 0x3)
diff --git a/drivers/gpio/gpio-tegra186.c b/drivers/gpio/gpio-tegra186.c
index d87dd06db40d..02d138cf9e59 100644
--- a/drivers/gpio/gpio-tegra186.c
+++ b/drivers/gpio/gpio-tegra186.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/ratelimit.h>
 #include <linux/seq_file.h>
 
 #include <dt-bindings/gpio/tegra186-gpio.h>
diff --git a/drivers/gpio/gpio-thunderx.c b/drivers/gpio/gpio-thunderx.c
index 8521c6aacace..cd439802a552 100644
--- a/drivers/gpio/gpio-thunderx.c
+++ b/drivers/gpio/gpio-thunderx.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/spinlock.h>
+#include <linux/ratelimit.h>
 
 #define GPIO_RX_DAT	0x0
 #define GPIO_TX_SET	0x8
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
index 85376baaa92f..441cf05fcd6a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
@@ -23,6 +23,7 @@
 #ifndef __AMDGPU_CTX_H__
 #define __AMDGPU_CTX_H__
 
+#include <linux/idr.h>
 #include <linux/ktime.h>
 #include <linux/types.h>
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 6a930c98387f..c195166a923b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -34,6 +34,7 @@
 #include <linux/pci.h>
 #include <linux/pci-p2pdma.h>
 #include <linux/apple-gmux.h>
+#include <linux/ratelimit.h>
 
 #include <drm/drm_aperture.h>
 #include <drm/drm_atomic_helper.h>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
index 508f02eb0cf8..59a5bc9b1120 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
@@ -24,6 +24,9 @@
 #ifndef __AMDGPU_IH_H__
 #define __AMDGPU_IH_H__
 
+#include <linux/types.h>
+#include <linux/wait.h>
+
 /* Maximum number of IVs processed at once */
 #define AMDGPU_IH_MAX_NUM_IVS	32
 
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.c b/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.c
index d8e449e6ebda..28df5859897c 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_color_mgmt.c
@@ -7,6 +7,8 @@
 
 #include "komeda_color_mgmt.h"
 
+#include <linux/array_size.h> // for ARRAY_SIZE()
+
 /* 10bit precision YUV2RGB matrix */
 static const s32 yuv2rgb_bt601_narrow[KOMEDA_N_YUV2RGB_COEFFS] = {
 	1192,    0, 1634,
diff --git a/drivers/gpu/drm/i915/i915_perf.c b/drivers/gpu/drm/i915/i915_perf.c
index 2d695818f006..27f9be67514f 100644
--- a/drivers/gpu/drm/i915/i915_perf.c
+++ b/drivers/gpu/drm/i915/i915_perf.c
@@ -193,6 +193,7 @@
 
 #include <linux/anon_inodes.h>
 #include <linux/nospec.h>
+#include <linux/ratelimit.h>
 #include <linux/sizes.h>
 #include <linux/uuid.h>
 
diff --git a/drivers/gpu/drm/i915/i915_perf_types.h b/drivers/gpu/drm/i915/i915_perf_types.h
index 46445248d193..403caa12cc86 100644
--- a/drivers/gpu/drm/i915/i915_perf_types.h
+++ b/drivers/gpu/drm/i915/i915_perf_types.h
@@ -9,6 +9,7 @@
 #include <linux/atomic.h>
 #include <linux/device.h>
 #include <linux/hrtimer.h>
+#include <linux/kobject.h>
 #include <linux/llist.h>
 #include <linux/poll.h>
 #include <linux/sysfs.h>
diff --git a/drivers/gpu/drm/i915/i915_scatterlist.h b/drivers/gpu/drm/i915/i915_scatterlist.h
index 6cf8a298849f..716e5ab11ce3 100644
--- a/drivers/gpu/drm/i915/i915_scatterlist.h
+++ b/drivers/gpu/drm/i915/i915_scatterlist.h
@@ -7,6 +7,7 @@
 #ifndef I915_SCATTERLIST_H
 #define I915_SCATTERLIST_H
 
+#include <linux/kref.h>
 #include <linux/pfn.h>
 #include <linux/scatterlist.h>
 #include <linux/dma-mapping.h>
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index 16a7cbc0b7dd..e7a2d2c3145a 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -25,6 +25,7 @@
 #include <linux/of_device.h>
 #include <linux/sizes.h>
 #include <linux/kthread.h>
+#include <linux/hrtimer.h>
 
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index 8d37a694b772..0c3d88ad0b0e 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -28,6 +28,7 @@
 #include "wndw.h"
 #include "handles.h"
 
+#include <linux/backlight.h>
 #include <linux/dma-mapping.h>
 #include <linux/hdmi.h>
 #include <linux/component.h>
diff --git a/drivers/gpu/drm/xe/xe_gpu_scheduler.c b/drivers/gpu/drm/xe/xe_gpu_scheduler.c
index e4ad1d6ce1d5..0f263dc0dc19 100644
--- a/drivers/gpu/drm/xe/xe_gpu_scheduler.c
+++ b/drivers/gpu/drm/xe/xe_gpu_scheduler.c
@@ -5,6 +5,8 @@
 
 #include "xe_gpu_scheduler.h"
 
+#include <linux/workqueue.h>
+
 static void xe_sched_process_msg_queue(struct xe_gpu_scheduler *sched)
 {
 	if (!READ_ONCE(sched->base.pause_submit))
diff --git a/drivers/gpu/drm/xe/xe_guc_ct.h b/drivers/gpu/drm/xe/xe_guc_ct.h
index f15f8a4857e0..31b2fbe4c264 100644
--- a/drivers/gpu/drm/xe/xe_guc_ct.h
+++ b/drivers/gpu/drm/xe/xe_guc_ct.h
@@ -8,6 +8,8 @@
 
 #include "xe_guc_ct_types.h"
 
+#include <linux/workqueue.h>
+
 struct drm_printer;
 
 int xe_guc_ct_init(struct xe_guc_ct *ct);
diff --git a/drivers/hid/intel-ish-hid/ishtp/bus.c b/drivers/hid/intel-ish-hid/ishtp/bus.c
index aa6cb033bb06..4ca13f42e44f 100644
--- a/drivers/hid/intel-ish-hid/ishtp/bus.c
+++ b/drivers/hid/intel-ish-hid/ishtp/bus.c
@@ -8,6 +8,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/kobject.h>
 #include <linux/device.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index ba82d1e79c13..457994a41b13 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -10,6 +10,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/module.h>
+#include <linux/idr.h>
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/jiffies.h>
diff --git a/drivers/hwmon/nct6775-core.c b/drivers/hwmon/nct6775-core.c
index 8d2ef3145bca..36f7efa05085 100644
--- a/drivers/hwmon/nct6775-core.c
+++ b/drivers/hwmon/nct6775-core.c
@@ -51,6 +51,7 @@
 #include <linux/err.h>
 #include <linux/mutex.h>
 #include <linux/bitops.h>
+#include <linux/device.h>
 #include <linux/nospec.h>
 #include <linux/regmap.h>
 #include "lm75.h"
diff --git a/drivers/iio/adc/ti-tsc2046.c b/drivers/iio/adc/ti-tsc2046.c
index 1bbb51a6683c..d388673500a1 100644
--- a/drivers/iio/adc/ti-tsc2046.c
+++ b/drivers/iio/adc/ti-tsc2046.c
@@ -11,6 +11,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
 #include <linux/units.h>
+#include <linux/hrtimer.h>
 
 #include <asm/unaligned.h>
 
diff --git a/drivers/infiniband/hw/hfi1/rc.c b/drivers/infiniband/hw/hfi1/rc.c
index b36242c9d42c..d5a94a2d144f 100644
--- a/drivers/infiniband/hw/hfi1/rc.c
+++ b/drivers/infiniband/hw/hfi1/rc.c
@@ -3,6 +3,7 @@
  * Copyright(c) 2015 - 2018 Intel Corporation.
  */
 
+#include <linux/hrtimer.h>
 #include <linux/io.h>
 #include <rdma/rdma_vt.h>
 #include <rdma/rdmavt_qp.h>
diff --git a/drivers/infiniband/hw/qib/qib_file_ops.c b/drivers/infiniband/hw/qib/qib_file_ops.c
index 29e4c59aa23b..dfa4ab446427 100644
--- a/drivers/infiniband/hw/qib/qib_file_ops.c
+++ b/drivers/infiniband/hw/qib/qib_file_ops.c
@@ -40,6 +40,7 @@
 #include <linux/highmem.h>
 #include <linux/io.h>
 #include <linux/jiffies.h>
+#include <linux/kobject.h>
 #include <linux/delay.h>
 #include <linux/export.h>
 #include <linux/uio.h>
diff --git a/drivers/infiniband/hw/usnic/usnic_ib_main.c b/drivers/infiniband/hw/usnic/usnic_ib_main.c
index 13b654ddd3cc..632f2a171f60 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_main.c
+++ b/drivers/infiniband/hw/usnic/usnic_ib_main.c
@@ -39,6 +39,7 @@
  *
  */
 
+#include <linux/kref.h>
 #include <linux/module.h>
 #include <linux/inetdevice.h>
 #include <linux/init.h>
diff --git a/drivers/infiniband/hw/usnic/usnic_ib_sysfs.c b/drivers/infiniband/hw/usnic/usnic_ib_sysfs.c
index fdb63a8fb997..82e761bff7d5 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_sysfs.c
+++ b/drivers/infiniband/hw/usnic/usnic_ib_sysfs.c
@@ -33,6 +33,7 @@
 
 #include <linux/init.h>
 #include <linux/errno.h>
+#include <linux/kref.h>
 
 #include <rdma/ib_user_verbs.h>
 #include <rdma/ib_addr.h>
diff --git a/drivers/infiniband/sw/rdmavt/cq.c b/drivers/infiniband/sw/rdmavt/cq.c
index 82c3f5932249..ba136ac88abc 100644
--- a/drivers/infiniband/sw/rdmavt/cq.c
+++ b/drivers/infiniband/sw/rdmavt/cq.c
@@ -3,6 +3,7 @@
  * Copyright(c) 2016 - 2018 Intel Corporation.
  */
 
+#include <linux/kref.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include "cq.h"
diff --git a/drivers/infiniband/sw/rdmavt/qp.c b/drivers/infiniband/sw/rdmavt/qp.c
index e6203e26cc06..49f74b7c6de8 100644
--- a/drivers/infiniband/sw/rdmavt/qp.c
+++ b/drivers/infiniband/sw/rdmavt/qp.c
@@ -5,6 +5,7 @@
 
 #include <linux/hash.h>
 #include <linux/bitops.h>
+#include <linux/hrtimer.h>
 #include <linux/lockdep.h>
 #include <linux/vmalloc.h>
 #include <linux/slab.h>
diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index 2916e77f589b..8a9b99ad671f 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -39,6 +39,7 @@
 #include <linux/string.h>
 #include <linux/parser.h>
 #include <linux/random.h>
+#include <linux/kobject_ns.h>
 #include <linux/jiffies.h>
 #include <linux/lockdep.h>
 #include <linux/inet.h>
diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 34db37fd9675..6e782f9a29ec 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -10,6 +10,7 @@
 #include <linux/delay.h>
 #include <linux/dma-map-ops.h>
 #include <linux/freezer.h>
+#include <linux/idr.h>
 #include <linux/interval_tree.h>
 #include <linux/iommu.h>
 #include <linux/module.h>
diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index ebff3baf3045..3452fa6784ae 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -18,6 +18,7 @@
 #include <linux/mailbox_client.h>
 #include <linux/mailbox_controller.h>
 #include <linux/of.h>
+#include <linux/hrtimer.h>
 
 #include "mailbox.h"
 
diff --git a/drivers/md/bcache/bset.c b/drivers/md/bcache/bset.c
index 2bba4d6aaaa2..8460b8d543d8 100644
--- a/drivers/md/bcache/bset.c
+++ b/drivers/md/bcache/bset.c
@@ -13,6 +13,7 @@
 
 #include <linux/console.h>
 #include <linux/sched/clock.h>
+#include <linux/mm.h> // for page_address()
 #include <linux/random.h>
 #include <linux/prefetch.h>
 
diff --git a/drivers/md/bcache/sysfs.h b/drivers/md/bcache/sysfs.h
index 65b8bd975ab1..2e06366b7b0b 100644
--- a/drivers/md/bcache/sysfs.h
+++ b/drivers/md/bcache/sysfs.h
@@ -2,6 +2,8 @@
 #ifndef _BCACHE_SYSFS_H_
 #define _BCACHE_SYSFS_H_
 
+#include <linux/sysfs.h>
+
 #define KTYPE(type)							\
 const struct kobj_type type ## _ktype = {					\
 	.release	= type ## _release,				\
diff --git a/drivers/media/cec/core/cec-pin.c b/drivers/media/cec/core/cec-pin.c
index 330d5d5d86ab..262870863e0a 100644
--- a/drivers/media/cec/core/cec-pin.c
+++ b/drivers/media/cec/core/cec-pin.c
@@ -6,6 +6,7 @@
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/sched/types.h>
+#include <linux/hrtimer.h>
 
 #include <media/cec-pin.h>
 #include "cec-pin-priv.h"
diff --git a/drivers/media/pci/pt3/pt3.c b/drivers/media/pci/pt3/pt3.c
index 246f73b8a9e7..e47d8fa88d5e 100644
--- a/drivers/media/pci/pt3/pt3.c
+++ b/drivers/media/pci/pt3/pt3.c
@@ -13,6 +13,7 @@
 #include <linux/pci.h>
 #include <linux/string.h>
 #include <linux/sched/signal.h>
+#include <linux/hrtimer.h>
 
 #include <media/dmxdev.h>
 #include <media/dvbdev.h>
diff --git a/drivers/memory/tegra/tegra234.c b/drivers/memory/tegra/tegra234.c
index abff87f917cb..cf595c6460ed 100644
--- a/drivers/memory/tegra/tegra234.c
+++ b/drivers/memory/tegra/tegra234.c
@@ -6,6 +6,7 @@
 #include <soc/tegra/mc.h>
 
 #include <dt-bindings/memory/tegra234-mc.h>
+#include <linux/device.h>
 #include <linux/interconnect.h>
 #include <linux/tegra-icc.h>
 
diff --git a/drivers/mfd/abx500-core.c b/drivers/mfd/abx500-core.c
index e896531d0354..db2e1706d987 100644
--- a/drivers/mfd/abx500-core.c
+++ b/drivers/mfd/abx500-core.c
@@ -7,6 +7,7 @@
 
 #include <linux/list.h>
 #include <linux/slab.h>
+#include <linux/device.h> // for devm_kzalloc()
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/export.h>
diff --git a/drivers/misc/cardreader/alcor_pci.c b/drivers/misc/cardreader/alcor_pci.c
index 0142c4bf4f42..d10a81756fe9 100644
--- a/drivers/misc/cardreader/alcor_pci.c
+++ b/drivers/misc/cardreader/alcor_pci.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/delay.h>
+#include <linux/idr.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/irq.h>
diff --git a/drivers/misc/dw-xdata-pcie.c b/drivers/misc/dw-xdata-pcie.c
index efd0ca8cc925..fb9b65d7730b 100644
--- a/drivers/misc/dw-xdata-pcie.c
+++ b/drivers/misc/dw-xdata-pcie.c
@@ -9,6 +9,7 @@
 #include <linux/miscdevice.h>
 #include <linux/bitfield.h>
 #include <linux/pci-epf.h>
+#include <linux/idr.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/device.h>
diff --git a/drivers/misc/lkdtm/heap.c b/drivers/misc/lkdtm/heap.c
index b1b316f99703..2ea3574de879 100644
--- a/drivers/misc/lkdtm/heap.c
+++ b/drivers/misc/lkdtm/heap.c
@@ -8,6 +8,7 @@
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/sched.h>
+#include <linux/jiffies.h>
 
 static struct kmem_cache *double_free_cache;
 static struct kmem_cache *a_cache;
diff --git a/drivers/misc/mei/bus.c b/drivers/misc/mei/bus.c
index f9bcff197615..71251ee2ffdc 100644
--- a/drivers/misc/mei/bus.c
+++ b/drivers/misc/mei/bus.c
@@ -7,6 +7,7 @@
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
+#include <linux/kobject.h>
 #include <linux/sched/signal.h>
 #include <linux/init.h>
 #include <linux/errno.h>
diff --git a/drivers/misc/mei/client.c b/drivers/misc/mei/client.c
index 9d090fa07516..e7886e1816da 100644
--- a/drivers/misc/mei/client.c
+++ b/drivers/misc/mei/client.c
@@ -7,6 +7,7 @@
 #include <linux/sched/signal.h>
 #include <linux/wait.h>
 #include <linux/delay.h>
+#include <linux/kref.h>
 #include <linux/slab.h>
 #include <linux/pm_runtime.h>
 #include <linux/dma-mapping.h>
diff --git a/drivers/misc/mei/debugfs.c b/drivers/misc/mei/debugfs.c
index 3b098d4c8e3d..f7a3ea46561a 100644
--- a/drivers/misc/mei/debugfs.c
+++ b/drivers/misc/mei/debugfs.c
@@ -6,6 +6,7 @@
 
 #include <linux/slab.h>
 #include <linux/kernel.h>
+#include <linux/kref.h>
 #include <linux/device.h>
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
diff --git a/drivers/misc/mei/main.c b/drivers/misc/mei/main.c
index 79e6f3c1341f..36707eaf7be0 100644
--- a/drivers/misc/mei/main.c
+++ b/drivers/misc/mei/main.c
@@ -14,6 +14,7 @@
 #include <linux/types.h>
 #include <linux/fcntl.h>
 #include <linux/poll.h>
+#include <linux/idr.h>
 #include <linux/init.h>
 #include <linux/ioctl.h>
 #include <linux/cdev.h>
diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index c38a6083f0a7..fe65f26da400 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -9,6 +9,7 @@
 #include <linux/crc32.h>
 #include <linux/delay.h>
 #include <linux/fs.h>
+#include <linux/idr.h>
 #include <linux/io.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
diff --git a/drivers/misc/vcpu_stall_detector.c b/drivers/misc/vcpu_stall_detector.c
index 6479c962da1a..be69d9c4a993 100644
--- a/drivers/misc/vcpu_stall_detector.c
+++ b/drivers/misc/vcpu_stall_detector.c
@@ -17,6 +17,7 @@
 #include <linux/percpu.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/hrtimer.h>
 
 #define VCPU_STALL_REG_STATUS		(0x00)
 #define VCPU_STALL_REG_LOAD_CNT		(0x04)
diff --git a/drivers/misc/xilinx_sdfec.c b/drivers/misc/xilinx_sdfec.c
index 94a0ee19bf20..03d0abf740c8 100644
--- a/drivers/misc/xilinx_sdfec.c
+++ b/drivers/misc/xilinx_sdfec.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/miscdevice.h>
+#include <linux/idr.h>
 #include <linux/io.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
index f0526dcc2162..7e52f6cd0cc2 100644
--- a/drivers/mtd/mtd_blkdevs.c
+++ b/drivers/mtd/mtd_blkdevs.c
@@ -5,6 +5,7 @@
  * Copyright © 2003-2010 David Woodhouse <dwmw2@infradead.org>
  */
 
+#include <linux/highmem.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/module.h>
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index eebf967f4711..230d14500ae7 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -20,6 +20,7 @@
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
 #include <linux/property.h>
+#include <linux/hrtimer.h>
 
 #include "mcp251xfd.h"
 
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
index bfe4caa0c99d..1182bc8dd529 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
@@ -17,6 +17,8 @@
 #include "mcp251xfd.h"
 #include "mcp251xfd-ram.h"
 
+#include <linux/hrtimer.h>
+
 static inline u8
 mcp251xfd_cmd_prepare_write_reg(const struct mcp251xfd_priv *priv,
 				union mcp251xfd_write_reg_buf *write_reg_buf,
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-rx.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-rx.c
index ced8d9c81f8c..1cfdd6ec3a12 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-rx.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-rx.c
@@ -13,6 +13,7 @@
 //
 
 #include <linux/bitfield.h>
+#include <linux/hrtimer.h>
 
 #include "mcp251xfd.h"
 
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c
index e5bd57b65aaf..75b226a868be 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c
@@ -13,6 +13,7 @@
 //
 
 #include <linux/bitfield.h>
+#include <linux/hrtimer.h>
 
 #include "mcp251xfd.h"
 
diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 705c3eb19cd3..6ae699443a1b 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -36,6 +36,7 @@
 #include <linux/ethtool.h>
 #include <linux/tcp.h>
 #include <linux/u64_stats_sync.h>
+#include <linux/hrtimer.h>
 
 #include <linux/in.h>
 #include <linux/ip.h>
diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ethernet/freescale/fec_ptp.c
index 181d9bfbee22..6f36d1ffbc61 100644
--- a/drivers/net/ethernet/freescale/fec_ptp.c
+++ b/drivers/net/ethernet/freescale/fec_ptp.c
@@ -32,6 +32,7 @@
 #include <linux/of.h>
 #include <linux/of_gpio.h>
 #include <linux/of_net.h>
+#include <linux/hrtimer.h>
 
 #include "fec.h"
 
diff --git a/drivers/net/ethernet/hisilicon/hip04_eth.c b/drivers/net/ethernet/hisilicon/hip04_eth.c
index b91e7a06b97f..4b75a40daa7f 100644
--- a/drivers/net/ethernet/hisilicon/hip04_eth.c
+++ b/drivers/net/ethernet/hisilicon/hip04_eth.c
@@ -15,6 +15,7 @@
 #include <linux/of_net.h>
 #include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
+#include <linux/hrtimer.h>
 
 #define SC_PPE_RESET_DREQ		0x026C
 
diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
index a5e3d1a88305..1c06334a38db 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
@@ -9,6 +9,7 @@
 #include <linux/ipv6.h>
 #include <net/ip6_checksum.h>
 #include <linux/bitfield.h>
+#include <linux/hrtimer.h>
 #include "rmnet_config.h"
 #include "rmnet_map.h"
 #include "rmnet_private.h"
diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 9d2f4ac783e4..45e4d70ad021 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -30,6 +30,7 @@
 #include <linux/sys_soc.h>
 #include <linux/dma/ti-cppi5.h>
 #include <linux/dma/k3-udma-glue.h>
+#include <linux/hrtimer.h>
 #include <net/switchdev.h>
 
 #include "cpsw_ale.h"
diff --git a/drivers/net/mdio/mdio-mux-meson-gxl.c b/drivers/net/mdio/mdio-mux-meson-gxl.c
index 89554021b5cc..b3e680d27e2b 100644
--- a/drivers/net/mdio/mdio-mux-meson-gxl.c
+++ b/drivers/net/mdio/mdio-mux-meson-gxl.c
@@ -9,6 +9,7 @@
 #include <linux/io.h>
 #include <linux/mdio-mux.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 
 #define ETH_REG2		0x0
diff --git a/drivers/net/mdio/mdio-mux-multiplexer.c b/drivers/net/mdio/mdio-mux-multiplexer.c
index 569b13383191..97e307d946a8 100644
--- a/drivers/net/mdio/mdio-mux-multiplexer.c
+++ b/drivers/net/mdio/mdio-mux-multiplexer.c
@@ -6,6 +6,7 @@
 
 #include <linux/mdio-mux.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/mux/consumer.h>
 #include <linux/platform_device.h>
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
index 85a78dea4085..b11bc7ab80a8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
@@ -5,6 +5,8 @@
 
 #include "mt76x02_usb.h"
 
+#include <linux/hrtimer.h>
+
 static void mt76x02u_remove_dma_hdr(struct sk_buff *skb)
 {
 	int hdr_len;
diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index a84340c2075f..914c3b63430f 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -23,6 +23,7 @@
 #include <net/ieee80211_radiotap.h>
 #include <linux/if_arp.h>
 #include <linux/rtnetlink.h>
+#include <linux/hrtimer.h>
 #include <linux/etherdevice.h>
 #include <linux/platform_device.h>
 #include <linux/debugfs.h>
diff --git a/drivers/net/wwan/iosm/iosm_ipc_imem.c b/drivers/net/wwan/iosm/iosm_ipc_imem.c
index 829515a601b3..d11ca25b07bd 100644
--- a/drivers/net/wwan/iosm/iosm_ipc_imem.c
+++ b/drivers/net/wwan/iosm/iosm_ipc_imem.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/delay.h>
+#include <linux/hrtimer.h>
 
 #include "iosm_ipc_chnl_cfg.h"
 #include "iosm_ipc_devlink.h"
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 030c80818240..0256c21a9243 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -13,6 +13,7 @@
 #include <linux/blk-mq.h>
 #include <linux/sed-opal.h>
 #include <linux/fault-inject.h>
+#include <linux/idr.h>
 #include <linux/rcupdate.h>
 #include <linux/wait.h>
 #include <linux/t10-pi.h>
diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index bda7a3009e85..5fcd8e9619f1 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -6,6 +6,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/blk-mq.h>
+#include <linux/idr.h>
 #include <linux/parser.h>
 #include <linux/random.h>
 #include <uapi/scsi/fc/fc_fs.h>
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 6c8acebe1a1a..cd1b2ae40656 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -8,6 +8,7 @@
 
 #include <linux/dma-mapping.h>
 #include <linux/types.h>
+#include <linux/bio.h>
 #include <linux/device.h>
 #include <linux/kref.h>
 #include <linux/percpu-refcount.h>
diff --git a/drivers/of/of_numa.c b/drivers/of/of_numa.c
index 5949829a1b00..9681c4dd5d82 100644
--- a/drivers/of/of_numa.c
+++ b/drivers/of/of_numa.c
@@ -10,6 +10,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/nodemask.h>
+#include <linux/topology.h> // for LOCAL_DISTANCE
 
 #include <asm/numa.h>
 
diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 87b7856f375a..59291addaeb3 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -7,6 +7,7 @@
 #include <linux/device.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/idr.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/msi.h>
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 9ab9b1008d8b..ad0d6194f074 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -24,6 +24,7 @@
 #include <linux/log2.h>
 #include <linux/logic_pio.h>
 #include <linux/pm_wakeup.h>
+#include <linux/idr.h> // for DEFINE_IDA
 #include <linux/interrupt.h>
 #include <linux/device.h>
 #include <linux/pm_runtime.h>
diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index 1804794d0e68..eea031b3f0ef 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -7,6 +7,7 @@
 #include <linux/switchtec.h>
 #include <linux/switchtec_ioctl.h>
 
+#include <linux/idr.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/fs.h>
diff --git a/drivers/perf/thunderx2_pmu.c b/drivers/perf/thunderx2_pmu.c
index 1edb9c03704f..64a06867616d 100644
--- a/drivers/perf/thunderx2_pmu.c
+++ b/drivers/perf/thunderx2_pmu.c
@@ -9,6 +9,7 @@
 #include <linux/cpuhotplug.h>
 #include <linux/perf_event.h>
 #include <linux/platform_device.h>
+#include <linux/hrtimer.h>
 
 /* Each ThunderX2(TX2) Socket has a L3C and DMC UNCORE PMU device.
  * Each UNCORE PMU device consists of 4 independent programmable counters.
diff --git a/drivers/platform/chrome/wilco_ec/telemetry.c b/drivers/platform/chrome/wilco_ec/telemetry.c
index b7c616f3d179..4031fc6dd4ad 100644
--- a/drivers/platform/chrome/wilco_ec/telemetry.c
+++ b/drivers/platform/chrome/wilco_ec/telemetry.c
@@ -30,6 +30,7 @@
 #include <linux/cdev.h>
 #include <linux/device.h>
 #include <linux/fs.h>
+#include <linux/idr.h>
 #include <linux/module.h>
 #include <linux/platform_data/wilco-ec.h>
 #include <linux/platform_device.h>
diff --git a/drivers/platform/x86/amd/pmf/tee-if.c b/drivers/platform/x86/amd/pmf/tee-if.c
index f8c0177afb0d..c74eed457982 100644
--- a/drivers/platform/x86/amd/pmf/tee-if.c
+++ b/drivers/platform/x86/amd/pmf/tee-if.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/debugfs.h>
+#include <linux/kobject.h>
 #include <linux/tee_drv.h>
 #include <linux/uuid.h>
 #include "pmf.h"
diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/biosattr-interface.c b/drivers/platform/x86/dell/dell-wmi-sysman/biosattr-interface.c
index c2dd2de6bc20..3114a7f5b5ee 100644
--- a/drivers/platform/x86/dell/dell-wmi-sysman/biosattr-interface.c
+++ b/drivers/platform/x86/dell/dell-wmi-sysman/biosattr-interface.c
@@ -6,6 +6,7 @@
  *  Copyright (c) 2020 Dell Inc.
  */
 
+#include <linux/kobject.h>
 #include <linux/wmi.h>
 #include "dell-wmi-sysman.h"
 
diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/enum-attributes.c b/drivers/platform/x86/dell/dell-wmi-sysman/enum-attributes.c
index 8cc212c85266..388844b02777 100644
--- a/drivers/platform/x86/dell/dell-wmi-sysman/enum-attributes.c
+++ b/drivers/platform/x86/dell/dell-wmi-sysman/enum-attributes.c
@@ -8,6 +8,8 @@
 
 #include "dell-wmi-sysman.h"
 
+#include <linux/kobject.h>
+
 get_instance_id(enumeration);
 
 static ssize_t current_value_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/int-attributes.c b/drivers/platform/x86/dell/dell-wmi-sysman/int-attributes.c
index 951e75b538fa..3adb2e17d786 100644
--- a/drivers/platform/x86/dell/dell-wmi-sysman/int-attributes.c
+++ b/drivers/platform/x86/dell/dell-wmi-sysman/int-attributes.c
@@ -8,6 +8,8 @@
 
 #include "dell-wmi-sysman.h"
 
+#include <linux/kobject.h>
+
 enum int_properties {MIN_VALUE = 6, MAX_VALUE, SCALAR_INCR};
 
 get_instance_id(integer);
diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/passobj-attributes.c b/drivers/platform/x86/dell/dell-wmi-sysman/passobj-attributes.c
index 230e6ee96636..1b2dfc8abbaa 100644
--- a/drivers/platform/x86/dell/dell-wmi-sysman/passobj-attributes.c
+++ b/drivers/platform/x86/dell/dell-wmi-sysman/passobj-attributes.c
@@ -8,6 +8,9 @@
 
 #include "dell-wmi-sysman.h"
 
+#include <linux/kobject.h>
+#include <linux/sysfs.h>
+
 enum po_properties {IS_PASS_SET = 1, MIN_PASS_LEN, MAX_PASS_LEN};
 
 get_instance_id(po);
diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/passwordattr-interface.c b/drivers/platform/x86/dell/dell-wmi-sysman/passwordattr-interface.c
index 86ec962aace9..c6ea8dbbded3 100644
--- a/drivers/platform/x86/dell/dell-wmi-sysman/passwordattr-interface.c
+++ b/drivers/platform/x86/dell/dell-wmi-sysman/passwordattr-interface.c
@@ -5,6 +5,7 @@
  *  Copyright (c) 2020 Dell Inc.
  */
 
+#include <linux/kobject.h>
 #include <linux/wmi.h>
 #include "dell-wmi-sysman.h"
 
diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/string-attributes.c b/drivers/platform/x86/dell/dell-wmi-sysman/string-attributes.c
index c392f0ecf8b5..a331f9433db5 100644
--- a/drivers/platform/x86/dell/dell-wmi-sysman/string-attributes.c
+++ b/drivers/platform/x86/dell/dell-wmi-sysman/string-attributes.c
@@ -8,6 +8,8 @@
 
 #include "dell-wmi-sysman.h"
 
+#include <linux/kobject.h>
+
 enum string_properties {MIN_LEN = 6, MAX_LEN};
 
 get_instance_id(str);
diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
index b929b4f82420..02041b2dd7fa 100644
--- a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
+++ b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
@@ -11,6 +11,7 @@
 #include <linux/dmi.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
+#include <linux/kobject.h>
 #include <linux/wmi.h>
 #include "dell-wmi-sysman.h"
 #include "../../firmware_attributes_class.h"
diff --git a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
index 8c9f4f3227fc..c5c73c8aac9f 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
@@ -10,6 +10,7 @@
 #include <linux/fs.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
+#include <linux/kobject.h>
 #include <linux/wmi.h>
 #include "bioscfg.h"
 #include "../../firmware_attributes_class.h"
diff --git a/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
index a2402d31c146..b6288aec7b1d 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
@@ -8,6 +8,9 @@
 
 #include "bioscfg.h"
 
+#include <linux/kobject.h>
+#include <linux/sysfs.h>
+
 GET_INSTANCE_ID(enumeration);
 
 static ssize_t current_value_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
diff --git a/drivers/platform/x86/hp/hp-bioscfg/int-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/int-attributes.c
index 86b7ac63fec2..5aa009b396d7 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/int-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/int-attributes.c
@@ -8,6 +8,9 @@
 
 #include "bioscfg.h"
 
+#include <linux/kobject.h>
+#include <linux/sysfs.h>
+
 GET_INSTANCE_ID(integer);
 
 static ssize_t current_value_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
diff --git a/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
index 1ff09dfb7d7e..e8b8ccc1cf7c 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
@@ -8,6 +8,8 @@
 
 #include "bioscfg.h"
 
+#include <linux/kobject.h>
+
 GET_INSTANCE_ID(ordered_list);
 
 static ssize_t current_value_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
diff --git a/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
index f7efe217a4bb..2e05200eb595 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
@@ -8,6 +8,9 @@
 
 #include "bioscfg.h"
 
+#include <linux/kobject.h>
+#include <linux/sysfs.h>
+
 GET_INSTANCE_ID(password);
 /*
  * Clear all passwords copied to memory for a particular
diff --git a/drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c
index 86f90238750c..0ace0adaabf0 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c
@@ -8,6 +8,8 @@
 
 #include "bioscfg.h"
 
+#include <linux/kobject.h>
+
 static const char * const spm_state_types[] = {
 	"not provisioned",
 	"provisioned",
diff --git a/drivers/platform/x86/hp/hp-bioscfg/string-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/string-attributes.c
index f0c20070094d..038e6e9deddf 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/string-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/string-attributes.c
@@ -8,6 +8,9 @@
 
 #include "bioscfg.h"
 
+#include <linux/kobject.h>
+#include <linux/sysfs.h>
+
 #define WMI_STRING_TYPE "HPBIOS_BIOSString"
 
 GET_INSTANCE_ID(string);
diff --git a/drivers/platform/x86/hp/hp-bioscfg/surestart-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/surestart-attributes.c
index b57e42f29282..3195365be1de 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/surestart-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/surestart-attributes.c
@@ -7,6 +7,8 @@
  */
 
 #include "bioscfg.h"
+
+#include <linux/kobject.h>
 #include <linux/types.h>
 
 /* Maximum number of log entries supported when log entry size is 16
diff --git a/drivers/platform/x86/intel/pmt/telemetry.c b/drivers/platform/x86/intel/pmt/telemetry.c
index 09258564dfc4..4c16360ed2af 100644
--- a/drivers/platform/x86/intel/pmt/telemetry.c
+++ b/drivers/platform/x86/intel/pmt/telemetry.c
@@ -10,6 +10,7 @@
 
 #include <linux/auxiliary_bus.h>
 #include <linux/kernel.h>
+#include <linux/kref.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
index 33bb58dc3f78..e9f18a868911 100644
--- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
+++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
@@ -6,6 +6,7 @@
  *
  */
 #include <linux/cpu.h>
+#include <linux/idr.h>
 #include <linux/module.h>
 #include "uncore-frequency-common.h"
 
diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.h b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.h
index 0e5bf507e555..fe37efcf0801 100644
--- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.h
+++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.h
@@ -10,6 +10,7 @@
 #define __INTEL_UNCORE_FREQ_COMMON_H
 
 #include <linux/device.h>
+#include <linux/kobject.h>
 
 /**
  * struct uncore_data - Encapsulate all uncore data
diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
index 3a396b763c49..77c35f1b0a81 100644
--- a/drivers/platform/x86/think-lmi.c
+++ b/drivers/platform/x86/think-lmi.c
@@ -14,6 +14,7 @@
 #include <linux/acpi.h>
 #include <linux/errno.h>
 #include <linux/fs.h>
+#include <linux/kobject.h>
 #include <linux/mutex.h>
 #include <linux/string_helpers.h>
 #include <linux/types.h>
diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 885a16bc059e..b87f397730b9 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -22,6 +22,7 @@
 #include <linux/device.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/kobject.h>
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
diff --git a/drivers/pmdomain/governor.c b/drivers/pmdomain/governor.c
index d1a10eeebd16..8e37c65f5084 100644
--- a/drivers/pmdomain/governor.c
+++ b/drivers/pmdomain/governor.c
@@ -10,6 +10,7 @@
 #include <linux/hrtimer.h>
 #include <linux/cpuidle.h>
 #include <linux/cpumask.h>
+#include <linux/device.h>
 #include <linux/ktime.h>
 
 static int dev_update_qos_constraint(struct device *dev, void *data)
diff --git a/drivers/power/reset/ltc2952-poweroff.c b/drivers/power/reset/ltc2952-poweroff.c
index fa25fbd53934..f94401ed1539 100644
--- a/drivers/power/reset/ltc2952-poweroff.c
+++ b/drivers/power/reset/ltc2952-poweroff.c
@@ -57,6 +57,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/reboot.h>
 #include <linux/property.h>
+#include <linux/hrtimer.h>
 
 struct ltc2952_poweroff {
 	struct hrtimer timer_trigger;
diff --git a/drivers/powercap/dtpm.c b/drivers/powercap/dtpm.c
index ce920f17f45f..bd8127edd8a8 100644
--- a/drivers/powercap/dtpm.c
+++ b/drivers/powercap/dtpm.c
@@ -18,6 +18,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/dtpm.h>
+#include <linux/export.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/powercap.h>
diff --git a/drivers/pps/clients/pps-ktimer.c b/drivers/pps/clients/pps-ktimer.c
index d33106bd7a29..7bb83872bb87 100644
--- a/drivers/pps/clients/pps-ktimer.c
+++ b/drivers/pps/clients/pps-ktimer.c
@@ -7,6 +7,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
diff --git a/drivers/pps/clients/pps-ldisc.c b/drivers/pps/clients/pps-ldisc.c
index 443d6bae19d1..4c2bd74399bc 100644
--- a/drivers/pps/clients/pps-ldisc.c
+++ b/drivers/pps/clients/pps-ldisc.c
@@ -7,6 +7,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/device.h>
 #include <linux/module.h>
 #include <linux/serial_core.h>
 #include <linux/tty.h>
diff --git a/drivers/pps/clients/pps_parport.c b/drivers/pps/clients/pps_parport.c
index 42f93d4c6ee3..9f9389158042 100644
--- a/drivers/pps/clients/pps_parport.c
+++ b/drivers/pps/clients/pps_parport.c
@@ -15,6 +15,7 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/idr.h>
 #include <linux/init.h>
 #include <linux/irqnr.h>
 #include <linux/time.h>
diff --git a/drivers/pps/kapi.c b/drivers/pps/kapi.c
index d9d566f70ed1..1df337bf5e7b 100644
--- a/drivers/pps/kapi.c
+++ b/drivers/pps/kapi.c
@@ -7,6 +7,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
diff --git a/drivers/pps/pps.c b/drivers/pps/pps.c
index 5d19baae6a38..a689fd42ccaa 100644
--- a/drivers/pps/pps.c
+++ b/drivers/pps/pps.c
@@ -15,6 +15,7 @@
 #include <linux/idr.h>
 #include <linux/mutex.h>
 #include <linux/cdev.h>
+#include <linux/device.h>
 #include <linux/poll.h>
 #include <linux/pps_kernel.h>
 #include <linux/slab.h>
diff --git a/drivers/rtc/class.c b/drivers/rtc/class.c
index 921ee1827974..0a4853d45ec0 100644
--- a/drivers/rtc/class.c
+++ b/drivers/rtc/class.c
@@ -14,6 +14,7 @@
 #include <linux/of.h>
 #include <linux/rtc.h>
 #include <linux/kdev_t.h>
+#include <linux/hrtimer.h>
 #include <linux/idr.h>
 #include <linux/slab.h>
 #include <linux/workqueue.h>
diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
index 1b63111cdda2..58f7d3a19dfe 100644
--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/rtc.h>
+#include <linux/hrtimer.h>
 #include <linux/sched.h>
 #include <linux/module.h>
 #include <linux/log2.h>
diff --git a/drivers/scsi/isci/isci.h b/drivers/scsi/isci/isci.h
index 4e6b1decbca7..4b9d92bff598 100644
--- a/drivers/scsi/isci/isci.h
+++ b/drivers/scsi/isci/isci.h
@@ -57,6 +57,7 @@
 #define __ISCI_H__
 
 #include <linux/interrupt.h>
+#include <linux/timer.h>
 #include <linux/types.h>
 
 #define DRV_NAME "isci"
diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 70bcee64bc8c..ee966d95b470 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -41,6 +41,7 @@
 #include <linux/crash_dump.h>
 #include <linux/cpu.h>
 #include <linux/cpuhotplug.h>
+#include <linux/hrtimer.h>
 
 #include <scsi/scsi.h>
 #include <scsi/scsi_device.h>
diff --git a/drivers/slimbus/slimbus.h b/drivers/slimbus/slimbus.h
index 00a7f112574b..29e9229a683c 100644
--- a/drivers/slimbus/slimbus.h
+++ b/drivers/slimbus/slimbus.h
@@ -7,6 +7,7 @@
 #define _DRIVERS_SLIMBUS_H
 #include <linux/module.h>
 #include <linux/device.h>
+#include <linux/idr.h>
 #include <linux/mutex.h>
 #include <linux/completion.h>
 #include <linux/slimbus.h>
diff --git a/drivers/soc/nuvoton/wpcm450-soc.c b/drivers/soc/nuvoton/wpcm450-soc.c
index c5e0d11c383b..d4a0cd4b406d 100644
--- a/drivers/soc/nuvoton/wpcm450-soc.c
+++ b/drivers/soc/nuvoton/wpcm450-soc.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/mfd/syscon.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index f3fec15c3112..4165f8b52804 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -3,6 +3,7 @@
 
 #include <linux/acpi.h>
 #include <linux/delay.h>
+#include <linux/idr.h>
 #include <linux/mod_devicetable.h>
 #include <linux/pm_runtime.h>
 #include <linux/soundwire/sdw_registers.h>
diff --git a/drivers/soundwire/intel_auxdevice.c b/drivers/soundwire/intel_auxdevice.c
index 93698532deac..724e9ed2f537 100644
--- a/drivers/soundwire/intel_auxdevice.c
+++ b/drivers/soundwire/intel_auxdevice.c
@@ -9,6 +9,7 @@
 #include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/module.h>
+#include <linux/idr.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/auxiliary_bus.h>
diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index e61302ef3c21..aeb009a79ba6 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -17,6 +17,7 @@
 #include <linux/platform_device.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/pm_runtime.h>
+#include <linux/ratelimit.h>
 #include <linux/reset.h>
 #include <linux/spi/spi.h>
 
diff --git a/drivers/staging/fbtft/fb_ssd1351.c b/drivers/staging/fbtft/fb_ssd1351.c
index b8d55aa8c5c7..ca4145ee1f67 100644
--- a/drivers/staging/fbtft/fb_ssd1351.c
+++ b/drivers/staging/fbtft/fb_ssd1351.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/backlight.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
diff --git a/drivers/target/target_core_fabric_configfs.c b/drivers/target/target_core_fabric_configfs.c
index 7156a4dc1ca7..2d208da07163 100644
--- a/drivers/target/target_core_fabric_configfs.c
+++ b/drivers/target/target_core_fabric_configfs.c
@@ -24,6 +24,7 @@
 #include <linux/unistd.h>
 #include <linux/string.h>
 #include <linux/syscalls.h>
+#include <linux/sysfs.h>
 #include <linux/configfs.h>
 
 #include <target/target_core_base.h>
diff --git a/drivers/target/target_core_file.c b/drivers/target/target_core_file.c
index 4d447520bab8..a907e646f45c 100644
--- a/drivers/target/target_core_file.c
+++ b/drivers/target/target_core_file.c
@@ -14,6 +14,7 @@
 #include <linux/parser.h>
 #include <linux/timer.h>
 #include <linux/blkdev.h>
+#include <linux/bvec.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/module.h>
diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
index 262e62ab6cf2..6593679a7304 100644
--- a/drivers/thermal/devfreq_cooling.c
+++ b/drivers/thermal/devfreq_cooling.c
@@ -10,6 +10,7 @@
  *      registered, the devfreq cooling won't react to it.
  */
 
+#include <linux/device.h>
 #include <linux/devfreq.h>
 #include <linux/devfreq_cooling.h>
 #include <linux/energy_model.h>
diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/intel/intel_powerclamp.c
index bc6eb0dd66a4..9266874463b4 100644
--- a/drivers/thermal/intel/intel_powerclamp.c
+++ b/drivers/thermal/intel/intel_powerclamp.c
@@ -31,6 +31,7 @@
 #include <linux/thermal.h>
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
+#include <linux/sysfs.h>
 #include <linux/idle_inject.h>
 
 #include <asm/msr.h>
diff --git a/drivers/thermal/intel/therm_throt.c b/drivers/thermal/intel/therm_throt.c
index e69868e868eb..62e13a1b2dea 100644
--- a/drivers/thermal/intel/therm_throt.c
+++ b/drivers/thermal/intel/therm_throt.c
@@ -14,6 +14,7 @@
  * Credits: Adapted from Zwane Mwaikambo's original code in mce_intel.c.
  *          Inspired by Ross Biro's and Al Borchers' counter code.
  */
+#include <linux/device.h>
 #include <linux/interrupt.h>
 #include <linux/notifier.h>
 #include <linux/jiffies.h>
diff --git a/drivers/tty/rpmsg_tty.c b/drivers/tty/rpmsg_tty.c
index 60a2915f5cfe..8a936c72ecd6 100644
--- a/drivers/tty/rpmsg_tty.c
+++ b/drivers/tty/rpmsg_tty.c
@@ -12,6 +12,7 @@
 
 #define pr_fmt(fmt)		KBUILD_MODNAME ": " fmt
 
+#include <linux/idr.h>
 #include <linux/module.h>
 #include <linux/rpmsg.h>
 #include <linux/slab.h>
diff --git a/drivers/tty/serial/8250/8250_bcm7271.c b/drivers/tty/serial/8250/8250_bcm7271.c
index 504c4c020857..f4af9373ff05 100644
--- a/drivers/tty/serial/8250/8250_bcm7271.c
+++ b/drivers/tty/serial/8250/8250_bcm7271.c
@@ -22,6 +22,7 @@
 #include <linux/delay.h>
 #include <linux/clk.h>
 #include <linux/debugfs.h>
+#include <linux/hrtimer.h>
 
 #include "8250.h"
 
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index c37905ea3cae..16c483d4ecf1 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -32,6 +32,7 @@
 #include <linux/uaccess.h>
 #include <linux/pm_runtime.h>
 #include <linux/ktime.h>
+#include <linux/hrtimer.h>
 
 #include <asm/io.h>
 #include <asm/irq.h>
diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 4aa72d5aeafb..87100d28fc92 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -27,6 +27,7 @@
 #include <linux/of.h>
 #include <linux/io.h>
 #include <linux/dma-mapping.h>
+#include <linux/hrtimer.h>
 
 #include <asm/irq.h>
 #include <linux/dma/imx-dma.h>
diff --git a/drivers/tty/serial/serial_base.h b/drivers/tty/serial/serial_base.h
index c74c548f0db6..27c260e08205 100644
--- a/drivers/tty/serial/serial_base.h
+++ b/drivers/tty/serial/serial_base.h
@@ -6,6 +6,8 @@
  * Author: Tony Lindgren <tony@atomide.com>
  */
 
+#include <linux/idr.h>
+
 #define to_serial_base_ctrl_device(d) container_of((d), struct serial_ctrl_device, dev)
 #define to_serial_base_port_device(d) container_of((d), struct serial_port_device, dev)
 
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index a85e7b9a2e49..1398cef67446 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -48,6 +48,7 @@
 #include <linux/timer.h>
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
+#include <linux/hrtimer.h>
 
 #ifdef CONFIG_SUPERH
 #include <asm/sh_bios.h>
diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 5f48ec37cb25..1f07145e5a68 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -25,6 +25,7 @@
 #include <linux/gpio.h>
 #include <linux/gpio/consumer.h>
 #include <linux/delay.h>
+#include <linux/hrtimer.h>
 
 #define CDNS_UART_TTY_NAME	"ttyPS"
 #define CDNS_UART_NAME		"xuartps"
diff --git a/drivers/usb/chipidea/otg_fsm.c b/drivers/usb/chipidea/otg_fsm.c
index c17516c29b63..522a5f3c0eb9 100644
--- a/drivers/usb/chipidea/otg_fsm.c
+++ b/drivers/usb/chipidea/otg_fsm.c
@@ -21,6 +21,7 @@
 #include <linux/usb/hcd.h>
 #include <linux/usb/chipidea.h>
 #include <linux/regulator/consumer.h>
+#include <linux/hrtimer.h>
 
 #include "ci.h"
 #include "bits.h"
diff --git a/drivers/usb/dwc2/hcd_queue.c b/drivers/usb/dwc2/hcd_queue.c
index 0d4495c6b9f7..e539dcce7b55 100644
--- a/drivers/usb/dwc2/hcd_queue.c
+++ b/drivers/usb/dwc2/hcd_queue.c
@@ -18,6 +18,7 @@
 #include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/usb.h>
+#include <linux/hrtimer.h>
 
 #include <linux/usb/hcd.h>
 #include <linux/usb/ch11.h>
diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/function/f_ncm.c
index ca5d5f564998..96a5084a0a4f 100644
--- a/drivers/usb/gadget/function/f_ncm.c
+++ b/drivers/usb/gadget/function/f_ncm.c
@@ -17,6 +17,7 @@
 #include <linux/device.h>
 #include <linux/etherdevice.h>
 #include <linux/crc32.h>
+#include <linux/hrtimer.h>
 
 #include <linux/usb/cdc.h>
 
diff --git a/drivers/usb/gadget/udc/max3420_udc.c b/drivers/usb/gadget/udc/max3420_udc.c
index 89e8cf2a2a7d..f92b914a5c04 100644
--- a/drivers/usb/gadget/udc/max3420_udc.c
+++ b/drivers/usb/gadget/udc/max3420_udc.c
@@ -26,6 +26,7 @@
 #include <linux/usb/gadget.h>
 #include <linux/spi/spi.h>
 #include <linux/gpio/consumer.h>
+#include <linux/hrtimer.h>
 
 #define MAX3420_MAX_EPS		4
 #define MAX3420_EP_MAX_PACKET		64  /* Same for all Endpoints */
diff --git a/drivers/usb/typec/class.h b/drivers/usb/typec/class.h
index 759b98355eeb..f57abf701dc5 100644
--- a/drivers/usb/typec/class.h
+++ b/drivers/usb/typec/class.h
@@ -4,6 +4,7 @@
 #define __USB_TYPEC_CLASS__
 
 #include <linux/device.h>
+#include <linux/idr.h>
 #include <linux/usb/typec.h>
 
 struct typec_mux;
diff --git a/drivers/usb/typec/pd.c b/drivers/usb/typec/pd.c
index b9cca2be76fc..aa73642e104c 100644
--- a/drivers/usb/typec/pd.c
+++ b/drivers/usb/typec/pd.c
@@ -6,6 +6,7 @@
  * Author: Heikki Krogerus <heikki.krogerus@linux.intel.com>
  */
 
+#include <linux/idr.h>
 #include <linux/slab.h>
 #include <linux/usb/pd.h>
 
diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
index 610a429c6191..2fc062fc13c7 100644
--- a/drivers/vfio/group.c
+++ b/drivers/vfio/group.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/vfio.h>
+#include <linux/idr.h>
 #include <linux/iommufd.h>
 #include <linux/anon_inodes.h>
 #include "vfio.h"
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dsi.c b/drivers/video/fbdev/omap2/omapfb/dss/dsi.c
index b7eb17a16ec4..c20a184acb1a 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/dsi.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/dsi.c
@@ -30,6 +30,7 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/component.h>
+#include <linux/hrtimer.h>
 
 #include <video/omapfb_dss.h>
 #include <video/mipi_display.h>
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/pll.c b/drivers/video/fbdev/omap2/omapfb/dss/pll.c
index 725194d52445..1fc0ebe2622f 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/pll.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/pll.c
@@ -10,6 +10,7 @@
 #include <linux/kernel.h>
 #include <linux/regulator/consumer.h>
 #include <linux/sched.h>
+#include <linux/hrtimer.h>
 
 #include <video/omapfb_dss.h>
 
diff --git a/drivers/virt/coco/tsm.c b/drivers/virt/coco/tsm.c
index d1c2db83a8ca..69ab9595c9f3 100644
--- a/drivers/virt/coco/tsm.c
+++ b/drivers/virt/coco/tsm.c
@@ -8,6 +8,7 @@
 #include <linux/slab.h>
 #include <linux/rwsem.h>
 #include <linux/string.h>
+#include <linux/sysfs.h>
 #include <linux/module.h>
 #include <linux/cleanup.h>
 #include <linux/configfs.h>
diff --git a/fs/aio.c b/fs/aio.c
index bb2ff48991f3..c347a2660c2b 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -45,6 +45,7 @@
 
 #include <linux/uaccess.h>
 #include <linux/nospec.h>
+#include <linux/hrtimer.h>
 
 #include "internal.h"
 
diff --git a/fs/bcachefs/chardev.c b/fs/bcachefs/chardev.c
index 226b39c17667..a2aa142a8b15 100644
--- a/fs/bcachefs/chardev.c
+++ b/fs/bcachefs/chardev.c
@@ -16,6 +16,7 @@
 #include <linux/cdev.h>
 #include <linux/device.h>
 #include <linux/fs.h>
+#include <linux/idr.h>
 #include <linux/ioctl.h>
 #include <linux/major.h>
 #include <linux/sched/task.h>
diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
index ec419b8e2c43..1eee24840245 100644
--- a/fs/bcachefs/fs.c
+++ b/fs/bcachefs/fs.c
@@ -34,6 +34,7 @@
 #include <linux/module.h>
 #include <linux/pagemap.h>
 #include <linux/posix_acl.h>
+#include <linux/quota.h>
 #include <linux/random.h>
 #include <linux/seq_file.h>
 #include <linux/statfs.h>
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 63b426cc7798..c72f5246430a 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -11,6 +11,7 @@
 #include <linux/slab.h>
 #include <linux/workqueue.h>
 #include <linux/btrfs.h>
+#include <linux/ratelimit.h>
 #include <linux/sched/mm.h>
 
 #include "ctree.h"
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 84c05246ffd8..dcae20d156ef 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -7,6 +7,7 @@
 #include <linux/sched/mm.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/sysfs.h>
 #include <linux/completion.h>
 #include <linux/bug.h>
 #include <linux/list.h>
diff --git a/fs/buffer.c b/fs/buffer.c
index b55dea034a5d..f32a7da32c7b 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -50,6 +50,7 @@
 #include <linux/fscrypt.h>
 #include <linux/fsverity.h>
 #include <linux/sched/isolation.h>
+#include <linux/ratelimit.h>
 
 #include "internal.h"
 
diff --git a/fs/ceph/metric.h b/fs/ceph/metric.h
index 0d0c44bd3332..37cc17f667bc 100644
--- a/fs/ceph/metric.h
+++ b/fs/ceph/metric.h
@@ -5,6 +5,8 @@
 #include <linux/ceph/types.h>
 #include <linux/percpu_counter.h>
 #include <linux/ktime.h>
+#include <linux/timer.h> // for round_jiffies_relative()
+#include <linux/workqueue.h> // for struct delayed_work
 
 extern bool disable_send_metrics;
 
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index b06e2bc86221..8793926ed89d 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -21,6 +21,7 @@
 #include <linux/netfs.h>
 #include <linux/fscache.h>
 #include <linux/hashtable.h>
+#include <linux/ratelimit.h>
 
 #include <linux/ceph/libceph.h>
 #include "crypto.h"
diff --git a/fs/configfs/mount.c b/fs/configfs/mount.c
index c2d820063ec4..57a6ab996950 100644
--- a/fs/configfs/mount.c
+++ b/fs/configfs/mount.c
@@ -15,6 +15,7 @@
 #include <linux/pagemap.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/sysfs.h>
 
 #include <linux/configfs.h>
 #include "configfs_internal.h"
diff --git a/fs/crypto/bio.c b/fs/crypto/bio.c
index 0ad8c30b8fa5..27216aa18ad4 100644
--- a/fs/crypto/bio.c
+++ b/fs/crypto/bio.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/bio.h>
 #include <linux/namei.h>
+#include <linux/blkdev.h> // errno_to_blk_status()
 #include "fscrypt_private.h"
 
 /**
diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 034a617cb1a5..54123210b6c4 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -27,6 +27,7 @@
 #include <linux/magic.h>
 #include <linux/slab.h>
 #include <linux/security.h>
+#include <linux/sysfs.h>
 
 #include "internal.h"
 
diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index c98aeda8abb2..193967a686aa 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2021, Alibaba Cloud
  */
 #include "internal.h"
+#include <linux/blkdev.h>
 #include <linux/sched/mm.h>
 #include <trace/events/erofs.h>
 
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index b0409badb017..c1138b2bd6ec 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -10,6 +10,7 @@
 #include <linux/fs.h>
 #include <linux/dax.h>
 #include <linux/dcache.h>
+#include <linux/idr.h>
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/pagemap.h>
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 5f60f163bd56..31bd221b72a2 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -10,6 +10,7 @@
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
 #include <linux/exportfs.h>
+#include <linux/blkdev.h>
 #include "xattr.h"
 
 #define CREATE_TRACE_POINTS
diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 3534d36a1474..4918d180b4a1 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -37,6 +37,7 @@
 #include <linux/seq_file.h>
 #include <linux/compat.h>
 #include <linux/rculist.h>
+#include <linux/hrtimer.h>
 #include <net/busy_poll.h>
 
 /*
diff --git a/fs/exec.c b/fs/exec.c
index af4fbb61cd53..64cf1dc62696 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -67,6 +67,7 @@
 #include <linux/time_namespace.h>
 #include <linux/user_events.h>
 #include <linux/rseq.h>
+#include <linux/posix-timers.h> // for posix_cpu_timers_exit()
 
 #include <linux/uaccess.h>
 #include <asm/mmu_context.h>
diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
index 6d332dff79dd..a982ea569b9d 100644
--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -12,6 +12,7 @@
 #include <linux/fs.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
+#include <linux/sysfs.h>
 #include <linux/proc_fs.h>
 #include <linux/part_stat.h>
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 84c9fead3ad4..3f59adf156a3 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -16,6 +16,7 @@
 #include <linux/crc32.h>
 #include <linux/magic.h>
 #include <linux/kobject.h>
+#include <linux/radix-tree.h>
 #include <linux/sched.h>
 #include <linux/cred.h>
 #include <linux/sched/mm.h>
diff --git a/fs/gfs2/recovery.c b/fs/gfs2/recovery.c
index 4db3ca9c3b02..8d8bdf892b8d 100644
--- a/fs/gfs2/recovery.c
+++ b/fs/gfs2/recovery.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/blkdev.h> // for bdev_read_only()
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/completion.h>
diff --git a/fs/gfs2/sys.c b/fs/gfs2/sys.c
index 250f340cb44d..15e89ab6acbd 100644
--- a/fs/gfs2/sys.c
+++ b/fs/gfs2/sys.c
@@ -9,6 +9,7 @@
 #include <linux/sched.h>
 #include <linux/cred.h>
 #include <linux/spinlock.h>
+#include <linux/sysfs.h>
 #include <linux/completion.h>
 #include <linux/buffer_head.h>
 #include <linux/module.h>
diff --git a/fs/hfsplus/wrapper.c b/fs/hfsplus/wrapper.c
index b0cb70400996..89f880abf598 100644
--- a/fs/hfsplus/wrapper.c
+++ b/fs/hfsplus/wrapper.c
@@ -10,6 +10,7 @@
  */
 
 #include <linux/fs.h>
+#include <linux/bio.h>
 #include <linux/blkdev.h>
 #include <linux/cdrom.h>
 #include <asm/unaligned.h>
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 093c4515b22a..cd0d007ba4a1 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -17,6 +17,7 @@
 #include <linux/bio.h>
 #include <linux/sched/signal.h>
 #include <linux/migrate.h>
+#include <linux/blkdev.h>
 #include "trace.h"
 
 #include "../internal.h"
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index bcd3f8cf5ea4..c7d017953468 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -12,6 +12,7 @@
 #include <linux/backing-dev.h>
 #include <linux/uio.h>
 #include <linux/task_io_accounting_ops.h>
+#include <linux/blkdev.h>
 #include "trace.h"
 
 #include "../internal.h"
diff --git a/fs/namespace.c b/fs/namespace.c
index 437f60e96d40..d80479bcf76c 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -31,6 +31,7 @@
 #include <uapi/linux/mount.h>
 #include <linux/fs_context.h>
 #include <linux/shmem_fs.h>
+#include <linux/sysfs.h>
 #include <linux/mnt_idmapping.h>
 #include <linux/nospec.h>
 
diff --git a/fs/nfs/nfs42xattr.c b/fs/nfs/nfs42xattr.c
index 49aaf28a6950..94fd57d7d930 100644
--- a/fs/nfs/nfs42xattr.c
+++ b/fs/nfs/nfs42xattr.c
@@ -10,6 +10,7 @@
 #include <linux/errno.h>
 #include <linux/nfs_fs.h>
 #include <linux/hashtable.h>
+#include <linux/list_lru.h>
 #include <linux/refcount.h>
 #include <uapi/linux/xattr.h>
 
diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index ae2ef5c11868..a2cb4532f7e3 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -5,6 +5,7 @@
  *
  */
 
+#include <linux/bio.h>
 #include <linux/blkdev.h>
 #include <linux/buffer_head.h>
 #include <linux/fs.h>
@@ -2698,4 +2699,4 @@ int ntfs_set_label(struct ntfs_sb_info *sbi, u8 *label, int len)
 out:
 	__putname(uni);
 	return err;
-}
\ No newline at end of file
+}
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index cef5467fd928..e0fc4805e21a 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -60,6 +60,7 @@
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <linux/statfs.h>
+#include <linux/ratelimit.h>
 
 #include "debug.h"
 #include "ntfs.h"
diff --git a/fs/pnode.c b/fs/pnode.c
index a799e0315cc9..c2f92e5a28fa 100644
--- a/fs/pnode.c
+++ b/fs/pnode.c
@@ -9,6 +9,7 @@
 #include <linux/mount.h>
 #include <linux/fs.h>
 #include <linux/nsproxy.h>
+#include <linux/seqlock.h>
 #include <uapi/linux/mount.h>
 #include "internal.h"
 #include "pnode.h"
diff --git a/fs/proc/uptime.c b/fs/proc/uptime.c
index b5343d209381..59ff141a3d4b 100644
--- a/fs/proc/uptime.c
+++ b/fs/proc/uptime.c
@@ -7,6 +7,7 @@
 #include <linux/time.h>
 #include <linux/time_namespace.h>
 #include <linux/kernel_stat.h>
+#include <linux/timekeeping.h> // for ktime_get_boottime_ts64()
 #include "internal.h"
 
 static int uptime_proc_show(struct seq_file *m, void *v)
diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
index d0d9bfdad30c..98a136f26d4c 100644
--- a/fs/pstore/inode.c
+++ b/fs/pstore/inode.c
@@ -22,6 +22,7 @@
 #include <linux/magic.h>
 #include <linux/pstore.h>
 #include <linux/slab.h>
+#include <linux/sysfs.h>
 #include <linux/uaccess.h>
 #include <linux/cleanup.h>
 
diff --git a/fs/reiserfs/reiserfs.h b/fs/reiserfs/reiserfs.h
index 725667880e62..335758395ee4 100644
--- a/fs/reiserfs/reiserfs.h
+++ b/fs/reiserfs/reiserfs.h
@@ -14,6 +14,7 @@
 #include <asm/unaligned.h>
 #include <linux/bitops.h>
 #include <linux/proc_fs.h>
+#include <linux/quota.h>
 #include <linux/buffer_head.h>
 
 /* the 32 bit compat definitions with int argument */
diff --git a/fs/sysctls.c b/fs/sysctls.c
index 8dbde9a802fa..90894bb067dd 100644
--- a/fs/sysctls.c
+++ b/fs/sysctls.c
@@ -6,6 +6,7 @@
  */
 #include <linux/init.h>
 #include <linux/sysctl.h>
+#include <linux/highuid.h>
 
 static struct ctl_table fs_shared_sysctls[] = {
 	{
diff --git a/fs/sysfs/mount.c b/fs/sysfs/mount.c
index 98467bb76737..2380a3f6f328 100644
--- a/fs/sysfs/mount.c
+++ b/fs/sysfs/mount.c
@@ -10,6 +10,7 @@
  */
 
 #include <linux/fs.h>
+#include <linux/kobject_ns.h>
 #include <linux/magic.h>
 #include <linux/mount.h>
 #include <linux/init.h>
diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index e1b172c0e091..1b46d6a7d3e9 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -21,6 +21,7 @@
 #include <linux/parser.h>
 #include <linux/magic.h>
 #include <linux/slab.h>
+#include <linux/sysfs.h>
 #include "internal.h"
 
 #define TRACEFS_DEFAULT_MODE	0700
diff --git a/fs/ubifs/io.c b/fs/ubifs/io.c
index 01d8eb170382..56e95da4f7ef 100644
--- a/fs/ubifs/io.c
+++ b/fs/ubifs/io.c
@@ -60,6 +60,7 @@
 
 #include <linux/crc32.h>
 #include <linux/slab.h>
+#include <linux/hrtimer.h>
 #include "ubifs.h"
 
 /**
diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index 09e270d6ed02..a9c286b8c373 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -24,6 +24,7 @@
 #include <linux/mount.h>
 #include <linux/math64.h>
 #include <linux/writeback.h>
+#include <linux/hrtimer.h>
 #include "ubifs.h"
 
 static int ubifs_default_version_set(const char *val, const struct kernel_param *kp)
diff --git a/fs/xfs/xfs_error.c b/fs/xfs/xfs_error.c
index b2cbbba3e15a..c64fb632718d 100644
--- a/fs/xfs/xfs_error.c
+++ b/fs/xfs/xfs_error.c
@@ -14,6 +14,7 @@
 #include "xfs_error.h"
 #include "xfs_sysfs.h"
 #include "xfs_inode.h"
+#include <linux/sysfs.h>
 
 #ifdef DEBUG
 
diff --git a/fs/xfs/xfs_sysfs.c b/fs/xfs/xfs_sysfs.c
index 17485666b672..09b2a05c802f 100644
--- a/fs/xfs/xfs_sysfs.c
+++ b/fs/xfs/xfs_sysfs.c
@@ -13,6 +13,7 @@
 #include "xfs_log.h"
 #include "xfs_log_priv.h"
 #include "xfs_mount.h"
+#include <linux/sysfs.h>
 
 struct xfs_sysfs_attr {
 	struct attribute attr;
diff --git a/fs/zonefs/sysfs.c b/fs/zonefs/sysfs.c
index 8ccb65c2b419..49f79f338550 100644
--- a/fs/zonefs/sysfs.c
+++ b/fs/zonefs/sysfs.c
@@ -6,6 +6,7 @@
  */
 #include <linux/fs.h>
 #include <linux/seq_file.h>
+#include <linux/sysfs.h>
 #include <linux/blkdev.h>
 
 #include "zonefs.h"
diff --git a/include/drm/drm_color_mgmt.h b/include/drm/drm_color_mgmt.h
index ed81741036d7..b5e183358bee 100644
--- a/include/drm/drm_color_mgmt.h
+++ b/include/drm/drm_color_mgmt.h
@@ -23,6 +23,7 @@
 #ifndef __DRM_COLOR_MGMT_H__
 #define __DRM_COLOR_MGMT_H__
 
+#include <linux/bits.h>
 #include <linux/ctype.h>
 #include <linux/math64.h>
 #include <drm/drm_property.h>
diff --git a/include/drm/drm_modeset_lock.h b/include/drm/drm_modeset_lock.h
index ec4f543c3d95..f901d4ad0c54 100644
--- a/include/drm/drm_modeset_lock.h
+++ b/include/drm/drm_modeset_lock.h
@@ -27,6 +27,7 @@
 #include <linux/types.h> /* stackdepot.h is not self-contained */
 #include <linux/stackdepot.h>
 #include <linux/ww_mutex.h>
+#include <linux/lockdep.h>
 
 struct drm_modeset_lock;
 
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index 5acc64954a88..4c598cfc2af3 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -28,6 +28,7 @@
 #include <linux/dma-fence.h>
 #include <linux/completion.h>
 #include <linux/xarray.h>
+#include <linux/wait.h>
 #include <linux/workqueue.h>
 
 #define MAX_WAIT_SCHED_ENTITY_Q_EMPTY msecs_to_jiffies(1000)
diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
index ae12696ec492..721659b4edd7 100644
--- a/include/linux/backing-dev-defs.h
+++ b/include/linux/backing-dev-defs.h
@@ -10,10 +10,15 @@
 #include <linux/percpu-refcount.h>
 #include <linux/flex_proportions.h>
 #include <linux/timer.h>
+#include <linux/wait.h>
 #include <linux/workqueue.h>
 #include <linux/kref.h>
 #include <linux/refcount.h>
 
+#ifdef CONFIG_CGROUP_WRITEBACK
+#include <linux/rwsem.h>
+#endif
+
 struct page;
 struct device;
 struct dentry;
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 875d792bffff..afae5a73b7cd 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -8,6 +8,7 @@
 #include <linux/mempool.h>
 /* struct bio, bio_vec and BIO_* flags are defined in blk_types.h */
 #include <linux/blk_types.h>
+#include <linux/bvec.h>
 #include <linux/uio.h>
 
 #define BIO_MAX_VECS		256U
diff --git a/include/linux/blk-integrity.h b/include/linux/blk-integrity.h
index 378b2459efe2..d91d3363d8b3 100644
--- a/include/linux/blk-integrity.h
+++ b/include/linux/blk-integrity.h
@@ -3,6 +3,7 @@
 #define _LINUX_BLK_INTEGRITY_H
 
 #include <linux/blk-mq.h>
+#include <linux/bio.h>
 
 struct request;
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 7a8150a5f051..d3e9e69aaa3c 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -2,6 +2,7 @@
 #ifndef BLK_MQ_H
 #define BLK_MQ_H
 
+#include <linux/bio.h>
 #include <linux/blkdev.h>
 #include <linux/sbitmap.h>
 #include <linux/lockdep.h>
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d7cac3de65b3..09e7268bc590 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -6,6 +6,7 @@
 #define _LINUX_BLKDEV_H
 
 #include <linux/types.h>
+#include <linux/fs.h> // for inode_unhashed()
 #include <linux/blk_types.h>
 #include <linux/device.h>
 #include <linux/list.h>
@@ -22,6 +23,7 @@
 #include <linux/blkzoned.h>
 #include <linux/sched.h>
 #include <linux/sbitmap.h>
+#include <linux/uio.h> // for iov_iter_is_aligned()
 #include <linux/uuid.h>
 #include <linux/xarray.h>
 
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 1b92aed49363..332ece824fde 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -22,6 +22,7 @@
 #include <linux/can/skb.h>
 #include <linux/ethtool.h>
 #include <linux/netdevice.h>
+#include <linux/workqueue.h> // for struct delayed_work
 
 /*
  * CAN mode
diff --git a/include/linux/dev_printk.h b/include/linux/dev_printk.h
index 6bfe70decc9f..a5151e4b9bde 100644
--- a/include/linux/dev_printk.h
+++ b/include/linux/dev_printk.h
@@ -12,6 +12,7 @@
 #define _DEVICE_PRINTK_H_
 
 #include <linux/compiler.h>
+#include <linux/stdarg.h>
 #include <linux/types.h>
 #include <linux/ratelimit.h>
 
diff --git a/include/linux/device.h b/include/linux/device.h
index 97c4b046c09d..ddba2d30c541 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -31,6 +31,7 @@
 #include <linux/device/class.h>
 #include <linux/device/driver.h>
 #include <linux/cleanup.h>
+#include <linux/sysfs.h> // for __ATTR_*
 #include <asm/device.h>
 
 struct device;
diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
index 5ef4ec1c36c3..76826d165298 100644
--- a/include/linux/device/bus.h
+++ b/include/linux/device/bus.h
@@ -17,6 +17,7 @@
 #include <linux/kobject.h>
 #include <linux/klist.h>
 #include <linux/pm.h>
+#include <linux/sysfs.h> // for struct attribute
 
 struct device_driver;
 struct fwnode_handle;
diff --git a/include/linux/device/class.h b/include/linux/device/class.h
index c576b49c55c2..6b1cebe43f8e 100644
--- a/include/linux/device/class.h
+++ b/include/linux/device/class.h
@@ -17,6 +17,7 @@
 #include <linux/kobject.h>
 #include <linux/klist.h>
 #include <linux/pm.h>
+#include <linux/uidgid_types.h>
 #include <linux/device/bus.h>
 
 struct device;
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 752dbde4cec1..1a202761599a 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -7,6 +7,7 @@
 
 #include <linux/device.h>
 #include <linux/err.h>
+#include <linux/idr.h> // for struct ida
 #include <linux/uio.h>
 #include <linux/bug.h>
 #include <linux/scatterlist.h>
diff --git a/include/linux/dtpm.h b/include/linux/dtpm.h
index a4a13514b730..eae69f6e4042 100644
--- a/include/linux/dtpm.h
+++ b/include/linux/dtpm.h
@@ -12,6 +12,8 @@
 #define MAX_DTPM_DESCR 8
 #define MAX_DTPM_CONSTRAINTS 1
 
+struct of_device_id;
+
 struct dtpm {
 	struct powercap_zone zone;
 	struct dtpm *parent;
diff --git a/include/linux/extcon.h b/include/linux/extcon.h
index e596a0abcb27..0fd2ca917549 100644
--- a/include/linux/extcon.h
+++ b/include/linux/extcon.h
@@ -19,6 +19,9 @@
 #define __LINUX_EXTCON_H__
 
 #include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/notifier.h>
+#include <linux/types.h>
 
 /*
  * Define the type of supported external connectors
diff --git a/include/linux/firmware.h b/include/linux/firmware.h
index 0311858b46ce..d45acd8c1e84 100644
--- a/include/linux/firmware.h
+++ b/include/linux/firmware.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_FIRMWARE_H
 #define _LINUX_FIRMWARE_H
 
+#include <linux/err.h>
 #include <linux/types.h>
 #include <linux/compiler.h>
 #include <linux/gfp.h>
diff --git a/include/linux/flex_proportions.h b/include/linux/flex_proportions.h
index e9a72fd0bfe7..b5d8c1a1b2a9 100644
--- a/include/linux/flex_proportions.h
+++ b/include/linux/flex_proportions.h
@@ -12,6 +12,7 @@
 #include <linux/spinlock.h>
 #include <linux/seqlock.h>
 #include <linux/gfp.h>
+#include <linux/irqflags.h> // for local_irq_save()
 
 /*
  * When maximum proportion of some event type is specified, this is the
diff --git a/include/linux/framer/framer-provider.h b/include/linux/framer/framer-provider.h
index 782cd5fc83d5..0519dfe6f61c 100644
--- a/include/linux/framer/framer-provider.h
+++ b/include/linux/framer/framer-provider.h
@@ -10,6 +10,7 @@
 #ifndef __DRIVERS_PROVIDER_FRAMER_H
 #define __DRIVERS_PROVIDER_FRAMER_H
 
+#include <linux/device.h>
 #include <linux/export.h>
 #include <linux/framer/framer.h>
 #include <linux/types.h>
diff --git a/include/linux/futex.h b/include/linux/futex.h
index b70df27d7e85..9fe23f0681ca 100644
--- a/include/linux/futex.h
+++ b/include/linux/futex.h
@@ -4,6 +4,7 @@
 
 #include <linux/sched.h>
 #include <linux/ktime.h>
+#include <linux/mutex.h>
 
 #include <uapi/linux/futex.h>
 
diff --git a/include/linux/hisi_acc_qm.h b/include/linux/hisi_acc_qm.h
index 5f4c74facf6a..33e3caa400de 100644
--- a/include/linux/hisi_acc_qm.h
+++ b/include/linux/hisi_acc_qm.h
@@ -5,6 +5,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/debugfs.h>
+#include <linux/idr.h>
 #include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/pci.h>
diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 991c83e929b4..ba795d668766 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -20,7 +20,9 @@
 #include <linux/rbtree.h>
 #include <linux/seqlock.h>
 #include <linux/timer.h>
+#include <asm/processor.h>  /* for cpu_relax() */
 
+struct restart_block;
 struct hrtimer_clock_base;
 struct hrtimer_cpu_base;
 
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index c5b36d2c1e73..6dafef342e91 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -9,6 +9,7 @@
 
 #include <linux/device.h>
 #include <linux/cdev.h>
+#include <linux/device.h>
 #include <linux/slab.h>
 #include <linux/iio/types.h>
 /* IIO TODO LIST */
diff --git a/include/linux/ipc.h b/include/linux/ipc.h
index 9b1434247aab..12f6839fad5b 100644
--- a/include/linux/ipc.h
+++ b/include/linux/ipc.h
@@ -7,6 +7,8 @@
 #include <linux/rhashtable-types.h>
 #include <uapi/linux/ipc.h>
 #include <linux/refcount.h>
+#include <linux/cache.h> // for ____cacheline_aligned_in_smp
+#include <linux/compiler_types.h> // for __randomize_layout
 
 /* used by in-kernel data structures */
 struct kern_ipc_perm {
diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 7a9ff464608d..ace4e4e48315 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -3,6 +3,7 @@
 #define __LINUX_MEMORY_HOTPLUG_H
 
 #include <linux/mmzone.h>
+#include <linux/seqlock.h>
 #include <linux/spinlock.h>
 #include <linux/notifier.h>
 #include <linux/bug.h>
diff --git a/include/linux/mm.h b/include/linux/mm.h
index e442fd0efdd9..b111daecd173 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -23,6 +23,8 @@
 #include <linux/err.h>
 #include <linux/page-flags.h>
 #include <linux/page_ref.h>
+#include <linux/percpu_counter.h>
+#include <linux/rwsem.h>
 #include <linux/overflow.h>
 #include <linux/sizes.h>
 #include <linux/sched.h>
@@ -30,6 +32,7 @@
 #include <linux/kasan.h>
 #include <linux/memremap.h>
 #include <linux/slab.h>
+#include <linux/seqlock.h>
 
 struct mempolicy;
 struct anon_vma;
diff --git a/include/linux/module.h b/include/linux/module.h
index 1153b0d99a80..fd3c85e4d95f 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -27,6 +27,7 @@
 #include <linux/tracepoint-defs.h>
 #include <linux/srcu.h>
 #include <linux/static_call_types.h>
+#include <linux/sysfs.h> // for struct attribute
 #include <linux/dynamic_debug.h>
 
 #include <linux/percpu.h>
diff --git a/include/linux/mtd/blktrans.h b/include/linux/mtd/blktrans.h
index 6e471436bba5..92a7c94777b7 100644
--- a/include/linux/mtd/blktrans.h
+++ b/include/linux/mtd/blktrans.h
@@ -8,6 +8,7 @@
 
 #include <linux/mutex.h>
 #include <linux/kref.h>
+#include <linux/list.h>
 #include <linux/sysfs.h>
 
 struct hd_geometry;
diff --git a/include/linux/ndctl.h b/include/linux/ndctl.h
index cd5a293ce3ae..4f21118ae7b1 100644
--- a/include/linux/ndctl.h
+++ b/include/linux/ndctl.h
@@ -13,6 +13,8 @@
 #ifndef _LINUX_NDCTL_H
 #define _LINUX_NDCTL_H
 
+#include <asm/page.h> // for PAGE_SIZE
+
 #include <uapi/linux/ndctl.h>
 
 enum {
diff --git a/include/linux/node.h b/include/linux/node.h
index 25b66d705ee2..c4c17037c954 100644
--- a/include/linux/node.h
+++ b/include/linux/node.h
@@ -18,6 +18,8 @@
 #include <linux/device.h>
 #include <linux/cpumask.h>
 #include <linux/list.h>
+#include <linux/mmzone.h> // for enum meminit_context
+#include <linux/nodemask.h> // for node_online()
 
 /**
  * struct access_coordinate - generic performance coordinates container
diff --git a/include/linux/notifier.h b/include/linux/notifier.h
index 45702bdcbceb..96fb0b489d8a 100644
--- a/include/linux/notifier.h
+++ b/include/linux/notifier.h
@@ -13,6 +13,7 @@
 #include <linux/errno.h>
 #include <linux/mutex.h>
 #include <linux/rwsem.h>
+#include <linux/spinlock.h>
 #include <linux/srcu.h>
 
 /*
diff --git a/include/linux/ns_common.h b/include/linux/ns_common.h
index 0f1d024bd958..241cef0bfaed 100644
--- a/include/linux/ns_common.h
+++ b/include/linux/ns_common.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_NS_COMMON_H
 #define _LINUX_NS_COMMON_H
 
+#include <linux/atomic.h>
 #include <linux/refcount.h>
 
 struct proc_ns_operations;
diff --git a/include/linux/pm.h b/include/linux/pm.h
index 97b0e23363c8..e0014edba850 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -17,6 +17,10 @@
 #include <linux/hrtimer.h>
 #include <linux/completion.h>
 
+#ifdef CONFIG_PM_CLK
+#include <linux/mutex_types.h>
+#endif
+
 /*
  * Callbacks for platform drivers to implement.
  */
diff --git a/include/linux/quotaops.h b/include/linux/quotaops.h
index 06cc8888199e..96ea5444b4a3 100644
--- a/include/linux/quotaops.h
+++ b/include/linux/quotaops.h
@@ -9,6 +9,7 @@
 #define _LINUX_QUOTAOPS_
 
 #include <linux/fs.h>
+#include <linux/quota.h>
 
 #define DQUOT_SPACE_WARN	0x1
 #define DQUOT_SPACE_RESERVE	0x2
diff --git a/include/linux/raid_class.h b/include/linux/raid_class.h
index e50416ba9cd9..095e1c91edb4 100644
--- a/include/linux/raid_class.h
+++ b/include/linux/raid_class.h
@@ -4,6 +4,8 @@
  *
  * Copyright (c) 2005 - James Bottomley <James.Bottomley@steeleye.com>
  */
+
+#include <linux/device.h>
 #include <linux/transport_class.h>
 
 struct raid_template {
diff --git a/include/linux/slab.h b/include/linux/slab.h
index b5f5ee8308d0..12a62a17e893 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -20,6 +20,7 @@
 #include <linux/percpu-refcount.h>
 #include <linux/cleanup.h>
 #include <linux/hash.h>
+#include <linux/mmzone.h>
 
 
 /*
diff --git a/include/linux/socket.h b/include/linux/socket.h
index cfcb7e2c3813..681bd2626f1e 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -8,6 +8,7 @@
 #include <linux/uio.h>			/* iovec support		*/
 #include <linux/types.h>		/* pid_t			*/
 #include <linux/compiler.h>		/* __user			*/
+#include <linux/time64.h>		/* timespec64			*/
 #include <uapi/linux/socket.h>
 
 struct file;
@@ -391,7 +392,6 @@ struct ucred {
 extern int move_addr_to_kernel(void __user *uaddr, int ulen, struct sockaddr_storage *kaddr);
 extern int put_cmsg(struct msghdr*, int level, int type, int len, void *data);
 
-struct timespec64;
 struct __kernel_timespec;
 struct old_timespec32;
 
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 66f814b63a43..4546af80247d 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -5,6 +5,7 @@
 #define __SOUNDWIRE_H
 
 #include <linux/bug.h>
+#include <linux/device.h>
 #include <linux/lockdep_types.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
diff --git a/include/linux/spi/spi_bitbang.h b/include/linux/spi/spi_bitbang.h
index 4444c2a992cb..0bd120e2c701 100644
--- a/include/linux/spi/spi_bitbang.h
+++ b/include/linux/spi/spi_bitbang.h
@@ -2,6 +2,8 @@
 #ifndef	__SPI_BITBANG_H
 #define	__SPI_BITBANG_H
 
+#include <linux/mutex.h>
+#include <linux/types.h>
 #include <linux/workqueue.h>
 
 struct spi_bitbang {
diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 8f3f72480e78..74edc15cfcf3 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -13,6 +13,8 @@
 
 #include <linux/rcu_node_tree.h>
 #include <linux/completion.h>
+#include <linux/mutex_types.h>
+#include <linux/workqueue.h>
 
 struct srcu_node;
 struct srcu_struct;
diff --git a/include/linux/stackdepot.h b/include/linux/stackdepot.h
index adcbb8f23600..a6aa21393755 100644
--- a/include/linux/stackdepot.h
+++ b/include/linux/stackdepot.h
@@ -21,6 +21,7 @@
 #define _LINUX_STACKDEPOT_H
 
 #include <linux/gfp.h>
+#include <linux/init.h>
 
 typedef u32 depot_stack_handle_t;
 
diff --git a/include/linux/sunrpc/rpc_pipe_fs.h b/include/linux/sunrpc/rpc_pipe_fs.h
index 3b35b6f6533a..5438de45300d 100644
--- a/include/linux/sunrpc/rpc_pipe_fs.h
+++ b/include/linux/sunrpc/rpc_pipe_fs.h
@@ -2,6 +2,9 @@
 #ifndef _LINUX_SUNRPC_RPC_PIPE_FS_H
 #define _LINUX_SUNRPC_RPC_PIPE_FS_H
 
+#include <linux/list.h>
+#include <linux/spinlock_types.h>
+#include <linux/wait.h>
 #include <linux/workqueue.h>
 
 struct rpc_pipe_dir_head {
diff --git a/include/linux/trace_recursion.h b/include/linux/trace_recursion.h
index d48cd92d2364..19bf980b039f 100644
--- a/include/linux/trace_recursion.h
+++ b/include/linux/trace_recursion.h
@@ -136,6 +136,7 @@ extern void ftrace_record_recursion(unsigned long ip, unsigned long parent_ip);
 #endif
 
 #ifdef CONFIG_ARCH_WANTS_NO_INSTR
+#include <linux/rcutree.h> // for rcu_is_watching()
 # define trace_warn_on_no_rcu(ip)					\
 	({								\
 		bool __ret = !rcu_is_watching();			\
diff --git a/include/linux/tty_port.h b/include/linux/tty_port.h
index 1b861f2100b6..2de08c8d2584 100644
--- a/include/linux/tty_port.h
+++ b/include/linux/tty_port.h
@@ -6,7 +6,7 @@
 #include <linux/kref.h>
 #include <linux/mutex.h>
 #include <linux/tty_buffer.h>
-#include <linux/wait.h>
+#include <linux/wait_types.h>
 
 struct attribute_group;
 struct tty_driver;
diff --git a/include/linux/u64_stats_sync.h b/include/linux/u64_stats_sync.h
index ffe48e69b3f3..cf4b090e799a 100644
--- a/include/linux/u64_stats_sync.h
+++ b/include/linux/u64_stats_sync.h
@@ -59,6 +59,8 @@
  * Example of use in drivers/net/loopback.c, using per_cpu containers,
  * in BH disabled context.
  */
+
+#include <asm/bitsperlong.h>
 #include <linux/seqlock.h>
 
 struct u64_stats_sync {
diff --git a/include/linux/wait_bit.h b/include/linux/wait_bit.h
index 7725b7579b78..96c90fbcf652 100644
--- a/include/linux/wait_bit.h
+++ b/include/linux/wait_bit.h
@@ -5,6 +5,9 @@
 /*
  * Linux wait-bit related types and methods:
  */
+#include <linux/bitops.h>
+#include <linux/init.h> // for __init
+#include <linux/kernel.h> // for might_sleep()
 #include <linux/wait.h>
 
 struct wait_bit_key {
diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index 453736fd1d23..9a7a3d2b543f 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -11,6 +11,7 @@
 #include <linux/flex_proportions.h>
 #include <linux/backing-dev-defs.h>
 #include <linux/blk_types.h>
+#include <linux/wait_bit.h>
 
 struct bio;
 
diff --git a/include/linux/ww_mutex.h b/include/linux/ww_mutex.h
index bb763085479a..f5b141b085ba 100644
--- a/include/linux/ww_mutex.h
+++ b/include/linux/ww_mutex.h
@@ -19,6 +19,7 @@
 
 #include <linux/mutex.h>
 #include <linux/rtmutex.h>
+#include <linux/lockdep.h>
 
 #if defined(CONFIG_DEBUG_MUTEXES) || \
    (defined(CONFIG_PREEMPT_RT) && defined(CONFIG_DEBUG_RT_MUTEXES))
diff --git a/include/media/media-device.h b/include/media/media-device.h
index 2c146d0b2b1c..b1b5b6dac4ff 100644
--- a/include/media/media-device.h
+++ b/include/media/media-device.h
@@ -11,6 +11,7 @@
 #ifndef _MEDIA_DEVICE_H
 #define _MEDIA_DEVICE_H
 
+#include <linux/idr.h> // for struct ida
 #include <linux/list.h>
 #include <linux/mutex.h>
 #include <linux/pci.h>
diff --git a/include/net/netns/ipv6.h b/include/net/netns/ipv6.h
index 5f2cfd84570a..858ee28e73f9 100644
--- a/include/net/netns/ipv6.h
+++ b/include/net/netns/ipv6.h
@@ -3,6 +3,10 @@
  * ipv6 in net namespaces
  */
 
+#include <linux/list.h>
+#include <linux/spinlock_types.h>
+#include <linux/rwlock_types.h>
+#include <linux/workqueue.h> // for struct delayed_work
 #include <net/inet_frag.h>
 
 #ifndef __NETNS_IPV6_H__
diff --git a/include/net/netns/mctp.h b/include/net/netns/mctp.h
index 1db8f9aaddb4..6c5039374021 100644
--- a/include/net/netns/mctp.h
+++ b/include/net/netns/mctp.h
@@ -6,6 +6,7 @@
 #ifndef __NETNS_MCTP_H__
 #define __NETNS_MCTP_H__
 
+#include <linux/list.h>
 #include <linux/mutex.h>
 #include <linux/types.h>
 
diff --git a/include/net/netns/xdp.h b/include/net/netns/xdp.h
index 21a4f25a187a..06d06cf2b966 100644
--- a/include/net/netns/xdp.h
+++ b/include/net/netns/xdp.h
@@ -2,6 +2,7 @@
 #ifndef __NETNS_XDP_H__
 #define __NETNS_XDP_H__
 
+#include <linux/list.h>
 #include <linux/mutex.h>
 #include <linux/types.h>
 
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 58e65af74ad1..140e012260a8 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -26,6 +26,7 @@
 #include <linux/kref.h>
 #include <linux/ktime.h>
 #include <linux/indirect_call_wrapper.h>
+#include <linux/hrtimer.h> // for hrtimer_try_to_cancel()
 
 #include <net/inet_connection_sock.h>
 #include <net/inet_timewait_sock.h>
diff --git a/include/sound/core.h b/include/sound/core.h
index dfef0c9d4b9f..eaae6da1e0b0 100644
--- a/include/sound/core.h
+++ b/include/sound/core.h
@@ -14,6 +14,7 @@
 #include <linux/pm.h>			/* pm_message_t */
 #include <linux/stringify.h>
 #include <linux/printk.h>
+#include <linux/wait.h>
 #include <linux/xarray.h>
 
 /* number of supported soundcards */
diff --git a/include/sound/util_mem.h b/include/sound/util_mem.h
index 01310e089143..3403b8f4dc86 100644
--- a/include/sound/util_mem.h
+++ b/include/sound/util_mem.h
@@ -2,6 +2,7 @@
 #ifndef __SOUND_UTIL_MEM_H
 #define __SOUND_UTIL_MEM_H
 
+#include <linux/list.h>
 #include <linux/mutex.h>
 /*
  *  Copyright (C) 2000 Takashi Iwai <tiwai@suse.de>
diff --git a/include/trace/events/iommu.h b/include/trace/events/iommu.h
index 70743db1fb75..4a438395759c 100644
--- a/include/trace/events/iommu.h
+++ b/include/trace/events/iommu.h
@@ -11,10 +11,9 @@
 #if !defined(_TRACE_IOMMU_H) || defined(TRACE_HEADER_MULTI_READ)
 #define _TRACE_IOMMU_H
 
+#include <linux/device.h> // for dev_driver_string()
 #include <linux/tracepoint.h>
 
-struct device;
-
 DECLARE_EVENT_CLASS(iommu_group_event,
 
 	TP_PROTO(int group_id, struct device *dev),
diff --git a/include/trace/events/power.h b/include/trace/events/power.h
index 77f14f7a11d4..db197c8e93d9 100644
--- a/include/trace/events/power.h
+++ b/include/trace/events/power.h
@@ -6,6 +6,7 @@
 #define _TRACE_POWER_H
 
 #include <linux/cpufreq.h>
+#include <linux/device.h>
 #include <linux/ktime.h>
 #include <linux/pm_qos.h>
 #include <linux/tracepoint.h>
diff --git a/init/init_task.c b/init/init_task.c
index 4daee6d761c8..28aa0031f42b 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -13,6 +13,7 @@
 #include <linux/numa.h>
 #include <linux/scs.h>
 #include <linux/plist.h>
+#include <linux/posix-timers.h> // for INIT_CPU_TIMERS()
 
 #include <linux/uaccess.h>
 
diff --git a/init/main.c b/init/main.c
index 521f40770e67..67af889b2f70 100644
--- a/init/main.c
+++ b/init/main.c
@@ -99,6 +99,7 @@
 #include <linux/init_syscalls.h>
 #include <linux/stackdepot.h>
 #include <linux/randomize_kstack.h>
+#include <linux/hrtimer.h>
 #include <net/net_namespace.h>
 
 #include <asm/io.h>
diff --git a/io_uring/cancel.c b/io_uring/cancel.c
index 8a8b07dfc444..0288bf4d015b 100644
--- a/io_uring/cancel.c
+++ b/io_uring/cancel.c
@@ -8,6 +8,7 @@
 #include <linux/namei.h>
 #include <linux/nospec.h>
 #include <linux/io_uring.h>
+#include <linux/hrtimer.h>
 
 #include <uapi/linux/io_uring.h>
 
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index cd9a137ad6ce..49db7fa2cebd 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -72,6 +72,7 @@
 #include <linux/io_uring/cmd.h>
 #include <linux/audit.h>
 #include <linux/security.h>
+#include <linux/hrtimer.h>
 #include <asm/shmparam.h>
 
 #define CREATE_TRACE_POINTS
diff --git a/io_uring/timeout.h b/io_uring/timeout.h
index a6939f18313e..1421625053da 100644
--- a/io_uring/timeout.h
+++ b/io_uring/timeout.h
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <linux/hrtimer.h>
+
 struct io_timeout_data {
 	struct io_kiocb			*req;
 	struct hrtimer			timer;
diff --git a/ipc/mq_sysctl.c b/ipc/mq_sysctl.c
index 21fba3a6edaf..2486dd36af57 100644
--- a/ipc/mq_sysctl.c
+++ b/ipc/mq_sysctl.c
@@ -13,6 +13,7 @@
 #include <linux/capability.h>
 #include <linux/slab.h>
 #include <linux/cred.h>
+#include <linux/uidgid.h>
 
 static int msg_max_limit_min = MIN_MSGMAX;
 static int msg_max_limit_max = HARD_MSGMAX;
diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 5eea4dc0509e..e27c7512e7b1 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -39,6 +39,7 @@
 #include <linux/sched/wake_q.h>
 #include <linux/sched/signal.h>
 #include <linux/sched/user.h>
+#include <linux/hrtimer.h>
 
 #include <net/sock.h>
 #include "util.h"
diff --git a/ipc/namespace.c b/ipc/namespace.c
index 6ecc30effd3e..8df3cda0b6ee 100644
--- a/ipc/namespace.c
+++ b/ipc/namespace.c
@@ -16,6 +16,7 @@
 #include <linux/user_namespace.h>
 #include <linux/proc_ns.h>
 #include <linux/sched/task.h>
+#include <linux/workqueue.h>
 
 #include "util.h"
 
diff --git a/ipc/sem.c b/ipc/sem.c
index a39cdc7bf88f..a2cdd57ab140 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -87,6 +87,7 @@
 #include <linux/sched/wake_q.h>
 #include <linux/nospec.h>
 #include <linux/rhashtable.h>
+#include <linux/hrtimer.h>
 
 #include <linux/uaccess.h>
 #include "util.h"
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index bcb951a2ecf4..ee230f61b6de 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -23,6 +23,7 @@
 #include <linux/btf_ids.h>
 #include <linux/bpf_mem_alloc.h>
 #include <linux/kasan.h>
+#include <linux/hrtimer.h>
 
 #include "../../lib/kstrtox.h"
 
diff --git a/kernel/cpu.c b/kernel/cpu.c
index ad7d0b00bce9..5b8319c849a7 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -37,6 +37,7 @@
 #include <linux/cpuset.h>
 #include <linux/random.h>
 #include <linux/cc_platform.h>
+#include <linux/hrtimer.h>
 
 #include <trace/events/power.h>
 #define CREATE_TRACE_POINTS
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 5ecfa57e3b97..1814755cf94f 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -55,6 +55,7 @@
 #include <linux/pgtable.h>
 #include <linux/buildid.h>
 #include <linux/task_work.h>
+#include <linux/hrtimer.h>
 
 #include "internal.h"
 
diff --git a/kernel/exit.c b/kernel/exit.c
index dfb963d2f862..9b4f638322b0 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -70,6 +70,7 @@
 #include <linux/sysfs.h>
 #include <linux/user_events.h>
 #include <linux/uaccess.h>
+#include <linux/hrtimer.h>
 
 #include <uapi/linux/wait.h>
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 83613bb3e66f..b7389080795e 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -49,6 +49,7 @@
 #include <linux/cpu.h>
 #include <linux/cgroup.h>
 #include <linux/security.h>
+#include <linux/hrtimer.h>
 #include <linux/hugetlb.h>
 #include <linux/seccomp.h>
 #include <linux/swap.h>
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 1e78ef24321e..fce9cabf8c98 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -38,6 +38,7 @@
 #include <linux/memblock.h>
 #include <linux/fault-inject.h>
 #include <linux/slab.h>
+#include <linux/hrtimer.h>
 
 #include "futex.h"
 #include "../locking/rtmutex_common.h"
diff --git a/kernel/futex/pi.c b/kernel/futex/pi.c
index 5722467f2737..3247e11341b3 100644
--- a/kernel/futex/pi.c
+++ b/kernel/futex/pi.c
@@ -3,6 +3,7 @@
 #include <linux/slab.h>
 #include <linux/sched/rt.h>
 #include <linux/sched/task.h>
+#include <linux/hrtimer.h>
 
 #include "futex.h"
 #include "../locking/rtmutex_common.h"
diff --git a/kernel/futex/requeue.c b/kernel/futex/requeue.c
index b47bb764b352..cc8bfc20d6a2 100644
--- a/kernel/futex/requeue.c
+++ b/kernel/futex/requeue.c
@@ -2,6 +2,7 @@
 
 #include <linux/plist.h>
 #include <linux/sched/signal.h>
+#include <linux/hrtimer.h>
 
 #include "futex.h"
 #include "../locking/rtmutex_common.h"
diff --git a/kernel/futex/syscalls.c b/kernel/futex/syscalls.c
index 4b6da9116aa6..3841d40a7928 100644
--- a/kernel/futex/syscalls.c
+++ b/kernel/futex/syscalls.c
@@ -2,6 +2,7 @@
 
 #include <linux/syscalls.h>
 #include <linux/time_namespace.h>
+#include <linux/hrtimer.h>
 
 #include "futex.h"
 
diff --git a/kernel/futex/waitwake.c b/kernel/futex/waitwake.c
index 3a10375d9521..2ec8b7403ef3 100644
--- a/kernel/futex/waitwake.c
+++ b/kernel/futex/waitwake.c
@@ -4,6 +4,7 @@
 #include <linux/sched/task.h>
 #include <linux/sched/signal.h>
 #include <linux/freezer.h>
+#include <linux/hrtimer.h>
 
 #include "futex.h"
 
diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index ecbc9b6aba3a..0bf5c70e1cde 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -10,8 +10,10 @@
 
 #include <linux/module.h>
 #include <linux/kernel.h>
+#include <linux/kobject.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
+#include <linux/sysfs.h>
 #include <linux/list.h>
 #include <linux/kallsyms.h>
 #include <linux/livepatch.h>
diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
index e54c3d60a904..b60b6dc439c1 100644
--- a/kernel/livepatch/transition.c
+++ b/kernel/livepatch/transition.c
@@ -8,6 +8,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/cpu.h>
+#include <linux/sched/idle.h>
 #include <linux/stacktrace.h>
 #include <linux/static_call.h>
 #include "core.h"
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 4a10e8c16fd2..4038acd3cf71 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -23,6 +23,7 @@
 #include <linux/sched/rt.h>
 #include <linux/sched/wake_q.h>
 #include <linux/ww_mutex.h>
+#include <linux/hrtimer.h>
 
 #include <trace/events/lock.h>
 
diff --git a/kernel/locking/rtmutex_common.h b/kernel/locking/rtmutex_common.h
index 1162e07cdaea..5ecdef2d8383 100644
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -14,6 +14,7 @@
 #define __KERNEL_RTMUTEX_COMMON_H
 
 #include <linux/debug_locks.h>
+#include <linux/rbtree.h>
 #include <linux/rtmutex.h>
 #include <linux/sched/wake_q.h>
 
diff --git a/kernel/padata.c b/kernel/padata.c
index e3f639ff1670..9d051ab75dad 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -22,6 +22,7 @@
 #include <linux/slab.h>
 #include <linux/sysfs.h>
 #include <linux/rcupdate.h>
+#include <linux/refcount.h>
 
 #define	PADATA_WORK_ONSTACK	1	/* Work's memory is on stack */
 
diff --git a/kernel/panic.c b/kernel/panic.c
index d49b68184c56..29b49d03b73e 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -34,6 +34,7 @@
 #include <linux/ratelimit.h>
 #include <linux/debugfs.h>
 #include <linux/sysfs.h>
+#include <linux/hrtimer.h> //for sysrq_timer_list_show()
 #include <linux/context_tracking.h>
 #include <trace/events/error_report.h>
 #include <asm/sections.h>
diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 7b44f5b89fa1..af6fb88f69dc 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -13,6 +13,7 @@
 #include <linux/cpufreq.h>
 #include <linux/cpumask.h>
 #include <linux/debugfs.h>
+#include <linux/device.h>
 #include <linux/energy_model.h>
 #include <linux/sched/topology.h>
 #include <linux/slab.h>
diff --git a/kernel/reboot.c b/kernel/reboot.c
index 22c16e2564cc..ec96587c78cd 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -9,6 +9,7 @@
 
 #include <linux/atomic.h>
 #include <linux/ctype.h>
+#include <linux/device.h>
 #include <linux/export.h>
 #include <linux/kexec.h>
 #include <linux/kmod.h>
diff --git a/kernel/signal.c b/kernel/signal.c
index 9561a3962ca6..bcab6ee3cd26 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -47,6 +47,7 @@
 #include <linux/cgroup.h>
 #include <linux/audit.h>
 #include <linux/sysctl.h>
+#include <linux/hrtimer.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/signal.h>
diff --git a/kernel/smpboot.c b/kernel/smpboot.c
index 1992b62e980b..19f25456254b 100644
--- a/kernel/smpboot.c
+++ b/kernel/smpboot.c
@@ -15,6 +15,7 @@
 #include <linux/percpu.h>
 #include <linux/kthread.h>
 #include <linux/smpboot.h>
+#include <linux/topology.h> // for cpu_to_node()
 
 #include "smpboot.h"
 
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index edb0f821dcea..8ae50f900e4c 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -39,6 +39,7 @@
 #include <linux/sched/nohz.h>
 #include <linux/sched/debug.h>
 #include <linux/timer.h>
+#include <linux/timerqueue.h>
 #include <linux/freezer.h>
 #include <linux/compat.h>
 
diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
index 0775b9ec952a..b37f8e91323d 100644
--- a/kernel/time/namespace.c
+++ b/kernel/time/namespace.c
@@ -17,6 +17,7 @@
 #include <linux/cred.h>
 #include <linux/err.h>
 #include <linux/mm.h>
+#include <linux/ktime.h> //for timespec64_to_ktime()
 
 #include <vdso/datapage.h>
 
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index b924f0f096fa..9b138586cd29 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -31,6 +31,7 @@
 #include <linux/compat.h>
 #include <linux/nospec.h>
 #include <linux/time_namespace.h>
+#include <linux/hrtimer.h>
 
 #include "timekeeping.h"
 #include "posix-timers.h"
diff --git a/kernel/time/timer_list.c b/kernel/time/timer_list.c
index ed7d6ad694fb..99ae83f3f646 100644
--- a/kernel/time/timer_list.c
+++ b/kernel/time/timer_list.c
@@ -10,6 +10,7 @@
 #include <linux/spinlock.h>
 #include <linux/sched.h>
 #include <linux/seq_file.h>
+#include <linux/timerqueue.h>
 #include <linux/kallsyms.h>
 #include <linux/nmi.h>
 
diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index bd0d01d00fb9..e9ca204afd28 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -21,6 +21,7 @@
 #include <linux/uaccess.h>
 #include <linux/cpumask.h>
 #include <linux/delay.h>
+#include <linux/hrtimer.h>
 #include <linux/sched/clock.h>
 #include <uapi/linux/sched/types.h>
 #include <linux/sched.h>
diff --git a/kernel/tsacct.c b/kernel/tsacct.c
index 4252f0645b9e..6b80f9db0c23 100644
--- a/kernel/tsacct.c
+++ b/kernel/tsacct.c
@@ -13,6 +13,7 @@
 #include <linux/acct.h>
 #include <linux/jiffies.h>
 #include <linux/mm.h>
+#include <linux/timekeeping.h> // for ktime_get_ns()
 
 /*
  * fill in basic accounting fields
diff --git a/kernel/ucount.c b/kernel/ucount.c
index 4aa6166cb856..74fb8c0c5126 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -7,6 +7,7 @@
 #include <linux/hash.h>
 #include <linux/kmemleak.h>
 #include <linux/user_namespace.h>
+#include <linux/uidgid.h>
 
 struct ucounts init_ucounts = {
 	.ns    = &init_user_ns,
diff --git a/kernel/user.c b/kernel/user.c
index 03cedc366dc9..28da71ea1e74 100644
--- a/kernel/user.c
+++ b/kernel/user.c
@@ -20,6 +20,8 @@
 #include <linux/user_namespace.h>
 #include <linux/binfmts.h>
 #include <linux/proc_ns.h>
+#include <linux/ratelimit.h>
+#include <linux/uidgid.h>
 
 #if IS_ENABLED(CONFIG_BINFMT_MISC)
 struct binfmt_misc init_binfmt_misc = {
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 81a8862295d6..984a954808b0 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -23,6 +23,7 @@
 #include <linux/sched/debug.h>
 #include <linux/sched/isolation.h>
 #include <linux/stop_machine.h>
+#include <linux/hrtimer.h>
 
 #include <asm/irq_regs.h>
 #include <linux/kvm_para.h>
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 9221a4c57ae1..8d3781af4396 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -40,6 +40,7 @@
 #include <linux/mempolicy.h>
 #include <linux/freezer.h>
 #include <linux/debug_locks.h>
+#include <linux/device.h>
 #include <linux/lockdep.h>
 #include <linux/idr.h>
 #include <linux/jhash.h>
diff --git a/lib/cpu_rmap.c b/lib/cpu_rmap.c
index 4c348670da31..6beb8632304e 100644
--- a/lib/cpu_rmap.c
+++ b/lib/cpu_rmap.c
@@ -7,6 +7,8 @@
 #include <linux/cpu_rmap.h>
 #include <linux/interrupt.h>
 #include <linux/export.h>
+#include <linux/kref.h>
+#include <linux/topology.h>
 
 /*
  * These functions maintain a mapping from CPUs to some ordered set of
diff --git a/lib/flex_proportions.c b/lib/flex_proportions.c
index 84ecccddc771..35784f94f0a7 100644
--- a/lib/flex_proportions.c
+++ b/lib/flex_proportions.c
@@ -34,6 +34,8 @@
  * which something happened with proportion of type j.
  */
 #include <linux/flex_proportions.h>
+#include <linux/math64.h>
+#include <linux/seqlock.h>
 
 int fprop_global_init(struct fprop_global *p, gfp_t gfp)
 {
diff --git a/lib/group_cpus.c b/lib/group_cpus.c
index ee272c4cefcc..27e49db5cfa2 100644
--- a/lib/group_cpus.c
+++ b/lib/group_cpus.c
@@ -8,6 +8,7 @@
 #include <linux/cpu.h>
 #include <linux/sort.h>
 #include <linux/group_cpus.h>
+#include <linux/topology.h> // for cpu_to_node()
 
 #ifdef CONFIG_SMP
 
diff --git a/lib/kobject.c b/lib/kobject.c
index 59dbcbdb1c91..3375f5b92baf 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -18,6 +18,8 @@
 #include <linux/stat.h>
 #include <linux/slab.h>
 #include <linux/random.h>
+#include <linux/uidgid.h>
+#include <linux/workqueue.h>
 
 /**
  * kobject_namespace() - Return @kobj's namespace tag.
diff --git a/lib/lockref.c b/lib/lockref.c
index 2afe4c5d8919..cf8795d78540 100644
--- a/lib/lockref.c
+++ b/lib/lockref.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/export.h>
 #include <linux/lockref.h>
+#include <linux/build_bug.h>
+#include <linux/spinlock.h>
 
 #if USE_CMPXCHG_LOCKREF
 
diff --git a/lib/objpool.c b/lib/objpool.c
index cfdc02420884..bce25547f931 100644
--- a/lib/objpool.c
+++ b/lib/objpool.c
@@ -7,6 +7,8 @@
 #include <linux/irqflags.h>
 #include <linux/cpumask.h>
 #include <linux/log2.h>
+#include <linux/refcount.h>
+#include <linux/topology.h>
 
 /*
  * objpool: ring-array based lockless MPMC/FIFO queues
diff --git a/lib/test_lockup.c b/lib/test_lockup.c
index c3fd87d6c2dd..3e41fc7174be 100644
--- a/lib/test_lockup.c
+++ b/lib/test_lockup.c
@@ -15,6 +15,7 @@
 #include <linux/mm.h>
 #include <linux/uaccess.h>
 #include <linux/file.h>
+#include <linux/hrtimer.h>
 
 static unsigned int time_secs;
 module_param(time_secs, uint, 0600);
diff --git a/mm/damon/sysfs-common.c b/mm/damon/sysfs-common.c
index 70edf45c2174..9217de9eb813 100644
--- a/mm/damon/sysfs-common.c
+++ b/mm/damon/sysfs-common.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/slab.h>
+#include <linux/sysfs.h>
 
 #include "sysfs-common.h"
 
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 8dbaac6e5c2d..17dfd8cf7a36 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/slab.h>
+#include <linux/sysfs.h>
 
 #include "sysfs-common.h"
 
diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 1f891e18b4ee..05962d593810 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -8,6 +8,7 @@
 #include <linux/pid.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
+#include <linux/sysfs.h>
 
 #include "sysfs-common.h"
 
diff --git a/mm/folio-compat.c b/mm/folio-compat.c
index 50412014f16f..97bcd7ea5423 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -6,6 +6,7 @@
 
 #include <linux/migrate.h>
 #include <linux/pagemap.h>
+#include <linux/ratelimit.h>
 #include <linux/rmap.h>
 #include <linux/swap.h>
 #include "internal.h"
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index fe43fbc44525..d61fcca99c02 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2,6 +2,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/mm.h>
+#include <linux/device.h>
 #include <linux/sched.h>
 #include <linux/sched/mm.h>
 #include <linux/sched/coredump.h>
diff --git a/mm/ksm.c b/mm/ksm.c
index 8c001819cf10..0ba82b05dd3f 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -35,6 +35,8 @@
 #include <linux/memory.h>
 #include <linux/mmu_notifier.h>
 #include <linux/swap.h>
+#include <linux/sysfs.h>
+#include <linux/kobject.h>
 #include <linux/ksm.h>
 #include <linux/hashtable.h>
 #include <linux/freezer.h>
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 5462d9e3c84c..58636ccd0494 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -6,6 +6,7 @@
 #include <linux/memory.h>
 #include <linux/memory-tiers.h>
 #include <linux/notifier.h>
+#include <linux/device.h>
 
 #include "internal.h"
 
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index a444e2d7dd2b..eb5098ea86c4 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -23,6 +23,7 @@
 #include <linux/vmalloc.h>
 #include <linux/ioport.h>
 #include <linux/delay.h>
+#include <linux/device.h>
 #include <linux/migrate.h>
 #include <linux/page-isolation.h>
 #include <linux/pfn.h>
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index d11dea7c5536..2bfa7f1dd9a3 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -97,6 +97,7 @@
 #include <linux/compat.h>
 #include <linux/ptrace.h>
 #include <linux/swap.h>
+#include <linux/sysfs.h>
 #include <linux/seq_file.h>
 #include <linux/proc_fs.h>
 #include <linux/migrate.h>
diff --git a/mm/workingset.c b/mm/workingset.c
index 226012974328..b1f6a8ad85ec 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -11,6 +11,7 @@
 #include <linux/shmem_fs.h>
 #include <linux/pagemap.h>
 #include <linux/atomic.h>
+#include <linux/list_lru.h>
 #include <linux/module.h>
 #include <linux/swap.h>
 #include <linux/dax.h>
diff --git a/net/can/j1939/bus.c b/net/can/j1939/bus.c
index 486687901602..da77a8940325 100644
--- a/net/can/j1939/bus.c
+++ b/net/can/j1939/bus.c
@@ -11,6 +11,8 @@
  */
 
 #include <net/sock.h>
+#include <linux/hrtimer.h>
+#include <linux/kref.h>
 
 #include "j1939-priv.h"
 
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index fe3df23a2595..fba7d1a0bd5c 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -9,6 +9,7 @@
 //                         Oleksij Rempel <kernel@pengutronix.de>
 
 #include <linux/can/skb.h>
+#include <linux/hrtimer.h>
 
 #include "j1939-priv.h"
 
diff --git a/net/ceph/string_table.c b/net/ceph/string_table.c
index 3191d9d160a2..ebdd605bb940 100644
--- a/net/ceph/string_table.c
+++ b/net/ceph/string_table.c
@@ -4,6 +4,7 @@
 #include <linux/string.h>
 #include <linux/spinlock.h>
 #include <linux/ceph/string_table.h>
+#include <linux/rbtree.h>
 
 static DEFINE_SPINLOCK(string_tree_lock);
 static struct rb_root string_tree = RB_ROOT;
diff --git a/net/sched/act_gate.c b/net/sched/act_gate.c
index c681cd011afd..08cf6001286a 100644
--- a/net/sched/act_gate.c
+++ b/net/sched/act_gate.c
@@ -10,6 +10,7 @@
 #include <linux/rtnetlink.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/hrtimer.h>
 #include <net/act_api.h>
 #include <net/netlink.h>
 #include <net/pkt_cls.h>
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index bda5327bf34d..209a82d8f1cc 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -27,6 +27,7 @@
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
+#include <linux/hrtimer.h>
 
 #include <crypto/aead.h>
 
diff --git a/samples/vfio-mdev/mtty.c b/samples/vfio-mdev/mtty.c
index 2284b3751240..c2c9b09b0cf9 100644
--- a/samples/vfio-mdev/mtty.c
+++ b/samples/vfio-mdev/mtty.c
@@ -20,6 +20,7 @@
 #include <linux/sched.h>
 #include <linux/wait.h>
 #include <linux/vfio.h>
+#include <linux/idr.h>
 #include <linux/iommu.h>
 #include <linux/sysfs.h>
 #include <linux/ctype.h>
diff --git a/security/integrity/ima/ima_mok.c b/security/integrity/ima/ima_mok.c
index 95cc31525c57..2d770de15b62 100644
--- a/security/integrity/ima/ima_mok.c
+++ b/security/integrity/ima/ima_mok.c
@@ -13,6 +13,7 @@
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/uidgid.h>
 #include <keys/system_keyring.h>
 
 
diff --git a/security/keys/proc.c b/security/keys/proc.c
index 4f4e2c1824f1..fc605b959656 100644
--- a/security/keys/proc.c
+++ b/security/keys/proc.c
@@ -10,6 +10,7 @@
 #include <linux/fs.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
+#include <linux/timekeeping.h> // for ktime_get_real_seconds()
 #include <asm/errno.h>
 #include "internal.h"
 
diff --git a/sound/soc/intel/avs/avs.h b/sound/soc/intel/avs/avs.h
index d694e08e44e1..2bbe43eb4cdd 100644
--- a/sound/soc/intel/avs/avs.h
+++ b/sound/soc/intel/avs/avs.h
@@ -12,6 +12,7 @@
 #include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/firmware.h>
+#include <linux/idr.h>
 #include <linux/kfifo.h>
 #include <sound/hda_codec.h>
 #include <sound/hda_register.h>
diff --git a/sound/soc/qcom/qdsp6/q6apm.h b/sound/soc/qcom/qdsp6/q6apm.h
index c248c8d2b1ab..5aa572a04a63 100644
--- a/sound/soc/qcom/qdsp6/q6apm.h
+++ b/sound/soc/qcom/qdsp6/q6apm.h
@@ -4,6 +4,7 @@
 #include <linux/types.h>
 #include <linux/slab.h>
 #include <linux/wait.h>
+#include <linux/idr.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/sched.h>
diff --git a/sound/soc/sof/sof-audio.h b/sound/soc/sof/sof-audio.h
index 8874ee5f557f..436c95eee19c 100644
--- a/sound/soc/sof/sof-audio.h
+++ b/sound/soc/sof/sof-audio.h
@@ -11,6 +11,7 @@
 #ifndef __SOUND_SOC_SOF_AUDIO_H
 #define __SOUND_SOC_SOF_AUDIO_H
 
+#include <linux/idr.h>
 #include <linux/workqueue.h>
 
 #include <sound/soc.h>
-- 
2.39.2


