Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF02D78149F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 23:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240531AbjHRVPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 17:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240778AbjHRVPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 17:15:42 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89164214
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 14:15:41 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58f9db8bc1dso10135647b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 14:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692393341; x=1692998141;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jem4cROi9qphCIk8SA3V6xQmrxAyRIHLARImADDaneY=;
        b=JDIkLrwOMLZTuos/xJL8m9DbQKbG5PZAeRI5YmFAkVnFqfqKDRmkNWTjR2ydHBchos
         ZwTUsGsPPeler78kiUryIeo+RZX0H/nGn4Wh1lTy4LUyNCGaMaZj2YkkUicNShAMrqN+
         Mle1SCWpxQdxQYeTzmN22S1/kcb2tzw1FzKE+hwzaHLpJGsGK5HJMQOt8sXNOa3NdZr/
         9gJ5cK8ifGCDq0MEuvKm/zb4JSPPMTfG4vX4uWTt7JpEmgL2moGX7M+hCugQqZ70m/nn
         B5bDYj8LHyHcZw0pr5uB7dkV3BuQybQmFnu79C1Kof2qjh71mdNoj20PPf81kF/WAFRU
         m3aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692393341; x=1692998141;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jem4cROi9qphCIk8SA3V6xQmrxAyRIHLARImADDaneY=;
        b=gWBal0mFJk/v5S/8c5nxzaL3vCBsfTA/mku3gMKIGi3A4zTfotThG0u+t+GaH+9DT7
         cxE9tk6gy4C41/CPx1gg+KP04+7CLWXpMkjH/qkR9S6gk+k4y9D+08sTeOXm18I3Q0SK
         hIkpd1GjI8g3pHF2XlSuI5LTgwgbRstFheYybIHYGeKQsrjK3JC5Rj9EMOJgMqMovtvH
         tsAEaRqhkooHr/BxgDhx0wF7CULeWNij0ciCC1HISEyLAb1aqiCS4TFadQFzBN9EkgpM
         PEncPrwDkwOcNyWj7wqtFIRV5pkDtBSOkvOi8l/w7ZdivD1bOqOo4lWdsBs7bk+oO6oH
         RLEg==
X-Gm-Message-State: AOJu0YzZgB96TfuQUPY/cMXGBSj8igw3SLTQN6uMJ3wvrCCnekAi89b6
        OwGx2cvoE57R3cpUCwJ4Sy5jhBgmL69J
X-Google-Smtp-Source: AGHT+IGRa2stsy8QZJfi6RdwZ3CiSQz8GGgelTAbogELSmuy2F7S/d9Slg4Cg25/asaaViD4egyWmEAMAlQi
X-Received: from zokeefe3.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1b6])
 (user=zokeefe job=sendgmr) by 2002:a05:6902:290:b0:d48:c04:f256 with SMTP id
 v16-20020a056902029000b00d480c04f256mr3251ybh.11.1692393341040; Fri, 18 Aug
 2023 14:15:41 -0700 (PDT)
Date:   Fri, 18 Aug 2023 14:15:33 -0700
In-Reply-To: <20230818211533.2523697-1-zokeefe@google.com>
Mime-Version: 1.0
References: <20230818211533.2523697-1-zokeefe@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230818211533.2523697-2-zokeefe@google.com>
Subject: [PATCH v2 2/2] smaps: set THPeligible if file mapping supports large folios
From:   "Zach O'Keefe" <zokeefe@google.com>
To:     linux-mm@kvack.org, Yang Shi <shy828301@gmail.com>
Cc:     linux-kernel@vger.kernel.org, "Zach O'Keefe" <zokeefe@google.com>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

File-backed memory can be backed by THPs either through collapse, when
CONFIG_READ_ONLY_THP_FOR_FS is enabled, or through fault, when the
filesystem supports large folio mappings.

Currently, smaps only knows about the former, so teach it about the
latter.

Signed-off-by: Zach O'Keefe <zokeefe@google.com>
Cc: Matthew Wilcox <willy@infradead.org>
---
 mm/huge_memory.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index cd379b2c077b..d8d6e83820f3 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -136,7 +136,16 @@ bool hugepage_vma_check(struct vm_area_struct *vma, unsigned long vm_flags,
 			 */
 			!!vma->vm_ops->huge_fault :
 			/* Only regular file is valid in collapse path */
-			file_thp_enabled(vma);
+			file_thp_enabled(vma) ||
+			 /*
+			  * THPeligible bit of smaps should surface the
+			  * possibility of THP through fault if the filesystem
+			  * supports it.  We don't check this in fault path,
+			  * because we want to fallback to the actual ->fault()
+			  * handler to make the decision.
+			  */
+			 (smaps && vma->vm_file &&
+			 mapping_large_folio_support(vma->vm_file->f_mapping));
 
 	if (vma_is_temporary_stack(vma))
 		return false;
-- 
2.42.0.rc1.204.g551eb34607-goog

