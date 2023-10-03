Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070917B66E6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 12:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239754AbjJCK5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 06:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239735AbjJCK5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 06:57:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D3A9B
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 03:57:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68061C433CA;
        Tue,  3 Oct 2023 10:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696330620;
        bh=L2ltrDergf8j+6fN/XHH5Y2TY5o3ImTEqYPcQIDDz74=;
        h=Date:From:To:Cc:Subject:From;
        b=XI3o7enOreh7fRsdaT70e9scAOoD65yQRBnHI6PYbVcep0ISwndyOulaRdbTy/VTF
         0U9drLcniIQyOtYmnZjHHNM0cX3J1t8xX/uazdVob2up4RGkLBhod76s+s1+iDsUQL
         dN01yQ2zvr8ECqcQnAVSH8KQUr6SsXxDNNXQsqYQc/jksSmHJx3H5yk3pf2c9Y2a1K
         17BlOVCZDoDyXgKR5wmI0VclvNtJLyP1+ntRipJp4kFsqTQ25kh3yl4FCZrhpVs9r3
         1XOq2udkA3et5rTP2CVa8jqSzPzCLPjh2xg2J+ExgVfpFV75GBtuH+dKAgZWo1qYOW
         GmIlJrrfFpuTg==
Date:   Tue, 3 Oct 2023 12:56:54 +0200
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Ayush Sawal <ayush.sawal@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rohit Maheshwari <rohitm@chelsio.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH v2][next] cxgb4/ch_ktls: Fix undefined behavior bug in struct
 chcr_ktls_ofld_ctx_tx
Message-ID: <ZRvzdlvlbX4+eIln@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`struct tls_offload_context_tx` is a flexible structure, which means
that it contains a flexible-array member at the bottom. This could
potentially lead to an overwrite of the objects following `base` in
`struct chcr_ktls_ofld_ctx_tx` at run-time.

Notice that flexible-array member `driver_state` in `struct
tls_offload_context_tx` can grow up to 16 bytes:

| include/net/tls.h-170:
| #define TLS_DRIVER_STATE_SIZE_TX  16

| include/net/tls.h-173:
| #define TLS_OFFLOAD_CONTEXT_SIZE_TX                                     \
|	(sizeof(struct tls_offload_context_tx) + TLS_DRIVER_STATE_SIZE_TX)

| net/tls/tls_device.c-1119:
| offload_ctx = kzalloc(TLS_OFFLOAD_CONTEXT_SIZE_TX, GFP_KERNEL);

Fix this by placing the declaration of object `base` at the end of
`struct chcr_ktls_ofld_ctx_tx`.

-Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
ready to enable it globally.

Fixes: 34aba2c45024 ("cxgb4/chcr : Register to tls add and del callback")
Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v2:
 - Update changelog text: mention -Wflex-array-member-not-at-end.

v1:
 - Link: https://lore.kernel.org/linux-hardening/ZRvyysCUTqA7aXN4@work/

 drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.h b/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.h
index 10572dc55365..35e34e3db663 100644
--- a/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.h
+++ b/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.h
@@ -68,8 +68,8 @@ struct chcr_ktls_info {
 };
 
 struct chcr_ktls_ofld_ctx_tx {
-	struct tls_offload_context_tx base;
 	struct chcr_ktls_info *chcr_info;
+	struct tls_offload_context_tx base;
 };
 
 struct chcr_ktls_uld_ctx {
-- 
2.34.1

