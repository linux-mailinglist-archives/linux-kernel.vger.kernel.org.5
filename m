Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB6E806A35
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 09:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377142AbjLFI4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 03:56:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377225AbjLFI4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 03:56:17 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DEC52134;
        Wed,  6 Dec 2023 00:56:18 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5F5D166072F1;
        Wed,  6 Dec 2023 08:56:16 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701852976;
        bh=cAQGXK/DFzV/MsA9WE+7jJOIqA7DYcQgRektvIwug7M=;
        h=From:To:Cc:Subject:Date:From;
        b=SRjSjvLDcbd1BMuyp/l5qZFEEIpqwHu90To1u9YmvfxgZwSGgYSmz9Xj6YCgoVU6n
         9Ht8eQTlCrLt7WYv1+qUJEroAzDa/6ObX72X3KzF6xDB477Gii0Cx6aaVzDqoUqaHk
         p/7GWzxk9MrswYQaByh6Zol3QHfMQlfao/hSfcjx8hg86WZ4klgiGPlEdW6/G5H6Fi
         G8DNU/8AeFg1faPyaG6w4FtlDp11SbWRiqL7ahdLbPONwI3uu+/NO7gQnTIFW4ycDv
         3Up8/UNHas/TojmGzRsQpGY/XE9CWybMtJvetmJ5ylIQLhunRXCjF5Iheo3bFUDNh0
         aEf4mqjtVjIXg==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     hverkuil@xs4all.nl, mchehab@kernel.org, tfiga@chromium.org
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v3 0/2] Clean up min_buffers_needed misusages
Date:   Wed,  6 Dec 2023 09:56:06 +0100
Message-Id: <20231206085608.33246-1-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series implement Hans's RFC: https://www.spinics.net/lists/linux-media/msg244455.html

To summarize Hans's proposal it is needed to distinguish two cases:
- the minimal number of buffers to be allocated when calling
  VIDIOC_REQBUFS.
- the minimale number of queued buffers before start streaming.
Until now drivers use vb2_queue min_buffers_needed field in the both
cases but before introduce delete buffers we need to clarify for which
usage each of them use min_buffers_needed field.

The branch with all patches is here:
https://gitlab.collabora.com/benjamin.gaignard/for-upstream/-/commits/clean_min_need_buffers_v3

I have tested with this command line, I haven't notice issues:
./test-media -kmemleak mc

changes in version 3:
- Just rename min_buffers_needed into min_queued_buffers everywhere
  without trying to fix the drivers.
- Introduce min_reqbufs_allocation field to be used when calling VIDIOC_REQBUFS.

changes in version 2:
- change min_buffers_needed into min_queues_buffers instead of min_dma_buffers_needed
- patches order
- only one patch to rename min_buffers_needed into min_queues_buffers.

