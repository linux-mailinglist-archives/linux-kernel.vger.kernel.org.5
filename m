Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C8D7FFD4B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 22:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbjK3VL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 16:11:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjK3VL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 16:11:26 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C34133
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 13:11:32 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40b51e26a7aso3825e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 13:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701378690; x=1701983490; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PSwK/iIUBtKeopk8fKtKKE8DudDA2CgZ8PHsMY6XyUg=;
        b=OuulLBd22c1LkpUfq468A9Oh2ANqHNxPmuIL6I88Wt89kDqxNYpp7Xbw2jnbyD3aPo
         TJtZXBeBmDQVVAmQzr6eWc2IziV6wUx/QhnbBMqQljgG3/qFmwBvP3Rkgpuz9eu6dOUE
         EF5NNDsxUJvDXN3zxu4BOMfwRjgc3+EuQVBuvo+xgbff+wP3RqjD1aosUkj6JJnSHqCu
         q76Ol5XhRODBHc5FulJlmYFWwEPzPGwZuNOU/Ml92/OBluc4/8KAKreWpIEgxUlxQxQt
         GwLqoha5nrYYMv92ErBMETyH5TtFa15he93nJq0SORwLBxHv3FFFtBCwysSfyRgclDYg
         yttQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701378690; x=1701983490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PSwK/iIUBtKeopk8fKtKKE8DudDA2CgZ8PHsMY6XyUg=;
        b=tyybmnQT7EjAc1WlzYlTpcwVCZuXNsZ5N7eunL0y+atMuSoH56HswrMAlcaWBD6Ch1
         txMcvkSjACOU3hp2yv6dhy/JwwZMx7mWXZXxfVxCyrvsKTBb3hO6aAJ2ta1irmdY0CA4
         vkqpv3XWfgB275AVtz02J4prtVvFwtkoZxY3zd3yIC/MuVU266PeARSjBpHIyNJlu4OP
         rfPurxGfDpXbIRpaD/jgLqqdRP9ejdLWfzdsK4/WX6pJ8kNJEe17AaLT9AFUpV7cfmqv
         YL+NlGNkXq45hqchVM4MPM+iUICIvTUaCxSScH2opwK5HxqdnqmI2utF+gGSg1SmzvVr
         eYZA==
X-Gm-Message-State: AOJu0Yyx+ocWIRnDDS/3hwzy2QHrhEXGcajM6HSf/4Wro0jj6UBaOFDt
        05PF+pLYqZNX0Vijgh+4zTI9uOl6PDOuQIFCGc3qRw==
X-Google-Smtp-Source: AGHT+IGulsP2QCuzIHa+rG0Hpgh5PJD0/rMEcGTfUIPfmrKcQQrbq4TQJ3THCqhvNaWeVQPyPA86IIS+53+MZHXnpas=
X-Received: by 2002:a05:600c:1d81:b0:40b:3d89:ba70 with SMTP id
 p1-20020a05600c1d8100b0040b3d89ba70mr15422wms.7.1701378690559; Thu, 30 Nov
 2023 13:11:30 -0800 (PST)
MIME-Version: 1.0
References: <20231030104732.241339-1-rf@opensource.cirrus.com>
In-Reply-To: <20231030104732.241339-1-rf@opensource.cirrus.com>
From:   Rae Moar <rmoar@google.com>
Date:   Thu, 30 Nov 2023 16:11:18 -0500
Message-ID: <CA+GJov5vcRPo30CFYDwRq-iXHqtDtLd2jrmB+y_=BY6o2mZaBA@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND] kunit: debugfs: Handle errors from alloc_string_stream()
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     brendan.higgins@linux.dev, davidgow@google.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 6:47=E2=80=AFAM Richard Fitzgerald
<rf@opensource.cirrus.com> wrote:
>
> In kunit_debugfs_create_suite() give up and skip creating the debugfs
> file if any of the alloc_string_stream() calls return an error or NULL.
> Only put a value in the log pointer of kunit_suite and kunit_test if it
> is a valid pointer to a log.
>
> This prevents the potential invalid dereference reported by smatch:
>
>  lib/kunit/debugfs.c:115 kunit_debugfs_create_suite() error: 'suite->log'
>         dereferencing possible ERR_PTR()
>  lib/kunit/debugfs.c:119 kunit_debugfs_create_suite() error: 'test_case->=
log'
>         dereferencing possible ERR_PTR()

Hello!

Thanks for sending the re-sends of these patches! This patch also
looks good to me! I have one comment below but I would still be happy
with the patch as is.

Reviewed-by: Rae Moar <rmoar@google.com>

Thanks!
-Rae

>
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Fixes: 05e2006ce493 ("kunit: Use string_stream for test log")
> ---
>  lib/kunit/debugfs.c | 30 +++++++++++++++++++++++++-----
>  1 file changed, 25 insertions(+), 5 deletions(-)
>
> diff --git a/lib/kunit/debugfs.c b/lib/kunit/debugfs.c
> index 270d185737e6..9d167adfa746 100644
> --- a/lib/kunit/debugfs.c
> +++ b/lib/kunit/debugfs.c
> @@ -109,14 +109,28 @@ static const struct file_operations debugfs_results=
_fops =3D {
>  void kunit_debugfs_create_suite(struct kunit_suite *suite)
>  {
>         struct kunit_case *test_case;
> +       struct string_stream *stream;
>
> -       /* Allocate logs before creating debugfs representation. */
> -       suite->log =3D alloc_string_stream(GFP_KERNEL);
> -       string_stream_set_append_newlines(suite->log, true);
> +       /*
> +        * Allocate logs before creating debugfs representation.
> +        * The suite->log and test_case->log pointer are expected to be N=
ULL
> +        * if there isn't a log, so only set it if the log stream was cre=
ated
> +        * successfully.
> +        */

I like this new comment. Thanks!

> +       stream =3D alloc_string_stream(GFP_KERNEL);
> +       if (IS_ERR_OR_NULL(stream))

In response to Dan Carpenter's comment from the last version, I see
the benefits of changing IS_ERR_OR_NULL() to IS_ERR() instead because
"stream" will not be NULL. This would then also be the same as the
check in kunit_alloc_string_stream.

However, I also see the benefit of checking for NULL just in case anyways.

I'm overall happy with either solution but just wanted to bring this up.

> +               return;
> +
> +       string_stream_set_append_newlines(stream, true);
> +       suite->log =3D stream;
>
>         kunit_suite_for_each_test_case(suite, test_case) {
> -               test_case->log =3D alloc_string_stream(GFP_KERNEL);
> -               string_stream_set_append_newlines(test_case->log, true);
> +               stream =3D alloc_string_stream(GFP_KERNEL);
> +               if (IS_ERR_OR_NULL(stream))
> +                       goto err;
> +
> +               string_stream_set_append_newlines(stream, true);
> +               test_case->log =3D stream;
>         }
>
>         suite->debugfs =3D debugfs_create_dir(suite->name, debugfs_rootdi=
r);
> @@ -124,6 +138,12 @@ void kunit_debugfs_create_suite(struct kunit_suite *=
suite)
>         debugfs_create_file(KUNIT_DEBUGFS_RESULTS, S_IFREG | 0444,
>                             suite->debugfs,
>                             suite, &debugfs_results_fops);
> +       return;
> +
> +err:
> +       string_stream_destroy(suite->log);
> +       kunit_suite_for_each_test_case(suite, test_case)
> +               string_stream_destroy(test_case->log);
>  }
>
>  void kunit_debugfs_destroy_suite(struct kunit_suite *suite)
> --
> 2.30.2
>
