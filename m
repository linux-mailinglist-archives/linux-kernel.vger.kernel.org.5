Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E30C77D4929
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 09:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233770AbjJXH6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 03:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbjJXH6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 03:58:38 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097B5111;
        Tue, 24 Oct 2023 00:58:36 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-4083dbc43cfso30453875e9.3;
        Tue, 24 Oct 2023 00:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698134314; x=1698739114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F/HtEs3uRz9gEWjbZhb7PO6cLxbnlpDSnYG/nx0cMBY=;
        b=F/dyGMQgmhF3JiwUgQcwVkMJRjFCzkjgSIMlc3gU0om+1QrYezWMPKD4gArJ++S9mT
         XGzfaal64ct0rU6Qgq2wglto2ZgeNGt9oEecZ6d4Md7kvi3jemsdoEFxYnTcEN2zDt9W
         9NJGLs9tn2xHgA58Hq35JJkf+IgMDOn2Upq574lbBtUHPAyug+06Us2mxcPXYea2caRw
         e5UEOdt0lv/gGk5+IEUVXe2xCqJSYUCX3ECB5+zKaUuF8bQ9AIZJSGAddeS8iI6/nLVQ
         qDN5oZDJ/tPuQxLBk/8e8N+eKHVQKQdtyIHm6TbvWXYk+O/B1cnuQe2ZxwOd3mgJ/IXf
         lWzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698134314; x=1698739114;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F/HtEs3uRz9gEWjbZhb7PO6cLxbnlpDSnYG/nx0cMBY=;
        b=YvvRTONZL8jJrbJl64gy/8+Kw1zL8CwUgS9OPKBTT9yn9f8CieuOwU7C0mMQ7llh9f
         dKvJeTo7cnhJxjBMNYR4cn4E+bCTuF3CEyeglcYLGZbHU0d4GZk3nYBKA0FQnjSktmOh
         FwF4x1UBcbW8DEWK+SNoyFmsLwZGhAeLUpD7EdPAz+RX7xptE2c8jo+ydaExkcMrVJMG
         WkL161WoItLAfh5S8pTT7bipwBh7gAUr6iT6Ugp2Zl0YHYNa3oTgxrlt+3F63bDLRJS2
         J09BRscrsKeavgpC2ZTZTyXZ7n46D4322dtTm7VUnmyzp6e6IY+rpwgEjIBppJmo05zW
         jjhA==
X-Gm-Message-State: AOJu0YxCpPTtQgtqd0z+tiweuPL2L+GVBxfa+peFY+OVh+/zuxoduEje
        D/mfQrAZXWJOXciN/IoemC4=
X-Google-Smtp-Source: AGHT+IF30oiEgFGhMcxcPgUJRA24HG6sxIFDWiPUfcQIYeZXfeyFm+j5FHiLpV82d/M11oRUgBv6Fg==
X-Received: by 2002:a05:600c:4e8c:b0:401:bf56:8ba6 with SMTP id f12-20020a05600c4e8c00b00401bf568ba6mr8759283wmq.28.1698134314272;
        Tue, 24 Oct 2023 00:58:34 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id r6-20020a05600c458600b00406443c8b4fsm16155790wmo.19.2023.10.24.00.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 00:58:33 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Gregory Greenman <gregory.greenman@intel.com>,
        Kalle Valo <kvalo@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        linux-wireless@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] wifi: iwlwifi: Fix spelling mistake "SESION" -> "SESSION"
Date:   Tue, 24 Oct 2023 08:58:32 +0100
Message-Id: <20231024075832.695405-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

There is a spelling mistake in a WARN message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/time-event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
index 218fdf1ed530..245d45f48cc0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
@@ -929,7 +929,7 @@ void iwl_mvm_rx_session_protect_notif(struct iwl_mvm *mvm,
 
 	if (WARN(ver > 2 && mvmvif->time_event_data.link_id >= 0 &&
 		 mvmvif->time_event_data.link_id != notif_link_id,
-		 "SESION_PROTECTION_NOTIF was received for link %u, while the current time event is on link %u\n",
+		 "SESSION_PROTECTION_NOTIF was received for link %u, while the current time event is on link %u\n",
 		 notif_link_id, mvmvif->time_event_data.link_id))
 		goto out_unlock;
 
-- 
2.39.2

