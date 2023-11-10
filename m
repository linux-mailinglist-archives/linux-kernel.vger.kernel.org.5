Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2077E7E7C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 18:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235108AbjKJRpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 12:45:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345947AbjKJRoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:44:13 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077842E5E3;
        Fri, 10 Nov 2023 03:19:04 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6b77ab73c6fso1554313b3a.1;
        Fri, 10 Nov 2023 03:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699615143; x=1700219943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=whk9fs0zCzhy1i9O39uD7og53FJTww2F/GslFxYNQj8=;
        b=HS9dQxGOly8V3hsO71myRrVbdvysy7N2eJAZ399ypwaGCb30g7acqPvP/EGCndrn/W
         XYMAuiCMe/FA+LcNEn3A+AFbBW8laF2cLsYK4YNZhJj7X9NeaFbTakF+FebCRa3j8U8E
         Ixr8DEeYB4bLe467jyofxeye+4DNzNlQ4RadNT90dOONlwgClqY+SsP54z0ELzXhNaEv
         mG9nA2SCBtxt5rI2Cwrt032+JqH1onAqxJzAOSouA8UZ1agLfT/yIDcSU1eFlQRmEAEI
         tDLMC8cMBT5bVTNPuhAupdjX307ENsruBN5O+WOnPJ9OweNupcUvOCjSnxDcEcAVcucJ
         XvAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699615143; x=1700219943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=whk9fs0zCzhy1i9O39uD7og53FJTww2F/GslFxYNQj8=;
        b=j0goO4CAaPRiE7SfWibZCIjzHDz5GpOG+QK4e0VhDXTt4GQN5INB/wM+fZZwXt7sD8
         NhzwrbSzsyW0kz7Wy/n6A2FIYk0zg5Z7/jsTqkowKDMDplr7SytBAW0MT+/U380DNGru
         t+XqhTyF1k8haP79/8OBbD8gFB52SNxSr+6nIp77rC7yRmqEubzKCTT53b7Q/xaXMR3s
         QTzJHdo6S5bI0Lt2zyI76ze0XbtDJ6MR/O4g2DJho8oPJhFZsBP9PW/JM3NjKLtySKec
         oap7AZRdsFQ4ptv0DmfJYpqw892CCU5Ah8kuoMn0QGkzSFQSzJdTh9Bxz7oqfKsRr8Qg
         Ehxg==
X-Gm-Message-State: AOJu0Yw3+k/pSqX8T8DiuvbzzvzftNUjg47BlZJk12OaKN1G0KIi1rzO
        2HNGWGUt5pr+i9g9URToGQw=
X-Google-Smtp-Source: AGHT+IGw4vv33oM9rlOTVNJk3OnzI5FpCQaZiu4GqoW3Mqur9SQA9+xVcTPzCOz+GRTd4FlS7wIZVQ==
X-Received: by 2002:a05:6a00:6c87:b0:68f:cb69:8e66 with SMTP id jc7-20020a056a006c8700b0068fcb698e66mr4055742pfb.15.1699615143426;
        Fri, 10 Nov 2023 03:19:03 -0800 (PST)
Received: from ubuntu.. ([202.166.220.102])
        by smtp.gmail.com with ESMTPSA id b15-20020a056a0002cf00b00690c0cf97c9sm12444462pft.73.2023.11.10.03.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 03:19:03 -0800 (PST)
From:   Dipendra Khadka <kdipendra88@gmail.com>
To:     kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com
Cc:     Dipendra Khadka <kdipendra88@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+44c2416196b7c607f226@syzkaller.appspotmail.com
Subject: [PATCH v2] Fixes the null pointer deferences in nsim_bpf
Date:   Fri, 10 Nov 2023 11:18:23 +0000
Message-Id: <20231110111823.2775-1-kdipendra88@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231110084425.2123-1-kdipendra88@gmail.com>
References: <20231110084425.2123-1-kdipendra88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syzkaller found a null pointer dereference in nsim_bpf
originating from the lack of a null check for state.

This patch fixes the issue by adding a check for state
in two functions nsim_prog_set_loaded() and nsim_setup_prog_hw_checks()

Reported-by: syzbot+44c2416196b7c607f226@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com./bug?extid=44c2416196b7c607f226
Fixes: 31d3ad832948 ("netdevsim: add bpf offload support")
Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
---
 drivers/net/netdevsim/bpf.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/netdevsim/bpf.c b/drivers/net/netdevsim/bpf.c
index f60eb97e3a62..5d755da3c736 100644
--- a/drivers/net/netdevsim/bpf.c
+++ b/drivers/net/netdevsim/bpf.c
@@ -97,7 +97,8 @@ static void nsim_prog_set_loaded(struct bpf_prog *prog, bool loaded)
 		return;
 
 	state = prog->aux->offload->dev_priv;
-	state->is_loaded = loaded;
+	if (state)
+		state->is_loaded = loaded;
 }
 
 static int
@@ -317,9 +318,11 @@ nsim_setup_prog_hw_checks(struct netdevsim *ns, struct netdev_bpf *bpf)
 	}
 
 	state = bpf->prog->aux->offload->dev_priv;
-	if (WARN_ON(strcmp(state->state, "xlated"))) {
-		NSIM_EA(bpf->extack, "offloading program in bad state");
-		return -EINVAL;
+	if (state) {
+		if (WARN_ON(strcmp(state->state, "xlated"))) {
+			NSIM_EA(bpf->extack, "offloading program in bad state");
+			return -EINVAL;
+		}
 	}
 	return 0;
 }
-- 
2.34.1

