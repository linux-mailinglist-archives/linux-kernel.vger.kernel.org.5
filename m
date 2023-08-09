Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFEF6775715
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 12:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbjHIK30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 06:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbjHIK3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 06:29:25 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215E31999
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 03:29:25 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-56d263da4f2so4771681eaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 03:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691576964; x=1692181764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dbRTactPL+UoTh7JhtLP7m2QS4BKZHHCNQWVDx5nQag=;
        b=GEO0/nvBajwIJUPnEU41+WNGwH2DtulMBc4FPYU1jw1eJyQzRO1uSpXBuBH8QLOwCt
         GwhW7UCHdaFTfMpbBv5D8LXISJFDNz6p84oe70QtyPQ0jjTGD/KZxrq2YaTVBZXBmjLX
         O/QMcqR39ySFwSZn+/0ISTfXyj/Fu+13hAe1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691576964; x=1692181764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dbRTactPL+UoTh7JhtLP7m2QS4BKZHHCNQWVDx5nQag=;
        b=AKdWrnwyF9bVgEMLvTQ1EqUdJYPVcVOw/G4dv8MPNElAGGAlKGOwdvA0Iz74cO0sZd
         tJ7ma5O/zAXWcmGEPvn9Oq0m1hjYZhvr+io6ZH/Ur8MZ74c6cw2ammUf4J+MrDq1OdAU
         lTGhKmfyI0ks6flveuwP9dHlsBk+1AtfIZXIuGBY3cTD4Ztivtx0t3ixrDxKGGzzDDpy
         R9DAOg4eYFfTJtU8GzE8wzeBYwch70oYEd9S5qt0hpKGwMNscY1ehMYoZj9yjVtZ+lPq
         mD+ndI9Y38sdaiaDLb9UiILWKXkgNi7yfRaOG2hNK+9OAnTFm0LZufN2kfdcSMXmo5ia
         IKSQ==
X-Gm-Message-State: AOJu0Yz6D5CRBBSdxDYd32jzX5BHa54WWynwXXGV6Wc/e0VfjdYCjNkv
        CfcdbE5TvuS1KquLySfoj541DBAz0Ntb2FaPCMB0hg==
X-Google-Smtp-Source: AGHT+IGZRaNEp0r0k3lBJzbjA9stkGRIasFKmrjd8YKrsWWFriAXqq3HukzU4wsTEvJmwBf0L3B0LsNobh4bY0RjQds=
X-Received: by 2002:aca:2113:0:b0:3a7:4878:235a with SMTP id
 19-20020aca2113000000b003a74878235amr2168484oiz.29.1691576964523; Wed, 09 Aug
 2023 03:29:24 -0700 (PDT)
MIME-Version: 1.0
References: <169139090386.324433.6412259486776991296.stgit@devnote2> <169139092722.324433.16681957760325391475.stgit@devnote2>
In-Reply-To: <169139092722.324433.16681957760325391475.stgit@devnote2>
From:   Florent Revest <revest@chromium.org>
Date:   Wed, 9 Aug 2023 12:29:13 +0200
Message-ID: <CABRcYmJpA7tWk7pNxMy-44aoT9fFByQY3kGiEfKDbOe9WPkmNg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/6] tracing: Expose ftrace_regs regardless of CONFIG_FUNCTION_TRACER
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        bpf <bpf@vger.kernel.org>, Sven Schnelle <svens@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alan Maguire <alan.maguire@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 7, 2023 at 8:48=E2=80=AFAM Masami Hiramatsu (Google)
<mhiramat@kernel.org> wrote:
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index ce156c7704ee..3fb94a1a2461 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -112,11 +112,11 @@ static inline int ftrace_mod_get_kallsym(unsigned i=
nt symnum, unsigned long *val
>  }
>  #endif
>
> -#ifdef CONFIG_FUNCTION_TRACER
> -
> -extern int ftrace_enabled;
> -
> -#ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
> +/*
> + * If the architecture doesn't support FTRACE_WITH_ARGS or disable funct=
ion

nit: disables*

> + * tracer, define the default(pt_regs compatible) ftrace_regs.
> + */
> +#if !defined(CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS) || !defined(CONFIG_FU=
NCTION_TRACER)

I wonder if we should make things simpler with:

#if defined(HAVE_PT_REGS_COMPAT_FTRACE_REGS) || !defined(CONFIG_FUNCTION_TR=
ACER)

And remove the ftrace_regs definitions that are copy-pastes of this
block in arch specific headers. Then we can enforce in a single point
that HAVE_PT_REGS_COMPAT_FTRACE_REGS holds.

Maybe that's a question for Steven ?
