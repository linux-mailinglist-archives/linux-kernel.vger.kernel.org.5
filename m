Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 932577A8CF7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 21:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjITTga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 15:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjITT3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 15:29:33 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924F1CD9;
        Wed, 20 Sep 2023 12:29:13 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50317080342so408894e87.2;
        Wed, 20 Sep 2023 12:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695238151; x=1695842951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ruI/DsrXUPHPt+yo4IDD0wOJzQ+cTuT8XaOYtD4sKFA=;
        b=XeAT/oXQ8jOHcpye/2I707yLdkIKkUrLGctawH4fa4AWrg2al0EoIkp6ONqyZL/SKi
         VBuJpc2D2q+36v7LBWbBAdwfVFwV47n7zssJjKZfSSBFz1ZS3a8toboU2zaYPg8VYFGF
         kOdso5k+RbLGtGIYcnKpQpRHqARltWzugjBf/jYwf/LR/BNiR8rn0QyGw4ftO1dIhaIr
         TnvRJar7wcHbpEhXNhgpnzKwGgLV+ikQ6pRq5HaWS5JY5XFLrYis3C3/TNUMpOQuGt0c
         +/rYfrhKweET9CnYGiwthl2Tn/IdHOgelQCDiT7yCUPmfu2awPP+Y+yameWH3U3715UF
         2wiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695238151; x=1695842951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ruI/DsrXUPHPt+yo4IDD0wOJzQ+cTuT8XaOYtD4sKFA=;
        b=vs5en5tmw9MeZTYcSCj+pzTVi85lcE96SMV4OIEGG1fUkQRCAgZ+C5aLcsn2N8A0Qj
         GBlmHsFEg/x7hsvf2NtvVgNCsL1xg+c2cr9Rjnn9HF40b4TrBKOJVv9QxbjhOr1CrO3b
         +Hm86wgcoNh7EmsLLvK/aLzjQ42Tj26+B1qsEEO2N1UX7TUSyMfWikvbC2piZPFqFUGy
         k5q3ZnPYQXuV/b08tqlfkN2cGslKI6pejwhRylSSRqkhMOTf/5P3PJd3FCU2E8Xqm0t+
         Fm1ffgcQiGeYSou347GVgroFa6lm3L+e/2Klse4HfdJGtxbU0mxVBs+5ReqbzHltsfgy
         yr3A==
X-Gm-Message-State: AOJu0YwGdoAq4wgKY5xZ4s+VikvYuS8gK2Ziy74rrDs9g7ke8Womh83T
        XFYhAxJmTvyuIuNS+ABzz7g=
X-Google-Smtp-Source: AGHT+IGNZjm+wfCwzWQAszOVACunejknYU5hlY3VaoId/Y1DBikEzHrl+fcXMYzw4TlI07AA56CvxQ==
X-Received: by 2002:a05:6512:3f1:b0:500:91ac:c0b5 with SMTP id n17-20020a05651203f100b0050091acc0b5mr2883240lfq.30.1695238151186;
        Wed, 20 Sep 2023 12:29:11 -0700 (PDT)
Received: from localhost ([178.176.86.251])
        by smtp.gmail.com with ESMTPSA id z23-20020ac25df7000000b004fdde1db756sm2808772lfq.26.2023.09.20.12.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 12:29:10 -0700 (PDT)
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
Subject: [PATCH v4 15/18] EDAC/synopsys: Add HIF/SDRAM mapping debugfs node
Date:   Wed, 20 Sep 2023 22:27:00 +0300
Message-ID: <20230920192806.29960-16-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920192806.29960-1-fancer.lancer@gmail.com>
References: <20230920192806.29960-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Since the available address mapping is about to be utilized for the
erroneous SDRAM address decode, before adding such functionality it will
be useful to have a way to get an info regarding the most complicated part
of the address translation - HIF/SDRAM mapping table just in case
something gets wrong in the implemented translation procedures. So add the
DebugFS node which on read returns the HIF/SDRAM mapping table in the
hexdump-like manner: first line contains the HIF address bit position
units, first column contains the HIF address bit position tens, the line
and column intersections have the SDRAM dimension (row/column/bank/etc)
and a bit position used to encode the corresponding HIF address bit.

