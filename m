Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456E577BA2F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 15:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbjHNNeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 09:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbjHNNeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 09:34:37 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02AB10D5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 06:34:35 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4fe0a3377bfso1872270e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 06:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1692020074; x=1692624874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FgBLbVkVIt/9kd84g/UWpkPAMBCoIvJC1bWfg1DPPL8=;
        b=UZB5emU7BQrsXjWUGbSRg+4K0288T0D2UoU0SwZNp2XEtw++592J2ylHKZcU/nqMwB
         I8/ovlVjiP27GI9G3cr0Z91HDwt80cRJ1aRZbDdjmxzOX9Zw/CEFB6Lh7H/SFkXUh8I1
         iYMQkCRE9khLcOmzycVKM9XfLVxnF8KP64ihU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692020074; x=1692624874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FgBLbVkVIt/9kd84g/UWpkPAMBCoIvJC1bWfg1DPPL8=;
        b=BTogXCLVz+ysMkEyOloPuk0xFrFUe24P44jxiNvKdNSscALmksGNEBg0SfgDgLjQ94
         CiUzFiHvEc+GxWu/l8FZMVkvEAP8cAgoXLW8+kGKmd2ZJ5Hw3UWnwtWhgD3FJaIJS8EQ
         D2EpwI8pUxQsjQJSFtCkGkd7HC1IZl780BZmHuN8E/ltLV9ZP0q9dysxvaDQFMkhWacH
         UuGAGTLXI7Al/3vPx0mah5UDKSbA4xwHGN032zB99gjhECoWO+FXpKVkjCzKzJ50SLiv
         0Ndq1vdvyBOVc1tpLgVixr7163Zs92E9nRERUaNLRaRjuRG9DfwvoOOyl+UJXqIgTdr1
         8gXw==
X-Gm-Message-State: AOJu0Yyroo48/hiJRJOGEWoRl+8ElUENXUPtVDeIC9c0QDusbisxp5PF
        qNc5Dz7uB0Z0jBJ2SAawkZsKij7iBmwMtUYJkOicsjuAF6lnSzoaTdk=
X-Google-Smtp-Source: AGHT+IFEWHMHs3CHiKsY+cKZShjPlwLZ7twsTzHLQ11xTg9ZMfI7qwWvak+Yz1zwqaW93n0c+gHYtCVVxcc1WHL1thU=
X-Received: by 2002:ac2:4892:0:b0:4fd:cbd8:17d5 with SMTP id
 x18-20020ac24892000000b004fdcbd817d5mr4669343lfc.4.1692020073708; Mon, 14 Aug
 2023 06:34:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230807085203.819772-1-david@readahead.eu> <20230807-porzellan-rehkitz-9fde1b94dd6b@brauner>
 <20230811112911.GA22566@redhat.com> <20230811-perplex-installieren-899f5925534d@brauner>
 <20230811115710.GA21779@redhat.com> <6feef7e0-ea72-412d-837e-34b6fdd3b869@app.fastmail.com>
 <20230814132039.GA17738@redhat.com>
In-Reply-To: <20230814132039.GA17738@redhat.com>
From:   Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date:   Mon, 14 Aug 2023 15:34:22 +0200
Message-ID: <CAJqdLrr4-Jzw7v5n8gXp54RM918-tCUa-rEg0XsnxOJ2bNKt7A@mail.gmail.com>
Subject: Re: [PATCH] pid: allow pidfds for reaped tasks
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     David Rheinsberg <david@readahead.eu>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Kees Cook <keescook@chromium.org>,
        Luca Boccassi <bluca@debian.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 3:21=E2=80=AFPM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> On 08/14, David Rheinsberg wrote:
> >
> > Hi Oleg,
> >
> > On Fri, Aug 11, 2023, at 1:57 PM, Oleg Nesterov wrote:
> > >> What code do we need to allow userspace to open a pidfd to a leader =
pid
> > >> even if it has already been exited and reaped (without also accident=
ly
> > >> allowing to open non-lead pid pidfds)?
> > >
> > > I'll try to think more, but can you also explain why do we need this?
> > >
> > > See my another email. Can't we simply shift the pid_has_task(PIDTYPE_=
TGID)
> > > check from pidfd_prepare() to pidfd_create() ? (and then we can kill
> > > pidfd_prepare and rename __pidfd_prepare to pidfd_prepare).
> >
> > Yes, the easiest solution would be to use `__pidfd_prepare()` and ensur=
e
> > that the caller only ever calls this on tg-leaders. This would work jus=
t
> > fine, imo. And this was my initial approach.
>
> Great,
>
> > I think Christian preferred an explicit assertion that ensures we do no=
t
> > accidentally hand out pidfds for non-tg-leaders. The question is thus w=
hether
> > there is an easy way to assert this even for reaped tasks?
> > Or whether there is a simple way to flag a pid that was used as tg-lead=
er?
>
> I do not see how can we check if a detached pid was a leader pid, and I d=
on't
> think it makes sense to add a new member into struct pid...
>
> > Or, ultimately, whether this has limited use and we should just use
> > `__pidfd_prepare()`?
>
> Well, if you confirm that sk->sk_peer_pid and scm->pid are always initial=
ized with
> task_tgid(current), I'd certainly prefer this approach unless Christian o=
bjects.

Dear colleagues,

I can confirm that sk->sk_peer_pid and scm->pid are always thread-group lea=
ders.

Kind regards,
Alex

>
> Oleg.
>
