Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CADD3809703
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 01:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235348AbjLHAQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 19:16:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444162AbjLHAP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 19:15:29 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D4A1718
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 16:15:32 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-7b459364167so55469439f.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 16:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701994531; x=1702599331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MCkZIwhi88nd/yzrQGwCF8kQMXxopVxRCEGtmZwQBaw=;
        b=l2IXjgR5KyRh26bbU9L28nP8CJjg6bC0LR7i+LwDQLfFaQolP0ug8BtNpxjMTsK77E
         zIKErZ5aWQSBXGZWoE3tvZk337IeG4LM14LQw4MGfoKPsAiWNbm0oTu163j+Zl4B47co
         8DHDqdQ6JDMhLr+okbPxKgFWj/MjZWAEpxL+h04jUwG97ZNSa15+EfRPep1zpQj71VUd
         Epa4n5RyBAlytTMMC/Ir8lO/dJZCoAcy3zNbsnXHUjyN99A2iLWyjvnKirJFLfsBUgSh
         6FmMJGJJKr8o+eL1mTEahfK/pLExdVllP3Sz+t8UlXS0QJZrJL0h7R15NI/sBpN9Knj2
         7ZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701994531; x=1702599331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MCkZIwhi88nd/yzrQGwCF8kQMXxopVxRCEGtmZwQBaw=;
        b=t5Is/Jl0EaOWWPqzqfbcDx2/36vt4QmdCQ4nibbz+VzphSKBAq4Gahs8dc9PAGTq9F
         c4QbEWy49NrXRKduY3QbiQae87Fbqhv9+BuHPWJ7ouC9HjPCJBFeDCq37IB8d4e1HdGc
         W1lK+ihuKWuKuRt/cHgW6hNbnKCCgcDPxb8QwfpVK7gsV0qH/qpvSXjjCR/sXtBsO1sh
         eOHe3D1U2rVdduXOKmhWa5cdtqKXccY7VxPdYxNw40kWJyal180Zov0oG6CpQqoG8Q7c
         p9a80b0vDvS5LYXag+H7P/vwuokcGlp5djFjq5IykR/BxWP847F8ZclGAuWe4FgJNTQv
         bqNg==
X-Gm-Message-State: AOJu0YwwwdCqLL4H1OgRwb6fQysrVtFvWiaKuMCtOOrWAENWFZvlSxHn
        Y8/2ywxnH8EpzTxUSDyFmDw=
X-Google-Smtp-Source: AGHT+IF62HqxZoU5OEf7v+oklk/u5OwmObuCekyon/8TDsbZbDa8lsgOGFM+fxxps4QNC/O7N3r1Jw==
X-Received: by 2002:a5e:c818:0:b0:7b7:ea:befe with SMTP id y24-20020a5ec818000000b007b700eabefemr1482198iol.14.1701994531316;
        Thu, 07 Dec 2023 16:15:31 -0800 (PST)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id z18-20020a056638241200b004664a0a7f2csm184652jat.177.2023.12.07.16.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 16:15:30 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     lb@semihalf.com, linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, bleung@google.com, contact@emersion.fr,
        daniel@ffwll.ch, dianders@chromium.org, groeck@google.com,
        jbaron@akamai.com, jim.cromie@gmail.com, john.ogness@linutronix.de,
        keescook@chromium.org, pmladek@suse.com, ppaalanen@gmail.com,
        rostedt@goodmis.org, seanpaul@chromium.org,
        sergey.senozhatsky@gmail.com, upstream@semihalf.com,
        vincent.whitchurch@axis.com, yanivt@google.com,
        gregkh@linuxfoundation.org
Subject: [re: PATCH v2 00/15 -  07/11] dyndbg: __skip_spaces
Date:   Thu,  7 Dec 2023 17:15:10 -0700
Message-ID: <bdc86387d74ea059d04f301df414ee3d6564634d.1701993656.git.jim.cromie@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1701993656.git.jim.cromie@gmail.com>
References: <CAK8ByeK8dGcbxfXghw6=LrhSWLmO0a4XuB8C0nsUc812aoU0Pw@mail.gmail.com> <cover.1701993656.git.jim.cromie@gmail.com>
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

This private version treats a comma like a space.
Its not known necessary ATM, but seems prudent.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index a380b8151dd8..c974f6e19ca1 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -628,6 +628,14 @@ static int ddebug_change(const struct ddebug_query *query,
 	return nfound;
 }
 
+char *__skip_spaces(const char *str)
+{
+	str = skip_spaces(str);
+	if (*str == ',')
+		str = skip_spaces(++str);
+	return (char *)str;
+}
+
 /*
  * Split the buffer `buf' into space-separated words.
  * Handles simple " and ' quoting, i.e. without nested,
@@ -642,7 +650,7 @@ static int ddebug_tokenize(char *buf, char *words[], int maxwords)
 		char *end;
 
 		/* Skip leading whitespace */
-		buf = skip_spaces(buf);
+		buf = __skip_spaces(buf);
 		if (!*buf)
 			break;	/* oh, it was trailing whitespace */
 		if (*buf == '#')
@@ -959,7 +967,7 @@ static int ddebug_exec_queries(char *query, const char *modname)
 		if (split)
 			*split++ = '\0';
 
-		query = skip_spaces(query);
+		query = __skip_spaces(query);
 		if (!query || !*query || *query == '#')
 			continue;
 
-- 
2.43.0

