Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4DFE7B5E45
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 02:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238662AbjJCAej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 20:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjJCAeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 20:34:36 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6FAA9
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 17:34:33 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6910ea9cca1so246934b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 17:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696293273; x=1696898073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kv8GuqsvKsi/EUYP1j3AWhIWAgjVOKJZXtPzqkrmwyA=;
        b=XQ8y/wTb0K0shlaXqdpYjnZ03//WneqKJtXbDx7WJwCwflpqSoeplLqpul6Y7xRLlJ
         l2dvhUklhfHU+BsuQTiPEgOj7WXOF5q5lz3TxbDSLovYzINWyFPp0xbEHACkO/oVtEzo
         tvbr8pl1gQ14jKfdflhtWbtXzZgO5iV3AO6i4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696293273; x=1696898073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kv8GuqsvKsi/EUYP1j3AWhIWAgjVOKJZXtPzqkrmwyA=;
        b=Ha1TRKGkZjbEcWX/0lyJ89Rf6/WhKG4BUz0lK9j0uVum3HhCnedBA9fyDBsgm9LozX
         71EmedsBXp8kuclI8X4Xf3+23iPfWFHTeLLOuJ3X9wZcSUtwfrV2Hys6cFiHQoAEsJlz
         0NF/8PhKWNxXSWg2SnoOILXKeKGy482tPxWPYGN4zNwGMIDKnmMDjkVWMzM7sdhZLaFz
         NE34oGM0KZktN0lgNV4ue84Kp5uJ87kNsjJcKB5TuGTplyxJiDcedo0GLq9YUrWSmLSH
         BE1ZXDIKwJGsUiEe7n3qs6HEaskTzoKxsUZsanu9VCvlHRHZEK5Jrbm5QfzFUEno7TCv
         dAew==
X-Gm-Message-State: AOJu0Yy9gOVhlhbc4x4n1yGIUlpfK7ICcQUJvMRvpt1t7kIUn0PD8toW
        iFH2BC46Vi3k0squoXaKLzNzjg==
X-Google-Smtp-Source: AGHT+IFmyY1Jz5vTG+gHqh7YJUJXUAwzo6atPGN8MYVl4TgNouohFY5Mk9dCNjzr0dbhxeAvEeGuow==
X-Received: by 2002:a05:6a00:392a:b0:693:42d2:cde0 with SMTP id fh42-20020a056a00392a00b0069342d2cde0mr11023259pfb.22.1696293273499;
        Mon, 02 Oct 2023 17:34:33 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:11a:201:f676:8db:8677:aefe])
        by smtp.gmail.com with ESMTPSA id bm2-20020a056a00320200b0068a13b0b300sm101368pfb.11.2023.10.02.17.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 17:34:33 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Benson Leung <bleung@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        chrome-platform@lists.linux.dev,
        Prashant Malani <pmalani@chromium.org>
Subject: [PATCH 2/4] platform/chrome: cros_ec_typec: Use dev_err_probe() more
Date:   Mon,  2 Oct 2023 17:34:26 -0700
Message-ID: <20231003003429.1378109-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
In-Reply-To: <20231003003429.1378109-1-swboyd@chromium.org>
References: <20231003003429.1378109-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's some debug prints here that can be upgraded to dev_err_probe()
so that we don't have to fish out the error messages when a true error
happens. If they're simply probe defers then the kernel will keep silent
but if they're true errors we'll see the errors in the logs.

Cc: Prashant Malani <pmalani@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/platform/chrome/cros_ec_typec.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 82e7d08b52c7..67000e4a8082 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -80,28 +80,28 @@ static int cros_typec_get_switch_handles(struct cros_typec_port *port,
 	port->mux = fwnode_typec_mux_get(fwnode);
 	if (IS_ERR(port->mux)) {
 		ret = PTR_ERR(port->mux);
-		dev_dbg(dev, "Mux handle not found: %d.\n", ret);
+		dev_err_probe(dev, ret, "Mux handle not found\n");
 		goto mux_err;
 	}
 
 	port->retimer = fwnode_typec_retimer_get(fwnode);
 	if (IS_ERR(port->retimer)) {
 		ret = PTR_ERR(port->retimer);
-		dev_dbg(dev, "Retimer handle not found: %d.\n", ret);
+		dev_err_probe(dev, ret, "Retimer handle not found\n");
 		goto retimer_sw_err;
 	}
 
 	port->ori_sw = fwnode_typec_switch_get(fwnode);
 	if (IS_ERR(port->ori_sw)) {
 		ret = PTR_ERR(port->ori_sw);
-		dev_dbg(dev, "Orientation switch handle not found: %d\n", ret);
+		dev_err_probe(dev, ret, "Orientation switch handle not found\n");
 		goto ori_sw_err;
 	}
 
 	port->role_sw = fwnode_usb_role_switch_get(fwnode);
 	if (IS_ERR(port->role_sw)) {
 		ret = PTR_ERR(port->role_sw);
-		dev_dbg(dev, "USB role switch handle not found: %d\n", ret);
+		dev_err_probe(dev, ret, "USB role switch handle not found\n");
 		goto role_sw_err;
 	}
 
-- 
https://chromeos.dev

