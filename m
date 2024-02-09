Return-Path: <linux-kernel+bounces-59624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F365284F9CD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8A94287C00
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7C47F48E;
	Fri,  9 Feb 2024 16:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="RCblLCBT"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D2F7B3DA
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 16:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707496857; cv=none; b=eFqgzRWzAf5Y+jlCYBPY5JTkSx12z88CoKRwrZAOTYwfFsDxkIcmYzc9x7otaUPT6iUoVjNCDF3NzF0olT2147I94Ev3T9T+jSQs/cFJolCgT1Ps77Ngxc25GXwxsbn/hGNnDb9YCAxC9ng+Qaa1MhWkG+2XEJapOZ0AmIqipHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707496857; c=relaxed/simple;
	bh=EINUZJwko3Gf0QbcPfi08L73aK5jL2hMEANq2ElpqNc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t5Sc//owrB7Ddqpvhxr1pqsnlqxEKfWnWuYthwfKf3T9r0QT2+JSjhvIqXwCViHb1bipOIIvtLA9RMDAai/0dMk2MqwEuk9V5Y/a1IUS5Kb+hyDYDCvwSBJ77MldwouZLb+AJPdvDNVgt5bRoVOBAYHIgilxezU4BQUoqpvlexY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=RCblLCBT; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a29c4bbb2f4so144064766b.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 08:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707496849; x=1708101649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ejWZEi7TYL5VXPc1nXDBB2l6mB09poQCjbbGA7dNR0M=;
        b=RCblLCBTwlpc3nicvha+qO6TxnhZ131w167OsYzQYC1TvXqfhChmGpaacNkcFptwVa
         Z6W3sQk6wVNdMnSmBPjj75DAsff4taWMCEeF2i5h4cU3CyzsZnxxDDiDI+C/ZcmShqhM
         lu26YfqlYcLPkh5nUL+CPul/a70A3E3XEl9ZHVzW14DFcS304WPg+Keg9nPU1JO+KvU3
         YfEksQqCV8blkNywo9eML6HZAJfty/JxXoOpHIAadC1/F9upb98u4qya7Y4P0iXmgaCU
         /xsAFQ0P3PWAFiPNOd081BbPCOnL4nyHJB1ZpUcTM9ApikTK2RhLugKcxFDk+uISMaWU
         JQnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707496849; x=1708101649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ejWZEi7TYL5VXPc1nXDBB2l6mB09poQCjbbGA7dNR0M=;
        b=u5kl4qGjWA5Fh+neKsp3nAsIyJnV/yE4eiX8aqalShCoTCbIFW8O34vkhbeF7umBnZ
         qc7MqYoU30KgWXcH3+fJQsGDtI4z3ypRjLWAvUCJ6vtNXBHNIkVy4vTBGx8QhGZZLk/A
         VKrQqCCQC2TtSEttPawj9hZ5AEGiAT2XjapwSQ8x0iipW30YhV6BS3Qy0XZPl/CCeVPN
         YB2mppotvwRpwl6arInuNNT1kP/95vDFroeGMoUWAgbA8axgVeWwMyzjvLv8CZ6kK3lD
         PU3snP6/9AbU9CHrthCUHPEGRQ19NLmc9+scIen8bFoLfWeb3aA1Swzj1a5gFxchj2+j
         O/eQ==
X-Gm-Message-State: AOJu0Ywab+sOVHglwUh0LWPTv9ceoJxa+J/15gWyvLc8XsxAGVjIqXDV
	sNCHqLmQTMxgGEMzu40Zsmb/xgO1BOnnQR4019Ejej9h1jSEENkiEKbfy0qq9ufaQn2pLHG8p04
	2
X-Google-Smtp-Source: AGHT+IEiEYRUSNjKzSvf2y4xVhJFrCLc+e6HaBILBWzjakegVEr/i/4nECgAWKhtrBXVZc5l+Khq9A==
X-Received: by 2002:a17:906:169a:b0:a3c:1638:b069 with SMTP id s26-20020a170906169a00b00a3c1638b069mr136626ejd.75.1707496848169;
        Fri, 09 Feb 2024 08:40:48 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id tl27-20020a170907c31b00b00a3bfe97fe27sm477724ejc.218.2024.02.09.08.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 08:40:45 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2 05/35] kref.h: move declarations to kref_types.h
Date: Fri,  9 Feb 2024 17:39:57 +0100
Message-Id: <20240209164027.2582906-6-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240209164027.2582906-1-max.kellermann@ionos.com>
References: <20240209164027.2582906-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

By providing declarations in a lean header, we can reduce header
dependencies.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 arch/arm64/kvm/vgic/vgic.h                           |  1 +
 block/bsg-lib.c                                      |  1 +
 drivers/acpi/acpi_ipmi.c                             |  1 +
 drivers/acpi/ec.c                                    |  1 +
 drivers/ata/libata-core.c                            |  1 +
 drivers/base/core.c                                  |  1 +
 drivers/char/hw_random/core.c                        |  1 +
 drivers/char/ipmi/ipmi_msghandler.c                  |  1 +
 drivers/char/xillybus/xillyusb.c                     |  1 +
 drivers/clk/clk.c                                    |  1 +
 drivers/comedi/comedi_buf.c                          |  1 +
 drivers/comedi/comedi_fops.c                         |  1 +
 drivers/dax/bus.c                                    |  1 +
 drivers/gpu/drm/drm_auth.c                           |  1 +
 drivers/gpu/drm/drm_connector.c                      |  1 +
 drivers/gpu/drm/drm_drv.c                            |  1 +
 drivers/gpu/drm/msm/msm_gem.h                        |  1 +
 drivers/gpu/drm/nouveau/nvkm/core/memory.c           |  2 ++
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/cgrp.c      |  1 +
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/chid.c      |  2 ++
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c        |  1 +
 drivers/greybus/connection.c                         |  1 +
 drivers/greybus/operation.c                          |  1 +
 drivers/hid/hid-core.c                               |  1 +
 drivers/hid/hid-cougar.c                             |  1 +
 drivers/hid/hid-debug.c                              |  1 +
 drivers/hid/hid-logitech-dj.c                        |  1 +
 drivers/hid/wacom_sys.c                              |  1 +
 drivers/iio/buffer/industrialio-buffer-dma.c         |  1 +
 drivers/iio/industrialio-buffer.c                    |  1 +
 drivers/infiniband/core/cache.c                      |  1 +
 drivers/infiniband/core/cm.c                         |  1 +
 drivers/infiniband/core/counters.c                   |  2 ++
 drivers/infiniband/core/device.c                     |  1 +
 drivers/infiniband/core/restrack.c                   |  1 +
 drivers/infiniband/hw/erdma/erdma_cm.c               |  1 +
 drivers/infiniband/hw/erdma/erdma_qp.c               |  2 ++
 drivers/infiniband/hw/qedr/qedr_iw_cm.c              |  2 ++
 drivers/infiniband/sw/rxe/rxe_pool.h                 |  2 ++
 drivers/infiniband/sw/rxe/rxe_queue.c                |  1 +
 drivers/infiniband/sw/siw/siw.h                      |  1 +
 drivers/infiniband/ulp/isert/ib_isert.c              |  1 +
 drivers/infiniband/ulp/rtrs/rtrs.c                   |  1 +
 drivers/infiniband/ulp/srpt/ib_srpt.c                |  1 +
 drivers/media/dvb-core/dvb_ca_en50221.c              |  1 +
 drivers/media/dvb-core/dvb_frontend.c                |  1 +
 drivers/media/dvb-core/dvbdev.c                      |  1 +
 drivers/misc/genwqe/card_dev.c                       |  1 +
 drivers/mtd/mtd_blkdevs.c                            |  1 +
 .../net/ethernet/chelsio/inline_crypto/chtls/chtls.h |  1 +
 .../ethernet/chelsio/inline_crypto/chtls/chtls_cm.c  |  1 +
 drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c   |  1 +
 drivers/net/ethernet/intel/ice/ice_sriov.c           |  2 ++
 drivers/net/ethernet/intel/ice/ice_vf_lib.c          |  2 ++
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c    |  1 +
 drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c |  1 +
 drivers/net/ethernet/mellanox/mlx5/core/uar.c        |  1 +
 .../net/ethernet/netronome/nfp/nfpcore/nfp_cppcore.c |  1 +
 drivers/net/ethernet/qlogic/qede/qede_rdma.c         |  1 +
 drivers/net/pse-pd/pse_core.c                        |  1 +
 drivers/net/wireless/ath/carl9170/tx.c               |  1 +
 drivers/nvdimm/core.c                                |  1 +
 drivers/nvdimm/dimm.c                                |  1 +
 drivers/nvdimm/dimm_devs.c                           |  1 +
 drivers/of/dynamic.c                                 |  1 +
 drivers/of/unittest.c                                |  1 +
 drivers/pci/hotplug/acpiphp_glue.c                   |  1 +
 drivers/pci/slot.c                                   |  1 +
 drivers/pci/switch/switchtec.c                       |  1 +
 drivers/pcmcia/cs_internal.h                         |  2 +-
 drivers/rpmsg/mtk_rpmsg.c                            |  1 +
 drivers/rpmsg/qcom_glink_native.c                    |  1 +
 drivers/rpmsg/qcom_smd.c                             |  1 +
 drivers/rpmsg/virtio_rpmsg_bus.c                     |  1 +
 drivers/scsi/bnx2fc/bnx2fc_els.c                     |  2 ++
 drivers/scsi/bnx2fc/bnx2fc_fcoe.c                    |  1 +
 drivers/scsi/bnx2fc/bnx2fc_hwi.c                     |  2 ++
 drivers/scsi/bnx2fc/bnx2fc_io.c                      |  2 ++
 drivers/scsi/bnx2fc/bnx2fc_tgt.c                     |  2 ++
 drivers/scsi/ch.c                                    |  1 +
 drivers/scsi/cxgbi/libcxgbi.h                        |  1 +
 drivers/scsi/device_handler/scsi_dh_alua.c           |  1 +
 drivers/scsi/device_handler/scsi_dh_rdac.c           |  1 +
 drivers/scsi/elx/efct/efct_hw.c                      |  2 ++
 drivers/scsi/elx/efct/efct_io.c                      |  2 ++
 drivers/scsi/elx/efct/efct_lio.c                     |  2 ++
 drivers/scsi/elx/efct/efct_scsi.c                    |  2 ++
 drivers/scsi/elx/efct/efct_unsol.c                   |  2 ++
 drivers/scsi/elx/libefc/efc_domain.c                 |  2 ++
 drivers/scsi/elx/libefc/efc_els.c                    |  1 +
 drivers/scsi/elx/libefc/efc_node.c                   |  2 ++
 drivers/scsi/elx/libefc/efc_nport.c                  |  2 ++
 drivers/scsi/fcoe/fcoe_ctlr.c                        |  1 +
 drivers/scsi/hosts.c                                 |  1 +
 drivers/scsi/libfc/fc_disc.c                         |  1 +
 drivers/scsi/libfc/fc_exch.c                         |  1 +
 drivers/scsi/libfc/fc_lport.c                        |  1 +
 drivers/scsi/libfc/fc_rport.c                        |  1 +
 drivers/scsi/libsas/sas_internal.h                   |  1 +
 drivers/scsi/lpfc/lpfc_bsg.c                         |  1 +
 drivers/scsi/lpfc/lpfc_debugfs.c                     |  1 +
 drivers/scsi/lpfc/lpfc_els.c                         |  1 +
 drivers/scsi/lpfc/lpfc_hbadisc.c                     |  1 +
 drivers/scsi/lpfc/lpfc_init.c                        |  1 +
 drivers/scsi/lpfc/lpfc_nportdisc.c                   |  1 +
 drivers/scsi/lpfc/lpfc_nvme.c                        |  1 +
 drivers/scsi/lpfc/lpfc_nvmet.c                       |  1 +
 drivers/scsi/lpfc/lpfc_sli.c                         |  1 +
 drivers/scsi/mpi3mr/mpi3mr.h                         |  1 +
 drivers/scsi/mpt3sas/mpt3sas_base.h                  |  1 +
 drivers/scsi/qedf/qedf_els.c                         |  2 ++
 drivers/scsi/qedf/qedf_io.c                          |  1 +
 drivers/scsi/qedf/qedf_main.c                        |  1 +
 drivers/scsi/qla2xxx/qla_inline.h                    |  2 ++
 drivers/scsi/qla4xxx/ql4_isr.c                       |  2 ++
 drivers/scsi/qla4xxx/ql4_os.c                        |  1 +
 drivers/scsi/scsi_scan.c                             |  1 +
 drivers/scsi/scsi_sysfs.c                            |  1 +
 drivers/scsi/sg.c                                    |  1 +
 drivers/soc/qcom/smem_state.c                        |  1 +
 drivers/staging/greybus/authentication.c             |  1 +
 drivers/staging/greybus/fw-download.c                |  1 +
 drivers/staging/greybus/fw-management.c              |  1 +
 drivers/target/iscsi/iscsi_target.c                  |  1 +
 drivers/target/iscsi/iscsi_target_nego.c             |  1 +
 drivers/target/target_core_device.c                  |  1 +
 drivers/target/target_core_pr.c                      |  1 +
 drivers/target/target_core_tmr.c                     |  2 ++
 drivers/target/target_core_tpg.c                     |  1 +
 drivers/target/target_core_transport.c               |  1 +
 drivers/target/target_core_user.c                    |  1 +
 drivers/usb/core/config.c                            |  1 +
 drivers/usb/core/hcd.c                               |  1 +
 drivers/usb/core/hub.c                               |  1 +
 drivers/usb/core/message.c                           |  1 +
 drivers/usb/core/urb.c                               |  1 +
 drivers/usb/gadget/function/f_fs.c                   |  1 +
 drivers/usb/host/oxu210hp-hcd.c                      |  1 +
 drivers/usb/misc/usblcd.c                            |  1 +
 drivers/vfio/container.c                             |  1 +
 drivers/vhost/scsi.c                                 |  1 +
 drivers/video/fbdev/smscufx.c                        |  1 +
 drivers/xen/xen-scsiback.c                           |  1 +
 drivers/xen/xenbus/xenbus_dev_frontend.c             |  1 +
 include/drm/drm_atomic.h                             |  2 ++
 include/drm/drm_auth.h                               |  2 +-
 include/drm/drm_device.h                             |  2 +-
 include/drm/drm_framebuffer.h                        |  1 +
 include/drm/drm_mode_object.h                        |  2 +-
 include/kvm/arm_vgic.h                               |  2 +-
 include/linux/backing-dev-defs.h                     |  2 +-
 include/linux/backing-dev.h                          |  1 +
 include/linux/ceph/messenger.h                       |  2 +-
 include/linux/ceph/mon_client.h                      |  2 +-
 include/linux/ceph/osd_client.h                      |  2 +-
 include/linux/comedi/comedidev.h                     |  2 +-
 include/linux/configfs.h                             |  2 +-
 include/linux/cpu_rmap.h                             |  2 +-
 include/linux/dmaengine.h                            |  1 +
 include/linux/greybus/connection.h                   |  2 +-
 include/linux/greybus/operation.h                    |  2 +-
 include/linux/hugetlb.h                              |  2 +-
 include/linux/hw_random.h                            |  2 +-
 include/linux/iio/buffer-dma.h                       |  2 +-
 include/linux/iio/buffer_impl.h                      |  2 +-
 include/linux/interrupt.h                            |  2 +-
 include/linux/klist.h                                |  2 +-
 include/linux/kobject.h                              |  2 +-
 include/linux/kref.h                                 |  5 +----
 include/linux/kref_types.h                           | 12 ++++++++++++
 include/linux/lockd/lockd.h                          |  2 +-
 include/linux/memory-tiers.h                         |  2 +-
 include/linux/mm_inline.h                            |  4 ++++
 include/linux/mm_types.h                             |  2 +-
 include/linux/mtd/blktrans.h                         |  2 +-
 include/linux/nfs_page.h                             |  2 +-
 include/linux/relay.h                                |  2 +-
 include/linux/rpmsg.h                                |  2 +-
 include/linux/sh_clk.h                               |  2 +-
 include/linux/sunrpc/xprt.h                          |  2 +-
 include/linux/surface_aggregator/serial_hub.h        |  2 +-
 include/linux/tee_drv.h                              |  2 +-
 include/linux/usb.h                                  |  2 +-
 include/linux/usb/serial.h                           |  2 +-
 include/linux/watch_queue.h                          |  2 +-
 include/media/media-request.h                        |  1 +
 include/media/v4l2-device.h                          |  2 ++
 include/net/bluetooth/hci_core.h                     |  1 +
 include/net/tls_toe.h                                |  2 +-
 include/rdma/ib_verbs.h                              |  2 +-
 include/rdma/restrack.h                              |  2 +-
 include/rdma/uverbs_types.h                          |  1 +
 kernel/irq/manage.c                                  |  1 +
 kernel/watch_queue.c                                 |  1 +
 lib/klist.c                                          |  1 +
 lib/kobject.c                                        |  1 +
 mm/memory-tiers.c                                    |  1 +
 mm/z3fold.c                                          |  1 +
 net/can/j1939/main.c                                 |  1 +
 net/can/j1939/transport.c                            |  1 +
 net/dsa/dsa.c                                        |  1 +
 net/nfc/llcp_core.c                                  |  1 +
 net/qrtr/af_qrtr.c                                   |  1 +
 net/rds/message.c                                    |  1 +
 net/rds/rdma.c                                       |  1 +
 net/tipc/node.c                                      |  2 ++
 net/tipc/subscr.c                                    |  2 ++
 net/tipc/topsrv.c                                    |  1 +
 net/tls/tls_toe.c                                    |  1 +
 sound/soc/qcom/qdsp6/q6apm.c                         |  1 +
 210 files changed, 252 insertions(+), 42 deletions(-)
 create mode 100644 include/linux/kref_types.h

