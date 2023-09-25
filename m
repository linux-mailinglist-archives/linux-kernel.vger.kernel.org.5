Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82ED77ACF9A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 07:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbjIYFux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 01:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjIYFuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 01:50:51 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F0883;
        Sun, 24 Sep 2023 22:50:40 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-405361bb9f7so55221685e9.2;
        Sun, 24 Sep 2023 22:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695621039; x=1696225839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2Wk3JI+uB7Xq8h7WElwf7+Ut1PeMYIPUkPNkJ6556Zk=;
        b=XTT+5SLohTp/Lcl1OfXcly7G9tnfp0GoihImHuiA8GHcC2NO/Qh2YWjLJ03bIDxKs6
         M1BR6UqEXVuqVfznEVISjipYrKSTFBMdO4aIGRxvnTyICxg/1MaMyVO6WMiad/6V8sVy
         AeJdhHT+yuYgnlo4iN31mluA+aIcuzPhU7eTLNrZwpSYARw3zjoFcJ5vnKyw34AvRrl4
         L2hs5rHl42CHARoChmPcyoO+YGTvjWMpY0tLMu7vutkGJFDbU2FOHR/9sTVRodhagOkB
         aMWn4Wowp82uWAOgqykgRIBC8ohWHj9eMX1ThBAeM6oQ7dOHS1geU4vm4EoUaEaiJ6Lh
         W56Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695621039; x=1696225839;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Wk3JI+uB7Xq8h7WElwf7+Ut1PeMYIPUkPNkJ6556Zk=;
        b=nywk3yw868eKEMs3Xcn7JDhL9FS2LUYPI2rwfYM5rt0C4ipbKUeFdhf6/Ovg+2x8Xr
         IoLfNODEkNas/RR4WWm6yXBLLPq+4P3b3yL9ixHD3elzx2OzYVa/sK5vkTYgbJoK3egV
         DfoU9MlwbpBqUM4MIeezHJHs7tpzToEhHd+mX1yJEdlIqOMJuvRZC8oOzQOjdncDNHlk
         Ho5sG9IfPy3o6i9R1TSLdd5z+BJOSznKq1DRwDysO9HY/r/pQUewLOX3qHekdSwO0WT+
         XvOBMnt6gpzRYonEdAzDm90FxP0YQWGFNsZExrsxyLEK2Q2BeAVH80lN5YE1jszyDZwq
         lgTQ==
X-Gm-Message-State: AOJu0YxcaZQp8KVxXzvbm8kw/VvGmqz+Rwo/z3Ap0srnvI3wR9uouaOL
        RSZpouxwi0bjDDqe6EVNRIdWej+2MsB97Yv3PiM=
X-Google-Smtp-Source: AGHT+IFOgE/pya2UdAlTcRzki1EPv9XUfxU26y5HJ39cCQ+9EKXip3YxEx5bH3upvW+VIH7VNu2v/g==
X-Received: by 2002:a5d:5607:0:b0:321:c888:1de7 with SMTP id l7-20020a5d5607000000b00321c8881de7mr5302971wrv.54.1695621038884;
        Sun, 24 Sep 2023 22:50:38 -0700 (PDT)
Received: from localhost ([213.144.205.82])
        by smtp.gmail.com with ESMTPSA id s28-20020adfa29c000000b003232f167df5sm319586wra.108.2023.09.24.22.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 22:50:38 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] perf kwork: Fix spelling mistake "Captuer" -> "Capture"
Date:   Mon, 25 Sep 2023 06:50:37 +0100
Message-Id: <20230925055037.18089-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

There is a spelling mistake in a pr_debug message. Fix it.
(I didn't see this one in the first spell check scan I ran).

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/perf/builtin-kwork.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
index 7e8dd35d764b..f007a9b27065 100644
--- a/tools/perf/builtin-kwork.c
+++ b/tools/perf/builtin-kwork.c
@@ -1866,7 +1866,7 @@ static void sig_handler(int sig)
 	 * Simply capture termination signal so that
 	 * the program can continue after pause returns
 	 */
-	pr_debug("Captuer signal %d\n", sig);
+	pr_debug("Capture signal %d\n", sig);
 }
 
 static int perf_kwork__report_bpf(struct perf_kwork *kwork)
-- 
2.39.2

