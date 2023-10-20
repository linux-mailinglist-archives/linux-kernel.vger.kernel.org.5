Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E007D17C1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 23:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbjJTVIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 17:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232860AbjJTVIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 17:08:25 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A92F10E7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 14:08:21 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6b20577ef7bso1129843b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 14:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697836101; x=1698440901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CQE73OQ0b8iyTRPhBZA90MrBZY63bSWJ7tj6pb5onnk=;
        b=C/wcTvjnhoKLAEVBZozgEwzY0xA/DkFBe0ny+6jN4qe9QGLfpf2hviHQQJGhx/UwZG
         SbMuv+PwCsEZ0nE9UHj418jXDtYUzQGxl5kfHTui68brDAHYidm8qVqNWMy1GMppu9ab
         F5wbVyrqwr8nfkCgN1M33E/s+MjSR5BA01gyQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697836101; x=1698440901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CQE73OQ0b8iyTRPhBZA90MrBZY63bSWJ7tj6pb5onnk=;
        b=wjqxJ4Rusw//gQqxtndyb0pjVi/32RTc+vB9G5GXnhm99SaRFKdZ8GrmVGjl0ObzQI
         VJ1VglDbArUmGo+l1ZSJx7CBkN9kih/9YaoWhlngg/+6/vaoHTnOEZ3OgkJrT3kJLDhn
         EQAhwCtglmZHSJ8uw/D6AjUAVrJSfy/p8w3Hy3OJgOG7oVKfSluJEmMQKVxg706wulpU
         CgCInY0+SC9n6OeHWV3AlYI4xWhxtWru2MWNxp9MrTW3vSX1NzLL3BhhccvWNWFepPtk
         uF3/t4LANh+SE1UqOvSFTDbRORYsjwJl8QR2zu05IJsKEnVcYSORUYBWgJv0ehOL4zbD
         werQ==
X-Gm-Message-State: AOJu0Yw2xTn5LC2B5mMCuca/AQHl+HDiaJmofPCyQU/9Wd8Xzf2j0+/c
        FdARaTLGGJc9zgk4lVmfxJI+yQ==
X-Google-Smtp-Source: AGHT+IHFBIplpt14DZg6hItiXgYR+r3PgP8bBFAvwNN0vfftWs9vbOrRHRML59tRSCJmkzB46s5Pgw==
X-Received: by 2002:a05:6a20:3c8b:b0:15d:9ee7:180a with SMTP id b11-20020a056a203c8b00b0015d9ee7180amr3042099pzj.4.1697836100885;
        Fri, 20 Oct 2023 14:08:20 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:c078:ee4f:479f:8486])
        by smtp.gmail.com with ESMTPSA id w14-20020aa7954e000000b00686b649cdd0sm1969278pfq.86.2023.10.20.14.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 14:08:20 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Jakub Kicinski <kuba@kernel.org>,
        Hayes Wang <hayeswang@realtek.com>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Edward Hill <ecgh@chromium.org>,
        Laura Nao <laura.nao@collabora.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Simon Horman <horms@kernel.org>, linux-usb@vger.kernel.org,
        Grant Grundler <grundler@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH v5 6/8] r8152: Check for unplug in r8153b_ups_en() / r8153c_ups_en()
Date:   Fri, 20 Oct 2023 14:06:57 -0700
Message-ID: <20231020140655.v5.6.I6405b1587446c157c6d6263957571f2b11f330a7@changeid>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
In-Reply-To: <20231020210751.3415723-1-dianders@chromium.org>
References: <20231020210751.3415723-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the adapter is unplugged while we're looping in r8153b_ups_en() /
r8153c_ups_en() we could end up looping for 10 seconds (20 ms * 500
loops). Add code similar to what's done in other places in the driver
to check for unplug and bail.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v2)

Changes in v2:
- ("Check for unplug in r8153b_ups_en() / r8153c_ups_en()") new for v2.

 drivers/net/usb/r8152.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 9888bc43e903..982f9ca03e7a 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -3663,6 +3663,8 @@ static void r8153b_ups_en(struct r8152 *tp, bool enable)
 			int i;
 
 			for (i = 0; i < 500; i++) {
+				if (test_bit(RTL8152_UNPLUG, &tp->flags))
+					return;
 				if (ocp_read_word(tp, MCU_TYPE_PLA, PLA_BOOT_CTRL) &
 				    AUTOLOAD_DONE)
 					break;
@@ -3703,6 +3705,8 @@ static void r8153c_ups_en(struct r8152 *tp, bool enable)
 			int i;
 
 			for (i = 0; i < 500; i++) {
+				if (test_bit(RTL8152_UNPLUG, &tp->flags))
+					return;
 				if (ocp_read_word(tp, MCU_TYPE_PLA, PLA_BOOT_CTRL) &
 				    AUTOLOAD_DONE)
 					break;
-- 
2.42.0.758.gaed0368e0e-goog

