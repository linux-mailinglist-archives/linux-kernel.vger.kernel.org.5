Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9477BC733
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 13:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343868AbjJGLfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 07:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234077AbjJGLfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 07:35:50 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628DAB6
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 04:35:49 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c888b3a25aso18306765ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 07 Oct 2023 04:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696678549; x=1697283349; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OC5rK9qIvmSdPXizzl/i9ObN30hGdlyAdlMZVQnqKXg=;
        b=K5H+UEla4XKesj6cptxpzyXdK7lwBWNrnQNfGBTQ3VCufjx2ttlJssyb+Ri/OYfWf6
         Cr2sRRsvyGqNqXipALr9w29SStciAxTghxiSJGjIastzZNsjnJUziFN8Mf+RyhyXWSgg
         6EdNCsBKaHZ4M9UuoaX1cuAqmlS1bHxPkdCA0tZyyjzlaSzYgh2Rdww/KSPR0OUgtNBJ
         Dav5UhuX/Oaq3pTAnqTknA6rP1dCYIRUr2l71MncyhkqHoD9HLYVOqITvVYFbQmK2dHy
         2GoZ/52/FBKAc4Uft9/TLn873LJ62yJCFRJUaAFkuYUm8im/SC84PrSi+3x0pBxNLeO1
         LM8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696678549; x=1697283349;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OC5rK9qIvmSdPXizzl/i9ObN30hGdlyAdlMZVQnqKXg=;
        b=k1MeQ/fKnE3ckg3U64jJWCfc4eN5KWl+efoseytYqAKXTdkCucJ6u/CUa9ByRzjqsW
         Vx4dhw8dUuNtNpOEsAe7B0thTBx3QwA5PAzsj0ZKENvNX3Uac8E9bQ1XiEK6il8vGFvH
         csEmTHBwlMYceLsS+JoO4O9J5gDGau6EnjYrQVoVYo8tRjejEbOwiXqfH8N50jpMocYI
         qmduoh3DBxzuJBM6yZFCeM19ThpYftEbnfW5XR+ZxG8rVS929o0JY+C4XkvYzf4CRRxU
         kW04ZrrHfSwoGm9FAKhJkdsWBfCOvD7Ot4PhqYtEC68wXlfNg3X+ng+395vkz9veXQA1
         /DpA==
X-Gm-Message-State: AOJu0YzNCKgitldyyImt85a2n7AOqTcDnI5Ph5iVPSvKciE9Aw85miJm
        OgjSXx25Ih80PzFXvQAphKE=
X-Google-Smtp-Source: AGHT+IFGS4xEFxEK4CNGp2eHbWcpIv/5M8gJnT1EnZbppV++n/iNOba81CMqMX3VJ37zaJmygvbthA==
X-Received: by 2002:a17:902:c404:b0:1c3:e130:18f1 with SMTP id k4-20020a170902c40400b001c3e13018f1mr12797969plk.20.1696678548670;
        Sat, 07 Oct 2023 04:35:48 -0700 (PDT)
Received: from MSCND1355B05.fareast.nevint.com ([183.242.39.186])
        by smtp.gmail.com with ESMTPSA id c18-20020a170903235200b001c62b9a51c0sm5664973plh.103.2023.10.07.04.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 04:35:48 -0700 (PDT)
From:   Zqiang <qiang.zhang1211@gmail.com>
To:     tj@kernel.org, jiangshanlai@gmail.com
Cc:     qiang.zhang1211@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH] workqueue: Use the kmem_cache_free() instead of kfree() to release pwq
Date:   Sat,  7 Oct 2023 19:35:41 +0800
Message-Id: <20231007113541.8365-1-qiang.zhang1211@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pwq objects is allocated by kmem_cache_alloc(), this commit therefore
use kmem_cache_free() instead of kfree() to release pwq objects and also
make use the correct tracepoint("trace_kmem_cache_free") to trace the
release of pwq.

Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
---
 kernel/workqueue.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index ebe24a5e1435..6f74cab2bd5a 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4610,8 +4610,12 @@ static int alloc_and_link_pwqs(struct workqueue_struct *wq)
 
 enomem:
 	if (wq->cpu_pwq) {
-		for_each_possible_cpu(cpu)
-			kfree(*per_cpu_ptr(wq->cpu_pwq, cpu));
+		for_each_possible_cpu(cpu) {
+			struct pool_workqueue *pwq = *per_cpu_ptr(wq->cpu_pwq, cpu);
+
+			if (pwq)
+				kmem_cache_free(pwq_cache, pwq);
+		}
 		free_percpu(wq->cpu_pwq);
 		wq->cpu_pwq = NULL;
 	}
-- 
2.17.1

