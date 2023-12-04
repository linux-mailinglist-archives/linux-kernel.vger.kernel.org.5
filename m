Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BEFB80346D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 14:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233882AbjLDNXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 08:23:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjLDNX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 08:23:28 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC8BCA;
        Mon,  4 Dec 2023 05:23:34 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 38FC76602020;
        Mon,  4 Dec 2023 13:23:32 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701696212;
        bh=j1IZwqeh1AVmPV2T7nMomzTCuWiBsuKDiy7etx0oXjg=;
        h=From:To:Cc:Subject:Date:From;
        b=Gr+9aZUifYks1yWXmMkJXWFRvad2YKpDmOx0mD+n6qnm3Q73UKTUlrcX5vH4BFM1z
         fOCnUK89CUmbZaTH4jotQuGOHMySWClsJt90QmQnqOk68GB95SdQTk0yS5Rk9IcvPi
         uSS3B4BsY8YtlAyw3Nry7/D53gbdaOAgL9YHBPYCc1v4FyTwZVlTjN9e9PWx2oSq3C
         CTasgutjS9M/1L+lPbkXXhW0qNIEMdU0H/xjQF1+JlhSe1KLDahgsbsDBKytxBvT9+
         OOTPVjm0bWOWD2fCLzaNPY41Bbb0LbzYUGJrOiAnqWppGG2C0MAPmprGk5p3GKMn+R
         FlYWA8TAte6IA==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     hverkuil@xs4all.nl, mchehab@kernel.org, tfiga@chromium.org,
        m.szyprowski@samsung.com, matt.ranostay@konsulko.com
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v2 00/36] Clean up min_buffers_needed misusages
Date:   Mon,  4 Dec 2023 14:22:47 +0100
Message-Id: <20231204132323.22811-1-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

I have done this in 3 steps:
- remove all min_buffers_needed = 1 (or 0) because that the default
  minimum buffers allocated when calling VIDIOC_REQBUFS
- add min_reqbufs_allocation field and convert all the drivers that I
  believe use min_buffers_needed field for VIDIOC_REQBUFS purpose.
- rename min_buffers_needed into min_queues_buffers.

The branch with all patches is here:
https://gitlab.collabora.com/benjamin.gaignard/for-upstream/-/commits/clean_min_need_buffers_v2

I have tested with this command line, I haven't notice issues:
./test-media -kmemleak mc

changes in version 2:
- change min_buffers_needed into min_queues_buffers instead of min_dma_buffers_needed
- patches order
- only one patch to rename min_buffers_needed into min_queues_buffers.

