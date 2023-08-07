Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D88B772C67
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 19:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjHGRNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 13:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbjHGRMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 13:12:33 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DAA2112;
        Mon,  7 Aug 2023 10:12:13 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bc1c1c68e2so29731165ad.3;
        Mon, 07 Aug 2023 10:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691428332; x=1692033132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GuYmHdMlJJm2W9mV95yYZgg2mXFJPDcfJ3tRYlFlHrM=;
        b=sS/VIkX47fuVcUKRL0cK2M6E4NLixhZ4dvdNS5yQN4wZFBy/NvIcAIDOMZlKsXmnaT
         qkDx6Msrx6ax7/jxstRRx0hXiYyaxZ0P18SReVIfZihM+jpDoIgxeTRi1VJiTGt14zrd
         P9J9ggKq9lMjx/HHtAbuuOWs1lt9BYwyoYqsgPht33IVBW2Eirc3VmswvwSewQFCxKwM
         O3MuO+NqJ8Dfwcsuv7rkzrrYP2GrO4uGOocy+Hlge+VqB4OktDEw1EqafkJF+luWzT19
         nXviOpAdXA/FraF/OBm3t0i5VZn9CAzp6HAetxm4cFUjErFyCxZhyaaeqx+CtLXh+olQ
         vwUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691428332; x=1692033132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GuYmHdMlJJm2W9mV95yYZgg2mXFJPDcfJ3tRYlFlHrM=;
        b=bJZIEwNe/4n639OeS/blvL/+8OoOn6VL1XFjFku5AoU1bRwzaOIT+HnbBeZVm4Fw9P
         ueIYHpduEYJVF0FjqrJWV0HYcI/xZ8OJEavlFgpBv5BzMzc19RccPmhiRGvyPbdt5oqD
         M2phyLMcMYCCLmlUbhmsFoA/d/6EvpF2+lYpO7Rbard+NBMw2Df3ZS6yTIckIog+g7qV
         0RbbT/Onu7stwGYPJB++n12MjovTuaH0hf0XSYbXyBKVa/tUuIZPYDeyPgAPXbh77Dx1
         SF5UOmyo9m85kLCCHTua9dkuNFExWsC3dKeEELBNhnGr+wKPqslR6Nelr8UZMr8ffAxP
         KZXA==
X-Gm-Message-State: AOJu0YxWOhoYoxMeAGouSEAykhOChpGt4pLBuVWiS3VscXP8aUk9SslK
        lddOaKjSOTZCaU8vTmfewlA=
X-Google-Smtp-Source: AGHT+IHNX8/tpl8CGO0R5k+B2yYyWetCEGj10aF8tXzMfdM+leuP+DXeencaiMPqZLDVUD4/bv0C8g==
X-Received: by 2002:a17:903:32d0:b0:1bb:14e7:4fd0 with SMTP id i16-20020a17090332d000b001bb14e74fd0mr9285594plr.7.1691428331973;
        Mon, 07 Aug 2023 10:12:11 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:6c80:7c10:75a0:44f4])
        by smtp.gmail.com with ESMTPSA id b4-20020a170902b60400b001a95f632340sm7159020pls.46.2023.08.07.10.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 10:12:11 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Georgi Djakov <djakov@kernel.org>,
        linux-pm@vger.kernel.org (open list:INTERCONNECT API),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 7/9] interconnect: Teach lockdep about icc_bw_lock order
Date:   Mon,  7 Aug 2023 10:11:41 -0700
Message-ID: <20230807171148.210181-8-robdclark@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230807171148.210181-1-robdclark@gmail.com>
References: <20230807171148.210181-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Teach lockdep that icc_bw_lock is needed in code paths that could
deadlock if they trigger reclaim.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/interconnect/core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index e15a92a79df1..1afbc4f7c6e7 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -1041,13 +1041,21 @@ void icc_sync_state(struct device *dev)
 			}
 		}
 	}
+	mutex_unlock(&icc_bw_lock);
 	mutex_unlock(&icc_lock);
 }
 EXPORT_SYMBOL_GPL(icc_sync_state);
 
 static int __init icc_init(void)
 {
-	struct device_node *root = of_find_node_by_path("/");
+	struct device_node *root;
+
+	/* Teach lockdep about lock ordering wrt. shrinker: */
+	fs_reclaim_acquire(GFP_KERNEL);
+	might_lock(&icc_bw_lock);
+	fs_reclaim_release(GFP_KERNEL);
+
+	root = of_find_node_by_path("/");
 
 	providers_count = of_count_icc_providers(root);
 	of_node_put(root);
-- 
2.41.0

