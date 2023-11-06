Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3E37E1946
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 04:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjKFDxQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 5 Nov 2023 22:53:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjKFDxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 22:53:14 -0500
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27293B8;
        Sun,  5 Nov 2023 19:53:12 -0800 (PST)
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6b5af4662b7so3228675b3a.3;
        Sun, 05 Nov 2023 19:53:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699242791; x=1699847591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V9fuperXbeRFYlZWP5/ntLp8L3b3+pqukS7QhZ37B4g=;
        b=gKMVxxTad4M2cJgx46voGyaaaAJ2PLdgkl1H3dmnquvQqLImuYmNNWItpqgzs6CFwS
         P8dln463ICN/OfwB6QkhHUnymrZPQYiWFgtPTYyEqyV+H2DHB270SEyiYA9HcwIq5A48
         1ofScY/5UFqwkfvVVCHfY+2hu89pdcnEZPmdFYQvRFHZOjhxH9vzBq5KSOP4Zx8FCxgG
         m9opSPXAtiSYtFBFPDEyciyIc9gRTPbolb+q+EM0yTMq7DXhOXnG4X/FDCOvVFw4EtpG
         Eel4s2PVhvw/sNE3iOUwcM3qdU3yCeBV8Ejd0gjV7rl407QX/EnU59HJCt/lIkDxwa/k
         Adgg==
X-Gm-Message-State: AOJu0YyG++K4+2gY1atcFLBdlWquVZGQMYtbYQUp8QfdBI6P1PZGOlVW
        XRnshl5rpIMu2bIBPdWWinu2n06OCF1plX2K7X4=
X-Google-Smtp-Source: AGHT+IEMFJMj6FwaXzp9OKZ1xMULFepLkLhpWrOdhdq5zAb4NRilIJ1dq6E9I2tmIq1mzK666LSNLzxKwgpEGrLHPlc=
X-Received: by 2002:a05:6a20:54a3:b0:13d:17cc:5bca with SMTP id
 i35-20020a056a2054a300b0013d17cc5bcamr26548829pzk.18.1699242791516; Sun, 05
 Nov 2023 19:53:11 -0800 (PST)
MIME-Version: 1.0
References: <20231102175735.2272696-1-irogers@google.com> <20231102175735.2272696-7-irogers@google.com>
In-Reply-To: <20231102175735.2272696-7-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sun, 5 Nov 2023 19:53:00 -0800
Message-ID: <CAM9d7chgQBGMmyDyi98OUzyJHWaNUfw34VD=pStkX_n-t5Vpkg@mail.gmail.com>
Subject: Re: [PATCH v4 06/53] tools api fs: Switch filename__read_str to use io.h
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nick Terrell <terrelln@fb.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Ming Wang <wangming01@loongson.cn>,
        James Clark <james.clark@arm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Leo Yan <leo.yan@linaro.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        German Gomez <german.gomez@arm.com>,
        Changbin Du <changbin.du@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>,
        Sandipan Das <sandipan.das@amd.com>,
        liuwenyu <liuwenyu7@huawei.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 2, 2023 at 10:58 AM Ian Rogers <irogers@google.com> wrote:
>
> filename__read_str has its own string reading code that allocates
> memory before reading into it. The memory allocated is sized at BUFSIZ
> that is 8kb. Most strings are short and so most of this 8kb is
> wasted.
>
> Refactor io__getline so that the newline character can be configurable
> and ignored in the case of filename__read_str.
>
> Code like build_caches_for_cpu in perf's header.c will read many
> strings and hold them in a data structure, in this case multiple
> strings per cache level per CPU. Using io.h's io__getline avoids the
> wasted memory as strings are temporarily read into a buffer on the
> stack before being copied to a buffer that grows 128 bytes at a time
> and is never sized larger than the string.
>
> For a 16 hyperthread system the memory consumption of "perf record
> true" is reduced by 180kb, primarily through saving memory when
> reading the cache information.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---

[SNIP]
> diff --git a/tools/lib/api/io.h b/tools/lib/api/io.h
> index a77b74c5fb65..50d33e14fb56 100644
> --- a/tools/lib/api/io.h
> +++ b/tools/lib/api/io.h
> @@ -141,7 +141,7 @@ static inline int io__get_dec(struct io *io, __u64 *dec)
>  }
>
>  /* Read up to and including the first newline following the pattern of getline. */

You may want to update the comment as well.

> -static inline ssize_t io__getline(struct io *io, char **line_out, size_t *line_len_out)
> +static inline ssize_t io__getline_nl(struct io *io, char **line_out, size_t *line_len_out, int nl)

How about io__getdelim() similar to POSIX?

Thanks,
Namhyung


>  {
>         char buf[128];
>         int buf_pos = 0;
> @@ -151,7 +151,7 @@ static inline ssize_t io__getline(struct io *io, char **line_out, size_t *line_l
>
>         /* TODO: reuse previously allocated memory. */
>         free(*line_out);
> -       while (ch != '\n') {
> +       while (ch != nl) {
>                 ch = io__get_char(io);
>
>                 if (ch < 0)
> @@ -184,4 +184,9 @@ static inline ssize_t io__getline(struct io *io, char **line_out, size_t *line_l
>         return -ENOMEM;
>  }
>
> +static inline ssize_t io__getline(struct io *io, char **line_out, size_t *line_len_out)
> +{
> +       return io__getline_nl(io, line_out, line_len_out, /*nl=*/'\n');
> +}
> +
>  #endif /* __API_IO__ */
> --
> 2.42.0.869.gea05f2083d-goog
>
