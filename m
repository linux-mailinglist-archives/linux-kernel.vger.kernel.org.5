Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87129788C6A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 17:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238758AbjHYP0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 11:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236907AbjHYP0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 11:26:01 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973CA212C;
        Fri, 25 Aug 2023 08:25:57 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-68c0d886ea0so432322b3a.2;
        Fri, 25 Aug 2023 08:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692977157; x=1693581957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PVUAfjuhlGCsdGRU6NCyYn5JBe7LfSVAI851QTnMYfw=;
        b=avaCuMI86t6FDHFMWtLPkJBIkA6Q61g1fG1I5qI3FhWb8/+MwyV6PA6KcdDcOA/Vf2
         X8iHff1VjwvzyXNeNlnY0wGOA2NCWP3xOmBkGSmeZgz51AdqZ9/2ZA1Kw25Ro6qaQTtI
         aV16ts4F583GdO82DciUz+pqeYGur/ghngIEXlqRPCSmkqaFGXpIzwwZMr+hEISYUUTi
         7fIfnGzHB4CgkKdXS956oP9904iCXqPfFAUug83wVA4e7XTMRzMMgVwnbGrFBL0jbwxE
         Xg/XmYRXfRdICejybXPrljxu0v+K5sSrO04R0mb6Kvo0azxMj4bGyKbUJPdPt2MagNX4
         jVyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692977157; x=1693581957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PVUAfjuhlGCsdGRU6NCyYn5JBe7LfSVAI851QTnMYfw=;
        b=cgdi2CfyNyANFXoJWxlvyn5RmsS+sjkwTaCqWcVteCtKasM01BlE7SiidrYS2kG1/M
         qmI1VtpID+EVuuEQ5M5/uEcM3D5OduKxRVolrfSYv6pb8FFcG8tt0CACO5hm+X01e/4/
         zOA/QqedtMhqNxcxxG9rIz142N0JJ/KoD5KnIcZPHxn6RRXUVsYJlM7AcPx0aMWlxa9A
         vZ1Wwh07XlgDlk/oAt7PpqShnJCgpzyAweBX2pMaPySiS9WykYTy4u66Ve4wANqijcxU
         4hTqWnm4oPNCY6L3FKnJwzxu0iWx08uWUqAFlhr6U5mCgZtYkP8pnNEPqZH6YKqo7PLS
         Vslg==
X-Gm-Message-State: AOJu0YzJx+5qWnexUeO6K1f0mVq6Mq8CIlP/tidavujVd+06PS7zIsrv
        i8UpOpAtGZgfitb+2ALs3Nc=
X-Google-Smtp-Source: AGHT+IGHDGppuZkAZwUYF/Oq5yH89HYDGye0Wf6tj/d8SxMoa3rAgzs85OId17NsbSbNXHP1qzxqiA==
X-Received: by 2002:a05:6a20:7287:b0:149:2fd0:a4ac with SMTP id o7-20020a056a20728700b001492fd0a4acmr15696607pzk.42.1692977156937;
        Fri, 25 Aug 2023 08:25:56 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:a7ba:1788:3b00:4316])
        by smtp.gmail.com with ESMTPSA id y1-20020aa78541000000b006879493aca0sm1701748pfn.26.2023.08.25.08.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 08:25:56 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH v2 2/4] tools/lib/perf: Add perf_record_header_attr_id()
Date:   Fri, 25 Aug 2023 08:25:50 -0700
Message-ID: <20230825152552.112913-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230825152552.112913-1-namhyung@kernel.org>
References: <20230825152552.112913-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HEADER_ATTR record has an event attr followed by the id array.  But
perf data from a different version could have different size of attr.

So it cannot just use event->attr.id to access the array.  Let's add the
perf_record_header_attr_id() macro to calculate the start of the array.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/lib/perf/include/perf/event.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
index ba2dcf64f4e6..e563dd8c3628 100644
--- a/tools/lib/perf/include/perf/event.h
+++ b/tools/lib/perf/include/perf/event.h
@@ -151,6 +151,10 @@ struct perf_record_header_attr {
 	__u64			 id[];
 };
 
+/* Returns the pointer to id array based on the actual attr size. */
+#define perf_record_header_attr_id(evt)			\
+	((void *)&(evt)->attr.attr + (evt)->attr.attr.size)
+
 enum {
 	PERF_CPU_MAP__CPUS = 0,
 	PERF_CPU_MAP__MASK = 1,
-- 
2.42.0.rc1.204.g551eb34607-goog

