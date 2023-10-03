Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE297B749A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 01:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234243AbjJCXRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 19:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234324AbjJCXRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 19:17:53 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66EAEFA
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 16:17:47 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bdf4752c3cso10720255ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 16:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696375066; x=1696979866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2hiNsKpT2HKUJ8qI7Tsyk3akcDPzjImS4VdPWR3XZT4=;
        b=aCSkSkl7sC4BruVJ6KatwzPKc6b7bhrSCn1NnqxhY7YizoiLOdMkWQpvql8jDkQYrm
         fydN6yVIdM+V5jG3cWusApcaU0lUb6UwTh0zieaICjAG1HrY1YBaeKLHKGW2OXCbvte9
         9vWifOlo7S2XBBg5BTp0kWUX4/tUgHyUvUfyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696375066; x=1696979866;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2hiNsKpT2HKUJ8qI7Tsyk3akcDPzjImS4VdPWR3XZT4=;
        b=DI3+4WmaHJPkd3nmwPoOmURmL3QhunvHTqpriYpT735jQqKjhhKfpBjPkT23yKrF4d
         FSLsw7d3IHr6c9IHlIkBo+Tv9TO03Vx0WHEGtcjLlzB4ppFexoZhhGzOUKdgmXuw7V++
         n7OCoTr/DoU7Mc/EU10BGvf8tMZbG6ZBvKc5XxakoHoQdaejB4kTXId/yYbMA5hoIBJ7
         FPmaHzr6CZg3VP3BZcVTDVsquHcqgqZ8gJtdef9PcCLZV/uW/ASn/0v1voVMs0Txlv4I
         Rt+vprtogHiLJHQxbKREPQ8ACPSp5IKt2Jtmvv9SE/OTZG2ONq11bm1a2AEiM2lbIKmo
         wSlQ==
X-Gm-Message-State: AOJu0YxunhHSyNJ7cHyubEklYk2N7GbExOqXCW9lzG3h2KuhCwnAVCkU
        /nviIGNEfFqry6emRXAEYK4cuw==
X-Google-Smtp-Source: AGHT+IEzbduhuq91qnIf9SmrVMDzR6Wn097mVLkmhj2fU4eb4uu4f4+qfWtXB80CU1vtpmuHsm0FCw==
X-Received: by 2002:a17:902:e84e:b0:1c0:d5b1:2de8 with SMTP id t14-20020a170902e84e00b001c0d5b12de8mr1214102plg.9.1696375066601;
        Tue, 03 Oct 2023 16:17:46 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x12-20020a170902ea8c00b001bb99e188fcsm2170047plb.194.2023.10.03.16.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 16:17:46 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Kees Cook <keescook@chromium.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemb@google.com>,
        Anqi Shen <amy.saq@antgroup.com>, netdev@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, syzbot <syzkaller@googlegroups.com>,
        Jianfeng Tan <henry.tjf@antgroup.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH] net/packet: Annotate struct packet_fanout with __counted_by
Date:   Tue,  3 Oct 2023 16:17:41 -0700
Message-Id: <20231003231740.work.413-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1323; i=keescook@chromium.org;
 h=from:subject:message-id; bh=GKawqwHl4UULkff2cIaeAmAbzx8aWFIbmG5VLVkLd4I=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlHKEUZGTBGbWEbfQHr5gGx1uBl6q3iB19j5TQ8
 4R6/WUoIzCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZRyhFAAKCRCJcvTf3G3A
 JiFBEACQ9z6btE2IRqV+dlPimus38QVTJ6TnbqlcqFLxVxfTBnSZPghD/CNiZuVouBKmCGzfc8Q
 H7Vlcjkf882aG66U6TSBtG2M9ndDjlyMpLwzjHNbD8sRH2f7VmHtLuM11Gsk7NAOMK2EU3uzZy5
 la89UC4CnKbQoki7cdi96USYK87HkKEMQ2FoktbUUSt0jDgZopRsieiYMkvhr//uOV/XtuzQPF4
 /P9r4qH6Z+cwQmuWV5fRvnAuZ+TtV6P8niy+TMK4u3v0NSyfhgqmzm81x7EEWPcApprDIIp7/Ep
 E4POegXoG7BGZ10Y216YaD9shGKXtcE8rQHPWfn95/z2HGh8xUrzz9M3VjV4A9KWS6NViF4UmKO
 TzlldgZ1RssRxTAChOf04lXMhc5VV8HFRnBkW+jIckgMei2klc0+SfeIERirUvcjDj6Hr/QWHvY
 4bDW579Wh6lNWVjyQICRm5G3kv9dz3Zgtdwef3NgZqsj2b4Y6p9/dmmbYCZlXZTrzM/0xvhHP/x
 FD0LlpmYBbed2Um/PQTQHk2Kd0nVWGbNxKB4bLXoGIc1NCecn1nqCO+JuvFMMvlIVQM1WaBtor9
 vrrpSr0s9k2fX6DT8MWId6QvSoe5Gni2yDgPb2AJ45TOUfZ1L7CNKBj3cHlIvxEm/uvbxIWDPco
 tS5hYpJ HBTM8msg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct packet_fanout.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>
Cc: Anqi Shen <amy.saq@antgroup.com>
Cc: netdev@vger.kernel.org
Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 net/packet/internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/packet/internal.h b/net/packet/internal.h
index 63f4865202c1..d29c94c45159 100644
--- a/net/packet/internal.h
+++ b/net/packet/internal.h
@@ -94,7 +94,7 @@ struct packet_fanout {
 	spinlock_t		lock;
 	refcount_t		sk_ref;
 	struct packet_type	prot_hook ____cacheline_aligned_in_smp;
-	struct sock	__rcu	*arr[];
+	struct sock	__rcu	*arr[] __counted_by(max_num_members);
 };
 
 struct packet_rollover {
-- 
2.34.1

