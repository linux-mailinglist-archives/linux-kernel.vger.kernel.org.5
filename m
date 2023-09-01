Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06B77902E3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 22:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350754AbjIAUno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 16:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245611AbjIAUnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 16:43:42 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E84F0E7F;
        Fri,  1 Sep 2023 13:43:38 -0700 (PDT)
Received: from localhost.localdomain (unknown [4.155.48.116])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5FDA9212A77F;
        Fri,  1 Sep 2023 13:43:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5FDA9212A77F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1693601018;
        bh=Hf9SnXuceZoq/4/ofWf9A3vljxlLROGDFUiObueCNRA=;
        h=From:To:Cc:Subject:Date:From;
        b=fbpcM+2borID5F7aXvRUS8dbyap3lmwghhlvbZ4vyke2NDcgKfG6I11aazX3+MnBN
         /3gCurGAPs36iohHOK7EPXKH0OArug9ZrgbJlUH9TXa3v9Nt664JU7h/r/iJ2zT4L7
         SSTbzQYvlJwGZboztLfZ+oG2xh7Rca1voJl9jN8w=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        ast@kernel.org, dcook@linux.microsoft.com
Subject: [PATCH 0/3] tracing/user_events: Allow events to persist for perfmon_capable users
Date:   Fri,  1 Sep 2023 20:43:29 +0000
Message-Id: <20230901204332.159-1-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are several scenarios that have come up where having a user_event
persist even if the process that registered it exits. The main one is
having a daemon create events on bootup that shouldn't get deleted if
the daemon has to exit or reload. Another is within OpenTelemetry
exporters, they wish to potentially check if a user_event exists on the
system to determine if exporting the data out should occur. The
user_event in this case must exist even in the absence of the owning
process running (such as the above daemon case).

Since persistent events aren't automatically cleaned up, we want to ensure
only trusted users are allowed to do this. It seems reasonable to use
CAP_PERFMON as that boundary, since those users can already do many things
via perf_event_open without requiring full CAP_SYS_ADMIN.

This patchset brings back the ability to use /sys/kernel/tracing/dynamic_events
to create user_events, as persist is now back to being supported. Both the
register and delete of events that persist require CAP_PERFMON, which prevents
a non-perfmon user from making an event go away that a perfmon user decided
should persist.

Beau Belgrave (3):
  tracing/user_events: Allow events to persist for perfmon_capable users
  selftests/user_events: Test persist flag cases
  tracing/user_events: Document persist event flags

 Documentation/trace/user_events.rst           | 21 ++++++-
 include/uapi/linux/user_events.h              | 11 +++-
 kernel/trace/trace_events_user.c              | 28 +++++-----
 .../testing/selftests/user_events/abi_test.c  | 55 ++++++++++++++++++-
 .../testing/selftests/user_events/dyn_test.c  | 54 +++++++++++++++++-
 5 files changed, 149 insertions(+), 20 deletions(-)


base-commit: f940e482b0f889e697372a22b6c15da87aa1f63a
-- 
2.34.1

