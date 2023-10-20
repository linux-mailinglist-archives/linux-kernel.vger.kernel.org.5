Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15ED07D0D20
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 12:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376713AbjJTKaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 06:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376891AbjJTKaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 06:30:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDFED6C
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 03:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697797761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JhGnN5oTuxVhuS5paGrO8rPmAiIVaRqsoegocfzp3Yw=;
        b=XNweh7mpbyPYNc+nf9iQvyJr1sz/GakezbZJWOr0bx0KemL13++BgDRb6ZvU3ERoNk+KTT
        LHMfboAhTw/UPY/9i7N4ElROWUFrMrjlMlZU5pVmmIPjd+NbhB1a0HFk8ND+9cQUFTv4s6
        aRJTwZ3oCAhBOoUBR/mHYPcJ+ihsTPo=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-5pEbXFCrNzuAz1zfUVq88g-1; Fri, 20 Oct 2023 06:29:12 -0400
X-MC-Unique: 5pEbXFCrNzuAz1zfUVq88g-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9b65c46bca8so43140866b.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 03:29:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697797750; x=1698402550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JhGnN5oTuxVhuS5paGrO8rPmAiIVaRqsoegocfzp3Yw=;
        b=p2RwSDJwRphqH9k/V3VzmPjT1N8mpVHanLbg8kDIdejv2g+31pYs/aCaND/mo6kZ6j
         42Dh6HyQJcz++royWcgCKUfXyHNRNBkO+rKURx6adAvaWp+GeU1foVS0UV3aUs+UFW7d
         iD9vOQ0uU9kBRUF5dhZtzztJamfnILI5pc3pXBlLxqQwnHlNiafzkGl/60krLZaf/nWv
         tTs5QsjB8h+bVzYoymPZWLv9Ov7Hgy2MU2PVLdp36XHfzAsYiVuFhI6X96FAvtqAO6vM
         r3MgNSZTPGnb0fC6IczSPgzFT3Fzc1zTw3f4pofAHuTnGl+ptnbZigkkWBInR82DVM17
         83zg==
X-Gm-Message-State: AOJu0YwxyucFEHq3yHwouEgE7XOj/HGzaSJrpHHi5bLK2zYs8/7biaIC
        yVRhwM5PiXNAZy3KZA1xB7VxA8TBrULBEGVk7N6ZdxyAba2oOJyl4DetChW97DjpVhS6SjSmXLc
        Q/4aoRSKgsMqyenyrGFwtZrRjQmWUq9tKhf3NwFKUKezJHVyGYsnuRU4Xntu71UQ5W0NwDVQnrI
        ePhBnJY7mO
X-Received: by 2002:a17:907:9451:b0:9be:cdca:dadb with SMTP id dl17-20020a170907945100b009becdcadadbmr919210ejc.69.1697797748672;
        Fri, 20 Oct 2023 03:29:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHo0yiea3dqrfrJGoMVrh3YY0Yl4BgYKv6V1WQS4jiqV+hERdHitP677jqLWSEYlitCtxFSA==
X-Received: by 2002:a17:907:9451:b0:9be:cdca:dadb with SMTP id dl17-20020a170907945100b009becdcadadbmr919157ejc.69.1697797746762;
        Fri, 20 Oct 2023 03:29:06 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (92-249-235-200.pool.digikabel.hu. [92.249.235.200])
        by smtp.gmail.com with ESMTPSA id h9-20020a1709062dc900b009930c80b87csm1223140eji.142.2023.10.20.03.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 03:29:05 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Takashi Iwai <tiwai@suse.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: [RFC PATCH 2/2] replace trivial incarnations of list_for_each_entry_del()
Date:   Fri, 20 Oct 2023 12:29:00 +0200
Message-ID: <20231020102901.3354273-3-mszeredi@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231020102901.3354273-1-mszeredi@redhat.com>
References: <20231020102901.3354273-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most of the work was done by coccinelle with variations of the following
semantic patch:

@@
identifier member;
expression head;
type T;
T *pos;
iterator name list_for_each_entry_del;
@@
-	while (!list_empty(head)) {
-		pos = list_first_entry(head, T, member);
-		list_del(&pos->member);
+	list_for_each_entry_del(pos, head, member) {
 		...
 	}

This patch replaces 275 instances of list_for_each_entry_del() and 147
instances of list_for_each_entry_del_init() resulting in net 1350 line
removed.

There are a lot more cases, but those are not so simple to detect or
verify.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 arch/powerpc/platforms/powermac/pfunc_core.c  |  7 +--
 arch/powerpc/platforms/powernv/opal-hmi.c     |  5 +-
 .../platforms/powernv/opal-memory-errors.c    |  5 +-
 arch/powerpc/platforms/pseries/hvcserver.c    |  7 +--
 arch/x86/kernel/cpu/sgx/encl.c                |  5 +-
 block/bfq-iosched.c                           |  7 +--
 block/blk-core.c                              |  9 +--
 block/blk-mq.c                                | 16 ++---
 block/mq-deadline.c                           |  8 +--
 drivers/accel/qaic/qaic_data.c                |  4 +-
 drivers/accel/qaic/qaic_drv.c                 |  4 +-
 drivers/acpi/acpi_ipmi.c                      |  6 +-
 drivers/android/binder_alloc.c                |  6 +-
 drivers/base/dd.c                             |  6 +-
 drivers/base/firmware_loader/main.c           |  5 +-
 drivers/base/regmap/regmap-debugfs.c          |  7 +--
 drivers/block/aoe/aoecmd.c                    |  6 +-
 drivers/block/drbd/drbd_nl.c                  |  8 +--
 drivers/block/loop.c                          |  5 +-
 drivers/block/nbd.c                           |  4 +-
 drivers/block/null_blk/main.c                 |  6 +-
 drivers/block/rbd.c                           |  6 +-
 drivers/block/xen-blkback/blkback.c           |  8 +--
 drivers/char/ipmi/ipmi_msghandler.c           | 12 +---
 drivers/crypto/ccp/ccp-dev-v3.c               |  8 +--
 drivers/crypto/ccp/ccp-dev-v5.c               |  8 +--
 drivers/dma/pl330.c                           |  5 +-
 drivers/dma/ptdma/ptdma-dev.c                 |  4 +-
 drivers/dma/tegra20-apb-dma.c                 | 22 ++-----
 drivers/firmware/cirrus/cs_dsp.c              | 15 ++---
 drivers/gpio/gpio-rockchip.c                  |  6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  6 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c          | 13 ++--
 .../gpu/drm/nouveau/nvkm/engine/disp/base.c   | 10 +---
 drivers/gpu/drm/vc4/vc4_gem.c                 | 15 ++---
 drivers/gpu/drm/virtio/virtgpu_gem.c          |  5 +-
 drivers/gpu/ipu-v3/ipu-image-convert.c        |  8 +--
 .../hid/intel-ish-hid/ishtp/client-buffers.c  | 20 ++-----
 drivers/i3c/master.c                          |  6 +-
 drivers/infiniband/core/cma.c                 | 13 +---
 drivers/infiniband/core/mad.c                 |  7 +--
 drivers/infiniband/core/mr_pool.c             |  5 +-
 drivers/infiniband/core/multicast.c           |  5 +-
 drivers/infiniband/core/uverbs_main.c         |  6 +-
 drivers/infiniband/hw/hfi1/mmu_rb.c           |  9 +--
 drivers/infiniband/hw/hfi1/qp.c               | 11 +---
 drivers/infiniband/hw/mlx4/alias_GUID.c       |  6 +-
 drivers/infiniband/ulp/ipoib/ipoib_cm.c       |  8 +--
 drivers/infiniband/ulp/rtrs/rtrs-srv.c        | 12 ++--
 drivers/macintosh/windfarm_fcu_controls.c     |  6 +-
 drivers/macintosh/windfarm_smu_controls.c     |  5 +-
 drivers/macintosh/windfarm_smu_sat.c          |  6 +-
 drivers/macintosh/windfarm_smu_sensors.c      |  5 +-
 drivers/md/bcache/alloc.c                     |  6 +-
 drivers/md/bcache/btree.c                     |  5 +-
 drivers/md/bcache/journal.c                   |  5 +-
 drivers/md/bcache/super.c                     |  5 +-
 drivers/md/dm-bufio.c                         |  6 +-
 drivers/md/dm-stats.c                         |  4 +-
 drivers/md/dm-zoned-metadata.c                | 10 +---
 drivers/md/raid1.c                            |  5 +-
 drivers/md/raid10.c                           |  5 +-
 drivers/md/raid5-cache.c                      |  5 +-
 drivers/md/raid5.c                            | 21 ++-----
 drivers/media/cec/core/cec-api.c              | 17 ++----
 drivers/media/common/saa7146/saa7146_vbi.c    |  5 +-
 drivers/media/common/saa7146/saa7146_video.c  |  5 +-
 drivers/media/dvb-frontends/rtl2832_sdr.c     |  9 +--
 drivers/media/mc/mc-entity.c                  |  7 +--
 drivers/media/pci/bt8xx/bttv-driver.c         | 13 +---
 drivers/media/pci/bt8xx/bttv-vbi.c            |  5 +-
 drivers/media/pci/cx18/cx18-queue.c           |  5 +-
 drivers/media/pci/cx18/cx18-streams.c         |  8 +--
 drivers/media/pci/cx23885/cx23885-417.c       |  8 +--
 drivers/media/pci/cx23885/cx23885-core.c      |  5 +-
 drivers/media/pci/cx23885/cx23885-vbi.c       |  8 +--
 drivers/media/pci/cx23885/cx23885-video.c     |  8 +--
 drivers/media/pci/cx25821/cx25821-video.c     |  8 +--
 drivers/media/pci/cx88/cx88-blackbird.c       | 15 +----
 drivers/media/pci/cx88/cx88-dvb.c             |  8 +--
 drivers/media/pci/cx88/cx88-mpeg.c            |  5 +-
 drivers/media/pci/cx88/cx88-vbi.c             |  8 +--
 drivers/media/pci/cx88/cx88-video.c           |  8 +--
 drivers/media/pci/dt3155/dt3155.c             |  5 +-
 .../pci/netup_unidvb/netup_unidvb_core.c      |  6 +-
 .../media/pci/solo6x10/solo6x10-v4l2-enc.c    |  9 +--
 drivers/media/pci/solo6x10/solo6x10-v4l2.c    |  9 +--
 drivers/media/pci/tw5864/tw5864-video.c       | 16 ++---
 drivers/media/pci/tw68/tw68-video.c           |  8 +--
 drivers/media/pci/tw686x/tw686x-video.c       | 22 ++-----
 drivers/media/pci/zoran/zoran_driver.c        |  4 +-
 .../media/platform/chips-media/coda-common.c  |  7 +--
 .../platform/nxp/imx8-isi/imx8-isi-video.c    | 16 +----
 .../platform/rockchip/rkisp1/rkisp1-capture.c |  6 +-
 .../platform/samsung/exynos4-is/media-dev.c   |  7 +--
 .../platform/samsung/s5p-mfc/s5p_mfc_enc.c    |  5 +-
 .../media/platform/ti/davinci/vpif_capture.c  |  5 +-
 .../media/platform/ti/davinci/vpif_display.c  |  5 +-
 drivers/media/platform/ti/omap3isp/ispvideo.c |  8 +--
 .../test-drivers/vivid/vivid-kthread-cap.c    | 23 +++-----
 .../test-drivers/vivid/vivid-kthread-out.c    | 23 ++------
 .../test-drivers/vivid/vivid-kthread-touch.c  |  9 +--
 .../media/test-drivers/vivid/vivid-sdr-cap.c  |  8 +--
 drivers/media/usb/airspy/airspy.c             |  8 +--
 drivers/media/usb/au0828/au0828-video.c       |  7 +--
 drivers/media/usb/em28xx/em28xx-video.c       | 14 ++---
 drivers/media/usb/msi2500/msi2500.c           |  9 +--
 drivers/media/usb/pwc/pwc-if.c                |  8 +--
 drivers/media/usb/stk1160/stk1160-v4l.c       |  5 +-
 drivers/media/usb/uvc/uvc_queue.c             |  7 +--
 drivers/mtd/ubi/wl.c                          |  6 +-
 drivers/net/ethernet/agere/et131x.c           |  6 +-
 .../net/ethernet/broadcom/bnx2x/bnx2x_main.c  |  7 +--
 .../net/ethernet/broadcom/bnx2x/bnx2x_sp.c    | 14 +----
 drivers/net/ethernet/brocade/bna/bfa_ioc.c    |  5 +-
 drivers/net/ethernet/brocade/bna/bfa_msgq.c   |  6 +-
 drivers/net/ethernet/brocade/bna/bna_tx_rx.c  |  9 +--
 drivers/net/ethernet/qlogic/qed/qed_ooo.c     | 17 ++----
 .../qlogic/qlcnic/qlcnic_sriov_common.c       | 10 +---
 drivers/net/ethernet/sfc/siena/siena_sriov.c  | 16 +----
 drivers/net/ethernet/sun/ldmvsw.c             |  4 +-
 drivers/net/ethernet/sun/sunvnet.c            |  4 +-
 drivers/net/wireless/ath/ath10k/qmi.c         |  5 +-
 drivers/net/wireless/ath/ath11k/qmi.c         |  5 +-
 drivers/net/wireless/ath/ath12k/qmi.c         |  5 +-
 drivers/net/wireless/ath/ath6kl/htc_pipe.c    |  6 +-
 drivers/net/wireless/ath/ath6kl/txrx.c        |  6 +-
 .../broadcom/brcm80211/brcmfmac/msgbuf.c      |  8 +--
 drivers/net/wireless/intel/ipw2x00/ipw2100.c  |  9 +--
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   |  7 +--
 drivers/net/wireless/intersil/p54/p54spi.c    |  7 +--
 .../net/wireless/mediatek/mt76/mt7915/mac.c   |  4 +-
 .../net/wireless/mediatek/mt76/mt7996/mac.c   |  4 +-
 drivers/net/wwan/wwan_hwsim.c                 | 14 ++---
 drivers/net/xen-netback/netback.c             | 10 +---
 drivers/nvme/host/fc.c                        |  5 +-
 drivers/nvme/target/rdma.c                    | 31 +++-------
 drivers/pci/controller/pci-hyperv.c           | 12 +---
 drivers/pinctrl/pinctrl-rockchip.c            |  6 +-
 drivers/s390/net/lcs.c                        |  5 +-
 drivers/scsi/aacraid/commctrl.c               |  6 +-
 drivers/scsi/bnx2i/bnx2i_init.c               |  4 +-
 drivers/scsi/csiostor/csio_mb.c               |  5 +-
 drivers/scsi/csiostor/csio_scsi.c             | 16 ++---
 drivers/scsi/ibmvscsi/ibmvscsi.c              |  4 +-
 drivers/scsi/libiscsi.c                       | 10 +---
 drivers/scsi/libsas/sas_scsi_host.c           |  6 +-
 drivers/scsi/lpfc/lpfc_bsg.c                  |  8 +--
 drivers/scsi/lpfc/lpfc_mem.c                  |  8 +--
 drivers/scsi/megaraid/megaraid_sas_base.c     | 11 +---
 drivers/scsi/mpi3mr/mpi3mr_os.c               | 13 ++--
 drivers/scsi/mvumi.c                          | 15 +----
 drivers/scsi/qla1280.c                        |  6 +-
 drivers/scsi/qla2xxx/qla_target.c             | 18 +++---
 .../staging/media/atomisp/pci/atomisp_cmd.c   |  5 +-
 drivers/staging/media/omap4iss/iss_video.c    |  9 +--
 drivers/staging/nvec/nvec.c                   |  4 +-
 drivers/target/target_core_tmr.c              |  5 +-
 drivers/tee/optee/call.c                      |  5 +-
 drivers/thunderbolt/nhi.c                     |  9 +--
 drivers/thunderbolt/tb.c                      |  8 +--
 drivers/usb/core/hcd.c                        |  7 +--
 drivers/usb/core/hub.c                        |  9 +--
 drivers/usb/gadget/composite.c                |  7 +--
 drivers/usb/gadget/function/f_printer.c       | 28 ++-------
 drivers/usb/gadget/function/u_ether.c         | 14 +----
 drivers/usb/gadget/function/u_serial.c        |  4 +-
 drivers/usb/gadget/function/uvc_queue.c       |  5 +-
 drivers/usb/gadget/legacy/inode.c             | 10 ++--
 drivers/usb/gadget/udc/dummy_hcd.c            |  6 +-
 drivers/usb/host/ehci-q.c                     |  6 +-
 drivers/usb/host/xhci-dbgtty.c                |  5 +-
 drivers/usb/mon/mon_main.c                    |  7 +--
 drivers/usb/mon/mon_text.c                    |  6 +-
 drivers/usb/usbip/vudc_dev.c                  |  5 +-
 drivers/usb/usbip/vudc_tx.c                   |  5 +-
 drivers/video/fbdev/udlfb.c                   |  5 +-
 drivers/watchdog/watchdog_core.c              | 10 +---
 drivers/xen/gntalloc.c                        |  5 +-
 drivers/xen/gntdev.c                          |  6 +-
 drivers/xen/xen-pciback/pci_stub.c            |  6 +-
 drivers/xen/xenbus/xenbus_dev_frontend.c      |  5 +-
 fs/afs/inode.c                                |  7 +--
 fs/afs/write.c                                |  5 +-
 fs/btrfs/backref.c                            | 10 +---
 fs/btrfs/block-group.c                        | 47 +++------------
 fs/btrfs/disk-io.c                            | 13 +---
 fs/btrfs/inode.c                              | 12 +---
 fs/btrfs/ordered-data.c                       |  7 +--
 fs/btrfs/qgroup.c                             | 17 ++----
 fs/btrfs/raid56.c                             |  6 +-
 fs/btrfs/ref-verify.c                         | 16 ++---
 fs/btrfs/relocation.c                         | 34 +++--------
 fs/btrfs/transaction.c                        | 26 +++-----
 fs/btrfs/tree-log.c                           |  6 +-
 fs/btrfs/volumes.c                            | 12 +---
 fs/btrfs/zstd.c                               |  5 +-
 fs/ceph/caps.c                                | 17 ++----
 fs/ceph/file.c                                |  6 +-
 fs/ceph/mds_client.c                          | 12 ++--
 fs/ceph/snap.c                                | 19 ++----
 fs/char_dev.c                                 |  8 +--
 fs/dlm/lockspace.c                            |  6 +-
 fs/dlm/member.c                               |  4 +-
 fs/ecryptfs/kthread.c                         |  7 +--
 fs/exfat/cache.c                              |  5 +-
 fs/ext4/fast_commit.c                         |  7 +--
 fs/ext4/page-io.c                             |  4 +-
 fs/ext4/super.c                               |  5 +-
 fs/fat/cache.c                                |  5 +-
 fs/fuse/dev.c                                 |  7 +--
 fs/gfs2/bmap.c                                |  5 +-
 fs/gfs2/glock.c                               |  4 +-
 fs/gfs2/log.c                                 |  8 +--
 fs/gfs2/lops.c                                | 14 +----
 fs/gfs2/quota.c                               |  6 +-
 fs/gfs2/recovery.c                            |  5 +-
 fs/gfs2/super.c                               |  4 +-
 fs/inode.c                                    |  7 +--
 fs/locks.c                                    |  5 +-
 fs/namespace.c                                |  8 +--
 fs/netfs/objects.c                            |  5 +-
 fs/nfs/blocklayout/blocklayout.c              |  8 +--
 fs/nfs/dir.c                                  |  5 +-
 fs/nfs/filelayout/filelayoutdev.c             | 11 +---
 fs/nfs/flexfilelayout/flexfilelayoutdev.c     | 18 +-----
 fs/nfs/nfs42xattr.c                           | 11 +---
 fs/nfs/nfs4client.c                           | 11 +---
 fs/nfs/pnfs_nfs.c                             |  7 +--
 fs/nfsd/filecache.c                           | 10 +---
 fs/nfsd/nfs4layouts.c                         |  6 +-
 fs/nfsd/nfs4state.c                           | 59 +++++--------------
 fs/nfsd/nfscache.c                            |  4 +-
 fs/nilfs2/gcinode.c                           |  4 +-
 fs/nilfs2/mdt.c                               |  6 +-
 fs/nilfs2/recovery.c                          | 14 ++---
 fs/nilfs2/segment.c                           |  7 +--
 fs/ocfs2/filecheck.c                          |  5 +-
 fs/pnode.c                                    | 24 +++-----
 fs/proc/vmcore.c                              | 19 +++---
 fs/smb/client/smbdirect.c                     |  6 +-
 fs/smb/server/crypto_ctx.c                    |  7 +--
 fs/smb/server/mgmt/share_config.c             |  8 +--
 fs/ubifs/commit.c                             |  6 +-
 fs/ubifs/gc.c                                 |  7 +--
 fs/ubifs/replay.c                             |  5 +-
 fs/ubifs/scan.c                               |  6 +-
 fs/ubifs/super.c                              | 20 ++-----
 fs/xfs/xfs_buf.c                              | 20 ++-----
 fs/xfs/xfs_log_cil.c                          | 12 ++--
 fs/xfs/xfs_qm.c                               |  8 +--
 io_uring/io_uring.c                           |  9 +--
 io_uring/kbuf.c                               |  8 +--
 kernel/audit_tree.c                           |  9 +--
 kernel/kthread.c                              | 10 ++--
 kernel/padata.c                               | 10 +---
 kernel/rcu/srcutiny.c                         |  6 +-
 kernel/sched/fair.c                           |  6 +-
 kernel/signal.c                               |  5 +-
 net/9p/trans_fd.c                             |  8 +--
 net/bluetooth/l2cap_core.c                    |  5 +-
 net/ceph/osd_client.c                         |  8 +--
 net/ceph/osdmap.c                             |  7 +--
 net/ceph/pagelist.c                           | 15 ++---
 net/core/dev.c                                | 15 +----
 net/handshake/netlink.c                       |  5 +-
 net/ipv6/addrconf.c                           | 16 +----
 net/mac80211/ibss.c                           | 10 +---
 net/mac80211/ocb.c                            | 10 +---
 net/rds/send.c                                | 10 +---
 net/rxrpc/call_object.c                       |  5 +-
 net/rxrpc/conn_object.c                       |  6 +-
 net/rxrpc/peer_event.c                        |  6 +-
 net/sunrpc/auth.c                             |  5 +-
 net/sunrpc/backchannel_rqst.c                 |  7 +--
 net/sunrpc/cache.c                            | 10 +---
 net/sunrpc/svc_xprt.c                         | 10 +---
 net/sunrpc/xprt.c                             |  5 +-
 net/sunrpc/xprtrdma/verbs.c                   |  9 +--
 net/vmw_vsock/vmci_transport.c                |  7 +--
 net/wireless/core.c                           |  8 +--
 net/wireless/reg.c                            |  7 +--
 net/wireless/util.c                           |  5 +-
 security/apparmor/lsm.c                       |  5 +-
 sound/core/misc.c                             |  4 +-
 sound/core/rawmidi.c                          |  5 +-
 sound/core/timer.c                            |  9 +--
 sound/core/ump.c                              |  5 +-
 sound/hda/ext/hdac_ext_controller.c           |  5 +-
 sound/pci/ctxfi/ctimap.c                      |  7 +--
 sound/pci/ctxfi/ctvmem.c                      | 14 +----
 sound/pci/hda/hda_codec.c                     |  8 +--
 sound/pci/hda/hda_controller.c                |  5 +-
 sound/soc/codecs/wm0010.c                     |  5 +-
 sound/soc/soc-pcm.c                           |  5 +-
 sound/usb/midi2.c                             |  6 +-
 296 files changed, 616 insertions(+), 1966 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/pfunc_core.c b/arch/powerpc/platforms/powermac/pfunc_core.c
index 22741ddfd5b2..0bde0a0dcdf6 100644
--- a/arch/powerpc/platforms/powermac/pfunc_core.c
+++ b/arch/powerpc/platforms/powermac/pfunc_core.c
@@ -779,6 +779,7 @@ EXPORT_SYMBOL_GPL(pmf_put_function);
 
 void pmf_unregister_driver(struct device_node *np)
 {
+	struct pmf_function *func;
 	struct pmf_device *dev;
 	unsigned long flags;
 
@@ -793,12 +794,8 @@ void pmf_unregister_driver(struct device_node *np)
 	}
 	list_del(&dev->link);
 
-	while(!list_empty(&dev->functions)) {
-		struct pmf_function *func =
-			list_entry(dev->functions.next, typeof(*func), link);
-		list_del(&func->link);
+	list_for_each_entry_del(func, &dev->functions, link) {
 		__pmf_put_function(func);
-	}
 
 	pmf_put_device(dev);
 	spin_unlock_irqrestore(&pmf_lock, flags);
diff --git a/arch/powerpc/platforms/powernv/opal-hmi.c b/arch/powerpc/platforms/powernv/opal-hmi.c
index f0c1830deb51..c345bfe53e8c 100644
--- a/arch/powerpc/platforms/powernv/opal-hmi.c
+++ b/arch/powerpc/platforms/powernv/opal-hmi.c
@@ -277,10 +277,7 @@ static void hmi_event_handler(struct work_struct *work)
 	int unrecoverable = 0;
 
 	spin_lock_irqsave(&opal_hmi_evt_lock, flags);
-	while (!list_empty(&opal_hmi_evt_list)) {
-		msg_node = list_entry(opal_hmi_evt_list.next,
-					   struct OpalHmiEvtNode, list);
-		list_del(&msg_node->list);
+	list_for_each_entry_del(msg_node, &opal_hmi_evt_list, list) {
 		spin_unlock_irqrestore(&opal_hmi_evt_lock, flags);
 
 		hmi_evt = (struct OpalHMIEvent *) &msg_node->hmi_evt;
diff --git a/arch/powerpc/platforms/powernv/opal-memory-errors.c b/arch/powerpc/platforms/powernv/opal-memory-errors.c
index a1754a28265d..ae311b9e320c 100644
--- a/arch/powerpc/platforms/powernv/opal-memory-errors.c
+++ b/arch/powerpc/platforms/powernv/opal-memory-errors.c
@@ -58,10 +58,7 @@ static void handle_memory_error(void)
 	struct OpalMsgNode *msg_node;
 
 	spin_lock_irqsave(&opal_mem_err_lock, flags);
-	while (!list_empty(&opal_memory_err_list)) {
-		 msg_node = list_entry(opal_memory_err_list.next,
-					   struct OpalMsgNode, list);
-		list_del(&msg_node->list);
+	list_for_each_entry_del(msg_node, &opal_memory_err_list, list) {
 		spin_unlock_irqrestore(&opal_mem_err_lock, flags);
 
 		merr_evt = (struct OpalMemoryErrorData *)
diff --git a/arch/powerpc/platforms/pseries/hvcserver.c b/arch/powerpc/platforms/pseries/hvcserver.c
index d48c9c7ce10f..ad6ef95e9683 100644
--- a/arch/powerpc/platforms/pseries/hvcserver.c
+++ b/arch/powerpc/platforms/pseries/hvcserver.c
@@ -62,17 +62,12 @@ static int hvcs_convert(long to_convert)
 int hvcs_free_partner_info(struct list_head *head)
 {
 	struct hvcs_partner_info *pi;
-	struct list_head *element;
 
 	if (!head)
 		return -EINVAL;
 
-	while (!list_empty(head)) {
-		element = head->next;
-		pi = list_entry(element, struct hvcs_partner_info, node);
-		list_del(element);
+	list_for_each_entry_del(pi, head, node)
 		kfree(pi);
-	}
 
 	return 0;
 }
diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index 279148e72459..ce5fbe8ef27e 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -745,10 +745,7 @@ void sgx_encl_release(struct kref *ref)
 		encl->secs.epc_page = NULL;
 	}
 
-	while (!list_empty(&encl->va_pages)) {
-		va_page = list_first_entry(&encl->va_pages, struct sgx_va_page,
-					   list);
-		list_del(&va_page->list);
+	list_for_each_entry_del(va_page, &encl->va_pages, list) {
 		sgx_encl_free_epc_page(va_page->epc_page);
 		kfree(va_page);
 	}
diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 3cce6de464a7..4604e7031eb8 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -6296,13 +6296,10 @@ static void bfq_insert_requests(struct blk_mq_hw_ctx *hctx,
 				struct list_head *list,
 				blk_insert_t flags)
 {
-	while (!list_empty(list)) {
-		struct request *rq;
+	struct request *rq;
 
-		rq = list_first_entry(list, struct request, queuelist);
-		list_del_init(&rq->queuelist);
+	list_for_each_entry_del_init(rq, list, queuelist)
 		bfq_insert_request(hctx, rq, flags);
-	}
 }
 
 static void bfq_update_hw_tag(struct bfq_data *bfqd)
diff --git a/block/blk-core.c b/block/blk-core.c
index 9d51e9894ece..c8b13562908c 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1098,15 +1098,12 @@ static void flush_plug_callbacks(struct blk_plug *plug, bool from_schedule)
 	LIST_HEAD(callbacks);
 
 	while (!list_empty(&plug->cb_list)) {
+		struct blk_plug_cb *cb;
+
 		list_splice_init(&plug->cb_list, &callbacks);
 
-		while (!list_empty(&callbacks)) {
-			struct blk_plug_cb *cb = list_first_entry(&callbacks,
-							  struct blk_plug_cb,
-							  list);
-			list_del(&cb->list);
+		list_for_each_entry_del(cb, &callbacks, list)
 			cb->callback(cb, from_schedule);
-		}
 	}
 }
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 1fafd54dce3c..87992c13005a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1488,11 +1488,8 @@ static void blk_mq_requeue_work(struct work_struct *work)
 		}
 	}
 
-	while (!list_empty(&flush_list)) {
-		rq = list_entry(flush_list.next, struct request, queuelist);
-		list_del_init(&rq->queuelist);
+	list_for_each_entry_del_init(rq, &flush_list, queuelist)
 		blk_mq_insert_request(rq, 0);
-	}
 
 	blk_mq_run_hw_queues(q, false);
 }
@@ -2821,14 +2818,11 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 static void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
 		struct list_head *list)
 {
+	struct request *rq;
 	int queued = 0;
 	blk_status_t ret = BLK_STS_OK;
 
-	while (!list_empty(list)) {
-		struct request *rq = list_first_entry(list, struct request,
-				queuelist);
-
-		list_del_init(&rq->queuelist);
+	list_for_each_entry_del_init(rq, list, queuelist) {
 		ret = blk_mq_request_issue_directly(rq, list_empty(list));
 		switch (ret) {
 		case BLK_STS_OK:
@@ -3271,9 +3265,7 @@ void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
 
 	blk_mq_clear_rq_mapping(drv_tags, tags);
 
-	while (!list_empty(&tags->page_list)) {
-		page = list_first_entry(&tags->page_list, struct page, lru);
-		list_del_init(&page->lru);
+	list_for_each_entry_del_init(page, &tags->page_list, lru) {
 		/*
 		 * Remove kmemleak object previously allocated in
 		 * blk_mq_alloc_rqs().
diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index f958e79277b8..94bda20d6486 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -865,18 +865,14 @@ static void dd_insert_requests(struct blk_mq_hw_ctx *hctx,
 			       struct list_head *list,
 			       blk_insert_t flags)
 {
+	struct request *rq;
 	struct request_queue *q = hctx->queue;
 	struct deadline_data *dd = q->elevator->elevator_data;
 	LIST_HEAD(free);
 
 	spin_lock(&dd->lock);
-	while (!list_empty(list)) {
-		struct request *rq;
-
-		rq = list_first_entry(list, struct request, queuelist);
-		list_del_init(&rq->queuelist);
+	list_for_each_entry_del_init(rq, list, queuelist)
 		dd_insert_request(hctx, rq, flags, &free);
-	}
 	spin_unlock(&dd->lock);
 
 	blk_mq_free_requests(&free);
diff --git a/drivers/accel/qaic/qaic_data.c b/drivers/accel/qaic/qaic_data.c
index f4b06792c6f1..9cf985736db1 100644
--- a/drivers/accel/qaic/qaic_data.c
+++ b/drivers/accel/qaic/qaic_data.c
@@ -1805,10 +1805,8 @@ static void empty_xfer_list(struct qaic_device *qdev, struct dma_bridge_chan *db
 	struct qaic_bo *bo;
 
 	spin_lock_irqsave(&dbc->xfer_lock, flags);
-	while (!list_empty(&dbc->xfer_list)) {
-		bo = list_first_entry(&dbc->xfer_list, typeof(*bo), xfer_list);
+	list_for_each_entry_del(bo, &dbc->xfer_list, xfer_list) {
 		bo->queued = false;
-		list_del(&bo->xfer_list);
 		spin_unlock_irqrestore(&dbc->xfer_lock, flags);
 		dma_sync_sgtable_for_cpu(&qdev->pdev->dev, bo->sgt, bo->dir);
 		complete_all(&bo->xfer_done);
diff --git a/drivers/accel/qaic/qaic_drv.c b/drivers/accel/qaic/qaic_drv.c
index b5de82e6eb4d..5e392a4ef5e1 100644
--- a/drivers/accel/qaic/qaic_drv.c
+++ b/drivers/accel/qaic/qaic_drv.c
@@ -243,9 +243,7 @@ static void qaic_destroy_drm_device(struct qaic_device *qdev, s32 partition_id)
 	 * user list.
 	 */
 	mutex_lock(&qddev->users_mutex);
-	while (!list_empty(&qddev->users)) {
-		usr = list_first_entry(&qddev->users, struct qaic_user, node);
-		list_del_init(&usr->node);
+	list_for_each_entry_del_init(usr, &qddev->users, node) {
 		kref_get(&usr->ref_count);
 		usr->qddev = NULL;
 		mutex_unlock(&qddev->users_mutex);
diff --git a/drivers/acpi/acpi_ipmi.c b/drivers/acpi/acpi_ipmi.c
index 0555f68c2dfd..42df6b201f18 100644
--- a/drivers/acpi/acpi_ipmi.c
+++ b/drivers/acpi/acpi_ipmi.c
@@ -335,11 +335,7 @@ static void ipmi_flush_tx_msg(struct acpi_ipmi_device *ipmi)
 	 * ipmi_recv_msg(s) are freed after invoking ipmi_destroy_user().
 	 */
 	spin_lock_irqsave(&ipmi->tx_msg_lock, flags);
-	while (!list_empty(&ipmi->tx_msg_list)) {
-		tx_msg = list_first_entry(&ipmi->tx_msg_list,
-					  struct acpi_ipmi_msg,
-					  head);
-		list_del(&tx_msg->head);
+	list_for_each_entry_del(tx_msg, &ipmi->tx_msg_list, head) {
 		spin_unlock_irqrestore(&ipmi->tx_msg_lock, flags);
 
 		/* wake up the sleep thread on the Tx msg */
diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index e3db8297095a..b74ffcde674c 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -827,12 +827,8 @@ void binder_alloc_deferred_release(struct binder_alloc *alloc)
 		buffers++;
 	}
 
-	while (!list_empty(&alloc->buffers)) {
-		buffer = list_first_entry(&alloc->buffers,
-					  struct binder_buffer, entry);
+	list_for_each_entry_del(buffer, &alloc->buffers, entry) {
 		WARN_ON(!buffer->free);
-
-		list_del(&buffer->entry);
 		WARN_ON_ONCE(!list_empty(&alloc->buffers));
 		kfree(buffer);
 	}
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index a528cec24264..1796659df9b9 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -95,11 +95,9 @@ static void deferred_probe_work_func(struct work_struct *work)
 	 * from under our feet.
 	 */
 	mutex_lock(&deferred_probe_mutex);
-	while (!list_empty(&deferred_probe_active_list)) {
-		private = list_first_entry(&deferred_probe_active_list,
-					typeof(*dev->p), deferred_probe);
+	list_for_each_entry_del_init(private, &deferred_probe_active_list,
+				     deferred_probe) {
 		dev = private->device;
-		list_del_init(&private->deferred_probe);
 
 		get_device(dev);
 
diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index b58c42f1b1ce..7ee7e2cdc3b3 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -1439,10 +1439,7 @@ static void __device_uncache_fw_images(void)
 	struct fw_cache_entry *fce;
 
 	spin_lock(&fwc->name_lock);
-	while (!list_empty(&fwc->fw_names)) {
-		fce = list_entry(fwc->fw_names.next,
-				struct fw_cache_entry, list);
-		list_del(&fce->list);
+	list_for_each_entry_del(fce, &fwc->fw_names, list) {
 		spin_unlock(&fwc->name_lock);
 
 		uncache_firmware(fce->name);
diff --git a/drivers/base/regmap/regmap-debugfs.c b/drivers/base/regmap/regmap-debugfs.c
index f36027591e1a..84ff2d11d753 100644
--- a/drivers/base/regmap/regmap-debugfs.c
+++ b/drivers/base/regmap/regmap-debugfs.c
@@ -68,13 +68,8 @@ static void regmap_debugfs_free_dump_cache(struct regmap *map)
 {
 	struct regmap_debugfs_off_cache *c;
 
-	while (!list_empty(&map->debugfs_off_cache)) {
-		c = list_first_entry(&map->debugfs_off_cache,
-				     struct regmap_debugfs_off_cache,
-				     list);
-		list_del(&c->list);
+	list_for_each_entry_del(c, &map->debugfs_off_cache, list)
 		kfree(c);
-	}
 }
 
 static bool regmap_printable(struct regmap *map, unsigned int reg)
diff --git a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
index d7317425be51..9c20aa87ad84 100644
--- a/drivers/block/aoe/aoecmd.c
+++ b/drivers/block/aoe/aoecmd.c
@@ -1644,17 +1644,13 @@ aoe_flush_iocq_by_index(int id)
 	struct frame *f;
 	struct aoedev *d;
 	LIST_HEAD(flist);
-	struct list_head *pos;
 	struct sk_buff *skb;
 	ulong flags;
 
 	spin_lock_irqsave(&iocq[id].lock, flags);
 	list_splice_init(&iocq[id].head, &flist);
 	spin_unlock_irqrestore(&iocq[id].lock, flags);
-	while (!list_empty(&flist)) {
-		pos = flist.next;
-		list_del(pos);
-		f = list_entry(pos, struct frame, head);
+	list_for_each_entry_del(f, &flist, head) {
 		d = f->t->d;
 		skb = f->r_skb;
 		spin_lock_irqsave(&d->lock, flags);
diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index d3538bd83fb3..d34164a12798 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -4836,12 +4836,10 @@ static int notify_initial_state_done(struct sk_buff *skb, unsigned int seq)
 
 static void free_state_changes(struct list_head *list)
 {
-	while (!list_empty(list)) {
-		struct drbd_state_change *state_change =
-			list_first_entry(list, struct drbd_state_change, list);
-		list_del(&state_change->list);
+	struct drbd_state_change *state_change;
+
+	list_for_each_entry_del(state_change, list, list)
 		forget_state_change(state_change);
-	}
 }
 
 static unsigned int notifications_for_state_change(struct drbd_state_change *state_change)
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 9f2d412fc560..282983bf9e30 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1941,10 +1941,7 @@ static void loop_process_work(struct loop_worker *worker,
 
 	current->flags |= PF_LOCAL_THROTTLE | PF_MEMALLOC_NOIO;
 	spin_lock_irq(&lo->lo_work_lock);
-	while (!list_empty(cmd_list)) {
-		cmd = container_of(
-			cmd_list->next, struct loop_cmd, list_entry);
-		list_del(cmd_list->next);
+	list_for_each_entry_del(cmd, cmd_list, list_entry) {
 		spin_unlock_irq(&lo->lo_work_lock);
 
 		loop_handle_cmd(cmd);
diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 800f131222fc..cee388b441d2 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -2564,9 +2564,7 @@ static void __exit nbd_cleanup(void)
 	idr_for_each(&nbd_index_idr, &nbd_exit_cb, &del_list);
 	mutex_unlock(&nbd_index_mutex);
 
-	while (!list_empty(&del_list)) {
-		nbd = list_first_entry(&del_list, struct nbd_device, list);
-		list_del_init(&nbd->list);
+	list_for_each_entry_del_init(nbd, &del_list, list) {
 		if (refcount_read(&nbd->config_refs))
 			pr_err("possibly leaking nbd_config (ref %d)\n",
 					refcount_read(&nbd->config_refs));
diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 968090935eb2..26104a7cf5b0 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1640,6 +1640,7 @@ static void null_map_queues(struct blk_mq_tag_set *set)
 
 static int null_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
 {
+	struct request *req;
 	struct nullb_queue *nq = hctx->driver_data;
 	LIST_HEAD(list);
 	int nr = 0;
@@ -1651,12 +1652,9 @@ static int null_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
 		blk_mq_set_request_complete(rq);
 	spin_unlock(&nq->poll_lock);
 
-	while (!list_empty(&list)) {
+	list_for_each_entry_del_init(req, &list, queuelist) {
 		struct nullb_cmd *cmd;
-		struct request *req;
 
-		req = list_first_entry(&list, struct request, queuelist);
-		list_del_init(&req->queuelist);
 		cmd = blk_mq_rq_to_pdu(req);
 		cmd->error = null_process_cmd(cmd, req_op(req), blk_rq_pos(req),
 						blk_rq_sectors(req));
diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index a999b698b131..142747ce3e52 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1493,10 +1493,8 @@ static void rbd_obj_request_destroy(struct kref *kref)
 
 	dout("%s: obj %p\n", __func__, obj_request);
 
-	while (!list_empty(&obj_request->osd_reqs)) {
-		osd_req = list_first_entry(&obj_request->osd_reqs,
-				    struct ceph_osd_request, r_private_item);
-		list_del_init(&osd_req->r_private_item);
+	list_for_each_entry_del_init(osd_req, &obj_request->osd_reqs,
+				     r_private_item) {
 		ceph_osdc_put_request(osd_req);
 	}
 
diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
index c362f4ad80ab..5cb0c378540c 100644
--- a/drivers/block/xen-blkback/blkback.c
+++ b/drivers/block/xen-blkback/blkback.c
@@ -300,12 +300,8 @@ void xen_blkbk_unmap_purged_grants(struct work_struct *work)
 	unmap_data.unmap_ops = unmap;
 	unmap_data.kunmap_ops = NULL;
 
-	while(!list_empty(&ring->persistent_purge_list)) {
-		persistent_gnt = list_first_entry(&ring->persistent_purge_list,
-		                                  struct persistent_gnt,
-		                                  remove_node);
-		list_del(&persistent_gnt->remove_node);
-
+	list_for_each_entry_del(persistent_gnt, &ring->persistent_purge_list,
+				remove_node) {
 		gnttab_set_unmap_op(&unmap[segs_to_unmap],
 			vaddr(persistent_gnt->page),
 			GNTMAP_host_map,
diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index 186f1fee7534..31ee10ac4ea8 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -3723,7 +3723,6 @@ static void cleanup_smi_msgs(struct ipmi_smi *intf)
 	int              i;
 	struct seq_table *ent;
 	struct ipmi_smi_msg *msg;
-	struct list_head *entry;
 	struct list_head tmplist;
 
 	/* Clear out our transmit queues and hold the messages. */
@@ -3743,12 +3742,8 @@ static void cleanup_smi_msgs(struct ipmi_smi *intf)
 	 * Return errors for all pending messages in queue and in the
 	 * tables waiting for remote responses.
 	 */
-	while (!list_empty(&tmplist)) {
-		entry = tmplist.next;
-		list_del(entry);
-		msg = list_entry(entry, struct ipmi_smi_msg, link);
+	list_for_each_entry_del(msg, &tmplist, link)
 		deliver_smi_err_response(intf, msg, IPMI_ERR_UNSPECIFIED);
-	}
 
 	for (i = 0; i < IPMI_IPMB_NUM_SEQ; i++) {
 		ent = &intf->seq_table[i];
@@ -4764,10 +4759,7 @@ static void handle_new_recv_msgs(struct ipmi_smi *intf)
 	/* See if any waiting messages need to be processed. */
 	if (!run_to_completion)
 		spin_lock_irqsave(&intf->waiting_rcv_msgs_lock, flags);
-	while (!list_empty(&intf->waiting_rcv_msgs)) {
-		smi_msg = list_entry(intf->waiting_rcv_msgs.next,
-				     struct ipmi_smi_msg, link);
-		list_del(&smi_msg->link);
+	list_for_each_entry_del(smi_msg, &intf->waiting_rcv_msgs, link) {
 		if (!run_to_completion)
 			spin_unlock_irqrestore(&intf->waiting_rcv_msgs_lock,
 					       flags);
diff --git a/drivers/crypto/ccp/ccp-dev-v3.c b/drivers/crypto/ccp/ccp-dev-v3.c
index fe69053b2394..f07b14efb5e4 100644
--- a/drivers/crypto/ccp/ccp-dev-v3.c
+++ b/drivers/crypto/ccp/ccp-dev-v3.c
@@ -550,16 +550,12 @@ static void ccp_destroy(struct ccp_device *ccp)
 		dma_pool_destroy(ccp->cmd_q[i].dma_pool);
 
 	/* Flush the cmd and backlog queue */
-	while (!list_empty(&ccp->cmd)) {
+	list_for_each_entry_del(cmd, &ccp->cmd, entry) {
 		/* Invoke the callback directly with an error code */
-		cmd = list_first_entry(&ccp->cmd, struct ccp_cmd, entry);
-		list_del(&cmd->entry);
 		cmd->callback(cmd->data, -ENODEV);
 	}
-	while (!list_empty(&ccp->backlog)) {
+	list_for_each_entry_del(cmd, &ccp->backlog, entry) {
 		/* Invoke the callback directly with an error code */
-		cmd = list_first_entry(&ccp->backlog, struct ccp_cmd, entry);
-		list_del(&cmd->entry);
 		cmd->callback(cmd->data, -ENODEV);
 	}
 }
diff --git a/drivers/crypto/ccp/ccp-dev-v5.c b/drivers/crypto/ccp/ccp-dev-v5.c
index 7b73332d6aa1..8c1002eea436 100644
--- a/drivers/crypto/ccp/ccp-dev-v5.c
+++ b/drivers/crypto/ccp/ccp-dev-v5.c
@@ -1048,16 +1048,12 @@ static void ccp5_destroy(struct ccp_device *ccp)
 	sp_free_ccp_irq(ccp->sp, ccp);
 
 	/* Flush the cmd and backlog queue */
-	while (!list_empty(&ccp->cmd)) {
+	list_for_each_entry_del(cmd, &ccp->cmd, entry) {
 		/* Invoke the callback directly with an error code */
-		cmd = list_first_entry(&ccp->cmd, struct ccp_cmd, entry);
-		list_del(&cmd->entry);
 		cmd->callback(cmd->data, -ENODEV);
 	}
-	while (!list_empty(&ccp->backlog)) {
+	list_for_each_entry_del(cmd, &ccp->backlog, entry) {
 		/* Invoke the callback directly with an error code */
-		cmd = list_first_entry(&ccp->backlog, struct ccp_cmd, entry);
-		list_del(&cmd->entry);
 		cmd->callback(cmd->data, -ENODEV);
 	}
 }
diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 3cf0b38387ae..f6c44a8f3ff3 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -1716,10 +1716,7 @@ static int pl330_update(struct pl330_dmac *pl330)
 	}
 
 	/* Now that we are in no hurry, do the callbacks */
-	while (!list_empty(&pl330->req_done)) {
-		descdone = list_first_entry(&pl330->req_done,
-					    struct dma_pl330_desc, rqd);
-		list_del(&descdone->rqd);
+	list_for_each_entry_del(descdone, &pl330->req_done, rqd) {
 		spin_unlock_irqrestore(&pl330->lock, flags);
 		dma_pl330_rqcb(descdone, PL330_ERR_NONE);
 		spin_lock_irqsave(&pl330->lock, flags);
diff --git a/drivers/dma/ptdma/ptdma-dev.c b/drivers/dma/ptdma/ptdma-dev.c
index a2bf13ff18b6..86f6184ef4e4 100644
--- a/drivers/dma/ptdma/ptdma-dev.c
+++ b/drivers/dma/ptdma/ptdma-dev.c
@@ -300,10 +300,8 @@ void pt_core_destroy(struct pt_device *pt)
 			  cmd_q->qbase_dma);
 
 	/* Flush the cmd queue */
-	while (!list_empty(&pt->cmd)) {
+	list_for_each_entry_del(cmd, &pt->cmd, entry) {
 		/* Invoke the callback directly with an error code */
-		cmd = list_first_entry(&pt->cmd, struct pt_cmd, entry);
-		list_del(&cmd->entry);
 		cmd->pt_cmd_callback(cmd->data, -ENODEV);
 	}
 }
diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index 063022f9df76..45e84382291d 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -641,10 +641,7 @@ static void tegra_dma_tasklet(struct tasklet_struct *t)
 	unsigned long flags;
 
 	spin_lock_irqsave(&tdc->lock, flags);
-	while (!list_empty(&tdc->cb_desc)) {
-		dma_desc = list_first_entry(&tdc->cb_desc, typeof(*dma_desc),
-					    cb_node);
-		list_del(&dma_desc->cb_node);
+	list_for_each_entry_del(dma_desc, &tdc->cb_desc, cb_node) {
 		dmaengine_desc_get_callback(&dma_desc->txd, &cb);
 		cb_count = dma_desc->cb_count;
 		dma_desc->cb_count = 0;
@@ -778,12 +775,8 @@ static int tegra_dma_terminate_all(struct dma_chan *dc)
 skip_dma_stop:
 	tegra_dma_abort_all(tdc);
 
-	while (!list_empty(&tdc->cb_desc)) {
-		dma_desc = list_first_entry(&tdc->cb_desc, typeof(*dma_desc),
-					    cb_node);
-		list_del(&dma_desc->cb_node);
+	list_for_each_entry_del(dma_desc, &tdc->cb_desc, cb_node)
 		dma_desc->cb_count = 0;
-	}
 	spin_unlock_irqrestore(&tdc->lock, flags);
 
 	return 0;
@@ -1326,18 +1319,11 @@ static void tegra_dma_free_chan_resources(struct dma_chan *dc)
 	tdc->config_init = false;
 	tdc->isr_handler = NULL;
 
-	while (!list_empty(&dma_desc_list)) {
-		dma_desc = list_first_entry(&dma_desc_list, typeof(*dma_desc),
-					    node);
-		list_del(&dma_desc->node);
+	list_for_each_entry_del(dma_desc, &dma_desc_list, node)
 		kfree(dma_desc);
-	}
 
-	while (!list_empty(&sg_req_list)) {
-		sg_req = list_first_entry(&sg_req_list, typeof(*sg_req), node);
-		list_del(&sg_req->node);
+	list_for_each_entry_del(sg_req, &sg_req_list, node)
 		kfree(sg_req);
-	}
 
 	tdc->slave_id = TEGRA_APBDMA_SLAVE_ID_INVALID;
 }
diff --git a/drivers/firmware/cirrus/cs_dsp.c b/drivers/firmware/cirrus/cs_dsp.c
index 79d4254d1f9b..0980d6c841e9 100644
--- a/drivers/firmware/cirrus/cs_dsp.c
+++ b/drivers/firmware/cirrus/cs_dsp.c
@@ -332,11 +332,9 @@ static struct cs_dsp_buf *cs_dsp_buf_alloc(const void *src, size_t len,
 
 static void cs_dsp_buf_free(struct list_head *list)
 {
-	while (!list_empty(list)) {
-		struct cs_dsp_buf *buf = list_first_entry(list,
-							  struct cs_dsp_buf,
-							  list);
-		list_del(&buf->list);
+	struct cs_dsp_buf *buf;
+
+	list_for_each_entry_del(buf, list, list) {
 		vfree(buf->buf);
 		kfree(buf);
 	}
@@ -1655,13 +1653,8 @@ static void cs_dsp_free_alg_regions(struct cs_dsp *dsp)
 {
 	struct cs_dsp_alg_region *alg_region;
 
-	while (!list_empty(&dsp->alg_regions)) {
-		alg_region = list_first_entry(&dsp->alg_regions,
-					      struct cs_dsp_alg_region,
-					      list);
-		list_del(&alg_region->list);
+	list_for_each_entry_del(alg_region, &dsp->alg_regions, list)
 		kfree(alg_region);
-	}
 }
 
 static void cs_dsp_parse_wmfw_id_header(struct cs_dsp *dsp,
diff --git a/drivers/gpio/gpio-rockchip.c b/drivers/gpio/gpio-rockchip.c
index b35b9604413f..5992d4b2d753 100644
--- a/drivers/gpio/gpio-rockchip.c
+++ b/drivers/gpio/gpio-rockchip.c
@@ -746,11 +746,7 @@ static int rockchip_gpio_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	while (!list_empty(&bank->deferred_pins)) {
-		cfg = list_first_entry(&bank->deferred_pins,
-				       struct rockchip_pin_deferred, head);
-		list_del(&cfg->head);
-
+	list_for_each_entry_del(cfg, &bank->deferred_pins, head) {
 		switch (cfg->param) {
 		case PIN_CONFIG_OUTPUT:
 			ret = rockchip_gpio_direction_output(&bank->gpio_chip, cfg->pin, cfg->arg);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index f5daadcec865..a1dd04ff7a14 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1331,11 +1331,7 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
 	struct dma_fence *f = NULL;
 	int r;
 
-	while (!list_empty(&vm->freed)) {
-		mapping = list_first_entry(&vm->freed,
-			struct amdgpu_bo_va_mapping, list);
-		list_del(&mapping->list);
-
+	list_for_each_entry_del(mapping, &vm->freed, list) {
 		if (vm->pte_support_ats &&
 		    mapping->start < AMDGPU_GMC_HOLE_START)
 			init_pte_value = AMDGPU_PTE_DEFAULT_ATC;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index bb16b795d1bc..075488240aa5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -366,20 +366,17 @@ static bool svm_bo_ref_unless_zero(struct svm_range_bo *svm_bo)
 
 static void svm_range_bo_release(struct kref *kref)
 {
+	struct svm_range *prange;
 	struct svm_range_bo *svm_bo;
 
 	svm_bo = container_of(kref, struct svm_range_bo, kref);
 	pr_debug("svm_bo 0x%p\n", svm_bo);
 
 	spin_lock(&svm_bo->list_lock);
-	while (!list_empty(&svm_bo->range_list)) {
-		struct svm_range *prange =
-				list_first_entry(&svm_bo->range_list,
-						struct svm_range, svm_bo_list);
-		/* list_del_init tells a concurrent svm_range_vram_node_new when
-		 * it's safe to reuse the svm_bo pointer and svm_bo_list head.
-		 */
-		list_del_init(&prange->svm_bo_list);
+	/* list_del_init tells a concurrent svm_range_vram_node_new when
+	 * it's safe to reuse the svm_bo pointer and svm_bo_list head.
+	 */
+	list_for_each_entry_del_init(prange, &svm_bo->range_list, svm_bo_list) {
 		spin_unlock(&svm_bo->list_lock);
 
 		pr_debug("svms 0x%p [0x%lx 0x%lx]\n", prange->svms,
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/base.c b/drivers/gpu/drm/nouveau/nvkm/engine/disp/base.c
index 73104b59f97f..9745251a205b 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/base.c
@@ -324,17 +324,11 @@ nvkm_disp_dtor(struct nvkm_engine *engine)
 
 	nvkm_event_fini(&disp->vblank);
 
-	while (!list_empty(&disp->conns)) {
-		conn = list_first_entry(&disp->conns, typeof(*conn), head);
-		list_del(&conn->head);
+	list_for_each_entry_del(conn, &disp->conns, head)
 		nvkm_conn_del(&conn);
-	}
 
-	while (!list_empty(&disp->outps)) {
-		outp = list_first_entry(&disp->outps, typeof(*outp), head);
-		list_del(&outp->head);
+	list_for_each_entry_del(outp, &disp->outps, head)
 		nvkm_outp_del(&outp);
-	}
 
 	while (!list_empty(&disp->iors)) {
 		ior = list_first_entry(&disp->iors, typeof(*ior), head);
diff --git a/drivers/gpu/drm/vc4/vc4_gem.c b/drivers/gpu/drm/vc4/vc4_gem.c
index 03648f954985..1fc170d95d38 100644
--- a/drivers/gpu/drm/vc4/vc4_gem.c
+++ b/drivers/gpu/drm/vc4/vc4_gem.c
@@ -918,6 +918,7 @@ vc4_get_bcl(struct drm_device *dev, struct vc4_exec_info *exec)
 static void
 vc4_complete_exec(struct drm_device *dev, struct vc4_exec_info *exec)
 {
+	struct vc4_bo *bo;
 	struct vc4_dev *vc4 = to_vc4_dev(dev);
 	unsigned long irqflags;
 	unsigned i;
@@ -940,12 +941,8 @@ vc4_complete_exec(struct drm_device *dev, struct vc4_exec_info *exec)
 		kvfree(exec->bo);
 	}
 
-	while (!list_empty(&exec->unref_list)) {
-		struct vc4_bo *bo = list_first_entry(&exec->unref_list,
-						     struct vc4_bo, unref_head);
-		list_del(&bo->unref_head);
+	list_for_each_entry_del(bo, &exec->unref_list, unref_head)
 		drm_gem_object_put(&bo->base.base);
-	}
 
 	/* Free up the allocation of any bin slots we used. */
 	spin_lock_irqsave(&vc4->job_lock, irqflags);
@@ -967,6 +964,7 @@ vc4_complete_exec(struct drm_device *dev, struct vc4_exec_info *exec)
 void
 vc4_job_handle_completed(struct vc4_dev *vc4)
 {
+	struct vc4_exec_info *exec;
 	unsigned long irqflags;
 	struct vc4_seqno_cb *cb, *cb_temp;
 
@@ -974,12 +972,7 @@ vc4_job_handle_completed(struct vc4_dev *vc4)
 		return;
 
 	spin_lock_irqsave(&vc4->job_lock, irqflags);
-	while (!list_empty(&vc4->job_done_list)) {
-		struct vc4_exec_info *exec =
-			list_first_entry(&vc4->job_done_list,
-					 struct vc4_exec_info, head);
-		list_del(&exec->head);
-
+	list_for_each_entry_del(exec, &vc4->job_done_list, head) {
 		spin_unlock_irqrestore(&vc4->job_lock, irqflags);
 		vc4_complete_exec(&vc4->base, exec);
 		spin_lock_irqsave(&vc4->job_lock, irqflags);
diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virtio/virtgpu_gem.c
index 7db48d17ee3a..d1f022bab8ff 100644
--- a/drivers/gpu/drm/virtio/virtgpu_gem.c
+++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
@@ -284,10 +284,7 @@ void virtio_gpu_array_put_free_work(struct work_struct *work)
 	struct virtio_gpu_object_array *objs;
 
 	spin_lock(&vgdev->obj_free_lock);
-	while (!list_empty(&vgdev->obj_free_list)) {
-		objs = list_first_entry(&vgdev->obj_free_list,
-					struct virtio_gpu_object_array, next);
-		list_del(&objs->next);
+	list_for_each_entry_del(objs, &vgdev->obj_free_list, next) {
 		spin_unlock(&vgdev->obj_free_lock);
 		virtio_gpu_array_put_free(objs);
 		spin_lock(&vgdev->obj_free_lock);
diff --git a/drivers/gpu/ipu-v3/ipu-image-convert.c b/drivers/gpu/ipu-v3/ipu-image-convert.c
index 841316582ea9..38cebdc05c33 100644
--- a/drivers/gpu/ipu-v3/ipu-image-convert.c
+++ b/drivers/gpu/ipu-v3/ipu-image-convert.c
@@ -1552,13 +1552,7 @@ static void empty_done_q(struct ipu_image_convert_chan *chan)
 
 	spin_lock_irqsave(&chan->irqlock, flags);
 
-	while (!list_empty(&chan->done_q)) {
-		run = list_entry(chan->done_q.next,
-				 struct ipu_image_convert_run,
-				 list);
-
-		list_del(&run->list);
-
+	list_for_each_entry_del(run, &chan->done_q, list) {
 		dev_dbg(priv->ipu->dev,
 			"%s: task %u: completing ctx %p run %p with %d\n",
 			__func__, chan->ic_task, run->ctx, run, run->status);
diff --git a/drivers/hid/intel-ish-hid/ishtp/client-buffers.c b/drivers/hid/intel-ish-hid/ishtp/client-buffers.c
index 513d7a4a1b8a..e0e932bf6955 100644
--- a/drivers/hid/intel-ish-hid/ishtp/client-buffers.c
+++ b/drivers/hid/intel-ish-hid/ishtp/client-buffers.c
@@ -101,20 +101,14 @@ void ishtp_cl_free_rx_ring(struct ishtp_cl *cl)
 
 	/* release allocated memory - pass over free_rb_list */
 	spin_lock_irqsave(&cl->free_list_spinlock, flags);
-	while (!list_empty(&cl->free_rb_list.list)) {
-		rb = list_entry(cl->free_rb_list.list.next, struct ishtp_cl_rb,
-				list);
-		list_del(&rb->list);
+	list_for_each_entry_del(rb, &cl->free_rb_list.list, list) {
 		kfree(rb->buffer.data);
 		kfree(rb);
 	}
 	spin_unlock_irqrestore(&cl->free_list_spinlock, flags);
 	/* release allocated memory - pass over in_process_list */
 	spin_lock_irqsave(&cl->in_process_spinlock, flags);
-	while (!list_empty(&cl->in_process_list.list)) {
-		rb = list_entry(cl->in_process_list.list.next,
-				struct ishtp_cl_rb, list);
-		list_del(&rb->list);
+	list_for_each_entry_del(rb, &cl->in_process_list.list, list) {
 		kfree(rb->buffer.data);
 		kfree(rb);
 	}
@@ -134,10 +128,7 @@ void ishtp_cl_free_tx_ring(struct ishtp_cl *cl)
 
 	spin_lock_irqsave(&cl->tx_free_list_spinlock, flags);
 	/* release allocated memory - pass over tx_free_list */
-	while (!list_empty(&cl->tx_free_list.list)) {
-		tx_buf = list_entry(cl->tx_free_list.list.next,
-				    struct ishtp_cl_tx_ring, list);
-		list_del(&tx_buf->list);
+	list_for_each_entry_del(tx_buf, &cl->tx_free_list.list, list) {
 		--cl->tx_ring_free_size;
 		kfree(tx_buf->send_buf.data);
 		kfree(tx_buf);
@@ -146,10 +137,7 @@ void ishtp_cl_free_tx_ring(struct ishtp_cl *cl)
 
 	spin_lock_irqsave(&cl->tx_list_spinlock, flags);
 	/* release allocated memory - pass over tx_list */
-	while (!list_empty(&cl->tx_list.list)) {
-		tx_buf = list_entry(cl->tx_list.list.next,
-				    struct ishtp_cl_tx_ring, list);
-		list_del(&tx_buf->list);
+	list_for_each_entry_del(tx_buf, &cl->tx_list.list, list) {
 		kfree(tx_buf->send_buf.data);
 		kfree(tx_buf);
 	}
diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 87283e4a4607..be9a41375bae 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -2427,12 +2427,8 @@ void i3c_generic_ibi_free_pool(struct i3c_generic_ibi_pool *pool)
 	struct i3c_generic_ibi_slot *slot;
 	unsigned int nslots = 0;
 
-	while (!list_empty(&pool->free_slots)) {
-		slot = list_first_entry(&pool->free_slots,
-					struct i3c_generic_ibi_slot, node);
-		list_del(&slot->node);
+	list_for_each_entry_del(slot, &pool->free_slots, node)
 		nslots++;
-	}
 
 	/*
 	 * If the number of freed slots is not equal to the number of allocated
diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 1e2cd7c8716e..b8d3f165da07 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -1914,13 +1914,10 @@ static void _cma_cancel_listens(struct rdma_id_private *id_priv)
 	 */
 	list_del_init(&id_priv->listen_any_item);
 
-	while (!list_empty(&id_priv->listen_list)) {
-		dev_id_priv =
-			list_first_entry(&id_priv->listen_list,
-					 struct rdma_id_private, listen_item);
+	list_for_each_entry_del_init(dev_id_priv, &id_priv->listen_list,
+				     listen_item) {
 		/* sync with device removal to avoid duplicate destruction */
 		list_del_init(&dev_id_priv->device_item);
-		list_del_init(&dev_id_priv->listen_item);
 		mutex_unlock(&lock);
 
 		rdma_destroy_id(&dev_id_priv->id);
@@ -2018,12 +2015,8 @@ static void cma_leave_mc_groups(struct rdma_id_private *id_priv)
 {
 	struct cma_multicast *mc;
 
-	while (!list_empty(&id_priv->mc_list)) {
-		mc = list_first_entry(&id_priv->mc_list, struct cma_multicast,
-				      list);
-		list_del(&mc->list);
+	list_for_each_entry_del(mc, &id_priv->mc_list, list)
 		destroy_mc(id_priv, mc);
-	}
 }
 
 static void _destroy_id(struct rdma_id_private *id_priv,
diff --git a/drivers/infiniband/core/mad.c b/drivers/infiniband/core/mad.c
index 674344eb8e2f..44c6b3cf003a 100644
--- a/drivers/infiniband/core/mad.c
+++ b/drivers/infiniband/core/mad.c
@@ -2508,11 +2508,8 @@ static void local_completions(struct work_struct *work)
 			       mad_agent_priv->qp_info->port_priv->port_num);
 
 	spin_lock_irqsave(&mad_agent_priv->lock, flags);
-	while (!list_empty(&mad_agent_priv->local_list)) {
-		local = list_entry(mad_agent_priv->local_list.next,
-				   struct ib_mad_local_private,
-				   completion_list);
-		list_del(&local->completion_list);
+	list_for_each_entry_del(local, &mad_agent_priv->local_list,
+				completion_list) {
 		spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
 		free_mad = 0;
 		if (local->mad_priv) {
diff --git a/drivers/infiniband/core/mr_pool.c b/drivers/infiniband/core/mr_pool.c
index c0e2df128b34..7dcec19032df 100644
--- a/drivers/infiniband/core/mr_pool.c
+++ b/drivers/infiniband/core/mr_pool.c
@@ -69,10 +69,7 @@ void ib_mr_pool_destroy(struct ib_qp *qp, struct list_head *list)
 	unsigned long flags;
 
 	spin_lock_irqsave(&qp->mr_lock, flags);
-	while (!list_empty(list)) {
-		mr = list_first_entry(list, struct ib_mr, qp_entry);
-		list_del(&mr->qp_entry);
-
+	list_for_each_entry_del(mr, list, qp_entry) {
 		spin_unlock_irqrestore(&qp->mr_lock, flags);
 		ib_dereg_mr(mr);
 		spin_lock_irqsave(&qp->mr_lock, flags);
diff --git a/drivers/infiniband/core/multicast.c b/drivers/infiniband/core/multicast.c
index a236532a9026..971793f1ec1f 100644
--- a/drivers/infiniband/core/multicast.c
+++ b/drivers/infiniband/core/multicast.c
@@ -398,11 +398,8 @@ static void process_group_error(struct mcast_group *group)
 	    group->pkey_index == pkey_index)
 		goto out;
 
-	while (!list_empty(&group->active_list)) {
-		member = list_entry(group->active_list.next,
-				    struct mcast_member, list);
+	list_for_each_entry_del_init(member, &group->active_list, list) {
 		refcount_inc(&member->refcount);
-		list_del_init(&member->list);
 		adjust_membership(group, member->multicast.rec.join_state, -1);
 		member->state = MCAST_ERROR;
 		spin_unlock_irq(&group->lock);
diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
index 495d5a5d0373..4ac1987d951c 100644
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -1191,10 +1191,8 @@ static void ib_uverbs_free_hw_resources(struct ib_uverbs_device *uverbs_dev,
 	uverbs_disassociate_api_pre(uverbs_dev);
 
 	mutex_lock(&uverbs_dev->lists_mutex);
-	while (!list_empty(&uverbs_dev->uverbs_file_list)) {
-		file = list_first_entry(&uverbs_dev->uverbs_file_list,
-					struct ib_uverbs_file, list);
-		list_del_init(&file->list);
+	list_for_each_entry_del_init(file, &uverbs_dev->uverbs_file_list,
+				     list) {
 		kref_get(&file->ref);
 
 		/* We must release the mutex before going ahead and calling
diff --git a/drivers/infiniband/hw/hfi1/mmu_rb.c b/drivers/infiniband/hw/hfi1/mmu_rb.c
index 7a51f7d73b61..3f7af80cf49e 100644
--- a/drivers/infiniband/hw/hfi1/mmu_rb.c
+++ b/drivers/infiniband/hw/hfi1/mmu_rb.c
@@ -105,11 +105,8 @@ void hfi1_mmu_rb_unregister(struct mmu_rb_handler *handler)
 	}
 	spin_unlock_irqrestore(&handler->lock, flags);
 
-	while (!list_empty(&del_list)) {
-		rbnode = list_first_entry(&del_list, struct mmu_rb_node, list);
-		list_del(&rbnode->list);
+	list_for_each_entry_del(rbnode, &del_list, list)
 		kref_put(&rbnode->refcount, release_immediate);
-	}
 
 	/* Now the mm may be freed. */
 	mmdrop(handler->mn.mm);
@@ -303,9 +300,7 @@ static void handle_remove(struct work_struct *work)
 	list_replace_init(&handler->del_list, &del_list);
 	spin_unlock_irqrestore(&handler->lock, flags);
 
-	while (!list_empty(&del_list)) {
-		node = list_first_entry(&del_list, struct mmu_rb_node, list);
-		list_del(&node->list);
+	list_for_each_entry_del(node, &del_list, list) {
 		trace_hfi1_mmu_release_node(node);
 		handler->ops->remove(handler->ops_arg, node);
 	}
diff --git a/drivers/infiniband/hw/hfi1/qp.c b/drivers/infiniband/hw/hfi1/qp.c
index 6193d48b2c1f..afde276d2563 100644
--- a/drivers/infiniband/hw/hfi1/qp.c
+++ b/drivers/infiniband/hw/hfi1/qp.c
@@ -106,14 +106,9 @@ const struct rvt_operation_params hfi1_post_parms[RVT_OPERATION_MAX] = {
 
 static void flush_list_head(struct list_head *l)
 {
-	while (!list_empty(l)) {
-		struct sdma_txreq *tx;
-
-		tx = list_first_entry(
-			l,
-			struct sdma_txreq,
-			list);
-		list_del_init(&tx->list);
+	struct sdma_txreq *tx;
+
+	list_for_each_entry_del_init(tx, l, list) {
 		hfi1_put_txreq(
 			container_of(tx, struct verbs_txreq, txreq));
 	}
diff --git a/drivers/infiniband/hw/mlx4/alias_GUID.c b/drivers/infiniband/hw/mlx4/alias_GUID.c
index 111fa88a3be4..ab2e8bc45906 100644
--- a/drivers/infiniband/hw/mlx4/alias_GUID.c
+++ b/drivers/infiniband/hw/mlx4/alias_GUID.c
@@ -806,13 +806,9 @@ void mlx4_ib_destroy_alias_guid_service(struct mlx4_ib_dev *dev)
 		det = &sriov->alias_guid.ports_guid[i];
 		cancel_delayed_work_sync(&det->alias_guid_work);
 		spin_lock_irqsave(&sriov->alias_guid.ag_work_lock, flags);
-		while (!list_empty(&det->cb_list)) {
-			cb_ctx = list_entry(det->cb_list.next,
-					    struct mlx4_alias_guid_work_context,
-					    list);
+		list_for_each_entry_del(cb_ctx, &det->cb_list, list) {
 			sa_query = cb_ctx->sa_query;
 			cb_ctx->sa_query = NULL;
-			list_del(&cb_ctx->list);
 			spin_unlock_irqrestore(&sriov->alias_guid.ag_work_lock, flags);
 			ib_sa_cancel_query(cb_ctx->query_id, sa_query);
 			wait_for_completion(&cb_ctx->done);
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_cm.c b/drivers/infiniband/ulp/ipoib/ipoib_cm.c
index b610d36295bb..5c3106e3febb 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_cm.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_cm.c
@@ -1351,9 +1351,7 @@ static void ipoib_cm_tx_start(struct work_struct *work)
 	netif_tx_lock_bh(dev);
 	spin_lock_irqsave(&priv->lock, flags);
 
-	while (!list_empty(&priv->cm.start_list)) {
-		p = list_entry(priv->cm.start_list.next, typeof(*p), list);
-		list_del_init(&p->list);
+	list_for_each_entry_del_init(p, &priv->cm.start_list, list) {
 		neigh = p->neigh;
 
 		qpn = IPOIB_QPN(neigh->daddr);
@@ -1405,9 +1403,7 @@ static void ipoib_cm_tx_reap(struct work_struct *work)
 	netif_tx_lock_bh(dev);
 	spin_lock_irqsave(&priv->lock, flags);
 
-	while (!list_empty(&priv->cm.reap_list)) {
-		p = list_entry(priv->cm.reap_list.next, typeof(*p), list);
-		list_del_init(&p->list);
+	list_for_each_entry_del_init(p, &priv->cm.reap_list, list) {
 		spin_unlock_irqrestore(&priv->lock, flags);
 		netif_tx_unlock_bh(dev);
 		ipoib_cm_tx_destroy(p);
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 75e56604e462..a780396dc7a9 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -1164,15 +1164,11 @@ static int rtrs_srv_inv_rkey(struct rtrs_srv_con *con,
 
 static void rtrs_rdma_process_wr_wait_list(struct rtrs_srv_con *con)
 {
-	spin_lock(&con->rsp_wr_wait_lock);
-	while (!list_empty(&con->rsp_wr_wait_list)) {
-		struct rtrs_srv_op *id;
-		int ret;
-
-		id = list_entry(con->rsp_wr_wait_list.next,
-				struct rtrs_srv_op, wait_list);
-		list_del(&id->wait_list);
+	struct rtrs_srv_op *id;
+	int ret;
 
+	spin_lock(&con->rsp_wr_wait_lock);
+	list_for_each_entry_del(id, &con->rsp_wr_wait_list, wait_list) {
 		spin_unlock(&con->rsp_wr_wait_lock);
 		ret = rtrs_srv_resp_rdma(id, id->status);
 		spin_lock(&con->rsp_wr_wait_lock);
diff --git a/drivers/macintosh/windfarm_fcu_controls.c b/drivers/macintosh/windfarm_fcu_controls.c
index 603ef6c600ba..7e4f7281e4ad 100644
--- a/drivers/macintosh/windfarm_fcu_controls.c
+++ b/drivers/macintosh/windfarm_fcu_controls.c
@@ -564,11 +564,9 @@ static void wf_fcu_remove(struct i2c_client *client)
 	struct wf_fcu_priv *pv = dev_get_drvdata(&client->dev);
 	struct wf_fcu_fan *fan;
 
-	while (!list_empty(&pv->fan_list)) {
-		fan = list_first_entry(&pv->fan_list, struct wf_fcu_fan, link);
-		list_del(&fan->link);
+	list_for_each_entry_del(fan, &pv->fan_list, link)
 		wf_unregister_control(&fan->ctrl);
-	}
+
 	kref_put(&pv->ref, wf_fcu_release);
 }
 
diff --git a/drivers/macintosh/windfarm_smu_controls.c b/drivers/macintosh/windfarm_smu_controls.c
index bdd92b27da2a..17d7b5e5d616 100644
--- a/drivers/macintosh/windfarm_smu_controls.c
+++ b/drivers/macintosh/windfarm_smu_controls.c
@@ -309,11 +309,8 @@ static void __exit smu_controls_exit(void)
 {
 	struct smu_fan_control *fct;
 
-	while (!list_empty(&smu_fans)) {
-		fct = list_entry(smu_fans.next, struct smu_fan_control, link);
-		list_del(&fct->link);
+	list_for_each_entry_del(fct, &smu_fans, link)
 		wf_unregister_control(&fct->ctrl);
-	}
 }
 
 
diff --git a/drivers/macintosh/windfarm_smu_sat.c b/drivers/macintosh/windfarm_smu_sat.c
index 50baa062c9df..9d878652d241 100644
--- a/drivers/macintosh/windfarm_smu_sat.c
+++ b/drivers/macintosh/windfarm_smu_sat.c
@@ -322,12 +322,8 @@ static void wf_sat_remove(struct i2c_client *client)
 	struct wf_sat_sensor *sens;
 
 	/* release sensors */
-	while(!list_empty(&sat->sensors)) {
-		sens = list_first_entry(&sat->sensors,
-					struct wf_sat_sensor, link);
-		list_del(&sens->link);
+	list_for_each_entry_del(sens, &sat->sensors, link)
 		wf_unregister_sensor(&sens->sens);
-	}
 	sat->i2c = NULL;
 	kref_put(&sat->ref, wf_sat_release);
 }
diff --git a/drivers/macintosh/windfarm_smu_sensors.c b/drivers/macintosh/windfarm_smu_sensors.c
index 2bdb73b34d29..a76b30dae984 100644
--- a/drivers/macintosh/windfarm_smu_sensors.c
+++ b/drivers/macintosh/windfarm_smu_sensors.c
@@ -463,11 +463,8 @@ static void __exit smu_sensors_exit(void)
 		wf_unregister_sensor(&smu_cpu_power->sens);
 
 	/* dispose of basic sensors */
-	while (!list_empty(&smu_ads)) {
-		ads = list_entry(smu_ads.next, struct smu_ad_sensor, link);
-		list_del(&ads->link);
+	list_for_each_entry_del(ads, &smu_ads, link)
 		wf_unregister_sensor(&ads->sens);
-	}
 }
 
 
diff --git a/drivers/md/bcache/alloc.c b/drivers/md/bcache/alloc.c
index ce13c272c387..5219629ad67d 100644
--- a/drivers/md/bcache/alloc.c
+++ b/drivers/md/bcache/alloc.c
@@ -698,12 +698,8 @@ void bch_open_buckets_free(struct cache_set *c)
 {
 	struct open_bucket *b;
 
-	while (!list_empty(&c->data_buckets)) {
-		b = list_first_entry(&c->data_buckets,
-				     struct open_bucket, list);
-		list_del(&b->list);
+	list_for_each_entry_del(b, &c->data_buckets, list)
 		kfree(b);
-	}
 }
 
 int bch_open_buckets_alloc(struct cache_set *c)
diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
index fd121a61f17c..65e19322ca3f 100644
--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -782,10 +782,7 @@ void bch_btree_cache_free(struct cache_set *c)
 		mca_data_free(b);
 	}
 
-	while (!list_empty(&c->btree_cache_freed)) {
-		b = list_first_entry(&c->btree_cache_freed,
-				     struct btree, list);
-		list_del(&b->list);
+	list_for_each_entry_del(b, &c->btree_cache_freed, list) {
 		cancel_delayed_work_sync(&b->work);
 		kfree(b);
 	}
diff --git a/drivers/md/bcache/journal.c b/drivers/md/bcache/journal.c
index c182c21de2e8..a1682eb2cdf4 100644
--- a/drivers/md/bcache/journal.c
+++ b/drivers/md/bcache/journal.c
@@ -397,11 +397,8 @@ int bch_journal_replay(struct cache_set *s, struct list_head *list)
 	pr_info("journal replay done, %i keys in %i entries, seq %llu\n",
 		keys, entries, end);
 err:
-	while (!list_empty(list)) {
-		i = list_first_entry(list, struct journal_replay, list);
-		list_del(&i->list);
+	list_for_each_entry_del(i, list, list)
 		kfree(i);
-	}
 
 	return ret;
 }
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 0ae2b3676293..abd7a07e2527 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -2128,11 +2128,8 @@ static int run_cache_set(struct cache_set *c)
 	set_bit(CACHE_SET_RUNNING, &c->flags);
 	return 0;
 err:
-	while (!list_empty(&journal)) {
-		l = list_first_entry(&journal, struct journal_replay, list);
-		list_del(&l->list);
+	list_for_each_entry_del(l, &journal, list)
 		kfree(l);
-	}
 
 	closure_sync(&cl);
 
diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
index bc309e41d074..55ce606dc720 100644
--- a/drivers/md/dm-bufio.c
+++ b/drivers/md/dm-bufio.c
@@ -1427,13 +1427,11 @@ static void __write_dirty_buffer(struct dm_buffer *b,
 
 static void __flush_write_list(struct list_head *write_list)
 {
+	struct dm_buffer *b;
 	struct blk_plug plug;
 
 	blk_start_plug(&plug);
-	while (!list_empty(write_list)) {
-		struct dm_buffer *b =
-			list_entry(write_list->next, struct dm_buffer, write_list);
-		list_del(&b->write_list);
+	list_for_each_entry_del(b, write_list, write_list) {
 		submit_io(b, REQ_OP_WRITE, write_endio);
 		cond_resched();
 	}
diff --git a/drivers/md/dm-stats.c b/drivers/md/dm-stats.c
index db2d997a6c18..b380b37936a9 100644
--- a/drivers/md/dm-stats.c
+++ b/drivers/md/dm-stats.c
@@ -215,9 +215,7 @@ void dm_stats_cleanup(struct dm_stats *stats)
 	struct dm_stat *s;
 	struct dm_stat_shared *shared;
 
-	while (!list_empty(&stats->list)) {
-		s = container_of(stats->list.next, struct dm_stat, list_entry);
-		list_del(&s->list_entry);
+	list_for_each_entry_del(s, &stats->list, list_entry) {
 		for (ni = 0; ni < s->n_entries; ni++) {
 			shared = &s->stat_shared[ni];
 			if (WARN_ON(dm_stat_in_flight(shared))) {
diff --git a/drivers/md/dm-zoned-metadata.c b/drivers/md/dm-zoned-metadata.c
index 9d3cca8e3dc9..f972e69ea134 100644
--- a/drivers/md/dm-zoned-metadata.c
+++ b/drivers/md/dm-zoned-metadata.c
@@ -944,10 +944,7 @@ int dmz_flush_metadata(struct dmz_metadata *zmd)
 	if (ret)
 		goto err;
 
-	while (!list_empty(&write_list)) {
-		mblk = list_first_entry(&write_list, struct dmz_mblock, link);
-		list_del_init(&mblk->link);
-
+	list_for_each_entry_del_init(mblk, &write_list, link) {
 		spin_lock(&zmd->mblk_lock);
 		clear_bit(DMZ_META_DIRTY, &mblk->state);
 		if (mblk->ref == 0)
@@ -2808,10 +2805,7 @@ static void dmz_cleanup_metadata(struct dmz_metadata *zmd)
 		dmz_free_mblock(zmd, mblk);
 	}
 
-	while (!list_empty(&zmd->mblk_lru_list)) {
-		mblk = list_first_entry(&zmd->mblk_lru_list,
-					struct dmz_mblock, link);
-		list_del_init(&mblk->link);
+	list_for_each_entry_del_init(mblk, &zmd->mblk_lru_list, link) {
 		rb_erase(&mblk->node, &zmd->mblk_rbtree);
 		dmz_free_mblock(zmd, mblk);
 	}
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 2aabac773fe7..bc39e0e617b4 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -2567,10 +2567,7 @@ static void raid1d(struct md_thread *thread)
 		if (!test_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags))
 			list_splice_init(&conf->bio_end_io_list, &tmp);
 		spin_unlock_irqrestore(&conf->device_lock, flags);
-		while (!list_empty(&tmp)) {
-			r1_bio = list_first_entry(&tmp, struct r1bio,
-						  retry_list);
-			list_del(&r1_bio->retry_list);
+		list_for_each_entry_del(r1_bio, &tmp, retry_list) {
 			idx = sector_to_idx(r1_bio->sector);
 			atomic_dec(&conf->nr_queued[idx]);
 			if (mddev->degraded)
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 023413120851..305ce283c381 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -3122,10 +3122,7 @@ static void raid10d(struct md_thread *thread)
 			}
 		}
 		spin_unlock_irqrestore(&conf->device_lock, flags);
-		while (!list_empty(&tmp)) {
-			r10_bio = list_first_entry(&tmp, struct r10bio,
-						   retry_list);
-			list_del(&r10_bio->retry_list);
+		list_for_each_entry_del(r10_bio, &tmp, retry_list) {
 			if (mddev->degraded)
 				set_bit(R10BIO_Degraded, &r10_bio->state);
 
diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
index 518b7cfa78b9..91943de6e64e 100644
--- a/drivers/md/raid5-cache.c
+++ b/drivers/md/raid5-cache.c
@@ -1133,10 +1133,7 @@ static void r5l_run_no_space_stripes(struct r5l_log *log)
 	struct stripe_head *sh;
 
 	spin_lock(&log->no_space_stripes_lock);
-	while (!list_empty(&log->no_space_stripes)) {
-		sh = list_first_entry(&log->no_space_stripes,
-				      struct stripe_head, log_list);
-		list_del_init(&sh->log_list);
+	list_for_each_entry_del_init(sh, &log->no_space_stripes, log_list) {
 		set_bit(STRIPE_HANDLE, &sh->state);
 		raid5_release_stripe(sh);
 	}
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 284cd71bcc68..8ea33f1e328a 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -2583,11 +2583,9 @@ static int resize_stripes(struct r5conf *conf, int newsize)
 	}
 	if (i) {
 		/* didn't get enough, give up */
-		while (!list_empty(&newstripes)) {
-			nsh = list_entry(newstripes.next, struct stripe_head, lru);
-			list_del(&nsh->lru);
+		list_for_each_entry_del(nsh, &newstripes, lru)
 			free_stripe(sc, nsh);
-		}
+
 		kmem_cache_destroy(sc);
 		mutex_unlock(&conf->cache_size_mutex);
 		return -ENOMEM;
@@ -2661,10 +2659,7 @@ static int resize_stripes(struct r5conf *conf, int newsize)
 	conf->active_name = 1-conf->active_name;
 
 	/* Step 4, return new stripes to service */
-	while(!list_empty(&newstripes)) {
-		nsh = list_entry(newstripes.next, struct stripe_head, lru);
-		list_del_init(&nsh->lru);
-
+	list_for_each_entry_del_init(nsh, &newstripes, lru) {
 #if PAGE_SIZE != DEFAULT_STRIPE_SIZE
 		for (i = 0; i < nsh->nr_pages; i++) {
 			if (nsh->pages[i])
@@ -5724,9 +5719,7 @@ static void raid5_unplug(struct blk_plug_cb *blk_cb, bool from_schedule)
 
 	if (cb->list.next && !list_empty(&cb->list)) {
 		spin_lock_irq(&conf->device_lock);
-		while (!list_empty(&cb->list)) {
-			sh = list_first_entry(&cb->list, struct stripe_head, lru);
-			list_del_init(&sh->lru);
+		list_for_each_entry_del_init(sh, &cb->list, lru) {
 			/*
 			 * avoid race release_stripe_plug() sees
 			 * STRIPE_ON_UNPLUG_LIST clear but the stripe
@@ -6481,11 +6474,9 @@ static sector_t reshape_request(struct mddev *mddev, sector_t sector_nr, int *sk
 	/* Now that the sources are clearly marked, we can release
 	 * the destination stripes
 	 */
-	while (!list_empty(&stripes)) {
-		sh = list_entry(stripes.next, struct stripe_head, lru);
-		list_del_init(&sh->lru);
+	list_for_each_entry_del_init(sh, &stripes, lru)
 		raid5_release_stripe(sh);
-	}
+
 	/* If this takes us to the resync_max point where we have to pause,
 	 * then we need to write out the superblock.
 	 */
diff --git a/drivers/media/cec/core/cec-api.c b/drivers/media/cec/core/cec-api.c
index 67dc79ef1705..c970370241c2 100644
--- a/drivers/media/cec/core/cec-api.c
+++ b/drivers/media/cec/core/cec-api.c
@@ -627,6 +627,7 @@ static int cec_open(struct inode *inode, struct file *filp)
 /* Override for the release function */
 static int cec_release(struct inode *inode, struct file *filp)
 {
+	struct cec_msg_entry *entry;
 	struct cec_devnode *devnode = cec_devnode_data(filp);
 	struct cec_adapter *adap = to_cec_adapter(devnode);
 	struct cec_fh *fh = filp->private_data;
@@ -664,22 +665,14 @@ static int cec_release(struct inode *inode, struct file *filp)
 		list_del_init(&data->xfer_list);
 	}
 	mutex_unlock(&adap->lock);
-	while (!list_empty(&fh->msgs)) {
-		struct cec_msg_entry *entry =
-			list_first_entry(&fh->msgs, struct cec_msg_entry, list);
-
-		list_del(&entry->list);
+	list_for_each_entry_del(entry, &fh->msgs, list)
 		kfree(entry);
-	}
+
 	for (i = CEC_NUM_CORE_EVENTS; i < CEC_NUM_EVENTS; i++) {
-		while (!list_empty(&fh->events[i])) {
-			struct cec_event_entry *entry =
-				list_first_entry(&fh->events[i],
-						 struct cec_event_entry, list);
+		struct cec_event_entry *entry;
 
-			list_del(&entry->list);
+		list_for_each_entry_del(entry, &fh->events[i], list)
 			kfree(entry);
-		}
 	}
 	kfree(fh);
 
diff --git a/drivers/media/common/saa7146/saa7146_vbi.c b/drivers/media/common/saa7146/saa7146_vbi.c
index bb7d81f7eba6..a35e2c5d8079 100644
--- a/drivers/media/common/saa7146/saa7146_vbi.c
+++ b/drivers/media/common/saa7146/saa7146_vbi.c
@@ -298,11 +298,8 @@ static void return_buffers(struct vb2_queue *q, int state)
 		dq->curr = NULL;
 		vb2_buffer_done(&buf->vb.vb2_buf, state);
 	}
-	while (!list_empty(&dq->queue)) {
-		buf = list_entry(dq->queue.next, struct saa7146_buf, list);
-		list_del(&buf->list);
+	list_for_each_entry_del(buf, &dq->queue, list)
 		vb2_buffer_done(&buf->vb.vb2_buf, state);
-	}
 }
 
 static void vbi_stop(struct saa7146_dev *dev)
diff --git a/drivers/media/common/saa7146/saa7146_video.c b/drivers/media/common/saa7146/saa7146_video.c
index 040489e15ea0..88648b9c6e77 100644
--- a/drivers/media/common/saa7146/saa7146_video.c
+++ b/drivers/media/common/saa7146/saa7146_video.c
@@ -643,11 +643,8 @@ static void return_buffers(struct vb2_queue *q, int state)
 		dq->curr = NULL;
 		vb2_buffer_done(&buf->vb.vb2_buf, state);
 	}
-	while (!list_empty(&dq->queue)) {
-		buf = list_entry(dq->queue.next, struct saa7146_buf, list);
-		list_del(&buf->list);
+	list_for_each_entry_del(buf, &dq->queue, list)
 		vb2_buffer_done(&buf->vb.vb2_buf, state);
-	}
 }
 
 static int start_streaming(struct vb2_queue *q, unsigned int count)
diff --git a/drivers/media/dvb-frontends/rtl2832_sdr.c b/drivers/media/dvb-frontends/rtl2832_sdr.c
index 02c619e51641..bc6a22ce4fcf 100644
--- a/drivers/media/dvb-frontends/rtl2832_sdr.c
+++ b/drivers/media/dvb-frontends/rtl2832_sdr.c
@@ -401,20 +401,15 @@ static int rtl2832_sdr_alloc_urbs(struct rtl2832_sdr_dev *dev)
 /* Must be called with vb_queue_lock hold */
 static void rtl2832_sdr_cleanup_queued_bufs(struct rtl2832_sdr_dev *dev)
 {
+	struct rtl2832_sdr_frame_buf *buf;
 	struct platform_device *pdev = dev->pdev;
 	unsigned long flags;
 
 	dev_dbg(&pdev->dev, "\n");
 
 	spin_lock_irqsave(&dev->queued_bufs_lock, flags);
-	while (!list_empty(&dev->queued_bufs)) {
-		struct rtl2832_sdr_frame_buf *buf;
-
-		buf = list_entry(dev->queued_bufs.next,
-				struct rtl2832_sdr_frame_buf, list);
-		list_del(&buf->list);
+	list_for_each_entry_del(buf, &dev->queued_bufs, list)
 		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);
-	}
 	spin_unlock_irqrestore(&dev->queued_bufs_lock, flags);
 }
 
diff --git a/drivers/media/mc/mc-entity.c b/drivers/media/mc/mc-entity.c
index 83468d4a440b..c77f7cba59e2 100644
--- a/drivers/media/mc/mc-entity.c
+++ b/drivers/media/mc/mc-entity.c
@@ -651,13 +651,10 @@ static int media_pipeline_explore_next_link(struct media_pipeline *pipe,
 
 static void media_pipeline_cleanup(struct media_pipeline *pipe)
 {
-	while (!list_empty(&pipe->pads)) {
-		struct media_pipeline_pad *ppad;
+	struct media_pipeline_pad *ppad;
 
-		ppad = list_first_entry(&pipe->pads, typeof(*ppad), list);
-		list_del(&ppad->list);
+	list_for_each_entry_del(ppad, &pipe->pads, list)
 		kfree(ppad);
-	}
 }
 
 static int media_pipeline_populate(struct media_pipeline *pipe,
diff --git a/drivers/media/pci/bt8xx/bttv-driver.c b/drivers/media/pci/bt8xx/bttv-driver.c
index aa708a0e5eac..976d9c596046 100644
--- a/drivers/media/pci/bt8xx/bttv-driver.c
+++ b/drivers/media/pci/bt8xx/bttv-driver.c
@@ -1545,10 +1545,7 @@ static int start_streaming(struct vb2_queue *q, unsigned int count)
 	if (ret == 0) {
 		if (btv->field_count)
 			seqnr++;
-		while (!list_empty(&btv->capture)) {
-			buf = list_entry(btv->capture.next,
-					 struct bttv_buffer, list);
-			list_del(&buf->list);
+		list_for_each_entry_del(buf, &btv->capture, list) {
 			buf->vbuf.sequence = (btv->field_count >> 1) + seqnr++;
 			vb2_buffer_done(&buf->vbuf.vb2_buf,
 					VB2_BUF_STATE_QUEUED);
@@ -2816,16 +2813,12 @@ static void bttv_irq_timeout(struct timer_list *t)
 	/* cancel all outstanding capture / vbi requests */
 	if (btv->field_count)
 		seqnr++;
-	while (!list_empty(&btv->capture)) {
-		item = list_entry(btv->capture.next, struct bttv_buffer, list);
-		list_del(&item->list);
+	list_for_each_entry_del(item, &btv->capture, list) {
 		item->vbuf.vb2_buf.timestamp = ktime_get_ns();
 		item->vbuf.sequence = (btv->field_count >> 1) + seqnr++;
 		vb2_buffer_done(&item->vbuf.vb2_buf, VB2_BUF_STATE_ERROR);
 	}
-	while (!list_empty(&btv->vcapture)) {
-		item = list_entry(btv->vcapture.next, struct bttv_buffer, list);
-		list_del(&item->list);
+	list_for_each_entry_del(item, &btv->vcapture, list) {
 		item->vbuf.vb2_buf.timestamp = ktime_get_ns();
 		item->vbuf.sequence = (btv->field_count >> 1) + seqnr++;
 		vb2_buffer_done(&item->vbuf.vb2_buf, VB2_BUF_STATE_ERROR);
diff --git a/drivers/media/pci/bt8xx/bttv-vbi.c b/drivers/media/pci/bt8xx/bttv-vbi.c
index ab213e51ec95..fee09c46fa31 100644
--- a/drivers/media/pci/bt8xx/bttv-vbi.c
+++ b/drivers/media/pci/bt8xx/bttv-vbi.c
@@ -133,10 +133,7 @@ static int start_streaming_vbi(struct vb2_queue *q, unsigned int count)
 	if (ret == 0) {
 		if (btv->field_count)
 			seqnr++;
-		while (!list_empty(&btv->vcapture)) {
-			buf = list_entry(btv->vcapture.next,
-					 struct bttv_buffer, list);
-			list_del(&buf->list);
+		list_for_each_entry_del(buf, &btv->vcapture, list) {
 			buf->vbuf.sequence = (btv->field_count >> 1) + seqnr++;
 			vb2_buffer_done(&buf->vbuf.vb2_buf,
 					VB2_BUF_STATE_QUEUED);
diff --git a/drivers/media/pci/cx18/cx18-queue.c b/drivers/media/pci/cx18/cx18-queue.c
index 013694bfcb1c..c054a24eb38d 100644
--- a/drivers/media/pci/cx18/cx18-queue.c
+++ b/drivers/media/pci/cx18/cx18-queue.c
@@ -416,10 +416,7 @@ void cx18_stream_free(struct cx18_stream *s)
 		kfree(mdl);
 
 	/* empty buf_pool */
-	while (!list_empty(&s->buf_pool)) {
-		buf = list_first_entry(&s->buf_pool, struct cx18_buffer, list);
-		list_del_init(&buf->list);
-
+	list_for_each_entry_del_init(buf, &s->buf_pool, list) {
 		dma_unmap_single(&s->cx->pci_dev->dev, buf->dma_handle,
 				 s->buf_size, s->dma);
 		kfree(buf->buf);
diff --git a/drivers/media/pci/cx18/cx18-streams.c b/drivers/media/pci/cx18/cx18-streams.c
index 597472754c4c..77cad68a624f 100644
--- a/drivers/media/pci/cx18/cx18-streams.c
+++ b/drivers/media/pci/cx18/cx18-streams.c
@@ -173,14 +173,10 @@ static int cx18_buf_prepare(struct vb2_buffer *vb)
 
 void cx18_clear_queue(struct cx18_stream *s, enum vb2_buffer_state state)
 {
-	while (!list_empty(&s->vb_capture)) {
-		struct cx18_vb2_buffer *buf;
+	struct cx18_vb2_buffer *buf;
 
-		buf = list_first_entry(&s->vb_capture,
-				       struct cx18_vb2_buffer, list);
-		list_del(&buf->list);
+	list_for_each_entry_del(buf, &s->vb_capture, list)
 		vb2_buffer_done(&buf->vb.vb2_buf, state);
-	}
 }
 
 static int cx18_start_streaming(struct vb2_queue *vq, unsigned int count)
diff --git a/drivers/media/pci/cx23885/cx23885-417.c b/drivers/media/pci/cx23885/cx23885-417.c
index 434677bd4ad1..ba81f615a567 100644
--- a/drivers/media/pci/cx23885/cx23885-417.c
+++ b/drivers/media/pci/cx23885/cx23885-417.c
@@ -1166,6 +1166,7 @@ static void buffer_queue(struct vb2_buffer *vb)
 
 static int cx23885_start_streaming(struct vb2_queue *q, unsigned int count)
 {
+	struct cx23885_buffer *buf;
 	struct cx23885_dev *dev = q->drv_priv;
 	struct cx23885_dmaqueue *dmaq = &dev->ts1.mpegq;
 	unsigned long flags;
@@ -1180,13 +1181,8 @@ static int cx23885_start_streaming(struct vb2_queue *q, unsigned int count)
 		return 0;
 	}
 	spin_lock_irqsave(&dev->slock, flags);
-	while (!list_empty(&dmaq->active)) {
-		struct cx23885_buffer *buf = list_entry(dmaq->active.next,
-			struct cx23885_buffer, queue);
-
-		list_del(&buf->queue);
+	list_for_each_entry_del(buf, &dmaq->active, queue)
 		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_QUEUED);
-	}
 	spin_unlock_irqrestore(&dev->slock, flags);
 	return ret;
 }
diff --git a/drivers/media/pci/cx23885/cx23885-core.c b/drivers/media/pci/cx23885/cx23885-core.c
index c8705d786cdd..3522310d4b16 100644
--- a/drivers/media/pci/cx23885/cx23885-core.c
+++ b/drivers/media/pci/cx23885/cx23885-core.c
@@ -1651,10 +1651,7 @@ static void do_cancel_buffers(struct cx23885_tsport *port, char *reason)
 	unsigned long flags;
 
 	spin_lock_irqsave(&port->slock, flags);
-	while (!list_empty(&q->active)) {
-		buf = list_entry(q->active.next, struct cx23885_buffer,
-				 queue);
-		list_del(&buf->queue);
+	list_for_each_entry_del(buf, &q->active, queue) {
 		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);
 		dprintk(1, "[%p/%d] %s - dma=0x%08lx\n",
 			buf, buf->vb.vb2_buf.index, reason,
diff --git a/drivers/media/pci/cx23885/cx23885-vbi.c b/drivers/media/pci/cx23885/cx23885-vbi.c
index 4bdd2bea3713..6d33b7faac2f 100644
--- a/drivers/media/pci/cx23885/cx23885-vbi.c
+++ b/drivers/media/pci/cx23885/cx23885-vbi.c
@@ -227,19 +227,15 @@ static int cx23885_start_streaming(struct vb2_queue *q, unsigned int count)
 
 static void cx23885_stop_streaming(struct vb2_queue *q)
 {
+	struct cx23885_buffer *buf;
 	struct cx23885_dev *dev = q->drv_priv;
 	struct cx23885_dmaqueue *dmaq = &dev->vbiq;
 	unsigned long flags;
 
 	cx_clear(VID_A_DMA_CTL, 0x22); /* FIFO and RISC enable */
 	spin_lock_irqsave(&dev->slock, flags);
-	while (!list_empty(&dmaq->active)) {
-		struct cx23885_buffer *buf = list_entry(dmaq->active.next,
-			struct cx23885_buffer, queue);
-
-		list_del(&buf->queue);
+	list_for_each_entry_del(buf, &dmaq->active, queue)
 		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);
-	}
 	spin_unlock_irqrestore(&dev->slock, flags);
 }
 
diff --git a/drivers/media/pci/cx23885/cx23885-video.c b/drivers/media/pci/cx23885/cx23885-video.c
index 9af2c5596121..8c904ba4b6c1 100644
--- a/drivers/media/pci/cx23885/cx23885-video.c
+++ b/drivers/media/pci/cx23885/cx23885-video.c
@@ -498,19 +498,15 @@ static int cx23885_start_streaming(struct vb2_queue *q, unsigned int count)
 
 static void cx23885_stop_streaming(struct vb2_queue *q)
 {
+	struct cx23885_buffer *buf;
 	struct cx23885_dev *dev = q->drv_priv;
 	struct cx23885_dmaqueue *dmaq = &dev->vidq;
 	unsigned long flags;
 
 	cx_clear(VID_A_DMA_CTL, 0x11);
 	spin_lock_irqsave(&dev->slock, flags);
-	while (!list_empty(&dmaq->active)) {
-		struct cx23885_buffer *buf = list_entry(dmaq->active.next,
-			struct cx23885_buffer, queue);
-
-		list_del(&buf->queue);
+	list_for_each_entry_del(buf, &dmaq->active, queue)
 		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);
-	}
 	spin_unlock_irqrestore(&dev->slock, flags);
 }
 
diff --git a/drivers/media/pci/cx25821/cx25821-video.c b/drivers/media/pci/cx25821/cx25821-video.c
index 1b80c990cb94..0a153b2187f5 100644
--- a/drivers/media/pci/cx25821/cx25821-video.c
+++ b/drivers/media/pci/cx25821/cx25821-video.c
@@ -273,6 +273,7 @@ static int cx25821_start_streaming(struct vb2_queue *q, unsigned int count)
 
 static void cx25821_stop_streaming(struct vb2_queue *q)
 {
+	struct cx25821_buffer *buf;
 	struct cx25821_channel *chan = q->drv_priv;
 	struct cx25821_dev *dev = chan->dev;
 	struct cx25821_dmaqueue *dmaq = &dev->channels[chan->id].dma_vidq;
@@ -280,13 +281,8 @@ static void cx25821_stop_streaming(struct vb2_queue *q)
 
 	cx_write(chan->sram_channels->dma_ctl, 0); /* FIFO and RISC disable */
 	spin_lock_irqsave(&dev->slock, flags);
-	while (!list_empty(&dmaq->active)) {
-		struct cx25821_buffer *buf = list_entry(dmaq->active.next,
-			struct cx25821_buffer, queue);
-
-		list_del(&buf->queue);
+	list_for_each_entry_del(buf, &dmaq->active, queue)
 		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);
-	}
 	spin_unlock_irqrestore(&dev->slock, flags);
 }
 
diff --git a/drivers/media/pci/cx88/cx88-blackbird.c b/drivers/media/pci/cx88/cx88-blackbird.c
index c1b41a9283c1..12005100b909 100644
--- a/drivers/media/pci/cx88/cx88-blackbird.c
+++ b/drivers/media/pci/cx88/cx88-blackbird.c
@@ -738,19 +738,15 @@ static int start_streaming(struct vb2_queue *q, unsigned int count)
 
 fail:
 	spin_lock_irqsave(&dev->slock, flags);
-	while (!list_empty(&dmaq->active)) {
-		struct cx88_buffer *buf = list_entry(dmaq->active.next,
-			struct cx88_buffer, list);
-
-		list_del(&buf->list);
+	list_for_each_entry_del(buf, &dmaq->active, list)
 		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_QUEUED);
-	}
 	spin_unlock_irqrestore(&dev->slock, flags);
 	return err;
 }
 
 static void stop_streaming(struct vb2_queue *q)
 {
+	struct cx88_buffer *buf;
 	struct cx8802_dev *dev = q->drv_priv;
 	struct cx88_dmaqueue *dmaq = &dev->mpegq;
 	struct cx8802_driver *drv = NULL;
@@ -766,13 +762,8 @@ static void stop_streaming(struct vb2_queue *q)
 		drv->request_release(drv);
 
 	spin_lock_irqsave(&dev->slock, flags);
-	while (!list_empty(&dmaq->active)) {
-		struct cx88_buffer *buf = list_entry(dmaq->active.next,
-			struct cx88_buffer, list);
-
-		list_del(&buf->list);
+	list_for_each_entry_del(buf, &dmaq->active, list)
 		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);
-	}
 	spin_unlock_irqrestore(&dev->slock, flags);
 }
 
diff --git a/drivers/media/pci/cx88/cx88-dvb.c b/drivers/media/pci/cx88/cx88-dvb.c
index 2087f2491c42..ce176173f143 100644
--- a/drivers/media/pci/cx88/cx88-dvb.c
+++ b/drivers/media/pci/cx88/cx88-dvb.c
@@ -130,6 +130,7 @@ static int start_streaming(struct vb2_queue *q, unsigned int count)
 
 static void stop_streaming(struct vb2_queue *q)
 {
+	struct cx88_buffer *buf;
 	struct cx8802_dev *dev = q->drv_priv;
 	struct cx88_dmaqueue *dmaq = &dev->mpegq;
 	unsigned long flags;
@@ -137,13 +138,8 @@ static void stop_streaming(struct vb2_queue *q)
 	cx8802_cancel_buffers(dev);
 
 	spin_lock_irqsave(&dev->slock, flags);
-	while (!list_empty(&dmaq->active)) {
-		struct cx88_buffer *buf = list_entry(dmaq->active.next,
-			struct cx88_buffer, list);
-
-		list_del(&buf->list);
+	list_for_each_entry_del(buf, &dmaq->active, list)
 		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);
-	}
 	spin_unlock_irqrestore(&dev->slock, flags);
 }
 
diff --git a/drivers/media/pci/cx88/cx88-mpeg.c b/drivers/media/pci/cx88/cx88-mpeg.c
index 2c1d5137ac47..6b2c37569505 100644
--- a/drivers/media/pci/cx88/cx88-mpeg.c
+++ b/drivers/media/pci/cx88/cx88-mpeg.c
@@ -276,11 +276,8 @@ static void do_cancel_buffers(struct cx8802_dev *dev)
 	unsigned long flags;
 
 	spin_lock_irqsave(&dev->slock, flags);
-	while (!list_empty(&q->active)) {
-		buf = list_entry(q->active.next, struct cx88_buffer, list);
-		list_del(&buf->list);
+	list_for_each_entry_del(buf, &q->active, list)
 		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);
-	}
 	spin_unlock_irqrestore(&dev->slock, flags);
 }
 
diff --git a/drivers/media/pci/cx88/cx88-vbi.c b/drivers/media/pci/cx88/cx88-vbi.c
index 469aeaa725ad..e3a17e834639 100644
--- a/drivers/media/pci/cx88/cx88-vbi.c
+++ b/drivers/media/pci/cx88/cx88-vbi.c
@@ -204,6 +204,7 @@ static int start_streaming(struct vb2_queue *q, unsigned int count)
 
 static void stop_streaming(struct vb2_queue *q)
 {
+	struct cx88_buffer *buf;
 	struct cx8800_dev *dev = q->drv_priv;
 	struct cx88_core *core = dev->core;
 	struct cx88_dmaqueue *dmaq = &dev->vbiq;
@@ -213,13 +214,8 @@ static void stop_streaming(struct vb2_queue *q)
 	cx_clear(VID_CAPTURE_CONTROL, 0x06);
 	cx8800_stop_vbi_dma(dev);
 	spin_lock_irqsave(&dev->slock, flags);
-	while (!list_empty(&dmaq->active)) {
-		struct cx88_buffer *buf = list_entry(dmaq->active.next,
-			struct cx88_buffer, list);
-
-		list_del(&buf->list);
+	list_for_each_entry_del(buf, &dmaq->active, list)
 		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);
-	}
 	spin_unlock_irqrestore(&dev->slock, flags);
 }
 
diff --git a/drivers/media/pci/cx88/cx88-video.c b/drivers/media/pci/cx88/cx88-video.c
index c0ef03ed74f9..a00d280cbb7e 100644
--- a/drivers/media/pci/cx88/cx88-video.c
+++ b/drivers/media/pci/cx88/cx88-video.c
@@ -539,6 +539,7 @@ static int start_streaming(struct vb2_queue *q, unsigned int count)
 
 static void stop_streaming(struct vb2_queue *q)
 {
+	struct cx88_buffer *buf;
 	struct cx8800_dev *dev = q->drv_priv;
 	struct cx88_core *core = dev->core;
 	struct cx88_dmaqueue *dmaq = &dev->vidq;
@@ -547,13 +548,8 @@ static void stop_streaming(struct vb2_queue *q)
 	cx_clear(MO_VID_DMACNTRL, 0x11);
 	cx_clear(VID_CAPTURE_CONTROL, 0x06);
 	spin_lock_irqsave(&dev->slock, flags);
-	while (!list_empty(&dmaq->active)) {
-		struct cx88_buffer *buf = list_entry(dmaq->active.next,
-			struct cx88_buffer, list);
-
-		list_del(&buf->list);
+	list_for_each_entry_del(buf, &dmaq->active, list)
 		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);
-	}
 	spin_unlock_irqrestore(&dev->slock, flags);
 }
 
diff --git a/drivers/media/pci/dt3155/dt3155.c b/drivers/media/pci/dt3155/dt3155.c
index 548156b199cc..9bc378dd8c1f 100644
--- a/drivers/media/pci/dt3155/dt3155.c
+++ b/drivers/media/pci/dt3155/dt3155.c
@@ -200,11 +200,8 @@ static void dt3155_stop_streaming(struct vb2_queue *q)
 		pd->curr_buf = NULL;
 	}
 
-	while (!list_empty(&pd->dmaq)) {
-		vb = list_first_entry(&pd->dmaq, typeof(*vb), done_entry);
-		list_del(&vb->done_entry);
+	list_for_each_entry_del(vb, &pd->dmaq, done_entry)
 		vb2_buffer_done(vb, VB2_BUF_STATE_ERROR);
-	}
 	spin_unlock_irq(&pd->lock);
 }
 
diff --git a/drivers/media/pci/netup_unidvb/netup_unidvb_core.c b/drivers/media/pci/netup_unidvb/netup_unidvb_core.c
index d85bfbb77a25..409755858232 100644
--- a/drivers/media/pci/netup_unidvb/netup_unidvb_core.c
+++ b/drivers/media/pci/netup_unidvb/netup_unidvb_core.c
@@ -625,12 +625,8 @@ static void netup_unidvb_queue_cleanup(struct netup_dma *dma)
 	unsigned long flags;
 
 	spin_lock_irqsave(&dma->lock, flags);
-	while (!list_empty(&dma->free_buffers)) {
-		buf = list_first_entry(&dma->free_buffers,
-			struct netup_unidvb_buffer, list);
-		list_del(&buf->list);
+	list_for_each_entry_del(buf, &dma->free_buffers, list)
 		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);
-	}
 	spin_unlock_irqrestore(&dma->lock, flags);
 }
 
diff --git a/drivers/media/pci/solo6x10/solo6x10-v4l2-enc.c b/drivers/media/pci/solo6x10/solo6x10-v4l2-enc.c
index 0adf3d80f248..d7b039a20489 100644
--- a/drivers/media/pci/solo6x10/solo6x10-v4l2-enc.c
+++ b/drivers/media/pci/solo6x10/solo6x10-v4l2-enc.c
@@ -714,19 +714,14 @@ static int solo_enc_start_streaming(struct vb2_queue *q, unsigned int count)
 
 static void solo_enc_stop_streaming(struct vb2_queue *q)
 {
+	struct solo_vb2_buf *buf;
 	struct solo_enc_dev *solo_enc = vb2_get_drv_priv(q);
 	unsigned long flags;
 
 	spin_lock_irqsave(&solo_enc->av_lock, flags);
 	solo_enc_off(solo_enc);
-	while (!list_empty(&solo_enc->vidq_active)) {
-		struct solo_vb2_buf *buf = list_entry(
-				solo_enc->vidq_active.next,
-				struct solo_vb2_buf, list);
-
-		list_del(&buf->list);
+	list_for_each_entry_del(buf, &solo_enc->vidq_active, list)
 		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);
-	}
 	spin_unlock_irqrestore(&solo_enc->av_lock, flags);
 }
 
diff --git a/drivers/media/pci/solo6x10/solo6x10-v4l2.c b/drivers/media/pci/solo6x10/solo6x10-v4l2.c
index e18cc41fca83..d6127ed51801 100644
--- a/drivers/media/pci/solo6x10/solo6x10-v4l2.c
+++ b/drivers/media/pci/solo6x10/solo6x10-v4l2.c
@@ -329,19 +329,14 @@ static int solo_start_streaming(struct vb2_queue *q, unsigned int count)
 
 static void solo_stop_streaming(struct vb2_queue *q)
 {
+	struct solo_vb2_buf *buf;
 	struct solo_dev *solo_dev = vb2_get_drv_priv(q);
 
 	solo_stop_thread(solo_dev);
 
 	spin_lock(&solo_dev->slock);
-	while (!list_empty(&solo_dev->vidq_active)) {
-		struct solo_vb2_buf *buf = list_entry(
-				solo_dev->vidq_active.next,
-				struct solo_vb2_buf, list);
-
-		list_del(&buf->list);
+	list_for_each_entry_del(buf, &solo_dev->vidq_active, list)
 		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);
-	}
 	spin_unlock(&solo_dev->slock);
 	INIT_LIST_HEAD(&solo_dev->vidq_active);
 }
diff --git a/drivers/media/pci/tw5864/tw5864-video.c b/drivers/media/pci/tw5864/tw5864-video.c
index 197ed8978102..d94e0580c78a 100644
--- a/drivers/media/pci/tw5864/tw5864-video.c
+++ b/drivers/media/pci/tw5864/tw5864-video.c
@@ -426,6 +426,7 @@ static int tw5864_disable_input(struct tw5864_input *input)
 
 static int tw5864_start_streaming(struct vb2_queue *q, unsigned int count)
 {
+	struct tw5864_buf *buf;
 	struct tw5864_input *input = vb2_get_drv_priv(q);
 	int ret;
 
@@ -433,18 +434,14 @@ static int tw5864_start_streaming(struct vb2_queue *q, unsigned int count)
 	if (!ret)
 		return 0;
 
-	while (!list_empty(&input->active)) {
-		struct tw5864_buf *buf = list_entry(input->active.next,
-						    struct tw5864_buf, list);
-
-		list_del(&buf->list);
+	list_for_each_entry_del(buf, &input->active, list)
 		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_QUEUED);
-	}
 	return ret;
 }
 
 static void tw5864_stop_streaming(struct vb2_queue *q)
 {
+	struct tw5864_buf *buf;
 	unsigned long flags;
 	struct tw5864_input *input = vb2_get_drv_priv(q);
 
@@ -455,13 +452,8 @@ static void tw5864_stop_streaming(struct vb2_queue *q)
 		vb2_buffer_done(&input->vb->vb.vb2_buf, VB2_BUF_STATE_ERROR);
 		input->vb = NULL;
 	}
-	while (!list_empty(&input->active)) {
-		struct tw5864_buf *buf = list_entry(input->active.next,
-						    struct tw5864_buf, list);
-
-		list_del(&buf->list);
+	list_for_each_entry_del(buf, &input->active, list)
 		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);
-	}
 	spin_unlock_irqrestore(&input->slock, flags);
 }
 
diff --git a/drivers/media/pci/tw68/tw68-video.c b/drivers/media/pci/tw68/tw68-video.c
index 773a18702d36..17c7a6aefbc1 100644
--- a/drivers/media/pci/tw68/tw68-video.c
+++ b/drivers/media/pci/tw68/tw68-video.c
@@ -503,17 +503,13 @@ static int tw68_start_streaming(struct vb2_queue *q, unsigned int count)
 
 static void tw68_stop_streaming(struct vb2_queue *q)
 {
+	struct tw68_buf *buf;
 	struct tw68_dev *dev = vb2_get_drv_priv(q);
 
 	/* Stop risc & fifo */
 	tw_clearl(TW68_DMAC, TW68_DMAP_EN | TW68_FIFO_EN);
-	while (!list_empty(&dev->active)) {
-		struct tw68_buf *buf =
-			container_of(dev->active.next, struct tw68_buf, list);
-
-		list_del(&buf->list);
+	list_for_each_entry_del(buf, &dev->active, list)
 		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);
-	}
 }
 
 static const struct vb2_ops tw68_video_qops = {
diff --git a/drivers/media/pci/tw686x/tw686x-video.c b/drivers/media/pci/tw686x/tw686x-video.c
index 3ebf7a2c95f0..d8f62911e243 100644
--- a/drivers/media/pci/tw686x/tw686x-video.c
+++ b/drivers/media/pci/tw686x/tw686x-video.c
@@ -130,12 +130,7 @@ static void tw686x_memcpy_buf_refill(struct tw686x_video_channel *vc,
 {
 	struct tw686x_v4l2_buf *buf;
 
-	while (!list_empty(&vc->vidq_queued)) {
-
-		buf = list_first_entry(&vc->vidq_queued,
-			struct tw686x_v4l2_buf, list);
-		list_del(&buf->list);
-
+	list_for_each_entry_del(buf, &vc->vidq_queued, list) {
 		vc->curr_bufs[pb] = buf;
 		return;
 	}
@@ -227,13 +222,9 @@ static void tw686x_sg_buf_refill(struct tw686x_video_channel *vc,
 	struct tw686x_dev *dev = vc->dev;
 	struct tw686x_v4l2_buf *buf;
 
-	while (!list_empty(&vc->vidq_queued)) {
+	list_for_each_entry_del(buf, &vc->vidq_queued, list) {
 		unsigned int buf_len;
 
-		buf = list_first_entry(&vc->vidq_queued,
-			struct tw686x_v4l2_buf, list);
-		list_del(&buf->list);
-
 		buf_len = (vc->width * vc->height * vc->format->depth) >> 3;
 		if (tw686x_sg_desc_fill(vc->sg_descs[pb], buf, buf_len)) {
 			v4l2_err(&dev->v4l2_dev,
@@ -471,16 +462,11 @@ static void tw686x_buf_queue(struct vb2_buffer *vb)
 static void tw686x_clear_queue(struct tw686x_video_channel *vc,
 			       enum vb2_buffer_state state)
 {
+	struct tw686x_v4l2_buf *buf;
 	unsigned int pb;
 
-	while (!list_empty(&vc->vidq_queued)) {
-		struct tw686x_v4l2_buf *buf;
-
-		buf = list_first_entry(&vc->vidq_queued,
-			struct tw686x_v4l2_buf, list);
-		list_del(&buf->list);
+	list_for_each_entry_del(buf, &vc->vidq_queued, list)
 		vb2_buffer_done(&buf->vb.vb2_buf, state);
-	}
 
 	for (pb = 0; pb < 2; pb++) {
 		if (vc->curr_bufs[pb])
diff --git a/drivers/media/pci/zoran/zoran_driver.c b/drivers/media/pci/zoran/zoran_driver.c
index fa672cc8bc67..86c672e3be9c 100644
--- a/drivers/media/pci/zoran/zoran_driver.c
+++ b/drivers/media/pci/zoran/zoran_driver.c
@@ -932,9 +932,7 @@ static void zr_vb2_stop_streaming(struct vb2_queue *vq)
 	}
 
 	spin_lock_irqsave(&zr->queued_bufs_lock, flags);
-	while (!list_empty(&zr->queued_bufs)) {
-		buf = list_entry(zr->queued_bufs.next, struct zr_buffer, queue);
-		list_del(&buf->queue);
+	list_for_each_entry_del(buf, &zr->queued_bufs, queue) {
 		vb2_buffer_done(&buf->vbuf.vb2_buf, VB2_BUF_STATE_ERROR);
 		zr->buf_in_reserve--;
 	}
diff --git a/drivers/media/platform/chips-media/coda-common.c b/drivers/media/platform/chips-media/coda-common.c
index cc4892129aaf..eefee828a377 100644
--- a/drivers/media/platform/chips-media/coda-common.c
+++ b/drivers/media/platform/chips-media/coda-common.c
@@ -2146,12 +2146,9 @@ static void coda_stop_streaming(struct vb2_queue *q)
 			flush_work(&ctx->seq_end_work);
 		}
 		spin_lock(&ctx->buffer_meta_lock);
-		while (!list_empty(&ctx->buffer_meta_list)) {
-			meta = list_first_entry(&ctx->buffer_meta_list,
-						struct coda_buffer_meta, list);
-			list_del(&meta->list);
+		list_for_each_entry_del(meta, &ctx->buffer_meta_list, list)
 			kfree(meta);
-		}
+
 		ctx->num_metas = 0;
 		spin_unlock(&ctx->buffer_meta_lock);
 		kfifo_init(&ctx->bitstream_fifo,
diff --git a/drivers/media/platform/nxp/imx8-isi/imx8-isi-video.c b/drivers/media/platform/nxp/imx8-isi/imx8-isi-video.c
index 10840c9a0912..84bd35389a35 100644
--- a/drivers/media/platform/nxp/imx8-isi/imx8-isi-video.c
+++ b/drivers/media/platform/nxp/imx8-isi/imx8-isi-video.c
@@ -737,27 +737,17 @@ static void mxc_isi_video_return_buffers(struct mxc_isi_video *video,
 
 	spin_lock_irq(&video->buf_lock);
 
-	while (!list_empty(&video->out_active)) {
-		buf = list_first_entry(&video->out_active,
-				       struct mxc_isi_buffer, list);
-		list_del_init(&buf->list);
+	list_for_each_entry_del_init(buf, &video->out_active, list) {
 		if (buf->discard)
 			continue;
 
 		vb2_buffer_done(&buf->v4l2_buf.vb2_buf, state);
 	}
 
-	while (!list_empty(&video->out_pending)) {
-		buf = list_first_entry(&video->out_pending,
-				       struct mxc_isi_buffer, list);
-		list_del_init(&buf->list);
+	list_for_each_entry_del_init(buf, &video->out_pending, list)
 		vb2_buffer_done(&buf->v4l2_buf.vb2_buf, state);
-	}
 
-	while (!list_empty(&video->out_discard)) {
-		buf = list_first_entry(&video->out_discard,
-				       struct mxc_isi_buffer, list);
-		list_del_init(&buf->list);
+	list_for_each_entry_del_init(buf, &video->out_discard, list) {
 	}
 
 	INIT_LIST_HEAD(&video->out_active);
diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
index 8f3cba319762..39eecd6ecf68 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
@@ -867,12 +867,8 @@ static void rkisp1_return_all_buffers(struct rkisp1_capture *cap,
 		vb2_buffer_done(&cap->buf.next->vb.vb2_buf, state);
 		cap->buf.next = NULL;
 	}
-	while (!list_empty(&cap->buf.queue)) {
-		buf = list_first_entry(&cap->buf.queue,
-				       struct rkisp1_buffer, queue);
-		list_del(&buf->queue);
+	list_for_each_entry_del(buf, &cap->buf.queue, queue)
 		vb2_buffer_done(&buf->vb.vb2_buf, state);
-	}
 	spin_unlock_irq(&cap->buf.lock);
 }
 
diff --git a/drivers/media/platform/samsung/exynos4-is/media-dev.c b/drivers/media/platform/samsung/exynos4-is/media-dev.c
index 5f10bb4eb4f7..0825279449b5 100644
--- a/drivers/media/platform/samsung/exynos4-is/media-dev.c
+++ b/drivers/media/platform/samsung/exynos4-is/media-dev.c
@@ -385,13 +385,10 @@ static struct exynos_media_pipeline *fimc_md_pipeline_create(
 
 static void fimc_md_pipelines_free(struct fimc_md *fmd)
 {
-	while (!list_empty(&fmd->pipelines)) {
-		struct fimc_pipeline *p;
+	struct fimc_pipeline *p;
 
-		p = list_entry(fmd->pipelines.next, typeof(*p), list);
-		list_del(&p->list);
+	list_for_each_entry_del(p, &fmd->pipelines, list)
 		kfree(p);
-	}
 }
 
 static int fimc_md_parse_one_endpoint(struct fimc_md *fmd,
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
index f62703cebb77..c0f94ec07f8e 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_enc.c
@@ -1116,10 +1116,7 @@ static void cleanup_ref_queue(struct s5p_mfc_ctx *ctx)
 	struct s5p_mfc_buf *mb_entry;
 
 	/* move buffers in ref queue to src queue */
-	while (!list_empty(&ctx->ref_queue)) {
-		mb_entry = list_entry((&ctx->ref_queue)->next,
-						struct s5p_mfc_buf, list);
-		list_del(&mb_entry->list);
+	list_for_each_entry_del(mb_entry, &ctx->ref_queue, list) {
 		ctx->ref_queue_cnt--;
 		list_add_tail(&mb_entry->list, &ctx->src_queue);
 		ctx->src_queue_cnt++;
diff --git a/drivers/media/platform/ti/davinci/vpif_capture.c b/drivers/media/platform/ti/davinci/vpif_capture.c
index 99fae8830c41..4eaf5f306a0a 100644
--- a/drivers/media/platform/ti/davinci/vpif_capture.c
+++ b/drivers/media/platform/ti/davinci/vpif_capture.c
@@ -293,10 +293,7 @@ static void vpif_stop_streaming(struct vb2_queue *vq)
 	}
 
 	spin_lock_irqsave(&common->irqlock, flags);
-	while (!list_empty(&common->dma_queue)) {
-		common->next_frm = list_entry(common->dma_queue.next,
-						struct vpif_cap_buffer, list);
-		list_del(&common->next_frm->list);
+	list_for_each_entry_del(common->next_frm, &common->dma_queue, list) {
 		vb2_buffer_done(&common->next_frm->vb.vb2_buf,
 				VB2_BUF_STATE_ERROR);
 	}
diff --git a/drivers/media/platform/ti/davinci/vpif_display.c b/drivers/media/platform/ti/davinci/vpif_display.c
index f8ec2991c667..ba8d3a73f6bb 100644
--- a/drivers/media/platform/ti/davinci/vpif_display.c
+++ b/drivers/media/platform/ti/davinci/vpif_display.c
@@ -280,10 +280,7 @@ static void vpif_stop_streaming(struct vb2_queue *vq)
 					VB2_BUF_STATE_ERROR);
 	}
 
-	while (!list_empty(&common->dma_queue)) {
-		common->next_frm = list_entry(common->dma_queue.next,
-						struct vpif_disp_buffer, list);
-		list_del(&common->next_frm->list);
+	list_for_each_entry_del(common->next_frm, &common->dma_queue, list) {
 		vb2_buffer_done(&common->next_frm->vb.vb2_buf,
 				VB2_BUF_STATE_ERROR);
 	}
diff --git a/drivers/media/platform/ti/omap3isp/ispvideo.c b/drivers/media/platform/ti/omap3isp/ispvideo.c
index daca689dc082..931d804e5b7d 100644
--- a/drivers/media/platform/ti/omap3isp/ispvideo.c
+++ b/drivers/media/platform/ti/omap3isp/ispvideo.c
@@ -437,14 +437,10 @@ static void isp_video_buffer_queue(struct vb2_buffer *buf)
 static void omap3isp_video_return_buffers(struct isp_video *video,
 					  enum vb2_buffer_state state)
 {
-	while (!list_empty(&video->dmaqueue)) {
-		struct isp_buffer *buf;
+	struct isp_buffer *buf;
 
-		buf = list_first_entry(&video->dmaqueue,
-				       struct isp_buffer, irqlist);
-		list_del(&buf->irqlist);
+	list_for_each_entry_del(buf, &video->dmaqueue, irqlist)
 		vb2_buffer_done(&buf->vb.vb2_buf, state);
-	}
 }
 
 static int isp_video_start_streaming(struct vb2_queue *queue,
diff --git a/drivers/media/test-drivers/vivid/vivid-kthread-cap.c b/drivers/media/test-drivers/vivid/vivid-kthread-cap.c
index 42048727d7ff..c2bac5a01465 100644
--- a/drivers/media/test-drivers/vivid/vivid-kthread-cap.c
+++ b/drivers/media/test-drivers/vivid/vivid-kthread-cap.c
@@ -830,13 +830,10 @@ void vivid_stop_generating_vid_cap(struct vivid_dev *dev, bool *pstreaming)
 
 	*pstreaming = false;
 	if (pstreaming == &dev->vid_cap_streaming) {
-		/* Release all active buffers */
-		while (!list_empty(&dev->vid_cap_active)) {
-			struct vivid_buffer *buf;
+		struct vivid_buffer *buf;
 
-			buf = list_entry(dev->vid_cap_active.next,
-					 struct vivid_buffer, list);
-			list_del(&buf->list);
+		/* Release all active buffers */
+		list_for_each_entry_del(buf, &dev->vid_cap_active, list) {
 			v4l2_ctrl_request_complete(buf->vb.vb2_buf.req_obj.req,
 						   &dev->ctrl_hdl_vid_cap);
 			vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);
@@ -846,12 +843,9 @@ void vivid_stop_generating_vid_cap(struct vivid_dev *dev, bool *pstreaming)
 	}
 
 	if (pstreaming == &dev->vbi_cap_streaming) {
-		while (!list_empty(&dev->vbi_cap_active)) {
-			struct vivid_buffer *buf;
+		struct vivid_buffer *buf;
 
-			buf = list_entry(dev->vbi_cap_active.next,
-					 struct vivid_buffer, list);
-			list_del(&buf->list);
+		list_for_each_entry_del(buf, &dev->vbi_cap_active, list) {
 			v4l2_ctrl_request_complete(buf->vb.vb2_buf.req_obj.req,
 						   &dev->ctrl_hdl_vbi_cap);
 			vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);
@@ -861,12 +855,9 @@ void vivid_stop_generating_vid_cap(struct vivid_dev *dev, bool *pstreaming)
 	}
 
 	if (pstreaming == &dev->meta_cap_streaming) {
-		while (!list_empty(&dev->meta_cap_active)) {
-			struct vivid_buffer *buf;
+		struct vivid_buffer *buf;
 
-			buf = list_entry(dev->meta_cap_active.next,
-					 struct vivid_buffer, list);
-			list_del(&buf->list);
+		list_for_each_entry_del(buf, &dev->meta_cap_active, list) {
 			v4l2_ctrl_request_complete(buf->vb.vb2_buf.req_obj.req,
 						   &dev->ctrl_hdl_meta_cap);
 			vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);
diff --git a/drivers/media/test-drivers/vivid/vivid-kthread-out.c b/drivers/media/test-drivers/vivid/vivid-kthread-out.c
index fac6208b51da..a090512210ef 100644
--- a/drivers/media/test-drivers/vivid/vivid-kthread-out.c
+++ b/drivers/media/test-drivers/vivid/vivid-kthread-out.c
@@ -294,6 +294,8 @@ int vivid_start_generating_vid_out(struct vivid_dev *dev, bool *pstreaming)
 
 void vivid_stop_generating_vid_out(struct vivid_dev *dev, bool *pstreaming)
 {
+	struct vivid_buffer *buf;
+
 	dprintk(dev, 1, "%s\n", __func__);
 
 	if (dev->kthread_vid_out == NULL)
@@ -302,12 +304,7 @@ void vivid_stop_generating_vid_out(struct vivid_dev *dev, bool *pstreaming)
 	*pstreaming = false;
 	if (pstreaming == &dev->vid_out_streaming) {
 		/* Release all active buffers */
-		while (!list_empty(&dev->vid_out_active)) {
-			struct vivid_buffer *buf;
-
-			buf = list_entry(dev->vid_out_active.next,
-					 struct vivid_buffer, list);
-			list_del(&buf->list);
+		list_for_each_entry_del(buf, &dev->vid_out_active, list) {
 			v4l2_ctrl_request_complete(buf->vb.vb2_buf.req_obj.req,
 						   &dev->ctrl_hdl_vid_out);
 			vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);
@@ -317,12 +314,7 @@ void vivid_stop_generating_vid_out(struct vivid_dev *dev, bool *pstreaming)
 	}
 
 	if (pstreaming == &dev->vbi_out_streaming) {
-		while (!list_empty(&dev->vbi_out_active)) {
-			struct vivid_buffer *buf;
-
-			buf = list_entry(dev->vbi_out_active.next,
-					 struct vivid_buffer, list);
-			list_del(&buf->list);
+		list_for_each_entry_del(buf, &dev->vbi_out_active, list) {
 			v4l2_ctrl_request_complete(buf->vb.vb2_buf.req_obj.req,
 						   &dev->ctrl_hdl_vbi_out);
 			vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);
@@ -332,12 +324,7 @@ void vivid_stop_generating_vid_out(struct vivid_dev *dev, bool *pstreaming)
 	}
 
 	if (pstreaming == &dev->meta_out_streaming) {
-		while (!list_empty(&dev->meta_out_active)) {
-			struct vivid_buffer *buf;
-
-			buf = list_entry(dev->meta_out_active.next,
-					 struct vivid_buffer, list);
-			list_del(&buf->list);
+		list_for_each_entry_del(buf, &dev->meta_out_active, list) {
 			v4l2_ctrl_request_complete(buf->vb.vb2_buf.req_obj.req,
 						   &dev->ctrl_hdl_meta_out);
 			vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);
diff --git a/drivers/media/test-drivers/vivid/vivid-kthread-touch.c b/drivers/media/test-drivers/vivid/vivid-kthread-touch.c
index fa711ee36a3f..d778da55b317 100644
--- a/drivers/media/test-drivers/vivid/vivid-kthread-touch.c
+++ b/drivers/media/test-drivers/vivid/vivid-kthread-touch.c
@@ -168,17 +168,14 @@ int vivid_start_generating_touch_cap(struct vivid_dev *dev)
 
 void vivid_stop_generating_touch_cap(struct vivid_dev *dev)
 {
+	struct vivid_buffer *buf;
+
 	if (!dev->kthread_touch_cap)
 		return;
 
 	dev->touch_cap_streaming = false;
 
-	while (!list_empty(&dev->touch_cap_active)) {
-		struct vivid_buffer *buf;
-
-		buf = list_entry(dev->touch_cap_active.next,
-				 struct vivid_buffer, list);
-		list_del(&buf->list);
+	list_for_each_entry_del(buf, &dev->touch_cap_active, list) {
 		v4l2_ctrl_request_complete(buf->vb.vb2_buf.req_obj.req,
 					   &dev->ctrl_hdl_touch_cap);
 		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);
diff --git a/drivers/media/test-drivers/vivid/vivid-sdr-cap.c b/drivers/media/test-drivers/vivid/vivid-sdr-cap.c
index a81f26b76988..4a2365664114 100644
--- a/drivers/media/test-drivers/vivid/vivid-sdr-cap.c
+++ b/drivers/media/test-drivers/vivid/vivid-sdr-cap.c
@@ -297,17 +297,13 @@ static int sdr_cap_start_streaming(struct vb2_queue *vq, unsigned count)
 /* abort streaming and wait for last buffer */
 static void sdr_cap_stop_streaming(struct vb2_queue *vq)
 {
+	struct vivid_buffer *buf;
 	struct vivid_dev *dev = vb2_get_drv_priv(vq);
 
 	if (dev->kthread_sdr_cap == NULL)
 		return;
 
-	while (!list_empty(&dev->sdr_cap_active)) {
-		struct vivid_buffer *buf;
-
-		buf = list_entry(dev->sdr_cap_active.next,
-				struct vivid_buffer, list);
-		list_del(&buf->list);
+	list_for_each_entry_del(buf, &dev->sdr_cap_active, list) {
 		v4l2_ctrl_request_complete(buf->vb.vb2_buf.req_obj.req,
 					   &dev->ctrl_hdl_sdr_cap);
 		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);
diff --git a/drivers/media/usb/airspy/airspy.c b/drivers/media/usb/airspy/airspy.c
index 462eb8423506..0204adb91ff0 100644
--- a/drivers/media/usb/airspy/airspy.c
+++ b/drivers/media/usb/airspy/airspy.c
@@ -440,19 +440,15 @@ static int airspy_alloc_urbs(struct airspy *s)
 /* Must be called with vb_queue_lock hold */
 static void airspy_cleanup_queued_bufs(struct airspy *s)
 {
+	struct airspy_frame_buf *buf;
 	unsigned long flags;
 
 	dev_dbg(s->dev, "\n");
 
 	spin_lock_irqsave(&s->queued_bufs_lock, flags);
-	while (!list_empty(&s->queued_bufs)) {
-		struct airspy_frame_buf *buf;
 
-		buf = list_entry(s->queued_bufs.next,
-				struct airspy_frame_buf, list);
-		list_del(&buf->list);
+	list_for_each_entry_del(buf, &s->queued_bufs, list)
 		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);
-	}
 	spin_unlock_irqrestore(&s->queued_bufs_lock, flags);
 }
 
diff --git a/drivers/media/usb/au0828/au0828-video.c b/drivers/media/usb/au0828/au0828-video.c
index fd9fc43d47e0..cdf679e6a198 100644
--- a/drivers/media/usb/au0828/au0828-video.c
+++ b/drivers/media/usb/au0828/au0828-video.c
@@ -880,6 +880,7 @@ static void au0828_stop_streaming(struct vb2_queue *vq)
 
 void au0828_stop_vbi_streaming(struct vb2_queue *vq)
 {
+	struct au0828_buffer *buf;
 	struct au0828_dev *dev = vb2_get_drv_priv(vq);
 	struct au0828_dmaqueue *vbiq = &dev->vbiq;
 	unsigned long flags = 0;
@@ -898,13 +899,9 @@ void au0828_stop_vbi_streaming(struct vb2_queue *vq)
 				VB2_BUF_STATE_ERROR);
 		dev->isoc_ctl.vbi_buf = NULL;
 	}
-	while (!list_empty(&vbiq->active)) {
-		struct au0828_buffer *buf;
 
-		buf = list_entry(vbiq->active.next, struct au0828_buffer, list);
-		list_del(&buf->list);
+	list_for_each_entry_del(buf, &vbiq->active, list)
 		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);
-	}
 	spin_unlock_irqrestore(&dev->slock, flags);
 
 	dev->vbi_timeout_running = 0;
diff --git a/drivers/media/usb/em28xx/em28xx-video.c b/drivers/media/usb/em28xx/em28xx-video.c
index 25e0620deff1..9c29ae802ba0 100644
--- a/drivers/media/usb/em28xx/em28xx-video.c
+++ b/drivers/media/usb/em28xx/em28xx-video.c
@@ -1136,6 +1136,7 @@ int em28xx_start_analog_streaming(struct vb2_queue *vq, unsigned int count)
 
 static void em28xx_stop_streaming(struct vb2_queue *vq)
 {
+	struct em28xx_buffer *buf;
 	struct em28xx *dev = vb2_get_drv_priv(vq);
 	struct em28xx_v4l2 *v4l2 = dev->v4l2;
 	struct em28xx_dmaqueue *vidq = &dev->vidq;
@@ -1159,18 +1160,15 @@ static void em28xx_stop_streaming(struct vb2_queue *vq)
 				VB2_BUF_STATE_ERROR);
 		dev->usb_ctl.vid_buf = NULL;
 	}
-	while (!list_empty(&vidq->active)) {
-		struct em28xx_buffer *buf;
 
-		buf = list_entry(vidq->active.next, struct em28xx_buffer, list);
-		list_del(&buf->list);
+	list_for_each_entry_del(buf, &vidq->active, list)
 		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);
-	}
 	spin_unlock_irqrestore(&dev->slock, flags);
 }
 
 void em28xx_stop_vbi_streaming(struct vb2_queue *vq)
 {
+	struct em28xx_buffer *buf;
 	struct em28xx *dev = vb2_get_drv_priv(vq);
 	struct em28xx_v4l2 *v4l2 = dev->v4l2;
 	struct em28xx_dmaqueue *vbiq = &dev->vbiq;
@@ -1194,13 +1192,9 @@ void em28xx_stop_vbi_streaming(struct vb2_queue *vq)
 				VB2_BUF_STATE_ERROR);
 		dev->usb_ctl.vbi_buf = NULL;
 	}
-	while (!list_empty(&vbiq->active)) {
-		struct em28xx_buffer *buf;
 
-		buf = list_entry(vbiq->active.next, struct em28xx_buffer, list);
-		list_del(&buf->list);
+	list_for_each_entry_del(buf, &vbiq->active, list)
 		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);
-	}
 	spin_unlock_irqrestore(&dev->slock, flags);
 }
 
diff --git a/drivers/media/usb/msi2500/msi2500.c b/drivers/media/usb/msi2500/msi2500.c
index 9759996ee6a4..99549b4175a3 100644
--- a/drivers/media/usb/msi2500/msi2500.c
+++ b/drivers/media/usb/msi2500/msi2500.c
@@ -543,19 +543,14 @@ static int msi2500_isoc_init(struct msi2500_dev *dev)
 /* Must be called with vb_queue_lock hold */
 static void msi2500_cleanup_queued_bufs(struct msi2500_dev *dev)
 {
+	struct msi2500_frame_buf *buf;
 	unsigned long flags;
 
 	dev_dbg(dev->dev, "\n");
 
 	spin_lock_irqsave(&dev->queued_bufs_lock, flags);
-	while (!list_empty(&dev->queued_bufs)) {
-		struct msi2500_frame_buf *buf;
-
-		buf = list_entry(dev->queued_bufs.next,
-				 struct msi2500_frame_buf, list);
-		list_del(&buf->list);
+	list_for_each_entry_del(buf, &dev->queued_bufs, list)
 		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);
-	}
 	spin_unlock_irqrestore(&dev->queued_bufs_lock, flags);
 }
 
diff --git a/drivers/media/usb/pwc/pwc-if.c b/drivers/media/usb/pwc/pwc-if.c
index e342199711d3..11636ce37a52 100644
--- a/drivers/media/usb/pwc/pwc-if.c
+++ b/drivers/media/usb/pwc/pwc-if.c
@@ -554,17 +554,13 @@ static void pwc_isoc_cleanup(struct pwc_device *pdev)
 static void pwc_cleanup_queued_bufs(struct pwc_device *pdev,
 				    enum vb2_buffer_state state)
 {
+	struct pwc_frame_buf *buf;
 	unsigned long flags = 0;
 
 	spin_lock_irqsave(&pdev->queued_bufs_lock, flags);
-	while (!list_empty(&pdev->queued_bufs)) {
-		struct pwc_frame_buf *buf;
 
-		buf = list_entry(pdev->queued_bufs.next, struct pwc_frame_buf,
-				 list);
-		list_del(&buf->list);
+	list_for_each_entry_del(buf, &pdev->queued_bufs, list)
 		vb2_buffer_done(&buf->vb.vb2_buf, state);
-	}
 	spin_unlock_irqrestore(&pdev->queued_bufs_lock, flags);
 }
 
diff --git a/drivers/media/usb/stk1160/stk1160-v4l.c b/drivers/media/usb/stk1160/stk1160-v4l.c
index a1f785a5ffd8..83a4d4ba68d1 100644
--- a/drivers/media/usb/stk1160/stk1160-v4l.c
+++ b/drivers/media/usb/stk1160/stk1160-v4l.c
@@ -756,10 +756,7 @@ void stk1160_clear_queue(struct stk1160 *dev, enum vb2_buffer_state vb2_state)
 
 	/* Release all active buffers */
 	spin_lock_irqsave(&dev->buf_lock, flags);
-	while (!list_empty(&dev->avail_bufs)) {
-		buf = list_first_entry(&dev->avail_bufs,
-			struct stk1160_buffer, list);
-		list_del(&buf->list);
+	list_for_each_entry_del(buf, &dev->avail_bufs, list) {
 		vb2_buffer_done(&buf->vb.vb2_buf, vb2_state);
 		stk1160_dbg("buffer [%p/%d] aborted\n",
 			    buf, buf->vb.vb2_buf.index);
diff --git a/drivers/media/usb/uvc/uvc_queue.c b/drivers/media/usb/uvc/uvc_queue.c
index 16fa17bbd15e..6b01cc44af84 100644
--- a/drivers/media/usb/uvc/uvc_queue.c
+++ b/drivers/media/usb/uvc/uvc_queue.c
@@ -45,15 +45,12 @@ static inline struct uvc_buffer *uvc_vbuf_to_buffer(struct vb2_v4l2_buffer *buf)
 static void uvc_queue_return_buffers(struct uvc_video_queue *queue,
 			       enum uvc_buffer_state state)
 {
+	struct uvc_buffer *buf;
 	enum vb2_buffer_state vb2_state = state == UVC_BUF_STATE_ERROR
 					? VB2_BUF_STATE_ERROR
 					: VB2_BUF_STATE_QUEUED;
 
-	while (!list_empty(&queue->irqqueue)) {
-		struct uvc_buffer *buf = list_first_entry(&queue->irqqueue,
-							  struct uvc_buffer,
-							  queue);
-		list_del(&buf->queue);
+	list_for_each_entry_del(buf, &queue->irqqueue, queue) {
 		buf->state = state;
 		vb2_buffer_done(&buf->buf.vb2_buf, vb2_state);
 	}
diff --git a/drivers/mtd/ubi/wl.c b/drivers/mtd/ubi/wl.c
index 26a214f016c1..f7777013354a 100644
--- a/drivers/mtd/ubi/wl.c
+++ b/drivers/mtd/ubi/wl.c
@@ -1718,11 +1718,9 @@ int ubi_thread(void *u)
  */
 static void shutdown_work(struct ubi_device *ubi)
 {
-	while (!list_empty(&ubi->works)) {
-		struct ubi_work *wrk;
+	struct ubi_work *wrk;
 
-		wrk = list_entry(ubi->works.next, struct ubi_work, list);
-		list_del(&wrk->list);
+	list_for_each_entry_del(wrk, &ubi->works, list) {
 		wrk->func(ubi, wrk, 1);
 		ubi->works_count -= 1;
 		ubi_assert(ubi->works_count >= 0);
diff --git a/drivers/net/ethernet/agere/et131x.c b/drivers/net/ethernet/agere/et131x.c
index 3d9220f9c9fe..30088e6db40c 100644
--- a/drivers/net/ethernet/agere/et131x.c
+++ b/drivers/net/ethernet/agere/et131x.c
@@ -2012,11 +2012,7 @@ static void et131x_rx_dma_memory_free(struct et131x_adapter *adapter)
 	/* Free RFDs and associated packet descriptors */
 	WARN_ON(rx_ring->num_ready_recv != rx_ring->num_rfd);
 
-	while (!list_empty(&rx_ring->recv_list)) {
-		rfd = list_entry(rx_ring->recv_list.next,
-				 struct rfd, list_node);
-
-		list_del(&rfd->list_node);
+	list_for_each_entry_del(rfd, &rx_ring->recv_list, list_node) {
 		rfd->skb = NULL;
 		kfree(rfd);
 	}
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
index 0d8e61c63c7c..d80bb466edae 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -12526,11 +12526,8 @@ static void bnx2x_free_mcast_macs_list(struct list_head *mcast_group_list)
 {
 	struct bnx2x_mcast_list_elem_group *current_mcast_group;
 
-	while (!list_empty(mcast_group_list)) {
-		current_mcast_group = list_first_entry(mcast_group_list,
-				      struct bnx2x_mcast_list_elem_group,
-				      mcast_group_link);
-		list_del(&current_mcast_group->mcast_group_link);
+	list_for_each_entry_del(current_mcast_group, mcast_group_list,
+				mcast_group_link) {
 		free_page((unsigned long)current_mcast_group);
 	}
 }
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sp.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sp.c
index 8e04552d2216..1d65a0195710 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sp.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sp.c
@@ -154,13 +154,8 @@ static inline void __bnx2x_exe_queue_reset_pending(
 {
 	struct bnx2x_exeq_elem *elem;
 
-	while (!list_empty(&o->pending_comp)) {
-		elem = list_first_entry(&o->pending_comp,
-					struct bnx2x_exeq_elem, link);
-
-		list_del(&elem->link);
+	list_for_each_entry_del(elem, &o->pending_comp, link)
 		bnx2x_exe_queue_free_elem(bp, elem);
-	}
 }
 
 /**
@@ -2659,11 +2654,8 @@ static void bnx2x_free_groups(struct list_head *mcast_group_list)
 {
 	struct bnx2x_mcast_elem_group *current_mcast_group;
 
-	while (!list_empty(mcast_group_list)) {
-		current_mcast_group = list_first_entry(mcast_group_list,
-				      struct bnx2x_mcast_elem_group,
-				      mcast_group_link);
-		list_del(&current_mcast_group->mcast_group_link);
+	list_for_each_entry_del(current_mcast_group, mcast_group_list,
+				mcast_group_link) {
 		free_page((unsigned long)current_mcast_group);
 	}
 }
diff --git a/drivers/net/ethernet/brocade/bna/bfa_ioc.c b/drivers/net/ethernet/brocade/bna/bfa_ioc.c
index b07522ac3e74..3bae7d6102e8 100644
--- a/drivers/net/ethernet/brocade/bna/bfa_ioc.c
+++ b/drivers/net/ethernet/brocade/bna/bfa_ioc.c
@@ -2172,10 +2172,7 @@ bfa_ioc_mbox_flush(struct bfa_ioc *ioc)
 	struct bfa_ioc_mbox_mod *mod = &ioc->mbox_mod;
 	struct bfa_mbox_cmd *cmd;
 
-	while (!list_empty(&mod->cmd_q)) {
-		cmd = list_first_entry(&mod->cmd_q, struct bfa_mbox_cmd, qe);
-		list_del(&cmd->qe);
-	}
+	list_for_each_entry_del(cmd, &mod->cmd_q, qe);
 }
 
 /**
diff --git a/drivers/net/ethernet/brocade/bna/bfa_msgq.c b/drivers/net/ethernet/brocade/bna/bfa_msgq.c
index fa40d5ec6f1c..a4a06e4486db 100644
--- a/drivers/net/ethernet/brocade/bna/bfa_msgq.c
+++ b/drivers/net/ethernet/brocade/bna/bfa_msgq.c
@@ -57,12 +57,8 @@ cmdq_sm_stopped_entry(struct bfa_msgq_cmdq *cmdq)
 	cmdq->token = 0;
 	cmdq->offset = 0;
 	cmdq->bytes_to_copy = 0;
-	while (!list_empty(&cmdq->pending_q)) {
-		cmdq_ent = list_first_entry(&cmdq->pending_q,
-					    struct bfa_msgq_cmd_entry, qe);
-		list_del(&cmdq_ent->qe);
+	list_for_each_entry_del(cmdq_ent, &cmdq->pending_q, qe)
 		call_cmdq_ent_cbfn(cmdq_ent, BFA_STATUS_FAILED);
-	}
 }
 
 static void
diff --git a/drivers/net/ethernet/brocade/bna/bna_tx_rx.c b/drivers/net/ethernet/brocade/bna/bna_tx_rx.c
index c05dc7a1c4a1..5e2a812f2705 100644
--- a/drivers/net/ethernet/brocade/bna/bna_tx_rx.c
+++ b/drivers/net/ethernet/brocade/bna/bna_tx_rx.c
@@ -904,10 +904,7 @@ bna_rx_mcast_delall(struct bna_rx *rx)
 	}
 
 	/* Schedule all entries in active_q for deletion */
-	while (!list_empty(&rxf->mcast_active_q)) {
-		mac = list_first_entry(&rxf->mcast_active_q,
-				       struct bna_mac, qe);
-		list_del(&mac->qe);
+	list_for_each_entry_del(mac, &rxf->mcast_active_q, qe) {
 		del_mac = bna_cam_mod_mac_get(bna_mcam_mod_del_q(rxf->rx->bna));
 		memcpy(del_mac, mac, sizeof(*del_mac));
 		list_add_tail(&del_mac->qe, &rxf->mcast_pending_del_q);
@@ -2490,9 +2487,7 @@ bna_rx_destroy(struct bna_rx *rx)
 
 	bna_rxf_uninit(&rx->rxf);
 
-	while (!list_empty(&rx->rxp_q)) {
-		rxp = list_first_entry(&rx->rxp_q, struct bna_rxp, qe);
-		list_del(&rxp->qe);
+	list_for_each_entry_del(rxp, &rx->rxp_q, qe) {
 		GET_RXQS(rxp, q0, q1);
 		if (rx->rcb_destroy_cbfn)
 			rx->rcb_destroy_cbfn(rx->bna->bnad, q0->rcb);
diff --git a/drivers/net/ethernet/qlogic/qed/qed_ooo.c b/drivers/net/ethernet/qlogic/qed/qed_ooo.c
index 5d725f59db24..8f07f54b1902 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_ooo.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_ooo.c
@@ -172,12 +172,8 @@ void qed_ooo_release_connection_isles(struct qed_hwfn *p_hwfn,
 	if (!p_archipelago)
 		return;
 
-	while (!list_empty(&p_archipelago->isles_list)) {
-		p_isle = list_first_entry(&p_archipelago->isles_list,
-					  struct qed_ooo_isle, list_entry);
-
-		list_del(&p_isle->list_entry);
-
+	list_for_each_entry_del(p_isle, &p_archipelago->isles_list,
+				list_entry) {
 		while (!list_empty(&p_isle->buffers_list)) {
 			p_buffer = list_first_entry(&p_isle->buffers_list,
 						    struct qed_ooo_buffer,
@@ -205,13 +201,8 @@ void qed_ooo_release_all_isles(struct qed_hwfn *p_hwfn,
 	for (i = 0; i < p_ooo_info->max_num_archipelagos; i++) {
 		p_archipelago = &(p_ooo_info->p_archipelagos_mem[i]);
 
-		while (!list_empty(&p_archipelago->isles_list)) {
-			p_isle = list_first_entry(&p_archipelago->isles_list,
-						  struct qed_ooo_isle,
-						  list_entry);
-
-			list_del(&p_isle->list_entry);
-
+		list_for_each_entry_del(p_isle, &p_archipelago->isles_list,
+					list_entry) {
 			while (!list_empty(&p_isle->buffers_list)) {
 				p_buffer =
 				    list_first_entry(&p_isle->buffers_list,
diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c
index f9dd50152b1e..640b0cb218c2 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_sriov_common.c
@@ -244,10 +244,7 @@ void qlcnic_sriov_cleanup_list(struct qlcnic_trans_list *t_list)
 
 	spin_lock_irqsave(&t_list->lock, flags);
 
-	while (!list_empty(&t_list->wait_list)) {
-		trans = list_first_entry(&t_list->wait_list,
-					 struct qlcnic_bc_trans, list);
-		list_del(&trans->list);
+	list_for_each_entry_del(trans, &t_list->wait_list, list) {
 		t_list->count--;
 		cmd.req.arg = (u32 *)trans->req_pay;
 		cmd.rsp.arg = (u32 *)trans->rsp_pay;
@@ -1530,10 +1527,7 @@ void qlcnic_sriov_cleanup_async_list(struct qlcnic_back_channel *bc)
 	cancel_work_sync(&bc->vf_async_work);
 
 	spin_lock(&bc->queue_lock);
-	while (!list_empty(head)) {
-		entry = list_entry(head->next, struct qlcnic_async_cmd,
-				   list);
-		list_del(&entry->list);
+	list_for_each_entry_del(entry, head, list) {
 		kfree(entry->cmd);
 		kfree(entry);
 	}
diff --git a/drivers/net/ethernet/sfc/siena/siena_sriov.c b/drivers/net/ethernet/sfc/siena/siena_sriov.c
index 8353c15dc233..e81284b24621 100644
--- a/drivers/net/ethernet/sfc/siena/siena_sriov.c
+++ b/drivers/net/ethernet/sfc/siena/siena_sriov.c
@@ -1148,10 +1148,7 @@ static void efx_siena_sriov_peer_work(struct work_struct *data)
 	mutex_unlock(&nic_data->local_lock);
 
 	/* Free any now unused endpoint pages */
-	while (!list_empty(&pages)) {
-		epp = list_first_entry(
-			&pages, struct efx_endpoint_page, link);
-		list_del(&epp->link);
+	list_for_each_entry_del(epp, &pages, link) {
 		dma_free_coherent(&efx->pci_dev->dev, EFX_PAGE_SIZE,
 				  epp->ptr, epp->addr);
 		kfree(epp);
@@ -1174,17 +1171,10 @@ static void efx_siena_sriov_free_local(struct efx_nic *efx)
 	struct efx_local_addr *local_addr;
 	struct efx_endpoint_page *epp;
 
-	while (!list_empty(&nic_data->local_addr_list)) {
-		local_addr = list_first_entry(&nic_data->local_addr_list,
-					      struct efx_local_addr, link);
-		list_del(&local_addr->link);
+	list_for_each_entry_del(local_addr, &nic_data->local_addr_list, link)
 		kfree(local_addr);
-	}
 
-	while (!list_empty(&nic_data->local_page_list)) {
-		epp = list_first_entry(&nic_data->local_page_list,
-				       struct efx_endpoint_page, link);
-		list_del(&epp->link);
+	list_for_each_entry_del(epp, &nic_data->local_page_list, link) {
 		dma_free_coherent(&efx->pci_dev->dev, EFX_PAGE_SIZE,
 				  epp->ptr, epp->addr);
 		kfree(epp);
diff --git a/drivers/net/ethernet/sun/ldmvsw.c b/drivers/net/ethernet/sun/ldmvsw.c
index a9a6670b5ff1..886b3ddbee37 100644
--- a/drivers/net/ethernet/sun/ldmvsw.c
+++ b/drivers/net/ethernet/sun/ldmvsw.c
@@ -436,9 +436,7 @@ static void vsw_cleanup(void)
 
 	/* just need to free up the vnet list */
 	mutex_lock(&vnet_list_mutex);
-	while (!list_empty(&vnet_list)) {
-		vp = list_first_entry(&vnet_list, struct vnet, list);
-		list_del(&vp->list);
+	list_for_each_entry_del(vp, &vnet_list, list) {
 		/* vio_unregister_driver() should have cleaned up port_list */
 		if (!list_empty(&vp->port_list))
 			pr_err("Ports not removed by VIO subsystem!\n");
diff --git a/drivers/net/ethernet/sun/sunvnet.c b/drivers/net/ethernet/sun/sunvnet.c
index e220620d0ffc..3934cc30a999 100644
--- a/drivers/net/ethernet/sun/sunvnet.c
+++ b/drivers/net/ethernet/sun/sunvnet.c
@@ -368,9 +368,7 @@ static void vnet_cleanup(void)
 	struct net_device *dev;
 
 	mutex_lock(&vnet_list_mutex);
-	while (!list_empty(&vnet_list)) {
-		vp = list_first_entry(&vnet_list, struct vnet, list);
-		list_del(&vp->list);
+	list_for_each_entry_del(vp, &vnet_list, list) {
 		dev = vp->dev;
 		/* vio_unregister_driver() should have cleaned up port_list */
 		BUG_ON(!list_empty(&vp->port_list));
diff --git a/drivers/net/wireless/ath/ath10k/qmi.c b/drivers/net/wireless/ath/ath10k/qmi.c
index 52c1a3de8da6..0191b1ad315f 100644
--- a/drivers/net/wireless/ath/ath10k/qmi.c
+++ b/drivers/net/wireless/ath/ath10k/qmi.c
@@ -1030,10 +1030,7 @@ static void ath10k_qmi_driver_event_work(struct work_struct *work)
 	struct ath10k *ar = qmi->ar;
 
 	spin_lock(&qmi->event_lock);
-	while (!list_empty(&qmi->event_list)) {
-		event = list_first_entry(&qmi->event_list,
-					 struct ath10k_qmi_driver_event, list);
-		list_del(&event->list);
+	list_for_each_entry_del(event, &qmi->event_list, list) {
 		spin_unlock(&qmi->event_lock);
 
 		switch (event->type) {
diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index 41fad03a3025..0274982c29f6 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -3184,10 +3184,7 @@ static void ath11k_qmi_driver_event_work(struct work_struct *work)
 	int ret;
 
 	spin_lock(&qmi->event_lock);
-	while (!list_empty(&qmi->event_list)) {
-		event = list_first_entry(&qmi->event_list,
-					 struct ath11k_qmi_driver_event, list);
-		list_del(&event->list);
+	list_for_each_entry_del(event, &qmi->event_list, list) {
 		spin_unlock(&qmi->event_lock);
 
 		if (test_bit(ATH11K_FLAG_UNREGISTERING, &ab->dev_flags)) {
diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index b2db0436bdde..026e932624ba 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -2986,10 +2986,7 @@ static void ath12k_qmi_driver_event_work(struct work_struct *work)
 	int ret;
 
 	spin_lock(&qmi->event_lock);
-	while (!list_empty(&qmi->event_list)) {
-		event = list_first_entry(&qmi->event_list,
-					 struct ath12k_qmi_driver_event, list);
-		list_del(&event->list);
+	list_for_each_entry_del(event, &qmi->event_list, list) {
 		spin_unlock(&qmi->event_lock);
 
 		if (test_bit(ATH12K_FLAG_UNREGISTERING, &ab->dev_flags))
diff --git a/drivers/net/wireless/ath/ath6kl/htc_pipe.c b/drivers/net/wireless/ath/ath6kl/htc_pipe.c
index 9b88d96bfe96..f8d790482fca 100644
--- a/drivers/net/wireless/ath/ath6kl/htc_pipe.c
+++ b/drivers/net/wireless/ath/ath6kl/htc_pipe.c
@@ -917,12 +917,8 @@ static void do_recv_completion(struct htc_endpoint *ep,
 	}
 
 	/* using legacy EpRecv */
-	while (!list_empty(queue_to_indicate)) {
-		packet = list_first_entry(queue_to_indicate,
-					  struct htc_packet, list);
-		list_del(&packet->list);
+	list_for_each_entry_del(packet, queue_to_indicate, list)
 		ep->ep_cb.rx(ep->target, packet);
-	}
 
 	return;
 }
diff --git a/drivers/net/wireless/ath/ath6kl/txrx.c b/drivers/net/wireless/ath/ath6kl/txrx.c
index a56fab6232a9..bc0b044e930f 100644
--- a/drivers/net/wireless/ath/ath6kl/txrx.c
+++ b/drivers/net/wireless/ath/ath6kl/txrx.c
@@ -699,11 +699,7 @@ void ath6kl_tx_complete(struct htc_target *target,
 	spin_lock_bh(&ar->lock);
 
 	/* reap completed packets */
-	while (!list_empty(packet_queue)) {
-		packet = list_first_entry(packet_queue, struct htc_packet,
-					  list);
-		list_del(&packet->list);
-
+	list_for_each_entry_del(packet, packet_queue, list) {
 		if (WARN_ON_ONCE(packet->endpoint == ENDPOINT_UNUSED ||
 				 packet->endpoint >= ENDPOINT_MAX))
 			continue;
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/msgbuf.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/msgbuf.c
index 45fbcbdc7d9e..a87be4cd928a 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/msgbuf.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/msgbuf.c
@@ -1663,13 +1663,9 @@ void brcmf_proto_msgbuf_detach(struct brcmf_pub *drvr)
 	if (drvr->proto->pd) {
 		msgbuf = (struct brcmf_msgbuf *)drvr->proto->pd;
 		cancel_work_sync(&msgbuf->flowring_work);
-		while (!list_empty(&msgbuf->work_queue)) {
-			work = list_first_entry(&msgbuf->work_queue,
-						struct brcmf_msgbuf_work_item,
-						queue);
-			list_del(&work->queue);
+		list_for_each_entry_del(work, &msgbuf->work_queue, queue)
 			kfree(work);
-		}
+
 		kfree(msgbuf->flow_map);
 		kfree(msgbuf->txstatus_done_map);
 		if (msgbuf->txflow_wq)
diff --git a/drivers/net/wireless/intel/ipw2x00/ipw2100.c b/drivers/net/wireless/intel/ipw2x00/ipw2100.c
index 0812db8936f1..b1852db39dca 100644
--- a/drivers/net/wireless/intel/ipw2x00/ipw2100.c
+++ b/drivers/net/wireless/intel/ipw2x00/ipw2100.c
@@ -5785,7 +5785,6 @@ static int ipw2100_close(struct net_device *dev)
 {
 	struct ipw2100_priv *priv = libipw_priv(dev);
 	unsigned long flags;
-	struct list_head *element;
 	struct ipw2100_tx_packet *packet;
 
 	IPW_DEBUG_INFO("enter\n");
@@ -5797,17 +5796,13 @@ static int ipw2100_close(struct net_device *dev)
 	netif_stop_queue(dev);
 
 	/* Flush the TX queue ... */
-	while (!list_empty(&priv->tx_pend_list)) {
-		element = priv->tx_pend_list.next;
-		packet = list_entry(element, struct ipw2100_tx_packet, list);
-
-		list_del(element);
+	list_for_each_entry_del(packet, &priv->tx_pend_list, list) {
 		DEC_STAT(&priv->tx_pend_stat);
 
 		libipw_txb_free(packet->info.d_struct.txb);
 		packet->info.d_struct.txb = NULL;
 
-		list_add_tail(element, &priv->tx_free_list);
+		list_add_tail(&packet->list, &priv->tx_free_list);
 		INC_STAT(&priv->tx_free_stat);
 	}
 	spin_unlock_irqrestore(&priv->low_lock, flags);
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 3ab6a68f1e9f..48e92fee9976 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -2643,13 +2643,10 @@ static void iwl_fw_error_dump(struct iwl_fw_runtime *fwrt,
 
 static void iwl_dump_ini_list_free(struct list_head *list)
 {
-	while (!list_empty(list)) {
-		struct iwl_fw_ini_dump_entry *entry =
-			list_entry(list->next, typeof(*entry), list);
+	struct iwl_fw_ini_dump_entry *entry;
 
-		list_del(&entry->list);
+	list_for_each_entry_del(entry, list, list)
 		vfree(entry);
-	}
 }
 
 static void iwl_fw_error_dump_data_free(struct iwl_fwrt_dump_data *dump_data)
diff --git a/drivers/net/wireless/intersil/p54/p54spi.c b/drivers/net/wireless/intersil/p54/p54spi.c
index ce0179b8ab36..49453219ff24 100644
--- a/drivers/net/wireless/intersil/p54/p54spi.c
+++ b/drivers/net/wireless/intersil/p54/p54spi.c
@@ -430,12 +430,7 @@ static int p54spi_wq_tx(struct p54s_priv *priv)
 
 	spin_lock_irqsave(&priv->tx_lock, flags);
 
-	while (!list_empty(&priv->tx_pending)) {
-		entry = list_entry(priv->tx_pending.next,
-				   struct p54s_tx_info, tx_list);
-
-		list_del_init(&entry->tx_list);
-
+	list_for_each_entry_del_init(entry, &priv->tx_pending, tx_list) {
 		spin_unlock_irqrestore(&priv->tx_lock, flags);
 
 		dinfo = container_of((void *) entry, struct p54s_tx_info,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index b8b0c0fda752..3d0c72fd9db4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1962,9 +1962,7 @@ void mt7915_mac_sta_rc_work(struct work_struct *work)
 	spin_lock_bh(&dev->mt76.sta_poll_lock);
 	list_splice_init(&dev->sta_rc_list, &list);
 
-	while (!list_empty(&list)) {
-		msta = list_first_entry(&list, struct mt7915_sta, rc_list);
-		list_del_init(&msta->rc_list);
+	list_for_each_entry_del_init(msta, &list, rc_list) {
 		changed = msta->changed;
 		msta->changed = 0;
 		spin_unlock_bh(&dev->mt76.sta_poll_lock);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index ac8759febe48..62476348e39c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -2152,9 +2152,7 @@ void mt7996_mac_sta_rc_work(struct work_struct *work)
 	spin_lock_bh(&dev->mt76.sta_poll_lock);
 	list_splice_init(&dev->sta_rc_list, &list);
 
-	while (!list_empty(&list)) {
-		msta = list_first_entry(&list, struct mt7996_sta, rc_list);
-		list_del_init(&msta->rc_list);
+	list_for_each_entry_del_init(msta, &list, rc_list) {
 		changed = msta->changed;
 		msta->changed = 0;
 		spin_unlock_bh(&dev->mt76.sta_poll_lock);
diff --git a/drivers/net/wwan/wwan_hwsim.c b/drivers/net/wwan/wwan_hwsim.c
index ff3dd24ddb33..8530da9c9562 100644
--- a/drivers/net/wwan/wwan_hwsim.c
+++ b/drivers/net/wwan/wwan_hwsim.c
@@ -318,15 +318,12 @@ static struct wwan_hwsim_dev *wwan_hwsim_dev_new(void)
 
 static void wwan_hwsim_dev_del(struct wwan_hwsim_dev *dev)
 {
+	struct wwan_hwsim_port *port;
+
 	debugfs_remove(dev->debugfs_portcreate);	/* Avoid new ports */
 
 	spin_lock(&dev->ports_lock);
-	while (!list_empty(&dev->ports)) {
-		struct wwan_hwsim_port *port;
-
-		port = list_first_entry(&dev->ports, struct wwan_hwsim_port,
-					list);
-		list_del_init(&port->list);
+	list_for_each_entry_del_init(port, &dev->ports, list) {
 		spin_unlock(&dev->ports_lock);
 		wwan_hwsim_port_del(port);
 		spin_lock(&dev->ports_lock);
@@ -489,10 +486,7 @@ static void wwan_hwsim_free_devs(void)
 	struct wwan_hwsim_dev *dev;
 
 	spin_lock(&wwan_hwsim_devs_lock);
-	while (!list_empty(&wwan_hwsim_devs)) {
-		dev = list_first_entry(&wwan_hwsim_devs, struct wwan_hwsim_dev,
-				       list);
-		list_del_init(&dev->list);
+	list_for_each_entry_del_init(dev, &wwan_hwsim_devs, list) {
 		spin_unlock(&wwan_hwsim_devs_lock);
 		wwan_hwsim_dev_del(dev);
 		spin_lock(&wwan_hwsim_devs_lock);
diff --git a/drivers/net/xen-netback/netback.c b/drivers/net/xen-netback/netback.c
index 88f760a7cbc3..ffce0f6e5050 100644
--- a/drivers/net/xen-netback/netback.c
+++ b/drivers/net/xen-netback/netback.c
@@ -880,17 +880,13 @@ bool xenvif_mcast_match(struct xenvif *vif, const u8 *addr)
 
 void xenvif_mcast_addr_list_free(struct xenvif *vif)
 {
+	struct xenvif_mcast_addr *mcast;
+
 	/* No need for locking or RCU here. NAPI poll and TX queue
 	 * are stopped.
 	 */
-	while (!list_empty(&vif->fe_mcast_addr)) {
-		struct xenvif_mcast_addr *mcast;
-
-		mcast = list_first_entry(&vif->fe_mcast_addr,
-					 struct xenvif_mcast_addr,
-					 entry);
+	list_for_each_entry_del(mcast, &vif->fe_mcast_addr, entry) {
 		--vif->fe_mcast_count;
-		list_del(&mcast->entry);
 		kfree(mcast);
 	}
 }
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index a15b37750d6e..1e5cf09d2088 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3798,10 +3798,7 @@ static ssize_t nvme_fc_nvme_discovery_store(struct device *dev,
 	}
 
 process_local_list:
-	while (!list_empty(&local_disc_list)) {
-		rport = list_first_entry(&local_disc_list,
-					 struct nvme_fc_rport, disc_list);
-		list_del_init(&rport->disc_list);
+	list_for_each_entry_del_init(rport, &local_disc_list, disc_list) {
 		spin_unlock_irqrestore(&nvme_fc_lock, flags);
 
 		lport = rport->lport;
diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 4597bca43a6d..46b55f5a6e17 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -520,15 +520,11 @@ static int nvmet_rdma_post_recv(struct nvmet_rdma_device *ndev,
 
 static void nvmet_rdma_process_wr_wait_list(struct nvmet_rdma_queue *queue)
 {
-	spin_lock(&queue->rsp_wr_wait_lock);
-	while (!list_empty(&queue->rsp_wr_wait_list)) {
-		struct nvmet_rdma_rsp *rsp;
-		bool ret;
-
-		rsp = list_entry(queue->rsp_wr_wait_list.next,
-				struct nvmet_rdma_rsp, wait_list);
-		list_del(&rsp->wait_list);
+	struct nvmet_rdma_rsp *rsp;
+	bool ret;
 
+	spin_lock(&queue->rsp_wr_wait_lock);
+	list_for_each_entry_del(rsp, &queue->rsp_wr_wait_list, wait_list) {
 		spin_unlock(&queue->rsp_wr_wait_lock);
 		ret = nvmet_rdma_execute_command(rsp);
 		spin_lock(&queue->rsp_wr_wait_lock);
@@ -1613,6 +1609,7 @@ static int nvmet_rdma_queue_connect(struct rdma_cm_id *cm_id,
 
 static void nvmet_rdma_queue_established(struct nvmet_rdma_queue *queue)
 {
+	struct nvmet_rdma_rsp *cmd;
 	unsigned long flags;
 
 	spin_lock_irqsave(&queue->state_lock, flags);
@@ -1622,13 +1619,7 @@ static void nvmet_rdma_queue_established(struct nvmet_rdma_queue *queue)
 	}
 	queue->state = NVMET_RDMA_Q_LIVE;
 
-	while (!list_empty(&queue->rsp_wait_list)) {
-		struct nvmet_rdma_rsp *cmd;
-
-		cmd = list_first_entry(&queue->rsp_wait_list,
-					struct nvmet_rdma_rsp, wait_list);
-		list_del(&cmd->wait_list);
-
+	list_for_each_entry_del(cmd, &queue->rsp_wait_list, wait_list) {
 		spin_unlock_irqrestore(&queue->state_lock, flags);
 		nvmet_rdma_handle_command(queue, cmd);
 		spin_lock_irqsave(&queue->state_lock, flags);
@@ -1640,6 +1631,7 @@ static void nvmet_rdma_queue_established(struct nvmet_rdma_queue *queue)
 
 static void __nvmet_rdma_queue_disconnect(struct nvmet_rdma_queue *queue)
 {
+	struct nvmet_rdma_rsp *rsp;
 	bool disconnect = false;
 	unsigned long flags;
 
@@ -1648,15 +1640,8 @@ static void __nvmet_rdma_queue_disconnect(struct nvmet_rdma_queue *queue)
 	spin_lock_irqsave(&queue->state_lock, flags);
 	switch (queue->state) {
 	case NVMET_RDMA_Q_CONNECTING:
-		while (!list_empty(&queue->rsp_wait_list)) {
-			struct nvmet_rdma_rsp *rsp;
-
-			rsp = list_first_entry(&queue->rsp_wait_list,
-					       struct nvmet_rdma_rsp,
-					       wait_list);
-			list_del(&rsp->wait_list);
+		list_for_each_entry_del(rsp, &queue->rsp_wait_list, wait_list)
 			nvmet_rdma_put_rsp(rsp);
-		}
 		fallthrough;
 	case NVMET_RDMA_Q_LIVE:
 		queue->state = NVMET_RDMA_Q_DISCONNECTING;
diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index bed3cefdaf19..8fcf61cf9754 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -2592,11 +2592,7 @@ static void pci_devices_present_work(struct work_struct *work)
 
 	/* Pull this off the queue and process it if it was the last one. */
 	spin_lock_irqsave(&hbus->device_list_lock, flags);
-	while (!list_empty(&hbus->dr_list)) {
-		dr = list_first_entry(&hbus->dr_list, struct hv_dr_state,
-				      list_entry);
-		list_del(&dr->list_entry);
-
+	list_for_each_entry_del(dr, &hbus->dr_list, list_entry) {
 		/* Throw this away if the list still has stuff in it. */
 		if (!list_empty(&hbus->dr_list)) {
 			kfree(dr);
@@ -2658,11 +2654,7 @@ static void pci_devices_present_work(struct work_struct *work)
 	spin_unlock_irqrestore(&hbus->device_list_lock, flags);
 
 	/* Delete everything that should no longer exist. */
-	while (!list_empty(&removed)) {
-		hpdev = list_first_entry(&removed, struct hv_pci_dev,
-					 list_entry);
-		list_del(&hpdev->list_entry);
-
+	list_for_each_entry_del(hpdev, &removed, list_entry) {
 		if (hpdev->pci_slot)
 			pci_destroy_slot(hpdev->pci_slot);
 
diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index 45e416f68e74..47331b516549 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -3442,12 +3442,8 @@ static int rockchip_pinctrl_remove(struct platform_device *pdev)
 		bank = &info->ctrl->pin_banks[i];
 
 		mutex_lock(&bank->deferred_lock);
-		while (!list_empty(&bank->deferred_pins)) {
-			cfg = list_first_entry(&bank->deferred_pins,
-					       struct rockchip_pin_deferred, head);
-			list_del(&cfg->head);
+		list_for_each_entry_del(cfg, &bank->deferred_pins, head)
 			kfree(cfg);
-		}
 		mutex_unlock(&bank->deferred_lock);
 	}
 
diff --git a/drivers/s390/net/lcs.c b/drivers/s390/net/lcs.c
index a1f2acd6fb8f..70f695ccf759 100644
--- a/drivers/s390/net/lcs.c
+++ b/drivers/s390/net/lcs.c
@@ -432,10 +432,7 @@ static void lcs_clear_multicast_list(struct lcs_card *card)
 	/* Free multicast list. */
 	LCS_DBF_TEXT(3, setup, "clmclist");
 	spin_lock_irqsave(&card->ipm_lock, flags);
-	while (!list_empty(&card->ipm_list)){
-		ipm = list_entry(card->ipm_list.next,
-				 struct lcs_ipm_list, list);
-		list_del(&ipm->list);
+	list_for_each_entry_del(ipm, &card->ipm_list, list) {
 		if (ipm->ipm_state != LCS_IPM_STATE_SET_REQUIRED){
 			spin_unlock_irqrestore(&card->ipm_lock, flags);
 			lcs_send_delipm(card, ipm);
diff --git a/drivers/scsi/aacraid/commctrl.c b/drivers/scsi/aacraid/commctrl.c
index e7cc927ed952..93c85582e4da 100644
--- a/drivers/scsi/aacraid/commctrl.c
+++ b/drivers/scsi/aacraid/commctrl.c
@@ -359,14 +359,10 @@ int aac_close_fib_context(struct aac_dev * dev, struct aac_fib_context * fibctx)
 	/*
 	 *	First free any FIBs that have not been consumed.
 	 */
-	while (!list_empty(&fibctx->fib_list)) {
-		struct list_head * entry;
+	list_for_each_entry_del(fib, &fibctx->fib_list, fiblink) {
 		/*
 		 *	Pull the next fib from the fibs
 		 */
-		entry = fibctx->fib_list.next;
-		list_del(entry);
-		fib = list_entry(entry, struct fib, fiblink);
 		fibctx->count--;
 		/*
 		 *	Free the space occupied by this copy of the fib.
diff --git a/drivers/scsi/bnx2i/bnx2i_init.c b/drivers/scsi/bnx2i/bnx2i_init.c
index 872ad37e2a6e..4155f6710e65 100644
--- a/drivers/scsi/bnx2i/bnx2i_init.c
+++ b/drivers/scsi/bnx2i/bnx2i_init.c
@@ -525,9 +525,7 @@ static void __exit bnx2i_mod_exit(void)
 	struct bnx2i_hba *hba;
 
 	mutex_lock(&bnx2i_dev_lock);
-	while (!list_empty(&adapter_list)) {
-		hba = list_entry(adapter_list.next, struct bnx2i_hba, link);
-		list_del(&hba->link);
+	list_for_each_entry_del(hba, &adapter_list, link) {
 		adapter_count--;
 
 		if (test_bit(BNX2I_CNIC_REGISTERED, &hba->reg_with_cnic)) {
diff --git a/drivers/scsi/csiostor/csio_mb.c b/drivers/scsi/csiostor/csio_mb.c
index 94810b19e747..a6fac1e4574d 100644
--- a/drivers/scsi/csiostor/csio_mb.c
+++ b/drivers/scsi/csiostor/csio_mb.c
@@ -1357,10 +1357,7 @@ csio_mb_completions(struct csio_hw *hw, struct list_head *cbfn_q)
 	struct csio_mbm *mbm = &hw->mbm;
 	enum fw_retval rv;
 
-	while (!list_empty(cbfn_q)) {
-		mbp = list_first_entry(cbfn_q, struct csio_mb, list);
-		list_del_init(&mbp->list);
-
+	list_for_each_entry_del_init(mbp, cbfn_q, list) {
 		rv = csio_mb_fw_retval(mbp);
 		if ((rv != FW_SUCCESS) && (rv != FW_HOSTERROR))
 			CSIO_INC_STATS(mbm, n_err);
diff --git a/drivers/scsi/csiostor/csio_scsi.c b/drivers/scsi/csiostor/csio_scsi.c
index 05e1a63e00c3..c96f8afabf34 100644
--- a/drivers/scsi/csiostor/csio_scsi.c
+++ b/drivers/scsi/csiostor/csio_scsi.c
@@ -2417,6 +2417,7 @@ csio_scsi_free_ddp_bufs(struct csio_scsim *scm, struct csio_hw *hw)
 int
 csio_scsim_init(struct csio_scsim *scm, struct csio_hw *hw)
 {
+	struct csio_sm *tmp;
 	int i;
 	struct csio_ioreq *ioreq;
 	struct csio_dma_buf *dma_buf;
@@ -2477,12 +2478,7 @@ csio_scsim_init(struct csio_scsim *scm, struct csio_hw *hw)
 	 * Free up existing allocations, since an error
 	 * from here means we are returning for good
 	 */
-	while (!list_empty(&scm->ioreq_freelist)) {
-		struct csio_sm *tmp;
-
-		tmp = list_first_entry(&scm->ioreq_freelist,
-				       struct csio_sm, sm_list);
-		list_del_init(&tmp->sm_list);
+	list_for_each_entry_del_init(tmp, &scm->ioreq_freelist, sm_list) {
 		ioreq = (struct csio_ioreq *)tmp;
 
 		dma_buf = &ioreq->dma_buf;
@@ -2505,15 +2501,11 @@ csio_scsim_init(struct csio_scsim *scm, struct csio_hw *hw)
 void
 csio_scsim_exit(struct csio_scsim *scm)
 {
+	struct csio_sm *tmp;
 	struct csio_ioreq *ioreq;
 	struct csio_dma_buf *dma_buf;
 
-	while (!list_empty(&scm->ioreq_freelist)) {
-		struct csio_sm *tmp;
-
-		tmp = list_first_entry(&scm->ioreq_freelist,
-				       struct csio_sm, sm_list);
-		list_del_init(&tmp->sm_list);
+	list_for_each_entry_del_init(tmp, &scm->ioreq_freelist, sm_list) {
 		ioreq = (struct csio_ioreq *)tmp;
 
 		dma_buf = &ioreq->dma_buf;
diff --git a/drivers/scsi/ibmvscsi/ibmvscsi.c b/drivers/scsi/ibmvscsi/ibmvscsi.c
index 59599299615d..624197378797 100644
--- a/drivers/scsi/ibmvscsi/ibmvscsi.c
+++ b/drivers/scsi/ibmvscsi/ibmvscsi.c
@@ -786,9 +786,7 @@ static void purge_requests(struct ibmvscsi_host_data *hostdata, int error_code)
 	unsigned long flags;
 
 	spin_lock_irqsave(hostdata->host->host_lock, flags);
-	while (!list_empty(&hostdata->sent)) {
-		evt = list_first_entry(&hostdata->sent, struct srp_event_struct, list);
-		list_del(&evt->list);
+	list_for_each_entry_del(evt, &hostdata->sent, list) {
 		del_timer(&evt->timer);
 
 		spin_unlock_irqrestore(hostdata->host->host_lock, flags);
diff --git a/drivers/scsi/libiscsi.c b/drivers/scsi/libiscsi.c
index 0fda8905eabd..783e454fe351 100644
--- a/drivers/scsi/libiscsi.c
+++ b/drivers/scsi/libiscsi.c
@@ -1620,10 +1620,7 @@ static int iscsi_data_xmit(struct iscsi_conn *conn)
 	 * overflow us with nop-ins
 	 */
 check_mgmt:
-	while (!list_empty(&conn->mgmtqueue)) {
-		task = list_entry(conn->mgmtqueue.next, struct iscsi_task,
-				  running);
-		list_del_init(&task->running);
+	list_for_each_entry_del_init(task, &conn->mgmtqueue, running) {
 		if (iscsi_prep_mgmt_task(conn, task)) {
 			/* regular RX path uses back_lock */
 			spin_lock_bh(&conn->session->back_lock);
@@ -1659,10 +1656,7 @@ static int iscsi_data_xmit(struct iscsi_conn *conn)
 	}
 
 	/* process pending command queue */
-	while (!list_empty(&conn->cmdqueue)) {
-		task = list_entry(conn->cmdqueue.next, struct iscsi_task,
-				  running);
-		list_del_init(&task->running);
+	list_for_each_entry_del_init(task, &conn->cmdqueue, running) {
 		if (conn->session->state == ISCSI_STATE_LOGGING_OUT) {
 			fail_scsi_task(task, DID_IMM_RETRY);
 			continue;
diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
index 9047cfcd1072..b038e9887ada 100644
--- a/drivers/scsi/libsas/sas_scsi_host.c
+++ b/drivers/scsi/libsas/sas_scsi_host.c
@@ -657,15 +657,13 @@ static void sas_eh_handle_resets(struct Scsi_Host *shost)
 {
 	struct sas_ha_struct *ha = SHOST_TO_SAS_HA(shost);
 	struct sas_internal *i = to_sas_internal(shost->transportt);
+	struct ssp_device *ssp;
 
 	/* handle directed resets to sas devices */
 	spin_lock_irq(&ha->lock);
-	while (!list_empty(&ha->eh_dev_q)) {
+	list_for_each_entry_del_init(ssp, &ha->eh_dev_q, eh_list_node) {
 		struct domain_device *dev;
-		struct ssp_device *ssp;
 
-		ssp = list_entry(ha->eh_dev_q.next, typeof(*ssp), eh_list_node);
-		list_del_init(&ssp->eh_list_node);
 		dev = container_of(ssp, typeof(*dev), ssp_dev);
 		kref_get(&dev->kref);
 		WARN_ONCE(dev_is_sata(dev), "ssp reset to ata device?\n");
diff --git a/drivers/scsi/lpfc/lpfc_bsg.c b/drivers/scsi/lpfc/lpfc_bsg.c
index 595dca92e8db..4ad6700304e1 100644
--- a/drivers/scsi/lpfc/lpfc_bsg.c
+++ b/drivers/scsi/lpfc/lpfc_bsg.c
@@ -782,16 +782,12 @@ lpfc_bsg_event_free(struct kref *kref)
 
 	list_del(&evt->node);
 
-	while (!list_empty(&evt->events_to_get)) {
-		ed = list_entry(evt->events_to_get.next, typeof(*ed), node);
-		list_del(&ed->node);
+	list_for_each_entry_del(ed, &evt->events_to_get, node) {
 		kfree(ed->data);
 		kfree(ed);
 	}
 
-	while (!list_empty(&evt->events_to_see)) {
-		ed = list_entry(evt->events_to_see.next, typeof(*ed), node);
-		list_del(&ed->node);
+	list_for_each_entry_del(ed, &evt->events_to_see, node) {
 		kfree(ed->data);
 		kfree(ed);
 	}
diff --git a/drivers/scsi/lpfc/lpfc_mem.c b/drivers/scsi/lpfc/lpfc_mem.c
index 89cbeba06aea..ca717c0d10e8 100644
--- a/drivers/scsi/lpfc/lpfc_mem.c
+++ b/drivers/scsi/lpfc/lpfc_mem.c
@@ -259,13 +259,9 @@ lpfc_mem_free(struct lpfc_hba *phba)
 	/* Free Device Data memory pool */
 	if (phba->device_data_mem_pool) {
 		/* Ensure all objects have been returned to the pool */
-		while (!list_empty(&phba->luns)) {
-			device_data = list_first_entry(&phba->luns,
-						       struct lpfc_device_data,
-						       listentry);
-			list_del(&device_data->listentry);
+		list_for_each_entry_del(device_data, &phba->luns, listentry)
 			mempool_free(device_data, phba->device_data_mem_pool);
-		}
+
 		mempool_destroy(phba->device_data_mem_pool);
 	}
 	phba->device_data_mem_pool = NULL;
diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index e1aa667dae66..2f31e5fceee8 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -2780,10 +2780,7 @@ static int megasas_wait_for_outstanding(struct megasas_instance *instance)
 		}
 
 		reset_index = 0;
-		while (!list_empty(&clist_local)) {
-			reset_cmd = list_entry((&clist_local)->next,
-						struct megasas_cmd, list);
-			list_del_init(&reset_cmd->list);
+		list_for_each_entry_del_init(reset_cmd, &clist_local, list) {
 			if (reset_cmd->scmd) {
 				reset_cmd->scmd->result = DID_REQUEUE << 16;
 				dev_notice(&instance->pdev->dev, "%d:%p reset [%02x]\n",
@@ -3822,11 +3819,7 @@ megasas_issue_pending_cmds_again(struct megasas_instance *instance)
 	list_splice_init(&instance->internal_reset_pending_q, &clist_local);
 	spin_unlock_irqrestore(&instance->hba_lock, flags);
 
-	while (!list_empty(&clist_local)) {
-		cmd = list_entry((&clist_local)->next,
-					struct megasas_cmd, list);
-		list_del_init(&cmd->list);
-
+	list_for_each_entry_del_init(cmd, &clist_local, list) {
 		if (cmd->sync_cmd || cmd->scmd) {
 			dev_notice(&instance->pdev->dev, "command %p, %p:%d"
 				"detected to be pending while HBA reset\n",
diff --git a/drivers/scsi/mpi3mr/mpi3mr_os.c b/drivers/scsi/mpi3mr/mpi3mr_os.c
index 89ba015c5d7e..85e5a5d7779f 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_os.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_os.c
@@ -2096,17 +2096,12 @@ void mpi3mr_flush_delayed_cmd_lists(struct mpi3mr_ioc *mrioc)
 	struct delayed_evt_ack_node *_evtack_node;
 
 	dprint_reset(mrioc, "flushing delayed dev_remove_hs commands\n");
-	while (!list_empty(&mrioc->delayed_rmhs_list)) {
-		_rmhs_node = list_entry(mrioc->delayed_rmhs_list.next,
-		    struct delayed_dev_rmhs_node, list);
-		list_del(&_rmhs_node->list);
+	list_for_each_entry_del(_rmhs_node, &mrioc->delayed_rmhs_list, list)
 		kfree(_rmhs_node);
-	}
+
 	dprint_reset(mrioc, "flushing delayed event ack commands\n");
-	while (!list_empty(&mrioc->delayed_evtack_cmds_list)) {
-		_evtack_node = list_entry(mrioc->delayed_evtack_cmds_list.next,
-		    struct delayed_evt_ack_node, list);
-		list_del(&_evtack_node->list);
+	list_for_each_entry_del(_evtack_node,
+				&mrioc->delayed_evtack_cmds_list, list) {
 		kfree(_evtack_node);
 	}
 }
diff --git a/drivers/scsi/mvumi.c b/drivers/scsi/mvumi.c
index d9d366ec17dc..6066ce52bfcd 100644
--- a/drivers/scsi/mvumi.c
+++ b/drivers/scsi/mvumi.c
@@ -347,10 +347,7 @@ static void mvumi_free_cmds(struct mvumi_hba *mhba)
 {
 	struct mvumi_cmd *cmd;
 
-	while (!list_empty(&mhba->cmd_pool)) {
-		cmd = list_first_entry(&mhba->cmd_pool, struct mvumi_cmd,
-							queue_pointer);
-		list_del(&cmd->queue_pointer);
+	list_for_each_entry_del(cmd, &mhba->cmd_pool, queue_pointer) {
 		if (!(mhba->hba_capability & HS_CAPABILITY_SUPPORT_DYN_SRC))
 			kfree(cmd->frame);
 		kfree(cmd);
@@ -388,10 +385,7 @@ static int mvumi_alloc_cmds(struct mvumi_hba *mhba)
 err_exit:
 	dev_err(&mhba->pdev->dev,
 			"failed to allocate memory for cmd[0x%x].\n", i);
-	while (!list_empty(&mhba->cmd_pool)) {
-		cmd = list_first_entry(&mhba->cmd_pool, struct mvumi_cmd,
-						queue_pointer);
-		list_del(&cmd->queue_pointer);
+	list_for_each_entry_del(cmd, &mhba->cmd_pool, queue_pointer) {
 		if (!(mhba->hba_capability & HS_CAPABILITY_SUPPORT_DYN_SRC))
 			kfree(cmd->frame);
 		kfree(cmd);
@@ -1767,10 +1761,7 @@ static void mvumi_handle_clob(struct mvumi_hba *mhba)
 	struct mvumi_cmd *cmd;
 	struct mvumi_ob_data *pool;
 
-	while (!list_empty(&mhba->free_ob_list)) {
-		pool = list_first_entry(&mhba->free_ob_list,
-						struct mvumi_ob_data, list);
-		list_del_init(&pool->list);
+	list_for_each_entry_del_init(pool, &mhba->free_ob_list, list) {
 		list_add_tail(&pool->list, &mhba->ob_data_list);
 
 		ob_frame = (struct mvumi_rsp_frame *) &pool->data[0];
diff --git a/drivers/scsi/qla1280.c b/drivers/scsi/qla1280.c
index 6e5e89aaa283..be98b5b066cf 100644
--- a/drivers/scsi/qla1280.c
+++ b/drivers/scsi/qla1280.c
@@ -1238,11 +1238,7 @@ qla1280_done(struct scsi_qla_host *ha)
 
 	done_q = &ha->done_q;
 
-	while (!list_empty(done_q)) {
-		sp = list_entry(done_q->next, struct srb, list);
-
-		list_del(&sp->list);
-	
+	list_for_each_entry_del(sp, done_q, list) {
 		cmd = sp->cmd;
 		bus = SCSI_BUS_32(cmd);
 		target = SCSI_TCN_32(cmd);
diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
index 2ef2dbac0db2..5a58356d58d4 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -6320,6 +6320,7 @@ static void qlt_abort_work(struct qla_tgt *tgt,
 
 static void qlt_sess_work_fn(struct work_struct *work)
 {
+	struct qla_tgt_sess_work_param *prm;
 	struct qla_tgt *tgt = container_of(work, struct qla_tgt, sess_work);
 	struct scsi_qla_host *vha = tgt->vha;
 	unsigned long flags;
@@ -6327,17 +6328,12 @@ static void qlt_sess_work_fn(struct work_struct *work)
 	ql_dbg(ql_dbg_tgt_mgt, vha, 0xf000, "Sess work (tgt %p)", tgt);
 
 	spin_lock_irqsave(&tgt->sess_work_lock, flags);
-	while (!list_empty(&tgt->sess_works_list)) {
-		struct qla_tgt_sess_work_param *prm = list_entry(
-		    tgt->sess_works_list.next, typeof(*prm),
-		    sess_works_list_entry);
-
-		/*
-		 * This work can be scheduled on several CPUs at time, so we
-		 * must delete the entry to eliminate double processing
-		 */
-		list_del(&prm->sess_works_list_entry);
-
+	/*
+	 * This work can be scheduled on several CPUs at time, so we
+	 * must delete the entry to eliminate double processing
+	 */
+	list_for_each_entry_del(prm, &tgt->sess_works_list,
+				sess_works_list_entry) {
 		spin_unlock_irqrestore(&tgt->sess_work_lock, flags);
 
 		switch (prm->type) {
diff --git a/drivers/staging/media/atomisp/pci/atomisp_cmd.c b/drivers/staging/media/atomisp/pci/atomisp_cmd.c
index 0803b296e9ac..919ca5fae425 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_cmd.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_cmd.c
@@ -637,10 +637,7 @@ void atomisp_flush_params_queue(struct atomisp_video_pipe *pipe)
 {
 	struct atomisp_css_params_with_list *param;
 
-	while (!list_empty(&pipe->per_frame_params)) {
-		param = list_entry(pipe->per_frame_params.next,
-				   struct atomisp_css_params_with_list, list);
-		list_del(&param->list);
+	list_for_each_entry_del(param, &pipe->per_frame_params, list) {
 		atomisp_free_css_parameters(&param->params);
 		kvfree(param);
 	}
diff --git a/drivers/staging/media/omap4iss/iss_video.c b/drivers/staging/media/omap4iss/iss_video.c
index 22fa4d6cae10..158b8421fb82 100644
--- a/drivers/staging/media/omap4iss/iss_video.c
+++ b/drivers/staging/media/omap4iss/iss_video.c
@@ -495,18 +495,13 @@ struct iss_buffer *omap4iss_video_buffer_next(struct iss_video *video)
  */
 void omap4iss_video_cancel_stream(struct iss_video *video)
 {
+	struct iss_buffer *buf;
 	unsigned long flags;
 
 	spin_lock_irqsave(&video->qlock, flags);
 
-	while (!list_empty(&video->dmaqueue)) {
-		struct iss_buffer *buf;
-
-		buf = list_first_entry(&video->dmaqueue, struct iss_buffer,
-				       list);
-		list_del(&buf->list);
+	list_for_each_entry_del(buf, &video->dmaqueue, list)
 		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);
-	}
 
 	vb2_queue_error(video->queue);
 	video->error = true;
diff --git a/drivers/staging/nvec/nvec.c b/drivers/staging/nvec/nvec.c
index 2823cacde130..1ed84cf8195e 100644
--- a/drivers/staging/nvec/nvec.c
+++ b/drivers/staging/nvec/nvec.c
@@ -442,9 +442,7 @@ static void nvec_dispatch(struct work_struct *work)
 	struct nvec_msg *msg;
 
 	spin_lock_irqsave(&nvec->rx_lock, flags);
-	while (!list_empty(&nvec->rx_data)) {
-		msg = list_first_entry(&nvec->rx_data, struct nvec_msg, node);
-		list_del_init(&msg->node);
+	list_for_each_entry_del_init(msg, &nvec->rx_data, node) {
 		spin_unlock_irqrestore(&nvec->rx_lock, flags);
 
 		if (nvec->sync_write_pending ==
diff --git a/drivers/target/target_core_tmr.c b/drivers/target/target_core_tmr.c
index 4718db628222..bb272ca7606b 100644
--- a/drivers/target/target_core_tmr.c
+++ b/drivers/target/target_core_tmr.c
@@ -338,10 +338,7 @@ static void core_tmr_drain_state_list(
 					   TMR_LUN_RESET_PRO : TMR_LUN_RESET,
 					   &drain_task_list);
 
-	while (!list_empty(&drain_task_list)) {
-		cmd = list_entry(drain_task_list.next, struct se_cmd, state_list);
-		list_del_init(&cmd->state_list);
-
+	list_for_each_entry_del_init(cmd, &drain_task_list, state_list) {
 		target_show_cmd("LUN_RESET: ", cmd);
 		pr_debug("LUN_RESET: ITT[0x%08llx] - %s pr_res_key: 0x%016Lx\n",
 			 cmd->tag, (preempt_and_abort_list) ? "preempt" : "",
diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index df5fb5410b72..bcf70a09388f 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -145,10 +145,7 @@ void optee_shm_arg_cache_uninit(struct optee *optee)
 	struct optee_shm_arg_entry *entry;
 
 	mutex_destroy(&optee->shm_arg_cache.mutex);
-	while (!list_empty(head)) {
-		entry = list_first_entry(head, struct optee_shm_arg_entry,
-					 list_node);
-		list_del(&entry->list_node);
+	list_for_each_entry_del(entry, head, list_node) {
 		if (find_first_bit(entry->map, MAX_ARG_COUNT_PER_ENTRY) !=
 		     MAX_ARG_COUNT_PER_ENTRY) {
 			pr_err("Freeing non-free entry\n");
diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
index 4b7bec74e89f..ef6426eddee9 100644
--- a/drivers/thunderbolt/nhi.c
+++ b/drivers/thunderbolt/nhi.c
@@ -308,13 +308,8 @@ static void ring_work(struct work_struct *work)
 invoke_callback:
 	/* allow callbacks to schedule new work */
 	spin_unlock_irqrestore(&ring->lock, flags);
-	while (!list_empty(&done)) {
-		frame = list_first_entry(&done, typeof(*frame), list);
-		/*
-		 * The callback may reenqueue or delete frame.
-		 * Do not hold on to it.
-		 */
-		list_del_init(&frame->list);
+	/* The callback may reenqueue or delete frame.  Do not hold on to it. */
+	list_for_each_entry_del_init(frame, &done, list) {
 		if (frame->callback)
 			frame->callback(ring, frame, canceled);
 	}
diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index dd0a1ef8cf12..bc311cb6a833 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -1466,6 +1466,7 @@ static void tb_dp_resource_available(struct tb *tb, struct tb_port *port)
 
 static void tb_disconnect_and_release_dp(struct tb *tb)
 {
+	struct tb_port *port;
 	struct tb_cm *tcm = tb_priv(tb);
 	struct tb_tunnel *tunnel, *n;
 
@@ -1478,12 +1479,7 @@ static void tb_disconnect_and_release_dp(struct tb *tb)
 			tb_deactivate_and_free_tunnel(tunnel);
 	}
 
-	while (!list_empty(&tcm->dp_resources)) {
-		struct tb_port *port;
-
-		port = list_first_entry(&tcm->dp_resources,
-					struct tb_port, list);
-		list_del_init(&port->list);
+	list_for_each_entry_del_init(port, &tcm->dp_resources, list) {
 	}
 }
 
diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 12b6dfeaf658..0fba3ac7de73 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -1666,6 +1666,7 @@ static void __usb_hcd_giveback_urb(struct urb *urb)
 
 static void usb_giveback_urb_bh(struct tasklet_struct *t)
 {
+	struct urb *urb;
 	struct giveback_urb_bh *bh = from_tasklet(bh, t, bh);
 	struct list_head local_list;
 
@@ -1674,11 +1675,7 @@ static void usb_giveback_urb_bh(struct tasklet_struct *t)
 	list_replace_init(&bh->head, &local_list);
 	spin_unlock_irq(&bh->lock);
 
-	while (!list_empty(&local_list)) {
-		struct urb *urb;
-
-		urb = list_entry(local_list.next, struct urb, urb_list);
-		list_del_init(&urb->urb_list);
+	list_for_each_entry_del_init(urb, &local_list, urb_list) {
 		bh->completing_ep = urb->ep;
 		__usb_hcd_giveback_urb(urb);
 		bh->completing_ep = NULL;
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 0ff47eeffb49..d1e94b7b461e 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -816,22 +816,17 @@ hub_clear_tt_buffer(struct usb_device *hdev, u16 devinfo, u16 tt)
  */
 static void hub_tt_work(struct work_struct *work)
 {
+	struct usb_tt_clear	*clear;
 	struct usb_hub		*hub =
 		container_of(work, struct usb_hub, tt.clear_work);
 	unsigned long		flags;
 
 	spin_lock_irqsave(&hub->tt.lock, flags);
-	while (!list_empty(&hub->tt.clear_list)) {
-		struct list_head	*next;
-		struct usb_tt_clear	*clear;
+	list_for_each_entry_del(clear, &hub->tt.clear_list, clear_list) {
 		struct usb_device	*hdev = hub->hdev;
 		const struct hc_driver	*drv;
 		int			status;
 
-		next = hub->tt.clear_list.next;
-		clear = list_entry(next, struct usb_tt_clear, clear_list);
-		list_del(&clear->clear_list);
-
 		/* drop lock so HCD can concurrently report other TT errors */
 		spin_unlock_irqrestore(&hub->tt.lock, flags);
 		status = hub_clear_tt_buffer(hdev, clear->devinfo, clear->tt);
diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index 0ace45b66a31..e894c798a273 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -1124,12 +1124,9 @@ int usb_add_config(struct usb_composite_dev *cdev,
 		status = usb_gadget_check_config(cdev->gadget);
 
 	if (status < 0) {
-		while (!list_empty(&config->functions)) {
-			struct usb_function		*f;
+		struct usb_function *f;
 
-			f = list_first_entry(&config->functions,
-					struct usb_function, list);
-			list_del(&f->list);
+		list_for_each_entry_del(f, &config->functions, list) {
 			if (f->unbind) {
 				DBG(cdev, "unbind function '%s'/%p\n",
 					f->name, f);
diff --git a/drivers/usb/gadget/function/f_printer.c b/drivers/usb/gadget/function/f_printer.c
index 076dd4c1be96..e2dead3691c1 100644
--- a/drivers/usb/gadget/function/f_printer.c
+++ b/drivers/usb/gadget/function/f_printer.c
@@ -1149,18 +1149,12 @@ static int printer_func_bind(struct usb_configuration *c,
 	device_destroy(&usb_gadget_class, devt);
 
 fail_rx_reqs:
-	while (!list_empty(&dev->rx_reqs)) {
-		req = container_of(dev->rx_reqs.next, struct usb_request, list);
-		list_del(&req->list);
+	list_for_each_entry_del(req, &dev->rx_reqs, list)
 		printer_req_free(dev->out_ep, req);
-	}
 
 fail_tx_reqs:
-	while (!list_empty(&dev->tx_reqs)) {
-		req = container_of(dev->tx_reqs.next, struct usb_request, list);
-		list_del(&req->list);
+	list_for_each_entry_del(req, &dev->tx_reqs, list)
 		printer_req_free(dev->in_ep, req);
-	}
 
 	usb_free_all_descriptors(f);
 	return ret;
@@ -1423,29 +1417,17 @@ static void printer_func_unbind(struct usb_configuration *c,
 	WARN_ON(!list_empty(&dev->rx_reqs_active));
 
 	/* Free all memory for this driver. */
-	while (!list_empty(&dev->tx_reqs)) {
-		req = container_of(dev->tx_reqs.next, struct usb_request,
-				list);
-		list_del(&req->list);
+	list_for_each_entry_del(req, &dev->tx_reqs, list)
 		printer_req_free(dev->in_ep, req);
-	}
 
 	if (dev->current_rx_req != NULL)
 		printer_req_free(dev->out_ep, dev->current_rx_req);
 
-	while (!list_empty(&dev->rx_reqs)) {
-		req = container_of(dev->rx_reqs.next,
-				struct usb_request, list);
-		list_del(&req->list);
+	list_for_each_entry_del(req, &dev->rx_reqs, list)
 		printer_req_free(dev->out_ep, req);
-	}
 
-	while (!list_empty(&dev->rx_buffers)) {
-		req = container_of(dev->rx_buffers.next,
-				struct usb_request, list);
-		list_del(&req->list);
+	list_for_each_entry_del(req, &dev->rx_buffers, list)
 		printer_req_free(dev->out_ep, req);
-	}
 	usb_free_all_descriptors(f);
 }
 
diff --git a/drivers/usb/gadget/function/u_ether.c b/drivers/usb/gadget/function/u_ether.c
index 4bb0553da658..a229ef44cec7 100644
--- a/drivers/usb/gadget/function/u_ether.c
+++ b/drivers/usb/gadget/function/u_ether.c
@@ -375,9 +375,7 @@ static void rx_fill(struct eth_dev *dev, gfp_t gfp_flags)
 
 	/* fill unused rxq slots with some skb */
 	spin_lock_irqsave(&dev->req_lock, flags);
-	while (!list_empty(&dev->rx_reqs)) {
-		req = list_first_entry(&dev->rx_reqs, struct usb_request, list);
-		list_del_init(&req->list);
+	list_for_each_entry_del_init(req, &dev->rx_reqs, list) {
 		spin_unlock_irqrestore(&dev->req_lock, flags);
 
 		if (rx_submit(dev, req, gfp_flags) < 0) {
@@ -1209,10 +1207,7 @@ void gether_disconnect(struct gether *link)
 	 */
 	usb_ep_disable(link->in_ep);
 	spin_lock(&dev->req_lock);
-	while (!list_empty(&dev->tx_reqs)) {
-		req = list_first_entry(&dev->tx_reqs, struct usb_request, list);
-		list_del(&req->list);
-
+	list_for_each_entry_del(req, &dev->tx_reqs, list) {
 		spin_unlock(&dev->req_lock);
 		usb_ep_free_request(link->in_ep, req);
 		spin_lock(&dev->req_lock);
@@ -1222,10 +1217,7 @@ void gether_disconnect(struct gether *link)
 
 	usb_ep_disable(link->out_ep);
 	spin_lock(&dev->req_lock);
-	while (!list_empty(&dev->rx_reqs)) {
-		req = list_first_entry(&dev->rx_reqs, struct usb_request, list);
-		list_del(&req->list);
-
+	list_for_each_entry_del(req, &dev->rx_reqs, list) {
 		spin_unlock(&dev->req_lock);
 		usb_ep_free_request(link->out_ep, req);
 		spin_lock(&dev->req_lock);
diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
index a92eb6d90976..d06772183eb7 100644
--- a/drivers/usb/gadget/function/u_serial.c
+++ b/drivers/usb/gadget/function/u_serial.c
@@ -494,9 +494,7 @@ static void gs_free_requests(struct usb_ep *ep, struct list_head *head,
 {
 	struct usb_request	*req;
 
-	while (!list_empty(head)) {
-		req = list_entry(head->next, struct usb_request, list);
-		list_del(&req->list);
+	list_for_each_entry_del(req, head, list) {
 		gs_free_req(ep, req);
 		if (allocated)
 			(*allocated)--;
diff --git a/drivers/usb/gadget/function/uvc_queue.c b/drivers/usb/gadget/function/uvc_queue.c
index 0aa3d7e1f3cc..616368964d79 100644
--- a/drivers/usb/gadget/function/uvc_queue.c
+++ b/drivers/usb/gadget/function/uvc_queue.c
@@ -254,10 +254,7 @@ void uvcg_queue_cancel(struct uvc_video_queue *queue, int disconnect)
 	unsigned long flags;
 
 	spin_lock_irqsave(&queue->irqlock, flags);
-	while (!list_empty(&queue->irqqueue)) {
-		buf = list_first_entry(&queue->irqqueue, struct uvc_buffer,
-				       queue);
-		list_del(&buf->queue);
+	list_for_each_entry_del(buf, &queue->irqqueue, queue) {
 		buf->state = UVC_BUF_STATE_ERROR;
 		vb2_buffer_done(&buf->buf.vb2_buf, VB2_BUF_STATE_ERROR);
 	}
diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
index ce9e31f3d26b..62bfba1cdff5 100644
--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -1540,18 +1540,18 @@ gadgetfs_setup (struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
 
 static void destroy_ep_files (struct dev_data *dev)
 {
+	struct ep_data	*ep;
+
 	DBG (dev, "%s %d\n", __func__, dev->state);
 
 	/* dev->state must prevent interference */
 	spin_lock_irq (&dev->lock);
-	while (!list_empty(&dev->epfiles)) {
-		struct ep_data	*ep;
+
+	/* break link to FS */
+	list_for_each_entry_del_init(ep, &dev->epfiles, epfiles) {
 		struct inode	*parent;
 		struct dentry	*dentry;
 
-		/* break link to FS */
-		ep = list_first_entry (&dev->epfiles, struct ep_data, epfiles);
-		list_del_init (&ep->epfiles);
 		spin_unlock_irq (&dev->lock);
 
 		dentry = ep->dentry;
diff --git a/drivers/usb/gadget/udc/dummy_hcd.c b/drivers/usb/gadget/udc/dummy_hcd.c
index 0953e1b5c030..806e3399d20b 100644
--- a/drivers/usb/gadget/udc/dummy_hcd.c
+++ b/drivers/usb/gadget/udc/dummy_hcd.c
@@ -328,11 +328,9 @@ static inline struct dummy *gadget_dev_to_dummy(struct device *dev)
 /* called with spinlock held */
 static void nuke(struct dummy *dum, struct dummy_ep *ep)
 {
-	while (!list_empty(&ep->queue)) {
-		struct dummy_request	*req;
+	struct dummy_request *req;
 
-		req = list_entry(ep->queue.next, struct dummy_request, queue);
-		list_del_init(&req->queue);
+	list_for_each_entry_del_init(req, &ep->queue, queue) {
 		req->req.status = -ESHUTDOWN;
 
 		spin_unlock(&dum->lock);
diff --git a/drivers/usb/host/ehci-q.c b/drivers/usb/host/ehci-q.c
index 666f5c4db25a..922679a63d3d 100644
--- a/drivers/usb/host/ehci-q.c
+++ b/drivers/usb/host/ehci-q.c
@@ -1402,11 +1402,7 @@ static void end_unlink_async(struct ehci_hcd *ehci)
 
 	/* Process the idle QHs */
 	ehci->async_unlinking = true;
-	while (!list_empty(&ehci->async_idle)) {
-		qh = list_first_entry(&ehci->async_idle, struct ehci_qh,
-				unlink_node);
-		list_del(&qh->unlink_node);
-
+	list_for_each_entry_del(qh, &ehci->async_idle, unlink_node) {
 		qh->qh_state = QH_STATE_IDLE;
 		qh->qh_next.qh = NULL;
 
diff --git a/drivers/usb/host/xhci-dbgtty.c b/drivers/usb/host/xhci-dbgtty.c
index b74e98e94393..14c93c8b7d48 100644
--- a/drivers/usb/host/xhci-dbgtty.c
+++ b/drivers/usb/host/xhci-dbgtty.c
@@ -171,11 +171,8 @@ xhci_dbc_free_requests(struct list_head *head)
 {
 	struct dbc_request	*req;
 
-	while (!list_empty(head)) {
-		req = list_entry(head->next, struct dbc_request, list_pool);
-		list_del(&req->list_pool);
+	list_for_each_entry_del(req, head, list_pool)
 		xhci_dbc_free_req(req);
-	}
 }
 
 static int dbc_tty_install(struct tty_driver *driver, struct tty_struct *tty)
diff --git a/drivers/usb/mon/mon_main.c b/drivers/usb/mon/mon_main.c
index 9812d102a005..a8cc3a407378 100644
--- a/drivers/usb/mon/mon_main.c
+++ b/drivers/usb/mon/mon_main.c
@@ -384,18 +384,13 @@ static int __init mon_init(void)
 static void __exit mon_exit(void)
 {
 	struct mon_bus *mbus;
-	struct list_head *p;
 
 	usb_unregister_notify(&mon_nb);
 	usb_mon_deregister();
 
 	mutex_lock(&mon_lock);
 
-	while (!list_empty(&mon_buses)) {
-		p = mon_buses.next;
-		mbus = list_entry(p, struct mon_bus, bus_link);
-		list_del(p);
-
+	list_for_each_entry_del(mbus, &mon_buses, bus_link) {
 		if (mbus->text_inited)
 			mon_text_del(mbus);
 		if (mbus->bin_inited)
diff --git a/drivers/usb/mon/mon_text.c b/drivers/usb/mon/mon_text.c
index 39cb14164652..e814d9a29f2b 100644
--- a/drivers/usb/mon/mon_text.c
+++ b/drivers/usb/mon/mon_text.c
@@ -644,7 +644,6 @@ static int mon_text_release(struct inode *inode, struct file *file)
 	struct mon_reader_text *rp = file->private_data;
 	struct mon_bus *mbus;
 	/* unsigned long flags; */
-	struct list_head *p;
 	struct mon_event_text *ep;
 
 	mutex_lock(&mon_lock);
@@ -665,10 +664,7 @@ static int mon_text_release(struct inode *inode, struct file *file)
 	 * So, we better not touch mbus.
 	 */
 	/* spin_lock_irqsave(&mbus->lock, flags); */
-	while (!list_empty(&rp->e_list)) {
-		p = rp->e_list.next;
-		ep = list_entry(p, struct mon_event_text, e_link);
-		list_del(p);
+	list_for_each_entry_del(ep, &rp->e_list, e_link) {
 		--rp->nevents;
 		kmem_cache_free(rp->e_slab, ep);
 	}
diff --git a/drivers/usb/usbip/vudc_dev.c b/drivers/usb/usbip/vudc_dev.c
index 44b04c54c086..4e2520ef48cc 100644
--- a/drivers/usb/usbip/vudc_dev.c
+++ b/drivers/usb/usbip/vudc_dev.c
@@ -74,10 +74,7 @@ static void nuke(struct vudc *udc, struct vep *ep)
 {
 	struct vrequest	*req;
 
-	while (!list_empty(&ep->req_queue)) {
-		req = list_first_entry(&ep->req_queue, struct vrequest,
-				       req_entry);
-		list_del_init(&req->req_entry);
+	list_for_each_entry_del_init(req, &ep->req_queue, req_entry) {
 		req->req.status = -ESHUTDOWN;
 
 		spin_unlock(&udc->lock);
diff --git a/drivers/usb/usbip/vudc_tx.c b/drivers/usb/usbip/vudc_tx.c
index 3ccb17c3e840..3137971d19f3 100644
--- a/drivers/usb/usbip/vudc_tx.c
+++ b/drivers/usb/usbip/vudc_tx.c
@@ -189,10 +189,7 @@ static int v_send_ret(struct vudc *udc)
 	int ret = 0;
 
 	spin_lock_irqsave(&udc->lock_tx, flags);
-	while (!list_empty(&udc->tx_queue)) {
-		txi = list_first_entry(&udc->tx_queue, struct tx_item,
-				       tx_entry);
-		list_del(&txi->tx_entry);
+	list_for_each_entry_del(txi, &udc->tx_queue, tx_entry) {
 		spin_unlock_irqrestore(&udc->lock_tx, flags);
 
 		switch (txi->type) {
diff --git a/drivers/video/fbdev/udlfb.c b/drivers/video/fbdev/udlfb.c
index b70762ead13c..d7c7ffe70c48 100644
--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -998,6 +998,7 @@ static int dlfb_ops_open(struct fb_info *info, int user)
 
 static void dlfb_ops_destroy(struct fb_info *info)
 {
+	struct dlfb_deferred_free *d;
 	struct dlfb_data *dlfb = info->par;
 
 	cancel_work_sync(&dlfb->damage_work);
@@ -1012,9 +1013,7 @@ static void dlfb_ops_destroy(struct fb_info *info)
 
 	fb_destroy_modelist(&info->modelist);
 
-	while (!list_empty(&dlfb->deferred_free)) {
-		struct dlfb_deferred_free *d = list_entry(dlfb->deferred_free.next, struct dlfb_deferred_free, list);
-		list_del(&d->list);
+	list_for_each_entry_del(d, &dlfb->deferred_free, list) {
 		vfree(d->mem);
 		kfree(d);
 	}
diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
index 5b55ccae06d4..59e30eac3264 100644
--- a/drivers/watchdog/watchdog_core.c
+++ b/drivers/watchdog/watchdog_core.c
@@ -444,16 +444,12 @@ EXPORT_SYMBOL_GPL(devm_watchdog_register_device);
 
 static int __init watchdog_deferred_registration(void)
 {
+	struct watchdog_device *wdd;
+
 	mutex_lock(&wtd_deferred_reg_mutex);
 	wtd_deferred_reg_done = true;
-	while (!list_empty(&wtd_deferred_reg_list)) {
-		struct watchdog_device *wdd;
-
-		wdd = list_first_entry(&wtd_deferred_reg_list,
-				       struct watchdog_device, deferred);
-		list_del(&wdd->deferred);
+	list_for_each_entry_del(wdd, &wtd_deferred_reg_list, deferred)
 		__watchdog_register_device(wdd);
-	}
 	mutex_unlock(&wtd_deferred_reg_mutex);
 	return 0;
 }
diff --git a/drivers/xen/gntalloc.c b/drivers/xen/gntalloc.c
index 26ffb8755ffb..46c114546af6 100644
--- a/drivers/xen/gntalloc.c
+++ b/drivers/xen/gntalloc.c
@@ -252,10 +252,7 @@ static int gntalloc_release(struct inode *inode, struct file *filp)
 	pr_debug("%s: priv %p\n", __func__, priv);
 
 	mutex_lock(&gref_mutex);
-	while (!list_empty(&priv->list)) {
-		gref = list_entry(priv->list.next,
-			struct gntalloc_gref, next_file);
-		list_del(&gref->next_file);
+	list_for_each_entry_del(gref, &priv->list, next_file) {
 		gref->users--;
 		if (gref->users == 0)
 			__del_gref(gref);
diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
index 61faea1f0663..c5c984ebb318 100644
--- a/drivers/xen/gntdev.c
+++ b/drivers/xen/gntdev.c
@@ -612,12 +612,8 @@ static int gntdev_release(struct inode *inode, struct file *flip)
 	pr_debug("priv %p\n", priv);
 
 	mutex_lock(&priv->lock);
-	while (!list_empty(&priv->maps)) {
-		map = list_entry(priv->maps.next,
-				 struct gntdev_grant_map, next);
-		list_del(&map->next);
+	list_for_each_entry_del(map, &priv->maps, next)
 		gntdev_put_map(NULL /* already removed */, map);
-	}
 	mutex_unlock(&priv->lock);
 
 #ifdef CONFIG_XEN_GNTDEV_DMABUF
diff --git a/drivers/xen/xen-pciback/pci_stub.c b/drivers/xen/xen-pciback/pci_stub.c
index e34b623e4b41..40decc8b710c 100644
--- a/drivers/xen/xen-pciback/pci_stub.c
+++ b/drivers/xen/xen-pciback/pci_stub.c
@@ -455,11 +455,7 @@ static int __init pcistub_init_devices_late(void)
 
 	spin_lock_irqsave(&pcistub_devices_lock, flags);
 
-	while (!list_empty(&seized_devices)) {
-		psdev = container_of(seized_devices.next,
-				     struct pcistub_device, dev_list);
-		list_del(&psdev->dev_list);
-
+	list_for_each_entry_del(psdev, &seized_devices, dev_list) {
 		spin_unlock_irqrestore(&pcistub_devices_lock, flags);
 
 		err = pcistub_init_device(psdev->dev);
diff --git a/drivers/xen/xenbus/xenbus_dev_frontend.c b/drivers/xen/xenbus/xenbus_dev_frontend.c
index 0792fda49a15..8e60622a21dc 100644
--- a/drivers/xen/xenbus/xenbus_dev_frontend.c
+++ b/drivers/xen/xenbus/xenbus_dev_frontend.c
@@ -216,11 +216,8 @@ static void queue_cleanup(struct list_head *list)
 {
 	struct read_buffer *rb;
 
-	while (!list_empty(list)) {
-		rb = list_entry(list->next, struct read_buffer, list);
-		list_del(list->next);
+	list_for_each_entry_del(rb, list, list)
 		kfree(rb);
-	}
 }
 
 struct watch_adapter {
diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 1c794a1896aa..1a9680493f35 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -808,6 +808,7 @@ int afs_drop_inode(struct inode *inode)
  */
 void afs_evict_inode(struct inode *inode)
 {
+	struct afs_wb_key *wbk;
 	struct afs_vnode_cache_aux aux;
 	struct afs_vnode *vnode = AFS_FS_I(inode);
 
@@ -826,12 +827,8 @@ void afs_evict_inode(struct inode *inode)
 	fscache_clear_inode_writeback(afs_vnode_cache(vnode), inode, &aux);
 	clear_inode(inode);
 
-	while (!list_empty(&vnode->wb_keys)) {
-		struct afs_wb_key *wbk = list_entry(vnode->wb_keys.next,
-						    struct afs_wb_key, vnode_link);
-		list_del(&wbk->vnode_link);
+	list_for_each_entry_del(wbk, &vnode->wb_keys, vnode_link)
 		afs_put_wb_key(wbk);
-	}
 
 	fscache_relinquish_cookie(afs_vnode_cache(vnode),
 				  test_bit(AFS_VNODE_DELETED, &vnode->flags));
diff --git a/fs/afs/write.c b/fs/afs/write.c
index e1c45341719b..314b5d2baec2 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -985,11 +985,8 @@ void afs_prune_wb_keys(struct afs_vnode *vnode)
 
 	spin_unlock(&vnode->wb_lock);
 
-	while (!list_empty(&graveyard)) {
-		wbk = list_entry(graveyard.next, struct afs_wb_key, vnode_link);
-		list_del(&wbk->vnode_link);
+	list_for_each_entry_del(wbk, &graveyard, vnode_link)
 		afs_put_wb_key(wbk);
-	}
 }
 
 /*
diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index b7d54efb4728..92020ff677c7 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -3596,10 +3596,7 @@ void btrfs_backref_error_cleanup(struct btrfs_backref_cache *cache,
 	struct btrfs_backref_node *upper;
 	struct btrfs_backref_edge *edge;
 
-	while (!list_empty(&cache->useless_node)) {
-		lower = list_first_entry(&cache->useless_node,
-				   struct btrfs_backref_node, list);
-		list_del_init(&lower->list);
+	list_for_each_entry_del_init(lower, &cache->useless_node, list) {
 	}
 	while (!list_empty(&cache->pending_edge)) {
 		edge = list_first_entry(&cache->pending_edge,
@@ -3629,10 +3626,7 @@ void btrfs_backref_error_cleanup(struct btrfs_backref_cache *cache,
 			list_add(&upper->list, &cache->useless_node);
 	}
 
-	while (!list_empty(&cache->useless_node)) {
-		lower = list_first_entry(&cache->useless_node,
-				   struct btrfs_backref_node, list);
-		list_del_init(&lower->list);
+	list_for_each_entry_del_init(lower, &cache->useless_node, list) {
 		if (lower == node)
 			node = NULL;
 		btrfs_backref_drop_node(cache, lower);
diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index b2e5107b7cec..6a499516f671 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1487,14 +1487,10 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 		return;
 
 	spin_lock(&fs_info->unused_bgs_lock);
-	while (!list_empty(&fs_info->unused_bgs)) {
+	list_for_each_entry_del_init(block_group, &fs_info->unused_bgs,
+				     bg_list) {
 		int trimming;
 
-		block_group = list_first_entry(&fs_info->unused_bgs,
-					       struct btrfs_block_group,
-					       bg_list);
-		list_del_init(&block_group->bg_list);
-
 		space_info = block_group->space_info;
 
 		if (ret || btrfs_mixed_space_info(space_info)) {
@@ -1776,15 +1772,10 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 	 * and their presence in the reclaim_bgs list must be preserved.
 	 */
 	list_sort(NULL, &fs_info->reclaim_bgs, reclaim_bgs_cmp);
-	while (!list_empty(&fs_info->reclaim_bgs)) {
+	list_for_each_entry_del_init(bg, &fs_info->reclaim_bgs, bg_list) {
 		u64 zone_unusable;
 		int ret = 0;
 
-		bg = list_first_entry(&fs_info->reclaim_bgs,
-				      struct btrfs_block_group,
-				      bg_list);
-		list_del_init(&bg->bg_list);
-
 		space_info = bg->space_info;
 		spin_unlock(&fs_info->unused_bgs_lock);
 
@@ -3527,10 +3518,7 @@ int btrfs_write_dirty_block_groups(struct btrfs_trans_handle *trans)
 	 * Refer to the definition of io_bgs member for details why it's safe
 	 * to use it without any locking
 	 */
-	while (!list_empty(io)) {
-		cache = list_first_entry(io, struct btrfs_block_group,
-					 io_list);
-		list_del_init(&cache->io_list);
+	list_for_each_entry_del_init(cache, io, io_list) {
 		btrfs_wait_cache_io(trans, cache, path);
 		btrfs_put_block_group(cache);
 	}
@@ -4307,38 +4295,21 @@ int btrfs_free_block_groups(struct btrfs_fs_info *info)
 	}
 
 	write_lock(&info->block_group_cache_lock);
-	while (!list_empty(&info->caching_block_groups)) {
-		caching_ctl = list_entry(info->caching_block_groups.next,
-					 struct btrfs_caching_control, list);
-		list_del(&caching_ctl->list);
+	list_for_each_entry_del(caching_ctl, &info->caching_block_groups, list)
 		btrfs_put_caching_control(caching_ctl);
-	}
 	write_unlock(&info->block_group_cache_lock);
 
 	spin_lock(&info->unused_bgs_lock);
-	while (!list_empty(&info->unused_bgs)) {
-		block_group = list_first_entry(&info->unused_bgs,
-					       struct btrfs_block_group,
-					       bg_list);
-		list_del_init(&block_group->bg_list);
+	list_for_each_entry_del_init(block_group, &info->unused_bgs, bg_list)
 		btrfs_put_block_group(block_group);
-	}
 
-	while (!list_empty(&info->reclaim_bgs)) {
-		block_group = list_first_entry(&info->reclaim_bgs,
-					       struct btrfs_block_group,
-					       bg_list);
-		list_del_init(&block_group->bg_list);
+	list_for_each_entry_del_init(block_group, &info->reclaim_bgs, bg_list)
 		btrfs_put_block_group(block_group);
-	}
 	spin_unlock(&info->unused_bgs_lock);
 
 	spin_lock(&info->zone_active_bgs_lock);
-	while (!list_empty(&info->zone_active_bgs)) {
-		block_group = list_first_entry(&info->zone_active_bgs,
-					       struct btrfs_block_group,
-					       active_bg_list);
-		list_del_init(&block_group->active_bg_list);
+	list_for_each_entry_del_init(block_group, &info->zone_active_bgs,
+				     active_bg_list) {
 		btrfs_put_block_group(block_group);
 	}
 	spin_unlock(&info->zone_active_bgs_lock);
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 68f60d50e1fd..3b4967daecf7 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1833,11 +1833,7 @@ void btrfs_free_fs_roots(struct btrfs_fs_info *fs_info)
 	struct btrfs_root *gang[8];
 	int i;
 
-	while (!list_empty(&fs_info->dead_roots)) {
-		gang[0] = list_entry(fs_info->dead_roots.next,
-				     struct btrfs_root, root_list);
-		list_del(&gang[0]->root_list);
-
+	list_for_each_entry_del(gang[0], &fs_info->dead_roots, root_list) {
 		if (test_bit(BTRFS_ROOT_IN_RADIX, &gang[0]->state))
 			btrfs_drop_and_free_fs_root(fs_info, gang[0]);
 		btrfs_put_root(gang[0]);
@@ -4817,12 +4813,7 @@ void btrfs_cleanup_dirty_bgs(struct btrfs_transaction *cur_trans,
 	 * Refer to the definition of io_bgs member for details why it's safe
 	 * to use it without any locking
 	 */
-	while (!list_empty(&cur_trans->io_bgs)) {
-		cache = list_first_entry(&cur_trans->io_bgs,
-					 struct btrfs_block_group,
-					 io_list);
-
-		list_del_init(&cache->io_list);
+	list_for_each_entry_del_init(cache, &cur_trans->io_bgs, io_list) {
 		spin_lock(&cache->lock);
 		cache->disk_cache_state = BTRFS_DC_ERROR;
 		spin_unlock(&cache->lock);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 7814b9d654ce..cd9ce29a25ab 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1578,12 +1578,8 @@ static noinline void submit_compressed_extents(struct btrfs_work *work)
 	nr_pages = (async_chunk->end - async_chunk->start + PAGE_SIZE) >>
 		PAGE_SHIFT;
 
-	while (!list_empty(&async_chunk->extents)) {
-		async_extent = list_entry(async_chunk->extents.next,
-					  struct async_extent, list);
-		list_del(&async_extent->list);
+	list_for_each_entry_del(async_extent, &async_chunk->extents, list)
 		submit_one_async_extent(async_chunk, async_extent, &alloc_hint);
-	}
 
 	/* atomic_sub_return implies a barrier */
 	if (atomic_sub_return(nr_pages, &fs_info->async_delalloc_pages) <
@@ -1733,11 +1729,9 @@ static noinline int csum_exist_in_range(struct btrfs_fs_info *fs_info,
 	if (ret == 0 && list_empty(&list))
 		return 0;
 
-	while (!list_empty(&list)) {
-		sums = list_entry(list.next, struct btrfs_ordered_sum, list);
-		list_del(&sums->list);
+	list_for_each_entry_del(sums, &list, list)
 		kfree(sums);
-	}
+
 	if (ret < 0)
 		return ret;
 	return 1;
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 345c449d588c..d20cc0ccec44 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -550,7 +550,6 @@ bool btrfs_dec_test_ordered_pending(struct btrfs_inode *inode,
  */
 void btrfs_put_ordered_extent(struct btrfs_ordered_extent *entry)
 {
-	struct list_head *cur;
 	struct btrfs_ordered_sum *sum;
 
 	trace_btrfs_ordered_extent_put(BTRFS_I(entry->inode), entry);
@@ -561,12 +560,8 @@ void btrfs_put_ordered_extent(struct btrfs_ordered_extent *entry)
 		ASSERT(RB_EMPTY_NODE(&entry->rb_node));
 		if (entry->inode)
 			btrfs_add_delayed_iput(BTRFS_I(entry->inode));
-		while (!list_empty(&entry->list)) {
-			cur = entry->list.next;
-			sum = list_entry(cur, struct btrfs_ordered_sum, list);
-			list_del(&sum->list);
+		list_for_each_entry_del(sum, &entry->list, list)
 			kvfree(sum);
-		}
 		kmem_cache_free(btrfs_ordered_extent_cache, entry);
 	}
 }
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index b99230db3c82..526e49fc97e2 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -221,19 +221,13 @@ static void __del_qgroup_rb(struct btrfs_fs_info *fs_info,
 	struct btrfs_qgroup_list *list;
 
 	list_del(&qgroup->dirty);
-	while (!list_empty(&qgroup->groups)) {
-		list = list_first_entry(&qgroup->groups,
-					struct btrfs_qgroup_list, next_group);
-		list_del(&list->next_group);
+	list_for_each_entry_del(list, &qgroup->groups, next_group) {
 		list_del(&list->next_member);
 		kfree(list);
 	}
 
-	while (!list_empty(&qgroup->members)) {
-		list = list_first_entry(&qgroup->members,
-					struct btrfs_qgroup_list, next_member);
+	list_for_each_entry_del(list, &qgroup->members, next_member) {
 		list_del(&list->next_group);
-		list_del(&list->next_member);
 		kfree(list);
 	}
 }
@@ -2847,6 +2841,7 @@ int btrfs_qgroup_account_extents(struct btrfs_trans_handle *trans)
  */
 int btrfs_run_qgroups(struct btrfs_trans_handle *trans)
 {
+	struct btrfs_qgroup *qgroup;
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	int ret = 0;
 
@@ -2862,11 +2857,7 @@ int btrfs_run_qgroups(struct btrfs_trans_handle *trans)
 		return ret;
 
 	spin_lock(&fs_info->qgroup_lock);
-	while (!list_empty(&fs_info->dirty_qgroups)) {
-		struct btrfs_qgroup *qgroup;
-		qgroup = list_first_entry(&fs_info->dirty_qgroups,
-					  struct btrfs_qgroup, dirty);
-		list_del_init(&qgroup->dirty);
+	list_for_each_entry_del_init(qgroup, &fs_info->dirty_qgroups, dirty) {
 		spin_unlock(&fs_info->qgroup_lock);
 		ret = update_qgroup_info_item(trans, qgroup);
 		if (ret)
diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 3e014b9370a3..c6efe769aee2 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1580,11 +1580,7 @@ static void raid_unplug(struct blk_plug_cb *cb, bool from_schedule)
 
 	list_sort(NULL, &plug->rbio_list, plug_cmp);
 
-	while (!list_empty(&plug->rbio_list)) {
-		cur = list_entry(plug->rbio_list.next,
-				 struct btrfs_raid_bio, plug_list);
-		list_del_init(&cur->plug_list);
-
+	list_for_each_entry_del_init(cur, &plug->rbio_list, plug_list) {
 		if (rbio_is_full(cur)) {
 			/* We have a full stripe, queue it down. */
 			start_async_work(cur, rmw_rbio_work);
diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
index 95d28497de7c..7bba6ae6281b 100644
--- a/fs/btrfs/ref-verify.c
+++ b/fs/btrfs/ref-verify.c
@@ -251,12 +251,9 @@ static void free_block_entry(struct block_entry *be)
 		kfree(ref);
 	}
 
-	while (!list_empty(&be->actions)) {
-		ra = list_first_entry(&be->actions, struct ref_action,
-				      list);
-		list_del(&ra->list);
+	list_for_each_entry_del(ra, &be->actions, list)
 		kfree(ra);
-	}
+
 	kfree(be);
 }
 
@@ -727,6 +724,8 @@ int btrfs_ref_tree_mod(struct btrfs_fs_info *fs_info,
 	 */
 	ret = -EINVAL;
 	if (action == BTRFS_ADD_DELAYED_EXTENT) {
+		struct ref_action *tmp;
+
 		/*
 		 * For subvol_create we'll just pass in whatever the parent root
 		 * is and the new root objectid, so let's not treat the passed
@@ -753,12 +752,7 @@ int btrfs_ref_tree_mod(struct btrfs_fs_info *fs_info,
 			goto out_unlock;
 		}
 
-		while (!list_empty(&be->actions)) {
-			struct ref_action *tmp;
-
-			tmp = list_first_entry(&be->actions, struct ref_action,
-					       list);
-			list_del(&tmp->list);
+		list_for_each_entry_del(tmp, &be->actions, list) {
 			kfree(tmp);
 		}
 	} else {
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 9951a0caf5bb..063cab9b7398 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -274,10 +274,7 @@ static int update_backref_cache(struct btrfs_trans_handle *trans,
 		btrfs_backref_cleanup_node(cache, node);
 	}
 
-	while (!list_empty(&cache->changed)) {
-		node = list_entry(cache->changed.next,
-				  struct btrfs_backref_node, list);
-		list_del_init(&node->list);
+	list_for_each_entry_del_init(node, &cache->changed, list) {
 		BUG_ON(node->pending);
 		update_backref_node(cache, node, node->new_bytenr);
 	}
@@ -393,17 +390,12 @@ struct btrfs_root *find_reloc_root(struct btrfs_fs_info *fs_info, u64 bytenr)
 static bool handle_useless_nodes(struct reloc_control *rc,
 				 struct btrfs_backref_node *node)
 {
+	struct btrfs_backref_node *cur;
 	struct btrfs_backref_cache *cache = &rc->backref_cache;
 	struct list_head *useless_node = &cache->useless_node;
 	bool ret = false;
 
-	while (!list_empty(useless_node)) {
-		struct btrfs_backref_node *cur;
-
-		cur = list_first_entry(useless_node, struct btrfs_backref_node,
-				 list);
-		list_del_init(&cur->list);
-
+	list_for_each_entry_del_init(cur, useless_node, list) {
 		/* Only tree root nodes can be added to @useless_nodes */
 		ASSERT(list_empty(&cur->upper));
 
@@ -1898,11 +1890,7 @@ int prepare_to_merge(struct reloc_control *rc, int err)
 
 	rc->merge_reloc_tree = 1;
 
-	while (!list_empty(&rc->reloc_roots)) {
-		reloc_root = list_entry(rc->reloc_roots.next,
-					struct btrfs_root, root_list);
-		list_del_init(&reloc_root->root_list);
-
+	list_for_each_entry_del_init(reloc_root, &rc->reloc_roots, root_list) {
 		root = btrfs_get_fs_root(fs_info, reloc_root->root_key.offset,
 				false);
 		if (IS_ERR(root)) {
@@ -4304,11 +4292,7 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
 
 	rc->merge_reloc_tree = 1;
 
-	while (!list_empty(&reloc_roots)) {
-		reloc_root = list_entry(reloc_roots.next,
-					struct btrfs_root, root_list);
-		list_del(&reloc_root->root_list);
-
+	list_for_each_entry_del(reloc_root, &reloc_roots, root_list) {
 		if (btrfs_root_refs(&reloc_root->root_item) == 0) {
 			list_add_tail(&reloc_root->root_list,
 				      &rc->reloc_roots);
@@ -4382,6 +4366,7 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
  */
 int btrfs_reloc_clone_csums(struct btrfs_ordered_extent *ordered)
 {
+	struct btrfs_ordered_sum *sums;
 	struct btrfs_inode *inode = BTRFS_I(ordered->inode);
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	u64 disk_bytenr = ordered->file_offset + inode->index_cnt;
@@ -4395,12 +4380,7 @@ int btrfs_reloc_clone_csums(struct btrfs_ordered_extent *ordered)
 	if (ret)
 		return ret;
 
-	while (!list_empty(&list)) {
-		struct btrfs_ordered_sum *sums =
-			list_entry(list.next, struct btrfs_ordered_sum, list);
-
-		list_del_init(&sums->list);
-
+	list_for_each_entry_del_init(sums, &list, list) {
 		/*
 		 * We need to offset the new_bytenr based on where the csum is.
 		 * We need to do this because we will read in entire prealloc
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index c780d3729463..a11b66574c4a 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -144,6 +144,8 @@ void btrfs_put_transaction(struct btrfs_transaction *transaction)
 {
 	WARN_ON(refcount_read(&transaction->use_count) == 0);
 	if (refcount_dec_and_test(&transaction->use_count)) {
+		struct btrfs_block_group *cache;
+
 		BUG_ON(!list_empty(&transaction->list));
 		WARN_ON(!RB_EMPTY_ROOT(
 				&transaction->delayed_refs.href_root.rb_root));
@@ -160,13 +162,8 @@ void btrfs_put_transaction(struct btrfs_transaction *transaction)
 		 * and calling btrfs_finish_extent_commit()), so we can not
 		 * discard the physical locations of the block groups.
 		 */
-		while (!list_empty(&transaction->deleted_bgs)) {
-			struct btrfs_block_group *cache;
-
-			cache = list_first_entry(&transaction->deleted_bgs,
-						 struct btrfs_block_group,
-						 bg_list);
-			list_del_init(&cache->bg_list);
+		list_for_each_entry_del_init(cache, &transaction->deleted_bgs,
+					     bg_list) {
 			btrfs_unfreeze_block_group(cache);
 			btrfs_put_block_group(cache);
 		}
@@ -203,10 +200,8 @@ static noinline void switch_commit_roots(struct btrfs_trans_handle *trans)
 
 	/* We can free old roots now. */
 	spin_lock(&cur_trans->dropped_roots_lock);
-	while (!list_empty(&cur_trans->dropped_roots)) {
-		root = list_first_entry(&cur_trans->dropped_roots,
-					struct btrfs_root, root_list);
-		list_del_init(&root->root_list);
+	list_for_each_entry_del_init(root, &cur_trans->dropped_roots,
+				     root_list) {
 		spin_unlock(&cur_trans->dropped_roots_lock);
 		btrfs_free_log(trans, root);
 		btrfs_drop_and_free_fs_root(fs_info, root);
@@ -1285,7 +1280,7 @@ static noinline int commit_cowonly_roots(struct btrfs_trans_handle *trans)
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct list_head *dirty_bgs = &trans->transaction->dirty_bgs;
 	struct list_head *io_bgs = &trans->transaction->io_bgs;
-	struct list_head *next;
+	struct btrfs_root *root;
 	struct extent_buffer *eb;
 	int ret;
 
@@ -1319,11 +1314,8 @@ static noinline int commit_cowonly_roots(struct btrfs_trans_handle *trans)
 		return ret;
 
 again:
-	while (!list_empty(&fs_info->dirty_cowonly_roots)) {
-		struct btrfs_root *root;
-		next = fs_info->dirty_cowonly_roots.next;
-		list_del_init(next);
-		root = list_entry(next, struct btrfs_root, dirty_list);
+	list_for_each_entry_del_init(root, &fs_info->dirty_cowonly_roots,
+				     dirty_list) {
 		clear_bit(BTRFS_ROOT_DIRTY, &root->state);
 
 		list_add_tail(&root->dirty_list,
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index cbb17b542131..4ac55c11e6bd 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4879,11 +4879,7 @@ static int btrfs_log_changed_extents(struct btrfs_trans_handle *trans,
 
 	list_sort(NULL, &extents, extent_cmp);
 process:
-	while (!list_empty(&extents)) {
-		em = list_entry(extents.next, struct extent_map, list);
-
-		list_del_init(&em->list);
-
+	list_for_each_entry_del_init(em, &extents, list) {
 		/*
 		 * If we had an error we just need to delete everybody from our
 		 * private list.
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 5a5a8d488a7b..51b844a6c081 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -406,12 +406,8 @@ static void free_fs_devices(struct btrfs_fs_devices *fs_devices)
 	struct btrfs_device *device;
 
 	WARN_ON(fs_devices->opened);
-	while (!list_empty(&fs_devices->devices)) {
-		device = list_entry(fs_devices->devices.next,
-				    struct btrfs_device, dev_list);
-		list_del(&device->dev_list);
+	list_for_each_entry_del(device, &fs_devices->devices, dev_list)
 		btrfs_free_device(device);
-	}
 	kfree(fs_devices);
 }
 
@@ -419,12 +415,8 @@ void __exit btrfs_cleanup_fs_uuids(void)
 {
 	struct btrfs_fs_devices *fs_devices;
 
-	while (!list_empty(&fs_uuids)) {
-		fs_devices = list_entry(fs_uuids.next,
-					struct btrfs_fs_devices, fs_list);
-		list_del(&fs_devices->fs_list);
+	list_for_each_entry_del(fs_devices, &fs_uuids, fs_list)
 		free_fs_devices(fs_devices);
-	}
 }
 
 static bool match_fsid_fs_devices(const struct btrfs_fs_devices *fs_devices,
diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
index e7ac4ec809a4..0c6a9e7f1d38 100644
--- a/fs/btrfs/zstd.c
+++ b/fs/btrfs/zstd.c
@@ -204,10 +204,7 @@ void zstd_cleanup_workspace_manager(void)
 
 	spin_lock_bh(&wsm.lock);
 	for (i = 0; i < ZSTD_BTRFS_MAX_LEVEL; i++) {
-		while (!list_empty(&wsm.idle_ws[i])) {
-			workspace = container_of(wsm.idle_ws[i].next,
-						 struct workspace, list);
-			list_del(&workspace->list);
+		list_for_each_entry_del(workspace, &wsm.idle_ws[i], list) {
 			list_del(&workspace->lru_list);
 			zstd_free_workspace(&workspace->list);
 		}
diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 14215ec646f7..69bb3deba960 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -137,12 +137,8 @@ void ceph_caps_finalize(struct ceph_mds_client *mdsc)
 	struct ceph_cap *cap;
 
 	spin_lock(&mdsc->caps_list_lock);
-	while (!list_empty(&mdsc->caps_list)) {
-		cap = list_first_entry(&mdsc->caps_list,
-				       struct ceph_cap, caps_item);
-		list_del(&cap->caps_item);
+	list_for_each_entry_del(cap, &mdsc->caps_list, caps_item)
 		kmem_cache_free(ceph_cap_cachep, cap);
-	}
 	mdsc->caps_total_count = 0;
 	mdsc->caps_avail_count = 0;
 	mdsc->caps_use_count = 0;
@@ -3813,10 +3809,7 @@ static void handle_cap_flush_ack(struct inode *inode, u64 flush_tid,
 out:
 	spin_unlock(&ci->i_ceph_lock);
 
-	while (!list_empty(&to_remove)) {
-		cf = list_first_entry(&to_remove,
-				      struct ceph_cap_flush, i_list);
-		list_del_init(&cf->i_list);
+	list_for_each_entry_del_init(cf, &to_remove, i_list) {
 		if (!cf->is_capsnap)
 			ceph_free_cap_flush(cf);
 	}
@@ -4882,11 +4875,9 @@ int ceph_purge_inode_cap(struct inode *inode, struct ceph_cap *cap, bool *invali
 		spin_lock(&mdsc->cap_dirty_lock);
 
 		/* trash all of the cap flushes for this inode */
-		while (!list_empty(&ci->i_cap_flush_list)) {
-			cf = list_first_entry(&ci->i_cap_flush_list,
-					      struct ceph_cap_flush, i_list);
+		list_for_each_entry_del_init(cf, &ci->i_cap_flush_list,
+					     i_list) {
 			list_del_init(&cf->g_list);
-			list_del_init(&cf->i_list);
 			if (!cf->is_capsnap)
 				ceph_free_cap_flush(cf);
 		}
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index b5f8038065d7..a5dd9a4d6e8f 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -1574,11 +1574,7 @@ ceph_direct_read_write(struct kiocb *iocb, struct iov_iter *iter,
 
 		list_splice(&aio_req->osd_reqs, &osd_reqs);
 		inode_dio_begin(inode);
-		while (!list_empty(&osd_reqs)) {
-			req = list_first_entry(&osd_reqs,
-					       struct ceph_osd_request,
-					       r_private_item);
-			list_del_init(&req->r_private_item);
+		list_for_each_entry_del_init(req, &osd_reqs, r_private_item) {
 			if (ret >= 0)
 				ceph_osdc_start_request(req->r_osdc, req);
 			if (ret < 0) {
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 615db141b6c4..7ba9dbf88147 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -1741,11 +1741,10 @@ static void detach_cap_releases(struct ceph_mds_session *session,
 static void dispose_cap_releases(struct ceph_mds_client *mdsc,
 				 struct list_head *dispose)
 {
-	while (!list_empty(dispose)) {
-		struct ceph_cap *cap;
+	struct ceph_cap *cap;
+
+	list_for_each_entry_del(cap, dispose, session_caps) {
 		/* zero out the in-progress message */
-		cap = list_first_entry(dispose, struct ceph_cap, session_caps);
-		list_del(&cap->session_caps);
 		ceph_put_cap(mdsc, cap);
 	}
 }
@@ -3440,10 +3439,7 @@ static void __wake_requests(struct ceph_mds_client *mdsc,
 
 	list_splice_init(head, &tmp_list);
 
-	while (!list_empty(&tmp_list)) {
-		req = list_entry(tmp_list.next,
-				 struct ceph_mds_request, r_wait);
-		list_del_init(&req->r_wait);
+	list_for_each_entry_del_init(req, &tmp_list, r_wait) {
 		dout(" wake request %p tid %llu\n", req, req->r_tid);
 		__do_request(mdsc, req);
 	}
diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
index 813f21add992..b1a19b93878f 100644
--- a/fs/ceph/snap.c
+++ b/fs/ceph/snap.c
@@ -255,10 +255,7 @@ static void __cleanup_empty_realms(struct ceph_mds_client *mdsc)
 	lockdep_assert_held_write(&mdsc->snap_rwsem);
 
 	spin_lock(&mdsc->snap_empty_lock);
-	while (!list_empty(&mdsc->snap_empty)) {
-		realm = list_first_entry(&mdsc->snap_empty,
-				   struct ceph_snap_realm, empty_item);
-		list_del(&realm->empty_item);
+	list_for_each_entry_del(realm, &mdsc->snap_empty, empty_item) {
 		spin_unlock(&mdsc->snap_empty_lock);
 		__destroy_snap_realm(mdsc, realm);
 		spin_lock(&mdsc->snap_empty_lock);
@@ -869,12 +866,8 @@ int ceph_update_snap_trace(struct ceph_mds_client *mdsc,
 	 * queue cap snaps _after_ we've built the new snap contexts,
 	 * so that i_head_snapc can be set appropriately.
 	 */
-	while (!list_empty(&dirty_realms)) {
-		realm = list_first_entry(&dirty_realms, struct ceph_snap_realm,
-					 dirty_item);
-		list_del_init(&realm->dirty_item);
+	list_for_each_entry_del_init(realm, &dirty_realms, dirty_item)
 		queue_realm_cap_snaps(realm);
-	}
 
 	if (realm_ret)
 		*realm_ret = first_realm;
@@ -1286,9 +1279,7 @@ void ceph_trim_snapid_map(struct ceph_mds_client *mdsc)
 	}
 	spin_unlock(&mdsc->snapid_map_lock);
 
-	while (!list_empty(&to_free)) {
-		sm = list_first_entry(&to_free, struct ceph_snapid_map, lru);
-		list_del(&sm->lru);
+	list_for_each_entry_del(sm, &to_free, lru) {
 		dout("trim snapid map %llx -> %x\n", sm->snap, sm->dev);
 		free_anon_bdev(sm->dev);
 		kfree(sm);
@@ -1310,9 +1301,7 @@ void ceph_cleanup_snapid_map(struct ceph_mds_client *mdsc)
 	}
 	spin_unlock(&mdsc->snapid_map_lock);
 
-	while (!list_empty(&to_free)) {
-		sm = list_first_entry(&to_free, struct ceph_snapid_map, lru);
-		list_del(&sm->lru);
+	list_for_each_entry_del(sm, &to_free, lru) {
 		free_anon_bdev(sm->dev);
 		if (WARN_ON_ONCE(atomic_read(&sm->ref))) {
 			pr_err("snapid map %llx -> %x still in use\n",
diff --git a/fs/char_dev.c b/fs/char_dev.c
index 950b6919fb87..dfa3e79eb1c1 100644
--- a/fs/char_dev.c
+++ b/fs/char_dev.c
@@ -434,13 +434,11 @@ void cd_forget(struct inode *inode)
 
 static void cdev_purge(struct cdev *cdev)
 {
+	struct inode *inode;
+
 	spin_lock(&cdev_lock);
-	while (!list_empty(&cdev->list)) {
-		struct inode *inode;
-		inode = container_of(cdev->list.next, struct inode, i_devices);
-		list_del_init(&inode->i_devices);
+	list_for_each_entry_del_init(inode, &cdev->list, i_devices)
 		inode->i_cdev = NULL;
-	}
 	spin_unlock(&cdev_lock);
 }
 
diff --git a/fs/dlm/lockspace.c b/fs/dlm/lockspace.c
index 0455dddb0797..8b7df9981057 100644
--- a/fs/dlm/lockspace.c
+++ b/fs/dlm/lockspace.c
@@ -852,12 +852,8 @@ static int release_lockspace(struct dlm_ls *ls, int force)
 	for (i = 0; i < DLM_REMOVE_NAMES_MAX; i++)
 		kfree(ls->ls_remove_names[i]);
 
-	while (!list_empty(&ls->ls_new_rsb)) {
-		rsb = list_first_entry(&ls->ls_new_rsb, struct dlm_rsb,
-				       res_hashchain);
-		list_del(&rsb->res_hashchain);
+	list_for_each_entry_del(rsb, &ls->ls_new_rsb, res_hashchain)
 		dlm_free_rsb(rsb);
-	}
 
 	/*
 	 * Free structures on any other lists
diff --git a/fs/dlm/member.c b/fs/dlm/member.c
index be7909ead71b..18608111d526 100644
--- a/fs/dlm/member.c
+++ b/fs/dlm/member.c
@@ -376,9 +376,7 @@ static void clear_memb_list(struct list_head *head,
 {
 	struct dlm_member *memb;
 
-	while (!list_empty(head)) {
-		memb = list_entry(head->next, struct dlm_member, list);
-		list_del(&memb->list);
+	list_for_each_entry_del(memb, head, list) {
 		if (after_del)
 			after_del(memb->nodeid);
 		kfree(memb);
diff --git a/fs/ecryptfs/kthread.c b/fs/ecryptfs/kthread.c
index ae4cb4e2e134..a2837b9ef202 100644
--- a/fs/ecryptfs/kthread.c
+++ b/fs/ecryptfs/kthread.c
@@ -54,11 +54,8 @@ static int ecryptfs_threadfn(void *ignored)
 			mutex_unlock(&ecryptfs_kthread_ctl.mux);
 			goto out;
 		}
-		while (!list_empty(&ecryptfs_kthread_ctl.req_list)) {
-			req = list_first_entry(&ecryptfs_kthread_ctl.req_list,
-					       struct ecryptfs_open_req,
-					       kthread_ctl_list);
-			list_del(&req->kthread_ctl_list);
+		list_for_each_entry_del(req, &ecryptfs_kthread_ctl.req_list,
+					kthread_ctl_list) {
 			*req->lower_file = dentry_open(&req->path,
 				(O_RDWR | O_LARGEFILE), current_cred());
 			complete(&req->done);
diff --git a/fs/exfat/cache.c b/fs/exfat/cache.c
index 5a2f119b7e8c..5181b3c34858 100644
--- a/fs/exfat/cache.c
+++ b/fs/exfat/cache.c
@@ -195,10 +195,7 @@ static void __exfat_cache_inval_inode(struct inode *inode)
 	struct exfat_inode_info *ei = EXFAT_I(inode);
 	struct exfat_cache *cache;
 
-	while (!list_empty(&ei->cache_lru)) {
-		cache = list_entry(ei->cache_lru.next,
-				   struct exfat_cache, cache_list);
-		list_del_init(&cache->cache_list);
+	list_for_each_entry_del_init(cache, &ei->cache_lru, cache_list) {
 		ei->nr_caches--;
 		exfat_cache_free(cache);
 	}
diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index b06de728b3b6..23618b7f5c36 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -1293,11 +1293,8 @@ static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
 #endif
 	}
 
-	while (!list_empty(&sbi->s_fc_dentry_q[FC_Q_MAIN])) {
-		fc_dentry = list_first_entry(&sbi->s_fc_dentry_q[FC_Q_MAIN],
-					     struct ext4_fc_dentry_update,
-					     fcd_list);
-		list_del_init(&fc_dentry->fcd_list);
+	list_for_each_entry_del_init(fc_dentry,
+				     &sbi->s_fc_dentry_q[FC_Q_MAIN], fcd_list) {
 		list_del_init(&fc_dentry->fcd_dilist);
 		spin_unlock(&sbi->s_fc_lock);
 
diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index dfdd7e5cf038..876e2ea28aa9 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -251,10 +251,8 @@ static int ext4_do_flush_completed_IO(struct inode *inode,
 	list_replace_init(head, &unwritten);
 	spin_unlock_irqrestore(&ei->i_completed_io_lock, flags);
 
-	while (!list_empty(&unwritten)) {
-		io_end = list_entry(unwritten.next, ext4_io_end_t, list);
+	list_for_each_entry_del_init(io_end, &unwritten, list) {
 		BUG_ON(!(io_end->flag & EXT4_IO_END_UNWRITTEN));
-		list_del_init(&io_end->list);
 
 		err = ext4_end_io_end(io_end);
 		if (unlikely(!ret && err))
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index dbebd8b3127e..50b8b43eae13 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -514,10 +514,7 @@ static void ext4_journal_commit_callback(journal_t *journal, transaction_t *txn)
 	ext4_maybe_update_superblock(sb);
 
 	spin_lock(&sbi->s_md_lock);
-	while (!list_empty(&txn->t_private_list)) {
-		jce = list_entry(txn->t_private_list.next,
-				 struct ext4_journal_cb_entry, jce_list);
-		list_del_init(&jce->jce_list);
+	list_for_each_entry_del_init(jce, &txn->t_private_list, jce_list) {
 		spin_unlock(&sbi->s_md_lock);
 		jce->jce_func(sb, jce, error);
 		spin_lock(&sbi->s_md_lock);
diff --git a/fs/fat/cache.c b/fs/fat/cache.c
index 738e427e2d21..e994c076a343 100644
--- a/fs/fat/cache.c
+++ b/fs/fat/cache.c
@@ -188,10 +188,7 @@ static void __fat_cache_inval_inode(struct inode *inode)
 	struct msdos_inode_info *i = MSDOS_I(inode);
 	struct fat_cache *cache;
 
-	while (!list_empty(&i->cache_lru)) {
-		cache = list_entry(i->cache_lru.next,
-				   struct fat_cache, cache_list);
-		list_del_init(&cache->cache_list);
+	list_for_each_entry_del_init(cache, &i->cache_lru, cache_list) {
 		i->nr_caches--;
 		fat_cache_free(cache);
 	}
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 1a8f82f478cb..ba6f7e470fc8 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2079,12 +2079,11 @@ static __poll_t fuse_dev_poll(struct file *file, poll_table *wait)
 /* Abort all requests on the given list (pending or processing) */
 static void end_requests(struct list_head *head)
 {
-	while (!list_empty(head)) {
-		struct fuse_req *req;
-		req = list_entry(head->next, struct fuse_req, list);
+	struct fuse_req *req;
+
+	list_for_each_entry_del_init(req, head, list) {
 		req->out.h.error = -ECONNABORTED;
 		clear_bit(FR_SENT, &req->flags);
-		list_del_init(&req->list);
 		fuse_request_end(req);
 	}
 }
diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index ef7017fb6951..9cd413f7d820 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -2174,11 +2174,8 @@ void gfs2_free_journal_extents(struct gfs2_jdesc *jd)
 {
 	struct gfs2_journal_extent *jext;
 
-	while(!list_empty(&jd->extent_list)) {
-		jext = list_first_entry(&jd->extent_list, struct gfs2_journal_extent, list);
-		list_del(&jext->list);
+	list_for_each_entry_del(jext, &jd->extent_list, list)
 		kfree(jext);
-	}
 }
 
 /**
diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 4a280be229a6..8b48fd5bcb25 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -1962,9 +1962,7 @@ __acquires(&lru_lock)
 
 	list_sort(NULL, list, glock_cmp);
 
-	while(!list_empty(list)) {
-		gl = list_first_entry(list, struct gfs2_glock, gl_lru);
-		list_del_init(&gl->gl_lru);
+	list_for_each_entry_del_init(gl, list, gl_lru) {
 		clear_bit(GLF_LRU, &gl->gl_flags);
 		if (!spin_trylock(&gl->gl_lockref.lock)) {
 add_back_to_lru:
diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
index e5271ae87d1c..339b56b20a91 100644
--- a/fs/gfs2/log.c
+++ b/fs/gfs2/log.c
@@ -1006,17 +1006,13 @@ static void trans_drain(struct gfs2_trans *tr)
 		return;
 
 	head = &tr->tr_buf;
-	while (!list_empty(head)) {
-		bd = list_first_entry(head, struct gfs2_bufdata, bd_list);
-		list_del_init(&bd->bd_list);
+	list_for_each_entry_del_init(bd, head, bd_list) {
 		if (!list_empty(&bd->bd_ail_st_list))
 			gfs2_remove_from_ail(bd);
 		kmem_cache_free(gfs2_bufdata_cachep, bd);
 	}
 	head = &tr->tr_databuf;
-	while (!list_empty(head)) {
-		bd = list_first_entry(head, struct gfs2_bufdata, bd_list);
-		list_del_init(&bd->bd_list);
+	list_for_each_entry_del_init(bd, head, bd_list) {
 		if (!list_empty(&bd->bd_ail_st_list))
 			gfs2_remove_from_ail(bd);
 		kmem_cache_free(gfs2_bufdata_cachep, bd);
diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
index 483f69807062..218f8da93238 100644
--- a/fs/gfs2/lops.c
+++ b/fs/gfs2/lops.c
@@ -739,11 +739,8 @@ static void buf_lo_after_commit(struct gfs2_sbd *sdp, struct gfs2_trans *tr)
 		return;
 
 	head = &tr->tr_buf;
-	while (!list_empty(head)) {
-		bd = list_first_entry(head, struct gfs2_bufdata, bd_list);
-		list_del_init(&bd->bd_list);
+	list_for_each_entry_del_init(bd, head, bd_list)
 		gfs2_unpin(sdp, bd->bd_bh, tr);
-	}
 }
 
 static void buf_lo_before_scan(struct gfs2_jdesc *jd,
@@ -900,9 +897,7 @@ void gfs2_drain_revokes(struct gfs2_sbd *sdp)
 	struct gfs2_bufdata *bd;
 	struct gfs2_glock *gl;
 
-	while (!list_empty(head)) {
-		bd = list_first_entry(head, struct gfs2_bufdata, bd_list);
-		list_del_init(&bd->bd_list);
+	list_for_each_entry_del_init(bd, head, bd_list) {
 		gl = bd->bd_gl;
 		gfs2_glock_remove_revoke(gl);
 		kmem_cache_free(gfs2_bufdata_cachep, bd);
@@ -1085,11 +1080,8 @@ static void databuf_lo_after_commit(struct gfs2_sbd *sdp, struct gfs2_trans *tr)
 		return;
 
 	head = &tr->tr_databuf;
-	while (!list_empty(head)) {
-		bd = list_first_entry(head, struct gfs2_bufdata, bd_list);
-		list_del_init(&bd->bd_list);
+	list_for_each_entry_del_init(bd, head, bd_list)
 		gfs2_unpin(sdp, bd->bd_bh, tr);
-	}
 }
 
 
diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index 171b2713d2e5..288c81b7ef40 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -142,12 +142,8 @@ static void gfs2_qd_list_dispose(struct list_head *list)
 {
 	struct gfs2_quota_data *qd;
 
-	while (!list_empty(list)) {
-		qd = list_first_entry(list, struct gfs2_quota_data, qd_lru);
-		list_del(&qd->qd_lru);
-
+	list_for_each_entry_del(qd, list, qd_lru)
 		gfs2_qd_dispose(qd);
-	}
 }
 
 
diff --git a/fs/gfs2/recovery.c b/fs/gfs2/recovery.c
index 5aae02669a40..fbac9d9d16ff 100644
--- a/fs/gfs2/recovery.c
+++ b/fs/gfs2/recovery.c
@@ -108,11 +108,8 @@ void gfs2_revoke_clean(struct gfs2_jdesc *jd)
 	struct list_head *head = &jd->jd_revoke_list;
 	struct gfs2_revoke_replay *rr;
 
-	while (!list_empty(head)) {
-		rr = list_first_entry(head, struct gfs2_revoke_replay, rr_list);
-		list_del(&rr->rr_list);
+	list_for_each_entry_del(rr, head, rr_list)
 		kfree(rr);
-	}
 }
 
 int __get_log_header(struct gfs2_sbd *sdp, const struct gfs2_log_header *lh,
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 02d93da21b2b..efb1d233a0c8 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -385,9 +385,7 @@ static int gfs2_lock_fs_check_clean(struct gfs2_sbd *sdp)
 	gfs2_assert_withdraw(sdp, !error2);
 
 out:
-	while (!list_empty(&list)) {
-		lfcc = list_first_entry(&list, struct lfcc, list);
-		list_del(&lfcc->list);
+	list_for_each_entry_del(lfcc, &list, list) {
 		gfs2_glock_dq_uninit(&lfcc->gh);
 		kfree(lfcc);
 	}
diff --git a/fs/inode.c b/fs/inode.c
index 84bc3c76e5cc..0d1eba0cfece 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -688,12 +688,9 @@ static void evict(struct inode *inode)
  */
 static void dispose_list(struct list_head *head)
 {
-	while (!list_empty(head)) {
-		struct inode *inode;
-
-		inode = list_first_entry(head, struct inode, i_lru);
-		list_del_init(&inode->i_lru);
+	struct inode *inode;
 
+	list_for_each_entry_del_init(inode, head, i_lru) {
 		evict(inode);
 		cond_resched();
 	}
diff --git a/fs/locks.c b/fs/locks.c
index 76ad05f8070a..31bcd5934dc4 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -342,11 +342,8 @@ locks_dispose_list(struct list_head *dispose)
 {
 	struct file_lock *fl;
 
-	while (!list_empty(dispose)) {
-		fl = list_first_entry(dispose, struct file_lock, fl_list);
-		list_del_init(&fl->fl_list);
+	list_for_each_entry_del_init(fl, dispose, fl_list)
 		locks_free_lock(fl);
-	}
 }
 
 void locks_init_lock(struct file_lock *fl)
diff --git a/fs/namespace.c b/fs/namespace.c
index e157efc54023..503ab3945671 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1648,13 +1648,11 @@ static void umount_tree(struct mount *mnt, enum umount_tree_flags how)
 	if (how & UMOUNT_PROPAGATE)
 		propagate_umount(&tmp_list);
 
-	while (!list_empty(&tmp_list)) {
-		struct mnt_namespace *ns;
+	list_for_each_entry_del_init(p, &tmp_list, mnt_list) {
+		struct mnt_namespace *ns = p->mnt_ns;
 		bool disconnect;
-		p = list_first_entry(&tmp_list, struct mount, mnt_list);
+
 		list_del_init(&p->mnt_expire);
-		list_del_init(&p->mnt_list);
-		ns = p->mnt_ns;
 		if (ns) {
 			ns->mounts--;
 			__touch_mnt_namespace(ns);
diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
index e17cdf53f6a7..756466b5a23e 100644
--- a/fs/netfs/objects.c
+++ b/fs/netfs/objects.c
@@ -61,10 +61,7 @@ void netfs_clear_subrequests(struct netfs_io_request *rreq, bool was_async)
 {
 	struct netfs_io_subrequest *subreq;
 
-	while (!list_empty(&rreq->subrequests)) {
-		subreq = list_first_entry(&rreq->subrequests,
-					  struct netfs_io_subrequest, rreq_link);
-		list_del(&subreq->rreq_link);
+	list_for_each_entry_del(subreq, &rreq->subrequests, rreq_link) {
 		netfs_put_subrequest(subreq, was_async,
 				     netfs_sreq_trace_put_clear);
 	}
diff --git a/fs/nfs/blocklayout/blocklayout.c b/fs/nfs/blocklayout/blocklayout.c
index 943aeea1eb16..a86a874d3332 100644
--- a/fs/nfs/blocklayout/blocklayout.c
+++ b/fs/nfs/blocklayout/blocklayout.c
@@ -644,6 +644,7 @@ static struct pnfs_layout_segment *
 bl_alloc_lseg(struct pnfs_layout_hdr *lo, struct nfs4_layoutget_res *lgr,
 		gfp_t gfp_mask)
 {
+	struct pnfs_block_extent *be;
 	struct layout_verification lv = {
 		.mode = lgr->range.iomode,
 		.start = lgr->range.offset >> SECTOR_SHIFT,
@@ -706,12 +707,7 @@ bl_alloc_lseg(struct pnfs_layout_hdr *lo, struct nfs4_layoutget_res *lgr,
 	}
 
 process_extents:
-	while (!list_empty(&extents)) {
-		struct pnfs_block_extent *be =
-			list_first_entry(&extents, struct pnfs_block_extent,
-					 be_list);
-		list_del(&be->be_list);
-
+	list_for_each_entry_del(be, &extents, be_list) {
 		if (!status)
 			status = ext_tree_insert(bl, be);
 
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index e6a51fd94fea..d4ec0bd4b8ac 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2787,11 +2787,8 @@ static void nfs_access_free_list(struct list_head *head)
 {
 	struct nfs_access_entry *cache;
 
-	while (!list_empty(head)) {
-		cache = list_entry(head->next, struct nfs_access_entry, lru);
-		list_del(&cache->lru);
+	list_for_each_entry_del(cache, head, lru)
 		nfs_access_free_entry(cache);
-	}
 }
 
 static unsigned long
diff --git a/fs/nfs/filelayout/filelayoutdev.c b/fs/nfs/filelayout/filelayoutdev.c
index acf4b88889dc..813282245eb6 100644
--- a/fs/nfs/filelayout/filelayoutdev.c
+++ b/fs/nfs/filelayout/filelayoutdev.c
@@ -174,11 +174,7 @@ nfs4_fl_alloc_deviceid_node(struct nfs_server *server, struct pnfs_device *pdev,
 			goto out_err_drain_dsaddrs;
 
 		/* If DS was already in cache, free ds addrs */
-		while (!list_empty(&dsaddrs)) {
-			da = list_first_entry(&dsaddrs,
-					      struct nfs4_pnfs_ds_addr,
-					      da_node);
-			list_del_init(&da->da_node);
+		list_for_each_entry_del_init(da, &dsaddrs, da_node) {
 			kfree(da->da_remotestr);
 			kfree(da);
 		}
@@ -188,10 +184,7 @@ nfs4_fl_alloc_deviceid_node(struct nfs_server *server, struct pnfs_device *pdev,
 	return dsaddr;
 
 out_err_drain_dsaddrs:
-	while (!list_empty(&dsaddrs)) {
-		da = list_first_entry(&dsaddrs, struct nfs4_pnfs_ds_addr,
-				      da_node);
-		list_del_init(&da->da_node);
+	list_for_each_entry_del_init(da, &dsaddrs, da_node) {
 		kfree(da->da_remotestr);
 		kfree(da);
 	}
diff --git a/fs/nfs/flexfilelayout/flexfilelayoutdev.c b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
index e028f5a0ef5f..b4e4ee29a3d4 100644
--- a/fs/nfs/flexfilelayout/flexfilelayoutdev.c
+++ b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
@@ -154,11 +154,7 @@ nfs4_ff_alloc_deviceid_node(struct nfs_server *server, struct pnfs_device *pdev,
 		goto out_err_drain_dsaddrs;
 
 	/* If DS was already in cache, free ds addrs */
-	while (!list_empty(&dsaddrs)) {
-		da = list_first_entry(&dsaddrs,
-				      struct nfs4_pnfs_ds_addr,
-				      da_node);
-		list_del_init(&da->da_node);
+	list_for_each_entry_del_init(da, &dsaddrs, da_node) {
 		kfree(da->da_remotestr);
 		kfree(da);
 	}
@@ -167,10 +163,7 @@ nfs4_ff_alloc_deviceid_node(struct nfs_server *server, struct pnfs_device *pdev,
 	return new_ds;
 
 out_err_drain_dsaddrs:
-	while (!list_empty(&dsaddrs)) {
-		da = list_first_entry(&dsaddrs, struct nfs4_pnfs_ds_addr,
-				      da_node);
-		list_del_init(&da->da_node);
+	list_for_each_entry_del_init(da, &dsaddrs, da_node) {
 		kfree(da->da_remotestr);
 		kfree(da);
 	}
@@ -462,13 +455,8 @@ void ff_layout_free_ds_ioerr(struct list_head *head)
 {
 	struct nfs4_ff_layout_ds_err *err;
 
-	while (!list_empty(head)) {
-		err = list_first_entry(head,
-				struct nfs4_ff_layout_ds_err,
-				list);
-		list_del(&err->list);
+	list_for_each_entry_del(err, head, list)
 		kfree(err);
-	}
 }
 
 /* called with inode i_lock held */
diff --git a/fs/nfs/nfs42xattr.c b/fs/nfs/nfs42xattr.c
index 911f634ba3da..64b8f933119e 100644
--- a/fs/nfs/nfs42xattr.c
+++ b/fs/nfs/nfs42xattr.c
@@ -863,10 +863,7 @@ nfs4_xattr_cache_scan(struct shrinker *shrink, struct shrink_control *sc)
 
 	freed = list_lru_shrink_walk(&nfs4_xattr_cache_lru, sc,
 	    cache_lru_isolate, &dispose);
-	while (!list_empty(&dispose)) {
-		cache = list_first_entry(&dispose, struct nfs4_xattr_cache,
-		    dispose);
-		list_del_init(&cache->dispose);
+	list_for_each_entry_del_init(cache, &dispose, dispose) {
 		nfs4_xattr_discard_cache(cache);
 		kref_put(&cache->ref, nfs4_xattr_free_cache_cb);
 	}
@@ -948,11 +945,7 @@ nfs4_xattr_entry_scan(struct shrinker *shrink, struct shrink_control *sc)
 
 	freed = list_lru_shrink_walk(lru, sc, entry_lru_isolate, &dispose);
 
-	while (!list_empty(&dispose)) {
-		entry = list_first_entry(&dispose, struct nfs4_xattr_entry,
-		    dispose);
-		list_del_init(&entry->dispose);
-
+	list_for_each_entry_del_init(entry, &dispose, dispose) {
 		/*
 		 * Drop two references: the one that we just grabbed
 		 * in entry_lru_isolate, and the one that was set
diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index 11e3a285594c..104b26e51281 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -154,10 +154,7 @@ nfs4_shutdown_ds_clients(struct nfs_client *clp)
 {
 	struct nfs4_ds_server *dss;
 
-	while (!list_empty(&clp->cl_ds_clients)) {
-		dss = list_entry(clp->cl_ds_clients.next,
-					struct nfs4_ds_server, list);
-		list_del(&dss->list);
+	list_for_each_entry_del(dss, &clp->cl_ds_clients, list) {
 		rpc_shutdown_client(dss->rpc_clnt);
 		kfree (dss);
 	}
@@ -168,12 +165,8 @@ nfs4_cleanup_callback(struct nfs_client *clp)
 {
 	struct nfs4_copy_state *cp_state;
 
-	while (!list_empty(&clp->pending_cb_stateids)) {
-		cp_state = list_entry(clp->pending_cb_stateids.next,
-					struct nfs4_copy_state, copies);
-		list_del(&cp_state->copies);
+	list_for_each_entry_del(cp_state, &clp->pending_cb_stateids, copies)
 		kfree(cp_state);
-	}
 }
 
 void nfs41_shutdown_client(struct nfs_client *clp)
diff --git a/fs/nfs/pnfs_nfs.c b/fs/nfs/pnfs_nfs.c
index afd23910f3bf..0f1f4707ec2f 100644
--- a/fs/nfs/pnfs_nfs.c
+++ b/fs/nfs/pnfs_nfs.c
@@ -686,13 +686,8 @@ static void destroy_ds(struct nfs4_pnfs_ds *ds)
 
 	nfs_put_client(ds->ds_clp);
 
-	while (!list_empty(&ds->ds_addrs)) {
-		da = list_first_entry(&ds->ds_addrs,
-				      struct nfs4_pnfs_ds_addr,
-				      da_node);
-		list_del_init(&da->da_node);
+	list_for_each_entry_del_init(da, &ds->ds_addrs, da_node)
 		nfs4_pnfs_ds_addr_free(da);
-	}
 
 	kfree(ds->ds_remotestr);
 	kfree(ds);
diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index ee9c923192e0..30ce8caeb37e 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -395,11 +395,8 @@ nfsd_file_dispose_list(struct list_head *dispose)
 {
 	struct nfsd_file *nf;
 
-	while (!list_empty(dispose)) {
-		nf = list_first_entry(dispose, struct nfsd_file, nf_lru);
-		list_del_init(&nf->nf_lru);
+	list_for_each_entry_del_init(nf, dispose, nf_lru)
 		nfsd_file_free(nf);
-	}
 }
 
 /**
@@ -630,11 +627,8 @@ nfsd_file_close_inode_sync(struct inode *inode)
 	trace_nfsd_file_close(inode);
 
 	nfsd_file_queue_for_close(inode, &dispose);
-	while (!list_empty(&dispose)) {
-		nf = list_first_entry(&dispose, struct nfsd_file, nf_lru);
-		list_del_init(&nf->nf_lru);
+	list_for_each_entry_del_init(nf, &dispose, nf_lru)
 		nfsd_file_free(nf);
-	}
 	flush_delayed_fput();
 }
 
diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index e8a80052cb1b..0c645e630d4f 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -451,11 +451,9 @@ nfsd4_insert_layout(struct nfsd4_layoutget *lgp, struct nfs4_layout_stateid *ls)
 static void
 nfsd4_free_layouts(struct list_head *reaplist)
 {
-	while (!list_empty(reaplist)) {
-		struct nfs4_layout *lp = list_first_entry(reaplist,
-				struct nfs4_layout, lo_perstate);
+	struct nfs4_layout *lp;
 
-		list_del(&lp->lo_perstate);
+	list_for_each_entry_del(lp, reaplist, lo_perstate) {
 		nfs4_put_stid(&lp->lo_state->ls_stid);
 		kmem_cache_free(nfs4_layout_cache, lp);
 	}
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 8534693eb6a4..f90f531d68a7 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -339,23 +339,15 @@ remove_blocked_locks(struct nfs4_lockowner *lo)
 
 	/* Dequeue all blocked locks */
 	spin_lock(&nn->blocked_locks_lock);
-	while (!list_empty(&lo->lo_blocked)) {
-		nbl = list_first_entry(&lo->lo_blocked,
-					struct nfsd4_blocked_lock,
-					nbl_list);
-		list_del_init(&nbl->nbl_list);
+	list_for_each_entry_del_init(nbl, &lo->lo_blocked, nbl_list) {
 		WARN_ON(list_empty(&nbl->nbl_lru));
 		list_move(&nbl->nbl_lru, &reaplist);
 	}
 	spin_unlock(&nn->blocked_locks_lock);
 
 	/* Now free them */
-	while (!list_empty(&reaplist)) {
-		nbl = list_first_entry(&reaplist, struct nfsd4_blocked_lock,
-					nbl_lru);
-		list_del_init(&nbl->nbl_lru);
+	list_for_each_entry_del_init(nbl, &reaplist, nbl_lru)
 		free_blocked_lock(nbl);
-	}
 }
 
 static void
@@ -1576,10 +1568,7 @@ free_ol_stateid_reaplist(struct list_head *reaplist)
 
 	might_sleep();
 
-	while (!list_empty(reaplist)) {
-		stp = list_first_entry(reaplist, struct nfs4_ol_stateid,
-				       st_locks);
-		list_del(&stp->st_locks);
+	list_for_each_entry_del(stp, reaplist, st_locks) {
 		fp = stp->st_stid.sc_file;
 		stp->st_stid.sc_free(&stp->st_stid);
 		if (fp)
@@ -1941,9 +1930,7 @@ static void nfsd4_del_conns(struct nfsd4_session *s)
 	struct nfsd4_conn *c;
 
 	spin_lock(&clp->cl_lock);
-	while (!list_empty(&s->se_conns)) {
-		c = list_first_entry(&s->se_conns, struct nfsd4_conn, cn_persession);
-		list_del_init(&c->cn_persession);
+	list_for_each_entry_del_init(c, &s->se_conns, cn_persession) {
 		spin_unlock(&clp->cl_lock);
 
 		unregister_xpt_user(c->cn_xprt, &c->cn_xpt_user);
@@ -2152,11 +2139,9 @@ static void drop_client(struct nfs4_client *clp)
 static void
 free_client(struct nfs4_client *clp)
 {
-	while (!list_empty(&clp->cl_sessions)) {
-		struct nfsd4_session *ses;
-		ses = list_entry(clp->cl_sessions.next, struct nfsd4_session,
-				se_perclnt);
-		list_del(&ses->se_perclnt);
+	struct nfsd4_session *ses;
+
+	list_for_each_entry_del(ses, &clp->cl_sessions, se_perclnt) {
 		WARN_ON_ONCE(atomic_read(&ses->se_ref));
 		free_session(ses);
 	}
@@ -2230,16 +2215,12 @@ __destroy_client(struct nfs4_client *clp)
 		list_add(&dp->dl_recall_lru, &reaplist);
 	}
 	spin_unlock(&state_lock);
-	while (!list_empty(&reaplist)) {
-		dp = list_entry(reaplist.next, struct nfs4_delegation, dl_recall_lru);
-		list_del_init(&dp->dl_recall_lru);
+	list_for_each_entry_del_init(dp, &reaplist, dl_recall_lru)
 		destroy_unhashed_deleg(dp);
-	}
-	while (!list_empty(&clp->cl_revoked)) {
-		dp = list_entry(clp->cl_revoked.next, struct nfs4_delegation, dl_recall_lru);
-		list_del_init(&dp->dl_recall_lru);
+
+	list_for_each_entry_del_init(dp, &clp->cl_revoked, dl_recall_lru)
 		nfs4_put_stid(&dp->dl_stid);
-	}
+
 	while (!list_empty(&clp->cl_openowners)) {
 		oo = list_entry(clp->cl_openowners.next, struct nfs4_openowner, oo_perclient);
 		nfs4_get_stateowner(&oo->oo_owner);
@@ -6170,12 +6151,8 @@ nfs4_laundromat(struct nfsd_net *nn)
 		list_add(&dp->dl_recall_lru, &reaplist);
 	}
 	spin_unlock(&state_lock);
-	while (!list_empty(&reaplist)) {
-		dp = list_first_entry(&reaplist, struct nfs4_delegation,
-					dl_recall_lru);
-		list_del_init(&dp->dl_recall_lru);
+	list_for_each_entry_del_init(dp, &reaplist, dl_recall_lru)
 		revoke_delegation(dp);
-	}
 
 	spin_lock(&nn->client_lock);
 	while (!list_empty(&nn->close_lru)) {
@@ -6215,12 +6192,9 @@ nfs4_laundromat(struct nfsd_net *nn)
 	}
 	spin_unlock(&nn->blocked_locks_lock);
 
-	while (!list_empty(&reaplist)) {
-		nbl = list_first_entry(&reaplist,
-					struct nfsd4_blocked_lock, nbl_lru);
-		list_del_init(&nbl->nbl_lru);
+	list_for_each_entry_del_init(nbl, &reaplist, nbl_lru)
 		free_blocked_lock(nbl);
-	}
+
 #ifdef CONFIG_NFSD_V4_2_INTER_SSC
 	/* service the server-to-server copy delayed unmount list */
 	nfsd4_ssc_expire_umount(nn);
@@ -6280,10 +6254,7 @@ deleg_reaper(struct nfsd_net *nn)
 	}
 	spin_unlock(&nn->client_lock);
 
-	while (!list_empty(&cblist)) {
-		clp = list_first_entry(&cblist, struct nfs4_client,
-					cl_ra_cblist);
-		list_del_init(&clp->cl_ra_cblist);
+	list_for_each_entry_del_init(clp, &cblist, cl_ra_cblist) {
 		clp->cl_ra->ra_keep = 0;
 		clp->cl_ra->ra_bmval[0] = BIT(RCA4_TYPE_MASK_RDATA_DLG);
 		trace_nfsd_cb_recall_any(clp->cl_ra);
diff --git a/fs/nfsd/nfscache.c b/fs/nfsd/nfscache.c
index 80621a709510..596e5371d237 100644
--- a/fs/nfsd/nfscache.c
+++ b/fs/nfsd/nfscache.c
@@ -123,9 +123,7 @@ nfsd_cacherep_dispose(struct list_head *dispose)
 	struct nfsd_cacherep *rp;
 	unsigned long freed = 0;
 
-	while (!list_empty(dispose)) {
-		rp = list_first_entry(dispose, struct nfsd_cacherep, c_lru);
-		list_del(&rp->c_lru);
+	list_for_each_entry_del(rp, dispose, c_lru) {
 		nfsd_cacherep_free(rp);
 		freed++;
 	}
diff --git a/fs/nilfs2/gcinode.c b/fs/nilfs2/gcinode.c
index 8beb2730929d..071102336615 100644
--- a/fs/nilfs2/gcinode.c
+++ b/fs/nilfs2/gcinode.c
@@ -181,9 +181,7 @@ void nilfs_remove_all_gcinodes(struct the_nilfs *nilfs)
 	struct list_head *head = &nilfs->ns_gc_inodes;
 	struct nilfs_inode_info *ii;
 
-	while (!list_empty(head)) {
-		ii = list_first_entry(head, struct nilfs_inode_info, i_dirty);
-		list_del_init(&ii->i_dirty);
+	list_for_each_entry_del_init(ii, head, i_dirty) {
 		truncate_inode_pages(&ii->vfs_inode.i_data, 0);
 		nilfs_btnode_cache_clear(ii->i_assoc_inode->i_mapping);
 		iput(&ii->vfs_inode);
diff --git a/fs/nilfs2/mdt.c b/fs/nilfs2/mdt.c
index 19c8158605ed..23b29bdf264f 100644
--- a/fs/nilfs2/mdt.c
+++ b/fs/nilfs2/mdt.c
@@ -612,12 +612,8 @@ static void nilfs_release_frozen_buffers(struct nilfs_shadow_map *shadow)
 	struct list_head *head = &shadow->frozen_buffers;
 	struct buffer_head *bh;
 
-	while (!list_empty(head)) {
-		bh = list_first_entry(head, struct buffer_head,
-				      b_assoc_buffers);
-		list_del_init(&bh->b_assoc_buffers);
+	list_for_each_entry_del_init(bh, head, b_assoc_buffers)
 		brelse(bh); /* drop ref-count to make it releasable */
-	}
 }
 
 /**
diff --git a/fs/nilfs2/recovery.c b/fs/nilfs2/recovery.c
index 0955b657938f..9301bafb04b3 100644
--- a/fs/nilfs2/recovery.c
+++ b/fs/nilfs2/recovery.c
@@ -374,13 +374,10 @@ static int nilfs_scan_dsync_log(struct the_nilfs *nilfs, sector_t start_blocknr,
 
 static void dispose_recovery_list(struct list_head *head)
 {
-	while (!list_empty(head)) {
-		struct nilfs_recovery_block *rb;
+	struct nilfs_recovery_block *rb;
 
-		rb = list_first_entry(head, struct nilfs_recovery_block, list);
-		list_del(&rb->list);
+	list_for_each_entry_del(rb, head, list)
 		kfree(rb);
-	}
 }
 
 struct nilfs_segment_entry {
@@ -403,13 +400,10 @@ static int nilfs_segment_list_add(struct list_head *head, __u64 segnum)
 
 void nilfs_dispose_segment_list(struct list_head *head)
 {
-	while (!list_empty(head)) {
-		struct nilfs_segment_entry *ent;
+	struct nilfs_segment_entry *ent;
 
-		ent = list_first_entry(head, struct nilfs_segment_entry, list);
-		list_del(&ent->list);
+	list_for_each_entry_del(ent, head, list)
 		kfree(ent);
-	}
 }
 
 static int nilfs_prepare_segment_for_recovery(struct the_nilfs *nilfs,
diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index 7ec16879756e..72353b237704 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -1055,12 +1055,9 @@ static int nilfs_segctor_apply_buffers(struct nilfs_sc_info *sci,
 	}
 
  dispose_buffers:
-	while (!list_empty(listp)) {
-		bh = list_first_entry(listp, struct buffer_head,
-				      b_assoc_buffers);
-		list_del_init(&bh->b_assoc_buffers);
+	list_for_each_entry_del_init(bh, listp, b_assoc_buffers)
 		brelse(bh);
-	}
+
 	return err;
 }
 
diff --git a/fs/ocfs2/filecheck.c b/fs/ocfs2/filecheck.c
index 1ad7106741f8..4fa008c53c9d 100644
--- a/fs/ocfs2/filecheck.c
+++ b/fs/ocfs2/filecheck.c
@@ -150,10 +150,7 @@ ocfs2_filecheck_sysfs_free(struct ocfs2_filecheck_sysfs_entry *entry)
 	struct ocfs2_filecheck_entry *p;
 
 	spin_lock(&entry->fs_fcheck->fc_lock);
-	while (!list_empty(&entry->fs_fcheck->fc_head)) {
-		p = list_first_entry(&entry->fs_fcheck->fc_head,
-				     struct ocfs2_filecheck_entry, fe_list);
-		list_del(&p->fe_list);
+	list_for_each_entry_del(p, &entry->fs_fcheck->fc_head, fe_list) {
 		BUG_ON(!p->fe_done); /* To free a undone file check entry */
 		kfree(p);
 	}
diff --git a/fs/pnode.c b/fs/pnode.c
index e4d0340393d5..52434cf4cc43 100644
--- a/fs/pnode.c
+++ b/fs/pnode.c
@@ -82,12 +82,9 @@ static int do_make_slave(struct mount *mnt)
 		master = mnt->mnt_master;
 		if (!master) {
 			struct list_head *p = &mnt->mnt_slave_list;
-			while (!list_empty(p)) {
-				slave_mnt = list_first_entry(p,
-						struct mount, mnt_slave);
-				list_del_init(&slave_mnt->mnt_slave);
+			list_for_each_entry_del_init(slave_mnt, p, mnt_slave)
 				slave_mnt->mnt_master = NULL;
-			}
+
 			return 0;
 		}
 	} else {
@@ -533,14 +530,12 @@ static void umount_list(struct list_head *to_umount,
 
 static void restore_mounts(struct list_head *to_restore)
 {
-	/* Restore mounts to a clean working state */
-	while (!list_empty(to_restore)) {
-		struct mount *mnt, *parent;
-		struct mountpoint *mp;
+	struct mount *mnt, *parent;
+	struct mountpoint *mp;
 
-		mnt = list_first_entry(to_restore, struct mount, mnt_umounting);
+	/* Restore mounts to a clean working state */
+	list_for_each_entry_del_init(mnt, to_restore, mnt_umounting) {
 		CLEAR_MNT_MARK(mnt);
-		list_del_init(&mnt->mnt_umounting);
 
 		/* Should this mount be reparented? */
 		mp = mnt->mnt_mp;
@@ -556,10 +551,9 @@ static void restore_mounts(struct list_head *to_restore)
 
 static void cleanup_umount_visitations(struct list_head *visited)
 {
-	while (!list_empty(visited)) {
-		struct mount *mnt =
-			list_first_entry(visited, struct mount, mnt_umounting);
-		list_del_init(&mnt->mnt_umounting);
+	struct mount *mnt;
+
+	list_for_each_entry_del_init(mnt, visited, mnt_umounting) {
 	}
 }
 
diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 1fb213f379a5..d396b0e43945 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -1535,13 +1535,10 @@ EXPORT_SYMBOL(vmcore_add_device_dump);
 static void vmcore_free_device_dumps(void)
 {
 #ifdef CONFIG_PROC_VMCORE_DEVICE_DUMP
-	mutex_lock(&vmcoredd_mutex);
-	while (!list_empty(&vmcoredd_list)) {
-		struct vmcoredd_node *dump;
+	struct vmcoredd_node *dump;
 
-		dump = list_first_entry(&vmcoredd_list, struct vmcoredd_node,
-					list);
-		list_del(&dump->list);
+	mutex_lock(&vmcoredd_mutex);
+	list_for_each_entry_del(dump, &vmcoredd_list, list) {
 		vfree(dump->buf);
 		vfree(dump);
 	}
@@ -1583,19 +1580,17 @@ fs_initcall(vmcore_init);
 /* Cleanup function for vmcore module. */
 void vmcore_cleanup(void)
 {
+	struct vmcore *m;
+
 	if (proc_vmcore) {
 		proc_remove(proc_vmcore);
 		proc_vmcore = NULL;
 	}
 
 	/* clear the vmcore list. */
-	while (!list_empty(&vmcore_list)) {
-		struct vmcore *m;
-
-		m = list_first_entry(&vmcore_list, struct vmcore, list);
-		list_del(&m->list);
+	list_for_each_entry_del(m, &vmcore_list, list)
 		kfree(m);
-	}
+
 	free_elfcorebuf();
 
 	/* clear vmcore device dump list */
diff --git a/fs/smb/client/smbdirect.c b/fs/smb/client/smbdirect.c
index 94df9eec3d8d..131d2bf3ff87 100644
--- a/fs/smb/client/smbdirect.c
+++ b/fs/smb/client/smbdirect.c
@@ -1234,11 +1234,7 @@ static int allocate_receive_buffers(struct smbd_connection *info, int num_buf)
 	return 0;
 
 allocate_failed:
-	while (!list_empty(&info->receive_queue)) {
-		response = list_first_entry(
-				&info->receive_queue,
-				struct smbd_response, list);
-		list_del(&response->list);
+	list_for_each_entry_del(response, &info->receive_queue, list) {
 		info->count_receive_queue--;
 
 		mempool_free(response, info->response_mempool);
diff --git a/fs/smb/server/crypto_ctx.c b/fs/smb/server/crypto_ctx.c
index 81488d04199d..acc57d58b8fb 100644
--- a/fs/smb/server/crypto_ctx.c
+++ b/fs/smb/server/crypto_ctx.c
@@ -240,13 +240,8 @@ void ksmbd_crypto_destroy(void)
 {
 	struct ksmbd_crypto_ctx *ctx;
 
-	while (!list_empty(&ctx_list.idle_ctx)) {
-		ctx = list_entry(ctx_list.idle_ctx.next,
-				 struct ksmbd_crypto_ctx,
-				 list);
-		list_del(&ctx->list);
+	list_for_each_entry_del(ctx, &ctx_list.idle_ctx, list)
 		ctx_free(ctx);
-	}
 }
 
 int ksmbd_crypto_create(void)
diff --git a/fs/smb/server/mgmt/share_config.c b/fs/smb/server/mgmt/share_config.c
index 328a412259dc..2c231d7dd6c8 100644
--- a/fs/smb/server/mgmt/share_config.c
+++ b/fs/smb/server/mgmt/share_config.c
@@ -34,13 +34,9 @@ static unsigned int share_name_hash(const char *name)
 
 static void kill_share(struct ksmbd_share_config *share)
 {
-	while (!list_empty(&share->veto_list)) {
-		struct ksmbd_veto_pattern *p;
+	struct ksmbd_veto_pattern *p;
 
-		p = list_entry(share->veto_list.next,
-			       struct ksmbd_veto_pattern,
-			       list);
-		list_del(&p->list);
+	list_for_each_entry_del(p, &share->veto_list, list) {
 		kfree(p->pattern);
 		kfree(p);
 	}
diff --git a/fs/ubifs/commit.c b/fs/ubifs/commit.c
index c4fc1047fc07..c051ee2d8b43 100644
--- a/fs/ubifs/commit.c
+++ b/fs/ubifs/commit.c
@@ -710,11 +710,9 @@ int dbg_check_old_index(struct ubifs_info *c, struct ubifs_zbranch *zroot)
 		ubifs_dump_node(c, &i->idx, ubifs_idx_node_sz(c, c->fanout));
 	}
 out_free:
-	while (!list_empty(&list)) {
-		i = list_entry(list.next, struct idx_node, list);
-		list_del(&i->list);
+	list_for_each_entry_del(i, &list, list)
 		kfree(i);
-	}
+
 	ubifs_err(c, "failed, error %d", err);
 	if (err > 0)
 		err = -EINVAL;
diff --git a/fs/ubifs/gc.c b/fs/ubifs/gc.c
index 3134d070fcc0..f6ed9152790f 100644
--- a/fs/ubifs/gc.c
+++ b/fs/ubifs/gc.c
@@ -984,13 +984,10 @@ int ubifs_gc_end_commit(struct ubifs_info *c)
  */
 void ubifs_destroy_idx_gc(struct ubifs_info *c)
 {
-	while (!list_empty(&c->idx_gc)) {
-		struct ubifs_gced_idx_leb *idx_gc;
+	struct ubifs_gced_idx_leb *idx_gc;
 
-		idx_gc = list_entry(c->idx_gc.next, struct ubifs_gced_idx_leb,
-				    list);
+	list_for_each_entry_del(idx_gc, &c->idx_gc, list) {
 		c->idx_gc_cnt -= 1;
-		list_del(&idx_gc->list);
 		kfree(idx_gc);
 	}
 }
diff --git a/fs/ubifs/replay.c b/fs/ubifs/replay.c
index 4211e4456b1e..34b0481440bd 100644
--- a/fs/ubifs/replay.c
+++ b/fs/ubifs/replay.c
@@ -868,11 +868,8 @@ static void destroy_bud_list(struct ubifs_info *c)
 {
 	struct bud_entry *b;
 
-	while (!list_empty(&c->replay_buds)) {
-		b = list_entry(c->replay_buds.next, struct bud_entry, list);
-		list_del(&b->list);
+	list_for_each_entry_del(b, &c->replay_buds, list)
 		kfree(b);
-	}
 }
 
 /**
diff --git a/fs/ubifs/scan.c b/fs/ubifs/scan.c
index 84a9157dcc32..bd87f2be29e6 100644
--- a/fs/ubifs/scan.c
+++ b/fs/ubifs/scan.c
@@ -357,10 +357,8 @@ void ubifs_scan_destroy(struct ubifs_scan_leb *sleb)
 	struct list_head *head;
 
 	head = &sleb->nodes;
-	while (!list_empty(head)) {
-		node = list_entry(head->next, struct ubifs_scan_node, list);
-		list_del(&node->list);
+	list_for_each_entry_del(node, head, list)
 		kfree(node);
-	}
+
 	kfree(sleb);
 }
diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index b08fb28d16b5..27b8720e919c 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -904,9 +904,7 @@ static void free_orphans(struct ubifs_info *c)
 		kfree(orph);
 	}
 
-	while (!list_empty(&c->orph_list)) {
-		orph = list_entry(c->orph_list.next, struct ubifs_orphan, list);
-		list_del(&orph->list);
+	list_for_each_entry_del(orph, &c->orph_list, list) {
 		kfree(orph);
 		ubifs_err(c, "orphan list not empty at unmount");
 	}
@@ -1180,21 +1178,15 @@ static void ubifs_release_options(struct ubifs_info *c)
  */
 static void destroy_journal(struct ubifs_info *c)
 {
-	while (!list_empty(&c->unclean_leb_list)) {
-		struct ubifs_unclean_leb *ucleb;
+	struct ubifs_unclean_leb *ucleb;
+	struct ubifs_bud *bud;
 
-		ucleb = list_entry(c->unclean_leb_list.next,
-				   struct ubifs_unclean_leb, list);
-		list_del(&ucleb->list);
+	list_for_each_entry_del(ucleb, &c->unclean_leb_list, list)
 		kfree(ucleb);
-	}
-	while (!list_empty(&c->old_buds)) {
-		struct ubifs_bud *bud;
 
-		bud = list_entry(c->old_buds.next, struct ubifs_bud, list);
-		list_del(&bud->list);
+	list_for_each_entry_del(bud, &c->old_buds, list)
 		kfree(bud);
-	}
+
 	ubifs_destroy_idx_gc(c);
 	ubifs_destroy_size_tree(c);
 	ubifs_tnc_close(c);
diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index c1ece4a08ff4..e7fe0aa600b1 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -1843,13 +1843,12 @@ xfs_buftarg_drain(
 
 	/* loop until there is nothing left on the lru list. */
 	while (list_lru_count(&btp->bt_lru)) {
+		struct xfs_buf *bp;
+
 		list_lru_walk(&btp->bt_lru, xfs_buftarg_drain_rele,
 			      &dispose, LONG_MAX);
 
-		while (!list_empty(&dispose)) {
-			struct xfs_buf *bp;
-			bp = list_first_entry(&dispose, struct xfs_buf, b_lru);
-			list_del_init(&bp->b_lru);
+		list_for_each_entry_del_init(bp, &dispose, b_lru) {
 			if (bp->b_flags & XBF_WRITE_FAIL) {
 				write_fail = true;
 				xfs_buf_alert_ratelimited(bp,
@@ -1913,6 +1912,7 @@ xfs_buftarg_shrink_scan(
 	struct shrinker		*shrink,
 	struct shrink_control	*sc)
 {
+	struct xfs_buf		*bp;
 	struct xfs_buftarg	*btp = container_of(shrink,
 					struct xfs_buftarg, bt_shrinker);
 	LIST_HEAD(dispose);
@@ -1921,12 +1921,8 @@ xfs_buftarg_shrink_scan(
 	freed = list_lru_shrink_walk(&btp->bt_lru, sc,
 				     xfs_buftarg_isolate, &dispose);
 
-	while (!list_empty(&dispose)) {
-		struct xfs_buf *bp;
-		bp = list_first_entry(&dispose, struct xfs_buf, b_lru);
-		list_del_init(&bp->b_lru);
+	list_for_each_entry_del_init(bp, &dispose, b_lru)
 		xfs_buf_rele(bp);
-	}
 
 	return freed;
 }
@@ -2252,11 +2248,7 @@ xfs_buf_delwri_submit(
 	xfs_buf_delwri_submit_buffers(buffer_list, &wait_list);
 
 	/* Wait for IO to complete. */
-	while (!list_empty(&wait_list)) {
-		bp = list_first_entry(&wait_list, struct xfs_buf, b_list);
-
-		list_del_init(&bp->b_list);
-
+	list_for_each_entry_del_init(bp, &wait_list, b_list) {
 		/*
 		 * Wait on the locked buffer, check for errors and unlock and
 		 * release the delwri queue reference.
diff --git a/fs/xfs/xfs_log_cil.c b/fs/xfs/xfs_log_cil.c
index 67a99d94701e..abe72f0cee2d 100644
--- a/fs/xfs/xfs_log_cil.c
+++ b/fs/xfs/xfs_log_cil.c
@@ -700,11 +700,8 @@ xlog_cil_free_logvec(
 {
 	struct xfs_log_vec	*lv;
 
-	while (!list_empty(lv_chain)) {
-		lv = list_first_entry(lv_chain, struct xfs_log_vec, lv_list);
-		list_del_init(&lv->lv_list);
+	list_for_each_entry_del_init(lv, lv_chain, lv_list)
 		kmem_free(lv);
-	}
 }
 
 /*
@@ -1094,10 +1091,9 @@ static void
 xlog_cil_cleanup_whiteouts(
 	struct list_head	*whiteouts)
 {
-	while (!list_empty(whiteouts)) {
-		struct xfs_log_item *item = list_first_entry(whiteouts,
-						struct xfs_log_item, li_cil);
-		list_del_init(&item->li_cil);
+	struct xfs_log_item *item;
+
+	list_for_each_entry_del_init(item, whiteouts, li_cil) {
 		trace_xfs_cil_whiteout_unpin(item);
 		item->li_ops->iop_unpin(item, 1);
 	}
diff --git a/fs/xfs/xfs_qm.c b/fs/xfs/xfs_qm.c
index 086e78a6143a..acdd6ac8fe18 100644
--- a/fs/xfs/xfs_qm.c
+++ b/fs/xfs/xfs_qm.c
@@ -504,6 +504,7 @@ xfs_qm_shrink_scan(
 	struct shrinker		*shrink,
 	struct shrink_control	*sc)
 {
+	struct xfs_dquot *dqp;
 	struct xfs_quotainfo	*qi = container_of(shrink,
 					struct xfs_quotainfo, qi_shrinker);
 	struct xfs_qm_isolate	isol;
@@ -523,13 +524,8 @@ xfs_qm_shrink_scan(
 	if (error)
 		xfs_warn(NULL, "%s: dquot reclaim failed", __func__);
 
-	while (!list_empty(&isol.dispose)) {
-		struct xfs_dquot	*dqp;
-
-		dqp = list_first_entry(&isol.dispose, struct xfs_dquot, q_lru);
-		list_del_init(&dqp->q_lru);
+	list_for_each_entry_del_init(dqp, &isol.dispose, q_lru)
 		xfs_qm_dqfree_one(dqp);
-	}
 
 	return freed;
 }
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index d839a80a6751..4c66d5f61be7 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -683,11 +683,8 @@ static void io_cqring_overflow_kill(struct io_ring_ctx *ctx)
 	clear_bit(IO_CHECK_CQ_OVERFLOW_BIT, &ctx->check_cq);
 	spin_unlock(&ctx->completion_lock);
 
-	while (!list_empty(&list)) {
-		ocqe = list_first_entry(&list, struct io_overflow_cqe, list);
-		list_del(&ocqe->list);
+	list_for_each_entry_del(ocqe, &list, list)
 		kfree(ocqe);
-	}
 }
 
 static void __io_cqring_overflow_flush(struct io_ring_ctx *ctx)
@@ -3237,9 +3234,7 @@ static __cold bool io_cancel_defer_files(struct io_ring_ctx *ctx,
 	if (list_empty(&list))
 		return false;
 
-	while (!list_empty(&list)) {
-		de = list_first_entry(&list, struct io_defer_entry, list);
-		list_del_init(&de->list);
+	list_for_each_entry_del_init(de, &list, list) {
 		io_req_task_queue_fail(de->req, -ECANCELED);
 		kfree(de);
 	}
diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
index 9123138aa9f4..f1167a896201 100644
--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -254,6 +254,7 @@ static int __io_remove_buffers(struct io_ring_ctx *ctx,
 
 void io_destroy_buffers(struct io_ring_ctx *ctx)
 {
+	struct page *page;
 	struct io_buffer_list *bl;
 	unsigned long index;
 	int i;
@@ -270,13 +271,8 @@ void io_destroy_buffers(struct io_ring_ctx *ctx)
 		kfree(bl);
 	}
 
-	while (!list_empty(&ctx->io_buffers_pages)) {
-		struct page *page;
-
-		page = list_first_entry(&ctx->io_buffers_pages, struct page, lru);
-		list_del_init(&page->lru);
+	list_for_each_entry_del_init(page, &ctx->io_buffers_pages, lru)
 		__free_page(page);
-	}
 }
 
 int io_remove_buffers_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
diff --git a/kernel/audit_tree.c b/kernel/audit_tree.c
index e867c17d3f84..991c3122fca9 100644
--- a/kernel/audit_tree.c
+++ b/kernel/audit_tree.c
@@ -754,6 +754,8 @@ static int tag_mount(struct vfsmount *mnt, void *arg)
 static int prune_tree_thread(void *unused)
 {
 	for (;;) {
+		struct audit_tree *victim;
+
 		if (list_empty(&prune_list)) {
 			set_current_state(TASK_INTERRUPTIBLE);
 			schedule();
@@ -762,12 +764,7 @@ static int prune_tree_thread(void *unused)
 		audit_ctl_lock();
 		mutex_lock(&audit_filter_mutex);
 
-		while (!list_empty(&prune_list)) {
-			struct audit_tree *victim;
-
-			victim = list_entry(prune_list.next,
-					struct audit_tree, list);
-			list_del_init(&victim->list);
+		list_for_each_entry_del_init(victim, &prune_list, list) {
 
 			mutex_unlock(&audit_filter_mutex);
 
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 1eea53050bab..d2d672c593ee 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -729,18 +729,16 @@ int kthreadd(void *unused)
 	cgroup_init_kthreadd();
 
 	for (;;) {
+		struct kthread_create_info *create;
+
 		set_current_state(TASK_INTERRUPTIBLE);
 		if (list_empty(&kthread_create_list))
 			schedule();
 		__set_current_state(TASK_RUNNING);
 
 		spin_lock(&kthread_create_lock);
-		while (!list_empty(&kthread_create_list)) {
-			struct kthread_create_info *create;
-
-			create = list_entry(kthread_create_list.next,
-					    struct kthread_create_info, list);
-			list_del_init(&create->list);
+		list_for_each_entry_del_init(create, &kthread_create_list,
+					     list) {
 			spin_unlock(&kthread_create_lock);
 
 			create_kthread(create);
diff --git a/kernel/padata.c b/kernel/padata.c
index 222d60195de6..63c083bf6c5d 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -352,6 +352,7 @@ static void invoke_padata_reorder(struct work_struct *work)
 
 static void padata_serial_worker(struct work_struct *serial_work)
 {
+	struct padata_priv *padata;
 	struct padata_serial_queue *squeue;
 	struct parallel_data *pd;
 	LIST_HEAD(local_list);
@@ -367,14 +368,7 @@ static void padata_serial_worker(struct work_struct *serial_work)
 
 	cnt = 0;
 
-	while (!list_empty(&local_list)) {
-		struct padata_priv *padata;
-
-		padata = list_entry(local_list.next,
-				    struct padata_priv, list);
-
-		list_del_init(&padata->list);
-
+	list_for_each_entry_del_init(padata, &local_list, list) {
 		padata->serial(padata);
 		cnt++;
 	}
diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
index 336af24e0fe3..7661df05cd03 100644
--- a/kernel/rcu/srcutiny.c
+++ b/kernel/rcu/srcutiny.c
@@ -275,10 +275,6 @@ void __init srcu_init(void)
 	struct srcu_struct *ssp;
 
 	srcu_init_done = true;
-	while (!list_empty(&srcu_boot_list)) {
-		ssp = list_first_entry(&srcu_boot_list,
-				      struct srcu_struct, srcu_work.entry);
-		list_del_init(&ssp->srcu_work.entry);
+	list_for_each_entry_del_init(ssp, &srcu_boot_list, srcu_work.entry)
 		schedule_work(&ssp->srcu_work);
-	}
 }
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 061a30a8925a..68d1a765a52d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9001,12 +9001,8 @@ static void attach_tasks(struct lb_env *env)
 	rq_lock(env->dst_rq, &rf);
 	update_rq_clock(env->dst_rq);
 
-	while (!list_empty(tasks)) {
-		p = list_first_entry(tasks, struct task_struct, se.group_node);
-		list_del_init(&p->se.group_node);
-
+	list_for_each_entry_del_init(p, tasks, se.group_node)
 		attach_task(env->dst_rq, p);
-	}
 
 	rq_unlock(env->dst_rq, &rf);
 }
diff --git a/kernel/signal.c b/kernel/signal.c
index 09019017d669..9319b05daf9e 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -465,11 +465,8 @@ void flush_sigqueue(struct sigpending *queue)
 	struct sigqueue *q;
 
 	sigemptyset(&queue->signal);
-	while (!list_empty(&queue->list)) {
-		q = list_entry(queue->list.next, struct sigqueue , list);
-		list_del_init(&q->list);
+	list_for_each_entry_del_init(q, &queue->list, list)
 		__sigqueue_free(q);
-	}
 }
 
 /*
diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index c4015f30f9fa..857f36bf2fc5 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -1152,16 +1152,14 @@ MODULE_ALIAS_9P("fd");
 
 static void p9_poll_workfn(struct work_struct *work)
 {
+	struct p9_conn *conn;
 	unsigned long flags;
 
 	p9_debug(P9_DEBUG_TRANS, "start %p\n", current);
 
 	spin_lock_irqsave(&p9_poll_lock, flags);
-	while (!list_empty(&p9_poll_pending_list)) {
-		struct p9_conn *conn = list_first_entry(&p9_poll_pending_list,
-							struct p9_conn,
-							poll_pending_link);
-		list_del_init(&conn->poll_pending_link);
+	list_for_each_entry_del_init(conn, &p9_poll_pending_list,
+				     poll_pending_link) {
 		spin_unlock_irqrestore(&p9_poll_lock, flags);
 
 		p9_poll_mux(conn);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 17ca13e8c044..63c7ff82f50a 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1879,11 +1879,8 @@ static void l2cap_unregister_all_users(struct l2cap_conn *conn)
 {
 	struct l2cap_user *user;
 
-	while (!list_empty(&conn->users)) {
-		user = list_first_entry(&conn->users, struct l2cap_user, list);
-		list_del_init(&user->list);
+	list_for_each_entry_del_init(user, &conn->users, list)
 		user->remove(conn, user);
-	}
 }
 
 static void l2cap_conn_del(struct hci_conn *hcon, int err)
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index d3a759e052c8..e4a0f42d255d 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -3445,6 +3445,7 @@ static int linger_notify_finish_wait(struct ceph_osd_linger_request *lreq,
  */
 static void handle_timeout(struct work_struct *work)
 {
+	struct ceph_osd *osd;
 	struct ceph_osd_client *osdc =
 		container_of(work, struct ceph_osd_client, timeout_work.work);
 	struct ceph_options *opts = osdc->client->options;
@@ -3519,13 +3520,8 @@ static void handle_timeout(struct work_struct *work)
 	if (atomic_read(&osdc->num_homeless) || !list_empty(&slow_osds))
 		maybe_request_map(osdc);
 
-	while (!list_empty(&slow_osds)) {
-		struct ceph_osd *osd = list_first_entry(&slow_osds,
-							struct ceph_osd,
-							o_keepalive_item);
-		list_del_init(&osd->o_keepalive_item);
+	list_for_each_entry_del_init(osd, &slow_osds, o_keepalive_item)
 		ceph_con_keepalive(&osd->o_con);
-	}
 
 	up_write(&osdc->lock);
 	schedule_delayed_work(&osdc->timeout_work,
diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index 295098873861..047d92d3a693 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -1034,12 +1034,9 @@ static void cleanup_workspace_manager(struct workspace_manager *wsm)
 {
 	struct crush_work *work;
 
-	while (!list_empty(&wsm->idle_ws)) {
-		work = list_first_entry(&wsm->idle_ws, struct crush_work,
-					item);
-		list_del_init(&work->item);
+	list_for_each_entry_del_init(work, &wsm->idle_ws, item)
 		free_workspace(work);
-	}
+
 	atomic_set(&wsm->total_ws, 0);
 	wsm->free_ws = 0;
 }
diff --git a/net/ceph/pagelist.c b/net/ceph/pagelist.c
index 74622b278d57..a0c2d5cc2b92 100644
--- a/net/ceph/pagelist.c
+++ b/net/ceph/pagelist.c
@@ -37,15 +37,13 @@ static void ceph_pagelist_unmap_tail(struct ceph_pagelist *pl)
 
 void ceph_pagelist_release(struct ceph_pagelist *pl)
 {
+	struct page *page;
+
 	if (!refcount_dec_and_test(&pl->refcnt))
 		return;
 	ceph_pagelist_unmap_tail(pl);
-	while (!list_empty(&pl->head)) {
-		struct page *page = list_first_entry(&pl->head, struct page,
-						     lru);
-		list_del(&page->lru);
+	list_for_each_entry_del(page, &pl->head, lru)
 		__free_page(page);
-	}
 	ceph_pagelist_free_reserve(pl);
 	kfree(pl);
 }
@@ -120,10 +118,9 @@ EXPORT_SYMBOL(ceph_pagelist_reserve);
 /* Free any pages that have been preallocated. */
 int ceph_pagelist_free_reserve(struct ceph_pagelist *pl)
 {
-	while (!list_empty(&pl->free_list)) {
-		struct page *page = list_first_entry(&pl->free_list,
-						     struct page, lru);
-		list_del(&page->lru);
+	struct page *page;
+
+	list_for_each_entry_del(page, &pl->free_list, lru) {
 		__free_page(page);
 		--pl->num_pages_free;
 	}
diff --git a/net/core/dev.c b/net/core/dev.c
index 5aaf5753d4e4..0e691eb4afd3 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10403,13 +10403,8 @@ void netdev_run_todo(void)
 
 	list_replace_init(&net_unlink_list, &unlink_list);
 
-	while (!list_empty(&unlink_list)) {
-		struct net_device *dev = list_first_entry(&unlink_list,
-							  struct net_device,
-							  unlink_list);
-		list_del_init(&dev->unlink_list);
+	list_for_each_entry_del_init(dev, &unlink_list, unlink_list)
 		dev->nested_level = dev->lower_level - 1;
-	}
 #endif
 
 	/* Snapshot list, allow later requests */
@@ -11166,6 +11161,7 @@ EXPORT_SYMBOL_GPL(__dev_change_net_namespace);
 
 static int dev_cpu_dead(unsigned int oldcpu)
 {
+	struct napi_struct *napi;
 	struct sk_buff **list_skb;
 	struct sk_buff *skb;
 	unsigned int cpu;
@@ -11195,12 +11191,7 @@ static int dev_cpu_dead(unsigned int oldcpu)
 	 * process_backlog() must be called by cpu owning percpu backlog.
 	 * We properly handle process_queue & input_pkt_queue later.
 	 */
-	while (!list_empty(&oldsd->poll_list)) {
-		struct napi_struct *napi = list_first_entry(&oldsd->poll_list,
-							    struct napi_struct,
-							    poll_list);
-
-		list_del_init(&napi->poll_list);
+	list_for_each_entry_del_init(napi, &oldsd->poll_list, poll_list) {
 		if (napi->poll == process_backlog)
 			napi->state = 0;
 		else
diff --git a/net/handshake/netlink.c b/net/handshake/netlink.c
index d0bc1dd8e65a..edfb04c38ee5 100644
--- a/net/handshake/netlink.c
+++ b/net/handshake/netlink.c
@@ -228,10 +228,7 @@ static void __net_exit handshake_net_exit(struct net *net)
 	list_splice_init(&requests, &hn->hn_requests);
 	spin_unlock(&hn->hn_lock);
 
-	while (!list_empty(&requests)) {
-		req = list_first_entry(&requests, struct handshake_req, hr_list);
-		list_del(&req->hr_list);
-
+	list_for_each_entry_del(req, &requests, hr_list) {
 		/*
 		 * Requests on this list have not yet been
 		 * accepted, so they do not have an fd to put.
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 0b6ee962c84e..4076f2e989ea 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -825,10 +825,7 @@ static void dev_forward_change(struct inet6_dev *idev)
 	}
 	read_unlock_bh(&idev->lock);
 
-	while (!list_empty(&tmp_addr_list)) {
-		ifa = list_first_entry(&tmp_addr_list,
-				       struct inet6_ifaddr, if_list_aux);
-		list_del(&ifa->if_list_aux);
+	list_for_each_entry_del(ifa, &tmp_addr_list, if_list_aux) {
 		if (idev->cnf.forwarding)
 			addrconf_join_anycast(ifa);
 		else
@@ -3858,10 +3855,7 @@ static int addrconf_ifdown(struct net_device *dev, bool unregister)
 		idev->if_flags &= ~(IF_RS_SENT|IF_RA_RCVD|IF_READY);
 
 	/* Step 3: clear tempaddr list */
-	while (!list_empty(&idev->tempaddr_list)) {
-		ifa = list_first_entry(&idev->tempaddr_list,
-				       struct inet6_ifaddr, tmp_list);
-		list_del(&ifa->tmp_list);
+	list_for_each_entry_del(ifa, &idev->tempaddr_list, tmp_list) {
 		write_unlock_bh(&idev->lock);
 		spin_lock_bh(&ifa->lock);
 
@@ -3878,14 +3872,10 @@ static int addrconf_ifdown(struct net_device *dev, bool unregister)
 		list_add_tail(&ifa->if_list_aux, &tmp_addr_list);
 	write_unlock_bh(&idev->lock);
 
-	while (!list_empty(&tmp_addr_list)) {
+	list_for_each_entry_del(ifa, &tmp_addr_list, if_list_aux) {
 		struct fib6_info *rt = NULL;
 		bool keep;
 
-		ifa = list_first_entry(&tmp_addr_list,
-				       struct inet6_ifaddr, if_list_aux);
-		list_del(&ifa->if_list_aux);
-
 		addrconf_del_dad_work(ifa);
 
 		keep = keep_addr && (ifa->flags & IFA_F_PERMANENT) &&
diff --git a/net/mac80211/ibss.c b/net/mac80211/ibss.c
index 5542c93edfba..278fc63d5996 100644
--- a/net/mac80211/ibss.c
+++ b/net/mac80211/ibss.c
@@ -698,10 +698,7 @@ static void ieee80211_ibss_disconnect(struct ieee80211_sub_if_data *sdata)
 	sta_info_flush(sdata);
 
 	spin_lock_bh(&ifibss->incomplete_lock);
-	while (!list_empty(&ifibss->incomplete_stations)) {
-		sta = list_first_entry(&ifibss->incomplete_stations,
-				       struct sta_info, list);
-		list_del(&sta->list);
+	list_for_each_entry_del(sta, &ifibss->incomplete_stations, list) {
 		spin_unlock_bh(&ifibss->incomplete_lock);
 
 		sta_info_free(local, sta);
@@ -1692,10 +1689,7 @@ void ieee80211_ibss_work(struct ieee80211_sub_if_data *sdata)
 		goto out;
 
 	spin_lock_bh(&ifibss->incomplete_lock);
-	while (!list_empty(&ifibss->incomplete_stations)) {
-		sta = list_first_entry(&ifibss->incomplete_stations,
-				       struct sta_info, list);
-		list_del(&sta->list);
+	list_for_each_entry_del(sta, &ifibss->incomplete_stations, list) {
 		spin_unlock_bh(&ifibss->incomplete_lock);
 
 		ieee80211_ibss_finish_sta(sta);
diff --git a/net/mac80211/ocb.c b/net/mac80211/ocb.c
index b44896e14522..e0aee270ab2d 100644
--- a/net/mac80211/ocb.c
+++ b/net/mac80211/ocb.c
@@ -130,10 +130,7 @@ void ieee80211_ocb_work(struct ieee80211_sub_if_data *sdata)
 	sdata_lock(sdata);
 
 	spin_lock_bh(&ifocb->incomplete_lock);
-	while (!list_empty(&ifocb->incomplete_stations)) {
-		sta = list_first_entry(&ifocb->incomplete_stations,
-				       struct sta_info, list);
-		list_del(&sta->list);
+	list_for_each_entry_del(sta, &ifocb->incomplete_stations, list) {
 		spin_unlock_bh(&ifocb->incomplete_lock);
 
 		ieee80211_ocb_finish_sta(sta);
@@ -213,10 +210,7 @@ int ieee80211_ocb_leave(struct ieee80211_sub_if_data *sdata)
 	sta_info_flush(sdata);
 
 	spin_lock_bh(&ifocb->incomplete_lock);
-	while (!list_empty(&ifocb->incomplete_stations)) {
-		sta = list_first_entry(&ifocb->incomplete_stations,
-				       struct sta_info, list);
-		list_del(&sta->list);
+	list_for_each_entry_del(sta, &ifocb->incomplete_stations, list) {
 		spin_unlock_bh(&ifocb->incomplete_lock);
 
 		sta_info_free(local, sta);
diff --git a/net/rds/send.c b/net/rds/send.c
index 5e57a1581dc6..d0675b91245e 100644
--- a/net/rds/send.c
+++ b/net/rds/send.c
@@ -608,13 +608,9 @@ static void rds_send_remove_from_sock(struct list_head *messages, int status)
 	struct rds_sock *rs = NULL;
 	struct rds_message *rm;
 
-	while (!list_empty(messages)) {
+	list_for_each_entry_del_init(rm, messages, m_conn_item) {
 		int was_on_sock = 0;
 
-		rm = list_entry(messages->next, struct rds_message,
-				m_conn_item);
-		list_del_init(&rm->m_conn_item);
-
 		/*
 		 * If we see this flag cleared then we're *sure* that someone
 		 * else beat us to removing it from the sock.  If we race
@@ -788,9 +784,7 @@ void rds_send_drop_to(struct rds_sock *rs, struct sockaddr_in6 *dest)
 
 	rds_wake_sk_sleep(rs);
 
-	while (!list_empty(&list)) {
-		rm = list_entry(list.next, struct rds_message, m_sock_item);
-		list_del_init(&rm->m_sock_item);
+	list_for_each_entry_del_init(rm, &list, m_sock_item) {
 		rds_message_wait(rm);
 
 		/* just in case the code above skipped this message
diff --git a/net/rxrpc/call_object.c b/net/rxrpc/call_object.c
index 773eecd1e979..4c6c5d8814d7 100644
--- a/net/rxrpc/call_object.c
+++ b/net/rxrpc/call_object.c
@@ -613,10 +613,7 @@ void rxrpc_release_calls_on_socket(struct rxrpc_sock *rx)
 
 	_enter("%p", rx);
 
-	while (!list_empty(&rx->to_be_accepted)) {
-		call = list_entry(rx->to_be_accepted.next,
-				  struct rxrpc_call, accept_link);
-		list_del(&call->accept_link);
+	list_for_each_entry_del(call, &rx->to_be_accepted, accept_link) {
 		rxrpc_propose_abort(call, RX_CALL_DEAD, -ECONNRESET,
 				    rxrpc_abort_call_sock_release_tba);
 		rxrpc_put_call(call, rxrpc_call_put_release_sock_tba);
diff --git a/net/rxrpc/conn_object.c b/net/rxrpc/conn_object.c
index ac85d4644a3c..dce3855202eb 100644
--- a/net/rxrpc/conn_object.c
+++ b/net/rxrpc/conn_object.c
@@ -441,11 +441,7 @@ void rxrpc_service_connection_reaper(struct work_struct *work)
 		rxrpc_set_service_reap_timer(rxnet, earliest);
 	}
 
-	while (!list_empty(&graveyard)) {
-		conn = list_entry(graveyard.next, struct rxrpc_connection,
-				  link);
-		list_del_init(&conn->link);
-
+	list_for_each_entry_del_init(conn, &graveyard, link) {
 		ASSERTCMP(atomic_read(&conn->active), ==, -1);
 		rxrpc_put_connection(conn, rxrpc_conn_put_service_reaped);
 	}
diff --git a/net/rxrpc/peer_event.c b/net/rxrpc/peer_event.c
index 552ba84a255c..876c649be7f8 100644
--- a/net/rxrpc/peer_event.c
+++ b/net/rxrpc/peer_event.c
@@ -240,11 +240,7 @@ static void rxrpc_peer_keepalive_dispatch(struct rxrpc_net *rxnet,
 
 	spin_lock(&rxnet->peer_hash_lock);
 
-	while (!list_empty(collector)) {
-		peer = list_entry(collector->next,
-				  struct rxrpc_peer, keepalive_link);
-
-		list_del_init(&peer->keepalive_link);
+	list_for_each_entry_del_init(peer, collector, keepalive_link) {
 		if (!rxrpc_get_peer_maybe(peer, rxrpc_peer_get_keepalive))
 			continue;
 
diff --git a/net/sunrpc/auth.c b/net/sunrpc/auth.c
index 814b0169f972..2e0d2736059c 100644
--- a/net/sunrpc/auth.c
+++ b/net/sunrpc/auth.c
@@ -328,11 +328,8 @@ void rpcauth_destroy_credlist(struct list_head *head)
 {
 	struct rpc_cred *cred;
 
-	while (!list_empty(head)) {
-		cred = list_entry(head->next, struct rpc_cred, cr_lru);
-		list_del_init(&cred->cr_lru);
+	list_for_each_entry_del_init(cred, head, cr_lru)
 		put_rpccred(cred);
-	}
 }
 
 static void
diff --git a/net/sunrpc/backchannel_rqst.c b/net/sunrpc/backchannel_rqst.c
index 65a6c6429a53..538450dea3bd 100644
--- a/net/sunrpc/backchannel_rqst.c
+++ b/net/sunrpc/backchannel_rqst.c
@@ -179,13 +179,8 @@ int xprt_setup_bc(struct rpc_xprt *xprt, unsigned int min_reqs)
 	/*
 	 * Memory allocation failed, free the temporary list
 	 */
-	while (!list_empty(&tmp_list)) {
-		req = list_first_entry(&tmp_list,
-				struct rpc_rqst,
-				rq_bc_pa_list);
-		list_del(&req->rq_bc_pa_list);
+	list_for_each_entry_del(req, &tmp_list, rq_bc_pa_list)
 		xprt_free_allocation(req);
-	}
 
 	dprintk("RPC:       setup backchannel transport failed\n");
 	return -ENOMEM;
diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
index 95ff74706104..48e0c256241f 100644
--- a/net/sunrpc/cache.c
+++ b/net/sunrpc/cache.c
@@ -746,11 +746,8 @@ static void cache_revisit_request(struct cache_head *item)
 
 	spin_unlock(&cache_defer_lock);
 
-	while (!list_empty(&pending)) {
-		dreq = list_entry(pending.next, struct cache_deferred_req, recent);
-		list_del_init(&dreq->recent);
+	list_for_each_entry_del_init(dreq, &pending, recent)
 		dreq->revisit(dreq, 0);
-	}
 }
 
 void cache_clean_deferred(void *owner)
@@ -770,11 +767,8 @@ void cache_clean_deferred(void *owner)
 	}
 	spin_unlock(&cache_defer_lock);
 
-	while (!list_empty(&pending)) {
-		dreq = list_entry(pending.next, struct cache_deferred_req, recent);
-		list_del_init(&dreq->recent);
+	list_for_each_entry_del_init(dreq, &pending, recent)
 		dreq->revisit(dreq, 1);
-	}
 }
 
 /*
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 4cfe9640df48..15e78a1eb723 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -987,10 +987,7 @@ void svc_age_temp_xprts_now(struct svc_serv *serv, struct sockaddr *server_addr)
 	}
 	spin_unlock_bh(&serv->sv_lock);
 
-	while (!list_empty(&to_be_closed)) {
-		le = to_be_closed.next;
-		list_del_init(le);
-		xprt = list_entry(le, struct svc_xprt, xpt_list);
+	list_for_each_entry_del_init(xprt, &to_be_closed, xpt_list) {
 		set_bit(XPT_CLOSE, &xprt->xpt_flags);
 		set_bit(XPT_KILL_TEMP, &xprt->xpt_flags);
 		dprintk("svc_age_temp_xprts_now: queuing xprt %p for closing\n",
@@ -1005,11 +1002,8 @@ static void call_xpt_users(struct svc_xprt *xprt)
 	struct svc_xpt_user *u;
 
 	spin_lock(&xprt->xpt_lock);
-	while (!list_empty(&xprt->xpt_users)) {
-		u = list_first_entry(&xprt->xpt_users, struct svc_xpt_user, list);
-		list_del_init(&u->list);
+	list_for_each_entry_del_init(u, &xprt->xpt_users, list)
 		u->callback(u);
-	}
 	spin_unlock(&xprt->xpt_lock);
 }
 
diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
index ab453ede54f0..d41b2b7cb081 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -1770,11 +1770,8 @@ EXPORT_SYMBOL_GPL(xprt_free_slot);
 static void xprt_free_all_slots(struct rpc_xprt *xprt)
 {
 	struct rpc_rqst *req;
-	while (!list_empty(&xprt->free)) {
-		req = list_first_entry(&xprt->free, struct rpc_rqst, rq_list);
-		list_del(&req->rq_list);
+	list_for_each_entry_del(req, &xprt->free, rq_list)
 		kfree(req);
-	}
 }
 
 static DEFINE_IDA(rpc_xprt_ids);
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 28c0771c4e8c..9d4ed2cb5bbf 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -1140,16 +1140,11 @@ static void rpcrdma_mrs_destroy(struct rpcrdma_xprt *r_xprt)
 void
 rpcrdma_buffer_destroy(struct rpcrdma_buffer *buf)
 {
+	struct rpcrdma_req *req;
 	rpcrdma_reps_destroy(buf);
 
-	while (!list_empty(&buf->rb_send_bufs)) {
-		struct rpcrdma_req *req;
-
-		req = list_first_entry(&buf->rb_send_bufs,
-				       struct rpcrdma_req, rl_list);
-		list_del(&req->rl_list);
+	list_for_each_entry_del(req, &buf->rb_send_bufs, rl_list)
 		rpcrdma_req_destroy(req);
-	}
 }
 
 /**
diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
index b370070194fa..eb5ceb9bdc08 100644
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -1594,12 +1594,9 @@ static int vmci_transport_socket_init(struct vsock_sock *vsk,
 
 static void vmci_transport_free_resources(struct list_head *transport_list)
 {
-	while (!list_empty(transport_list)) {
-		struct vmci_transport *transport =
-		    list_first_entry(transport_list, struct vmci_transport,
-				     elem);
-		list_del(&transport->elem);
+	struct vmci_transport *transport;
 
+	list_for_each_entry_del(transport, transport_list, elem) {
 		if (transport->detach_sub_id != VMCI_INVALID_ID) {
 			vmci_event_unsubscribe(transport->detach_sub_id);
 			transport->detach_sub_id = VMCI_INVALID_ID;
diff --git a/net/wireless/core.c b/net/wireless/core.c
index 64e861617110..3386ed5f68fb 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -1051,18 +1051,14 @@ EXPORT_SYMBOL(wiphy_rfkill_start_polling);
 
 void cfg80211_process_wiphy_works(struct cfg80211_registered_device *rdev)
 {
+	struct wiphy_work *wk;
 	unsigned int runaway_limit = 100;
 	unsigned long flags;
 
 	lockdep_assert_held(&rdev->wiphy.mtx);
 
 	spin_lock_irqsave(&rdev->wiphy_work_lock, flags);
-	while (!list_empty(&rdev->wiphy_work_list)) {
-		struct wiphy_work *wk;
-
-		wk = list_first_entry(&rdev->wiphy_work_list,
-				      struct wiphy_work, entry);
-		list_del_init(&wk->entry);
+	list_for_each_entry_del_init(wk, &rdev->wiphy_work_list, entry) {
 		spin_unlock_irqrestore(&rdev->wiphy_work_lock, flags);
 
 		wk->func(&rdev->wiphy, wk);
diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 0317cf9da307..de64008f741e 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -487,12 +487,7 @@ static void reg_regdb_apply(struct work_struct *work)
 	rtnl_lock();
 
 	mutex_lock(&reg_regdb_apply_mutex);
-	while (!list_empty(&reg_regdb_apply_list)) {
-		request = list_first_entry(&reg_regdb_apply_list,
-					   struct reg_regdb_apply_request,
-					   list);
-		list_del(&request->list);
-
+	list_for_each_entry_del(request, &reg_regdb_apply_list, list) {
 		set_regdom(request->regdom, REGD_SOURCE_INTERNAL_DB);
 		kfree(request);
 	}
diff --git a/net/wireless/util.c b/net/wireless/util.c
index 1783ab9d57a3..6ac1b4dedb77 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -1038,10 +1038,7 @@ void cfg80211_process_wdev_events(struct wireless_dev *wdev)
 	unsigned long flags;
 
 	spin_lock_irqsave(&wdev->event_lock, flags);
-	while (!list_empty(&wdev->event_list)) {
-		ev = list_first_entry(&wdev->event_list,
-				      struct cfg80211_event, list);
-		list_del(&ev->list);
+	list_for_each_entry_del(ev, &wdev->event_list, list) {
 		spin_unlock_irqrestore(&wdev->event_lock, flags);
 
 		wdev_lock(wdev);
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 108eccc5ada5..ef419b71ce92 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1710,10 +1710,7 @@ static void destroy_buffers(void)
 	union aa_buffer *aa_buf;
 
 	spin_lock(&aa_buffers_lock);
-	while (!list_empty(&aa_global_buffers)) {
-		aa_buf = list_first_entry(&aa_global_buffers, union aa_buffer,
-					 list);
-		list_del(&aa_buf->list);
+	list_for_each_entry_del(aa_buf, &aa_global_buffers, list) {
 		spin_unlock(&aa_buffers_lock);
 		kfree(aa_buf);
 		spin_lock(&aa_buffers_lock);
diff --git a/sound/core/misc.c b/sound/core/misc.c
index d32a19976a2b..f7769582975d 100644
--- a/sound/core/misc.c
+++ b/sound/core/misc.c
@@ -173,9 +173,7 @@ static void snd_fasync_work_fn(struct work_struct *work)
 	struct snd_fasync *fasync;
 
 	spin_lock_irq(&snd_fasync_lock);
-	while (!list_empty(&snd_fasync_list)) {
-		fasync = list_first_entry(&snd_fasync_list, struct snd_fasync, list);
-		list_del_init(&fasync->list);
+	list_for_each_entry_del_init(fasync, &snd_fasync_list, list) {
 		spin_unlock_irq(&snd_fasync_lock);
 		if (fasync->on)
 			kill_fasync(&fasync->fasync, fasync->signal, fasync->poll);
diff --git a/sound/core/rawmidi.c b/sound/core/rawmidi.c
index 1431cb997808..cd1179369e58 100644
--- a/sound/core/rawmidi.c
+++ b/sound/core/rawmidi.c
@@ -1970,11 +1970,8 @@ static void snd_rawmidi_free_substreams(struct snd_rawmidi_str *stream)
 {
 	struct snd_rawmidi_substream *substream;
 
-	while (!list_empty(&stream->substreams)) {
-		substream = list_entry(stream->substreams.next, struct snd_rawmidi_substream, list);
-		list_del(&substream->list);
+	list_for_each_entry_del(substream, &stream->substreams, list)
 		kfree(substream);
-	}
 }
 
 /* called from ump.c, too */
diff --git a/sound/core/timer.c b/sound/core/timer.c
index e6e551d4a29e..04c202babf1b 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -779,13 +779,8 @@ static void snd_timer_process_callbacks(struct snd_timer *timer,
 	struct snd_timer_instance *ti;
 	unsigned long resolution, ticks;
 
-	while (!list_empty(head)) {
-		ti = list_first_entry(head, struct snd_timer_instance,
-				      ack_list);
-
-		/* remove from ack_list and make empty */
-		list_del_init(&ti->ack_list);
-
+	/* remove from ack_list and make empty */
+	list_for_each_entry_del_init(ti, head, ack_list) {
 		if (!(ti->flags & SNDRV_TIMER_IFLG_DEAD)) {
 			ticks = ti->pticks;
 			ti->pticks = 0;
diff --git a/sound/core/ump.c b/sound/core/ump.c
index 3bef1944e955..0a1fcaf7b072 100644
--- a/sound/core/ump.c
+++ b/sound/core/ump.c
@@ -74,10 +74,7 @@ static void snd_ump_endpoint_free(struct snd_rawmidi *rmidi)
 	struct snd_ump_endpoint *ump = rawmidi_to_ump(rmidi);
 	struct snd_ump_block *fb;
 
-	while (!list_empty(&ump->block_list)) {
-		fb = list_first_entry(&ump->block_list, struct snd_ump_block,
-				      list);
-		list_del(&fb->list);
+	list_for_each_entry_del(fb, &ump->block_list, list) {
 		if (fb->private_free)
 			fb->private_free(fb);
 		kfree(fb);
diff --git a/sound/hda/ext/hdac_ext_controller.c b/sound/hda/ext/hdac_ext_controller.c
index 6199bb60ccf0..fff6e1382859 100644
--- a/sound/hda/ext/hdac_ext_controller.c
+++ b/sound/hda/ext/hdac_ext_controller.c
@@ -117,11 +117,8 @@ void snd_hdac_ext_link_free_all(struct hdac_bus *bus)
 {
 	struct hdac_ext_link *hlink;
 
-	while (!list_empty(&bus->hlink_list)) {
-		hlink = list_first_entry(&bus->hlink_list, struct hdac_ext_link, list);
-		list_del(&hlink->list);
+	list_for_each_entry_del(hlink, &bus->hlink_list, list)
 		kfree(hlink);
-	}
 }
 EXPORT_SYMBOL_GPL(snd_hdac_ext_link_free_all);
 
diff --git a/sound/pci/ctxfi/ctimap.c b/sound/pci/ctxfi/ctimap.c
index d5a53d2f5f15..db3b126e757d 100644
--- a/sound/pci/ctxfi/ctimap.c
+++ b/sound/pci/ctxfi/ctimap.c
@@ -96,13 +96,8 @@ int input_mapper_delete(struct list_head *mappers, struct imapper *entry,
 void free_input_mapper_list(struct list_head *head)
 {
 	struct imapper *entry;
-	struct list_head *pos;
 
-	while (!list_empty(head)) {
-		pos = head->next;
-		list_del(pos);
-		entry = list_entry(pos, struct imapper, list);
+	list_for_each_entry_del(entry, head, list)
 		kfree(entry);
-	}
 }
 
diff --git a/sound/pci/ctxfi/ctvmem.c b/sound/pci/ctxfi/ctvmem.c
index 7a805c4a58e1..1a863691e127 100644
--- a/sound/pci/ctxfi/ctvmem.c
+++ b/sound/pci/ctxfi/ctvmem.c
@@ -215,22 +215,14 @@ int ct_vm_create(struct ct_vm **rvm, struct pci_dev *pci)
 void ct_vm_destroy(struct ct_vm *vm)
 {
 	int i;
-	struct list_head *pos;
 	struct ct_vm_block *entry;
 
 	/* free used and unused list nodes */
-	while (!list_empty(&vm->used)) {
-		pos = vm->used.next;
-		list_del(pos);
-		entry = list_entry(pos, struct ct_vm_block, list);
+	list_for_each_entry_del(entry, &vm->used, list)
 		kfree(entry);
-	}
-	while (!list_empty(&vm->unused)) {
-		pos = vm->unused.next;
-		list_del(pos);
-		entry = list_entry(pos, struct ct_vm_block, list);
+
+	list_for_each_entry_del(entry, &vm->unused, list)
 		kfree(entry);
-	}
 
 	/* free allocated page table pages */
 	for (i = 0; i < CT_PTP_NUM; i++)
diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 33af707a65ab..5069878fc752 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -120,12 +120,10 @@ static int add_conn_list(struct hda_codec *codec, hda_nid_t nid, int len,
 
 static void remove_conn_list(struct hda_codec *codec)
 {
-	while (!list_empty(&codec->conn_list)) {
-		struct hda_conn_list *p;
-		p = list_first_entry(&codec->conn_list, typeof(*p), list);
-		list_del(&p->list);
+	struct hda_conn_list *p;
+
+	list_for_each_entry_del(p, &codec->conn_list, list)
 		kfree(p);
-	}
 }
 
 /* read the connection and add to the cache */
diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index 406779625fb5..732ff038788a 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -1317,10 +1317,7 @@ void azx_free_streams(struct azx *chip)
 	struct hdac_bus *bus = azx_bus(chip);
 	struct hdac_stream *s;
 
-	while (!list_empty(&bus->stream_list)) {
-		s = list_first_entry(&bus->stream_list, struct hdac_stream, list);
-		list_del(&s->list);
+	list_for_each_entry_del(s, &bus->stream_list, list)
 		kfree(stream_to_azx_dev(s));
-	}
 }
 EXPORT_SYMBOL_GPL(azx_free_streams);
diff --git a/sound/soc/codecs/wm0010.c b/sound/soc/codecs/wm0010.c
index 1d4259433f47..c65171564926 100644
--- a/sound/soc/codecs/wm0010.c
+++ b/sound/soc/codecs/wm0010.c
@@ -478,12 +478,9 @@ static int wm0010_firmware_load(const char *name, struct snd_soc_component *comp
 	ret = 0;
 
 abort1:
-	while (!list_empty(&xfer_list)) {
-		xfer = list_first_entry(&xfer_list, struct wm0010_boot_xfer,
-					list);
+	list_for_each_entry_del(xfer, &xfer_list, list) {
 		kfree(xfer->t.rx_buf);
 		kfree(xfer->t.tx_buf);
-		list_del(&xfer->list);
 		kfree(xfer);
 	}
 
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 54704250c0a2..c5b28cea8a10 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1317,10 +1317,7 @@ void dpcm_be_disconnect(struct snd_soc_pcm_runtime *fe, int stream)
 	}
 	snd_soc_dpcm_stream_unlock_irq(fe, stream);
 
-	while (!list_empty(&deleted_dpcms)) {
-		dpcm = list_first_entry(&deleted_dpcms, struct snd_soc_dpcm,
-					list_fe);
-		list_del(&dpcm->list_fe);
+	list_for_each_entry_del(dpcm, &deleted_dpcms, list_fe) {
 		dpcm_remove_debugfs_state(dpcm);
 		kfree(dpcm);
 	}
diff --git a/sound/usb/midi2.c b/sound/usb/midi2.c
index 1ec177fe284e..95682bdee3e6 100644
--- a/sound/usb/midi2.c
+++ b/sound/usb/midi2.c
@@ -692,12 +692,8 @@ static void free_all_midi2_umps(struct snd_usb_midi2_interface *umidi)
 {
 	struct snd_usb_midi2_ump *rmidi;
 
-	while (!list_empty(&umidi->rawmidi_list)) {
-		rmidi = list_first_entry(&umidi->rawmidi_list,
-					 struct snd_usb_midi2_ump, list);
-		list_del(&rmidi->list);
+	list_for_each_entry_del(rmidi, &umidi->rawmidi_list, list)
 		kfree(rmidi);
-	}
 }
 
 static int create_midi2_ump(struct snd_usb_midi2_interface *umidi,
-- 
2.41.0

