Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB679808D4A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 17:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235311AbjLGQO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 11:14:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235614AbjLGQOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 11:14:42 -0500
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA83E10E4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 08:14:32 -0800 (PST)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1fae0e518a4so1072018fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 08:14:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701965672; x=1702570472;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ZhzYoCpdG6VhiSR/L2EDWgRjEplV0sOkvK2BvrQlBY=;
        b=ibpKbcMCGJ9SW18Q10N5LzQcVL7Zt6AgMnzwsnLhSIWl5Sm0szJ5TeHEbjWTcWP9/b
         Xjo3V9oXQfF2AEqx/W0HifCxDuoDLu1LeLiWwmb3vm3WW7N6Ccf83tURvi6Je8o6xkqo
         f2LyzCTRdPr52OpmPvU56Qp0Yj/EzV1nPGIhyvbAXRfyhpZVedngrcyoAkwGRYAmgzgP
         9tNi6ptTXf/cdZg3W4+RTHxWJ79UXPlpI1yD/ra3hqKUa+9IdGP7H7fbQ2o1Tt6NObmX
         jeWyZ/iF4hj/WERWQbQjrqDQ1SxZGHB5MjTK0YJ3/EEwsR8KgDM40GnhfRGs5bBPuPe9
         1Txg==
X-Gm-Message-State: AOJu0Yxl7cdyVZshkWxcvL2ii2q7r5v8XTzzIg1IM5YIbnT8YYu9zAF4
        yaVsmks9yXKx9yV9oc+vDe1UH9VLRw==
X-Google-Smtp-Source: AGHT+IGg2De8Hudycv0spwcW7xlFp+/VXPuPdzbTiHU6aD1PozQnaH5DPp9trSHMsK0DhtAvDlnW1w==
X-Received: by 2002:a05:6870:ac21:b0:1fa:db2d:628c with SMTP id kw33-20020a056870ac2100b001fadb2d628cmr1430930oab.8.1701965672023;
        Thu, 07 Dec 2023 08:14:32 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id yl13-20020a05687c218d00b001fb17559927sm19102oab.48.2023.12.07.08.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 08:14:31 -0800 (PST)
Received: (nullmailer pid 2570647 invoked by uid 1000);
        Thu, 07 Dec 2023 16:14:30 -0000
From:   Rob Herring <robh@kernel.org>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] firmware: microchip: Replace of_device.h with explicit include
Date:   Thu,  7 Dec 2023 10:14:30 -0600
Message-ID: <20231207161430.2570611-1-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DT of_device.h and of_platform.h date back to the separate
of_platform_bus_type before it was merged into the regular platform bus.
As part of that merge prepping Arm DT support 13 years ago, they
"temporarily" include each other. They also include platform_device.h
and of.h. Soon the implicit includes are going to be removed.

of_device.h isn't needed, but platform_device.h is.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/firmware/microchip/mpfs-auto-update.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/microchip/mpfs-auto-update.c b/drivers/firmware/microchip/mpfs-auto-update.c
index d56a95b36b85..81f5f62e34fc 100644
--- a/drivers/firmware/microchip/mpfs-auto-update.c
+++ b/drivers/firmware/microchip/mpfs-auto-update.c
@@ -14,7 +14,7 @@
 #include <linux/math.h>
 #include <linux/module.h>
 #include <linux/mtd/mtd.h>
-#include <linux/of_device.h>
+#include <linux/platform_device.h>
 #include <linux/sizes.h>
 
 #include <soc/microchip/mpfs.h>
-- 
2.42.0

