Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8C57528E0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 18:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234491AbjGMQid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 12:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234941AbjGMQhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 12:37:24 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750262D46;
        Thu, 13 Jul 2023 09:37:04 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-346541baf2aso5038165ab.1;
        Thu, 13 Jul 2023 09:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689266223; x=1691858223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xtXcwS8d/IDIwtZ853/2GI+9Fn3yNRgVoZNcTx+O3Ew=;
        b=HlYsuUhPgjpXCZ9henX1PDwU0cw3h2N3V5/vsfI3JqIAfhpOmkW+trSjYWT65U3nyC
         jLebmc9PX5LkHYZtGISPEwFqP511fRUaV3p126UUUQ12cEoisYsRB0Ai0IFMoK/o+Zno
         rGguAhVV1T0Xtt56BsYcD8yFiSs4AzNYqyvja+HjPwA8MdQrfo408bDsxt9OJHXJyZ3y
         NcJt4Mr3dq/irqiTKq+AH7wN/d04UujVFnf3InP9dyq90JzGLKhF4XgF3DEE6WUMuJvX
         hlybq+IReegFZ0TKYVW5nMEdCMyQ4uQvKHiCH6vc07xhaWaOnWfaVWviGizRleqeG3TT
         UVIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689266223; x=1691858223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xtXcwS8d/IDIwtZ853/2GI+9Fn3yNRgVoZNcTx+O3Ew=;
        b=S7PhbR/FylssW1zOHKmrzmEdu8gzszsKLlzwHCGhcrwcUVNQ5xHRj10+tZPcKd96mq
         tvVf89jiYsRrOVDvXC1BdfqQVQRyI89a44U8e4YSCeqpWKoI/n1xalzN9wi+rUfVQKwd
         afhwbwChEvxU9BesX2wjxfgKTbg263APmppCZS1BZoRtbF+my2BDI+ELNbkRMAkzsbp4
         xQqeDORk3GRRsxpfS9h+m99NxLp1HWbFi9fsmM4Pj3dfrsynQpdOvvJnIrJsbFpFGlOU
         9yd6PucrNBIxCujFf2qOVkpaAMESDGapuWUy8E8JmKvW4xMkVtUnFwDWTB561m4NsT3f
         cklA==
X-Gm-Message-State: ABy/qLY3x5S1WpyNhCatNgX9ZoI0fvP2q5MFd6cE82nNYkUzSxlJz1Oh
        nQBDxot9depOUV7aDXT7uuw=
X-Google-Smtp-Source: APBJJlGKK8QkvWwdEzHjGRc5A1ATdY9Dfw8qrHFYEawb7ulcwGWCKqqAd0Mg8QH2SMEdwJLdP2dZ3w==
X-Received: by 2002:a92:6c0f:0:b0:346:7fc:4fb8 with SMTP id h15-20020a926c0f000000b0034607fc4fb8mr122786ilc.1.1689266223658;
        Thu, 13 Jul 2023 09:37:03 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id s7-20020a92d907000000b00345950d7e94sm2147571iln.20.2023.07.13.09.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 09:37:03 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, daniel.vetter@ffwll.ch,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     jani.nikula@intel.com, ville.syrjala@linux.intel.com,
        seanpaul@chromium.org, robdclark@gmail.com,
        gregkh@linuxfoundation.org, Jim Cromie <jim.cromie@gmail.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-sparse@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH v4 18/21] compiler.h: RFC - s/__LINE__/__COUNTER__/ in __UNIQUE_ID fallback
Date:   Thu, 13 Jul 2023 10:36:23 -0600
Message-ID: <20230713163626.31338-19-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230713163626.31338-1-jim.cromie@gmail.com>
References: <20230713163626.31338-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We currently have 3 defns for __UNIQUE_ID(); gcc and clang are using
__COUNTER__ for real uniqueness, 3rd just uses __LINE__, which should
fail on this (and harder to avoid situations):

  DECLARE_FOO(); DECLARE_FOO();

Its 2023, can we haz a no-fallback __UNIQUE_ID ?

NOTE:

This also changes __UNIQUE_ID_ to _kaUID_.  Ive been getting
lkp-reports of collisions on names which should be unique; this
shouldnt happen on gcc & clang, but does on some older ones, on some
platforms, on some allyes & rand-configs.  Like this:

mips64-linux-ld:
drivers/gpu/drm/display/drm_dp_helper.o:(__dyndbg_class_users+0x0):
multiple definition of `__UNIQUE_ID_ddebug_class_user405';
drivers/gpu/drm/drm_gem_shmem_helper.o:(__dyndbg_class_users+0x0):
first defined here

Like above, the collision reports appear to always be 3-digit
counters, which look like line-numbers.  Changing to _kaUID_ in this
defn should make it more obvious (in *.i file) when a fallback has
happened.  To be clear, I havent seen it yet.  Nor have I seen the
multiple-defn problem above since adding this patch.

Lets see what lkp-robot says about this.

CC: Luc Van Oostenryck <luc.vanoostenryck@gmail.com> (maintainer:SPARSE CHECKER)
CC: Nathan Chancellor <nathan@kernel.org> (supporter:CLANG/LLVM BUILD SUPPORT)
CC: Nick Desaulniers <ndesaulniers@google.com> (supporter:CLANG/LLVM BUILD SUPPORT)
CC: Tom Rix <trix@redhat.com> (reviewer:CLANG/LLVM BUILD SUPPORT)
CC: linux-sparse@vger.kernel.org (open list:SPARSE CHECKER)
CC: linux-kernel@vger.kernel.org (open list)
CC: llvm@lists.linux.dev (open list:CLANG/LLVM BUILD SUPPORT)
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/compiler.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index d7779a18b24f..677d6c47cd9e 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -177,9 +177,9 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 	__asm__ ("" : "=r" (var) : "0" (var))
 #endif
 
-/* Not-quite-unique ID. */
+/* JFTI: to fix Not-quite-unique ID */
 #ifndef __UNIQUE_ID
-# define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __LINE__)
+# define __UNIQUE_ID(prefix) __PASTE(__PASTE(_kaUID_, prefix), __COUNTER__)
 #endif
 
 /**
-- 
2.41.0

