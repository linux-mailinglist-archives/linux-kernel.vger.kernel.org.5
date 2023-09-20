Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6544B7A8C5C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 21:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjITTMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 15:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjITTMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 15:12:01 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C122D8;
        Wed, 20 Sep 2023 12:11:45 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-5029ace4a28so1529027e87.1;
        Wed, 20 Sep 2023 12:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695237102; x=1695841902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EgoOFuIOH/yTjnEmwXNjUQs0ssos4vCiXDfBrtR+jUo=;
        b=mTsCNcIh/MPNhhU5zCFSsm/KkP0xxycGUxb372kAsK92ocQvjZkCejwQVer4JTTJ3t
         aAbJOD+z2yJtl0ASBCKzHeghRY/APc/3D3Y2C8XGsVzmRMzjthgdJUv+1o2aOBJFUD+I
         pWFmr+7c/2uXejg/ktOJFoRJX+YKropUFDK7pJd5XdLXadHamsrhKsL5zWVzwSUDWORp
         Ak4NIhhtKa1qYo7VN6NWoy2HZ77cxy2p6wB4x67pVsYWQBUFt0FrSXZhYXHXbsaGCyMb
         owcJCVPoPPwAFZeSTQv2pb460x3DEym1Rfeea4/Ou+vEpp35k8ykaZnoDBgxnhChyQfy
         NNyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695237102; x=1695841902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EgoOFuIOH/yTjnEmwXNjUQs0ssos4vCiXDfBrtR+jUo=;
        b=VD7ycx/jOS8gpBNao4PbMRWqr7HlzHwSjQajR3eznsU+QNdhB/AZzJyquywHHS75pN
         oPhHEUiXWBom195EaTQu5az46WB1v9q4K4qYVgv5iq5QOYulolShTK5ZTe1J1wxn4Php
         UcX2Fc6Y8mNZZ9OzMqNBJR9rbEuLARMrInv8ajo1Gwxwu1TVpXAs35PBDWO2ejI2c+ez
         iB+SKU7r0ok1XmOC62LfU5HJPi7pFaxnw8t+foZHA9VFYB3v6SolnuyAJZTOyJyFCRfS
         GkMcjTAY1wHyLiDE5i0K0XEqayNmTKgXuTICGBnPlPJVA3h6XbNMJtED1QNXQ5KVByra
         ikkw==
X-Gm-Message-State: AOJu0YzFvzKah+Wgt5VbuU/hG1WcW89QyB4nocyxJj/Oc1ZBPLdrjUKl
        ogPgBp0yxHKVxP4BYW1M8CE=
X-Google-Smtp-Source: AGHT+IFMiafOQ/yXgxqpUJDVLbYEs4mqVu/8ZemDTcrkOcKti8HCwKXib/arZc0C8dMF9giPBdSSYA==
X-Received: by 2002:a05:6512:10d0:b0:500:c00e:8f15 with SMTP id k16-20020a05651210d000b00500c00e8f15mr2512617lfg.16.1695237102034;
        Wed, 20 Sep 2023 12:11:42 -0700 (PDT)
Received: from localhost ([85.26.234.178])
        by smtp.gmail.com with ESMTPSA id b28-20020a056512025c00b00503258fa962sm1049905lfo.199.2023.09.20.12.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 12:11:41 -0700 (PDT)
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
Subject: [PATCH v4 08/20] EDAC/synopsys: Drop internal CE and UE counters
Date:   Wed, 20 Sep 2023 22:10:32 +0300
Message-ID: <20230920191059.28395-9-fancer.lancer@gmail.com>
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

First of all these counters aren't exposed anyhow from the driver.
Secondly the EDAC core already tracks the total amount of the correctable
and uncorrectable errors (see mem_ctl_info.{ce_mc,ue_mc} fields usage).
Drop the useless internal counters then for good.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---

Changelog v4:
- Drop redundant empty line.
- Drop private counters access from the check_errors() method too.
---
 drivers/edac/synopsys_edac.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index afe9f475cb4e..c2ac2eb64642 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -305,8 +305,6 @@ struct synps_ecc_status {
  * @message:		Buffer for framing the event specific info.
  * @stat:		ECC status information.
  * @p_data:		Platform data.
- * @ce_cnt:		Correctable Error count.
- * @ue_cnt:		Uncorrectable Error count.
  * @poison_addr:	Data poison address.
  * @row_shift:		Bit shifts for row bit.
  * @col_shift:		Bit shifts for column bit.
@@ -320,8 +318,6 @@ struct synps_edac_priv {
 	char message[SYNPS_EDAC_MSG_SIZE];
 	struct synps_ecc_status stat;
 	const struct synps_platform_data *p_data;
-	u32 ce_cnt;
-	u32 ue_cnt;
 #ifdef CONFIG_EDAC_DEBUG
 	ulong poison_addr;
 	u32 row_shift[18];
@@ -593,13 +589,8 @@ static irqreturn_t intr_handler(int irq, void *dev_id)
 	if (status)
 		return IRQ_NONE;
 
-	priv->ce_cnt += priv->stat.ce_cnt;
-	priv->ue_cnt += priv->stat.ue_cnt;
 	handle_error(mci, &priv->stat);
 
-	edac_dbg(3, "Total error count CE %d UE %d\n",
-		 priv->ce_cnt, priv->ue_cnt);
-
 	if (priv->p_data->quirks & SYNPS_ZYNQMP_IRQ_REGS)
 		writel(regval, priv->baseaddr + DDR_QOS_IRQ_STAT_OFST);
 
@@ -625,12 +616,7 @@ static void check_errors(struct mem_ctl_info *mci)
 	if (status)
 		return;
 
-	priv->ce_cnt += priv->stat.ce_cnt;
-	priv->ue_cnt += priv->stat.ue_cnt;
 	handle_error(mci, &priv->stat);
-
-	edac_dbg(3, "Total error count CE %d UE %d\n",
-		 priv->ce_cnt, priv->ue_cnt);
 }
 
 /**
-- 
2.41.0

