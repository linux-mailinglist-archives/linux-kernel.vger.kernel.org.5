Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5A17DDA3D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 01:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377104AbjKAA1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 20:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377002AbjKAA1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 20:27:09 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C4B181;
        Tue, 31 Oct 2023 17:26:45 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-35748b32d73so24405625ab.0;
        Tue, 31 Oct 2023 17:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698798404; x=1699403204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2r2Xy/LUqkHG59xFuO4NDcaCnT0VxXpDLDYMeh9aWn8=;
        b=KnrlPxece63xyuOBMNnRrJlBakMju0SrdFkUX+M/brEvV95/IEJb9T6qSI5XzExH9V
         zah0eI3kHAkUCToYQxm3jOZ+2wjbbdwL4Q4RAQMfKsxZsnvse8dMO7Otv0PN4Jk8aRIm
         VdxbnFqrPMCQOv9DFJHWKWD25o0fk/5SqH6uAXsrlabvkl6oicK4DvCpK9yZEPWdszzj
         BNjaBqhtZQEAnopK8gTwn9JUguKEdtEWmoW7t+45qzVINWRPjVEBU0RYJf2oGtCSy4h7
         nmWQI+uQh89wnjD0pL7/gJ1PE3qpG6M8dzaZ+ymifTnkv3KL8EgVVxPPwQTT9Qr5KPx0
         Rl1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698798404; x=1699403204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2r2Xy/LUqkHG59xFuO4NDcaCnT0VxXpDLDYMeh9aWn8=;
        b=D3IMorvhrzvKsGpzA3BLYDDRGRNN4JiT5BWLWR1bJFFtUBf1puKOgdpkcoplOShxV1
         rbdsNYXmUmhK/CVul7m+aFSSUknm8s2J5YNaivA7szK4Bxv3ldGInUAUuYmdy6gBIID0
         RVWdaaWJ9DNHdgCOknCVvwaFxpBAXU1j5IVDmkLEHmqttAIQ28BqWW0EGOct+cExFSL5
         caC1AkngHkADwIfydOk1SB/1/ZdyTx5mU3Gq/vdzs4Jf26H48IL8kzBu8GaLSDKV39yn
         Fr6tTnY6/d2uF25W345kocQ5LyD5apUjyIsHJXhJGCah46Szd/WoK6itw4AHp8ELk385
         GmLg==
X-Gm-Message-State: AOJu0Yxi4cPFosrExCaX34j0cy3+O7HQrKb0oluXds8oB3JFe002c6Xq
        sVVxRI9YdbXxzybGSRE4ieXrq2I8aY1oNg==
X-Google-Smtp-Source: AGHT+IFJ+EO25MFzuh5tK6lN7VgLWzxSfGJvEw3xuzQxhOciZy5mpoFNsIJKMGKNq9pPh0T4ilf3hg==
X-Received: by 2002:a05:6e02:330d:b0:359:3754:e6bb with SMTP id bm13-20020a056e02330d00b003593754e6bbmr3823026ilb.21.1698798404300;
        Tue, 31 Oct 2023 17:26:44 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id t1-20020a92c901000000b00357cc8df1d5sm141701ilp.68.2023.10.31.17.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 17:26:43 -0700 (PDT)
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
Subject: [PATCH v7d 19/23] dyndbg: add _DPRINTK_FLAGS_INCL_LOOKUP
Date:   Tue, 31 Oct 2023 18:26:05 -0600
Message-ID: <20231101002609.3533731-20-jim.cromie@gmail.com>
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

dyndbg's dynamic prefixing (by +tmfsl flags) is needlessly expensive.

When an enabled (with +p) pr_debug is called, _DPRINTK_FLAGS_INCL_ANY
prefix decorations are sprintf'd into stack-mem for every call.

This string (or part of it) could be cached once its 1st generated,
and retrieved thereafter, as long as its deleted any time the
callsite's flags are changed afterwards.

So consider the prefix/decoration flags: 'tmfsl', and what should be
in the cache:

-t  thread-id. not part of the "callsite" info, derived from current.
    doesn't belong in the cache. it would be wrong.
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
index 4ffddf5e9152..b4550f80cfd5 100644
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

