Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC6FC7B74AA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 01:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234981AbjJCXSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 19:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234908AbjJCXSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 19:18:45 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F727C9
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 16:18:37 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c60f1a2652so2891695ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 16:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696375116; x=1696979916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cs/y+xaFiHWEOz6Orvy1iq9h94Wx2pdzVIF/nLH5ouQ=;
        b=of9zwq4so6JvnrmFQXDJe7dWqOSRgSSDWZQRgZKmRK51JJyEvkIDT8bUtmUHRElqiQ
         g+mGTqFnsfhmGD0y3ZzdKjDTmifhuzWzBdOFZlDGKsy1u3VlkUWsnux0PBBQGKhkktPk
         rCMNkpPlU+o6Drn894KU7APOs9RYLpPAvmNVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696375116; x=1696979916;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cs/y+xaFiHWEOz6Orvy1iq9h94Wx2pdzVIF/nLH5ouQ=;
        b=LRh8YslWUdXhyvSjpjzhYW2FGJkpbIOr6k77ntM40NWtZbTLzpQVv152Lmr/3KLZJ8
         ObPTvG/2O2rKmdDzHV/MjVh3eCLUZetLiZFoEuB+ceqxXIzWWWeVv4Nqmm33+WYeg5YS
         gY24Kg0s2b2NaL5FFD7xVP3Y7BYUXCI8ATyuzq3scNB6txJtEyK1cjR4x9t+tUNt9q0A
         vpGy78mNMQWBapmfujQHy4/UkX0PEW5fLoSmpBidVsaAp8lP9PHV5MyaWbz1Opr0iqvI
         K9W2Ed98qdYOfFE254a2R5oPbEvsRtAPrMnTiacnaRwfDbcT+5HLYGjopOmTA30FddlI
         W+PQ==
X-Gm-Message-State: AOJu0YxYH2GDOp7lNcvlaz9DYFEtsrv+eHr7EqtZ2hNSxoZsge1gWLtY
        Qfw0jN0Rrl34aj6XRgZ1Nm64Xw==
X-Google-Smtp-Source: AGHT+IG2rmxvRQTV1QqeWHHUBymNu1S3TU8uYeUrwUlYaT3KK2tpSvc/uvywB/UQwgvWxExDCrsMbg==
X-Received: by 2002:a17:902:db86:b0:1c3:e5bf:a9fe with SMTP id m6-20020a170902db8600b001c3e5bfa9femr886524pld.30.1696375116475;
        Tue, 03 Oct 2023 16:18:36 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t12-20020a1709028c8c00b001b89466a5f4sm2192072plo.105.2023.10.03.16.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 16:18:36 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Kees Cook <keescook@chromium.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH] flow_offload: Annotate struct flow_action_entry with __counted_by
Date:   Tue,  3 Oct 2023 16:18:33 -0700
Message-Id: <20231003231833.work.027-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1296; i=keescook@chromium.org;
 h=from:subject:message-id; bh=0boqWAsd/6ZiDm6IubJhgrIAyAV2i1CalHaJrRP30Sg=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlHKFJjLDxYFWAIlzLyPwWgmZ9hiaj7VEOr2oHY
 k08COfXcdCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZRyhSQAKCRCJcvTf3G3A
 JrK8D/9KEPYj/M8bXAiIzxWF2ZyJR84xb9ciEEfjEjN2R4UHdjtchwNrtasquYrt3ny+WIGBbhe
 0JtnoSkCuYrCzaTNpFQpAVzcKZMYAWOoTfq8XhRw2t8wwKrsiTpXgFd03LDFVgqgqamzoOXwyCi
 VIsbY5R7xwYN9QoafMgKzwFlNt0gNdb0JALM9kFi1qxxKVXJKh7hJB6BepurEVM9/3t3qR/AeqX
 2Xp5re530r88nPiId+lrJucvtIiZGC+EWjgwcMP9ZLg3sIdrmtXVDqeEXTLl9cSRMVnlPLRyk9o
 BVFl6eI3bjvpX9XG1Hk7XEk9UkjIOvK5d7ybgYiQIELVfYgt3SM19+jQFcg0opDFiTiFTVLeOSr
 RZ62m/4MMT+blNcje0k+2kr0KBdkZ2QPN1yBuvvQUQGiEOiAst/XtSRQRzcurQnB71jd7rvzbhY
 8mK+AXpzzX6mSSquLFzpQYS/DNsfZuda9IyoJ4cBNa/aC6Lll7qGFFJIhu7waaUmJ4GD7u/WE0i
 hYaMBUWBon4+wbtKUUgLqI8HJhyNfxSoXaA1JwhKA7liruJEb7wSadoNZKL51HpVQgvv6mNShDe
 oWrRx5uLCPSPzgKjEhQIHY8foSPVBmtvbRWzmEenClfkDY4KC6Y3KelbIByzdKscBCONl9tL/9+
 XLbpVM1 KEBl5urw==
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
their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct flow_action_entry.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/net/flow_offload.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/flow_offload.h b/include/net/flow_offload.h
index 9efa9a59e81f..314087a5e181 100644
--- a/include/net/flow_offload.h
+++ b/include/net/flow_offload.h
@@ -333,7 +333,7 @@ struct flow_action_entry {
 
 struct flow_action {
 	unsigned int			num_entries;
-	struct flow_action_entry	entries[];
+	struct flow_action_entry	entries[] __counted_by(num_entries);
 };
 
 static inline bool flow_action_has_entries(const struct flow_action *action)
-- 
2.34.1

