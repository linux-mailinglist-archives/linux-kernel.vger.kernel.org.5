Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A157A8C59
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 21:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjITTMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 15:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjITTLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 15:11:53 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3F119A;
        Wed, 20 Sep 2023 12:11:41 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-5041d6d8b10so364087e87.2;
        Wed, 20 Sep 2023 12:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695237099; x=1695841899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KgRtaGDbHaMGWmEwhQaYHn3tA5PgGGeG5k0hEehgseI=;
        b=WF3NTZMWY/IOzP9U5n0o3/fNcL4UX/C5aqw5Yv7PJ99S7/gpDmC+PHCvbkEEBHAFhq
         q1VD+yAk8RmPnYYIaf2HFHOnslPzkqrFdiz+yDl0bhY+5LaGx9H2l1vMyaPQFuivWMZC
         FfjWd6fDa0f+5/5FK5RbZSC8C6QZiAiCYshfa+6HlpQoNGu237VZkV2wEEv47lpdoden
         TsMAD7lCbZbBBv0U6dRFqpr8XlsX0kkBg8B+xy6vipICbv8oKu6zlTRP4aAUu9tOvRRM
         /6kLL+PfqDjKIB6XktD3BhOrQBC7DHmyFuv4O0jlgg2DnaWfmD6EAveui1a/N3xf8b9E
         orrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695237099; x=1695841899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KgRtaGDbHaMGWmEwhQaYHn3tA5PgGGeG5k0hEehgseI=;
        b=w+AfPYtErp39jynDX2Q0URA+sj0YZ88xvZi7hjgQaw0symaRpvHsm+QdM3dS4Q21Pv
         KkAszjFReLHsbl57p1ymaspo6KWwzNdcCbauvKev8KRrOegJmp5S97nHz4ElY3nbskSB
         +sCBdo6D4m73wONrr3h3EYxF4pnEHAMrCHyaP0mDsk8Smv5z42JGbG5JhApQFdAjsqdZ
         LiF3x1C345u3X/Z9vX3iZEXHooYOcM00it59ttWAddNo0pyB8Jyx4wJU4LvZATHiU0Mz
         kIjFz+ojStyTBxENH3TpVCo1HuyfZJeD7LoxYq7SH/15lx6wnwcaN2tLqDbLSH8aH301
         G4dw==
X-Gm-Message-State: AOJu0Yx2eyNumqKttsZ5tPouUIAGbhZYCwWtRsDLvozgid0iTh8cSt/V
        JcMGM4SvFsBZY1D1hpwGM0M=
X-Google-Smtp-Source: AGHT+IGya33WFhxdC4EYABqaLXroOtVCi7s5LjlnqRdO5Il1/r9BwISYxMeCX7Y4TK9B9L7NOKN2rw==
X-Received: by 2002:a05:6512:a8b:b0:502:ff3b:7670 with SMTP id m11-20020a0565120a8b00b00502ff3b7670mr4078855lfu.4.1695237099249;
        Wed, 20 Sep 2023 12:11:39 -0700 (PDT)
Received: from localhost ([178.176.81.142])
        by smtp.gmail.com with ESMTPSA id eq14-20020a056512488e00b004fe2a7a2ee2sm2794990lfb.160.2023.09.20.12.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 12:11:38 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Michal Simek <michal.simek@amd.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Punnaiah Choudary Kalluri 
        <punnaiah.choudary.kalluri@xilinx.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 07/20] EDAC/synopsys: Use platform device devm ioremap method
Date:   Wed, 20 Sep 2023 22:10:31 +0300
Message-ID: <20230920191059.28395-8-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920191059.28395-1-fancer.lancer@gmail.com>
References: <20230920191059.28395-1-fancer.lancer@gmail.com>
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

DW DDRs CSRs resource descriptor is used by the devm_ioremap_resource()
function invocation only in the driver probe method. Thus convert the
platform_get_resource() and devm_ioremap_resource() couple to just a
single devm_platform_ioremap_resource() method call.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/edac/synopsys_edac.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 6b81ac9dda8b..afe9f475cb4e 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -1335,11 +1335,9 @@ static int mc_probe(struct platform_device *pdev)
 	struct synps_edac_priv *priv;
 	struct mem_ctl_info *mci;
 	void __iomem *baseaddr;
-	struct resource *res;
 	int rc;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	baseaddr = devm_ioremap_resource(&pdev->dev, res);
+	baseaddr = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(baseaddr))
 		return PTR_ERR(baseaddr);
 
-- 
2.41.0

