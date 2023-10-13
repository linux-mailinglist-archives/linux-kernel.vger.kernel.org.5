Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84CE17C8572
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 14:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbjJMMOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 08:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbjJMMOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 08:14:04 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3911BBD
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 05:14:03 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c9d132d92cso5612825ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 05:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697199242; x=1697804042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X4z+hjgZoqLiz+otFUtzfcX1EPVHUCZR+4Ag5x9f1fQ=;
        b=TvxZdjPP1S4lzY1RK+OoFohvLhNRZEFKdidXfK0oKNMREN6Uywy0rt9hNyVQjGBLuT
         dCe8/xP1OZidNdiegunFjo8UkO5NiIi/WcG+QA+GaJDFa3cGlCPeDvyWDrbMfntN8dfP
         ilPyxMPxJ/EjCd3o4SQxtaHEF4NA9o5PUolsfko+CMJ9LM079z6BSk/t3GDey3wLn0bt
         Fb3Tbx/8jFoFdga1F8UgBqy7vDvGirimqPxFgSXw3E5ZcJSzh/EgaMYCm9N65x7fXbjP
         ++EHJCoSUYUj/xm7S8tYwpNYZp2vx8D6YYq9cdsToOBGp9/cGGqJYVGVgIJyB+pQsL0w
         rVZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697199242; x=1697804042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X4z+hjgZoqLiz+otFUtzfcX1EPVHUCZR+4Ag5x9f1fQ=;
        b=pr1UB01SMJSCzgqPyNBzPQH99HmfUD3LU3iIre8k+a/xuxsOp5/8eVz6q12tuoIghj
         naeMU/T6Vcm8/lRUUotHNs2zlKmhwtLzNE7z6F4JP15gOfRtWafPk0Xz1wZMj9Ngk3uY
         vl9yx1JiZlPJWE8Wmj53PoTi3+WKqScSjrkvGieJ6b8wm/CIr45hvXsXdYCn2LmKtLVI
         BSgpHoE/b36TM4aitkiBibU3t7l5y2qY8zd+vQgOU3/oaOroQ3L9ojM4skgvFRrCyiH4
         indoGmRnjWOKHVybu4tH7QHY/NVEIoQSUTvyPBceOsuFArgclzGieKTAwaFWQH+itdGC
         +RZQ==
X-Gm-Message-State: AOJu0Yyq7F4KE4m5Guk4NG6cJwnwT6OmICLFbzYZyunQ045KEg07rkNW
        UBlDZaggrQqKrUWUqSRougo=
X-Google-Smtp-Source: AGHT+IEvL0BqKkBivK2O51JqvuzsTo5t+dd4ijMHTK++9Mpa1lZpCfypvnqQ5IeTEfD71vwd34Eezw==
X-Received: by 2002:a17:902:ce84:b0:1c6:9312:187 with SMTP id f4-20020a170902ce8400b001c693120187mr29212356plg.3.1697199242587;
        Fri, 13 Oct 2023 05:14:02 -0700 (PDT)
Received: from localhost.localdomain ([140.116.154.65])
        by smtp.gmail.com with ESMTPSA id ja20-20020a170902efd400b001c1f4edfb9csm3747683plb.173.2023.10.13.05.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 05:14:01 -0700 (PDT)
From:   Kuan-Wei Chiu <visitorckw@gmail.com>
To:     ville.syrjala@linux.intel.com, zhenyuw@linux.intel.com,
        zhi.a.wang@intel.com
Cc:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        airlied@gmail.com, daniel@ffwll.ch,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v2] drm/i915/gvt: Optimize mmio_offset_compare() for efficiency
Date:   Fri, 13 Oct 2023 20:13:55 +0800
Message-Id: <20231013121355.2125824-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ZSkdoVcMxKIbXUOW@intel.com>
References: <ZSkdoVcMxKIbXUOW@intel.com>
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

The original code used conditional branching in the mmio_offset_compare
function to compare two values and return -1, 1, or 0 based on the
result. However, the list_sort comparison function only needs results
<0, >0, or =0. This patch optimizes the code to make the comparison
branchless, improving efficiency and reducing code size. This change
reduces the number of comparison operations from 1-2 to a single
subtraction operation, thereby saving the number of instructions.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
v1 -> v2:
- Add explicit type cast in case the sizes of u32 and int differ.

 drivers/gpu/drm/i915/gvt/debugfs.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/debugfs.c b/drivers/gpu/drm/i915/gvt/debugfs.c
index baccbf1761b7..d85d8a3b5ae5 100644
--- a/drivers/gpu/drm/i915/gvt/debugfs.c
+++ b/drivers/gpu/drm/i915/gvt/debugfs.c
@@ -48,11 +48,7 @@ static int mmio_offset_compare(void *priv,
 
 	ma = container_of(a, struct diff_mmio, node);
 	mb = container_of(b, struct diff_mmio, node);
-	if (ma->offset < mb->offset)
-		return -1;
-	else if (ma->offset > mb->offset)
-		return 1;
-	return 0;
+	return (int)ma->offset - (int)mb->offset;
 }
 
 static inline int mmio_diff_handler(struct intel_gvt *gvt,
-- 
2.25.1

