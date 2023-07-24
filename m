Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27AFA75FFD1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 21:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjGXT3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 15:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjGXT3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 15:29:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C5310E4;
        Mon, 24 Jul 2023 12:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0FujArfu7E/KTN1mlKzztQlR74xZ/uhX/VqwNimO1ag=; b=dlXIyuHhxR9o3f2zUpEs3clL+2
        yzn7QTM9lrwYRgpVfZVgAXPrgO1PTsytDOUcOQcMZctsNWdpdIdrqr/05MByXuFHVEy9jlPFzE1Kd
        TMW3mo7ALcEa3zxVeNNBQ8CT1U/LlD6+Olx9bTkiOzjhFPoyhkZgywCDq9m5dLiiikSRCp61kCCKY
        oSuPtOTT3Kc0njtJDicDgBtX6q1SyVvaXgbmYJzW7GjEXWz6lL0+9MrlUsH5KqKL0QgtlHLJGTIML
        kf8FaSWP2NczzlIQFbHHWGX5fHj1xaeZKpwkcaptXSlU2Nr4lOpTS+OndPupkif8/OL3680jPtDUB
        D8X3p1QQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qO1Eg-005Itu-1i;
        Mon, 24 Jul 2023 19:28:50 +0000
Date:   Mon, 24 Jul 2023 12:28:50 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org
Subject: Re: [PATCH 2/2] [v2] kallsyms: rework symbol lookup return codes
Message-ID: <ZL7Q8r8L5FY1bFA/@bombadil.infradead.org>
References: <20230724135327.1173309-1-arnd@kernel.org>
 <20230724135327.1173309-2-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724135327.1173309-2-arnd@kernel.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 03:53:02PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Building with W=1 in some configurations produces a false positive
> warning for kallsyms:
> 
> kernel/kallsyms.c: In function '__sprint_symbol.isra':
> kernel/kallsyms.c:503:17: error: 'strcpy' source argument is the same as destination [-Werror=restrict]
>   503 |                 strcpy(buffer, name);
>       |                 ^~~~~~~~~~~~~~~~~~~~
> 
> This originally showed up while building with -O3, but later started
> happening in other configurations as well, depending on inlining
> decisions. The underlying issue is that the local 'name' variable is
> always initialized to the be the same as 'buffer' in the called functions
> that fill the buffer, which gcc notices while inlining, though it could
> see that the address check always skips the copy.
> 
> The calling conventions here are rather unusual, as all of the internal
> lookup functions (bpf_address_lookup, ftrace_mod_address_lookup,
> ftrace_func_address_lookup, module_address_lookup and
> kallsyms_lookup_buildid) already use the provided buffer and either return
> the address of that buffer to indicate success, or NULL for failure,
> but the callers are written to also expect an arbitrary other buffer
> to be returned.
> 
> Rework the calling conventions to return the length of the filled buffer
> instead of its address, which is simpler and easier to follow as well
> as avoiding the warning. Leave only the kallsyms_lookup() calling conventions
> unchanged, since that is called from 16 different functions and
> adapting this would be a much bigger change.
> 
> Link: https://lore.kernel.org/all/20200107214042.855757-1-arnd@arndb.de/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

For modules side of things:

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
