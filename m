Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEFE77FE1C6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 22:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234460AbjK2V0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 16:26:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234361AbjK2V0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 16:26:21 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902EC10D0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 13:26:26 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3b844e3e817so150104b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 13:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701293186; x=1701897986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oMcpqMy/WvMvoKWfDIGBKOAFuUqj17oPCULwBqejJlE=;
        b=C4lVJORKiRKQoLOQRaMC0SKViy4tj5C4e1iiha9OLbp2gviPXgdHl7Xarh4ln2cEkD
         mS2A2YJWz12HOoP8DMLXJjMrGizPLGZm87yzy6xoItNNbf82ynA+kLSGoiu3ZcR56wux
         fK0Y6KaA80U64dwQzXNWcokDnh5vYwmj/VnBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701293186; x=1701897986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oMcpqMy/WvMvoKWfDIGBKOAFuUqj17oPCULwBqejJlE=;
        b=bn+5DuUc8fskVyHtFGi+wnqDpGtFnVm9XFV8gpkJzrVxQyOli1LVY5CJ3Y+kIx9sKf
         dE6fumlfVnPDKunZ6lKcPT6ashp2T240Z6zXFtfScyI00bNnP6/6aoLOOxuo6lv5GXX/
         20OyBV/DLIoToF5xk+LbwwGMGNmQ8MdCAMuVaUp6+GoNqUbsDlbRhJrVIIm3slSFZROX
         i+Qp7Hp9uZsMvvysUsy0ppX0ldMd13LmnBqG7OoWMH9FEbc6ArzuPKv4G0YIu8RTE1Df
         tr0S7AlGJkKbXifbLSq7auq/1z/R6IykT9pbKyqTmn56eoTQ/Ob2qHxdYdx+wNjy7mYF
         98/A==
X-Gm-Message-State: AOJu0YxkBF+E66sig1PUV4+l95BgH7U3rL+eK1F1j18biNkrI+ap5L3g
        X4ZfJ+dzGASlf6VE4iZ1lwf+mw==
X-Google-Smtp-Source: AGHT+IFo9hDsSnSIWGrEdAY02Q4aEt7ECJUEAfZCr9exhU1TWNqAB4sD/xSLIxG2Em2k71nznnAgzw==
X-Received: by 2002:a54:4587:0:b0:3b8:37ba:7c73 with SMTP id z7-20020a544587000000b003b837ba7c73mr21628925oib.53.1701293185870;
        Wed, 29 Nov 2023 13:26:25 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:dcf:15e4:5f50:e692])
        by smtp.gmail.com with ESMTPSA id t22-20020a634616000000b005c215baacc1sm11816336pga.70.2023.11.29.13.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 13:26:25 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Jakub Kicinski <kuba@kernel.org>,
        Hayes Wang <hayeswang@realtek.com>,
        "David S . Miller" <davem@davemloft.net>
Cc:     linux-usb@vger.kernel.org, Grant Grundler <grundler@chromium.org>,
        Laura Nao <laura.nao@collabora.com>,
        Edward Hill <ecgh@chromium.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Simon Horman <horms@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH net v3 3/5] r8152: Add RTL8152_INACCESSIBLE to r8156b_wait_loading_flash()
Date:   Wed, 29 Nov 2023 13:25:22 -0800
Message-ID: <20231129132521.net.v3.3.Ib839d9adc704a04f99743f070d6c8e39dec6a1aa@changeid>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
In-Reply-To: <20231129132521.net.v3.1.I77097aa9ec01aeca1b3c75fde4ba5007a17fdf76@changeid>
References: <20231129132521.net.v3.1.I77097aa9ec01aeca1b3c75fde4ba5007a17fdf76@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delay loops in r8152 should break out if RTL8152_INACCESSIBLE is set
so that they don't delay too long if the device becomes
inaccessible. Add the break to the loop in
r8156b_wait_loading_flash().

Fixes: 195aae321c82 ("r8152: support new chips")
Reviewed-by: Grant Grundler <grundler@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v3:
- Use `break` when we see RTL8152_INACCESSIBLE, not `return`.

Changes in v2:
- Added Fixes tag to RTL8152_INACCESSIBLE patches.
- Split RTL8152_INACCESSIBLE patches by the commit the loop came from.

 drivers/net/usb/r8152.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index e9955701f455..c4dd81e2421f 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -5521,6 +5521,8 @@ static void r8156b_wait_loading_flash(struct r8152 *tp)
 		int i;
 
 		for (i = 0; i < 100; i++) {
+			if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
+				break;
 			if (ocp_read_word(tp, MCU_TYPE_USB, USB_GPHY_CTRL) & GPHY_PATCH_DONE)
 				break;
 			usleep_range(1000, 2000);
-- 
2.43.0.rc1.413.gea7ed67945-goog

