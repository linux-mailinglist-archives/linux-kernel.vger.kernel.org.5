Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A04E27B33B5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 15:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233387AbjI2NeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 09:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbjI2NeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 09:34:03 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4E71AC
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 06:34:02 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c5db4925f9so5094835ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 06:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695994442; x=1696599242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=azoAECka1qG7hbjMpMLuBitjG49sO6K0wZNSLJW8ov4=;
        b=ZU2o/w+P4unIA3i8xHCijq9RxxFxkWrjTnxlKqjIvHozcOoGHM94B7/b3G5kIXuGOi
         m58GZXCLuvorXfowv7aGMoLbRlqhDENnhnIwWKla45oJAuXUdC7DHin5TuUb+W25Etdg
         8W7wuhXvkG6ksd1dNQzO47kxiV1iAfxxrleBuMX4CF6GXr6V8dHCaqtqI1GRVCIZ23OE
         n7yqH3Koe4h6qB/oPpMzn8Xl6bDFVKaIAWNhKxYITfkbCeaXLT9cPTrMAa2zsUGqY7vY
         v04rKM9GOlVONBt+4fdzHHrWJ2wCtjqB01gEo5OSgb8RJQOMzz6NOnX0XVtgrZSI2PNW
         0E/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695994442; x=1696599242;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=azoAECka1qG7hbjMpMLuBitjG49sO6K0wZNSLJW8ov4=;
        b=qnm/Yj3freblpwakP93gez15MyobTI4bGHWs6ndzg4siFgq6yUSc1eoYOISWMidiN2
         9bQGzYK0puefsvlq/f+HDC+Tpw7G7pqlCH4ZLViqy1JNO5GBsyIXpGcczmw37UMBYyaq
         +R3Z0Ko7498wh5CY/7mJk9L85Kchp9KAeuTyOI1sdqD3n2CmCPTSMuq3dyT9nJC+ep0o
         d4VEFRqqP8J7Bblk2vch371lS8B4cRGfoBt0mi8egDqwH0JfRBogMGJJ3k9Z44VQHHps
         hzRA/N0zFiBTz5E3UtlFcmxdVXrh3e7HWMtWbZQZVHvYd6efzDw+YJWzSZxHVyqAHPU/
         jRnA==
X-Gm-Message-State: AOJu0Ywdskk1xTJteTQwiHqg2IIrgop8draBwPpfGfZCpZ9ZEskrTNvN
        E5khluDWh88Ri1JCU9LePSRTEYU4HmNX2A==
X-Google-Smtp-Source: AGHT+IHCJH59/Udfa8JUc7SQyMOgYgg1fXYEOgrnqxqgko6Qluq+CWhczST28WmL1KpCsBDjokFSlg==
X-Received: by 2002:a17:902:c651:b0:1be:f37f:a8d5 with SMTP id s17-20020a170902c65100b001bef37fa8d5mr5573740pls.10.1695994441654;
        Fri, 29 Sep 2023 06:34:01 -0700 (PDT)
Received: from masabert ([202.12.244.3])
        by smtp.gmail.com with ESMTPSA id a20-20020a170903101400b001c731b62403sm3635597plb.218.2023.09.29.06.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 06:34:01 -0700 (PDT)
Received: by masabert (Postfix, from userid 1000)
        id 353E72360885; Fri, 29 Sep 2023 22:33:59 +0900 (JST)
From:   Masanari Iida <standby24x7@gmail.com>
To:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, vschneid@redhat.com
Cc:     Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH] sched/topology: Fix a spelling typo in message.
Date:   Fri, 29 Sep 2023 22:33:45 +0900
Message-Id: <20230929133345.259360-1-standby24x7@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a spelling typo in toloplogy.c

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 kernel/sched/topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index a7b50bba7829..1a993844ba24 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2305,7 +2305,7 @@ static struct sched_domain *build_sched_domain(struct sched_domain_topology_leve
 
 		if (!cpumask_subset(sched_domain_span(child),
 				    sched_domain_span(sd))) {
-			pr_err("BUG: arch topology borken\n");
+			pr_err("BUG: arch topology broken\n");
 #ifdef CONFIG_SCHED_DEBUG
 			pr_err("     the %s domain not a subset of the %s domain\n",
 					child->name, sd->name);
-- 
2.41.0

