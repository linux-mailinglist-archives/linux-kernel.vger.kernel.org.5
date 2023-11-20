Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 203467F0B3F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 05:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbjKTEPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 23:15:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjKTEP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 23:15:27 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A5A192
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 20:15:24 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1cc9b626a96so28409665ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 20:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1700453723; x=1701058523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NBYMzx+0ghq9rZyVtiAqDaDvPyfZ7l/tXiv5hFDBJO0=;
        b=EoV1eH8nMolHwat5vCDJ9l0P1b3M4LhUiKAYjnh0o1A/omwMQFi8hUJVICLiGb1O3D
         okrCq4TztO3iGFe/FZXhyEPTu97Eh2IYp/mnGQAQoYT9uvIwcY5ADKWpfhNFyt4sRYUt
         ohZQWBLbh8szGwMUBCdy1tXiUtDOjSpse56YS8plnVG6FZ6T2W1t67o1MUtVDIXxcTN9
         aUwnzlOUqPIHXXnlPB09Osb5PNvFneVV66sKJiKT0ZqQ71ldh/bVuJqhn5tCaI9CTazP
         Eo5xWdOuIRH9r7XJFSX9+TjnJb9WiAuNr0vNeRHOq6Kw8WbCVERQZ3a5v0Sf03l87kis
         hNgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700453723; x=1701058523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NBYMzx+0ghq9rZyVtiAqDaDvPyfZ7l/tXiv5hFDBJO0=;
        b=AOVDY6fq5JIhOO4iRdTocruOEIKtYz80GdPfaFoMiiXahiGNTdt51ixBkN35ZXlgGc
         eVu+ybJC3eYFXKWGi8GQblAQVImqicEpnb23d3Z2VtEC/AOLItAzrHc9CNmADSPIfyPB
         9glrQKDYvZkup7kDuYV02L11uGejUBILrBFH2nWEwSQZu/bHuI89Cwwwj5d0alEOKZIE
         kh2vsO8GsVHwhjx68dvYBN2sVM/KpALfiF1hUuFu5gqFWHAkGZOqawLpLPMaeHM0Dh2h
         bKPK8dzW5/TEs0Q3wjMeFoiLb6NzNUwClWTuOVUks/IPtSFPXtIcXimqePDm5jWkcZsI
         l69Q==
X-Gm-Message-State: AOJu0YwFl+KGKw+keCT4Bz8uycMTSexamZ+sny4EN+YkpT9SUZ2t+LPb
        FAXXh/DCD+jE6K/naRAOXaHwB6nCj8u9+vQmAvcPeA==
X-Google-Smtp-Source: AGHT+IFzCbeU4CTx9W7O4tgf+D6DkEWwwsoqzZ0Uet0Jse+eegf3YJcfUUdpQFUFODbxgg/IszJdgg==
X-Received: by 2002:a17:902:e54e:b0:1cc:636f:f376 with SMTP id n14-20020a170902e54e00b001cc636ff376mr4712244plf.44.1700453723651;
        Sun, 19 Nov 2023 20:15:23 -0800 (PST)
Received: from C02G705SMD6V.bytedance.net ([61.213.176.5])
        by smtp.gmail.com with ESMTPSA id h18-20020a170902f7d200b001cc4e477861sm5065266plw.212.2023.11.19.20.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 20:15:23 -0800 (PST)
From:   Jia Zhu <zhujia.zj@bytedance.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com
Cc:     linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, jefflexu@linux.alibaba.com,
        hsiangkao@linux.alibaba.com, Jia Zhu <zhujia.zj@bytedance.com>
Subject: [PATCH V6 RESEND 1/5] cachefiles: introduce object ondemand state
Date:   Mon, 20 Nov 2023 12:14:18 +0800
Message-Id: <20231120041422.75170-2-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20231120041422.75170-1-zhujia.zj@bytedance.com>
References: <20231120041422.75170-1-zhujia.zj@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, @ondemand_id field was used not only to identify ondemand
state of the object, but also to represent the index of the xarray.
This commit introduces @state field to decouple the role of @ondemand_id
and adds helpers to access it.

Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/cachefiles/internal.h | 21 +++++++++++++++++++++
 fs/cachefiles/ondemand.c | 21 +++++++++------------
 2 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 2ad58c465208..00beedeaec18 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -44,6 +44,11 @@ struct cachefiles_volume {
 	struct dentry			*fanout[256];	/* Fanout subdirs */
 };
 
+enum cachefiles_object_state {
+	CACHEFILES_ONDEMAND_OBJSTATE_CLOSE, /* Anonymous fd closed by daemon or initial state */
+	CACHEFILES_ONDEMAND_OBJSTATE_OPEN, /* Anonymous fd associated with object is available */
+};
+
 /*
  * Backing file state.
  */
