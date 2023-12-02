Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB15D801EA5
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 22:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbjLBVWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 16:22:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbjLBVWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 16:22:17 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1EAB185
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 13:22:22 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6d8750718adso857622a34.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Dec 2023 13:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701552142; x=1702156942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gj+Y/6VXeJ+r0pgecRkRsTt5zcHlqOxutguYUyMKTVU=;
        b=gr2teot24exISStimGuA6uwZHfe8C8GO9of9Yown0wbJwWfmsXN0HEm+HMYnJHXR0K
         9BPA7IobVYUOiNHw64fjIRcAzthG9Yf1rAUaizoN6bbILac2nvdeQFcPYTv/SDRcrsMc
         aFZviUgx0jG0xlgyeAFQpuaji9Z8HASRtWgFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701552142; x=1702156942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gj+Y/6VXeJ+r0pgecRkRsTt5zcHlqOxutguYUyMKTVU=;
        b=EoQd9olEzaoVLGsKw7FOpT4dBXkHjJu/Uqpb9CXNBflEWmOSlXoYy9xejbODMatSkG
         fYQSjvs7HUPepiq+lZcPgqBZzioOVFGrLqg2zpGlHWAXOjK4mfWRC614JiiuANqf2T19
         xnMryRaEIopMYcPSbJL5/nye5JwxxFUjBrgRepwX3vj9H9N+eztjF31WLPJkQdVdXlTp
         KD7G08bZn/6rltFTQZvGR29pN6guQz56iwsnEm6KN8Q6ANU0b7PAPnq0sxTmQKLMRhN8
         7r1qhhfuWROHK+gP8tbiVME/6hIujQc1C3HnFXrKAUT50slAkfzRviah67k77PygHupx
         NSHw==
X-Gm-Message-State: AOJu0Yy8PN7KgyD4jXtlYXxaNkgXRQnzGha0VF8Ts/8TB0V6JJ97pLrL
        GnGFexaNpeiobn7R5S9S+cACxw==
X-Google-Smtp-Source: AGHT+IHI/l9YXsb8W4D5DKnvxPxPdidKCGMOauTa2UvDzy+vvVxKcKISva6dGT2AXfYPWma8tUjI+A==
X-Received: by 2002:a05:6808:309c:b0:3b8:b063:6b8d with SMTP id bl28-20020a056808309c00b003b8b0636b8dmr1923224oib.60.1701552142290;
        Sat, 02 Dec 2023 13:22:22 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p10-20020a17090a930a00b002867594de40sm1351802pjo.14.2023.12.02.13.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 13:22:18 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>,
        linux-hardening@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/5] pstore: inode: Convert kfree() usage to __free(kfree)
Date:   Sat,  2 Dec 2023 13:22:11 -0800
Message-Id: <20231202212217.243710-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231202211535.work.571-kees@kernel.org>
References: <20231202211535.work.571-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1508; i=keescook@chromium.org;
 h=from:subject; bh=FqMfSJ9tnf+E4NKsMDABD4Hv9XWcLEDAeeuD1HVeW1g=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBla6AGUcAUjxMoJ6U4X0vLxi+fYt1AWVqAhC5g3
 8R9qQmTZrCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZWugBgAKCRCJcvTf3G3A
 JqoTD/sEQ48wmQkFhwAOp4TsKfq+vZmWkT5yfGDyxOQ2ucZIBmBzGRljVmzMiuznpXr3hR6RMn6
 CI5L7iPa+hQEPuuIdH4ULzOkZKlNGhNWGY6qT/NysWagTanA2+tPygJoTDa3shFPV8Qg/ktXOmA
 EzaYBnYM32d95qHxY+O7UzeQQHZ+L8mW0w+7Pi4LnpbaEdoxc66d/yrcVqkNxC51p/VeozU/deM
 rk5C2MNd7/VwWxOqHlp1SIiA899X4IXHIaMopuLi/lfj5TGjWQYSw89mtkk3p/zmCoxe0za6uqJ
 5EkmLzOEZ5XC2P4LS/bWhBwNEzOv4Jy7tDzYhbi37IkEM5XnLTEoVRCAB66Swzv/2WOGDhqh3rK
 IWicrRHiv496Kk7nhiqTyyIQ7vTvoRxCEcarCa+abBlzBe1hcVZa3QWkzGBJyXCYxo8Eqh+vspr
 9GNiGEtp4IHwd4bDA7xIm+m36TXHvQTk31FKlch+AdsiZpHPZwxRZ7uslC2pmtV8uCcqoa+MEOQ
 HeLGQpB9Lheyc3q0B2RPlcqX4RCXu1MzGSJV446zBw7SUb5C/OD4rMGYlzWCHvuMwBVo9ScPTLY
 Yvnc9q7XkjLRd9JF0+Bf3QSnvRXDIn8bk1Sv2zb2M11q84weUwdkEaxXXSh3/8kBccf3Vc0s6fO bwrQdBKoi0BSe6w==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mostly as an example to myself, replace a simple allocation pattern with
the automatic kfree cleanup features now exposed by cleanup.h.

Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/pstore/inode.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
index d41c20d1b5e8..20f3452c8196 100644
--- a/fs/pstore/inode.c
+++ b/fs/pstore/inode.c
@@ -23,6 +23,7 @@
 #include <linux/pstore.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
+#include <linux/cleanup.h>
 
 #include "internal.h"
 
@@ -64,7 +65,7 @@ static void free_pstore_private(struct pstore_private *private)
 static void *pstore_ftrace_seq_start(struct seq_file *s, loff_t *pos)
 {
 	struct pstore_private *ps = s->private;
-	struct pstore_ftrace_seq_data *data;
+	struct pstore_ftrace_seq_data *data __free(kfree) = NULL;
 
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data)
@@ -72,13 +73,10 @@ static void *pstore_ftrace_seq_start(struct seq_file *s, loff_t *pos)
 
 	data->off = ps->total_size % REC_SIZE;
 	data->off += *pos * REC_SIZE;
-	if (data->off + REC_SIZE > ps->total_size) {
-		kfree(data);
+	if (data->off + REC_SIZE > ps->total_size)
 		return NULL;
-	}
-
-	return data;
 
+	return_ptr(data);
 }
 
 static void pstore_ftrace_seq_stop(struct seq_file *s, void *v)
-- 
2.34.1

