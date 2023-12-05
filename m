Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4BAE805DAE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 19:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbjLES0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 13:26:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346164AbjLES0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 13:26:22 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195B1AC
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 10:26:28 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1d04d286bc0so27672605ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 10:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701800787; x=1702405587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gj+Y/6VXeJ+r0pgecRkRsTt5zcHlqOxutguYUyMKTVU=;
        b=D20vB1XU6llsWmRtYeRb+7tHyyu03VkhL4zTEBRbYPx3qnUQ6kXjgv1j5jPc4T0PK8
         6HVDbi73p0GTLNlU79dknLYL8pZ3aeo31e2k7XyQowrU4MfkkHrJq0zJ4DPpkF6Gn/5j
         GniI1EAPn4ZeArqCsLQUBpCelH8gXtnw0IGEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701800787; x=1702405587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gj+Y/6VXeJ+r0pgecRkRsTt5zcHlqOxutguYUyMKTVU=;
        b=iRAXEinB+d+xSnjoeynMFXe9UONjjkyL/fLi/wYxUlEk+W/75Et2p3x5v+WhDCZaNl
         gOQZlLtVrILgtzYRCRBsXqzv8ghnASWlOUNArV+ibbzBEYUsxfyedgMMyxHVdmX8j0Hw
         XrqNPC7lhxl+YhDKFSGL/Vm8gUrLN67ZkdSHfx/ik1TBmSdt2cHc8yLLqRXD9CaeOh0t
         SIsPxs5dyuckMFyZ/kubF5WXCT/Oh1vzPe++7ESqE3Ue6YcFc3o8S0aY5V8szmDyaAiW
         qVns1kMJAuaws+buyl8rN6yYlhJ9KeIJr8ysCa8x1k92s6AgDFMg1tsmmMB4OnVKeDCz
         Dm4g==
X-Gm-Message-State: AOJu0Yw+eHV1u2LZzpV8PmWRIlYFfbUPRnyEjw8ubw09pR7RrcAnfAel
        Wn7g/NCbcbBE4gnjca+V1UBh6Q==
X-Google-Smtp-Source: AGHT+IH2Uowmzrvs0/hFAJeLe2bBRPGCrI+wFvyd3EPO+VDeMZnOhPy9LvBZ3OyihXLzXpiRCc2yuQ==
X-Received: by 2002:a17:903:22d1:b0:1d0:83bc:5649 with SMTP id y17-20020a17090322d100b001d083bc5649mr3507541plg.33.1701800787406;
        Tue, 05 Dec 2023 10:26:27 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q1-20020a17090311c100b001cfc9c926b7sm6932210plh.75.2023.12.05.10.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 10:26:23 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] pstore: inode: Convert kfree() usage to __free(kfree)
Date:   Tue,  5 Dec 2023 10:26:14 -0800
Message-Id: <20231205182622.1329923-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231205175449.work.110-kees@kernel.org>
References: <20231205175449.work.110-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1508; i=keescook@chromium.org;
 h=from:subject; bh=FqMfSJ9tnf+E4NKsMDABD4Hv9XWcLEDAeeuD1HVeW1g=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlb2tIUcAUjxMoJ6U4X0vLxi+fYt1AWVqAhC5g3
 8R9qQmTZrCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZW9rSAAKCRCJcvTf3G3A
 JjghD/wIsxOIyOzMtLfhNlUVRahUTySDQm9IoANjLGPQpTM0t1M8cwKeOjqfoL6alstZ4SNMEtX
 aJRZ28bbOztu6npnVmPlUtnUB4WVY2Bz7k4tpXjWx33VDzP5Z0HTcofBhJHGnv6441jMZIoBxdq
 kJOTFjwX9aMXL04GktAdix5olQ9MlRXUPPfBVITMabidz3zl4uWgxPYLOJvTdVdHHX+6iFdvyAQ
 u2csi5n6tzxerwZgHQDP7ETWPo61URuwGJcVZBxrCZ9VC+NrvOwx7aawthLBtWuF43TkpD2tguH
 ZgLJp7jma2D7WzIsJLrYSWrTlABHt1mACNT/u4FPIYsY/VA/Xk9j36ks1rKr+SqGRA4cWfIEYbw
 Ak40uD77bKYKRhdToOqk2W9Zt9cAR/QGCniYHsGveA958RkKZbkvm8zRmlrdnnhDeq2Pryyrcwe
 ExJAhOk1Y3nGeKC82pXbWX7lBazYlywHADTscKEz5hedwrJp0URz8E9ZWnfvXzh+lOGzE4zGm3a
 4usnTUGodSc8P2ax00DqkMuGzVUfZScxELHGfdki5KoeeigEQNKF0DAE54BJTMEIYnq8Ul1EoJH
 Ajo4h7C54I3kOS5qQ6clsgyIDejsoQQWoMRRW1JkkuTcDVRO2xHlIBrPN/bJIronulIZcSob3xZ ZlAj3lFpzoj3VkA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

