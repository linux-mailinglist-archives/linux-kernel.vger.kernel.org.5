Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72196780A44
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 12:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376312AbjHRKfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 06:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376531AbjHRKef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 06:34:35 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A67E420E;
        Fri, 18 Aug 2023 03:33:24 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qWwn6-005H3N-Ju; Fri, 18 Aug 2023 18:33:17 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 18 Aug 2023 18:33:17 +0800
Date:   Fri, 18 Aug 2023 18:33:17 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     davem@davemloft.net, dhowells@redhat.com, pabeni@redhat.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+cba21d50095623218389@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] crypto: fix uninit-value in af_alg_free_resources
Message-ID: <ZN9I7TYiT0ElRca2@gondor.apana.org.au>
References: <20230813122344.14142-1-paskripkin@gmail.com>
 <20230814180341.8621-1-paskripkin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814180341.8621-1-paskripkin@gmail.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,TVD_RCVD_IP,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 09:03:41PM +0300, Pavel Skripkin wrote:
> Syzbot was able to trigger use of uninitialized memory in
> af_alg_free_resources.
> 
> Bug is caused by missing initialization of rsgl->sgl.need_unpin before
> adding to rsgl_list. Then in case of extract_iter_to_sg() failure, rsgl
> is left with uninitialized need_unpin which is read during clean up
> 
> BUG: KMSAN: uninit-value in af_alg_free_sg crypto/af_alg.c:545 [inline]
> BUG: KMSAN: uninit-value in af_alg_free_areq_sgls crypto/af_alg.c:778 [inline]
> BUG: KMSAN: uninit-value in af_alg_free_resources+0x3d1/0xf60 crypto/af_alg.c:1117
>  af_alg_free_sg crypto/af_alg.c:545 [inline]
>  af_alg_free_areq_sgls crypto/af_alg.c:778 [inline]
>  af_alg_free_resources+0x3d1/0xf60 crypto/af_alg.c:1117
>  _skcipher_recvmsg crypto/algif_skcipher.c:144 [inline]
> ...
> 
> Uninit was created at:
>  slab_post_alloc_hook+0x12f/0xb70 mm/slab.h:767
>  slab_alloc_node mm/slub.c:3470 [inline]
>  __kmem_cache_alloc_node+0x536/0x8d0 mm/slub.c:3509
>  __do_kmalloc_node mm/slab_common.c:984 [inline]
>  __kmalloc+0x121/0x3c0 mm/slab_common.c:998
>  kmalloc include/linux/slab.h:586 [inline]
>  sock_kmalloc+0x128/0x1c0 net/core/sock.c:2683
>  af_alg_alloc_areq+0x41/0x2a0 crypto/af_alg.c:1188
>  _skcipher_recvmsg crypto/algif_skcipher.c:71 [inline]
> 
> Fixes: c1abe6f570af ("crypto: af_alg: Use extract_iter_to_sg() to create scatterlists")
> Reported-and-tested-by: syzbot+cba21d50095623218389@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=cba21d50095623218389
> Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
> ---
> 
> Changes since v1:
> 	- Move sgl.need_unpin initialization upper instead of
> 	  pre-initializing it with false as suggested by David
> 
> ---
>  crypto/af_alg.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
