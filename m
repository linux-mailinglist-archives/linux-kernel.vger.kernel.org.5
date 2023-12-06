Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0125F8065B4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 04:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376494AbjLFDjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 22:39:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjLFDjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 22:39:16 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3190122
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 19:39:22 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6d9a1c13ea6so1772186a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 19:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701833962; x=1702438762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W3sE9AMuF5Cpcz2r27jKfNNhaZ7KU7EZsUTmYqK/6Ww=;
        b=BuN9/3Pdku7aKoLTQFi6OllEfhpmuwClWyND6ZxD26rXszmIK3lum1ZjSCBrnXnYlm
         mtcdp6wMYNBkta09uioYQPbPh0ncrE4oELfF5hCWj4CgHTjdQyWs01X/3dJR7ZAqpm7z
         8XnHuvms8zMkdAFcGR4MOax31jalprP2OaYyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701833962; x=1702438762;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W3sE9AMuF5Cpcz2r27jKfNNhaZ7KU7EZsUTmYqK/6Ww=;
        b=I8PDYDMX4MF5BOct3I35wLa7wX0WDH4ZJvh6VCvoSSMHAbXlRysvc2wlqfkLyTvupk
         7hLLxP+XHJ/sin9qt906awRL9CRJCcdaCb45hFwUFSf7wPg1NHcMTBxj1B1T1p/o2kd1
         matRzWLvwezpkTPbrgp1M1bARoAPNJ20158RMdaJi/IkNocDmHFq9hTQa8I5S3a+Ks+m
         v3hgM+OIqkdMEJ0japWl84VEMxTee5DiIpCQ8WTHv3x1CYd/V9G9mnx4q0OHDMc43oWv
         UR1jtqmXPNfFzQnPZ+0qhOVhdNfWOh1JI453x9rq+yeN4WWhmBEWRWUioOpP/PwG2bVW
         8Mkw==
X-Gm-Message-State: AOJu0YyZpTKl89v44spkXhb5SLGCBtYhEHqnc1EexirGhTQKNSZnve5a
        lef5UbFKkjTyNnI8Kl6WXcI4iQ==
X-Google-Smtp-Source: AGHT+IEtFlNImFsK/ttpZ11z7F7eXCOIhz+TBaFImOqS82wKsVg8xHnrKbMV8+ikLOdwwH689z351Q==
X-Received: by 2002:a9d:6ace:0:b0:6d8:74e2:6351 with SMTP id m14-20020a9d6ace000000b006d874e26351mr380949otq.43.1701833962233;
        Tue, 05 Dec 2023 19:39:22 -0800 (PST)
Received: from judyhsiao0523.c.googlers.com.com (198.180.199.104.bc.googleusercontent.com. [104.199.180.198])
        by smtp.gmail.com with ESMTPSA id r8-20020aa78b88000000b006889511ab14sm10132447pfd.37.2023.12.05.19.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 19:39:21 -0800 (PST)
From:   Judy Hsiao <judyhsiao@chromium.org>
To:     Eric Dumazet <edumazet@google.com>,
        David Ahern <dsahern@kernel.org>,
        Simon Horman <horms@kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Judy Hsiao <judyhsiao@chromium.org>,
        Brian Haley <haleyb.dev@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Joel Granados <joel.granados@gmail.com>,
        Julian Anastasov <ja@ssi.bg>,
        Leon Romanovsky <leon@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH v2] neighbour: Don't let neigh_forced_gc() disable preemption for long
Date:   Wed,  6 Dec 2023 03:38:33 +0000
Message-ID: <20231206033913.1290566-1-judyhsiao@chromium.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are seeing cases where neigh_cleanup_and_release() is called by
neigh_forced_gc() many times in a row with preemption turned off.
When running on a low powered CPU at a low CPU frequency, this has
been measured to keep preemption off for ~10 ms. That's not great on a
system with HZ=1000 which expects tasks to be able to schedule in
with ~1ms latency.

Suggested-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Judy Hsiao <judyhsiao@chromium.org>

---

Changes in v2:
- Use ktime_get_ns() for timeout calculation instead of jiffies.

 net/core/neighbour.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index df81c1f0a570..552719c3bbc3 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -253,9 +253,11 @@ static int neigh_forced_gc(struct neigh_table *tbl)
 {
 	int max_clean = atomic_read(&tbl->gc_entries) -
 			READ_ONCE(tbl->gc_thresh2);
+	u64 tmax = ktime_get_ns() + NSEC_PER_MSEC;
 	unsigned long tref = jiffies - 5 * HZ;
 	struct neighbour *n, *tmp;
 	int shrunk = 0;
+	int loop = 0;
 
 	NEIGH_CACHE_STAT_INC(tbl, forced_gc_runs);
 
@@ -278,11 +280,16 @@ static int neigh_forced_gc(struct neigh_table *tbl)
 				shrunk++;
 			if (shrunk >= max_clean)
 				break;
+			if (++loop == 16) {
+				if (ktime_get_ns() > tmax)
+					goto unlock;
+				loop = 0;
+			}
 		}
 	}
 
 	WRITE_ONCE(tbl->last_flush, jiffies);
-
+unlock:
 	write_unlock_bh(&tbl->lock);
 
 	return shrunk;
-- 
2.43.0.rc2.451.g8631bc7472-goog

