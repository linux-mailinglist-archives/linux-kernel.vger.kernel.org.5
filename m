Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA5047A8DC2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 22:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjITUZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 16:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjITUZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 16:25:22 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284E0A9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 13:25:16 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c3f97f2239so1775585ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 13:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695241515; x=1695846315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HLsolMbfTcky/mq0N2Sjy3jKMIZ0cn6Kt8D7kr3ZLbA=;
        b=idg9mn+pOz1RB/T+DWxbU9bLb2yBZCtQZxGRJ1Cw2wgSnhbr2N7FHauU1DCHoSI2wL
         sp5tC5uAkPUdo0qbN0uC9hvwI7NhQp7qyuF3nA6LLOn3yko5ABoBw1mM1BD/yBtMb2Bs
         B/+V8t20M/fxY6Q6s1BjXDZx7NQjZe6xD161Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695241515; x=1695846315;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HLsolMbfTcky/mq0N2Sjy3jKMIZ0cn6Kt8D7kr3ZLbA=;
        b=pcxZ+sA+lC8s8W/NqT/Dj9REZ80UiAJHR4o6Lc4kUwNL+U5bTkcAE2eDh+D1IFFugu
         VkZh7eFJmJsPtgVCxYZ6x6rmQNWWiKv7EakZcv0TRs6NR43d574rlPtl1eUCGKhRHZoz
         HRm5jZDRHjiHfNgPoDeDJekhv1o0Yi3U+RDF7D6xy3Di2Rd6mEvDPfjSObC32rS3k83V
         ApO2ZitqsudtDNNzyFCEg05zr0ZnfzXUnyHEkuYuLJ2CGgJOHrfIGiG7gtpNYEZjkmU0
         kKu6obFj7xMUyD43+cf7yj66y/FVDJfSIfS4VLSkjrJh78AGJ1OPV7Phq6Hyw/mDkf4k
         RSPA==
X-Gm-Message-State: AOJu0YxPXTintim8R/Az6DMWJIve6bvebISJqvcd21YN4fSObOexHcr5
        QA+oC16oVpNOc0JEQn11Rh2JVA==
X-Google-Smtp-Source: AGHT+IFVHKDUobBqcyI0UFeJiGt0IUFOy3z689StXms06Ozhtc0Cb2cP58rRolqky6OedGm55dlwgw==
X-Received: by 2002:a17:902:e5cc:b0:1b9:e241:ad26 with SMTP id u12-20020a170902e5cc00b001b9e241ad26mr4977033plf.9.1695241515558;
        Wed, 20 Sep 2023 13:25:15 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id v7-20020a1709029a0700b001bdeedd8579sm12158496plp.252.2023.09.20.13.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 13:25:15 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Mirko Lindner <mlindner@marvell.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] sky2: Make sure there is at least one frag_addr available
Date:   Wed, 20 Sep 2023 13:25:13 -0700
Message-Id: <20230920202509.never.299-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2499; i=keescook@chromium.org;
 h=from:subject:message-id; bh=JtH8ia5EUsvZeslNPbo/pPdiDtP1l/CRreh41gNliXg=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlC1UoGsWV9fc6bHQBBJ+xGp+iDZyM6HX8oY2U/
 7oUvq+Eav6JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQtVKAAKCRCJcvTf3G3A
 Ju/SEACudjOkVLTvJcBjQsP/GB0DAs//hFk1Mv5SsqVjgogKa7NqyjdUkhGjwraS7pnMoKSmMtY
 1qi2Td/0KKg3cmzOZ2zPxkUjWETKIssoW/64DkYz+ekmrmc3kkg+WghfuQY0+aktxibzaFXs0aw
 XVBUVCBT94OGiTVkqdWtZQ3NXmiHgvHWC9uXl14uP/oQzJ5dzXz4dSDwx1F1pbHrR7C6f66Ynv2
 sILy3iI9t7TvCevoTMXwFu+cqa5KZbSDAIlTFn+M3cioJnoxQvpDqiKDaePd0XiWmg/qEedTGGH
 EJ+kxoPKwpkL1d3GWzeuNd0aHBjX+i/1f9XZMd1QSyQZIjvC0uzkGOg752KC8pZM/3FJqQlDRpS
 FP3CrKVbZ6JXuy2Hcb927WqGT1mJlToCFu+mU0A3ZVaUZj9+whX++YJ96OZV0iyhHV6T/Rt7FAP
 L1CAt/aT8tzMNZwe9aUnKJqwfyHUzLLE7kcfBSQLQeYzT5GfnBI722wQ8VDtXgrMPcMRwMtN2lJ
 FTYYUITeBItngwczBOaYkEHvvDODeOuMVybmSCP9sMz4FXsGE9beFINqzgfNh/3atKbW8oWdqdK
 412f+GPtp4S7BmvYpBfUOt28dt4t1ALZqpjtOBL5vDcLEy7v/vXdX+kZwsOmuOqGh9i08WhLNh8
 ihyi2/f ePgf7i1Q==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the likely pathological case of building sky2 with 16k PAGE_SIZE,
make sure there is at least 1 frag_addr in struct rx_ring_info:

   In file included from include/linux/skbuff.h:28,
                    from include/net/net_namespace.h:43,
                    from include/linux/netdevice.h:38,
                    from drivers/net/ethernet/marvell/sky2.c:18:
   drivers/net/ethernet/marvell/sky2.c: In function 'sky2_rx_unmap_skb':
   include/linux/dma-mapping.h:416:36: warning: array subscript i is outside array bounds of 'dma_addr_t[0]' {aka 'long long unsigned int[]'} [-Warray-bounds=]
     416 | #define dma_unmap_page(d, a, s, r) dma_unmap_page_attrs(d, a, s, r, 0)
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/marvell/sky2.c:1257:17: note: in expansion of macro 'dma_unmap_page'
    1257 |                 dma_unmap_page(&pdev->dev, re->frag_addr[i],
         |                 ^~~~~~~~~~~~~~
   In file included from drivers/net/ethernet/marvell/sky2.c:41:
   drivers/net/ethernet/marvell/sky2.h:2198:25: note: while referencing 'frag_addr'
    2198 |         dma_addr_t      frag_addr[ETH_JUMBO_MTU >> PAGE_SHIFT];
         |                         ^~~~~~~~~

With CONFIG_PAGE_SIZE_16KB=y, PAGE_SHIFT == 14, so:

  #define ETH_JUMBO_MTU   9000

causes "ETH_JUMBO_MTU >> PAGE_SHIFT" to be 0. Use "?: 1" to solve this build warning.

Cc: Mirko Lindner <mlindner@marvell.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202309191958.UBw1cjXk-lkp@intel.com/
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/ethernet/marvell/sky2.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/sky2.h b/drivers/net/ethernet/marvell/sky2.h
index ddec1627f1a7..8d0bacf4e49c 100644
--- a/drivers/net/ethernet/marvell/sky2.h
+++ b/drivers/net/ethernet/marvell/sky2.h
@@ -2195,7 +2195,7 @@ struct rx_ring_info {
 	struct sk_buff	*skb;
 	dma_addr_t	data_addr;
 	DEFINE_DMA_UNMAP_LEN(data_size);
-	dma_addr_t	frag_addr[ETH_JUMBO_MTU >> PAGE_SHIFT];
+	dma_addr_t	frag_addr[ETH_JUMBO_MTU >> PAGE_SHIFT ?: 1];
 };
 
 enum flow_control {
-- 
2.34.1

