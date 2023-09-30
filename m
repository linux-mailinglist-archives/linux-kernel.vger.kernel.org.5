Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D847B3D4C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 02:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233742AbjI3A0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 20:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjI3A0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 20:26:21 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFE3AC
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 17:26:19 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-57bd4e4ada6so4749824eaf.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 17:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696033579; x=1696638379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QbfpQN37laUl2WFbk/JUjdvHtmzW2FP9r8yjNfG2YLo=;
        b=N2On7hm0v6bO/vYq+ZKQHCWRicgEPiPCGmSUmENioT0Op5KvdMS17+XVZEwm1di+Oo
         LNZB809MCTMLVRMb4jtjlC+jjVCyXF7yVaee5KF5QucjPBwik7jt6AVvrzYF7Uy65x/z
         T3E9MpqbUB+FZPmvhfdOKsmiIZMnDcV5BZPEbqe4H4Rzgmp5r2t59irRDXBkPuJzVpp+
         FiPvoSd3LJ7eHkS4pNUwj4VNDGX46yTe6BJatUaLCdTdCwrIIkYFYqIsGNUlNbFlo586
         VyukY0PiqZ4bPLAGPmq0KfwDSt8WllwCnslj5WDUvTrZmnuBql1wzR8+UXT1cz5Bui2S
         /MIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696033579; x=1696638379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QbfpQN37laUl2WFbk/JUjdvHtmzW2FP9r8yjNfG2YLo=;
        b=w4TlodVLQjEn2guT5dRCYYTSUGsNG07fTdn1kpZOI5Rp5Nw6V9WvWQDK54K7UpgfR+
         4CsbRhrbbpH6Ao4qhBn7Q5b72qhFxGKNt7+t3f4FH4Llgws4U5sSKnnb/CUensdw2tX7
         QHRd1U/nN8gzk5ADbMatMYK7jdFo8FC/hmswstpeCoPDoUzt1EZJuR0Z48z8OHXqASE4
         4D1p92xaNuk6zVvYrx25qlvLOD6HcrLgV3CKvQtUsl/kPmk84XWBl9tqrKL/7DhTPqO4
         NhHpmeljH8i9R1gaBg7jcQ6QZbRJlUdifCcc8qf+nYcf3HMJi7r3X/K00Z76cGb0ozeS
         ij0Q==
X-Gm-Message-State: AOJu0Yxlu4ns6HF7nZbvcMfURLoU2dH/E2OIwv7lQIYLDPhgU1xSmwSN
        yWFbMMYWSa7AD/Gc3tiVdc8qQl9g7a/N5vfs1OUpww==
X-Google-Smtp-Source: AGHT+IEnRrU7CVgMf72e+LktSeTUw0cdVqJFtcjlykDed9+Pj3tYUvkKbyV/GHqyPdFp3MyKBDnYyiWKVk5elL888IU=
X-Received: by 2002:a05:6358:4406:b0:134:c37f:4b64 with SMTP id
 z6-20020a056358440600b00134c37f4b64mr6109683rwc.30.1696033578664; Fri, 29 Sep
 2023 17:26:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230929174442.1635558-1-bgeffon@google.com> <202309291304.9AC4F5CFB@keescook>
In-Reply-To: <202309291304.9AC4F5CFB@keescook>
From:   Brian Geffon <bgeffon@google.com>
Date:   Fri, 29 Sep 2023 20:25:42 -0400
Message-ID: <CADyq12xRZfafeu1PVxB1G9zTgThB0W5nok2eXPFLC+T28-b-Bg@mail.gmail.com>
Subject: Re: [PATCH] pid: Allow frozen userspace to reboot from non-init pid ns
To:     Kees Cook <keescook@chromium.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org
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

On Fri, Sep 29, 2023 at 4:09=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Fri, Sep 29, 2023 at 01:44:42PM -0400, Brian Geffon wrote:
> > When the system has a frozen userspace, for example, during hibernation
> > the child reaper task will also be frozen. Attmepting to deliver a
> > signal to it to handle the reboot(2) will ultimately lead to the system
> > hanging unless userspace is thawed.
> >
> > This change checks if the current task is the suspending task and if so
> > it will allow it to proceed with a reboot from the non-init pid ns.
>
> I don't know the code flow too well here, but shouldn't init_pid_ns
> always be doing the reboot regardless of anything else?

I think the point of this is, normally the reaper is runnable and so
an appropriate signal will be delivered allowing them to also clean up
[2]. In our case, they won't be runnable and doing this wouldn't make
sense.

>
> Also how is this syscall running if current is frozen? This feels weird
> to me... shouldn't the frozen test be against pid_ns->child_reaper
> instead of current?

The task which froze the system won't be frozen to make sure this
happens it will have the flag PF_SUSPEND_TASK added, so we know if we
have this flag we're the only running user space task [1].

>
> -Kees

I hope my understanding is correct and it makes sense. Thanks for
taking the time to review.

Brian

1. https://elixir.bootlin.com/linux/latest/source/kernel/power/process.c#L1=
30
2. https://elixir.bootlin.com/linux/latest/source/kernel/pid_namespace.c#L3=
27


>
> --
> Kees Cook
