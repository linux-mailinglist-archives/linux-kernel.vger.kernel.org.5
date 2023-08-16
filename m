Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE4777EDD0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 01:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347151AbjHPX1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 19:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347167AbjHPX1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 19:27:17 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5E52723
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 16:27:15 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b9bf52cd08so105459141fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 16:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1692228434; x=1692833234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q45JqAXzr4Yc7nNEyhWOzDg94DzcZe7EdIRyJCqv0Jo=;
        b=YcPQmIOtMYQxiiZ/0AoABDlTNdSDIrOtk2rGs70EhaTerh977ds3mBVgJcKMcJTDHe
         YjKFJ/KIfKRAka9zH6TltVJEIm9Zy6YyMSj1y+Tvdn7Ih5/BknEoMv00A1MUjAKHV86c
         Jf0U662FZiWrgTbizBQ0/YqFTtOjmLu9LVX40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692228434; x=1692833234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q45JqAXzr4Yc7nNEyhWOzDg94DzcZe7EdIRyJCqv0Jo=;
        b=OFcpVPc+cNnmykk+AeryWPGGEC+6OSZj3DlWRzjhbDlfqBpJw2Rf1AIo6l7CRQo864
         /VAOmnbjkOCytMxVvumsou8UlqzBXGJ1TtMbhmykhhTKzgQwx13xjgYxwzSVu1W4t9ty
         ZpTnlYtGN1E+EwghBYU+AAGos7WZe+8j2lN06ZyeNztUUU6ti6g2+phncjLgrEjgTP81
         dJKrfZBswVB3UqZhBuRb8412XVAW2PV2tyTRGnoopo0togKHI4QOx3cDCx07NuyYYgAg
         ovNIIB9sRVaXD3JGy0quLGGYATlrdfcrF09wC4BJ6QjfEltMhavM8ekVl26uy0/oznxU
         Ad2w==
X-Gm-Message-State: AOJu0YzKwQEBPqMPc6LJmwoMb8k0vqsyFoSv8vGHEykyf2iz4/wji4SF
        Es0wOqT+ObqPdZX9a0g+/Kao0OxN81ArRgVhv+haVA==
X-Google-Smtp-Source: AGHT+IH0VhJQ4iHGjbsEVYoyXsbb7mFyuwd1ohzgGIBeAZ28yYlgIp80AlZ4zKJUOIb/8h8k0GqlMkO3KvQm76wUGac=
X-Received: by 2002:a2e:80c7:0:b0:2b5:9f54:e290 with SMTP id
 r7-20020a2e80c7000000b002b59f54e290mr2556165ljg.0.1692228434049; Wed, 16 Aug
 2023 16:27:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230815190949.GA3207581@google.com> <6a234118-1ad2-4e22-ad80-f35a1dab8f03@paulmck-laptop>
In-Reply-To: <6a234118-1ad2-4e22-ad80-f35a1dab8f03@paulmck-laptop>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 16 Aug 2023 19:27:03 -0400
Message-ID: <CAEXW_YQkPOPXEwTCc3nZ2CH_scOomPgz7ACYECi3k64T+YD5Vg@mail.gmail.com>
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 6:57=E2=80=AFPM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Tue, Aug 15, 2023 at 07:09:49PM +0000, Joel Fernandes (Google) wrote:
> > When debugging, it can be difficult to quickly find the ftrace dump
> > within the console log, which in turn makes it difficult to process it
> > independent of the result of the console output.  This commit therefore
> > copies the contents of the buffers into its own file to make it easier
> > to locate and process the ftrace dump. The original ftrace dump is stil=
l
> > available in the console log in cases where it is more convenient to
> > process it there, for example, when you have a script that processes
> > console output as well as ftrace-dump data.
> >
> > Also handle the case of multiple ftrace dumps potentially showing up in=
 the
> > log. Example for a file like [1], it will extract as [2].
> >
> > [1]:
> > foo
> > foo
> > Dumping ftrace buffer:
> > ---------------------------------
> > blah
> > blah
> > ---------------------------------
> > more
> > bar
> > baz
> > Dumping ftrace buffer:
> > ---------------------------------
> > blah2
> > blah2
> > ---------------------------------
> > bleh
> > bleh
> >
> > [2]:
> >
> > Ftrace dump 1:
> > blah
> > blah
> >
> > Ftrace dump 2:
> > blah2
> > blah2
> >
> >
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>
> Very good, and I did queue this one.
>
> I fixed the indentation of the awk script.  Perhaps your text editor is
> being too smart for our good?  ;-)

Thanks!  Yes the editor messing up is a possibility, I'll go look at
that, though the indent seems still messed up in your dev branch:

The line "/Dumping ftrace buffer:/ " has spaces, as does the "awk <
$1" line. Is that intentional?  All the following ones have tabs.

thanks,

 - Joel
