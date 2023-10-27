Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DED47D921D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 10:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345589AbjJ0IlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 04:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235105AbjJ0Ika (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 04:40:30 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4C219A3;
        Fri, 27 Oct 2023 01:40:14 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-4084de32db5so14835115e9.0;
        Fri, 27 Oct 2023 01:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698396013; x=1699000813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NLfx2GCVwo2B3bImCCwCI1lgsjgZt6z3r+jCmDSbHsg=;
        b=g2pGX+IaPuhevRFURWowXm7G+66N2yHMN+ZUdFgZlM9C7YpCShA41erZEVlwsueOlX
         BOhndoi1X3/nRzE2KiLOeoZxilHRKckZDYDcA0uXnrnAjs7fQDtq9ZBzMWdnSVS07C9X
         Uxe6Au5pbfivno6SCnsw+4TQaccuQQdSyPFjNBZdSzOqUVFDWWaRS6ne4OlbiwZWCdfx
         0vMs1W+wf+ixYgWgNLaIjcv/12vKwj8VjXFNG8zqTTCQQfAsK7mUGJVzP1iWQTy1TjBo
         hG7a1O3t5XNuCOgbfMkv1cD0SPd2RBkuqf8FzN1ZLz1KDvFC0ArVVi78B+sjAaHsrjtb
         R5EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698396013; x=1699000813;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NLfx2GCVwo2B3bImCCwCI1lgsjgZt6z3r+jCmDSbHsg=;
        b=LVNkjqfmJvN8vSKQqXsdPY7g85KGl8srZ4cSj3JEGFJA0YE7Xt+2yo88gHbHQnJMSz
         cyunGEjrPz6iOT+HhyHPemidB/IUWc+IrehkDuIgNCJR/ahgmOxYhcFHCFcgTsR68t1J
         V0kQ0pkuB1S8tDFe1ZTWfDulnD1lhJxSCaQ4TdlpVECZnLE9xuvQXmO/m1NwLHhD7LKX
         EFoBfRsUMkjmtMXMdcur6/ouHBmGBr35mKRlHzlvf/tNKsYBi1TLsAu/GE2Lo5NAXGIy
         EZnMQhLXbuwlNNph/Q/uLfwYiY5zBUxLkjtkA95mtz1OEiPXD7WCLtz0WNXuY6L+1SbO
         CJQA==
X-Gm-Message-State: AOJu0YxUXqLg7XRDXFwBFlFOYewKuDf0KW9ON6xo/XdOjtpQ/7folpYB
        rzfCdybeiypoBTw/p0z0Xa0=
X-Google-Smtp-Source: AGHT+IHlZlQcpEITcJAvwaFd2YBxY5klWuCO0q22QjmwnyxXzB0IGr8JjdKrK5xSjl6wyD9g6GeoHA==
X-Received: by 2002:a05:600c:4748:b0:409:325:e499 with SMTP id w8-20020a05600c474800b004090325e499mr1609413wmo.32.1698396012758;
        Fri, 27 Oct 2023 01:40:12 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id u6-20020a05600c19c600b004064288597bsm1064379wmq.30.2023.10.27.01.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 01:40:12 -0700 (PDT)
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
Subject: [PATCH][next] perf report: Fix spelling mistake "heirachy" -> "hierarchy"
Date:   Fri, 27 Oct 2023 09:40:11 +0100
Message-Id: <20231027084011.1167091-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a spelling mistake in a ui error message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/perf/builtin-report.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index ca8f2331795c..9cb1da2dc0c0 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -705,7 +705,7 @@ static int report__collapse_hists(struct report *rep)
 	 */
 	if (perf_data__is_pipe(session->data)) {
 		if (perf_hpp__setup_hists_formats(&perf_hpp_list, evlist) < 0) {
-			ui__error("Failed to setup hierachy output formats\n");
+			ui__error("Failed to setup hierarchy output formats\n");
 			return -1;
 		}
 	}
-- 
2.39.2

