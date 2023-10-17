Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA0797CC555
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 15:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343984AbjJQN6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 09:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343968AbjJQN6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 09:58:02 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23CC610C
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 06:57:38 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c9d922c039so45753245ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 06:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697551058; x=1698155858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eW5Gw9lfx88ca1Dfq2MtXvfhvw7cUu9QhwY8xI1fswY=;
        b=fwtZhN5K9FT9toa56UrJZ5QMkXyIQyGnQvN45xRL9ZU+X/PlfepOs58IFyhvwBxaNP
         jmxa7jhk6QgM2NSqlDHjHr76fsth1xt6NT2lKJvx4PU2Z4nTWwb3Y/AxOzJ9RgoNkKSM
         YeAQbHjafbSaDmCacJjLnxbn1m9kduSA/P7eYlasVGLPiHa1zRKQM1TjIeVWu8FNLk3y
         SNzmGBbX+Xm9FzUfAEdCgka1b7lTUj72nTN0AC7EysE4MVkA//1JFSCAGM8AqBeWuh6Z
         e6H2XpUYTqAmh2bWkgDxDj3otcAjt+b1ox3F0UBpD02/3Vzk+V8uFmLsYk2IiK1mHnJT
         1nlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697551058; x=1698155858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eW5Gw9lfx88ca1Dfq2MtXvfhvw7cUu9QhwY8xI1fswY=;
        b=uVkIUaRi31YEJTcR4VNTzvJVmf4ftusWBJ7fYV9T4tmz43BP8POBDC8IzyLsOxLoJe
         JNgEcOTAalW2fK/sGqYmlEeVAfr3PM7eU5dZnu1+h/Ueqh58j2mKV6EKcS1pMgddzXu7
         XzHyDTOiOloKlbubxQjVyoIvQqJUbQAX7dD/K3fbCDd3p1bOiYATOmchGnpm0G9cO9aT
         O59GyMEqPFj0jqNEo81dv86So3kPl8yZgvWpF5qamfYxCeETsSP/56/pQA0pFx/NxRtZ
         pAj2O3mfQaW9ZP451PIB1UwRF2Sd35iyEjvtt1QO8qrElqV9E2Qde3LREgkg3rHDChAH
         mT4A==
X-Gm-Message-State: AOJu0YwRGSwlrizyAVzVeXmFC/omumo0AKKxcLj0aO4VPDFDX+qHW6P0
        w+2gCi8+ocviJ6XfOjO0jFVVjw==
X-Google-Smtp-Source: AGHT+IHpKgRBA8ZM+uMeoha8LLvSfXNFnKnpOzRcQHmNdHaCoUv70KRV4I33W7Rv+6GsoAEvvSh7MQ==
X-Received: by 2002:a17:902:ef8c:b0:1c3:4565:22f with SMTP id iz12-20020a170902ef8c00b001c34565022fmr2057058plb.21.1697551058231;
        Tue, 17 Oct 2023 06:57:38 -0700 (PDT)
Received: from devz1.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id b9-20020a170903228900b001b9e9edbf43sm1566634plh.171.2023.10.17.06.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 06:57:38 -0700 (PDT)
From:   "wuqiang.matt" <wuqiang.matt@bytedance.com>
To:     linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
        davem@davemloft.net, anil.s.keshavamurthy@intel.com,
        naveen.n.rao@linux.ibm.com, rostedt@goodmis.org,
        peterz@infradead.org, akpm@linux-foundation.org,
        sander@svanheule.net, ebiggers@google.com,
        dan.j.williams@intel.com, jpoimboe@kernel.org
Cc:     linux-kernel@vger.kernel.org, lkp@intel.com, mattwu@163.com,
        "wuqiang.matt" <wuqiang.matt@bytedance.com>
Subject: [PATCH v11 5/5] MAINTAINERS: objpool added
Date:   Tue, 17 Oct 2023 21:56:54 +0800
Message-Id: <20231017135654.82270-6-wuqiang.matt@bytedance.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231017135654.82270-1-wuqiang.matt@bytedance.com>
References: <20231017135654.82270-1-wuqiang.matt@bytedance.com>
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

objpool, a scalable and lockless ring-array based object pool, was
introduced to replace the original freelist (a LIFO queue based on
singly linked list) to improve kretprobe scalability.

Signed-off-by: wuqiang.matt <wuqiang.matt@bytedance.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 48abe1a281f2..1c0a38d763a2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15328,6 +15328,13 @@ F:	include/linux/objagg.h
 F:	lib/objagg.c
 F:	lib/test_objagg.c
 
+OBJPOOL
+M:	Matt Wu <wuqiang.matt@bytedance.com>
+S:	Supported
+F:	include/linux/objpool.h
+F:	lib/objpool.c
+F:	lib/test_objpool.c
+
 OBJTOOL
 M:	Josh Poimboeuf <jpoimboe@kernel.org>
 M:	Peter Zijlstra <peterz@infradead.org>
-- 
2.40.1

