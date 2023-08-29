Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B98378C276
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 12:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235143AbjH2Kl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 06:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232916AbjH2Kk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 06:40:56 -0400
Received: from mx.exactcode.de (mx.exactcode.de [144.76.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE42319F
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 03:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=exactco.de; s=x;
        h=From:Cc:To:Message-Id:Date; bh=KX8QTz3c+K2TezNJslC+a8871SHZBAhhiH2EqdRXY3s=;
        b=hcPo9Tlu4q9IQGMFqahQ1dX4fun989JEZNt89ce3wmAFw51wZtVBZ2L5w5vxW6l+Xi35f1b8Z5C9HoDlbVDMMQBNYQiO5fx0xhYepnWSUcqCeaRmjwGgFufbkmzDtlusJZKAgLOSy4lU3orrBi29fo3oeJRGjN5UwdFD/86GytY=;
Received: from exactco.de ([90.187.5.221])
        by mx.exactcode.de with esmtp (Exim 4.82)
        (envelope-from <rene@exactcode.com>)
        id 1qawA8-0004l8-Al; Tue, 29 Aug 2023 10:41:32 +0000
Received: from [192.168.2.103] (helo=localhost)
        by exactco.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.86_2)
        (envelope-from <rene@exactcode.com>)
        id 1qaw9f-0007li-L5; Tue, 29 Aug 2023 10:41:04 +0000
Date:   Tue, 29 Aug 2023 12:40:51 +0200 (CEST)
Message-Id: <20230829.124051.819197662377979913.rene@exactcode.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
X-Spam-Score: 0.3 (/)
From:   rene@exactcode.com
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,MISSING_SUBJECT,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Scheduler not fully honoring CPU priorities for pref perf cores
From: Rene Rebe <rene@exactcode.com>
X-Mailer: Mew version 6.8 on Emacs 29.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hey there,

over the weekend I tested the AMD cppc prefcore patch[1], and after
fixing it (sigh) and seeing some improvements, I was still suprised
that the kernel scheduler with SCHED_MC_PRIO=3Dy would not more relibal=
e
schedule to the highest perf cores.

For examples this are the sorted perf values and associated cpu cores
set by the AMD pstate code via sched_set_itmt_core_prio() and thus
returned by arch_asym_cpu_priority

236 0 16
236 2 18
231 4 20
226 5 21
221 1 17
216 7 23
211 6 22
206 3 19
201 15 31
196 13 29
191 11 27
186 14 30
181 12 28
176 10 26
171 8 24
166 9 25

And I would expect the scheduler to fill the SMT siblings by priority,
e.g. any of: 0/16, 2/18, 4/20, ... However, while this "somewhat"
happens, it does not reliably happen always . For example currently,
with the 6.4 or 6.5 kernel, the Linux scheduelr somehow quite
deterministically decides to first use core 15 for me, before
utilizing 0, 2 or 4 and often throws in core 13, too - before using
other higher boosting cores.

AFAICS there appears to be quite some missed opportunity here, given
that some workloads have minute long single or few threada loads,
e.g. minute long gcc, clang, rustc LTO linking (at times 4-6 minutes
in the case of Firefox even on a Ryzen 7950x) there appears to be
quite some room for improvements. In the current state I can meassure
a ~0.7% performance improvement with the (fixed) AMD prefered core
patch, while as a test manually re-scheduling lto linker jobs from
mediocre to highest performance cores using taskset from user-space I
can reach a avg. improvement of 200MHz and nearly 2% of total Firefox
build time improvement. I would expect many such workloads, including
possibly Linux gaming to have such room for improvements.
Unfortunately I don't have a compatible Intel Turbo Boost Max
Technology system to test if their initial implementation would have
behave any better.

I tried to debug this, however, as you probably can imagine, there are
quite many different scheduling conditions to follow and understand for=

someone not regularly working on the scheduler. So I thought I better
drop a quick note and ask for input. Any guidance how to best debug
this scheduler decisions would be highly appreciated, as I did not yet
find a good way to debug this further, ... :-/

Thank you so much,

	Ren=E9

1) https://lore.kernel.org/linux-acpi/20230829064340.1136448-1-li.meng@=
amd.com/

-- =

  Ren=E9 Rebe, ExactCODE GmbH, Lietzenburger Str. 42, DE-10789 Berlin
  https://exactcode.com | https://t2sde.org | https://rene.rebe.de
