Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1074F7A27D8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 22:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237201AbjIOUOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 16:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237391AbjIOUOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 16:14:23 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81C42D48
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:14:07 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-57790939a2bso1913656a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694808847; x=1695413647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oicgvy8ZQsJ/H+s8ny1gZL4bTkfKVCg2IoVNijyvIg8=;
        b=EjpTVTvrhMrBfI4a4z7FGR0J0I3Gf/GoYG5NMdl2JpAlkx45McjW0i2i/cbzPRaka5
         kwMe1NrUmxalrYLY0VH64DYVRsPbbLLdYPPPisUGlDhjVB7Iiv6UiCuWMsCmqruwsAim
         Pm3sH/BaPeAXp4WO/11ew+E/kQgxui6Zme3z0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694808847; x=1695413647;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oicgvy8ZQsJ/H+s8ny1gZL4bTkfKVCg2IoVNijyvIg8=;
        b=EqlBjXSrJ887LUh1eqEIwPOWxI+sCcKJ5dFe4Grpp09mtt6VpJsurLNv5Zvt3u2D9x
         68GZcKR1iNxroMXwvUXSVnLnRzowFfG5KLr5xCnebRZkFiMmhjo1Bufe3cxOhQmfBaL3
         MBuTp2V7CR8k/IQRp2X2jLFrg8O52J0OZ215voUWg7DBFbDdp7xXwJ1e+RwCghMVD/vo
         73j4SvhfeFnW9wM3qOVZRAp/CP9pSLkDeTcWhv1IXy5SEWaMR0O21vVbJ6d5HSOeYGUR
         zFLaeaJPRzvGtxzdTJB5WIpYZuMtXHaF9wq++fIoRk2BwZhs2Nv1mxLuQ2xOn7lNJXtX
         Yc2w==
X-Gm-Message-State: AOJu0Yx/293Fi7bXoDO3xXpP4+LORo1rXGzygeLGknraenxCMJa32nKs
        YDtXut56CXliCPG9E3Tt8hkNKA==
X-Google-Smtp-Source: AGHT+IEfYZ/UgYfdCyr2ODsTNvO+DYWeLrEHu+ivgaehYmkWlq+ooFcHoKRvAx82GGQF2u3fKgu+EA==
X-Received: by 2002:a17:90a:5305:b0:268:81c6:a01f with SMTP id x5-20020a17090a530500b0026881c6a01fmr2702511pjh.26.1694808847113;
        Fri, 15 Sep 2023 13:14:07 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id fu17-20020a17090ad19100b0027498485107sm1706587pjb.12.2023.09.15.13.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 13:14:06 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Jan Kara <jack@suse.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] udf: Annotate struct udf_bitmap with __counted_by
Date:   Fri, 15 Sep 2023 13:14:05 -0700
Message-Id: <20230915201404.never.574-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1040; i=keescook@chromium.org;
 h=from:subject:message-id; bh=BUpk+NqQMMN0qmYWwrmO8FxGwWxEGEYVaPG+zJ06MRo=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlBLsMQJt2qp7TQ1LA96Hxy7q1jthVYf/zpnN+m
 6CUfAwnwb6JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQS7DAAKCRCJcvTf3G3A
 Jr7/D/9yErTRxAzHaDFDOzE/kRrbYmZ7UQLL6OxblKmIJk2ZNjhDFMvjmBuH9qGGUyuKFVZVNty
 jkmndMLGM7tb6dm0iw8UMVFvNrkZFV0EiHGODAYvPBU7d1oHnykVINhpUzNaHe2LWH0zwnZDAcS
 zzBQJCty+384+FztuKlLv1hAopQ2XSb88RAjjuL6wRs4oVX29cxtUqK6JkdH0e2KjD3Z0RIIZsb
 8lEhJvCrXURb2xbk7wdfEZeYsoWtd2kVxRttuQHckbzpEUrm/MqdGT37LjfEpy74ca3xowvkNwV
 th0vm7VJkATIKsol5ZUnOlFiFNB4V7ebcoUB9Hh+XDdhVYK+eViNiim52AkJC41M069BDtSOENy
 QcyBtVXwG3dmdYqNt0vrYsFo2S2zC/qYY9c9HteiiwN44m8KcoB5XNojWp71FcecOT94VokbyWe
 mY3azzMBACSTYM4iIRfqBG7n5R3/R0OPwzoCQ3O963ohrgUMyl7/pwO9JV0nDDbAUCz9eFwG8h7
 zDVEbAMoYP1fqBqOaTvjGufri6IfzxzoFPUeRgqAgI2CWN226XpMfy6f8cGM6TqN5GkoRqJuHZU
 oTojGtvqPoo8XXIMtTfHBugsyIejsxCebBBoBonJ0yApGKcfrj4Q4zKG+6oXquYnMXA2yRrXosN
 eJT3+x/ OJ9Ye6Jg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
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

As found with Coccinelle[1], add __counted_by for struct udf_bitmap.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Jan Kara <jack@suse.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/udf/udf_sb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/udf/udf_sb.h b/fs/udf/udf_sb.h
index 9af6ff7f9747..f9a60bc1abcf 100644
--- a/fs/udf/udf_sb.h
+++ b/fs/udf/udf_sb.h
@@ -86,7 +86,7 @@ struct udf_virtual_data {
 struct udf_bitmap {
 	__u32			s_extPosition;
 	int			s_nr_groups;
-	struct buffer_head	*s_block_bitmap[];
+	struct buffer_head	*s_block_bitmap[] __counted_by(s_nr_groups);
 };
 
 struct udf_part_map {
-- 
2.34.1

