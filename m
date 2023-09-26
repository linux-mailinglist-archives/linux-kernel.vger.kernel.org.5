Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC807AEEB7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 16:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233632AbjIZOVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 10:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbjIZOVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 10:21:34 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3866DCE;
        Tue, 26 Sep 2023 07:21:28 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-4180f5c51f8so26154471cf.1;
        Tue, 26 Sep 2023 07:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695738087; x=1696342887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nRGa0U9FQCtSnVtZP5ZEvcMMAX0AVtjNp21OId7BT6Q=;
        b=Edk2+4ncL3lX4gOHNlwyVfm3DOThsDFGs8UlO8EkqRWFkBzWNrLH+esXCy9MALcq1J
         um2HOkTliorQ/McHmTe6fU0z/3HWabBONQ2oeute0agP58y8oySGjNxXcHNUR6+hl7bf
         pslzfq8ujxCb1WhOPsZ4xiY8ro1fJ5gRF8iMaXe+930j2caty+KX0qRbUilw8R+gntFX
         2Ewv6GdYKWbKVBrXozBNpiRCFBRvFxlywLr6tKp98VXg8kcDAMYNXGMn/0Wxr5uDGQsU
         zoGmL113RO7IAvc1fv5Ji1C+HQyJ9skpcuWyAFsPjW4xib1BNhP4xiJ9odrBCt/iqcUf
         aTCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695738087; x=1696342887;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nRGa0U9FQCtSnVtZP5ZEvcMMAX0AVtjNp21OId7BT6Q=;
        b=mzsPQCmODDurvNx+2v7F2bQ+Z82I6RLB990R9h1F7p+Vtz17Kaxjq3NpeFVVtk+sW6
         fYRhIBACzs60MifLaAs4E80fHkL2801eGp9jquWX68peSbgCFIOTDROEDJm7HUtY8yEo
         T67ikxZRsJtzVU/aMnSqSIRBozNP0pY4DPeZWo8y1Z7f+YZ/V+t1vmeFtSxgIhsunUVF
         qlHHhJ7UOVzgzkM95VhG52cgschp6Zy0EqIrlikqJln9n5PVqh59bHBa6oummg9gLZoG
         prmzA9qmX36KtlOE1s7phau6dc1fmrDlTk8UB6+O8ay8nqV9q/wpCU1lQV4+iiUjR3E0
         NLnA==
X-Gm-Message-State: AOJu0YzqMY61EJJ/xuIPlJUg7woZUAAnhJ++ZBx/emvoz/wyYsvbIw0i
        QhFPgbnO6SAySrII2yXgVRE=
X-Google-Smtp-Source: AGHT+IECmHjkfhI6XFRhqcGUFyLG9B4Zu8ufS+Y/RJgQoP2Pa1gEzDRwpyDM99Tj/C7FbktYK2D5Bg==
X-Received: by 2002:a05:622a:207:b0:417:8b47:8486 with SMTP id b7-20020a05622a020700b004178b478486mr2879985qtx.34.1695738087285;
        Tue, 26 Sep 2023 07:21:27 -0700 (PDT)
Received: from US-B32Y0T3.na.ds.lexmark.com (ip98-166-230-239.hr.hr.cox.net. [98.166.230.239])
        by smtp.gmail.com with ESMTPSA id fp6-20020a05622a508600b004181aa90b46sm1521496qtb.89.2023.09.26.07.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 07:21:26 -0700 (PDT)
From:   Nicholas Lowell <nicholas.lowell@gmail.com>
X-Google-Original-From: Nicholas Lowell <Nicholas.Lowell@gmail.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Nicholas Lowell <nlowell@lexmark.com>
Subject: [PATCH] trace: tracing_event_filter: fast path when no subsystem filters
Date:   Tue, 26 Sep 2023 10:20:58 -0400
Message-Id: <20230926142058.1370-1-Nicholas.Lowell@gmail.com>
X-Mailer: git-send-email 2.39.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Lowell <nlowell@lexmark.com>

If there are no filters in the event subsystem, then there's no
reason to continue and hit the potentially time consuming
tracepoint_synchronize_unregister function.  This should give
a speed up for initial disabling/configuring

Signed-off-by: Nicholas Lowell <nlowell@lexmark.com>
---
 kernel/trace/trace_events_filter.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 33264e510d16..93653d37a132 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1317,22 +1317,29 @@ void free_event_filter(struct event_filter *filter)
 	__free_filter(filter);
 }
 
-static inline void __remove_filter(struct trace_event_file *file)
+static inline int __remove_filter(struct trace_event_file *file)
 {
 	filter_disable(file);
-	remove_filter_string(file->filter);
+	if (file->filter)
+		remove_filter_string(file->filter);
+	else
+		return 0;
+
+	return 1;
 }
 
-static void filter_free_subsystem_preds(struct trace_subsystem_dir *dir,
+static int filter_free_subsystem_preds(struct trace_subsystem_dir *dir,
 					struct trace_array *tr)
 {
 	struct trace_event_file *file;
+	int i = 0;
 
 	list_for_each_entry(file, &tr->events, list) {
 		if (file->system != dir)
 			continue;
-		__remove_filter(file);
+		i += __remove_filter(file);
 	}
+	return i;
 }
 
 static inline void __free_subsystem_filter(struct trace_event_file *file)
@@ -2411,7 +2418,9 @@ int apply_subsystem_event_filter(struct trace_subsystem_dir *dir,
 	}
 
 	if (!strcmp(strstrip(filter_string), "0")) {
-		filter_free_subsystem_preds(dir, tr);
+		if (filter_free_subsystem_preds(dir, tr) == 0)
+			goto out_unlock;
+
 		remove_filter_string(system->filter);
 		filter = system->filter;
 		system->filter = NULL;
-- 
2.25.1

