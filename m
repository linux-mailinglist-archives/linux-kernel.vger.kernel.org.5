Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 181087EE498
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 16:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345321AbjKPPse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 10:48:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345232AbjKPPsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 10:48:32 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17596D59;
        Thu, 16 Nov 2023 07:48:28 -0800 (PST)
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: andrzej.p)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DF506660734C;
        Thu, 16 Nov 2023 15:48:25 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1700149706;
        bh=qOGURixP10SKLR9eMJf0x73f6ugT8/gbvL3YowPyUCo=;
        h=From:To:Cc:Subject:Date:From;
        b=ev+qQXOisOTKnWgq1P8D8oEK9yX30W34JGRLzV4HX5MsrGgm5YSfT1TzKlVvs57sN
         jBk6KH6DXlhwFAnLWXHB/J/NH2MvGglS/ROafXqXx8zTDgGQ8+WZsx19p3SrsoMg5F
         /PwJvvgMErv+GUu7KnFg1TZMdE9xO2GWaJPnoNG99XheUvcgUFrpHjxZhTgTgqxFR9
         ymC+EI1dQI66IedwlkqLLasg7uL6hGRYGeKzn0qkMvTzPvWDhrDR5Sg4RAZkfg8GBs
         J93wjM93c473Jgzoq4nMovXzxh68aVPVQYttT5nW3me3sAFvu6FDEAOcJh4z0RnULv
         KW8GoQcONBLTQ==
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
To:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Cc:     Hugues Fruchet <hugues.fruchet@foss.st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>, kernel@collabora.com
Subject: [RFC 0/6] H.264 stateless encoder RFC 0/6
Date:   Thu, 16 Nov 2023 16:48:10 +0100
Message-Id: <20231116154816.70959-1-andrzej.p@collabora.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,

This series adds uAPI for stateless H.264 encoding and an
accompanying driver using it.

It has been tested on an stm32mp25 and there exists
a gstreamer user:

https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/5676

example pipeline:

gst-launch-1.0 videotestsrc num-buffers=30 ! video/x-raw, format=YUY2 !
v4l2slh264enc ! filesink location=test.h264

Rebased onto v6.6 with:

- some patches from ST to actually run the hardware
- my previous VP8 statless encoding series
- VP8 support for H1 from Hugues Fruchet

In particular, this series depends on the latter, which can be
found here:

https://patchwork.linuxtv.org/project/linux-media/list/?series=11358

Here's a branch which contains everything needed to actually run:

https://gitlab.collabora.com/linux/for-upstream/-/tree/h264-enc-rfc-6.6

I kindly ask for comments.

Regards,

Andrzej Pietrasiewicz (6):
  media: verisilicon Correct a typo in
    H1_REG_ENC_CTRL2_DEBLOCKING_FILTER_MODE
  media: verisilicon: Correct a typo in H1_REG_MAD_CTRL_MAD_THRESHOLD
  media: verisilicon: Improve constant's name
  media: verisilicon: Update H1 register definitions
  media: uapi: Add H.264 stateless encoding uAPI
  media: verisilicon: Add H.264 stateless encoder

 drivers/media/platform/verisilicon/Makefile   |   1 +
 drivers/media/platform/verisilicon/hantro.h   |   3 +
 .../media/platform/verisilicon/hantro_drv.c   |  10 +
 .../platform/verisilicon/hantro_h1_h264_enc.c | 493 +++++++++++
 .../platform/verisilicon/hantro_h1_regs.h     |  20 +-
 .../platform/verisilicon/hantro_h1_vp8_enc.c  |   2 +-
 .../media/platform/verisilicon/hantro_h264.c  | 777 ++++++++++++++++++
 .../media/platform/verisilicon/hantro_hw.h    |  23 +
 .../platform/verisilicon/stm32mp25_venc_hw.c  |  22 +-
 drivers/media/v4l2-core/v4l2-ctrls-core.c     |  54 ++
 drivers/media/v4l2-core/v4l2-ctrls-defs.c     |   9 +
 include/uapi/linux/v4l2-controls.h            |  85 ++
 include/uapi/linux/videodev2.h                |   2 +
 13 files changed, 1496 insertions(+), 5 deletions(-)
 create mode 100644 drivers/media/platform/verisilicon/hantro_h1_h264_enc.c

-- 
2.25.1

