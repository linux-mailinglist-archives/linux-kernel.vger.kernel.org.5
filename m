Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2065D7A8C55
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 21:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjITTLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 15:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjITTLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 15:11:40 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D552CF;
        Wed, 20 Sep 2023 12:11:34 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c00c0f11b2so2324251fa.1;
        Wed, 20 Sep 2023 12:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695237092; x=1695841892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=osBqvthiVpODVt2c1wzVUJqaUOTaV5YdFAQXjwCgrOg=;
        b=efQrtZSoYUf07dKmlWmf2IMo8cT/d1saWXatQZm9jL92dqHnpvALOPPDlztcd5Ey9j
         oyCgexEa6gcvnbOKUQ1Ee24hbAjCvEWRnZpEdAENydbu650D+6p/WtYENJgujyh98Jln
         HWrL3ydwQ5IGS29UQvB55KqtGRVthpKg8wKGHDUYUIk0zc8e6MyLSAiK5m15qCeA00p0
         RzwuPrRqi4zJebMO+jMKB2FnRK8X8wLZfgFgpx5p9tA7JC5nXDQpKB4q23muOkqseOuA
         iaTKohFyMmBi3zKv4wZft0DWOgTTGVb2VeRM2FS7fjuo20I0KCMQR/NCfX5hmKATQymX
         bjgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695237092; x=1695841892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=osBqvthiVpODVt2c1wzVUJqaUOTaV5YdFAQXjwCgrOg=;
        b=FwRJNliKwE+YpVsDMz6SqZd7ITh8HSEBFdqQVUWIWney1GQPawms+/dUpHnsz2XqIm
         0P8meRtPb4nhN9/63U3TaQ8qrdTdbkY3jWjw8Xnunfx0VxcGkGyNsO562L8N/X4UmbZ3
         ScAGDWexaKNkBy7Fp3bhx/5c9QxdcTOr4mm5QWrJRYvrXRzyONEL8mjcPLIcpqVb0Bqc
         rm6I9QKLGm/hkCrgnI/fY4P2fS1/he4VpvYG5t8rHcvjjgrCVPW1wXH2d7LglnRmrQhm
         EGq6bgttNui6oAA1T6DlVH4KXSIHxWjFrWlMeyfDhxDnaMkk0SZqhakSVzvqcMoP0g5H
         16/w==
X-Gm-Message-State: AOJu0Yz6+IWrxTQNdr/NDDb9V2hB9FttY+15WaOL/y5dHYhZFLk6j/SD
        Kp+eY7fgHwYCg6OGEPdzBro=
X-Google-Smtp-Source: AGHT+IGnTKjiNhn/9kC3KwPltttCQCu2dvvWsIdie+bvalpNb96ncreNZ221kglbiXEEJnidC8kSNA==
X-Received: by 2002:a2e:9a97:0:b0:2be:54b4:ff84 with SMTP id p23-20020a2e9a97000000b002be54b4ff84mr2917371lji.51.1695237092303;
        Wed, 20 Sep 2023 12:11:32 -0700 (PDT)
Received: from localhost ([85.26.234.43])
        by smtp.gmail.com with ESMTPSA id d10-20020a2e890a000000b002c023d3dadesm1061455lji.113.2023.09.20.12.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 12:11:31 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Michal Simek <michal.simek@amd.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Punnaiah Choudary Kalluri 
        <punnaiah.choudary.kalluri@xilinx.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
        Borislav Petkov <bp@suse.de>
Subject: [PATCH v4 05/20] EDAC/synopsys: Fix reading errors count before ECC status
Date:   Wed, 20 Sep 2023 22:10:29 +0300
Message-ID: <20230920191059.28395-6-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920191059.28395-1-fancer.lancer@gmail.com>
References: <20230920191059.28395-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aside with fixing the errors count CSR usage the commit e2932d1f6f05
("EDAC/synopsys: Read the error count from the correct register") all of
the sudden has also changed the order of the errors status check
procedure. So now the errors handler method first reads the number of CE
and UE and only then makes sure that any of these errors have actually
happened. It doesn't make sense. Fix that by getting back the correct
procedures order: first check the ECC status, then read the number of
errors.

Fixes: e2932d1f6f05 ("EDAC/synopsys: Read the error count from the correct register")
Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
Reviewed-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
---
 drivers/edac/synopsys_edac.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 308da6f82d3d..fff4b07ff6ac 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -419,18 +419,18 @@ static int zynqmp_get_error_info(struct synps_edac_priv *priv)
 	base = priv->baseaddr;
 	p = &priv->stat;
 
-	regval = readl(base + ECC_ERRCNT_OFST);
-	p->ce_cnt = regval & ECC_ERRCNT_CECNT_MASK;
-	p->ue_cnt = (regval & ECC_ERRCNT_UECNT_MASK) >> ECC_ERRCNT_UECNT_SHIFT;
-	if (!p->ce_cnt)
-		goto ue_err;
-
 	regval = readl(base + ECC_STAT_OFST);
 	if (!regval)
 		return 1;
 
 	p->ceinfo.bitpos = (regval & ECC_STAT_BITNUM_MASK);
 
+	regval = readl(base + ECC_ERRCNT_OFST);
+	p->ce_cnt = regval & ECC_ERRCNT_CECNT_MASK;
+	p->ue_cnt = (regval & ECC_ERRCNT_UECNT_MASK) >> ECC_ERRCNT_UECNT_SHIFT;
+	if (!p->ce_cnt)
+		goto ue_err;
+
 	regval = readl(base + ECC_CEADDR0_OFST);
 	p->ceinfo.row = (regval & ECC_CEADDR0_RW_MASK);
 	regval = readl(base + ECC_CEADDR1_OFST);
-- 
2.41.0

