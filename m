Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035FC79385A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 11:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237217AbjIFJeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 05:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237277AbjIFJdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 05:33:49 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767B71985;
        Wed,  6 Sep 2023 02:32:53 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-79536bc6697so119821039f.1;
        Wed, 06 Sep 2023 02:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693992772; x=1694597572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mupUPPSzcJJRakpj7WwBk32eQdNzGLMXaNaR5uYzp8A=;
        b=Dzy44+sOzdbwhd4QcnIg0YHTHu55rWSzdCZOeeKK+defqfmBN75i+pU8rq4c/4tOet
         A+UqVIiF8etQOehGHwSbnEIam161FLezBcOqJpw5VamgqKQlHjty7CSxwhPlbd4m6n2W
         hd0kvsvzRDGk4/oyxKVedLIp40c0hu4PN0CNvSdjtLH8TMkyHze9liTQzkMIvG0peDeU
         x0QUJDpA6QOwr6JL0g+MBMdCxtSlzKNDSDgcaacVGQKNV9If7myzLCRdCr0CQZl4gEyN
         9ct51igsu5VfiAVKRV2Xo9ao7ToMnYf4B/8bm9nDMuzj3nVqpmESg3e3L9hcsjyk3G/F
         Ow4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693992772; x=1694597572;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mupUPPSzcJJRakpj7WwBk32eQdNzGLMXaNaR5uYzp8A=;
        b=Lc9YzqzJDnTeL0cLWKrfJyI5nlLmW6GypI7UFX1PuZbMXLNjzXUOWXsJbu5eS6CGzs
         Txm9DxPjUtusp9wUBgVBVNisunpGT8SNOo7dzAbtsuxYEKwOsbj2dWP0Qq4w5GC4uQ+f
         XjyYcQFlqbSoJ8j8tgFSnJx7g5UF63O4NTJgvCYrvDsrtxAimwjNV0pbRIW9iYKAcOga
         qwawfHO8RWR4vLoDlho7m9U+qocPVgxoNm6Iqt/FHYDCpisdFyTieKNrnrHbSpA9G54q
         TqQMT/YE5fQVpY051kVstm3osE1VigiWStf686/IR5OrVL94jdouUS1pUiZbEnnYaIT6
         OWaQ==
X-Gm-Message-State: AOJu0YyRvyyosPw3A7rgLogBxL5Ae3PVav1YJ+dp1xzzzNsftq5vHecU
        yUZm7uRCShHBNjSNhvopsDSypxZGprI=
X-Google-Smtp-Source: AGHT+IE/SxiZTAwA6/WLLQiLQA7rDnQp1XnmilfdxbosDcDYc7XRyk31gS9W2/PZj8txrfKloPKY3Q==
X-Received: by 2002:a5e:db07:0:b0:784:314f:8d68 with SMTP id q7-20020a5edb07000000b00784314f8d68mr16922177iop.1.1693992772074;
        Wed, 06 Sep 2023 02:32:52 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:b68d:99e6:78c9:f0e6])
        by smtp.gmail.com with ESMTPSA id s10-20020a02cf2a000000b0042b320c13aasm4792732jar.89.2023.09.06.02.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 02:32:50 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-omap@vger.kernel.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] bus: ti-sysc: Fix missing AM35xx SoC matching
Date:   Wed,  6 Sep 2023 04:32:44 -0500
Message-Id: <20230906093244.99292-1-aford173@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit feaa8baee82a ("bus: ti-sysc: Implement SoC revision handling")
created a list of SoC types searching for strings based on names
and wildcards which associates the SoC to different families.

The OMAP34xx and OMAP35xx are treated as SOC_3430 while
OMAP36xx and OMAP37xx are treated as SOC_3630, but the AM35xx
isn't listed.

The AM35xx is mostly an OMAP3430, and a later commit a12315d6d270
("bus: ti-sysc: Make omap3 gpt12 quirk handling SoC specific") looks
for the SOC type and behaves in a certain way if it's SOC_3430.

This caused a regression on the AM3517 causing it to return two
errors:

 ti-sysc: probe of 48318000.target-module failed with error -16
 ti-sysc: probe of 49032000.target-module failed with error -16

Fix this by treating the AM35xx as a SOC_3430, and the error
conditions will disappear.

Fixes: a12315d6d270 ("bus: ti-sysc: Make omap3 gpt12 quirk handling SoC specific")
Fixes: feaa8baee82a ("bus: ti-sysc: Implement SoC revision handling")

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index eb4e7bee1e20..5d7779747941 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -3025,6 +3025,7 @@ static void ti_sysc_idle(struct work_struct *work)
 static const struct soc_device_attribute sysc_soc_match[] = {
 	SOC_FLAG("OMAP242*", SOC_2420),
 	SOC_FLAG("OMAP243*", SOC_2430),
+	SOC_FLAG("AM35*", SOC_3430),
 	SOC_FLAG("OMAP3[45]*", SOC_3430),
 	SOC_FLAG("OMAP3[67]*", SOC_3630),
 	SOC_FLAG("OMAP443*", SOC_4430),
-- 
2.39.2

