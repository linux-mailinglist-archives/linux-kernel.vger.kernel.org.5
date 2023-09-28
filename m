Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2953C7B1715
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 11:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbjI1JVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 05:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbjI1JVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 05:21:07 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996568E
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 02:21:01 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-32488a22810so261980f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 02:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1695892860; x=1696497660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Oh9cj7emIXRYfVzKVzGsfFEfSezfYh/zsZTNNRw9uKk=;
        b=eeH1cMhIYZyFWo4wuhbK1K9AexcD8ELSrx4+lhEnY9LCAEsTyp4WKszRpfucYcg5b2
         lh6pa+i9bkaZQ98zQgXJfAF7Ch9aM4fy5AKMOcaH2boY0pQRhKxrAan2+lYie+sEgB0Y
         4m6rIFAhMROpfFR9f8mUSe0Mp3qjLzJgzRyJSxMz2sKpg7AK0fGGIe5ln/BY7fHgMs1S
         3o+jiOLYRA8nimlunJMcZrT/tdGChRwyKTYbIqYhZgbm71YnDwgF5nMsOoXT9EmdHexh
         zbEr7o009zA1Zgc+GhJj2gnmo9Z62Es6fp66K8TwxuC+mpJhJV2q6kkjkSaPFzSPPeWZ
         XacQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695892860; x=1696497660;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Oh9cj7emIXRYfVzKVzGsfFEfSezfYh/zsZTNNRw9uKk=;
        b=Sx3xzs0muZq9XIghK8eUoKjmywU05c2x4/q3RBw5oiT+bNA1zvnIbCftIwatdEn8cg
         GWgHuJm7sxNs0oLwKhdcqAD8GTIqK5Awke0TwcUHl8jXGKTZO0e8na5w9ngwzq7T7v6D
         hgWonaHalq62rkDa/6WA8Ey5DbVp+8bz54I6ZQnNpyzrgjr3Eo/JBMc21OBV+VW9lV/C
         YeeXEcQfxNJB8X8Aba0YkvRgdbjnvmaHocDofkJqJtSOPUbv8jay7UQWgF3SXofi0sMV
         ojTahV4xXP1Aj4ChwSf9j54QaLOLoMC8k3O5mLE1ntrBuSEQLQdZEi2f2cwcVhdM9Sm6
         iStg==
X-Gm-Message-State: AOJu0YxwCFtLDAlexs5n7p2jlr5mtU2LooRIBkxIYgdXzCq/BYvUfdw8
        PjL7QpbNQC3DhAjH10+YeUY0XQ==
X-Google-Smtp-Source: AGHT+IEmRB93IHqkI+FEarFdfiDoG74c83jd/+Pi1E+NcrPtrEXk0oH7u/JRCroiepCaQzNqmADvSQ==
X-Received: by 2002:adf:f641:0:b0:324:647e:a8b3 with SMTP id x1-20020adff641000000b00324647ea8b3mr718935wrp.14.1695892859940;
        Thu, 28 Sep 2023 02:20:59 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:6e4c:e3c1:5cb8:b60e])
        by smtp.gmail.com with ESMTPSA id e9-20020adfe7c9000000b003197efd1e7bsm5009156wrn.114.2023.09.28.02.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 02:20:59 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        kernel@quicinc.com,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 00/11] arm64: qcom: add and enable SHM Bridge support
Date:   Thu, 28 Sep 2023 11:20:29 +0200
Message-Id: <20230928092040.9420-1-brgl@bgdev.pl>
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

This is technically the second iteration of the SHM Bridge enablement on
QCom platforms but in practice it's a complete rewrite.

During the internal discussion with QCom the requirement has been established
as an SHM Bridge pool manager with the assumption that there will be multiple
users, each with their own pool. The problem with this is that we don't have
many potential users of SHM pools upstream at the moment which was rightfully
pointed out in the reviews under v1 (which even had some unused symbols etc.).

Moreover: after some investigating, it turns out that there simply isn't any
need for multiple pools as the core SCM only allocates a buffer if given call
requires more than 4 arguments and there are only a handful of SCM calls that
need to pass a physical address to a buffer as argument to the trustzone.

