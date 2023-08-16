Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B6E77EDFC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 01:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347251AbjHPXvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 19:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347244AbjHPXuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 19:50:46 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73161FFF
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 16:50:44 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b9aa1d3029so110745711fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 16:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1692229843; x=1692834643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u/5G3QgFGFGYcCCbceUI8z745E3OyAQYy5/0oN2WUOU=;
        b=OQKlBS2puNqbwHsORAT3ClcWdNeZZTcWCq5DKVu4nVPNishmKpjLlgzgTCyVY2DLpO
         n/LPbsNGAWPDRTjye0aY9zo3+4D2DNP633qnRoNcFu6R6oJLbpv6I+CtMEutxs77pmre
         EJq0N3U2TW9L2Msa6+C8JLI24xDHbN9wzMFl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692229843; x=1692834643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u/5G3QgFGFGYcCCbceUI8z745E3OyAQYy5/0oN2WUOU=;
        b=Njjvr81MALbcJQZj8nXAGRMk9+MCk/BUtw/wmkLm+H480zXWiD6SVrbhoKvW1mbdtU
         bOQXV50j09hK+HWk8JC+emNLlgMvI+wmNNQOOIJRiyTmGwWkjhijfCFy4TzBQdDXjej2
         66rQKw5Pr3nBDFgahBftmpqTMbWOMtAIsX7/P+4kRleJoChK79eYfn8+aKAxKSZxEMKa
         2XgivsBh/qcMqcsXDK/C0G+2iu2CxjOEhuLxnOrMqW+Xr+vKJBu9u3PgMstqOgrrJaIS
         YRmwE44z1BMb22BtvKHrw6kyRWams3VZnUZo/i8VCv30soIcx8f/MAaa8vYpyFLHV9J+
         QpXQ==
X-Gm-Message-State: AOJu0Yx8Dda7JIqqIKUzCBbsADQMI8sGn2DVmKK+VDEmUjkQhqDkBs+A
        tngFiKDQDs7UUcsPXY2dhxgSoqcVt6bjW8nqYdY6RA==
X-Google-Smtp-Source: AGHT+IFUDssSYM5H0I8ZkAVpohfsoXu9mzINcmES7Jrm562HA2kXsL+c/YLdpiNQj2D0I9ntWVO1k2U63vQ4kD5eOsw=
X-Received: by 2002:a2e:9955:0:b0:2b9:b693:c906 with SMTP id
 r21-20020a2e9955000000b002b9b693c906mr2598589ljj.27.1692229842431; Wed, 16
 Aug 2023 16:50:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230815190949.GA3207581@google.com> <6a234118-1ad2-4e22-ad80-f35a1dab8f03@paulmck-laptop>
 <CAEXW_YQkPOPXEwTCc3nZ2CH_scOomPgz7ACYECi3k64T+YD5Vg@mail.gmail.com> <bd06ed64-dcc9-4514-b6b0-f11591ac37f1@paulmck-laptop>
In-Reply-To: <bd06ed64-dcc9-4514-b6b0-f11591ac37f1@paulmck-laptop>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 16 Aug 2023 19:50:31 -0400
Message-ID: <CAEXW_YQFXpEaJ4EuLOcxwyUOR7XiNmP0ShMtC6bcjSe6h=SSgw@mail.gmail.com>
Subject: Re: [PATCH v3] rcutorture: Copy out ftrace into its own console file
To:     paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <shuah@kernel.org>, Joel <agnel.joel@gmail.com>,
        rcu@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 7:46=E2=80=AFPM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Wed, Aug 16, 2023 at 07:27:03PM -0400, Joel Fernandes wrote:
> > On Wed, Aug 16, 2023 at 6:57=E2=80=AFPM Paul E. McKenney <paulmck@kerne=
l.org> wrote:
> > >
> > > On Tue, Aug 15, 2023 at 07:09:49PM +0000, Joel Fernandes (Google) wro=
te:
> > > > When debugging, it can be difficult to quickly find the ftrace dump
> > > > within the console log, which in turn makes it difficult to process=
 it
> > > > independent of the result of the console output.  This commit there=
fore
> > > > copies the contents of the buffers into its own file to make it eas=
ier
> > > > to locate and process the ftrace dump. The original ftrace dump is =
still
> > > > available in the console log in cases where it is more convenient t=
o
> > > > process it there, for example, when you have a script that processe=
s
> > > > console output as well as ftrace-dump data.
> > > >
> > > > Also handle the case of multiple ftrace dumps potentially showing u=
p in the
> > > > log. Example for a file like [1], it will extract as [2].
> > > >
> > > > [1]:
> > > > foo
> > > > foo
> > > > Dumping ftrace buffer:
> > > > ---------------------------------
> > > > blah
> > > > blah
> > > > ---------------------------------
> > > > more
> > > > bar
> > > > baz
> > > > Dumping ftrace buffer:
> > > > ---------------------------------
> > > > blah2
> > > > blah2
> > > > ---------------------------------
> > > > bleh
> > > > bleh
> > > >
> > > > [2]:
> > > >
> > > > Ftrace dump 1:
> > > > blah
> > > > blah
> > > >
> > > > Ftrace dump 2:
> > > > blah2
> > > > blah2
> > > >
> > > >
> > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > >
> > > Very good, and I did queue this one.
> > >
> > > I fixed the indentation of the awk script.  Perhaps your text editor =
is
> > > being too smart for our good?  ;-)
> >
> > Thanks!  Yes the editor messing up is a possibility, I'll go look at
> > that, though the indent seems still messed up in your dev branch:
> >
> > The line "/Dumping ftrace buffer:/ " has spaces, as does the "awk <
> > $1" line. Is that intentional?  All the following ones have tabs.
>
> Not intentional at all, thank you for catching it!
>
> How about the fixup patch shown below, to be merged into the current
> commit?

Looks good to me, thanks!

 - Joel



>
>                                                         Thanx, Paul
>
> ------------------------------------------------------------------------
>
> commit 2322b84997c61e98bd48369f12c9b83b6e0d0ffb
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Wed Aug 16 16:44:49 2023 -0700
>
>     fixup! rcutorture: Copy out ftrace into its own console file
>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>
> diff --git a/tools/testing/selftests/rcutorture/bin/functions.sh b/tools/=
testing/selftests/rcutorture/bin/functions.sh
> index 1ac86f68a436..6e415ddb206f 100755
> --- a/tools/testing/selftests/rcutorture/bin/functions.sh
> +++ b/tools/testing/selftests/rcutorture/bin/functions.sh
> @@ -339,9 +339,9 @@ specify_qemu_net () {
>  # [...]
>  # ---------------------------------
>  extract_ftrace_from_console() {
> -        awk < "$1" '
> +       awk < "$1" '
>
> -        /Dumping ftrace buffer:/ {
> +       /Dumping ftrace buffer:/ {
>                 buffer_count++
>                 print "Ftrace dump " buffer_count ":"
>                 capture =3D 1
