Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E9877BF7E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 20:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjHNSD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 14:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbjHNSDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 14:03:46 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE8010DE;
        Mon, 14 Aug 2023 11:03:45 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b9bf52cd08so67904551fa.2;
        Mon, 14 Aug 2023 11:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692036224; x=1692641024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mC2VXhQU4CT2VksXFrqMrSWVDm6lE1KSTIG6MCJKlyQ=;
        b=B8d6JJ6vW2JP8DGhMzF0cTe3zGMnkA4RxRa1jsozlrNhPTyVmQ5SAwEoO9bNgk2w7v
         1ms1nzq7zCAtDzuvEYwNaev7Z1+luCvPIeln/Wc/JTfSBQ/qTaO1lxeLFjhaySwZMjYX
         ayGiCT2+rlBFHjDkF2hPapu8aItQ+uGLFc2VLvHwF4iFNS1RNHUEHcDFTPZXhhd1O+72
         ZGlmZseLXq5bilRyskGf38w8iCfFkMtHxic7DwzIcTRZEqSPZQ2ULzp9rubTzkd50EJY
         YGo+JD7yeNg7q3USjyqULjhQ1RVkppodbSfOctTMTgDFfKEjYq+knnoiPVHLMyIf0HD7
         PmNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692036224; x=1692641024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mC2VXhQU4CT2VksXFrqMrSWVDm6lE1KSTIG6MCJKlyQ=;
        b=CUQ8jRBmrDL9OWczQoJgmhI2qRPZvE4+LgpvXFpBwkvUEgyijqTdRZgzxiFOHfzPOD
         37IHU7MKT7SL6tzbD2Gu7veu2x0Qqrw1mBitCalFpHCpjppzc94FvvhPML6TKAuhpHhV
         LLWmx9JSoBHn2mzJD8oZKkNJcBOb7ycwSRWQtbuoaD86YDqZpcyDedNyF1TPF8xWsbMG
         VkUrOoeh0YcHGtMqILTY7wkWN/fIYUFLnl0zOmwbRimEiEOv8aex0JEh2tQPqiwt7RE6
         qCN+LaEL4t8Fjwetf+VrDDENDpxrHCSKlfJ5X/dg9YwJJFiN6h/86Z+zra+tQWUrWz6V
         DAYA==
X-Gm-Message-State: AOJu0YwnjWQdhbnd98zw7lVK6axNqNPi+IAejhrZ1SQBeT+pCW5TRnmf
        cTsM2Huwx5kTFWmgHLHaKII=
X-Google-Smtp-Source: AGHT+IF7gMEe3vJFVMtOlRZ218BSwotA2DoAUSs7z9Qnop0AdryTgdrg8UGTSqHeqnJrfyGq70r//g==
X-Received: by 2002:a2e:930d:0:b0:2b9:f27f:e491 with SMTP id e13-20020a2e930d000000b002b9f27fe491mr7567188ljh.42.1692036223664;
        Mon, 14 Aug 2023 11:03:43 -0700 (PDT)
Received: from fedora.. ([2a00:1370:8180:6b00:a1a8:4887:1af4:637a])
        by smtp.gmail.com with ESMTPSA id p24-20020a2ea418000000b002b1b92910c8sm2552460ljn.86.2023.08.14.11.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 11:03:43 -0700 (PDT)
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        dhowells@redhat.com, pabeni@redhat.com
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>,
        syzbot+cba21d50095623218389@syzkaller.appspotmail.com
Subject: [PATCH v2] crypto: fix uninit-value in af_alg_free_resources
Date:   Mon, 14 Aug 2023 21:03:41 +0300
Message-Id: <20230814180341.8621-1-paskripkin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230813122344.14142-1-paskripkin@gmail.com>
References: <20230813122344.14142-1-paskripkin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syzbot was able to trigger use of uninitialized memory in
af_alg_free_resources.

Bug is caused by missing initialization of rsgl->sgl.need_unpin before
adding to rsgl_list. Then in case of extract_iter_to_sg() failure, rsgl
is left with uninitialized need_unpin which is read during clean up

BUG: KMSAN: uninit-value in af_alg_free_sg crypto/af_alg.c:545 [inline]
BUG: KMSAN: uninit-value in af_alg_free_areq_sgls crypto/af_alg.c:778 [inline]
BUG: KMSAN: uninit-value in af_alg_free_resources+0x3d1/0xf60 crypto/af_alg.c:1117
 af_alg_free_sg crypto/af_alg.c:545 [inline]
 af_alg_free_areq_sgls crypto/af_alg.c:778 [inline]
 af_alg_free_resources+0x3d1/0xf60 crypto/af_alg.c:1117
 _skcipher_recvmsg crypto/algif_skcipher.c:144 [inline]
...

Uninit was created at:
 slab_post_alloc_hook+0x12f/0xb70 mm/slab.h:767
 slab_alloc_node mm/slub.c:3470 [inline]
 __kmem_cache_alloc_node+0x536/0x8d0 mm/slub.c:3509
 __do_kmalloc_node mm/slab_common.c:984 [inline]
 __kmalloc+0x121/0x3c0 mm/slab_common.c:998
 kmalloc include/linux/slab.h:586 [inline]
 sock_kmalloc+0x128/0x1c0 net/core/sock.c:2683
 af_alg_alloc_areq+0x41/0x2a0 crypto/af_alg.c:1188
 _skcipher_recvmsg crypto/algif_skcipher.c:71 [inline]

Fixes: c1abe6f570af ("crypto: af_alg: Use extract_iter_to_sg() to create scatterlists")
Reported-and-tested-by: syzbot+cba21d50095623218389@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=cba21d50095623218389
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---

Changes since v1:
	- Move sgl.need_unpin initialization upper instead of
	  pre-initializing it with false as suggested by David

---
 crypto/af_alg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/crypto/af_alg.c b/crypto/af_alg.c
index 06b15b9f661c..10efb56d8b48 100644
--- a/crypto/af_alg.c
+++ b/crypto/af_alg.c
@@ -1241,6 +1241,8 @@ int af_alg_get_rsgl(struct sock *sk, struct msghdr *msg, int flags,
 				return -ENOMEM;
 		}
 
+		rsgl->sgl.need_unpin =
+			iov_iter_extract_will_pin(&msg->msg_iter);
 		rsgl->sgl.sgt.sgl = rsgl->sgl.sgl;
 		rsgl->sgl.sgt.nents = 0;
 		rsgl->sgl.sgt.orig_nents = 0;
@@ -1255,8 +1257,6 @@ int af_alg_get_rsgl(struct sock *sk, struct msghdr *msg, int flags,
 		}
 
 		sg_mark_end(rsgl->sgl.sgt.sgl + rsgl->sgl.sgt.nents - 1);
-		rsgl->sgl.need_unpin =
-			iov_iter_extract_will_pin(&msg->msg_iter);
 
 		/* chain the new scatterlist with previous one */
 		if (areq->last_rsgl)
-- 
2.40.1

