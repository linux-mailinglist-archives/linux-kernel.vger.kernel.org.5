Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDAA7FFC0A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 21:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376637AbjK3UMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 15:12:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376596AbjK3UMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 15:12:18 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F31310FF
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 12:12:24 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1cfae5ca719so12803335ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 12:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701375143; x=1701979943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f0qCHVo7XzgiM/gOkeUKMtC009iJZbF6DLauLv10AR0=;
        b=OQ9rBmLHsdjdQ294mwxh7moyfDaokLIaUc1KpfSs9Ja/kLPTTSyqzZHbJqhIK77DME
         mC9T1C0MP5SECbGGKeeAMqq1fHoE2yJSxHoujE45USwHqx7NI2Wnpd6x3AyDEi9RUqxF
         VoZd3HAMZ9ZUK9XGjSxdSwCzxOuqHNwH33k90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701375143; x=1701979943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f0qCHVo7XzgiM/gOkeUKMtC009iJZbF6DLauLv10AR0=;
        b=WEZor/ghqc9rqir059FzIbzfvy3V6FvSUJuejQJraz0NIyPvcXuy28JzBMPaCpGVZs
         ZQlWns4UoeIDy9hrgOnLVvoDu/eSmM95CoV2x+mp/v773HYCpfg9qE+WrkE23mcUhGV5
         hfeoLMYuqet3hABdv0B88yu233ENqv9CeS2vvSUthtec00WbIfkv2G2F4eoT91o2GpH1
         L5ADPWLB93HfngmUpUWmdHBzwBoQ4VItn38bndKpvL4/nYqVzuTDBLHay1OeD0a5GS17
         4HYzR+Nj8w6d6Ius3gkr6oJpYE8SYlisVVAjZDdnK3nDYMEh36zwnoaCmyhhAu68JCWj
         aseg==
X-Gm-Message-State: AOJu0YyTIKVA5hGdbHta6M0tEtxLXye98B5TKnHhAJO98BtjyoY/NdVP
        sl8kxgRb0wwhSYUXxxIkU5h86w==
X-Google-Smtp-Source: AGHT+IG7GB1EAs6x6BGig4Qdnq8J7tH7U+ck4TUN97KpzMVewKtuS3lBCHehX3Fj143SB3P6el4zJA==
X-Received: by 2002:a17:902:be12:b0:1cf:9e9f:fddf with SMTP id r18-20020a170902be1200b001cf9e9ffddfmr22774377pls.44.1701375143633;
        Thu, 30 Nov 2023 12:12:23 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id v1-20020a1709029a0100b001cfb573674fsm1800131plp.30.2023.11.30.12.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 12:12:23 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>, Tejun Heo <tj@kernel.org>,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH v2 1/3] kernfs: Convert kernfs_walk_ns() from strlcpy() to strscpy()
Date:   Thu, 30 Nov 2023 12:12:17 -0800
Message-Id: <20231130201222.3613535-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231130200937.it.424-kees@kernel.org>
References: <20231130200937.it.424-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1627; i=keescook@chromium.org;
 h=from:subject; bh=KaMikVVf9IlMYxhWSymwvYJ80Grx9jhkkXD92Gcwols=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlaOyjg8fq+Kgz91M5MgN0iGKTEy9c1pTW6k2g3
 Om7gwyq3vSJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZWjsowAKCRCJcvTf3G3A
 JvipD/9bZ1YWV76igC9fhSpnzKbHHp6551cCO3pInR0GeFHntgT5F19ANIOxgzmIBPsQZGJzh+S
 YT33if7BAW5mJS6SW0/JwpmKCMt8jUN5Dw4H+uwr/lSO2v1JBLUv65KaJHbKxOuKYhf/K8m+KeC
 G15UFTVEgDW8PCfT6tFshli/Pl5byyOhNZEAfR5ojzzeErfO0NoGkBPtn2kmyDnE1ttT+Eo1dZd
 bYa7mFWYeoYxpu2W/8DvsErrwskB2vYVPqSDoJrl2frQE+xkzNZCO5ru8Vjw7GXgE+t0DiYt8hg
 F7iw8uygmx11wG/5naWBwc/NsxsKeqPK6yeHqXtYWRU4ACZEC0D3eoa0n5sHaNjE9no1jRL5yub
 Br09TCk7VxJLPDv+qbH2QMY/ebs2zICGc+P+E04Ee8r3TuzfEI1NARDnNLfY0s2n9g6qy2jZYfy
 trVptzxRK9qS8DEBJtkRYr8LOD7nEwBM3xsmLANcgWYAcxDR4zGMlHRPuqg2YNHYqR5OGl4jEGq
 Y/a19aWEub4yvainVlv8qmZzWncVUktEIvBYR8tKuVcO6HxIlp9LsRTeTfYZsOmM5/EN1piG0yR
 RKr/6Sg6QBCZuCORc73txJPy9xzWq24oCIWbt3xq7SBvSQhoxYgbp9sJ/sTC4nO0ZlN0uBjgqTc gLWikxOalpnj9pA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strlcpy() reads the entire source buffer first. This read may exceed
the destination size limit. This is both inefficient and can lead
to linear read overflows if a source string is not NUL-terminated[1].
Additionally, it returns the size of the source string, not the
resulting size of the destination string. In an effort to remove strlcpy()
completely[2], replace strlcpy() here with strscpy().

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy [1]
Link: https://github.com/KSPP/linux/issues/89 [2]
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Azeem Shaikh <azeemshaikh38@gmail.com>
Link: https://lore.kernel.org/r/20231116192127.1558276-1-keescook@chromium.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/kernfs/dir.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 8b2bd65d70e7..37353901ede1 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -850,16 +850,16 @@ static struct kernfs_node *kernfs_walk_ns(struct kernfs_node *parent,
 					  const unsigned char *path,
 					  const void *ns)
 {
-	size_t len;
+	ssize_t len;
 	char *p, *name;
 
 	lockdep_assert_held_read(&kernfs_root(parent)->kernfs_rwsem);
 
 	spin_lock_irq(&kernfs_pr_cont_lock);
 
-	len = strlcpy(kernfs_pr_cont_buf, path, sizeof(kernfs_pr_cont_buf));
+	len = strscpy(kernfs_pr_cont_buf, path, sizeof(kernfs_pr_cont_buf));
 
-	if (len >= sizeof(kernfs_pr_cont_buf)) {
+	if (len < 0) {
 		spin_unlock_irq(&kernfs_pr_cont_lock);
 		return NULL;
 	}
-- 
2.34.1