@@ -62,6 +67,7 @@ struct cachefiles_object {
 #define CACHEFILES_OBJECT_USING_TMPFILE	0		/* Have an unlinked tmpfile */
 #ifdef CONFIG_CACHEFILES_ONDEMAND
 	int				ondemand_id;
+	enum cachefiles_object_state	state;
 #endif
 };
 
@@ -296,6 +302,21 @@ extern void cachefiles_ondemand_clean_object(struct cachefiles_object *object);
 extern int cachefiles_ondemand_read(struct cachefiles_object *object,
 				    loff_t pos, size_t len);
 
+#define CACHEFILES_OBJECT_STATE_FUNCS(_state, _STATE)	\
+static inline bool								\
+cachefiles_ondemand_object_is_##_state(const struct cachefiles_object *object) \
+{												\
+	return object->state == CACHEFILES_ONDEMAND_OBJSTATE_##_STATE; \
+}												\
+												\
+static inline void								\
+cachefiles_ondemand_set_object_##_state(struct cachefiles_object *object) \
+{												\
+	object->state = CACHEFILES_ONDEMAND_OBJSTATE_##_STATE; \
+}
+
+CACHEFILES_OBJECT_STATE_FUNCS(open, OPEN);
+CACHEFILES_OBJECT_STATE_FUNCS(close, CLOSE);
 #else
 static inline ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 					char __user *_buffer, size_t buflen)
diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index 0254ed39f68c..90456b8a4b3e 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -15,6 +15,7 @@ static int cachefiles_ondemand_fd_release(struct inode *inode,
 
 	xa_lock(&cache->reqs);
 	object->ondemand_id = CACHEFILES_ONDEMAND_ID_CLOSED;
+	cachefiles_ondemand_set_object_close(object);
 
 	/*
 	 * Flush all pending READ requests since their completion depends on
@@ -176,6 +177,8 @@ int cachefiles_ondemand_copen(struct cachefiles_cache *cache, char *args)
 		set_bit(FSCACHE_COOKIE_NO_DATA_TO_READ, &cookie->flags);
 	trace_cachefiles_ondemand_copen(req->object, id, size);
 
+	cachefiles_ondemand_set_object_open(req->object);
+
 out:
 	complete(&req->done);
 	return ret;
@@ -363,7 +366,8 @@ static int cachefiles_ondemand_send_req(struct cachefiles_object *object,
 		/* coupled with the barrier in cachefiles_flush_reqs() */
 		smp_mb();
 
-		if (opcode != CACHEFILES_OP_OPEN && object->ondemand_id <= 0) {
+		if (opcode != CACHEFILES_OP_OPEN &&
+			!cachefiles_ondemand_object_is_open(object)) {
 			WARN_ON_ONCE(object->ondemand_id == 0);
 			xas_unlock(&xas);
 			ret = -EIO;
@@ -430,18 +434,11 @@ static int cachefiles_ondemand_init_close_req(struct cachefiles_req *req,
 					      void *private)
 {
 	struct cachefiles_object *object = req->object;
-	int object_id = object->ondemand_id;
 
-	/*
-	 * It's possible that object id is still 0 if the cookie looking up
-	 * phase failed before OPEN request has ever been sent. Also avoid
-	 * sending CLOSE request for CACHEFILES_ONDEMAND_ID_CLOSED, which means
-	 * anon_fd has already been closed.
-	 */
-	if (object_id <= 0)
+	if (!cachefiles_ondemand_object_is_open(object))
 		return -ENOENT;
 
-	req->msg.object_id = object_id;
+	req->msg.object_id = object->ondemand_id;
 	trace_cachefiles_ondemand_close(object, &req->msg);
 	return 0;
 }
@@ -460,7 +457,7 @@ static int cachefiles_ondemand_init_read_req(struct cachefiles_req *req,
 	int object_id = object->ondemand_id;
 
 	/* Stop enqueuing requests when daemon has closed anon_fd. */
-	if (object_id <= 0) {
+	if (!cachefiles_ondemand_object_is_open(object)) {
 		WARN_ON_ONCE(object_id == 0);
 		pr_info_once("READ: anonymous fd closed prematurely.\n");
 		return -EIO;
@@ -485,7 +482,7 @@ int cachefiles_ondemand_init_object(struct cachefiles_object *object)
 	 * creating a new tmpfile as the cache file. Reuse the previously
 	 * allocated object ID if any.
 	 */
-	if (object->ondemand_id > 0)
+	if (cachefiles_ondemand_object_is_open(object))
 		return 0;
 
 	volume_key_size = volume->key[0] + 1;
-- 
2.20.1

