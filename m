Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDCC27E3323
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 03:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbjKGChc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 21:37:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjKGChb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 21:37:31 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1C7129
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 18:37:27 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c5056059e0so74173551fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 18:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1699324645; x=1699929445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G2ag1vqlZRaktWdg6szgML9cajZnEi6ZYK3MTjrbTdg=;
        b=JlfLPzha0yJfaAZPfxhTA4qtghQ2mVNhXKnfKH4oLwhrZ5J4nCBj85RbmFTYcrIk3D
         PSV89sEKZa3FL/pYfI2dG/2W47xLvaMSX0JqrT9PelxlH9gmfDMGl/lJ8sEpe5ef+DiJ
         HSVeCntlxRdN3GyC3R/7tfvtcy6RNZws7bp3m/rO4ls/SdOLBINJMRT6ZyQZSW1c+UbT
         JNjFHuaXNCLG8wHl1vM2sWEW9szBELg1PwHJx4zr8HtBYPShh1kg+F8CuGHHgGunZNQC
         ZqpeAK+HFahN7OInPsPbCiA9PCYsW9RPZRppA0qYAT4pl8U8AZ+6mViZuBOfDLAyCKk6
         S8qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699324645; x=1699929445;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G2ag1vqlZRaktWdg6szgML9cajZnEi6ZYK3MTjrbTdg=;
        b=caeArhQ4AM8zxa01kVv16ZFBF5adVWVcr1M14zWDN/mzpqh/tMPeuWots89g5nLKfZ
         tvaFuHO7h/8S+9mkairxzQp0fTrZy0QDDzf/DCatq2g3kO+bvtQ4GLravFNFr3en6eeq
         9svtoOI+QFm6J30kXLEJLYlqNjW56RMC2GT2rooWY2bLH/SJUiywqKL6OpYsdWV0UFQN
         C2IjgZcKZQ78QYqf4tOLAKosUG6FVmxzGVYuj1KtH3kh5W2z6/F7Ocx9FXNxu5JE/z1r
         vpNp1SCduiZRQexLmRZemCxfqLGUS1ZsOr/eAAiNiJc9HPncL/zwH157eDOKmFLENKem
         Bw6Q==
X-Gm-Message-State: AOJu0Yya4a9pF9pL9chF/or+dD6ASaXnzqN/tFfz0/edArPGAfnCeaP5
        po2EeNPwVdd3dEtIPPnQ9/870g==
X-Google-Smtp-Source: AGHT+IHW1r1GDscl/3LTXeATPrP+sGKKFYl+mpOOf5TrjPtTC+ZJxF1cjKDEqt+QizXIr6dGf0sv7g==
X-Received: by 2002:a2e:b0dc:0:b0:2c5:174b:9a53 with SMTP id g28-20020a2eb0dc000000b002c5174b9a53mr23870747ljl.26.1699324645325;
        Mon, 06 Nov 2023 18:37:25 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id s7-20020a05600c45c700b003fc16ee2864sm13949594wmo.48.2023.11.06.18.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 18:37:24 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-kernel@vger.kernel.org, Dmitry Safonov <dima@arista.com>,
        David Ahern <dsahern@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Eric Biggers <ebiggers@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Francesco Ruggeri <fruggeri05@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Salam Noureddine <noureddine@arista.com>,
        netdev@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: [PATCH] crypto: ahash - Set using_shash for cloned ahash wrapper over shash
Date:   Tue,  7 Nov 2023 02:37:17 +0000
Message-ID: <20231107023717.820093-1-dima@arista.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cloned child of ahash that uses shash under the hood should use
shash helpers (like crypto_shash_setkey()).

The following panic may be observed on TCP-AO selftests:

> ==================================================================
> BUG: KASAN: wild-memory-access in crypto_mod_get+0x1b/0x60
> Write of size 4 at addr 5d5be0ff5c415e14 by task connect_ipv4/1397
>
> CPU: 0 PID: 1397 Comm: connect_ipv4 Tainted: G        W          6.6.0+ #47
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x46/0x70
>  kasan_report+0xc3/0xf0
>  kasan_check_range+0xec/0x190
>  crypto_mod_get+0x1b/0x60
>  crypto_spawn_alg+0x53/0x140
>  crypto_spawn_tfm2+0x13/0x60
>  hmac_init_tfm+0x25/0x60
>  crypto_ahash_setkey+0x8b/0x100
>  tcp_ao_add_cmd+0xe7a/0x1120
>  do_tcp_setsockopt+0x5ed/0x12a0
>  do_sock_setsockopt+0x82/0x100
>  __sys_setsockopt+0xe9/0x160
>  __x64_sys_setsockopt+0x60/0x70
>  do_syscall_64+0x3c/0xe0
>  entry_SYSCALL_64_after_hwframe+0x46/0x4e
> ==================================================================
> general protection fault, probably for non-canonical address 0x5d5be0ff5c415e14: 0000 [#1] PREEMPT SMP KASAN
> CPU: 0 PID: 1397 Comm: connect_ipv4 Tainted: G    B   W          6.6.0+ #47
> Call Trace:
>  <TASK>
>  ? die_addr+0x3c/0xa0
>  ? exc_general_protection+0x144/0x210
>  ? asm_exc_general_protection+0x22/0x30
>  ? add_taint+0x26/0x90
>  ? crypto_mod_get+0x20/0x60
>  ? crypto_mod_get+0x1b/0x60
>  ? ahash_def_finup_done1+0x58/0x80
>  crypto_spawn_alg+0x53/0x140
>  crypto_spawn_tfm2+0x13/0x60
>  hmac_init_tfm+0x25/0x60
>  crypto_ahash_setkey+0x8b/0x100
>  tcp_ao_add_cmd+0xe7a/0x1120
>  do_tcp_setsockopt+0x5ed/0x12a0
>  do_sock_setsockopt+0x82/0x100
>  __sys_setsockopt+0xe9/0x160
>  __x64_sys_setsockopt+0x60/0x70
>  do_syscall_64+0x3c/0xe0
>  entry_SYSCALL_64_after_hwframe+0x46/0x4e
>  </TASK>
> RIP: 0010:crypto_mod_get+0x20/0x60

Make sure that the child/clone has using_shash set when parent is
an shash user.

Fixes: 2f1f34c1bf7b ("crypto: ahash - optimize performance when wrapping shash")
Cc: David Ahern <dsahern@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: Eric Biggers <ebiggers@google.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Francesco Ruggeri <fruggeri05@gmail.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Salam Noureddine <noureddine@arista.com>
Cc: netdev@vger.kernel.org
Cc: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 crypto/ahash.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/crypto/ahash.c b/crypto/ahash.c
index deee55f939dc..80c3e5354711 100644
--- a/crypto/ahash.c
+++ b/crypto/ahash.c
@@ -651,6 +651,7 @@ struct crypto_ahash *crypto_clone_ahash(struct crypto_ahash *hash)
 			err = PTR_ERR(shash);
 			goto out_free_nhash;
 		}
+		nhash->using_shash = true;
 		*nctx = shash;
 		return nhash;
 	}

base-commit: be3ca57cfb777ad820c6659d52e60bbdd36bf5ff
-- 
2.42.0

