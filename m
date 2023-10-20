Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A793E7D17C4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 23:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbjJTVIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 17:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232710AbjJTVIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 17:08:24 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A837E10D4
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 14:08:19 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6b36e1fcee9so1253929b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 14:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697836099; x=1698440899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bAHIdwVQAiU7foM+hKZA1xP7duO0xSFXmMfBzAEr0JE=;
        b=jjPP0R+Zvip59m9GnAgCjFOC5ZF15TLYAfIkxR04byd7FNrDKaiarIblamhi0ORbje
         xfpt1fG7hy8ApnKxT/ypaiehvhf0p3bgboxbvPk+hoTbhr/9w3u+w6Ismd0ejkv3FINH
         YHYzi0dF3D+B6L+LL2jSO0ht1U6tbHLAShq64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697836099; x=1698440899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bAHIdwVQAiU7foM+hKZA1xP7duO0xSFXmMfBzAEr0JE=;
        b=wFD4rtEE4xneJGPl3nES1yaOZOAFZC3pHHvvJnSUChn71Ujhf8EIOOI45LULvqJDXn
         qXo/uYj3OPeGOtPtXEH3mQsh2F6329L9kFBBHGMsHW7iPNr4mFLsPsIAFUDVTewyhB8s
         p7OLKEAQZR2H66an9nOu7CBGyVCQFg0eH04adRI2/u1uLsvuoXpuqFcN0vmpfNdAMcO1
         rckkr68uXEJp0Y3Ifu4T17GjsFU9q27aVKXwzCT0+DLgDmcHcQnZktY978Tgyz+TGaSz
         u/GXwYCELbkfcTKkt81rT+pyZSHXJZSZlUCrrt+nWcye1YAP8qu34F7o0oB3e8tvqzY4
         5p3A==
X-Gm-Message-State: AOJu0YwfAE81VI7Bq/yqelnun4ZnQZ0EvnWJWAW+4I+3Ku10YXUM4LNn
        ge8ox4SUHiy+uEDpIc3jX9PolQ==
X-Google-Smtp-Source: AGHT+IEn6jcxkt9TyQiKUw23seFuVPHzoEYn+HWDkq+K/reiZe+dgtgWKedWHh/Hs0mkO3kxL0L5Iw==
X-Received: by 2002:a05:6a00:1402:b0:693:3851:bd3e with SMTP id l2-20020a056a00140200b006933851bd3emr3272815pfu.3.1697836099153;
        Fri, 20 Oct 2023 14:08:19 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:c078:ee4f:479f:8486])
        by smtp.gmail.com with ESMTPSA id w14-20020aa7954e000000b00686b649cdd0sm1969278pfq.86.2023.10.20.14.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 14:08:18 -0700 (PDT)
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
Subject: [PATCH v5 5/8] r8152: Check for unplug in rtl_phy_patch_request()
Date:   Fri, 20 Oct 2023 14:06:56 -0700
Message-ID: <20231020140655.v5.5.I300ed6c3269c77756bdd10dd0d6f97db85470186@changeid>
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

If the adapter is unplugged while we're looping in
rtl_phy_patch_request() we could end up looping for 10 seconds (2 ms *
5000 loops). Add code similar to what's done in other places in the
driver to check for unplug and bail.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

(no changes since v2)

Changes in v2:
- ("Check for unplug in rtl_phy_patch_request()") new for v2.

 drivers/net/usb/r8152.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 656fe90734fc..9888bc43e903 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -4046,6 +4046,9 @@ static int rtl_phy_patch_request(struct r8152 *tp, bool request, bool wait)
 	for (i = 0; wait && i < 5000; i++) {
 		u32 ocp_data;
 
+		if (test_bit(RTL8152_UNPLUG, &tp->flags))
+			break;
+
 		usleep_range(1000, 2000);
 		ocp_data = ocp_reg_read(tp, OCP_PHY_PATCH_STAT);
 		if ((ocp_data & PATCH_READY) ^ check)
-- 
2.42.0.758.gaed0368e0e-goog

