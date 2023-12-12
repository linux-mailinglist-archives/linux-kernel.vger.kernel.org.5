Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6084C80F497
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 18:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376681AbjLLR12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 12:27:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235084AbjLLR11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 12:27:27 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F10B9F;
        Tue, 12 Dec 2023 09:27:32 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1d336a8e27fso4977145ad.2;
        Tue, 12 Dec 2023 09:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702402051; x=1703006851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pAz4ODF6UTOOaFnSikdhsc6gxYzI76HyzuBIuPlXUuY=;
        b=LuWmVF1ZlfxEbcA1Ip24YNUouNfBptWYlMZNVsQhwm7YHjXeGtchzbeTECj0rCdMoR
         vMsNyi9e3Q1fa8EBAczvv6Q8JVMrd3nW/2WyYAvquthY/hDrEoGYzU+/7aT+S5PIj8qG
         cSeWTH/alO9zpBe/7SJutEZEeE2sdsff18aReYHoxl/zceRDnGCIh/aqsxKzC/lWlLhr
         k4tcGvZLHuyx6OfN/f+9xNWKCj+EQiHwaRZZNgZTY87dw+lDCBsCmuNWL/Y1f103DGXa
         WCD9+PbUvdazr5HJTMYXZHQkYUcAfwquYjF10J9yigj05RWKNlnMhi5yZOk1IfO68agY
         JWkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702402051; x=1703006851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pAz4ODF6UTOOaFnSikdhsc6gxYzI76HyzuBIuPlXUuY=;
        b=ADnuixeS9hwA8Y80WBv097/9s5CXM/8rvjDZ+wOhdIXlw/7lw2DgTaAMOH09iCV/wX
         J87KksDYhTHw25dvuzI+iusbNMfHF8TulyIjBNEFoO6SAu6bfgsmQDxKAlDWPpONuj5E
         TrMun1I+gWmVNVdhzOjUVqn5VkknMF9rT0uH+KEcd4vWYG3BQy3vnGxgfMNnUsAvG0gK
         S/4WKdwvOv43AW/riqNm1xOmXxCPHjtVyIxta0rCfhXHJ7NDlThrkQOJV9RlUdE4wKNG
         j3et1ia1kzmoxGPFNRPI7gbxJNUWHkPIjJeFAxGSTtiveslyvLSJUBBwJrl4V6QyfPY+
         ZiUA==
X-Gm-Message-State: AOJu0YwrqdK+++EYBF1TY3AhC08dXDDkpfKN+x6pYjQfh0qsI/5KGr6v
        ZylWimfNo4GIkIgTxnSXF0edZRzpXGA/b56t
X-Google-Smtp-Source: AGHT+IH/2CMXFQGUUfM9milW99DYW0Jq/Kybrqf9ebV6G3X/s1DcqvIZTHxAQsGIL5vUlYFD4tE+OA==
X-Received: by 2002:a17:902:c943:b0:1d0:acd4:92ee with SMTP id i3-20020a170902c94300b001d0acd492eemr3860613pla.43.1702402051026;
        Tue, 12 Dec 2023 09:27:31 -0800 (PST)
Received: from localhost.localdomain ([101.0.63.152])
        by smtp.gmail.com with ESMTPSA id b18-20020a170902d51200b001cf511aa772sm8863170plg.145.2023.12.12.09.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 09:27:30 -0800 (PST)
From:   "Neeraj Upadhyay (AMD)" <neeraj.iitr10@gmail.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, paulmck@kernel.org, Neeraj.Upadhyay@amd.com,
        Philipp Stanner <pstanner@redhat.com>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>
Subject: [PATCH rcu 2/5] rculist.h: docs: Fix wrong function summary
Date:   Tue, 12 Dec 2023 22:56:50 +0530
Message-Id: <20231212172653.11485-2-neeraj.iitr10@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231212172343.GA11383@neeraj.linux>
References: <20231212172343.GA11383@neeraj.linux>
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

From: Philipp Stanner <pstanner@redhat.com>

The brief summary in the docstring for function list_next_or_null_rcu()
states that the function is supposed to provide the "first" member of a
list, whereas in truth it returns the next member.

Change the docstring so it describes what the function actually does.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay (AMD) <neeraj.iitr10@gmail.com>
---
 include/linux/rculist.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/rculist.h b/include/linux/rculist.h
index d29740be4833..3dc1e58865f7 100644
--- a/include/linux/rculist.h
+++ b/include/linux/rculist.h
@@ -355,7 +355,7 @@ static inline void list_splice_tail_init_rcu(struct list_head *list,
 })
 
 /**
- * list_next_or_null_rcu - get the first element from a list
+ * list_next_or_null_rcu - get the next element from a list
  * @head:	the head for the list.
  * @ptr:        the list head to take the next element from.
  * @type:       the type of the struct this is embedded in.
-- 
2.40.1

