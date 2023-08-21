Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8A7782C5F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 16:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236100AbjHUOpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 10:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232349AbjHUOpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 10:45:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FACBE3;
        Mon, 21 Aug 2023 07:45:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97049617A6;
        Mon, 21 Aug 2023 14:45:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4765DC433C8;
        Mon, 21 Aug 2023 14:45:36 +0000 (UTC)
Date:   Mon, 21 Aug 2023 10:45:50 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Song Liu <song@kernel.org>,
        Francis Laniel <flaniel@linux.microsoft.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [RFC PATCH v1 1/1] tracing/kprobe: Add multi-probe support for
 'perf_kprobe' PMU
Message-ID: <20230821104550.57d60a75@gandalf.local.home>
In-Reply-To: <20230821190152.c467e40a5ee3d57715600159@kernel.org>
References: <20230816163517.112518-1-flaniel@linux.microsoft.com>
        <20230818213705.b4f5e18b392c4837068cba6f@kernel.org>
        <20230818114141.2a3a75ee@gandalf.local.home>
        <4853240.31r3eYUQgx@pwmachine>
        <20230818142033.1d7685e9@gandalf.local.home>
        <20230819101519.568d658fbb6461cc60d348e5@kernel.org>
        <CAPhsuW7d4cMi_FAtvyTn4HJWzRdocJaEVq-uYVcW43=JDE_EnA@mail.gmail.com>
        <20230820183218.bf0b04be3c0ccac5e7b2a587@kernel.org>
        <CAPhsuW73yT+D9HhLhi8pafYZsgT=qsqk5foAwGRTvStnWCZwNA@mail.gmail.com>
        <20230820221612.33dfc3b3072f8bd8517f95b5@kernel.org>
        <CAPhsuW7+dRddDe9XLuM2ANnGZOa2J4MnSDkWZ_xZCGVxj02bXQ@mail.gmail.com>
        <20230821190152.c467e40a5ee3d57715600159@kernel.org>
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

On Mon, 21 Aug 2023 19:01:52 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > kprobe BPF program has access to pt_regs, so it can read ip of the
> > attached function. Can we do the same with regular kprobe (no bpf)?  
> 
> Yes, it can. So I think it is OK to expand CAP_PERFMON to access kallsyms.
> But this means CAP_PERMON itself is not safe in some case.

What are the privileges that CAP_PERFMON gives. I can see why Kees told me
to avoid capabilities when looking at what has access to tracefs. Because
it becomes very difficult to know what the privileges you are giving when
you give out a capability. I just stick to normal ACL (file permissions)
and everything is much easier and simpler to know what has access to what.

-- Steve
