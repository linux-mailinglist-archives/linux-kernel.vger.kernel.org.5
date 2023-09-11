Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D4D79C0D5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358795AbjIKWNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235955AbjIKJrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:47:01 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C124E4A
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 02:46:57 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c39500767aso6232585ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 02:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694425617; x=1695030417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FXa1LVTr7cMGrveLuEzAv2/sv0TRtu2+M0j9hstuDhg=;
        b=BaRzbLov5BT4pw/1CESQTlJ40A4oFsf/vNTGEkFZ5sTNaIpW+njPUTjTgHU1xeZdNr
         w8+bj0rh5Ko4tl8fy+3AG5N6ntHkuAMZAfvnrSWJ5s40pfUyhpK425X0XtX6kP6qUmqm
         sssKIUMe2uV2pupUB724NI76IfVmqTQ1A56xcRV3XPhtXYXDFBtIQ5CDxl2ucnxA6p9G
         FpKkG69Vu8TYCczUmEitM+SCIi9gyZJFHN7JcQiYKyTJIx1u+Ef2ebci403Ejx8WB+vI
         bQfvjkWmUZ5xm9afbdrpjtZ23S23PCGHHhAzc/1rrg+LPAjKJqgQpEROsyfsGDVJ7Trq
         449A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694425617; x=1695030417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FXa1LVTr7cMGrveLuEzAv2/sv0TRtu2+M0j9hstuDhg=;
        b=nRNvwSV6bjhR/GBgNwRVbV/Y4aIRcRTeU6MfxEVolQkoQyqgNx0R6UlFhbuLd5CSdq
         joFMZPdrw82Mw3YuksG+V4E1c9SndVjh9liO25M2hrAIF28FAdO94rXF0H3RNsPOOVXN
         N+wxV3V1EzuQYG92pY+fX/X4HYGW77yvcF7kpmQe6juqj7WzIZBEUoIEoq/dNJzwg/zq
         kFUofYiXT3vn9HbDdq7mJ6FZv48wV0h7jCmENpnsoHQkb4JQSsVhcLyDbxJMLd9bcUa/
         dbCLZrzJcDCX24R6/8hZSkU0pMYW4cx8DgFH3cQtf+nrvkla2FAgGBpmyzEwUxdhH2OT
         m4zA==
X-Gm-Message-State: AOJu0Yx4Eb5lrzO43CPGJ9BfMLeik6+n8p3YxZ2PwK/mCmBHkJDrI9XF
        cQ7DMv1pNfV/NbYetKEQdyW38g==
X-Google-Smtp-Source: AGHT+IHKZ7oB5FMEwi+qCC0j2E1ekjFtKsjq/92jKkTijP5Pj32E0W6thfocXbY8FqhF+sPzRd82Ug==
X-Received: by 2002:a17:902:d508:b0:1c1:fbec:bc32 with SMTP id b8-20020a170902d50800b001c1fbecbc32mr10679560plg.6.1694425616764;
        Mon, 11 Sep 2023 02:46:56 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id az7-20020a170902a58700b001bdc2fdcf7esm5988188plb.129.2023.09.11.02.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 02:46:56 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        muchun.song@linux.dev
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        linux-nfs@vger.kernel.org
Subject: [PATCH v6 12/45] nfsd: dynamically allocate the nfsd-filecache shrinker
Date:   Mon, 11 Sep 2023 17:44:11 +0800
Message-Id: <20230911094444.68966-13-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230911094444.68966-1-zhengqi.arch@bytedance.com>
References: <20230911094444.68966-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use new APIs to dynamically allocate the nfsd-filecache shrinker.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
CC: Chuck Lever <chuck.lever@oracle.com>
CC: Jeff Layton <jlayton@kernel.org>
CC: Neil Brown <neilb@suse.de>
CC: Olga Kornievskaia <kolga@netapp.com>
CC: Dai Ngo <Dai.Ngo@oracle.com>
CC: Tom Talpey <tom@talpey.com>
CC: linux-nfs@vger.kernel.org
---
 fs/nfsd/filecache.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index ee9c923192e0..9c62b4502539 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -521,11 +521,7 @@ nfsd_file_lru_scan(struct shrinker *s, struct shrink_control *sc)
 	return ret;
 }
 
-static struct shrinker	nfsd_file_shrinker = {
-	.scan_objects = nfsd_file_lru_scan,
-	.count_objects = nfsd_file_lru_count,
-	.seeks = 1,
-};
+static struct shrinker *nfsd_file_shrinker;
 
 /**
  * nfsd_file_cond_queue - conditionally unhash and queue a nfsd_file
@@ -746,12 +742,19 @@ nfsd_file_cache_init(void)
 		goto out_err;
 	}
 
-	ret = register_shrinker(&nfsd_file_shrinker, "nfsd-filecache");
-	if (ret) {
-		pr_err("nfsd: failed to register nfsd_file_shrinker: %d\n", ret);
+	nfsd_file_shrinker = shrinker_alloc(0, "nfsd-filecache");
+	if (!nfsd_file_shrinker) {
+		ret = -ENOMEM;
+		pr_err("nfsd: failed to allocate nfsd_file_shrinker\n");
 		goto out_lru;
 	}
 
+	nfsd_file_shrinker->count_objects = nfsd_file_lru_count;
+	nfsd_file_shrinker->scan_objects = nfsd_file_lru_scan;
+	nfsd_file_shrinker->seeks = 1;
+
+	shrinker_register(nfsd_file_shrinker);
+
 	ret = lease_register_notifier(&nfsd_file_lease_notifier);
 	if (ret) {
 		pr_err("nfsd: unable to register lease notifier: %d\n", ret);
@@ -774,7 +777,7 @@ nfsd_file_cache_init(void)
 out_notifier:
 	lease_unregister_notifier(&nfsd_file_lease_notifier);
 out_shrinker:
-	unregister_shrinker(&nfsd_file_shrinker);
+	shrinker_free(nfsd_file_shrinker);
 out_lru:
 	list_lru_destroy(&nfsd_file_lru);
 out_err:
@@ -891,7 +894,7 @@ nfsd_file_cache_shutdown(void)
 		return;
 
 	lease_unregister_notifier(&nfsd_file_lease_notifier);
-	unregister_shrinker(&nfsd_file_shrinker);
+	shrinker_free(nfsd_file_shrinker);
 	/*
 	 * make sure all callers of nfsd_file_lru_cb are done before
 	 * calling nfsd_file_cache_purge
-- 
2.30.2

