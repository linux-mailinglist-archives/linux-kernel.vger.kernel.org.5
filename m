Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E281F7B7495
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 01:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbjJCXRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 19:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232338AbjJCXRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 19:17:33 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101ABB4
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 16:17:30 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-694ed847889so1245315b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 16:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696375049; x=1696979849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pC6/v4iVoFQU1IrJy4nniQew2pnCIehdGbhCmJV0Sik=;
        b=ofs/0CjFBF8yBfnP9ab3lL0Df1RvL3orhXCX1ITuM0rJ7eEimE4hWAEDheSfQsoay1
         iwf1xGJngWp5ci9C36sTwJqZzvwFNKH09X6gFWlqJFzOTjB+Br2IgFpMZVt5gE1St82h
         vTuTqL+IkDLL734sl5hBU+eDEcQjpxb8aky0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696375049; x=1696979849;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pC6/v4iVoFQU1IrJy4nniQew2pnCIehdGbhCmJV0Sik=;
        b=gBFmZ+BtcZ0Nd8qahdFqZGXmaY2zaEUtenBGZKu/0Un6H0ofU1leCUWXOlhZtELkJ6
         wsy6aG5n1/OCMn+POArMEWq2fbg6nvVj5LNb7IGbcqfMg+ThN1ilWY5U189pkeEarwZV
         6TDdwHg0ifzLURGg+V2cjKjYx6UlxeijXdgEVAVnujF4K4YxZW+9kPkU5JBOvtsLijSI
         rE+qpSJEtNrfZ9Xb3R4IaI5UxQhXFZb53rdg8d3DvyisHP4Vb5AmxSuGOPXU18I9bXzL
         QrIhaBD2V2OgZZKsajFvo04rNl63DI6p+OS0pvwEGkbEvtyyKxD4P0GSddKct0UE2B6U
         5zpg==
X-Gm-Message-State: AOJu0Ywn8K8ClNp7BilOZZDCBN0kUgzo/bEmXQNJNtqrcxuuh1asuDFo
        6QoI1ncs2I6zYMwrTBSk4MZJkQ==
X-Google-Smtp-Source: AGHT+IHuGnaJKo/eW/4N6NAvL49m6h5gcj04i+ab7cUtcvywEoaT716ZI5XjapIrHclCSR0v4pBMHg==
X-Received: by 2002:a05:6a00:179a:b0:68e:4587:3da8 with SMTP id s26-20020a056a00179a00b0068e45873da8mr1129484pfg.21.1696375049514;
        Tue, 03 Oct 2023 16:17:29 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n7-20020aa78a47000000b00692c5b1a731sm1906278pfa.186.2023.10.03.16.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 16:17:28 -0700 (PDT)
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
Subject: [PATCH] net/mlx5: Annotate struct mlx5_fc_bulk with __counted_by
Date:   Tue,  3 Oct 2023 16:17:22 -0700
Message-Id: <20231003231718.work.679-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1504; i=keescook@chromium.org;
 h=from:subject:message-id; bh=+jSITB/6TjSNj+40UA2fLQfGBMphst2NI+EvobKBg1k=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlHKECE89aWTMpk+BTOLsSMGlsQ5PDBZzFpKrD6
 7pVALRUNgqJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZRyhAgAKCRCJcvTf3G3A
 JsAED/9rep0qQL+Uri2yFkaImn8wrEfqCeiUW1dFWN1RYWA57gJIdN2l8m9to7t7t5Qhk8gp0Wl
 TUT/iVzK8etbeuqspeyDrRAJ5ePGg2PGNCBS5ghrevJdY2fImYvh3ARSOdc4e/aFOzqLbqXaKAK
 fwLmjvTj0gcPTX63rT3vW0m3BUBNODkOb0uRZ7Y4D+Jha0Vu1Kmp8zNxpazut9zE9tf31p++P46
 Tl15RjuVZlraJnO25sQCiO2D5kFio2XrIcavvPvIvAVNMCPb8d/+n0v7veeoWKmUhHv2T4+dtBj
 CM/BxQs7ga8vX7Srtu8dFy8KqMYSUvEsWppbZBv7UIvb/+zbdKjVWDcRXwaj0nBoa3aD5vjwoef
 WBv+62w7L34Pq0OBEm87kf5hbU9sawslHfkzscuh1YhbLIwANFe13YToHZy4tXL8/hq15yS9V3g
 O8M8WLXHQISnuGDNigW84R1phmsUt5Xuqq8Gu4Nd6kk0mv2mBUu0bQEVHvKH5glOHkipYjsl+x4
 wbn8hGzVBszGzD8zrQZ5r3UBiPBuM4tSqO5Wb7LQPWIyB3/KvMwK2DGdCY7dQOiD0z+wbHxHrP4
 FFDWH3HyBf9odaSZGGyOFqdaCpNJKZ6RyVW8BSBJrHHwqWjANX+jFn7TODlZ6UKXpA9uWpZEWSf
 SNOYZmX OgJF6EZg==
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

As found with Coccinelle[1], add __counted_by for struct mlx5_fc_bulk.

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
 drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c
index 17fe30a4c06c..0c26d707eed2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c
@@ -539,7 +539,7 @@ struct mlx5_fc_bulk {
 	u32 base_id;
 	int bulk_len;
 	unsigned long *bitmask;
-	struct mlx5_fc fcs[];
+	struct mlx5_fc fcs[] __counted_by(bulk_len);
 };
 
 static void mlx5_fc_init(struct mlx5_fc *counter, struct mlx5_fc_bulk *bulk,
-- 
2.34.1

