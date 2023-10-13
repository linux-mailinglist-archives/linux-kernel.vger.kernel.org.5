Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532DE7C84DE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 13:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbjJMLtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 07:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbjJMLs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 07:48:56 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD95B7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 04:48:54 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-31f71b25a99so1881428f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 04:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697197733; x=1697802533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2gi1dKzgbLyY2SGQKC/6ay+pgQCsg2LD4vhB0IMddqs=;
        b=Df+x9qIrKOtgMBqVwf8EslOGU+zId7IHjzs4pYWovq3Q1n8gohvzjJuFyEOJNNL0VQ
         G9xymbxKoiLlOJwwjN3EJ5is5Mha6/b9JkXxm7kKD1fJ08BAaQqmU9Tvxeyp47DrT+2T
         Tn+rKI5zQIsf5bnLulL2/qgr5KshrP3uyr53uDZcej3yDPNJ+i4xerYZgCq/z4zhbbIs
         A/bVsSUEZkk/6ZN16TAPotudhvEg4pkHxaSegP7X/SwHrOSzJVnoF4k0Fgo7ezOLJdGe
         P6eq9vIEWCpxszVx/XSB2/HGeT0O84BaYwFKQDTF0o34TzVma8Py1Zd11EAyw83DPDOh
         bMCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697197733; x=1697802533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2gi1dKzgbLyY2SGQKC/6ay+pgQCsg2LD4vhB0IMddqs=;
        b=uqKjzSOhFNbC5J0bKQsUmj4mBuIaceYBjtkGdSZ8uv+91+uYy06R8Ih04YGW3upgUS
         zQa/K6jUYrEVg55LhOtGtWbjuXHHUMuwqEEn7KfyTvcFmJeniEFRvjBYxrmHZq4lYona
         M0QqP3SsslMcv3++EOjC7VkhBzBS4tgxwR9tH5gdFNrylUDGA/9c60/wbp4EJrfHFvwq
         oOb4wJPHF+y1365KeLaLYzBklgR3xQKJEJ0mijQS8QApja6UNjUYuZPA1RwEgh0umP2N
         8KgzqC02XWQV0R7eR2S5Q3gGln4vyXZFWlM1/fbkdZkr14zuzPEiKePx9HyhyzgU4qow
         NfWQ==
X-Gm-Message-State: AOJu0Yzi1rmXE0vcC/nJ2axzlqhWINrPOOZeoY3Am9CnS8+nIkUI4KMA
        rwaF/H1Cf7Htx/hDxxSYiB453Q==
X-Google-Smtp-Source: AGHT+IFWbMSJLaS2e62akmpbNVQl02Sa0VSNKRFr/iE/hQFrd9xJFWfWuGkaE7IwS+onu+pa4TFjGg==
X-Received: by 2002:adf:f28b:0:b0:321:67f4:8bd7 with SMTP id k11-20020adff28b000000b0032167f48bd7mr22133317wro.32.1697197732611;
        Fri, 13 Oct 2023 04:48:52 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:4209:13a:988d:80be])
        by smtp.gmail.com with ESMTPSA id j23-20020a05600c1c1700b00407754b998dsm974509wms.27.2023.10.13.04.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 04:48:52 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@quicinc.com,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v4 00/15] arm64: qcom: add and enable SHM Bridge support
Date:   Fri, 13 Oct 2023 13:48:28 +0200
Message-Id: <20231013114843.63205-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

This is pretty much another full rewrite of the SHM Bridge support
series. After more on- and off-list discussions I think this time it
will be close to the final thing though.

We've established the need for using separate pools for SCM and QSEECOM
as well as the upcoming scminvoke driver.

It's also become clear that in order to be future-proof, the new
allocator must be an abstraction layer of a higher level as the SHM
Bridge will not be the only memory protection mechanism that we'll see
upstream. Hence the rename to TrustZone Memory rather than SCM Memory
allocator.

Also to that end: the new allocator is its own module now and provides a
Kconfig choice menu for selecting the mode of operation (currently
default and SHM Bridge).

Due to a high divergence from v2, I dropped all tags except for
patch 1/15 which didn't change.