diff --git a/arch/arm64/kvm/vgic/vgic.h b/arch/arm64/kvm/vgic/vgic.h
index 8d134569d0a1..6aeffbe017c0 100644
--- a/arch/arm64/kvm/vgic/vgic.h
+++ b/arch/arm64/kvm/vgic/vgic.h
@@ -6,6 +6,7 @@
 #define __KVM_ARM_VGIC_NEW_H__
 
 #include <linux/irqchip/arm-gic-common.h>
+#include <linux/kref.h>
 #include <asm/kvm_mmu.h>
 
 #define PRODUCT_ID_KVM		0x4b	/* ASCII code K */
diff --git a/block/bsg-lib.c b/block/bsg-lib.c
index b3acdbdb6e7e..15d31c179ad7 100644
--- a/block/bsg-lib.c
+++ b/block/bsg-lib.c
@@ -9,6 +9,7 @@
 #include <linux/bsg.h>
 #include <linux/slab.h>
 #include <linux/blk-mq.h>
+#include <linux/kref.h>
 #include <linux/delay.h>
 #include <linux/scatterlist.h>
 #include <linux/bsg-lib.h>
diff --git a/drivers/acpi/acpi_ipmi.c b/drivers/acpi/acpi_ipmi.c
index 31b360db74a1..ab8e7a640d99 100644
--- a/drivers/acpi/acpi_ipmi.c
+++ b/drivers/acpi/acpi_ipmi.c
@@ -12,6 +12,7 @@
 #include <linux/completion.h>
 #include <linux/ipmi.h>
 #include <linux/spinlock.h>
+#include <linux/kref.h>
 
 MODULE_AUTHOR("Zhao Yakui");
 MODULE_DESCRIPTION("ACPI IPMI Opregion driver");
diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index bb4f4c935e60..0edab9edbc0f 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -29,6 +29,7 @@
 #include <linux/suspend.h>
 #include <linux/acpi.h>
 #include <linux/dmi.h>
+#include <linux/kref.h>
 #include <asm/io.h>
 
 #include "internal.h"
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 0e8b78e69042..0939f79e4c49 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -48,6 +48,7 @@
 #include <linux/log2.h>
 #include <linux/slab.h>
 #include <linux/glob.h>
+#include <linux/kref.h>
 #include <scsi/scsi.h>
 #include <scsi/scsi_cmnd.h>
 #include <scsi/scsi_host.h>
diff --git a/drivers/base/core.c b/drivers/base/core.c
index e3e8bbf42004..586d2bdbe0bd 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -14,6 +14,7 @@
 #include <linux/err.h>
 #include <linux/fwnode.h>
 #include <linux/init.h>
+#include <linux/kref.h>
 #include <linux/kstrtox.h>
 #include <linux/module.h>
 #include <linux/slab.h>
diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
index 415e09a77022..f60fd8242db7 100644
--- a/drivers/char/hw_random/core.c
+++ b/drivers/char/hw_random/core.c
@@ -28,6 +28,7 @@
 #include <linux/sprintf.h>
 #include <linux/string.h>
 #include <linux/uaccess.h>
+#include <linux/kref.h>
 
 #define RNG_MODULE_NAME		"hw_random"
 
diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index dee055371123..769026a866e6 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -38,6 +38,7 @@
 #include <linux/nospec.h>
 #include <linux/vmalloc.h>
 #include <linux/delay.h>
+#include <linux/kref.h>
 
 #define IPMI_DRIVER_VERSION "39.2"
 
diff --git a/drivers/char/xillybus/xillyusb.c b/drivers/char/xillybus/xillyusb.c
index 5a5afa14ca8c..37994b7b30d7 100644
--- a/drivers/char/xillybus/xillyusb.c
+++ b/drivers/char/xillybus/xillyusb.c
@@ -28,6 +28,7 @@
 #include <linux/poll.h>
 #include <linux/delay.h>
 #include <linux/usb.h>
+#include <linux/kref.h>
 
 #include "xillybus_class.h"
 
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 2253c154a824..bf9131940cb1 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -9,6 +9,7 @@
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/clk/clk-conf.h>
+#include <linux/kref.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/spinlock.h>
diff --git a/drivers/comedi/comedi_buf.c b/drivers/comedi/comedi_buf.c
index 393966c09740..ac9e8b2c58a3 100644
--- a/drivers/comedi/comedi_buf.c
+++ b/drivers/comedi/comedi_buf.c
@@ -9,6 +9,7 @@
 
 #include <linux/vmalloc.h>
 #include <linux/slab.h>
+#include <linux/kref.h>
 #include <linux/comedi/comedidev.h>
 #include "comedi_internal.h"
 
diff --git a/drivers/comedi/comedi_fops.c b/drivers/comedi/comedi_fops.c
index 8e0ab06e3494..859df6db3d9d 100644
--- a/drivers/comedi/comedi_fops.c
+++ b/drivers/comedi/comedi_fops.c
@@ -26,6 +26,7 @@
 #include <linux/fs.h>
 #include <linux/comedi/comedidev.h>
 #include <linux/cdev.h>
+#include <linux/kref.h>
 
 #include <linux/io.h>
 #include <linux/uaccess.h>
diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index ee5277a8f723..679d232a207e 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -8,6 +8,7 @@
 #include <linux/slab.h>
 #include <linux/dax.h>
 #include <linux/io.h>
+#include <linux/kref.h>
 #include "dax-private.h"
 #include "bus.h"
 #include <linux/sprintf.h>
diff --git a/drivers/gpu/drm/drm_auth.c b/drivers/gpu/drm/drm_auth.c
index 22aa015df387..5b1481720007 100644
--- a/drivers/gpu/drm/drm_auth.c
+++ b/drivers/gpu/drm/drm_auth.c
@@ -29,6 +29,7 @@
  */
 
 #include <linux/slab.h>
+#include <linux/kref.h>
 
 #include <drm/drm_auth.h>
 #include <drm/drm_drv.h>
diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index ae90134336db..2aadea38c3e0 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -36,6 +36,7 @@
 
 #include <linux/property.h>
 #include <linux/uaccess.h>
+#include <linux/kref.h>
 
 #include <video/cmdline.h>
 
diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index 06f96722c02e..b4abe1edadeb 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -35,6 +35,7 @@
 #include <linux/slab.h>
 #include <linux/sprintf.h>
 #include <linux/srcu.h>
+#include <linux/kref.h>
 
 #include <drm/drm_accel.h>
 #include <drm/drm_cache.h>
diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_gem.h
index 8d414b072c29..735963ce4e6e 100644
--- a/drivers/gpu/drm/msm/msm_gem.h
+++ b/drivers/gpu/drm/msm/msm_gem.h
@@ -9,6 +9,7 @@
 
 #include <linux/kref.h>
 #include <linux/dma-resv.h>
+#include <linux/ratelimit.h>
 #include "drm/drm_exec.h"
 #include "drm/gpu_scheduler.h"
 #include "msm_drv.h"
diff --git a/drivers/gpu/drm/nouveau/nvkm/core/memory.c b/drivers/gpu/drm/nouveau/nvkm/core/memory.c
index a705c2dfca80..a40cd36d0d7d 100644
--- a/drivers/gpu/drm/nouveau/nvkm/core/memory.c
+++ b/drivers/gpu/drm/nouveau/nvkm/core/memory.c
@@ -26,6 +26,8 @@
 #include <subdev/fb.h>
 #include <subdev/instmem.h>
 
+#include <linux/kref.h>
+
 void
 nvkm_memory_tags_put(struct nvkm_memory *memory, struct nvkm_device *device,
 		     struct nvkm_tags **ptags)
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/cgrp.c b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/cgrp.c
index 814db9daa194..190e1227c342 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/cgrp.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/cgrp.c
@@ -27,6 +27,7 @@
 
 #include <core/gpuobj.h>
 #include <subdev/mmu.h>
+#include <linux/kref.h>
 
 static void
 nvkm_cgrp_ectx_put(struct nvkm_cgrp *cgrp, struct nvkm_ectx **pectx)
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/chid.c b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/chid.c
index 23944d95efd5..f7b4da9d231e 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/chid.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/chid.c
@@ -21,6 +21,8 @@
  */
 #include "chid.h"
 
