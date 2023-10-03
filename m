Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9497D7B749B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 01:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233320AbjJCXRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 19:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbjJCXRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 19:17:39 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975FCBB
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 16:17:35 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-693375d2028so1146705b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 16:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696375055; x=1696979855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GoKQpmMqfvqKzHnLxZqD4HyHEsiNZ2wH5iTpRblmiR4=;
        b=bnTBWeUjdt1I4J/BfeTKPBGkPZW7nlspwaDKA9bzcMMfsegNl3rMUV3+YZPSSADOZ0
         9KzaGE3DQlUBw0xRfe7iB0QKx8Ys1Q3c+utDuzfk+jvQzYReUHg7GW8nv2ExOqNFz84+
         lIkBw/BKvDmCGag0CF/zTzLwMOffEU2V0fIuw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696375055; x=1696979855;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GoKQpmMqfvqKzHnLxZqD4HyHEsiNZ2wH5iTpRblmiR4=;
        b=BI1zHe+6Vvl8oo1rqs44sjZHqGuCWusoFL1o7c529ggkWvnqlQKzdjkQBacFksY+DL
         kVCGweEGj0xdVyKy50PfWywCxf69Ki+bSOGoxcnNRb5tMz05pwzC3ehcVfNvK+dph7P+
         1mfKY7/NDpe4MNyyRtgTQvJ9ER/bReLn9jtTUxvxM+2PjrlNJXSKoWkX+lOuP1FpgC1N
         OOGDyQgy8rBbR8JmgjrnGvED5KwlSUZhOp8o3917jcgiBYgI6iQlHoNo8he1LPG4c2ef
         xIDgKPYPpMgj65B2VdbDl24zzbOs9V9s5RQbKfbbvh49qKm9eP56O9N4A9v8lLXLkfiy
         Wjfg==
X-Gm-Message-State: AOJu0Yw9Tqg3NR1xD74UrU5cJPy+P4a2Vp6+lfF9a1JDM5o4cfwOjK2g
        nYJm1473cCOK6uef7ziO6MEXtQ==
X-Google-Smtp-Source: AGHT+IGHJDUN/6E4AVoGh+IF3RFevWze6T8pc7xq/e7zFBZVKvCx1ePEZLa2oRxMwKGEVJJ01u7crg==
X-Received: by 2002:a05:6a20:3d13:b0:160:a752:59e with SMTP id y19-20020a056a203d1300b00160a752059emr936572pzi.40.1696375055059;
        Tue, 03 Oct 2023 16:17:35 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f11-20020a17090274cb00b001c0c86a5415sm2171759plt.154.2023.10.03.16.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 16:17:34 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Saeed Mahameed <saeedm@nvidia.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH] net/mlx5: Annotate struct mlx5_flow_handle with __counted_by
Date:   Tue,  3 Oct 2023 16:17:30 -0700
Message-Id: <20231003231730.work.166-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1463; i=keescook@chromium.org;
 h=from:subject:message-id; bh=f4vYnzC3KAMbhe3PqA9dQTWjat9pNjLmhrrK9jgwO8c=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlHKEKOBp2oKoOdsMZ42xUeFs28bfpJIdHoC1hr
 xN+4gwoi/yJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZRyhCgAKCRCJcvTf3G3A
 JnVcD/9OO1uAbC5Mu8AdWtl4mv3U7HH3JxWnR+y6OyXqdQtJS6Cqn1dejXUIYRJh44Sq+kT716I
 FUs0HEhVgknlMkWN4f5Qzy+2LcH9uTSNUfNLCCzXGwLYH2jCbBFVg4HCO1PeqhRYiLubOCll8t1
 BrZU2+OiuHqIDMcl/M2ll0CnI5J9ORxpkJLspsSGSZQQXrZJALMJ63vZRVMbdgAcrjJ48pwAvzm
 diGSqJWKqz4gQW0QzsOgFTGNlmGlhIkC96iCF6xO/p8sMi5lC7yIstjF7p8u2ogCfGdYahAgpxt
 7jdfIEXFuYZt8z+/+Uy2CjW/dXRfZ1CLVrUq0zX2ixuTNrMe4zhq6mAMONDF8bWpEkVVadzE3td
 0nk6Ninq/lCDZhZZ9mwhz10ZorGEeiA1J9YcX0WR0C29P05xurEN6dzy8tKMTFnM9dGLdzEYTpK
 T6L7TDpI4ySjWf/XhJXCgzhOqwOLmvtJX/328SAFczoH6Cd7ohK0jc3gi3AKjx8uonMDPNDjNzN
 WmTD8lRClxhacI3z2fQrMBoTlJnLJb5SQ6/r3SeAoYu/7c5Nut6+qdAJQCZTO48A6lrC/d/TfiO
 /oNfumYbWNf+u/Pdb6IzLiJmcr1Ma2m4WvM2DKw3pyMo0pnEjBQE5vf81ACsuKqcER80i5p9bl+
 IOPyguL n2YaaogQ==
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

As found with Coccinelle[1], add __counted_by for struct mlx5_flow_handle.

Cc: Saeed Mahameed <saeedm@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Cc: linux-rdma@vger.kernel.org
Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
index 4aed1768b85f..78eb6b7097e1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
@@ -181,7 +181,7 @@ struct mlx5_flow_rule {
 
 struct mlx5_flow_handle {
 	int num_rules;
-	struct mlx5_flow_rule *rule[];
+	struct mlx5_flow_rule *rule[] __counted_by(num_rules);
 };
 
 /* Type of children is mlx5_flow_group */
-- 
2.34.1

