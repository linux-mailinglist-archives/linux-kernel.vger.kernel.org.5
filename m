Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9A4380F4C6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 18:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233093AbjLLRkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 12:40:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376853AbjLLRkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 12:40:32 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2DD91;
        Tue, 12 Dec 2023 09:40:38 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1d098b87eeeso52055005ad.0;
        Tue, 12 Dec 2023 09:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702402837; x=1703007637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nPISlKbrUG0tK8lJYNvUNWP7nyNY1BbwflsKiLuTFi0=;
        b=eZPlRk2iIfqZrnHaPFJ9Bf1vEpZG3EJ+6rO6/frCRthqggEMAUG5l5HdNNWvO5c3Y4
         Q1fPPpF4Eu0yMdytpWV9f+bgBZe/HjRH4IaJwjG2ibIeuYW4XAiq7kTbknWxCnTbh0ZD
         8jRIvRUeXxOkd7lHV1sdbfKJOSe/1oAQdDt6fMSzsNL2UHKNDhjxZRlcu5sJW8Gab1wO
         CJVOgTPb1QawPaYvKvbmDUVswnmsKUj6bPXf5CcJwvDQ0YFrR3ZXn5YhQ9WIyziCObk9
         Z+yJCFgg5da304vfM78uEw0isY2hQkb4bmscUHhxWWVNhp5k3e0VOUEHZ+iJVIJeV10p
         J+lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702402837; x=1703007637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nPISlKbrUG0tK8lJYNvUNWP7nyNY1BbwflsKiLuTFi0=;
        b=bFaD4H6Tu9iMC1843nXClbA+LLm7Z/OmhKZa4YxFwH6/Lu6/w2alvYVmfZWX8R3do3
         6lkvqIo8vHvkNnyS+y1D7c7D0qrF/9zZ4Jam/2u23/QGP/kpM0jMXdstFFBkEE0lPank
         7HEmK54DqSZXTjkgPaUm1CZyBhTmZzY55ulBfmL2ilkpirYV3mt+3P0usZ0nXLdlZwLH
         PGPuDntSQhfuPFeicCnVnnY8XfH4Am+ZSYorOL+dGczOM21N9/HyX1I4tScHg32fYipl
         W8Mpj3tmLV753lkG+ubU5sbwSPkP24Zgf2s5ZfdRrT1Ev8lMEyiR0qS64gAECNbdS6cB
         dnCQ==
X-Gm-Message-State: AOJu0Yxe8eCyAwQXgXKXcpvfNO41OufHpfsK1yN1faIIUmGoZlA3i+Vx
        /2HH2qk1/hoeYhSjD5TsXZaBHIq/PTa3yMv7
X-Google-Smtp-Source: AGHT+IHJeTQSjclWqrS02Kkk0Gg9HCxjs71I9GHnus5nJtRAN/H5XxCosDarhXXb57RNxFjeGpWhCw==
X-Received: by 2002:a17:903:1cc:b0:1d0:ba41:1ec with SMTP id e12-20020a17090301cc00b001d0ba4101ecmr7966274plh.49.1702402837234;
        Tue, 12 Dec 2023 09:40:37 -0800 (PST)
Received: from localhost.localdomain ([101.0.63.152])
        by smtp.gmail.com with ESMTPSA id jc19-20020a17090325d300b001cc25cfec58sm8903135plb.226.2023.12.12.09.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 09:40:36 -0800 (PST)
From:   "Neeraj Upadhyay (AMD)" <neeraj.iitr10@gmail.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, paulmck@kernel.org, Neeraj.Upadhyay@amd.com,
        Pedro Falcato <pedro.falcato@gmail.com>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>
Subject: [PATCH rcu 2/3] rcu: Remove unused macros from rcupdate.h
Date:   Tue, 12 Dec 2023 23:10:03 +0530
Message-Id: <20231212174004.11754-2-neeraj.iitr10@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231212173948.GA11724@neeraj.linux>
References: <20231212173948.GA11724@neeraj.linux>
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

From: Pedro Falcato <pedro.falcato@gmail.com>

ulong2long, USHORT_CMP_GE and USHORT_CMP_LT are redundant and have been
unused for quite a few releases.

Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay (AMD) <neeraj.iitr10@gmail.com>
---
 include/linux/rcupdate.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index f7206b2623c9..aa87c82236dd 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -34,9 +34,6 @@
 
 #define ULONG_CMP_GE(a, b)	(ULONG_MAX / 2 >= (a) - (b))
 #define ULONG_CMP_LT(a, b)	(ULONG_MAX / 2 < (a) - (b))
-#define ulong2long(a)		(*(long *)(&(a)))
-#define USHORT_CMP_GE(a, b)	(USHRT_MAX / 2 >= (unsigned short)((a) - (b)))
-#define USHORT_CMP_LT(a, b)	(USHRT_MAX / 2 < (unsigned short)((a) - (b)))
 
 /* Exported common interfaces */
 void call_rcu(struct rcu_head *head, rcu_callback_t func);
-- 
2.40.1

