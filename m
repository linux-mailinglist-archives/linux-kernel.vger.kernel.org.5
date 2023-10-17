Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2E07CBF21
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 11:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234920AbjJQJ2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 05:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234911AbjJQJ1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 05:27:47 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039A4132
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 02:27:37 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-5079f6efd64so4046260e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 02:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697534856; x=1698139656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pS4a4EGcukWNDLRE2YgnhxxLWaSY26SIF3Mm3XN+DRA=;
        b=otpTBB06EYnDNVDwJY5GMDU8U1BTq3YaMdZoKoMJAb/NdikHWQTCJzcLHMFM2bfMs4
         gqL12zLkpKV0tPtYgabV5mE47fZtqq+wYYsaKfaOyz7WYjthITSMaAzCfaGs3kZIOYeF
         fZ5xfq4fFqODiZU+VSleSU6hJPvdQYxWw1euVsAQoZRhIn5ZSBfRDvR/sG06a6dUzRU0
         hANpl9KpjqslcJTAYdAg1fwVCcB8lmswjC/ml2gKeZEli2rbjPZleFi0YVCg0M4IQ/5L
         ++sYMPxpENaGnY5/pkjmx9rLhw2dII8oldV2/Ng9mtwWwlt8xgIyVsXe3RTS1SJefLTB
         3Wnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697534856; x=1698139656;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pS4a4EGcukWNDLRE2YgnhxxLWaSY26SIF3Mm3XN+DRA=;
        b=BY37+AIQiP/54yby0j31Z3GBSuH5z21I7Bz3xjPSWPZ85hUo8ziWSYEhcymDIYxg2w
         NXgt85Tcf9TpHVUv5AChr/8fY8IhBYgZjCH1E5W2pDxttn105RcoQQrJDjckwbe0tmgq
         Zy8MdzSG17prVkqVnLC15Xa1HyQitQj56WDswfIDjzT2glsZkAf2u4w76pyQ4X0VKMu7
         qsdDTE3T4Bqv1hVIr+nv4jXBlwM4gPxlFoXPv7+xJXCjgB2rtXO3ZrrES7bCltH3HHuT
         tJNpdeSRnvGCJ+z4swpqWB7PNyaBiKcJha050vH6renGG5DJGod7lCQcX3afUH4Or2hg
         3y/g==
X-Gm-Message-State: AOJu0YxYLTCAp7sBoHTSXS+Uc/yFDCW/DpuluRmaQPjZI/UnClcD1VjF
        SSvJHDtrTRPo4Wh5bt1oM2fFTQ==
X-Google-Smtp-Source: AGHT+IF/egdZII4kru9SBHTW0O/r1+PG/CtRqw6z6UOEjseVewU3XFTFxOLHbhsN87p+XXRBmvQC7A==
X-Received: by 2002:a05:6512:3c82:b0:507:aaa9:b080 with SMTP id h2-20020a0565123c8200b00507aaa9b080mr1671271lfv.33.1697534855976;
        Tue, 17 Oct 2023 02:27:35 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:f1ee:b000:ce90:ed14])
        by smtp.gmail.com with ESMTPSA id j5-20020a05600c1c0500b003fe1c332810sm9460787wms.33.2023.10.17.02.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 02:27:35 -0700 (PDT)
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
Subject: [PATCH v5 00/15] arm64: qcom: add and enable SHM Bridge support
Date:   Tue, 17 Oct 2023 11:27:17 +0200
Message-Id: <20231017092732.19983-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
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

v4 -> v5:
- fix the return value from qcom_tzmem_init() if SHM Bridge is not supported
- remove a comment that's no longer useful
- collect tags

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
 drivers/firmware/{ => qcom}/qcom_scm-smc.c    |  30 +-
 drivers/firmware/{ => qcom}/qcom_scm.c        | 179 +++++----
 drivers/firmware/{ => qcom}/qcom_scm.h        |  21 +-
 drivers/firmware/qcom/qcom_tzmem.c            | 365 ++++++++++++++++++
 drivers/firmware/qcom/qcom_tzmem.h            |  13 +
 include/linux/firmware/qcom/qcom_qseecom.h    |   4 +-
 include/linux/firmware/qcom/qcom_scm.h        |   6 +
 include/linux/firmware/qcom/qcom_tzmem.h      |  28 ++
 17 files changed, 746 insertions(+), 315 deletions(-)
 create mode 100644 drivers/firmware/qcom/Kconfig
 create mode 100644 drivers/firmware/qcom/Makefile
 rename drivers/firmware/{ => qcom}/qcom_qseecom.c (100%)
 rename drivers/firmware/{ => qcom}/qcom_qseecom_uefisecapp.c (84%)
 rename drivers/firmware/{ => qcom}/qcom_scm-legacy.c (100%)
 rename drivers/firmware/{ => qcom}/qcom_scm-smc.c (90%)
 rename drivers/firmware/{ => qcom}/qcom_scm.c (93%)
 rename drivers/firmware/{ => qcom}/qcom_scm.h (88%)
 create mode 100644 drivers/firmware/qcom/qcom_tzmem.c
 create mode 100644 drivers/firmware/qcom/qcom_tzmem.h
 create mode 100644 include/linux/firmware/qcom/qcom_tzmem.h

-- 
2.39.2