Benjamin Gaignard (36):
  media: usb: cx231xx: Remove useless setting of min_buffers_needed
  media: chips-media: coda: Remove useless setting of min_buffers_needed
  media: microchip: Remove useless setting of min_buffers_needed
  media: amphion: Remove useless setting of min_buffers_needed
  media: qcom: venus: Remove useless setting of min_buffers_needed
  media: i2c: video-i2c: Remove useless setting of min_buffers_needed
  media: dvb-core: Remove useless setting of min_buffers_needed
  media: atmel: Remove useless setting of min_buffers_needed
  media: ipu3: Remove useless setting of min_buffers_needed
  media: ti: am437x: Remove useless setting of min_buffers_needed
  media: ti: davinci: Remove useless setting of min_buffers_needed
  input: touchscreen: atmel: Remove useless setting of
    min_buffers_needed
  media: ti: j721e-csi2rx: Remove useless setting of min_buffers_needed
  media: ti: omap: Remove useless setting of min_buffers_needed
  media: pci: intel: ipu3: Remove useless setting of min_buffers_needed
  videobuf2: Add min_reqbufs_allocation field to vb2_queue structure
  media: test-drivers: Fix misuse of min_buffers_needed field
  media: usb: dvb-usb: cxusb-analog: Fix misuse of min_buffers_needed
    field
  media: usb: gspca: Fix misuse of min_buffers_needed field
  media: atmel: Fix misuse of min_buffers_needed field
  media: imx7-media-csi: Fix misuse of min_buffers_needed field
  media: nuvoton: Fix misuse of min_buffers_needed field
  media: sti: hva: Fix misuse of min_buffers_needed field
  media: rockchip: rkisp1: Fix misuse of min_buffers_needed field
  media: aspeed: Fix misuse of min_buffers_needed field
  media: sun4i-csi: Fix misuse of min_buffers_needed field
  media: sunxi: sun8i-di: Fix misuse of min_buffers_needed field
  media: sun8i-rotate: Fix misuse of min_buffers_needed field
  media: sunxi: sun6i-csi: Fix misuse of min_buffers_needed field
  media: imx: Fix misuse of min_buffers_needed field
  media: starfive: Fix misuse of min_buffers_needed field
  media: tegra-video: Fix misuse of min_buffers_needed field
  media: ti: cal: Fix misuse of min_buffers_needed field
  media: saa7146: Fix misuse of min_buffers_needed field
  input: touchscreen: sur40: Fix misuse of min_buffers_needed field
  videobuf2: core: Rename min_buffers_needed field to vb2_queue

 drivers/input/touchscreen/atmel_mxt_ts.c      |  1 -
 drivers/input/touchscreen/sur40.c             |  2 +-
 drivers/media/common/saa7146/saa7146_fops.c   |  2 +-
 .../media/common/videobuf2/videobuf2-core.c   | 28 +++++++++++--------
 drivers/media/dvb-core/dvb_vb2.c              |  1 -
 drivers/media/i2c/video-i2c.c                 |  1 -
 drivers/media/pci/bt8xx/bttv-driver.c         |  2 +-
 drivers/media/pci/cobalt/cobalt-v4l2.c        |  2 +-
 drivers/media/pci/cx18/cx18-streams.c         |  2 +-
 drivers/media/pci/cx23885/cx23885-417.c       |  2 +-
 drivers/media/pci/cx23885/cx23885-dvb.c       |  2 +-
 drivers/media/pci/cx23885/cx23885-video.c     |  4 +--
 drivers/media/pci/cx25821/cx25821-video.c     |  2 +-
 drivers/media/pci/cx88/cx88-blackbird.c       |  2 +-
 drivers/media/pci/cx88/cx88-dvb.c             |  2 +-
 drivers/media/pci/cx88/cx88-video.c           |  4 +--
 drivers/media/pci/dt3155/dt3155.c             |  2 +-
 drivers/media/pci/intel/ipu3/ipu3-cio2.c      |  1 -
 drivers/media/pci/mgb4/mgb4_vin.c             |  2 +-
 drivers/media/pci/mgb4/mgb4_vout.c            |  2 +-
 drivers/media/pci/tw5864/tw5864-video.c       |  2 +-
 drivers/media/pci/tw68/tw68-video.c           |  2 +-
 drivers/media/pci/tw686x/tw686x-video.c       |  2 +-
 drivers/media/pci/zoran/zoran_driver.c        |  5 +---
 drivers/media/platform/amphion/vpu_v4l2.c     |  2 --
 drivers/media/platform/aspeed/aspeed-video.c  |  2 +-
 drivers/media/platform/atmel/atmel-isi.c      |  2 +-
 .../platform/chips-media/coda/coda-common.c   |  1 -
 .../platform/microchip/microchip-isc-base.c   |  1 -
 drivers/media/platform/nuvoton/npcm-video.c   |  2 +-
 drivers/media/platform/nxp/imx7-media-csi.c   |  2 +-
 .../platform/nxp/imx8-isi/imx8-isi-video.c    |  2 +-
 drivers/media/platform/qcom/venus/vdec.c      |  2 --
 drivers/media/platform/qcom/venus/venc.c      |  2 --
 .../platform/renesas/rcar-vin/rcar-dma.c      |  2 +-
 drivers/media/platform/renesas/renesas-ceu.c  |  2 +-
 .../platform/renesas/rzg2l-cru/rzg2l-video.c  |  2 +-
 drivers/media/platform/renesas/sh_vou.c       |  2 +-
 .../platform/rockchip/rkisp1/rkisp1-capture.c |  2 +-
 drivers/media/platform/st/sti/hva/hva-v4l2.c  |  4 +--
 drivers/media/platform/st/stm32/stm32-dcmi.c  |  2 +-
 .../platform/sunxi/sun4i-csi/sun4i_dma.c      |  2 +-
 .../sunxi/sun6i-csi/sun6i_csi_capture.c       |  2 +-
 .../media/platform/sunxi/sun8i-di/sun8i-di.c  |  3 +-
 .../sunxi/sun8i-rotate/sun8i_rotate.c         |  3 +-
 .../media/platform/ti/am437x/am437x-vpfe.c    |  1 -
 drivers/media/platform/ti/cal/cal-video.c     |  2 +-
 .../media/platform/ti/davinci/vpif_capture.c  |  1 -
 .../media/platform/ti/davinci/vpif_display.c  |  1 -
 .../platform/ti/j721e-csi2rx/j721e-csi2rx.c   |  1 -
 drivers/media/platform/ti/omap/omap_vout.c    |  1 -
 .../media/test-drivers/vimc/vimc-capture.c    |  2 +-
 drivers/media/test-drivers/vivid/vivid-core.c |  4 +--
 drivers/media/usb/cx231xx/cx231xx-417.c       |  1 -
 drivers/media/usb/cx231xx/cx231xx-video.c     |  2 --
 drivers/media/usb/dvb-usb/cxusb-analog.c      |  2 +-
 drivers/media/usb/gspca/gspca.c               |  6 ++--
 .../media/deprecated/atmel/atmel-isc-base.c   |  1 -
 drivers/staging/media/imx/imx-media-capture.c |  2 +-
 drivers/staging/media/ipu3/ipu3-v4l2.c        |  2 --
 drivers/staging/media/meson/vdec/vdec.c       |  4 +--
 .../staging/media/starfive/camss/stf-video.c  |  2 +-
 .../media/sunxi/sun6i-isp/sun6i_isp_capture.c |  2 +-
 .../media/sunxi/sun6i-isp/sun6i_isp_params.c  |  2 +-
 drivers/staging/media/tegra-video/vi.c        |  2 +-
 include/media/videobuf2-core.h                | 10 +++++--
 samples/v4l/v4l2-pci-skeleton.c               |  2 +-
 67 files changed, 77 insertions(+), 97 deletions(-)

-- 
2.39.2

