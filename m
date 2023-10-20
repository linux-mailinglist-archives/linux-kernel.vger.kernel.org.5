Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3F57D17BA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 23:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbjJTVI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 17:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbjJTVIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 17:08:16 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37AB7D70
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 14:08:14 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6bee11456baso1143646b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 14:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697836094; x=1698440894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2t/WxCh6KdH2++1xQE9zOJhNaEepvtTtM2yGGCDnfvM=;
        b=IEFc52JD4Q0EusatVY/1HZS5odGzw3pdcgghbFuL8C7dZz9bMpAt8OFIye/bzE1xc7
         OG8GuYLZ1IeEk56r7RKjr3JM+zQevy1qfrwLKQaOMnH5kKVSHbTXP61KSeYuXvwTkYz1
         pImO3djVfbFkkR8tzxbVg5CdzHXW/Ig1rElr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697836094; x=1698440894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2t/WxCh6KdH2++1xQE9zOJhNaEepvtTtM2yGGCDnfvM=;
        b=wdS0RJI4FBy4uWOxl48oVUBok4XTCCBqskbBrAR8TbRM4uE9vSkVVs/eJ9Lut/Awo3
         R4uxiCIGcQRofcp+J29djgeqd3tp/yy/AJYWM7JQGlshpU7Zqr/jtIllBpuW0zQGuNR9
         VT9utqUMTZoi6qlbPsYLWmAE2M6UOMYyyuGZIUq50aZi/RZSsai872pGKXzDk2Nah02+
         8QGtJycI3LcWX/PGDD2tCk5hhlJD5OEVb6QMf2YGFjIlAjqqCLxpp+aEfX0HaJyRrIdu
         ocPFsd6MlVHxwsTtmChyxWX5UpgSrBxmQZDKeheHCFuyLHcqkBnhhfyaGnUT5SF2kpvk
         Ih0g==
X-Gm-Message-State: AOJu0YxhI9JIH93URz0NXicMC4dIYbhDhYSeVyVkxqv4H1cwI+qpVvCR
        XkPUxmgfL+qmYnhIwjoe1mgPOA==
X-Google-Smtp-Source: AGHT+IE6axLBKc3+wPtanABcT7sl7VGqkG2bF/ojJ4QnAH6ktIyTpmQIevCdzc7G9qZC5QtLCn5amQ==
X-Received: by 2002:a05:6a20:548c:b0:159:dccb:8bb4 with SMTP id i12-20020a056a20548c00b00159dccb8bb4mr3477526pzk.23.1697836093673;
        Fri, 20 Oct 2023 14:08:13 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:c078:ee4f:479f:8486])
        by smtp.gmail.com with ESMTPSA id w14-20020aa7954e000000b00686b649cdd0sm1969278pfq.86.2023.10.20.14.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 14:08:13 -0700 (PDT)
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
Subject: [PATCH v5 2/8] r8152: Run the unload routine if we have errors during probe
Date:   Fri, 20 Oct 2023 14:06:53 -0700
Message-ID: <20231020140655.v5.2.Ica8e16a84695e787d55e54e291fbf8a28e7f2f7b@changeid>
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

The rtl8152_probe() function lacks a call to the chip-specific
unload() routine when it sees an error in probe. Add it in to match
the cleanup code in rtl8152_disconnect().

Fixes: ac718b69301c ("net/usb: new driver for RTL8152")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v5:
- ("Run the unload routine if we have errors during probe") new for v5.

 drivers/net/usb/r8152.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 482957beae66..201c688e3e3f 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -9783,6 +9783,8 @@ static int rtl8152_probe(struct usb_interface *intf,
 
 out1:
 	tasklet_kill(&tp->tx_tl);
+	if (tp->rtl_ops.unload)
+		tp->rtl_ops.unload(tp);
 	usb_set_intfdata(intf, NULL);
 out:
 	free_netdev(netdev);
-- 
2.42.0.758.gaed0368e0e-goog

