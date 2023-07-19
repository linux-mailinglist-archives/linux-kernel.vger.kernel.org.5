Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E9675A2E0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 01:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjGSXjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 19:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjGSXjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 19:39:13 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BFF610A
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 16:39:12 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-4036bd4fff1so129541cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 16:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689809951; x=1690414751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HmrEfOt69YUXnEdwJv4OzNXNHr6DjdUI8qa/nWwMStA=;
        b=0WKLPir2pa9/CRXGovk0E4uvoZZE9YWDMnWHWVTl4C/JUTXTiLxiL5w8EC6AjUb5M8
         sKmhU5dQlMz/mXX9sXo4+sgGdW1LAUVTetns3CHFEdIhmt4sTzWfYSt0Gp14qZBVjm1G
         P1/d5VzxifD7nw/azv2wTdoDjah8GA/4Mh0cEtO0NhGcegpI7Q674tm7S+8Z4WN+9cO8
         r5kf089kSAfX7HN3FZEmF/GQmbpswdQxGm50dJb4qdN/kKDjLh/dtyCbcF1jB9aOU6Ui
         joEZ797Scb48278WXsqbpIqHqA9xpNdCX+t3yDLxhkXXtkW4tvf00wj5g/mj08QXX4KE
         9MyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689809951; x=1690414751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HmrEfOt69YUXnEdwJv4OzNXNHr6DjdUI8qa/nWwMStA=;
        b=lnIyPmz3iUi7JLNPi7DaT+FJc4OdQdP4yay0o++vFR3qmTEcd+H1KurZeZLA6RWLkA
         JG0poUNNKfYBXyWhm3KX6aAEMig+db6uNGgknkg/hsocvc2l1YAS7aVpaHKRVZnf4OLd
         tqzKjE01da/xaU8cz9fUMLQ3TBMYk21wXVG0biVbwfTTS/v1aLa7SSC0T8xvZcXc+ij4
         AhiVxvBJ3oIAS9pAY9Fc8BNw8uXgOFFSWwL9ab2jYfc3BixH8x4zyQQ/Tw1rwimYqrbN
         iD/OyKFy9GV7Zj1/gvyLmJcze93ggoLeqxxG386WHcERn75D3AqIQwmWYNGHCVa4brbt
         omQQ==
X-Gm-Message-State: ABy/qLZV3cExe//ClzJmhML9X1lvEx4kfO3sbRZwSP8NgaWxERgB1NL5
        0JQ1coAOaoA6UYovaeK69+T31mPOu4e2yrrbZBorTA==
X-Google-Smtp-Source: APBJJlENRHebbDBgH0cBdZkRZDSVow7n9gxI/Za8tVG/FbVfhGnh/QwaqwDQdWnjN/0mBfMUalijnoI3davazs14tWY=
X-Received: by 2002:ac8:5acc:0:b0:3de:1aaa:42f5 with SMTP id
 d12-20020ac85acc000000b003de1aaa42f5mr61671qtd.15.1689809951571; Wed, 19 Jul
 2023 16:39:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230713143406.14342-1-cyphar@cyphar.com> <20230713143406.14342-4-cyphar@cyphar.com>
In-Reply-To: <20230713143406.14342-4-cyphar@cyphar.com>
From:   Jeff Xu <jeffxu@google.com>
Date:   Wed, 19 Jul 2023 16:38:35 -0700
Message-ID: <CALmYWFsusw5H6aa9Po6QyEKr7beUSTN+PmGzc0Er0tuGEmYCbA@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] selftests: memfd: error out test process when
 child test fails
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Verkamp <dverkamp@chromium.org>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Thu, Jul 13, 2023 at 7:34=E2=80=AFAM Aleksa Sarai <cyphar@cyphar.com> wr=
ote:
>
> Before this change, a test runner using this self test would see a
> return code of 0 when the tests using a child process (namely the
> MFD_NOEXEC_SEAL and MFD_EXEC tests) failed, masking test failures.
>
> Fixes: 11f75a01448f ("selftests/memfd: add tests for MFD_NOEXEC_SEAL MFD_=
EXEC")
> Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> ---
>  tools/testing/selftests/memfd/memfd_test.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/s=
elftests/memfd/memfd_test.c
> index d8342989c547..8b7390ad81d1 100644
> --- a/tools/testing/selftests/memfd/memfd_test.c
> +++ b/tools/testing/selftests/memfd/memfd_test.c
> @@ -1219,7 +1219,24 @@ static pid_t spawn_newpid_thread(unsigned int flag=
s, int (*fn)(void *))
>
>  static void join_newpid_thread(pid_t pid)
>  {
> -       waitpid(pid, NULL, 0);
> +       int wstatus;
> +
> +       if (waitpid(pid, &wstatus, 0) < 0) {
> +               printf("newpid thread: waitpid() failed: %m\n");
> +               abort();
> +       }
> +
> +       if (WIFEXITED(wstatus) && WEXITSTATUS(wstatus) !=3D 0) {
> +               printf("newpid thread: exited with non-zero error code %d=
\n",
> +                      WEXITSTATUS(wstatus));
> +               abort();
> +       }
> +
> +       if (WIFSIGNALED(wstatus)) {
> +               printf("newpid thread: killed by signal %d\n",
> +                      WTERMSIG(wstatus));
> +               abort();
> +       }
>  }
>
Signed-off-by: Jeff Xu <jeffxu@google.com>

-Jeff Xu

>  /*
> --
> 2.41.0
>
