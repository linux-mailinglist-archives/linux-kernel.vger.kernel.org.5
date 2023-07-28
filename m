Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0387976649C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 08:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233414AbjG1G7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 02:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbjG1G7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 02:59:09 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C1D198A
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 23:59:08 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-403cb525738so11451971cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 23:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690527547; x=1691132347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uBrLltNK/fDQgPKGFScyH1SDUmmIH86PwWRaDh569qE=;
        b=SnpBnY2otihuHHHYSDjHJOPZT9jkR75uqSrm0wLVx0ID2esJ6KaK3gH47A6BardiPh
         y29FLCa+aFMSDSoaUNavqOQDEQ4F8MecDEJmBQCil06OOb+UF1EfrFvv8x0Jlr/USQLC
         R+iWvdAiHDPucg1tPytbsDytFtFnF9wHhFY+c9WqR0gMU+obe4ooJR6RCw+Q3uD5LX1y
         TOYz/rt4XK591cUqd3r+4mx/18Hksnq5G2uErJNFszqIavTiCv7lVdUunVVZhB2NMeju
         ZYyYMb9MVt8KJWYlpmETvumOoKKK7+YPGkJ6Xtv3Fm+xFgJJQz7Av3qBzrLo0lE0JCLP
         RuyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690527547; x=1691132347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uBrLltNK/fDQgPKGFScyH1SDUmmIH86PwWRaDh569qE=;
        b=QiHldNlzv+5UFAiOnCiolUmuhbBrB6uIf08N4tGy79mR+4HrqhvfqPYTrl4bY52bqo
         hw9q5Ls2d2GjsWhP22I2a/ZnqV1pHglha2Al+Co1IklJyhhI3n7yVVmx7BzpilB1zsRK
         Thdhi6I4uNTnUKQuejyB12Mc4SAgWchZ32gyV+O1PGqILFpFK8bJPV04eQgsjmoV2Vo5
         z5aqjB0hXSCJuA0vA/RJHdHDQm1FJbTr387tSpwAjkgYkZZMpEhTeoDt/qxRHp/tHtGx
         wnnP0pCMZd5vezI1xBx2yzV6w+s4wpt2kszFywZw5qihWAS95vD3sF4UpD2sCv5PqeyY
         W8Xw==
X-Gm-Message-State: ABy/qLb6zL1vDcQ0YKz+WmflQ//y2GzhjrI14c/W+tMPBsU0MxqaQW9G
        D7kKzxbaU0kC5Q6PtCA0hgaZaQMpyFRfruP48qFjQSet
X-Google-Smtp-Source: APBJJlHg75yjSFYybiZyNX0p1R660gZtMx4uxNZHQamf2phdSTVEpDTI3nzSY6Fpzgt1B0Epe+/OspI3XwT96qzAg0s=
X-Received: by 2002:a05:622a:11cc:b0:403:9be1:c969 with SMTP id
 n12-20020a05622a11cc00b004039be1c969mr2270692qtk.62.1690527547226; Thu, 27
 Jul 2023 23:59:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230727212157.2985025-1-ppbuk5246@gmail.com> <20230727215318.43455-1-sj@kernel.org>
In-Reply-To: <20230727215318.43455-1-sj@kernel.org>
From:   Yun Levi <ppbuk5246@gmail.com>
Date:   Fri, 28 Jul 2023 07:58:56 +0100
Message-ID: <CAM7-yPQEnppWQ4j7mc4WG3POKbjzOLynkFXsSw47GRhSUaTawg@mail.gmail.com>
Subject: Re: [PATCH v2] damon: Use pmdp_get instead of drectly dereferencing pmd.
To:     SeongJae Park <sj@kernel.org>
Cc:     akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 10:53=E2=80=AFPM SeongJae Park <sj@kernel.org> wrot=
e:
>
> Hi Levi,
>
>
> Thank you for quick respin.
>
> I still hope the subject to drop the ending period, and start the subject=
 with
> lowercase, like other mm/damon/ commits.
>

Sorry to bother you, I should find why the ending period inserted..

> > As ptep_get, Use the pmdp_get wrapper when we accessing pmdval
> > instead of directly dereferencing pmd.
>
> Based on the usual git commit message line length recommendation (72
> characters), there is nothing really wrong, but putting 'instead' at the =
first
> line may look more consistent with other messages.

> Since this is the good place to put additional comments not suitable for =
the
> changelog[2], it would be helpful if you could put changes of this patch =
that
> made after the v1 here, from next time.
>
> Above comments are only my trivial and personal preferences, so I wouldn'=
t ask
> you to respin, unless you really want to.
>
> [1] https://github.com/torvalds/linux/pull/17
> [2] https://docs.kernel.org/process/submitting-patches.html#the-canonical=
-patch-format

Thanks for letting me know some details why I missed :)

Many thanks.

--------
Sincerely,
Levi.
