Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD447F30A2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 15:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234304AbjKUOZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 09:25:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234281AbjKUOZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 09:25:17 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16081D51
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 06:24:46 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6b1d1099a84so5310854b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 06:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1700576685; x=1701181485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BQYwJQjKhySUG7SsmpVBnxUpf+Jrz1ajgA6palaWrFM=;
        b=REfrDuQxXQ+HzwB7FgCwmor5rAI71g2RCGGb46LBPw4XtSe8F78WA6gTNWd8Qh/0yh
         5dIM3+q89dTSMA5EKwHdA9LTELAIXr1bmNuKewoK7vNWoV7oPtTj90ZMVt4QJ0cg8BKs
         UrBha3hyPjeD+a6f3/p3n8HWV4lzc/c+Qk7LeJ97JMdC3nd0grAmX7cRgrWX6erZ+J7k
         pgyWoVdF0S47lNBGdTU5tnr5vhIUhj9JXAyS+W5CCmFeZIZEvQT+yecS7QVbo4PwLwtY
         qRoh7keGmiHRfLl1N55RnRoVTJiv31N2Rn/piXit5TvGZZIPAGpmY8Elq3Q2xJaMr2kR
         3WSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700576685; x=1701181485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BQYwJQjKhySUG7SsmpVBnxUpf+Jrz1ajgA6palaWrFM=;
        b=h5xwh8fkwLuqS7uuQvdbM5HfqV1R7DDFy5xlWVsfsaHvIH2RiRk4yzK3o3pKkcL6PD
         z2rEMfTRrue/nPxNRcUvtA+z1zLrSlYHGFBRvHdv1fpdf9YHyPV2GQlEBBAgSOsEm85C
         h4QkdkfUojpVI8NlxHONLv9SiAu/gsBeoBZYnK4n3RtKUxy128Kd/NwJAWjWmb0ozTzH
         tqGaNApD4z4Zl7XpMLO1mBlnH+2iSzZ0K0AOK5vN32oYMQ7pPQNQ9INisY5W/txtFf8f
         dPbYixFVvXO0bCm9gS3Bydppz4wHXhnDxKIB4eAFYjPd3aKxAAXDJcPywtb0P6zFf3j5
         ytFw==
X-Gm-Message-State: AOJu0Yy0gfL7kNhu5cqKiwKkm75PsfnauNEf/LnUM45Xp8de6AX3CpYZ
        vtJvCqJozzw3Ae9ts4BgOZS2Sw==
X-Google-Smtp-Source: AGHT+IEIjroP416LXBt6XlPHirqpf89r1vmzg9nVdVzS5F8PL+ZcqkvogWm5yXbuGxjX92apejfh4w==
X-Received: by 2002:a05:6a00:80a:b0:6cb:a18b:2182 with SMTP id m10-20020a056a00080a00b006cba18b2182mr8114491pfk.1.1700576685502;
        Tue, 21 Nov 2023 06:24:45 -0800 (PST)
Received: from devz1.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id d13-20020a056a00244d00b0068842ebfd10sm7923193pfj.160.2023.11.21.06.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 06:24:45 -0800 (PST)
From:   "wuqiang.matt" <wuqiang.matt@bytedance.com>
To:     ubizjak@gmail.com, mark.rutland@arm.com, vgupta@kernel.org,
        bcain@quicinc.com, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
        chris@zankel.net, jcmvbkbc@gmail.com, geert@linux-m68k.org,
        andi.shyti@linux.intel.com, mingo@kernel.org, palmer@rivosinc.com,
        andrzej.hajda@intel.com, arnd@arndb.de, peterz@infradead.org,
        mhiramat@kernel.org
Cc:     linux-arch@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-openrisc@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        mattwu@163.com, linux@roeck-us.net,
        "wuqiang.matt" <wuqiang.matt@bytedance.com>
Subject: [PATCH v3 1/5] arch,locking/atomic: arc: arch_cmpxchg should check data size
Date:   Tue, 21 Nov 2023 22:23:43 +0800
Message-Id: <20231121142347.241356-2-wuqiang.matt@bytedance.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231121142347.241356-1-wuqiang.matt@bytedance.com>
References: <20231121142347.241356-1-wuqiang.matt@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch_cmpxchg() should check data size rather than pointer size in case
CONFIG_ARC_HAS_LLSC is defined. So rename __cmpxchg to __cmpxchg_32 to
emphasize it's explicit support of 32bit data size with BUILD_BUG_ON()
added to avoid any possible misuses with unsupported data types.

In case CONFIG_ARC_HAS_LLSC is undefined, arch_cmpxchg() uses spinlock
to accomplish SMP-safety, so the BUILD_BUG_ON checking is uncecessary.

v2 -> v3:
  - Patches regrouped and has the improvement for xtensa included
  - Comments refined to address why these changes are needed

v1 -> v2:
  - Try using native cmpxchg variants if avaialble, as Arnd advised

Signed-off-by: wuqiang.matt <wuqiang.matt@bytedance.com>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 arch/arc/include/asm/cmpxchg.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arc/include/asm/cmpxchg.h b/arch/arc/include/asm/cmpxchg.h
index e138fde067de..bf46514f6f12 100644
--- a/arch/arc/include/asm/cmpxchg.h
+++ b/arch/arc/include/asm/cmpxchg.h
@@ -18,14 +18,16 @@
  * if (*ptr == @old)
  *      *ptr = @new
  */
-#define __cmpxchg(ptr, old, new)					\
+#define __cmpxchg_32(ptr, old, new)					\
 ({									\
 	__typeof__(*(ptr)) _prev;					\
 									\
+	BUILD_BUG_ON(sizeof(*(ptr)) != 4);				\
+									\
 	__asm__ __volatile__(						\
-	"1:	llock  %0, [%1]	\n"					\
+	"1:	llock  %0, [%1]		\n"				\
 	"	brne   %0, %2, 2f	\n"				\
-	"	scond  %3, [%1]	\n"					\
+	"	scond  %3, [%1]		\n"				\
 	"	bnz     1b		\n"				\
 	"2:				\n"				\
 	: "=&r"(_prev)	/* Early clobber prevent reg reuse */		\
@@ -47,7 +49,7 @@
 									\
 	switch(sizeof((_p_))) {						\
 	case 4:								\
-		_prev_ = __cmpxchg(_p_, _o_, _n_);			\
+		_prev_ = __cmpxchg_32(_p_, _o_, _n_);			\
 		break;							\
 	default:							\
 		BUILD_BUG();						\
@@ -65,8 +67,6 @@
 	__typeof__(*(ptr)) _prev_;					\
 	unsigned long __flags;						\
 									\
-	BUILD_BUG_ON(sizeof(_p_) != 4);					\
-									\
 	/*								\
 	 * spin lock/unlock provide the needed smp_mb() before/after	\
 	 */								\
-- 
2.40.1

