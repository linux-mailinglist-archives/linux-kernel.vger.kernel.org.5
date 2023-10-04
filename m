Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265547B8289
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 16:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242894AbjJDOjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 10:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242899AbjJDOjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 10:39:51 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63370DC;
        Wed,  4 Oct 2023 07:39:46 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-533c4d20b33so2303043a12.0;
        Wed, 04 Oct 2023 07:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696430385; x=1697035185; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1pU3vRG3ujzAmgHVGQIt+s362G2AfPzTmLtCuEhE6Us=;
        b=f+k5RaLfnkiYeU46AHqTDsadglAdTCgZbfydnp4RpQssiD9dXwlZUkZC6o82aQLTOc
         YGhtGSUtm1cP6attY64/YG3qjCjMdeZIU7EWOYrC6a0V+7iyuIRlBsUG+3+U+x9Lt+CB
         3VdvEc+VykeDtAI92uWw4xrPQ5LryC6MgOfbCxm1AMYJwQx/KmpPj3IX6zK/oVQNlUEh
         wHKg9OnSlzHtkQk6zGWxqa/U/ZCDvHM9A6YM4HEFE10ulnkQs3lEtDH97FUkCLXrv7t+
         6j/B2+GmpEuAl/baqk7VLE4YkhGF2b7OSIql4GY7uJdbS+no6MEn+y57ZBxvrR8b5u41
         zcxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696430385; x=1697035185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1pU3vRG3ujzAmgHVGQIt+s362G2AfPzTmLtCuEhE6Us=;
        b=DfAqp2d4q509mkqNevVv92NzvGel2cHdL/6rVuQlHX3meojLrMg4UXYOuoZ/7MGpav
         SfzOkASpWPidbq+D8YpZlCq1j7vRPOz3CLAOWCun9BWeJTovHCFxPcp2Q1g2/8WYo2ET
         QUxEGRxNtdcYLkBf/W6SJ+1kIjdaAjTOuxz0x+hik0tXqgbHkBKzCld/RA7xphKm8uCc
         6kDKhefUPRKzK6cdxKzVKIs4vOjStLfSXDcg/UH8Y+NMuCWG6UcvRKbP986rtndOk71L
         H/XMmw62LNbM310XY228Gax90Ui7vGf6s3n5Q5/upqtGUyhiyC8/APWSkFiJdT7fvGfR
         3LVQ==
X-Gm-Message-State: AOJu0YySNHkncEEeW2/WTRpDhE2FLXfvJhNEhBSGkPrFD6Rjdw7zpsif
        5PsCundM8x17sXfayG7F9tv+Lp7+r6jMZf7xtKy6G9m4zc8=
X-Google-Smtp-Source: AGHT+IH5P777m9cFUf1YjDSL5NN4UxVbTGYZoF0GPQeAlvVxn8WDXu7OxuqKQhlOF2XGW2ZtpFvIWN641iz3NDKBzl8=
X-Received: by 2002:aa7:d5c6:0:b0:522:b876:9ef5 with SMTP id
 d6-20020aa7d5c6000000b00522b8769ef5mr2127589eds.8.1696430384499; Wed, 04 Oct
 2023 07:39:44 -0700 (PDT)
