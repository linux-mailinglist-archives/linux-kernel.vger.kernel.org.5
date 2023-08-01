Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A59AA76BDAC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 21:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbjHATZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 15:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232411AbjHATZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 15:25:15 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D963582
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 12:25:02 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-38c35975545so4731491b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 12:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690917902; x=1691522702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JVStSKOXHuVNjupka5b4LgzYs1g1E9EjO7OugsAUVZI=;
        b=nGSW7hG5U6v+anh6x7l3AKx2jw08rqRM3ja6Ha8kC7KMTzWTZ5rUtjnL++PlStVEq+
         fKC8pOprYrVNOzRsg4dU36ZFw1Rh0JxaU+UnOYtEoY/HFJ6hi8IzIPXvz8ZWgsAhiqgK
         WKckw3N4DBhTwJS8elwpYPNTSpflqW9PhVFwc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690917902; x=1691522702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JVStSKOXHuVNjupka5b4LgzYs1g1E9EjO7OugsAUVZI=;
        b=NB2AjgbWbfyx/AsMRfZJuU/7vJ08oEnBS3rHdxMfcEDhvQ/ZEAx+YDiLn2twN/zJws
         +ehhuB6A8GrCt/+JINGwH2tglvliuGSk9RYbxp5uN4OYQhn9b2FZv3VqdwOO8yasd5tQ
         f6MWMdtfOMDKgb6orhR6pTfOAQS9rCeyw1Q3zQ3o4yOoNM+h2s+WPuNQ5zBfqBodDRAh
         Ss1eK94U3n5A5CNU6s3tkoeNmDCTTywo98+PMhBmkaXWwSK+5887YDP6ZJcjzp20J8sz
         A246JK38FPmWf45iqL+MpuAe3oUldiW/x2fPYwhC/+McXmLxjP2tt+EjHs7X0uOuA2HR
         BQ1g==
X-Gm-Message-State: ABy/qLY2tXU76OLPf7zbsOcMMu4/ChEdWJksSCnMBy7CHZadywlXaTgi
        Ql7QG0Kv4KKde3ewZrhs43wQGFFelYlTcpDIW/dCtR6qa2lljveaUXs=
X-Google-Smtp-Source: APBJJlEm1J3KL2r3HOetAysmO5T/aleeOed9lahwvrPBY5QHmqz8ldc8jZwRYKGHDPE1BPooGl5UYxsFN0u2uyZ3+58=
X-Received: by 2002:a05:6808:219a:b0:3a2:a96d:19c3 with SMTP id
 be26-20020a056808219a00b003a2a96d19c3mr16886646oib.41.1690917902045; Tue, 01
 Aug 2023 12:25:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230714114753.170814-1-david@readahead.eu> <CALmYWFsjy2jOfKyM3Gd3Ag+p6u5ejDoBp6RhqcXkcAkMiby4SA@mail.gmail.com>
 <fb464cbf-04c4-4346-a96b-e0b2ab804e16@app.fastmail.com>
In-Reply-To: <fb464cbf-04c4-4346-a96b-e0b2ab804e16@app.fastmail.com>
From:   Jeff Xu <jeffxu@chromium.org>
Date:   Tue, 1 Aug 2023 12:24:51 -0700
Message-ID: <CABi2SkUOxngcDwRDtFFD2Uef=BUXVN08dMYhmpuS_b1xC39L7g@mail.gmail.com>
Subject: Re: [PATCH] memfd: support MFD_NOEXEC alongside MFD_EXEC
To:     David Rheinsberg <david@readahead.eu>
Cc:     Jeff Xu <jeffxu@google.com>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Daniel Verkamp <dverkamp@chromium.org>, linux-mm@kvack.org,
        Peter Xu <peterx@redhat.com>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Fri, Jul 28, 2023 at 12:55=E2=80=AFAM David Rheinsberg <david@readahead.=
