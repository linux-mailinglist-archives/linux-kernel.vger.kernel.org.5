Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40A0763DA0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 19:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbjGZR1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 13:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjGZR1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 13:27:02 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FD71BC1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 10:27:00 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-40540a8a3bbso17141cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 10:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690392419; x=1690997219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eh/u/3oGRS27e8zFhRvxdI/qhhrHZL9r58i24C4GPzM=;
        b=Z5nnOHOsigSkUjHY9VXlm8uRkVIK+o/C2ciOWGFX5ZreNGtzqo/DStSNwyhEIhOtlQ
         1HZzHZ5Z/bI51P/9sr29qxtvtj/V7i2ofdTHxABNFkC9eDM95l42z0FNMm0TGm319XUX
         8bUiZ5pTUJOSjIx+EL3W7+eREjzSB+v3AHoeoeHSU8w7nIsb0HUjj5eVzjlzr07yvf4A
         3xFcVLyORSM2Y7MmUPJ7UscJYE2y4a9wj3WBOgW8PAgwhhKBZTvGayeQaIqTVoCeQwAx
         UmxxXi4SVtt1jxPdhne6PV59lg+8y8GnTdCo+UhI8ClHj1C9555IwX7cRS7NSPp9n0NB
         3W1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690392419; x=1690997219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eh/u/3oGRS27e8zFhRvxdI/qhhrHZL9r58i24C4GPzM=;
        b=FP9oggE0sqyztOm3k5utzVGOj10IPBE7L3B1gCb57jxSkEQj6NVGUR7sMYQX75sZqA
         gZheKOnbh2eyt5N8J4LYVsCZP0v3LHjK1Pnc/EvefGGftdyVkljpSPEAQR4LbVE8IASL
         EY6OX+mjG4acPdf9f27BE69GCGi+UJDH1dq1w2ldPjs6/W6Jc8NFP0MooMlyXEbvyjyw
         X3Z0UhKDPfb5TWIor9JBVvbHDBTF89cbxTdIq000Z30IUyQQQfGmr7f7ETpKSHRkPl7P
         5ChNUazREikbjQB3RJESfQOa0v1CVhyxz/wxrDsYrFfAC3KNVI065ZTinlAx4C5Of3LZ
         6UxQ==
X-Gm-Message-State: ABy/qLbU0EouLWyGZJoXO4SndFLlc2K48Z5e7CbanHGwUTQtQPK4rId6
        yU//02jiqnj9votF9USup+Z/Zyc499ewHrgIP4R/VL+HMOm49in25h0=
X-Google-Smtp-Source: APBJJlHGWp+bm4jUOLGlkNEl7j1aAqridXdXn43BV8tVe7NcvahvARkO60jNNy8/qF/NabVfFMjAZLZ74r9V7SwkK/E=
X-Received: by 2002:a05:622a:18a1:b0:403:eeb9:a76 with SMTP id
 v33-20020a05622a18a100b00403eeb90a76mr529479qtc.17.1690392419547; Wed, 26 Jul
 2023 10:26:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230725092149.443119-1-xiexiuqi@huawei.com>
In-Reply-To: <20230725092149.443119-1-xiexiuqi@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 26 Jul 2023 10:26:48 -0700
Message-ID: <CAP-5=fV5NZTFM_9+KnKhZKWmnqc223koOioE9O6hzAvPMrxy7g@mail.gmail.com>
Subject: Re: [PATCH] tools/mm: fix undefined reference to pthread_once
To:     Xie XiuQi <xiexiuqi@huawei.com>
Cc:     akpm@linux-foundation.org, acme@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, weiyongjun1@huawei.com
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

On Tue, Jul 25, 2023 at 2:24=E2=80=AFAM Xie XiuQi <xiexiuqi@huawei.com> wro=
te:
>
> Commit 97d5f2e9ee12 ("tools api fs: More thread safety for global
> filesystem variables") introduces pthread_once, so the libpthread
> should be added at link time, or we'll meet the following compile
> error when 'make -C tools/mm':
>
>   gcc -Wall -Wextra -I../lib/ -o page-types page-types.c ../lib/api/libap=
i.a
>   ~/linux/tools/lib/api/fs/fs.c:146: undefined reference to `pthread_once=
'
>   ~/linux/tools/lib/api/fs/fs.c:147: undefined reference to `pthread_once=
'
>   ~/linux/tools/lib/api/fs/fs.c:148: undefined reference to `pthread_once=
'
>   ~/linux/tools/lib/api/fs/fs.c:149: undefined reference to `pthread_once=
'
>   ~/linux/tools/lib/api/fs/fs.c:150: undefined reference to `pthread_once=
'
>   /usr/bin/ld: ../lib/api/libapi.a(libapi-in.o):~/linux/tools/lib/api/fs/=
fs.c:151:
>   more undefined references to `pthread_once' follow
>   collect2: error: ld returned 1 exit status
>   make: *** [Makefile:22: page-types] Error 1
>
> Fixes: 97d5f2e9ee12 ("tools api fs: More thread safety for global filesys=
tem variables")
> Signed-off-by: Xie XiuQi <xiexiuqi@huawei.com>

Apologies.
Acked-by: Ian Rogers <irogers@google.com>

Alternatively we could #ifdef the behavior, but this way is cleaner imo.

Thanks,
Ian

> ---
>  tools/mm/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/mm/Makefile b/tools/mm/Makefile
> index 6c1da51f4177..9997b2e401ae 100644
> --- a/tools/mm/Makefile
> +++ b/tools/mm/Makefile
> @@ -9,7 +9,7 @@ LIB_DIR =3D ../lib/api
>  LIBS =3D $(LIB_DIR)/libapi.a
>
>  CFLAGS +=3D -Wall -Wextra -I../lib/
> -LDFLAGS +=3D $(LIBS)
> +LDFLAGS +=3D $(LIBS) -lpthread
>
>  all: $(TARGETS)
>
> --
> 2.25.1
>
