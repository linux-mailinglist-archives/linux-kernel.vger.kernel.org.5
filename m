Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C06C78BB37
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 00:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234300AbjH1Wxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 18:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234297AbjH1Wxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 18:53:32 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE81711C
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 15:53:29 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id ada2fe7eead31-44ea1f87427so1324287137.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 15:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693263209; x=1693868009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/rPp/OBCbyvFuIsHpW2W/8NQ9YGESVReCdBvNabrZPc=;
        b=PmlCkaLnq/9d+ZnDSOIUY8W62gfd1Q4PDaWiXBTWNtBqBxYKE0gyPz8TTHoby2nbd2
         hw7d1NxYT8IfYsrUgaU4vmdj7yC/f37TtpJKdoKKajqtzT0PxJFhfWfiVvqLdcj36VyQ
         zzRd+gduere0MLd8tVzamhFXpcsOpDoWyG8ITbEttncN9w/gQYVubKGK6R/hk9enDdVc
         KuoAasgQXK6fWagBTZNNNPYuiwZM1ErU/dzEuhbMpEdWCSepeH1B2Sd8lVyra99gSHqa
         AmBGiUfY/IrrFEybNYJsSUxFjFyL5vyEQd09jeisfTE7jMdZ5P+gMQZwwcOt4qBalOEt
         3NbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693263209; x=1693868009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/rPp/OBCbyvFuIsHpW2W/8NQ9YGESVReCdBvNabrZPc=;
        b=QQ6j/ozNp3rJHVxgF8iPXu1LK0UD2eQNthDyoq/FIQbKV4Iylqapn5i7dvEqvaNcxw
         4GLS7psJIuFayfy/NfZGRKPhVjGwqack/OZO5wM/wf8sKTjN3adYbormKxGajAi5+2yV
         e8GdPlbMLI0tP0c/H5agf7MQR7+X+a4frpkmNoFM8ByagGKmn0zK+zEa2c/YTXPyoDmd
         mkIG9gEPNK+TYta0G6uzpa3YlI3cQNPoWk56/PWaDmdfAkMW9avP5+RvgTXIoxyvaXKD
         FPU551NAo+rJb2WQMzvuc46I8R1MOELAQxdusThJlv2r81cUhJJ+RlC+WKWOypuasjuy
         BRgQ==
X-Gm-Message-State: AOJu0Yxm2JKGRSMnR7fHjHJb5dEr0vh4VmsQBVw8kKIUEopMzZ3GIhWO
        cK/D9HHZEItCZyTkzjS+wwmmd0HbGQNTwXrmr/rV5A==
X-Google-Smtp-Source: AGHT+IGrZ5DKqPE2cjwP21nhG3fcsE8gMLdq/0yZ6jUtdfaFjIXOh1d5/lBcvYIomLGq7Sd4rp173jQCHPoyaeaI+uM=
X-Received: by 2002:a67:fb49:0:b0:44e:8e28:284f with SMTP id
 e9-20020a67fb49000000b0044e8e28284fmr11952083vsr.18.1693263208813; Mon, 28
 Aug 2023 15:53:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230828153142.2843753-1-hca@linux.ibm.com> <20230828153142.2843753-2-hca@linux.ibm.com>
 <ZO0j3M8KFWeEznXy@google.com>
In-Reply-To: <ZO0j3M8KFWeEznXy@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 28 Aug 2023 15:53:17 -0700
Message-ID: <CAKwvOd=MG6KdE9fTGBV317s9-RkjcUWednkC1akpODGE2iuvgQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] s390/dasd: fix string length handling
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Stefan Haberland <sth@linux.ibm.com>,
        =?UTF-8?B?SmFuIEjDtnBwbmVy?= <hoeppner@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, nathan@kernel.org,
        llvm@lists.linux.dev, David Laight <David.Laight@aculab.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 3:46=E2=80=AFPM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Mon, Aug 28, 2023 at 05:31:42PM +0200, Heiko Carstens wrote:
> > Building dasd_eckd.o with latest clang reveals this bug:
> >
> >     CC      drivers/s390/block/dasd_eckd.o
> >       drivers/s390/block/dasd_eckd.c:1082:3: warning: 'snprintf' will a=
lways be truncated;
> >       specified size is 1, but format string expands to at least 11 [-W=
fortify-source]
> >        1082 |                 snprintf(print_uid, sizeof(*print_uid),
> >             |                 ^
> >       drivers/s390/block/dasd_eckd.c:1087:3: warning: 'snprintf' will a=
lways be truncated;
> >       specified size is 1, but format string expands to at least 10 [-W=
fortify-source]
> >        1087 |                 snprintf(print_uid, sizeof(*print_uid),
> >             |                 ^
> >
> > Fix this by moving and using the existing UID_STRLEN for the arrays
> > that are being written to. Also rename UID_STRLEN to DASD_UID_STRLEN
> > to clarify its scope.
> >
> > Fixes: 23596961b437 ("s390/dasd: split up dasd_eckd_read_conf")
> > Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>
> > Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
>
> Thanks for the patch! Nathan just reported a bunch of these. I took a
> look at these two and thought "yeah that's clearly a bug in the kernel
> sources." Fix LGTM.
>
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Closes: https://github.com/ClangBuiltLinux/linux/issues/1923
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Meant to add:

Tested-by: Nick Desaulniers <ndesaulniers@google.com> # build

>
> I also like David's idea of passing `char ident [DASD_UID_STRLEN]`, too,
> but I don't feel strongly either way.



--=20
Thanks,
~Nick Desaulniers
