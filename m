Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6877B74B0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 01:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234871AbjJCXTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 19:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234673AbjJCXS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 19:18:59 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D44102
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 16:18:47 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c5db4925f9so2776065ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 16:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696375127; x=1696979927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BfDQBScYxSUnSyfi4Uo6dvpGeAqp/VpjWLErGf4V/4Y=;
        b=c39GCY13A683WQCyXS91Ah+kckgiae7d4dciHzklFjcoQIB+TDGXGlWWf4PLFilZX8
         +1E8A99I6S3jAWXv5wkfYCAKs/b1ukQNYCj43Q+2nO2oLcLFnrZYft0BjxUWbj6kvu/u
         ulzUIJCN3AfQrOHaGQePEgSjrvC5/4Jp2U6aA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696375127; x=1696979927;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BfDQBScYxSUnSyfi4Uo6dvpGeAqp/VpjWLErGf4V/4Y=;
        b=o3PzSfLlcFC7JYbYZguqnGWgCxesZTBt0O53Qeu4YdmGjRyxae9mHINSWypqMb1XVR
         /FwLoi3YjZNcqkMNB5iJkT6wbWtRStUiUYm+jFX2N35W8/zwoeoVs/vCs4b+jzkiN6Wc
         1HEpwpyh1FDz+UCYE0YhHteyxCi8Kwib8KTDCqkcLazr/5VAywXvFAJbtAvEvu3OiEwZ
         yqXkxOYDO9oX7i1u+gPAAGzVttb9b7lJZb2JO8GVRprwQSmjiK8RIucmSZJnzNzaNPPp
         HycsvRrAXPTUifCLwMSYtwzzbkZ7Sppy+A4ts8qxmuEwPU53cMRGpjA3SzwnmtTRUnnh
         foeA==
X-Gm-Message-State: AOJu0YxZBqNv0QmVFW+XWC9ZJFlx9vhARNbjxsDLmx8sejDjtz9PplXi
        8PiMPgrEtaY+K5GJTN4YZm6kbA==
X-Google-Smtp-Source: AGHT+IEQQoskUukjcV6UR3tDbZMEU82tUa1GjjWkAWraorZYJdgm/37PjJsSVWQuLq54fcBY2UxXAw==
X-Received: by 2002:a17:902:d4cb:b0:1c5:d8a3:8783 with SMTP id o11-20020a170902d4cb00b001c5d8a38783mr1089962plg.11.1696375126989;
        Tue, 03 Oct 2023 16:18:46 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g2-20020a170902868200b001bde65894c8sm2155966plo.268.2023.10.03.16.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 16:18:46 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Simon Horman <horms@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Simon Horman <simon.horman@corigine.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, oss-drivers@corigine.com,
        netdev@vger.kernel.org, Louis Peens <louis.peens@corigine.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH] nfp: Annotate struct nfp_reprs with __counted_by
Date:   Tue,  3 Oct 2023 16:18:43 -0700
Message-Id: <20231003231843.work.811-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1385; i=keescook@chromium.org;
 h=from:subject:message-id; bh=GBdZ/bN+5XfvUCtrP1SCYpOVG1FCyQF4BGZ+0KiNObU=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlHKFT3XcaVjq8M5JxizadLIhdl5wOFCRk4jHmt
 IqwNVjEepmJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZRyhUwAKCRCJcvTf3G3A
 JjtdD/9D9R+8v9dgd3XY2WHug3rJjyK4+8aPw1mMYmILmQAYJrviLmccxjiM3F8I8PdZetcj6SX
 RbH4C+nQWdw5ItnpPFkHGDihNWS9JWqOKv+oGkwUa3Whsf7iRHBvZf7uB/OgbdEO293mVpH28xd
 KbDCTzrjImpUo55jjiQpypeXtqmMx9ETglaTTFwQcsy0AFJijWbvSS8agYnozYrZRQ/PImZqVtX
 SFpz7g3JLBAoGdtYE9fQ7jjJ03qrd+ZQrvXLw9SIaO9HFyflrYGihTFC1VCzd7kPAwollvn4m97
 HH7yUiaKoVQDlXMiCxjF1SJJJ5QIFF+rmU+yQNBLg/yzGofvOSNIHLJHsBoI1WCt1cuuf0mnJaC
 +99noNzwMdxYbz2ty0nd3nkKAgq9GWcgxUmxwAnh6DyTzhCdCyXTQFbQdFIwQPWMkk3XZzW/MBM
 oi4Nl8a1A7APm4f2ShQWBNUF+X5+K4WiwWDDm02GDNhGbhd8g4SqOBl0/u8VfysAI6ItMlF6Bmr
 hypptMkfiJr5Kgaw9lCUFKeoF4buVYEhf6KaQp/5D+vPYIEYbR/LYJZQC4OIlgi8AOgnMELTjFx
 ToEkiMcod9orNCiC8N2Sp0fIEREqeIVvOYH/MV1ScmN7S/nb6gSwPSSvo5KhnEOicTn5xHj2QxY
 Xabvqd3 WXqLy3lg==
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

As found with Coccinelle[1], add __counted_by for struct nfp_reprs.

Cc: Simon Horman <simon.horman@corigine.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: oss-drivers@corigine.com
Cc: netdev@vger.kernel.org
Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/ethernet/netronome/nfp/nfp_net_repr.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_repr.h b/drivers/net/ethernet/netronome/nfp/nfp_net_repr.h
index 48a74accbbd3..77bf4198dbde 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_repr.h
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_repr.h
@@ -18,7 +18,7 @@ struct nfp_port;
  */
 struct nfp_reprs {
 	unsigned int num_reprs;
-	struct net_device __rcu *reprs[];
+	struct net_device __rcu *reprs[] __counted_by(num_reprs);
 };
 
 /**
-- 
2.34.1

