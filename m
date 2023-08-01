Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329B976B7D6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 16:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234700AbjHAOlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 10:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233684AbjHAOlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 10:41:37 -0400
Received: from out-94.mta0.migadu.com (out-94.mta0.migadu.com [91.218.175.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921C01702
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 07:41:36 -0700 (PDT)
Message-ID: <c643db9c-c9fb-9e8d-f35c-e5c9316f657d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1690900894; h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V4lu9rl80wnpynbxYMmCvM9Rbb29PtC/a1L2v3oqVO0=;
        b=qVaXNcLloEZwQ2po8bFkXfXrg349uHQUgN8d/XBrekpVlt+0SSC30kHjxtrIdeMT1gDnTR
        CkVGzp5+BONOjUUfdt7ukfJMwMQ35o+ByfUy8Mhv0SsUFyiBPNK7tP+0UdeW2t38BnZefB
        8Gck6qbJnSiJKaq139e4ecgImIX7OUo=
Date:   Tue, 1 Aug 2023 07:41:26 -0700
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH] [v5] bpf: fix bpf_probe_read_kernel prototype mismatch
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, stable@vger.kernel.org,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        David Vernet <void@manifault.com>,
        Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20230801111449.185301-1-arnd@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20230801111449.185301-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/1/23 4:13 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> bpf_probe_read_kernel() has a __weak definition in core.c and another
> definition with an incompatible prototype in kernel/trace/bpf_trace.c,
> when CONFIG_BPF_EVENTS is enabled.
> 
> Since the two are incompatible, there cannot be a shared declaration in
> a header file, but the lack of a prototype causes a W=1 warning:
> 
> kernel/bpf/core.c:1638:12: error: no previous prototype for 'bpf_probe_read_kernel' [-Werror=missing-prototypes]
> 
> On 32-bit architectures, the local prototype
> 
> u64 __weak bpf_probe_read_kernel(void *dst, u32 size, const void *unsafe_ptr)
> 
> passes arguments in other registers as the one in bpf_trace.c
> 
> BPF_CALL_3(bpf_probe_read_kernel, void *, dst, u32, size,
>              const void *, unsafe_ptr)
> 
> which uses 64-bit arguments in pairs of registers.
> 
> As both versions of the function are fairly simple and only really
> differ in one line, just move them into a header file as an inline
> function that does not add any overhead for the bpf_trace.c callers
> and actually avoids a function call for the other one.
> 
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/all/ac25cb0f-b804-1649-3afb-1dc6138c2716@iogearbox.net/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Yonghong Song <yonghong.song@linux.dev>
