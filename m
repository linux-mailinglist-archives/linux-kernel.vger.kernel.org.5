Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBDF7803F16
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 21:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233664AbjLDUOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 15:14:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232447AbjLDUOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 15:14:19 -0500
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D636D3
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 12:14:25 -0800 (PST)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-58e1ddc68b2so2000997eaf.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 12:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1701720865; x=1702325665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6c7W+Z0n44cx31K9z6TknZvQ8WpPWuGgMuK2rK3kYgI=;
        b=k1eHOOIjZWC+jz6H4eR7N1oP4jhctprLaO+KIUwjlmlkiW7c0V7YZ6v+8vvTxr2EwE
         rxcZCCbSwXtjG4jfE8Uf2CnCgieuULs0EO3NpvVuk6txOJKidgJqbk7lFfKOWC9dDdQ9
         k09hV2lQyDPTzDKG7iVSEwTpNbHVIDtV09U6BfIszxtybx+fhNiL7IjWoQSDDFkA1/pW
         IiabBMclV/iwW41PR9S8vz1KyzXgCZlyaAPHnK0d846aoMlVFhgV7pOT/9tB3UEJRpb7
         ItOl2w5LmspBJc/rKJbsrh+dD90S9LeYZ5qmRF/i19hGu0uMybS16/wy0Ct5giulVX9Q
         JyDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701720865; x=1702325665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6c7W+Z0n44cx31K9z6TknZvQ8WpPWuGgMuK2rK3kYgI=;
        b=DG7agyKtjoE/WW2R6lNlJ0/x0JLHbrlAbM1l1t3Oi2SL5xqHzlljZO2y51TqXpnLFY
         CLnAcssB0X0ZX+jnAhE4lWy1sjyQSlRGwNybysmIQzFPo79+4DnUu7khn/k2BuitjhKs
         YVYYopDFaz0vT1ko/UlcMrgoBfGOJ1KXRUhxjj6hompDjZoNV7AGvcsLDRraKCDKSzba
         XMcNN+9L9xrXSf0+c68cGlZB+Lc+A9lVxwY4OqeinDj+D7s2XPRADr9+DFqkftgE17GE
         UBK3a1hjBlx1Ryt5Gch4x12HLG01odH7Fhkm+Z93a3uK7mPn2MSNOTDjsXzbpCizHD2c
         CrNg==
X-Gm-Message-State: AOJu0YxD/Z+Ie2sUhUqGvTQIIvNO7I3/Em/ry9Xw6DV9hXy/4AmuP6iW
        qXyNFlNwHqHJYq/8srBBi3opvg==
X-Google-Smtp-Source: AGHT+IG/K86ebDBCHf8O0u2HkrIeBkifZWBUyzEDU/F2m0TUx1B/C3gGG8NPHiawXlUugm7PuLe5pQ==
X-Received: by 2002:a05:6358:5208:b0:170:40b1:88ac with SMTP id b8-20020a056358520800b0017040b188acmr992899rwa.65.1701720864819;
        Mon, 04 Dec 2023 12:14:24 -0800 (PST)
Received: from zhadum.home.kylehuey.com (c-76-126-33-191.hsd1.ca.comcast.net. [76.126.33.191])
        by smtp.gmail.com with ESMTPSA id n7-20020a63f807000000b005b529d633b7sm7894060pgh.14.2023.12.04.12.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 12:14:24 -0800 (PST)
From:   Kyle Huey <me@kylehuey.com>
X-Google-Original-From: Kyle Huey <khuey@kylehuey.com>
To:     Kyle Huey <khuey@kylehuey.com>, linux-kernel@vger.kernel.org
Cc:     Robert O'Callahan <robert@ocallahan.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH 1/2] perf/bpf: Allow a bpf program to suppress I/O signals.
Date:   Mon,  4 Dec 2023 12:14:05 -0800
Message-Id: <20231204201406.341074-2-khuey@kylehuey.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231204201406.341074-1-khuey@kylehuey.com>
References: <20231204201406.341074-1-khuey@kylehuey.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Returning zero from a bpf program attached to a perf event already
suppresses any data output. This allows it to suppress I/O availability
signals too.

Signed-off-by: Kyle Huey <khuey@kylehuey.com>
---
 kernel/events/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index b704d83a28b2..34d7b19d45eb 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10417,8 +10417,10 @@ static void bpf_overflow_handler(struct perf_event *event,
 	rcu_read_unlock();
 out:
 	__this_cpu_dec(bpf_prog_active);
-	if (!ret)
+	if (!ret) {
+		event->pending_kill = 0;
 		return;
+	}
 
 	event->orig_overflow_handler(event, data, regs);
 }
-- 
2.34.1

