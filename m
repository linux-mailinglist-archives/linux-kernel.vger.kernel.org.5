Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 105EE77FF76
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 23:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355142AbjHQVDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 17:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355172AbjHQVDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 17:03:32 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4923589
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 14:03:30 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-68872cadc7cso220501b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 14:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692306210; x=1692911010;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NfS80rdvjC+m6qhv52KISAltR5va/tDpeHzyoanDsI0=;
        b=FJas0+eST4okoJWSS6RCysgzg0fj3Loq6oDvOWc5CflQR7vp4NV1eLXMiDj/Cowb/H
         HS7iDE50P0Yde3sKbLCCdVvBXyRFl3mkJvtxNUZDyu80DyJ9KSfxeaOxEA5qxjX7Cx62
         xpgQqZ7G+G2Fa9JikL2tz/BxgZiYAI1k+2plE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692306210; x=1692911010;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NfS80rdvjC+m6qhv52KISAltR5va/tDpeHzyoanDsI0=;
        b=gvbRswRjBk6UUTyCyL+fHHpim3brznVeAxZ8K09yg8QXvL8eBDh6lDHJGEH35kHOjX
         jUe/B7KBO/FKjBJ2S6z6Omozkg3PtexiK6RFcn7OyYl/ZbaK3W5yYkwKamtZ1FGupyL3
         SZw4yqZZ8X+5sioaYUf5VIIuj1pwFOoDaEHndkaKq8btnbsQ+4e7gkKx8tp/4lMIQKHH
         gc0WyXM13Y6QVTrvsophh/gy3sVcbg2B5SjeILKyU01WVPJtUxC1LIIBm1NbD9hRx2Oc
         J02tLmdVvwINWtgbcEw7VvVcrs4KAIu9pjK3GmuAeRhENrR9G9mKhtuv3xt/9dMVFvNl
         KFtw==
X-Gm-Message-State: AOJu0Yxf6idsR556hK9au9S1Bx8Iy1Cedd4nSjbT5G7LQJSQ95e41VWB
        sH/Rsl6Iv0y3xo5MqkNBHYaojA==
X-Google-Smtp-Source: AGHT+IEO4gNnhl2ooknWaiN5W0VRAo8Ktjbq9t5NGymGilNuMderwFfgK5JuIgY4Q1yxZVS57mollw==
X-Received: by 2002:a05:6a00:198a:b0:668:753a:b150 with SMTP id d10-20020a056a00198a00b00668753ab150mr731267pfl.21.1692306210065;
        Thu, 17 Aug 2023 14:03:30 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q13-20020a62e10d000000b00686236718d8sm197124pfh.41.2023.08.17.14.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 14:03:29 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] integrity: Annotate struct ima_rule_opt_list with __counted_by
Date:   Thu, 17 Aug 2023 14:03:28 -0700
Message-Id: <20230817210327.never.598-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1990; i=keescook@chromium.org;
 h=from:subject:message-id; bh=GpbrBY44rmYcaNwTehqSCUt4o0snmReubO2vlJQen7s=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBk3osgscS9wZD5eGd/OmyOJlzZSsaXAhrsROadk
 3Ql7xKO5s6JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZN6LIAAKCRCJcvTf3G3A
 JpgXD/0YjyTzVbKewZU7aUBPJkZCjNbwow0h2y1LaMuBfC4U+6szREmOA8cyvDv65uQQGBEuNZg
 39HLyihd+pROrxzk5nZvlfVzu2fisWM/0SOlp/UlrCrPju0kRP2Q5/6g/IIB0/Af/ynX1HRWjW3
 PMp5u87eXsm6WN+ed5WeBqSc+Se32bYnpLE3hTLg1FbF5w4ip3qtDajbk6103cj1zzXonqirm9q
 AISgJudGXdHY6neUxv6/Gy0jeZH+GAS2NAiVC/Apzatl8TODu+5yRqNw/quhgzpqbGTrMsM5Edj
 cOmpOfWhB0Ana1I7Y/qL8QTPGrgR8RfwNuAhmOOd8aaFbpIQXLG+7xjU/X0GzlYeNFQC4fhPacn
 JW1wKnsdnTwXMgO/zXhfxdKaSeg1LdSsv9fjSUNzB9M/ScnmGDGL4FsrWYYf2fbweYp7kdM0f9X
 MCM7GC4ZtaVCnrGlxdJoHd6956En5iNueehXXEG5mayXb9OuUix5Gh1xgfX4MGkEey6QgoBv9ya
 H/tb0H71pVjduXVpYBenKcNKcNLe5ZpZMpYgAlHkpty0M0Grwr/bhpmKyHJlpT6Q2WzU4/ugO0H
 35VRbVde28PKyei2xTKmi4emyW5KuKfAPnLTLqyLHgOEohM/Us0BBRlaRZSLYVE7bHxHjngVVqi
 /6GP72M 9bKidutQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct ima_rule_opt_list.
Additionally, since the element count member must be set before accessing
the annotated flexible array member, move its initialization earlier.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Mimi Zohar <zohar@linux.ibm.com>
Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 security/integrity/ima/ima_policy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 69452b79686b..f69062617754 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -68,7 +68,7 @@ enum policy_rule_list { IMA_DEFAULT_POLICY = 1, IMA_CUSTOM_POLICY };
 
 struct ima_rule_opt_list {
 	size_t count;
-	char *items[];
+	char *items[] __counted_by(count);
 };
 
 /*
@@ -342,6 +342,7 @@ static struct ima_rule_opt_list *ima_alloc_rule_opt_list(const substring_t *src)
 		kfree(src_copy);
 		return ERR_PTR(-ENOMEM);
 	}
+	opt_list->count = count;
 
 	/*
 	 * strsep() has already replaced all instances of '|' with '\0',
@@ -357,7 +358,6 @@ static struct ima_rule_opt_list *ima_alloc_rule_opt_list(const substring_t *src)
 		opt_list->items[i] = cur;
 		cur = strchr(cur, '\0') + 1;
 	}
-	opt_list->count = count;
 
 	return opt_list;
 }
-- 
2.34.1

