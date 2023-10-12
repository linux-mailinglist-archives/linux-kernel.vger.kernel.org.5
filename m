Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC5B7C74B4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 19:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379646AbjJLRYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 13:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379633AbjJLRWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 13:22:43 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9BDD5D;
        Thu, 12 Oct 2023 10:22:11 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-79fce245bf6so47189639f.1;
        Thu, 12 Oct 2023 10:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697131331; x=1697736131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jwbGLv7+qIU1qCKTfLfixrysNO4bjXZnfSqF5055b/A=;
        b=GoNpSbciHRpT0Sq97TjI+r9MCuR4IZr82iCqZSbbreH9olOy9r6R7iE+4US7yrcxQr
         EdkSypA8Mgf9MGq6q1gU5Q7zxGEFmJbZ8H2y1sWIWrE7hr12E7mfo3HEYWPCrHqr0oQU
         ifPCBpPd2yMJs4+NMAZB/Ugc5ynwp9st1x/9Ab3RHS30QlnxC7LI924CqgFwjM5x46Yj
         Aa2kDsJKCX5PD46JAyS31DPzQOAEJqUfWlg09pbxH9MwJ1S/Voc05Yw35IXC+rdw+yUr
         PUZKMqGRDvYef36ogcTXr+j9zkcMW0u3CQNv0XgU3faab8ZLPxE6Q1I2VEdGyn6SMbD5
         ApCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697131331; x=1697736131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jwbGLv7+qIU1qCKTfLfixrysNO4bjXZnfSqF5055b/A=;
        b=HNYZBIiIzK+yXXco3BCwktUCS97m1aSZ0pM64oC54OTd1rvs4jVqICu7N4O73xBEa/
         Xdqi5jBExlxhaepOs0/vgU0NJDx3+pLZBLA2HSLD70fEGMoP5uAoqAQG77R7DCNSo6+g
         bKcAvQo7Z3eh/r8ZNc2UHRmWfdCggFYdW6L1rauxiHOHL++oFVDiMvSGuN0jjwRTGC9j
         RyZYHaVigO2wmNMfzxNMkkliZ7fj8w4h94pGu6F50YDdT5n7BIKrDtbDyfktaZju58mJ
         OXu8hzfh/RmZesSSoyflscG5DLlDo9ghDX36WxYN2fBCHo96CQhPkl6+hJkBt6lYf653
         8jNA==
X-Gm-Message-State: AOJu0YyaHAJGSGJsTLt1kCsCS1Ra6OIGNqend/6WWZU9VeG4fws2kC/P
        jTQmZXhEIQDEiO9u+upaLhTvqh94yALd3Q==
X-Google-Smtp-Source: AGHT+IECtPOLBs2br6sMKT09k7PFb8qWkcW7q5x1QEYhPaTgMqhZEUB2IkNqklsbRaZ6DquL0rs/LQ==
X-Received: by 2002:a5d:9743:0:b0:79f:96db:f33d with SMTP id c3-20020a5d9743000000b0079f96dbf33dmr27485863ioo.9.1697131330992;
        Thu, 12 Oct 2023 10:22:10 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id r25-20020a028819000000b0043cef0711c1sm3992211jai.158.2023.10.12.10.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 10:22:10 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, jbaron@akamai.com,
        gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     daniel.vetter@ffwll.ch, jani.nikula@intel.com,
        ville.syrjala@linux.intel.com, seanpaul@chromium.org,
        robdclark@gmail.com, groeck@google.com, yanivt@google.com,
        bleung@google.com, linux-doc@vger.kernel.org,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v7 22/25] dyndbg: improve err report in attach_user_module_classes
Date:   Thu, 12 Oct 2023 11:21:33 -0600
Message-ID: <20231012172137.3286566-23-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012172137.3286566-1-jim.cromie@gmail.com>
References: <20231012172137.3286566-1-jim.cromie@gmail.com>
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

convert a WARN on 3 conditions, into BUG_ON 2 of them (which don't
happen), and an early return on (!cli->user_mod_name), which *was*
happening, so should be seen going forward.  Maybe this should be a
WARN.

NB: The underlying problem was a missing __align(8) in the
DYNDBG_CLASSMAP_USE, which manifested as a corrupt record with a map
pointer which segv'd.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 974395bf8a83..3dc512fb1d66 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1284,9 +1284,11 @@ static void ddebug_attach_user_module_classes(struct ddebug_table *dt,
 	 */
 	for_each_boxed_vector(di, class_users, num_class_users, i, cli) {
 
-		if (WARN_ON(!cli || !cli->map || !cli->user_mod_name))
-			continue;
-
+		BUG_ON(!cli || !cli->map);
+		if (!cli->user_mod_name) {
+			pr_warn("class_ref[%d] !user-mod-name looking for %s\n", i, dt->mod_name);
+			return;
+		}
 		if (!strcmp(cli->user_mod_name, dt->mod_name)) {
 
 			vpr_cm_info(cli->map, "class_ref[%d] %s -> %s", i,
-- 
2.41.0

