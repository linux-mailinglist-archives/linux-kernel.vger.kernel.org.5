Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBEFF75A4A3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 05:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjGTDJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 23:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjGTDJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 23:09:45 -0400
X-Greylist: delayed 366 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 19 Jul 2023 20:09:42 PDT
Received: from lobo.ruivo.org (lobo.ruivo.org [173.14.175.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E811739
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 20:09:42 -0700 (PDT)
Received: by lobo.ruivo.org (Postfix, from userid 1011)
        id 66E9252C72; Wed, 19 Jul 2023 23:03:35 -0400 (EDT)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Received: from jake.ruivo.org (bob.qemu.ruivo [192.168.72.19])
        by lobo.ruivo.org (Postfix) with ESMTPA id 87ADF529EE;
        Wed, 19 Jul 2023 23:03:17 -0400 (EDT)
Received: by jake.ruivo.org (Postfix, from userid 1000)
        id 6356F220029; Wed, 19 Jul 2023 23:03:17 -0400 (EDT)
Date:   Wed, 19 Jul 2023 23:03:17 -0400
From:   Aristeu Rozanski <aris@ruivo.org>
To:     Tony Luck <tony.luck@intel.com>
Cc:     rostedt@goodmis.org, linux-kernel@vger.kernel.org
Subject: Re: rasdaemon broke between v6.0 and v6.3?
Message-ID: <20230720030317.GC94963@cathedrallabs.org>
References: <ZLhzWoyRCWN0FmqE@agluck-desk3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZLhzWoyRCWN0FmqE@agluck-desk3>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 04:35:54PM -0700, Tony Luck wrote:
> [resend as plain text - sorry for the earlier HTML]
> 
> An internal team is seeing tests that worked on v6.0 fail on v6.3. The problem is that
> rasdaemon isn’t waking up to process the “mce_record” trace events.
> 
> Manually checking for them works:
> 
> root@R-4251:/sys/kernel/debug/tracing>systemctl stop rasdaemon
> root@R-4251:/sys/kernel/debug/tracing>
> root@R-4251:/sys/kernel/debug/tracing>
> root@R-4251:/sys/kernel/debug/tracing>echo 1 > events/mce/mce_record/enable
> root@R-4251:/sys/kernel/debug/tracing>
> root@R-4251:/sys/kernel/debug/tracing>cat trace_pipe
>            <...>-235     [000] .....   596.892583: mce_record: CPU: 0, MCGc/s: f000c15/0, MC13: 8c00004200800090, IPID: 0000000000000000, ADDR/MISC/SYND: 0000000123450000/08000a80c2982086/0000000000000000, RIP: 00:<0000000000000000>, TSC: 14120b051a1, PROCESSOR: 0:c06f1, TIME: 1689802780, SOCKET: 0, APIC: 0
>      kworker/0:2-235     [000] .....   597.204343: mce_record: CPU: 0, MCGc/s: f000c15/0, MC255: 9c0000000000009f, IPID: 0000000000000000, ADDR/MISC/SYND: 0000000123450000/000000000000008c/0000000000000000, RIP: 00:<0000000000000000>, TSC: 0, PROCESSOR: 0:c06f1, TIME: 1689802781, SOCKET: 0, APIC: 0
> 
> So their tests are injecting errors, and the trace event is firing.
> 
> Is there some updated version of rasdaemon needed?
> 
> Some kernel CONFIG option problem?

Looks like you're hitting the issue this commit is supposed to fix:
http://git.infradead.org/users/mchehab/rasdaemon.git/commit/6986d818e6d2c846c001fc7211b5a4153e5ecd11

-- 
Aristeu

