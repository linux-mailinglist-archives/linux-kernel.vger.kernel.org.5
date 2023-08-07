Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44F46771CCD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 11:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjHGJCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 05:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbjHGJBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 05:01:47 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C261738
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 02:01:34 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b9eaa7c83dso7827291fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 02:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1691398892; x=1692003692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0zHdqO6B0uFI6lNP0y9AW2K5q29rU7RbO5lwyLOgfdE=;
        b=LvpiUi2kF02TYvAh9ppDB9Zt0Yl128QZ+CHwoRMnhwI2jzEd3T5k171dhS+Eo2hstW
         HLv/94M2N/XvN2Mq9W3rNKSY9kSeexDCKKQdHZJvj/IUOP8kwbHGYJ3ny7J1jhoM+A7p
         lvKeixtRkTvgD6UYMjEDyh16nBYtTAMnlNFcE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691398892; x=1692003692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0zHdqO6B0uFI6lNP0y9AW2K5q29rU7RbO5lwyLOgfdE=;
        b=ao0wZYhJNN5czjZ/2fAJ/5HpXV6sXIAklvfZ7FYBCh0hbiMX+j87bkwOW+5o3O6xM7
         8iOQI9Sf1y0f1DF3M0WHlahj3KZkxeXcohLeiuv+47JZ9uGYr+ovc90zHEMfXf49FeqZ
         0archXW6myZKJL8JW4GXuVwgpzJKjTfBdPjCur/CA0d9UC3bUTvEaCscc5FQJfo8RXYp
         5hxHWOFxwSRedyaGjmfR1R9ZoHw2208GyWqKdY/IX3o0JmMJ8SskHsHeT6u+cKv+Audd
         PvPePnKAujRQ5gIDZJlgpbIeTaeZz/Sn6PqOFT7h8m79rSZndQAQN1/UUYTCDCoE60Cb
         hL7g==
X-Gm-Message-State: ABy/qLZiUQaVCZBQreaTa6O3tEOM2GZ5ED6foVWXc1EKoNrllyczYYvZ
        4HdN1q8LDV0oKIXaOP6hcmAeDWZ3Ger4TehG1QxmXHxUdFC4+VKUWwQNT5nW
X-Google-Smtp-Source: APBJJlG0jyfKgEFF91WdALcAehEdYNuGJReQnPKPInJCZ96HtklkX/fJEt3YNtPsAxp47CaVDyLg0GbMFA8KBS3LL74=
X-Received: by 2002:a2e:a788:0:b0:2b9:689b:2e3a with SMTP id
 c8-20020a2ea788000000b002b9689b2e3amr20263450ljf.3.1691398891995; Mon, 07 Aug
 2023 02:01:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230807085203.819772-1-david@readahead.eu>
In-Reply-To: <20230807085203.819772-1-david@readahead.eu>
From:   Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date:   Mon, 7 Aug 2023 11:01:20 +0200
Message-ID: <CAJqdLroQE1sU2uOG018Ezyome1sQb89c_mdSdvOCpM7=XNt+xg@mail.gmail.com>
Subject: Re: [PATCH] pid: allow pidfds for reaped tasks
To:     David Rheinsberg <david@readahead.eu>
Cc:     linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Jan Kara <jack@suse.cz>, Kees Cook <keescook@chromium.org>,
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

