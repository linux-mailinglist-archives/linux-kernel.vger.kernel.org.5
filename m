Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E09E76D4C7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbjHBRKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 13:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232590AbjHBRJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:09:47 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0452B30F1
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 10:09:36 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-314417861b9so50468f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 10:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690996175; x=1691600975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9JXyrEikc3QRlWp5ZDjTpySdvtRjTtey3fpa/M0v9NY=;
        b=geuk+efyXZZ7bJlsEuhZfXB544jaiq13WtOYQ6V5CYcHjBb8P/eXLF5AwO0V+qSh8A
         lq7n9a+FxHXrJy9SaszDJzeDo2R6OQ8roA4Bus4J9eYKE8jEiNL13YWPWr65cmNvMlp4
         NbsBhU91qq33U40eqEa8UeOs3GBNeoSXSo4ME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690996175; x=1691600975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9JXyrEikc3QRlWp5ZDjTpySdvtRjTtey3fpa/M0v9NY=;
        b=jPUsJxX+h9LP9CIN60lHY1/TKJwNbr0bBHxVH6ZG/SaJJICQg2jaGSZ0FdGt5jtdaQ
         Fu4EvjzUTELjd5rSWJ/WTQ40pRhALOQ3yMkXe3D0mMFvs/IP5vmP9kzM0cg/PXUUGzV5
         i+i0dJdUwnx3MEIcrJGldvgQqS4tENVeVsKMgLBfXP1aZvtv+nyjNgYG7JZY/zbv9fa9
         85Bx6NcshnQXl6Ts89Xr2y41F/TR3qlbgcP/dnVrmacwl8SytRPM+K0Eo23/XkxnJ15c
         zBQPdK58cYU3zRS/pq5dH/J4YxJULSIgcqs69blIavxcEq49to5eZ/lJXF72fTtMMWhC
         hWfw==
X-Gm-Message-State: ABy/qLY4FepTTVZTEO0FOCDQahJX6t5PoB/hB4GsyVL9WFmMnKPRcP4h
        ciDWN19AD4eZgl6PzGuxWJZrmw==
X-Google-Smtp-Source: APBJJlEHrrXECtPdvO8iK3tMF69agBXEGUdVPex6vTfKSLGX0OejbkIg0UJ3blbMa5bYKZ6k1f1rvA==
X-Received: by 2002:adf:fc90:0:b0:317:6cca:a68a with SMTP id g16-20020adffc90000000b003176ccaa68amr5572520wrr.41.1690996174731;
        Wed, 02 Aug 2023 10:09:34 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:4fa6:1e54:d09:5ba3])
        by smtp.gmail.com with ESMTPSA id s1-20020a5d4ec1000000b003063db8f45bsm19508396wrv.23.2023.08.02.10.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 10:09:33 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sctp@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        hillf.zj@alibaba-inc.com, marcelo.leitner@gmail.com,
        lucien.xin@gmail.com, Florent Revest <revest@chromium.org>,
        syzbot+d769eed29cc42d75e2a3@syzkaller.appspotmail.com,
        syzbot+610ec0671f51e838436e@syzkaller.appspotmail.com
Subject: [RFC 1/1] crypto: Defer transforms destruction to a worker function
Date:   Wed,  2 Aug 2023 19:09:23 +0200
Message-ID: <20230802170923.1151605-2-revest@chromium.org>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
In-Reply-To: <20230802170923.1151605-1-revest@chromium.org>
References: <20230802170923.1151605-1-revest@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, crypto spawns can be freed in a softirq context (eg: from
sctp socket destruction's rcu callbacks). In that context, grabbing the
crypto_alg_sem is dangerous and makes CONFIG_DEBUG_ATOMIC_SLEEP scream.

Defer transform destruction to a worker function so they don't use that
semaphore in a softirq.

Reported-by: syzbot+d769eed29cc42d75e2a3@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d769eed29cc42d75e2a3
Reported-by: syzbot+610ec0671f51e838436e@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=610ec0671f51e838436e
Signed-off-by: Florent Revest <revest@chromium.org>
---
 crypto/api.c           | 26 ++++++++++++++++++--------
 include/linux/crypto.h |  3 +++
 2 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/crypto/api.c b/crypto/api.c
index b9cc0c906efe..f877251954d5 100644
--- a/crypto/api.c
+++ b/crypto/api.c
@@ -640,6 +640,21 @@ void *crypto_alloc_tfm_node(const char *alg_name,
 }
 EXPORT_SYMBOL_GPL(crypto_alloc_tfm_node);
 
+void crypto_destroy_tfm_workfn(struct work_struct *w)
+{
+	struct crypto_alg *alg;
+	struct crypto_tfm *tfm;
+
+	tfm = container_of(w, struct crypto_tfm, free_work);
+	alg = tfm->__crt_alg;
+
+	if (!tfm->exit && alg->cra_exit)
+		alg->cra_exit(tfm);
+	crypto_exit_ops(tfm);
+	crypto_mod_put(alg);
+	kfree_sensitive(tfm->to_free);
+}
+
 /*
  *	crypto_destroy_tfm - Free crypto transform
  *	@mem: Start of tfm slab
@@ -650,20 +665,15 @@ EXPORT_SYMBOL_GPL(crypto_alloc_tfm_node);
  */
 void crypto_destroy_tfm(void *mem, struct crypto_tfm *tfm)
 {
-	struct crypto_alg *alg;
-
 	if (IS_ERR_OR_NULL(mem))
 		return;
 
 	if (!refcount_dec_and_test(&tfm->refcnt))
 		return;
-	alg = tfm->__crt_alg;
 
-	if (!tfm->exit && alg->cra_exit)
-		alg->cra_exit(tfm);
-	crypto_exit_ops(tfm);
-	crypto_mod_put(alg);
-	kfree_sensitive(mem);
+	tfm->to_free = mem;
+	INIT_WORK(&tfm->free_work, crypto_destroy_tfm_workfn);
+	queue_work(system_unbound_wq, &tfm->free_work);
 }
 EXPORT_SYMBOL_GPL(crypto_destroy_tfm);
 
diff --git a/include/linux/crypto.h b/include/linux/crypto.h
index 31f6fee0c36c..34ff2e1dca2b 100644
--- a/include/linux/crypto.h
+++ b/include/linux/crypto.h
@@ -430,6 +430,9 @@ struct crypto_tfm {
 	
 	struct crypto_alg *__crt_alg;
 
+	struct work_struct free_work;
+	void *to_free;
+
 	void *__crt_ctx[] CRYPTO_MINALIGN_ATTR;
 };
 
-- 
2.41.0.585.gd2178a4bd4-goog

