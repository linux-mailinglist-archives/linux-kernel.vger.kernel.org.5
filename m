Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD587B39AF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 20:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233144AbjI2SHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 14:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232923AbjI2SHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 14:07:50 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D0F1B0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 11:07:48 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c5c91bec75so110129255ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 11:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696010867; x=1696615667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3cXa0cO8yt2b6e+VGi8zgr6GOxIgX0GS3Nbuo7CXwec=;
        b=C7zQjsY0bLpXxORG1txjs2Kg3j+zIgfX8oP8/R1uZrA/0JjeDf1q8nsLaVcDxcfGWZ
         ONHsTIGhASybM9COXhKobV5iUzQ8bpjfI+N3/giEqq5Uo/TOzZUq/yM+IVsbxrB+z4IM
         JSUyqdYzTOjo27v1yAwaxTL6m5dwb75cvIFhg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696010867; x=1696615667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3cXa0cO8yt2b6e+VGi8zgr6GOxIgX0GS3Nbuo7CXwec=;
        b=sdggvdeUkHsgyOSbEeIz7pM6A0a98Or2O8cgA/1HGRXequG06q8hMdE2BEXb/Q2Mpp
         T8wyhrCqHayDqIBDQQeQ3PkbljzaC+XpMCIhN3Ni9ZmIKxrGTMew5HEME1CbJMw8Fbnp
         rm745O2w1g/0K3ACYUX0UEMx8pWAoY832WFhr6z/P/ezECQfoOcjU12kpcb+kkk+3Bpp
         T+hI1R3o9LjpxKqShBHXwYcSh03+8NuB4WJdUMs4opgzZnOA7nHDzYlnTp59TE39oCxf
         gq6K6bQMpNv564My+iKSuMuSfCfFXd+9Bo4y2+94bGbC+w9K9sfKXA10aIz3enqCuiEA
         lsHQ==
X-Gm-Message-State: AOJu0YxWpJLKTiNtCCYbW7Qn6VBW1mMin36iWaiq6WpDzNRX2Pu5t+68
        oTTNhpJcL6aiQYdqnYQDVVp2Qg==
X-Google-Smtp-Source: AGHT+IFtu4c4ZFASN8YJ8+i8qsvc58IIkosaQq3qEI0WmbaBdN20jLQIPQZc62BpHb3+w0fTnXx5Tg==
X-Received: by 2002:a17:903:24f:b0:1bd:bba1:be78 with SMTP id j15-20020a170903024f00b001bdbba1be78mr5817296plh.23.1696010867484;
        Fri, 29 Sep 2023 11:07:47 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p16-20020a170902e75000b001c446dea2c5sm17144513plf.143.2023.09.29.11.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 11:07:46 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Ido Schimmel <idosch@nvidia.com>
Cc:     Kees Cook <keescook@chromium.org>, Petr Machata <petrm@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH 1/5] mlxsw: Annotate struct mlxsw_linecards with __counted_by
Date:   Fri, 29 Sep 2023 11:07:40 -0700
Message-Id: <20230929180746.3005922-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230929180611.work.870-kees@kernel.org>
References: <20230929180611.work.870-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1509; i=keescook@chromium.org;
 h=from:subject; bh=Ww0CdLXqXc4lNTAvPkI5tpHASRFsk/+Dd/7elsfsEVo=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlFxJvZ0ctS3Apt7u/ZPa2oHBqvLK7sDWQzgvto
 ev8sStvUCOJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZRcSbwAKCRCJcvTf3G3A
 JtPID/9lzDk8uueD1NLYXfN5nJTT1N04aIYmTyDtXOx9Q2ze4G6KfG72FccvuQD7QCYudQIhMti
 UN9kFRwzHB7UjP9+D3r86ENK4dpKPvnIeIFJpd+Hvg4vvG+DHtLDZGJIeTi4dnyw4z2ayv/4Lgy
 OoSQKKswKBI5hkv1uMxbxIljvEhJDhbbWhEme2fxZvzV4c8mInhVzj90PhhsRET4a5lxGwe+Al3
 JMx4CP859l1P2gwm9vaxIazkD1E3IKgESNenzlG9zjXyuFTkazOjQfdFDUBiEesU4WrkZCzJeKA
 UuQZW27ZR8vwOh9N2cu1ONtfxOC3XRQPmnu0IDt0yyM0Vp3fEVJkAQn8Ti5J58VNHTGj9/INkms
 33nE+9B37Lpmr0v5oEhgLhVfUOzIeXEoOHjnvoed9Pmw0+QqjEMq636LMMuxTp/O45pqisaLrGM
 nQcAqGkoQiYUXpyAzmKfzC4AGHALfiI8/0EZGSqr+5hPIGdiDEWxQiL61EQ4kgUuubp16GUcRdQ
 MvmN1Nz1hHJzFP1lA9sBSTnAcyDLZDYUSFP555nDHRyjzoDPbiQtCWbMEaKn6rQYBA9t1LasSzS
 RMn1fKyLWauhfAYUUXnimfKBeQDtWvFwT4nVKcDVN9mtuu7N0+VNU0r8/O+oSgsdzzpFTbA2Kqz XW74PgNoDQaokuQ==
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

As found with Coccinelle[1], add __counted_by for struct mlxsw_linecards.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Ido Schimmel <idosch@nvidia.com>
Cc: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/ethernet/mellanox/mlxsw/core.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core.h b/drivers/net/ethernet/mellanox/mlxsw/core.h
index e5474d3e34db..c6bc5819ce43 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/core.h
@@ -624,7 +624,7 @@ struct mlxsw_linecards {
 	struct mlxsw_linecard_types_info *types_info;
 	struct list_head event_ops_list;
 	struct mutex event_ops_list_lock; /* Locks accesses to event ops list */
-	struct mlxsw_linecard linecards[];
+	struct mlxsw_linecard linecards[] __counted_by(count);
 };
 
 static inline struct mlxsw_linecard *
-- 
2.34.1

