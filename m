Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F06E79D857
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 20:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237305AbjILSHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 14:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjILSHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 14:07:15 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 362C410D3;
        Tue, 12 Sep 2023 11:07:11 -0700 (PDT)
Received: from localhost.localdomain (unknown [4.155.48.112])
        by linux.microsoft.com (Postfix) with ESMTPSA id AC791212BC16;
        Tue, 12 Sep 2023 11:07:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AC791212BC16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1694542030;
        bh=y1wsenSMOrkmybSIHUz/bazYjNhC0hJ4tRUN+9GanlI=;
        h=From:To:Cc:Subject:Date:From;
        b=I79iPRKd+Rgw5hwAQXekb0Judn6ik8AwfQ4FYhrH4pLCPd0WA9ADtHhscmsFrnCKp
         lPvsaoxhq1BaSG/NHLBhjWuuLNIKP5AUWD/8ucQMbxYQkJFTZD98EXXmGySyvYiBxP
         DBbdzhUsU2eIFvrnrVYRwtI4Duz54xnQ5k5lQWNA=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        ast@kernel.org, dcook@linux.microsoft.com
Subject: [PATCH v2 0/3] tracing/user_events: Allow events to persist for perfmon_capable users
Date:   Tue, 12 Sep 2023 18:07:01 +0000
Message-Id: <20230912180704.1284-1-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Change History:

V2:
Added common user_event_capable() function to check access given
the register flags.

Ensure access check is done for dynamic_events when implicitly removing
events, such as "echo 'u:test' > /sys/kernel/tracing/dynamic_events".

Beau Belgrave (3):
  tracing/user_events: Allow events to persist for perfmon_capable users
  selftests/user_events: Test persist flag cases
  tracing/user_events: Document persist event flags

 Documentation/trace/user_events.rst           | 21 ++++++-
 include/uapi/linux/user_events.h              | 11 +++-
 kernel/trace/trace_events_user.c              | 36 +++++++-----
 .../testing/selftests/user_events/abi_test.c  | 55 ++++++++++++++++++-
 .../testing/selftests/user_events/dyn_test.c  | 54 +++++++++++++++++-
 5 files changed, 157 insertions(+), 20 deletions(-)


base-commit: fc1653abba0d554aad80224e51bcad42b09895ed
-- 
2.34.1

