Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A50E7A26FE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 21:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236587AbjIOTMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 15:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237084AbjIOTLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 15:11:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62EFFB;
        Fri, 15 Sep 2023 12:11:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58F84C433C7;
        Fri, 15 Sep 2023 19:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694805104;
        bh=IIDXBilgYAneCN/K2/MuOtg+9tUcnGL2d4QYXB9Cw5E=;
        h=Date:From:To:Cc:Subject:From;
        b=ROjc3G6vf0mbKgyCUv2ffJE3OCLUUI8UgG1FpZlN7sUBj3U60h82ohjf+dQwDwIr5
         mjY3eC4WjOluKDZUZWZ/s+prYh1hQe/ABLGpmi87IQttMOGklRePtm11Jplsi7WdOO
         sgbXBJ4cZfXfMyhRk/ByV8r7qJWs3Z+h7yOwIiy+Cfjro97ozQLM71Z7G58QLqHcnD
         hrRfPRja3Lp2hBof2+z43xZ2PDB0aweG3K/ab3U5qd7WHrIjZbr8R6OQTFdcn5uq22
         do8ziQM5OrWT97WPF/CWRyYMAtOjvVT907dQSdZ0ltR3AZV8zj8+lHi2I7q+1q+91d
         yazLwwwgtzFdA==
Date:   Fri, 15 Sep 2023 13:12:38 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Boris Pismenny <borisp@nvidia.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] tls: Use size_add() in call to struct_size()
Message-ID: <ZQSspmE8Ww8/UNkH@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If, for any reason, the open-coded arithmetic causes a wraparound,
the protection that `struct_size()` adds against potential integer
overflows is defeated. Fix this by hardening call to `struct_size()`
with `size_add()`.

Fixes: b89fec54fd61 ("tls: rx: wrap decrypt params in a struct")
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 net/tls/tls_sw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index d1fc295b83b5..270712b8d391 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1487,7 +1487,7 @@ static int tls_decrypt_sg(struct sock *sk, struct iov_iter *out_iov,
 	 */
 	aead_size = sizeof(*aead_req) + crypto_aead_reqsize(ctx->aead_recv);
 	aead_size = ALIGN(aead_size, __alignof__(*dctx));
-	mem = kmalloc(aead_size + struct_size(dctx, sg, n_sgin + n_sgout),
+	mem = kmalloc(aead_size + struct_size(dctx, sg, size_add(n_sgin, n_sgout)),
 		      sk->sk_allocation);
 	if (!mem) {
 		err = -ENOMEM;
-- 
2.34.1