Tested on sm8550 and sa8775p with the Inline Crypto Engine and
remoteproc.

v3 -> v4:
- include linux/sizes.h for SZ_X macros
- use dedicated RCU APIs to dereference radix tree slots
- fix kerneldocs
- fix the comment in patch 14/15: it's the hypervisor, not the TrustZone
  that creates the SHM bridge

v2 -> v3:
- restore pool management and use separate pools for different users
- don't use the new allocator in qcom_scm_pas_init_image() as the
  TrustZone will create an SHM bridge for us here
- rewrite the entire series again for most part

v1 -> v2:
- too many changes to list, it's a complete rewrite as explained above

Bartosz Golaszewski (15):
  firmware: qcom: move Qualcomm code into its own directory
  firmware: qcom: scm: add a missing forward declaration for struct
    device
  firmware: qcom: scm: remove unneeded 'extern' specifiers
  firmware: qcom: add a dedicated TrustZone buffer allocator
  firmware: qcom: scm: enable the TZ mem allocator
  firmware: qcom: scm: smc: switch to using the SCM allocator
  firmware: qcom: scm: make qcom_scm_assign_mem() use the TZ allocator
  firmware: qcom: scm: make qcom_scm_ice_set_key() use the TZ allocator
  firmware: qcom: scm: make qcom_scm_lmh_dcvsh() use the TZ allocator
  firmware: qcom: scm: make qcom_scm_qseecom_app_get_id() use the TZ
    allocator
  firmware: qcom: qseecom: convert to using the TZ allocator
  firmware: qcom: scm: add support for SHM bridge operations
  firmware: qcom: tzmem: enable SHM Bridge support
  firmware: qcom: scm: clarify the comment in qcom_scm_pas_init_image()
  arm64: defconfig: enable SHM Bridge support for the TZ memory
    allocator

 MAINTAINERS                                   |   4 +-
 arch/arm64/configs/defconfig                  |   1 +
 drivers/firmware/Kconfig                      |  48 +--
 drivers/firmware/Makefile                     |   5 +-
 drivers/firmware/qcom/Kconfig                 |  86 +++++
 drivers/firmware/qcom/Makefile                |  10 +
 drivers/firmware/{ => qcom}/qcom_qseecom.c    |   0
 .../{ => qcom}/qcom_qseecom_uefisecapp.c      | 261 +++++--------
 drivers/firmware/{ => qcom}/qcom_scm-legacy.c |   0
 drivers/firmware/{ => qcom}/qcom_scm-smc.c    |  28 +-
 drivers/firmware/{ => qcom}/qcom_scm.c        | 179 +++++----
 drivers/firmware/{ => qcom}/qcom_scm.h        |  21 +-
 drivers/firmware/qcom/qcom_tzmem.c            | 365 ++++++++++++++++++
 drivers/firmware/qcom/qcom_tzmem.h            |  13 +
 include/linux/firmware/qcom/qcom_qseecom.h    |   4 +-
 include/linux/firmware/qcom/qcom_scm.h        |   6 +
 include/linux/firmware/qcom/qcom_tzmem.h      |  28 ++
 17 files changed, 746 insertions(+), 313 deletions(-)
 create mode 100644 drivers/firmware/qcom/Kconfig
 create mode 100644 drivers/firmware/qcom/Makefile
 rename drivers/firmware/{ => qcom}/qcom_qseecom.c (100%)
 rename drivers/firmware/{ => qcom}/qcom_qseecom_uefisecapp.c (84%)
 rename drivers/firmware/{ => qcom}/qcom_scm-legacy.c (100%)
 rename drivers/firmware/{ => qcom}/qcom_scm-smc.c (91%)
 rename drivers/firmware/{ => qcom}/qcom_scm.c (93%)
 rename drivers/firmware/{ => qcom}/qcom_scm.h (88%)
 create mode 100644 drivers/firmware/qcom/qcom_tzmem.c
 create mode 100644 drivers/firmware/qcom/qcom_tzmem.h
 create mode 100644 include/linux/firmware/qcom/qcom_tzmem.h

-- 
2.39.2