Benjamin Gaignard (2):
  videobuf2: core: Rename min_buffers_needed field to vb2_queue
  videobuf2: Add min_reqbufs_allocation field to vb2_queue structure

 drivers/input/touchscreen/atmel_mxt_ts.c      |  2 +-
 drivers/input/touchscreen/sur40.c             |  2 +-
 drivers/media/common/saa7146/saa7146_fops.c   |  2 +-
 .../media/common/videobuf2/videobuf2-core.c   | 23 ++++++++++---------
 drivers/media/dvb-core/dvb_vb2.c              |  2 +-
 drivers/media/i2c/video-i2c.c                 |  2 +-
 drivers/media/pci/bt8xx/bttv-driver.c         |  2 +-
 drivers/media/pci/cobalt/cobalt-v4l2.c        |  2 +-
 drivers/media/pci/cx18/cx18-streams.c         |  2 +-
 drivers/media/pci/cx23885/cx23885-417.c       |  2 +-
 drivers/media/pci/cx23885/cx23885-dvb.c       |  2 +-
 drivers/media/pci/cx23885/cx23885-video.c     |  4 ++--
 drivers/media/pci/cx25821/cx25821-video.c     |  2 +-
 drivers/media/pci/cx88/cx88-blackbird.c       |  2 +-
 drivers/media/pci/cx88/cx88-dvb.c             |  2 +-
 drivers/media/pci/cx88/cx88-video.c           |  4 ++--
 drivers/media/pci/dt3155/dt3155.c             |  2 +-
 drivers/media/pci/intel/ipu3/ipu3-cio2.c      |  2 +-
 drivers/media/pci/mgb4/mgb4_vin.c             |  2 +-
 drivers/media/pci/mgb4/mgb4_vout.c            |  2 +-
 drivers/media/pci/tw5864/tw5864-video.c       |  2 +-
 drivers/media/pci/tw68/tw68-video.c           |  2 +-
 drivers/media/pci/tw686x/tw686x-video.c       |  2 +-
 drivers/media/pci/zoran/zoran_driver.c        |  5 +---
 drivers/media/platform/amphion/vpu_v4l2.c     |  4 ++--
 drivers/media/platform/aspeed/aspeed-video.c  |  2 +-
 drivers/media/platform/atmel/atmel-isi.c      |  2 +-
 .../platform/chips-media/coda/coda-common.c   |  2 +-
 .../platform/microchip/microchip-isc-base.c   |  2 +-
 drivers/media/platform/nuvoton/npcm-video.c   |  2 +-
 drivers/media/platform/nxp/imx7-media-csi.c   |  2 +-
 .../platform/nxp/imx8-isi/imx8-isi-video.c    |  2 +-
 drivers/media/platform/qcom/venus/vdec.c      |  4 ++--
 drivers/media/platform/qcom/venus/venc.c      |  4 ++--
 .../platform/renesas/rcar-vin/rcar-dma.c      |  2 +-
 drivers/media/platform/renesas/renesas-ceu.c  |  2 +-
 .../platform/renesas/rzg2l-cru/rzg2l-video.c  |  2 +-
 drivers/media/platform/renesas/sh_vou.c       |  2 +-
 .../platform/rockchip/rkisp1/rkisp1-capture.c |  2 +-
 drivers/media/platform/st/sti/hva/hva-v4l2.c  |  4 ++--
 drivers/media/platform/st/stm32/stm32-dcmi.c  |  2 +-
 .../st/stm32/stm32-dcmipp/dcmipp-bytecap.c    |  4 ++--
 .../platform/sunxi/sun4i-csi/sun4i_dma.c      |  2 +-
 .../sunxi/sun6i-csi/sun6i_csi_capture.c       |  2 +-
 .../media/platform/sunxi/sun8i-di/sun8i-di.c  |  4 ++--
 .../sunxi/sun8i-rotate/sun8i_rotate.c         |  4 ++--
 .../media/platform/ti/am437x/am437x-vpfe.c    |  2 +-
 drivers/media/platform/ti/cal/cal-video.c     |  2 +-
 .../media/platform/ti/davinci/vpif_capture.c  |  2 +-
 .../media/platform/ti/davinci/vpif_display.c  |  2 +-
 .../platform/ti/j721e-csi2rx/j721e-csi2rx.c   |  2 +-
 drivers/media/platform/ti/omap/omap_vout.c    |  2 +-
 .../media/test-drivers/vimc/vimc-capture.c    |  2 +-
 drivers/media/test-drivers/vivid/vivid-core.c |  2 +-
 drivers/media/usb/cx231xx/cx231xx-417.c       |  2 +-
 drivers/media/usb/cx231xx/cx231xx-video.c     |  4 ++--
 drivers/media/usb/dvb-usb/cxusb-analog.c      |  2 +-
 drivers/media/usb/gspca/gspca.c               |  6 ++---
 .../media/deprecated/atmel/atmel-isc-base.c   |  2 +-
 drivers/staging/media/imx/imx-media-capture.c |  2 +-
 drivers/staging/media/ipu3/ipu3-v4l2.c        |  2 +-
 drivers/staging/media/meson/vdec/vdec.c       |  4 +---
 .../staging/media/starfive/camss/stf-video.c  |  2 +-
 .../media/sunxi/sun6i-isp/sun6i_isp_capture.c |  2 +-
 .../media/sunxi/sun6i-isp/sun6i_isp_params.c  |  2 +-
 drivers/staging/media/tegra-video/vi.c        |  2 +-
 include/media/videobuf2-core.h                | 10 ++++++--
 samples/v4l/v4l2-pci-skeleton.c               |  2 +-
 68 files changed, 98 insertions(+), 96 deletions(-)

-- 
2.39.2