eu> wrote:
>
> Hi
>
> On Tue, Jul 18, 2023, at 9:03 PM, Jeff Xu wrote:
> > Hi David
> >
> > Thanks email and patch for discussion.
> >
> > On Fri, Jul 14, 2023 at 4:48=E2=80=AFAM David Rheinsberg <david@readahe=
ad.eu> wrote:
> >>
> >> Add a new flag for memfd_create() called MFD_NOEXEC, which has the
> >> opposite effect as MFD_EXEC (i.e., it strips the executable bits from
> >> the inode file mode).
> >>
> > I previously thought about having the symmetric flags, such as
> > MFD_NOEXEC/MFD_EXEC/MFD_NOEXEC_SEAL/MFD_EXEC_SEAL, but decided against
> > it. The app shall decide beforehand what the memfd is created for, if
> > it is no-executable, then it should be sealed, such that it can't be
> > chmod to enable "X" bit.
>
> My point is, an application might decide to *not* seal a property, becaus=
e it knows it has to change it later on. But it might still want to disable=
 the executable bit initially, so to avoid having executable pages around t=
hat can be exploited.
>

I understand that.
My argument was this application can do this in two steps, as in my
previous email:
1> memfd_create(MFD_EXEC)
2> chmod

Two system calls back to back isn't too terrible,  and I know this
might seem to be not optimized for your user case, I will explain it
later, please read on.

> >> The default mode for memfd_create() has historically been to use 0777 =
as
> >> file modes. The new `MFD_EXEC` flag has now made this explicit, paving
> >> the way to reduce the default to 0666 and thus dropping the executable
> >> bits for security reasons. Additionally, the `MFD_NOEXEC_SEAL` flag ha=
s
> >> been added which allows this without changing the default right now.
> >>
> >> Unfortunately, `MFD_NOEXEC_SEAL` enforces `MFD_ALLOW_SEALING` and
> >> `F_SEAL_EXEC`, with no alternatives available. This leads to multiple
> >> issues:
> >>
> >>  * Applications that do not want to allow sealing either have to use
> >>    `MFD_EXEC` (which we don't want, unless they actually need the
> >>    executable bits), or they must add `F_SEAL_SEAL` immediately on
> >>    return of memfd_create(2) with `MFD_NOEXEC_SEAL`, since this
> >>    implicitly enables sealing.
> >>
> >>    Note that we explicitly added `MFD_ALLOW_SEALING` when creating
> >>    memfd_create(2), because enabling seals on existing users of shmem
> >>    without them knowing about it can easily introduce DoS scenarios.
> >
> > The application that doesn't want MFD_NOEXEC_SEAL can use MFD_EXEC,
> > the kernel won't add MFD_ALLOW_SEALING implicitly. MFD_EXEC makes the
> > kernel behave the same as before, this is also  why sysctl
> > vm.memfd_noexec=3D0 can work seamlessly.
> >
> >>   It
> >>    is unclear why `MFD_NOEXEC_SEAL` was designed to enable seals, and
> >>    this is especially dangerous with `MEMFD_NOEXEC_SCOPE_NOEXEC_SEAL`
> >>    set via sysctl, since it will silently enable sealing on every memf=
d
> >>    created.
> >>
> > Without sealing, chmod(2) can modify the mfd to be executable, that is
> > the consideration that MFD_NOEXEC is not provided as an option.
> > Indeed, current design is "biased" towards promoting MFD_NOEXEC_SEAL
> > as the safest approach, and try to avoid the pitfall that dev
> > accidently uses "MFD_NOEXEC" without realizing it can still be
> > chmod().
>
> I think I didn't get my point across. Imagine an application that does *N=
OT* use sealing, but uses memfds. This application shares memfds with untru=
sted clients, and does this in a safe way (SIGBUS protected). Everything wo=
rks fine, unless someone decides to enable `vm.memfd_noexec=3D2`. Suddenly,=
 the memfd will have sealing enabled *without* the application ever request=
ing this. Now any untrusted client that got the memfd can add seals to the =
memfd, even though the creator of the memfd did not enable sealing. This cl=
ient can now seal WRITES on the memfd, even though it really should not be =
able to do that.
>
> (This is not an hypothetical setup, we have such setups for data sharing =
already)

Thanks, this helps me understand your point better.

I'm not convinced that sysctl needs to consider the threat model of
"someone" changing and breaking an application.  If we follow that
threat model, there are a lot of other sysctls to worry about.

Also, in the system that you described, if memfd is handled to an
untrusted process, not only "sealing"  can cause damage, but also
chmod, arbitrary rw,  imo the right approach is to harden the process
or mechanism of passing the memfd.

