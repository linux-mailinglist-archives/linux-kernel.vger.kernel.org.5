Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A223C79C306
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239149AbjILCeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239323AbjILCeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:34:06 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506C989A96;
        Mon, 11 Sep 2023 16:10:44 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-79536bc6697so181327839f.1;
        Mon, 11 Sep 2023 16:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694473746; x=1695078546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ESkE1bZNfU1HWAKelmlyxfVO/PhQytfAXhWjbkh3sXk=;
        b=Lcjj5t0jnyL1eJYPppc/vIAmycCSJaxf2llQpcpyHfWJ94OcmpNlA6vCAdW3rWj4za
         H6ql6yiPFYV0tF+aKqeJCuJaynXZs7Uca+2Hy5rbiW/t5s3ECXygnkiRKEFurUtXYJ+H
         3ltRwRTp/ZBHYbsd2wG5OxmJvxOUz850ef7Vj9Zm54Nk1ybtgaecHGb/ERr76Ai8HZfe
         3BntSBWn7IugX8H6yvMttDV9Qy+kCe8+0Rj2NhpxS5kJr3bsp+MOsvc5mzWSM0QzijT5
         oy3bQGrnq4AcdOb+3XXBGKBpEc4Jh61YP4idJkNEIKbCqV4vxU94UCELLKOxnrzm0IuT
         AlcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694473746; x=1695078546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ESkE1bZNfU1HWAKelmlyxfVO/PhQytfAXhWjbkh3sXk=;
        b=gdrR4WU/24L3gJ94tQOEV3tSX8rKFNxRhIPnHt8o7JmoXITY5kWba5v5opz4ixTyxJ
         5PUu5W9fdjrXP3mEmdEQJg9xz8VBzyi5K7lxnkqygoGuGDhTyGL8HW6tJZ08QvpkhmN0
         AF6zGfdSBWBBZRo3e+c/V150Q4XtorlC2suL59FVZWZ1hJ8cb7Nv31ZCDtpMoiDkN00i
         2w9gAOJwmIuM0CaFOvtq0qAWVoqZCPJ0z7KGOnDcWRioY8a3JyIaxMb2auSKwjDxKuYG
         ZJTOCarwMVZGKENojw5MsD6F2bS8ZzSwRjQuB6jG54R24SgnzXM+kLB2gVf8cyGg2HID
         Nq+Q==
X-Gm-Message-State: AOJu0Yzmp6yna0yNr6gf2iH/foCer524FjFBzwouOxzJ0sMY7E4W3VDj
        uCe4PiB6D3zzkCe+9i7DTPw=
X-Google-Smtp-Source: AGHT+IHNuCLf8PX+N8HFzY2KIxhpLtrrXX7XbHvVmw+f5uCzl6ZDWoiAWyY7Py4er03hU5zXqdzM6g==
X-Received: by 2002:a05:6e02:1bae:b0:34c:c8e8:ca87 with SMTP id n14-20020a056e021bae00b0034cc8e8ca87mr14120307ili.20.1694473746384;
        Mon, 11 Sep 2023 16:09:06 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id z4-20020a029f04000000b00423240c7296sm2512607jal.69.2023.09.11.16.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 16:09:06 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org, mcgrof@kernel.org,
        daniel.vetter@ffwll.ch
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, jani.nikula@intel.com,
        ville.syrjala@linux.intel.com, seanpaul@chromium.org,
        robdclark@gmail.com, linux-doc@vger.kernel.org,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v6 19/22] dyndbg: add _DPRINTK_FLAGS_INCL_LOOKUP
Date:   Mon, 11 Sep 2023 17:08:35 -0600
Message-ID: <20230911230838.14461-20-jim.cromie@gmail.com>
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

dyndbg's dynamic prefixing (by +tmfsl flags) is needlessly expensive.

When an enabled (with +p) pr_debug is called, _DPRINTK_FLAGS_INCL_ANY
prefix decorations are sprintf'd into stack-mem for every call.

This string (or part of it) could be cached once its 1st generated,
and retreived thereafter, as long as its deleted any time the
callsite's flags are changed afterwards.

So consider the prefix/decoration flags: 'tmfsl', and what should be
in the cache:

-t  thread-id. not part of the "callsite" info, derived from current.
    doesnt belong in the cache. it would be wrong.
    can be done in outer: dynamic_emit_prefix()

-l  line number
    this could be part of the prefix, but would bloat the cache
    can also be done in outer: dynamic_emit_prefix()

-mfs  module, function, source-file
    we cache these, composed into a sub-string.
    they are "lookups", currently to descriptor fields,
    could be accessor macros to "compressed" tables.
    cache saves more access work.

All enabled together, they compose a prefix string like:

  # outer   -----inner----------   outer
  "[tid] module:function:sourcfile:line: "

So this patch extracts _DPRINTK_FLAGS_INCL_LOOKUP macro out of
_DPRINTK_FLAGS_INCL_ANY macro, then redefs latter.

Next re-refactor dynamic_emit_prefix inner/outer fns accordingly.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index bdb0d12b13ec..c5609560ca1b 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -40,10 +40,12 @@ struct _ddebug {
 #define _DPRINTK_FLAGS_INCL_SOURCENAME	(1<<5)
 #define _DPRINTK_FLAGS_PREFIX_CACHED	(1<<7)
 
-#define _DPRINTK_FLAGS_INCL_ANY		\
-	(_DPRINTK_FLAGS_INCL_MODNAME | _DPRINTK_FLAGS_INCL_FUNCNAME |\
-	 _DPRINTK_FLAGS_INCL_LINENO  | _DPRINTK_FLAGS_INCL_TID |\
+#define _DPRINTK_FLAGS_INCL_LOOKUP					\
+	(_DPRINTK_FLAGS_INCL_MODNAME | _DPRINTK_FLAGS_INCL_FUNCNAME |	\
 	 _DPRINTK_FLAGS_INCL_SOURCENAME)
+#define _DPRINTK_FLAGS_INCL_ANY						\
+	(_DPRINTK_FLAGS_INCL_LINENO | _DPRINTK_FLAGS_INCL_TID |		\
+	 _DPRINTK_FLAGS_INCL_LOOKUP)
 
 #if defined DEBUG
 #define _DPRINTK_FLAGS_DEFAULT _DPRINTK_FLAGS_PRINT
-- 
2.41.0

