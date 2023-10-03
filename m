Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1E07B71CB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 21:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240936AbjJCTdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 15:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240940AbjJCTdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 15:33:42 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E78D3
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 12:33:37 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9b2c5664cb4so44593466b.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 12:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696361615; x=1696966415; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KmOK5nTUWkYnjS4nXNkbZr/qlzx1/zJ4Eml2lPlllD0=;
        b=F4i64Agz3HBkjXgzpnCjB3vz+O0w83N1NZxNnI3XsirbXsYDUTdVP6H5cYmUHcvyWK
         FY/ecFVgf2ASX2uOjEgjXMNSW/cIIJCdi5lrcAQKuyycvqko7k9aIaj+0LbJp/GE+tjo
         +B26QIyb7zg1IbgyozScur0++IJYp3ZG6pfFk16uESHT2GC1xckNAWk+w6fiilmecm39
         zOQQcP9KWg8Kv4VWGrLHWMQ7mOWxvCgb8bz8zOlF6FIatsHgSNr6OKfhqiT2M98hTuD/
         ATzlptQNgtgyFSFucZRQExe/OZ3z0d5u18gpaSVSUQMQIRPtOqTattj9n4xODqZqcVSX
         tvjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696361615; x=1696966415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KmOK5nTUWkYnjS4nXNkbZr/qlzx1/zJ4Eml2lPlllD0=;
        b=V5cK+AavJXFtrP4wXqSDG8/j2t5Ixl3gQwsRUyd1THbALpPvk/T34gC5kuXY0U4e5A
         QIolpturayCuXL+5oB49ETrFq9tttN9neZSQQg8gQP7KbIWJ1brEHoL3kqBaRlRkcH0e
         B7IW2Ypf0WSmBU1ymyIYdB69K8cZhw2GT0xliZSXaWn32nJOWkOsFwgSPfd8Dup7bic/
         Ux4DY1WfPU4bHg2dXesGJwMcN61pyBoIYUEfzcpJ9WOoD0lRvNtaoBzq6w/upQFnX3Vv
         Hac6XYh8HRCsJPWzAvCXMzogkxvzqSpZr+TnN2w7lU7r+bR9ZFy1g6wcQNZrBgk6ybWc
         knQQ==
X-Gm-Message-State: AOJu0YySc/8kbPU2UamZaWNYGuqQzlONNCQtMb5GTW564lyltB6xS1bB
        KzhFcQZWHj4kZq8FdyP1jW8=
X-Google-Smtp-Source: AGHT+IFgGySfjQxeVabz8Mba5OoaWdJl77RgI6UFFhg5QoRtEsxwEAh9kkDPu6KCLk0CvKxBMrxAiQ==
X-Received: by 2002:a17:906:530b:b0:9a1:aea8:cb5a with SMTP id h11-20020a170906530b00b009a1aea8cb5amr131361ejo.1.1696361615592;
        Tue, 03 Oct 2023 12:33:35 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id c20-20020a170906529400b0098d2d219649sm1531444ejm.174.2023.10.03.12.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 12:33:35 -0700 (PDT)
Date:   Tue, 3 Oct 2023 21:33:33 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 05/11] staging: rtl8192e: Remove unused parameter mesh_flag
Message-ID: <3daa591db70978b305e4a1db7353fd96574d5591.1696360403.git.philipp.g.hortmann@gmail.com>
References: <cover.1696360403.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1696360403.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused parameter mesh_flag of function
rtllib_softmac_start_protocol().

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 2 +-
 drivers/staging/rtl8192e/rtllib.h            | 2 +-
 drivers/staging/rtl8192e/rtllib_softmac.c    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index d01cfca39ef5..9c872819969a 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -611,7 +611,7 @@ static int _rtl92e_sta_up(struct net_device *dev)
 		rtl92e_check_rfctrl_gpio_timer(&priv->gpio_polling_timer);
 
 	if (priv->rtllib->link_state != MAC80211_LINKED)
-		rtllib_softmac_start_protocol(priv->rtllib, 0);
+		rtllib_softmac_start_protocol(priv->rtllib);
 	rtllib_reset_queue(priv->rtllib);
 	_rtl92e_watchdog_timer_cb(&priv->watch_dog_timer);
 
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 41b34331380c..546eedfeb43e 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1705,7 +1705,7 @@ void rtllib_EnableIntelPromiscuousMode(struct net_device *dev, bool bInitState);
 void rtllib_DisableIntelPromiscuousMode(struct net_device *dev,
 					bool bInitState);
 void rtllib_softmac_stop_protocol(struct rtllib_device *ieee);
-void rtllib_softmac_start_protocol(struct rtllib_device *ieee, u8 mesh_flag);
+void rtllib_softmac_start_protocol(struct rtllib_device *ieee);
 
 void rtllib_reset_queue(struct rtllib_device *ieee);
 void rtllib_wake_all_queues(struct rtllib_device *ieee);
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index babd48aa327d..11395dbc9d4d 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -2316,7 +2316,7 @@ void rtllib_stop_protocol(struct rtllib_device *ieee)
 	ieee->assocresp_ies_len = 0;
 }
 
-void rtllib_softmac_start_protocol(struct rtllib_device *ieee, u8 mesh_flag)
+void rtllib_softmac_start_protocol(struct rtllib_device *ieee)
 {
 	mutex_lock(&ieee->wx_mutex);
 	rtllib_start_protocol(ieee);
-- 
2.42.0

