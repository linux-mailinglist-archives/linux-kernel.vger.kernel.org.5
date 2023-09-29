Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311E97B39B5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 20:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233823AbjI2SIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 14:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233233AbjI2SHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 14:07:52 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A76CC2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 11:07:50 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-69335ddbe16so3967777b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 11:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696010870; x=1696615670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZNuuPDo9it8tkX6qPOGwJo4GQ7mQ5hyHXJpkMAiaQU=;
        b=Xe4tE7z3UjPddP/3wIOYwdmU5WH1aUpqMSwfeVediFgy50ezbBfLiAMHJDz7zT5Gc0
         F/+RE5p0eBiGuPJ/wYZ2fr5kAOG3ifZNPiCG+bWEa1V+Ls+I57PqRPAs/lHfsCgFxesu
         MpfOnu+/cjzx6FwhKDC5gWFInbrRKGci81SV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696010870; x=1696615670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KZNuuPDo9it8tkX6qPOGwJo4GQ7mQ5hyHXJpkMAiaQU=;
        b=eLY09hZ6S32kKxSKBmVL9X8qrZvyUNf+H2ZamXYQDVAmQ/pNbHKCZC9HjsmDkXaP48
         yU4w4nUkzuo9KrkHxhhE/oZ2FMkm3q5sHYKYiEPyN2nNbj0e5r5ooZTkvNqeTi07Zw+a
         HMWVC5Y7dBLf9yZVGM6EaoDi0hJooyHJq4oSNAtzwzcjjPvvcj00RBbybqKwcDMCcUEV
         lX8pnb9dfl9b6jbm+2r4MaF3cHSiFUnk/+qOEoxM4LclwG9QV9806mYNKhb6ODC/IP6H
         CBaYg2c7j+tPsNwYitRd7BGu6qM7d+ODeBlQ66hoWGOWHF14nBovA71vU+kyET8UmTRb
         67fQ==
X-Gm-Message-State: AOJu0YwFECdYEG8N+rMlOJmIKfG+Vq06C/N3OmRuvfNZGsjtkyxdDlgn
        xS2T54f0T0lukcWAerimUbBRgQ==
X-Google-Smtp-Source: AGHT+IFJ95BU6niyoo2gApDZnCXcDkP0dSKiwEwps//qgcxM63JrZFlYbqCMoWXf0lhhCnJHW9sTvw==
X-Received: by 2002:a05:6a20:158e:b0:160:18d6:a3d7 with SMTP id h14-20020a056a20158e00b0016018d6a3d7mr5378517pzj.1.1696010868900;
        Fri, 29 Sep 2023 11:07:48 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c13-20020a170902d48d00b001bee782a1desm17055007plg.181.2023.09.29.11.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 11:07:47 -0700 (PDT)
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
Subject: [PATCH 4/5] mlxsw: spectrum_router: Annotate struct mlxsw_sp_nexthop_group_info with __counted_by
Date:   Fri, 29 Sep 2023 11:07:43 -0700
Message-Id: <20230929180746.3005922-4-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230929180611.work.870-kees@kernel.org>
References: <20230929180611.work.870-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1562; i=keescook@chromium.org;
 h=from:subject; bh=B8keI90TRW2q45uUonlCrEQKui4OLUvrgLBebVNQ9NA=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlFxJv3gQ2icCiNvzN2SrB6CO5vY/Quxy8Fmvkp
 MWA5zi05RKJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZRcSbwAKCRCJcvTf3G3A
 JlMgD/9KspItI7uRPQsQk5b1n6wj1VGlU6uDB/MzB8j7BFvYACH75tHJ6+EtAxCMs6WH2/1xOJB
 Zc//rKE5ME8cSKtfDy2yuCaWHFyuMkgN1a33v24+KmVjWOC8Z/QjFt5svRWte8710RTditYZOT7
 XKykSAvsTe4/HJALIvV4CYJjTF4uavOTyu5UlYB7ZHjBBe0+VR+xepIZPkEjOgCYBRLh7lX/MeG
 fr3kiTfV1+0L6p5GA+Jbl2WymK1k56AOkQZXyBngR74bpIruI0iJJdu0vJKwC30V3SHQujqCe2k
 z598oohT+Wnd0x8ojB3RKTl1Kd1jHRSPN3uXlaIEIr33yM8vKL4PaoYIRnE6ZAh4LB8XeMkhrF2
 AQjtjTNgvq05sJ/iwgNhIjSE0TzGlV8uwf6IBWDELikCMijBFN2BhQg5lXOlI9ZzjV39Pv6Ghbg
 IEa8dbjv8XLSyhtIAWT9wZq+uOFfvYMeRwC/ff+Qeqx7S0B97oA19xAfKE2Ug/0eKSAwybHM0Ao
 eEzDT1/Q9mpQFcEl0vrNwq17gJM2cUasPKjBnI1W7aqj+rez0GpJxzyho+3j2K9MSMxbW2cqrw1
 nPBe7q3r8weENye2KqEWW5tjD5rkm2B1ikBvcdhkjlR/5K3OlyydwoM7dgEWGY1p0uLg0xY5rcC kErWnebJxPj8H3A==
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

As found with Coccinelle[1], add __counted_by for struct mlxsw_sp_nexthop_group_info.

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
 drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
index debd2c466f11..82a95125d9ca 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -3107,7 +3107,7 @@ struct mlxsw_sp_nexthop_group_info {
 	   gateway:1, /* routes using the group use a gateway */
 	   is_resilient:1;
 	struct list_head list; /* member in nh_res_grp_list */
-	struct mlxsw_sp_nexthop nexthops[];
+	struct mlxsw_sp_nexthop nexthops[] __counted_by(count);
 };
 
 static struct mlxsw_sp_rif *
-- 
2.34.1