+#include <linux/kref.h>
+
 void
 nvkm_chid_put(struct nvkm_chid *chid, int id, spinlock_t *data_lock)
 {
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c
index 3234082e9dfe..2671874418f9 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c
@@ -24,6 +24,7 @@
 #include <linux/sprintf.h>
 
 #include <subdev/fb.h>
+#include <linux/kref.h>
 
 static void
 nvkm_vmm_pt_del(struct nvkm_vmm_pt **ppgt)
diff --git a/drivers/greybus/connection.c b/drivers/greybus/connection.c
index 1f20315b50e6..58cad347c6aa 100644
--- a/drivers/greybus/connection.c
+++ b/drivers/greybus/connection.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/workqueue.h>
+#include <linux/kref.h>
 #include <linux/greybus.h>
 #include <linux/sprintf.h>
 
diff --git a/drivers/greybus/operation.c b/drivers/greybus/operation.c
index d1c7de8f0005..4ccd2fe75eea 100644
--- a/drivers/greybus/operation.c
+++ b/drivers/greybus/operation.c
@@ -14,6 +14,7 @@
 #include <linux/workqueue.h>
 #include <linux/greybus.h>
 #include <linux/completion.h>
+#include <linux/kref.h>
 
 #include "greybus_trace.h"
 
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index f0fdd4cae9c0..9d5611a74890 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -17,6 +17,7 @@
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/kref.h>
 #include <linux/list.h>
 #include <linux/mm.h>
 #include <linux/spinlock.h>
diff --git a/drivers/hid/hid-cougar.c b/drivers/hid/hid-cougar.c
index cb8bd8aae15b..2452cddc96c3 100644
--- a/drivers/hid/hid-cougar.c
+++ b/drivers/hid/hid-cougar.c
@@ -8,6 +8,7 @@
 #include <linux/hid.h>
 #include <linux/module.h>
 #include <linux/printk.h>
+#include <linux/kref.h>
 
 #include "hid-ids.h"
 
diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
index c4044de0d253..c4845c6d5db7 100644
--- a/drivers/hid/hid-debug.c
+++ b/drivers/hid/hid-debug.c
@@ -19,6 +19,7 @@
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
 #include <linux/kfifo.h>
+#include <linux/kref.h>
 #include <linux/sched/signal.h>
 #include <linux/export.h>
 #include <linux/slab.h>
diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
index 382a256dc75f..5dcef9b5cca4 100644
--- a/drivers/hid/hid-logitech-dj.c
+++ b/drivers/hid/hid-logitech-dj.c
@@ -11,6 +11,7 @@
 #include <linux/hid.h>
 #include <linux/module.h>
 #include <linux/kfifo.h>
+#include <linux/kref.h>
 #include <linux/delay.h>
 #include <linux/sprintf.h>
 #include <linux/usb.h> /* For to_usb_interface for kvm extra intf check */
diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 6c10e5b5cae0..35bcd621590c 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -6,6 +6,7 @@
 #include "wacom_wac.h"
 #include "wacom.h"
 #include <linux/input/mt.h>
+#include <linux/kref.h>
 #include <linux/kstrtox.h>
 #include <linux/sprintf.h>
 
diff --git a/drivers/iio/buffer/industrialio-buffer-dma.c b/drivers/iio/buffer/industrialio-buffer-dma.c
index 5610ba67925e..e60eaf64157b 100644
--- a/drivers/iio/buffer/industrialio-buffer-dma.c
+++ b/drivers/iio/buffer/industrialio-buffer-dma.c
@@ -6,6 +6,7 @@
 
 #include <linux/slab.h>
 #include <linux/kernel.h>
+#include <linux/kref.h>
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/workqueue.h>
diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index cf23286e349c..f4d0a7b65067 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -21,6 +21,7 @@
 #include <linux/poll.h>
 #include <linux/sched/signal.h>
 #include <linux/sprintf.h>
+#include <linux/kref.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/iio-opaque.h>
diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index c02a96d3572a..0e93a2c47a36 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -38,6 +38,7 @@
 #include <linux/slab.h>
 #include <linux/workqueue.h>
 #include <linux/netdevice.h>
+#include <linux/kref.h>
 #include <net/addrconf.h>
 
 #include <rdma/ib_cache.h>
diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index ff58058aeadc..9ce6e86c0ab4 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -10,6 +10,7 @@
 #include <linux/completion.h>
 #include <linux/dma-mapping.h>
 #include <linux/device.h>
+#include <linux/kref.h>
 #include <linux/module.h>
 #include <linux/err.h>
 #include <linux/idr.h>
diff --git a/drivers/infiniband/core/counters.c b/drivers/infiniband/core/counters.c
index af59486fe418..e6be9912ccd3 100644
--- a/drivers/infiniband/core/counters.c
+++ b/drivers/infiniband/core/counters.c
@@ -8,6 +8,8 @@
 #include "core_priv.h"
 #include "restrack.h"
 
+#include <linux/kref.h>
+
 #define ALL_AUTO_MODE_MASKS (RDMA_COUNTER_MASK_QP_TYPE | RDMA_COUNTER_MASK_PID)
 
 static int __counter_set_mode(struct rdma_port_counter *port_counter,
diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index c3e468184fa7..f2ab1a5e432e 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -36,6 +36,7 @@
 #include <linux/string.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
+#include <linux/kref.h>
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/netdevice.h>
diff --git a/drivers/infiniband/core/restrack.c b/drivers/infiniband/core/restrack.c
index a67620d86416..8cffa2c73110 100644
--- a/drivers/infiniband/core/restrack.c
+++ b/drivers/infiniband/core/restrack.c
@@ -11,6 +11,7 @@
 #include <linux/sched/task.h>
 #include <linux/pid_namespace.h>
 #include <linux/completion.h>
+#include <linux/kref.h>
 
 #include "cma_priv.h"
 #include "restrack.h"
diff --git a/drivers/infiniband/hw/erdma/erdma_cm.c b/drivers/infiniband/hw/erdma/erdma_cm.c
index 771059a8eb7d..92dc689691d8 100644
--- a/drivers/infiniband/hw/erdma/erdma_cm.c
+++ b/drivers/infiniband/hw/erdma/erdma_cm.c
@@ -11,6 +11,7 @@
 /* Copyright (c) 2017, Open Grid Computing, Inc. */
 
 #include <linux/workqueue.h>
+#include <linux/kref.h>
 #include <trace/events/sock.h>
 
 #include "erdma.h"
diff --git a/drivers/infiniband/hw/erdma/erdma_qp.c b/drivers/infiniband/hw/erdma/erdma_qp.c
index 544bb5143acf..32538a737840 100644
--- a/drivers/infiniband/hw/erdma/erdma_qp.c
+++ b/drivers/infiniband/hw/erdma/erdma_qp.c
@@ -11,6 +11,8 @@
 #include <linux/completion.h>
 #include <linux/kernel.h> // for upper_32_bits(), lower_32_bits()
 
+#include <linux/kref.h>
+
 void erdma_qp_llp_close(struct erdma_qp *qp)
 {
 	struct erdma_qp_attrs qp_attrs;
diff --git a/drivers/infiniband/hw/qedr/qedr_iw_cm.c b/drivers/infiniband/hw/qedr/qedr_iw_cm.c
index ae2866761faa..006572fbdac6 100644
--- a/drivers/infiniband/hw/qedr/qedr_iw_cm.c
+++ b/drivers/infiniband/hw/qedr/qedr_iw_cm.c
@@ -40,6 +40,8 @@
 #include "qedr_iw_cm.h"
 #include <linux/completion.h>
 
+#include <linux/kref.h>
+
 static inline void
 qedr_fill_sockaddr4(const struct qed_iwarp_cm_info *cm_info,
 		    struct iw_cm_event *event)
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
index b42e26427a70..15b0084b534e 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.h
+++ b/drivers/infiniband/sw/rxe/rxe_pool.h
@@ -7,6 +7,8 @@
 #ifndef RXE_POOL_H
 #define RXE_POOL_H
 
+#include <linux/kref.h>
+
 enum rxe_elem_type {
 	RXE_TYPE_UC,
 	RXE_TYPE_PD,
diff --git a/drivers/infiniband/sw/rxe/rxe_queue.c b/drivers/infiniband/sw/rxe/rxe_queue.c
index 9611ee191a46..50c8865f313e 100644
--- a/drivers/infiniband/sw/rxe/rxe_queue.c
+++ b/drivers/infiniband/sw/rxe/rxe_queue.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/vmalloc.h>
+#include <linux/kref.h>
 #include "rxe.h"
 #include "rxe_loc.h"
 #include "rxe_queue.h"
diff --git a/drivers/infiniband/sw/siw/siw.h b/drivers/infiniband/sw/siw/siw.h
index 75253f2b3e3d..a8aaa1c55a30 100644
--- a/drivers/infiniband/sw/siw/siw.h
+++ b/drivers/infiniband/sw/siw/siw.h
@@ -10,6 +10,7 @@
 #include <rdma/restrack.h>
 #include <linux/socket.h>
 #include <linux/skbuff.h>
+#include <linux/kref.h>
 #include <crypto/hash.h>
 #include <linux/crc32.h>
 #include <linux/crc32c.h>
diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
index 399f2560bbc6..ef3f1f974eae 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -14,6 +14,7 @@
 #include <linux/socket.h>
 #include <linux/in.h>
 #include <linux/in6.h>
+#include <linux/kref.h>
 #include <linux/kstrtox.h>
 #include <rdma/ib_verbs.h>
 #include <rdma/ib_cm.h>
diff --git a/drivers/infiniband/ulp/rtrs/rtrs.c b/drivers/infiniband/ulp/rtrs/rtrs.c
index 49e04e3ddb56..b34f5b848511 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs.c
@@ -11,6 +11,7 @@
 
 #include <linux/module.h>
 #include <linux/inet.h>
+#include <linux/kref.h>
 #include <linux/sprintf.h>
 
 #include "rtrs-pri.h"
diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index 6fb457fe9a42..125f478bc3d9 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -40,6 +40,7 @@
 #include <linux/ctype.h>
 #include <linux/hex.h>
 #include <linux/kthread.h>
+#include <linux/kref.h>
 #include <linux/sprintf.h>
 #include <linux/string.h>
 #include <linux/delay.h>
diff --git a/drivers/media/dvb-core/dvb_ca_en50221.c b/drivers/media/dvb-core/dvb_ca_en50221.c
index baf64540dc00..2fe271dca822 100644
--- a/drivers/media/dvb-core/dvb_ca_en50221.c
+++ b/drivers/media/dvb-core/dvb_ca_en50221.c
@@ -26,6 +26,7 @@
 #include <linux/spinlock.h>
 #include <linux/sched/signal.h>
 #include <linux/kthread.h>
+#include <linux/kref.h>
 
 #include <media/dvb_ca_en50221.h>
 #include <media/dvb_ringbuffer.h>
diff --git a/drivers/media/dvb-core/dvb_frontend.c b/drivers/media/dvb-core/dvb_frontend.c
index 93d3378a0df4..964a3e429d12 100644
--- a/drivers/media/dvb-core/dvb_frontend.c
+++ b/drivers/media/dvb-core/dvb_frontend.c
@@ -22,6 +22,7 @@
 #include <linux/slab.h>
 #include <linux/poll.h>
 #include <linux/semaphore.h>
+#include <linux/kref.h>
 #include <linux/module.h>
 #include <linux/nospec.h>
 #include <linux/list.h>
diff --git a/drivers/media/dvb-core/dvbdev.c b/drivers/media/dvb-core/dvbdev.c
index 0b81b9ebc77f..703784ff4ba4 100644
--- a/drivers/media/dvb-core/dvbdev.c
+++ b/drivers/media/dvb-core/dvbdev.c
@@ -22,6 +22,7 @@
 #include <linux/fs.h>
 #include <linux/cdev.h>
 #include <linux/mutex.h>
+#include <linux/kref.h>
 #include <media/dvbdev.h>
 
 /* Due to enum tuner_pad_index */
diff --git a/drivers/misc/genwqe/card_dev.c b/drivers/misc/genwqe/card_dev.c
index 4441aca2280a..a2a2dd307942 100644
--- a/drivers/misc/genwqe/card_dev.c
+++ b/drivers/misc/genwqe/card_dev.c
@@ -25,6 +25,7 @@
 #include <linux/wait.h>
 #include <linux/delay.h>
 #include <linux/atomic.h>
+#include <linux/kref.h>
 
 #include "card_base.h"
 #include "card_ddcb.h"
diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
index cb09e9fe5c6a..c2e0dfaf2801 100644
--- a/drivers/mtd/mtd_blkdevs.c
+++ b/drivers/mtd/mtd_blkdevs.c
@@ -21,6 +21,7 @@
 #include <linux/mutex.h>
 #include <linux/sprintf.h>
 #include <linux/uaccess.h>
+#include <linux/kref.h>
 
 #include "mtdcore.h"
 
diff --git a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls.h b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls.h
index 7ff82b6778ba..946e03bf687b 100644
--- a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls.h
+++ b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls.h
@@ -20,6 +20,7 @@
 #include <crypto/scatterwalk.h>
 #include <crypto/internal/hash.h>
 #include <linux/tls.h>
+#include <linux/kref.h>
 #include <net/tls.h>
 #include <net/tls_prot.h>
 #include <net/tls_toe.h>
diff --git a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c
index 6f6525983130..fcff72267c1c 100644
--- a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c
+++ b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c
@@ -14,6 +14,7 @@
 #include <linux/inetdevice.h>
 #include <linux/ip.h>
 #include <linux/tcp.h>
+#include <linux/kref.h>
 #include <linux/sched/signal.h>
 #include <linux/kallsyms.h>
 #include <linux/kprobes.h>
diff --git a/drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c b/drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c
index 854d87e1125c..e1d418aa5253 100644
--- a/drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c
+++ b/drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c
@@ -47,6 +47,7 @@
 #include <linux/skbuff.h>
 #include <linux/pci.h>
 #include <linux/scatterlist.h>
+#include <linux/kref.h>
 
 #include "libcxgb_ppm.h"
 
diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index a94a1c48c3de..fd87757bad43 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -14,6 +14,8 @@
 #include "ice_vf_vsi_vlan_ops.h"
 #include "ice_vlan.h"
 
+#include <linux/kref.h>
+
 /**
  * ice_free_vf_entries - Free all VF entries from the hash table
  * @pf: pointer to the PF structure
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
index 2ffdae9a82df..604effc72bb8 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
@@ -7,6 +7,8 @@
 #include "ice_fltr.h"
 #include "ice_virtchnl_allowlist.h"
 
+#include <linux/kref.h>
+
 /* Public functions which may be accessed by all driver files */
 
 /**
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
index 7a48d6ab5478..a726290264c2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
@@ -36,6 +36,7 @@
 #include <linux/mlx5/driver.h>
 #include <linux/mlx5/eswitch.h>
 #include <linux/mlx5/vport.h>
+#include <linux/kref.h>
 #include "lib/devcom.h"
 #include "mlx5_core.h"
 #include "eswitch.h"
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
index e7d59cfa8708..dbe7fb20fbc6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
@@ -3,6 +3,7 @@
 
 #include <linux/mlx5/vport.h>
 #include <linux/list.h>
+#include <linux/kref.h>
 #include "lib/devcom.h"
 #include "mlx5_core.h"
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/uar.c b/drivers/net/ethernet/mellanox/mlx5/core/uar.c
index 1513112ecec8..a34567921588 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/uar.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/uar.c
@@ -31,6 +31,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/kref.h>
 #include <linux/mlx5/driver.h>
 #include "mlx5_core.h"
 
diff --git a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_cppcore.c b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_cppcore.c
index a8286d0032d1..79e2585caea2 100644
--- a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_cppcore.c
+++ b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_cppcore.c
@@ -19,6 +19,7 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/wait.h>
+#include <linux/kref.h>
 
 #include "nfp_arm.h"
 #include "nfp_cpp.h"
diff --git a/drivers/net/ethernet/qlogic/qede/qede_rdma.c b/drivers/net/ethernet/qlogic/qede/qede_rdma.c
index 970c90725856..bdc131b36363 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_rdma.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_rdma.c
@@ -7,6 +7,7 @@
 #include <linux/pci.h>
 #include <linux/netdevice.h>
 #include <linux/list.h>
+#include <linux/kref.h>
 #include <linux/mutex.h>
 #include <linux/qed/qede_rdma.h>
 #include "qede.h"
diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 146b81f08a89..a1e8b7f6e1f6 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -8,6 +8,7 @@
 #include <linux/device.h>
 #include <linux/of.h>
 #include <linux/pse-pd/pse.h>
+#include <linux/kref.h>
 
 static DEFINE_MUTEX(pse_list_mutex);
 static LIST_HEAD(pse_controller_list);
diff --git a/drivers/net/wireless/ath/carl9170/tx.c b/drivers/net/wireless/ath/carl9170/tx.c
index 812604601ae4..6cfdef09e5bf 100644
--- a/drivers/net/wireless/ath/carl9170/tx.c
+++ b/drivers/net/wireless/ath/carl9170/tx.c
@@ -40,6 +40,7 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/etherdevice.h>
+#include <linux/kref.h>
 #include <net/mac80211.h>
 #include "carl9170.h"
 #include "hw.h"
diff --git a/drivers/nvdimm/core.c b/drivers/nvdimm/core.c
index 7e083d3e1274..f1416032dd04 100644
--- a/drivers/nvdimm/core.c
+++ b/drivers/nvdimm/core.c
@@ -16,6 +16,7 @@
 #include <linux/mutex.h>
 #include <linux/slab.h>
 #include <linux/io.h>
+#include <linux/kref.h>
 #include "nd-core.h"
 #include "nd.h"
 
diff --git a/drivers/nvdimm/dimm.c b/drivers/nvdimm/dimm.c
index 91d9163ee303..4013e842ac1f 100644
--- a/drivers/nvdimm/dimm.c
+++ b/drivers/nvdimm/dimm.c
@@ -10,6 +10,7 @@
 #include <linux/slab.h>
 #include <linux/mm.h>
 #include <linux/nd.h>
+#include <linux/kref.h>
 #include "label.h"
 #include "nd.h"
 
diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
index caf8646b27db..4826a36fcb2e 100644
--- a/drivers/nvdimm/dimm_devs.c
+++ b/drivers/nvdimm/dimm_devs.c
@@ -12,6 +12,7 @@
 #include <linux/io.h>
 #include <linux/fs.h>
 #include <linux/mm.h>
+#include <linux/kref.h>
 #include "nd-core.h"
 #include "label.h"
 #include "pmem.h"
diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index 9effc63f8ae4..86f181924937 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -15,6 +15,7 @@
 #include <linux/sprintf.h>
 #include <linux/string.h>
 #include <linux/proc_fs.h>
+#include <linux/kref.h>
 
 #include "of_private.h"
 
diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 2c97d90ae5e2..ba0b0b238083 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -11,6 +11,7 @@
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/hashtable.h>
+#include <linux/kref.h>
 #include <linux/libfdt.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index 5b1f271c6034..7cf646925192 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -37,6 +37,7 @@
 #include <linux/mutex.h>
 #include <linux/slab.h>
 #include <linux/acpi.h>
+#include <linux/kref.h>
 
 #include "../pci.h"
 #include "acpiphp.h"
diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
index 9f14687700bf..b63c980b0932 100644
--- a/drivers/pci/slot.c
+++ b/drivers/pci/slot.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/err.h>
+#include <linux/kref.h>
 #include "pci.h"
 #include <linux/sprintf.h>
 
diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index eea031b3f0ef..b971519e5756 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -16,6 +16,7 @@
 #include <linux/wait.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/nospec.h>
+#include <linux/kref.h>
 
 MODULE_DESCRIPTION("Microsemi Switchtec(tm) PCIe Management Driver");
 MODULE_VERSION("0.1");
diff --git a/drivers/pcmcia/cs_internal.h b/drivers/pcmcia/cs_internal.h
index 04a9f4060740..0f9b12511e22 100644
--- a/drivers/pcmcia/cs_internal.h
+++ b/drivers/pcmcia/cs_internal.h
@@ -18,7 +18,7 @@
 #define _LINUX_CS_INTERNAL_H
 
 #include <linux/ioport.h> // for struct resource
-#include <linux/kref.h>
+#include <linux/kref_types.h>
 
 /* Flags in client state */
 #define CLIENT_WIN_REQ(i)	(0x1<<(i))
diff --git a/drivers/rpmsg/mtk_rpmsg.c b/drivers/rpmsg/mtk_rpmsg.c
index d1213c33da20..c3a099ab2508 100644
--- a/drivers/rpmsg/mtk_rpmsg.c
+++ b/drivers/rpmsg/mtk_rpmsg.c
@@ -10,6 +10,7 @@
 #include <linux/rpmsg/mtk_rpmsg.h>
 #include <linux/slab.h>
 #include <linux/workqueue.h>
+#include <linux/kref.h>
 
 #include "rpmsg_internal.h"
 
diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
index bb9df423f1c7..9ad2f4f7cf03 100644
--- a/drivers/rpmsg/qcom_glink_native.c
+++ b/drivers/rpmsg/qcom_glink_native.c
@@ -20,6 +20,7 @@
 #include <linux/workqueue.h>
 #include <linux/mailbox_client.h>
 #include <linux/completion.h>
+#include <linux/kref.h>
 
 #include "rpmsg_internal.h"
 #include "qcom_glink_native.h"
diff --git a/drivers/rpmsg/qcom_smd.c b/drivers/rpmsg/qcom_smd.c
index 87d81788dfc9..4f7b3b2a8b7e 100644
--- a/drivers/rpmsg/qcom_smd.c
+++ b/drivers/rpmsg/qcom_smd.c
@@ -21,6 +21,7 @@
 #include <linux/wait.h>
 #include <linux/rpmsg.h>
 #include <linux/rpmsg/qcom_smd.h>
+#include <linux/kref.h>
 
 #include "rpmsg_internal.h"
 
diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index 1062939c3264..7cd43e2bb13a 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -15,6 +15,7 @@
 #include <linux/idr.h>
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
+#include <linux/kref.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/rpmsg.h>
diff --git a/drivers/scsi/bnx2fc/bnx2fc_els.c b/drivers/scsi/bnx2fc/bnx2fc_els.c
index 754f2e82d955..3b1a9ac9fd9c 100644
--- a/drivers/scsi/bnx2fc/bnx2fc_els.c
+++ b/drivers/scsi/bnx2fc/bnx2fc_els.c
@@ -16,6 +16,8 @@
 
 #include "bnx2fc.h"
 
+#include <linux/kref.h>
+
 static void bnx2fc_logo_resp(struct fc_seq *seq, struct fc_frame *fp,
 			     void *arg);
 static void bnx2fc_flogi_resp(struct fc_seq *seq, struct fc_frame *fp,
diff --git a/drivers/scsi/bnx2fc/bnx2fc_fcoe.c b/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
index 9727c4d67f08..1535f84c7796 100644
--- a/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
+++ b/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
@@ -20,6 +20,7 @@
 #include <linux/sprintf.h>
 
 #include <linux/ethtool.h>
+#include <linux/kref.h>
 
 static struct list_head adapter_list;
 static struct list_head if_list;
diff --git a/drivers/scsi/bnx2fc/bnx2fc_hwi.c b/drivers/scsi/bnx2fc/bnx2fc_hwi.c
index 6fcbe30d8239..754ed78ac09d 100644
--- a/drivers/scsi/bnx2fc/bnx2fc_hwi.c
+++ b/drivers/scsi/bnx2fc/bnx2fc_hwi.c
@@ -16,6 +16,8 @@
 #include "bnx2fc.h"
 #include <linux/completion.h>
 
+#include <linux/kref.h>
+
 DECLARE_PER_CPU(struct bnx2fc_percpu_s, bnx2fc_percpu);
 
 static void bnx2fc_fastpath_notification(struct bnx2fc_hba *hba,
diff --git a/drivers/scsi/bnx2fc/bnx2fc_io.c b/drivers/scsi/bnx2fc/bnx2fc_io.c
index 8d9b7ebecd32..20a91f4be034 100644
--- a/drivers/scsi/bnx2fc/bnx2fc_io.c
+++ b/drivers/scsi/bnx2fc/bnx2fc_io.c
@@ -15,6 +15,8 @@
 #include "bnx2fc.h"
 #include <linux/completion.h>
 
+#include <linux/kref.h>
+
 #define RESERVE_FREE_LIST_INDEX num_possible_cpus()
 
 static int bnx2fc_split_bd(struct bnx2fc_cmd *io_req, u64 addr, int sg_len,
diff --git a/drivers/scsi/bnx2fc/bnx2fc_tgt.c b/drivers/scsi/bnx2fc/bnx2fc_tgt.c
index df1e76420cce..d67658628bfe 100644
--- a/drivers/scsi/bnx2fc/bnx2fc_tgt.c
+++ b/drivers/scsi/bnx2fc/bnx2fc_tgt.c
@@ -15,6 +15,8 @@
 
 #include "bnx2fc.h"
 #include <linux/completion.h>
+#include <linux/kref.h>
+
 static void bnx2fc_upld_timer(struct timer_list *t);
 static void bnx2fc_ofld_timer(struct timer_list *t);
 static int bnx2fc_init_tgt(struct bnx2fc_rport *tgt,
diff --git a/drivers/scsi/ch.c b/drivers/scsi/ch.c
index 4480bffb826f..a2bbeeda85ba 100644
--- a/drivers/scsi/ch.c
+++ b/drivers/scsi/ch.c
@@ -25,6 +25,7 @@
 #include <linux/mutex.h>
 #include <linux/idr.h>
 #include <linux/slab.h>
+#include <linux/kref.h>
 
 #include <scsi/scsi.h>
 #include <scsi/scsi_cmnd.h>
diff --git a/drivers/scsi/cxgbi/libcxgbi.h b/drivers/scsi/cxgbi/libcxgbi.h
index d92cf1dccc2f..d33f45d78dbe 100644
--- a/drivers/scsi/cxgbi/libcxgbi.h
+++ b/drivers/scsi/cxgbi/libcxgbi.h
@@ -15,6 +15,7 @@
 #define	__LIBCXGBI_H__
 
 #include <linux/kernel.h>
+#include <linux/kref.h>
 #include <linux/errno.h>
 #include <linux/types.h>
 #include <linux/debugfs.h>
diff --git a/drivers/scsi/device_handler/scsi_dh_alua.c b/drivers/scsi/device_handler/scsi_dh_alua.c
index b277d67b9473..2cc10ac336f6 100644
--- a/drivers/scsi/device_handler/scsi_dh_alua.c
+++ b/drivers/scsi/device_handler/scsi_dh_alua.c
@@ -7,6 +7,7 @@
  */
 #include <linux/slab.h>
 #include <linux/delay.h>
+#include <linux/kref.h>
 #include <linux/module.h>
 #include <asm/unaligned.h>
 #include <linux/sprintf.h>
diff --git a/drivers/scsi/device_handler/scsi_dh_rdac.c b/drivers/scsi/device_handler/scsi_dh_rdac.c
index f8a09e3eba58..584c3eb2a34f 100644
--- a/drivers/scsi/device_handler/scsi_dh_rdac.c
+++ b/drivers/scsi/device_handler/scsi_dh_rdac.c
@@ -25,6 +25,7 @@
 #include <linux/workqueue.h>
 #include <linux/slab.h>
 #include <linux/module.h>
+#include <linux/kref.h>
 
 #define RDAC_NAME "rdac"
 #define RDAC_RETRY_COUNT 5
diff --git a/drivers/scsi/elx/efct/efct_hw.c b/drivers/scsi/elx/efct/efct_hw.c
index c49768b8375d..a8714af4c73b 100644
--- a/drivers/scsi/elx/efct/efct_hw.c
+++ b/drivers/scsi/elx/efct/efct_hw.c
@@ -10,6 +10,8 @@
 #include <linux/kernel.h> // for upper_32_bits(), lower_32_bits()
 #include <linux/kstrtox.h>
 
+#include <linux/kref.h>
+
 struct efct_hw_link_stat_cb_arg {
 	void (*cb)(int status, u32 num_counters,
 		   struct efct_hw_link_stat_counts *counters, void *arg);
diff --git a/drivers/scsi/elx/efct/efct_io.c b/drivers/scsi/elx/efct/efct_io.c
index c612f0a48839..bc2a8361b32c 100644
--- a/drivers/scsi/elx/efct/efct_io.c
+++ b/drivers/scsi/elx/efct/efct_io.c
@@ -8,6 +8,8 @@
 #include "efct_hw.h"
 #include "efct_io.h"
 
+#include <linux/kref.h>
+
 struct efct_io_pool {
 	struct efct *efct;
 	spinlock_t lock;	/* IO pool lock */
diff --git a/drivers/scsi/elx/efct/efct_lio.c b/drivers/scsi/elx/efct/efct_lio.c
index 5c57821cf031..f35607708c13 100644
--- a/drivers/scsi/elx/efct/efct_lio.c
+++ b/drivers/scsi/elx/efct/efct_lio.c
@@ -11,6 +11,8 @@
 #include <linux/kstrtox.h>
 #include <linux/sprintf.h>
 
+#include <linux/kref.h>
+
 /*
  * lio_wq is used to call the LIO backed during creation or deletion of
  * sessions. This brings serialization to the session management as we create
diff --git a/drivers/scsi/elx/efct/efct_scsi.c b/drivers/scsi/elx/efct/efct_scsi.c
index f0f0b696fd77..ea106a7c67eb 100644
--- a/drivers/scsi/elx/efct/efct_scsi.c
+++ b/drivers/scsi/elx/efct/efct_scsi.c
@@ -8,6 +8,8 @@
 #include "efct_hw.h"
 #include <linux/kernel.h> // for upper_32_bits(), lower_32_bits()
 
+#include <linux/kref.h>
+
 #define enable_tsend_auto_resp(efct)	1
 #define enable_treceive_auto_resp(efct)	0
 
diff --git a/drivers/scsi/elx/efct/efct_unsol.c b/drivers/scsi/elx/efct/efct_unsol.c
index e6addab66a60..51db356a5122 100644
--- a/drivers/scsi/elx/efct/efct_unsol.c
+++ b/drivers/scsi/elx/efct/efct_unsol.c
@@ -7,6 +7,8 @@
 #include "efct_driver.h"
 #include "efct_unsol.h"
 
+#include <linux/kref.h>
+
 #define frame_printf(efct, hdr, fmt, ...) \
 	do { \
 		char s_id_text[16]; \
diff --git a/drivers/scsi/elx/libefc/efc_domain.c b/drivers/scsi/elx/libefc/efc_domain.c
index 29363c07130f..ae5386b51af8 100644
--- a/drivers/scsi/elx/libefc/efc_domain.c
+++ b/drivers/scsi/elx/libefc/efc_domain.c
@@ -11,6 +11,8 @@
 #include "efc.h"
 #include <linux/sprintf.h>
 
+#include <linux/kref.h>
+
 int
 efc_domain_cb(void *arg, int event, void *data)
 {
diff --git a/drivers/scsi/elx/libefc/efc_els.c b/drivers/scsi/elx/libefc/efc_els.c
index 84bc81d7ce76..49d1446b826a 100644
--- a/drivers/scsi/elx/libefc/efc_els.c
+++ b/drivers/scsi/elx/libefc/efc_els.c
@@ -11,6 +11,7 @@
 #include "efc.h"
 #include "efc_els.h"
 #include "../libefc_sli/sli4.h"
+#include <linux/kref.h>
 
 #define EFC_LOG_ENABLE_ELS_TRACE(efc)		\
 		(((efc) != NULL) ? (((efc)->logmask & (1U << 1)) != 0) : 0)
diff --git a/drivers/scsi/elx/libefc/efc_node.c b/drivers/scsi/elx/libefc/efc_node.c
index c8a971b3b666..3004a954586d 100644
--- a/drivers/scsi/elx/libefc/efc_node.c
+++ b/drivers/scsi/elx/libefc/efc_node.c
@@ -7,6 +7,8 @@
 #include "efc.h"
 #include <linux/sprintf.h>
 
+#include <linux/kref.h>
+
 int
 efc_remote_node_cb(void *arg, int event, void *data)
 {
diff --git a/drivers/scsi/elx/libefc/efc_nport.c b/drivers/scsi/elx/libefc/efc_nport.c
index 01de5c0e6106..ee90c44c6618 100644
--- a/drivers/scsi/elx/libefc/efc_nport.c
+++ b/drivers/scsi/elx/libefc/efc_nport.c
@@ -28,6 +28,8 @@
 #include "efc.h"
 #include <linux/sprintf.h>
 
+#include <linux/kref.h>
+
 void
 efc_nport_cb(void *arg, int event, void *data)
 {
diff --git a/drivers/scsi/fcoe/fcoe_ctlr.c b/drivers/scsi/fcoe/fcoe_ctlr.c
index 19eee108db02..06aed8faebd5 100644
--- a/drivers/scsi/fcoe/fcoe_ctlr.c
+++ b/drivers/scsi/fcoe/fcoe_ctlr.c
@@ -20,6 +20,7 @@
 #include <linux/errno.h>
 #include <linux/bitops.h>
 #include <linux/slab.h>
+#include <linux/kref.h>
 #include <net/rtnetlink.h>
 
 #include <scsi/fc/fc_els.h>
diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
index 983369844840..7296c81e1841 100644
--- a/drivers/scsi/hosts.c
+++ b/drivers/scsi/hosts.c
@@ -37,6 +37,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/idr.h>
+#include <linux/kref.h>
 #include <scsi/scsi_device.h>
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_transport.h>
diff --git a/drivers/scsi/libfc/fc_disc.c b/drivers/scsi/libfc/fc_disc.c
index 384f48ff64d7..b6e43d94aab1 100644
--- a/drivers/scsi/libfc/fc_disc.c
+++ b/drivers/scsi/libfc/fc_disc.c
@@ -25,6 +25,7 @@
 #include <linux/err.h>
 #include <linux/export.h>
 #include <linux/list.h>
+#include <linux/kref.h>
 
 #include <asm/unaligned.h>
 
diff --git a/drivers/scsi/libfc/fc_exch.c b/drivers/scsi/libfc/fc_exch.c
index 1d91c457527f..783a3e1ddf2b 100644
--- a/drivers/scsi/libfc/fc_exch.c
+++ b/drivers/scsi/libfc/fc_exch.c
@@ -16,6 +16,7 @@
 #include <linux/err.h>
 #include <linux/export.h>
 #include <linux/log2.h>
+#include <linux/kref.h>
 
 #include <scsi/fc/fc_fc2.h>
 
diff --git a/drivers/scsi/libfc/fc_lport.c b/drivers/scsi/libfc/fc_lport.c
index d6b6b0083d89..08d5bea8f1aa 100644
--- a/drivers/scsi/libfc/fc_lport.c
+++ b/drivers/scsi/libfc/fc_lport.c
@@ -79,6 +79,7 @@
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/slab.h>
+#include <linux/kref.h>
 #include <asm/unaligned.h>
 #include <linux/sprintf.h>
 
diff --git a/drivers/scsi/libfc/fc_rport.c b/drivers/scsi/libfc/fc_rport.c
index 33da3c1085f0..13f7745d1605 100644
--- a/drivers/scsi/libfc/fc_rport.c
+++ b/drivers/scsi/libfc/fc_rport.c
@@ -54,6 +54,7 @@
 #include <linux/workqueue.h>
 #include <linux/export.h>
 #include <linux/rculist.h>
+#include <linux/kref.h>
 
 #include <asm/unaligned.h>
 
diff --git a/drivers/scsi/libsas/sas_internal.h b/drivers/scsi/libsas/sas_internal.h
index 3804aef165ad..97903a3fecfd 100644
--- a/drivers/scsi/libsas/sas_internal.h
+++ b/drivers/scsi/libsas/sas_internal.h
@@ -15,6 +15,7 @@
 #include <scsi/libsas.h>
 #include <scsi/sas_ata.h>
 #include <linux/pm_runtime.h>
+#include <linux/kref.h>
 
 #ifdef pr_fmt
 #undef pr_fmt
diff --git a/drivers/scsi/lpfc/lpfc_bsg.c b/drivers/scsi/lpfc/lpfc_bsg.c
index d80e6e81053b..63160d72de45 100644
--- a/drivers/scsi/lpfc/lpfc_bsg.c
+++ b/drivers/scsi/lpfc/lpfc_bsg.c
@@ -28,6 +28,7 @@
 #include <linux/list.h>
 #include <linux/bsg-lib.h>
 #include <linux/vmalloc.h>
+#include <linux/kref.h>
 
 #include <scsi/scsi.h>
 #include <scsi/scsi_host.h>
diff --git a/drivers/scsi/lpfc/lpfc_debugfs.c b/drivers/scsi/lpfc/lpfc_debugfs.c
index ed342fe37d8a..1140afeaf666 100644
--- a/drivers/scsi/lpfc/lpfc_debugfs.c
+++ b/drivers/scsi/lpfc/lpfc_debugfs.c
@@ -28,6 +28,7 @@
 #include <linux/idr.h>
 #include <linux/interrupt.h>
 #include <linux/kthread.h>
+#include <linux/kref.h>
 #include <linux/slab.h>
 #include <linux/pci.h>
 #include <linux/spinlock.h>
diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index 2407836d50f6..e62dcf317b39 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -26,6 +26,7 @@
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
+#include <linux/kref.h>
 #include <linux/sprintf.h>
 
 #include <scsi/scsi.h>
diff --git a/drivers/scsi/lpfc/lpfc_hbadisc.c b/drivers/scsi/lpfc/lpfc_hbadisc.c
index ec92d296dc44..1702ca92ac06 100644
--- a/drivers/scsi/lpfc/lpfc_hbadisc.c
+++ b/drivers/scsi/lpfc/lpfc_hbadisc.c
@@ -31,6 +31,7 @@
 #include <linux/lockdep.h>
 #include <linux/sprintf.h>
 #include <linux/utsname.h>
+#include <linux/kref.h>
 
 #include <scsi/scsi.h>
 #include <scsi/scsi_device.h>
diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index e25d5dad210d..e1a890588065 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -28,6 +28,7 @@
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/kthread.h>
+#include <linux/kref.h>
 #include <linux/pci.h>
 #include <linux/spinlock.h>
 #include <linux/sched/clock.h>
diff --git a/drivers/scsi/lpfc/lpfc_nportdisc.c b/drivers/scsi/lpfc/lpfc_nportdisc.c
index 8e425be7c7c9..6f15f7b2b75b 100644
--- a/drivers/scsi/lpfc/lpfc_nportdisc.c
+++ b/drivers/scsi/lpfc/lpfc_nportdisc.c
@@ -25,6 +25,7 @@
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
+#include <linux/kref.h>
 
 #include <scsi/scsi.h>
 #include <scsi/scsi_device.h>
diff --git a/drivers/scsi/lpfc/lpfc_nvme.c b/drivers/scsi/lpfc/lpfc_nvme.c
index 15e18a8588c7..0da1eda3ca4d 100644
--- a/drivers/scsi/lpfc/lpfc_nvme.c
+++ b/drivers/scsi/lpfc/lpfc_nvme.c
@@ -23,6 +23,7 @@
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
+#include <linux/kref.h>
 #include <linux/delay.h>
 #include <asm/unaligned.h>
 #include <linux/completion.h>
diff --git a/drivers/scsi/lpfc/lpfc_nvmet.c b/drivers/scsi/lpfc/lpfc_nvmet.c
index 9653552bc37d..8a74a010761c 100644
--- a/drivers/scsi/lpfc/lpfc_nvmet.c
+++ b/drivers/scsi/lpfc/lpfc_nvmet.c
@@ -23,6 +23,7 @@
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
+#include <linux/kref.h>
 #include <linux/delay.h>
 #include <asm/unaligned.h>
 #include <linux/completion.h>
diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index a80b3ca0b53f..32f0adadd35d 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -26,6 +26,7 @@
 #include <linux/pci.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
+#include <linux/kref.h>
 #include <linux/slab.h>
 #include <linux/lockdep.h>
 #include <linux/sprintf.h>
diff --git a/drivers/scsi/mpi3mr/mpi3mr.h b/drivers/scsi/mpi3mr/mpi3mr.h
index 3de1ee05c44e..0d2c32c8d9ff 100644
--- a/drivers/scsi/mpi3mr/mpi3mr.h
+++ b/drivers/scsi/mpi3mr/mpi3mr.h
@@ -20,6 +20,7 @@
 #include <linux/io.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
+#include <linux/kref.h>
 #include <linux/miscdevice.h>
 #include <linux/module.h>
 #include <linux/pci.h>
diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.h b/drivers/scsi/mpt3sas/mpt3sas_base.h
index bf100a4ebfc3..c561ec02c57a 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.h
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.h
@@ -68,6 +68,7 @@
 #include <linux/pci.h>
 #include <linux/poll.h>
 #include <linux/irq_poll.h>
+#include <linux/kref.h>
 
 #include "mpt3sas_debug.h"
 #include "mpt3sas_trigger_diag.h"
diff --git a/drivers/scsi/qedf/qedf_els.c b/drivers/scsi/qedf/qedf_els.c
index 1ff5bc314fc0..44fd48a14abb 100644
--- a/drivers/scsi/qedf/qedf_els.c
+++ b/drivers/scsi/qedf/qedf_els.c
@@ -5,6 +5,8 @@
  */
 #include "qedf.h"
 
+#include <linux/kref.h>
+
 /* It's assumed that the lock is held when calling this function. */
 static int qedf_initiate_els(struct qedf_rport *fcport, unsigned int op,
 	void *data, uint32_t data_len,
diff --git a/drivers/scsi/qedf/qedf_io.c b/drivers/scsi/qedf/qedf_io.c
index d26fd13e17dc..250cc5377a5b 100644
--- a/drivers/scsi/qedf/qedf_io.c
+++ b/drivers/scsi/qedf/qedf_io.c
@@ -5,6 +5,7 @@
  */
 #include <linux/spinlock.h>
 #include <linux/vmalloc.h>
+#include <linux/kref.h>
 #include "qedf.h"
 #include <linux/completion.h>
 #include <scsi/scsi_tcq.h>
diff --git a/drivers/scsi/qedf/qedf_main.c b/drivers/scsi/qedf/qedf_main.c
index e8105d73673a..f47354ef4906 100644
--- a/drivers/scsi/qedf/qedf_main.c
+++ b/drivers/scsi/qedf/qedf_main.c
@@ -21,6 +21,7 @@
 #include <linux/if_ether.h>
 #include <linux/if_vlan.h>
 #include <linux/cpu.h>
+#include <linux/kref.h>
 #include "qedf.h"
 #include "qedf_dbg.h"
 #include <linux/completion.h>
diff --git a/drivers/scsi/qla2xxx/qla_inline.h b/drivers/scsi/qla2xxx/qla_inline.h
index 565c216a6a5b..03bc1c87acf0 100644
--- a/drivers/scsi/qla2xxx/qla_inline.h
+++ b/drivers/scsi/qla2xxx/qla_inline.h
@@ -6,6 +6,8 @@
 
 #include "qla_target.h"
 #include <linux/completion.h>
+#include <linux/kref.h>
+
 /**
  * qla24xx_calc_iocbs() - Determine number of Command Type 3 and
  * Continuation Type 1 IOCBs to allocate.
diff --git a/drivers/scsi/qla4xxx/ql4_isr.c b/drivers/scsi/qla4xxx/ql4_isr.c
index 8604d35c01f6..3a8e48ecf499 100644
--- a/drivers/scsi/qla4xxx/ql4_isr.c
+++ b/drivers/scsi/qla4xxx/ql4_isr.c
@@ -10,6 +10,8 @@
 #include "ql4_inline.h"
 #include <linux/completion.h>
 
+#include <linux/kref.h>
+
 /**
  * qla4xxx_copy_sense - copy sense data	into cmd sense buffer
  * @ha: Pointer to host adapter structure.
diff --git a/drivers/scsi/qla4xxx/ql4_os.c b/drivers/scsi/qla4xxx/ql4_os.c
index 1e30e5654297..a2ac7f4f3ca8 100644
--- a/drivers/scsi/qla4xxx/ql4_os.c
+++ b/drivers/scsi/qla4xxx/ql4_os.c
@@ -9,6 +9,7 @@
 #include <linux/completion.h>
 #include <linux/iscsi_boot_sysfs.h>
 #include <linux/inet.h>
+#include <linux/kref.h>
 #include <linux/sprintf.h>
 
 #include <scsi/scsi_tcq.h>
diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
index 254b7478b308..8a5b23ce5986 100644
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -36,6 +36,7 @@
 #include <linux/spinlock.h>
 #include <linux/async.h>
 #include <linux/slab.h>
+#include <linux/kref.h>
 #include <asm/unaligned.h>
 
 #include <scsi/scsi.h>
diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index abb1751708aa..0bbae4ae759c 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -16,6 +16,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/bsg.h>
 #include <linux/sprintf.h>
+#include <linux/kref.h>
 
 #include <scsi/scsi.h>
 #include <scsi/scsi_device.h>
diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index e38dc64755dd..0dd2157a0129 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -50,6 +50,7 @@ static int sg_version_num = 30536;	/* 2 digits for each component */
 #include <linux/ratelimit.h>
 #include <linux/uio.h>
 #include <linux/cred.h> /* for sg_check_file_access() */
+#include <linux/kref.h>
 
 #include <scsi/scsi.h>
 #include <scsi/scsi_cmnd.h>
diff --git a/drivers/soc/qcom/smem_state.c b/drivers/soc/qcom/smem_state.c
index e848cc9a3cf8..ded25c077ec5 100644
--- a/drivers/soc/qcom/smem_state.c
+++ b/drivers/soc/qcom/smem_state.c
@@ -9,6 +9,7 @@
 #include <linux/of.h>
 #include <linux/slab.h>
 #include <linux/soc/qcom/smem_state.h>
+#include <linux/kref.h>
 
 static LIST_HEAD(smem_states);
 static DEFINE_MUTEX(list_lock);
diff --git a/drivers/staging/greybus/authentication.c b/drivers/staging/greybus/authentication.c
index d53e58f92e81..6d900eebfcb3 100644
--- a/drivers/staging/greybus/authentication.c
+++ b/drivers/staging/greybus/authentication.c
@@ -11,6 +11,7 @@
 #include <linux/fs.h>
 #include <linux/ioctl.h>
 #include <linux/uaccess.h>
+#include <linux/kref.h>
 
 #include "greybus_authentication.h"
 #include "firmware.h"
diff --git a/drivers/staging/greybus/fw-download.c b/drivers/staging/greybus/fw-download.c
index 3240b22ba1e3..5bdc7b17dd94 100644
--- a/drivers/staging/greybus/fw-download.c
+++ b/drivers/staging/greybus/fw-download.c
@@ -8,6 +8,7 @@
 
 #include <linux/firmware.h>
 #include <linux/jiffies.h>
+#include <linux/kref.h>
 #include <linux/mutex.h>
 #include <linux/sprintf.h>
 #include <linux/workqueue.h>
diff --git a/drivers/staging/greybus/fw-management.c b/drivers/staging/greybus/fw-management.c
index 3054f084d777..33073951a2cb 100644
--- a/drivers/staging/greybus/fw-management.c
+++ b/drivers/staging/greybus/fw-management.c
@@ -14,6 +14,7 @@
 #include <linux/ioctl.h>
 #include <linux/uaccess.h>
 #include <linux/greybus.h>
+#include <linux/kref.h>
 
 #include "firmware.h"
 #include "greybus_firmware.h"
diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/iscsi_target.c
index 003c6a7c81a7..8aca97f728b0 100644
--- a/drivers/target/iscsi/iscsi_target.c
+++ b/drivers/target/iscsi/iscsi_target.c
@@ -18,6 +18,7 @@
 #include <linux/vmalloc.h>
 #include <linux/idr.h>
 #include <linux/delay.h>
+#include <linux/kref.h>
 #include <linux/sched/signal.h>
 #include <asm/unaligned.h>
 #include <linux/inet.h>
diff --git a/drivers/target/iscsi/iscsi_target_nego.c b/drivers/target/iscsi/iscsi_target_nego.c
index 1ed854637556..87d2c3597ffd 100644
--- a/drivers/target/iscsi/iscsi_target_nego.c
+++ b/drivers/target/iscsi/iscsi_target_nego.c
@@ -12,6 +12,7 @@
 #include <linux/kthread.h>
 #include <linux/slab.h>
 #include <linux/sched/signal.h>
+#include <linux/kref.h>
 #include <net/sock.h>
 #include <trace/events/sock.h>
 #include <scsi/iscsi_proto.h>
diff --git a/drivers/target/target_core_device.c b/drivers/target/target_core_device.c
index 3862f6889167..66824c18da1e 100644
--- a/drivers/target/target_core_device.c
+++ b/drivers/target/target_core_device.c
@@ -17,6 +17,7 @@
 #include <linux/timer.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/kref.h>
 #include <linux/kthread.h>
 #include <linux/in.h>
 #include <linux/export.h>
diff --git a/drivers/target/target_core_pr.c b/drivers/target/target_core_pr.c
index 008575f020ba..6ed604a164f8 100644
--- a/drivers/target/target_core_pr.c
+++ b/drivers/target/target_core_pr.c
@@ -19,6 +19,7 @@
 #include <linux/file.h>
 #include <linux/fcntl.h>
 #include <linux/fs.h>
+#include <linux/kref.h>
 #include <scsi/scsi_proto.h>
 #include <asm/unaligned.h>
 
diff --git a/drivers/target/target_core_tmr.c b/drivers/target/target_core_tmr.c
index 4718db628222..16da808bcc61 100644
--- a/drivers/target/target_core_tmr.c
+++ b/drivers/target/target_core_tmr.c
@@ -14,6 +14,8 @@
 #include <linux/spinlock.h>
 #include <linux/list.h>
 #include <linux/export.h>
+#include <linux/workqueue.h>
+#include <linux/kref.h>
 
 #include <target/target_core_base.h>
 #include <target/target_core_backend.h>
diff --git a/drivers/target/target_core_tpg.c b/drivers/target/target_core_tpg.c
index 65fbe25c6779..2029182eb1d2 100644
--- a/drivers/target/target_core_tpg.c
+++ b/drivers/target/target_core_tpg.c
@@ -18,6 +18,7 @@
 #include <linux/spinlock.h>
 #include <linux/in.h>
 #include <linux/export.h>
+#include <linux/kref.h>
 #include <net/sock.h>
 #include <net/tcp.h>
 #include <scsi/scsi_proto.h>
diff --git a/drivers/target/target_core_transport.c b/drivers/target/target_core_transport.c
index bfc1ed048182..3523b77feacb 100644
--- a/drivers/target/target_core_transport.c
+++ b/drivers/target/target_core_transport.c
@@ -17,6 +17,7 @@
 #include <linux/timer.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/kref.h>
 #include <linux/kthread.h>
 #include <linux/in.h>
 #include <linux/cdrom.h>
diff --git a/drivers/target/target_core_user.c b/drivers/target/target_core_user.c
index ad6983204909..b7c6ae0f7aa2 100644
--- a/drivers/target/target_core_user.c
+++ b/drivers/target/target_core_user.c
@@ -24,6 +24,7 @@
 #include <linux/mutex.h>
 #include <linux/workqueue.h>
 #include <linux/pagemap.h>
+#include <linux/kref.h>
 #include <net/genetlink.h>
 #include <scsi/scsi_common.h>
 #include <scsi/scsi_proto.h>
diff --git a/drivers/usb/core/config.c b/drivers/usb/core/config.c
index 7f8d33f92ddb..095a913b7b2a 100644
--- a/drivers/usb/core/config.c
+++ b/drivers/usb/core/config.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/device.h>
+#include <linux/kref.h>
 #include <asm/byteorder.h>
 #include "usb.h"
 
diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 617b96048706..c9b45e189320 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -35,6 +35,7 @@
 #include <linux/genalloc.h>
 #include <linux/io.h>
 #include <linux/kcov.h>
+#include <linux/kref.h>
 
 #include <linux/phy/phy.h>
 #include <linux/usb.h>
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 9cde9042991e..0c4908891182 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -32,6 +32,7 @@
 #include <linux/random.h>
 #include <linux/pm_qos.h>
 #include <linux/kobject.h>
+#include <linux/kref.h>
 
 #include <linux/bitfield.h>
 #include <linux/uaccess.h>
diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
index f8dfa2ef6117..14bfad425dd4 100644
--- a/drivers/usb/core/message.c
+++ b/drivers/usb/core/message.c
@@ -22,6 +22,7 @@
 #include <linux/usb/quirks.h>
 #include <linux/usb/hcd.h>	/* for usbcore internals */
 #include <linux/usb/of.h>
+#include <linux/kref.h>
 #include <asm/byteorder.h>
 
 #include "usb.h"
diff --git a/drivers/usb/core/urb.c b/drivers/usb/core/urb.c
index cd03a388c9c6..a1c5134ed619 100644
--- a/drivers/usb/core/urb.c
+++ b/drivers/usb/core/urb.c
@@ -14,6 +14,7 @@
 #include <linux/wait.h>
 #include <linux/usb/hcd.h>
 #include <linux/scatterlist.h>
+#include <linux/kref.h>
 
 #define to_urb(d) container_of(d, struct urb, kref)
 
diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index fdfb00d4c6b5..f5b0080e08bc 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -27,6 +27,7 @@
 #include <linux/sprintf.h>
 #include <linux/uio.h>
 #include <linux/vmalloc.h>
+#include <linux/kref.h>
 #include <asm/unaligned.h>
 
 #include <linux/usb/ccid.h>
diff --git a/drivers/usb/host/oxu210hp-hcd.c b/drivers/usb/host/oxu210hp-hcd.c
index 9a38ed733e59..91260da16759 100644
--- a/drivers/usb/host/oxu210hp-hcd.c
+++ b/drivers/usb/host/oxu210hp-hcd.c
@@ -27,6 +27,7 @@
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/completion.h>
+#include <linux/kref.h>
 
 #include <asm/irq.h>
 #include <asm/unaligned.h>
diff --git a/drivers/usb/misc/usblcd.c b/drivers/usb/misc/usblcd.c
index 8a208018535f..3123be926623 100644
--- a/drivers/usb/misc/usblcd.c
+++ b/drivers/usb/misc/usblcd.c
@@ -22,6 +22,7 @@
 #include <linux/sprintf.h>
 #include <linux/uaccess.h>
 #include <linux/usb.h>
+#include <linux/kref.h>
 
 #define DRIVER_VERSION "USBLCD Driver Version 1.05"
 
diff --git a/drivers/vfio/container.c b/drivers/vfio/container.c
index d53d08f16973..7ef54f61c423 100644
--- a/drivers/vfio/container.c
+++ b/drivers/vfio/container.c
@@ -9,6 +9,7 @@
 #include <linux/fs.h>
 #include <linux/capability.h>
 #include <linux/iommu.h>
+#include <linux/kref.h>
 #include <linux/miscdevice.h>
 #include <linux/vfio.h>
 #include <uapi/linux/vfio.h>
diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index f7a10719c44a..ced7e376ea7f 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -39,6 +39,7 @@
 #include <linux/virtio_scsi.h>
 #include <linux/llist.h>
 #include <linux/bitmap.h>
+#include <linux/kref.h>
 
 #include "vhost.h"
 
diff --git a/drivers/video/fbdev/smscufx.c b/drivers/video/fbdev/smscufx.c
index 35d682b110c4..2b6143c7203c 100644
--- a/drivers/video/fbdev/smscufx.c
+++ b/drivers/video/fbdev/smscufx.c
@@ -29,6 +29,7 @@
 #include <linux/vmalloc.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
+#include <linux/kref.h>
 #include "edid.h"
 
 #define check_warn(status, fmt, args...) \
diff --git a/drivers/xen/xen-scsiback.c b/drivers/xen/xen-scsiback.c
index f3c57d46a3c2..019fb228e046 100644
--- a/drivers/xen/xen-scsiback.c
+++ b/drivers/xen/xen-scsiback.c
@@ -47,6 +47,7 @@
 #include <linux/spinlock.h>
 #include <linux/configfs.h>
 #include <linux/completion.h>
+#include <linux/kref.h>
 
 #include <generated/utsrelease.h>
 
diff --git a/drivers/xen/xenbus/xenbus_dev_frontend.c b/drivers/xen/xenbus/xenbus_dev_frontend.c
index d95a484dc006..0398f79a74a4 100644
--- a/drivers/xen/xenbus/xenbus_dev_frontend.c
+++ b/drivers/xen/xenbus/xenbus_dev_frontend.c
@@ -57,6 +57,7 @@
 #include <linux/slab.h>
 #include <linux/miscdevice.h>
 #include <linux/workqueue.h>
+#include <linux/kref.h>
 
 #include <xen/xenbus.h>
 #include <xen/xen.h>
diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
index 4d7f4c5f2001..6e79d1825fa5 100644
--- a/include/drm/drm_atomic.h
+++ b/include/drm/drm_atomic.h
@@ -31,6 +31,8 @@
 #include <drm/drm_crtc.h>
 #include <drm/drm_util.h>
 
+#include <linux/kref.h>
+
 /**
  * struct drm_crtc_commit - track modeset commits on a CRTC
  *
diff --git a/include/drm/drm_auth.h b/include/drm/drm_auth.h
index cb7377d5f5c3..da669629536c 100644
--- a/include/drm/drm_auth.h
+++ b/include/drm/drm_auth.h
@@ -29,7 +29,7 @@
  */
 
 #include <linux/idr.h>
-#include <linux/kref.h>
+#include <linux/kref_types.h>
 
 struct drm_file;
 
diff --git a/include/drm/drm_device.h b/include/drm/drm_device.h
index 6a1bbdd515cd..6ea1ca468d20 100644
--- a/include/drm/drm_device.h
+++ b/include/drm/drm_device.h
@@ -2,7 +2,7 @@
 #define _DRM_DEVICE_H_
 
 #include <linux/list.h>
-#include <linux/kref.h>
+#include <linux/kref_types.h>
 #include <linux/mutex_types.h>
 #include <linux/idr.h>
 
diff --git a/include/drm/drm_framebuffer.h b/include/drm/drm_framebuffer.h
index 668077009fce..bdee553d86fb 100644
--- a/include/drm/drm_framebuffer.h
+++ b/include/drm/drm_framebuffer.h
@@ -26,6 +26,7 @@
 #include <linux/ctype.h>
 #include <linux/list.h>
 #include <linux/sched.h>
+#include <linux/kref.h>
 
 #include <drm/drm_fourcc.h>
 #include <drm/drm_mode_object.h>
diff --git a/include/drm/drm_mode_object.h b/include/drm/drm_mode_object.h
index 08d7a7f0188f..df8f92230fda 100644
--- a/include/drm/drm_mode_object.h
+++ b/include/drm/drm_mode_object.h
@@ -23,7 +23,7 @@
 #ifndef __DRM_MODESET_H__
 #define __DRM_MODESET_H__
 
-#include <linux/kref.h>
+#include <linux/kref_types.h>
 #include <drm/drm_lease.h>
 struct drm_object_properties;
 struct drm_property;
diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index c1c4a6266b58..00bf2cc4bb02 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -8,7 +8,7 @@
 #include <linux/bits.h>
 #include <linux/kvm.h>
 #include <linux/irqreturn.h>
-#include <linux/kref.h>
+#include <linux/kref_types.h>
 #include <linux/mutex_types.h>
 #include <linux/spinlock_types.h>
 #include <linux/static_key.h>
diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
index 977f0323383d..b379687434fa 100644
--- a/include/linux/backing-dev-defs.h
+++ b/include/linux/backing-dev-defs.h
@@ -12,7 +12,7 @@
 #include <linux/timer_types.h>
 #include <linux/wait.h>
 #include <linux/workqueue_types.h>
-#include <linux/kref.h>
+#include <linux/kref_types.h>
 
 #ifdef CONFIG_CGROUP_WRITEBACK
 #include <linux/rwsem.h>
diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index d8c63b13ce0c..3c39a171c073 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -17,6 +17,7 @@
 #include <linux/backing-dev-defs.h>
 #include <linux/percpu_counter.h>
 #include <linux/slab.h>
+#include <linux/kref.h>
 
 static inline struct backing_dev_info *bdi_get(struct backing_dev_info *bdi)
 {
diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
index 577de5f3ef17..a694da70e70f 100644
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -4,7 +4,7 @@
 
 #include <linux/bvec.h>
 #include <linux/crypto.h>
-#include <linux/kref.h>
+#include <linux/kref_types.h>
 #include <linux/mutex_types.h>
 #include <linux/net.h>
 #include <linux/uio.h>
diff --git a/include/linux/ceph/mon_client.h b/include/linux/ceph/mon_client.h
index 8226ea42fc78..1b23c4cf663b 100644
--- a/include/linux/ceph/mon_client.h
+++ b/include/linux/ceph/mon_client.h
@@ -3,7 +3,7 @@
 #define _FS_CEPH_MON_CLIENT_H
 
 #include <linux/completion.h>
-#include <linux/kref.h>
+#include <linux/kref_types.h>
 #include <linux/rbtree_types.h>
 
 #include <linux/ceph/messenger.h>
diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index baa9629186ec..289034e8854f 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -4,7 +4,7 @@
 
 #include <linux/bitrev.h>
 #include <linux/completion.h>
-#include <linux/kref.h>
+#include <linux/kref_types.h>
 #include <linux/mempool.h>
 #include <linux/rbtree_types.h>
 #include <linux/refcount_types.h>
diff --git a/include/linux/comedi/comedidev.h b/include/linux/comedi/comedidev.h
index bde0255d4406..d7a75b15c6f7 100644
--- a/include/linux/comedi/comedidev.h
+++ b/include/linux/comedi/comedidev.h
@@ -14,7 +14,7 @@
 #include <linux/mutex_types.h>
 #include <linux/spinlock_types.h>
 #include <linux/rwsem.h>
-#include <linux/kref.h>
+#include <linux/kref_types.h>
 #include <linux/comedi.h>
 
 #define COMEDI_VERSION(a, b, c) (((a) << 16) + ((b) << 8) + (c))
diff --git a/include/linux/configfs.h b/include/linux/configfs.h
index 4a8326e7342b..5aac65d90883 100644
--- a/include/linux/configfs.h
+++ b/include/linux/configfs.h
@@ -22,7 +22,7 @@
 #include <linux/stat.h>   /* S_IRUGO */
 #include <linux/types.h>  /* ssize_t */
 #include <linux/list.h>   /* struct list_head */
-#include <linux/kref.h>   /* struct kref */
+#include <linux/kref_types.h> /* struct kref */
 #include <linux/mutex_types.h> /* struct mutex */
 
 #define CONFIGFS_ITEM_NAME_LEN	20
diff --git a/include/linux/cpu_rmap.h b/include/linux/cpu_rmap.h
index effe8bef0a3a..db82833bfe21 100644
--- a/include/linux/cpu_rmap.h
+++ b/include/linux/cpu_rmap.h
@@ -10,7 +10,7 @@
 #include <linux/cpumask.h>
 #include <linux/gfp_types.h>
 #include <linux/slab.h>
-#include <linux/kref.h>
+#include <linux/kref_types.h>
 
 /**
  * struct cpu_rmap - CPU affinity reverse-map
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 1a202761599a..32c2f49177b1 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -13,6 +13,7 @@
 #include <linux/scatterlist.h>
 #include <linux/bitmap.h>
 #include <linux/types.h>
+#include <linux/kref.h>
 #include <asm/page.h>
 
 /**
diff --git a/include/linux/greybus/connection.h b/include/linux/greybus/connection.h
index d8926e864937..168fa2a284a8 100644
--- a/include/linux/greybus/connection.h
+++ b/include/linux/greybus/connection.h
@@ -12,7 +12,7 @@
 #include <linux/bits.h>
 #include <linux/list.h>
 #include <linux/kfifo.h>
-#include <linux/kref.h>
+#include <linux/kref_types.h>
 
 #define GB_CONNECTION_FLAG_CSD		BIT(0)
 #define GB_CONNECTION_FLAG_NO_FLOWCTRL	BIT(1)
diff --git a/include/linux/greybus/operation.h b/include/linux/greybus/operation.h
index ba5f09816035..c49053e5707d 100644
--- a/include/linux/greybus/operation.h
+++ b/include/linux/greybus/operation.h
@@ -10,7 +10,7 @@
 #define __OPERATION_H
 
 #include <linux/completion.h>
-#include <linux/kref.h>
+#include <linux/kref_types.h>
 #include <linux/timer_types.h>
 #include <linux/types.h>
 #include <linux/workqueue_types.h>
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 444d509c2647..de6cbc00806e 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -10,7 +10,7 @@
 #include <linux/cgroup.h>
 #include <linux/page_ref.h>
 #include <linux/list.h>
-#include <linux/kref.h>
+#include <linux/kref_types.h>
 #include <linux/pgtable.h>
 #include <linux/gfp_types.h>
 #include <linux/userfaultfd_k.h>
diff --git a/include/linux/hw_random.h b/include/linux/hw_random.h
index 136e9842120e..96cad10d0201 100644
--- a/include/linux/hw_random.h
+++ b/include/linux/hw_random.h
@@ -15,7 +15,7 @@
 #include <linux/completion.h>
 #include <linux/types.h>
 #include <linux/list.h>
-#include <linux/kref.h>
+#include <linux/kref_types.h>
 
 /**
  * struct hwrng - Hardware Random Number Generator driver
diff --git a/include/linux/iio/buffer-dma.h b/include/linux/iio/buffer-dma.h
index 395762ed9bf1..8c04fff96e57 100644
--- a/include/linux/iio/buffer-dma.h
+++ b/include/linux/iio/buffer-dma.h
@@ -8,7 +8,7 @@
 #define __INDUSTRIALIO_DMA_BUFFER_H__
 
 #include <linux/list.h>
-#include <linux/kref.h>
+#include <linux/kref_types.h>
 #include <linux/spinlock_types.h>
 #include <linux/mutex_types.h>
 #include <linux/iio/buffer_impl.h>
diff --git a/include/linux/iio/buffer_impl.h b/include/linux/iio/buffer_impl.h
index 89c3fd7c29ca..184f8c399854 100644
--- a/include/linux/iio/buffer_impl.h
+++ b/include/linux/iio/buffer_impl.h
@@ -2,7 +2,7 @@
 #ifndef _IIO_BUFFER_GENERIC_IMPL_H_
 #define _IIO_BUFFER_GENERIC_IMPL_H_
 #include <linux/sysfs.h>
-#include <linux/kref.h>
+#include <linux/kref_types.h>
 
 #ifdef CONFIG_IIO_BUFFER
 
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 2ac9e5f9af3d..e3a0f2c22a75 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -10,7 +10,7 @@
 #include <linux/irqnr.h>
 #include <linux/hardirq.h>
 #include <linux/irqflags.h>
-#include <linux/kref.h>
+#include <linux/kref_types.h>
 #include <linux/workqueue_types.h>
 #include <linux/jump_label.h>
 
diff --git a/include/linux/klist.h b/include/linux/klist.h
index 632ae9c720ac..5bd7819286d7 100644
--- a/include/linux/klist.h
+++ b/include/linux/klist.h
@@ -11,7 +11,7 @@
 #define _LINUX_KLIST_H
 
 #include <linux/spinlock_types.h>
-#include <linux/kref.h>
+#include <linux/kref_types.h>
 #include <linux/list.h>
 
 struct klist_node;
diff --git a/include/linux/kobject.h b/include/linux/kobject.h
index 8890ab7bdbdc..da97815b97fb 100644
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -22,7 +22,7 @@
 #include <linux/container_of.h>
 #include <linux/spinlock_types.h>
 #include <linux/stdarg.h> // for va_list
-#include <linux/kref.h>
+#include <linux/kref_types.h>
 #include <linux/kobject_ns.h>
 #include <linux/uidgid_types.h>
 
diff --git a/include/linux/kref.h b/include/linux/kref.h
index 536ada1a1bc4..ca6280808d1a 100644
--- a/include/linux/kref.h
+++ b/include/linux/kref.h
@@ -13,12 +13,9 @@
 #ifndef _KREF_H_
 #define _KREF_H_
 
+#include <linux/kref_types.h>
 #include <linux/refcount.h>
 
-struct kref {
-	refcount_t refcount;
-};
-
 #define KREF_INIT(n)	{ .refcount = REFCOUNT_INIT(n), }
 
 /**
diff --git a/include/linux/kref_types.h b/include/linux/kref_types.h
new file mode 100644
index 000000000000..cd048cc26178
--- /dev/null
+++ b/include/linux/kref_types.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef _KREF_TYPES_H_
+#define _KREF_TYPES_H_
+
+#include <linux/refcount_types.h>
+
+struct kref {
+	refcount_t refcount;
+};
+
+#endif /* _KREF_TYPES_H_ */
diff --git a/include/linux/lockd/lockd.h b/include/linux/lockd/lockd.h
index 72a5538f35af..4e5f0c402d51 100644
--- a/include/linux/lockd/lockd.h
+++ b/include/linux/lockd/lockd.h
@@ -16,7 +16,7 @@
 #include <linux/in6.h>
 #include <net/ipv6.h>
 #include <linux/fs.h>
-#include <linux/kref.h>
+#include <linux/kref_types.h>
 #include <linux/refcount_types.h>
 #include <linux/utsname.h>
 #include <linux/lockd/bind.h>
diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
index f3f91280d20b..524d774e52b0 100644
--- a/include/linux/memory-tiers.h
+++ b/include/linux/memory-tiers.h
@@ -4,7 +4,7 @@
 
 #include <linux/types.h>
 #include <linux/nodemask_types.h>
-#include <linux/kref.h>
+#include <linux/kref_types.h>
 #include <linux/mmzone.h>
 #include <linux/notifier.h>
 /*
diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index f4fe593c1400..e9b6c2d1348d 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -10,6 +10,10 @@
 #include <linux/userfaultfd_k.h>
 #include <linux/swapops.h>
 
+#ifdef CONFIG_ANON_VMA_NAME
+#include <linux/kref.h>
+#endif
+
 /**
  * folio_is_file_lru - Should the folio be on a file LRU or anon LRU?
  * @folio: The folio to test.
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 95f1539a05bc..e44ef7852019 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -7,7 +7,7 @@
 #include <linux/auxvec.h>
 #include <linux/cache.h> // for ____cacheline_aligned_in_smp
 #include <linux/compiler_types.h> // for __randomize_layout
-#include <linux/kref.h>
+#include <linux/kref_types.h>
 #include <linux/list.h>
 #include <linux/spinlock_types.h>
 #include <linux/rbtree_types.h>
diff --git a/include/linux/mtd/blktrans.h b/include/linux/mtd/blktrans.h
index 7be6117fad23..a50f6bce4db1 100644
--- a/include/linux/mtd/blktrans.h
+++ b/include/linux/mtd/blktrans.h
@@ -7,7 +7,7 @@
 #define __MTD_TRANS_H__
 
 #include <linux/mutex_types.h>
-#include <linux/kref.h>
+#include <linux/kref_types.h>
 #include <linux/list.h>
 
 struct hd_geometry;
diff --git a/include/linux/nfs_page.h b/include/linux/nfs_page.h
index 13411baa80c6..69e5528cd6c4 100644
--- a/include/linux/nfs_page.h
+++ b/include/linux/nfs_page.h
@@ -16,7 +16,7 @@
 #include <linux/sunrpc/auth.h>
 #include <linux/nfs_xdr.h>
 
-#include <linux/kref.h>
+#include <linux/kref_types.h>
 
 /*
  * Valid flags for a dirty buffer
diff --git a/include/linux/relay.h b/include/linux/relay.h
index 50ac01f8d6d1..d33735edc3cb 100644
--- a/include/linux/relay.h
+++ b/include/linux/relay.h
@@ -19,7 +19,7 @@
 #include <linux/bug.h>
 #include <linux/fs.h>
 #include <linux/poll.h>
-#include <linux/kref.h>
+#include <linux/kref_types.h>
 #include <linux/percpu.h>
 
 /*
diff --git a/include/linux/rpmsg.h b/include/linux/rpmsg.h
index cdc3574fd712..f4113dc73dce 100644
--- a/include/linux/rpmsg.h
+++ b/include/linux/rpmsg.h
@@ -14,7 +14,7 @@
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/mod_devicetable.h>
-#include <linux/kref.h>
+#include <linux/kref_types.h>
 #include <linux/mutex_types.h>
 #include <linux/poll.h>
 #include <linux/rpmsg/byteorder.h>
diff --git a/include/linux/sh_clk.h b/include/linux/sh_clk.h
index 3b2d8de6e7d8..ec5c2199bfce 100644
--- a/include/linux/sh_clk.h
+++ b/include/linux/sh_clk.h
@@ -5,7 +5,7 @@
 #include <linux/list.h>
 #include <linux/cpufreq.h>
 #include <linux/types.h>
-#include <linux/kref.h>
+#include <linux/kref_types.h>
 #include <linux/clk.h>
 #include <linux/err.h>
 
diff --git a/include/linux/sunrpc/xprt.h b/include/linux/sunrpc/xprt.h
index 464f6a9492ab..8e0db9706986 100644
--- a/include/linux/sunrpc/xprt.h
+++ b/include/linux/sunrpc/xprt.h
@@ -14,7 +14,7 @@
 #include <linux/socket.h>
 #include <linux/in.h>
 #include <linux/ktime.h>
-#include <linux/kref.h>
+#include <linux/kref_types.h>
 #include <linux/sunrpc/sched.h>
 #include <linux/sunrpc/xdr.h>
 #include <linux/sunrpc/msg_prot.h>
diff --git a/include/linux/surface_aggregator/serial_hub.h b/include/linux/surface_aggregator/serial_hub.h
index d8dbef6b7fc2..a1fa81483c61 100644
--- a/include/linux/surface_aggregator/serial_hub.h
+++ b/include/linux/surface_aggregator/serial_hub.h
@@ -13,7 +13,7 @@
 #define _LINUX_SURFACE_AGGREGATOR_SERIAL_HUB_H
 
 #include <linux/crc-itu-t.h>
-#include <linux/kref.h>
+#include <linux/kref_types.h>
 #include <linux/ktime.h>
 #include <linux/list.h>
 #include <linux/types.h>
diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index 911ddf92dcee..6e900afbefb8 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -8,7 +8,7 @@
 
 #include <linux/device.h>
 #include <linux/idr.h>
-#include <linux/kref.h>
+#include <linux/kref_types.h>
 #include <linux/list.h>
 #include <linux/mod_devicetable.h>
 #include <linux/tee.h>
diff --git a/include/linux/usb.h b/include/linux/usb.h
index b72fc1da5d96..d7e2fa3d888d 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -15,7 +15,7 @@
 #include <linux/delay.h>	/* for mdelay() */
 #include <linux/interrupt.h>	/* for in_interrupt() */
 #include <linux/list.h>		/* for struct list_head */
-#include <linux/kref.h>		/* for struct kref */
+#include <linux/kref_types.h>	/* for struct kref */
 #include <linux/device.h>	/* for struct device */
 #include <linux/fs.h>		/* for struct file_operations */
 #include <linux/completion.h>	/* for struct completion */
diff --git a/include/linux/usb/serial.h b/include/linux/usb/serial.h
index 2d47c0ae9d64..9e187981537e 100644
--- a/include/linux/usb/serial.h
+++ b/include/linux/usb/serial.h
@@ -9,7 +9,7 @@
 #ifndef __LINUX_USB_SERIAL_H
 #define __LINUX_USB_SERIAL_H
 
-#include <linux/kref.h>
+#include <linux/kref_types.h>
 #include <linux/mutex_types.h>
 #include <linux/serial.h>
 #include <linux/kfifo.h>
diff --git a/include/linux/watch_queue.h b/include/linux/watch_queue.h
index 429c7b6afead..7943a4d15c2f 100644
--- a/include/linux/watch_queue.h
+++ b/include/linux/watch_queue.h
@@ -11,7 +11,7 @@
 #define _LINUX_WATCH_QUEUE_H
 
 #include <uapi/linux/watch_queue.h>
-#include <linux/kref.h>
+#include <linux/kref_types.h>
 #include <linux/rcupdate.h>
 
 #ifdef CONFIG_WATCH_QUEUE
diff --git a/include/media/media-request.h b/include/media/media-request.h
index 3cd25a2717ce..0747bd09d93d 100644
--- a/include/media/media-request.h
+++ b/include/media/media-request.h
@@ -16,6 +16,7 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/refcount.h>
+#include <linux/kref.h>
 
 #include <media/media-device.h>
 
diff --git a/include/media/v4l2-device.h b/include/media/v4l2-device.h
index f6f111fae33c..59bdd74f312c 100644
--- a/include/media/v4l2-device.h
+++ b/include/media/v4l2-device.h
@@ -13,6 +13,8 @@
 #include <media/v4l2-subdev.h>
 #include <media/v4l2-dev.h>
 
+#include <linux/kref.h>
+
 struct v4l2_ctrl_handler;
 
 /**
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 2bdea85b7c44..f5fd9cfe3712 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -29,6 +29,7 @@
 #include <linux/idr.h>
 #include <linux/leds.h>
 #include <linux/rculist.h>
+#include <linux/kref.h>
 
 #include <net/bluetooth/hci.h>
 #include <net/bluetooth/hci_sync.h>
diff --git a/include/net/tls_toe.h b/include/net/tls_toe.h
index b3aa7593ce2c..7bd0d9edfe8c 100644
--- a/include/net/tls_toe.h
+++ b/include/net/tls_toe.h
@@ -31,7 +31,7 @@
  * SOFTWARE.
  */
 
-#include <linux/kref.h>
+#include <linux/kref_types.h>
 #include <linux/list.h>
 
 struct sock;
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 3800bb8b9c14..64b62d1388a4 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -16,7 +16,7 @@
 #include <linux/types.h>
 #include <linux/device.h>
 #include <linux/dma-mapping.h>
-#include <linux/kref.h>
+#include <linux/kref_types.h>
 #include <linux/list.h>
 #include <linux/rwsem.h>
 #include <linux/workqueue_types.h>
diff --git a/include/rdma/restrack.h b/include/rdma/restrack.h
index 11e487bdf61c..f5a4ae56a1d9 100644
--- a/include/rdma/restrack.h
+++ b/include/rdma/restrack.h
@@ -8,7 +8,7 @@
 
 #include <linux/typecheck.h>
 #include <linux/sched.h>
-#include <linux/kref.h>
+#include <linux/kref_types.h>
 #include <linux/completion.h>
 #include <linux/sched/task.h>
 #include <uapi/rdma/rdma_netlink.h>
diff --git a/include/rdma/uverbs_types.h b/include/rdma/uverbs_types.h
index ccd11631c167..8744e75220a3 100644
--- a/include/rdma/uverbs_types.h
+++ b/include/rdma/uverbs_types.h
@@ -7,6 +7,7 @@
 #define _UVERBS_TYPES_
 
 #include <linux/kernel.h>
+#include <linux/kref.h>
 #include <rdma/ib_verbs.h>
 
 struct uverbs_obj_type;
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 1782f90cd8c6..9fc9d3dd066c 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -10,6 +10,7 @@
 
 #include <linux/irq.h>
 #include <linux/kthread.h>
+#include <linux/kref.h>
 #include <linux/module.h>
 #include <linux/random.h>
 #include <linux/interrupt.h>
diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
index 2655c71c0763..89f29ce7c58c 100644
--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -15,6 +15,7 @@
 #include <linux/printk.h>
 #include <linux/miscdevice.h>
 #include <linux/fs.h>
+#include <linux/kref.h>
 #include <linux/mm.h>
 #include <linux/pagemap.h>
 #include <linux/poll.h>
diff --git a/lib/klist.c b/lib/klist.c
index 332a4fbf18ff..4b21ad1f24ad 100644
--- a/lib/klist.c
+++ b/lib/klist.c
@@ -36,6 +36,7 @@
 #include <linux/klist.h>
 #include <linux/export.h>
 #include <linux/sched.h>
+#include <linux/kref.h>
 
 /*
  * Use the lowest bit of n_klist to mark deleted nodes and exclude
diff --git a/lib/kobject.c b/lib/kobject.c
index 52f845e8fbdc..48ba445604f8 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -21,6 +21,7 @@
 #include <linux/random.h>
 #include <linux/uidgid.h>
 #include <linux/workqueue.h>
+#include <linux/kref.h>
 
 /**
  * kobject_namespace() - Return @kobj's namespace tag.
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 614b3a260747..161a75affa14 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -3,6 +3,7 @@
 #include <linux/lockdep.h>
 #include <linux/sysfs.h>
 #include <linux/kobject.h>
+#include <linux/kref.h>
 #include <linux/kstrtox.h>
 #include <linux/memory.h>
 #include <linux/memory-tiers.h>
diff --git a/mm/z3fold.c b/mm/z3fold.c
index 58946cacbfbb..6ec1dc8ad44b 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -40,6 +40,7 @@
 #include <linux/spinlock.h>
 #include <linux/zpool.h>
 #include <linux/kmemleak.h>
+#include <linux/kref.h>
 
 /*
  * NCHUNKS_ORDER determines the internal allocation granularity, effectively
diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
index ecff1c947d68..5ee94b242a25 100644
--- a/net/can/j1939/main.c
+++ b/net/can/j1939/main.c
@@ -17,6 +17,7 @@
 #include <linux/can/skb.h>
 #include <linux/if_arp.h>
 #include <linux/module.h>
+#include <linux/kref.h>
 
 #include "j1939-priv.h"
 
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index fba7d1a0bd5c..258d638701f5 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -10,6 +10,7 @@
 
 #include <linux/can/skb.h>
 #include <linux/hrtimer.h>
+#include <linux/kref.h>
 
 #include "j1939-priv.h"
 
diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
index ac7be864e80d..8d2de3a80e7f 100644
--- a/net/dsa/dsa.c
+++ b/net/dsa/dsa.c
@@ -17,6 +17,7 @@
 #include <linux/of.h>
 #include <linux/of_mdio.h>
 #include <linux/of_net.h>
+#include <linux/kref.h>
 #include <net/dsa_stubs.h>
 #include <net/sch_generic.h>
 
diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index 18be13fb9b75..0a0af3b7f7e6 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -8,6 +8,7 @@
 
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/kref.h>
 #include <linux/list.h>
 #include <linux/nfc.h>
 
diff --git a/net/qrtr/af_qrtr.c b/net/qrtr/af_qrtr.c
index 41ece61eb57a..f26aa822c8ef 100644
--- a/net/qrtr/af_qrtr.c
+++ b/net/qrtr/af_qrtr.c
@@ -9,6 +9,7 @@
 #include <linux/termios.h>	/* For TIOCINQ/OUTQ */
 #include <linux/spinlock.h>
 #include <linux/wait.h>
+#include <linux/kref.h>
 
 #include <net/sock.h>
 
diff --git a/net/rds/message.c b/net/rds/message.c
index 7af59d2443e5..8f9d4d0b3b54 100644
--- a/net/rds/message.c
+++ b/net/rds/message.c
@@ -36,6 +36,7 @@
 #include <linux/skbuff.h>
 #include <linux/list.h>
 #include <linux/errqueue.h>
+#include <linux/kref.h>
 
 #include "rds.h"
 
diff --git a/net/rds/rdma.c b/net/rds/rdma.c
index fba82d36593a..b1746a7efd7d 100644
--- a/net/rds/rdma.c
+++ b/net/rds/rdma.c
@@ -31,6 +31,7 @@
  *
  */
 #include <linux/pagemap.h>
+#include <linux/kref.h>
 #include <linux/slab.h>
 #include <linux/rbtree.h>
 #include <linux/dma-mapping.h> /* for DMA_*_DEVICE */
diff --git a/net/tipc/node.c b/net/tipc/node.c
index dac7957e6133..ee91201526fd 100644
--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -47,6 +47,8 @@
 #include "crypto.h"
 #include <linux/sprintf.h>
 
+#include <linux/kref.h>
+
 #define INVALID_NODE_SIG	0x10000
 #define NODE_CLEANUP_AFTER	300000
 
diff --git a/net/tipc/subscr.c b/net/tipc/subscr.c
index 05d49ad81290..2aecf783a314 100644
--- a/net/tipc/subscr.c
+++ b/net/tipc/subscr.c
@@ -39,6 +39,8 @@
 #include "name_table.h"
 #include "subscr.h"
 
+#include <linux/kref.h>
+
 static void tipc_sub_send_event(struct tipc_subscription *sub,
 				struct publication *p,
 				u32 event)
diff --git a/net/tipc/topsrv.c b/net/tipc/topsrv.c
index 8ee0c07d00e9..5691abab78f2 100644
--- a/net/tipc/topsrv.c
+++ b/net/tipc/topsrv.c
@@ -43,6 +43,7 @@
 #include "bearer.h"
 #include <net/sock.h>
 #include <linux/module.h>
+#include <linux/kref.h>
 #include <trace/events/sock.h>
 
 /* Number of messages to send before rescheduling */
diff --git a/net/tls/tls_toe.c b/net/tls/tls_toe.c
index 825669e1ab47..1a1c7aca3cda 100644
--- a/net/tls/tls_toe.c
+++ b/net/tls/tls_toe.c
@@ -34,6 +34,7 @@
 #include <linux/list.h>
 #include <linux/rcupdate.h>
 #include <linux/spinlock.h>
+#include <linux/kref.h>
 #include <net/inet_connection_sock.h>
 #include <net/tls.h>
 #include <net/tls_toe.h>
diff --git a/sound/soc/qcom/qdsp6/q6apm.c b/sound/soc/qcom/qdsp6/q6apm.c
index 2a2a5bd98110..93dcbc01db77 100644
--- a/sound/soc/qcom/qdsp6/q6apm.c
+++ b/sound/soc/qcom/qdsp6/q6apm.c
@@ -12,6 +12,7 @@
 #include <linux/slab.h>
 #include <linux/soc/qcom/apr.h>
 #include <linux/wait.h>
+#include <linux/kref.h>
 #include <sound/soc.h>
 #include <sound/soc-dapm.h>
 #include <sound/pcm.h>
-- 
2.39.2


