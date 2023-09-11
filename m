Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD31579BA25
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349690AbjIKVeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244224AbjIKTjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 15:39:49 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7634612A
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 12:39:45 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c397ed8681so17377495ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 12:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694461185; x=1695065985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iZS9exdhsXGWlwAB3PPHAHPTpMkYjkQ66zHV37ZNnIo=;
        b=VJFdmIKkhv/Q+m+JOoiFKhTBZ+rrK10LCUqGXdzbKbRxyxO8VMsfe8fPD8KOMRWZcf
         vU251VLuJpCuLwTAwx+e6hWYNi3DA5QOlKgv1LHZqM+kzklQD7DMAFRt5+hB4T2AYork
         SLJZF2nasOAcgpLboG144l4aqhJkoSBMSfExM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694461185; x=1695065985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iZS9exdhsXGWlwAB3PPHAHPTpMkYjkQ66zHV37ZNnIo=;
        b=Ozky3k4H23xe2Zevm91Lg1GKs+HAg49XgQ4iI141/Ebk5zwN+D6cH+EYRncjQlKNxS
         VrhopCpfMtu1qQ0g0mbKgaeKfqwUrk+agSoQ8izucnpBmEeALDM6F3ugCTEV36Ws1Vk/
         ArclOb6CoElWyYZ+QgXlr74hIg5TADu3CBO/pgEtUjZWZJdRFhf1goLrnrfSbln2L0/U
         2yTVp13Lyi4y7c/hseXDTAEnGRc/84h9LU4jGoQIRnnU4S2FQPqs7CKzOVdCnfMkS3hi
         WJX5L7zJMWWQYK3RuI2eKj8PCI7kQ1Oyf0PvTQWe177bxRXQwdId/ZCEXAOPu07xet+M
         g/zg==
X-Gm-Message-State: AOJu0Yz3S8uFB4xSomSk5w+h34fBVQwhLDp9T6dA0gdQPWtOECdmz45F
        GvDbPxN64DHZNAPFXnOzFl7I5f6WKmv9o8jLdPI=
X-Google-Smtp-Source: AGHT+IE7TogpeCC/K5uuUl78NkURxmB6xAcGOF09QSqED+BJ2qE4ZV0Dxs2vBHRHl4QM+fNIhII6jQ==
X-Received: by 2002:a17:90b:164e:b0:268:10a3:cea8 with SMTP id il14-20020a17090b164e00b0026810a3cea8mr8146677pjb.9.1694461184937;
        Mon, 11 Sep 2023 12:39:44 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:11a:201:d487:5e33:6656:3711])
        by smtp.gmail.com with ESMTPSA id fu8-20020a17090ad18800b00262e485156esm7736543pjb.57.2023.09.11.12.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 12:39:44 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        platform-driver-x86@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Prashant Malani <pmalani@chromium.org>
Subject: [PATCH v3 3/4] platform/x86: intel_scu_ipc: Don't override scu in intel_scu_ipc_dev_simple_command()
Date:   Mon, 11 Sep 2023 12:39:35 -0700
Message-ID: <20230911193937.302552-4-swboyd@chromium.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230911193937.302552-1-swboyd@chromium.org>
References: <20230911193937.302552-1-swboyd@chromium.org>
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

Andy discovered this bug during patch review. The 'scu' argument to this
function shouldn't be overridden by the function itself. It doesn't make
any sense. Looking at the commit history, we see that commit
f57fa18583f5 ("platform/x86: intel_scu_ipc: Introduce new SCU IPC API")
removed the setting of the scu to ipcdev in other functions, but not
this one. That was an oversight. Remove this line so that we stop
overriding the scu instance that is used by this function.

Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Closes: https://lore.kernel.org/r/ZPjdZ3xNmBEBvNiS@smile.fi.intel.com
Cc: Prashant Malani <pmalani@chromium.org>
Fixes: f57fa18583f5 ("platform/x86: intel_scu_ipc: Introduce new SCU IPC API")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/platform/x86/intel_scu_ipc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/intel_scu_ipc.c
index 8be1686e22e9..6958265db29d 100644
--- a/drivers/platform/x86/intel_scu_ipc.c
+++ b/drivers/platform/x86/intel_scu_ipc.c
@@ -443,7 +443,6 @@ int intel_scu_ipc_dev_simple_command(struct intel_scu_ipc_dev *scu, int cmd,
 		mutex_unlock(&ipclock);
 		return -ENODEV;
 	}
-	scu = ipcdev;
 	cmdval = sub << 12 | cmd;
 	ipc_command(scu, cmdval);
 	err = intel_scu_ipc_check_status(scu);
-- 
https://chromeos.dev

