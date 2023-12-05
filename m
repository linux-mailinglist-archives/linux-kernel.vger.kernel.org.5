Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43FFC806133
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 23:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346345AbjLEV7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 16:59:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjLEV7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 16:59:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA24D5B
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 13:59:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FA32C433C7;
        Tue,  5 Dec 2023 21:59:43 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
        (envelope-from <rostedt@goodmis.org>)
        id 1rAdSc-00000000PNl-1XKj;
        Tue, 05 Dec 2023 17:00:10 -0500
Message-ID: <20231205215208.195443981@goodmis.org>
User-Agent: quilt/0.67
Date:   Tue, 05 Dec 2023 16:52:08 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 0/3] tracing: Keep instance main and snapshot buffers in sync
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fix keeping instance buffers in sync. That is, when the main ring buffer
size is updated, the size of the instance snapshot buffer also needs
to be updated if it is allocated.

Changes since v1: https://lore.kernel.org/all/20231205115223.5256e1a1@gandalf.local.home/

- That was just patch 3 with the change log of patch 1.
  That patch just needs to be ignored.

Steven Rostedt (Google) (3):
      tracing: Always update snapshot buffer size
      tracing: Stop current tracer when resizing buffer
      tracing: Disable snapshot buffer when stopping instance tracers

----
 kernel/trace/trace.c | 123 ++++++++++++++++++---------------------------------
 1 file changed, 42 insertions(+), 81 deletions(-)
