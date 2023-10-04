Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C25D47B84F2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 18:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243323AbjJDQY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 12:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243303AbjJDQYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 12:24:24 -0400
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7C2D8;
        Wed,  4 Oct 2023 09:23:45 -0700 (PDT)
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6934202b8bdso1882674b3a.1;
        Wed, 04 Oct 2023 09:23:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696436624; x=1697041424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2GXRfMSN09aAE7TFNkE+Gfjpxe8UR8P6twMstwRkNR0=;
        b=IBgibaeb3tySH+tBV4HlRnHdcxIPHAqseONnXtIX5XuN2gbUsPGjS4xfhpNPRxQRQN
         4Zsl8MBjYMlfgyLwK7xM65mmnLjlkVKWWVCF0naBySydnxpOMAWS3usarcmQ15q0nD4p
         nPf0ZP6TI5rqoZNLx7MaD3TYnvj3BVEd4+fdBoNgFgbXsGKFJQOtMSW0SOeV/E9jRZcu
         NkT/+ibrSegzyeGzxfa/M1RGMPi6mP2yuGHIsIScRAuCIqBGQZHcN0nC/GH2OT5cl85E
         kqM5iQLV5AwWwn89r4/eNOtZRBxZ+7aDzzLTRs2vqxtDN/avTMAeXiWvNaHf3tK/E69v
         p7FA==
X-Gm-Message-State: AOJu0Yzwqn054wn06ddh57PPuRhvXLrUTmmI6fkGwQKzuy706dwji++S
        EcWEuybw0auv35F7EgU6OtnIhjIJxes8XF2g
X-Google-Smtp-Source: AGHT+IFiG1rwUI5PqUAiSGgJem7r9bmYI2z9UWg0Y2eYGShiO8nFHSLvDdkY/XFSZuHsoDWrULzb8g==
X-Received: by 2002:a05:6a00:1687:b0:68a:5395:7aa5 with SMTP id k7-20020a056a00168700b0068a53957aa5mr2985608pfc.17.1696436624179;
        Wed, 04 Oct 2023 09:23:44 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:3ce7])
        by smtp.gmail.com with ESMTPSA id r2-20020a62e402000000b0068aca503b9fsm3426462pfh.114.2023.10.04.09.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 09:23:43 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
Subject: [PATCH bpf-next v2 1/2] bpf: Add ability to pin bpf timer to calling CPU
Date:   Wed,  4 Oct 2023 11:23:38 -0500
Message-ID: <20231004162339.200702-2-void@manifault.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004162339.200702-1-void@manifault.com>
References: <20231004162339.200702-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BPF supports creating high resolution timers using bpf_timer_* helper
functions. Currently, only the BPF_F_TIMER_ABS flag is supported, which
specifies that the timeout should be interpreted as absolute time. It
would also be useful to be able to pin that timer to a core. For
example, if you wanted to make a subset of cores run without timer
interrupts, and only have the timer be invoked on a single core.

This patch adds support for this with a new BPF_F_TIMER_CPU_PIN flag.
When specified, the HRTIMER_MODE_PINNED flag is passed to
hrtimer_start(). A subsequent patch will update selftests to validate.

Acked-by: Song Liu <song@kernel.org>
Signed-off-by: David Vernet <void@manifault.com>
---
 include/uapi/linux/bpf.h       | 4 ++++
 kernel/bpf/helpers.c           | 5 ++++-
 tools/include/uapi/linux/bpf.h | 4 ++++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 70bfa997e896..a7d4a1a69f21 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5096,6 +5096,8 @@ union bpf_attr {
  *		**BPF_F_TIMER_ABS**
  *			Start the timer in absolute expire value instead of the
  *			default relative one.
+ *		**BPF_F_TIMER_CPU_PIN**
+ *			Timer will be pinned to the CPU of the caller.
  *
  *	Return
  *		0 on success.
@@ -7309,9 +7311,11 @@ struct bpf_core_relo {
  * Flags to control bpf_timer_start() behaviour.
  *     - BPF_F_TIMER_ABS: Timeout passed is absolute time, by default it is
  *       relative to current time.
+ *     - BPF_F_TIMER_CPU_PIN: Timer will be pinned to the CPU of the caller.
  */
 enum {
 	BPF_F_TIMER_ABS = (1ULL << 0),
+	BPF_F_TIMER_CPU_PIN = (1ULL << 1),
 };
 
 /* BPF numbers iterator state */
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index dd1c69ee3375..d2840dd5b00d 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1272,7 +1272,7 @@ BPF_CALL_3(bpf_timer_start, struct bpf_timer_kern *, timer, u64, nsecs, u64, fla
 
 	if (in_nmi())
 		return -EOPNOTSUPP;
-	if (flags > BPF_F_TIMER_ABS)
+	if (flags & ~(BPF_F_TIMER_ABS | BPF_F_TIMER_CPU_PIN))
 		return -EINVAL;
 	__bpf_spin_lock_irqsave(&timer->lock);
 	t = timer->timer;
@@ -1286,6 +1286,9 @@ BPF_CALL_3(bpf_timer_start, struct bpf_timer_kern *, timer, u64, nsecs, u64, fla
 	else
 		mode = HRTIMER_MODE_REL_SOFT;
 
+	if (flags & BPF_F_TIMER_CPU_PIN)
+		mode |= HRTIMER_MODE_PINNED;
+
 	hrtimer_start(&t->timer, ns_to_ktime(nsecs), mode);
 out:
 	__bpf_spin_unlock_irqrestore(&timer->lock);
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 70bfa997e896..a7d4a1a69f21 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5096,6 +5096,8 @@ union bpf_attr {
  *		**BPF_F_TIMER_ABS**
  *			Start the timer in absolute expire value instead of the
  *			default relative one.
+ *		**BPF_F_TIMER_CPU_PIN**
+ *			Timer will be pinned to the CPU of the caller.
  *
  *	Return
  *		0 on success.
@@ -7309,9 +7311,11 @@ struct bpf_core_relo {
  * Flags to control bpf_timer_start() behaviour.
  *     - BPF_F_TIMER_ABS: Timeout passed is absolute time, by default it is
  *       relative to current time.
+ *     - BPF_F_TIMER_CPU_PIN: Timer will be pinned to the CPU of the caller.
  */
 enum {
 	BPF_F_TIMER_ABS = (1ULL << 0),
+	BPF_F_TIMER_CPU_PIN = (1ULL << 1),
 };
 
 /* BPF numbers iterator state */
-- 
2.41.0