On Mon, Aug 7, 2023 at 10:52=E2=80=AFAM David Rheinsberg <david@readahead.e=
u> wrote:
>
> A pidfd can currently only be created for tasks that are thread-group
> leaders and not reaped. This patch changes the pidfd-core to allow for
> pidfds on reapead thread-group leaders as well.
>
> A pidfd can outlive the task it refers to, and thus user-space must
> already be prepared that the task underlying a pidfd is gone at the time
> they get their hands on the pidfd. For instance, resolving the pidfd to
> a PID via the fdinfo must be prepared to read `-1`.
>
> Despite user-space knowing that a pidfd might be stale, several kernel
> APIs currently add another layer that checks for this. In particular,
> SO_PEERPIDFD returns `EINVAL` if the peer-task was already reaped,
> but returns a stale pidfd if the task is reaped immediately after the
> respective alive-check.
>
> This has the unfortunate effect that user-space now has two ways to
> check for the exact same scenario: A syscall might return
> EINVAL/ESRCH/... *or* the pidfd might be stale, even though there is no
> particular reason to distinguish both cases. This also propagates
> through user-space APIs, which pass on pidfds. They must be prepared to
> pass on `-1` *or* the pidfd, because there is no guaranteed way to get a
> stale pidfd from the kernel.
>
> This patch changes the core pidfd helpers to allow creation of pidfds
> even if the PID is no longer linked to any task. This only affects one
> of the three pidfd users that currently exist:
>
>  1) fanotify already tests for a linked TGID-task manually before
>     creating the PIDFD, thus it is not directly affected by this change.
>     However, note that the current fanotify code fails with an error if
>     the target process is reaped exactly between the TGID-check in
>     fanotify and the test in pidfd_prepare(). With this patch, this
>     will no longer be the case.
>
>  2) pidfd_open(2) calls find_get_pid() before creating the pidfd, thus
>     it is also not directly affected by this change.
>     Again, similar to fanotify, there is a race between the
>     find_get_pid() call and pidfd_prepare(), which currently causes
>     pidfd_open(2) to return EINVAL rather than ESRCH if the process is
>     reaped just between those two checks. With this patch, this will no
>     longer be the case.
>
>  3) SO_PEERPIDFD will be affected by this change and from now on return
>     stale pidfds rather than EINVAL if the respective peer task is
>     reaped already.
>
> Given that users of SO_PEERPIDFD must already deal with stale pidfds,
> this change hopefully simplifies the API of SO_PEERPIDFD, and all
> dependent user-space APIs (e.g., GetConnectionCredentials() on D-Bus
> driver APIs). Also note that SO_PEERPIDFD is still pending to be
> released with linux-6.5.
>
> Signed-off-by: David Rheinsberg <david@readahead.eu>
> ---
>  kernel/fork.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/fork.c b/kernel/fork.c
> index d2e12b6d2b18..4dde19a8c264 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2161,7 +2161,7 @@ static int __pidfd_prepare(struct pid *pid, unsigne=
d int flags, struct file **re
>   * Allocate a new file that stashes @pid and reserve a new pidfd number =
in the
>   * caller's file descriptor table. The pidfd is reserved but not install=
ed yet.
>   *
> - * The helper verifies that @pid is used as a thread group leader.
> + * The helper verifies that @pid is/was used as a thread group leader.
>   *
>   * If this function returns successfully the caller is responsible to ei=
ther
>   * call fd_install() passing the returned pidfd and pidfd file as argume=
nts in
> @@ -2180,7 +2180,14 @@ static int __pidfd_prepare(struct pid *pid, unsign=
ed int flags, struct file **re
>   */
>  int pidfd_prepare(struct pid *pid, unsigned int flags, struct file **ret=
)
>  {
> -       if (!pid || !pid_has_task(pid, PIDTYPE_TGID))
> +       if (!pid)
> +               return -EINVAL;
> +
> +       /*
> +        * Non thread-group leaders cannot have pidfds, but we allow them=
 for
> +        * reaped thread-group leaders.
> +        */
> +       if (pid_has_task(pid, PIDTYPE_PID) && !pid_has_task(pid, PIDTYPE_=
TGID))
>                 return -EINVAL;

Hi David!

As far as I understand, __unhash_process is always called with a
tasklist_lock held for writing.
Don't we need to take tasklist_lock for reading here to guarantee
consistency between
pid_has_task(pid, PIDTYPE_PID) and pid_has_task(pid, PIDTYPE_TGID)
return values?

Kind regards,
Alex

>
>         return __pidfd_prepare(pid, flags, ret);
> --
> 2.41.0
>
