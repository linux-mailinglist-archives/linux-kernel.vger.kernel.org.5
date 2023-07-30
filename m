Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37FA9768622
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 17:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjG3PG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 11:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjG3PG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 11:06:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E007CD
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 08:06:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6CE360C8C
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 15:06:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA830C433C7;
        Sun, 30 Jul 2023 15:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690729585;
        bh=sxXT8+GXdV7qRF5Fj0Xa8//dfWxQO1148iNut5roa4E=;
        h=Date:From:To:Cc:Subject:From;
        b=DQ7eSIkk9lRxgcR3IYwsMS/YZFCFcxGlQoeQ6nW++m7AXYGDelzVhLW4+pbnNk6hN
         a0akBpdZBiOWKyOcdAWlSpi9Wj0uTQgBiXwNUIGDzJAE3U6/DKoqORgibbiQcklmLI
         o6p29RPBLIvodnochNQdHbzt2aAE7hUdqqofp9tB6NAye7IXWGr0Ea0d0M8FctTGLw
         xtEClq6Q+TSy1quO/5wJ0DTWYZlSE/+pQv9nrDh1fm+b4Clq4NXqxJ5hL/5SmL4AsE
         IhEo6bB1wIRsRAobQza281oq2DfElNHJSQLv+rDuXu8sMma+jsPLJuLjTwqi68choQ
         eDdsqnOUJ0Hfw==
Date:   Mon, 31 Jul 2023 00:06:21 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu (Google) <mhiramat@kernel.org>
Subject: [GIT PULL] probes: Fixes for 6.5-rc3
Message-Id: <20230731000621.1d34c8638a1285901fb6f9a7@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Probe fixes for 6.5-rc3:

- probe-events: Fix to add NULL check for some BTF API calls which can
  return error code and NULL.

- ftrace selftests: Fix to check fprobe and kprobe event correctly. This
  fixes a miss condition of the test command.

- kprobes: Prohibit probing on the function which starts from "__cfi_"
  and "__pfx_" since those are auto generated for kernel CFI and not
  executed.


Please pull the latest probes-fixes-v6.5-rc3 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
probes-fixes-v6.5-rc3

Tag SHA1: 1586c2c77c542c0f9a20bfe5bbebfc739f8dbd2a
Head SHA1: de02f2ac5d8cfb311f44f2bf144cc20002f1fbbd


Masami Hiramatsu (Google) (3):
      tracing/probes: Fix to add NULL check for BTF APIs
      selftests/ftrace: Fix to check fprobe event eneblement
      kprobes: Prohibit probing on CFI preamble symbol

----
 kernel/kprobes.c                                           | 14 +++++++++++++-
 kernel/trace/trace_probe.c                                 |  8 ++++----
 .../selftests/ftrace/test.d/dynevent/add_remove_btfarg.tc  |  2 +-
 3 files changed, 18 insertions(+), 6 deletions(-)

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
