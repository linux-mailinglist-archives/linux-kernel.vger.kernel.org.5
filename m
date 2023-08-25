Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D401F788C6B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 17:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240185AbjHYP0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 11:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237464AbjHYP0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 11:26:02 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473A72137;
        Fri, 25 Aug 2023 08:26:00 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-68a3e271491so844135b3a.0;
        Fri, 25 Aug 2023 08:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692977160; x=1693581960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2FJUnRDHEZaApoThKe1ItomuG6aOppIegF4bJQrMsxU=;
        b=a+uJIwyuNnk3TVTQtZqW9uS+xJz2Gwe11uXTuYJQ3Skl544YB+I6cm+yPL8tms1KZm
         Js8A08lH113Q4uSBGfsXo4vYVh5tg9DV8RgTqEgEVC1a1YfYoDuhQJj2BW99m6XlH6VM
         NnfvgX3PfxRSbWunnGa/xh7tM2xd7Z4VE5qzdzN6FqmacCu7ZDF3SrgQwRpuRCizp6As
         Sa2yvnKC9K9NowhzXxvsYZHymfhfxzJpByNxva0THoQ8WlMIBB2EaUi1a4Y+aGOEaK7u
         ooxAZUhVDn6OZCtfAFnTPgjSWLGrap+yfutDs/iMdqhCcR8Xwd3wQcJd3XJHo09mrbNp
         kMlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692977160; x=1693581960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2FJUnRDHEZaApoThKe1ItomuG6aOppIegF4bJQrMsxU=;
        b=fCcYr99YLwmi1wN2+wPlLH2i+Qb2ufjG9Ym6Vv7+IAZhy+TvRQGnZyTjK+hxv8+T6X
         DNwm4YoeRkyJ13IYcMHZp8Rt+OvlkST286K3C2EeDFXD2cOtJZ8X4OG3wyKX8QiIUDNe
         PphJorOhmtuYYcr0K1BPzT8+Dl5bWirStO45RILLWLZWz6YO2JTIuV18sXD8EENW3GE4
         73V4Yp7JuSFpJ4HEKVe/W5mFRToyV4hBkJqR0bsTYjf9mrfe+zjlCIGgD5saqhMPdCYm
         YNPRkuKlbqyGR8oK1e5iEiFZrZQpee6NouYQpdM1Xw69tn5mqiU9KS3zYQpY2SnAOTpM
         o6GQ==
X-Gm-Message-State: AOJu0YzqCS8doNiap9Zk9QKuh/30Ej9ZWkOUU75yKoBMsDHnN1h6+CcH
        Btfle8zzVOtGU3aaOKxvVJE=
X-Google-Smtp-Source: AGHT+IHSQAyMHvANuR7fSUjRBKdsbfh5Ib/PbKyDzJqOdw7KsjZX6sLG+DRCxBJbw2nlkZyV0q1Ipg==
X-Received: by 2002:a05:6a20:3d13:b0:14c:6a05:dfbf with SMTP id y19-20020a056a203d1300b0014c6a05dfbfmr2897922pzi.60.1692977159611;
        Fri, 25 Aug 2023 08:25:59 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:a7ba:1788:3b00:4316])
        by smtp.gmail.com with ESMTPSA id y1-20020aa78541000000b006879493aca0sm1701748pfn.26.2023.08.25.08.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 08:25:59 -0700 (PDT)
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
Subject: [PATCH v2 4/4] tools/lib/perf: Get rid of attr.id field
Date:   Fri, 25 Aug 2023 08:25:52 -0700
Message-ID: <20230825152552.112913-4-namhyung@kernel.org>
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

Now there's no in-tree user of the field.  To remove the possible bug
later, let's get rid of the 'id' field and add a comment for that.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/lib/perf/include/perf/event.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
index e563dd8c3628..ae64090184d3 100644
--- a/tools/lib/perf/include/perf/event.h
+++ b/tools/lib/perf/include/perf/event.h
@@ -148,7 +148,13 @@ struct perf_record_switch {
 struct perf_record_header_attr {
 	struct perf_event_header header;
 	struct perf_event_attr	 attr;
-	__u64			 id[];
+	/*
+	 * Array of u64 id follows here but we cannot use a flexible array
+	 * because size of attr in the data can be different then current
+	 * version.  Please use perf_record_header_attr_id() below.
+	 *
+	 * __u64		 id[];  // do not use this
+	 */
 };
 
 /* Returns the pointer to id array based on the actual attr size. */
-- 
2.42.0.rc1.204.g551eb34607-goog

