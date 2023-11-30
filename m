Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 364517FE652
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 02:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344046AbjK3Bmx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 29 Nov 2023 20:42:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbjK3Bmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 20:42:51 -0500
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF3395;
        Wed, 29 Nov 2023 17:42:58 -0800 (PST)
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2856254bd74so456968a91.2;
        Wed, 29 Nov 2023 17:42:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701308578; x=1701913378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ivoJxkCdzt3z1KRXcXZxqZP8Xkb6cmsg3m3L6Nbeo2w=;
        b=QTglPJA3ByKUKhnDH3eWl5l1kKBfj3Xv1XhDXQUyhK3Fua3BS5BryUg+7RAFPUCPpn
         /IZY3VbJHUR5qfIJqAdtMMqIsLj03h9Hav2Yu0uH50AJjLCBdDu5AXkHi3bviejepPai
         iQwWIWG7pQZKuQDyK0n0dVWb3ewo3y1enif/7x28tHReWUUqm3TuhzZpzuXjquCFkCyG
         FSnWb13WCyfdCF1MVpShcD5tG4SP1WfsyQiUyuk6KB455nuyBxXXExdmjTuUZEhHD4IM
         p+bTIefiz5mHjY7FJsXG3jW6UUpWd718luz54PLLcmT611am57ZCpdTZPHMxo52g8b/P
         qu/A==
X-Gm-Message-State: AOJu0Yxpv4+et9z31x7foeS1H8cS7fYyZNPXAdtv26/lqHVYooLByI+I
        FVTSCGQhJr3s7Oxl2R4O0H9hIC6x5ja3/Tqiqms=
X-Google-Smtp-Source: AGHT+IF1rO1VkZ51jkR3hbMtb53x10XLTbSAz/OODkgWbTstVWu31Cgg87bOxSAYY24ZZ6D54ByCuy5rp5ek8BgaOpQ=
X-Received: by 2002:a17:90b:17cf:b0:285:a18e:7565 with SMTP id
 me15-20020a17090b17cf00b00285a18e7565mr15721075pjb.5.1701308577748; Wed, 29
 Nov 2023 17:42:57 -0800 (PST)
MIME-Version: 1.0
References: <20231127220902.1315692-1-irogers@google.com> <20231127220902.1315692-6-irogers@google.com>
In-Reply-To: <20231127220902.1315692-6-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 29 Nov 2023 17:42:46 -0800
Message-ID: <CAM9d7cgFJ4i05-ow07VXoCGxEHTbmuetM5C_8bvMC43JGOmwpw@mail.gmail.com>
Subject: Re: [PATCH v5 05/50] tools api fs: Avoid reading whole file for a 1
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
        linux-perf-users@vger.kernel.org,
        Guilherme Amadio <amadio@gentoo.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 2:09 PM Ian Rogers <irogers@google.com> wrote:
>
> sysfs__read_bool used the first byte from a fully read file into a
> string. It then looked at the first byte's value. Avoid doing this and
> just read the first byte.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/lib/api/fs/fs.c | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
>
> diff --git a/tools/lib/api/fs/fs.c b/tools/lib/api/fs/fs.c
> index 004f2af5504b..337fde770e45 100644
> --- a/tools/lib/api/fs/fs.c
> +++ b/tools/lib/api/fs/fs.c
> @@ -447,15 +447,22 @@ int sysfs__read_str(const char *entry, char **buf, size_t *sizep)
>
>  int sysfs__read_bool(const char *entry, bool *value)
>  {
> -       char *buf;
> -       size_t size;
> -       int ret;
> +       struct io io;
> +       char bf[16];
> +       int ret = 0;
> +       char path[PATH_MAX];
> +       const char *sysfs = sysfs__mountpoint();
> +
> +       if (!sysfs)
> +               return -1;
>
> -       ret = sysfs__read_str(entry, &buf, &size);
> -       if (ret < 0)
> -               return ret;
> +       snprintf(path, sizeof(path), "%s/%s", sysfs, entry);
> +       io.fd = open(path, O_RDONLY);
> +       if (io.fd < 0)
> +               return -errno;
>
> -       switch (buf[0]) {
> +       io__init(&io, io.fd, bf, sizeof(bf));
> +       switch (io__get_char(&io)) {
>         case '1':
>         case 'y':
>         case 'Y':
> @@ -469,8 +476,7 @@ int sysfs__read_bool(const char *entry, bool *value)
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
> 2.43.0.rc1.413.gea7ed67945-goog
>
