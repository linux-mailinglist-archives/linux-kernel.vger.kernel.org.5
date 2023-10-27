Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 292717DA276
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 23:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346557AbjJ0V30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 17:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232848AbjJ0V3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 17:29:24 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78BE71AA
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 14:29:21 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-7a66a7fc2d4so81974639f.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 14:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698442160; x=1699046960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C3v2FO97IXXXiaSzXTYxRflnbKiHcASyLC55jbu8gdA=;
        b=c3ATuOYWyCDACC3DEW0JvY5bnwPi9AoyjtREvkAyEAooLuhtuYtf5+EkMSaeupyTXX
         jCy5+XgCxY/MtSKU9Omd1ApwJfk03iXJm73ORAbpmNXN6Pgh2ZvVSuetSSsOdmFJIR3Y
         nP1TUwEcTI/PK1kyf3pNEBFRN/I2qgl0lFVzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698442160; x=1699046960;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C3v2FO97IXXXiaSzXTYxRflnbKiHcASyLC55jbu8gdA=;
        b=ks+Nkpmfl82u7fwJoMCrhWO0Wy+iYI8ro1Ob0BtJof5NjiInDUv2sVUKowUXY7WM2V
         HErpVnkGbjTy/RXiSBpv6+mhhHSbYGvPVGB17Zb/JhdD60lmQaczj2zN/BFjKn/9Lenu
         dfTBdajd8pCGr0gFJG5N8ys1TR/P0KxMjjtSU1sAJYr1ivrSuqOKc2vBOnmRbCOr3g/N
         kcffz35T/z/jgLFwQ9EEw1aUyQ3gfE/dVQpWEeLbEEW9znuavsc0B8DvAoayjDZH2rIr
         WKTvr2+s2OP8VxchSLschZF5fa2Xsd2FiHjiXfnY8d31uzXKbzEiav2QsAYBpxB8FRvL
         2+Yg==
X-Gm-Message-State: AOJu0YyzULV1XhWHEQE54zlacjpX758QI/1ImjtX90GCTaFoYvz7yq2z
        xATdz1kyrR2aHKtmmqftObcvMYtTKqsGrcyuJtU=
X-Google-Smtp-Source: AGHT+IHcj7gMdPmDoIIG4hoUQKjRHYFsRkugyVOR7xqwWrc6wGLKW+T/Mq8vVzxhsbJRNZooQL3sig==
X-Received: by 2002:a05:6602:1495:b0:79f:d671:c732 with SMTP id a21-20020a056602149500b0079fd671c732mr5229077iow.10.1698442160591;
        Fri, 27 Oct 2023 14:29:20 -0700 (PDT)
Received: from markhas1.lan (71-218-45-6.hlrn.qwest.net. [71.218.45.6])
        by smtp.gmail.com with ESMTPSA id q26-20020a6bf21a000000b0079f9efd067asm677101ioh.1.2023.10.27.14.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 14:29:19 -0700 (PDT)
From:   Mark Hasemeyer <markhas@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        stable@vger.kernel.org, Mark Hasemeyer <markhas@chromium.org>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Sanket Goswami <Sanket.Goswami@amd.com>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v1] platform/x86/amd/pmc: Get smu version before reading dram size
Date:   Fri, 27 Oct 2023 15:28:05 -0600
Message-ID: <20231027212916.1035991-1-markhas@chromium.org>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calls to amd_pmc_get_dram_size can fail because the function assumes smu
version information has already been read when it hasn't. The smu
version is lazily read as opposed to being read at probe because it is
slow and increases boot time.

Read the smu version information if it has not been read yet.

Link: https://lore.kernel.org/all/a3ee6577-d521-6d18-0a15-2f97d6f8ac3a@amd.com/
Fixes: be8325fb3d8c ("platform/x86/amd: pmc: Get STB DRAM size from PMFW")
Cc: stable@vger.kernel.org # 6.5.x

Signed-off-by: Mark Hasemeyer <markhas@chromium.org>
---

 drivers/platform/x86/amd/pmc/pmc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/platform/x86/amd/pmc/pmc.c b/drivers/platform/x86/amd/pmc/pmc.c
index cd6ac04c1468..f668eddbc5d5 100644
--- a/drivers/platform/x86/amd/pmc/pmc.c
+++ b/drivers/platform/x86/amd/pmc/pmc.c
@@ -970,6 +970,11 @@ static int amd_pmc_get_dram_size(struct amd_pmc_dev *dev)
 
 	switch (dev->cpu_id) {
 	case AMD_CPU_ID_YC:
+		if (!dev->major) {
+			ret = amd_pmc_get_smu_version(dev);
+			if (ret)
+				goto err_dram_size;
+		}
 		if (!(dev->major > 90 || (dev->major == 90 && dev->minor > 39))) {
 			ret = -EINVAL;
 			goto err_dram_size;
-- 
2.42.0.820.g83a721a137-goog

