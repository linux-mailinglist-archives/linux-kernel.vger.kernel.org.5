Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 567157EE490
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 16:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345251AbjKPPri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 10:47:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjKPPrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 10:47:35 -0500
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A723A98
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 07:47:31 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1700149165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=zGJY/UaMXZJk2KoIDNYtHJc8ukK/8yvCIHPa7DqyLmA=;
        b=TfGitfsdv/JsDiFUyq99pS8cb2IKzKGlgaQrG5xdBc9AQQSQrTzD6ZmcoULq0V8rrHbDn6
        0XM163BFkvjkfpcaOKPnsQxqu57dIJJ3lA/4KA7EWubgVaj8Ho2sUg5i2tbiiXLnlVyybv
        VcEe7/IRObBbYWkt1u3v4oaaMrXaeO0=
From:   Cixi Geng <cixi.geng@linux.dev>
To:     apw@canonical.com, joe@perches.co, dwaipayanray1@gmail.com,
        lukas.bulwahn@gmail.com, akpm@linux-foundation.org,
        rdunlap@infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] checkpatch: add judgment condition for Kconfig help test
Date:   Thu, 16 Nov 2023 23:39:04 +0800
Message-Id: <20231116153904.15589-1-cixi.geng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cixi Geng <cixi.geng1@unisoc.com>

The has_help only counted the  situation which the patch file add
a help line, when the config was renamed and  modify description,
the has_help is zero for the "help" line not added.

here is one case:
    the modify file: drivers/iio/adc/Kconfig  line(1047)

    -config SC27XX_ADC
    +config SPRD_ADC
     	tristate "Spreadtrum SC27xx series PMICs ADC"
     	depends on MFD_SC27XX_PMIC || COMPILE_TEST
    +	depends on ARCH_SPRD
     	help
    -	  Say yes here to build support for the integrated ADC inside the
    -	  Spreadtrum SC27xx series PMICs.
    +	  Say yes here to build support for the integrated ADC inside of the
    +	  Spreadtrum SC27xx and UMPxx series PMICs.

     	  This driver can also be built as a module. If so, the module
     	  will be called sc27xx_adc.

the checkpatch result:
    WARNING: please write a help paragraph that fully describes the config symbol
    #23: FILE: drivers/iio/adc/Kconfig:1050:
    +config SPRD_ADC
    +	tristate "Spreadtrum's ADC PMICs driver"
     	depends on MFD_SC27XX_PMIC || COMPILE_TEST
    +	depends on ARCH_SPRD
     	help
    +	  Say yes here to build support for the integrated ADC inside of the
    +	  Say yes here to build support for the integrated ADC inside of the
    +	  Say yes here to build support for the integrated ADC inside of the
    +	  Spreadtrum SC27xx and UMPxx series PMICs.

     	  This driver can also be built as a module. If so, the module
     	  will be called sc27xx_adc.

    total: 0 errors, 1 warnings, 17 lines checked

Fixes: b8709bce9089 ("checkpatch: improve Kconfig help test")
Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 25fdb7fda112..402009d08505 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3616,7 +3616,7 @@ sub process {
 					$needs_help = 1;
 					next;
 				}
-				if ($f =~ /^\+\s*help\s*$/) {
+				if ($f =~ /^\+\s*help\s*$/ || $f =~ /^\s*help\s*$/) {
 					$has_help = 1;
 					next;
 				}
-- 
2.34.1

