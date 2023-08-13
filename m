Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 767A977A611
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 13:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjHMLBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 07:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjHMLB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 07:01:28 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50608170D;
        Sun, 13 Aug 2023 04:01:29 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-686f19b6dd2so2321055b3a.2;
        Sun, 13 Aug 2023 04:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691924489; x=1692529289;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dIx3E8QDpnEzVTbkCLWDZWHa0zlmtqhLo20j+vuNiJQ=;
        b=Mx8py+HisInkEu9PfRzoQPep/XRUv3Dr/F+4qHdbjKCaMYQSirKh8yRNZ2jTEJjMBC
         clnpY7oBdlB/Z4uf7kApAgBuTKn9W6b+n8Uz4cnY8qvKQQh5TnVSpI5/kQb2WsKDpHj7
         772PL4jmMfBKI+To2PES2+oTy6K52lF6HAXCiHcmDrX0oPxisEKuf1vpf5tE132tkRWy
         kb/jmzneTntyTpcWpGAy2fl/S12w0bM6YhdEHC67opRl4vRMyGlls8DZT2xuGILgSt3w
         4Ztoc2WFmgPtIgDYyZUsgxepXNq02WCXsCWUTox8riDojjpCIM5B8eW9JoM9aHF1pRK3
         jY5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691924489; x=1692529289;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dIx3E8QDpnEzVTbkCLWDZWHa0zlmtqhLo20j+vuNiJQ=;
        b=CG+f+ye0vqT6oU3SWcgZuX7hedhz4NcZeCAkZ/l+L5iBZC53qkkugMt6sAVq5Kh0IJ
         qHwmaOYJtfMmX5Ksn7tLwLgxIr47E6hbCye2aKYbfoFSv/65X1pEY7aKTNAZZjeqGCmj
         L747vzCn0oNr7JqWIY0HkXouNuchvJPr8weTYWYxp4i/qgXryM+Le4bva9Tuq8tuS+st
         ylKjLTyJ85Ed7kX/oiN3FZ8CgYn75FZ7twYbBvozfEfD0V/ihLef1f+7QRB+VzzrmswI
         u0N/+TZx5UYI+iWnZDy7U32svMb0irDI9p3H6zLSSPk4LhuVonD9eQgyY1R9YJSK7uB6
         ePLw==
X-Gm-Message-State: AOJu0YwzG8+bsPT0HP4I82wO56fQuZidAAKewjYg+81dQ46BQhN4v4U7
        PAUIEHP+frjDMzo1JOoym+w=
X-Google-Smtp-Source: AGHT+IGJTQuQonYB6BKUw4PWJ3jAaaanpnTdgGLbZC1g7Y//dgViTo9wIIKcRsJAbvIzTZja+okZ7g==
X-Received: by 2002:a17:902:f545:b0:1b9:e972:134d with SMTP id h5-20020a170902f54500b001b9e972134dmr5764797plf.3.1691924488635;
        Sun, 13 Aug 2023 04:01:28 -0700 (PDT)
Received: from localhost.localdomain ([2409:40c2:100c:8e93:d00a:1992:423:e24e])
        by smtp.gmail.com with ESMTPSA id k8-20020a17090a404800b00268b439a0cbsm6103075pjg.23.2023.08.13.04.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 04:01:28 -0700 (PDT)
From:   coolrrsh@gmail.com
To:     Shyam-sundar.S-k@amd.com, hdegoede@redhat.com,
        markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Rajeshwar R Shinde <coolrrsh@gmail.com>
Subject: [PATCH] platform: sps: Fix an unsigned comparison that can
Date:   Sun, 13 Aug 2023 16:31:22 +0530
Message-Id: <20230813110122.129793-1-coolrrsh@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajeshwar R Shinde <coolrrsh@gmail.com>

The variable 'mode' is declared as unsigned int in local function.
The return value of function amd_pmf_get_pprof_modes(dev) is int and
it is stored in the 'mode' variable. Also the value of 'mode' variable
is compared with 0 which is signed int by default. Thus redeclaring the
variable to signed int.

This fixes warning such as:
drivers/platform/x86/amd/pmf/sps.c:128:5-9:
WARNING: Unsigned expression compared with zero: mode < 0

Signed-off-by: Rajeshwar R Shinde <coolrrsh@gmail.com>
---
 drivers/platform/x86/amd/pmf/sps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/amd/pmf/sps.c b/drivers/platform/x86/amd/pmf/sps.c
index ab69d517a36a..703723a66830 100644
--- a/drivers/platform/x86/amd/pmf/sps.c
+++ b/drivers/platform/x86/amd/pmf/sps.c
@@ -176,7 +176,7 @@ int amd_pmf_get_pprof_modes(struct amd_pmf_dev *pmf)
 
 int amd_pmf_power_slider_update_event(struct amd_pmf_dev *dev)
 {
-	u8 mode, flag = 0;
+	int mode, flag = 0;
 	int src;
 
 	mode = amd_pmf_get_pprof_modes(dev);
-- 
2.25.1

