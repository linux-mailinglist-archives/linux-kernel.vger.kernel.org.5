Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A647CE2FE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 18:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjJRQj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 12:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjJRQjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 12:39:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A03EA
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 09:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697647120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=oHj6EwFz8BHjW/yggtu6OM4m0PkCRoLlO9ayp66fdYs=;
        b=JAGUYqzozHINk6HZ1d6kaVlZMxEkT0OiZ1kPREptYqo7hYMQx/1/42rXGoVWOGN7BYzTuQ
        PNhYI/zww1bNnaJ84se8HcDUbBzkI4L9Zni7hxRtiSpoX4DF69tHMzmwPsRUsdSiOA1d0n
        iFYmfAKPp7rf2CBEtJfstyd3HA4P88U=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-5rp-c6lCOFSw6oKsrXnmNw-1; Wed, 18 Oct 2023 12:38:34 -0400
X-MC-Unique: 5rp-c6lCOFSw6oKsrXnmNw-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-66d38d57f49so50017216d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 09:38:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697647113; x=1698251913;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oHj6EwFz8BHjW/yggtu6OM4m0PkCRoLlO9ayp66fdYs=;
        b=EXWb0fFDQlZD1fGWrwbMgLBNo235R+v3SOH/ktdtf7bDrHjtHglZvVWWUPdDGOcgMS
         UhJ4ajFWKpEnSZfIHBUBX2L8GMMA6oL0GucrFTPoczaCpfto/b5x61AE+8AhBoJHoVht
         OPvbbXLICq0EkVsdzYSMY/j0rH8WIJOVCGdKyotAFkE/+ZA8M44o/QR+FjrUa/Npn3FL
         EsMmxEN+e6U/90jo4VBlzqiHpEDeinF6osDhnVTNX8Zx8EJExR37wbeQrFT8kj4SHcxe
         1WVkDxI2rpYNemCB0mR/aQJjMpB0aHHBTlW/3AQhKDFdgrzsGCCnzDviog0V1AMUwVbJ
         d6ng==
X-Gm-Message-State: AOJu0YzMWM8egSmiJL7DA82tgJWsu0WQu+vpP7XaiGKCMqbkbAHQswhD
        tz8v83yauyCcWB7o6MWFc7ixef4rt80zkGuZ30VHpBZJtUmy02ayra8+1ueYlsuqpWT5+GkkkRH
        KzzaeOUPMYZvyZicQ9Q77qeU=
X-Received: by 2002:ad4:5b8b:0:b0:66d:43fd:f4e4 with SMTP id 11-20020ad45b8b000000b0066d43fdf4e4mr5312166qvp.45.1697647113740;
        Wed, 18 Oct 2023 09:38:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRD+Ge85kWm9yZdvPOOqG6RtGusTbEBje3/ErVCbJtUf+gccGOsYnKb7S21qIV56jPHTesKA==
X-Received: by 2002:ad4:5b8b:0:b0:66d:43fd:f4e4 with SMTP id 11-20020ad45b8b000000b0066d43fdf4e4mr5312147qvp.45.1697647113412;
        Wed, 18 Oct 2023 09:38:33 -0700 (PDT)
Received: from klayman.redhat.com (net-2-34-31-107.cust.vodafonedsl.it. [2.34.31.107])
        by smtp.gmail.com with ESMTPSA id mi1-20020a056214558100b0066d15724ff7sm81896qvb.52.2023.10.18.09.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 09:38:33 -0700 (PDT)
From:   Marco Pagani <marpagan@redhat.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fpga: disable KUnit test suites when module support is enabled
Date:   Wed, 18 Oct 2023 18:38:13 +0200
Message-ID: <20231018163814.100803-1-marpagan@redhat.com>
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

The fpga core currently assumes that all manager, bridge, and region
devices have a parent device associated with a driver that can be used
to take the module's refcount. This behavior causes the fpga test suites
to crash with a null-ptr-deref since parent fake devices do not have a
driver. This patch disables all fpga KUnit test suites when loadable
module support is enabled until the fpga core is fixed. Test suites
can still be run using the KUnit default UML kernel.

Signed-off-by: Marco Pagani <marpagan@redhat.com>
---
 drivers/fpga/tests/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/tests/Kconfig b/drivers/fpga/tests/Kconfig
index e4a64815f16d..d4e55204c092 100644
--- a/drivers/fpga/tests/Kconfig
+++ b/drivers/fpga/tests/Kconfig
@@ -1,6 +1,6 @@
 config FPGA_KUNIT_TESTS
-	tristate "KUnit test for the FPGA subsystem" if !KUNIT_ALL_TESTS
-	depends on FPGA && FPGA_REGION && FPGA_BRIDGE && KUNIT=y
+	bool "KUnit test for the FPGA subsystem" if !KUNIT_ALL_TESTS
+	depends on FPGA=y && FPGA_REGION=y && FPGA_BRIDGE=y && KUNIT=y && MODULES=n
 	default KUNIT_ALL_TESTS
         help
           This builds unit tests for the FPGA subsystem
-- 
2.41.0

