Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3D0A7B23DC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 19:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbjI1RZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 13:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbjI1RZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 13:25:34 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31ED91A4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 10:25:32 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9ae3d4c136fso335444966b.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 10:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1695921930; x=1696526730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v/TGT+v2onwhR3DWI/C2XC90jEj/DLLYrXKmnR2IfXs=;
        b=chyq2RM7TRkMav4kl6LfB1ZA12RrnS94Jl+ADgBTqgzkD5nViYFBMNoWTo4ueBForF
         lzmlvsruUlaqklO8yLHrznKdhJMy2EBRos31/CMC++Zh0/i/cHFjNxJaZ03bxRfuU2yy
         zyxNmJ7HQy1+5/hu0r0Y77IiVN1n7SLdx2VcI8qEMTgRcFlW7P/8UK8IK5HTs5JuQLSE
         U4yRErpwg5506oVIvt4+v/fWS3TdAytsAD0yrlT3UC04hxiJInYJ1z39DuoI7r+YRebr
         aU9+DFuNOYzkoE85VRhrWlFdqn4bJGjHyjVbGDTeywWVOShPaNDz/dmHhVKVgOorqeDT
         +maQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695921930; x=1696526730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v/TGT+v2onwhR3DWI/C2XC90jEj/DLLYrXKmnR2IfXs=;
        b=AcgYHXyj7q6UMRYA9/DPQM+IGHUP0ubCED2qIMZUlGVql2fB6zKey84Zlyx8BUueeF
         c6/L3miO57yTRBjaByFLneo6Af0J45QjBDreV2BiSXD4buFBkneD1CYORIbxLHWZhKEn
         7+ckyYG33iQiWnBPldHwsds/oegLofz1xdUGYoPC/7aj/UUoI5vce4RvByIKGjoTTLfs
         bzI13+VGaKKwpq6d6afm6k/9F2tLWO8uso3+WJ5tZyhEERpO7ZyaYdekw33HpkMriZVF
         Y395hzlY7wEl0gffco8jgUMycyqvoh/cgywVsCFDPXTWVicfnYaVEELgs7kBfsUm4LAJ
         PkyQ==
X-Gm-Message-State: AOJu0Yye+oD5WP2WFrO8cKw/Bq1mwZwnZkAQAOmTVDB49N5cLeHHelCT
        jxFwAJVHuGTUnX5koEmguSEPxA==
X-Google-Smtp-Source: AGHT+IH0euAGYjrCZbgJ8RFIhz/xz08t6fWykn21eNHckLKUHkkweKDGKXgPC/XNOmxmryeAGfBWbA==
X-Received: by 2002:a17:906:5185:b0:9ae:50de:1aaf with SMTP id y5-20020a170906518500b009ae50de1aafmr1750879ejk.4.1695921930540;
        Thu, 28 Sep 2023 10:25:30 -0700 (PDT)
Received: from localhost.localdomain ([45.147.210.162])
        by smtp.gmail.com with ESMTPSA id j17-20020a170906279100b0099329b3ab67sm11151788ejc.71.2023.09.28.10.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 10:25:29 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, andres@anarazel.de, tglx@linutronix.de,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5/8] futex: add wake_data to struct futex_q
Date:   Thu, 28 Sep 2023 11:25:14 -0600
Message-Id: <20230928172517.961093-6-axboe@kernel.dk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230928172517.961093-1-axboe@kernel.dk>
References: <20230928172517.961093-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With handling multiple futex_q for waitv, we cannot easily go from the
futex_q to data related to that request or queue. Add a wake_data
argument that belongs to the wake handler assigned.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 kernel/futex/futex.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
index 33835b81e0c3..76f6c2e0f539 100644
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -148,6 +148,7 @@ typedef void (futex_wake_fn)(struct wake_q_head *wake_q, struct futex_q *q);
  * @task:		the task waiting on the futex
  * @lock_ptr:		the hash bucket lock
  * @wake:		the wake handler for this queue
+ * @wake_data:		data associated with the wake handler
  * @key:		the key the futex is hashed on
  * @pi_state:		optional priority inheritance state
  * @rt_waiter:		rt_waiter storage for use with requeue_pi
@@ -173,6 +174,7 @@ struct futex_q {
 	struct task_struct *task;
 	spinlock_t *lock_ptr;
 	futex_wake_fn *wake;
+	void *wake_data;
 	union futex_key key;
 	struct futex_pi_state *pi_state;
 	struct rt_mutex_waiter *rt_waiter;
-- 
2.40.1

