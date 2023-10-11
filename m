Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97C847C4B04
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 08:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343997AbjJKGzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 02:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjJKGz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 02:55:29 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5781B93
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 23:55:28 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c87a85332bso54513865ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 23:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697007328; x=1697612128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ykcEFA0ijkjBw3h+Q6uTEQDITJX5wqqBCPD/TQXajLU=;
        b=JEGGDHUJGMH5VVHqt7OenbSyE1T7GEWQD7o4I58dzPNPMai47+31zh7VQLYmCSAsZS
         gXS81dZVG8EyGBZTDtguCYJ51ORs5j8ehVN9f8RDtBMhIneBLOU3tpobrKqd17rEe0iQ
         uYYSiO46M1NfoVUeUh8hO4y5joE0dwzR8sZKt5fmjUbcRtUpmox7lKTjOka7hvhrdV1e
         o1ldor38kOCZ8ZMxRst7x34xJStIuJGEAzNS3oFqgVvudW93viOmjyJXP2K21dZSQ/9f
         e3qOob87p2Uf6zjJdnW5yQngTxetlouIPePD8wbk/EwD2pVdLsYjWg3fYpXvE/BEsMgY
         d/BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697007328; x=1697612128;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ykcEFA0ijkjBw3h+Q6uTEQDITJX5wqqBCPD/TQXajLU=;
        b=sebvvqGc4VB6VJkKtc/V20tcwTnRCCP3UIQNEgPtwSngh7KGSj8x21cVFIvFRUvyzg
         JbF1m9ghNL9TsHobv2yfz7eigJHgirwF8kbNCcc6ZceK8O9WFZgq1AqnOKo85vLKe0Ai
         LW5TSbXUl0XAHPj2pogToaWrrUtV2qF0d2mkDf76+yXJf61M5Ie1ifA6Di1vb5/4YbAK
         1QKf0s+Eha1Fh5/aUwxfV4hZ8vcQNZHDiCjjPD0ew1DjwHp51lFovV6FWdSEOs7SvVp2
         /Qnl2RIXQAXpgoGVUKczlJlI0kD7d7Tkzs2GM0Ae9PeQS1hHFAQjy2i/3b52c2HJ9qqD
         ZQKA==
X-Gm-Message-State: AOJu0Yy/cz4v6ULLpnD2L2ouZCdhm7UWbljI2hWyiYmv8t727Es/JHyt
        pNXvtOa74F5aBaU587KZ0f5zkQ==
X-Google-Smtp-Source: AGHT+IFtVfqEL3cXupeR7zWbExjmzoKlxynYw+PKgUbPODHu4M5raoe1y9iuzkIlnRn5PIPBoTMuAw==
X-Received: by 2002:a05:6a20:938b:b0:15a:2c0b:6c73 with SMTP id x11-20020a056a20938b00b0015a2c0b6c73mr25644714pzh.12.1697007327744;
        Tue, 10 Oct 2023 23:55:27 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([61.213.176.10])
        by smtp.gmail.com with ESMTPSA id n14-20020a170902d2ce00b001bf52834696sm13010464plc.207.2023.10.10.23.55.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Oct 2023 23:55:27 -0700 (PDT)
From:   Yunhui Cui <cuiyunhui@bytedance.com>
To:     akpm@linux-foundation.org, keescook@chromium.org,
        brauner@kernel.org, jeffxu@google.com, frederic@kernel.org,
        mcgrof@kernel.org, cyphar@cyphar.com, cuiyunhui@bytedance.com,
        rongtao@cestc.cn, linux-kernel@vger.kernel.org
Subject: [PATCH] pid_ns: support pidns switching between sibling
Date:   Wed, 11 Oct 2023 14:54:46 +0800
Message-Id: <20231011065446.53034-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the scenario of container acceleration, when a target pstree
is cloned from a temp pstree, we hope that the cloned process is
inherently in the target's pid namespace.
Examples of what we expected:

/* switch to target ns first. */
setns(target_ns, CLONE_NEWPID);
if(!fork()) {
/* Child */
...
}
/* switch back */
setns(temp_ns, CLONE_NEWPID);

However, it is limited by the existing implementation, CAP_SYS_ADMIN
has been checked in pidns_install(), so remove the limitation that only
by traversing parent can switch pidns.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 kernel/pid_namespace.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index 3028b2218aa4..774db1f268f1 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -389,7 +389,7 @@ static int pidns_install(struct nsset *nsset, struct ns_common *ns)
 {
 	struct nsproxy *nsproxy = nsset->nsproxy;
 	struct pid_namespace *active = task_active_pid_ns(current);
-	struct pid_namespace *ancestor, *new = to_pid_ns(ns);
+	struct pid_namespace *new = to_pid_ns(ns);
 
 	if (!ns_capable(new->user_ns, CAP_SYS_ADMIN) ||
 	    !ns_capable(nsset->cred->user_ns, CAP_SYS_ADMIN))
@@ -406,12 +406,6 @@ static int pidns_install(struct nsset *nsset, struct ns_common *ns)
 	if (new->level < active->level)
 		return -EINVAL;
 
-	ancestor = new;
-	while (ancestor->level > active->level)
-		ancestor = ancestor->parent;
-	if (ancestor != active)
-		return -EINVAL;
-
 	put_pid_ns(nsproxy->pid_ns_for_children);
 	nsproxy->pid_ns_for_children = get_pid_ns(new);
 	return 0;
-- 
2.20.1

