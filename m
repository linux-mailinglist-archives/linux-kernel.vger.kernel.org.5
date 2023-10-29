Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9917C7DADC9
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 19:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjJ2Soq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 14:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjJ2Soo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 14:44:44 -0400
X-Greylist: delayed 595 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 29 Oct 2023 11:44:39 PDT
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012B3C2;
        Sun, 29 Oct 2023 11:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1698605077;
 bh=gogipZf0R0iOWdYyr1sBKjhOfpGlLqwJaMpBSjca5Mk=;
 b=eZjJcwec7ptknl/8pfUQrGoejCwWCyRsIFKsCp/NqoNYqAJzWzB58D/9YO3PYCj4zYH9JOdY8
 Stn0vPWMvgfCMQcaY6am/CC957fBY7OaE9o7wwAmfVOBwRoUr0mXZy1+l9wlobC+p8otmWeYDo2
 hj5dXxg238cR1IsjkObiLR8Ts2FDbfoj15Ev2t+BeAEfWcE0WgLqLGoaj17NVbECUrVmUM4gFHx
 N6i6Y0K/4K2xsZ7qfQXdmqMOo90BGjzG6Jtq11QBot4Eh3IdkHi9z8+TL10KGmxwEIWvAGwO+KR
 s6M/HMgfuur8hKx5ZwAsfxuAQLgUDDglCaEuirp7WUNA==
From:   Jonas Karlman <jonas@kwiboo.se>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Alex Bee <knaerzche@gmail.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        Christopher Obbard <chris.obbard@collabora.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v3 00/10] media: rkvdec: Add H.264 High 10 and 4:2:2 profile support
Date:   Sun, 29 Oct 2023 18:34:07 +0000
Message-ID: <20231029183427.1781554-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 653ea5b98fe0ffca230b0f08
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a revival of a 3 year old series [1] now that NV15/NV20/NV30 support
for display driver have landed in drm-misc tree.

This series adds H.264 High 10 and 4:2:2 profile support to the Rockchip
Video Decoder driver.

Patch 1 adds helpers for calculating plane bytesperline and sizeimage.
Patch 2 adds two new pixelformats for semi-planer 10-bit 4:2:0/4:2:2 YUV.

Patch 3 change to use bytesperline and buffer height to configure strides.
Patch 4 change to use values from SPS/PPS control to configure the HW.
Patch 5 remove an unnecessary call to validate sps at streaming start.

Patch 6-9 refactor code to support validation and filtering of CAPUTRE
formats based on codec ops.

Patch 10 adds final bits to support H.264 High 10 and 4:2:2 profiles.

Changes in v3:
- Drop merged patches
- Use bpp and bpp_div instead of prior misuse of block_w/block_h
- New patch to use values from SPS/PPS control to configure the HW
- New patch to remove an unnecessary call to validate sps at streaming start
- Reworked pixel format validation

Changes in v2:
- Collect r-b tags
- SPS pic width and height in mbs validation moved to rkvdec_try_ctrl
- New patch to not override output buffer sizeimage
- Reworked pixel format validation
- Only align decoded buffer instead of changing frmsize step_width

Following drm-misc commits adds support for NV15/NV20/NV30 to VOP driver:
728c15b4b5f3 ("drm/fourcc: Add NV20 and NV30 YUV formats")
d4b384228562 ("drm/rockchip: vop: Add NV15, NV20 and NV30 support")

To fully runtime test this series you may need above drm commits and ffmpeg
patches from [2], this series and drm patches is also available at [3].

[1] https://lore.kernel.org/linux-media/20200706215430.22859-1-jonas@kwiboo.se/
[2] https://github.com/jernejsk/FFmpeg/commits/v4l2-request-n6.0/
[3] https://github.com/Kwiboo/linux-rockchip/commits/linuxtv-rkvdec-high-10-v3/

Regards,
Jonas

Alex Bee (1):
  media: rkvdec: h264: Don't hardcode SPS/PPS parameters

Jonas Karlman (9):
  media: v4l2-common: Add helpers to calculate bytesperline and
    sizeimage
  media: v4l2: Add NV15 and NV20 pixel formats
  media: rkvdec: h264: Use bytesperline and buffer height as virstride
  media: rkvdec: h264: Remove SPS validation at streaming start
  media: rkvdec: Extract rkvdec_fill_decoded_pixfmt helper method
  media: rkvdec: Move rkvdec_reset_decoded_fmt() function
  media: rkvdec: Prepare for adding format validation ops
  media: rkvdec: Add get_fmt_opaque and valid_fmt ops
  media: rkvdec: h264: Support High 10 and 4:2:2 profiles

 .../media/v4l/pixfmt-yuv-planar.rst           | 128 ++++++++++++
 drivers/media/v4l2-core/v4l2-common.c         |  80 ++++----
 drivers/media/v4l2-core/v4l2-ioctl.c          |   2 +
 drivers/staging/media/rkvdec/rkvdec-h264.c    |  91 ++++----
 drivers/staging/media/rkvdec/rkvdec.c         | 194 +++++++++++++-----
 drivers/staging/media/rkvdec/rkvdec.h         |   3 +
 include/uapi/linux/videodev2.h                |   2 +
 7 files changed, 367 insertions(+), 133 deletions(-)

--
2.42.0

