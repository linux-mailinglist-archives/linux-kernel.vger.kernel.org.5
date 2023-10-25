Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709AC7D77D4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 00:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjJYW2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 18:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjJYW22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 18:28:28 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD27C4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 15:28:26 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6bcef66f9caso47628b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 15:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698272905; x=1698877705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FZxI3ub9JozV6+6IOvOpJE/ZTX8Zxt3TUWc6QGqqjFk=;
        b=hi08eH0fhjPBQ53aJZmzGP+QuvcEnLExXY2mzsYfrwxrKULEa4I8FztS7G6wyQOU1c
         LR5fSvkeEG5D0+t5yxLALMW9R64VCl/ECOuZekd67Z0ifEVxeTuBKYjD9lA1xIXjtfvM
         EQx6cliZS9NGM0LUVRChhjwON9wNX8goLNFjVdRK/25vztIwGXjJYaZvyZnB2mVxTap6
         fhkH79flPDHV2/pnvZ2Oo5RoMUSyNcLVNZe3Vmxu5cP6amgvnb/ePGieaZY9aoo6X2XJ
         C7BZxkeZXHOIfM6GvWzTm6QrIqC0LMSd4Tkj81GK1CFDUxe5YnuoUrJ5qNM6ffbkSlsI
         z9ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698272905; x=1698877705;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FZxI3ub9JozV6+6IOvOpJE/ZTX8Zxt3TUWc6QGqqjFk=;
        b=LH/xIUimgWnQ1SqdXEhkGsm3A1fiUXHFO0x39Jn3OsK2dIFwUHqf/sbDgvI7b31fkh
         BJEvIvAaNxoK+61YN5n4gxlh1sJldvq0Bo+46kQFY/5+8kNe5A1POOOmMzQE8vZENvtU
         y7OQQIZ6SO2gvfo155hSY/hC4YViBihmW4rFaGuPr8NwR6pfzCFYaemskN+hEFXwfvUq
         skeuNkN5PHlqV/BA1o6I0M76mgYdvBr7WBjwO0EUGPotlx+o3E34nbR4v9wbfJB0PHhB
         zDIj7mBx/bMYYxxGMlIRVJbZeUxl7AdOL+0vSW3vOE0nbr08PNm86O3TNkpj6YthK5OY
         cuxA==
X-Gm-Message-State: AOJu0Yyd//1uKuduVO3MKdrhyyXSKcXlEQEZbWPxh1F21JwRWS2U5/4m
        GxBbdL7PmfpqRCHxfXqJ4Wk=
X-Google-Smtp-Source: AGHT+IHD30Uv9Bpm7YQdU9kkcThi9PVQIIoveL1K5nQXJdHyhzOsc8S+zCmeQBAqEtWSVNAqr0/exQ==
X-Received: by 2002:a62:e816:0:b0:6bf:1621:ccad with SMTP id c22-20020a62e816000000b006bf1621ccadmr16899762pfi.0.1698272905586;
        Wed, 25 Oct 2023 15:28:25 -0700 (PDT)
Received: from abhinav.. ([103.75.161.211])
        by smtp.gmail.com with ESMTPSA id y23-20020aa79af7000000b006b5922221f4sm9879813pfp.8.2023.10.25.15.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 15:28:24 -0700 (PDT)
From:   Abhinav Singh <singhabhinav9051571833@gmail.com>
To:     akpm@linux-foundation.org, brauner@kernel.org, surenb@google.com,
        mst@redhat.com, michael.christie@oracle.com,
        mathieu.desnoyers@efficios.com, mjguzik@gmail.com,
        npiggin@gmail.com, shakeelb@google.com, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Abhinav Singh <singhabhinav9051571833@gmail.com>
Subject: [PATCH] Fixing warning of directly dereferencing  __rcu tagged
Date:   Thu, 26 Oct 2023 03:58:11 +0530
Message-Id: <20231025222811.855336-1-singhabhinav9051571833@gmail.com>
X-Mailer: git-send-email 2.39.2
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

This patch fixes the warning about directly dereferencing a pointer
tagged with __rcu annotation.

Dereferencing the pointers tagged with __rcu directly should 
always be avoided according to the docs. There is a rcu helper 
functions rcu_dereference(...) to use when dereferencing a __rcu 
pointer. This functions returns the non __rcu tagged pointer. 
Like normal pointer there should be a check for null case when 
further dereferencing the returned dereferenced __rcu pointer.


Signed-off-by: Abhinav Singh <singhabhinav9051571833@gmail.com>
---
 kernel/fork.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 10917c3e1f03..5afb1b389a66 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2369,7 +2369,9 @@ __latent_entropy struct task_struct *copy_process(
 
 	retval = -EAGAIN;
 	if (is_rlimit_overlimit(task_ucounts(p), UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC))) {
-		if (p->real_cred->user != INIT_USER &&
+		const struct cred *real_cred = rcu_dereference(p->real_cred);
+
+		if (real_cred && real_cred->user != INIT_USER &&
 		    !capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN))
 			goto bad_fork_cleanup_count;
 	}
-- 
2.39.2

