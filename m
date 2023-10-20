Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E22F87D17B9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 23:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232885AbjJTVIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 17:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbjJTVIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 17:08:23 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E1CD6D
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 14:08:16 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6b36e1fcea0so1107537b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 14:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697836095; x=1698440895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZvOeqgh1R0cFVT/LR2McM1sRBuOsLz4JWxKyKe8PLwc=;
        b=fvrGT2uIFyeVVEgMKDDOv3hLBZrccgGahRS/L1FAcXmLUZw5xzd2FtVuNtbPKMbGDL
         PeH3tsTbm/+zEesEPqmYR6QvH5lgY5LvCpv7DaDEoeeQJ9P2MQMV4FkaO1gPSxBdGUPT
         gucm08DAC2ueM/EG1sJl2tWDOzj90Kc35i1lI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697836095; x=1698440895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZvOeqgh1R0cFVT/LR2McM1sRBuOsLz4JWxKyKe8PLwc=;
        b=nMty3qIqb6JJxvwyVgil/cx/cM1vccvYsWDnQK6+MkBr71JVOFXSs1xcJgRjWhn26f
         KDiEdWcmnwvH6Oot81RROLsg4KoMw5djc7sVA5IvsHVMHvRkgYON3ZTOpgWE1UPu5Nuz
         i9kB7OI0dG8Gns6Ev7U2FS0M/bj3tddxWzw0n0uvn2eoJhcRxVdf0SsgIztl/fWgbn+F
         is3X0+8w3C0JIuqnBQWLrT2Rx1G1iEmATcrbKtWWT4XaJi9D/8MeekL2dyKU4QU5Hg3y
         VYbeGHiFCDy9e+mRKnVypBg69kUyj9DW8ZbfmzAoSORFd53nvWxGzx5VwhbWb+nJ/GTy
         HDsA==
X-Gm-Message-State: AOJu0Yy+XwiGe3chDuSKuQlFL/pryhV/kh1xYYJx9IVp4FISUKrlb2xt
        WjIE6SLEbWMEgAJYW6zKuFYx/A==
X-Google-Smtp-Source: AGHT+IEzitYnZ+qhAkuPmGLMEpNU1IygWpXUTt1/zzwHbDbA+VfqgbH3v+NEMoQ+ttmtINkvfrrfsw==
X-Received: by 2002:a05:6a20:432c:b0:17b:1696:e5ea with SMTP id h44-20020a056a20432c00b0017b1696e5eamr3319169pzk.14.1697836095564;
        Fri, 20 Oct 2023 14:08:15 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:c078:ee4f:479f:8486])
        by smtp.gmail.com with ESMTPSA id w14-20020aa7954e000000b00686b649cdd0sm1969278pfq.86.2023.10.20.14.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 14:08:14 -0700 (PDT)
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
Subject: [PATCH v5 3/8] r8152: Cancel hw_phy_work if we have an error in probe
Date:   Fri, 20 Oct 2023 14:06:54 -0700
Message-ID: <20231020140655.v5.3.I33c8decabd2e77c37524db02b4e6b9b4dbc3a8d6@changeid>
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

The error handling in rtl8152_probe() is missing a call to cancel the
hw_phy_work. Add it in to match what's in the cleanup code in
rtl8152_disconnect().

Fixes: a028a9e003f2 ("r8152: move the settings of PHY to a work queue")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v5:
- ("Cancel hw_phy_work if we have an error in probe") new for v5.

 drivers/net/usb/r8152.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 201c688e3e3f..d10b0886b652 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -9783,6 +9783,7 @@ static int rtl8152_probe(struct usb_interface *intf,
 
 out1:
 	tasklet_kill(&tp->tx_tl);
+	cancel_delayed_work_sync(&tp->hw_phy_work);
 	if (tp->rtl_ops.unload)
 		tp->rtl_ops.unload(tp);
 	usb_set_intfdata(intf, NULL);
-- 
2.42.0.758.gaed0368e0e-goog

