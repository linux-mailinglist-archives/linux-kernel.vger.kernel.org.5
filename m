Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABCA76DBFF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 02:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjHCAHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 20:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233417AbjHCAGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 20:06:55 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DBE30CF
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 17:06:30 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1bb5c259b44so253315fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 17:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691021189; x=1691625989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C5bV8lUVCZT9FHeRYVjRrJMMVO8kdf2AYYmYfyHoLRc=;
        b=Q43jhR9FPq4V4QC4bkK60Vp0Apj3fPeT3tJVRErdVrxxqmGP7j8AlgpeIN4vns2sU0
         tqdIeChLPqzv02ps+kk8oeDO/zymqpAk8uWAdU66q36Oa8hGAF/n+zUkjCAgs8Ohl25w
         LP5y+j88CgWQDq42U0pMLOE8HrtCd30+O9//8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691021189; x=1691625989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C5bV8lUVCZT9FHeRYVjRrJMMVO8kdf2AYYmYfyHoLRc=;
        b=fhDDLZMRDovtD3n/xS2wAm1woYPcaPm9j3F3zcE0JD7dhLYpg0fV35jCxhXW946QmN
         FSR/0HEQ6aVYhCteX3NwTSP0i2hO4+QT9W9XMgjQutY3F7k8XOy1uAkBjLoLLdgsKIAe
         47DQkmD6EB4ryhT2mnXtpJ6hnFbJ0q9JmNCwgAbVJTEaPVdoBoufvwYBzX2uFH+reENf
         MBPw+NGPgK9ByOKB1Yf4HA/Zu1oTZhn9bBhaI8cXtpXqoT7SadLKAk2cvmr1izsaBvDO
         fMzmLvQKyon9sUP89QKXuMk+i7dYso8m4zqZhzjlHphKwQacNhAGWuj+WyBrcUB8Sn6a
         gO9w==
X-Gm-Message-State: ABy/qLZkAC5z/+C7zcU+3dk3Tv4MnEH726WuOtnp5fthUyPdVQRsfaY7
        XafMHFebv52zrTDiHR42HDdqNpaeA+wFEo58xkvH0380PSqDImRAZTw=
X-Google-Smtp-Source: APBJJlHULcxpHCqbXXv011nCfdvIzK7LvTT08X/UtG0LktiOwZGcV63sf1mW3qYe23ClG3POXFIKjL7Zxpyd3M8n7zw=
X-Received: by 2002:a05:6871:1c6:b0:1ba:53ed:18c9 with SMTP id
 q6-20020a05687101c600b001ba53ed18c9mr18741812oad.37.1691021189390; Wed, 02
 Aug 2023 17:06:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230714114753.170814-1-david@readahead.eu> <CALmYWFsjy2jOfKyM3Gd3Ag+p6u5ejDoBp6RhqcXkcAkMiby4SA@mail.gmail.com>
 <fb464cbf-04c4-4346-a96b-e0b2ab804e16@app.fastmail.com> <CABi2SkUOxngcDwRDtFFD2Uef=BUXVN08dMYhmpuS_b1xC39L7g@mail.gmail.com>
 <dadfd8d3-fe83-4aee-b8aa-3b31d4408f66@app.fastmail.com>
In-Reply-To: <dadfd8d3-fe83-4aee-b8aa-3b31d4408f66@app.fastmail.com>
From:   Jeff Xu <jeffxu@chromium.org>
Date:   Wed, 2 Aug 2023 17:06:17 -0700
Message-ID: <CABi2SkU1Cf4a99YCyyAie=NQXC7aXvroSTRrzruiXVxupTZrpA@mail.gmail.com>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 2, 2023 at 12:58=E2=80=AFAM David Rheinsberg <david@readahead.e=
u> wrote:
> >> I think I didn't get my point across. Imagine an application that does=
 *NOT* use sealing, but uses memfds. This application shares memfds with un=
trusted clients, and does this in a safe way (SIGBUS protected). Everything=
 works fine, unless someone decides to enable `vm.memfd_noexec=3D2`. Sudden=
ly, the memfd will have sealing enabled *without* the application ever requ=
esting this. Now any untrusted client that got the memfd can add seals to t=
he memfd, even though the creator of the memfd did not enable sealing. This=
 client can now seal WRITES on the memfd, even though it really should not =
be able to do that.
> >>
> >> (This is not an hypothetical setup, we have such setups for data shari=
ng already)
> >
> > Thanks, this helps me understand your point better.
> >
> > I'm not convinced that sysctl needs to consider the threat model of
> > "someone" changing and breaking an application.  If we follow that
> > threat model, there are a lot of other sysctls to worry about.
> >
> > Also, in the system that you described, if memfd is handled to an
> > untrusted process, not only "sealing"  can cause damage, but also
> > chmod, arbitrary rw,  imo the right approach is to harden the process
> > or mechanism of passing the memfd.
>
> No. The model I describe is carefully designed to hand out file-descripto=
rs to inodes that the clients have *no* access to. They cannot run fchmod(2=
), unlink(2), etc. All they can do is operate on the open file. And all acc=
ess to this shared file is properly guarded against possible damage the oth=
er concurrent clients can do. The entire model is already hardened against =
malicious actors.
>
> With the new sysctl, a new attack-vector is introduced, which was not pos=
sible before.
>
> I was *explicitly* told to add `MFD_ALLOW_SEALING` for that exact reason =
when introducing memfd_create(2). So I am a bit baffled why it is now ok to=
 enable sealing behind the users back.
