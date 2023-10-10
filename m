Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9FED7BF08E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 04:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441808AbjJJCAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 22:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378945AbjJJCAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 22:00:01 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EAA28F;
        Mon,  9 Oct 2023 18:59:50 -0700 (PDT)
X-UUID: 5f6a0846977943199b4452c4cbcdd13c-20231010
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:3bee9790-88c2-4661-aca1-cf7c02a62ad7,IP:15,
        URL:0,TC:0,Content:-25,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACT
        ION:release,TS:-15
X-CID-INFO: VERSION:1.1.32,REQID:3bee9790-88c2-4661-aca1-cf7c02a62ad7,IP:15,UR
        L:0,TC:0,Content:-25,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-15
X-CID-META: VersionHash:5f78ec9,CLOUDID:773d9cf0-9a6e-4c39-b73e-f2bc08ca3dc5,B
        ulkID:231010093340A5656J4H,BulkQuantity:1,Recheck:0,SF:24|17|19|44|102,TC:
        nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI
        :0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-UUID: 5f6a0846977943199b4452c4cbcdd13c-20231010
X-User: yaolu@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by mailgw
        (envelope-from <yaolu@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 399756980; Tue, 10 Oct 2023 09:59:38 +0800
From:   Lu Yao <yaolu@kylinos.cn>
To:     hare@suse.com
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lu Yao <yaolu@kylinos.cn>
Subject: [PATCH] scsi: aic7xxx: Fix build 'aicasm' warning
Date:   Tue, 10 Oct 2023 09:59:35 +0800
Message-Id: <20231010015935.478006-1-yaolu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with CONFIG_AIC7XXX_BUILD_FIRMWARE=y or
CONFIG_AIC79XX_BUILD_FIRMWARE=y,  the warning message is as follow:

  aicasm_gram.tab.c:1722:16: warning: implicit declaration of function
    ‘yylex’ [-Wimplicit-function-declaration]

  aicasm_macro_gram.c:68:25: warning: implicit declaration of function
    ‘mmlex’ [-Wimplicit-function-declaration]

  aicasm_scan.l:417:6: warning: implicit declaration of function
    ‘mm_switch_to_buffer’

  aicasm_scan.l:418:6: warning: implicit declaration of function
    ‘mmparse’

  aicasm_scan.l:421:6: warning: implicit declaration of function
    ‘mm_delete_buffer’

The solution is to add the corresponding function declaration to the
corresponding file.

Signed-off-by: Lu Yao <yaolu@kylinos.cn>
---
 drivers/scsi/aic7xxx/aicasm/aicasm_gram.y       | 1 +
 drivers/scsi/aic7xxx/aicasm/aicasm_macro_gram.y | 1 +
 drivers/scsi/aic7xxx/aicasm/aicasm_scan.l       | 3 +++
 3 files changed, 5 insertions(+)

diff --git a/drivers/scsi/aic7xxx/aicasm/aicasm_gram.y b/drivers/scsi/aic7xxx/aicasm/aicasm_gram.y
index 65182ad9cdf8..b1c9ce477cbd 100644
--- a/drivers/scsi/aic7xxx/aicasm/aicasm_gram.y
+++ b/drivers/scsi/aic7xxx/aicasm/aicasm_gram.y
@@ -102,6 +102,7 @@ static void add_conditional(symbol_t *symbol);
 static void add_version(const char *verstring);
 static int  is_download_const(expression_t *immed);
 static int  is_location_address(symbol_t *symbol);
+int yylex();
 void yyerror(const char *string);
 
 #define SRAM_SYMNAME "SRAM_BASE"
diff --git a/drivers/scsi/aic7xxx/aicasm/aicasm_macro_gram.y b/drivers/scsi/aic7xxx/aicasm/aicasm_macro_gram.y
index 8c0479865f04..5c7350eb5b5c 100644
--- a/drivers/scsi/aic7xxx/aicasm/aicasm_macro_gram.y
+++ b/drivers/scsi/aic7xxx/aicasm/aicasm_macro_gram.y
@@ -61,6 +61,7 @@
 static symbol_t *macro_symbol;
 
 static void add_macro_arg(const char *argtext, int position);
+int mmlex();
 void mmerror(const char *string);
 
 %}
diff --git a/drivers/scsi/aic7xxx/aicasm/aicasm_scan.l b/drivers/scsi/aic7xxx/aicasm/aicasm_scan.l
index c78d4f68eea5..fc7e6c58148d 100644
--- a/drivers/scsi/aic7xxx/aicasm/aicasm_scan.l
+++ b/drivers/scsi/aic7xxx/aicasm/aicasm_scan.l
@@ -64,6 +64,9 @@ static char *string_buf_ptr;
 static int  parren_count;
 static int  quote_count;
 static char buf[255];
+void mm_switch_to_buffer(YY_BUFFER_STATE);
+void mmparse();
+void mm_delete_buffer(YY_BUFFER_STATE);
 %}
 
 PATH		([/]*[-A-Za-z0-9_.])+
-- 
2.25.1

