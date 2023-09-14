Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BAA979F99E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 06:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234465AbjINEmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 00:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233796AbjINEmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 00:42:47 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70AA31998
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 21:42:42 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-592210fe8easo8343857b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 21:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694666561; x=1695271361; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1HUitirtv3MlkOjFE/+m21aYPcp7zNtjHMHmwF7qUUE=;
        b=4FaOT++M4mmbE8qmGg8bcDu+h0LN9B+B2pvwcCdu+D03RNGyM48D5Dc17pnj5WMQp5
         c4Xq0wmUu2kQtrHLEvtmdFFNiz+qjfDnE5EKLIWBYR2V+WofBdbYOboS7o+y3ftz/5mS
         nqBMJKMOBueGIraN6Z/8TGjIOuVJVqSn81m07W22Mmz3uRWFf4TN1Hd3I2G6Kiv0yfmq
         SFy9bjhq3S28s8jtYYGwKbfshamAPrsJy6uXuygz393MWzwvdsB6PtsoiEZtEa7SI9KF
         lm7TLr2+lxsVrhRcRr3+uxd7g5M6RTQCdnfoHjJ9HLgKJqA+bq+gVXEmbdPI1xLyPZse
         IPCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694666561; x=1695271361;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1HUitirtv3MlkOjFE/+m21aYPcp7zNtjHMHmwF7qUUE=;
        b=doNyfiHmHgGx+8YYm8dNEJSMVJMTFGeQF9cKqeq9ibVGBwN+yWdTvoFeYLnrpDmPL2
         KU8Y3BJeadDbNQZqtd8OFYbHXCY102fib5pQwOVpa75cZERZCEMAD7s/doV7Na/l4GFf
         jVtPr0oYwNDC0gSBis5nr0j8VerAgcskrXM12UtgIPD6ZEtaBQxurT8xkRMXBNcQPzhv
         SyDRRzsHo9vz1duvs2t+pvC14tSJa9t/ZHlSAEii2eg2WOaK7E6FZvp1gb075LfASzKF
         W60WFQhZn+gjb5BMIKKoMFnPcC0me2ad2qk2hmUYXgQj3C7RxH8f6MdWNJqL/cmRurQq
         kVtA==
X-Gm-Message-State: AOJu0YzXxnEdVx82HfYQ/tQNYiXdpoeS0uFbWnq9YJaEXFzotOSrAfyf
        1Iex7vKxjxKQTMe9aJdLSsh+Cnr0Bge3
X-Google-Smtp-Source: AGHT+IEN/077fAkp5yMboSyz7Pt4O7f+pFXS5/PlYDxMWe3T6O8biy09CF1qTv4xeXl/Vyd19SfmjQeV8EC7
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7612:4bb6:bcf1:779c])
 (user=irogers job=sendgmr) by 2002:a25:26c4:0:b0:d47:5cc3:9917 with SMTP id
 m187-20020a2526c4000000b00d475cc39917mr96593ybm.9.1694666561603; Wed, 13 Sep
 2023 21:42:41 -0700 (PDT)
Date:   Wed, 13 Sep 2023 21:42:32 -0700
Message-Id: <20230914044233.1550195-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Subject: [PATCH v1] perf symbol: Avoid an undefined behavior warning
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The node (nd) may be NULL and pointer arithmetic on NULL is undefined
behavior. Move the computation of next below the NULL check on the
node.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/symbol.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 3f36675b7c8f..5b54d2639df4 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -202,11 +202,10 @@ void symbols__fixup_duplicate(struct rb_root_cached *symbols)
 		curr = rb_entry(nd, struct symbol, rb_node);
 again:
 		nd = rb_next(&curr->rb_node);
-		next = rb_entry(nd, struct symbol, rb_node);
-
 		if (!nd)
 			break;
 
+		next = rb_entry(nd, struct symbol, rb_node);
 		if (curr->start != next->start)
 			continue;
 
-- 
2.42.0.459.ge4e396fd5e-goog

