Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D6980ED07
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 14:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376546AbjLLNPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 08:15:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235218AbjLLNP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 08:15:29 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86346CA;
        Tue, 12 Dec 2023 05:15:35 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id d2e1a72fcca58-6ce6d926f76so3917009b3a.1;
        Tue, 12 Dec 2023 05:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702386935; x=1702991735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Czl9kOFrZP+hpYOswuJ1In+XAL9Pf70YYpXxrimZvIU=;
        b=cCtGXfOWq+0CMo7XgpQeKs5eD4OLdjfgAa5Y2YPGB9ej2MF1y1Dj3jfJZUEMqVB6/D
         RKNkYldyLfxKdmH63CfK5waJq+8gpqPFqc8c6I2FAhrz6WDIQeKKdEbQ/7BNAoQiSZGI
         7efLD2VNyZ5BYfwtC3/1UcUjJJtJXDjRs5GujSIKEv8ckVCxafl/L1a19T21jM1X07zo
         e8OL7OqTnsIWe26o9NCUNZFr564HcXtMAt6tBX8DH0XMBZnGEYtIINgLg9dgUgGAS3gH
         9YMCVw6A8QEpSo8seeOtdrpp5Qgaj0Q58IJ7v4CAhuSOxgzXp278Zck2SlLaU466FONr
         bCsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702386935; x=1702991735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Czl9kOFrZP+hpYOswuJ1In+XAL9Pf70YYpXxrimZvIU=;
        b=GKPkjyaCz2i/RtbVbRD6YwPbtyOfDjm0BACt3ks+90bCjKyPzheJDn64u+I6EK1gdJ
         LugZ3lyKF9AK7T8Cr/TBGq8r/eKX809Nvm8bQi1N1mjYjffYLz8kIGlJ+kWfELzEGd6N
         oHhyPZTgIYkb1rr6G2CBbEwheOVqx24t4UZKnOylq1Ii7zkb9jcsBhQArYriTzJuwVjy
         sSMLaKxHd/9BiEqDandJOBKH0EgwkvGi6P/stIMvsGRMXdab3SY5ZbQIKsoTqs9Jv4UL
         Mm/9Q9+fpdgY7oK4r9PPYsXrPYcNxi/x589PoEF3TTGOWC03LcsX4ptdTyNKGOgHmjle
         KueQ==
X-Gm-Message-State: AOJu0Yx0j04TlVjvLICAx1xgRbs2rhxValm4riyarRcrX8nuTREifAua
        CoVzhhPQAz4Griepuw+t2tY=
X-Google-Smtp-Source: AGHT+IF2OITEweRZmsoxrHTHnek4Ib0hin0ZOs5RSnsEFi+ap3EGkfflLpSDwZgcZ0OQTdTGMV4zkQ==
X-Received: by 2002:a05:6a20:914f:b0:190:37a0:f343 with SMTP id x15-20020a056a20914f00b0019037a0f343mr8677544pzc.34.1702386934738;
        Tue, 12 Dec 2023 05:15:34 -0800 (PST)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id x20-20020aa793b4000000b006c4d2479bf8sm8095026pff.51.2023.12.12.05.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 05:15:34 -0800 (PST)
From:   Menglong Dong <menglong8.dong@gmail.com>
To:     andrii@kernel.org, yonghong.song@linux.dev
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        martin.lau@linux.dev, song@kernel.org, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Menglong Dong <menglong8.dong@gmail.com>
Subject: [PATCH net-next v2 1/2] bpf: make the verifier trace the "not qeual" for regs
Date:   Tue, 12 Dec 2023 21:10:30 +0800
Message-Id: <20231212131031.3088661-2-menglong8.dong@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231212131031.3088661-1-menglong8.dong@gmail.com>
References: <20231212131031.3088661-1-menglong8.dong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can derive some new information for BPF_JNE in regs_refine_cond_op().
Take following code for example:

  /* The type of "a" is u16 */
  if (a > 0 && a < 100) {
    /* the range of the register for a is [0, 99], not [1, 99],
     * and will cause the following error:
     *
     *   invalid zero-sized read
     *
     * as a can be 0.
     */
    bpf_skb_store_bytes(skb, xx, xx, a, 0);
  }

In the code above, "a > 0" will be compiled to "jmp xxx if a == 0". In the
TRUE branch, the dst_reg will be marked as known to 0. However, in the
fallthrough(FALSE) branch, the dst_reg will not be handled, which makes
the [min, max] for a is [0, 99], not [1, 99].

For BPF_JNE, we can reduce the range of the dst reg if the src reg is a
const and is exactly the edge of the dst reg.

Signed-off-by: Menglong Dong <menglong8.dong@gmail.com>
---
 kernel/bpf/verifier.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 727a59e4a647..08ee0e02df96 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14332,7 +14332,34 @@ static void regs_refine_cond_op(struct bpf_reg_state *reg1, struct bpf_reg_state
 		}
 		break;
 	case BPF_JNE:
-		/* we don't derive any new information for inequality yet */
+		if (!is_reg_const(reg2, is_jmp32))
+			swap(reg1, reg2);
+		if (!is_reg_const(reg2, is_jmp32))
+			break;
+
+		/* try to recompute the bound of reg1 if reg2 is a const and
+		 * is exactly the edge of reg1.
+		 */
+		val = reg_const_value(reg2, is_jmp32);
+		if (is_jmp32) {
+			if (reg1->u32_min_value == (u32)val)
+				reg1->u32_min_value++;
+			if (reg1->u32_max_value == (u32)val)
+				reg1->u32_max_value--;
+			if (reg1->s32_min_value == (s32)val)
+				reg1->s32_min_value++;
+			if (reg1->s32_max_value == (s32)val)
+				reg1->s32_max_value--;
+		} else {
+			if (reg1->umin_value == (u64)val)
+				reg1->umin_value++;
+			if (reg1->umax_value == (u64)val)
+				reg1->umax_value--;
+			if (reg1->smin_value == (s64)val)
+				reg1->smin_value++;
+			if (reg1->smax_value == (s64)val)
+				reg1->smax_value--;
+		}
 		break;
 	case BPF_JSET:
 		if (!is_reg_const(reg2, is_jmp32))
-- 
2.39.2

