Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C18F7AB6E8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 19:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbjIVRNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 13:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232287AbjIVRNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 13:13:06 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC251B0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:12:57 -0700 (PDT)
Received: from ginger.. (unknown [177.98.21.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: koike)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5633D6607262;
        Fri, 22 Sep 2023 18:12:51 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695402776;
        bh=AxQ28p5S5GmVSbnU0jiwXnKK+GT+jESsGF+xjPThjDw=;
        h=From:To:Cc:Subject:Date:From;
        b=H8ILSP/y7VBgP8A2WJoBG5c/iMSrK00F/VQB5B/SdG8wqMUDn0A6ycuioUUdS8c0T
         lAxK2Dh0kGkhfhuH8EzZnfCGg+5NJAHd82FueP3gcwwyBgprXxoyC8lLBn8xiqUkFy
         FbJcFCteQDesVuTh/Pvv+jPXHLxmQrwntjmUs3TAs0h6bD6TirZNzhUdvpnMnDTVg4
         b6cMaJ8fsKjFL4ZL/cWG4o561udLHacc9K5o6/nJAzV/QeauehSnmo6YPdBMdVHuRl
         z2HE7dLji55P8TxQen6aby8ECSjcx+dXw9FU/1nzxPwH82VYM24YUZGuYe5DqJLwx8
         1xbvsQm+9jIxw==
From:   Helen Koike <helen.koike@collabora.com>
To:     dri-devel@lists.freedesktop.org
Cc:     airlied@gmail.com, daniel@ffwll.ch, rodrigosiqueiramelo@gmail.com,
        melissa.srw@gmail.com, mairacanal@riseup.net,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        daniel@fooishbar.org, vignesh.raman@collabora.com,
        jani.nikula@linux.intel.com, mripard@kernel.org,
        michel.daenzer@mailbox.org, quic_abhinavk@quicinc.com,
        quic_jesszhan@quicinc.com
Subject: [PATCH v2 0/2] drm/ci: Update Mesa and Introduce VKMS Support
Date:   Fri, 22 Sep 2023 14:12:35 -0300
Message-Id: <20230922171237.550762-1-helen.koike@collabora.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset offers two enhancements to drm/ci:

1. Mesa Version Update. drm/ci re-uses components from Mesa project.
A recent bug in MesaCI was fixed. The first patch updates drm/ci
Mesa's version, re-allowing containers rebuilds when uncached,
essencial for new runs.

2. VKMS Driver Testing, together with the -skips.txt and -fails.txt
list that were found during the tests.

See pipeline https://gitlab.freedesktop.org/helen.fornazier/linux/-/pipelines/992263
(there is a vgem job on top but it shouldn't affect the result)


v2:
- mesauprev: point to upstream mesa/mesa (solved the TODO and removed RFC tag)
- vkms jov: do not mv modules to /lib/modules in the job definition, leave it to
  crosvm-runner.sh

Helen Koike (2):
  drm/ci: uprev mesa version - fix container build
  drm/ci: add tests on vkms

 MAINTAINERS                                   |  1 +
 drivers/gpu/drm/ci/build.sh                   |  1 -
 drivers/gpu/drm/ci/gitlab-ci.yml              | 16 +++++++++-
 drivers/gpu/drm/ci/igt_runner.sh              |  6 ++--
 drivers/gpu/drm/ci/image-tags.yml             |  2 +-
 drivers/gpu/drm/ci/lava-submit.sh             |  2 +-
 drivers/gpu/drm/ci/test.yml                   | 23 ++++++++++++++-
 drivers/gpu/drm/ci/x86_64.config              |  1 +
 .../drm/ci/xfails/virtio_gpu-none-flakes.txt  |  0
 drivers/gpu/drm/ci/xfails/vkms-none-fails.txt | 29 +++++++++++++++++++
 drivers/gpu/drm/ci/xfails/vkms-none-skips.txt | 10 +++++++
 11 files changed, 83 insertions(+), 8 deletions(-)
 delete mode 100644 drivers/gpu/drm/ci/xfails/virtio_gpu-none-flakes.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/vkms-none-fails.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/vkms-none-skips.txt

-- 
2.34.1

