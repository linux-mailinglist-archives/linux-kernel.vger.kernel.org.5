Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA497D6640
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 11:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233876AbjJYJH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 05:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233804AbjJYJH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 05:07:56 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D8F182;
        Wed, 25 Oct 2023 02:07:54 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d9443c01a7336-1ca79b731f1so10492315ad.0;
        Wed, 25 Oct 2023 02:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698224874; x=1698829674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=16RyNcr8fXdSv8PEk5/PP5mj/W1hB9JFhs/uYMnfilQ=;
        b=RKT6Zd7oyfLASImUzgGsagN+d+jp6Sq64RQZRdIhcSJYnIeojtQsvVE3lC00tXr4fp
         TsoRkpc6elMcXPn8HDQO0Wdl0x+pBYJd3ku4ZhY/9ABhGZ8ZkvlE65KdyiNy9NSTrI9g
         EEshxj8cDeiJCDCUY4tBdgSNogRyO5iZ3TqDv9I70WwK/LaKacFK1hsJ+WmbeUQUWAYB
         ggun/GPphPgenG7eNjkeDbwAVySUf/FGdpMBahitrHV2sxNoUvomSj2gJvD8ORBoentc
         qXqhnHTaG9cETb2ArhOU9k4dbds8gfU8pBtrPBrkuJsLkXuXo4Uz0wcrIuvvFOf3ElJs
         0FWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698224874; x=1698829674;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=16RyNcr8fXdSv8PEk5/PP5mj/W1hB9JFhs/uYMnfilQ=;
        b=rpxkLzHije5djOlM9lE/DJZ/DGzvrcTrlQQrrMT8miPLepJ525Mwr0LnQ+W9KRAdTT
         +ladgPmI6iw/HrzVr999H/AxAf6w1iiZtjk5B48PRmn7qQDOBzbQ60xOU8fKgsDAT312
         IlmtjKh380pN8egVm2Ha7FoY5BDIqVfmb0FdQ5Dyaz5Nt5qApDVJ63XhhH1x++awDI7M
         oAcnxNjay6+vQwzxFWlyaDv1gt0YgX5c6tXc5FdkUS8c03SjtXJiYXdto7flDLBAryNJ
         kCmFUCfXnk2DmaHkonNbFCS6H4/eKx3/NtO954hYjiuhMkTqGysbSCyTCNvPnTzs7O08
         /Odw==
X-Gm-Message-State: AOJu0YwpE2cRdHgmVAJPbXnyfNJNU/83YU3MXTez2HU3NBsS99GG2mbo
        uJpPLewdG/lEvI410KQLcU0=
X-Google-Smtp-Source: AGHT+IFyNuBmzwGlUgWsDXNy99+YoXF0mB0httpc8mHUXkVXr17vpkP5ZRkYrBTffvPCzjO3gw6qbQ==
X-Received: by 2002:a17:902:e291:b0:1ca:273d:232 with SMTP id o17-20020a170902e29100b001ca273d0232mr13712988plc.0.1698224873774;
        Wed, 25 Oct 2023 02:07:53 -0700 (PDT)
Received: from hbh25y.mshome.net ([103.114.158.1])
        by smtp.gmail.com with ESMTPSA id l20-20020a170903005400b001bba7aab822sm8824870pla.5.2023.10.25.02.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 02:07:53 -0700 (PDT)
From:   Hangyu Hua <hbh25y@gmail.com>
To:     kristo@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        tony@atomide.com, claudiu.beznea@microchip.com, robh@kernel.org,
        andriy.shevchenko@linux.intel.com,
        dario.binacchi@amarulasolutions.com
Cc:     linux-omap@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hangyu Hua <hbh25y@gmail.com>
Subject: [PATCH] ti: fix possible memory leak in _ti_omap4_clkctrl_setup
Date:   Wed, 25 Oct 2023 17:07:41 +0800
Message-Id: <20231025090741.32997-1-hbh25y@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kstrndup and kstrdup_and_replace in clkctrl_get_name can perform
dynamic memory allocation. So clkctrl_name needs to be freed when
provider->clkdm_name is NULL.

Fixes: bd46cd0b802d ("clk: ti: clkctrl: check return value of kasprintf()")
Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
---
 drivers/clk/ti/clkctrl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/ti/clkctrl.c b/drivers/clk/ti/clkctrl.c
index 607e34d8e289..cb4aa8a45bb2 100644
--- a/drivers/clk/ti/clkctrl.c
+++ b/drivers/clk/ti/clkctrl.c
@@ -591,6 +591,7 @@ static void __init _ti_omap4_clkctrl_setup(struct device_node *node)
 		provider->clkdm_name = kasprintf(GFP_KERNEL,
 						 "%s_clkdm", clkctrl_name);
 		if (!provider->clkdm_name) {
+			kfree(clkctrl_name);
 			kfree(provider);
 			return;
 		}
-- 
2.34.1

