Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 007B37E0360
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 14:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376748AbjKCNKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 09:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376706AbjKCNK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 09:10:27 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2443C1A8
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 06:10:19 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-507be298d2aso2552420e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 06:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1699017017; x=1699621817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uhWtxM0qS6kRyTFS+yHc5Oehyo7Hed75UZyn2RY1SHs=;
        b=CzmZz9a238rOXfNbgg2ABmsVemX8oNTwFrVYX+ARpKYJeob2f5vXQZ2w/0X/hganWQ
         tugNcztMK0f6fkwMQUjAojB/LbAYBftge7yJYeaf3kEhGIwGfg0hSOn72roT6MeK3JUa
         6QSrYiFJ6VF+PiTL9DhHHOhldOiPXGzFfgowMp2Agkoy6vX0FCj3gZpOeOe7WgAXE9CY
         JV1+h7SivlaFiHvZmQJIyZNo2r/LB2RLMm2oYdr/yzccu7C0U54x22c+WI7nDhq73k0I
         f0rO9WDNoymLq2V43coY9gG0cBbwbeX9z/+GL7oE1bdjX6c9xfN3TDxWCtTZMLV7qPxJ
         dncw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699017017; x=1699621817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uhWtxM0qS6kRyTFS+yHc5Oehyo7Hed75UZyn2RY1SHs=;
        b=kQ3KlVYUB02cakuk5fGxZBFwRUXkmXr+vZwvRisxT5OX4+gQZDh6lMbv24ZWYnHWI5
         jIQCOSFMNqFcIeCPeYFroVnMx85TpwECwKT2jg/ikBwxIUA7lT4/M5YpC8QWMiBtq4zK
         vSuAd2wJjcFUdzL0YPT0nt20bY8fLFz/AEwr2E5GQOU9LfJ4WlNj40EoAovS/PPAJip4
         0/cnIKDzN1XjlEhiDvrjo/74ZaTFpXDpxoYliJKbt68arJU62WaX0dkQfUIEvqdLgews
         ZQkhHy9dImxGLeAH+VZ+z3VXtq6MePxkL0CSSPbLTn0y8LKwQhfY8ggm3GaZTx8l3rjA
         865Q==
X-Gm-Message-State: AOJu0Yxt6tQgrYnEQ/o7lEDoi1tbke3knT47j+pvLmKo08yoZccNhw2b
        th6EdpAiH/MJkZHOdBuKI5wxprPX79Qy20M+Fe/f
X-Google-Smtp-Source: AGHT+IG6q0aJI6J5+4iBm5dvQHxXgkv3aKium5C/q4Dh0pH4eX2eFdJAJv9bVJeeKtUNHU6zmYMtng==
X-Received: by 2002:ac2:446e:0:b0:4fe:2f8a:457e with SMTP id y14-20020ac2446e000000b004fe2f8a457emr16338767lfl.43.1699017017298;
        Fri, 03 Nov 2023 06:10:17 -0700 (PDT)
Received: from ukaszb-l.wifi.semihalf.net ([83.142.187.85])
        by smtp.gmail.com with ESMTPSA id f21-20020ac25335000000b00507a69a4799sm216336lfh.270.2023.11.03.06.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 06:10:17 -0700 (PDT)
From:   =?UTF-8?q?=C5=81ukasz=20Bartosik?= <lb@semihalf.com>
To:     Jason Baron <jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     Guenter Roeck <groeck@google.com>,
        Yaniv Tzoreff <yanivt@google.com>,
        Benson Leung <bleung@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        upstream@semihalf.com
Subject: [PATCH v1 02/12] dyndbg: add _DPRINTK_FLAGS_TRACE
Date:   Fri,  3 Nov 2023 14:10:01 +0100
Message-Id: <20231103131011.1316396-3-lb@semihalf.com>
X-Mailer: git-send-email 2.38.3
In-Reply-To: <20231103131011.1316396-1-lb@semihalf.com>
References: <20231103131011.1316396-1-lb@semihalf.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jim Cromie <jim.cromie@gmail.com>

Add new flag, and OR it into _DPRINTK_FLAGS_ENABLED definition

CC: vincent.whitchurch@axis.com
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 7be791af7cf1..497130816e9c 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -33,6 +33,9 @@ struct _ddebug {
 	 */
 #define _DPRINTK_FLAGS_NONE	0
 #define _DPRINTK_FLAGS_PRINTK	(1 << 0) /* printk() a message using the format */
+#define _DPRINTK_FLAGS_TRACE	(1 << 6)
+#define _DPRINTK_FLAGS_ENABLED	(_DPRINTK_FLAGS_PRINTK | _DPRINTK_FLAGS_TRACE)
+
 #define _DPRINTK_FLAGS_INCL_MODNAME	(1<<1)
 #define _DPRINTK_FLAGS_INCL_FUNCNAME	(1<<2)
 #define _DPRINTK_FLAGS_INCL_LINENO	(1<<3)
@@ -44,8 +47,6 @@ struct _ddebug {
 	 _DPRINTK_FLAGS_INCL_LINENO  | _DPRINTK_FLAGS_INCL_TID |\
 	 _DPRINTK_FLAGS_INCL_SOURCENAME)
 
-#define _DPRINTK_FLAGS_ENABLED		_DPRINTK_FLAGS_PRINTK
-
 #if defined DEBUG
 #define _DPRINTK_FLAGS_DEFAULT _DPRINTK_FLAGS_PRINTK
 #else
-- 
2.42.0.869.gea05f2083d-goog

