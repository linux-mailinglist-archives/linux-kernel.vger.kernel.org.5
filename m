Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1FC796DA5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 01:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244931AbjIFXe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 19:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244886AbjIFXe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 19:34:57 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36BD19C;
        Wed,  6 Sep 2023 16:34:53 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-34df2a961a0so1372695ab.2;
        Wed, 06 Sep 2023 16:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694043293; x=1694648093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GPiD2nqWpooFzEFjv1+ctUArxYEmVQ9w6ftYrG1WlT8=;
        b=YB9zUUV+Tyu8KlQrgO764tR7CxuxG5+dBkLs2L9M2Wo6sCWYt9i2lk2nC37NMkutYB
         HOXzXyTyX1+gbzzswxtNcsRx1tzGfTgJbxYV64C8XRhWJvFt//8RO/TVU8oQXI1xlbhD
         JLwuJFbsTaoqYS1aM9b9/dfLEIWDJmTkchF0MoiOlE0KEOHBVxC0+iqb+03r2aOhQZre
         zRIzsnu9jbzKS6vsOo5E8cUBYMKSf2jG6dgA1OXCoTrIXYbULPPgf9+HFCpMVrWJyDLT
         XTG4sDuZIAJooOf9ikVaeSO3HU89pD3qw/mmraO3MhF4jUY1aumVGjED4bhiSVrm3u82
         bJWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694043293; x=1694648093;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GPiD2nqWpooFzEFjv1+ctUArxYEmVQ9w6ftYrG1WlT8=;
        b=R8ZkYB6QdGBZzMOBC+gf63dQEltYJuSGP5vxPRUosfcB7HWzwb1iu9z04oC1jhKr90
         Y/U6/Ii1p7P+zQbuJQGrw6dngy2ZupRsNvZ2xBe2z2ukjhmgIF21h/CuFsx13yGKoyG7
         JCzFZBlcX+iB2ZC4jCAMn4/Z2yN5NKrJeE5cbK5kZkpnq0JkwZdKkwHMEWsdocQwzc/O
         VCp+Ktu+miga3Ps/QEHTsdS1W69GWr0WdsH/msjIgX1GRlGowMOKe33BBRh3BGmsXwF5
         f7c97TEijMSQRc8CKbrCpSQuvSbkDuO5xNfLJX+wOtbkTkjl1DUCTrbK+p9sFwOHu56S
         l43g==
X-Gm-Message-State: AOJu0Yw1D7LlpjFW/oh79soP5nb+l/+jDW9mdAJSeEcSfzVKVE4TpgrN
        3FYQvvzMOc52tyukSaY4eLenOL82LWs=
X-Google-Smtp-Source: AGHT+IG5Cn18bCGH5/+HDQfRmMcnRCz0Csl3suWvpDs2U2kh7LKiifj3jq/IKcpdULj/WP1Iei5Mig==
X-Received: by 2002:a05:6e02:1154:b0:345:d58d:9ae5 with SMTP id o20-20020a056e02115400b00345d58d9ae5mr18404420ill.7.1694043292574;
        Wed, 06 Sep 2023 16:34:52 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:c24d:eb45:b814:f30b])
        by smtp.gmail.com with ESMTPSA id s25-20020a02ad19000000b0042b227eb1ddsm5161142jan.55.2023.09.06.16.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 16:34:50 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-omap@vger.kernel.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org
Subject: [PATCH V2] bus: ti-sysc: Fix missing AM35xx SoC matching
Date:   Wed,  6 Sep 2023 18:34:42 -0500
Message-Id: <20230906233442.270835-1-aford173@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

Fix this by treating the creating SOC_AM35 and inserting it between
the SOC_3430 and SOC_3630.  If it is treaed the same way as the
SOC_3430 when checking the status of sysc_check_active_timer,
the error conditions will disappear.

Fixes: a12315d6d270 ("bus: ti-sysc: Make omap3 gpt12 quirk handling SoC specific")
Fixes: feaa8baee82a ("bus: ti-sysc: Implement SoC revision handling")

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index eb4e7bee1e20..42c12df07cea 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -38,6 +38,7 @@ enum sysc_soc {
 	SOC_2420,
 	SOC_2430,
 	SOC_3430,
+	SOC_AM35,
 	SOC_3630,
 	SOC_4430,
 	SOC_4460,
@@ -1862,7 +1863,7 @@ static void sysc_pre_reset_quirk_dss(struct sysc *ddata)
 		dev_warn(ddata->dev, "%s: timed out %08x !+ %08x\n",
 			 __func__, val, irq_mask);
 
-	if (sysc_soc->soc == SOC_3430) {
+	if (sysc_soc->soc == SOC_3430 || sysc_soc->soc == SOC_AM35) {
 		/* Clear DSS_SDI_CONTROL */
 		sysc_write(ddata, 0x44, 0);
 
@@ -3025,6 +3026,7 @@ static void ti_sysc_idle(struct work_struct *work)
 static const struct soc_device_attribute sysc_soc_match[] = {
 	SOC_FLAG("OMAP242*", SOC_2420),
 	SOC_FLAG("OMAP243*", SOC_2430),
+	SOC_FLAG("AM35*", SOC_AM35),
 	SOC_FLAG("OMAP3[45]*", SOC_3430),
 	SOC_FLAG("OMAP3[67]*", SOC_3630),
 	SOC_FLAG("OMAP443*", SOC_4430),
@@ -3229,7 +3231,7 @@ static int sysc_check_active_timer(struct sysc *ddata)
 	 * can be dropped if we stop supporting old beagleboard revisions
 	 * A to B4 at some point.
 	 */
-	if (sysc_soc->soc == SOC_3430)
+	if (sysc_soc->soc == SOC_3430 || sysc_soc->soc == SOC_AM35)
 		error = -ENXIO;
 	else
 		error = -EBUSY;
-- 
2.39.2

