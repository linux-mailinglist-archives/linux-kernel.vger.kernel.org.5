Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C155A7F0B52
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 05:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbjKTEQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 23:16:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbjKTEQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 23:16:01 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62248D4F
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 20:15:35 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6b709048d8eso3421830b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 20:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1700453735; x=1701058535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I3yQNAV5i9i/OMA9ll/UNVMs7Fn6oZ5qFKK0D5McEKU=;
        b=d0vGKCk4zGx5Jop+QSR74xHH7BtSZE4ftth39YxjQjjfWGuayxxLq6UGPNKNIBdiL3
         GMSRSFvGFpl0PNU/DJi2xAwEa/ViynzkTEky0lpHfIEBeDA4So6liI0SPR68ahTSPPmf
         ghzbSc0j3L2ctAB282Uuc9MDfvqEfDIVffnesBwajJm5eHgJjXePpZbuH3Z/1MGVVfkd
         5UpZI3iOkccLRez16SQKjYsx2LoK2tJQ6C5GQcOEjqu6MVbHuLI6vWl5qAKHlRu2VCQ1
         NcNp6f2vM+fziWBp0+hN+Y5KsEw1VGFeg2KRmAXwtpjDjI/EH6oRRqrk2gRPzkAH1Qkz
         KCNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700453735; x=1701058535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I3yQNAV5i9i/OMA9ll/UNVMs7Fn6oZ5qFKK0D5McEKU=;
        b=uEThkmMS7toVeQaqlw1wCSVtboVgVpLedvQFKC41wHipTCVFq6lNPlBGpHC0O+s5MS
         jVPFF3Lihe7+ZOpQEPPgTBaWeRTPJCJbdlTPASqBgr9AepRVTPwq/SZkkq4kK034BqQr
         0YtKlHwKgXXsTKCfE5yDB2Kgu0HkRgcOJbaFCpWK6bSfwQK7268kaIBhyClGznbVsnQe
         3S05hrIEcihknamljoFfisUJM8PjfaaPcMraVWDnE/eTOAPyDJvvI7hboOe590FF4jBi
         YotyMGDEa0BaKWvwj02/U7T7BYlj+bYJ+AUP7ePkBIPwAqFdLO2MJjBI3yJAuZqmWznG
         3zUA==
X-Gm-Message-State: AOJu0YyA0GkyQMQbrzl1YDQ3nizXgF/zUb8pgFOWQRgJWabGcsv8iTZ6
        LWVfFoEYmYiIhsoq1wwMgFYZZg==
X-Google-Smtp-Source: AGHT+IFkSm1NBdoY7dzAdsWmGn420PY4USgPH4erEC9WZuyziRFrX75OKDKwLGHvlN5iggDKFyl5pw==
X-Received: by 2002:a05:6a20:438d:b0:187:b4f2:b025 with SMTP id i13-20020a056a20438d00b00187b4f2b025mr5073423pzl.27.1700453734859;
        Sun, 19 Nov 2023 20:15:34 -0800 (PST)
Received: from C02G705SMD6V.bytedance.net ([61.213.176.5])
        by smtp.gmail.com with ESMTPSA id h18-20020a170902f7d200b001cc4e477861sm5065266plw.212.2023.11.19.20.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 20:15:34 -0800 (PST)
From:   Jia Zhu <zhujia.zj@bytedance.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com
Cc:     linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, jefflexu@linux.alibaba.com,
        hsiangkao@linux.alibaba.com, Jia Zhu <zhujia.zj@bytedance.com>,
        Xin Yin <yinxin.x@bytedance.com>
Subject: [PATCH V6 RESEND 4/5] cachefiles: narrow the scope of triggering EPOLLIN events in ondemand mode
Date:   Mon, 20 Nov 2023 12:14:21 +0800
Message-Id: <20231120041422.75170-5-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20231120041422.75170-1-zhujia.zj@bytedance.com>
References: <20231120041422.75170-1-zhujia.zj@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't trigger EPOLLIN when there are only reopening read requests in
xarray.

Suggested-by: Xin Yin <yinxin.x@bytedance.com>
Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/cachefiles/daemon.c   | 14 ++++++++++++--
 fs/cachefiles/internal.h | 12 ++++++++++++
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index aa4efcabb5e3..70caa1946207 100644
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -355,14 +355,24 @@ static __poll_t cachefiles_daemon_poll(struct file *file,
 					   struct poll_table_struct *poll)
 {
 	struct cachefiles_cache *cache = file->private_data;
+	XA_STATE(xas, &cache->reqs, 0);
+	struct cachefiles_req *req;
 	__poll_t mask;
 
 	poll_wait(file, &cache->daemon_pollwq, poll);
 	mask = 0;
 
 	if (cachefiles_in_ondemand_mode(cache)) {
-		if (!xa_empty(&cache->reqs))
-			mask |= EPOLLIN;
+		if (!xa_empty(&cache->reqs)) {
+			rcu_read_lock();
+			xas_for_each_marked(&xas, req, ULONG_MAX, CACHEFILES_REQ_NEW) {
+				if (!cachefiles_ondemand_is_reopening_read(req)) {
+					mask |= EPOLLIN;
+					break;
+				}
+			}
+			rcu_read_unlock();
+		}
 	} else {
 		if (test_bit(CACHEFILES_STATE_CHANGED, &cache->flags))
 			mask |= EPOLLIN;
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index b9a90f1a0c01..26e5f8f123ef 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -329,6 +329,13 @@ cachefiles_ondemand_set_object_##_state(struct cachefiles_object *object) \
 CACHEFILES_OBJECT_STATE_FUNCS(open, OPEN);
 CACHEFILES_OBJECT_STATE_FUNCS(close, CLOSE);
 CACHEFILES_OBJECT_STATE_FUNCS(reopening, REOPENING);
+
+static inline bool cachefiles_ondemand_is_reopening_read(struct cachefiles_req *req)
+{
+	return cachefiles_ondemand_object_is_reopening(req->object) &&
+			req->msg.opcode == CACHEFILES_OP_READ;
+}
+
 #else
 static inline ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 					char __user *_buffer, size_t buflen)
@@ -359,6 +366,11 @@ static inline int cachefiles_ondemand_init_obj_info(struct cachefiles_object *ob
 static inline void cachefiles_ondemand_deinit_obj_info(struct cachefiles_object *obj)
 {
 }
+
+static inline bool cachefiles_ondemand_is_reopening_read(struct cachefiles_req *req)
+{
+	return false;
+}
 #endif
 
 /*
-- 
2.20.1

