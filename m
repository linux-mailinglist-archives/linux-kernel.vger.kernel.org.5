Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF367B760A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 03:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbjJDBCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 21:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjJDBCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 21:02:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B443A9
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 18:02:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38633C433C8;
        Wed,  4 Oct 2023 01:02:03 +0000 (UTC)
Date:   Tue, 3 Oct 2023 21:03:09 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] tracing/timerlat: Hotplug support for the user-space
 interface
Message-ID: <20231003210309.4335307d@gandalf.local.home>
In-Reply-To: <a1bbd57692c1a59458c4ee99999b7f83a29bc3c5.1695999408.git.bristot@kernel.org>
References: <a1bbd57692c1a59458c4ee99999b7f83a29bc3c5.1695999408.git.bristot@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Sep 2023 17:02:46 +0200
Daniel Bristot de Oliveira <bristot@kernel.org> wrote:

> The osnoise/per_cpu/CPU$/timerlat_fd is create for each possible
> CPU, but it might create confusion if the CPU is not online.
> 
> Create the file only for online CPUs, also follow hotplug by
> creating and deleting as CPUs come and go.
> 
> Fixes: e88ed227f639 ("tracing/timerlat: Add user-space interface")

Is this a fix that needs to go in now and Cc'd to stable? Or is this
something that can wait till the next merge window?

-- Steve


> Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
> ---
> 
> Changes from V2:
>   - Better split the code into the generic (per_cpu/cpu$)
>     and timerlat (/timerlat_fd) specific function (Daniel)
>   - Fixed a cpus_read_lock/unlock() usage (kbuild test)
>   Link: https://lore.kernel.org/lkml/6b9a5f306e488bc77bf8521faeade420a0adf3e4.1695224204.git.bristot@kernel.org/
> 
> Changes from V1:
>   - Fix compilation issue when !HOTPLUG
>   - Fix init interface | hotplug race
>   Link: https://lore.kernel.org/lkml/b619d9fd08a3bb47018cf40afa95783844a3c1fd.1694789910.git.bristot@kernel.org/
> 
>  kernel/trace/trace_osnoise.c | 149 ++++++++++++++++++++++++++++-------
>  1 file changed, 121 insertions(+), 28 deletions(-)
> 
>
