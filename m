Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B83D7FE1C8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 22:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234547AbjK2V0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 16:26:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234456AbjK2V0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 16:26:24 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1136510C0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 13:26:30 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-5c18a3387f5so199689a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 13:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701293189; x=1701897989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MOZ1iLO8KtuEsZF7yZy5/8QOIlpTKo1m7A68f7ka2pI=;
        b=MJHG3FeNRJCV08bAES4RXwkf/jmlD7P+a2DJaKxg4x3vMs+05LcH+QtFy6akdFQxNB
         GAiYp/SgiSOcPphniGk4d5fikI0D3hXbOwqQqZ6fEN+PsdOdJ9QFKYkGgjSE5/FljEDN
         5YZqk667LykslGSxFsmP6n2C6HeqJDnuk3XsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701293189; x=1701897989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MOZ1iLO8KtuEsZF7yZy5/8QOIlpTKo1m7A68f7ka2pI=;
        b=VrrWqGyWAK76LYkUKgqnT7ybSoPCduPaPA8NsZBz/K6Y/7AGf2n99x/FUzfbWDdcCI
         rre5p42Q++Mm2jUXtGE31H/0jaCuzl+geT5Ls46DC8IA3WLOS1wmwo2nfZ1FZaEfQpAF
         nteETSVVcDT1boglVvHBbVMKa37KeivbpzztEHveG6PNiE8UPvdLtHHO2zg0IS16yYdZ
         mV2TlL6L6ghyzyoU1pJmBHEYi3Ez0UpTrnNcWNv8yeYS89e0Y0xKkMwi/21JYITZBEDG
         cMgmnjdYdB8RzZGALpZ72iAl152NnSQzEFB1/i1hdRT+dU/egT+q0IvPm/NtxZk3acK1
         6EJg==
X-Gm-Message-State: AOJu0YwmPts4070BqyXJpclz0BVFW0Uq42wuXDtz2OalrRxIrxIiHMXL
        z99afX5Rr4fdXaMOvJUokUZnjw==
X-Google-Smtp-Source: AGHT+IEhYjXD7fB92XlW1tMK7UHu4TadS7/wiHBovCTqBhKemR/gkXXjTAQ9pSQRYbjR1uPPeh5LiA==
X-Received: by 2002:a05:6a20:9698:b0:18b:4dc2:a4e1 with SMTP id hp24-20020a056a20969800b0018b4dc2a4e1mr18432953pzc.55.1701293189548;
        Wed, 29 Nov 2023 13:26:29 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:dcf:15e4:5f50:e692])
        by smtp.gmail.com with ESMTPSA id t22-20020a634616000000b005c215baacc1sm11816336pga.70.2023.11.29.13.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 13:26:29 -0800 (PST)
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
Subject: [PATCH net v3 5/5] r8152: Add RTL8152_INACCESSIBLE to r8153_aldps_en()
Date:   Wed, 29 Nov 2023 13:25:24 -0800
Message-ID: <20231129132521.net.v3.5.I1306b6432228404d6e61b2d43c2f71885292e972@changeid>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
In-Reply-To: <20231129132521.net.v3.1.I77097aa9ec01aeca1b3c75fde4ba5007a17fdf76@changeid>
References: <20231129132521.net.v3.1.I77097aa9ec01aeca1b3c75fde4ba5007a17fdf76@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delay loops in r8152 should break out if RTL8152_INACCESSIBLE is set
so that they don't delay too long if the device becomes
inaccessible. Add the break to the loop in r8153_aldps_en().

Fixes: 4214cc550bf9 ("r8152: check if disabling ALDPS is finished")
Reviewed-by: Grant Grundler <grundler@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v2)

Changes in v2:
- Added Fixes tag to RTL8152_INACCESSIBLE patches.
- Split RTL8152_INACCESSIBLE patches by the commit the loop came from.

 drivers/net/usb/r8152.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 3958eb622d47..fcdc9ba0f826 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -5803,6 +5803,8 @@ static void r8153_aldps_en(struct r8152 *tp, bool enable)
 		data &= ~EN_ALDPS;
 		ocp_reg_write(tp, OCP_POWER_CFG, data);
 		for (i = 0; i < 20; i++) {
+			if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
+				return;
 			usleep_range(1000, 2000);
 			if (ocp_read_word(tp, MCU_TYPE_PLA, 0xe000) & 0x0100)
 				break;
-- 
2.43.0.rc1.413.gea7ed67945-goog

