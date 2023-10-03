Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 736F67B6340
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 10:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239342AbjJCIH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 04:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239225AbjJCIHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 04:07:21 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8836CB7;
        Tue,  3 Oct 2023 01:07:15 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:b6df:b784:6a0f:8451])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CD6A06607313;
        Tue,  3 Oct 2023 09:07:12 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1696320433;
        bh=qj0bnDV/xFPYTBegLSnkEtqZDOJIKZaMrpfQDOlp2LI=;
        h=From:To:Cc:Subject:Date:From;
        b=jYodERC3YXqPMp8tA+HsW/6Tpa+h3Z9OOMfSzq/5MvdGvAZJZ2cPhnFl9U8nMYLu0
         RahbQCrhjnHarLpzsE3Ksdg1hGIoCL1NNA5UjjthY83q1WPmR4WYkW2K1easCR8IDI
         LiK8ED58c3dXV8uBYW035cQ0vLGvKRisUdwXDWChVlOvxxLMaQPnoJ5Fc5siDZfwNL
         IlOVPZoB8paE0F/P5nEpfmAsAo/evBCDMa/Zx52k3v8FfY3xMntnf53CwgGr6goA+e
         NQMdNl4GbZzP+pYKOt8Dy8czmZ0I/lqEH5Dnz2u/viiaApqiPMMNMXUj7eo3MW/GB/
         s0Ohe84diqQtA==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     mchehab@kernel.org, tfiga@chromium.org, m.szyprowski@samsung.com,
        ming.qian@nxp.com, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        hverkuil-cisco@xs4all.nl, nicolas.dufresne@collabora.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v10 00/54] Add DELETE_BUF ioctl
Date:   Tue,  3 Oct 2023 10:06:09 +0200
Message-Id: <20231003080704.43911-1-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unlike when resolution change on keyframes, dynamic resolution change
on inter frames doesn't allow to do a stream off/on sequence because
it is need to keep all previous references alive to decode inter frames.
This constraint have two main problems:
- more memory consumption.
- more buffers in use.
To solve these issue this series introduce DELETE_BUFS ioctl and remove
the 32 buffers limit per queue.

VP9 conformance tests using fluster give a score of 210/305.
The 24 resize inter tests (vp90-2-21-resize_inter_* files) are ok
but require to use postprocessor.

Kernel branch is available here:
https://gitlab.collabora.com/benjamin.gaignard/for-upstream/-/commits/remove_vb2_queue_limit_v10

GStreamer branch to use DELETE_BUF ioctl and testing dynamic resolution
change is here:
https://gitlab.freedesktop.org/benjamin.gaignard1/gstreamer/-/commits/VP9_drc

changes in version 10:
- Make BUFFER_INDEX_MASK definition more readable
- Rebase on media_stage/master branch and add a patch for nuvoton
  driver.
- Fix issue on patch 13

changes in version 9:
- BUFFER_INDEX_MASK now depends on PAGE_SHIFT value to match
  architectures requirements.
- Correctly initialize max_num_buffers in vb2_core_queue_init()
- run 'test-media -kmemleak mc' on top of the series and on patches 1 to 47 without failures.
- fix compilation issue in patch 50

changes in version 8:
- Add V4L2_BUF_CAP_SUPPORTS_SET_MAX_BUFS and new 'max_buffers' field in v4l2_create_buffers
  structure to report the maximum number of buffers that a queue could allocate.
- Add V4L2_BUF_CAP_SUPPORTS_DELETE_BUFS to indicate that a queue support
  DELETE_BUFS ioctl.
- Make some test drivers use more than 32 buffers and DELETE_BUFS ioctl.
- Fix remarks done by Hans
- Move "media: core: Rework how create_buf index returned value is
  computed" patch to the top of the serie.

changes in version 7:
- Use a bitmap to know which entries are valid in queue bufs array.
  The number of buffers in the queue could must calculated from the
  bitmap so num_buffers becomes useless. This led to add quite few
  patches to remove it from all the drivers.
  Note: despiste my attention I may have miss some calls to
  num_buffers...
- Split patches to make them more readable.
- Run v4l2-compliance with additional delete-bufs tests.
- Run ./test-media -kmemleak vivid and no more failures.
  Note: I had to remove USERPTR streaming test because they to much
  frequentely hit get_framevec bug. It is not related to my series
  since this happens all the time on master branch.
- Fix Hans remarks on v6

changes in version 6:
- Get a patch per driver to use vb2_get_buffer() instead of directly access
  to queue buffers array.
- Add lock in vb2_core_delete_buf()
- Use vb2_buffer instead of index
- Fix various comments
- Change buffer index name to BUFFER_INDEX_MASK
- Stop spamming kernel log with unbalanced counters

