Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6B57600FF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 23:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjGXVRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 17:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjGXVRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 17:17:04 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093FD1FCA
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 14:16:28 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-40550136e54so91931cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 14:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690233377; x=1690838177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pJZwhOa5W46yVUw/MRzjeoW5wsfgpkSFvsTCkcv2gno=;
        b=eQpDwwdq6CzMw+lZdzVXKIPPe/ghUVYbILNdFsaamI7yeuXz6tpTQ0sSbN1Qw6Q5d/
         9z5R0FqrASmLwxokrOjwwjF4Tp3pqhn87L0Sl9qq9pVc5BZTzoplRL0mXOOyRFULRSni
         UjWrbOeftG+g5PhMbEmWU0LTV2IKB1vl+RQ7N9U2e8vQUBsulmkDMuS6xuYWUYGq/v/4
         kqq6Jy5dlyuutmLGzwq9PsIJnLokKOrZrnt6hHPIPrl13Vrg1eeR3hoCDvZ4Sedj4Xpp
         CYiZvVf8/WqxoK8DlnPTTMf621k5U38yBLsaraGmF0R/WOAGfh0jX8qXFTqdqKL4nfLV
         cQ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690233377; x=1690838177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pJZwhOa5W46yVUw/MRzjeoW5wsfgpkSFvsTCkcv2gno=;
        b=bY6RMoDdvYN+Nr7T/vDSVZfn9sHjXhqsYw05x+h141VGHSPYjQALGT2YFUycXgsmcC
         1WtHv4uFdneZK5UBVnQxNYzoQiH0MoQX0ld3t++3LxvUn796qgTMrEPdCV5IjrAvRsDT
         9CgdwxWJGodqx8T2To7TDoc1ia6i4j/odaUJedkP44Nf4WS1OS1n9VN/SZoSbTZQMEdp
         zdiu7BNB+yyPsMzP1GBNncRgt2KxtJxsBVJoLeOmvdbyKdpcaurlxdQ9kJ0rh/+RdXT6
         EjxXNqZm34Tius7/2e43SYIlpxsXMmyaNNyZMbc/LH8j3bT0/yWEtfEL63D/2HMxgtTg
         Lc7A==
X-Gm-Message-State: ABy/qLac62TURnA1b4d14LrGxzgY8mdBFx8mfLyZFSDjVBSg8KAlph0A
        EWLyGne2i7/9lIs7OlANxvXlseS+g6vXip1O+6+cgu50ZWyfiGpO7bimjA==
X-Google-Smtp-Source: APBJJlF+U6AFKlXW7wJNCRUIGyOsekXz/YiiF9d76grybDvvPdZ9TPWSOCAvjlL+roY1JE6XngsXXptt+lBrWvvJTEA=
X-Received: by 2002:a05:622a:181b:b0:403:caaa:1f9b with SMTP id
 t27-20020a05622a181b00b00403caaa1f9bmr504085qtc.2.1690233376745; Mon, 24 Jul
 2023 14:16:16 -0700 (PDT)
MIME-Version: 1.0
References: <ZL7ocEWxjRtWR80T@kernel.org>
In-Reply-To: <ZL7ocEWxjRtWR80T@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 24 Jul 2023 14:16:05 -0700
Message-ID: <CAP-5=fVy8cYrYH5EmdrJo0+q0CHj=chTxWYkieLi6LwTSjFCAQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf dlfilter: Initialize addr_location before
 passing it to thread__find_symbol_fb()
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Disha Goel <disgoel@linux.vnet.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>, Kajol Jain <kjain@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 2:09=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> As thread__find_symbol_fb() will end up calling thread__find_map() and
> it in turn will call these on uninitialized memory:
>
>         maps__zput(al->maps);
>         map__zput(al->map);
>         thread__zput(al->thread);

Normally there would be a addr_location__exit. It looks here like most
values are copied in al_to_d_al, which copies reference counted values
without doing appropriate gets. Perhaps add the gets in al_to_d_al and
add the exit to make it clear there can't be addr_location related
leaks here.

Thanks,
Ian

> Fixes: 0dd5041c9a0eaf8c ("perf addr_location: Add init/exit/copy function=
s")
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> Cc: Disha Goel <disgoel@linux.vnet.ibm.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kajol Jain <kjain@linux.ibm.com>
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Link: https://lore.kernel.org/lkml/
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/util/dlfilter.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/perf/util/dlfilter.c b/tools/perf/util/dlfilter.c
> index 46f74b2344dbb34c..798a53d7e6c9dfc5 100644
> --- a/tools/perf/util/dlfilter.c
> +++ b/tools/perf/util/dlfilter.c
> @@ -166,6 +166,7 @@ static __s32 dlfilter__resolve_address(void *ctx, __u=
64 address, struct perf_dlf
>         if (!thread)
>                 return -1;
>
> +       addr_location__init(&al);
>         thread__find_symbol_fb(thread, d->sample->cpumode, address, &al);
>
>         al_to_d_al(&al, &d_al);
> --
> 2.37.1
>
