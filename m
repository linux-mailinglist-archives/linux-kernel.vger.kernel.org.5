Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B53547C9104
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 00:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbjJMWt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 18:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232559AbjJMWtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 18:49:31 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75C8E1;
        Fri, 13 Oct 2023 15:48:55 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-351208d0d6cso9742015ab.1;
        Fri, 13 Oct 2023 15:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697237333; x=1697842133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wnBLKUk9O3xETUCsilAg0vyOCJCY1VGcTM3FhTYpKWY=;
        b=YlOmx/IozpyFmqd1RSFX3kEdAGMlliZDwHs856e1l0lNFNz27tDfgNhNlcQghn9StU
         BI5/6ian6YEDn1VF6OvrYvGFjP0rpyhC4IeYTskgIpUA0nixDR5ha5m37FHLZmnbqixo
         orfPyBv3gUwPfpI9aUrrPbMbGKveQ7CT5LvWLm5pBL03pvdkOBfRhLPIB2gn+xAvxiFe
         uMHL9ehBiizQKkNV+6FqWuxky2xn579KD/+1vuSaMxqtLYMWq/jncNDKoXfW5X+Z7dq+
         gjFZsnze5NrpXv82N6c0OWgwSkSa3DnU/rzPDj7qr9FTdKZAglFdjuhc+iZ+FeLbcbG0
         itxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697237333; x=1697842133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wnBLKUk9O3xETUCsilAg0vyOCJCY1VGcTM3FhTYpKWY=;
        b=NuhyTnuU1nq5Q06fPv9b4l7JocnSzqq7hy+qTbCZKDqdTiOZNxegMrz9jtQftQA1XF
         GjE7SkeBZVnDmyLQ6P9J2ySJpaRrjQKQgBjB9N7tMJn0fnRz6Z77+cPg+R8VulK2AunJ
         f8j0jUfuYDfJLi4yM5yekswzxvnxflTy+r/9KRRbAen7aDSVNV65m1HE6/Scff8JQdWp
         punNyu6VaiyagEYNZlbjhi4BTuvmMapjVr+jnBIicfimETULC95VfI+QKWkEMxTSpA6P
         0iTK/PecrF1zH6KJbEGSnM8EEyDC4+4aY60Q6KhZxpiOT9kaHs/ccM/Zc1cevOLrzAeo
         R6VA==
X-Gm-Message-State: AOJu0Ywqiwoti1GRaYJWGDOmX4FzOQxG+Dt7XtTb628qUCvZN7igihE/
        u71jRxECMEz8A2lkwwab4p+BtAUGJfadkw==
X-Google-Smtp-Source: AGHT+IHJBnSInwEpEahOM99jH0rsVnEtmw1JeshrZau0+PNtsF/3sESjxbLknd+gDdbfHObZb+ARmg==
X-Received: by 2002:a92:da83:0:b0:357:6e14:835f with SMTP id u3-20020a92da83000000b003576e14835fmr1403410iln.15.1697237333447;
        Fri, 13 Oct 2023 15:48:53 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id t10-20020a92dc0a000000b003512c3e8809sm1683071iln.71.2023.10.13.15.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 15:48:52 -0700 (PDT)
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
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v7b 19/25] dyndbg: reserve flag bit _DPRINTK_FLAGS_PREFIX_CACHED
Date:   Fri, 13 Oct 2023 16:48:11 -0600
Message-ID: <20231013224818.3456409-20-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231013224818.3456409-1-jim.cromie@gmail.com>
References: <20231013224818.3456409-1-jim.cromie@gmail.com>
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

Reserve bit 7 to remember that a pr-debug callsite is/was:
- enabled, with +p
- wants a dynamic-prefix, with one+ of module:function:sourcfile
- was previously called
- was thus saved in the cache. NOT YET.

Its unclear whether any cache fetch would be faster than 2-3 field
fetches, but theres another factor; the 3 columns in the __dyndbg
section are highly redundant and compressible, but to get the
compression, we need field accessors, which will rebalance the
tradeoff.

So, for now, its just the bit reservation.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index f182f95caabb..927cb14f24e0 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -38,6 +38,7 @@ struct _ddebug {
 #define _DPRINTK_FLAGS_INCL_LINENO	(1<<3)
 #define _DPRINTK_FLAGS_INCL_TID		(1<<4)
 #define _DPRINTK_FLAGS_INCL_SOURCENAME	(1<<5)
+#define _DPRINTK_FLAGS_PREFIX_CACHED	(1<<7)
 
 #define _DPRINTK_FLAGS_INCL_ANY		\
 	(_DPRINTK_FLAGS_INCL_MODNAME | _DPRINTK_FLAGS_INCL_FUNCNAME |\
-- 
2.41.0

