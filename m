Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD8767AF0E9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 18:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235340AbjIZQkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 12:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235322AbjIZQkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 12:40:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 310CC10A
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 09:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695746359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=837Kme305+Qcb4evSQsWQExwLiy1HV1fTxRz6UFoLMg=;
        b=DoFVRQsL/NRtztb58guy782YuN1GOcItPbLPZ6apYxg6O+yzx/WpKNdm5LbYWFqTBqLYPS
        IqadRfJpEALBvSrqgP5jOgh6vt2E09iAKyHpp63FTDxrxrxW5Y5Aojvfyx7FXkaoIJTx5v
        vP1VzYzL8UAQeTCSBPjwwf7u2n/Qokc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-ECfGvOjaNdSkK23clOqkuA-1; Tue, 26 Sep 2023 12:39:17 -0400
X-MC-Unique: ECfGvOjaNdSkK23clOqkuA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-405917470e8so46201255e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 09:39:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695746356; x=1696351156;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=837Kme305+Qcb4evSQsWQExwLiy1HV1fTxRz6UFoLMg=;
        b=feXyGRUXJ81BKKG1MUiBC/VPQO3tzL1fvVCVn3UPKKIh6/MIz98rfMw/rzmaInUsW7
         Keq/hXc9aXy6j4nmZUqlNh9L8mcBYR5S8ZNtqR97PY9G8jO1aqK6Ipof3Rkm4FauH2Cz
         7W8OZJ3+JeAwJX+PEzFOSzy+UOw9Or8pBLu2j6hPVJ9PWsfA+dLjxyKVk9L2hhQyKFJM
         Fqcxi8IKzcNQbXgeLvWd/VZKO87BrNRtKPzInkOFxSDLLaK2nIAxumeCdy2jeVt6WJ2U
         DxdW0JlL61tjLU1j2PF7p0tOKNc8dQ4R6a7rn19uC0r8GJtzJ/keOGP1y0IadiH0+kPq
         tupQ==
X-Gm-Message-State: AOJu0Ywn4RNJWgSlNBTe3qBc/lYP+7gEWRSL3sqR4a15AdPbzbZJG6rr
        cKz8mi/w5uL0GpMDtBr0NK2XnG1LmKHlnzG2LvmwI0GwF+1A67lvQT9m48s3a48Ged5BDOr1Y2S
        ZtdeBiEvFxWRjnWQHNieKjFI=
X-Received: by 2002:a05:600c:3658:b0:405:359e:ee43 with SMTP id y24-20020a05600c365800b00405359eee43mr8949387wmq.1.1695746356070;
        Tue, 26 Sep 2023 09:39:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDq2Y03ww54+pIYPefZxQl9NkeQGLGMHlVqfNsz/9UH8/RNnXfpZ1pegaFQwZZdpw6zGn82Q==
X-Received: by 2002:a05:600c:3658:b0:405:359e:ee43 with SMTP id y24-20020a05600c365800b00405359eee43mr8949366wmq.1.1695746355754;
        Tue, 26 Sep 2023 09:39:15 -0700 (PDT)
Received: from klayman.redhat.com (net-2-34-30-58.cust.vodafonedsl.it. [2.34.30.58])
        by smtp.gmail.com with ESMTPSA id w10-20020adfde8a000000b0031fba0a746bsm15171803wrl.9.2023.09.26.09.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 09:39:15 -0700 (PDT)
From:   Marco Pagani <marpagan@redhat.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: [PATCH 0/4] fpga: add platform drivers to the FPGA KUnit test suites
Date:   Tue, 26 Sep 2023 18:39:07 +0200
Message-ID: <20230926163911.66114-1-marpagan@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add and register minimal platform drivers associated with parent
platform devices used for testing to prevent a null-ptr-deref when
try_module_get() is called.

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

