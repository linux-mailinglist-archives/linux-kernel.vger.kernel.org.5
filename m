Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A1479C33E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240505AbjILCqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232972AbjILCqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:46:38 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E5810DBE9;
        Mon, 11 Sep 2023 16:27:48 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-57756115f08so1535725a12.3;
        Mon, 11 Sep 2023 16:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694474777; x=1695079577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mmy4CQw8YdfUBsoDy2sZHYo8FTokxGCRVZcEnly2Jnk=;
        b=lwre9pJUZcQTXRB60c0sEd2Vb0tYVOdpzPfRdUqw0I+GX0dA3rvrYXzSZBHvpiPZCA
         UiT4ewBCOrfd06QG0wEsrptT9XE3kPSCFfXolJYe/gIRxGucNHpFOXQMiLpB2Mj/GcT5
         aAV1QvK20neqZrPrwlCmvMxIUZMXqetvcDB3DyF9m4fEEeoAxN/nkVOpk8Lf8Sa6faN+
         YJ1En3kUjGuJYYLqeObDEuR7+6MoR19rF3ZToV/cNsLO5IjcJFm5n5TuACOBpw6fZgqQ
         6VsJsgFovikYrUyiHPNqBlYFNbgrIz1IPtHD+ADGmiR0q+xhROKQn0Bk0RoG4bMLKWR9
         1uDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694474777; x=1695079577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mmy4CQw8YdfUBsoDy2sZHYo8FTokxGCRVZcEnly2Jnk=;
        b=Y1HQgNMbpSahLiDINmhEaPjd9SUOw2rA27GV3+0Cm0NIU6hDCU2OZqzGkByr9PiRqc
         VigpcI2tBSfDu2i3WH/iuab6NQHFFJDGCkKuNSL2eJy6NEr+Un8/TJvDOtqo9Nvap7w3
         /re8G+UipZEKCKZxTresyj0hVuNwBUWmhray65tCq+EAeqoNBZkwHyUyzocGwbMzJyXS
         1HxkBb3+Yr1KZ8ttiD4eLNXH0xDtskOC+bAhsp9a9coRJhQzfxqwaYcjjcaYGTrp+gpG
         YUPZs0y5FGUSc5wyTAbTsrwT844ujQB5mNqRk1JlJV3UOgNaYAomF7mScY6m4i0s3xtC
         Mqcw==
X-Gm-Message-State: AOJu0YwdkeLUAv+bPIskUNjTDoOjL8CBRTdbPNvwl9MlUIkUyqiBR5Cs
        5m4hNGrv1cKNLmKachwVaKt/Aj7Er4ZhuQ==
X-Google-Smtp-Source: AGHT+IHLAdJUICDJlpY2SLsUaMJZhDgX9mAPnhl1PjVBKn7g0kArqTJLgGWW4MmaywrbY9ZEQTsn9Q==
X-Received: by 2002:a05:6602:197:b0:791:1b1c:b758 with SMTP id m23-20020a056602019700b007911b1cb758mr13933894ioo.19.1694473725817;
        Mon, 11 Sep 2023 16:08:45 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id z4-20020a029f04000000b00423240c7296sm2512607jal.69.2023.09.11.16.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 16:08:45 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org, mcgrof@kernel.org,
        daniel.vetter@ffwll.ch
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, jani.nikula@intel.com,
        ville.syrjala@linux.intel.com, seanpaul@chromium.org,
        robdclark@gmail.com, linux-doc@vger.kernel.org,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v6 02/22] dyndbg: make ddebug_class_param union members same size
Date:   Mon, 11 Sep 2023 17:08:18 -0600
Message-ID: <20230911230838.14461-3-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911230838.14461-1-jim.cromie@gmail.com>
References: <20230911230838.14461-1-jim.cromie@gmail.com>
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

struct ddebug_class_param keeps a ref to the state-storage of the
param, make both flavors use the same unsigned long under-type.
ISTM this is simpler and safer.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 2 +-
 lib/dynamic_debug.c           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 4fcbf4d4fd0a..5231aaf361c4 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -124,7 +124,7 @@ struct _ddebug_info {
 struct ddebug_class_param {
 	union {
 		unsigned long *bits;
-		unsigned int *lvl;
+		unsigned long *lvl;
 	};
 	char flags[8];
 	const struct ddebug_class_map *map;
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index fea732db7323..6fee76fcddd1 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -796,7 +796,7 @@ int param_get_dyndbg_classes(char *buffer, const struct kernel_param *kp)
 
 	case DD_CLASS_TYPE_LEVEL_NAMES:
 	case DD_CLASS_TYPE_LEVEL_NUM:
-		return scnprintf(buffer, PAGE_SIZE, "%d\n", *dcp->lvl);
+		return scnprintf(buffer, PAGE_SIZE, "%ld\n", *dcp->lvl);
 	default:
 		return -1;
 	}
-- 
2.41.0

