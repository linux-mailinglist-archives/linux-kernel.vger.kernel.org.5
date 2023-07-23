Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9858375E4B5
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 22:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjGWUG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 16:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGWUG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 16:06:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E99E124
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 13:06:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C33560E99
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 20:06:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F1E2C433C7;
        Sun, 23 Jul 2023 20:06:54 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qNfLx-001c1a-1X;
        Sun, 23 Jul 2023 16:06:53 -0400
Message-ID: <20230723200623.034313147@goodmis.org>
User-Agent: quilt/0.66
Date:   Sun, 23 Jul 2023 16:06:23 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/3] tracing: Minor fixes for 6.5-rc2
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tracing fixes for 6.5-rc2:

- Swapping the ring buffer for snapshotting (for things like irqsoff)
  can crash if the ring buffer is being resized. Disable swapping
  when this happens. The missed swap will be reported to the tracer.

- Report error if the histogram fails to be created due to an error in
  adding a histogram variable, in event_hist_trigger_parse().

- Remove unused declaration of tracing_map_set_field_descr().


Chen Lin (1):
      ring-buffer: Do not swap cpu_buffer during resize process

Mohamed Khalfella (1):
      tracing/histograms: Return an error if we fail to add histogram to hist_vars list

YueHaibing (1):
      tracing: Remove unused extern declaration tracing_map_set_field_descr()

----
 kernel/trace/ring_buffer.c       | 14 +++++++++++++-
 kernel/trace/trace.c             |  3 ++-
 kernel/trace/trace_events_hist.c |  3 ++-
 kernel/trace/tracing_map.h       |  4 ----
 4 files changed, 17 insertions(+), 7 deletions(-)