MIME-Version: 1.0
References: <20231002144149.1325-1-Nicholas.Lowell@gmail.com> <20231003223003.675bd888@gandalf.local.home>
In-Reply-To: <20231003223003.675bd888@gandalf.local.home>
From:   Nick Lowell <nicholas.lowell@gmail.com>
Date:   Wed, 4 Oct 2023 10:39:33 -0400
Message-ID: <CAFEqNJ2=rt5KaDaAah1t8gGbLViW7VZEDq+81drvuWUz4CKR2w@mail.gmail.com>
Subject: Re: [PATCH v2] trace: tracing_event_filter: fast path when no
 subsystem filters
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        Nicholas Lowell <nlowell@lexmark.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 3, 2023 at 10:29=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Mon,  2 Oct 2023 10:41:48 -0400
> Nicholas Lowell <nicholas.lowell@gmail.com> wrote:
>
> > @@ -2411,7 +2418,12 @@ int apply_subsystem_event_filter(struct trace_su=
bsystem_dir *dir,
> >       }
> >
> >       if (!strcmp(strstrip(filter_string), "0")) {
> > -             filter_free_subsystem_preds(dir, tr);
> > +             /* If nothing was freed, we do not need to sync */
> > +             if (!filter_free_subsystem_preds(dir, tr)) {
> > +                     if(!(WARN_ON_ONCE(system->filter)))
> > +                             goto out_unlock;
> > +             }
> > +
> >               remove_filter_string(system->filter);
> >               filter =3D system->filter;
> >               system->filter =3D NULL;
> > --
>
> This is why I asked for the warning:
>
> trace-cmd record -o /tmp/trace.dat -e sched -f "(common_pid =3D=3D $$) ||=
 ((common_pid > 10) && common_pid < 100) || (common_pid >=3D 1000 && common=
_pid <=3D 1050) || (common_pid > 10000 && common_pid < 20000)" sleep 5
>
>
> Causes:
>
> ------------[ cut here ]------------
>  WARNING: CPU: 5 PID: 944 at kernel/trace/trace_events_filter.c:2423 appl=
y_subsystem_event_filter+0x18c/0x5e0
>  Modules linked in:
>  CPU: 5 PID: 944 Comm: trace-cmd Not tainted 6.6.0-rc4-test-00009-gff7cd7=
446fe5 #102
>  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1=
.16.2-1 04/01/2014
>  RIP: 0010:apply_subsystem_event_filter+0x18c/0x5e0
>  Code: 44 24 08 00 00 00 00 48 8b 6d 00 4c 39 f5 75 bc 48 8b 44 24 18 4c =
8b 60 18 4c 89 e5 45 84 ff 75 14 48 85 ed 0f 84 37 ff ff ff <0f> 0b eb 10 e=
8 4b be fd ff eb b0 4d 85 e4 0f 84 a3 02 00 00 48 8b
>  RSP: 0018:ffff9b4941607db8 EFLAGS: 00010286
>  RAX: ffff8b2780a77280 RBX: ffff8b2780a77400 RCX: 0000000000000000
>  RDX: 0000000000000000 RSI: ffff8b2781c11c38 RDI: ffff8b2781c11c38
>  RBP: ffff8b28df449030 R08: ffff8b2781c11c38 R09: 0000000000000000
>  R10: ffff8b2781c11c38 R11: 0000000000000000 R12: ffff8b28df449030
>  R13: ffffffffaaf64de0 R14: ffffffffaaf66bb8 R15: 0000000000000000
>  FS:  00007fd221def3c0(0000) GS:ffff8b28f7d40000(0000) knlGS:000000000000=
0000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 000056117c93e160 CR3: 000000010173a003 CR4: 0000000000170ee0
>  Call Trace:
>   <TASK>
>   ? apply_subsystem_event_filter+0x18c/0x5e0
>   ? __warn+0x81/0x130
>   ? apply_subsystem_event_filter+0x18c/0x5e0
>   ? report_bug+0x191/0x1c0
>   ? handle_bug+0x3c/0x80
>   ? exc_invalid_op+0x17/0x70
>   ? asm_exc_invalid_op+0x1a/0x20
>   ? apply_subsystem_event_filter+0x18c/0x5e0
>   ? apply_subsystem_event_filter+0x5b/0x5e0
>   ? __check_object_size+0x25b/0x2c0
>   subsystem_filter_write+0x41/0x70
>   vfs_write+0xf2/0x440
>   ? kmem_cache_free+0x22/0x350
>   ksys_write+0x6f/0xf0
>   do_syscall_64+0x3f/0xc0
>   entry_SYSCALL_64_after_hwframe+0x6e/0xd8
>  RIP: 0033:0x7fd221ee7ae0
>
> -- Steve

Is this just informative indicating that there are issues with how
filters are being used or are you saying there is something else I
need to do before this patch is approved?
What version of trace-cmd is that using?
