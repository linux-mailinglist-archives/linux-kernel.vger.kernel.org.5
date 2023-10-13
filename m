Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 671107C8D6F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 21:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbjJMTEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 15:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbjJMTEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 15:04:32 -0400
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E443C2;
        Fri, 13 Oct 2023 12:04:31 -0700 (PDT)
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6c49f781855so1557009a34.3;
        Fri, 13 Oct 2023 12:04:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697223870; x=1697828670;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SOea3bsamMK4hAXF6CNzM5cnxGOtZw/7j8mHNIqbKNo=;
        b=vECfDo7D8rFez9889/lYemRxSwvtcVQWC9XoXXoRDMDG7maGnEoLQ1j7iWyKgEC0lD
         S47AQH11GuVRVzi5HKby3neVErxVVJ5boC9/PhphgXbEs4yQToxIid0CY/h6Sgdy/Ot8
         GKW+LNugtdOOquRc1Q3F5KmNCZDTbFWHI3xq9oHQmF38W1ToAGNStMMJ7utyIXyk6AVS
         I9yXJZdMNeovFmZnJTR4boHUqSUFirp7/pKiAixxOOX0wkOJ0S3wQDToU9XGT4bUxmaB
         aub6ZLJsaVuVaI81Rvn9kkmHDHGcXAFts90mziwQG/1P47vIcTGmYn9i/+T4/7aCOZNE
         WfIA==
X-Gm-Message-State: AOJu0Yy2pvQSdEwtPmNSdTtD3c2wAmg+Kk8dLhgKcVilQdqS58RnSqLj
        eUQrFHN9Oy0wErYlEZNDHoMA6w9Nug==
X-Google-Smtp-Source: AGHT+IHmQjAasi9qypMXf81lriTnj2NPbj41ulVVOk4ZfRqplqK31lYG66kevPxsF+n6lPlYzHMQQg==
X-Received: by 2002:a05:6830:3d17:b0:6c0:e5c3:40b5 with SMTP id eu23-20020a0568303d1700b006c0e5c340b5mr26495473otb.6.1697223870362;
        Fri, 13 Oct 2023 12:04:30 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r25-20020a056830135900b006c63d749becsm752581otq.58.2023.10.13.12.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 12:04:29 -0700 (PDT)
Received: (nullmailer pid 247804 invoked by uid 1000);
        Fri, 13 Oct 2023 19:04:28 -0000
From:   Rob Herring <robh@kernel.org>
To:     Jan Luebbe <jlu@pengutronix.de>, Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] EDAC: armada_xp: Explicitly include correct DT includes
Date:   Fri, 13 Oct 2023 14:03:42 -0500
Message-ID: <20231013190342.246973-1-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DT of_device.h and of_platform.h date back to the separate
of_platform_bus_type before it was merged into the regular platform bus.
As part of that merge prepping Arm DT support 13 years ago, they
"temporarily" include each other. They also include platform_device.h
and of.h. As a result, there's a pretty much random mix of those include
files used throughout the tree. In order to detangle these headers and
replace the implicit includes with struct declarations, users need to
explicitly include the correct includes.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/edac/armada_xp_edac.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/armada_xp_edac.c b/drivers/edac/armada_xp_edac.c
index c4bd2fb9c46b..f18db536d58e 100644
--- a/drivers/edac/armada_xp_edac.c
+++ b/drivers/edac/armada_xp_edac.c
@@ -5,7 +5,9 @@
 
 #include <linux/kernel.h>
 #include <linux/edac.h>
-#include <linux/of_platform.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
 
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/hardware/cache-aurora-l2.h>
-- 
2.42.0

