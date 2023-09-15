Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC35A7A2486
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 19:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235489AbjIORTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 13:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235995AbjIORT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 13:19:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 366632720;
        Fri, 15 Sep 2023 10:18:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1D6CC433C8;
        Fri, 15 Sep 2023 17:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694798296;
        bh=YO2T/6WW3bJjxN+Z8mYt9aoZJVmK6skob5Zddb0K2Gs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fm4mzSfILYdRHi+Q7V7D1B9m2b6jcr5JpeHoccD7vrqlE01LU9KltJ6EDE5Fegy3q
         dg2+n8iGr5mYcARWKi6Xl3bWvQJnmgHZ5nyhorw9X9PEcuy8V8llZaO5Sns3R63EtK
         wCnvF3tQ8V+4/+VcpOJBexc3fUH7Fmfqt6113MVJN8sb+srXjd+onx2RZ+zL3Q6B/d
         kmaJa4Dd8pHTSVfC1A9oqSm7eHjPY3iJ1ux39KVTJqaC3SVcVM2Rn4z/7jiuBaNoEO
         suWD+BXhFGq4MMPZl3RtSO8nyzBQ+jdcE0KD2wD2fCgF+C65H+DNLWfvpPLxx41XXn
         5jd6BDszX+R7Q==
Date:   Fri, 15 Sep 2023 10:18:14 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, stable@vger.kernel.org,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Marcus Seyfarth <m.seyfarth@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH v2] bpf: Fix BTF_ID symbol generation collision
Message-ID: <20230915171814.GA1721473@dev-arch.thelio-3990X>
References: <20230915-bpf_collision-v2-1-027670d38bdf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915-bpf_collision-v2-1-027670d38bdf@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 09:42:20AM -0700, Nick Desaulniers wrote:
> Marcus and Satya reported an issue where BTF_ID macro generates same
> symbol in separate objects and that breaks final vmlinux link.
> 
>   ld.lld: error: ld-temp.o <inline asm>:14577:1: symbol
>   '__BTF_ID__struct__cgroup__624' is already defined
> 
> This can be triggered under specific configs when __COUNTER__ happens to
> be the same for the same symbol in two different translation units,
> which is already quite unlikely to happen.
> 
> Add __LINE__ number suffix to make BTF_ID symbol more unique, which is
> not a complete fix, but it would help for now and meanwhile we can work
> on better solution as suggested by Andrii.
> 
> Cc: stable@vger.kernel.org
> Reported-by: Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>
> Reported-by: Marcus Seyfarth <m.seyfarth@gmail.com>
> Closes: https://github.com/ClangBuiltLinux/linux/issues/1913
> Tested-by: Marcus Seyfarth <m.seyfarth@gmail.com>
> Debugged-by: Nathan Chancellor <nathan@kernel.org>
> Co-developed-by: Jiri Olsa <jolsa@kernel.org>
> Link: https://lore.kernel.org/bpf/CAEf4Bzb5KQ2_LmhN769ifMeSJaWfebccUasQOfQKaOd0nQ51tw@mail.gmail.com/
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  tools/include/linux/btf_ids.h | 2 +-

Shouldn't this diff be in include/linux/btf_ids.h as well? Otherwise, I
don't think it will be used by the kernel build.

>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/include/linux/btf_ids.h b/tools/include/linux/btf_ids.h
> index 71e54b1e3796..30e920b96a18 100644
> --- a/tools/include/linux/btf_ids.h
> +++ b/tools/include/linux/btf_ids.h
> @@ -38,7 +38,7 @@ asm(							\
>  	____BTF_ID(symbol)
>  
>  #define __ID(prefix) \
> -	__PASTE(prefix, __COUNTER__)
> +	__PASTE(prefix, __COUNTER__ __LINE__)
>  
>  /*
>   * The BTF_ID defines unique symbol for each ID pointing
> 
> ---
> base-commit: 9fdfb15a3dbf818e06be514f4abbfc071004cbe7
> change-id: 20230915-bpf_collision-36889a391d44
> 
> Best regards,
> -- 
> Nick Desaulniers <ndesaulniers@google.com>
> 
