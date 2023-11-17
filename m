Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 374AE7EF93F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 22:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346238AbjKQVKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 16:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235563AbjKQVKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 16:10:23 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1EE91735
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 13:09:59 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6b20577ef7bso2241588b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 13:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700255399; x=1700860199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DL5piRnOOgGpwdkxQbi83S5rjEjfPe4DjTzZgACvY58=;
        b=EIyHVlKiSNhvyjB29Mm9SC2Cksbkw8cRh8ped9kyLt/tn60jK6yxzAb2qdMZtQdb1G
         51IIH5TP0BVhDyAqHpBM6rPpMeXP3vUF8fDSc1FaRS9BnrfWDm95Rvvqu9qbD7y3X/+o
         hKacmxm77F7aStYWW/MvaHgM6GYgYNZbIt2Pw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700255399; x=1700860199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DL5piRnOOgGpwdkxQbi83S5rjEjfPe4DjTzZgACvY58=;
        b=HdZFsIHwCpIdiB7erP4uTyXrwSnZORJaA/hyYWMYVD68fA4+eY5W4ca2/egMX4JYaI
         AMoccZIeOgB18Si+H7SY0jSYdVFmNHdkEXkiJxO4WJWY7ZulaJvNjNiqDwgVRFJ+ar/q
         FnKR9kDpqUKqFgWRkMWiQgy8JDZArYfviNuHBRNvdNwH2fDDVPvVJ/2T4oDLqaiXuKjf
         vKGNx4nJ1dK/COKQk0Re65OmbFWZOAYqVLTtbJvqJBXnBwGbNPx69k+OQUeLhhdFokA8
         kbsrWPJQStq3JAA9DtcJ4SNTX4UhZvnApFHub+onmt1qlSkvlLKea+h1Zffo9LQVBcmh
         CXUw==
X-Gm-Message-State: AOJu0YyuAufDmg1Mq55iBq5MYksuwhMdBbKUug77VDG99LtrODjnP+Yl
        r4cKCs+DVA3zY1UP/Yj9ztDyCQ==
X-Google-Smtp-Source: AGHT+IGHWMC8lpH06rvyXJMANK059TL4Qd9yND7/duFlglKPEMZcUlex5YYsClh3kZ/YlBoNHES+4A==
X-Received: by 2002:a05:6a20:bea5:b0:187:652d:95b5 with SMTP id gf37-20020a056a20bea500b00187652d95b5mr289192pzb.62.1700255398792;
        Fri, 17 Nov 2023 13:09:58 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:b953:95f4:4240:7018])
        by smtp.gmail.com with ESMTPSA id h20-20020a056a00219400b006c624e8e7e8sm1780587pfi.83.2023.11.17.13.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 13:09:58 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Jakub Kicinski <kuba@kernel.org>,
        Hayes Wang <hayeswang@realtek.com>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Grant Grundler <grundler@chromium.org>,
        Simon Horman <horms@kernel.org>,
        Edward Hill <ecgh@chromium.org>, linux-usb@vger.kernel.org,
        Laura Nao <laura.nao@collabora.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Douglas Anderson <dianders@chromium.org>,
        =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH 2/2] r8152: Add RTL8152_INACCESSIBLE checks to more loops
Date:   Fri, 17 Nov 2023 13:08:42 -0800
Message-ID: <20231117130836.2.I79c8a6c8cafd89979af5407d77a6eda589833dca@changeid>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
In-Reply-To: <20231117130836.1.I77097aa9ec01aeca1b3c75fde4ba5007a17fdf76@changeid>
References: <20231117130836.1.I77097aa9ec01aeca1b3c75fde4ba5007a17fdf76@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previous commits added checks for RTL8152_INACCESSIBLE in the loops in
the driver. There are still a few more that keep tripping the driver
up in error cases and make things take longer than they should. Add
those in.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/net/usb/r8152.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index d6edf0254599..aca7dd7b4090 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -3000,6 +3000,8 @@ static void rtl8152_nic_reset(struct r8152 *tp)
 		ocp_write_byte(tp, MCU_TYPE_PLA, PLA_CR, CR_RST);
 
 		for (i = 0; i < 1000; i++) {
+			if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
+				return;
 			if (!(ocp_read_byte(tp, MCU_TYPE_PLA, PLA_CR) & CR_RST))
 				break;
 			usleep_range(100, 400);
@@ -3329,6 +3331,8 @@ static void rtl_disable(struct r8152 *tp)
 	rxdy_gated_en(tp, true);
 
 	for (i = 0; i < 1000; i++) {
+		if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
+			return;
 		ocp_data = ocp_read_byte(tp, MCU_TYPE_PLA, PLA_OOB_CTRL);
 		if ((ocp_data & FIFO_EMPTY) == FIFO_EMPTY)
 			break;
@@ -3336,6 +3340,8 @@ static void rtl_disable(struct r8152 *tp)
 	}
 
 	for (i = 0; i < 1000; i++) {
+		if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
+			return;
 		if (ocp_read_word(tp, MCU_TYPE_PLA, PLA_TCR0) & TCR0_TX_EMPTY)
 			break;
 		usleep_range(1000, 2000);
@@ -5499,6 +5505,8 @@ static void wait_oob_link_list_ready(struct r8152 *tp)
 	int i;
 
 	for (i = 0; i < 1000; i++) {
+		if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
+			return;
 		ocp_data = ocp_read_byte(tp, MCU_TYPE_PLA, PLA_OOB_CTRL);
 		if (ocp_data & LINK_LIST_READY)
 			break;
@@ -5513,6 +5521,8 @@ static void r8156b_wait_loading_flash(struct r8152 *tp)
 		int i;
 
 		for (i = 0; i < 100; i++) {
+			if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
+				return;
 			if (ocp_read_word(tp, MCU_TYPE_USB, USB_GPHY_CTRL) & GPHY_PATCH_DONE)
 				break;
 			usleep_range(1000, 2000);
@@ -5635,6 +5645,8 @@ static int r8153_pre_firmware_1(struct r8152 *tp)
 	for (i = 0; i < 104; i++) {
 		u32 ocp_data = ocp_read_byte(tp, MCU_TYPE_USB, USB_WDT1_CTRL);
 
+		if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
+			return -ENODEV;
 		if (!(ocp_data & WTD1_EN))
 			break;
 		usleep_range(1000, 2000);
@@ -5791,6 +5803,8 @@ static void r8153_aldps_en(struct r8152 *tp, bool enable)
 		data &= ~EN_ALDPS;
 		ocp_reg_write(tp, OCP_POWER_CFG, data);
 		for (i = 0; i < 20; i++) {
+			if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
+				return;
 			usleep_range(1000, 2000);
 			if (ocp_read_word(tp, MCU_TYPE_PLA, 0xe000) & 0x0100)
 				break;
-- 
2.43.0.rc0.421.g78406f8d94-goog

