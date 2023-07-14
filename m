Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9B3C753C38
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 15:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235488AbjGNNyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 09:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235800AbjGNNyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 09:54:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE6A35AD
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 06:54:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CD1B61D24
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 13:54:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CC3BC433C9;
        Fri, 14 Jul 2023 13:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689342867;
        bh=fnsr69YEFhL0CNDEAvXZxjBa2ltEn94RQ8xp+FTmL3A=;
        h=Date:From:To:Cc:Subject:From;
        b=eShTfDSZe5wjAfLxpDWrKMGCWTHd3Rxr0uGH+P0N+rAWd5wtYu3BzR8BcylfSMTjs
         An119s9bWWp8tlZ/77OJfGQMOEnWx1Wa118U35SIBu4ZBvsxWVoNYI3iYO+PrBAsTk
         uNojjQeICRIEhBc4aayvb988++69Sj73yguE8rMSsl4N/v/jxknv/RL3GLNL0zbGRx
         RCJSeExp+kCb5OOcDWgcYgyMwxTFj2JrO+L4y0oAAGTie5XsRW/Em+bDFfLUR74RJU
         rcDnYs0DcvwmaxSN+hi50ZXBOThxYgrqf0XJwr96Te+Z+Oxc+zYcilKKNrAnsv96Df
         d/fVcEZbkzcFw==
Date:   Fri, 14 Jul 2023 22:54:23 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] probes: 2nd fix series for v6.5-rc1
Message-Id: <20230714225423.58bce65b3a6f65acfcc49c97@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Probe fixes for 6.5-rc1, the 2nd set:

 - fprobe: Add a comment why fprobe will be skipped if another kprobe is
   running in fprobe_kprobe_handler().

 - probe-events: Fix some issues related to fetch-argument
  . Fix double counting of the string length for user-string and symstr.
    This will require longer buffer in the array case.
  . Fix not to count error code (minus value) for the total used length
    in array argument. This makes the total used length shorter.
  . Fix to update dynamic used data size counter only if fetcharg uses
    the dynamic size data. This may mis-count the used dynamic data
    size and corrupt data.
  . Revert "tracing: Add "(fault)" name injection to kernel probes"
    because that did not work correctly with a bug, and we agreed the
    current '(fault)' output (instead of '"(fault)"' like a string)
    explains what happened more clearly.
  . Fix to record 0-length (means fault access) data_loc data in fetch
    function itself, instead of store_trace_args(). If we record an
    array of string, this will fix to save fault access data on each
    entry of the array correctly.


Please pull the latest probes-fixes-v6.5-rc1-2 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
probes-fixes-v6.5-rc1-2

Tag SHA1: 48d932f93e2c38d39b53a7518c4fa2e221b53a50
Head SHA1: 797311bce5c2ac90b8d65e357603cfd410d36ebb


Masami Hiramatsu (Google) (6):
      fprobes: Add a comment why fprobe_kprobe_handler exits if kprobe is running
      tracing/probes: Fix to avoid double count of the string length on the array
      tracing/probes: Fix not to count error code to total length
      tracing/probes: Fix to update dynamic data counter if fetcharg uses it
      Revert "tracing: Add "(fault)" name injection to kernel probes"
      tracing/probes: Fix to record 0-length data_loc in fetch_store_string*() if fails

----
 kernel/trace/fprobe.c             |  6 ++++++
 kernel/trace/trace.h              |  2 ++
 kernel/trace/trace_probe.c        |  2 +-
 kernel/trace/trace_probe_kernel.h | 30 ++++++++----------------------
 kernel/trace/trace_probe_tmpl.h   | 10 +++++-----
 kernel/trace/trace_uprobe.c       |  3 ++-
 6 files changed, 24 insertions(+), 29 deletions(-)


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