Regards,
Benjamin
 
Benjamin Gaignard (54):
  media: videobuf2: Rework offset 'cookie' encoding pattern
  media: videobuf2: Stop spamming kernel log with all queue counter
  media: videobuf2: Use vb2_buffer instead of index
  media: amphion: Use vb2_get_buffer() instead of directly access to
    buffers array
  media: mediatek: jpeg: Use vb2_get_buffer() instead of directly access
    to buffers array
  media: mediatek: vdec: Remove useless loop
  media: sti: hva: Use vb2_get_buffer() instead of directly access to
    buffers array
  media: visl: Use vb2_get_buffer() instead of directly access to
    buffers array
  media: atomisp: Use vb2_get_buffer() instead of directly access to
    buffers array
  media: dvb-core: Use vb2_get_buffer() instead of directly access to
    buffers array
  media: videobuf2: Access vb2_queue bufs array through helper functions
  media: videobuf2: Be more flexible on the number of queue stored
    buffers
  media: Report the maximum possible number of buffers for the queue
  media: test-drivers: vivid: Increase max supported buffers for capture
    queues
  media: test-drivers: vicodec: Increase max supported capture queue
    buffers
  media: verisilicon: Refactor postprocessor to store more buffers
  media: verisilicon: Store chroma and motion vectors offset
  media: verisilicon: g2: Use common helpers to compute chroma and mv
    offsets
  media: verisilicon: vp9: Allow to change resolution while streaming
  media: Remove duplicated index vs q->num_buffers check
  media: core: Add helper to get queue number of buffers
  media: dvb-core: Do not initialize twice queue num_buffer field
  media: dvb-frontends: rtl2832_srd: Use queue min_buffers_needed field
  media: video-i2c: Set min_buffers_needed to 2
  media: pci: cx18: Set correct value to min_buffers_needed field
  media: pci: dt3155: Remove useless check
  media: pci: netup_unidvb: Remove useless number of buffers check
  media: pci: tw68: Stop direct calls to queue num_buffers field
  media: pci: tw686x: Set min_buffers_needed to 3
  media: amphion: Stop direct calls to queue num_buffers field
  media: coda: Stop direct calls to queue num_buffers field
  media: mediatek: vcodec: Stop direct calls to queue num_buffers field
  media: nxp: Stop direct calls to queue num_buffers field
  media: renesas: Set min_buffers_needed to 16
  media: ti: Use queue min_buffers_needed field to set the min number of
    buffers
  media: verisilicon: Stop direct calls to queue num_buffers field
  media: test-drivers: Stop direct calls to queue num_buffers field
  media: usb: airspy: Set min_buffers_needed to 8
  media: usb: cx231xx: Set min_buffers_needed to CX231XX_MIN_BUF
  media: usb: hackrf: Set min_buffers_needed to 8
  media: usb: usbtv: Set min_buffers_needed to 2
  media: atomisp: Stop direct calls to queue num_buffers field
  media: imx: Stop direct calls to queue num_buffers field
  media: meson: vdec: Stop direct calls to queue num_buffers field
  touchscreen: sur40: Stop direct calls to queue num_buffers field
  sample: v4l: Stop direct calls to queue num_buffers field
  media: cedrus: Stop direct calls to queue num_buffers field
  media: nuvoton: Stop direct calls to queue num_buffers field
  media: core: Rework how create_buf index returned value is computed
  media: core: Add bitmap manage bufs array entries
  media: core: Free range of buffers
  media: v4l2: Add DELETE_BUFS ioctl
  media: v4l2: Add mem2mem helpers for DELETE_BUFS ioctl
  media: test-drivers: Use helper for DELETE_BUFS ioctl

 .../userspace-api/media/v4l/user-func.rst     |   1 +
 .../media/v4l/vidioc-create-bufs.rst          |   8 +-
 .../media/v4l/vidioc-delete-bufs.rst          |  80 +++
 .../media/v4l/vidioc-reqbufs.rst              |   2 +
 drivers/input/touchscreen/sur40.c             |   5 +-
 .../media/common/videobuf2/videobuf2-core.c   | 554 +++++++++++-------
 .../media/common/videobuf2/videobuf2-v4l2.c   | 118 +++-
 drivers/media/dvb-core/dvb_vb2.c              |  17 +-
 drivers/media/dvb-frontends/rtl2832_sdr.c     |   9 +-
 drivers/media/i2c/video-i2c.c                 |   5 +-
 drivers/media/pci/cx18/cx18-streams.c         |  13 +-
 drivers/media/pci/dt3155/dt3155.c             |   2 -
 .../pci/netup_unidvb/netup_unidvb_core.c      |   4 +-
 drivers/media/pci/tw68/tw68-video.c           |   6 +-
 drivers/media/pci/tw686x/tw686x-video.c       |  13 +-
 drivers/media/platform/amphion/vpu_dbg.c      |  30 +-
 drivers/media/platform/amphion/vpu_v4l2.c     |   4 +-
 .../media/platform/chips-media/coda-common.c  |   2 +-
 .../platform/mediatek/jpeg/mtk_jpeg_core.c    |   7 +-
 .../vcodec/decoder/vdec/vdec_vp9_req_lat_if.c |   9 +-
 .../mediatek/vcodec/encoder/mtk_vcodec_enc.c  |   2 +-
 drivers/media/platform/nuvoton/npcm-video.c   |   2 +-
 drivers/media/platform/nxp/imx7-media-csi.c   |   7 +-
 drivers/media/platform/renesas/rcar_drif.c    |   8 +-
 drivers/media/platform/st/sti/hva/hva-v4l2.c  |   9 +-
 .../media/platform/ti/am437x/am437x-vpfe.c    |   7 +-
 drivers/media/platform/ti/cal/cal-video.c     |   5 +-
 .../media/platform/ti/davinci/vpif_capture.c  |   5 +-
 .../media/platform/ti/davinci/vpif_display.c  |   5 +-
 drivers/media/platform/ti/omap/omap_vout.c    |   5 +-
 drivers/media/platform/verisilicon/hantro.h   |   9 +-
 .../media/platform/verisilicon/hantro_drv.c   |   5 +-
 .../media/platform/verisilicon/hantro_g2.c    |  14 +
 .../platform/verisilicon/hantro_g2_hevc_dec.c |  18 +-
 .../platform/verisilicon/hantro_g2_vp9_dec.c  |  28 +-
 .../media/platform/verisilicon/hantro_hw.h    |   7 +-
 .../platform/verisilicon/hantro_postproc.c    |  93 ++-
 .../media/platform/verisilicon/hantro_v4l2.c  |  27 +-
 .../media/test-drivers/vicodec/vicodec-core.c |   3 +
 drivers/media/test-drivers/vim2m.c            |   2 +
 .../media/test-drivers/vimc/vimc-capture.c    |   2 +
 drivers/media/test-drivers/visl/visl-dec.c    |  32 +-
 drivers/media/test-drivers/visl/visl-video.c  |   2 +
 drivers/media/test-drivers/vivid/vivid-core.c |  14 +
 .../media/test-drivers/vivid/vivid-meta-cap.c |   3 -
 .../media/test-drivers/vivid/vivid-meta-out.c |   5 +-
 .../test-drivers/vivid/vivid-touch-cap.c      |   5 +-
 .../media/test-drivers/vivid/vivid-vbi-cap.c  |   5 +-
 .../media/test-drivers/vivid/vivid-vbi-out.c  |   5 +-
 .../media/test-drivers/vivid/vivid-vid-cap.c  |   5 +-
 .../media/test-drivers/vivid/vivid-vid-out.c  |   5 +-
 drivers/media/usb/airspy/airspy.c             |   9 +-
 drivers/media/usb/cx231xx/cx231xx-417.c       |   4 +-
 drivers/media/usb/cx231xx/cx231xx-video.c     |   4 +-
 drivers/media/usb/hackrf/hackrf.c             |   9 +-
 drivers/media/usb/usbtv/usbtv-video.c         |   3 +-
 drivers/media/v4l2-core/v4l2-dev.c            |   1 +
 drivers/media/v4l2-core/v4l2-ioctl.c          |  21 +-
 drivers/media/v4l2-core/v4l2-mem2mem.c        |  20 +
 .../staging/media/atomisp/pci/atomisp_ioctl.c |   4 +-
 drivers/staging/media/imx/imx-media-capture.c |   7 +-
 drivers/staging/media/meson/vdec/vdec.c       |  13 +-
 .../staging/media/sunxi/cedrus/cedrus_h264.c  |   8 +-
 .../staging/media/sunxi/cedrus/cedrus_h265.c  |   9 +-
 include/media/v4l2-ioctl.h                    |   4 +
 include/media/v4l2-mem2mem.h                  |  12 +
 include/media/videobuf2-core.h                |  65 +-
 include/media/videobuf2-v4l2.h                |  13 +
 include/uapi/linux/videodev2.h                |  24 +-
 samples/v4l/v4l2-pci-skeleton.c               |   5 +-
 70 files changed, 966 insertions(+), 502 deletions(-)
 create mode 100644 Documentation/userspace-api/media/v4l/vidioc-delete-bufs.rst

-- 
2.39.2

