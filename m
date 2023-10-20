Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20BF67D0D1D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 12:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376863AbjJTKaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 06:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376713AbjJTK34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 06:29:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313B8D66
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 03:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697797747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=//3SbJJeNcWFwjwSbQdPSDoOVfnJ62EKjrp2h08jTc8=;
        b=MHoD1OMtFpGC7lMMLRTqp0S+PwUGLp4T8Aopw4l8O3Nbff0NMDOgoVC+XX+43eiDydArqy
        z0uKP/44BewEWJ1U7mHpeq2B0FNpxZwO4FxkA5T9//6MwUhInBByIc+e1X+2fOmnrtImhc
        XkuBoA6S95F8kmBNgH4DrsqZ2TmVXT8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-oG7xcKPFMOO9-Fx7kIpkwQ-1; Fri, 20 Oct 2023 06:29:05 -0400
X-MC-Unique: oG7xcKPFMOO9-Fx7kIpkwQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-993c2d9e496so41518966b.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 03:29:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697797744; x=1698402544;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=//3SbJJeNcWFwjwSbQdPSDoOVfnJ62EKjrp2h08jTc8=;
        b=bz6xewR/pT9csBfDNjn2GXXJChbIEL2TmFZ/EPyplePNGcVDCFsFAyK9tncaiFQMio
         ZJ+Qoy6+Q88qWpfU2jbCNjdEmejxXVZ2UsA2h5GhZihW3HF/yk/w57OVbCiujXaWF3n9
         ARTd4iMghgCmdgFV2EiXdoTnpKWGIhgzMOe0w79VlQBqrrlikOcyIbXayLWNAnuo1VwR
         jnQLXdrlE/QIT2HbbGNRDDTsYZUGmakEflYkvIIg5M5lETovncEiUmbpFtdydb49G9SU
         xXOD6ZIZLcx9QE6ym/FQG2PwvSkal6rIZ0BWieRuk2rznKvfz0JmdmtxngYER6SFsOcG
         Y0NA==
X-Gm-Message-State: AOJu0Ywiq/1tCBnIGC5SDDUv5fKrcfGux3TfMnHuURxYx+b4e51MnL0t
        RI1IOC5pd1kIDgqBs9t50tRfbKiIR4qBmlXrVyvLSbwqCkhk+2B2gx4H/NaUR0d2/jB15C5Gakh
        TDG1D6cUTVATOSXQ3OFbPzFnLUZKl3JGaWoSwmsm/NPfDkLMgvJk15NtrOhamoyHXe0br0DKlkk
        oStaVjEBzL
X-Received: by 2002:a17:906:fd87:b0:9a1:fcd7:b825 with SMTP id xa7-20020a170906fd8700b009a1fcd7b825mr782295ejb.71.1697797743986;
        Fri, 20 Oct 2023 03:29:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkO/6QZnD1x89XbHyXL1xBdGFCTOZSGiTqkjvDLPOJirHjxWNbxwzb2KNXUdyDtg3rnTLK4w==
X-Received: by 2002:a17:906:fd87:b0:9a1:fcd7:b825 with SMTP id xa7-20020a170906fd8700b009a1fcd7b825mr782277ejb.71.1697797743478;
        Fri, 20 Oct 2023 03:29:03 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (92-249-235-200.pool.digikabel.hu. [92.249.235.200])
        by smtp.gmail.com with ESMTPSA id h9-20020a1709062dc900b009930c80b87csm1223140eji.142.2023.10.20.03.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 03:29:02 -0700 (PDT)
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
Subject: [RFC PATCH 0/2] add list iterate & delete macros
Date:   Fri, 20 Oct 2023 12:28:58 +0200
Message-ID: <20231020102901.3354273-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.41.0
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

It turns out that a very common pattern is:

  - remove first element
  - do something with first element
  - repeat until list is empty

This is most often coded as something like:

	while (!list_empty(head)) {
		pos = list_first_entry(head, typeof(*pos), member);
		list_del(&pos->member);
		...
	}

The first patch adds macros to condense this pattern into a single list
iteration statement.

The second patch replaces some instances with the new macros.

I think the most important result is that it makes the pattern recognisable
and is easier to read.

Any comments or objections?

Should the conversion patch be split up by subsystem?

Thanks,
Miklos


Miklos Szeredi (2):
  add list_for_each_entry_del()
  replace trivial incarnations of list_for_each_entry_del()

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
 include/linux/list.h                          | 29 +++++++++
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
 297 files changed, 645 insertions(+), 1966 deletions(-)

-- 
2.41.0

