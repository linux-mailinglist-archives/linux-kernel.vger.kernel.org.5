Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3365A757CEF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 15:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbjGRNKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 09:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232606AbjGRNKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 09:10:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803FC19F
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 06:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689685764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=T5QD2fsjtTcZ/589j4SQYIRD/EBKlbJl3ariQjPHEPM=;
        b=PzyblA59gjtqwdIQFPcp7ewwmuP+IZHteurPFjXChnyZoWv6zJpH/nALWbYhpmom799RmT
        heooO/9Yqew0kUUaDaYfEuoTfNOMYTrFYkTlLJcaen1cHuCnou61YqA3LtKGBqPOxl4MJQ
        nKKohNDxCD1oAXL6tivRLORCahDIPAg=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-98hbbsxEOz6afE-afqGHXA-1; Tue, 18 Jul 2023 09:03:16 -0400
X-MC-Unique: 98hbbsxEOz6afE-afqGHXA-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-635e91cba88so64705856d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 06:03:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689685396; x=1692277396;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T5QD2fsjtTcZ/589j4SQYIRD/EBKlbJl3ariQjPHEPM=;
        b=GtbF9zH8VXrykW+mbVi1ufEmH9nOKE3UAfpG9UfVsi6CY1oT35cf1Hh7sOqYz3EZgx
         iup/gDEwcHtHfTdjWJHwRBxIsB6w9/8KfDQvTIgrpf01sHNfFqLt7BYP18DgPIIItC3r
         pGXDK513/I0zNkhSjdsA7f7wJDgOLT2i7OJ/XAZaJoO0UvUCV3VxuiQdrIGZoMAfu/39
         nItzw/g4eXniZ6zbvKG2FEKseIqqrF/ykE5f1B02dAmQ5shyMePCf4PIVi9KIPY2NF61
         s/Ym4+ruNJViJmqK7c8vQqmIcdEEbMH7N3y0gxD86dflUtAVXdmW8Gmsjbay96mH9s+e
         9ctg==
X-Gm-Message-State: ABy/qLZ7sdadZyER0lSGfBRozWiSJa8ySmJGl/R5s01gIFRvnRCsL6bI
        mBrHykKdFIfy/WczOpUCsBg+a9QSNJIBO62gA32YTg7k6dgoqdzgZVeqTkTfMR9tYZXmCyKo76d
        642h8LmXSarQbzLgBkBk9qpU=
X-Received: by 2002:a0c:b305:0:b0:635:f35c:3f87 with SMTP id s5-20020a0cb305000000b00635f35c3f87mr14409650qve.8.1689685396258;
        Tue, 18 Jul 2023 06:03:16 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGT6ykKWcrEdp+40wspG3hIKFDRxl7eVhKuyVgB+xl2dEZ67+NazgxWX2u3xZ55qSle5LKEnA==
X-Received: by 2002:a0c:b305:0:b0:635:f35c:3f87 with SMTP id s5-20020a0cb305000000b00635f35c3f87mr14409611qve.8.1689685395570;
        Tue, 18 Jul 2023 06:03:15 -0700 (PDT)
Received: from klayman.redhat.com (net-2-34-27-228.cust.vodafonedsl.it. [2.34.27.228])
        by smtp.gmail.com with ESMTPSA id h18-20020a05620a10b200b00765ab6d3e81sm550221qkk.122.2023.07.18.06.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 06:03:15 -0700 (PDT)
From:   Marco Pagani <marpagan@redhat.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: [PATCH v10 0/4] fpga: add initial KUnit tests for the subsystem
Date:   Tue, 18 Jul 2023 15:03:00 +0200
Message-ID: <20230718130304.87048-1-marpagan@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set introduces an initial set of KUnit test suites for the
core components of the FPGA subsystem.

Tests can be run using:
[user@localhost linux]$ ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/fpga/tests

v10:
- Improved code style and fixed comment typos for FPGA Manager ops

v9:
- Improved and commented test ops for the FPGA Manager test suite
- Fixed minor capitalization discrepancies

v8:
- Using memset to set header and payload of the test image
- Using sg_miter_* functions to check the image in the write_sg op
- Includes sorted in alphabetical order
- Add commas for fpga_bridge_ops
- Improved Makefile

v7:
- Dropped RFC prefix
- Add comments to explain fakes and helper functions
- Changed the implementation of the Bridge used in the Region suite

v6:
- Restructured the code into self-contained test modules
- Added tests for the basic behaviors of the components
- Improved programming tests for the FPGA Manager
- Fixed code/comments mismatch in the list of Bridges test case

v5:
- Removed most of the exported functions using shared buffers for stats
- Moved all KUnit expectations/assertions to the main test module
- Removed standalone use case to simplify the code
- Removed instances counters from fake components (using device.id instead)
- Set header size in the .parse_header op
- Improved bridge get_put_list test case

v4:
- Fix build error

v3:
- Calling fpga_bridges_put() between reconfigurations
- Functions for registering fake modules allocate and return context structs

v2:
- Restructured code into multiple suites to test components in isolation
- Reduced code duplication using init and exit methods
- Using a get_bridges() method to build the list of bridges just before programming
- Regions and Bridges are organized topologically
- Changed bitstream/bit to images
- Allocate images dynamically
- Renamed fpga-tests to fpga-test
- Simplified Kconfig
- Add license info to the fpga-test module

Marco Pagani (4):
  fpga: add an initial KUnit suite for the FPGA Manager
  fpga: add an initial KUnit suite for the FPGA Bridge
  fpga: add an initial KUnit suite for the FPGA Region
  fpga: add configuration for the FPGA KUnit test suites.

 drivers/fpga/Kconfig                  |   2 +
 drivers/fpga/Makefile                 |   3 +
 drivers/fpga/tests/.kunitconfig       |   5 +
 drivers/fpga/tests/Kconfig            |  11 +
 drivers/fpga/tests/Makefile           |   6 +
 drivers/fpga/tests/fpga-bridge-test.c | 175 ++++++++++++++
 drivers/fpga/tests/fpga-mgr-test.c    | 327 ++++++++++++++++++++++++++
 drivers/fpga/tests/fpga-region-test.c | 211 +++++++++++++++++
 8 files changed, 740 insertions(+)
 create mode 100644 drivers/fpga/tests/.kunitconfig
 create mode 100644 drivers/fpga/tests/Kconfig
 create mode 100644 drivers/fpga/tests/Makefile
 create mode 100644 drivers/fpga/tests/fpga-bridge-test.c
 create mode 100644 drivers/fpga/tests/fpga-mgr-test.c
 create mode 100644 drivers/fpga/tests/fpga-region-test.c


base-commit: fdf0eaf11452d72945af31804e2a1048ee1b574c
-- 
2.41.0

