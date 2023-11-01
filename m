Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054017DDA24
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 01:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376956AbjKAA1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 20:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376971AbjKAA0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 20:26:42 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8E0101;
        Tue, 31 Oct 2023 17:26:34 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-352a22e1471so24290415ab.0;
        Tue, 31 Oct 2023 17:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698798394; x=1699403194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mLvXeLnsRUQ3/TUrQnBU04ibB7JIWTVa6JOjlgQ9hVM=;
        b=JPGLrh4BrDgX4CTlPH6es0DC8EYZ/Le74ckoKiK1p7dFPgalHmHnbl0n+Xs/vwXR2o
         pz4hLGkfEPCU/f4Ii+Vu+BgFYHoGtn+lzIfzUG8zBYtZVa5ng0Nq0iSGGiK4cZ7rpkZy
         1YUVHh0lJPq0u7T0IV8l8+jvRlR0pPYrMWSu1sL+bF6SikJs68E+MrssaEBN3NXsjTOu
         6IdFQsDRA4IIGZhUEUhnehfMAVXzHq8G8KIgxCH8ChCB6r14v9yv80Yvv+56IjxCS1m8
         Chp9nwI7NLJV4BQ8jY8UXmn7I8F1koweIfrlQvdMyLI+/Z9eGOv8boI70+/CAk6o/FgU
         F8Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698798394; x=1699403194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mLvXeLnsRUQ3/TUrQnBU04ibB7JIWTVa6JOjlgQ9hVM=;
        b=wJrO4tdYZ3lvyC1oIg+vmJRL0VS3gRE0rvRNv9H9YuolOcvgR1f9mr1dGBxd1++I1I
         oDmqKaZD7jLEfiE/wQtL+CFCMA4kiru0VDjfC9Ql3nKnSp1UcoXCMM6nh2qWtg6GP38G
         MEku5ER2PdYSL+IFi4DKSEwPcJX+AgEWOzkI113SwM4SEiCNT33Xfqp27H+VYkcvN/U3
         P0wPfbKHHH4h0g/sAQPA5IvVZhQXiWH5Ec4bhX3ntnXprGct9ktSO3pEFXhPHaA0lsL7
         pkHXNqbSOENrmz2z9AfvGpFktvP8CaGfSV7r9ekiAfeaD0K1xcNr154n2YZIqI/202wU
         C4Aw==
X-Gm-Message-State: AOJu0YwR8Oe8AtgyiaKLsGswIflPiL7MEHj2FvMcn0NWL5HfxmZjRwsx
        zmnR/OVaCJA6jgaKEVGIK54oxGn0RhjbWw==
X-Google-Smtp-Source: AGHT+IH246yK5XoAuq8aFwuTy3IhmHQfJeZAmtaH8z4ascPRKOZJiUIEKC/NefNQ28TvH8PRxfb+Ug==
X-Received: by 2002:a05:6e02:b26:b0:351:5a77:f169 with SMTP id e6-20020a056e020b2600b003515a77f169mr18404169ilu.29.1698798394030;
        Tue, 31 Oct 2023 17:26:34 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id t1-20020a92c901000000b00357cc8df1d5sm141701ilp.68.2023.10.31.17.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 17:26:33 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, jbaron@akamai.com,
        gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     lb@semihalf.com, linux@rasmusvillemoes.dk, joe@perches.com,
        mcgrof@kernel.org, daniel.vetter@ffwll.ch, jani.nikula@intel.com,
        ville.syrjala@linux.intel.com, seanpaul@chromium.org,
        robdclark@gmail.com, groeck@google.com, yanivt@google.com,
        bleung@google.com, linux-doc@vger.kernel.org,
        quic_saipraka@quicinc.com, will@kernel.org,
        catalin.marinas@arm.com, quic_psodagud@quicinc.com, maz@kernel.org,
        arnd@arndb.de, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, mingo@redhat.com,
        jim.cromie@gmail.com
Subject: [PATCH v7d 12/23] dyndbg: reduce verbose=3 messages in ddebug_add_module
Date:   Tue, 31 Oct 2023 18:25:58 -0600
Message-ID: <20231101002609.3533731-13-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231101002609.3533731-1-jim.cromie@gmail.com>
References: <20231101002609.3533731-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

