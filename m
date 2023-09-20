Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1167A8AC8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 19:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjITRpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 13:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjITRpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 13:45:04 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1117DB9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 10:44:58 -0700 (PDT)
Received: from ginger.. (unknown [177.98.21.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: koike)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A648C66071EF;
        Wed, 20 Sep 2023 18:44:52 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695231896;
        bh=7izphSNlUlY6toAYO8sGMEscU9ZreXBpSqo3489vsfo=;
        h=From:To:Cc:Subject:Date:From;
        b=SuC7+g/stbjbvv3I1wIMW1PtOS4W4G1VV1Ow7Tn/nJulcClzdzqfTs5OJRptgpBEY
         W+xlQjH4aCX9gRDERpcQSD3vdJchKU08FmujX1Sn6GBh6k6p1hZajstsiZthwAs+6/
         n8SfNt7Fxc5XW017QSG2fuEW4m7GswbD7gUNbrYTrP05jp5l/KGzEgp8UXVcyosSMx
         OAz3v9JVAIGL48SK3ct58Qupo2t4Ji0In9R2iG0QEbyUHLSOwL5eRf32t3v8i+lO2U
         XKw3OvI9+Zv27KxbNp0eC+qJKE1lDVrUUiIe4Kc0CaOk8W4kPGBlbmuvG68Y8hCVAL
         +y0gmvi8F+Y7Q==
From:   Helen Koike <helen.koike@collabora.com>
To:     dri-devel@lists.freedesktop.org
Cc:     airlied@gmail.com, daniel@ffwll.ch, rodrigosiqueiramelo@gmail.com,
        melissa.srw@gmail.com, mairacanal@riseup.net,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        daniel@fooishbar.org, vignesh.raman@collabora.com,
        jani.nikula@linux.intel.com, mripard@kernel.org,
        michel.daenzer@mailbox.org
Subject: [RFC PATCH 0/2] drm/ci: Update Mesa and Introduce VKMS Support
Date:   Wed, 20 Sep 2023 14:44:42 -0300
Message-Id: <20230920174444.409586-1-helen.koike@collabora.com>
X-Mailer: git-send-email 2.34.1
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

This patchset offers two enhancements to drm/ci:

1. Mesa Version Update. drm/ci re-uses components from Mesa project.
A recent bug in MesaCI was fixed. The first patch updates drm/ci
Mesa's version, re-allowing containers rebuilds when uncached,
essencial for new runs.

At this moment, this change depends on the following MR:
	https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/25238
For now, I'm just pointing to a branch in my personal repo (this is why
it is an RFC) so people can already review and test it.


2. VKMS Driver Testing, together with the -skips.txt and -fails.txt
list that were found during the tests.

Helen Koike (2):
  drm/ci: uprev mesa version - fix container build
  drm: ci: add tests on vkms

 MAINTAINERS                                   |  1 +
 drivers/gpu/drm/ci/build.sh                   |  1 -
 drivers/gpu/drm/ci/gitlab-ci.yml              | 20 +++++++++++--
 drivers/gpu/drm/ci/igt_runner.sh              |  6 ++--
 drivers/gpu/drm/ci/image-tags.yml             |  2 +-
 drivers/gpu/drm/ci/lava-submit.sh             |  2 +-
 drivers/gpu/drm/ci/test.yml                   | 24 ++++++++++++++-
 drivers/gpu/drm/ci/x86_64.config              |  1 +
 .../drm/ci/xfails/virtio_gpu-none-flakes.txt  |  0
 drivers/gpu/drm/ci/xfails/vkms-none-fails.txt | 29 +++++++++++++++++++
 drivers/gpu/drm/ci/xfails/vkms-none-skips.txt | 10 +++++++
 11 files changed, 87 insertions(+), 9 deletions(-)
 delete mode 100644 drivers/gpu/drm/ci/xfails/virtio_gpu-none-flakes.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/vkms-none-fails.txt
 create mode 100644 drivers/gpu/drm/ci/xfails/vkms-none-skips.txt

-- 
2.34.1

