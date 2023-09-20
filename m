Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5AA17A8C51
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 21:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjITTLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 15:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjITTLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 15:11:36 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D71AF;
        Wed, 20 Sep 2023 12:11:28 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-5008d16cc36so344389e87.2;
        Wed, 20 Sep 2023 12:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695237086; x=1695841886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZnR6l+vYOh9Csf9eBwgQHTo/sUEkvBg0hJ7+UGZ8t70=;
        b=TNMK6pnIc7HTFAHxZdDx7uu8/pjaDh5/eyj2ZtwGNcgUG2POe95l8rHCUAnuhHF+W4
         /AJxFzyVeRMhvwsaiGqa85ZnDKCSOgpxD52J0o6AxQ9uaQMp1/OsSppt61OESagcw1F1
         Rs+d8ehnwNiDGmX36wYbxXyo3RfVxQcFcKJh8CcTRtsk/GXZ13WMosEyggFKJRYvM8r+
         eZgLYMQ9q2XRkM8fvJ/VZEMkJjwYW0V3OSMBTKu4BBklaFqI+PcOfqef9w0zVktxeQlx
         6a0H+qPbwy5x6sKSlUywkosXlB0kZO8/fjc7FVPXFT8l/usaG/Bc7m5angbDQUehCsQC
         RBXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695237086; x=1695841886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZnR6l+vYOh9Csf9eBwgQHTo/sUEkvBg0hJ7+UGZ8t70=;
        b=IODceeovfqcVS6+TYvxZqUolxRrjKkI+Nqu6hAx9vr6gYMgUuZG8g7rUujjFQw6Jv9
         946fReL6p8eGa5yJYdsSkHrMf6dF1Ae8jYFcCmSyTPBpG/k0G56vjfIVIWsMHygct36U
         aV3P1OktdVRY8APl7vuKklhClZwR8WzFGoTtU5u0Lr+tyjGw+dUbF+5+O1jxDKwcsxfb
         d+DU4WXuAaPSJHdfjaSVJL9W+/xNbUMH8WUQOxWbBMz1hNGkL8+TwWukfKjsdmFiCs3W
         l0+hs+F9NuIYrzT0z5GbF9SGgfz7H0sfeuMCBgFC+iLJPAlGGZDMu0qb72vTtlymdsh/
         /1yg==
X-Gm-Message-State: AOJu0YzdSHDPWgK7WHWWPMAudf9aKavWr4PQTtFbtM7o+u4VX/XWGQcw
        JvGvFOIVHWzuLTJgxcQKBoU=
X-Google-Smtp-Source: AGHT+IExfWuCoa4RzHs2lEM9AIkEJYLw9ooHlfGZM2+IIUrULkxRvC9LOMmRYav56Pnn28/FK1GUFA==
X-Received: by 2002:ac2:5dd3:0:b0:500:78ee:4cd7 with SMTP id x19-20020ac25dd3000000b0050078ee4cd7mr3193711lfq.23.1695237086256;
        Wed, 20 Sep 2023 12:11:26 -0700 (PDT)
Received: from localhost ([85.140.6.11])
        by smtp.gmail.com with ESMTPSA id f9-20020ac251a9000000b00501c1794883sm2812429lfk.251.2023.09.20.12.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 12:11:25 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Michal Simek <michal.simek@amd.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Punnaiah Choudary Kalluri 
        <punnaiah.choudary.kalluri@xilinx.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>
Subject: [PATCH v4 03/20] EDAC/synopsys: Fix mci->scrub_cap field setting
Date:   Wed, 20 Sep 2023 22:10:27 +0300
Message-ID: <20230920191059.28395-4-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920191059.28395-1-fancer.lancer@gmail.com>
References: <20230920191059.28395-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mem_ctl_info.scrub_cap field is supposed to be set with the ECC
scrub-related flags. Instead the driver erroneously initializes it with
the SCRUB_HW_SRC flag ID. It's definitely wrong, though it hasn't caused
any problem so far since the structure field isn't used by the EDAC core.
Fix it anyway by using the SCRUB_FLAG_HW_SRC macro to initialize the
field.

Fixes: ae9b56e3996d ("EDAC, synps: Add EDAC support for zynq ddr ecc controller")
Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/edac/synopsys_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index b463bd802961..65790097beb2 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -856,7 +856,7 @@ static void mc_init(struct mem_ctl_info *mci, struct platform_device *pdev)
 	/* Initialize controller capabilities and configuration */
 	mci->mtype_cap = MEM_FLAG_DDR3 | MEM_FLAG_DDR2;
 	mci->edac_ctl_cap = EDAC_FLAG_NONE | EDAC_FLAG_SECDED;
-	mci->scrub_cap = SCRUB_HW_SRC;
+	mci->scrub_cap = SCRUB_FLAG_HW_SRC;
 	mci->scrub_mode = SCRUB_NONE;
 
 	mci->edac_cap = EDAC_FLAG_SECDED;
-- 
2.41.0

