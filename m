Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63DF577FA71
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 17:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352954AbjHQPNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 11:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353047AbjHQPNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 11:13:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27752705;
        Thu, 17 Aug 2023 08:12:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 93C5B65C96;
        Thu, 17 Aug 2023 15:12:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76C4DC433C8;
        Thu, 17 Aug 2023 15:12:58 +0000 (UTC)
Date:   Thu, 17 Aug 2023 11:13:03 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Francis Laniel <flaniel@linux.microsoft.com>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/1] tracing/kprobe: Add multi-probe support for
 'perf_kprobe' PMU
Message-ID: <20230817111303.47b50197@gandalf.local.home>
In-Reply-To: <4852847.31r3eYUQgx@pwmachine>
References: <20230816163517.112518-1-flaniel@linux.microsoft.com>
        <20230816163517.112518-2-flaniel@linux.microsoft.com>
        <20230816144213.0f24cc62@gandalf.local.home>
        <4852847.31r3eYUQgx@pwmachine>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Aug 2023 12:59:30 +0200
Francis Laniel <flaniel@linux.microsoft.com> wrote:

> > Why can't you just pass in the address like sysfs does?  
> 
> To get the addresses from /proc/kallsyms, you need to either have CAP_SYSLOG 
> or even CAP_SYS_ADMIN.
> But to call perf_event_open(), you only need CAP_PERFMON.
> This way, by giving only the name you can trace function with less privileges 
> (i.e. without CAP_SYS_ADMIN).
> Please correct me if I am wrong as I am not an expert in knowing the minimal 
> set of capabilities you need to trace.

I wonder if we should add an option to put in the non-relocated address?
One that can be acquired by debuginfo in the vmlinux. I'm assuming that the
kernel has access to the added offset (I haven't looked). If it does, then
we could allow users to just add something like "+@0xffffffffdeadbeef" and
add the relocation offset to get to the mapped address of the function.

This would allow those without kallsym privileges to pass in kernel address
for tracing.

-- Steve
