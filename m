Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB5B7C749F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 19:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379697AbjJLRXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 13:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379693AbjJLRWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 13:22:31 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75F9185;
        Thu, 12 Oct 2023 10:22:00 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-79fca042ec0so46715739f.3;
        Thu, 12 Oct 2023 10:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697131319; x=1697736119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mLvXeLnsRUQ3/TUrQnBU04ibB7JIWTVa6JOjlgQ9hVM=;
        b=glp09uPmcs6e231kucILmNnXu5+05D1GU6QVqdGpMqSINIYi8t1QT7FpHwypzLcNKZ
         NWrncl6v1GhJwxpd82r49LHmW2OD2A+WnHWyr0ThWQWl8padmnTqQreBlbDLgKOl/LSK
         ds4+NVnqj694c3Kt7CYJsf2FTkG5hdaH2bmJKVCKVmw056Mbt/lbG74iywcuXaaYeyEY
         k1Pgzk0Y53ugL8QlugK5pU/l06huewn29VNR8vE1OTZzvE7GgGLaBiYmzv2PYUTL8MEr
         JyDXaX3/VisFgfHgP3XQ1+y2BOi6ab3f15eViYNNc+87L4wR+4saghdT7pMe9ADIEE8J
         WJDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697131319; x=1697736119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mLvXeLnsRUQ3/TUrQnBU04ibB7JIWTVa6JOjlgQ9hVM=;
        b=hkuFiwgq4/XERjaclxjdryBGQL2BtJ3WjZAnj3OmXAXvWQs3/AFBRo2Ryw6pfRIQBq
         yYwwMK+HiuEyW+si/TGjegVqjyflKP+KXvq0d8F1xMtnVg6p3UUM62XFyRR69LHW+Wxn
         d1BewWR1gLuHX60zIoaDyFM58K66iMed3xxi3xYP5zy97znru/8SCLmLFyoMkgyBz60q
         79ZGUJRiQUJ0iVUysC8X3OEP3TKf/Rowma5rg/apL55v+UHe+Y2xsKrPp5bj/UmU6j78
         ulk3P3vFflKXMfvsQe6C2dfwd+efHlGkO3f2L7fk5upU2B7hhmabKDFuzZVcJTjn3EWS
         u7hQ==
X-Gm-Message-State: AOJu0YxKNTwJpE9q2nlRvbT2Uyv0pcQvhz8VeNgFh3YLpuINODTek0Mv
        rZPokL1be60KLbcTXNW0j+NRM6a4wYU/9A==
X-Google-Smtp-Source: AGHT+IE2tJWSIJx2OKiUKOKA8OGPuZNoC8ZMOC/9GzKy2gHun+n4J8zu0A2UicwUk/2jPgQyNDrSRw==
X-Received: by 2002:a5e:dd0d:0:b0:786:7100:72de with SMTP id t13-20020a5edd0d000000b00786710072demr25476578iop.16.1697131319452;
        Thu, 12 Oct 2023 10:21:59 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id r25-20020a028819000000b0043cef0711c1sm3992211jai.158.2023.10.12.10.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 10:21:59 -0700 (PDT)
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
Subject: [PATCH v7 12/25] dyndbg: reduce verbose=3 messages in ddebug_add_module
Date:   Thu, 12 Oct 2023 11:21:23 -0600
Message-ID: <20231012172137.3286566-13-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012172137.3286566-1-jim.cromie@gmail.com>
References: <20231012172137.3286566-1-jim.cromie@gmail.com>
MIME-Version: 1.0
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

