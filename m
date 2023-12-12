Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E76CE80F4AA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 18:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346521AbjLLReU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 12:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232358AbjLLReT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 12:34:19 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894FF8E;
        Tue, 12 Dec 2023 09:34:25 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-28abd1ecb85so602476a91.0;
        Tue, 12 Dec 2023 09:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702402464; x=1703007264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kOjHx9AciPI0bIXgcXZ7IgsUeZnP8qbNbJ9CPNPXPQE=;
        b=lHWQAdTXFMDmV/UPQDigQ/B08OhulArDOg8M+HDT7yHh7mIp/ksVoYLE8jYPITDQza
         J8lWRrDDn4ezQdvsm49m1eaYNe+PO+HOdAXmnJHFDl/yvwkjBl8QGeOQurUNfkA6zEKw
         7A+lB/xA1EquCDk7wKtVLVCWGYAxy6K9Z9tT/B8550VQF2zwH/lSAUgK1Sjl4p8bxMy0
         tsmAYgTH5YlxFCvzW+pS3nmxlEaqPcO02IQsRoYgtjHsWCaqra97vBgTdppH25VKvxfp
         At1ylBOnSUAiDbTKAeSMDkrDpCoD/66dTFU7dP1pw0dsnhesk70wgIyE33tTvPCY/xj+
         QlOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702402464; x=1703007264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kOjHx9AciPI0bIXgcXZ7IgsUeZnP8qbNbJ9CPNPXPQE=;
        b=Ol9FjyM4DgdpixGtRzFBXEvCC3GcebbpL/tS4ueNCHtKUKqL07bZXIoea3AWDpgSq5
         P+gwanrpm6Nev4xFeVaFlwDj6OgBXUei5QQ+UhCK2m23ECIHgveo5fdDwz6dfZIFkbOV
         13YrD1ght5ucZRyjVLs+JSBneXUxShIaXLli/N1zhOn97TbCiwTAdog/cmWfPLSyIx+u
         EgJ5onp6eGKl1qEMT8PWcYYrI0W/vh2AAPkCrNw7CXB/bYBYQ2gKHJKdU9Vy4JkiYpKr
         Ej3Cw5wwwFbXTqA2RcGvWLkVPnm6zKPh5bI6EWREDgqosPi/Db/pB1j4+nIVdBKMBW8C
         Gmyg==
X-Gm-Message-State: AOJu0YxbQjYw5cgnMVgO4bg2S3Nzy6e7XPU3Xp1lX8C8E1IG8RDe0mfU
        NZMrXEIdsIDe1yHnAfasuDx1u8l+w5qRGifM
X-Google-Smtp-Source: AGHT+IE4wTs42pptzmoD3ldD3SBz8bD8IWZocjwoJa+8yqUeJ3f9fVmRfb++MOlvMkmXmtizjwyDVg==
X-Received: by 2002:a17:90b:b14:b0:286:c399:7c16 with SMTP id bf20-20020a17090b0b1400b00286c3997c16mr3097304pjb.44.1702402463875;
        Tue, 12 Dec 2023 09:34:23 -0800 (PST)
Received: from localhost.localdomain ([101.0.63.152])
        by smtp.gmail.com with ESMTPSA id nc4-20020a17090b37c400b00285545ac9d2sm9213862pjb.47.2023.12.12.09.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 09:34:23 -0800 (PST)
From:   "Neeraj Upadhyay (AMD)" <neeraj.iitr10@gmail.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, paulmck@kernel.org, Neeraj.Upadhyay@amd.com,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>
Subject: [PATCH rcu 1/4] locktorture: Increase Hamming distance between call_rcu_chain and rcu_call_chains
Date:   Tue, 12 Dec 2023 23:04:11 +0530
Message-Id: <20231212173414.11602-1-neeraj.iitr10@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231212173334.GA11572@neeraj.linux>
References: <20231212173334.GA11572@neeraj.linux>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

One letter difference is really not enough, so this commit changes
call_rcu_chain to call_rcu_chain_list.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay (AMD) <neeraj.iitr10@gmail.com>
---
 kernel/locking/locktorture.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index 69d3cd2cfc3b..415d81e6ce70 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -124,7 +124,7 @@ struct call_rcu_chain {
 	struct rcu_head crc_rh;
 	bool crc_stop;
 };
-struct call_rcu_chain *call_rcu_chain;
+struct call_rcu_chain *call_rcu_chain_list;
 
 /* Forward reference. */
 static void lock_torture_cleanup(void);
@@ -1074,12 +1074,12 @@ static int call_rcu_chain_init(void)
 
 	if (call_rcu_chains <= 0)
 		return 0;
-	call_rcu_chain = kcalloc(call_rcu_chains, sizeof(*call_rcu_chain), GFP_KERNEL);
-	if (!call_rcu_chain)
+	call_rcu_chain_list = kcalloc(call_rcu_chains, sizeof(*call_rcu_chain_list), GFP_KERNEL);
+	if (!call_rcu_chain_list)
 		return -ENOMEM;
 	for (i = 0; i < call_rcu_chains; i++) {
-		call_rcu_chain[i].crc_stop = false;
-		call_rcu(&call_rcu_chain[i].crc_rh, call_rcu_chain_cb);
+		call_rcu_chain_list[i].crc_stop = false;
+		call_rcu(&call_rcu_chain_list[i].crc_rh, call_rcu_chain_cb);
 	}
 	return 0;
 }
@@ -1089,13 +1089,13 @@ static void call_rcu_chain_cleanup(void)
 {
 	int i;
 
-	if (!call_rcu_chain)
+	if (!call_rcu_chain_list)
 		return;
 	for (i = 0; i < call_rcu_chains; i++)
-		smp_store_release(&call_rcu_chain[i].crc_stop, true);
+		smp_store_release(&call_rcu_chain_list[i].crc_stop, true);
 	rcu_barrier();
-	kfree(call_rcu_chain);
-	call_rcu_chain = NULL;
+	kfree(call_rcu_chain_list);
+	call_rcu_chain_list = NULL;
 }
 
 static void lock_torture_cleanup(void)
-- 
2.40.1

