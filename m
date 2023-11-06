Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E1B7E1947
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 04:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjKFD4A convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 5 Nov 2023 22:56:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjKFDz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 22:55:58 -0500
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26156F9;
        Sun,  5 Nov 2023 19:55:56 -0800 (PST)
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5b92b670f2aso3218210a12.2;
        Sun, 05 Nov 2023 19:55:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699242955; x=1699847755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QfWESybjsduF9qwoLWKD5+nRstHYc4pbbbkyPkX7v3A=;
        b=OgztEGUK5KEaQMF2EViuF3gWUTTcpqFPwNBPUG40xh3/IZ7hNDFbaR1hqwg5gfCjVg
         iWlzY+tBxsdVY8A/dmxp3b31WAq6Ts76RYxQX7W6CU/mX8rWrEl4t3sObwTc7dmOdrtO
         BAwveymhv/USTGnnJseRBbbWI+wZaN4Cm8dmi4YnWufoDLMmwbqtuhfPeovpoo2/j+DI
         N5D3qHQSByktQH8TYj+GRT6+VV9m6SbmmrC230YzVs1wg3ISB0lPph5pm9bW8++RJV6A
         03ekkbybgHbFxXs1cUZwZ36N1kfhroRZqFwZxxDuWlZ/aqoJnb11YxRtJThev3HkmqX+
         BFDw==
X-Gm-Message-State: AOJu0YwQhMs3FuuoiXHdMfaP1O7h9CdikJ0zOBI7CMenV0bShnrP6e6G
        8Ur/ay0DelZJ3iSq/g1cigDlOclom9T9IVDkVXY=
X-Google-Smtp-Source: AGHT+IGbzywoiCWSH7SJOoGMLj3HgkTdhIfrlAkfTOdxwAJ0kx0qGL3BL1wIafykBBczR49bXKwLpmnOoHl//fXz4SQ=
X-Received: by 2002:a05:6300:8004:b0:181:61ad:3aeb with SMTP id
 an4-20020a056300800400b0018161ad3aebmr19226207pzc.43.1699242955563; Sun, 05
 Nov 2023 19:55:55 -0800 (PST)
MIME-Version: 1.0
References: <20231102175735.2272696-1-irogers@google.com> <20231102175735.2272696-8-irogers@google.com>
In-Reply-To: <20231102175735.2272696-8-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sun, 5 Nov 2023 19:55:44 -0800
Message-ID: <CAM9d7chKHASNE2BbL-6G7KJ-SwKMGXW+wujLsqiB+pFUPxJ2kA@mail.gmail.com>
Subject: Re: [PATCH v4 07/53] tools api fs: Avoid reading whole file for a 1
 byte bool
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
> sysfs__read_bool used the first byte from a fully read file into a
> string. It then looked at the first byte's value. Avoid doing this and
> just read the first byte.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/lib/api/fs/fs.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/tools/lib/api/fs/fs.c b/tools/lib/api/fs/fs.c
> index 496812b5f1d2..4c35a689d1fc 100644
> --- a/tools/lib/api/fs/fs.c
> +++ b/tools/lib/api/fs/fs.c
> @@ -447,15 +447,16 @@ int sysfs__read_str(const char *entry, char **buf, size_t *sizep)
>
>  int sysfs__read_bool(const char *entry, bool *value)
>  {
> -       char *buf;
> -       size_t size;
> -       int ret;
> +       struct io io;
> +       char bf[16];
> +       int ret = 0;
>
> -       ret = sysfs__read_str(entry, &buf, &size);
> -       if (ret < 0)
> -               return ret;
> +       io.fd = open(entry, O_RDONLY);

The entry is a name in sysfs, so you need to get the full name.

Thanks,
Namhyung


> +       if (io.fd < 0)
> +               return -errno;
>
> -       switch (buf[0]) {
> +       io__init(&io, io.fd, bf, sizeof(bf));
> +       switch (io__get_char(&io)) {
>         case '1':
>         case 'y':
>         case 'Y':
> @@ -469,8 +470,7 @@ int sysfs__read_bool(const char *entry, bool *value)
>         default:
>                 ret = -1;
>         }
> -
> -       free(buf);
> +       close(io.fd);
>
>         return ret;
>  }
> --
> 2.42.0.869.gea05f2083d-goog
>
