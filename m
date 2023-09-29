Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4187B39C7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 20:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233759AbjI2SML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 14:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233709AbjI2SL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 14:11:57 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28321B2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 11:11:54 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c5bbb205e3so130601875ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 11:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696011114; x=1696615914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yrVonC05p6jOVhwUsfVJLWHka6sFzEOVBvIvQ8Q6DqQ=;
        b=iam2DgOt+pc0XpODhJMdV7fFqweB00abGT6qzmh0ROiTggfKN/uA26owAG9Wr7gAfi
         OVEYRh5M34c3svag3tP7qerBoaXgvjLFgEnzYiufn+X8t4y7Qo8W4+G0G7kPfTRnfHlg
         NaRToJAUo9/nJSawNsR7QJ8ntC/8SaOLnKnNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696011114; x=1696615914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yrVonC05p6jOVhwUsfVJLWHka6sFzEOVBvIvQ8Q6DqQ=;
        b=GehJVjRgC0qWQp3EKF9CAA9PafflggbL/NdYIYOzLwuGpKPnzXm5pERTW2uiFs3BPy
         X4R72XyQ8oo/eY0ML7bLgllk7H7dj8mSZs/UVEVR92pqDUy/cDVlH3m34czEm2MYYc0q
         /NaC7OPnyNdZgqkfOM6SyBYqLiPbjyVyjhuxa+3LLWLZogp9SiFATBGAHBHXM3qP6OMR
         T8qaDS6qvfW7TJKqAPU6wUPFMPJqlrTa6AOhKy+XFKxI/GVkU5URMOEfrL8kKIcHaPVV
         lakM9Q/I40WrN9NfYFnza4B73wHQkrjLVdVTtFff0bFmHz40CcxM0DygvA4zXE7ztYKy
         tEXw==
X-Gm-Message-State: AOJu0Yy7O8bdF0th7u6Uv3Vaquc4KNt84MoN65ATEKHtcr2LU40UDiYu
        WQWGPvaF5i/bO5NvB/MPG8ddlQ==
X-Google-Smtp-Source: AGHT+IFgn+YcX7y6H3lg00IXM/XrZra8mruPoKoixaSoCVKNNnq8jxU4+SgPqKTL8waGiLmnTcRybg==
X-Received: by 2002:a17:902:d38c:b0:1c7:4ac4:8f45 with SMTP id e12-20020a170902d38c00b001c74ac48f45mr1746465pld.43.1696011114345;
        Fri, 29 Sep 2023 11:11:54 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j1-20020a170902c3c100b001bc18e579aesm11121886plj.101.2023.09.29.11.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 11:11:53 -0700 (PDT)
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
Subject: [PATCH 5/5] cxgb4: Annotate struct smt_data with __counted_by
Date:   Fri, 29 Sep 2023 11:11:49 -0700
Message-Id: <20230929181149.3006432-5-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230929181042.work.990-kees@kernel.org>
References: <20230929181042.work.990-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1333; i=keescook@chromium.org;
 h=from:subject; bh=JLyOuNbsppgNQ4E7t00aHIOLLwYOPNO4180/z7PYk3s=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlFxNkFhFFrPwEa/QR03Eug35cqUa66za8zL4Yc
 tXAGq5NrJKJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZRcTZAAKCRCJcvTf3G3A
 JhyfEACGOow2LuF71Rl2/1+567N4njI1FCgglmine5Smin9dsg3gXEI6wm5z9CqGgrQaAxNKx4C
 zmoIQ01iI7Dv13ajsqLxuuxhsDJJi33Q5MjAQ6XbWMCN0LDUIiu2pR1Kfv9XKAWxKV7qn/Oahln
 sryf9SDc7OSHj/Wou2usLanxazxvNzODnuZReRlw705m4BdnO7+yoLKCd981sdmOohczCfAyMaA
 oq2HA/pt2OaGJpZg2cOkDnndqDHgTmlwxYRg0Q8EUMa1h7eclM4/txL2VR1E0E9Spgv5lPy3iIh
 3rT+0yAVFoS8jrHSxABKSgNMRRP8AMKK3PkL5oHS1mqJDFYcbFBgjuKj6sKIbea4RtS0cYek06M
 hQv1Rk9XX6y//jV7kU22s0/ms+WqRZcuSyVxxmYgk+jwnAmAG3oONUwdDKAmPdMrChdWi+Vin4i
 5OAqx9x/Eq7456qC3yfH/YvEbpgKV1sMnxV3Q8GGgxw0rrrhY2tk99LzQ1S/WTU0x5s4ke3c2t8
 Siui7ik4Owf/oSeTLtn0yvCObp0kqkPgm/SpI/ZFoRDeudgpA51AFk4mvoy4fWw7de2TLJv9xqE
 KgbrKJRdrPpV7PEwtt/iay1GE7okgsjLZngWqD5ddaUA0tA5o/C1aDYkNpJJyXLkAW8ZADALiFl qSiszCEru7ozwrA==
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

As found with Coccinelle[1], add __counted_by for struct smt_data.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Raju Rangoju <rajur@chelsio.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/ethernet/chelsio/cxgb4/smt.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/smt.h b/drivers/net/ethernet/chelsio/cxgb4/smt.h
index 541249d78914..109c1dff563a 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/smt.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/smt.h
@@ -66,7 +66,7 @@ struct smt_entry {
 struct smt_data {
 	unsigned int smt_size;
 	rwlock_t lock;
-	struct smt_entry smtab[];
+	struct smt_entry smtab[] __counted_by(smt_size);
 };
 
 struct smt_data *t4_init_smt(void);
-- 
2.34.1

