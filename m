Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4878D79C9DD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 10:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232637AbjILI1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 04:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232520AbjILI06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 04:26:58 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB1D210D7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 01:26:54 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-401b3ea0656so56425095e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 01:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694507213; x=1695112013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R5ZWDB1FqFuWIcPP5uo4y/kiHrFaFSG3Le/UDhdwTss=;
        b=LisAvLo57XxkUFPNZ04wZ6MVrPqXudZtvjtSSmebJodiaTFUwCreF+EVZRkcusP5LJ
         pr+ZWdEykKIe2tql54QONnaHuWwkaHgJOIMobRS4y5ST4iqm5l12d6Yf0IPOsQHaFqjl
         rXR7cN1chsUosw76CuGoX0dcf8gfTj3GxlNlkpckcYlRMVrOCOqH+RnaaCpqh7q0E4Kv
         iPWdL/HPfJSgCJGbZ78zdAD12UVz506de1+WygNRYgSSmCwSI6hq7hAnMlICA3+BZkzA
         C5pmbCMAdOs9CCsIAKmKsw4IyctPesi0vIwm+O8T6CA8n2YTdV6hCa8/C2w78LsCKz/R
         YuiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694507213; x=1695112013;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R5ZWDB1FqFuWIcPP5uo4y/kiHrFaFSG3Le/UDhdwTss=;
        b=ZDnHvenbr8e47D7t8+zFfI3DY3O9/ERJspnkIipLtxsnKzYw9USGOEsIjw+gUOj7zJ
         672z3KMlxO7XECknFgfKgvEBKZaRFGGAhXTQKY98pBOomN+0YtAUYAMWYKeAKnfH6RDN
         a4rC1wWE021fuKg0Ikb4npsK3Y0G2PWhH7EbFHCXCN9szHgox7sIOsYUfpFZTxvo+Kgo
         Vwi0RUEmMuptps3j0SUBzqJqpfdSvPKvd/vczXVTxCxZFQRA0yj+c3rMSDdavNZ2pPlY
         CjbCX9zS5Qj/1igISQRAMexqHjdOnsxbWG1nLn1T9trYnLFvrpwcurNuQdmoIAPbfYLN
         AOmA==
X-Gm-Message-State: AOJu0YwjcQzdi/SFNlqp5pM3m9k3WaEi/X9EqKsq/wlP2avXB/0weWH6
        R94cCw1XOVOv/qhVqFCqDp003g==
X-Google-Smtp-Source: AGHT+IHBmdgDBl+nMxBfNCjmsLnlBByQvmI+Z+e3WcXEE5tS6wvEsHVVK0U8DjiYci0H1J7C3kZWUQ==
X-Received: by 2002:a05:600c:3b9a:b0:402:f5c4:2e5a with SMTP id n26-20020a05600c3b9a00b00402f5c42e5amr11179870wms.37.1694507212943;
        Tue, 12 Sep 2023 01:26:52 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:907f:4cd7:f0ae:6b2a])
        by smtp.gmail.com with ESMTPSA id e10-20020adf9bca000000b003143cb109d5sm9793110wrc.14.2023.09.12.01.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 01:26:52 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] slab: drop unneeded NULL-pointer check in kfree auto cleanup
Date:   Tue, 12 Sep 2023 10:26:43 +0200
Message-Id: <20230912082643.13144-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

kfree() already accepts and silently ignores NULL-pointers, there's no
need to check it when running the auto cleanup routine.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 include/linux/slab.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 8228d1276a2f..fb709ed506ba 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -228,7 +228,7 @@ void kfree(const void *objp);
 void kfree_sensitive(const void *objp);
 size_t __ksize(const void *objp);
 
-DEFINE_FREE(kfree, void *, if (_T) kfree(_T))
+DEFINE_FREE(kfree, void *, kfree(_T))
 
 /**
  * ksize - Report actual allocation size of associated object
-- 
2.39.2

