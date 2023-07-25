Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D547760BA2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 09:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbjGYH1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 03:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbjGYH00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 03:26:26 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B1D18D;
        Tue, 25 Jul 2023 00:23:03 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-668704a5b5bso4857432b3a.0;
        Tue, 25 Jul 2023 00:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690269782; x=1690874582;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vKQjaMEJgYXDeiEqOBeyjwVlXPnI8CfInsVRC+pOwA0=;
        b=HNKC0I6t6rPeziRa/W467uitLYzDJL0JmAEEtV+PzeyPtcsfK6xjU6i5LRr0JbYMDd
         gbIL7MBrUvsfXzqJOQ3LJ+EaZGnHYSZb+rDbmADhP36HShfupzHX3qXwv2+FYCQtUbaq
         KJnztmCHluVNxPtx3kCmC/zIjc1ORRb1DNYUtwU3PxpfiDA4QVScOEcTWkDQ97EKSGQq
         ZklS4cJRnFDbV/JKnF0+5JAremo9ZwDtuRX+r1Nk5y2gQpM0O4Z/wTHIXoLEY4XYTXg+
         69O/2xtkiQmEXFg6NXaZROy93fuJSHAGeAfyM7a3so07p3yujaKuKIHGCMHxrDXNtqfX
         JJag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690269782; x=1690874582;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vKQjaMEJgYXDeiEqOBeyjwVlXPnI8CfInsVRC+pOwA0=;
        b=FhYF/GHQIIZp8a1KlBLZ2wnUGXZlGSdSmKeYhin3apOYm4JIYzRr/YKM1W61cxitob
         tQOEPP87k0IuY60kZ2nyK0NdRKMWJUKm+eoFjaAHEHBpjVZI8hEkl3nd024pDskiTNdM
         qSztPx0oMmnCYh7MBuIeaOozsaUm+6kYM4M8S47HQyQc9vFT6Yx/kEXeMca9qOpMbGX1
         Xxg+bGjVPa+7MzyiFLEGTeMSqjtpweOHGkoK+Jv6WoTCy/kka1YI4Q+yntJlxMgd6hoz
         KJo/K1E8rxqFgt6CeRbjkEjjnOtRgVoNY8zJo6clgU7UHhLpNCAXeMSEqjXvdmyKcMFT
         I7jg==
X-Gm-Message-State: ABy/qLazBL3fZOPNOI/XjiS5hyKel6cxbSFm45TseG1fhyRNpNOZc5TL
        +UvC6iBHG/nhkfuP2rKaIjE=
X-Google-Smtp-Source: APBJJlFjuoIgVBB2FhBq+74GoKcJSX+dXgAV1Y9+UPu8nu7svMqm2LdkIrh0NP5+f1Rj3TLNe/QZgQ==
X-Received: by 2002:a05:6a00:130b:b0:67b:f249:35e2 with SMTP id j11-20020a056a00130b00b0067bf24935e2mr12223848pfu.21.1690269782467;
        Tue, 25 Jul 2023 00:23:02 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.82])
        by smtp.googlemail.com with ESMTPSA id d12-20020a63734c000000b0055acfd94c20sm9863908pgn.35.2023.07.25.00.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 00:23:01 -0700 (PDT)
From:   Ze Gao <zegao2021@gmail.com>
X-Google-Original-From: Ze Gao <zegao@tencent.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, Ze Gao <zegao@tencent.com>
Subject: [RFC PATCH 0/3] report task state in symbolic chars in sched tracepoints
Date:   Tue, 25 Jul 2023 15:22:51 +0800
Message-Id: <20230725072254.32045-1-zegao@tencent.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the status quo, we should see three different outcomes of the reported
sched-out task state from perf-script, perf-sched-timehist, and Tp_printk
of tracepoint sched_switch.  And it's not hard to figure out that the
former two are built upon the third one, and the reason why we see this
inconsistency is that the former two does not catch up with the internal
change of reported task state definitions as the kernel evolves.

IMHO, exporting internal representations of task state in the tracepoint
sched_switch is not a good practice and not encouraged at all, which can
easily break userspace tools that relies on it. Especially when tracepoints
are massively used in many observability tools nowadays due to its stable
nature, which makes them no longer used for debug only purpose and we
should be careful to decide what ought to be reported to userspace and what
ought not.

Therefore, to fix the issues mentioned above for good, instead of choosing
to sync the userspace tracing tools with the latest task states constants
mapping, I proposed to replace reported task state in sched_switch with
a symbolic character, and save the further processing of userspace tools
and spare them from knowing further implementation details in the kernel.

After this patch seires, we report 'RSDTtXZPI' the same as in procfs, plus
a 'p' which denotes PREEMP_ACTIVE and is used for sched_switch tracepoint only.

Reviews welcome!

Regards,

Ze

Ze Gao (2):
  sched, tracing: report task state in symbolic chars instead
  perf sched: sync with latest sched_switch tracepoint definition

 include/trace/events/sched.h | 41 ++++++++++-----------------
 tools/perf/builtin-sched.c   | 55 ++++++------------------------------
 2 files changed, 24 insertions(+), 72 deletions(-)

Ze Gao (1):
  libtraceevent: sync with latest sched_switch tracepoint definition

 plugins/plugin_sched_switch.c | 23 +----------------------
 1 file changed, 1 insertion(+), 22 deletions(-)

-- 
2.40.1

