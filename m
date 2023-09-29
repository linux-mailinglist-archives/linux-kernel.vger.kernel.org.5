Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93E67B39BE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 20:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233702AbjI2SL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 14:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjI2SLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 14:11:53 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B09D19F
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 11:11:51 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c434c33ec0so111750835ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 11:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696011111; x=1696615911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LelDNgIaKJAGv8m5QtAniz9H43KU5lbEctjO62ftcqY=;
        b=c6JXIVj8+lpK/dfbLFSBBXWCRfw/iOqrSjbUE9h28HcY5xoTuqoUYrChI+t9ZpwZuU
         JAWSdZxLk04I308cwN7stuS6ROcscZTvhh8N3J6jarqvnP4DwINMJ2qa3nC4A3CEi1Wd
         J1Cfi7W5VK3YwrWjia9nk4/rIiDGc6c5uqCIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696011111; x=1696615911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LelDNgIaKJAGv8m5QtAniz9H43KU5lbEctjO62ftcqY=;
        b=tfD2eo99BOHmGFApf73wIohCt0/XY65lBpbx6vL7BlpyRw4+qOlvMnh68RasRT68HI
         mew8fi69TZvxzSr5U86b6g2bDVmGVRS1Xo7XLMQJZhTJDIN/AL45/A+pft8ONYXkU780
         gXkBBaeA79cxhfs/GtuuMx0o2L6G+I+mHLKOZ8CpX9vP2brZ7KGGo0f6ZcDy0+Bss1/L
         hSElPOfVHYVV1/82WiY8M6WN8uFBVyiaX5zGv8cL0zBIJLhnfdaFOVLGO3AEgGzGooAg
         MMccTixoCxi8IlX5cy6b/dok8EDDLcS3HITzHPt9JDJePpKouop3bT+bFhrjjXGWOUxm
         1DNA==
X-Gm-Message-State: AOJu0YyrSHbp5USHgvlhqiEjhE4//8qbgyvMBbn2bpHbfq/RT/9iE/+j
        mvJU/8CFxP2i1aIdkpqOQOGGpA==
X-Google-Smtp-Source: AGHT+IFp3bhP+Nqbdbpr+lLgR4vtr77JK8lxcWx2zxMlaCWdtIt61fdrd8th89qUIyLgBpTfPNGTAg==
X-Received: by 2002:a17:902:e545:b0:1c0:d17a:bfef with SMTP id n5-20020a170902e54500b001c0d17abfefmr4502026plf.30.1696011110955;
        Fri, 29 Sep 2023 11:11:50 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g10-20020a1709026b4a00b001b8a2edab6asm17075217plt.244.2023.09.29.11.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 11:11:50 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Raju Rangoju <rajur@chelsio.com>
Cc:     Kees Cook <keescook@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH 2/5] cxgb4: Annotate struct clip_tbl with __counted_by
Date:   Fri, 29 Sep 2023 11:11:46 -0700
Message-Id: <20230929181149.3006432-2-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230929181042.work.990-kees@kernel.org>
References: <20230929181042.work.990-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1345; i=keescook@chromium.org;
 h=from:subject; bh=1xjwdL5f1ZwQtlSjHraq4S6Ct1cTzMptk05f7F0Knyw=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlFxNkClAByZ2t2imOLxlyWRMjihvubRYuwVOju
 CbJdpqAEYiJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZRcTZAAKCRCJcvTf3G3A
 JmRDD/4xcFd2xErFHHO52g54sKzulxzUwaY7hKB/cJqB+eXbtFGgB2tt9GnWDUYTucvNWfGfrRO
 WefuPoFa1In2irZrcx0pjDUGznGE0qFXLd86FJtIOeSIEJq35TMjFQOnq6tqhTenU3znVkbQZev
 64kT7WHWe+/WYF1syArYm5+LofMLkW1zctxLTdrpIRXBXpxbK9IzCd6gG7yQPGh/nCDZaZJR++k
 D/oSNxxnkr/cGbxRxhf5s/8qYKXv5Y8uzNPu2q5G9yzEf6e+8urdbYNlDIn4WGlWwpOVsGubTh+
 ef8O9z++/PzDHpk+g5s6fMxH3IM1sNyQbzRSblOMYA6ciGJzENjrSxqVZKJtIVk/gu4cEYIdRSC
 MZTZgdpN+v10komKMPQwIO/PiQ/38irV/eA1mWTw5lLAm8tqB6LPg6MgYOuOGXtFoI+neSJYPf/
 x5hWOqzImqqP2rxs3VchpeExsk3srsZJl6fPJKZxcRQ2K8rIR49s8wzZr3k3xKhPdYXoqMAu6lK
 whn/87qgrQShDDdmtGChdFZuoQ8jBLDXo1Y37dgkk0uN1pnVazzfaYydiESmJYIMAqDs7eiDSb+
 dMhc2XY+KeQ78Dvg0PDZtR//QWpS5+pG+iPfaLmlEqG6/1pQASs8+LUwdkJXtia2ClOU5W+qlcR fszdrCV9cNLMyTQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

As found with Coccinelle[1], add __counted_by for struct clip_tbl.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Raju Rangoju <rajur@chelsio.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/ethernet/chelsio/cxgb4/clip_tbl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/clip_tbl.h b/drivers/net/ethernet/chelsio/cxgb4/clip_tbl.h
index 290c1058069a..847c7fc2bbd9 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/clip_tbl.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/clip_tbl.h
@@ -29,7 +29,7 @@ struct clip_tbl {
 	atomic_t nfree;
 	struct list_head ce_free_head;
 	void *cl_list;
-	struct list_head hash_list[];
+	struct list_head hash_list[] __counted_by(clipt_size);
 };
 
 enum {
-- 
2.34.1

