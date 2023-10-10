Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB7887C4155
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 22:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbjJJUhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 16:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJJUhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 16:37:45 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE72F8E
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 13:37:42 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c3e23a818bso2934761fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 13:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1696970261; x=1697575061; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P3GSefbd6ENM7iA2f/vLjLRcW91rVVOQzMA/Obez7bs=;
        b=IDWLL8dKiqnLLeO+EYj7BivNrXbu9u3hB4I+sgBpCFkTOlhN8kGQeShNFvcEiONGQG
         bnWIstXaNac5x/QlsitN+NTP9sAsNTE2QyGXf/JSVbsnblVklmUc+XCpJlas5AxUUXCw
         b9qfSzba5P080QrYHRkW+x5XZ/mk7JLWKF0Jo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696970261; x=1697575061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P3GSefbd6ENM7iA2f/vLjLRcW91rVVOQzMA/Obez7bs=;
        b=MAT+CR5jtLqNm+myxyLzMvYKhfboCvtezBkRAE6mom3OtZSpv4x0ckEOISaljfZFCT
         qr4oKHR8J36vqwQusKTVZIcGLvvP5HHptAaXIJvW5xS0fGbcnaVIPSsZRHd/HKF9gWJ0
         hS1v8mftm2XhOzguM5hN+/JBbOayQS+ZAI4zoGfIaB6Q8YbxJADd/DKElF5ipf7/aiRD
         b6bVpdQuJxU7So+hrETN7g9rbRcsVnjWMqZeBGXbX2EQiYuUkPCDeo/zADbqF36viG6t
         g+yT7pHTE1ey5Ru+s0WhZ1PyibpTvUkh+vuiX/DRZjALfPC4xlYI8cN6S0NZwUkMdLJN
         RFlg==
X-Gm-Message-State: AOJu0YxzGvG86RUc2i3Wc1yqq0lbgPEa43Q2KtnyABInqQXvO4hdu0Np
        X62QsBvp7YJCEvJIznsgkOGjhfW9QrzjboUwUNvqew==
X-Google-Smtp-Source: AGHT+IHui13Pk+tjY+AxTC5P7+ngD0nQWScasEWsguCbaOR+22w7HjXTffTWj2fFHBLPmjdeultcNbQ8mdrMVoxzpaM=
X-Received: by 2002:a2e:9347:0:b0:2c0:7d6:570b with SMTP id
 m7-20020a2e9347000000b002c007d6570bmr10671343ljh.26.1696970260872; Tue, 10
 Oct 2023 13:37:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230929021213.2364883-1-joel@joelfernandes.org>
 <87bkdl55qm.fsf@email.froward.int.ebiederm.org> <CAEXW_YQ=HGok600ARtCKBNDs1OHSc=UM4hWmBdQ=sXZvif0Z5g@mail.gmail.com>
 <CAEXW_YQ3YZExYb6FLg3fvWr9K+FGgNQx7xk3p-PngLG6rt8Ntw@mail.gmail.com> <87il7fzusf.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87il7fzusf.fsf@email.froward.int.ebiederm.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 10 Oct 2023 16:37:30 -0400
Message-ID: <CAEXW_YRv4Uqfn-9cQvDTRGNbCbC9s3jg+PP1-nqYP-DNO54R-w@mail.gmail.com>
Subject: Re: [PATCH] kexec: Fix reboot race during device_shutdown()
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Ricardo Ribalda <ribalda@google.com>,
        Ross Zwisler <zwisler@google.com>,
        Rob Clark <robdclark@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        kexec@lists.infradead.org
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

On Mon, Oct 9, 2023 at 11:30=E2=80=AFAM Eric W. Biederman <ebiederm@xmissio=
n.com> wrote:
>
> Joel Fernandes <joel@joelfernandes.org> writes:
>
> > On Mon, Oct 2, 2023 at 2:18=E2=80=AFPM Joel Fernandes <joel@joelfernand=
es.org> wrote:
> > [..]
> >> > > Such freezing is already being done if kernel supports KEXEC_JUMP =
and
> >> > > kexec_image->preserve_context is true. However, doing it if either=
 of these are
> >> > > not true prevents crashes/races.
> >> >
> >> > The KEXEC_JUMP case is something else entirely.  It is supposed to w=
ork
> >> > like suspend to RAM.  Maybe reboot should as well, but I am
> >> > uncomfortable making a generic device fix kexec specific.
> >>
> >> I see your point of view. I think regular reboot should also be fixed
> >> to avoid similar crash possibilities. I am happy to make a change for
> >> that similar to this patch if we want to proceed that way.
> >>
> >> Thoughts?
> >
> > Just checking how we want to proceed, is the consensus that we should
> > prevent kernel crashes without relying on userspace stopping all
> > processes? Should we fix regular reboot syscall as well and not just
> > kexec reboot?
>
> It just occurred to me there is something very fishy about all of this.
>
> What userspace do you have using kexec (not kexec on panic) that doesn't
> preform the same userspace shutdown as a normal reboot?
>
> Quite frankly such a userspace is buggy, and arguably that is where you
> should start fixing things.

It is a simple unit test that tests kexec support by kexec-rebooting
the kernel. I don't think SIGSTOP/SIGKILL'ing during kexec-reboot is
ideal because in a real panic-on-kexec type crash, that may not happen
and so does not emulate the real world that well. I think we want the
kexec-reboot to do a *reboot* without crashing the kernel while doing
so. Ricardo/Steve can chime on what they feel as well.

> That way you can get the orderly shutdown
> of userspace daemons/services along with an orderly shutdown of
> everything the kernel is responsible for.

Fixing in userspace is an option but people are not happy that the
kernel can crash like that.

> At the kernel level a kexec reboot and a normal reboot have been
> deliberately kept as close as possible.  Which is why I say we should
> fix it in reboot.

You mean fix it in userspace?

thanks,

 - Joel
