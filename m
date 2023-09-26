Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5114C7AF442
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 21:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbjIZTmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 15:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjIZTmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 15:42:54 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDADCFC
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 12:42:47 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-79fb64b5265so229298339f.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 12:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695757367; x=1696362167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ylRB+o0Qkrun1yi4fSnYM174Q1wG3Ph+hurLuy8H7Hg=;
        b=TWm/VCEj9si6AjdAXsmNB/RbeRtOrLatEwkYKR+e8ab+fZZVdF0Ze8ewRdwZlSfYRk
         U3mS12hlGML+XU+1lFTvG8devxxWKU20JxkERQzwOJ5e8rm8r+9e4VuSuc2+soiuCFt7
         8rowKY81p6mGn+BYqQklLUGGovkJ/CPxcitoo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695757367; x=1696362167;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ylRB+o0Qkrun1yi4fSnYM174Q1wG3Ph+hurLuy8H7Hg=;
        b=WQpORTN0q2abv1N/WVrDFcYYyqTU4DojhTNxOaBjFbgIxyp5TnMj47Rxv+simeEVHW
         GMr2qOSAEC7EgYmENdNVSGuCVRrDKoUMtU4YxKJmkuX2HUrOOI8KtXKPaGs2dssWatH3
         nxWLtnq3VCPO74zgMoC5ucTDT7N2XbdGgUHGU3fCodmelzjEMQ5t+Sjfch8bIh+jBeu2
         EFlUj7xLTRiNLDsQJzdkHmb8blTU7cfzh2r5F2Iw7uGVXs+doQEaM9Kiks6ILEb8DU7v
         PFyPkTt3/bI9bg2aDTXeN99RBnlCxHe8cJ9nhabDSpmAxERf4JXlvB+9H5v+QgxitnJU
         rR/g==
X-Gm-Message-State: AOJu0YwsFGli2zShG8732PQCDxLQkf98rcoMDynhvRW7+aHP/sf6X4+d
        +Qq2QuX46wBs06gSVdCyoymi6w==
X-Google-Smtp-Source: AGHT+IFzCUeJ4+/f6cMQn/wpsFZyt5uO+MfysuCHFTtVfIOOSW4N6mcQ3ugSwBAMbKLYPMLI3Tso2g==
X-Received: by 2002:a05:6e02:1d0c:b0:351:50f1:1f98 with SMTP id i12-20020a056e021d0c00b0035150f11f98mr3806231ila.32.1695757367326;
        Tue, 26 Sep 2023 12:42:47 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:1da0:a3ce:7aae:e9fa])
        by smtp.gmail.com with ESMTPSA id g6-20020a056e02130600b0035134f1a240sm1961451ilr.86.2023.09.26.12.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 12:42:47 -0700 (PDT)
From:   Simon Glass <sjg@chromium.org>
To:     devicetree@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
        Lean Sheng Tan <sheng.tan@9elements.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Dhaval Sharma <dhaval@rivosinc.com>,
        Maximilian Brune <maximilian.brune@9elements.com>,
        Yunhui Cui <cuiyunhui@bytedance.com>,
        Guo Dong <guo.dong@intel.com>, Tom Rini <trini@konsulko.com>,
        ron minnich <rminnich@gmail.com>, Gua Guo <gua.guo@intel.com>,
        Chiu Chasel <chasel.chiu@intel.com>,
        linux-acpi@vger.kernel.org,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Simon Glass <sjg@chromium.org>
Subject: [PATCH v7 1/2] schemas: memory: Add ECC properties
Date:   Tue, 26 Sep 2023 13:42:38 -0600
Message-ID: <20230926194242.2732127-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some memories provide ECC detection and/or correction. For software which
wants to check memory, it is helpful to see which regions provide this
feature.

Add this as a property of the /memory nodes, since it presumably follows
the hardware-level memory system.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v7:
- Drop unnecessary |
- Add a blank line between properties

Changes in v6:
- Use a number of bits instead of a string property
- Fix inidcates typo

Changes in v5:
- Redo to make this property specific to ECC
- Provide properties both for detection and correction

Changes in v3:
- Add new patch to update the /memory nodes

 dtschema/schemas/memory.yaml | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/dtschema/schemas/memory.yaml b/dtschema/schemas/memory.yaml
index 1d74410..b3bf3c9 100644
--- a/dtschema/schemas/memory.yaml
+++ b/dtschema/schemas/memory.yaml
@@ -35,6 +35,19 @@ patternProperties:
           For the purpose of identification, each NUMA node is associated with
           a unique token known as a node id.
 
+      ecc-detection-bits:
+        default: 0
+        description: |
+          If present, this indicates the number of bits of memory error which
+          can be detected and reported by the Error-Correction Code (ECC) memory
+          subsystem (typically 0, 1 or 2).
+
+      ecc-correction-bits:
+        default: 0
+        description: |
+          If present, this indicates the number of bits of memory error which
+          can be corrected by the Error-Correction Code (ECC) memory subsystem
+          (typically 0, 1 or 2).
 
     required:
       - device_type
-- 
2.42.0.515.g380fc7ccd1-goog

