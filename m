Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4A9D7B368F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 17:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233565AbjI2PWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 11:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233536AbjI2PWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 11:22:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7608EF7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 08:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696000872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2RjG0vxzlp2XNSTnbZsP+fW84/NpvbH3AB72ShSUKnA=;
        b=XoyyUVL1jD+jpqvOWJsTp9k6qXksjpXW+z/JlYcagTPNkIP++9Kdp/U52yHYsVOsO+bQks
        4c1me3On5xRpkrl76/AgefhXfzqU6c8Z4s6+xUQQD4OO4L5WlX6j4QUoaicEKgiVbSwSuX
        klf/Skwg7mayg4RZ5zrgeCl+QjnLlOU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-CV0KRmI4NfKrJ_gEKnNNuA-1; Fri, 29 Sep 2023 11:21:11 -0400
X-MC-Unique: CV0KRmI4NfKrJ_gEKnNNuA-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4194d8b6fceso107854661cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 08:21:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696000871; x=1696605671;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2RjG0vxzlp2XNSTnbZsP+fW84/NpvbH3AB72ShSUKnA=;
        b=Ul05ineU3hYe2nRicOEMWTumZFxpPSVRw4bTnwcjjGdQzIgwPKCFrfGzNt9sKwEcT1
         kC/uPwlsz8eIlGLmONVpCLEjP8mEvaf3iqhGVCpJx/wkB/TwbZ8xtYFpRAll5mTFHxZl
         9d7dhYyGtMEM6iNMGd4PCJg17l3FEsEyY+BgBj5JB9b3ITIMZejkBffvK+YDA5ogHJ49
         u4XG/OyKfSpHTmi25j9AsojDj0KgjZFpBkG9phkQDOu516f+E3ninmwJn0VwYzzMftRI
         DuWhjLaInZo706LLUQnychiPhGb0l0lPu8aSGBQ7+WD9iCmSFB/iCP+xyJnWJfLl8Ysw
         L95g==
X-Gm-Message-State: AOJu0YwvMMLi/LG0p3xfz30YxINiPUq20opEF9K9baz4MBtZWiDjfOZL
        eCpH9+PF+97Ql3o7QZouS/LFJhk28KpIiNgdyPmK1o8RS2pRsldK1HMUIGHrOD2c0nne8Oveeuw
        hSWZI8jg7rOb/r8xSHsgvrYs=
X-Received: by 2002:ac8:57c7:0:b0:419:53ce:3fa9 with SMTP id w7-20020ac857c7000000b0041953ce3fa9mr5832304qta.53.1696000870691;
        Fri, 29 Sep 2023 08:21:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEN1zu4gWKrOid0K633sP55/uvJCk4Eh5nH/sEFDbbakhFkC4oZ5JKl9fj1A+P1+6qWn8xKGw==
X-Received: by 2002:ac8:57c7:0:b0:419:53ce:3fa9 with SMTP id w7-20020ac857c7000000b0041953ce3fa9mr5832288qta.53.1696000870476;
        Fri, 29 Sep 2023 08:21:10 -0700 (PDT)
Received: from klayman.redhat.com (net-2-34-30-58.cust.vodafonedsl.it. [2.34.30.58])
        by smtp.gmail.com with ESMTPSA id bq14-20020a05622a1c0e00b00419801b1094sm287053qtb.13.2023.09.29.08.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 08:21:10 -0700 (PDT)
From:   Marco Pagani <marpagan@redhat.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: [PATCH v2 0/4] fpga: add platform drivers to the FPGA KUnit test suites
Date:   Fri, 29 Sep 2023 17:20:53 +0200
Message-ID: <20230929152057.85047-1-marpagan@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add and register minimal platform drivers associated with parent
platform devices used for testing to prevent a null-ptr-deref when
try_module_get() is called.

v2:
- Renamed include guard symbol in fpga-test-helpers.h

Marco Pagani (4):
  fpga: add helpers for the FPGA KUnit test suites.
  fpga: add a platform driver to the FPGA Manager test suite
  fpga: add a platform driver to the FPGA Bridge test suite
  fpga: add a platform driver to the FPGA Region test suite

 drivers/fpga/tests/fpga-bridge-test.c  | 18 +++++++++++++++-
 drivers/fpga/tests/fpga-mgr-test.c     | 18 +++++++++++++++-
 drivers/fpga/tests/fpga-region-test.c  | 26 ++++++++++++++++++-----
 drivers/fpga/tests/fpga-test-helpers.h | 29 ++++++++++++++++++++++++++
 4 files changed, 84 insertions(+), 7 deletions(-)
 create mode 100644 drivers/fpga/tests/fpga-test-helpers.h


base-commit: 6465e260f48790807eef06b583b38ca9789b6072
-- 
2.41.0

