Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31BA4796D98
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 01:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244784AbjIFXY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 19:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232862AbjIFXYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 19:24:55 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12074199B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 16:24:52 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99bf3f59905so31595566b.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 16:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694042690; x=1694647490; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OIy/S2GIHPrddAMkFG5TTxbNi1DEK6tKwQNJxNkWe38=;
        b=IIVbi4VkdLw7viVCAd8th7IKzDvLLzuKctsMeThCP4gWIxAw2ggnOrZE+/qoQEfwjP
         FE2fqm4Ut6Fbg7/rtv8jmYPTbW36gef5qDqLmwLEExJb9kMk9YFOvcNGfn2z//zox6O/
         bKfnP+8lF2EGONPAvloUO7q8b231L1tGsgIzbJKXPoVrNWW6gPnjqMf04QdEZ+Y+h8r2
         QF7pKiA2l/nePc49PLRXNaU05DutIY0RgQ/CPnRkNRRck55gHX0Tk8aS9l3WvJZWPbwF
         GeosVGfJ17vqxICcJ/GyEbVtNsnXBLtpw6tkcLsuolhnRGlq5EdtrpjcZkFEJTutE9se
         JZ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694042690; x=1694647490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OIy/S2GIHPrddAMkFG5TTxbNi1DEK6tKwQNJxNkWe38=;
        b=FJaZMYyCCUgNF8n1ie0g0k6T7VHczK0sD9cDMopklt3Mg/16JRxOrq186yzqV44/na
         7hAOJE4Ud0NXeR3tEkma+7VWZJwB+H2Pz3LHGKGSyRzyfDBSFZwxDH/LuxaE4p2R3dUB
         +yGp33nim1kSVaNYOpkP0WVve99Yj0qx0YCed92QdJfZqdhqCYcLQ/trwQDXyn3V5LWt
         S2LO8swGQzBvEnkc/j6ZWL2CpV+sa6d5N3eZaL8EC/3mJj+cUl6VLypBT3Je29qR7vaP
         GfIHkeggbcsHJns4/Yw0Lv4VH3RUZeMjCqJYUWjnEn3IgtaP8y/ypazCZP5ME/qWqk5d
         N/TQ==
X-Gm-Message-State: AOJu0YwB6aa3XoMHFht75Fat7omAl6PGrFMxE20UM4Gt8ll/8wK7JBYM
        jyBdDqNv27RFezexdD1W0bdzk6K+EC39kedGDSepPA==
X-Google-Smtp-Source: AGHT+IEZKgVhzYxiWAo3bdKKl4UyUlyaeu6fY9gq+pQ95E/bGNm66qdOOfJECF9YXi7Fzq8L9vZkeXF7WUvEl5qI8PI=
X-Received: by 2002:a17:907:2bed:b0:9a1:b6e1:c2e with SMTP id
 gv45-20020a1709072bed00b009a1b6e10c2emr3536524ejc.33.1694042690451; Wed, 06
 Sep 2023 16:24:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230905-strncpy-arch-arm64-v4-1-bc4b14ddfaef@google.com> <20230906184849.GB5021@willie-the-truck>
In-Reply-To: <20230906184849.GB5021@willie-the-truck>
From:   Justin Stitt <justinstitt@google.com>
Date:   Wed, 6 Sep 2023 16:24:37 -0700
Message-ID: <CAFhGd8qEYGvajC8jNCcMf1zy7A5hY0Cn767CC=XDgtoJsmQDhA@mail.gmail.com>
Subject: Re: [PATCH v4] arm64/sysreg: refactor deprecated strncpy
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Mostafa Saleh <smostafa@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 6, 2023 at 11:48=E2=80=AFAM Will Deacon <will@kernel.org> wrote=
:
>
> On Tue, Sep 05, 2023 at 08:10:21PM +0000, Justin Stitt wrote:
> > strncpy is deprecated [1] and should not be used if the src string is
> > not NUL-terminated.
> >
> > When dealing with `cmdline` we are counting the number of characters
> > until a space then copying these over into `buf`. Let's not use any of
> > the str*() functions since the src string is not necessarily NUL-termin=
ated.
> >
> > Prefer `memcpy()` alongside a forced NUL-termination as it more
> > accurately describes what is going on within this function, i.e: copyin=
g
> > from non NUL-terminated buffer into a NUL-terminated buffer.
> >
> > Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#st=
rncpy-on-nul-terminated-strings [1]
> > Link: https://github.com/KSPP/linux/issues/90
> > Cc: linux-hardening@vger.kernel.org
> > Suggested-by: Kees Cook <keescook@chromium.org>
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > ---
> > Changes in v4:
> > - rebase onto mainline (thanks Will)
> > - Link to v3: https://lore.kernel.org/r/20230831-strncpy-arch-arm64-v3-=
1-cdbb1e7ea5e1@google.com
>
> The original patch converting the strncpy() to strscpy() has already land=
ed
> upstream, so this doesn't apply as-is.
>
> Rather than go through a v5, I've reverted your original patch and squash=
ed
> this on top with a new commit message. I'll push it out tomorrow on to th=
e
> arm64 fixes branch.
Thanks! Sorry I hadn't noticed it go through -- especially with all
the reviews surrounding the patches.

>
> Thanks,
>
> Will
