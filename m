Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 273E27CE3FA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbjJRRG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 13:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbjJRRGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:06:32 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4730C185;
        Wed, 18 Oct 2023 10:06:25 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-77acb04309dso284293239f.2;
        Wed, 18 Oct 2023 10:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697648784; x=1698253584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mLvXeLnsRUQ3/TUrQnBU04ibB7JIWTVa6JOjlgQ9hVM=;
        b=Nr6Aq4C3SjJiw3qHQe83gCz5GxFbhOuGiKw15Cj4wh819sQdZiUKSYtfEeDRcKTdWD
         7J2JeP9m4HihWsOJKExEwy6QGW9DImTxfMAwZnhAmmOmYIq2uOlZByvV4eEnPk6cD1I4
         /Rp6ihZHw1ShZ4TSghwj85YeAJHy3s9fOE00MPLxyI7midHYtEMj9OZD2Af7O5JpSeGL
         +EyT1xtN7zNvkA55nuUfCyOAx7XFVpAnl12bP9HG9jf9FeAWqtACyMTX+aT+7IBd6FdT
         br4CVguvVggxEJC7tfHTbI3Y9CbXewER09CRu/KV15sBweyUru7CzgA18v4LEy6XKoyX
         KK0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697648784; x=1698253584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mLvXeLnsRUQ3/TUrQnBU04ibB7JIWTVa6JOjlgQ9hVM=;
        b=Ip7O/bUAwRO/OKRV8fivzQ8A20dynRi+/w6jDrfQKagTXWC4E+WMynN/cTUkykbxxa
         uX64JN3yGThoZThyCdzt1m//Yefymn2z1diii+XaAn2Wwj46W95Nx3a6YrN9WGP64EA1
         B/VW6GsSRYu4xCiqoaeoiZuu3tfaCJr1rqDInveEckJ6mPxdvohpWPHRgdG6DsJY3AU3
         rcgdeTtBiK9hhLGkTSayBYeUGkPte5ncWE5EZLMQzrBWE5tqQH8Njon1GPsmUet0suXc
         +ovhyIk9XNzHZLBX2aN+vB98dDtqIj8FWKI7xxrm8wAqmObaxPQ1dFQuKBiS2RoiX1dG
         icIw==
X-Gm-Message-State: AOJu0YyZcnKMESsYMgWhl1ECcALkNVj3FitsuN+R8ajGjsrM1ZUKCBLY
        S4qms8fIMWfn8ILzLFRo8GHj8dNLHg1fOw==
X-Google-Smtp-Source: AGHT+IHXn5aDSBWQ4yV+ZfP2Q8uwJsUM84jyQKFm2T659/qUKTQfbS6h1rfjfndzbeqO5bduFZlWHg==
X-Received: by 2002:a05:6602:1611:b0:791:2db5:c779 with SMTP id x17-20020a056602161100b007912db5c779mr6946727iow.10.1697648784315;
        Wed, 18 Oct 2023 10:06:24 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id n4-20020a5d8244000000b0079fa1a7cd36sm1228944ioo.30.2023.10.18.10.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 10:06:23 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, jbaron@akamai.com,
        gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     lb@semihalf.com, linux@rasmusvillemoes.dk, joe@perches.com,
        mcgrof@kernel.org, daniel.vetter@ffwll.ch, jani.nikula@intel.com,
        ville.syrjala@linux.intel.com, seanpaul@chromium.org,
        robdclark@gmail.com, groeck@google.com, yanivt@google.com,
        bleung@google.com, rostedt@goodmis.org, linux-doc@vger.kernel.org,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v7c 12/24] dyndbg: reduce verbose=3 messages in ddebug_add_module
Date:   Wed, 18 Oct 2023 11:05:52 -0600
Message-ID: <20231018170604.569042-13-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018170604.569042-1-jim.cromie@gmail.com>
References: <20231018170604.569042-1-jim.cromie@gmail.com>
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

The fn currently says "add-module", then "skipping" if the module has
no prdbgs.  Just check 1st and return quietly.

no functional change

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 8beb98a831f5..45870a699507 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1242,11 +1242,10 @@ static int ddebug_add_module(struct _ddebug_info *di, const char *modname)
 {
 	struct ddebug_table *dt;
 
-	v3pr_info("add-module: %s.%d sites\n", modname, di->num_descs);
-	if (!di->num_descs) {
-		v3pr_info(" skip %s\n", modname);
+	if (!di->num_descs)
 		return 0;
-	}
+
+	v3pr_info("add-module: %s %d sites\n", modname, di->num_descs);
 
 	dt = kzalloc(sizeof(*dt), GFP_KERNEL);
 	if (dt == NULL) {
-- 
2.41.0