Note DW uMCTL2 DDRC IP-core doesn't have a parameter to set the HIF
address width. So the maximum value (60 bits) of the UMCTL2_A_ADDRW
synthesize parameter [1] is utilized as the maximum HIF address width.
That parameter defines the controller ports address bus width and in case
if the DQ bus width equals to eight bytes defines the HIF address width
too. So its upper constraints is fully applicable in this case.

[1] DesignWare® Cores Enhanced Universal DDR Memory Controller (uMCTL2)
    Databook, Version 3.91a, October 2020, p.515

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/edac/synopsys_edac.c | 82 ++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index a359018c261c..6b8949c66eef 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -156,6 +156,7 @@
 /* DDRC address mapping parameters */
 #define DDR_ADDRMAP_NREGS		12
 
+#define DDR_MAX_HIF_WIDTH		60
 #define DDR_MAX_ROW_WIDTH		18
 #define DDR_MAX_COL_WIDTH		14
 #define DDR_MAX_BANK_WIDTH		3
@@ -1324,6 +1325,84 @@ static int snps_ddrc_info_show(struct seq_file *s, void *data)
 
 DEFINE_SHOW_ATTRIBUTE(snps_ddrc_info);
 
+static u8 snps_find_sdram_dim(struct snps_edac_priv *priv, u8 hif, char *dim)
+{
+	struct snps_hif_sdram_map *map = &priv->hif_sdram_map;
+	int i;
+
+	for (i = 0; i < DDR_MAX_ROW_WIDTH; i++) {
+		if (map->row[i] == hif) {
+			*dim = 'r';
+			return i;
+		}
+	}
+
+	for (i = 0; i < DDR_MAX_COL_WIDTH; i++) {
+		if (map->col[i] == hif) {
+			*dim = 'c';
+			return i;
+		}
+	}
+
+	for (i = 0; i < DDR_MAX_BANK_WIDTH; i++) {
+		if (map->bank[i] == hif) {
+			*dim = 'b';
+			return i;
+		}
+	}
+
+	for (i = 0; i < DDR_MAX_BANKGRP_WIDTH; i++) {
+		if (map->bankgrp[i] == hif) {
+			*dim = 'g';
+			return i;
+		}
+	}
+
+	for (i = 0; i < DDR_MAX_RANK_WIDTH; i++) {
+		if (map->rank[i] == hif) {
+			*dim = 'a';
+			return i;
+		}
+	}
+
+	return DDR_ADDRMAP_UNUSED;
+}
+
+static int snps_hif_sdram_map_show(struct seq_file *s, void *data)
+{
+	struct mem_ctl_info *mci = s->private;
+	struct snps_edac_priv *priv = mci->pvt_info;
+	char dim, buf[SNPS_DBGFS_BUF_LEN];
+	const int line_len = 10;
+	u8 bit;
+	int i;
+
+	seq_printf(s, "%3s", "");
+	for (i = 0; i < line_len; i++)
+		seq_printf(s, " %02d ", i);
+
+	for (i = 0; i < DDR_MAX_HIF_WIDTH; i++) {
+		if (i % line_len == 0)
+			seq_printf(s, "\n%02d ", i);
+
+		bit = snps_find_sdram_dim(priv, i, &dim);
+
+		if (bit != DDR_ADDRMAP_UNUSED)
+			scnprintf(buf, SNPS_DBGFS_BUF_LEN, "%c%hhu", dim, bit);
+		else
+			scnprintf(buf, SNPS_DBGFS_BUF_LEN, "--");
+
+		seq_printf(s, "%3s ", buf);
+	}
+	seq_putc(s, '\n');
+
+	seq_puts(s, "r - row, c - column, b - bank, g - bank group, a - rank\n");
+
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(snps_hif_sdram_map);
+
 /**
  * snps_data_poison_setup - Update poison registers.
  * @priv:		DDR memory controller private instance data.
@@ -1443,6 +1522,9 @@ static void snps_create_debugfs_nodes(struct mem_ctl_info *mci)
 	edac_debugfs_create_file("ddrc_info", 0400, mci->debugfs, mci,
 				 &snps_ddrc_info_fops);
 
+	edac_debugfs_create_file("hif_sdram_map", 0400, mci->debugfs, mci,
+				 &snps_hif_sdram_map_fops);
+
 	edac_debugfs_create_file("inject_data_error", 0600, mci->debugfs, mci,
 				 &snps_inject_data_error);
 
-- 
2.41.0

