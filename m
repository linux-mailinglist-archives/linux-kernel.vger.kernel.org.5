Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEC2782BAF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 16:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235941AbjHUOYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 10:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235932AbjHUOYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 10:24:40 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367BCE2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 07:24:38 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4ff88239785so5020378e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 07:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1692627876; x=1693232676;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gPDn+AM+nE1Msl9ECDPxx14WMyfdDVEac2xAC1ONR/Q=;
        b=dnqNzoj12sR7v5evYG572J590KzB7lFQ2vyMLE8f26x0lrLOZUIjmrjq0+ZUTnjgaT
         FDunUJIM0DmqOsnO0gfk0tCQMcmHjhDEde20zcKRt9uzZoEmriHH27I6nlF8xmRoKecH
         Oy4XXKQUsWFJ71amaPXz7KwtiEwsMjNZHD+pLCtzYSmXoyEaGruwDdfKA0mdgfT8F4TQ
         3JKq2vnPKRkNSMbcMx3TjoOz6Fyz1OpP9wXFy3TYYynjrUzym2oyXghVUsFO6iQ16mKN
         u6PKGM2GFMQ1v3bz+jV+nEJ8VP3E2bGfAEXXcmvozX0cImxfCwNXFVSvGPu3lDanxWGj
         EGTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692627876; x=1693232676;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gPDn+AM+nE1Msl9ECDPxx14WMyfdDVEac2xAC1ONR/Q=;
        b=PsumC8aO6dSHCsx9d3yMrcv8f6v5i/iqriLPHVZUBeBnSMiqH9zpvPVGruRzYIaCNZ
         lSYRoEcZ7MZ2Xd1q3EFEIYgkn0lXU5MsEe/b5MPpYBucUtAaDhVJqSbwla3B0sDMQnx6
         vhNNxwSqs76QklfDipzG7geD6p5Kcb6B1u7Qvd+xCJzax94GzWeYYrUc569Z1eC9dbh5
         H7yIt7PrbkOV3DM8ikdadQKpHENI7HDuldqqelCxJpvecrNOnf/F3tdhPQ12vN6I2dhf
         SFgbLyW3/ijF4WDFTrNP/3RI80quQv37JygxStg6+GxycZojnDcv6//vzv60C14Zx+dv
         EuBg==
X-Gm-Message-State: AOJu0YzKN1Aj5D7GySNAzDzd0YA6jWM4W/NrXupwxp1Q0vGqbb8EFCZt
        6I3gzfMt0hOgJ6EL+CXsCfTu3A==
X-Google-Smtp-Source: AGHT+IErsrF8B8YUvfsJbD0GYuz/5Mc2vKk2fKEIpuGgnaLF/jRF94m8u602U0V/kVxaJ6y4EXauDw==
X-Received: by 2002:a05:6512:31c8:b0:4fe:5133:1213 with SMTP id j8-20020a05651231c800b004fe51331213mr5604650lfe.12.1692627876421;
        Mon, 21 Aug 2023 07:24:36 -0700 (PDT)
Received: from [127.0.1.1] ([86.71.62.228])
        by smtp.gmail.com with ESMTPSA id k9-20020a056402048900b0052540e85390sm6020340edv.43.2023.08.21.07.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 07:24:36 -0700 (PDT)
From:   Julien Panis <jpanis@baylibre.com>
Date:   Mon, 21 Aug 2023 16:24:18 +0200
Subject: [PATCH] bus: ti-sysc: Use fsleep() instead of usleep_range() in
 sysc_reset()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230821-fix-ti-sysc-reset-v1-1-5a0a5d8fae55@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAJFz42QC/x3NwQrCMBCE4Vcpe3YhSRsRX0U8JHG0ezDKbihK6
 bubevwZPmYlgwqMzsNKikVMXrWHPwxU5lQfYLn1puDC6E7B810+3ITta4UVhsax+OPkoh+nmKm
 7nAycNdUy7/KZrEH34a3o+n92uW7bDwXj9mR8AAAA
To:     Tony Lindgren <tony@atomide.com>
Cc:     linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        vigneshr@ti.com, Julien Panis <jpanis@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692627875; l=1644;
 i=jpanis@baylibre.com; s=20230526; h=from:subject:message-id;
 bh=wosjVAPxqS63TYMds7orC3rBPMd9IvKzazAuLflW8Ho=;
 b=XIJ5qxcY8LwWlb2BWKQPb8v3jg2fVGyFGZ8lAlf9CaK84wSxCFPdhAILXwqfNS7rdgvnUT1GT
 q3Ru+mNSU/eCsC8+jidCRnOqeGYT8YR2lqg4VnaWxL2rwmGFkM/1Vc/
X-Developer-Key: i=jpanis@baylibre.com; a=ed25519;
 pk=8eSM4/xkiHWz2M1Cw1U3m2/YfPbsUdEJPCWY3Mh9ekQ=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The am335x-evm started producing boot errors because of subtle timing
changes:

Unhandled fault: external abort on non-linefetch (0x1008) at 0xf03c1010
...
sysc_reset from sysc_probe+0xf60/0x1514
sysc_probe from platform_probe+0x5c/0xbc
...

The fix consists in using the appropriate sleep function in sysc reset.
For flexible sleeping, fsleep is recommended. Here, sysc delay parameter
can take any value in [0 - 255] us range. As a result, fsleep() should
be used, calling udelay() for a sysc delay lower than 10 us.

Signed-off-by: Julien Panis <jpanis@baylibre.com>
Fixes: e709ed70d122 ("bus: ti-sysc: Fix missing reset delay handling")
---
Fix boot errors for am335x-evm in sysc_reset(), by using fsleep() instead
of usleep_range() function. Thus, udelay() will be called if the configured
sysc delay is lower than 10 us (which is usually the case, since the value
set in the device tree is currently 2 us).
---
 drivers/bus/ti-sysc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index 4cb23b9e06ea..59b8bdd9203e 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -2147,8 +2147,7 @@ static int sysc_reset(struct sysc *ddata)
 	}
 
 	if (ddata->cfg.srst_udelay)
-		usleep_range(ddata->cfg.srst_udelay,
-			     ddata->cfg.srst_udelay * 2);
+		fsleep(ddata->cfg.srst_udelay);
 
 	if (ddata->post_reset_quirk)
 		ddata->post_reset_quirk(ddata);

---
base-commit: f7757129e3dea336c407551c98f50057c22bb266
change-id: 20230821-fix-ti-sysc-reset-5c164051345b

Best regards,
-- 
Julien Panis <jpanis@baylibre.com>

