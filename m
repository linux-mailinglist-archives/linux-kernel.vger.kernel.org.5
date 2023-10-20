Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8127D14E3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 19:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377916AbjJTRaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 13:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjJTRaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 13:30:22 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74755A3;
        Fri, 20 Oct 2023 10:30:20 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-31427ddd3fbso793618f8f.0;
        Fri, 20 Oct 2023 10:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697823019; x=1698427819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NxpOXyb87A9tg1EnyFOnn6XQcp6Ef9sPYFZmIQknO/4=;
        b=Cw1zd9eltba6besS6mIeJCLCvQnxEceYYk6FIzDMRjGcA2svzj8TW2qZ2CeLgoV2yp
         2wdVGQ5a++UOKvKgJnJIfd3/tFBuOSeeaNM0c5/TqzuAGZrsl8Bz/9iKcBlvXZFottCf
         RVQuoX1pFEHAKOrMzyry3yBs4f5Fl1hZ/DSbo2tCZ20D1NzhqIMWjK7i6mVJmGJvvciv
         iY/r+ZUXjYegu+g+KXiHZcEwQbPP1AlBcp6VGZ+gst+l9nQ0hQKEY7zTN41jdylWHfMf
         B01H7qZjSs30XEorE8Pid3G02/CZKacoH8V9+dRKuScnWTw/H/1b+Accu4uAdyUx5ojZ
         /Sfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697823019; x=1698427819;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NxpOXyb87A9tg1EnyFOnn6XQcp6Ef9sPYFZmIQknO/4=;
        b=ZgjixgPWHxMCRIqc67JCCmTUuT0ZdE+FBA/N7gdblvTWhJLR7cwogt8LaNUDQzaCn/
         COcuqhGUhWjSNLkCSYKtgjf4Ob6iP7ez4D/RokGnlY7rOzP4zbiKesE6FTHK5nUvfURf
         LfDdjNDVdVKgbnfl8lzEqCR2uaJ1M2kF8u7+CXvv0axsobGdUwuPnIFpiG+PB9Jrho2/
         MPqtp00s9hfVGp6SzgjXJow0jhbpPmIfIUrgHYV6K2iqGfBXFhifwVW16Z4uLjNDP5pc
         GEV9uJIHwVX4QxDuOb5exT5jwiswZeRqZOeDo3Zz0GshctBcrAEjY9ghCLoWwmwdjx/S
         DtxA==
X-Gm-Message-State: AOJu0YyDOY9W0+7FXXkw9SXRWmvRbceMwAnoOOoMa3JK0+asrvSc2onB
        32D8xfSWUM3KwNV3ESGbytc=
X-Google-Smtp-Source: AGHT+IHKMIMV/P7s2BKrgigGnTNV6sABljrLOhvsv462uIs/FRCd8uGfJnqGkQ+ETWSbQNPsKW/kyQ==
X-Received: by 2002:a5d:5b1c:0:b0:32d:a61a:85cc with SMTP id bx28-20020a5d5b1c000000b0032da61a85ccmr3083519wrb.8.1697823018563;
        Fri, 20 Oct 2023 10:30:18 -0700 (PDT)
Received: from PC-PEDRO-ARCH.lan ([2001:8a0:7280:5801:9441:3dce:686c:bfc7])
        by smtp.gmail.com with ESMTPSA id r6-20020a5d6946000000b00318147fd2d3sm2102854wrw.41.2023.10.20.10.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 10:30:18 -0700 (PDT)
From:   Pedro Falcato <pedro.falcato@gmail.com>
To:     "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>, linux-kernel@vger.kernel.org,
        Pedro Falcato <pedro.falcato@gmail.com>
Subject: [PATCH] rcu: Remove unused macros from rcupdate.h
Date:   Fri, 20 Oct 2023 18:30:15 +0100
Message-ID: <20231020173015.30509-1-pedro.falcato@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ulong2long, USHORT_CMP_GE and USHORT_CMP_LT are redundant and have been
unused for quite a few releases.

Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
---
Just a boring chore patch that cleans up a few unused macros.

I'm *very* interested in knowing how that ulong2long macro came along,
though. What was wrong with '(long) a'?
 include/linux/rcupdate.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 5e5f920ade9..b9b6b828115 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -34,9 +34,6 @@
 
 #define ULONG_CMP_GE(a, b)	(ULONG_MAX / 2 >= (a) - (b))
 #define ULONG_CMP_LT(a, b)	(ULONG_MAX / 2 < (a) - (b))
-#define ulong2long(a)		(*(long *)(&(a)))
-#define USHORT_CMP_GE(a, b)	(USHRT_MAX / 2 >= (unsigned short)((a) - (b)))
-#define USHORT_CMP_LT(a, b)	(USHRT_MAX / 2 < (unsigned short)((a) - (b)))
 
 /* Exported common interfaces */
 void call_rcu(struct rcu_head *head, rcu_callback_t func);
-- 
2.42.0