Additionally all but one SCM call allocate buffers passed to the TZ only for
the duration of the call and then free it right aftr it returns. The one
exception is called once and the buffer it uses can remain in memory until
released by the user.

This all makes using multiple pools wasteful as most of that memory will be
reserved but remain unused 99% of the time. What we need is a single pool of
SCM memory that deals out chunks of suitable format (coherent and
page-aligned) that fulfills the requirements of all calls.

As not all architectures support SHM bridge, it makes sense to first unify the
memory operations in SCM calls. All users do some kind of DMA mapping to obtain
buffers, most using dma_alloc_coherent() which impacts performance.

Genalloc pools are very fast so let's use them instead. Create a custom
allocator that also deals with the mapping and use it across all SCM calls.

Then once this is done, let's extend the allocator to use the SHM bridge
functionality if available on the given platform.

While at it: let's create a qcom specific directory in drivers/firmware/ and
move relevant code in there.

I couldn't test all SCM calls but tested with the inline crypto engine on
sm8550 and sa8775p that runs most of new code paths (with and without SHM
bridge). At least qseecom would need some Tested-by.

v1 -> v2:
- too many changes to list, it's a complete rewrite as explained above

Bartosz Golaszewski (11):
  firmware: qcom: move Qualcomm code into its own directory
  firmware: qcom: scm: add a dedicated SCM memory allocator
  firmware: qcom: scm: switch to using the SCM allocator
  firmware: qcom: scm: make qcom_scm_assign_mem() use the SCM allocator
  firmware: qcom: scm: make qcom_scm_ice_set_key() use the SCM allocator
  firmware: qcom: scm: make qcom_scm_pas_init_image() use the SCM
    allocator
  firmware: qcom: scm: make qcom_scm_lmh_dcvsh() use the SCM allocator
  firmware: qcom: scm: make qcom_scm_qseecom_app_get_id() use the SCM
    allocator
  firmware: qcom: qseecom: convert to using the SCM allocator
  firmware: qcom-scm: add support for SHM bridge operations
  firmware: qcom: scm: enable SHM bridge

 MAINTAINERS                                   |   4 +-
 drivers/firmware/Kconfig                      |  48 +---
 drivers/firmware/Makefile                     |   5 +-
 drivers/firmware/qcom/Kconfig                 |  56 ++++
 drivers/firmware/qcom/Makefile                |   9 +
 drivers/firmware/{ => qcom}/qcom_qseecom.c    |   0
 .../{ => qcom}/qcom_qseecom_uefisecapp.c      | 251 ++++++------------
 drivers/firmware/{ => qcom}/qcom_scm-legacy.c |   0
 drivers/firmware/qcom/qcom_scm-mem.c          | 170 ++++++++++++
 drivers/firmware/{ => qcom}/qcom_scm-smc.c    |  21 +-
 drivers/firmware/{ => qcom}/qcom_scm.c        | 149 ++++++-----
 drivers/firmware/{ => qcom}/qcom_scm.h        |   9 +
 include/linux/firmware/qcom/qcom_qseecom.h    |   4 +-
 include/linux/firmware/qcom/qcom_scm.h        |  13 +
 14 files changed, 427 insertions(+), 312 deletions(-)
 create mode 100644 drivers/firmware/qcom/Kconfig
 create mode 100644 drivers/firmware/qcom/Makefile
 rename drivers/firmware/{ => qcom}/qcom_qseecom.c (100%)
 rename drivers/firmware/{ => qcom}/qcom_qseecom_uefisecapp.c (84%)
 rename drivers/firmware/{ => qcom}/qcom_scm-legacy.c (100%)
 create mode 100644 drivers/firmware/qcom/qcom_scm-mem.c
 rename drivers/firmware/{ => qcom}/qcom_scm-smc.c (92%)
 rename drivers/firmware/{ => qcom}/qcom_scm.c (94%)
 rename drivers/firmware/{ => qcom}/qcom_scm.h (95%)

-- 
2.39.2

