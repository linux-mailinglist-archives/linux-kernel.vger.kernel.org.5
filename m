Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22CAB7907A4
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 13:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352067AbjIBLvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 07:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbjIBLvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 07:51:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D3DE6A
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 04:51:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F259E60ACF
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 11:51:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B2DBC433C8;
        Sat,  2 Sep 2023 11:51:06 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qcP9q-000Juz-0b;
        Sat, 02 Sep 2023 07:51:18 -0400
Message-ID: <20230902115035.786076237@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 02 Sep 2023 07:50:35 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 00/11] tracing: Minor fixes for 6.6
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Tracing fixes and clean ups for 6.6:

 - Replace strlcpy() with strscpy()

 - Initialize the pipe cpumask to zero on allocation

 - Use within_module() instead of open coding it

 - Remove extra space in hwlat_detectory/mode output

 - Use LIST_HEAD() instead of open coding it

 - A bunch of clean ups and fixes for the cpumask filter

 - Set local da_mon_##name to static

 - Fix race in snapshot buffer between cpu write and swap

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace/urgent

Head SHA1: cbb557ba92f08b945e2cb20b7ab37ef49ab53cdd


Azeem Shaikh (1):
      tracing: Replace strlcpy with strscpy in trace/events/task.h

Brian Foster (1):
      tracing: Zero the pipe cpumask on alloc to avoid spurious -EBUSY

Levi Yun (1):
      ftrace: Use within_module to check rec->ip within specified module.

Mikhail Kobuk (1):
      tracing: Remove extra space at the end of hwlat_detector/mode

Ruan Jinjie (1):
      ftrace: Use LIST_HEAD to initialize clear_hash

Valentin Schneider (4):
      tracing/filters: Fix error-handling of cpulist parsing buffer
      tracing/filters: Fix double-free of struct filter_pred.mask
      tracing/filters: Change parse_pred() cpulist ternary into an if block
      tracing/filters: Fix coding style issues

Yu Liao (1):
      rv: Set variable 'da_mon_##name' to static

Zheng Yejian (1):
      tracing: Fix race issue between cpu buffer write and swap

----
 include/rv/da_monitor.h            |  2 +-
 include/trace/events/task.h        |  2 +-
 kernel/trace/ftrace.c              | 10 +++-------
 kernel/trace/trace.c               | 21 ++++++++++++++-------
 kernel/trace/trace_events_filter.c | 25 +++++++++++++++++++------
 kernel/trace/trace_hwlat.c         |  2 +-
 6 files changed, 39 insertions(+), 23 deletions(-)