>
> Thus, setting the security-option `memfd_noexec` *breaks* applications, b=
ecause it enables sealing. If `MFD_NOEXEC_SEAL` would *not* imply `MFD_ALLO=
W_SEALING`, this would not be an issue. IOW, why does =C2=B4MFD_NOEXEC_SEAL=
` clear `F_SEAL_SEAL` even if `MFD_ALLOW_SEALING` is not set?
>

If MFD_NOEXEC_SEAL is not desired, then it should not be used to
overwrite memfd_create() in this system.

For the question of why the sysctl adding a seal without application
setting it , the rationale here is, as summary of previous/this
emails:
1> The sysctl helps a system (or container in pid name) to migrate out
of old API, e.g, a container can update only the  applications that
need executable memfd, change the sysctl to MFD_NOEXEC_SEAL overwrite,
thus secure the usage of executable memfd to only those need to. This
is faster than updating all of the applications.
2> Since the sysctl does overwrite, it has potential to break an
application's intent, i.e.  an unmigrated application which expects
executable memfd, and kernel uses MFD_NOEXEC_SEAL overwrite. It is
important to use this with caution and abundant tests before turning
it on.
3> The seal is added because the majority of users should just care
about MFD_NOEXEC_SEAL, this prevents changing the memfd to executable
through chmod at runtime.

> >>  * Applications that do not want `MFD_EXEC`, but rely on
> >>    `F_GET_SEALS` to *NOT* return `F_SEAL_EXEC` have no way of achievin=
g
> >>    this other than using `MFD_EXEC` and clearing the executable bits
> >>    manually via fchmod(2). Using `MFD_NOEXEC_SEAL` will set
> >>    `F_SEAL_EXEC` and thus break existing code that hard-codes the
> >>    seal-set.
> >>
> >>    This is already an issue when sending log-memfds to systemd-journal=
d
> >>    today, which verifies the seal-set of the received FD and fails if
> >>    unknown seals are set. Hence, you have to use `MFD_EXEC` when
> >>    creating memfds for this purpose, even though you really do not nee=
d
> >>    the executable bits set.
> >>
> >>  * Applications that want to enable the executable bit later on,
> >>    currently have no way to create the memfd without it. They have to
> >>    clear the bits immediately after creating it via fchmod(2), or just
> >>    leave them set.
> >>
> > Is it OK to do what you want in two steps ? What is the concern there ?=
 i.e.
> > memfd_create(MFD_EXEC), then chmod to remove the "X" bit.
> >
> > I imagine this is probably already what the application does for
> > creating no-executable mfd before my patch, i.e.:
> > memfd_create(), then chmod() to remove "X" to remove "X" bit.
>
> Yes, correct, this is not a technical issue, but rather an API issue. I d=
on't think most memfd-users are aware that their inode has the executable b=
it set, and they likely don't want it. But for backwards-compatibility reas=
ons (as noted above), they cannot use `MFD_NOEXEC_SEAL`. Hence, we have to =
make them explicitly request an executable memfd via `MFD_EXEC` now, even t=
hough they clearly do not want this. And then we have to add code to drop t=
he executable immediately afterwards.
>
> It don't understand why we don't add out `MFD_NOEXEC` and thus make it a =
lot easier to patch existing applications? And we make it explicit that the=
se applications don't care for the executable-bit, rather than forcing them=
 to request the executable bit just to drop it immediately.
>
> The downside of `MFD_NOEXEC` is that it might be picked over `MFD_NOEXEC_=
SEAL` by uneducated users, thus reducing security. But right now, the alter=
native is that existing code picks `MFD_EXEC` instead and never clears the =
executable bit, because it is a hassle to do so.
>

Yes. This is the downside I was thinking about.

I lean to believe the kernel API shouldn't be feature rich, it could
be simple, optimized towards the majority of user cases, and ideally,
is self-explained without devs to look through documentation. For
example, if I had to choose one to implement between MFD_NOEXEC and
MFD_NOEXEC_SEAL, I would choose MFD_NOEXEC_SEAL because it should be
what most users care about.

> Or is there another reason *not* to include `MFD_NOEXEC`? I am not sure I=
 understand fully why you fight it so vehemently?
>

I wouldn't add it myself, I hope to convince you not to :-).
If you still think it is beneficial to add MFD_NOEXEC (saving one
chmod call and making it easy to use), I wouldn't feel bad about that.
I would suggest going with documentation to help devs to choose
between those two, i.e. recommend MFD_NOEXEC_SEAL in most cases.

Thanks
Best regards,
-Jeff

> Thanks
> David
>