>
> I agree that the new sysctl is a root-only option. But I fail to see *why=
* it implies `MFD_ALLOW_SEALING`? This behavior is not documented nor is it=
 explained in the original commit-messages, nor mentioned *anywhere*.
>
> >> Thus, setting the security-option `memfd_noexec` *breaks* applications=
, because it enables sealing. If `MFD_NOEXEC_SEAL` would *not* imply `MFD_A=
LLOW_SEALING`, this would not be an issue. IOW, why does =C2=B4MFD_NOEXEC_S=
EAL` clear `F_SEAL_SEAL` even if `MFD_ALLOW_SEALING` is not set?
> >>
> >
> > If MFD_NOEXEC_SEAL is not desired, then it should not be used to
> > overwrite memfd_create() in this system.
> >
> > For the question of why the sysctl adding a seal without application
> > setting it , the rationale here is, as summary of previous/this
> > emails:
>
> I still think we are not talking about the same thing. I completely under=
stand why you add the seal! I am just questioning why you *CLEAR* `F_SEAL_S=
EAL`? That is, why do you enable `MFD_ALLOW_SEALING` without the user reque=
sting it? You could just set `F_SEAL_EXEC` without clearing `F_SEAL_SEAL`. =
And then require `MFD_ALLOW_SEALING` on top to clear `F_SEAL_SEAL`.
>
Ah, I apologize. I didn't read it carefully enough and misunderstood
you, thanks for clarification.

The reason that F_SEAL_SEAL is cleared, is that MFD_NOEXEC_SEAL
implies MFD_ALLOW_SEALING, and it seems to be reasonable that
application might want to use sealing  e.g I image application write
the content to memfd then adding F_SEAL_WRITE.

Your point is that MFD_ALLOW_SEALING should not be implied by
MFD_NOEXEC_SEAL. An application should still explicitly set
MFD_ALLOW_SEALING.

To me, MFD_NOEXEC_SEAL, the _SEAL part implies to allow sealing, but
of course, this might not be so clear to anyone other than me :-) ,
documentation is indeed necessary.

And with the context you described,  now I think your approach is better:
1> application set MFD_NOEXEC_SEAL, with MFD_ALLOW_SEALING
    F_SEAL_EXEC is set, F_SEAL_SEAL is clear.
2> Application set MFD_NOEXEC_SEAL, without MFD_ALLOW_SEALING
    F_SEAL_EXEC and F_SEAL_SEAL are set.

> [...]
> >> The downside of `MFD_NOEXEC` is that it might be picked over `MFD_NOEX=
EC_SEAL` by uneducated users, thus reducing security. But right now, the al=
ternative is that existing code picks `MFD_EXEC` instead and never clears t=
he executable bit, because it is a hassle to do so.
> >>
> >
> > Yes. This is the downside I was thinking about.
> >
> > I lean to believe the kernel API shouldn't be feature rich, it could
> > be simple, optimized towards the majority of user cases, and ideally,
> > is self-explained without devs to look through documentation. For
> > example, if I had to choose one to implement between MFD_NOEXEC and
> > MFD_NOEXEC_SEAL, I would choose MFD_NOEXEC_SEAL because it should be
> > what most users care about.
>
> Well, if we were to go back, we would make MFD_NOEXEC(_SEAL) the default =
and just add `MFD_EXEC` :)
>
> >> Or is there another reason *not* to include `MFD_NOEXEC`? I am not sur=
e I understand fully why you fight it so vehemently?
> >>
> >
> > I wouldn't add it myself, I hope to convince you not to :-).
> > If you still think it is beneficial to add MFD_NOEXEC (saving one
> > chmod call and making it easy to use), I wouldn't feel bad about that.
> > I would suggest going with documentation to help devs to choose
> > between those two, i.e. recommend MFD_NOEXEC_SEAL in most cases.
>
> Any application that cannot use `F_SEAL_EXEC` (e.g., because its peers ve=
rify for historic reasons that the seal is not set) now has to do an extra =
dance to get the "safer" behavior, rather than getting the "safer" behavior=
 by default. That is, we make it easier to get the unsafe behavior than to =
get the safe behavior (in this particular scenario).
> Without `MFD_NOEXEC`, it is easier to end up with a 0777 memfd than not. =
I want the application that desires `S_IXUSR` to jump through hoops, not th=
e application that does *not* require it.
>
I see your points now, i.e.  the "disallow sealing entirely" is at
least as important as "not able to chmod to add X".
I think the reasonable mid-ground is perhaps adding MFD_NOEXEC
support, with some documentation to help dev to choose between
MFD_NOEXEC and MFD_NOEXEC_SEAL

Would you like to update your patch to the last version on Andrew's
branch, adding selftest, and perhaps help for documentation ?

Thanks!
-Jeff
