Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B57475AC32
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 12:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbjGTKkf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 20 Jul 2023 06:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjGTKkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 06:40:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A775510F1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 03:40:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36D46619D6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 10:40:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A708C433C7;
        Thu, 20 Jul 2023 10:40:29 +0000 (UTC)
Date:   Thu, 20 Jul 2023 06:40:28 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Aristeu Rozanski <aris@ruivo.org>, linux-kernel@vger.kernel.org
Subject: Re: rasdaemon broke between v6.0 and v6.3?
Message-ID: <20230720064028.1aeb3c18@gandalf.local.home>
In-Reply-To: <ZLhzWoyRCWN0FmqE@agluck-desk3>
References: <ZLhzWoyRCWN0FmqE@agluck-desk3>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jul 2023 16:35:54 -0700
Tony Luck <tony.luck@intel.com> wrote:

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
> 

A bug was fixed that I think affected rasdaemon.

commit 3e46d910d8acf94e5360126593b68bf4fee4c4a1
Author: Shiju Jose <shiju.jose@huawei.com>
Date:   Thu Feb 2 18:23:09 2023 +0000

    tracing: Fix poll() and select() do not work on per_cpu trace_pipe and trace_pipe_raw

Make sure /sys/kernel/tracing/buffer_percent = 0

-- Steve
