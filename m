Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8EF7B39B3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 20:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233728AbjI2SHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 14:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232985AbjI2SHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 14:07:50 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57CB91B3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 11:07:48 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c60cec8041so77448555ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 11:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696010868; x=1696615668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ytcIulEB3Bd0Lgb6X1DnmKvq+hrlwdq4lTgiyfurQ14=;
        b=cuVBAaBIyghBmO81lSaXEHPxf8OVa6KMq/GYIsVSGifxEQocRaOx42pF+eNKaSQ5P5
         rOypC71o23d2fU/MJpbwX6Qc9lGsWIcsdmt+ZZnPdnm7Vpw9PM7kxTd0gz3CCTlMoQco
         QALsoJnrQ/HR713Uw99Y31d4+mOClc1OrG8jE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696010868; x=1696615668;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ytcIulEB3Bd0Lgb6X1DnmKvq+hrlwdq4lTgiyfurQ14=;
        b=jNLrokdfL4OzFh8NzFLg3NBb+XkkjM+z0Lxr4qbIazORogzEELvLSIJtCoi30MXMc5
         kyu6bs20q7ZlyNx2BYrW/LMI8J0wVypdSaJUJb4rfqZN8lRQJTyOAHXk3+O8qCOJjG1J
         L3lb6+ev2wNvjO56tqgyekhgQZOvfNMizJa40SCpfWaCKQSYPbQduQ7kDNoPCEfIKLUW
         qsl6ukDY0L3uNbb6Zpti2rwaoUoVGlZiHT/FG0Bby/nkvOGOA7+l37NOKiZkQAuNikrE
         AShei6zUuueLyZTSDUncbCs9nFS9UJcotuGphlnCaoSQL8YKKKjsuw2CMDzRCNiTFp34
         ZxLQ==
X-Gm-Message-State: AOJu0YwmvSrlaf/Z3WAkej0bzfc+n1JUaJiDyepOCXSqr7cssczYAsb0
        OU+mwIw73TQpW/HK34I0Oz/UfA==
X-Google-Smtp-Source: AGHT+IGMFNLTCNCtA/FqnKOTA460hZC6guf310Jbrn09vBZrg4EKduZUZHOzzcMy8xMUvOVnVjCeYQ==
X-Received: by 2002:a17:902:ea8d:b0:1bb:94ed:20a with SMTP id x13-20020a170902ea8d00b001bb94ed020amr4663075plb.24.1696010867805;
        Fri, 29 Sep 2023 11:07:47 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jw13-20020a170903278d00b001c74876f018sm1605993plb.18.2023.09.29.11.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 11:07:46 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Ido Schimmel <idosch@nvidia.com>
Cc:     Kees Cook <keescook@chromium.org>, Petr Machata <petrm@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-hardening@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH 0/5] mlxsw: Annotate structs with __counted_by
Date:   Fri, 29 Sep 2023 11:07:39 -0700
Message-Id: <20230929180611.work.870-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1021; i=keescook@chromium.org;
 h=from:subject:message-id; bh=GMvcoJa22FgGaZ5PVgWxKg4zkvx6Wc5lsJ5JwJVw2fI=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlFxJvZx4KMD65V6zmNUdqeMe55R3rtiwTNYOc6
 EZZ9t3itwqJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZRcSbwAKCRCJcvTf3G3A
 JilLD/9r7z+Y0akNEbzBq9UIK6u9F8wxjl2UhnrMWJV3dIfqBfLZuKWOV5DzIinJVsMdydRvZ7g
 LzeVXCUcQ9Y5xtrOmqzuO7qt1YrYJ2ivzNReGQNY37w5stJlTgoQECYYskZmbIzKLLHbd2PmXEK
 5PVWAtEQ9fgKUA+34HyZ7QplTHvqrrEYeCLOmrKWHvPAW/l+gl0+fV+CF0uEgpKOCk8LCnFlODo
 iBQDBo0ty6OqTWAItcqrMvAzf3DnS/LoznwCjVUtt8Qe4Z16eBkFFrrN09ptZlIGnVEZAI+CBEo
 NiHxE5nHwqvZb4vVFLa37SLJC5Zn0V+W7engScEuW+vmsaIbzyEDWvueXrbFWXxC5L/BEVjt5jA
 RLuI9pH223rzBSA/Fva1nt3P1MHUlopmO9ge7/lAZmSp5h6tYcdxQKOFSqgCmWRjHJttAjzx4k5
 EjHejSkET+0kGXK4q1lm5OYkUUNT7RJBywxrTTVB0X+v1ZTIIYW3kS+jqMsfI3GL8pCXdKig8eW
 lAVjor5R8hTWY5x35fn6Bn0ofB60JmP5BmukdqqVwACrrQ3tb5O0r6Uh/1YObqO5d7wbmd76Sn2
 +NkqwfKsUKtD6BPbF0eEX7oywwTZaKrYh7KjFV3vlVlMy4Wpf6Pt0NkFeGDzTA2RXe0LVTQnGok
 9cFR6xv keo3z+2g==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This annotates several mlxsw structures with the coming __counted_by attribute
for bounds checking of flexible arrays at run-time. For more details, see
commit dd06e72e68bc ("Compiler Attributes: Add __counted_by macro").

Thanks!

-Kees

Kees Cook (5):
  mlxsw: Annotate struct mlxsw_linecards with __counted_by
  mlxsw: core: Annotate struct mlxsw_env with __counted_by
  mlxsw: spectrum: Annotate struct mlxsw_sp_counter_pool with
    __counted_by
  mlxsw: spectrum_router: Annotate struct mlxsw_sp_nexthop_group_info
    with __counted_by
  mlxsw: spectrum_span: Annotate struct mlxsw_sp_span with __counted_by

 drivers/net/ethernet/mellanox/mlxsw/core.h            | 2 +-
 drivers/net/ethernet/mellanox/mlxsw/core_env.c        | 2 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum_cnt.c    | 2 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c | 2 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c   | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.34.1

