Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F3B792F85
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 22:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242614AbjIEUIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 16:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242565AbjIEUIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 16:08:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3825EFA;
        Tue,  5 Sep 2023 13:08:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 847B1C433B6;
        Tue,  5 Sep 2023 18:26:52 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qdalb-000zNZ-28;
        Tue, 05 Sep 2023 14:27:11 -0400
Message-ID: <20230905182607.505212458@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 05 Sep 2023 14:26:07 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ajay Kaher <akaher@vmware.com>,
        kernel test robot <oliver.sang@intel.com>,
        Ching-lin Yu <chinglinyu@google.com>
Subject: [PATCH 0/2] tracing: Add missing LOCKDOWN_TRACEFS checking
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


When LOCKDOWN_TRACEFS is activated, some of the tracefs functions can
still return success leaving tracefs in an undefined state.

I broke this up into two patches. One that fixes just tracefs that
existed before this merge window and needs to be backported to stable.
The other fixes changes added to this merge window.

This should fix the issue reported by kernel test robot:

  https://lore.kernel.org/all/202309050916.58201dc6-oliver.sang@intel.com/

Steven Rostedt (Google) (2):
      tracefs: Add missing lockdown check to tracefs_create_dir()
      tracefs/eventfs: Add missing lockdown checks

----
 fs/tracefs/event_inode.c | 15 +++++++++++++++
 fs/tracefs/inode.c       |  3 +++
 2 files changed, 18 insertions(+)
