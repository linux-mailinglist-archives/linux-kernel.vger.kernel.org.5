Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4EE88005EA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 09:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377888AbjLAIji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 03:39:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377878AbjLAIjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 03:39:33 -0500
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027DE1713
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 00:39:40 -0800 (PST)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-58d956c8c38so1047523eaf.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 00:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701419979; x=1702024779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HAD/BJOp3KfcAEwToEpZAFOpfcfSAx6mao3aBhe0GVs=;
        b=fOftkOdjSW3o0FXm6twOtVVAn04q2GIaFHpMitI+XsVqySe/WDltjjm4EpHmV6/6Vs
         MquYTSl8iG2kG5MJx119L/+ri8Lc1IlMUvfj4Aham58cEwbR/fwJREtIcl5GNf4VH+Vy
         rz1OEz9YYevRQ6pzDkWEi0G7eG/ffF7+SeTz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701419979; x=1702024779;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HAD/BJOp3KfcAEwToEpZAFOpfcfSAx6mao3aBhe0GVs=;
        b=V/0u2js1thNBTfvl5KNAj92WhKpq+rd2gyGDIEttC9SgNmXyrvMyLQCpwbUMXnAHUx
         V08slpg3iKcGYKS/3YjSRT/WZBe35hwlReWKXwk8yL2Xk3qFaEolVIKtpFwb5ebIgCT9
         22hAomSxvGv0+fhGnJ1mnPyo5sNL/8OxgIYGmI+ApHYdY3Q1f9Bh3HzxAQuAWub+AduM
         F/WDtaa/IRt5/sqXuXCIf9Q/brz6L28kic0Qc2Nj8mji2ykoQW5F3hFzz2ZLmrJP9Ehu
         2mmgWh78N6eJrJ1KdP4Ch4+Er5Pz4kv4MCx5K0pwYOebBjzUkRhA+n2ZLr7nb52y31b4
         NrRg==
X-Gm-Message-State: AOJu0Yy6e6/eBLLXNxo0iE8hPOqeiYkACIxAPILbI0oa3jEHigqBERKB
        KniQMMGUVo2NV4EjyObEuMxeOA==
X-Google-Smtp-Source: AGHT+IFRIZi1t3+6sB5l+ZFlRb5IEgTuJyz64lMyM/xKkArWyB7tZ0RcUsK3ZoDsk1o6uNy6C/voyA==
X-Received: by 2002:a05:6358:3a0e:b0:16d:d643:4800 with SMTP id g14-20020a0563583a0e00b0016dd6434800mr25665290rwe.21.1701419979280;
        Fri, 01 Dec 2023 00:39:39 -0800 (PST)
Received: from judyhsiao0523.c.googlers.com.com (148.175.199.104.bc.googleusercontent.com. [104.199.175.148])
        by smtp.gmail.com with ESMTPSA id hy7-20020a056a006a0700b0068790c41ca2sm2500089pfb.27.2023.12.01.00.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 00:39:38 -0800 (PST)
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
        Luis Chamberlain <mcgrof@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH v1] neighbour: Don't let neigh_forced_gc() disable preemption for long
Date:   Fri,  1 Dec 2023 08:39:03 +0000
Message-ID: <20231201083926.1817394-1-judyhsiao@chromium.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

 net/core/neighbour.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index df81c1f0a570..f7a89c7a7673 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -256,6 +256,8 @@ static int neigh_forced_gc(struct neigh_table *tbl)
 	unsigned long tref = jiffies - 5 * HZ;
 	struct neighbour *n, *tmp;
 	int shrunk = 0;
+	bool finish = true;
+	unsigned long timeout = jiffies + msecs_to_jiffies(1);        /* timeout in 1ms */
 
 	NEIGH_CACHE_STAT_INC(tbl, forced_gc_runs);
 
@@ -278,10 +280,14 @@ static int neigh_forced_gc(struct neigh_table *tbl)
 				shrunk++;
 			if (shrunk >= max_clean)
 				break;
+			if (time_after(jiffies, timeout)) {
+				finish = false;
+				break;
+			}
 		}
 	}
-
-	WRITE_ONCE(tbl->last_flush, jiffies);
+	if (finish)
+		WRITE_ONCE(tbl->last_flush, jiffies);
 
 	write_unlock_bh(&tbl->lock);
 
-- 
2.43.0.rc2.451.g8631bc7472-goog

