Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43CB47E0E8A
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 10:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbjKDJRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 05:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbjKDJQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 05:16:59 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A2FD49
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 02:16:35 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-7781bc3783fso186448385a.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 Nov 2023 02:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1699089394; x=1699694194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TZsOGiaArG1gPfWJWYyqQWKmeMDqaJOsSKH43M0pjNo=;
        b=Q/U+dBHCPN+0cYxnzGDmOICtLzHegbWb2rExRSc9m0SSrRRG/7baJ4tiI/SuE1VeqH
         qa04UYbzXRvAmHv4GrOQeX3yscLfaLpWQ2YJE1PGNR1RhnTWdLz2K5FtdR6LygDxgSKa
         OCO/cQoCIsErOX7ebeTijU44VG1x7Xm8FEgn4okcW0i1cy/TJNSFy+k4mIcprYXnUg8E
         DVIgD2k46XlA4PGlthjXDyoL0LcjTC0J0I5BEkmgDVLFUP0Whel+xniIuj6s7kLFQiPu
         634TCks3uHSlEuW9w10j0rQ0kAkET7ZG3SO+JMLnafVcaH8zIzbmxo3KhPE3x/eGpOVS
         wwfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699089394; x=1699694194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TZsOGiaArG1gPfWJWYyqQWKmeMDqaJOsSKH43M0pjNo=;
        b=J9xOeLs/o/eq+YrdLZc/cgGzK18a2vL296XoJ+pUo04uymFb4PY3jr9fqS9BToF/sX
         zcapgu3PA1IkFsL1XvfC9gIbxUU9N/UPfpJGQ7tsgB7+dJODcnbCj9KQrm3MnernhEKk
         WoaFToea2R8QeZW4At2It+19KyRPda57shbcXWEI1Dje3wU59UKsiScdb+6YVc7UB7wB
         Z2Cacv99wOgcGNzGEs2GjjdVvw5kBflxRvEwA2nuPUPGHddQ2gX4LM0jnXMuHOfuZ5nJ
         5Po/U/hfmrnrqItI/aUIlPP7wrt2aD+usfGb1I1RDRGubhBygYDP5oBCkdSsqd/8Q9us
         H0Dw==
X-Gm-Message-State: AOJu0YzT9Ub1LfNz5tJWYtU23HW7BKwqRzuaSH02uQRhUsWxNQk8l0pl
        t/O7NA5mcHJtArFaUC7WsW505Q==
X-Google-Smtp-Source: AGHT+IGjAYKMZlAfEP3ECe1n3sw6IIECunrstOALu+CAcSUP9EdkfONAQy3WGvW0OrN94BxZJnCbWg==
X-Received: by 2002:a05:620a:2588:b0:777:2767:6465 with SMTP id x8-20020a05620a258800b0077727676465mr27504451qko.40.1699089394700;
        Sat, 04 Nov 2023 02:16:34 -0700 (PDT)
Received: from devz1.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id d4-20020a170903230400b001cc54202429sm2585127plh.288.2023.11.04.02.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Nov 2023 02:16:34 -0700 (PDT)
From:   "wuqiang.matt" <wuqiang.matt@bytedance.com>
To:     vgupta@kernel.org, bcain@quicinc.com, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
        geert@linux-m68k.org, andi.shyti@linux.intel.com, mingo@kernel.org,
        palmer@rivosinc.com, andrzej.hajda@intel.com, arnd@arndb.de,
        peterz@infradead.orgm, mhiramat@kernel.org
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-openrisc@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, mattwu@163.com,
        linux@roeck-us.ne, "wuqiang.matt" <wuqiang.matt@bytedance.com>
Subject: [PATCH v2 1/4] locking/atomic: arc: data size checking in arch_cmpxchg
Date:   Sat,  4 Nov 2023 17:16:12 +0800
Message-Id: <20231104091615.4884-2-wuqiang.matt@bytedance.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231104091615.4884-1-wuqiang.matt@bytedance.com>
References: <20231104091615.4884-1-wuqiang.matt@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Macro __cmpxchg() renamed to __cmpxchg_32() to emphasize it's explicit
support of 32bit data size, BUILD_BUG_ON() added to avoid any possible
misuses with unsupported data types.

In case CONFIG_ARC_HAS_LLSC is undefined, arch_cmpxchg() uses spinlock
to accomplish SMP-safety, so the BUILD_BUG_ON checking is uncecessary.

Signed-off-by: wuqiang.matt <wuqiang.matt@bytedance.com>
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

